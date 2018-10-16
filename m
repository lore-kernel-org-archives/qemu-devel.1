Received: from eggs.gnu.org ([2001:4830:134:3::10]:58157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gCMt3-000206-8t
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 06:47:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gCMsx-0001Lt-Cn
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 06:47:39 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38444)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gCMsx-0000ss-4M
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 06:47:35 -0400
Received: by mail-qt1-f194.google.com with SMTP id l9-v6so25032738qtf.5
	for <qemu-devel@nongnu.org>; Tue, 16 Oct 2018 03:47:24 -0700 (PDT)
MIME-Version: 1.0
References: <20180914135230.15178-1-marcandre.lureau@redhat.com>
	<20181011154834.GA10122@redhat.com>
	<CAMxuvawbr3i5d6dfaobcfOD3gvFNnR_vEzws6kmGUG+GBaJaOg@mail.gmail.com>
	<20181012095554.GV16720@redhat.com>
In-Reply-To: <20181012095554.GV16720@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 16 Oct 2018 14:47:12 +0400
Message-ID: <CAMxuvazRPJMxaGARop-bBsowh7HfZRnjNuOjQ=zpVBsOM_f9=w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: "P. Berrange, Daniel" <berrange@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, libvir-list <libvir-list@redhat.com>, "Hoffmann, Gerd" <kraxel@redhat.com>, "Liu,
	Changpeng" <changpeng.liu@intel.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Felipe Franciosi <felipe@nutanix.com>, Gonglei <arei.gonglei@huawei.com>, "Coquelin,
	Maxime" <maxime.coquelin@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, "Kaplansky,
	Victor" <victork@redhat.com>, "Armbruster, Markus" <armbru@redhat.com>

Hi

On Fri, Oct 12, 2018 at 1:56 PM Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m> wrote:
>
> On Fri, Oct 12, 2018 at 01:43:39PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > On Thu, Oct 11, 2018 at 7:49 PM Daniel P. Berrang=C3=A9 <berrange@redha=
t.com> wrote:
> > >
> > > Adding Markus since we're talking about new CLI argument and capabili=
ty
> > > reporting standards.
> > >
> > > On Fri, Sep 14, 2018 at 05:52:30PM +0400, Marc-Andr=C3=A9 Lureau wrot=
e:
> > > > +Backend program conventions
> > > > +---------------------------
> > > > +
> > > > +vhost-user backends provide various services and they may need to =
be
> > > > +configured manually depending on the use case. However, it is a go=
od
> > > > +idea to follow the conventions listed here when possible. Users, Q=
EMU
> > > > +or libvirt, can then rely on some common behaviour to avoid
> > > > +heterogenous configuration and management of the backend program a=
nd
> > > > +facilitate interoperability.
> > > > +
> > > > +In order to be discoverable, default vhost-user backends should be
> > > > +located under "/usr/libexec", and be named "vhost-user-$device" wh=
ere
> > > > +"$device" is the device name in lower-case following the name list=
ed
> > > > +in the Linux virtio_ids.h header (ex: the VIRTIO_ID_RPROC_SERIAL
> > > > +backend would be named "vhost-user-rproc-serial").
> > > > +
> > > > +Mechanisms to list, and to select among alternatives implementatio=
ns
> > > > +or modify the default backend are not described at this point (a
> > > > +distribution may use update-alternatives, for example, to list and=
 to
> > > > +pick a different default backend).
> > >
> > > I don't think that update-alternatives is a good thing as it presumes
> > > that each host only needs a single preferred impl at a time.
> > >
> > > I think we need to be able to discover all impls for a given device
> > > type.
> >
> > That was left for a future improvement. I don't think it's a good idea
> > to tackle problems we don't have yet.
>
> I think the need to support multiple alternatives will arrive pretty
> much immediately, as it has already been raised in previous threads
> about vhost-user. It is counterproductive to implement something we

