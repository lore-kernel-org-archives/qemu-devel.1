Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A274C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 13:29:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FFB0206CC
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 13:29:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FFB0206CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVbfE-0007PM-9S
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 08:29:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51456)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iVbeE-0006u4-J1
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 08:28:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iVbeD-0003TY-Fo
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 08:28:26 -0500
Received: from 3.mo177.mail-out.ovh.net ([46.105.36.172]:59592)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iVbeD-0003Sv-9l
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 08:28:25 -0500
Received: from player756.ha.ovh.net (unknown [10.109.143.72])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id F0389113B09
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2019 14:28:22 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player756.ha.ovh.net (Postfix) with ESMTPSA id BD619B565E95;
 Fri, 15 Nov 2019 13:28:17 +0000 (UTC)
Date: Fri, 15 Nov 2019 14:28:16 +0100
From: Greg Kurz <groug@kaod.org>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH for-5.0 0/8] ppc: Consolidate QOM links and pointers to
 the same object
Message-ID: <20191115142816.5399cb36@bahia.lan>
In-Reply-To: <59f7978d-0c34-cc92-f0bd-e72a1a7e9d8f@kaod.org>
References: <157381880498.136087.3775284829737989585.stgit@bahia.lan>
 <59f7978d-0c34-cc92-f0bd-e72a1a7e9d8f@kaod.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 12102861049572268427
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudefhedgheefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdqfffguegfifdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthhqredtredtjeenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeehiedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.36.172
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 15 Nov 2019 13:16:22 +0100
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> On 15/11/2019 12:53, Greg Kurz wrote:
> > There's a recurring pattern in the code where a const link is added to a
> > newly instanciated object and the link is then used in the object's rea=
lize
> > function to keep a pointer to the QOM entity which the link points to.
> >=20
> > void create_obj_B(Object *obj_a)
> > {
> >     Object *obj_b;
> >=20
> >     obj_b =3D object_new(TYPE_B);
> >     object_property_add_const_link(obj_b, "link-to-a", obj_a, &error_ab=
ort);
> > }
> >=20
> > void object_B_realize(DeviceState *dev, Error **errp)
> > {
> >     Object *obj_a;
> >=20
> >     obj_a =3D object_property_get_link(OBJECT(dev), "link-to-a", errp);
> >     if (!obj_a) {
> >         return;
> >     }
> >=20
> >     obj_b->obj_a =3D A(obj_a); // If obj_b->obj_a is changed, the link =
property
> >                              // still points to the original obj_a that=
 was
> >                              // passed to object_property_add_const_lin=
k()
> > }
> >=20
> > Confusing bugs could arise if the pointer and the link go out of sync f=
or
> > some reason. This can be avoided if the property is defined to directly=
 use
> > the pointer with object_property_add_link() and object_property_set_lin=
k().
> >=20
> > This series just does that for all occurences of the fragile pattern in
> > the XIVE and PNV code.
>=20
> Can we use DEFINE_PROP_LINK() instead ?
>=20

Heh this seems to be even better indeed. I'll give a try.

> C.=20
>=20
>=20
> >=20
> > --
> > Greg
> >=20
> > ---
> >=20
> > Greg Kurz (8):
> >       xive: Link "cpu" property to XiveTCTX::cs pointer
> >       xive: Link "xive" property to XiveSource::xive pointer
> >       xive: Link "xive" property to XiveEndSource::xrtr pointer
> >       ppc/pnv: Link "psi" property to PnvLpc::psi pointer
> >       ppc/pnv: Link "psi" property to PnvOCC::psi pointer
> >       ppc/pnv: Link "chip" property to PnvHomer::chip pointer
> >       ppc/pnv: Link "chip" property to PnvCore::chip pointer
> >       ppc/pnv: Link "chip" property to PnvXive::chip pointer
> >=20
> >=20
> >  hw/intc/pnv_xive.c        |   29 +++++++++-----------
> >  hw/intc/spapr_xive.c      |    8 +++---
> >  hw/intc/xive.c            |   65 ++++++++++++++++++++++---------------=
--------
> >  hw/ppc/pnv.c              |   32 +++++++++++-----------
> >  hw/ppc/pnv_core.c         |   18 +++++++-----
> >  hw/ppc/pnv_homer.c        |   24 +++++++++--------
> >  hw/ppc/pnv_lpc.c          |   23 ++++++++--------
> >  hw/ppc/pnv_occ.c          |   23 ++++++++--------
> >  hw/ppc/pnv_psi.c          |    3 +-
> >  include/hw/ppc/pnv.h      |    2 +
> >  include/hw/ppc/pnv_core.h |    2 +
> >  11 files changed, 115 insertions(+), 114 deletions(-)
> >=20
>=20


