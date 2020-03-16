Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96533C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 23:33:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DCB1205ED
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 23:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="OIFVdv1X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DCB1205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDzEs-0000nx-I9
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 19:33:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50380)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jDzDa-0007dU-E9
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 19:32:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jDzDZ-0005dz-2Y
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 19:32:22 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:44157 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jDzDY-0004ya-7R; Mon, 16 Mar 2020 19:32:20 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48hCJJ30Fwz9sRR; Tue, 17 Mar 2020 10:32:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1584401536;
 bh=DNyPYA+nO4b3fa8B0bkXyh8dNit8KveOaim+6PvxVpc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=OIFVdv1X3zIG9YZjuG6zfHrv/FzHoiKnf6ip1g9ECABe1KOrLK23SGQinZF3oyObZ
 ikwRGLojoNdHzMitOxUFfXBweR66xtLrt3RsDU8Fovll8u+Q5bQwTUmsEul3ULFkXF
 bi19W6b01I1vr2sMfEQt/HI92gncs5/hrOLgl8i4=
Date: Tue, 17 Mar 2020 10:30:29 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 7/8] ppc/spapr: Implement FWNMI System Reset delivery
Message-ID: <20200316233029.GG20264@umbus.fritz.box>
References: <20200316142613.121089-1-npiggin@gmail.com>
 <20200316142613.121089-8-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="WkfBGePaEyrk4zXB"
Content-Disposition: inline
In-Reply-To: <20200316142613.121089-8-npiggin@gmail.com>
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
Cc: Aravinda Prasad <arawinda.p@gmail.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>, Ganesh Goudar <ganeshgr@linux.ibm.com>,
 qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--WkfBGePaEyrk4zXB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2020 at 12:26:12AM +1000, Nicholas Piggin wrote:
> PAPR requires that if "ibm,nmi-register" succeeds, then the hypervisor
> delivers all system reset and machine check exceptions to the registered
> addresses.
>=20
> System Resets are delivered with registers set to the architected state,
> and with no interlock.
>=20
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to ppc-for-5.0.

> ---
>  hw/ppc/spapr.c | 46 ++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 44 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 25221d843c..78e649f47d 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -967,7 +967,29 @@ static void spapr_dt_rtas(SpaprMachineState *spapr, =
void *fdt)
>      _FDT(fdt_setprop(fdt, rtas, "ibm,max-associativity-domains",
>                       maxdomains, sizeof(maxdomains)));
> =20
> -    _FDT(fdt_setprop_cell(fdt, rtas, "rtas-size", RTAS_SIZE));
> +    /*
> +     * FWNMI reserves RTAS_ERROR_LOG_MAX for the machine check error log,
> +     * and 16 bytes per CPU for system reset error log plus an extra 8 b=
ytes.
> +     *
> +     * The system reset requirements are driven by existing Linux and Po=
werVM
> +     * implementation which (contrary to PAPR) saves r3 in the error log
> +     * structure like machine check, so Linux expects to find the saved =
r3
> +     * value at the address in r3 upon FWNMI-enabled sreset interrupt (a=
nd
> +     * does not look at the error value).
> +     *
> +     * System reset interrupts are not subject to interlock like machine
> +     * check, so this memory area could be corrupted if the sreset is
> +     * interrupted by a machine check (or vice versa) if it was shared. =
To
> +     * prevent this, system reset uses per-CPU areas for the sreset save
> +     * area. A system reset that interrupts a system reset handler could
> +     * still overwrite this area, but Linux doesn't try to recover in th=
at
> +     * case anyway.
> +     *
> +     * The extra 8 bytes is required because Linux's FWNMI error log che=
ck
> +     * is off-by-one.
> +     */
> +    _FDT(fdt_setprop_cell(fdt, rtas, "rtas-size", RTAS_ERROR_LOG_MAX +
> +			  ms->smp.max_cpus * sizeof(uint64_t)*2 + sizeof(uint64_t)));
>      _FDT(fdt_setprop_cell(fdt, rtas, "rtas-error-log-max",
>                            RTAS_ERROR_LOG_MAX));
>      _FDT(fdt_setprop_cell(fdt, rtas, "rtas-event-scan-rate",
> @@ -3399,8 +3421,28 @@ static void spapr_machine_finalizefn(Object *obj)
> =20
>  void spapr_do_system_reset_on_cpu(CPUState *cs, run_on_cpu_data arg)
>  {
> +    SpaprMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
> +
>      cpu_synchronize_state(cs);
> -    ppc_cpu_do_system_reset(cs, -1);
> +    /* If FWNMI is inactive, addr will be -1, which will deliver to 0x10=
0 */
> +    if (spapr->fwnmi_system_reset_addr !=3D -1) {
> +        uint64_t rtas_addr, addr;
> +        PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> +        CPUPPCState *env =3D &cpu->env;
> +
> +        /* get rtas addr from fdt */
> +        rtas_addr =3D spapr_get_rtas_addr();
> +        if (!rtas_addr) {
> +            qemu_system_guest_panicked(NULL);
> +            return;
> +        }
> +
> +        addr =3D rtas_addr + RTAS_ERROR_LOG_MAX + cs->cpu_index * sizeof=
(uint64_t)*2;
> +        stq_be_phys(&address_space_memory, addr, env->gpr[3]);
> +        stq_be_phys(&address_space_memory, addr + sizeof(uint64_t), 0);
> +        env->gpr[3] =3D addr;
> +    }
> +    ppc_cpu_do_system_reset(cs, spapr->fwnmi_system_reset_addr);
>  }
> =20
>  static void spapr_nmi(NMIState *n, int cpu_index, Error **errp)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--WkfBGePaEyrk4zXB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5wDBUACgkQbDjKyiDZ
s5IQthAA2USi1wwSuK9dRkSCHFUR1b88SKA0Rm7+/7b9JfFMMUjYRJt6wbWKXC22
FUDU8l2gR9Ii8oslvFw7e2b9vVOGFA/aYcZ2EV5FSLhBTF7uPXJRqt0OQVUJEUtD
G1X9vSpVhnfVa15IDsTs8P5wya03a++gQNo4aVnEnDZjdRgb0OhEjgLwu0Kvgair
Bf35MpkczTtxjRVfBPtPzM+pomv3o9OfbYCkPnAhUxzHhH8DVDaYQ5feDyNkU7Yq
eLhVTIXEp0XzST25/hRP2DXERtkKamf9ryCKu7cukpXAu9EkbHkx5WefvykQAeCQ
ujIl8XX/+bmH9/WJSmBz4rYEOycsGTY8jKEz+y847UaSSvQGKYI0H7jO9HAOY/gL
g6o33Qu1bnJfAn8WHlNiZSWIn+AINdPl+Wgc9zUZQnQPFe9vI9b9yqnPNtfcprrZ
zkhFDQLaRFukXqCevpqJMQP6hED3NIB0UsEUiMriI6vQvY6cpCOba8NMdOEc/ZRi
W8GknNOjdYh2qpVCriImNMWPXYjfvHqvctFAohgFOdEh+qCYni0g4SnfqzDABNAt
ihAhb8RyNG9TmpjzUeXBZvbW3zZX5OBVnd2147O9biuL1a4mEV7w3lsaBtze/QBu
BVpqHbcSPT8F1hZFgKl1V1pv4/u3oGCD66Na8hT+falB+aYsQV4=
=FvRR
-----END PGP SIGNATURE-----

--WkfBGePaEyrk4zXB--

