Received: from eggs.gnu.org ([2001:4830:134:3::10]:36597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gHXU8-0002kj-Bh
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 13:07:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gHXU3-0003Th-EC
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 13:07:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34834)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gHXU3-0003Ro-5i
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 13:07:15 -0400
Date: Tue, 30 Oct 2018 17:07:04 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181030170704.GN27951@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180921111332.12973-1-marcandre.lureau@redhat.com>
	<20180924111241.0a686314@redhat.com>
	<CAJ+F1CK4BisaXjrJN7uX8pkteScSetTpQjyYoWXv8OyHNT-kGQ@mail.gmail.com>
	<CAJ+F1CJDqvCdoHpVQ5NnAHEY_suda65q58d3bOYQ4Q=Zk7k0Sg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJ+F1CJDqvCdoHpVQ5NnAHEY_suda65q58d3bOYQ4Q=Zk7k0Sg@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/2] RFC: object: recommend a few type
 check macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Guangrong Xiao <xiaoguangrong.eric@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, QEMU <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>, Richard Henderson <rth@twiddle.net>

On Tue, Oct 30, 2018 at 08:37:47PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Mon, Oct 1, 2018 at 5:47 PM Marc-Andr=C3=A9 Lureau
> <marcandre.lureau@gmail.com> wrote:
> >
> > Hi
> >
> > On Mon, Sep 24, 2018 at 1:30 PM Igor Mammedov <imammedo@redhat.com> w=
rote:
> > >
> > > On Fri, 21 Sep 2018 15:13:30 +0400
> > > Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:
> > >
> > > > Hi,
> > > >
> > > > This is a readability suggestion. See the first patch for the doc
> > > > change, and the second patch for an example of usage and readabil=
ity
> > > > improvement.
> > > Looks like a nice improvement,
> > > but could you conversion tree wide so we end up with a consistent
> > > way to cast across the tree.
> > > Probably it would result in negative diffstat and demonstrate
> > > usefulness of the simplification in numbers.
> >
> > It doesn't result in negative diffstat, since often a one-liner is
> > replaced by a 2-liner macro ;)
> >
> > However, the resulting code is more pleasant to read imho.
> >
> > I attached the whole diff here, the branch with the 49 patches
> > split-series is here: https://github.com/elmarco/qemu/commits/object
> >
> > Let me know what you think
>=20
> So after doing that conversion work, what do we do?

I say submit it, as I'm in favour of the readability of the macro and
like the alignment with gobject paradigm.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
