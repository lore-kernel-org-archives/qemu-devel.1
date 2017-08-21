Received: from eggs.gnu.org ([2001:4830:134:3::10]:32928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1djiQZ-0004Ii-2Q
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 04:51:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1djiQY-0007G8-2x
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 04:51:19 -0400
Date: Mon, 21 Aug 2017 18:47:48 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170821084748.GK12356@umbus.fritz.box>
References: <1503297029-28436-1-git-send-email-thuth@redhat.com>
	<20170821075520.GJ12356@umbus.fritz.box>
	<20170821104502.18b31564@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fUvfsPTz/SzOZDdw"
Content-Disposition: inline
In-Reply-To: <20170821104502.18b31564@nial.brq.redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] hw/ppc/spapr: Fix segfault when
 instantiating a 'pc-dimm' without 'memdev'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Xiao Guangrong <guangrong.xiao@linux.intel.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>


--fUvfsPTz/SzOZDdw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 21, 2017 at 10:45:02AM +0200, Igor Mammedov wrote:
> On Mon, 21 Aug 2017 17:55:20 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Mon, Aug 21, 2017 at 08:30:29AM +0200, Thomas Huth wrote:
> > > QEMU currently crashes when trying to use a 'pc-dimm' on the pseries
> > > machine without specifying its 'memdev' property. This happens because
> > > pc_dimm_get_memory_region() does not check whether the 'memdev' prope=
rty
> > > has properly been set by the user. Looking closer at this function, i=
t's
> > > also obvious that it is using &error_abort to call another function -=
 and
> > > this is bad in a function that is used in the hot-plugging calling ch=
ain
> > > since this can also cause QEMU to exit unexpectedly.
> > >=20
> > > So let's fix these issues in a proper way now: Add a "Error **errp"
> > > parameter to pc_dimm_get_memory_region() which we use in case the 'me=
mdev'
> > > property has not been set by the user, and which we can use instead of
> > > the &error_abort, and change the callers of get_memory_region() to ma=
ke
> > > use of this "errp" parameter for proper error checking.
> > >=20
> > > Signed-off-by: Thomas Huth <thuth@redhat.com> =20
> >=20
> > ppc portions
> >=20
> > Acked-by: David Gibson <david@gibson.dropbear.id.au>
> >=20
> > and the rest
> >=20
> > Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
>=20
> =20
> > I'm happy to queue this or have someone else queue it.
> Pls, go ahead and queue it via your tree

Done.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--fUvfsPTz/SzOZDdw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmanjIACgkQbDjKyiDZ
s5JS1xAAwVW7P9tEB2Zg0Fu/sxpyR/qmieXolVKqZ1IYlAEN0yI1izWE5FhiXlIu
K7z/SXh3oo1az8Yplf8NeoT1NcJZ5kkVg+VMDbiZlSpWOjxpu+kqznky430lVqpr
eng9swQ1tegGi65QKQQgDnsKtr3wFuOmQAXzJPww/0cYFJe0s5Xx1XlKtarbMGxw
2+YL81TFNHBc0MPRrzBzA4QzehY9lRSVVO2HN2itxuchDUUCBf5uBkl7EwPx7xWe
1xvW1NhInUKGUcXXqvddRaWRMeksBmVD/wIbrGXeyI2VUXnE39m02uVIFxEWY3u3
5X/nWF+JjqQYWj408eoBrv87UDacbu5hZdMnHtwUmzmEDhFekI62+kwDH8wrHQTk
Iz6r7RJWvP7V/R0oN/QDWg4SfIQjHtgHoMBG/j8PP2f1KqrsKo6z/lukov1D/K/E
xCBDwNDV6WWgjv66oiWQk+S2l2V0vLFxlah3LuEyYoqkNaj45j4zTnCKLNlMcuaT
GfobMsjxRm9eMyTGNGtW9VE6ar7XWjxU4S+cQujL4+ugbqr96SuqomLh6qWj3Tyu
93fwr0AtmxfTcEwzyxhqQOWnHjnwGE7cU3lDjQLGOSRGExYOsEQ/HN9/rqO5gF21
PTZTqE/G9vR54dpVq6T9YPymcSVkpeh9+90hsFNDLaGvJn9gZVk=
=Z5Wp
-----END PGP SIGNATURE-----

--fUvfsPTz/SzOZDdw--