At this point, there are no alternative implementation of the
vhost-user-gpu or vhost-user-input backends (and no other device has
been implemented to follow this spec).

> know is not satisfactory when we can easily provide an approach
> which is extensible for no significant extra work upfront. Having
> it aligned with the approach we do for firmware makes it even more
> compelling, as we get a consistent story across QEMU instead of
> two completely different approaches for the same concept.

That's not incompatible with doing it as a future improvement.

>
>
> > > > +The backend program must not daemonize itself, but it may be
> > > > +daemonized by the management layer. It may also have a restricted
> > > > +access to the system.
> > > > +
> > > > +File descriptors 0, 1 and 2 will exist, and have regular
> > > > +stdin/stdout/stderr usage (they may be redirected to /dev/null by =
the
> > > > +management layer, or to a log handler).
> > > > +
> > > > +The backend program must end (as quickly and cleanly as possible) =
when
> > > > +the SIGTERM signal is received. Eventually, it may be SIGKILL by t=
he
> > > > +management layer after a few seconds.
> > > > +
> > > > +The following command line options have an expected behaviour. The=
y
> > > > +are mandatory, unless explicitly said differently:
> > > > +
> > > > +* --socket-path=3DPATH
> > > > +
> > > > +This option specify the location of the vhost-user Unix domain soc=
ket.
> > > > +It is incompatible with --fd.
> > > > +
> > > > +* --fd=3DFDNUM
> > > > +
> > > > +When this argument is given, the backend program is started with t=
he
> > > > +vhost-user socket as file descriptor FDNUM. It is incompatible wit=
h
> > > > +--socket-path.
> > > > +
> > > > +* --print-capabilities
> > > > +
> > > > +Output to stdout a line-seperated list of backend capabilities, an=
d
> > > > +then exit successfully. Other options and arguments should be igno=
red,
> > > > +and the backend program should not perform its normal function.
> > >
> > > This is going to repeat the mistakes we've had with every other
> > > binary in QEMU. A "simple" flag list or args sounds appealing,
> > > but we've always been burnt by it in the medium-long term, which
> > > is why we created QAPI.
> >
> > isn't libvirt using a list of strings/symbols as well for the
> > capabilities? To me it sounds fairly easy to extend this way.
> >
> > > If we're doing to have any capabilities reporting, we should
> > > model it in QAPI schema, so any '--print-capabilities' arg
> > > should print a JSON doc following the documented schema.
> >
> > perhaps we could have --print-json-capabilities later, if needed.
>
> A QAPI schema can still start off as reporting a simple list of
> features flags.
> The key point is to provide a data format that is extensible
> right from the start. For QEMU that means QAPI, instead of
> inventing yet another custom data format, that we'd have to
> fix later when we find a flat list of strings is insufficient.


Changing --print-capabilites from:
feature-a
feature-b

to a json form:
{
  "features": [
    "feature-a",
    "feature-b"
  ]
}

Would that be extensible enough?

>
>
> > > While talking about QAPI, I think this is an opportunity to
> > > also avoid the problems of CLI arg values becoming more
> > > complex than just scalars. eg
> > >
> > >   --socket-path=3DPATH
> > >
> > > may inevitably grow more options  - eg to perhaps say whether
> > > to use it in listen or connect mode. Or to indicate a reconnect
> > > timeout. etc
> >
> > Yes, that would be new capabilities symbols. That doesn't require json =
to me.
>
> It just reinvents the chardev unix socket syntax, but in a
> different adhoc manner, which is repeating the mistake we have
> made time & again in QEMU. Using QAPI we can directly accept
> the ChardevSocket syntax we already know about. Instead of
> having --socket-path and --fd and documenting that they are
> mutually exclusive ChardevSocket QAPI schema provides that
> representation in a well defined format which is discoverable
> and QEMU and mgmt apps already understand.

That would require external vhost-user backends to implement QAPI/json
parsing. Is this necessary for a vhost-user backend? I doubt it.

>
>
> Regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
