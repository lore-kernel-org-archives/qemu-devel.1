Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF292C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 12:13:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB726206E0
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 12:13:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="mXaSFMnk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB726206E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDSeM-0001L5-Im
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 08:13:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33556)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iDScs-0008Dq-QX
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 08:12:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iDScr-0001aW-AW
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 08:12:02 -0400
Received: from ozlabs.org ([203.11.71.1]:34025)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iDSco-0001NQ-Kr; Thu, 26 Sep 2019 08:12:01 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46fDLY4YXHz9sDB; Thu, 26 Sep 2019 22:11:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1569499909;
 bh=yNZ6CGfFgj7n2E519KmJ2C1XwRtMYpmI95cYE/JiXHE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mXaSFMnkWQDbpDHkgDD5ZlEx4FsWA6XpGED5VhV3T2IsdHCIumtzQRjHXtCP0gzFT
 R1K+pZDbbKl9H1hG3bvCcDamI4NSBD5U2DmnrW410nnVLpeW0mUpVHAesK4fTlOqlk
 EYKwNMjmnZOKlqz+HIsqPsozQHV0V4Bt6SdhG6DU=
Date: Thu, 26 Sep 2019 21:29:13 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 20/20] spapr: Eliminate SpaprIrq::init hook
Message-ID: <20190926112913.GY17405@umbus>
References: <20190925064534.19155-1-david@gibson.dropbear.id.au>
 <20190925064534.19155-21-david@gibson.dropbear.id.au>
 <1b74c0fc-b318-df5a-d66d-fe59ae562d70@kaod.org>
 <20190926011336.GS17405@umbus>
 <92ce15dd-f7f9-3d2b-4226-9693bd9cfd65@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="krsqJi1PDCheOQxO"
Content-Disposition: inline
In-Reply-To: <92ce15dd-f7f9-3d2b-4226-9693bd9cfd65@kaod.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
 qemu-devel@nongnu.org, groug@kaod.org, qemu-ppc@nongnu.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--krsqJi1PDCheOQxO
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2019 at 09:05:56AM +0200, C=E9dric Le Goater wrote:
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

Ah, interesting.

> I don't think we can change that without breaking migration though
> :/

Hm, there might be a way around it, I'll see what I can do, but
probably as a rather later patch.

>=20
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

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--krsqJi1PDCheOQxO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2MoQkACgkQbDjKyiDZ
s5KO+w//WNT+WYb9Hj3Lwl7Gspt13/FQ1cpRj5OOnDtTTrvKPGVdXaDhfftQdc4I
N8wuCmCPq0qRiLBa3S6+tF092bokx6I3qiEELPlbCDyIxGyWmN46s4qz7Y5D/MQi
w5+e4HkYeCRccHgWyLTZXoeYGVxGEHkRwd1a3VZYX8z13S/w+mXx66CKkT6JGA6S
ZRyq3SIcTS/NO802HMOYsLzaMSuYlWWNd1wtwRl4f+rLkG0lcHC7ebNHiy8Aspa2
XrX4xA09NYeGNEcX88mO/oe4X7FDGdT8peHfnBFojgrD3tOH+CLLYW2kzRW2efFa
Kn0qsDyXFv4o1nhATERdfiiQSvCidKRvw96XZ8WneTqzWdj5UXkxrbz9bKkre//A
6Uhco0UGxFtvseo5R8jmLn1khmQr2kc/D4huU7/MfJ6MTvwZPiD0VHjg3U2LClCo
bMwxX2e5AWAa5loJU0azkil0E3JPDSGKCftvwWTdsPDSiNeEkL6KdMmWeG1DPSNf
YtoNWU5atNyjgjXQZcwlNxrFPM6wHhGocg7l5RRZpoTrbCJR1g04u9kPqCmMBT+r
ZxtTSD6Sdagp4itTNPLsd8dzm3zxeEug17crnOwRXysJVqaQ0VoGvmsm+a5xCfkB
Z68J75SaH8ksO72F8xls9/51of3PK8AUxomkRrte6n+oaqXlZSM=
=aQxc
-----END PGP SIGNATURE-----

--krsqJi1PDCheOQxO--

