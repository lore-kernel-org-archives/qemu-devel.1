Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1557C352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 11:13:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A86ED20720
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 11:13:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A86ED20720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j01ZR-0000mn-RO
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 06:13:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58728)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1j01Yc-000831-7X
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 06:12:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1j01Yb-00063w-03
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 06:12:21 -0500
Received: from 12.mo4.mail-out.ovh.net ([178.33.104.253]:44808)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1j01Ya-00061x-PW
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 06:12:20 -0500
Received: from player789.ha.ovh.net (unknown [10.108.54.74])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id 2781D223DCF
 for <qemu-devel@nongnu.org>; Fri,  7 Feb 2020 12:12:17 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player789.ha.ovh.net (Postfix) with ESMTPSA id 09002F25AABD;
 Fri,  7 Feb 2020 11:12:12 +0000 (UTC)
Date: Fri, 7 Feb 2020 12:12:09 +0100
From: Greg Kurz <groug@kaod.org>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH] ppc: function to setup latest class options
Message-ID: <20200207121209.06a1be98@bahia.lan>
In-Reply-To: <e77a2a7b-ed74-7584-4751-711b115e98c7@redhat.com>
References: <20200207064628.1196095-1-mst@redhat.com>
 <e77a2a7b-ed74-7584-4751-711b115e98c7@redhat.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 5048816661030607139
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrheehgddvhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgsehtqhertdertdejnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeekledrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.33.104.253
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
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 7 Feb 2020 11:35:47 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> On 2/7/20 7:48 AM, Michael S. Tsirkin wrote:
> > We are going to add more init for the latest machine, so move the setup
> > to a function so we don't have to change the DEFINE_SPAPR_MACHINE macro
> > each time.
> >=20
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >   hw/ppc/spapr.c | 9 +++++++--
> >   1 file changed, 7 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 02cf53fc5b..4cf2a992a5 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -4428,6 +4428,12 @@ static const TypeInfo spapr_machine_info =3D {
> >       },
> >   };
> >  =20
> > +static void spapr_machine_latest_class_options(MachineClass *mc)
> > +{
> > +    mc->alias =3D "pseries";
> > +    mc->is_default =3D 1;
>=20
> But we can have only 1 default per QEMU binary... How PPC manage having=20
> multiple defaults? The first or last listed is choosen as default?
>=20

IIUC it isn't about putting multiple defaults here. It is about putting
any additional init for the default machine type that we cannot put in
spapr_machine_class_init(), instead of putting it in the versioned
init function, eg. spapr_machine_5_0_class_options(). Otherwise this
would force us to carry the change when we add a new machine version.

> > +}
> > +
> >   #define DEFINE_SPAPR_MACHINE(suffix, verstr, latest)                 \
> >       static void spapr_machine_##suffix##_class_init(ObjectClass *oc, \
> >                                                       void *data)      \
> > @@ -4435,8 +4441,7 @@ static const TypeInfo spapr_machine_info =3D {
> >           MachineClass *mc =3D MACHINE_CLASS(oc);                      =
  \
> >           spapr_machine_##suffix##_class_options(mc);                  \
> >           if (latest) {                                                \
> > -            mc->alias =3D "pseries";                                  =
 \
> > -            mc->is_default =3D 1;                                     =
 \
> > +            spapr_machine_latest_class_options(mc);                  \
> >           }                                                            \
> >       }                                                                \
> >       static const TypeInfo spapr_machine_##suffix##_info =3D {        =
  \
> >=20
>=20
>=20


