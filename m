Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5BB0C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 15:53:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B44A222C6
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 15:53:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B44A222C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDW5E-0004IR-Oy
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 11:53:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56822)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iDVoJ-00059d-Cw
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 11:36:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iDVoF-00041t-LD
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 11:36:01 -0400
Received: from 3.mo173.mail-out.ovh.net ([46.105.34.1]:59732)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iDVoF-0003ve-FM
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 11:35:59 -0400
Received: from player693.ha.ovh.net (unknown [10.109.146.50])
 by mo173.mail-out.ovh.net (Postfix) with ESMTP id AE2E811A8B2
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 17:35:53 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player693.ha.ovh.net (Postfix) with ESMTPSA id 28655A3FE141;
 Thu, 26 Sep 2019 15:35:41 +0000 (UTC)
Date: Thu, 26 Sep 2019 17:35:39 +0200
From: Greg Kurz <groug@kaod.org>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 20/20] spapr: Eliminate SpaprIrq::init hook
Message-ID: <20190926173539.4a07d419@bahia.lan>
In-Reply-To: <92ce15dd-f7f9-3d2b-4226-9693bd9cfd65@kaod.org>
References: <20190925064534.19155-1-david@gibson.dropbear.id.au>
 <20190925064534.19155-21-david@gibson.dropbear.id.au>
 <1b74c0fc-b318-df5a-d66d-fe59ae562d70@kaod.org>
 <20190926011336.GS17405@umbus>
 <92ce15dd-f7f9-3d2b-4226-9693bd9cfd65@kaod.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 15769635571495049611
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrfeeggdeltdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.34.1
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
 =?UTF-8?B?TWFy?= =?UTF-8?B?Yy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 26 Sep 2019 09:05:56 +0200
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> >>> +    if (spapr->irq->xive) {
> >>> +        uint32_t nr_servers =3D spapr_max_server_number(spapr);
> >>> +        DeviceState *dev;
> >>> +        int i;
> >>> +
> >>> +        dev =3D qdev_create(NULL, TYPE_SPAPR_XIVE);
> >>> +        qdev_prop_set_uint32(dev, "nr-irqs",
> >>> +                             spapr->irq->nr_xirqs + SPAPR_XIRQ_BASE);
> >>> +        /*
> >>> +         * 8 XIVE END structures per CPU. One for each available
> >>> +         * priority
> >>> +         */
> >>> +        qdev_prop_set_uint32(dev, "nr-ends", nr_servers << 3);
> >>> +        qdev_init_nofail(dev);
> >>> +
> >>> +        spapr->xive =3D SPAPR_XIVE(dev);
> >>> +
> >>> +        /* Enable the CPU IPIs */
> >>> +        for (i =3D 0; i < nr_servers; ++i) {
> >>> +            Error *local_err =3D NULL;
> >>> +
> >>> +            spapr_xive_irq_claim(spapr->xive, SPAPR_IRQ_IPI + i, fal=
se, &local_err);
> >>> +            if (local_err) {
> >>> +                goto out;
> >>> +            }
> >>> +        }
> >>
> >> We could move the IPI claim part in the realize routine of SPAPR_XIVE.
> >=20
> > Yeah, I know.  I thought about this, but there's a slight complication
> > in that the XIVE part doesn't know nr_servers directly.  There's
> > several possible ways to handle that, but I wasn't 100% happy with any
> > that I came up with yet.
>=20
> The "nr-ends" property was inappropriate, "nr-servers" would have been
> better and we would have hidden the calculation of ENDs 'nr_servers << 3'
> in the realize routine of SpaprXive.=20
>=20

Yeah it would make sense to have nr_servers within the sPAPR XIVE object,
so that we don't have to pass it when building the FDT node. Same stands
for XICS actually.

And as part of my current work to reduce HW VP consumption, I also need
nr_servers to pass it to the KVM device.

> I don't think we can change that without breaking migration though :/
>=20

Hmm... why ? The QOM property is just an interface, it doesn't change the
state. In the end we migrate the same number of XiveEND objects.

> C.
>=20
> >>
> >>> +        spapr_xive_hcall_init(spapr);
> >>
> >> This also.
> >=20
> > Right.
> >=20
> >> It can be done later one.
> >=20
> > That's my intention.
> >=20
> >>
> >> C.
> >>
> >>> +    }
> >>> =20
> >>>      spapr->qirqs =3D qemu_allocate_irqs(spapr->irq->set_irq, spapr,
> >>>                                        spapr->irq->nr_xirqs + SPAPR_X=
IRQ_BASE);
> >>> +
> >>> +out:
> >>> +    error_propagate(errp, local_err);
> >>>  }
> >>> =20
> >>>  void spapr_irq_claim(SpaprMachineState *spapr, int irq, bool lsi, Er=
ror **errp)
> >>> @@ -757,7 +744,6 @@ SpaprIrq spapr_irq_xics_legacy =3D {
> >>>      .xics        =3D true,
> >>>      .xive        =3D false,
> >>> =20
> >>> -    .init        =3D spapr_irq_init_xics,
> >>>      .claim       =3D spapr_irq_claim_xics,
> >>>      .free        =3D spapr_irq_free_xics,
> >>>      .print_info  =3D spapr_irq_print_info_xics,
> >>> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> >>> index 6816cb0500..fa862c665b 100644
> >>> --- a/include/hw/ppc/spapr_irq.h
> >>> +++ b/include/hw/ppc/spapr_irq.h
> >>> @@ -42,7 +42,6 @@ typedef struct SpaprIrq {
> >>>      bool        xics;
> >>>      bool        xive;
> >>> =20
> >>> -    void (*init)(SpaprMachineState *spapr, Error **errp);
> >>>      void (*claim)(SpaprMachineState *spapr, int irq, bool lsi, Error=
 **errp);
> >>>      void (*free)(SpaprMachineState *spapr, int irq);
> >>>      void (*print_info)(SpaprMachineState *spapr, Monitor *mon);
> >>> diff --git a/include/hw/ppc/xics_spapr.h b/include/hw/ppc/xics_spapr.h
> >>> index 691a6d00f7..267984a97b 100644
> >>> --- a/include/hw/ppc/xics_spapr.h
> >>> +++ b/include/hw/ppc/xics_spapr.h
> >>> @@ -34,6 +34,7 @@
> >>>  #define TYPE_ICS_SPAPR "ics-spapr"
> >>>  #define ICS_SPAPR(obj) OBJECT_CHECK(ICSState, (obj), TYPE_ICS_SPAPR)
> >>> =20
> >>> +void ics_spapr_create(SpaprMachineState *spapr, int nr_xirqs, Error =
**errp);
> >>>  void spapr_dt_xics(SpaprMachineState *spapr, uint32_t nr_servers, vo=
id *fdt,
> >>>                     uint32_t phandle);
> >>>  int xics_kvm_connect(SpaprMachineState *spapr, Error **errp);
> >>>
> >>
> >=20
>=20


