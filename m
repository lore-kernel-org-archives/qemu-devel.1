Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8EB2C43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 21:10:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29B4A206D4
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 21:10:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29B4A206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIegn-0001Ap-3A
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 17:10:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39688)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dilfridge@gentoo.org>)
 id 1kIegE-0000mG-ML
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 17:09:30 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:51856)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dilfridge@gentoo.org>)
 id 1kIegC-0006eZ-R8
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 17:09:30 -0400
From: Andreas =?ISO-8859-1?Q?K=2E_H=FCttel?= <dilfridge@gentoo.org>
To: Alistair Francis <alistair23@gmail.com>
Subject: Re: riscv32 wait() problem, qemu or glibc?
Date: Thu, 17 Sep 2020 00:09:10 +0300
Message-ID: <9381423.g9G3TJQzCC@farino>
Organization: Gentoo Linux
In-Reply-To: <CAKmqyKPqg4no7DM+z-EdJAAKzta9Mcfn=Fz0DjC5dbSKEtDtCg@mail.gmail.com>
References: <9435182.tdPhlSkOF2@farino>
 <CAKmqyKPqg4no7DM+z-EdJAAKzta9Mcfn=Fz0DjC5dbSKEtDtCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1703976.rmoMso0CXa";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Received-SPF: pass client-ip=140.211.166.183;
 envelope-from=dilfridge@gentoo.org; helo=smtp.gentoo.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 17:09:19
X-ACL-Warn: Detected OS   = ???
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: GNU C Library <libc-alpha@sourceware.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--nextPart1703976.rmoMso0CXa
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

> My guess is that somewhere in QEMU the types don't match what RV32 is
> using. It's probably worth printing out the size, alignment and value
> of everything at every stage and see what breaks.

Thanks.

> AFAIK RV32 linux-user mode is pretty much un-tested. So their might be
> all sorts of issues with it unfortunately.

Would you consider qemu system mode more reliable?

I need to prepare some bootable riscv gentoo images eventually anyway. Migh=
t=20
as well try a riscv32 one for comparison then if that is more promising.

=2D-=20
Andreas K. H=FCttel
dilfridge@gentoo.org
Gentoo Linux developer=20
(council, qa, toolchain, base-system, perl, libreoffice)
--nextPart1703976.rmoMso0CXa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQKTBAABCgB9FiEE50NBr50KpJKM5MK59n+4O2olsAAFAl9ifvZfFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldEU3
NDM0MUFGOUQwQUE0OTI4Q0U0QzJCOUY2N0ZCODNCNkEyNUIwMDAACgkQ9n+4O2ol
sAAOVQ//T/FVJwcYt3+2LBFd9JiapOhXcPd45qkFGmHJl4masZAUrVZAcJM3YZwO
RaVH3OiU5FGLk3vMY/rLDbISibYvPtHfqoPGF/qHqvSsckWZSflwISm3UbnXhx19
qPxpIaRWA6KJr4AeS/k6jJujzXB3yjcBqCud9JmgXfJR8Vf/Mns9xgNgyjnZFbll
PKHomxds+ejA3RoGjuwxZyFcpCCJLaDa7LVPbu6Y/OHgAvp8ieLQVKpyxq/QUjKT
6Z8Zj/9SjkiJjN3xDGqdzpuSOanub3n1pWQM7IrzVWrNRH9Vfjv4lfxcptZao2+t
4vmDJ+6RGDNsBvh/5dsWQCwaSwWJ+SzYjswPuDYwb0nk435vSf3e67eZsOBahB9K
t9ukFegS7Uyi6ewE13vVSmsF4kOHy2wQ3iFJW4WUfUjC1FHBO1BTRsWvXntKOb6F
VoU2osfMBEoV43NSA4q4mqTs1YmjnHlj+GRUd17y1MbZPXg12H3V+9XdwDzqg9hT
XGbGpU14SaWESefgaOUs6PMQHl9Bc2z+/xsW+soowtTwhsohXyULgB3PfH1IcY++
K3fIWOJjfEjdcAZrH3TAg+2j6Gbr3P56ZMryOEakYEwBa8ILayH2Q3oj9DTY1Qem
7pK7W8Ro+B4vaOgPzvbDoEAVR58YwiNvCbZBliFjnQBhayDUpvU=
=mHJs
-----END PGP SIGNATURE-----

--nextPart1703976.rmoMso0CXa--




