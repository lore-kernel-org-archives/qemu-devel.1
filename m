Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 260B1C2D0EC
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 00:59:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E88222070A
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 00:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="jB3QV9/R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E88222070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHdLk-0003Fs-1m
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 20:59:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46795)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jHdKp-00025L-S2
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 20:58:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jHdKn-00014R-F0
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 20:58:55 -0400
Received: from ozlabs.org ([203.11.71.1]:54961)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jHdKm-0000sJ-C1; Thu, 26 Mar 2020 20:58:53 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48pNlQ4NxFz9sR4; Fri, 27 Mar 2020 11:58:42 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1585270722;
 bh=Za5SZXDzmd6A+1u4wcoYcoaKBQQd+ybL5UQgIOHlA2c=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jB3QV9/R0SYUBOtnByD1Yjuvc/XFzcLJX/hh92SvpSR5SUaVb2cyc/phJthiO+qtz
 rkxCeUAatDpEXrRiwmA51Vt/unidSJcucX+Mrc7hfwNW94IcIfv5LDjhG8Wje++uTZ
 X8hxZfubIAr9r/pJbd0ZTbyH5naSuBwZPTBF8d50=
Date: Fri, 27 Mar 2020 10:55:16 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [RFC for-5.1 1/4] spapr: Refactor locating NVLink2 devices for
 device tree creation
Message-ID: <20200326235516.GC456060@umbus.fritz.box>
References: <20200326054009.454477-1-david@gibson.dropbear.id.au>
 <20200326054009.454477-2-david@gibson.dropbear.id.au>
 <20200326125738.4df23c2b@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="qjNfmADvan18RZcF"
Content-Disposition: inline
In-Reply-To: <20200326125738.4df23c2b@bahia.lan>
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
Cc: aik@ozlabs.ru, qemu-ppc@nongnu.org, clg@kaod.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--qjNfmADvan18RZcF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2020 at 12:57:38PM +0100, Greg Kurz wrote:
65;5803;1c> On Thu, 26 Mar 2020 16:40:06 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > Currently spapr_phb_nvgpu_populate_pcidev_dt() works a little cryptical=
ly.
> > It steps through all the NVLink2 GPUs and NPUs and if they match the de=
vice
> > we're called for, we generate the relevant device tree information.
> >=20
> > Make this a little more obvious by introducing helpers to determine it a
>=20
> ... to determine if a

Fixed, thanks.

