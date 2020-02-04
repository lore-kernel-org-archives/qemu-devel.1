Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA0B9C35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 21:52:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A28CA2082E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 21:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="FWQkbb5h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A28CA2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz67q-0000c6-RZ
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 16:52:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45558)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iz675-0008Ur-K5
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 16:52:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iz674-0002T9-1h
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 16:52:07 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:46783 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iz673-000221-98; Tue, 04 Feb 2020 16:52:05 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48Bz1V2NYbz9sRY; Wed,  5 Feb 2020 08:51:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1580853118;
 bh=YsDa2RIEApyly1mTiKHUZq5vgo/hArd40q56HjR/Jj4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FWQkbb5hzLd4mtuIzxVemGH4kbJBVpNH2otTpmL/JT7MiTAacMe/K2/6TLBRR3h4+
 VcDel/O5rNMuYs7HeXjsQ2s0p+eJvpxTf2dYLS914PSVKUcnGdtzsXR2Z7fZbWzmV9
 H0NPSRheEAdXBEiSKyBsSb8Biys40nN47VmhAI8U=
Date: Tue, 4 Feb 2020 16:58:10 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH qemu] spapr/rtas: Print message from "ibm,os-term"
Message-ID: <20200204055810.GD60221@umbus.fritz.box>
References: <20200203032044.118585-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="a2FkP9tdjPU2nyhF"
Content-Disposition: inline
In-Reply-To: <20200203032044.118585-1-aik@ozlabs.ru>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--a2FkP9tdjPU2nyhF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 03, 2020 at 02:20:44PM +1100, Alexey Kardashevskiy wrote:
> The "ibm,os-term" RTAS call has a single parameter which is a pointer to
> a message from the guest kernel about the termination cause; this prints
> it.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Applied to ppc-for-5.0, thanks.

> ---
>  hw/ppc/spapr_rtas.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> index 883fe28465e6..656fdd221665 100644
> --- a/hw/ppc/spapr_rtas.c
> +++ b/hw/ppc/spapr_rtas.c
> @@ -345,6 +345,13 @@ static void rtas_ibm_os_term(PowerPCCPU *cpu,
>                              target_ulong args,
>                              uint32_t nret, target_ulong rets)
>  {
> +    target_ulong msgaddr =3D rtas_ld(args, 0);
> +    char msg[512];
> +
> +    cpu_physical_memory_read(msgaddr, msg, sizeof(msg) - 1);
> +    msg[sizeof(msg) - 1] =3D 0;
> +
> +    error_report("OS terminated: %s", msg);
>      qemu_system_guest_panicked(NULL);
> =20
>      rtas_st(rets, 0, RTAS_OUT_SUCCESS);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--a2FkP9tdjPU2nyhF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl45B+4ACgkQbDjKyiDZ
s5JWVQ/9GChjxrGU9E6npTsmwM/3j2HOUU8OrCY+CSeqg7G4YZNjwbVnmxoaTEDM
V3lu72BwqyCnUXTMzs4s0RgpFuKb/rKx/SK/vMJe1CJSuk3z7eLE8Yij3DCSXFPW
u1nB/Vd3u52nAd/xsajGb7RQ+kE8h8BYZE18LvddfHa7+yF0fe2rLQQgcZrc4fcI
1Q7Mc8p0GyBfi1YfpLA5cgNxwynIk5PSm3xnoYsXCvnJWz/pxir4hNwP8oeMrxxH
WPb3rgkfBN5/jnhlR2A+8WWeuVo5hUuji+M8D41jkbWiqzF46hpCGDSOAHqOxx3V
eYLpwJ1iNtEuu02XvcxNoZPz8Jz/oNUPVDqnhTAUT8WgNR4RkzZI/v5ooRaGi0aP
nkyKvc8WKyFMkQrZxuGO5WAnp7YocdjBniN+xe2QBsYKZSExOS4Gyk93ozY+/8eG
T+f5jnHXYvejReAUibanyXUmRTOUyl+GGfPRgSAkqR9p0NY/zZDB3CI2DI9s6k3h
a0wOACdDyG4ql3hQc1UGurgb/NSYovsslwT9sAVoXv5OEa9/qjB0FeaHvaACLaiF
W5N02QWvd2brR2yDJ8JgX99vNAqkWexImH+W3gvRb8+HPcNtL+hLuwC65p/+o/m9
EZFMOlT062393XyvfkO9qd7z0NrqYVifc3UqJctIs1auItuEB5g=
=C0gK
-----END PGP SIGNATURE-----

--a2FkP9tdjPU2nyhF--

