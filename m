Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA171CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 18:09:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CF11205F4
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 18:09:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CF11205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNhXy-0002cW-CL
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 14:09:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40601)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iNgwd-0008M7-76
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 13:30:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iNgwb-0007X6-JX
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 13:30:42 -0400
Received: from 4.mo69.mail-out.ovh.net ([46.105.42.102]:46273)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iNgwb-0007WS-BA
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 13:30:41 -0400
Received: from player786.ha.ovh.net (unknown [10.109.143.189])
 by mo69.mail-out.ovh.net (Postfix) with ESMTP id F01D66D213
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 19:30:38 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player786.ha.ovh.net (Postfix) with ESMTPSA id BE217B729F92;
 Thu, 24 Oct 2019 17:30:32 +0000 (UTC)
Date: Thu, 24 Oct 2019 19:30:30 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v5 4/7] ppc/pnv: Add a PnvChip pointer to PnvCore
Message-ID: <20191024193030.40ee674e@bahia.lan>
In-Reply-To: <20191024023812.GO6439@umbus.fritz.box>
References: <20191022163812.330-1-clg@kaod.org>
 <20191022163812.330-5-clg@kaod.org>
 <20191024023812.GO6439@umbus.fritz.box>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/MZtdGY+9DSBGz1VusGPK_0r";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Ovh-Tracer-Id: 16122323719608113638
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrledugdduudegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.42.102
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
Cc: Philippe =?UTF-8?B?TWF0aGll?= =?UTF-8?B?dS1EYXVkw6k=?= <philmd@redhat.com>,
 qemu-ppc@nongnu.org, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/MZtdGY+9DSBGz1VusGPK_0r
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 24 Oct 2019 13:38:12 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Tue, Oct 22, 2019 at 06:38:09PM +0200, C=C3=A9dric Le Goater wrote:
> > We will use it to reset the interrupt presenter from the CPU reset
> > handler.
> >=20
> > Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> > Reviewed-by: Greg Kurz <groug@kaod.org>
> > ---
> >  include/hw/ppc/pnv_core.h | 3 +++
> >  hw/ppc/pnv_core.c         | 3 ++-
> >  2 files changed, 5 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/include/hw/ppc/pnv_core.h b/include/hw/ppc/pnv_core.h
> > index bfbd2ec42aa6..55eee95104da 100644
> > --- a/include/hw/ppc/pnv_core.h
> > +++ b/include/hw/ppc/pnv_core.h
> > @@ -31,6 +31,8 @@
> >  #define PNV_CORE_GET_CLASS(obj) \
> >       OBJECT_GET_CLASS(PnvCoreClass, (obj), TYPE_PNV_CORE)
> > =20
> > +typedef struct PnvChip PnvChip;
> > +
> >  typedef struct PnvCore {
> >      /*< private >*/
> >      CPUCore parent_obj;
> > @@ -38,6 +40,7 @@ typedef struct PnvCore {
> >      /*< public >*/
> >      PowerPCCPU **threads;
> >      uint32_t pir;
> > +    PnvChip *chip;
>=20
> I don't love having this as a redundant encoding of the information
> already in the property, since it raises the possibility of confusing
> bugs if they ever got out of sync.
>=20

Ouch, we also have this pattern in xive_tctx_realize(). The XiveTCXT
object has both a "cpu" property and a pointer to the vCPU.

> It's not a huge deal, but it would be nice to at least to at least
> consider either a) grabbing the property everywhere you need it (if
> there aren't too many places) or b) customizing the property
> definition so it's written directly into that field.
>=20

The pointer to the vCPU is used among other things to get the
value of the PIR, which is needed by the presenting logic to
match physical CAM lines. This is a _hot_ path so it's probably
better to go for b).

> > =20
> >      MemoryRegion xscom_regs;
> >  } PnvCore;
> > diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> > index 9f981a4940e6..cc17bbfed829 100644
> > --- a/hw/ppc/pnv_core.c
> > +++ b/hw/ppc/pnv_core.c
> > @@ -222,6 +222,7 @@ static void pnv_core_realize(DeviceState *dev, Erro=
r **errp)
> >                                  "required link 'chip' not found: ");
> >          return;
> >      }
> > +    pc->chip =3D PNV_CHIP(chip);
> > =20
> >      pc->threads =3D g_new(PowerPCCPU *, cc->nr_threads);
> >      for (i =3D 0; i < cc->nr_threads; i++) {
> > @@ -243,7 +244,7 @@ static void pnv_core_realize(DeviceState *dev, Erro=
r **errp)
> >      }
> > =20
> >      for (j =3D 0; j < cc->nr_threads; j++) {
> > -        pnv_realize_vcpu(pc->threads[j], PNV_CHIP(chip), &local_err);
> > +        pnv_realize_vcpu(pc->threads[j], pc->chip, &local_err);
> >          if (local_err) {
> >              goto err;
> >          }
>=20


--Sig_/MZtdGY+9DSBGz1VusGPK_0r
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAl2x37YACgkQcdTV5YIv
c9YomBAAvX0uUCVX1jZLr0bxt0nf0domv0LIzMRKQJROzMTqo8/DzsLlc3Xuq21a
lHwTuh3dA8syWQ4TQpbYZvmg+KZIpVeE8R3xYs4YHrUxQE6kpLUYZSqtaXtH5w43
KlYwB8+SSAIw76zlCiJArf/xXhymHa7MRdfU8MSzW69FG7W2Q+U7Q7/MPez/vY6M
x4rAjxEAeQcUnyJ9ZCTzh68q0Bh2wAmbMyzvqcmIirtmNHejaNeTjRPsLkLVKg1b
MEb3vAniBdW3+qF2Y5ifiT5Z3b+dkzmSrCV9nMuoA4yy3UDwc/XTMcTWnBSbho8z
P4D8GQfCp+uUcUbD9dcOzuT334jhVtK91SgFH6Z403waHOsXHLzbkeP1wCJ7XZbH
ZTCW1p41ckFAvP/iPBkaBGYISSI5EHEFaA8OA/zCBiUGu8ev8mTUUOnJoZBPlg8+
p2gh9K3VZU9dSqnpmTas/D/yP2g+cbED1zdLmx1lgPJO5VVMecxpTkXq5/CZZx+3
PCkT3i3QIBJGdBe+Puj7zcvuEgKzJ9x43QsvVMqLTnv8UTS/ddiOJ/IF0YkUup1l
P5ukyLXBiHSJWsD6GZTNjZy7x8IU0gHQ2ZBqPdGtl0B6nLwprYFOybT0kMguCfqC
IwaIqVia34SMAIDLU8qpl04KFYbeUcxH6amJwfs4jcdOppYGDtI=
=+EOy
-----END PGP SIGNATURE-----

--Sig_/MZtdGY+9DSBGz1VusGPK_0r--

