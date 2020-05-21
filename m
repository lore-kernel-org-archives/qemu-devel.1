Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9DB9C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 05:15:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 780CA20748
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 05:15:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Cxxu3VkN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 780CA20748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbdXu-0001zo-NK
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 01:15:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32786)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jbdXD-0000ye-Cq; Thu, 21 May 2020 01:14:23 -0400
Received: from ozlabs.org ([203.11.71.1]:52005)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jbdXB-0003Gk-Qz; Thu, 21 May 2020 01:14:23 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49SHpw5ZqYz9sT6; Thu, 21 May 2020 15:14:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1590038056;
 bh=V4BhrQcYdN6rAAw2yhbYrnwa1gmsi0PFHV57Jf1FmHE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Cxxu3VkNbVfUgRr6nqS3KH3IH/ouNoDcAVUAkKDkRQeZdiGPBSzZJvtQDYXvyUi9c
 Mxx+ScDOJlMXz1noRYxlSn7GQWAHIg3JPNb7WFhLbuVw4st4ab1hn1F2sl/nNq6JMW
 AX1xBjy35SN8Way9fPp+CxhHOByLe958LsQtL1cc=
Date: Thu, 21 May 2020 15:13:45 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v2 2/2] spapr: Add a new level of NUMA for GPUs
Message-ID: <20200521051345.GG63349@umbus.fritz.box>
References: <20200518214418.18248-1-arbab@linux.ibm.com>
 <20200518214418.18248-2-arbab@linux.ibm.com>
 <20200521013616.15664254@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Zrag5V6pnZGjLKiw"
Content-Disposition: inline
In-Reply-To: <20200521013616.15664254@bahia.lan>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 23:43:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: qemu-ppc@nongnu.org, Daniel Henrique Barboza <danielhb@linux.ibm.com>,
 Leonardo Augusto Guimaraes Garcia <lagarcia@linux.ibm.com>,
 Reza Arbab <arbab@linux.ibm.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Zrag5V6pnZGjLKiw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2020 at 01:36:16AM +0200, Greg Kurz wrote:
