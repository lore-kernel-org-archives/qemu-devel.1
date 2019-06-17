Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2170C31E57
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 12:51:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE2C920861
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 12:51:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE2C920861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47178 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcr6l-0004TC-07
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 08:51:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46414)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <groug@kaod.org>) id 1hcr3f-0002ko-W9
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 08:48:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1hcr3e-00055w-G8
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 08:48:23 -0400
Received: from 5.mo68.mail-out.ovh.net ([46.105.62.179]:53606)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1hcr3e-00054I-Ai
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 08:48:22 -0400
Received: from player761.ha.ovh.net (unknown [10.109.159.69])
 by mo68.mail-out.ovh.net (Postfix) with ESMTP id 3CB7E12F5DF
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 14:48:18 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player761.ha.ovh.net (Postfix) with ESMTPSA id 526BF6EE6275;
 Mon, 17 Jun 2019 12:48:13 +0000 (UTC)
Date: Mon, 17 Jun 2019 14:48:12 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190617144812.63b94658@bahia.lan>
In-Reply-To: <20190617111205.GA5929@umbus>
References: <20190612020723.96802-1-aik@ozlabs.ru>
 <20190617102510.341d71a5@bahia.lan> <20190617111205.GA5929@umbus>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/fAA0gcrwRJjPJiiBqw.ECwt"; protocol="application/pgp-signature"
X-Ovh-Tracer-Id: 10093129715404872166
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrudeijedgheejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.62.179
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH qemu REPOST] spapr/rtas: Force
 big endian compile for rtas
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/fAA0gcrwRJjPJiiBqw.ECwt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 17 Jun 2019 21:12:05 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Mon, Jun 17, 2019 at 10:25:10AM +0200, Greg Kurz wrote:
> 65;5603;1c> On Wed, 12 Jun 2019 12:07:23 +1000
> > Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> >  =20
> > > At the moment the rtas's Makefile uses generic QEMU rules which means
> > > that when QEMU is compiled on a little endian system, the spapr-rtas.=
bin
> > > is compiled as little endian too which is incorrect as it is always
> > > executed in big endian mode. =20
> >=20
> > I'm naively thinking that executing code compiled as little endian
> > in big endian mode would result in an exception... Can you explain
> > how/why this ever worked ? =20
>=20
> Because basically nobody actually built the rtas blob from the
> sources, they just used the pre-compiled blob, which is correctly
> built BE.
>=20

Ah ! Everyone has been using blob from this pre-ppc64le commit:

commit d818bfc5c34c59e9c6d03b3b9983bb5435967292
Author: Aurelien Jarno <aurelien@aurel32.net>
Date:   Fri Apr 1 20:04:24 2011 +0200

    pc-bios/spapr-rtas.bin: remove executable flag
   =20
    Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>

> That said executing LE code in BE mode won't necessarily result in an
> exception - it'll just execute whatever the instructions are you get
> when you byte reverse the ones you inteded, which may or may not be
> valid.  It's *likely* to cause an exception fairly soon, but the
> opcode space is densely populated enough that there's a good chance it
> won't cause an immediate illegal instruction.
>=20

In theory yes, but in this precise case, the first instruction of the
rtas blob is 7c641b78 ('mr r4, r3') and I've manually checked that
781b647c raises an exception on both POWER8 and POWER9.

--Sig_/fAA0gcrwRJjPJiiBqw.ECwt
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAl0HjAwACgkQcdTV5YIv
c9b0UQ//VMFWCqkXE6XPhmah+tTR2B5lOkfanKgPFzv8anecybmtANKuBm3YeY9A
Zyb+ZHkYyA2grK5HcQgJLHZVnb5WLZMMOgOrf+UzC6qL5vRjXWfci80p6M0mPCIK
VfVFM1YGZt3AIjWuQFzJGVKm2UQPWpORDF+AeRJDdakTGRnVJOABcIFnGiO6Bwrr
70nyIxHPIWOmN8Xn/qI9bQ/nZSClJDDkOHqRR7Ji4ocfeQMwRg9OVXjdIFps7CJs
5XFfcrcESpa257oG0VD6a5bYRNa4LSvzA/hY4FZQGBzUNnrQnTHsRekKJavNuzYl
cDOiDNWfgkPfXbOQEbu8o2Poevix1Vjq8Tor4Cmmb4M7oBr4mE0i6uibon7xY+08
8BZyzNhewGT8qhAgvOPAiAbc5bzI9Da70vzUP2vQFIg0prsm7jTeR2qF6TqlQ1WE
FokqTtCuKFZEr0QzMa74PPWIdQNSjNGlmCgnDzVaLBJNc/bw2eUKHnX9ltnSJYCB
gHOGji4kRFda4xfDfXQol6EBQTwk32uq5FcmNjwoWt6tqG6pSW5zMuLBRVFsYJ/i
TVW41HdCqgXeKHSiYW6olBDvqVkZHeh5Len30uK3mGLpZ+a+JhAelzQ4pFUsV+3m
CfZ6lPEpT2VPkAupshs9rLXyjcju9wPnwlgC7kUvpbNSrCenYFg=
=aLqq
-----END PGP SIGNATURE-----

--Sig_/fAA0gcrwRJjPJiiBqw.ECwt--

