Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A2CC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 13:28:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20D85206CD
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 13:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="IBgkxu8+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20D85206CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7gBh-0006ZW-4s
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 09:28:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39952)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Mark.Syms@citrix.com>) id 1i7gAz-00067B-OI
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 09:27:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Mark.Syms@citrix.com>) id 1i7gAu-00038X-Pa
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 09:27:21 -0400
Received: from esa2.hc3370-68.iphmx.com ([216.71.145.153]:37042)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Mark.Syms@citrix.com>)
 id 1i7gAu-00035r-FE
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 09:27:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1568122037;
 h=from:to:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=jtGkDe2wYpDX4yDMVzSmh1QduLA4rl0nCVnRlPXJVN0=;
 b=IBgkxu8+THMaCkHa/ZNqc0JQboSC3NXYkQUksgN0fBzd2OKmsAsttuHL
 4XZD+XUI1d22bFycJ+zdRYd9iASh3K3ifumUsFW9iUvgQtOrPok29sUHb
 rdpVOLUHuCPdL0ubHqq5jPyeTqzmbw4NgHaNm+nW2PXcFK1V5JpdQZESA A=;
Authentication-Results: esa2.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none;
 spf=None smtp.pra=Mark.Syms@citrix.com;
 spf=Pass smtp.mailfrom=Mark.Syms@citrix.com;
 spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa2.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 Mark.Syms@citrix.com) identity=pra; client-ip=162.221.158.21;
 receiver=esa2.hc3370-68.iphmx.com;
 envelope-from="Mark.Syms@citrix.com";
 x-sender="Mark.Syms@citrix.com"; x-conformance=sidf_compatible
Received-SPF: Pass (esa2.hc3370-68.iphmx.com: domain of
 Mark.Syms@citrix.com designates 162.221.158.21 as permitted
 sender) identity=mailfrom; client-ip=162.221.158.21;
 receiver=esa2.hc3370-68.iphmx.com;
 envelope-from="Mark.Syms@citrix.com";
 x-sender="Mark.Syms@citrix.com";
 x-conformance=sidf_compatible; x-record-type="v=spf1";
 x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
 ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
 ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
 ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83 ~all"
Received-SPF: None (esa2.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 postmaster@mail.citrix.com) identity=helo;
 client-ip=162.221.158.21; receiver=esa2.hc3370-68.iphmx.com;
 envelope-from="Mark.Syms@citrix.com";
 x-sender="postmaster@mail.citrix.com";
 x-conformance=sidf_compatible
IronPort-SDR: ++fpYCHkB/axMU8O3CpoUlUjM6dpXqkVk4FyCXH/+v9CUfymVQesSkhhjGGee+Gvm9xhwhc1Lu
 mlitJff3Rw1dCPr0VAoe2hU20Nq7GIR9PRYz5kVyQmugWxiQ1wjhQrgMamIj8JUOIoXeb9T4GV
 Y16xWbLKYQKq3K8B2Ay6RW8Igr/+Pkvvk3c4v7keR9D2FURH1rmIPDTTOK2lz5y90EGyH3IBXq
 Zbzw6xgiE/FmRrlvzBpw2+5eO5zDZqeCL0/TyJShpnpnRVsp99SxhTI5630jcocu6e9BqC85JJ
 Q6A=
X-SBRS: 2.7
X-MesageID: 5370777
X-Ironport-Server: esa2.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.64,489,1559534400"; 
   d="scan'208";a="5370777"
From: Mark Syms <Mark.Syms@citrix.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: Valgrind confused by queue macros
Thread-Index: AdVn2TTmG0WDoKwzR2+3/z64vpIPIA==
Date: Tue, 10 Sep 2019 13:27:08 +0000
Message-ID: <e2cce2353aa44e2481f01b96ee1e6028@AMSPEX02CL01.citrite.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.145.153
Subject: [Qemu-devel] Valgrind confused by queue macros
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

While trying to track down an issue in using qemu 4.1 with some development=
 features we needed/wanted to run valgrind on it to find a memory error. Un=
fortunately the form of the queue macros seems to really confuse valgrind a=
nd cause it to report many " Use of uninitialised value " errors.

As an example, in qemu_aio_coroutine_enter -=20

Use of uninitialised value of size 8
   at 0x69E7E5: qemu_aio_coroutine_enter (qemu-coroutine.c:109)

Conditional jump or move depends on uninitialised value(s)
   at 0x69E7FA: qemu_aio_coroutine_enter (qemu-coroutine.c:112)

Use of uninitialised value of size 8
   at 0x69E800: qemu_aio_coroutine_enter (qemu-coroutine.c:118)

Use of uninitialised value of size 8
   at 0x69E809: qemu_aio_coroutine_enter (qemu-coroutine.c:120)

Use of uninitialised value of size 8
   at 0x69E822: qemu_aio_coroutine_enter (qemu-coroutine.c:122)

Use of uninitialised value of size 8
   at 0x69E83A: qemu_aio_coroutine_enter (qemu-coroutine.c:134)

Use of uninitialised value of size 8
   at 0x69E845: qemu_aio_coroutine_enter (qemu-coroutine.c:139)

This seems to ultimately result from it thinking that pending is not initia=
lised by this line

    QSIMPLEQ_HEAD(, Coroutine) pending =3D QSIMPLEQ_HEAD_INITIALIZER(pendin=
g);

As this issue in itself accounts for 7 errors every time that qemu_aio_coro=
utine_enter is called (which is frequently) valgrind very soon gives up and=
 says the code is too broken to report errors on - unless that is you disab=
le the error-limit which is what we've done but then you still have to iden=
tify the real errors in the middle of these ones.

Not sure what it is about the macros in the initialisation line that cause =
valgrind to think it isn't initialised, whilst there is a small amount of m=
acro magic in there it looks like it does actually result in things being c=
orrectly initialised.

This is using valgrind 3.13.0-13.el7 on a CentOS 7 system.

Any clues about how to resolve this? Or is it just a fact of life that valg=
rind is never going to be happy with this code?

Thanks,

Mark.

