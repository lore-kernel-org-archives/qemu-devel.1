Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E3DCC4CEC9
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 12:51:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02F25206C2
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 12:51:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02F25206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iACxP-0008NV-5l
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 08:51:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38584)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iACtL-0005v2-OB
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 08:47:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iACtI-0000at-AJ
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 08:47:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49344)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iACtI-0000ZG-1I
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 08:47:32 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AB1AEC0495A3
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 12:47:30 +0000 (UTC)
Received: from redhat.com (ovpn-112-41.ams2.redhat.com [10.36.112.41])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CA0FA6012E;
 Tue, 17 Sep 2019 12:47:23 +0000 (UTC)
Date: Tue, 17 Sep 2019 13:47:21 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190917124721.GQ1069@redhat.com>
References: <20190912122514.22504-1-marcandre.lureau@redhat.com>
 <20190912122514.22504-6-marcandre.lureau@redhat.com>
 <20190916100035.GC2887@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190916100035.GC2887@work-vm>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Tue, 17 Sep 2019 12:47:30 +0000 (UTC)
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: quintela@redhat.com, mprivozn@redhat.com, qemu-devel@nongnu.org,
 stefanha@redhat.com, pbonzini@redhat.com,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Sep 16, 2019 at 11:00:35AM +0100, Dr. David Alan Gilbert wrote:
> (Copying in Stefan since he was looking at DBus for virtiofs)
>=20
> * Marc-Andr=C3=A9 Lureau (marcandre.lureau@redhat.com) wrote:
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  docs/interop/dbus.rst  | 73 ++++++++++++++++++++++++++++++++++++++++=
++
> >  docs/interop/index.rst |  1 +
> >  2 files changed, 74 insertions(+)
> >  create mode 100644 docs/interop/dbus.rst
> >=20
> > diff --git a/docs/interop/dbus.rst b/docs/interop/dbus.rst
> > new file mode 100644
> > index 0000000000..c08f026edc
> > --- /dev/null
> > +++ b/docs/interop/dbus.rst
> > @@ -0,0 +1,73 @@
> > +=3D=3D=3D=3D=3D
> > +D-Bus
> > +=3D=3D=3D=3D=3D
> > +
> > +Introduction
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +QEMU may be running with various helper processes involved:
> > + - vhost-user* processes (gpu, virtfs, input, etc...)
> > + - TPM emulation (or other devices)
> > + - user networking (slirp)
> > + - network services (DHCP/DNS, samba/ftp etc)
> > + - background tasks (compression, streaming etc)
> > + - client UI
> > + - admin & cli
> > +
> > +Having several processes allows stricter security rules, as well as
> > +greater modularity.
> > +
> > +While QEMU itself uses QMP as primary IPC (and Spice/VNC for remote
> > +display), D-Bus is the de facto IPC of choice on Unix systems. The
> > +wire format is machine friendly, good bindings exist for various
> > +languages, and there are various tools available.
> > +
> > +Using a bus, helper processes can discover and communicate with each
> > +other easily, without going through QEMU. The bus topology is also
> > +easier to apprehend and debug than a mesh. However, it is wise to
> > +consider the security aspects of it.
> > +
> > +Security
> > +=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +A QEMU D-Bus bus should be private to a single VM. Thus, only
> > +cooperative tasks are running on the same bus to serve the VM.
> > +
> > +D-Bus, the protocol and standard, doesn't have mechanisms to enforce
> > +security between peers once the connection is established. Peers may
> > +have additional mechanisms to enforce security rules, based for
> > +example on UNIX credentials.
> > +
> > +dbus-daemon can enforce various policies based on the UID/GID of the
> > +processes that are connected to it. It is thus a good idea to run
> > +helpers as different UID from QEMU and set appropriate policies (so
> > +helper processes are only allowed to talk to qemu for example).
> > +
> > +For example, this allows only ``qemu`` user to talk to ``qemu-helper=
``
> > +``org.qemu.Helper1`` service:
> > +
> > +.. code:: xml
> > +
> > +  <policy user=3D"qemu">
> > +     <allow send_destination=3D"org.qemu.Helper1"/>
> > +     <allow receive_sender=3D"org.qemu.Helper1"/>
> > +  </policy>
> > +
> > +  <policy user=3D"qemu-helper">
> > +     <allow own=3D"org.qemu.Helper1"/>
> > +  </policy>
> > +
> > +
> > +dbus-daemon can also perfom SELinux checks based on the security
> > +context of the source and the target. For example, ``virtiofs_t``
> > +could be allowed to send a message to ``svirt_t``, but ``virtiofs_t`=
`
> > +wouldn't be allowed to send a message to ``virtiofs_t``.
>=20
> I think we need to start thinking about this more now rather than
> 'can'. .

Thinking about DBus usage with helpers, as compared to the current state
with monolithic QEMU, the top priority is to ensure no degradation in
security vs current practice.

That is fairly easy from libvirt's POV - we simply need to make sure
that the dbus daemon and all helpers get given the same SELinux svirt_t
content as used for QEMU, so each QEMU is still siloed to the same
extent.

If SELinux is not enabled, then currently an out of the box libvirt
config only protects the host from QEMU, it doesn't protect QEMU
from other QEMUs, since they all run the same user ID.

It is possible to tell libvirt to run each QEMU as a separate user
ID if the mgmt app has a range of user IDs avalable. In this case,
we would simply run the helpers/dbus as the same per-QEMU user ID
to ensure we don't regress.


Getting an improved security model is obviously the ultimate goal,
as this modularity needs to offer some benefit to outweight its
costs.

In terms of SELinux, this will involve creating distinct SElinux
contexts for each helper process. (svirt_slirp_t, svirt_swtpm_t,
etc, etc).

In terms of DAC, in the per QEMU user ID scenario,  we would need
to allocate at least 2 UIDs for each QEMU process, so that helpers
would be separate from the QEMU. To be honest it would be better
if we had 3 UIDs, to the dbus daemon was separated from both the
helpers and QEMU.

This starts to sound like alot of UIDs which is tedious to manage.
Libvirt already puts QEMU in a separate mount namespace. From a
DAC POV, to get meaninguful separation will probably want libvirt
to consider the "user" namespace too. This is quite a bit of work
to get everything labelled right for  different user namespace,
but it may well simplify mgmt thereafter. We still have the same
problem though, of needing to assign a range of user IDs for each
user namespace.

Overall, I can see the possible technical options for securing
this use of DBus, so I'm not too concerned here.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

