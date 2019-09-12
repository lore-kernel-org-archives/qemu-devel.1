Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5320C4CEC6
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 15:18:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A223C20856
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 15:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="ZPonS1/K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A223C20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8Qrs-0006Fo-Lr
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 11:18:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38967)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Paul.Durrant@citrix.com>) id 1i8QpG-0004Bf-66
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 11:16:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Paul.Durrant@citrix.com>) id 1i8QpE-0004jn-Nk
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 11:16:01 -0400
Received: from esa2.hc3370-68.iphmx.com ([216.71.145.153]:43510)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Paul.Durrant@citrix.com>)
 id 1i8QpE-0004i7-Ep
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 11:16:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1568301361;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=x0ib6NLGTxY5+v4S2EE3NqXlHjp57FOukSnc0biB1As=;
 b=ZPonS1/KbQ56S7TVVFYuLWfGtdq5i0d69yIgjWo9MYrbwiu6Xzm91JtX
 zNesRkJduyE1JdaSorAk0hzA4gdneGrZXHqjtFtyeeUbX62EzbdaE4rwU
 VxiPm8iMQphW7oO00lNyl3+7fXqIzO7TqDaP7dEpc63tqUf6cdu9jKO7b 4=;
Authentication-Results: esa2.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none;
 spf=None smtp.pra=Paul.Durrant@citrix.com;
 spf=Pass smtp.mailfrom=Paul.Durrant@citrix.com;
 spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa2.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 Paul.Durrant@citrix.com) identity=pra;
 client-ip=162.221.158.21; receiver=esa2.hc3370-68.iphmx.com;
 envelope-from="Paul.Durrant@citrix.com";
 x-sender="Paul.Durrant@citrix.com"; x-conformance=sidf_compatible
Received-SPF: Pass (esa2.hc3370-68.iphmx.com: domain of
 Paul.Durrant@citrix.com designates 162.221.158.21 as
 permitted sender) identity=mailfrom;
 client-ip=162.221.158.21; receiver=esa2.hc3370-68.iphmx.com;
 envelope-from="Paul.Durrant@citrix.com";
 x-sender="Paul.Durrant@citrix.com";
 x-conformance=sidf_compatible; x-record-type="v=spf1";
 x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
 ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
 ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
 ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83 ~all"
Received-SPF: None (esa2.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 postmaster@mail.citrix.com) identity=helo;
 client-ip=162.221.158.21; receiver=esa2.hc3370-68.iphmx.com;
 envelope-from="Paul.Durrant@citrix.com";
 x-sender="postmaster@mail.citrix.com";
 x-conformance=sidf_compatible
IronPort-SDR: 3+/XlMaJNZuDstqazJtQZzKvQtp77ZoKO5tNHMiw/prNrShaiJy+Cz5ecWtYVgNu3TEKWwdsax
 I4uzmv5YSCdVmE6ZvGpI0WilGgbjNCAJxkTMmtC8X+h0diFOR3VfeWe5a+7AzM8+oPaQn//np0
 BW7omwHnP5uGusFPi/n1xK12Uwsb3gAe/mbTlKCZywkrETlQ+w6w0iJUC39s2qJ70AGxe5LC2G
 8CimoSLUErrqw2+WcwgVUDBfjtBIRWyrzu0Qbf68CbraMl2oooKT0HPj33bgnLMOj50wuP2Wq1
 msA=
X-SBRS: 2.7
X-MesageID: 5489132
X-Ironport-Server: esa2.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.64,497,1559534400"; 
   d="scan'208";a="5489132"
From: Paul Durrant <Paul.Durrant@citrix.com>
To: Anthony Perard <anthony.perard@citrix.com>
Thread-Topic: [PATCH v2 3/3] xen: perform XenDevice clean-up in XenBus watch
 handler
Thread-Index: AQHVaWP1a6uo9FDbNkeviSOLMWhOMKcoAmKAgAAj/tA=
Date: Thu, 12 Sep 2019 15:15:30 +0000
Message-ID: <c71d01fbe7ab46d78992fe30fd2e550d@AMSPEX02CL03.citrite.net>
References: <20190912121646.29148-1-paul.durrant@citrix.com>
 <20190912121646.29148-4-paul.durrant@citrix.com>
 <20190912150417.GD1308@perard.uk.xensource.com>
In-Reply-To: <20190912150417.GD1308@perard.uk.xensource.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.145.153
Subject: Re: [Qemu-devel] [PATCH v2 3/3] xen: perform XenDevice clean-up in
 XenBus watch handler
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
Cc: "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Stefano
 Stabellini <sstabellini@kernel.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> -----Original Message-----
