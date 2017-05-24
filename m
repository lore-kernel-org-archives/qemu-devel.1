Received: from eggs.gnu.org ([2001:4830:134:3::10]:39444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dDTeZ-00018S-2E
	for qemu-devel@nongnu.org; Wed, 24 May 2017 06:36:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dDTeX-0004SE-Td
	for qemu-devel@nongnu.org; Wed, 24 May 2017 06:36:31 -0400
Date: Wed, 24 May 2017 20:27:47 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170524102747.GA12929@umbus.fritz.box>
References: <20170523111812.13469-1-lvivier@redhat.com>
	<20170523111812.13469-2-lvivier@redhat.com>
	<20170523172842.1fce414e@bahia.ttt.fr.ibm.com>
	<bc9a69f9-eb7b-943a-a9bf-bb4a3b18f525@redhat.com>
	<20170524045236.GU30246@umbus.fritz.box>
	<20170524115513.71a014f2@bahia.ttt.fr.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pWyiEgJYm5f9v55/"
Content-Disposition: inline
In-Reply-To: <20170524115513.71a014f2@bahia.ttt.fr.ibm.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 1/4] spapr: add pre_plug
 function for memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 24, 2017 at 11:55:13AM +0200, Greg Kurz wrote:
1;4601;0c> On Wed, 24 May 2017 14:52:36 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
> [...]
> >=20
> > This patch seems like a good idea regardless of the rest, so I've
> > fixed the minor nits Greg pointed out and merged to ppc-for-2.10.
> >=20
>=20
> David,
>=20
> Commit d2e4c6a1437fab2fbb4553b598f25e282c475199 in your ppc-for-2.10 bran=
ch
> doesn't compile:
>=20
> +static void spapr_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceSta=
te *dev,
> +                                  Error **errp)
> +{
> +    PCDIMMDevice *dimm =3D PC_DIMM(dev);
> +    PCDIMMDeviceClass *ddc =3D PC_DIMM_GET_CLASS(dimm);
> +    MemoryRegion *mr =3D ddc->get_memory_region(dimm);
> +    uint64_t size =3D memory_region_size(mr);
> +    char *mem_dev;
> +
> +    if (size % SPAPR_MEMORY_BLOCK_SIZE) {
> +        error_setg(&local_err, "Hotplugged memory size must be a multipl=
e of "
>=20
> s/&local_err/errp/
>=20
> +                      "%lld MB", SPAPR_MEMORY_BLOCK_SIZE / M_BYTE);
> +        goto out;
>=20
> s/goto out/return/
>=20
> +    }
> +
> +    mem_dev =3D object_property_get_str(OBJECT(dimm), PC_DIMM_MEMDEV_PRO=
P, NULL);
> +    if (mem_dev && !kvmppc_is_mem_backend_page_size_ok(mem_dev)) {
> +        error_setg(errp, "Memory backend has bad page size. "
> +                   "Use 'memory-backend-file' with correct mem-path.");
> +    }
> +}
> +

Sorry, I found and fixed that already, but forgot to push the update.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--pWyiEgJYm5f9v55/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZJWAgAAoJEGw4ysog2bOSyEAP/2B3lafi3pLYVNGm1TB+qpgQ
TmG3ApIsDe0/3pGMCOgCCgk8C+xeJvMOP/ExffVj3hbkjfH1Rl/2tZwbRqkxW+5m
tqM6yT2EIEQuDlzIC1ndXHbUJ30LOSr9SCvZhUwvCoGDgfB/V5r9FMQuEW4wnCeK
WFybGG6ZMZr/zBJ2uJ42LbYbUu06jXOkcQ69pxSDSPIXacqJjBQZQa2rdJKH0wwh
Px6Ydb4+mHAEEzFW6U7Yuf5YFc1e1XAC2QahVN4mwUdssD/nl7Zfyyd5DqBqCCXa
vxZ+SiKTfM+D+/nxvEsIL7KV7oZv/he7TFVqv7gR15VVqRHtAxLemnYhSXeNOtoY
kyoRYKMm1Az+CcLPsLSwpUHYhfaUvv/eZdYu7/hMU057uIwqq8dxpRDeU/1g6uGq
3Xvu4PCkq6wI3EmQ+GSWJWgLAwiuF0USVO5NqJR+SZ06Fi1/z4NDB7n9nWYYMHgA
VlCYEN08IvGFPrqU5yYAWSDmmvbo+SA32njCr0Ka3ZQQr0OwELkOwR5ds93cZhTz
tnX8GBJQIT3+k7i+q/wc4DVKUL3uGeOfFbbRbXvQeMdFjYxiK1Ti2jFdDtB9ESgC
Ej25+rghyoN6ueGXMt+9xj0R+kzWFnI8Ovrq7p03X5yf2AhcO1o2kc3Pfi+hYxwh
ENzazxsA+X6eSiR1yON1
=3Yl0
-----END PGP SIGNATURE-----

--pWyiEgJYm5f9v55/--
