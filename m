Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3626C04E53
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 01:46:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DDDB216FD
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 01:46:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="SjrE4Nha"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DDDB216FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46849 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hR5TY-0007xH-PQ
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 21:46:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hR5R9-00068T-Fq
	for qemu-devel@nongnu.org; Wed, 15 May 2019 21:44:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hR5GN-00006R-Nx
	for qemu-devel@nongnu.org; Wed, 15 May 2019 21:32:55 -0400
Received: from ozlabs.org ([203.11.71.1]:45069)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hR5GK-0008Fl-R8; Wed, 15 May 2019 21:32:51 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 454DSL3RTGz9sDn; Thu, 16 May 2019 11:32:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1557970354;
	bh=sPsIzxFENY+s4b5BcMhm8aYRnomyHt33R/F7WtMHUhQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SjrE4Nhap2/pIMeWcL6Ptkwb/BWJmKBGcDR6B0j8wKu/ip0z8hHVbS2bPLa/mpU65
	zKFt+Y+rCy7/qly7V7/W6U7Gp/ttBeJfjoNQJLDX9IIXyi4cckmd+ualeN9TBG5pR1
	xDrRQMkAZU2cs2USh8Gu7N+ixdAujQP7f9l18+TA=
Date: Thu, 16 May 2019 11:24:56 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Message-ID: <20190516012456.GA3207@umbus.fritz.box>
References: <155793986451.464434.12887933000007255549.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline
In-Reply-To: <155793986451.464434.12887933000007255549.stgit@bahia.lan>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH] spapr/xive: Sanity checks of OV5 during CAS
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>, qemu-ppc@nongnu.org,
	=?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2019 at 07:04:24PM +0200, Greg Kurz wrote:
> If a machine is started with ic-mode=3Dxive but the guest only knows
> about XICS, eg. an RHEL 7.6 guest, the kernel panics. This is
> expected but a bit unfortunate since the crash doesn't provide
> much information for the end user to guess what's happening.
>=20
> Detect that during CAS and exit QEMU with a proper error message
> instead, like it is already done for the MMU.
>=20
> Even if this is less likely to happen, the opposite case of a guest
> that only knows about XIVE would certainly fail all the same if the
> machine is started with ic-mode=3Dxics.
>=20
> Also, the only valid values a guest can pass in byte 23 of OV5 during
> CAS are 0b00 (XIVE legacy mode) and 0b01 (XIVE exploitation mode). Any
> other value is a bug, at least with the current spec. Again, it does
> not seem right to let the guest go on without a precise idea of the
> interrupt mode it asked for.
>=20
> Handle these cases as well.
>=20
> Reported-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
> Signed-off-by: Greg Kurz <groug@kaod.org>

Seems sensible to me, applied.

> ---
>  hw/ppc/spapr_hcall.c |   24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>=20
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 6c16d2b12040..63a55614b83d 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1513,6 +1513,7 @@ static target_ulong h_client_architecture_support(P=
owerPCCPU *cpu,
>      bool guest_radix;
>      Error *local_err =3D NULL;
>      bool raw_mode_supported =3D false;
> +    bool guest_xive;
> =20
>      cas_pvr =3D cas_check_pvr(spapr, cpu, &addr, &raw_mode_supported, &l=
ocal_err);
>      if (local_err) {
> @@ -1545,10 +1546,17 @@ static target_ulong h_client_architecture_support=
(PowerPCCPU *cpu,
>          error_report("guest requested hash and radix MMU, which is inval=
id.");
>          exit(EXIT_FAILURE);
>      }
> +    if (spapr_ovec_test(ov5_guest, OV5_XIVE_BOTH)) {
> +        error_report("guest requested an invalid interrupt mode");
> +        exit(EXIT_FAILURE);
> +    }
> +
>      /* The radix/hash bit in byte 24 requires special handling: */
>      guest_radix =3D spapr_ovec_test(ov5_guest, OV5_MMU_RADIX_300);
>      spapr_ovec_clear(ov5_guest, OV5_MMU_RADIX_300);
> =20
> +    guest_xive =3D spapr_ovec_test(ov5_guest, OV5_XIVE_EXPLOIT);
> +
>      /*
>       * HPT resizing is a bit of a special case, because when enabled
>       * we assume an HPT guest will support it until it says it
> @@ -1632,6 +1640,22 @@ static target_ulong h_client_architecture_support(=
PowerPCCPU *cpu,
>                                            ov5_updates) !=3D 0);
>      }
> =20
> +    /*
> +     * Ensure the guest asks for an interrupt mode we support; otherwise
> +     * terminate the boot.
> +     */
> +    if (guest_xive) {
> +        if (spapr->irq->ov5 =3D=3D SPAPR_OV5_XIVE_LEGACY) {
> +            error_report("Guest requested unavailable interrupt mode (XI=
VE)");
> +            exit(EXIT_FAILURE);
> +        }
> +    } else {
> +        if (spapr->irq->ov5 =3D=3D SPAPR_OV5_XIVE_EXPLOIT) {
> +            error_report("Guest requested unavailable interrupt mode (XI=
CS)");
> +            exit(EXIT_FAILURE);
> +        }
> +    }
> +
>      /*
>       * Generate a machine reset when we have an update of the
>       * interrupt mode. Only required when the machine supports both
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlzcu+YACgkQbDjKyiDZ
s5JrXRAAt9hUmHDbeUgZoTkpt6BrSChd9/n4DCGwQVxcqKmQvH61u4uwfh96Hm2R
7+TPaYVDEFuEkDDyQX6kN3hLb8ETR1nMuAITObriH8cSG7mokf441y+KQioWQ0eb
9rOT8eKwciKjKLkb1Y278MR15LXuTYAiEcznCx4sGuejG3kCOEi5sAscK6ZVCx00
SNV54v19UJfdK/DO+2+dzQ0BND3vg03tjaSev2j6WVsjPXBeL0SONBNpjBZV9Rfv
srxghHDCKzTarofPV22Ou1bu961o9TBg7ZrARsAhWwyktjfWvKF+IK+dews4omO8
HR62CtE7hYvrBvcq40NXhDruvDLvtwU3zTVqcTqc0tKyB3zJJyOwhiitXn29usVg
a01IScdti7X9/AlLWLD9Lmyl4H5m9ZXPp0kxCSBd+NENVkQGMXzmjH/ug5VcakrV
6Wp/NKraMLZU4OlSvAB02XxsfPsmcDYGZcrPsOAiLi01VrbPk8H2pgBPY9hFD7Jp
E4P30CN1yBliVixgKcGH8NsJyWT8kul22ZQavrfmkIYxEJ8O0gr6xd6RD6aw/yck
p5cO3LU2aCdFPAwsq8hv0D5N2IJ1Kdhwj2x5kGjMQJ5S+6yIv/GsXwYF2vxRlycA
4t2lKrvRU3cEmMRahxJDhCVu8wRsVdWVYxs/mnDQqtYmn8JDq80=
=xqmK
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--