> From: Anthony PERARD <anthony.perard@citrix.com>
> Sent: 12 September 2019 16:04
> To: Paul Durrant <Paul.Durrant@citrix.com>
> Cc: qemu-devel@nongnu.org; xen-devel@lists.xenproject.org; Stefano Stabel=
lini <sstabellini@kernel.org>
> Subject: Re: [PATCH v2 3/3] xen: perform XenDevice clean-up in XenBus wat=
ch handler
>=20
> On Thu, Sep 12, 2019 at 01:16:46PM +0100, Paul Durrant wrote:
> > Cleaning up offine XenDevice objects directly in
>               ^ offline
>=20
> > xen_device_backend_changed() is dangerous as xen_device_unrealize() wil=
l
> > modify the watch list that is being walked. Even the QLIST_FOREACH_SAFE=
()
> > used in notifier_list_notify() is insufficient as *two* notifiers (for
> > the frontend and backend watches) are removed, thus potentially renderi=
ng
> > the 'next' pointer unsafe.
> >
> > The solution is to use the XenBus backend_watch handler to do the clean=
-up
> > instead, as it is invoked whilst walking a separate watch list.
> >
> > This patch therefore adds a new 'offline_devices' list to XenBus, to wh=
ich
> > offline devices are added by xen_device_backend_changed(). The XenBus
> > backend_watch registration is also changed to not only invoke
> > xen_bus_enumerate() but also a new xen_bus_cleanup() function, which wi=
ll
> > walk 'offline_devices' and perform the necessary actions.
> > For safety a an extra 'online' check is also added to
>              ^ one 'a' too many?
>=20
> > xen_bus_type_enumerate() to make sure that no attempt is made to create=
 a
> > new XenDevice object for a backend that is offline.
> >
> > NOTE: This patch also include some cosmetic changes:
> >       - substitute the local variable name 'backend_state'
> >         in xen_bus_type_enumerate() with 'state', since there
> >         is no ambiguity with any other state in that context.
> >       - change xen_device_state_is_active() to
> >         xen_device_frontend_is_active() (and pass a XenDevice directly)
> >         since the state tests contained therein only apply to a fronten=
d.
> >       - use 'state' rather then 'xendev->backend_state' in
> >         xen_device_backend_changed() to shorten the code.
> >
> > Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
> > ---
> >
> > v2:
> >  - Make sure we don't try to add a XenDevice to 'offline_devices' more =
than
> >    once
> > ---
> >
> >      /*
> >       * If a backend is still 'online' then we should leave it alone bu=
t,
> > -     * if a backend is not 'online', then the device should be destroy=
ed
> > -     * once the state is Closed.
> > +     * if a backend is not 'online', then the device is a candidate
> > +     * for destruction. Hence add it to the 'offline' list to be clean=
ed
> > +     * by xen_bus_cleanup().
> >       */
> > -    if (!xendev->backend_online &&
> > -        (xendev->backend_state =3D=3D XenbusStateClosed ||
> > -         xendev->backend_state =3D=3D XenbusStateInitialising ||
> > -         xendev->backend_state =3D=3D XenbusStateInitWait ||
> > -         xendev->backend_state =3D=3D XenbusStateUnknown)) {
> > -        Error *local_err =3D NULL;
> > +    if (!online &&
> > +        (state =3D=3D XenbusStateClosed ||  state =3D=3D XenbusStateIn=
itialising ||
> > +         state =3D=3D XenbusStateInitWait || state =3D=3D XenbusStateU=
nknown) &&
> > +        !QLIST_NEXT(xendev, list)) {
>=20
> Could you add a note about this QLIST_NEXT? I don't think it's going to
> be obvious enough why we check that there are no next item. I might only
> understand it just because of your reply to the v1 of the patch.
> (Well the changelog of the patch also point out what it's for.)
>=20

Sure, it's worth a comment.

> > +        XenBus *xenbus =3D XEN_BUS(qdev_get_parent_bus(DEVICE(xendev))=
);
> >
> > -        if (!xen_backend_try_device_destroy(xendev, &local_err)) {
> > -            object_unparent(OBJECT(xendev));
> > -        }
> > +        QLIST_INSERT_HEAD(&xenbus->offline_devices, xendev, list);
> >
> > -        if (local_err) {
> > -            error_report_err(local_err);
> > -        }
> > +        /*
> > +         * Re-write the state to cause a XenBus backend_watch notifica=
tion,
> > +         * resulting in a call to xen_bus_cleanup().
> > +         */
> > +        xen_device_backend_printf(xendev, "state", "%u", state);
>=20
> It kind of feels wrong to rely on xenstore to notify QEMU's xenbus
> driver that a device needs cleanup. But that does the job.
>=20

I had originally considered setting up an event notifier but that seemed li=
ke more fds than were strictly necessary ;-)

> With a note about the use of QLIST_NEXT and the few typo fixed, the
> patch will be good to go.
>=20

Cool. I'll tidy up and send a v3.

  Paul

> Thanks,
>=20
> --
> Anthony PERARD

