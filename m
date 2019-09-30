Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8221CC4360C
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 04:22:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 384592086A
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 04:22:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="cPTdXF8G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 384592086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEnCD-0007SC-59
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 00:22:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44575)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iEn63-0002S8-1V
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 00:15:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iEn60-0001pr-Qk
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 00:15:38 -0400
Received: from ozlabs.org ([203.11.71.1]:43541)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iEn5y-0001oo-LK; Mon, 30 Sep 2019 00:15:36 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46hTb64rMZz9sPK; Mon, 30 Sep 2019 14:15:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1569816930;
 bh=QnpWiDG3mdXpyE6tZSBapSV28smV5IZxUKTA5m6lSOc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=cPTdXF8GDBaFv+n5QRDA1rcvpt7+zXJddSqQwyv4gNbBo2jAgwpvb4SzHspTM8AYJ
 05XisDg37gNYvdhbVVdH3+hstcCzYaEeKYtAMoavVAqe3xckfrVxnQ9ZH/lKpEe+Oq
 rgM/GxKT4kOW5QPGZ+NAKnMZkirX/CG0oxnJpSQQ=
Date: Mon, 30 Sep 2019 12:44:41 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v2 32/33] spapr: Move SpaprIrq::nr_xirqs to
 SpaprMachineClass
Message-ID: <20190930024441.GF11105@umbus.fritz.box>
References: <20190927055028.11493-1-david@gibson.dropbear.id.au>
 <20190927055028.11493-33-david@gibson.dropbear.id.au>
 <20190927172216.7249f34d@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Ls2Gy6y7jbHLe9Od"
Content-Disposition: inline
In-Reply-To: <20190927172216.7249f34d@bahia.lan>
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
Cc: Jason Wang <jasowang@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org,
 clg@kaod.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Ls2Gy6y7jbHLe9Od
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2019 at 05:22:16PM +0200, Greg Kurz wrote:
> On Fri, 27 Sep 2019 15:50:27 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > For the benefit of peripheral device allocation, the number of available
> > irqs really wants to be the same on a given machine type version,
> > regardless of what irq backends we are using.  That's the case now, but
> > only because we make sure the different SpaprIrq instances have the same
> > value except for the special legacy one.
> >=20
> > Since this really only depends on machine type version, move the value =
to
> > SpaprMachineClass instead of SpaprIrq.  This also puts the code to set =
it
> > to the lower value on old machine types right next to setting
> > legacy_irq_allocation, which needs to go hand in hand.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  hw/ppc/spapr.c             |  2 ++
> >  hw/ppc/spapr_irq.c         | 33 ++++++++++++++++-----------------
> >  include/hw/ppc/spapr.h     |  1 +
> >  include/hw/ppc/spapr_irq.h |  1 -
> >  4 files changed, 19 insertions(+), 18 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 34b693beba..7113249c89 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -4513,6 +4513,7 @@ static void spapr_machine_class_init(ObjectClass =
*oc, void *data)
> >      smc->irq =3D &spapr_irq_dual;
> >      smc->dr_phb_enabled =3D true;
> >      smc->linux_pci_probe =3D true;
> > +    smc->nr_xirqs =3D SPAPR_NR_XIRQS;
>=20
> This is the last user of SPAPR_NR_XIRQS.
>=20
> $ git grep SPAPR_NR_XIRQS
> hw/ppc/spapr.c:    smc->nr_xirqs =3D SPAPR_NR_XIRQS;
> include/hw/ppc/spapr_irq.h:#define SPAPR_NR_XIRQS       0x1000
>=20
> Maybe open-code it here, like you already do for SPAPR_IRQ_XICS_LEGACY_NR=
_XIRQS
> below.

I thought about it.  I kind of prefer having the #define, though I'm
not really sure that's a rational choice.