>=20
> > given PCI device is an NVLink2 GPU or NPU, returning the NVLink2 slot a=
nd
> > link number information as well.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
>=20
> LGTM
>=20
> Reviewed-by: Greg Kurz <groug@kaod.org>
>=20
> >  hw/ppc/spapr_pci_nvlink2.c | 115 +++++++++++++++++++++++++------------
> >  1 file changed, 79 insertions(+), 36 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr_pci_nvlink2.c b/hw/ppc/spapr_pci_nvlink2.c
> > index 8332d5694e..7d3a685421 100644
> > --- a/hw/ppc/spapr_pci_nvlink2.c
> > +++ b/hw/ppc/spapr_pci_nvlink2.c
> > @@ -390,13 +390,12 @@ void spapr_phb_nvgpu_ram_populate_dt(SpaprPhbStat=
e *sphb, void *fdt)
> > =20
> >  }
> > =20
> > -void spapr_phb_nvgpu_populate_pcidev_dt(PCIDevice *dev, void *fdt, int=
 offset,
> > -                                        SpaprPhbState *sphb)
> > +static bool is_nvgpu(PCIDevice *dev, SpaprPhbState *sphb, int *slot)
> >  {
> > -    int i, j;
> > +    int i;
> > =20
> >      if (!sphb->nvgpus) {
> > -        return;
> > +        return false;
> >      }
> > =20
> >      for (i =3D 0; i < sphb->nvgpus->num; ++i) {
> > @@ -406,47 +405,91 @@ void spapr_phb_nvgpu_populate_pcidev_dt(PCIDevice=
 *dev, void *fdt, int offset,
> >          if (!nvslot->gpdev) {
> >              continue;
> >          }
> > +
> >          if (dev =3D=3D nvslot->gpdev) {
> > -            uint32_t npus[nvslot->linknum];
> > +            if (slot) {
> > +                *slot =3D i;
> > +            }
> > +            return true;
> > +        }
> > +    }
> > =20
> > -            for (j =3D 0; j < nvslot->linknum; ++j) {
> > -                PCIDevice *npdev =3D nvslot->links[j].npdev;
> > +    return false;
> > +}
> > =20
> > -                npus[j] =3D cpu_to_be32(PHANDLE_PCIDEV(sphb, npdev));
> > -            }
> > -            _FDT(fdt_setprop(fdt, offset, "ibm,npu", npus,
> > -                             j * sizeof(npus[0])));
> > -            _FDT((fdt_setprop_cell(fdt, offset, "phandle",
> > -                                   PHANDLE_PCIDEV(sphb, dev))));
> > +static bool is_nvnpu(PCIDevice *dev, SpaprPhbState *sphb, int *slot, i=
nt *link)
> > +{
> > +    int i, j;
> > +
> > +    if (!sphb->nvgpus) {
> > +        return false;
> > +    }
> > +
> > +    for (i =3D 0; i < sphb->nvgpus->num; ++i) {
> > +        SpaprPhbPciNvGpuSlot *nvslot =3D &sphb->nvgpus->slots[i];
> > +
> > +        /* Skip "slot" without attached GPU */
> > +        if (!nvslot->gpdev) {
> >              continue;
> >          }
> > =20
> >          for (j =3D 0; j < nvslot->linknum; ++j) {
> > -            if (dev !=3D nvslot->links[j].npdev) {
> > -                continue;
> > +            if (dev =3D=3D nvslot->links[j].npdev) {
> > +                if (slot) {
> > +                    *slot =3D i;
> > +                }
> > +                if (link) {
> > +                    *link =3D j;
> > +                }
> > +                return true;
> >              }
> > +        }
> > +    }
> > =20
> > -            _FDT((fdt_setprop_cell(fdt, offset, "phandle",
> > -                                   PHANDLE_PCIDEV(sphb, dev))));
> > -            _FDT(fdt_setprop_cell(fdt, offset, "ibm,gpu",
> > -                                  PHANDLE_PCIDEV(sphb, nvslot->gpdev))=
);
> > -            _FDT((fdt_setprop_cell(fdt, offset, "ibm,nvlink",
> > -                                   PHANDLE_NVLINK(sphb, i, j))));
> > -            /*
> > -             * If we ever want to emulate GPU RAM at the same location=
 as on
> > -             * the host - here is the encoding GPA->TGT:
> > -             *
> > -             * gta  =3D ((sphb->nv2_gpa >> 42) & 0x1) << 42;
> > -             * gta |=3D ((sphb->nv2_gpa >> 45) & 0x3) << 43;
> > -             * gta |=3D ((sphb->nv2_gpa >> 49) & 0x3) << 45;
> > -             * gta |=3D sphb->nv2_gpa & ((1UL << 43) - 1);
> > -             */
> > -            _FDT(fdt_setprop_cell(fdt, offset, "memory-region",
> > -                                  PHANDLE_GPURAM(sphb, i)));
> > -            _FDT(fdt_setprop_u64(fdt, offset, "ibm,device-tgt-addr",
> > -                                 nvslot->tgt));
> > -            _FDT(fdt_setprop_cell(fdt, offset, "ibm,nvlink-speed",
> > -                                  nvslot->links[j].link_speed));
> > +    return false;
> > +}
> > +
> > +void spapr_phb_nvgpu_populate_pcidev_dt(PCIDevice *dev, void *fdt, int=
 offset,
> > +                                        SpaprPhbState *sphb)
> > +{
> > +    int slot, link;
> > +
> > +    if (is_nvgpu(dev, sphb, &slot)) {
> > +        SpaprPhbPciNvGpuSlot *nvslot =3D &sphb->nvgpus->slots[slot];
> > +        uint32_t npus[nvslot->linknum];
> > +
> > +        for (link =3D 0; link < nvslot->linknum; ++link) {
> > +            PCIDevice *npdev =3D nvslot->links[link].npdev;
> > +
> > +            npus[link] =3D cpu_to_be32(PHANDLE_PCIDEV(sphb, npdev));
> >          }
> > +        _FDT(fdt_setprop(fdt, offset, "ibm,npu", npus,
> > +                         link * sizeof(npus[0])));
> > +        _FDT((fdt_setprop_cell(fdt, offset, "phandle",
> > +                               PHANDLE_PCIDEV(sphb, dev))));
> > +    } else if (is_nvnpu(dev, sphb, &slot, &link)) {
> > +        SpaprPhbPciNvGpuSlot *nvslot =3D &sphb->nvgpus->slots[slot];
> > +
> > +        _FDT((fdt_setprop_cell(fdt, offset, "phandle",
> > +                               PHANDLE_PCIDEV(sphb, dev))));
> > +        _FDT(fdt_setprop_cell(fdt, offset, "ibm,gpu",
> > +                              PHANDLE_PCIDEV(sphb, nvslot->gpdev)));
> > +        _FDT((fdt_setprop_cell(fdt, offset, "ibm,nvlink",
> > +                               PHANDLE_NVLINK(sphb, slot, link))));
> > +        /*
> > +         * If we ever want to emulate GPU RAM at the same location as
> > +         * on the host - here is the encoding GPA->TGT:
> > +         *
> > +         * gta  =3D ((sphb->nv2_gpa >> 42) & 0x1) << 42;
> > +         * gta |=3D ((sphb->nv2_gpa >> 45) & 0x3) << 43;
> > +         * gta |=3D ((sphb->nv2_gpa >> 49) & 0x3) << 45;
> > +         * gta |=3D sphb->nv2_gpa & ((1UL << 43) - 1);
> > +         */
> > +        _FDT(fdt_setprop_cell(fdt, offset, "memory-region",
> > +                              PHANDLE_GPURAM(sphb, slot)));
> > +        _FDT(fdt_setprop_u64(fdt, offset, "ibm,device-tgt-addr",
> > +                             nvslot->tgt));
> > +        _FDT(fdt_setprop_cell(fdt, offset, "ibm,nvlink-speed",
> > +                              nvslot->links[link].link_speed));
> >      }
> >  }
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--qjNfmADvan18RZcF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl59QOQACgkQbDjKyiDZ
s5K7BhAAt4LuoGKHTup+dmFCqD7T66svfvOzdx8HiilERAs6ENW0DKQolo4S2lOi
5l2hlncT0jPDdhlhW6QGPhz1xs4HhdHPaWVwUTVA8Q9EWdQntHRNlC4FqO6QCUUc
clcr2xKdDaKBz6/O5u2/+kDXR6dq3ncoUw1Sqa1A2zQAqaIweRfYEBSjDCDCI/G+
vO9UlU7c6sQm0pilJlIiR/s5lnSXT440fu9+GHzjpcnne9qu2wT3ljRRmmV5paig
q6g3z6zVnZx7euJWZSMEXcMynGpaBwShTC2Lf33xQ0Xw29jgjTzWve+UOxMURW4C
nGPetlrNKjIhEnofyhbxhHbo6VyX/Bm5UCb62c0RDCRZt9qtuvrODfUE5bRsTrpR
hM67CGtkK7B8H3QpMZsIwgK8fy6emgiEjR+7Xnmp76JZhlIRCija2OBm18VAVLNI
BkATbm2Dj/2V1tGhM/tuCn8/IU2b68FRXr5FCf9hUvcHB9PB2fDqo8A4L4ZgCRAv
01mQxZUBBIIQw2CXZK1nwtsxmvQsPS/paEd0Y0GuSGvMgX6prDzV0QNT/msbpG4h
oR/7jqxslN/IGbBokIyueD3TfpJJ9XPT4E/tTFkr7WuXDfwPpil3Tevw6eA0pKWX
gxVQmvWcfVq1STri3KiUHbVeDMuG8XeG8APYqhFSWbM6CUwauAY=
=EU2e
-----END PGP SIGNATURE-----

--qjNfmADvan18RZcF--

