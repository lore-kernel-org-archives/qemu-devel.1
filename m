Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB23C4360C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 11:10:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A715F20862
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 11:10:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A715F20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGLTO-00057R-Mh
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 07:10:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58041)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iGKNt-00038K-Lj
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 06:00:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iGKNr-0007D8-62
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 06:00:25 -0400
Received: from 8.mo68.mail-out.ovh.net ([46.105.74.219]:56318)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iGKNp-0007Bd-ED
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 06:00:23 -0400
Received: from player718.ha.ovh.net (unknown [10.109.159.90])
 by mo68.mail-out.ovh.net (Postfix) with ESMTP id 53A64145C43
 for <qemu-devel@nongnu.org>; Fri,  4 Oct 2019 12:00:18 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player718.ha.ovh.net (Postfix) with ESMTPSA id D4B15A7FAB9E;
 Fri,  4 Oct 2019 10:00:08 +0000 (UTC)
Date: Fri, 4 Oct 2019 12:00:07 +0200
From: Greg Kurz <groug@kaod.org>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH] xive: Make some device types not user creatable
Message-ID: <20191004120007.24d70d6f@bahia.lan>
In-Reply-To: <e4c1619d-b982-e4ab-eeb9-31baddd885ba@redhat.com>
References: <157017473006.331610.2983143972519884544.stgit@bahia.lan>
 <e4c1619d-b982-e4ab-eeb9-31baddd885ba@redhat.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 1743174532891187491
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrhedugddujecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.74.219
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
Cc: Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 qemu-ppc@nongnu.org, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 4 Oct 2019 11:17:30 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> Hi Greg,
>=20
> On 10/4/19 9:38 AM, Greg Kurz wrote:
> > Some device types of the XIVE model are exposed to the QEMU command
> > line:
> >=20
> > $ ppc64-softmmu/qemu-system-ppc64 -device help | grep xive
> > name "xive-end-source", desc "XIVE END Source"
> > name "xive-source", desc "XIVE Interrupt Source"
> > name "xive-tctx", desc "XIVE Interrupt Thread Context"
> >=20
> > These are internal devices that shouldn't be instantiable by the
> > user. By the way, they can't be because their respective realize
> > functions expect link properties that can't be set from the command
> > line:
> >=20
> > qemu-system-ppc64: -device xive-source: required link 'xive' not found:
> >   Property '.xive' not found
> > qemu-system-ppc64: -device xive-end-source: required link 'xive' not fo=
und:
> >   Property '.xive' not found
> > qemu-system-ppc64: -device xive-tctx: required link 'cpu' not found:
> >   Property '.cpu' not found
>=20
> Why do you have to test that manually, isn't it what=20
> tests/device-introspect-test.c::test_one_device does?
>=20

Heh probably because I wasn't aware of it :)

And BTW, test_one_device() can't help here since it only cares
about 'device_add foo,help' not crashing QEMU:

    help =3D qtest_hmp(qts, "device_add \"%s,help\"", type);

as explained in a comment at the beginning of the file.

/*
 * Covers QMP device-list-properties and HMP device_add help.  We
 * currently don't check that their output makes sense, only that QEMU
 * survives.  Useful since we've had an astounding number of crash
 * bugs around here.
 */

> > Hide them by setting dc->user_creatable to false in their respective
> > class init functions.
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >   hw/intc/xive.c |    3 +++
> >   1 file changed, 3 insertions(+)
> >=20
> > diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> > index 29df06df1136..6c54a35fd4bb 100644
> > --- a/hw/intc/xive.c
> > +++ b/hw/intc/xive.c
> > @@ -670,6 +670,7 @@ static void xive_tctx_class_init(ObjectClass *klass=
, void *data)
> >       dc->realize =3D xive_tctx_realize;
> >       dc->unrealize =3D xive_tctx_unrealize;
> >       dc->vmsd =3D &vmstate_xive_tctx;
> > +    dc->user_creatable =3D false;
> >   }
> >  =20
> >   static const TypeInfo xive_tctx_info =3D {
> > @@ -1118,6 +1119,7 @@ static void xive_source_class_init(ObjectClass *k=
lass, void *data)
> >       dc->props   =3D xive_source_properties;
> >       dc->realize =3D xive_source_realize;
> >       dc->vmsd    =3D &vmstate_xive_source;
> > +    dc->user_creatable =3D false;
> >   }
> >  =20
> >   static const TypeInfo xive_source_info =3D {
> > @@ -1853,6 +1855,7 @@ static void xive_end_source_class_init(ObjectClas=
s *klass, void *data)
> >       dc->desc    =3D "XIVE END Source";
> >       dc->props   =3D xive_end_source_properties;
> >       dc->realize =3D xive_end_source_realize;
> > +    dc->user_creatable =3D false;
> >   }
> >  =20
> >   static const TypeInfo xive_end_source_info =3D {
> >=20
> >=20