>=20
> With or without that fixed.
>=20
> Reviewed-by: Greg Kurz <groug@kaod.org>
>=20
> >  }
> > =20
> >  static const TypeInfo spapr_machine_info =3D {
> > @@ -4648,6 +4649,7 @@ static void spapr_machine_3_0_class_options(Machi=
neClass *mc)
> >      compat_props_add(mc->compat_props, hw_compat_3_0, hw_compat_3_0_le=
n);
> > =20
> >      smc->legacy_irq_allocation =3D true;
> > +    smc->nr_xirqs =3D 0x400;
> >      smc->irq =3D &spapr_irq_xics_legacy;
> >  }
> > =20
> > diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> > index 799755c811..f76f30f54b 100644
> > --- a/hw/ppc/spapr_irq.c
> > +++ b/hw/ppc/spapr_irq.c
> > @@ -106,7 +106,6 @@ int spapr_irq_init_kvm(int (*fn)(SpaprInterruptCont=
roller *, Error **),
> >   */
> > =20
> >  SpaprIrq spapr_irq_xics =3D {
> > -    .nr_xirqs    =3D SPAPR_NR_XIRQS,
> >      .xics        =3D true,
> >      .xive        =3D false,
> >  };
> > @@ -116,7 +115,6 @@ SpaprIrq spapr_irq_xics =3D {
> >   */
> > =20
> >  SpaprIrq spapr_irq_xive =3D {
> > -    .nr_xirqs    =3D SPAPR_NR_XIRQS,
> >      .xics        =3D false,
> >      .xive        =3D true,
> >  };
> > @@ -134,7 +132,6 @@ SpaprIrq spapr_irq_xive =3D {
> >   * Define values in sync with the XIVE and XICS backend
> >   */
> >  SpaprIrq spapr_irq_dual =3D {
> > -    .nr_xirqs    =3D SPAPR_NR_XIRQS,
> >      .xics        =3D true,
> >      .xive        =3D true,
> >  };
> > @@ -249,16 +246,19 @@ void spapr_irq_dt(SpaprMachineState *spapr, uint3=
2_t nr_servers,
> > =20
> >  uint32_t spapr_irq_nr_msis(SpaprMachineState *spapr)
> >  {
> > -    if (SPAPR_MACHINE_GET_CLASS(spapr)->legacy_irq_allocation) {
> > -        return spapr->irq->nr_xirqs;
> > +    SpaprMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
> > +
> > +    if (smc->legacy_irq_allocation) {
> > +        return smc->nr_xirqs;
> >      } else {
> > -        return SPAPR_XIRQ_BASE + spapr->irq->nr_xirqs - SPAPR_IRQ_MSI;
> > +        return SPAPR_XIRQ_BASE + smc->nr_xirqs - SPAPR_IRQ_MSI;
> >      }
> >  }
> > =20
> >  void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
> >  {
> >      MachineState *machine =3D MACHINE(spapr);
> > +    SpaprMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
> >      Error *local_err =3D NULL;
> > =20
> >      if (machine_kernel_irqchip_split(machine)) {
> > @@ -295,8 +295,7 @@ void spapr_irq_init(SpaprMachineState *spapr, Error=
 **errp)
> >              goto out;
> >          }
> > =20
> > -        object_property_set_int(obj, spapr->irq->nr_xirqs, "nr-irqs",
> > -                                &local_err);
> > +        object_property_set_int(obj, smc->nr_xirqs, "nr-irqs", &local_=
err);
> >          if (local_err) {
> >              goto out;
> >          }
> > @@ -315,8 +314,7 @@ void spapr_irq_init(SpaprMachineState *spapr, Error=
 **errp)
> >          int i;
> > =20
> >          dev =3D qdev_create(NULL, TYPE_SPAPR_XIVE);
> > -        qdev_prop_set_uint32(dev, "nr-irqs",
> > -                             spapr->irq->nr_xirqs + SPAPR_XIRQ_BASE);
> > +        qdev_prop_set_uint32(dev, "nr-irqs", smc->nr_xirqs + SPAPR_XIR=
Q_BASE);
> >          /*
> >           * 8 XIVE END structures per CPU. One for each available
> >           * priority
> > @@ -343,7 +341,7 @@ void spapr_irq_init(SpaprMachineState *spapr, Error=
 **errp)
> >      }
> > =20
> >      spapr->qirqs =3D qemu_allocate_irqs(spapr_set_irq, spapr,
> > -                                      spapr->irq->nr_xirqs + SPAPR_XIR=
Q_BASE);
> > +                                      smc->nr_xirqs + SPAPR_XIRQ_BASE);
> > =20
> >  out:
> >      error_propagate(errp, local_err);
> > @@ -351,10 +349,11 @@ out:
> > =20
> >  int spapr_irq_claim(SpaprMachineState *spapr, int irq, bool lsi, Error=
 **errp)
> >  {
> > +    SpaprMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
> >      int rc;
> > =20
> >      assert(irq >=3D SPAPR_XIRQ_BASE);
> > -    assert(irq < (spapr->irq->nr_xirqs + SPAPR_XIRQ_BASE));
> > +    assert(irq < (smc->nr_xirqs + SPAPR_XIRQ_BASE));
> > =20
> >      if (spapr->xive) {
> >          SpaprInterruptControllerClass *sicc =3D SPAPR_INTC_GET_CLASS(s=
papr->xive);
> > @@ -379,10 +378,11 @@ int spapr_irq_claim(SpaprMachineState *spapr, int=
 irq, bool lsi, Error **errp)
> > =20
> >  void spapr_irq_free(SpaprMachineState *spapr, int irq, int num)
> >  {
> > +    SpaprMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
> >      int i;
> > =20
> >      assert(irq >=3D SPAPR_XIRQ_BASE);
> > -    assert((irq + num) <=3D (spapr->irq->nr_xirqs + SPAPR_XIRQ_BASE));
> > +    assert((irq + num) <=3D (smc->nr_xirqs + SPAPR_XIRQ_BASE));
> > =20
> >      for (i =3D irq; i < (irq + num); i++) {
> >          if (spapr->xive) {
> > @@ -402,6 +402,8 @@ void spapr_irq_free(SpaprMachineState *spapr, int i=
rq, int num)
> > =20
> >  qemu_irq spapr_qirq(SpaprMachineState *spapr, int irq)
> >  {
> > +    SpaprMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
> > +
> >      /*
> >       * This interface is basically for VIO and PHB devices to find the
> >       * right qemu_irq to manipulate, so we only allow access to the
> > @@ -410,7 +412,7 @@ qemu_irq spapr_qirq(SpaprMachineState *spapr, int i=
rq)
> >       * interfaces, we can change this if we need to in future.
> >       */
> >      assert(irq >=3D SPAPR_XIRQ_BASE);
> > -    assert(irq < (spapr->irq->nr_xirqs + SPAPR_XIRQ_BASE));
> > +    assert(irq < (smc->nr_xirqs + SPAPR_XIRQ_BASE));
> > =20
> >      if (spapr->ics) {
> >          assert(ics_valid_irq(spapr->ics, irq));
> > @@ -563,10 +565,7 @@ int spapr_irq_find(SpaprMachineState *spapr, int n=
um, bool align, Error **errp)
> >      return first + ics->offset;
> >  }
> > =20
> > -#define SPAPR_IRQ_XICS_LEGACY_NR_XIRQS     0x400
> > -
> >  SpaprIrq spapr_irq_xics_legacy =3D {
> > -    .nr_xirqs    =3D SPAPR_IRQ_XICS_LEGACY_NR_XIRQS,
> >      .xics        =3D true,
> >      .xive        =3D false,
> >  };
> > diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> > index 763da757f0..623e8e3f93 100644
> > --- a/include/hw/ppc/spapr.h
> > +++ b/include/hw/ppc/spapr.h
> > @@ -119,6 +119,7 @@ struct SpaprMachineClass {
> >      bool use_ohci_by_default;  /* use USB-OHCI instead of XHCI */
> >      bool pre_2_10_has_unused_icps;
> >      bool legacy_irq_allocation;
> > +    uint32_t nr_xirqs;
> >      bool broken_host_serial_model; /* present real host info to the gu=
est */
> >      bool pre_4_1_migration; /* don't migrate hpt-max-page-size */
> >      bool linux_pci_probe;
> > diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> > index 308bfcefd1..73d8beda39 100644
> > --- a/include/hw/ppc/spapr_irq.h
> > +++ b/include/hw/ppc/spapr_irq.h
> > @@ -77,7 +77,6 @@ int spapr_irq_msi_alloc(SpaprMachineState *spapr, uin=
t32_t num, bool align,
> >  void spapr_irq_msi_free(SpaprMachineState *spapr, int irq, uint32_t nu=
m);
> > =20
> >  typedef struct SpaprIrq {
> > -    uint32_t    nr_xirqs;
> >      bool        xics;
> >      bool        xive;
> >  } SpaprIrq;
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Ls2Gy6y7jbHLe9Od
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2RbBgACgkQbDjKyiDZ
s5JEXg//fTS9usOPxz5S2aQ084xBr5tsEz8QPPZhyG+7KVnN24UVxTEl06XHqVpe
9BeEH4q5ERZ0CMpeInSFuSvQjDbhF2Xrwzh0OD5Y1tsQw7BSj7kH8QQ/PADfjHpM
djDA0T1EprEQur+INMmj8QqnNq1pymmRmc7crYwGL010k1CPhTMy/CfmG/hGLwx+
OL5dG5xB1ibOJwRml7Ql8nKxRWQgPo3FZB9qbbMBR2pQuJWQ/nOwWZXahM/SQrHI
v50Bpz8KArps6cZkTVQ1kpUbZHtewaLtYI7IqrQoZk6nZyAJn7b6bt48+BotgOGh
/WQoHZamSFofLbZeVtaX95ubqR4Pnb2OCHpYdogEeC4AuOS44tF711oL+N6vgZfO
B9pggM6ahufdny9dmloMQHYecDndBTLIt52GY5XIKnklUOpLxCq3374rGENJXAKO
ajUHRhwh2+2po9oYk2r1YQfNMrsBmP10/cw4KCvVPfXSo3CyNLttnBkuCSUgyZ+Q
WcvOcNjoTuBe/CjJ1+8xhS2Fnm54rQVMjzj+tif/8Y3fx305bHJlOw0S/fWKtCI6
/S3ZszXirqP07Qh0b/gaXYaS4TRtWn91wMHwWtXkYJHzqP5vNCuSZH1s3vGZzMnh
m8q2Dakj+Ei9xFjnpAu9h1QUh91fvNezt+/PWVRTgZ5eKZsp7R0=
=2ERL
-----END PGP SIGNATURE-----

--Ls2Gy6y7jbHLe9Od--

