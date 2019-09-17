Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB4EC4CECD
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 08:12:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DB7B20862
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 08:12:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DB7B20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iA8bZ-0006Sv-LT
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 04:12:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52343)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iA8as-0005p3-8H
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 04:12:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iA8ap-0006gh-KN
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 04:12:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40624)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iA8ap-0006gG-8x
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 04:12:11 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 402748980E0;
 Tue, 17 Sep 2019 08:12:10 +0000 (UTC)
Received: from work-vm (ovpn-116-53.ams2.redhat.com [10.36.116.53])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0866760167;
 Tue, 17 Sep 2019 08:12:05 +0000 (UTC)
Date: Tue, 17 Sep 2019 09:12:03 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Message-ID: <20190917081203.GA3370@work-vm>
References: <20190912122514.22504-1-marcandre.lureau@redhat.com>
 <20190912122514.22504-6-marcandre.lureau@redhat.com>
 <20190916100035.GC2887@work-vm>
 <CAJ+F1C+GAJc8vYVLzBZWonVkjp-rdWFemAdwgE2sbxJDFKp0Uw@mail.gmail.com>
 <20190916131514.GG2887@work-vm>
 <CAJ+F1C+mbPHHO_Oet-CxUsfAxTrLvezvcV=+0KG+Rv2za=-arg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAJ+F1C+mbPHHO_Oet-CxUsfAxTrLvezvcV=+0KG+Rv2za=-arg@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.67]); Tue, 17 Sep 2019 08:12:10 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 5/6] docs: start a document to describe
 D-Bus usage
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Michal Privoznik <mprivozn@redhat.com>,
 QEMU <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Marc-Andr=E9 Lureau (marcandre.lureau@gmail.com) wrote:
> Hi
>=20
> On Mon, Sep 16, 2019 at 5:15 PM Dr. David Alan Gilbert
> <dgilbert@redhat.com> wrote:
> >
> > * Marc-Andr=E9 Lureau (marcandre.lureau@gmail.com) wrote:
> > > Hi
> > >
> > > On Mon, Sep 16, 2019 at 2:02 PM Dr. David Alan Gilbert
> > > <dgilbert@redhat.com> wrote:
> > > >
> > > > (Copying in Stefan since he was looking at DBus for virtiofs)
> > > >
> > > > * Marc-Andr=E9 Lureau (marcandre.lureau@redhat.com) wrote:
> > > > > Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com=
>

<snip>

> > > Do you have a specific question we can answer or guide for qemu? Is
> > > there something we have to document or implement?
> > >
> > > Since qemu is not managing the extra processes or applying policies=
, I
> > > don't know what else could be done. From qemu pov, it can rely on
> > > management layer to trust the bus and the helpers, similar to trust=
ing
> > > the system in general.
> >
> > Well pretty much the same questions I asked in the discussion on v2;
> > what is the supported configuration to ensure that one helper that's
> > been compromised can't attack the others and qemu?
>=20
> I thought I gave the answer to that question above. What is missing? I
> don't think one can generalize it here, it will be a case by case for
> each helper, how they interact with each other and qemu.

I think we need an example of how to lock it down; i.e. to allow a
helper to provide migration data but not to be able to speak to other
helpers.

Dave

> >
> > Dave
> >
> > > > Dave
> > > >
> > > > > +Guidelines
> > > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > +
> > > > > +When implementing new D-Bus interfaces, it is recommended to f=
ollow
> > > > > +the "D-Bus API Design Guidelines":
> > > > > +https://dbus.freedesktop.org/doc/dbus-api-design.html
> > > > > +
> > > > > +The "org.qemu*" prefix is reserved for the QEMU project.
> > > > > diff --git a/docs/interop/index.rst b/docs/interop/index.rst
> > > > > index b4bfcab417..fa4478ce2e 100644
> > > > > --- a/docs/interop/index.rst
> > > > > +++ b/docs/interop/index.rst
> > > > > @@ -13,6 +13,7 @@ Contents:
> > > > >     :maxdepth: 2
> > > > >
> > > > >     bitmaps
> > > > > +   dbus
> > > > >     live-block-operations
> > > > >     pr-helper
> > > > >     vhost-user
> > > > > --
> > > > > 2.23.0
> > > > >
> > > > --
> > > > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> > > >
> > >
> > >
> > > --
> > > Marc-Andr=E9 Lureau
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>=20
>=20
>=20
> --=20
> Marc-Andr=E9 Lureau
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

