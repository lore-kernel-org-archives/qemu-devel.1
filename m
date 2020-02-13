Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C4C8C352A3
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 04:13:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08D5A2073C
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 04:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="cMw81FZs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08D5A2073C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j25so-0001MB-5q
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 23:13:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36221)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1j25sB-0000qR-RD
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 23:13:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1j25sA-0005ve-IO
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 23:13:07 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:41177)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1j25s9-0005tR-HP; Wed, 12 Feb 2020 23:13:06 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48J35T6qwCz9sRX; Thu, 13 Feb 2020 15:13:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1581567181;
 bh=23smO4OZpKHGrNoU2HG+RJmTQaQgnv0j+T5ikhvyT8o=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=cMw81FZsjdj1JEx787+GWw43YrQuvVtjzPaOF+ex6ZNjdOgwUczT3K27OIpv3MAqF
 visaZlsYaEl2YllTRjTHgO+rP7/tcKiSOUT7W7pYNzkpJeTJr7ZRw9IW0vPcnQGO+Z
 nkHEtV9BX3NEtYcG8JBanF12/c9XfiJxUIlYQ6dE=
Date: Thu, 13 Feb 2020 14:34:51 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH qemu v6 1/6] ppc: Start CPU in the default mode which is
 big-endian 32bit
Message-ID: <20200213033451.GE124369@umbus.fritz.box>
References: <20200203032943.121178-1-aik@ozlabs.ru>
 <20200203032943.121178-2-aik@ozlabs.ru>
 <20200212054304.GY22584@umbus.fritz.box>
 <5b900904-ccb6-58c7-5e11-c8de1154cc52@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="/2994txjAzEdQwm5"
Content-Disposition: inline
In-Reply-To: <5b900904-ccb6-58c7-5e11-c8de1154cc52@ozlabs.ru>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--/2994txjAzEdQwm5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2020 at 02:09:17PM +1100, Alexey Kardashevskiy wrote:
>=20
>=20
> On 12/02/2020 16:43, David Gibson wrote:
> > On Mon, Feb 03, 2020 at 02:29:38PM +1100, Alexey Kardashevskiy wrote:
> >> At the moment we enforce 64bit mode on a CPU when reset. This does not
> >> make difference as SLOF or Linux set the desired mode straight away.
> >> However if we ever boot something other than these two,
> >> this might not work as, for example, GRUB expects the default MSR state
> >> and does not work properly.
> >>
> >> This removes setting MSR_SF from the PPC CPU reset.
> >=20
> > Hrm.  This is in the core cpu model so it doesn't just affect pseries,
> > but powernv (and theoretically others) as well.  Generally the cpu
> > model should have the bare metal behaviour, and we can override it in
> > the pseries machine if necessary.
> >=20
> > So for a bare metal POWER system, what mode do we start in?  I'm
> > guessing it probably doesn't matter in practice, since the skiboot
> > firmware also probably does a mode set on entry, but it'd be nice to
> > get this right in theory.
>=20
>=20
> Huh. "Figure 65.  MSR setting due to interrupt" of PowerISA 3.0 says
> "The SF bit is set to 1" so after all the existing behavior is correct
> and my patch is just wrong. Cool.

Well, I guess SF after interrupt isn't *necessarily* the same as SF at
reset, but it's a good place to start.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--/2994txjAzEdQwm5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5Ew9gACgkQbDjKyiDZ
s5Iz7Q//a0O2MqL3cFokJTh5ClMOLSKvmShdnHZpPiyw46zVCF6wxZav9OiuNKwA
tGuZ/EVsjX//QTPxICO8RIcutFbBWSlJlWXAdaWXsMRdxZ4TxBLeetFw/piJ/3SO
ZeYLcmK+oin+iMjeuqxRmGlCXr41LyermoLLbOHgm7RWEksM653fuJyJIwZDl4Yy
zRZZ/Yj4z+T+UGOyyJIQloSBxthkeM/gaVcbdL97yVW+kyM3HqWOkO/jCTHrMaPP
xZGnm/5gjrIasVw3z7iuB0bltn9vUZmXL8Bk7iAHdyyj1nZxZNWGLOPeHxgd2nuG
rjkd0tt742KPGNzE0lfJir2I33IyAGS1yJMVcM7evm+rvDdpQ7t1C5vbB5nOu/k3
nuS62tQ27gwNJoIlaGslmfcfWk6iTqgRSTJJqFlu3JG44Af9tZVphB7W9RuL7OR8
sU6dc+WvMBDU6U7IE6ZGIEGs77Y3BU+3CEwrKCcFs6aNAbIUO7pHR6jMMFiqxeih
ejpBNhCgcgK20zs4RjvNA+O/Tt5N3ZHvceqe9K4Y/2BUjQu2nzzSdEseSwrCcqWE
SLi3pk+6/VlsVYVuCUEGbyO5GtFU7vvx8JzKp7CZDEH24/n6kpUWjvpAdQ8euaDe
ZDUL5eQQvYrwrabPC0aCQ3coCV2UmPLYrB2QiwDKFK16YYYdKic=
=rlmM
-----END PGP SIGNATURE-----

--/2994txjAzEdQwm5--

