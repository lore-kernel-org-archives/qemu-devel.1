Received: from eggs.gnu.org ([2001:4830:134:3::10]:57911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gHsfv-0006Sv-N1
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 11:44:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gHsfr-0006QD-6K
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 11:44:55 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37862)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gHsfq-0006N8-PX
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 11:44:50 -0400
Received: by mail-qk1-f193.google.com with SMTP id 131so10240357qkd.4
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 08:44:49 -0700 (PDT)
MIME-Version: 1.0
References: <20180914135230.15178-1-marcandre.lureau@redhat.com>
	<20181011154834.GA10122@redhat.com>
	<CAMxuvawbr3i5d6dfaobcfOD3gvFNnR_vEzws6kmGUG+GBaJaOg@mail.gmail.com>
	<20181012095554.GV16720@redhat.com>
	<CAMxuvazRPJMxaGARop-bBsowh7HfZRnjNuOjQ=zpVBsOM_f9=w@mail.gmail.com>
	<20181016121438.GD7995@redhat.com>
In-Reply-To: <20181016121438.GD7995@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 31 Oct 2018 19:44:36 +0400
Message-ID: <CAMxuvayaPxq1EJATVVsQUvA1bktUoUPZmez+-O4R2U81g-Vvfg@mail.gmail.com>
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

On Tue, Oct 16, 2018 at 4:14 PM Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m> wrote:
> > > It just reinvents the chardev unix socket syntax, but in a
> > > different adhoc manner, which is repeating the mistake we have
> > > made time & again in QEMU. Using QAPI we can directly accept
> > > the ChardevSocket syntax we already know about. Instead of
> > > having --socket-path and --fd and documenting that they are
> > > mutually exclusive ChardevSocket QAPI schema provides that
> > > representation in a well defined format which is discoverable
> > > and QEMU and mgmt apps already understand.
> >
> > That would require external vhost-user backends to implement QAPI/json
> > parsing. Is this necessary for a vhost-user backend? I doubt it.
>
> They could, but would not be required, to implement QAPI/json parser.
>
> The QAPI schema defines a standard for how to model & interpret the
> non-scalar values for command line arguments. An external impl would
> need to ensure that whatever parsing it does for CLI args is semantically
> compatible with the parsing rules defined by the QEMU QAPI schema we
> define to ensure interoperability of its impl.

So you would want to have something like?

--chardev '{ "id" : "bar", "backend" : { "type" : "socket", "data" : {
"addr" : { "type": "unix", "path": "/tmp/foo.sock" }, "server":
"false"  } } }'

instead of:

--socket-path=3D/tmp/foo.sock

I don't really get what that will help with, for the vhost-user backend cas=
e...

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
