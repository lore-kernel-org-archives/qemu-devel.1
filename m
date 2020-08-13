Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A5D6C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 11:11:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0113020791
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 11:11:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="D6wLMLvb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0113020791
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6B8U-0002Hd-6J
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 07:11:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58138)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k6B7W-0000ZK-HG; Thu, 13 Aug 2020 07:10:06 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:50241 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k6B7T-0002ny-VJ; Thu, 13 Aug 2020 07:10:06 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BS3kb56qrz9sTH; Thu, 13 Aug 2020 21:09:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1597316999;
 bh=QJJJZwd1YLPuT8GgXwy/R9jbDIc8rvWxt84eandFw5c=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=D6wLMLvbLuc+QA9nbzGLz+1tPXEcEUhbGwk/zzKP3a165VrHPpRM5HTFLUTXDLD+3
 IgThVDUEHJWHjDETKbjd3DLSzQAeWHBIl72Pph6tcYb18YLXjA0XXfMR+3euTyKLpm
 2rIvvYSTSUAAPu39vYv9xN/316dn+Nm3lXRQm7zM=
Date: Thu, 13 Aug 2020 20:50:41 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v3 for-5.2 1/3] ppc/xive: Rework setup of
 XiveSource::esb_mmio
Message-ID: <20200813105041.GA5509@yekko.fritz.box>
References: <159679991916.876294.8967140647442842745.stgit@bahia.lan>
 <159679992680.876294.7520540158586170894.stgit@bahia.lan>
 <ed5e553d-0cd5-9195-ff0d-681b79d432c1@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline
In-Reply-To: <ed5e553d-0cd5-9195-ff0d-681b79d432c1@kaod.org>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: Daniel Henrique Barboza <danielhb@linux.ibm.com>, qemu-ppc@nongnu.org,
 Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 07, 2020 at 02:36:01PM +0200, C=E9dric Le Goater wrote:
