Received: from eggs.gnu.org ([2001:4830:134:3::10]:58911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gCOFf-000425-Jm
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 08:15:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gCOFb-0007fV-Fd
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 08:15:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52712)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gCOFY-0007bP-Hq
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 08:15:01 -0400
Date: Tue, 16 Oct 2018 13:14:38 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181016121438.GD7995@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180914135230.15178-1-marcandre.lureau@redhat.com>
	<20181011154834.GA10122@redhat.com>
	<CAMxuvawbr3i5d6dfaobcfOD3gvFNnR_vEzws6kmGUG+GBaJaOg@mail.gmail.com>
	<20181012095554.GV16720@redhat.com>
	<CAMxuvazRPJMxaGARop-bBsowh7HfZRnjNuOjQ=zpVBsOM_f9=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMxuvazRPJMxaGARop-bBsowh7HfZRnjNuOjQ=zpVBsOM_f9=w@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] vhost-user: define conventions for
 vhost-user backends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, libvir-list <libvir-list@redhat.com>, "Hoffmann, Gerd" <kraxel@redhat.com>, "Liu, Changpeng" <changpeng.liu@intel.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Felipe Franciosi <felipe@nutanix.com>, Gonglei <arei.gonglei@huawei.com>, "Coquelin, Maxime" <maxime.coquelin@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, "Kaplansky, Victor" <victork@redhat.com>, "Armbruster, Markus" <armbru@redhat.com>

On Tue, Oct 16, 2018 at 02:47:12PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Fri, Oct 12, 2018 at 1:56 PM Daniel P. Berrang=C3=A9 <berrange@redha=
t.com> wrote:
> >
> > On Fri, Oct 12, 2018 at 01:43:39PM +0400, Marc-Andr=C3=A9 Lureau wrot=
e:
> > > Hi
> > >
> > > On Thu, Oct 11, 2018 at 7:49 PM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
> > > >
> > > > Adding Markus since we're talking about new CLI argument and capa=
bility
> > > > reporting standards.
> > > >
> > > > On Fri, Sep 14, 2018 at 05:52:30PM +0400, Marc-Andr=C3=A9 Lureau =
wrote:
> > > > > +Backend program conventions
> > > > > +---------------------------
> > > > > +
> > > > > +vhost-user backends provide various services and they may need=
 to be
> > > > > +configured manually depending on the use case. However, it is =
a good
> > > > > +idea to follow the conventions listed here when possible. User=
s, QEMU
> > > > > +or libvirt, can then rely on some common behaviour to avoid
> > > > > +heterogenous configuration and management of the backend progr=
am and
> > > > > +facilitate interoperability.
> > > > > +
> > > > > +In order to be discoverable, default vhost-user backends shoul=
d be
> > > > > +located under "/usr/libexec", and be named "vhost-user-$device=
" where
> > > > > +"$device" is the device name in lower-case following the name =
listed
> > > > > +in the Linux virtio_ids.h header (ex: the VIRTIO_ID_RPROC_SERI=
AL
> > > > > +backend would be named "vhost-user-rproc-serial").
> > > > > +
> > > > > +Mechanisms to list, and to select among alternatives implement=
ations
> > > > > +or modify the default backend are not described at this point =
(a
> > > > > +distribution may use update-alternatives, for example, to list=
 and to
> > > > > +pick a different default backend).
> > > >
> > > > I don't think that update-alternatives is a good thing as it pres=
umes
> > > > that each host only needs a single preferred impl at a time.
> > > >
> > > > I think we need to be able to discover all impls for a given devi=
ce
> > > > type.
> > >
> > > That was left for a future improvement. I don't think it's a good i=
dea
> > > to tackle problems we don't have yet.
> >
> > I think the need to support multiple alternatives will arrive pretty
> > much immediately, as it has already been raised in previous threads
> > about vhost-user. It is counterproductive to implement something we
>=20
> At this point, there are no alternative implementation of the
> vhost-user-gpu or vhost-user-input backends (and no other device has
> been implemented to follow this spec).

We can't assume that will remain true. The very notion of the
capabilities reporting for optional features indicates that
we're expecting alternate impls with varying feature sets.

> > know is not satisfactory when we can easily provide an approach
> > which is extensible for no significant extra work upfront. Having
> > it aligned with the approach we do for firmware makes it even more
> > compelling, as we get a consistent story across QEMU instead of
> > two completely different approaches for the same concept.
>=20
> That's not incompatible with doing it as a future improvement.

