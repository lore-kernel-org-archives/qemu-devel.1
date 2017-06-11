Received: from eggs.gnu.org ([2001:4830:134:3::10]:38137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dK2Ql-0005xv-Ij
	for qemu-devel@nongnu.org; Sun, 11 Jun 2017 08:57:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dK2Qi-0005Yf-Hi
	for qemu-devel@nongnu.org; Sun, 11 Jun 2017 08:57:23 -0400
Date: Sun, 11 Jun 2017 20:30:25 +0800
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170611123025.GB18542@umbus>
References: <20170602031507.29881-1-david@gibson.dropbear.id.au>
	<20170602031507.29881-3-david@gibson.dropbear.id.au>
	<20170609155556.1447e151@bahia.ttt.fr.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uQr8t48UFsdbeI+V"
Content-Disposition: inline
In-Reply-To: <20170609155556.1447e151@bahia.ttt.fr.ibm.com>
Subject: Re: [Qemu-devel] [PATCHv5 2/4] pseries: Move CPU compatibility
 property to machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: clg@kaod.org, mdroth@linux.vnet.ibm.com, sursingh@redhat.com, bharata@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com, abologna@redhat.com, sbobroff@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--uQr8t48UFsdbeI+V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 09, 2017 at 03:55:56PM +0200, Greg Kurz wrote:
> On Fri,  2 Jun 2017 13:15:05 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > Server class POWER CPUs have a "compat" property, which is used to set =
the
> > backwards compatibility mode for the processor.  However, this only mak=
es
> > sense for machine types which don't give the guest access to hypervisor
> > privilege - otherwise the compatibility level is under the guest's cont=
rol.
> >=20
> > To reflect this, this removes the CPU 'compat' property and instead
> > creates a 'max-cpu-compat' property on the pseries machine.  Strictly
> > speaking this breaks compatibility, but AFAIK the 'compat' option was
> > never (directly) used with -device or device_add.
> >=20
> > The option was used with -cpu.  So, to maintain compatibility, this
> > patch adds a hack to the cpu option parsing to strip out any compat
> > options supplied with -cpu and set them on the machine property
> > instead of the now deprecated cpu property.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
>=20
> Just one trivial style nit in ppc_compat_prop_set().
>=20
> Reviewed-by: Greg Kurz <groug@kaod.org>
>=20
> and
>=20
> Tested-by: Greg Kurz <groug@kaod.org>

Thanks.

[snip]

> > +static void ppc_compat_prop_set(Object *obj, Visitor *v, const char *n=
ame,
> > +                                void *opaque, Error **errp)
> > +{
> > +    Error *error =3D NULL;
>=20
> s/error/local_error maybe ? For consistency with ppc_compat_add_property(=
) below.

Yeah, makes sense.  local_err does seem to be by far the more common
name for this idiom.


--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--uQr8t48UFsdbeI+V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZPTfeAAoJEGw4ysog2bOSTnkP/i2c5YBjSd+v+Jpkz2DQXSfz
BhvcmxIGU3D7iS91YaMWhK0LiH9rC2KXlHj9NuM9+xqceNY04Tu75cgGPJ9UGd2b
nbfuDntOeGEUnK3SdiAaqIkfixHvcZV4YH1BfdHN1R3UYDu8J07eIDYxEUNU/efd
jW4QAVhytu/wwTaiaTW/VVASVV393PBKDsF3vkGoRTLf95bgD5oTGRe25HYLkUju
Z1BFJ5tZ7CBLO0+lZR34fwWWfVAJFtBwRsl3GFLgiSyGRJcyowanUv1VSeHprxjc
il2TMDAUKmLJfVZp3Wwiy5rGI/cKx6aNDLAyx+3F4qgVKQ31OpM1ueC/Xhg0RzBV
VgnRQZ9DOcxkZDZ13GdM7dF1iawAqVqMJrQEP6RIXHMANpSeKmwVHu/9im1nmEfw
OJbDagezbjTSguzxvkUsRYtLAtV2eTLBq+kMydXC9AbLcFkAAVZBpMOtGjawltaA
V3plPDG72luSIJn2JAazfDQDiLGF4rHdwx8sPSBUz0NDfU5XXdKBw8S5YbKoOEuC
viF1nsMO13p59s4NJfODsCfpK8A9JS9kWcNJOKqgrYI/3pZmCtEWN7DZLcB36br0
/DjawXiLGYrzYhQ2ca9IoZ3wsqUOQ+dDi3VL/vG4jqHS8j0+XHaoTj1ODol5/k22
TddalrCM/8EwhVLJvl0b
=IqJE
-----END PGP SIGNATURE-----

--uQr8t48UFsdbeI+V--
