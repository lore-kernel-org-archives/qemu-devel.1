Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8347AC76186
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 03:41:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E8DD206C2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 03:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="K8qut5pL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E8DD206C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnaoO-0006Dc-62
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 23:41:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42577)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hnao6-0005Pf-2Z
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 23:40:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hnao4-0003iV-0y
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 23:40:41 -0400
Received: from ozlabs.org ([203.11.71.1]:45187)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1hnao0-0003fi-Ap
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 23:40:38 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45pNMJ2Tzgz9sLt; Wed, 17 Jul 2019 13:40:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1563334828;
 bh=1+Zigjlu9mc9HJ1wqc5krsmV9bQGUb1nOoUwYTSDOIU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=K8qut5pLSzuSmib1+Fa9BMCt/04uwWl6YjS1LG5t8cb3vPFZjhNngbLoxan3WjiRT
 xqTsJNT+SyXfbr5VrHXSPE7Ebhe4vY8QwEL8He2rxP35zYSSSEMw8/6zfnDQ7vOhVh
 j2FGCy/FPkrE7mpevie6VDCakH7TdObIfp+VDxsY=
Date: Wed, 17 Jul 2019 13:03:34 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Stefan Brankovic <stefan.brankovic@rt-rk.com>
Message-ID: <20190717030334.GF9123@umbus.fritz.box>
References: <1563200574-11098-1-git-send-email-stefan.brankovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="5CUMAwwhRxlRszMD"
Content-Disposition: inline
In-Reply-To: <1563200574-11098-1-git-send-email-stefan.brankovic@rt-rk.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH v5 0/8] target/ppc: Optimize emulation of
 some Altivec instructions
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
Cc: richard.henderson@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--5CUMAwwhRxlRszMD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2019 at 04:22:46PM +0200, Stefan Brankovic wrote:
> Optimize emulation of ten Altivec instructions: lvsl, lvsr, vsl, vsr, vpk=
px,
> vgbbd, vclzb, vclzh, vclzw and vclzd.
>=20
> This series buils up on and complements recent work of Thomas Murta, Mark
> Cave-Ayland and Richard Henderson in the same area. It is based on devisi=
ng TCG
> translation implementation for selected instructions rather than using he=
lpers.
> The selected instructions are most of the time idiosyncratic to ppc platf=
orm,
> so relatively complex TCG translation (without direct mapping to host
> instruction that is not possible in these cases) seems to be the best opt=
ion,
> and that approach is presented in this series. The performance improvemen=
ts
> are significant in all cases.

I've now also applied patches 4-6 to ppc-for-4.2, leaving just the
ones which don't have acks from rth yet.

>=20
> V5:
>=20
> Fixed vpkpx bug and added it back in patch.
> Fixed graphical distortions on OSX 10.3 and 10.4.
> Removed conversion of vmrgh and vmrgl instructions to vector operations f=
or
> further investigation.
>=20
> V4:
>=20
> Addressed Richard's Henderson's suggestions.
> Removed vpkpx's optimization for further investigation on graphical disto=
rtions
> it caused on OSX 10.2-4 guests.
> Added opcodes for vector vmrgh(b|h|w) and vmrgl(b|h|w) in tcg.
> Implemented vector vmrgh and vmrgl instructions for i386.
> Converted vmrgh and vmrgl instructions to vector operations.
>=20
> V3:
>=20
> Fixed problem during build.
>=20
> V2:
>=20
> Addressed Richard's Henderson's suggestions.
> Fixed problem during build on patch 2/8.
> Rebased series to the latest qemu code.
>=20
> Stefan Brankovic (8):
>   target/ppc: Optimize emulation of lvsl and lvsr instructions
>   target/ppc: Optimize emulation of vsl and vsr instructions
>   target/ppc: Optimize emulation of vpkpx instruction
>   target/ppc: Optimize emulation of vgbbd instruction
>   target/ppc: Optimize emulation of vclzd instruction
>   target/ppc: Optimize emulation of vclzw instruction
>   target/ppc: Optimize emulation of vclzh and vclzb instructions
>   target/ppc: Refactor emulation of vmrgew and vmrgow instructions
>=20
>  target/ppc/helper.h                 |  10 -
>  target/ppc/int_helper.c             | 365 --------------------
>  target/ppc/translate/vmx-impl.inc.c | 656 ++++++++++++++++++++++++++++++=
++----
>  3 files changed, 587 insertions(+), 444 deletions(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--5CUMAwwhRxlRszMD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0ukAQACgkQbDjKyiDZ
s5JIsBAAu729SbosdQDnqM65ufRKH+JMy08S3PPwUcIat0nFCgujbqfMotxRDPb8
d4RhJvynuZ9VnSdO1D73bJbRdD/QzX66ywJdl0JwpJxrIH+kDi9s1pgwdFEd5cw4
QuelvFG5BcKZiAGmu0DIoN/D26TWxnQKwzigyea4NOkSAohZmz7kC361rL2eTd2w
YvFBX7XrcRsR4jEaidfpy6HVzGUqlLbrLpR/xNFYikCFgmAbhar8DBsGK4QMk5Ok
yq00G+3KSC/VXjuC75C075jqaVdwNrnKn8V4uf9wc8SE7eAoYnXsAQKOebcuiofH
yAyQGKzNOfF+dhF83PS+IGHJCSw2Q8sLzqUe/sVfQtJdPOB+aRFKicp7rwpBhVev
K1xa303SAeYcMYhgvWUzpM1oX9WkqkBVM5C535+YvLHlgx/CiPMG9Z9McpiOtRWH
ngyLqCkwekxyXH8Xh4D7YRef/KYMecid8+BiWuCHOgp83L0lMXLCmOwNDfCnhXGr
gvqIOyY5TEbKFeKuCcXL4y8aeFu7hMsNyeuNl2qIotC4+z90oXTrAFZDaqW1GViB
7tiQQFgqmmVdzqhH6llIOo6rFKpjG/biYbQ0CZT08D02380VJll2WkxwRmRYJpy+
H/itOnQ2oYZWlDCxzuxVLCb+7aNMHPwqoKsJRZz4N/T98c/Hg0Y=
=gv0u
-----END PGP SIGNATURE-----

--5CUMAwwhRxlRszMD--