It is different from the POV of libvirt, as it implies two different
ways to identifying which is the preferred / default vhost. I don't
see a compelling reason to provide an initial impl that is intentionally
not flexible enough to cope with future needs.

> > > > > +The backend program must not daemonize itself, but it may be
> > > > > +daemonized by the management layer. It may also have a restric=
ted
> > > > > +access to the system.
> > > > > +
> > > > > +File descriptors 0, 1 and 2 will exist, and have regular
> > > > > +stdin/stdout/stderr usage (they may be redirected to /dev/null=
 by the
> > > > > +management layer, or to a log handler).
> > > > > +
> > > > > +The backend program must end (as quickly and cleanly as possib=
le) when
> > > > > +the SIGTERM signal is received. Eventually, it may be SIGKILL =
by the
> > > > > +management layer after a few seconds.
> > > > > +
> > > > > +The following command line options have an expected behaviour.=
 They
> > > > > +are mandatory, unless explicitly said differently:
> > > > > +
> > > > > +* --socket-path=3DPATH
> > > > > +
> > > > > +This option specify the location of the vhost-user Unix domain=
 socket.
> > > > > +It is incompatible with --fd.
> > > > > +
> > > > > +* --fd=3DFDNUM
> > > > > +
> > > > > +When this argument is given, the backend program is started wi=
th the
> > > > > +vhost-user socket as file descriptor FDNUM. It is incompatible=
 with
> > > > > +--socket-path.
> > > > > +
> > > > > +* --print-capabilities
> > > > > +
> > > > > +Output to stdout a line-seperated list of backend capabilities=
, and
> > > > > +then exit successfully. Other options and arguments should be =
ignored,
> > > > > +and the backend program should not perform its normal function=
.
> > > >
> > > > This is going to repeat the mistakes we've had with every other
> > > > binary in QEMU. A "simple" flag list or args sounds appealing,
> > > > but we've always been burnt by it in the medium-long term, which
> > > > is why we created QAPI.
> > >
> > > isn't libvirt using a list of strings/symbols as well for the
> > > capabilities? To me it sounds fairly easy to extend this way.
> > >
> > > > If we're doing to have any capabilities reporting, we should
> > > > model it in QAPI schema, so any '--print-capabilities' arg
> > > > should print a JSON doc following the documented schema.
> > >
> > > perhaps we could have --print-json-capabilities later, if needed.
> >
> > A QAPI schema can still start off as reporting a simple list of
> > features flags.
> > The key point is to provide a data format that is extensible
> > right from the start. For QEMU that means QAPI, instead of
> > inventing yet another custom data format, that we'd have to
> > fix later when we find a flat list of strings is insufficient.
>=20
>=20
> Changing --print-capabilites from:
> feature-a
> feature-b
>=20
> to a json form:
> {
>   "features": [
>     "feature-a",
>     "feature-b"
>   ]
> }
>=20
> Would that be extensible enough?

As long as the JSON format is associated with a QAPI schema so we
have a clear specification that we're following as illustrated in
this example

  https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg02459.html

> > > > While talking about QAPI, I think this is an opportunity to
> > > > also avoid the problems of CLI arg values becoming more
> > > > complex than just scalars. eg
> > > >
> > > >   --socket-path=3DPATH
> > > >
> > > > may inevitably grow more options  - eg to perhaps say whether
> > > > to use it in listen or connect mode. Or to indicate a reconnect
> > > > timeout. etc
> > >
> > > Yes, that would be new capabilities symbols. That doesn't require j=
son to me.
> >
> > It just reinvents the chardev unix socket syntax, but in a
> > different adhoc manner, which is repeating the mistake we have
> > made time & again in QEMU. Using QAPI we can directly accept
> > the ChardevSocket syntax we already know about. Instead of
> > having --socket-path and --fd and documenting that they are
> > mutually exclusive ChardevSocket QAPI schema provides that
> > representation in a well defined format which is discoverable
> > and QEMU and mgmt apps already understand.
>=20
> That would require external vhost-user backends to implement QAPI/json
> parsing. Is this necessary for a vhost-user backend? I doubt it.

They could, but would not be required, to implement QAPI/json parser.

The QAPI schema defines a standard for how to model & interpret the
non-scalar values for command line arguments. An external impl would
need to ensure that whatever parsing it does for CLI args is semantically
compatible with the parsing rules defined by the QEMU QAPI schema we
define to ensure interoperability of its impl.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
