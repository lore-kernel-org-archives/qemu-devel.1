Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF252C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 05:38:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A956020652
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 05:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="nX3c+zN6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A956020652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieYES-00011F-R9
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 00:38:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38378)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ieYDo-0000O4-H7
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 00:38:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ieYDm-0002KY-P1
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 00:38:08 -0500
Received: from ozlabs.org ([203.11.71.1]:49563)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ieYDl-0002Js-Iz; Tue, 10 Dec 2019 00:38:06 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47X83X6GHvz9sRH; Tue, 10 Dec 2019 16:38:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1575956280;
 bh=zBb4vPVAkFQWtQKkyA3yoOb1WqT8DaCN2ZAl1x8JrCI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=nX3c+zN60BrAVTEhv7SH9BBNGxsOfTf42SijFVYW3uNAVSYd3ISRxchg/ajdZsgsW
 yG8YTBDojCCsoxVU2I3qUoQca4ZMayfmazwf4KgxIN9B06d6t8eC9huftjqJdO9llv
 CGNXDTJZZe4bpXl+A+qzL824j7qFv8mzj7CyN2wQ=
Date: Tue, 10 Dec 2019 16:29:06 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [for-5.0 3/4] spapr: Clean up RMA size calculation
Message-ID: <20191210052906.GJ207300@umbus.fritz.box>
References: <20191129013504.145455-1-david@gibson.dropbear.id.au>
 <20191129013504.145455-4-david@gibson.dropbear.id.au>
 <26f70f7b-d2e3-689a-693e-66ced0f6d4f8@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="j+MD90OnwjQyWNYt"
