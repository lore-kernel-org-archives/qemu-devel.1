Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67684C43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 15:20:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31A0D206F2
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 15:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aepfle.de header.i=@aepfle.de header.b="ZEDD6XYw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31A0D206F2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aepfle.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHqmP-0006fl-Ao
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 11:20:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40939)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <olaf@aepfle.de>) id 1jHqlX-0005WN-17
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 11:19:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <olaf@aepfle.de>) id 1jHqlW-0002Z6-3O
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 11:19:22 -0400
Received: from mo6-p01-ob.smtp.rzone.de ([2a01:238:20a:202:5301::3]:25334)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <olaf@aepfle.de>) id 1jHqlV-0002S7-T6
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 11:19:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1585322360;
 s=strato-dkim-0002; d=aepfle.de;
 h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=PpQs5DUr+N/EfPuuflCivLOcWKeHNj9YqpvbA1C6e+M=;
 b=ZEDD6XYwea65s2Qyy/6aCd9dbwC+OI6g3AyGQwQDnd5693dqxTLwfDOz8rQsNoGdSy
 1u5u+4fuSkMzmJgyjtJtjXMIGZnps1iUapxpJUv1An+y8BCq/dGfZO2/ywoxR3vtemHU
 jsEJSAseVrdrHOihuQoAFUVa1q+qsbQ9Sa29t2Tup5fYgGBT2YBrjRvddrBetbK6RpYi
 l1yuzwrUjqpYLN1QpJbbQ7CBBwAlmlDVCFHznghN5IpDNXbUvwTIMT36qoqfAcuhJjvU
 3QNLZ/m0Si2X/mXhs1IcfwE6+Qu4E2JTjlzlNSHWNmQeOnfIKLSgRMMlmDQnQ5HC4o2o
 PAaA==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QXkBR9MXjAuzBW/OdlBZQ4AHSS1Wwg"
X-RZG-CLASS-ID: mo00
Received: from aepfle.de by smtp.strato.de (RZmta 46.2.1 DYNA|AUTH)
 with ESMTPSA id 204e5fw2RFJJ4X8
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Fri, 27 Mar 2020 16:19:19 +0100 (CET)
Date: Fri, 27 Mar 2020 16:19:16 +0100
From: Olaf Hering <olaf@aepfle.de>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3] piix: fix xenfv regression, add compat machine
 xenfv-qemu4
Message-ID: <20200327151916.GA13951@aepfle.de>
References: <20200113174521.3336-1-olaf@aepfle.de>
 <20200325064736.22416-1-olaf@aepfle.de>
 <9123dcfd-862f-8986-b728-f4b3d806aea6@redhat.com>
 <20200325164522.39869e56.olaf@aepfle.de>
 <ce1dd710-7818-3883-183e-73e7cfbf22d5@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline
In-Reply-To: <ce1dd710-7818-3883-183e-73e7cfbf22d5@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 2a01:238:20a:202:5301::3
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
Cc: "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Wed, Mar 25, Paolo Bonzini wrote:

> On 25/03/20 16:45, Olaf Hering wrote:
> >> hw_compat_3_1 and pc_compat_3_1
> > I have asked about this earlier, so again:
> > What do all these arrays do in the context of 'xenfv' to the emulated system?
> They change the hardware and CPU features that is presented to the VMs,
> if the respective devices are included in the virtual machine.  For
> example USB devices will have a different serial number on 3.1 and 5.0,
> and VGA devices present EDID information on 4.1+.

I will adjust the change to use either pc_i440fx_3_1_machine_options
or pc_i440fx_4_2_machine_options.

Olaf

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAl5+GXQACgkQ86SN7mm1
DoDoKQ//YMoMx90SZ8RY3Z4s65weYdIohMIvr4cA8qrdgLCeBgiAGJYfFoNV3LlZ
hSj/W9q0dGZfudR6j6uLEo0xLyRwwxhT0Z6XSwLj8Jj2KfEK9ICWD7BdUcDY3WwT
ICSvmyjNM44AXxk5TdAGaDd1EixXj40QSdqPrv/heVx9H9/HCYWsWAmNti6fU2A4
d+KU2HGeG0AvoMYaISi45+TD+iPuJNnh2Lmz3L5nxhPCZb54xOnajJyZAMlZRQdH
/+mM5/q/E1Lm8laLz/TdLRliTsS99yYAGEg4yY7ht/1hsQTM5XMIEyK+JNeWgzQ9
cCbvow2URwpQ2JyessiBZMD+6L9Aozozdvb0/0+3tZh2m0L177gMODQDjuDn9UVp
INsA2k1yQiK2jxaK/hnR6eiF2fnmgRTnI4NlTV9/gJt4gi9ex83Oj58dDpz2dFQG
g1SBnh5+ORUr19OSLkkgzykbGOiK8q9duyZHmJ97X9I8SVc8n8Xd7KT7Ptf2iqMR
WTnsBKabLMEB99Iby5s4BT+i6ZZxOzx83K0c0WxDyu6FAN0WiErGiCwhZAKhLKmj
yTVCqzkTNFwQnumj2mgiobSG80awASkXyJaDsoJtOVVlBB6JUwqXloPgWWpOaRRx
ZhoZIBDUeIhMJIi/Y4UuTlsuZ+q4B0+IP0aCMRGtNmj/IkvUXeQ=
=R3DH
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--