> On Mon, 18 May 2020 16:44:18 -0500
> Reza Arbab <arbab@linux.ibm.com> wrote:
>=20
> > NUMA nodes corresponding to GPU memory currently have the same
> > affinity/distance as normal memory nodes. Add a third NUMA associativity
> > reference point enabling us to give GPU nodes more distance.
> >=20
> > This is guest visible information, which shouldn't change under a
> > running guest across migration between different qemu versions, so make
> > the change effective only in new (pseries > 5.0) machine types.
> >=20
> > Before, `numactl -H` output in a guest with 4 GPUs (nodes 2-5):
> >=20
> > node distances:
> > node   0   1   2   3   4   5
> >   0:  10  40  40  40  40  40
> >   1:  40  10  40  40  40  40
> >   2:  40  40  10  40  40  40
> >   3:  40  40  40  10  40  40
> >   4:  40  40  40  40  10  40
> >   5:  40  40  40  40  40  10
> >=20
> > After:
> >=20
> > node distances:
> > node   0   1   2   3   4   5
> >   0:  10  40  80  80  80  80
> >   1:  40  10  80  80  80  80
> >   2:  80  80  10  80  80  80
> >   3:  80  80  80  10  80  80
> >   4:  80  80  80  80  10  80
> >   5:  80  80  80  80  80  10
> >=20
> > These are the same distances as on the host, mirroring the change made
> > to host firmware in skiboot commit f845a648b8cb ("numa/associativity:
> > Add a new level of NUMA for GPU's").
> >=20
> > Signed-off-by: Reza Arbab <arbab@linux.ibm.com>
> > ---
> >  hw/ppc/spapr.c             | 11 +++++++++--
> >  hw/ppc/spapr_pci_nvlink2.c |  2 +-
> >  2 files changed, 10 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 88b4a1f17716..1d9193d5ee49 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -893,7 +893,11 @@ static void spapr_dt_rtas(SpaprMachineState *spapr=
, void *fdt)
> >      int rtas;
> >      GString *hypertas =3D g_string_sized_new(256);
> >      GString *qemu_hypertas =3D g_string_sized_new(256);
> > -    uint32_t refpoints[] =3D { cpu_to_be32(0x4), cpu_to_be32(0x4) };
> > +    uint32_t refpoints[] =3D {
> > +        cpu_to_be32(0x4),
> > +        cpu_to_be32(0x4),
> > +        cpu_to_be32(0x2),
> > +    };
> >      uint32_t nr_refpoints;
> >      uint64_t max_device_addr =3D MACHINE(spapr)->device_memory->base +
> >          memory_region_size(&MACHINE(spapr)->device_memory->mr);
> > @@ -4544,7 +4548,7 @@ static void spapr_machine_class_init(ObjectClass =
*oc, void *data)
> >      smc->linux_pci_probe =3D true;
> >      smc->smp_threads_vsmt =3D true;
> >      smc->nr_xirqs =3D SPAPR_NR_XIRQS;
> > -    smc->nr_assoc_refpoints =3D 2;
> > +    smc->nr_assoc_refpoints =3D 3;
> >      xfc->match_nvt =3D spapr_match_nvt;
> >  }
> > =20
> > @@ -4611,8 +4615,11 @@ DEFINE_SPAPR_MACHINE(5_1, "5.1", true);
> >   */
> >  static void spapr_machine_5_0_class_options(MachineClass *mc)
> >  {
> > +    SpaprMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
> > +
> >      spapr_machine_5_1_class_options(mc);
> >      compat_props_add(mc->compat_props, hw_compat_5_0, hw_compat_5_0_le=
n);
> > +    smc->nr_assoc_refpoints =3D 2;
> >  }
> > =20
> >  DEFINE_SPAPR_MACHINE(5_0, "5.0", false);
> > diff --git a/hw/ppc/spapr_pci_nvlink2.c b/hw/ppc/spapr_pci_nvlink2.c
> > index 8332d5694e46..247fd48731e2 100644
> > --- a/hw/ppc/spapr_pci_nvlink2.c
> > +++ b/hw/ppc/spapr_pci_nvlink2.c
> > @@ -362,7 +362,7 @@ void spapr_phb_nvgpu_ram_populate_dt(SpaprPhbState =
*sphb, void *fdt)
> >          uint32_t associativity[] =3D {
> >              cpu_to_be32(0x4),
> >              SPAPR_GPU_NUMA_ID,
> > -            SPAPR_GPU_NUMA_ID,
> > +            cpu_to_be32(nvslot->numa_id),
>=20
> This is a guest visible change. It should theoretically be controlled
> with a compat property of the PHB (look for "static GlobalProperty" in
> spapr.c). But since this code is only used for GPU passthrough and we
> don't support migration of such devices, I guess it's okay. Maybe just
> mention it in the changelog.

Yeah, we might get away with it, but it should be too hard to get this
right, so let's do it.

>=20
> >              SPAPR_GPU_NUMA_ID,
> >              cpu_to_be32(nvslot->numa_id)
> >          };
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Zrag5V6pnZGjLKiw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl7GDgkACgkQbDjKyiDZ
s5IzpA//XgLiPKYu3UOjVMQrJ+ebHr5QVvwHxIf10BH7Ux9EUme7YHwy/m6GO4vG
Qm1PKkZ6oys/ujwYFmlbCZSYeJRM9jPUEsgQOMviNl52Hl687l91zftHfll1Si9H
t+Cec3H80tgBO6V2jJORREO083UePk1v98n5SCj6T/z3vliJKXA0+JoiGS3gxsFH
o+C11D1Jb2FSgKAlJZJIF+RTiRQBBwJkI43AXK9r9Fb+ey8am2WREJTSF9KwMngq
CLGHHidky/FPKbO2WYvixMrY6GVIPve3V9DfCgntlRe+CXKRiSLDGA/Oo/HDc1pQ
xq8eNa3VCLDowJOp9SztHgyeD5nrje0t+Bw8xbbHiUOrNYyp9zZB1nlG7FoBZ3m5
Dfy6vfYYDPkH6Th8pZNYqw9xjGHs0cBW4vAFufYE+M+1FDSquGGT3zzuMpx2OPAT
bOE+35bKy5UudswWx7hLkPT/zQbjCeyf1bvij1N6lQBowQZjP76gdqKqALN3oheI
vA0V/S5iWhGzCN6ruLoyI/Jlyps7m6YmyYe6blscb1kFmp2deHCusDxqtnGBiE/G
aKEk1FPzUMju1ct+B4QIkcS79zDqdn9gb5N7gPmRznvZ4+IlVTG9gxPQx90nXTVi
49pnq4Hp2P06Kv2S/hse0hYMSRyEs8M/8d7bQrg/ggjEr5ka6+8=
=8fyH
-----END PGP SIGNATURE-----

--Zrag5V6pnZGjLKiw--

