Received: from eggs.gnu.org ([2001:4830:134:3::10]:47615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eJki5-0007Rd-Rp
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 13:34:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eJki4-0002f0-QB
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 13:34:21 -0500
Date: Tue, 28 Nov 2017 16:34:08 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20171128183408.GP3037@localhost.localdomain>
References: <20171125151610.20547-1-ehabkost@redhat.com>
	<20171125151610.20547-2-ehabkost@redhat.com>
	<CAJ+F1CJRkXNnU+NK93vvSg806=vUBwxx9KGLGoJ_XBQFi+-Nfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAJ+F1CJRkXNnU+NK93vvSg806=vUBwxx9KGLGoJ_XBQFi+-Nfw@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/6] machine: Replace has_dynamic_sysbus
 with list of allowed devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, jgross@suse.com, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Alexander Graf <agraf@suse.de>, Anthony Perard <anthony.perard@citrix.com>, "open list:ARM" <qemu-arm@nongnu.org>, "open list:sPAPR pseries" <qemu-ppc@nongnu.org>, Marcel Apfelbaum <marcel@redhat.com>, xen-devel@lists.xenproject.org, Laszlo Ersek <lersek@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On Tue, Nov 28, 2017 at 05:55:15PM +0100, Marc-Andr=E9 Lureau wrote:
[...]
> Hi
>=20
> On Sat, Nov 25, 2017 at 4:16 PM, Eduardo Habkost <ehabkost@redhat.com> =
wrote:
> > The existing has_dynamic_sysbus flag makes the machine accept
> > every user-creatable sysbus device type on the command-line.
> > Replace it with a list of allowed device types, so machines can
> > easily accept some sysbus devices while rejecting others.
> >
> > To keep exactly the same behavior as before, the existing
> > has_dynamic_sysbus=3Dtrue assignments are replaced with a
> > TYPE_SYS_BUS_DEVICE entry on the allowed list.  Other patches
> > will replace the TYPE_SYS_BUS_DEVICE entries with more specific
> > lists of devices.
> >
> > Cc: Peter Maydell <peter.maydell@linaro.org>
> > Cc: Marcel Apfelbaum <marcel@redhat.com>
> > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > Cc: Alexander Graf <agraf@suse.de>
> > Cc: David Gibson <david@gibson.dropbear.id.au>
> > Cc: Stefano Stabellini <sstabellini@kernel.org>
> > Cc: Anthony Perard <anthony.perard@citrix.com>
> > Cc: qemu-arm@nongnu.org
> > Cc: qemu-ppc@nongnu.org
> > Cc: xen-devel@lists.xenproject.org
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>=20
> Reviewed-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>

Thanks!

[...]
> > -    mc->has_dynamic_sysbus =3D true;
> > +    /*TODO: allow only sysbus devices that really work with this mac=
hine */
>=20
> cosmetic: why do you not leave a space between * and TODO ? (you did
> that repeatedly)

Good question.  :)

For reasons I can't explain, I thought "/*TODO:" was more common
than "/* TODO:", but I was mistaken.  I will change this to
"/* TODO:" when committing the patches.

--=20
Eduardo
