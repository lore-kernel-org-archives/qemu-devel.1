Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 897EAC10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 06:36:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53A692082E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 06:36:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Xi1PLyyQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53A692082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59760 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEpnI-0006he-9V
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 02:36:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hEplX-0005Jn-Uw
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 02:34:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hEplU-0000nK-JF
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 02:34:22 -0400
Received: from ozlabs.org ([203.11.71.1]:45517)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hEplQ-0000l9-JR; Fri, 12 Apr 2019 02:34:18 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 44gSm46ZFDz9s9y; Fri, 12 Apr 2019 16:34:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1555050852;
	bh=TGUWk4x0fzOiLcIW6/AQYEMY+AyndgLMw18ZOx5v7b4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xi1PLyyQvITDwSIEo34pjRrIh9zXuAILklEvXnXnIHUYeoFe1bz2Bieq9jOS2cN46
	ZFfOjlbxymxZZwRlewQX/ipPoB5YopZyb3fCdDd0v59a2rX0Nd7aVYGzzUjDnbFX5v
	JFEjCf0WdFtnYrUN96I7yCheyE9YIijJWFxCdGpA=
Date: Fri, 12 Apr 2019 16:21:31 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Message-ID: <20190412062131.GF8005@umbus.fritz.box>
References: <20190411080004.8690-1-clg@kaod.org>
	<20190411080004.8690-5-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qftxBdZWiueWNAVY"
Content-Disposition: inline
In-Reply-To: <20190411080004.8690-5-clg@kaod.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH 4/6] ppc/hash32: Rework R and C bit updates
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
	Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190412062131.RIZvWt-4FsmTdCaW7Lz-zsg2Je_TVf6VdFUxRqnCQdI@z>


--qftxBdZWiueWNAVY
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2019 at 10:00:02AM +0200, C=E9dric Le Goater wrote:
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>=20
> With MT-TCG, we are now running translation in a racy way, thus
> we need to mimic hardware when it comes to updating the R and
> C bits, by doing byte stores.
>=20
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied, thanks.

> ---
>  target/ppc/mmu-hash32.c | 45 ++++++++++++++++++++++++++++-------------
>  1 file changed, 31 insertions(+), 14 deletions(-)
>=20
> diff --git a/target/ppc/mmu-hash32.c b/target/ppc/mmu-hash32.c
> index 3f4dee835e2d..55cf156a0b49 100644
> --- a/target/ppc/mmu-hash32.c
> +++ b/target/ppc/mmu-hash32.c
> @@ -345,6 +345,24 @@ static hwaddr ppc_hash32_pteg_search(PowerPCCPU *cpu=
, hwaddr pteg_off,
>      return -1;
>  }
> =20
> +static void ppc_hash32_set_r(PowerPCCPU *cpu, hwaddr pte_offset, uint32_=
t pte1)
> +{
> +    target_ulong base =3D ppc_hash32_hpt_base(cpu);
> +    hwaddr offset =3D pte_offset + 6;
> +
> +    /* The HW performs a non-atomic byte update */
> +    stb_phys(CPU(cpu)->as, base + offset, ((pte1 >> 8) & 0xff) | 0x01);
> +}
> +
> +static void ppc_hash32_set_c(PowerPCCPU *cpu, hwaddr pte_offset, uint64_=
t pte1)
> +{
> +    target_ulong base =3D ppc_hash32_hpt_base(cpu);
> +    hwaddr offset =3D pte_offset + 7;
> +
> +    /* The HW performs a non-atomic byte update */
> +    stb_phys(CPU(cpu)->as, base + offset, (pte1 & 0xff) | 0x80);
> +}
> +
>  static hwaddr ppc_hash32_htab_lookup(PowerPCCPU *cpu,
>                                       target_ulong sr, target_ulong eaddr,
>                                       ppc_hash_pte32_t *pte)
> @@ -403,7 +421,6 @@ int ppc_hash32_handle_mmu_fault(PowerPCCPU *cpu, vadd=
r eaddr, int rwx,
>      hwaddr pte_offset;
>      ppc_hash_pte32_t pte;
>      int prot;
> -    uint32_t new_pte1;
>      const int need_prot[] =3D {PAGE_READ, PAGE_WRITE, PAGE_EXEC};
>      hwaddr raddr;
> =20
> @@ -519,20 +536,20 @@ int ppc_hash32_handle_mmu_fault(PowerPCCPU *cpu, va=
ddr eaddr, int rwx,
> =20
>      /* 8. Update PTE referenced and changed bits if necessary */
> =20
> -    new_pte1 =3D pte.pte1 | HPTE32_R_R; /* set referenced bit */
> -    if (rwx =3D=3D 1) {
> -        new_pte1 |=3D HPTE32_R_C; /* set changed (dirty) bit */
> -    } else {
> -        /*
> -         * Treat the page as read-only for now, so that a later write
> -         * will pass through this function again to set the C bit
> -         */
> -        prot &=3D ~PAGE_WRITE;
> -    }
> -
> -    if (new_pte1 !=3D pte.pte1) {
> -        ppc_hash32_store_hpte1(cpu, pte_offset, new_pte1);
> +    if (!(pte.pte1 & HPTE32_R_R)) {
> +        ppc_hash32_set_r(cpu, pte_offset, pte.pte1);
>      }
> +    if (!(pte.pte1 & HPTE32_R_C)) {
> +        if (rwx =3D=3D 1) {
> +            ppc_hash32_set_c(cpu, pte_offset, pte.pte1);
> +        } else {
> +            /*
> +             * Treat the page as read-only for now, so that a later write
> +             * will pass through this function again to set the C bit
> +             */
> +            prot &=3D ~PAGE_WRITE;
> +        }
> +     }
> =20
>      /* 9. Determine the real address from the PTE */
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--qftxBdZWiueWNAVY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlywLmsACgkQbDjKyiDZ
s5JzOQ/7BAcar/0MgvngS9ZY43x9HaPpC387DXfh9Z/x+Tq29+BqiBDQeOGMbpAf
Tfek55RIt7WMB9RmM0VynwqCbEsYjZEKt/5p0ArS+8rNshXZPkN/SNBFqEsMRyFy
JPPWgLgl1AP27eho5aWStvZJtKcfxA8Td+rYYZqEQn4WjFpg/os2pM9TJ8aVpyMi
Gmy1gmrlOUrlG2qfDARTVB/gv7ZZl+4jlhhr//8++cIQ80gz3j0lEezAz/OPnn6B
LjPMcvG8NHY/+VHStjYa2TcGwPIjgWpX45rLmfB/wT3mIicH6qFc4XZxZr3XttUD
/3pMyXR3xc3ObXJw6aIDi9Nq04EUKWmV2rr+hShLTtcsj/Kh/HRBUxDj3FnHhW5I
J0iF82QaOQld8+FvCYwh49ZdNO5eaIybyV8Z1Kqtarn7DuGFPokHpaMOpcOQL50L
eEcKVbHEbas1CYq3I/uclT8zGuCn6PghwRu0VU1KEQ6cVx7/CwIn+eWB3L/z01sz
4TYeXNs7YuPO3yT88rpupC1HM0iwD975XHnbNFxIRPO0NPB2Ka/zN9EHoe+BgWe9
QCzugeqwzRD1rwnZ+O+5m6+fcx0xlNBtHPAhYVkrWVWeGRSxV1Jn27a+5AODIt8E
o5/6J4dhFGxZ199NiZslsnb/b4ZwBBI4jFtwA07hTuMDgHpg6m4=
=1jkU
-----END PGP SIGNATURE-----

--qftxBdZWiueWNAVY--

