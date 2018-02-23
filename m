Received: from eggs.gnu.org ([2001:4830:134:3::10]:59574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhenyuw@linux.intel.com>) id 1ep3wm-0003HZ-SQ
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 22:24:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhenyuw@linux.intel.com>) id 1ep3vg-0006AI-Ft
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 22:22:56 -0500
Received: from mga12.intel.com ([192.55.52.136]:34418)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zhenyuw@linux.intel.com>)
	id 1ep3vf-00066c-LB
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 22:21:47 -0500
Date: Fri, 23 Feb 2018 11:14:38 +0800
From: Zhenyu Wang <zhenyuw@linux.intel.com>
Message-ID: <20180223031437.ix4kyynqvzgal65l@zhen-hp.sh.intel.com>
Reply-To: Zhenyu Wang <zhenyuw@linux.intel.com>
References: <20180219111458.25983-1-kraxel@redhat.com>
	<20180219111458.25983-5-kraxel@redhat.com>
	<20180222153740.3zkvjen77uwjqhd2@sirius.home.kraxel.org>
	<CAFEAcA8_VRML=FopCKdGnrPCyZ9MwKokMj60962=tgCNwNT2oA@mail.gmail.com>
	<20180222095917.29eda1d9@w520.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="shavk5og3mkyxpdk"
Content-Disposition: inline
In-Reply-To: <20180222095917.29eda1d9@w520.home>
Subject: Re: [Qemu-devel] [PATCH v4 4/7] qdev: add hotpluggable to
 DeviceState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Tina Zhang <tina.zhang@intel.com>, Kirti Wankhede <kwankhede@nvidia.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, intel-gvt-dev@lists.freedesktop.org


--shavk5og3mkyxpdk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2018.02.22 09:59:17 -0700, Alex Williamson wrote:
> On Thu, 22 Feb 2018 15:46:17 +0000
> Peter Maydell <peter.maydell@linaro.org> wrote:
>=20
> > On 22 February 2018 at 15:37, Gerd Hoffmann <kraxel@redhat.com> wrote:
> > > On Mon, Feb 19, 2018 at 12:14:55PM +0100, Gerd Hoffmann wrote: =20
> > >> vfio display support wants disable hotplug for certain devices, beca=
use
> > >> qemu doesn't support hotplugging display devices and qemu consoles.
> > >>
> > >> Add a hotpluggable bool to DeviceState, initialize it from
> > >> DeviceClass->hotpluggable, update device_get_hotpluggable accordingl=
y.
> > >>
> > >> Devices can flip the new variable from true to false if needed. =20
> > >
> > > Alex wants an ack for this one.  Who maintains it these days?
> > >
> > > MAINTAINERS doesn't list qdev.  For QOM which is closest probably
> > > Andreas F=E4rber is listed.  Havn't seen him on the list for a while
> > > though.
> > >
> > > Ok, lets try some usual suspects...
> > > Markus? Eric? Paolo? Peter?  Any comments on this one? =20
> >=20
> > What type of device is only sometimes hotpluggable ?
> > The commit message says "display devices" and "consoles",
> > but I would expect those to both be types of device which
> > have a class which is never hotpluggable, so you can mark
> > them non-hotpluggable with the existing class flag rather
> > than needing a per-instance flag.
>=20
> With this series, a vfio-pci device optionally supports a display.  The
> vfio-pci device is hotpluggable, but QEMU display support is not.  So
> the solution here is to make the vfio-pci device non-hotpluggable only
> when it supports and enables a display.
>

I'm not sure, how this is supposed to work?

And there's also case that vgpu's display is not required but still need
device hotplug feature e.g to use render/media acceleration, as supported
by current vfio mdev device on gvt-g.

> Gerd, is there another solution that the display object is instantiated
> separately from the vfio-pci object and the display support in the
> vfio-pci device references the display object via an id.  Possibly
> vfio-pci could remain hotpluggable while the display class device is
> not.  Potentially one display could be switched between multiple
> display capable devices, like an input control button on a monitor,
> losing signal if none are connected.  Possible?  Clearly I have no idea
> how display objects actually work in QEMU.  Thanks,
>=20
> Alex
> _______________________________________________
> intel-gvt-dev mailing list
> intel-gvt-dev@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/intel-gvt-dev

--=20
Open Source Technology Center, Intel ltd.

$gpg --keyserver wwwkeys.pgp.net --recv-keys 4D781827

--shavk5og3mkyxpdk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQTXuabgHDW6LPt9CICxBBozTXgYJwUCWo+HHQAKCRCxBBozTXgY
J9PvAKCIP0DbJvdloafcJiGRluq4wsE4fQCfUvt1McOmzkBZoMrhpUyATZZ8dPs=
=Dgk2
-----END PGP SIGNATURE-----

--shavk5og3mkyxpdk--
