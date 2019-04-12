Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6599FC10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 06:38:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D8B62082E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 06:38:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="gunlv9xJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D8B62082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59786 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEpp4-0008Me-Gf
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 02:38:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hEplc-0005LO-U5
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 02:34:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hEplX-0000q5-Uj
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 02:34:27 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:36285 helo=ozlabs.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hEplU-0000la-9M; Fri, 12 Apr 2019 02:34:21 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 44gSm43Rnnz9s5c; Fri, 12 Apr 2019 16:34:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1555050852;
	bh=okiiehQDm5/MCUtCb6gQrlMlxTy5H3LcdJJaarFrGI8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gunlv9xJjk1YHrs7LWqC3Y7QyfZawyiK49vTnpfT/PC1b+UdEVGCAB0syCf9+Bsp3
	7++vRYtIjXQFvG2tibJpL8n5YNyfOPX51yT24SyDZc3LmFiOAzn0oNxoX6ZiAL6W11
	sfuKvtzUmN4yU8DwMMXv05q20BsyBXhyN02EXDSs=
Date: Fri, 12 Apr 2019 16:10:44 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Message-ID: <20190412061044.GC8005@umbus.fritz.box>
References: <20190411080004.8690-1-clg@kaod.org>
	<20190411080004.8690-2-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Y5rl02BVI9TCfPar"
Content-Disposition: inline
In-Reply-To: <20190411080004.8690-2-clg@kaod.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH 1/6] target/ppc: Don't check UPRT in radix
 mode when in HV real mode
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
Message-ID: <20190412061044.x8LQgywZ885CS_dcYAuWRG9xltnM9e_F34UTIcT_QP4@z>


--Y5rl02BVI9TCfPar
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2019 at 09:59:59AM +0200, C=E9dric Le Goater wrote:
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>=20
> It appears that during kexec, we run for a while in hypervisor
> real mode with LPCR:HR set and LPCR:UPRT clear, which trips
> the assertion in ppc_radix64_handle_mmu_fault().
>=20
> First this shouldn't be an assertion, it's a guest error.
>=20
> Then we shouldn't be checking these things in hypervisor real
> mode (or in virtual hypervisor guest real mode which is similar)
> as the real HW won't use those LPCR bits in those cases anyway,
> so technically it's ok to have this discrepancy.
>=20
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied to ppc-for-4.1, thanks.

> ---
>  target/ppc/mmu-radix64.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>=20
> diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
> index ca1fb2673f93..cac076ee92d9 100644
> --- a/target/ppc/mmu-radix64.c
> +++ b/target/ppc/mmu-radix64.c
> @@ -228,10 +228,10 @@ int ppc_radix64_handle_mmu_fault(PowerPCCPU *cpu, v=
addr eaddr, int rwx,
>      ppc_v3_pate_t pate;
> =20
>      assert((rwx =3D=3D 0) || (rwx =3D=3D 1) || (rwx =3D=3D 2));
> -    assert(ppc64_use_proc_tbl(cpu));
> =20
> -    /* Real Mode Access */
> -    if (((rwx =3D=3D 2) && (msr_ir =3D=3D 0)) || ((rwx !=3D 2) && (msr_d=
r =3D=3D 0))) {
> +    /* HV or virtual hypervisor Real Mode Access */
> +    if ((msr_hv || cpu->vhyp) &&
> +        (((rwx =3D=3D 2) && (msr_ir =3D=3D 0)) || ((rwx !=3D 2) && (msr_=
dr =3D=3D 0)))) {

Hrm.. this looks like a different bug fix.  Were we preivously
incorrectly handling guest real mode when running powernv?

>          /* In real mode top 4 effective addr bits (mostly) ignored */
>          raddr =3D eaddr & 0x0FFFFFFFFFFFFFFFULL;
> =20
> @@ -241,6 +241,16 @@ int ppc_radix64_handle_mmu_fault(PowerPCCPU *cpu, va=
ddr eaddr, int rwx,
>          return 0;
>      }
> =20
> +    /*
> +     * Check UPRT (we avoid the check in real mode to deal with
> +     * transitional states during kexec.
> +     */
> +    if (!ppc64_use_proc_tbl(cpu)) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "LPCR:UPRT not set in radix mode ! LPCR=3D%016lx\n=
",
> +                      env->spr[SPR_LPCR]);
> +    }
> +
>      /* Virtual Mode Access - get the fully qualified address */
>      if (!ppc_radix64_get_fully_qualified_addr(env, eaddr, &lpid, &pid)) {
>          ppc_radix64_raise_segi(cpu, rwx, eaddr);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Y5rl02BVI9TCfPar
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlywK+EACgkQbDjKyiDZ
s5LHbBAAx0fcB2MeWFKDmKNS0G4EG2DmNF1fJERuWPlBZll9JUZZdDcPBtrplHvt
6Qrum/sddTruQ6ti0LSwXLY8IkOTTgwA6vvf4kIEFuVuXFhCjfMEZG4ua8/AOSM+
1GbSdcZYxq6C86dF+vgz5oA+hwnbc/JY6SApS3D/bv+KuJ/oF/jKXHn568yt93BC
zG63mYSJZRzCqsieHjjcVTgOV5FCBTFxvL1KQAv2CVEk/+jlboMFvZZaEoiHw/T3
Dp8PzDj0eyck03GGLzIzbIZnYVSeocn7//9osFgJjHKZ+De2bamN9xUVbOaoS59T
xlvuxdEak/Qqj+cZ9hzUDGNQthD2/x+HkksEOqohIs/NtGJkXuyq9EvrMa3ziMZO
347/WJM2JNV217KyU68jURppK4CHtFNrt5SDX+s4CNxsDuh9WzEqh5eNFcVHIeGi
U9N0vkR23xviGS8oLZwWNCmgMcKLsASeuCnZo57Ag7zhBZ01P3hjoP5aSE2sHcN5
Gh80ekFmEbvULCYPXXj8WIYEn1s8/0Ff0XVQVkqjZke1o2ofcO8dtpFeYef7SD0V
8Omeu8NuO7AeiChlgwKCyLQ8khjALAUJ839dGJ3y3VcqmRKpLwWZLOJ2PHPXRihz
ycgDLF1h+3xIF6bqTL6DHXpkYAOhmaXYBVIdmAq0IVTnIHikEU4=
=ZOsX
-----END PGP SIGNATURE-----

--Y5rl02BVI9TCfPar--

