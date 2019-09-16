Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B95C49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 13:17:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EED620644
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 13:17:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EED620644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9qsk-0002L3-EX
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 09:17:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39539)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1i9qqh-0001ea-Nx
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 09:15:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1i9qqe-0005c3-5q
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 09:15:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53364)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1i9qqd-0005bL-TX
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 09:15:20 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8720F3090FC2;
 Mon, 16 Sep 2019 13:15:18 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.111])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E1A7F5C1D6;
 Mon, 16 Sep 2019 13:15:16 +0000 (UTC)
Date: Mon, 16 Sep 2019 14:15:14 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Message-ID: <20190916131514.GG2887@work-vm>
References: <20190912122514.22504-1-marcandre.lureau@redhat.com>
 <20190912122514.22504-6-marcandre.lureau@redhat.com>
 <20190916100035.GC2887@work-vm>
 <CAJ+F1C+GAJc8vYVLzBZWonVkjp-rdWFemAdwgE2sbxJDFKp0Uw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAJ+F1C+GAJc8vYVLzBZWonVkjp-rdWFemAdwgE2sbxJDFKp0Uw@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Mon, 16 Sep 2019 13:15:18 +0000 (UTC)
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
> On Mon, Sep 16, 2019 at 2:02 PM Dr. David Alan Gilbert
> <dgilbert@redhat.com> wrote:
> >
> > (Copying in Stefan since he was looking at DBus for virtiofs)
> >
> > * Marc-Andr=E9 Lureau (marcandre.lureau@redhat.com) wrote:
> > > Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> > > ---
> > >  docs/interop/dbus.rst  | 73 ++++++++++++++++++++++++++++++++++++++=
++++
> > >  docs/interop/index.rst |  1 +
> > >  2 files changed, 74 insertions(+)
> > >  create mode 100644 docs/interop/dbus.rst
> > >
> > > diff --git a/docs/interop/dbus.rst b/docs/interop/dbus.rst
> > > new file mode 100644
> > > index 0000000000..c08f026edc
> > > --- /dev/null
> > > +++ b/docs/interop/dbus.rst
> > > @@ -0,0 +1,73 @@
> > > +=3D=3D=3D=3D=3D
> > > +D-Bus
> > > +=3D=3D=3D=3D=3D
> > > +
> > > +Introduction
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > +
> > > +QEMU may be running with various helper processes involved:
> > > + - vhost-user* processes (gpu, virtfs, input, etc...)
> > > + - TPM emulation (or other devices)
> > > + - user networking (slirp)
> > > + - network services (DHCP/DNS, samba/ftp etc)
> > > + - background tasks (compression, streaming etc)
> > > + - client UI
> > > + - admin & cli
> > > +
> > > +Having several processes allows stricter security rules, as well a=
s
> > > +greater modularity.
> > > +
> > > +While QEMU itself uses QMP as primary IPC (and Spice/VNC for remot=
e
> > > +display), D-Bus is the de facto IPC of choice on Unix systems. The
> > > +wire format is machine friendly, good bindings exist for various
> > > +languages, and there are various tools available.
> > > +
> > > +Using a bus, helper processes can discover and communicate with ea=
ch
> > > +other easily, without going through QEMU. The bus topology is also
> > > +easier to apprehend and debug than a mesh. However, it is wise to
> > > +consider the security aspects of it.
> > > +
> > > +Security
> > > +=3D=3D=3D=3D=3D=3D=3D=3D
> > > +
> > > +A QEMU D-Bus bus should be private to a single VM. Thus, only
> > > +cooperative tasks are running on the same bus to serve the VM.
> > > +
> > > +D-Bus, the protocol and standard, doesn't have mechanisms to enfor=
ce
> > > +security between peers once the connection is established. Peers m=
ay
> > > +have additional mechanisms to enforce security rules, based for
> > > +example on UNIX credentials.
> > > +
> > > +dbus-daemon can enforce various policies based on the UID/GID of t=
he
> > > +processes that are connected to it. It is thus a good idea to run
> > > +helpers as different UID from QEMU and set appropriate policies (s=
o
> > > +helper processes are only allowed to talk to qemu for example).
> > > +
> > > +For example, this allows only ``qemu`` user to talk to ``qemu-help=
er``
> > > +``org.qemu.Helper1`` service:
> > > +
> > > +.. code:: xml
> > > +
> > > +  <policy user=3D"qemu">
> > > +     <allow send_destination=3D"org.qemu.Helper1"/>
> > > +     <allow receive_sender=3D"org.qemu.Helper1"/>
> > > +  </policy>
> > > +
> > > +  <policy user=3D"qemu-helper">
> > > +     <allow own=3D"org.qemu.Helper1"/>
> > > +  </policy>
> > > +
> > > +
> > > +dbus-daemon can also perfom SELinux checks based on the security
> > > +context of the source and the target. For example, ``virtiofs_t``
> > > +could be allowed to send a message to ``svirt_t``, but ``virtiofs_=
t``
> > > +wouldn't be allowed to send a message to ``virtiofs_t``.
> >
> > I think we need to start thinking about this more now rather than
> > 'can'. .
>=20
> Do you have a specific question we can answer or guide for qemu? Is
> there something we have to document or implement?
>=20
> Since qemu is not managing the extra processes or applying policies, I
> don't know what else could be done. From qemu pov, it can rely on
> management layer to trust the bus and the helpers, similar to trusting
> the system in general.

Well pretty much the same questions I asked in the discussion on v2;
what is the supported configuration to ensure that one helper that's
been compromised can't attack the others and qemu?

Dave

> > Dave
> >
> > > +Guidelines
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > +
> > > +When implementing new D-Bus interfaces, it is recommended to follo=
w
> > > +the "D-Bus API Design Guidelines":
> > > +https://dbus.freedesktop.org/doc/dbus-api-design.html
> > > +
> > > +The "org.qemu*" prefix is reserved for the QEMU project.
> > > diff --git a/docs/interop/index.rst b/docs/interop/index.rst
> > > index b4bfcab417..fa4478ce2e 100644
> > > --- a/docs/interop/index.rst
> > > +++ b/docs/interop/index.rst
> > > @@ -13,6 +13,7 @@ Contents:
> > >     :maxdepth: 2
> > >
> > >     bitmaps
> > > +   dbus
> > >     live-block-operations
> > >     pr-helper
> > >     vhost-user
> > > --
> > > 2.23.0
> > >
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> >
>=20
>=20
> --=20
> Marc-Andr=E9 Lureau
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

