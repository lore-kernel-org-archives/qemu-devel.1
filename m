Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36FFEC2D0EE
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 01:01:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1F8A2054F
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 01:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="iia9mNs/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1F8A2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJ5HR-00072n-0x
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 21:01:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42503)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jJ5Fn-0005Cv-9Q
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 20:59:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jJ5Fm-0002mt-5V
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 20:59:43 -0400
Received: from ozlabs.org ([203.11.71.1]:46127)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jJ5Fl-0002kF-7r; Mon, 30 Mar 2020 20:59:42 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48rrZc6Rztz9sSM; Tue, 31 Mar 2020 11:59:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1585616376;
 bh=Ryt01ZGy1o3ld80W3U6xgNhpkckeU9adp6xrcWWacxI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=iia9mNs/aiHkfyE2mPzLpAPyBWAproj/H7MdM7UrzIXa9N6qaAMdNrKAFXPF7nyqy
 0R5xWAm/tckfMUBcU28HJBmpMVX8zWZbHq1Vr0qYR4q0EBaVpjQGf0SCCEDYdoanN8
 vEAUJiZCF4vWxMx8M3YzuQZQgYDiKNPPS+UvlocU=
Date: Tue, 31 Mar 2020 11:59:27 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 3/7] target/ppc: Assert if HV mode is set when running
 under a pseries machine
Message-ID: <20200331005927.GF47772@umbus.fritz.box>
References: <20200330094946.24678-1-clg@kaod.org>
 <20200330094946.24678-4-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="3yNHWXBV/QO9xKNm"
Content-Disposition: inline
In-Reply-To: <20200330094946.24678-4-clg@kaod.org>
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
Cc: Suraj Jitindar Singh <sjitindarsingh@gmail.com>, qemu-ppc@nongnu.org,
 Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--3yNHWXBV/QO9xKNm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2020 at 11:49:42AM +0200, C=E9dric Le Goater wrote:
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied to ppc-for-5.1.

> ---
>  target/ppc/mmu-radix64.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
> index f6007e956569..d2422d1c54c9 100644
> --- a/target/ppc/mmu-radix64.c
> +++ b/target/ppc/mmu-radix64.c
> @@ -231,6 +231,7 @@ int ppc_radix64_handle_mmu_fault(PowerPCCPU *cpu, vad=
dr eaddr, int rwx,
>      ppc_v3_pate_t pate;
>      bool relocation;
> =20
> +    assert(!(msr_hv && cpu->vhyp));
>      assert((rwx =3D=3D 0) || (rwx =3D=3D 1) || (rwx =3D=3D 2));
> =20
>      relocation =3D ((rwx =3D=3D 2) && (msr_ir =3D=3D 1)) || ((rwx !=3D 2=
) && (msr_dr =3D=3D 1));

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--3yNHWXBV/QO9xKNm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl6Cle8ACgkQbDjKyiDZ
s5Idfg/+Mywc2lmedc85/8dg7u0nNySVYbvO9XnPtFaGUEZc0gok7KCq1ckT45Dd
+EJYqbGu4NUPS6P9xQA3IFRciszvHo0i1vyIINh2UlGfH5Jffn+7VDJffW/z0NcA
NI10GPoSlDCrPAR0091FLuXZSOggJybGtZGwksRWvewzCNTcGYI/1BTPJlKo3iW1
RVDDHe5JVaOYRLbxTQJrFxM6iDilBaU4mBDf1wYv+HiKPdPybStUBkM4gB/olhTO
nJ8IR8qb3ljx7PnUR4QrKGdKRCi/oBnpx6cFwOG+HBAC28EYHKPhAQI5UizpxeMR
I9PyBHLBbjYI1V73BY/tvNkkruGFEl7AUfMKpSubN4/c5oga4pYthu3yXb3Npln2
Gk1s5o0bHpFwIqGWx6Shc9V1zv4L8QFdPOBKq9Lqsykai22bdD3VzJsSTVKDblep
fwtI7DQJv9pejen5sRGjUmou4D5EeW4zvkEaihH5UI0mDLBprWM4dTKIQuyFL7t/
0GVAlP1XdMQnB45VOTNmQuXBfDw6qkpMdjSXIBDjo7lmFHUKFamkXP/ml95G50nX
inmJ+I58mafHBKaCil9EsLgb3iDeXyqORS+U7Iu50Wn8a+a9K9pcsKPhJD2qX7Fa
/LFk2zW0zNmJJw5TjwYZz5Kg5kT3ouyXdv0k+kyDdPiKvg3p6Bo=
=vDWB
-----END PGP SIGNATURE-----

--3yNHWXBV/QO9xKNm--

