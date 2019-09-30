Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB07EC4360C
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 04:18:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 984EC2086A
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 04:18:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="VigZolSW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 984EC2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEn8j-0004EZ-Ao
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 00:18:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44559)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iEn62-0002S6-67
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 00:15:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iEn60-0001pS-6m
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 00:15:38 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:51395)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iEn5z-0001oj-PT; Mon, 30 Sep 2019 00:15:36 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46hTb60rYpz9sP7; Mon, 30 Sep 2019 14:15:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1569816930;
 bh=ci5tQUG7JqyU3jf/y7bpSb4CKzpjeYiVuHpk/3C+AvY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=VigZolSWPiIfSXLQ/KSISiUccMzTGYM141LVBvEM+F09OV4WeG/I0gtJ1zL2D/0w8
 XKLwY3azC8KEO9BESgju7x4MCeRcrIvWpuCCDaVwUOBEd9BMSdKdHiY8SwHgPiCwOI
 FlNPVJ7bSrFLcXZbkGz7oF9TJatdbpb0fjP1VDN0=
Date: Mon, 30 Sep 2019 11:39:24 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v2 17/33] xive: Improve irq claim/free path
Message-ID: <20190930013924.GA11105@umbus.fritz.box>
References: <20190927055028.11493-1-david@gibson.dropbear.id.au>
 <20190927055028.11493-18-david@gibson.dropbear.id.au>
 <20190927104014.0dc57503@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline
In-Reply-To: <20190927104014.0dc57503@bahia.lan>
User-Agent: Mutt/1.12.1 (2019-06-15)
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
Cc: Jason Wang <jasowang@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org,
 clg@kaod.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2019 at 10:40:14AM +0200, Greg Kurz wrote:
> On Fri, 27 Sep 2019 15:50:12 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > spapr_xive_irq_claim() returns a bool to indicate if it succeeded.
> > But most of the callers and one callee use int return values and/or an
> > Error * with more information instead.  In any case, ints are a more
> > common idiom for success/failure states than bools (one never knows
> > what sense they'll be in).
> >=20
> > So instead change to an int return value to indicate presence of error
> > + an Error * to describe the details through that call chain.
> >=20
> > It also didn't actually check if the irq was already claimed, which is
> > one of the primary purposes of the claim path, so do that.
> >=20
> > spapr_xive_irq_free() also returned a bool... which no callers checked
> > and was always true, so just drop it.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > Reviewed-by: C=E9dric Le Goater <clg@kaod.org>
> > ---
> >  hw/intc/spapr_xive.c        | 20 +++++++++-----------
> >  hw/intc/spapr_xive_kvm.c    |  8 ++++----
> >  hw/ppc/spapr_irq.c          | 14 ++++++++------
> >  include/hw/ppc/spapr_xive.h |  4 ++--
> >  include/hw/ppc/xive.h       |  2 +-
> >  5 files changed, 24 insertions(+), 24 deletions(-)
> >=20
> > diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> > index 47b5ec0b56..04879abf2e 100644
> > --- a/hw/intc/spapr_xive.c
> > +++ b/hw/intc/spapr_xive.c
> > @@ -528,12 +528,17 @@ static void spapr_xive_register_types(void)
> > =20
> >  type_init(spapr_xive_register_types)
> > =20
> > -bool spapr_xive_irq_claim(SpaprXive *xive, uint32_t lisn, bool lsi)
> > +int spapr_xive_irq_claim(SpaprXive *xive, int lisn, bool lsi, Error **=
errp)
> >  {
> >      XiveSource *xsrc =3D &xive->source;
> > =20
> >      assert(lisn < xive->nr_irqs);
> > =20
> > +    if (xive_eas_is_valid(&xive->eat[lisn])) {
> > +        error_setg(errp, "IRQ %d is not free", lisn);
> > +        return -EBUSY;
> > +    }
> > +
> >      /*
> >       * Set default values when allocating an IRQ number
> >       */
> > @@ -543,24 +548,17 @@ bool spapr_xive_irq_claim(SpaprXive *xive, uint32=
_t lisn, bool lsi)
> >      }
> > =20
> >      if (kvm_irqchip_in_kernel()) {
> > -        Error *local_err =3D NULL;
> > -
> > -        kvmppc_xive_source_reset_one(xsrc, lisn, &local_err);
> > -        if (local_err) {
> > -            error_report_err(local_err);
> > -            return false;
> > -        }
> > +        return kvmppc_xive_source_reset_one(xsrc, lisn, errp);
> >      }
> > =20
> > -    return true;
> > +    return 0;
> >  }
> > =20
> > -bool spapr_xive_irq_free(SpaprXive *xive, uint32_t lisn)
> > +void spapr_xive_irq_free(SpaprXive *xive, int lisn)
> >  {
> >      assert(lisn < xive->nr_irqs);
> > =20
> >      xive->eat[lisn].w &=3D cpu_to_be64(~EAS_VALID);
> > -    return true;
> >  }
> > =20
> >  /*
> > diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
> > index 2006f96aec..51b334b676 100644
> > --- a/hw/intc/spapr_xive_kvm.c
> > +++ b/hw/intc/spapr_xive_kvm.c
> > @@ -232,14 +232,14 @@ void kvmppc_xive_sync_source(SpaprXive *xive, uin=
t32_t lisn, Error **errp)
> >   * only need to inform the KVM XIVE device about their type: LSI or
> >   * MSI.
> >   */
> > -void kvmppc_xive_source_reset_one(XiveSource *xsrc, int srcno, Error *=
*errp)
> > +int kvmppc_xive_source_reset_one(XiveSource *xsrc, int srcno, Error **=
errp)
> >  {
> >      SpaprXive *xive =3D SPAPR_XIVE(xsrc->xive);
> >      uint64_t state =3D 0;
> > =20
> >      /* The KVM XIVE device is not in use */
> >      if (xive->fd =3D=3D -1) {
> > -        return;
> > +        return -ENODEV;
> >      }
> > =20
> >      if (xive_source_irq_is_lsi(xsrc, srcno)) {
> > @@ -249,8 +249,8 @@ void kvmppc_xive_source_reset_one(XiveSource *xsrc,=
 int srcno, Error **errp)
> >          }
> >      }
> > =20
> > -    kvm_device_access(xive->fd, KVM_DEV_XIVE_GRP_SOURCE, srcno, &state,
> > -                      true, errp);
> > +    return kvm_device_access(xive->fd, KVM_DEV_XIVE_GRP_SOURCE, srcno,=
 &state,
> > +                             true, errp);
> >  }
> > =20
> >  static void kvmppc_xive_source_reset(XiveSource *xsrc, Error **errp)
> > diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> > index da9e80b24e..4951329959 100644
> > --- a/hw/ppc/spapr_irq.c
> > +++ b/hw/ppc/spapr_irq.c
> > @@ -246,7 +246,13 @@ static void spapr_irq_init_xive(SpaprMachineState =
*spapr, Error **errp)
> > =20
> >      /* Enable the CPU IPIs */
> >      for (i =3D 0; i < nr_servers; ++i) {
> > -        spapr_xive_irq_claim(spapr->xive, SPAPR_IRQ_IPI + i, false);
> > +        Error *local_err =3D NULL;
> > +
> > +        spapr_xive_irq_claim(spapr->xive, SPAPR_IRQ_IPI + i, false, &l=
ocal_err);
> > +        if (local_err) {
> > +            error_propagate(errp, local_err);
> > +            return;
> > +        }
>=20
> Quoting the changelog
>=20
> > So instead change to an int return value to indicate presence of error
> > + an Error * to describe the details through that call chain.
>=20
> Shouldn't this rather be:
>=20
>         if (spapr_xive_irq_claim(spapr->xive, SPAPR_IRQ_IPI + i, false, e=
rrp)) {
>             return;
>         }
>=20
> ?

Yes, yes it should.  Fixed now.

>=20
> With or without that fixed,
>=20
> Reviewed-by: Greg Kurz <groug@kaod.org>
>=20
> >      }
> > =20
> >      spapr_xive_hcall_init(spapr);
> > @@ -255,11 +261,7 @@ static void spapr_irq_init_xive(SpaprMachineState =
*spapr, Error **errp)
> >  static int spapr_irq_claim_xive(SpaprMachineState *spapr, int irq, boo=
l lsi,
> >                                  Error **errp)
> >  {
> > -    if (!spapr_xive_irq_claim(spapr->xive, irq, lsi)) {
> > -        error_setg(errp, "IRQ %d is invalid", irq);
> > -        return -1;
> > -    }
> > -    return 0;
> > +    return spapr_xive_irq_claim(spapr->xive, irq, lsi, errp);
> >  }
> > =20
> >  static void spapr_irq_free_xive(SpaprMachineState *spapr, int irq)
> > diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
> > index bfd40f01d8..0df20a6590 100644
> > --- a/include/hw/ppc/spapr_xive.h
> > +++ b/include/hw/ppc/spapr_xive.h
> > @@ -54,8 +54,8 @@ typedef struct SpaprXive {
> >   */
> >  #define SPAPR_XIVE_BLOCK_ID 0x0
> > =20
> > -bool spapr_xive_irq_claim(SpaprXive *xive, uint32_t lisn, bool lsi);
> > -bool spapr_xive_irq_free(SpaprXive *xive, uint32_t lisn);
> > +int spapr_xive_irq_claim(SpaprXive *xive, int lisn, bool lsi, Error **=
errp);
> > +void spapr_xive_irq_free(SpaprXive *xive, int lisn);
> >  void spapr_xive_pic_print_info(SpaprXive *xive, Monitor *mon);
> >  int spapr_xive_post_load(SpaprXive *xive, int version_id);
> > =20
> > diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> > index 6d38755f84..fd3319bd32 100644
> > --- a/include/hw/ppc/xive.h
> > +++ b/include/hw/ppc/xive.h
> > @@ -425,7 +425,7 @@ static inline uint32_t xive_nvt_cam_line(uint8_t nv=
t_blk, uint32_t nvt_idx)
> >   * KVM XIVE device helpers
> >   */
> > =20
> > -void kvmppc_xive_source_reset_one(XiveSource *xsrc, int srcno, Error *=
*errp);
> > +int kvmppc_xive_source_reset_one(XiveSource *xsrc, int srcno, Error **=
errp);
> >  void kvmppc_xive_source_set_irq(void *opaque, int srcno, int val);
> >  void kvmppc_xive_cpu_connect(XiveTCTX *tctx, Error **errp);
> >  void kvmppc_xive_cpu_synchronize_state(XiveTCTX *tctx, Error **errp);
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2RXMkACgkQbDjKyiDZ
s5Lz2w/9EVhOFO7O+EBCQFKyXX4Pjv4v9T9NRvuOXSzyWghcH1AJ2tH6z/nl4gAZ
hpJ2F5N5NGshk2I1Gbg2ddiP4HJU0ixlk2WEpLsCd+HNzqCtyYKsMI0Oqct9OIx0
bcf5VSTNZ7ymC6J207vDt3+jDo1rHgbASU+smjvvruJ2F5Xli783B1PrgV6Ag181
gmkd4DQqeD+Cj5hBseDhqPch+R17WOP0AiEIRiy+DabIU7oT8q/KQVowOQvhQKRJ
tLMnRe8qHGPgA2LSaez/pIvuwhdmmbgxcvt0GJ18hYNiGKC9DaFze732tZI83vo/
+RGj6/CNvqbBH4yrdJk/fF9mYYppcy+EwhAmNUqPfZA8bWQuNcLMcg4X239CuIhn
kYQc94rY+k1UO+alfqVRqd81FK930l77uAq2Fl7Sne5sQiBTnQntOt5to5/6F0VA
E2AWBqD2wP1Z9JYOb4be5mz+4RC0KCzyWn+UHyMOjqvwBvQXTkywhRIRy/jeh558
XANPVv0jo/Jvbc5sFN4S7YKBYS88+CC924d+yyGOBIUqKyTWC5z9c4qPNDPnSwlk
h1A1IAmZRGvXA0z+6jquL+dHb4gpls4RW51ZYlplTUPmC1/dDZsBo2hhnqJI1dMd
7FmT7jODkwbela4X8Bt5xEMz43jqNSo6lOlrsmI0FJVNvOaerWY=
=z9qB
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--

