Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF237C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 11:43:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EB8221848
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 11:43:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EB8221848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i17yz-0003KO-Ol
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 07:43:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50405)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1i17xK-0001J9-8m
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 07:42:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1i17xI-0000dO-Ib
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 07:42:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45584)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1i17xI-0000cu-9R
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 07:42:08 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 997A4C050061
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2019 11:42:07 +0000 (UTC)
Received: from redhat.com (ovpn-112-60.ams2.redhat.com [10.36.112.60])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8370D60610;
 Fri, 23 Aug 2019 11:42:00 +0000 (UTC)
Date: Fri, 23 Aug 2019 12:41:57 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <20190823114157.GG9654@redhat.com>
References: <20190808150325.21939-1-marcandre.lureau@redhat.com>
 <20190823112053.GE9654@redhat.com>
 <CAMxuvayoLetZkJ_HNKxC8Y0Yk33hn5pHLLn32R-XCuD7z31i=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMxuvayoLetZkJ_HNKxC8Y0Yk33hn5pHLLn32R-XCuD7z31i=Q@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Fri, 23 Aug 2019 11:42:07 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 0/2] Add dbus-vmstate
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Juan Quintela <quintela@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 23, 2019 at 03:31:16PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Fri, Aug 23, 2019 at 3:21 PM Daniel P. Berrang=C3=A9 <berrange@redha=
t.com> wrote:
> >
> > On Thu, Aug 08, 2019 at 07:03:23PM +0400, Marc-Andr=C3=A9 Lureau wrot=
e:
> > > Hi,
> > >
> > > With external processes or helpers participating to the VM support,=
 it
> > > becomes necessary to handle their migration. Various options exist =
to
> > > transfer their state:
> > > 1) as the VM memory, RAM or devices (we could say that's how
> > >    vhost-user devices can be handled today, they are expected to
> > >    restore from ring state)
> > > 2) other "vmstate" (as with TPM emulator state blobs)
> > > 3) left to be handled by management layer
> > >
> > > 1) is not practical, since an external processes may legitimatelly
> > > need arbitrary state date to back a device or a service, or may not
> > > even have an associated device.
> > >
> > > 2) needs ad-hoc code for each helper, but is simple and working
> > >
> > > 3) is complicated for management layer, QEMU has the migration timi=
ng
> > >
> > > The proposed "dbus-vmstate" object will connect to a given D-Bus
> > > peer address, and save/load from org.qemu.VMState1 interface.
> > >
> > > This way, helpers can have their state migrated with QEMU, without
> > > implementing another ad-hoc support (such as done for TPM emulation=
)
> > >
> > > I chose D-Bus as it is ubiquitous on Linux (it is systemd IPC), and
> > > can be made to work on various other OSes. There are several
> > > implementations and good bindings for various languages.
> > > (the tests/dbus-vmstate-test.c is a good example of how simple
> > > the implementation of services can be, even in C)
> > >
> > > v2:
> > > - D-Bus is most common and practical through a bus, but it requires=
 a
> > >   daemon to be running. I argue that the benefits outweight the cos=
t
> > >   of running an extra daemon in v1 in the context of multi-process
> > >   qemu, but it is also possible to connect in p2p mode as done in t=
his
> > >   new version.
> >
> > So yesterday Stefanha brought up need for "mgmt apis" on the
> > virtiofsd helper process & the conclusion is that dbus makes
> > most sense for this purpose:
> >
> >   https://www.redhat.com/archives/virtio-fs/2019-August/msg00339.html
> >
> > This use case is a slightly different from vmstate though.
> >
> > For vmstate we have two parties - virtiofsd and QEMU talking
> >
> > For the "mgmt apis" in virtiofsd, we have arbitrary parties
> > involved - virtiofsd *and* an admin client tool, and/or
> > maybe libvirt.
> >
> > I think this different scenario means that we do in fact need
> > to have a bus present, as the p2p model doesn't scale well
> > to many clients.
> >
> > Even if we have 1 dbus-daemon per QEMU instance, we need to cope
> > with multiple instances of the same helper needing to connect.
> > So we need to come up with some for identifying services. Normally
> > DBus only allows 1 peer to own a given well known service name at
> > any time.  So we can't simply talk to a well-known 'org.qemu.virtiofs=
d'
> > service name.
> >
> > Each service would need to to just rely on exporting objects under
> > its unique service id  (they look like :1.NNNN for some uniq NNN)
> >
> > QEMU still needs to known which connections on the bus are actually
> > providing vhost-user services, and which are other things (like
> > libvirt or random mgmt tools)
> >
> > So perhaps QEMU should expose a service  'org.qemu.VhostUserManager'
> > with an object /org/qemu/VhostUSerManager
> >
> > Each helper supporting vmstate could register its existance
> > by invoking a method
> >
> >    org.qemu.VhostUserManager.Register(":1.NNNN")
>=20
>=20
> There is no need for extra registration if the services are queued.
> You can then query the queue of org.qemu.VhostUser instances.
>=20
> This is the approach I took in v1 of this series with
> org.qemu.VMState1 service name.
>=20
> See https://patchew.org/QEMU/20190708072437.3339-1-marcandre.lureau@red=
hat.com/20190708072437.3339-4-marcandre.lureau@redhat.com/

I think that's a pretty gross hack tha is abusing the unique service
concept, as we clearly don't have unique services anymore.

> Other approaches are common prefix (ex:
> org.mpris.MediaPlayer2.FooBar), which also allows to identify a
> particular implementation in a simple way.

This means QEMU still has to iterate over every single client
on the bus to identify them. If you're doing that, there's
no point in owning a well known service at all. Just iterate
over the unique bus names and look for the exported object
path /org/qemu/VMState


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