Content-Disposition: inline
In-Reply-To: <26f70f7b-d2e3-689a-693e-66ced0f6d4f8@ozlabs.ru>
User-Agent: Mutt/1.12.1 (2019-06-15)
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
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 groug@kaod.org, clg@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--j+MD90OnwjQyWNYt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 03, 2019 at 02:44:06PM +1100, Alexey Kardashevskiy wrote:
>=20
>=20
> On 29/11/2019 12:35, David Gibson wrote:
> > Move the calculation of the Real Mode Area (RMA) size into a helper
> > function.  While we're there clean it up and correct it in a few ways:
> >   * Add comments making it clearer where the various constraints come f=
rom
> >   * Remove a pointless check that the RMA fits within Node 0 (we've just
> >     clamped it so that it does)
> >   * The 16GiB limit we apply is only correct for POWER8, but there is a=
lso
> >     a 1TiB limit that applies on POWER9.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  hw/ppc/spapr.c | 57 +++++++++++++++++++++++++++++++-------------------
> >  1 file changed, 35 insertions(+), 22 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 52c39daa99..7efd4f2b85 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -2664,6 +2664,40 @@ static PCIHostState *spapr_create_default_phb(vo=
id)
> >      return PCI_HOST_BRIDGE(dev);
> >  }
> > =20
> > +static hwaddr spapr_rma_size(SpaprMachineState *spapr, Error **errp)
> > +{
> > +    MachineState *machine =3D MACHINE(spapr);
> > +    hwaddr rma_size =3D machine->ram_size;
> > +    hwaddr node0_size =3D spapr_node0_size(machine);
> > +
> > +    /* RMA has to fit in the first NUMA node */
> > +    rma_size =3D MIN(rma_size, node0_size);
> > +
> > +    /*
> > +     * VRMA access is via a special 1TiB SLB mapping, so the RMA can
> > +     * never exceed that
> > +     */
> > +    rma_size =3D MIN(rma_size, TiB);
> > +
> > +    /*
> > +     * RMA size is controlled in hardware by LPCR[RMLS].  On POWER8
>=20
>=20
> RMA is controlled by LPCR on P8 but the RMLS bits on P9 are reserved
> (also reserved in PowerISA 3.0).
>=20
>=20
> > +     * the largest RMA that can be specified there is 16GiB
>=20
>=20
> The P8 user manual says:
> =3D=3D=3D
> The following RMO sizes are available for the POWER8 processor.
> The RMLS[34:37] field in the LPCR defines the RMO sizes, as described bel=
ow.
> 1000 - 32 MB
> 0011 - 64 MB
> 0111 - 128 MB
> 0100 - 256 MB
> 0010 - 1 GB
> 0001 - 16 GB
> 0000 - 256 GB
> =3D=3D=3D
>=20
> The maximum seems to be 256GiB.

Huh.  Ok, looks like I was wrong about where that 16GiB clamp came
=66rom originally.  I wonder where it *did* come from, or if it's simply
wrong.

> > +     */
> > +    if (!ppc_type_check_compat(machine->cpu_type, CPU_POWERPC_LOGICAL_=
3_00,
> > +                               0, spapr->max_compat_pvr)) {
> > +        rma_size =3D MIN(rma_size, 16 * GiB);
> > +    }
> > +
> > +    if (rma_size < (MIN_RMA_SLOF * MiB)) {
>=20
>=20
> nit: it is time to redefine MIN_RMA_SLOF to use MiBs imho :)

Yeah, I'd thought about that too.  I've added a patch to clean that up.

>=20
>=20
> > +        error_setg(errp,
> > +"pSeries SLOF firmware requires >=3D %ldMiB guest RMA (Real Mode Area)=
",
> > +                   MIN_RMA_SLOF);
>=20
> Something went wrong with formatting here.

Actually, that's intentional.  The idea is to keep the string on one
line for greppability, without going too far to the right.  I believe
that's a generally accepted exception to the usual formatting rules in
qemu.

>=20
> Otherwise looks good. Thanks,
>=20
>=20
>=20
> > +        return -1;
> > +    }
> > +
> > +    return rma_size;
> > +}
> > +
> >  /* pSeries LPAR / sPAPR hardware init */
> >  static void spapr_machine_init(MachineState *machine)
> >  {
> > @@ -2675,7 +2709,6 @@ static void spapr_machine_init(MachineState *mach=
ine)
> >      int i;
> >      MemoryRegion *sysmem =3D get_system_memory();
> >      MemoryRegion *ram =3D g_new(MemoryRegion, 1);
> > -    hwaddr node0_size =3D spapr_node0_size(machine);
> >      long load_limit, fw_size;
> >      char *filename;
> >      Error *resize_hpt_err =3D NULL;
> > @@ -2715,20 +2748,7 @@ static void spapr_machine_init(MachineState *mac=
hine)
> >          exit(1);
> >      }
> > =20
> > -    spapr->rma_size =3D node0_size;
> > -
> > -    /* Actually we don't support unbounded RMA anymore since we added
> > -     * proper emulation of HV mode. The max we can get is 16G which
> > -     * also happens to be what we configure for PAPR mode so make sure
> > -     * we don't do anything bigger than that
> > -     */
> > -    spapr->rma_size =3D MIN(spapr->rma_size, 0x400000000ull);
> > -
> > -    if (spapr->rma_size > node0_size) {
> > -        error_report("Numa node 0 has to span the RMA (%#08"HWADDR_PRI=
x")",
> > -                     spapr->rma_size);
> > -        exit(1);
> > -    }
> > +    spapr->rma_size =3D spapr_rma_size(spapr, &error_fatal);
> > =20
> >      /* Setup a load limit for the ramdisk leaving room for SLOF and FD=
T */
> >      load_limit =3D MIN(spapr->rma_size, RTAS_MAX_ADDR) - FW_OVERHEAD;
> > @@ -2956,13 +2976,6 @@ static void spapr_machine_init(MachineState *mac=
hine)
> >          }
> >      }
> > =20
> > -    if (spapr->rma_size < (MIN_RMA_SLOF * MiB)) {
> > -        error_report(
> > -            "pSeries SLOF firmware requires >=3D %ldM guest RMA (Real =
Mode Area memory)",
> > -            MIN_RMA_SLOF);
> > -        exit(1);
> > -    }
> > -
> >      if (kernel_filename) {
> >          uint64_t lowaddr =3D 0;
> > =20
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--j+MD90OnwjQyWNYt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3vLSIACgkQbDjKyiDZ
s5In5hAAj9QQmrVsQVS8EhKIbhxYV/aDWyfo79ZXq62UPlrxCQLG6/y5MAGFgnK4
CGPqXAfGUldderKIHqG5cRU21w6ZGoCldEXhc6JVHpEv/pBcv+XJaZLRz6cKtOJP
5Ab+nKt8YtWxzsyakid22IPK+dDnEPaGOnBCQAqxcPQqKmFYuSFqUSvSd2m/wfVz
ziKjJ4nBOtOF0hzVnTgiBv9+lBL7RKBKunK3EwDmXBOF3um8/i26y3P3PLFYKEdf
kzAVi3ESA+JWUCOGdRj0pH59Pq7WrNvi8HI8sDrPa/bh1TNPLayGBw0Iiy2GOOeO
vxSH16OQQC5/IIxPkslEqUTFC2B6scf2gwmg7ZZymcRtmJJKC7ODR4KiAiQ71V15
3t9Stk5zGJaAVvffQ2X8KN/ye8A9IsGnsuA23WtwT3eOAYUTltCMVSFpo0kgTDEh
NrfkqpaBx+lP+VVNNMGW6Hl5ctg0ScRjmrmaYf9E6NmxZHlwAH8MabAUbue3a/MB
VU70ybnVAx8smC9A7wRot/ym/4k6Ef0ezXAi/R5X5xuSV4bPJgsDHPlVFkHKkHm7
rsUMFnab2TYJbqr+maVWzGH8/mG9xsv2p3FpxgP4kHp5i7YlUukhIF+zZQoScOjC
97Wu4+IQFhdpOVApkg/ksfXeMSZ4uUha/cVsiV3YuU24OB8qBPU=
=/Zrq
-----END PGP SIGNATURE-----

--j+MD90OnwjQyWNYt--