> On 8/7/20 1:32 PM, Greg Kurz wrote:
> > Depending on whether XIVE is emultated or backed with a KVM XIVE device,
> > the ESB MMIOs of a XIVE source point to an I/O memory region or a mapped
> > memory region.
> >=20
> > This is currently handled by checking kvm_irqchip_in_kernel() returns
> > false in xive_source_realize(). This is a bit awkward as we usually
> > need to do extra things when we're using the in-kernel backend, not
> > less. But most important, we can do better: turn the existing "xive.esb"
> > memory region into a plain container, introduce an "xive.esb-emulated"
> > I/O subregion and rename the existing "xive.esb" subregion in the KVM
> > code to "xive.esb-kvm". Since "xive.esb-kvm" is added with overlap
> > and a higher priority, it prevails over "xive.esb-emulated" (ie.
> > a guest using KVM XIVE will interact with "xive.esb-kvm" instead of
> > the default "xive.esb-emulated" region.
> >=20
> > While here, consolidate the computation of the MMIO region size in
> > a common helper.
> >=20
> > Suggested-by: C=E9dric Le Goater <clg@kaod.org>
> > Signed-off-by: Greg Kurz <groug@kaod.org>
>=20
> This is much better
>=20
> Reviewed-by: C=E9dric Le Goater <clg@kaod.org>

Appled to ppc-for-5.2.

>=20
> Thanks,
>=20
> C.
>=20
> > ---
> >  hw/intc/spapr_xive_kvm.c |    4 ++--
> >  hw/intc/xive.c           |   11 ++++++-----
> >  include/hw/ppc/xive.h    |    6 ++++++
> >  3 files changed, 14 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
> > index 893a1ee77e70..6130882be678 100644
> > --- a/hw/intc/spapr_xive_kvm.c
> > +++ b/hw/intc/spapr_xive_kvm.c
> > @@ -742,7 +742,7 @@ int kvmppc_xive_connect(SpaprInterruptController *i=
ntc, uint32_t nr_servers,
> >      SpaprXive *xive =3D SPAPR_XIVE(intc);
> >      XiveSource *xsrc =3D &xive->source;
> >      Error *local_err =3D NULL;
> > -    size_t esb_len =3D (1ull << xsrc->esb_shift) * xsrc->nr_irqs;
> > +    size_t esb_len =3D xive_source_esb_len(xsrc);
> >      size_t tima_len =3D 4ull << TM_SHIFT;
> >      CPUState *cs;
> >      int fd;
> > @@ -788,7 +788,7 @@ int kvmppc_xive_connect(SpaprInterruptController *i=
ntc, uint32_t nr_servers,
> >      }
> > =20
> >      memory_region_init_ram_device_ptr(&xsrc->esb_mmio_kvm, OBJECT(xsrc=
),
> > -                                      "xive.esb", esb_len, xsrc->esb_m=
map);
> > +                                      "xive.esb-kvm", esb_len, xsrc->e=
sb_mmap);
> >      memory_region_add_subregion_overlap(&xsrc->esb_mmio, 0,
> >                                          &xsrc->esb_mmio_kvm, 1);
> > =20
> > diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> > index 9b55e0356c62..561d746cd1da 100644
> > --- a/hw/intc/xive.c
> > +++ b/hw/intc/xive.c
> > @@ -1128,6 +1128,7 @@ static void xive_source_reset(void *dev)
> >  static void xive_source_realize(DeviceState *dev, Error **errp)
> >  {
> >      XiveSource *xsrc =3D XIVE_SOURCE(dev);
> > +    size_t esb_len =3D xive_source_esb_len(xsrc);
> > =20
> >      assert(xsrc->xive);
> > =20
> > @@ -1147,11 +1148,11 @@ static void xive_source_realize(DeviceState *de=
v, Error **errp)
> >      xsrc->status =3D g_malloc0(xsrc->nr_irqs);
> >      xsrc->lsi_map =3D bitmap_new(xsrc->nr_irqs);
> > =20
> > -    if (!kvm_irqchip_in_kernel()) {
> > -        memory_region_init_io(&xsrc->esb_mmio, OBJECT(xsrc),
> > -                              &xive_source_esb_ops, xsrc, "xive.esb",
> > -                              (1ull << xsrc->esb_shift) * xsrc->nr_irq=
s);
> > -    }
> > +    memory_region_init(&xsrc->esb_mmio, OBJECT(xsrc), "xive.esb", esb_=
len);
> > +    memory_region_init_io(&xsrc->esb_mmio_emulated, OBJECT(xsrc),
> > +                          &xive_source_esb_ops, xsrc, "xive.esb-emulat=
ed",
> > +                          esb_len);
> > +    memory_region_add_subregion(&xsrc->esb_mmio, 0, &xsrc->esb_mmio_em=
ulated);
> > =20
> >      qemu_register_reset(xive_source_reset, dev);
> >  }
> > diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> > index 705cf48176fc..82a61eaca74f 100644
> > --- a/include/hw/ppc/xive.h
> > +++ b/include/hw/ppc/xive.h
> > @@ -191,6 +191,7 @@ typedef struct XiveSource {
> >      uint64_t        esb_flags;
> >      uint32_t        esb_shift;
> >      MemoryRegion    esb_mmio;
> > +    MemoryRegion    esb_mmio_emulated;
> > =20
> >      /* KVM support */
> >      void            *esb_mmap;
> > @@ -215,6 +216,11 @@ static inline bool xive_source_esb_has_2page(XiveS=
ource *xsrc)
> >          xsrc->esb_shift =3D=3D XIVE_ESB_4K_2PAGE;
> >  }
> > =20
> > +static inline size_t xive_source_esb_len(XiveSource *xsrc)
> > +{
> > +    return (1ull << xsrc->esb_shift) * xsrc->nr_irqs;
> > +}
> > +
> >  /* The trigger page is always the first/even page */
> >  static inline hwaddr xive_source_esb_page(XiveSource *xsrc, uint32_t s=
rcno)
> >  {
> >=20
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl81Gv8ACgkQbDjKyiDZ
s5I1iBAAkoZyPKaZ9zVzfpiTuB81PE36mXEM7odxYiDRSjzjfRccX3KBTdNsxHsb
MOaqFQ/mZO0LU8Ag0LyIEVlLWX9N6sDWUh6nNY/YqhiniyUtMfW7tKS7pKChcQ4n
aM8kgxXeQb48K73K5qjScrx9c645Gb7Aosaa4BlZ6Cup9ktpzM0/XL/wg6fttOXj
ERPpChb6y5+b8lyqBCVf5Ny8lvttRsuUNQM046he1HA6ycUqI05F/vuGuOuoXY4Y
mw602oc7pIMJzDQsSzdBPhimBdDo0cvOc42Vccp188llP/2T13k8N4fMChmh1jS7
eWLcgLDNm/TGDZmCk35oGeEvhLHMbWFFeiXLzN1WUBOIVbn/e3uVqSlqD0KxXOfj
i5gQFgJ5YbSmlC/QRnfzETsFBQ4oGKUQZQDY+tf32sHRJ4+VKeMe+MDM3JNkBKeo
N3WuWJINh4BozTkMKw1IJ95+s9G11LmNIoilZ3EipH6CQQRZRiU4+fZxtJzCWaxQ
7FfyDocd0NuXghmIR9tN7f1z8TJJugEIrTL8nDvpw0iF+smoIszwsm+kYVWx/eNA
MINuBMEDpuVyOBilOCIdPM+2J5y9JXkK0b22yRzkoB2JJ841zWFXdMhyNLPLJfmq
ESH7jAFui10h7DdcMjNqUDBmu106zOyfnnInHQaIrbcyXzQNrOc=
=jnJ5
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--

