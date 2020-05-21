Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA14C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 05:15:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6154420748
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 05:15:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="IdFeghp7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6154420748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbdXt-000204-Fv
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 01:15:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32788)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jbdXD-0000yf-EA; Thu, 21 May 2020 01:14:23 -0400
Received: from ozlabs.org ([203.11.71.1]:51605)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jbdXB-0003Gj-LI; Thu, 21 May 2020 01:14:23 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49SHpw4vZBz9sTC; Thu, 21 May 2020 15:14:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1590038056;
 bh=HlpPo307BgyGZ1fDfIK9tCCEldKEwCvd1Wje0PtzBCs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=IdFeghp7A0Lz6rqCGKdbiPKKaWktbRz/A6iGNRsznSLSa/KXTWn7jFlx8syLIrCeR
 q9+ee/ShhkZ6M1exAK55KrsKv1QhyLfpnrw1oE0CnzYiIGlXYRV76GlswtdZuS4XVr
 BtPBNfUoCvblbvptNQuHIFuvtLRPkZ63v7f5pfAM=
Date: Thu, 21 May 2020 15:12:49 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v2 1/2] spapr: Add associativity reference point count to
 machine info
Message-ID: <20200521051249.GF63349@umbus.fritz.box>
References: <20200518214418.18248-1-arbab@linux.ibm.com>
 <20200521013437.5da898fb@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Zi0sgQQBxRFxMTsj"
Content-Disposition: inline
In-Reply-To: <20200521013437.5da898fb@bahia.lan>
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


--Zi0sgQQBxRFxMTsj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2020 at 01:34:37AM +0200, Greg Kurz wrote:
> On Mon, 18 May 2020 16:44:17 -0500
> Reza Arbab <arbab@linux.ibm.com> wrote:
>=20
> > Make the number of NUMA associativity reference points a
> > machine-specific value, using the currently assumed default (two
> > reference points). This preps the next patch to conditionally change it.
> >=20
> > Signed-off-by: Reza Arbab <arbab@linux.ibm.com>
> > ---
> >  hw/ppc/spapr.c         | 6 +++++-
> >  include/hw/ppc/spapr.h | 1 +
> >  2 files changed, 6 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index c18eab0a2305..88b4a1f17716 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -889,10 +889,12 @@ static int spapr_dt_rng(void *fdt)
> >  static void spapr_dt_rtas(SpaprMachineState *spapr, void *fdt)
> >  {
> >      MachineState *ms =3D MACHINE(spapr);
> > +    SpaprMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(ms);
> >      int rtas;
> >      GString *hypertas =3D g_string_sized_new(256);
> >      GString *qemu_hypertas =3D g_string_sized_new(256);
> >      uint32_t refpoints[] =3D { cpu_to_be32(0x4), cpu_to_be32(0x4) };
> > +    uint32_t nr_refpoints;
> >      uint64_t max_device_addr =3D MACHINE(spapr)->device_memory->base +
> >          memory_region_size(&MACHINE(spapr)->device_memory->mr);
> >      uint32_t lrdr_capacity[] =3D {
> > @@ -944,8 +946,9 @@ static void spapr_dt_rtas(SpaprMachineState *spapr,=
 void *fdt)
> >                       qemu_hypertas->str, qemu_hypertas->len));
> >      g_string_free(qemu_hypertas, TRUE);
> > =20
> > +    nr_refpoints =3D MIN(smc->nr_assoc_refpoints, ARRAY_SIZE(refpoints=
));
>=20
> Having the machine requesting more reference points than available
> would clearly be a bug. I'd rather add an assert() than silently
> clipping to the size of refpoints[].

Actually, I think this "num reference points" thing is a false
abstraction.  It's selecting a number of entries from a list of
reference points that's fixed.  The number of things we could do
simply by changing the machine property and not the array is pretty
small.

I think it would be simpler to just have a boolean in the machine
class.

> >      _FDT(fdt_setprop(fdt, rtas, "ibm,associativity-reference-points",
> > -                     refpoints, sizeof(refpoints)));
> > +                     refpoints, nr_refpoints * sizeof(uint32_t)));
> > =20
>=20
> Size can be expressed without yet another explicit reference to the
> uint32_t type:
>=20
> nr_refpoints * sizeof(refpoints[0])
>=20
> >      _FDT(fdt_setprop(fdt, rtas, "ibm,max-associativity-domains",
> >                       maxdomains, sizeof(maxdomains)));
> > @@ -4541,6 +4544,7 @@ static void spapr_machine_class_init(ObjectClass =
*oc, void *data)
> >      smc->linux_pci_probe =3D true;
> >      smc->smp_threads_vsmt =3D true;
> >      smc->nr_xirqs =3D SPAPR_NR_XIRQS;
> > +    smc->nr_assoc_refpoints =3D 2;
>=20
> When adding a new setting for the default machine type, we usually
> take care of older machine types at the same time, ie. folding this
> patch into the next one. Both patches are simple enough that it should
> be okay and this would avoid this line to be touched again.
>=20
> >      xfc->match_nvt =3D spapr_match_nvt;
> >  }
> > =20
> > diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> > index e579eaf28c05..abaf9a92adc0 100644
> > --- a/include/hw/ppc/spapr.h
> > +++ b/include/hw/ppc/spapr.h
> > @@ -129,6 +129,7 @@ struct SpaprMachineClass {
> >      bool linux_pci_probe;
> >      bool smp_threads_vsmt; /* set VSMT to smp_threads by default */
> >      hwaddr rma_limit;          /* clamp the RMA to this size */
> > +    uint32_t nr_assoc_refpoints;
> > =20
> >      void (*phb_placement)(SpaprMachineState *spapr, uint32_t index,
> >                            uint64_t *buid, hwaddr *pio,=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Zi0sgQQBxRFxMTsj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl7GDdEACgkQbDjKyiDZ
s5IkHA/8CMFIMr3Wp+axNjKWt9UBahd8DqIMtKSa6HUvVzbskPOqC+XRRaFwkXyo
p7JSXVjC7P0crPXiYgIVqTzgBhjx8/Qmb1TY0yZ0rgd5Dxzjg4KOUk7FbnEPWqOr
2tqUzKAhF+McoGaI7qyouYvTIZlYUFR9pEypEyeJ5A/fv137yRkEUMp72AnLehPF
k/NPOEbEE0RSrko97FKopEI9o2QYodlLgoO+TAgzk1Z58rMnIklt77yUNhr5JGly
y8wNjlOU/WvcwmtyqWAcmOOpyNkSbJ3pm+y42rBKbCpHxeymkOKCyuMnkRWlEhYI
tFQ2F11CgaNizlMbsAOnGAdyFRl7HyVW7cdaLH+LK5RzIVRE4LMIF3boOo6VMLCd
ECZwBei0ddhhfdMCnQkDzSfTr34kxs/k7bctrfdgFiYwjmoH9kL4ljJo23ZC19iu
dv5TVJ0s9lZijKCDB1tJ8lDmb3aLOVzEsibdqLsr2Cuej6w5UhMSTyksSW8Xqbfk
4UBR5uF5sg4R5fb2DEmbomMdUG5932jn5eIvbGKCvB7P0auNFg0SpoaLEWRG09jo
tV8ymTkf2FO5RFp+SbfJ2KwW1y4tX+eocDhWnRsADurANK/Zq+ilsAoR46grZ4ds
VuDeFnRupX1BbRS+FdRuNk72lDB+HvbEZrajwQwOgcR3VYwwqtw=
=xXKG
-----END PGP SIGNATURE-----

--Zi0sgQQBxRFxMTsj--

