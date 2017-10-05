Received: from eggs.gnu.org ([2001:4830:134:3::10]:46777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e090r-00066y-VF
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 12:28:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e090r-0006Xm-6c
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 12:28:41 -0400
Date: Thu, 5 Oct 2017 18:28:33 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171005162833.GC4416@localhost.localdomain>
References: <20170925122808.14561-1-kwolf@redhat.com>
	<20170925122808.14561-5-kwolf@redhat.com>
	<c58176c1-09c7-fa47-baec-ce287bca1264@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Content-Disposition: inline
In-Reply-To: <c58176c1-09c7-fa47-baec-ce287bca1264@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 4/5] qemu-iotests: Test commit block job
 where top has two parents
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, qemu-devel@nongnu.org


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 25.09.2017 um 22:19 hat Eric Blake geschrieben:
> On 09/25/2017 07:28 AM, Kevin Wolf wrote:
> > +                        "data": {
> > +                            "compat": "1.1",
>=20
> You should make the test specifically exclude compat=3D0.10 images, or
> else have further filtering in place if we can still support this on old
> images.

Squashed in a line to this effect:

    _unsupported_imgopts compat=3D0.10

And applied the series to the block branch.

Kevin

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJZ1l2xAAoJEH8JsnLIjy/W7iYP/R4tvD1MyusLo0FcA1l8YoGs
Du/5NWXx1aZId1Cy2yt7x4BOiL2RSQOAXXo+ourobJMog56vCiPU9RGvOfM1MxB+
mG6oszocNflp/NjVABdei/YJQOtrZs+2Sny0fAbwjfcf1WRLiVvpfXNWhtB0si/O
PPZk6wrQbBkfFhoy2OtwFHUP9gIQ/yCQiA4qhrB+m/iZQy0sHu0JbB1mCJYXran/
fxhmNJRT7BWkLSkN3JIALRe53syk1cNzqar6aBNsgDhAm/x6OFfh+JhsmD599a1t
6iV1e4nkf2n9J4KZszxl+HCIjz6dhrD39NOcnap3fmVBxEoYnKKl2afpaInjATAa
JHKw9uFoqgrGcdtHS8rJJ11XdRH4OzF2BTiEqbHPQZ8+tIGYgyVl4dutLbCRRF7a
6auIEgACZdDufE72D94/2S69zk+vfgI2NAAy9/XZ+bYKxDeovzIeroLfLRVZVxph
tdXIyT+VZfP4UAUtcPQH9yZgopf/OQrEnNE5G5Tcc7YMvFp/Uw22SqHz8dzb8Yze
SIbQ0veyNWqh/954bJW/9p3WrA3N+/HssMLitlgg+5Oxggc5ZNrsxOwCOgDuxhDO
Rav8MiMmqI10WUn8k6k9qaFeX+m7N+eOslNQdHbEFwZvGBi/19IVec/+kDbcGl9e
CYjkBdGj478KOo8ZrcEE
=b2V0
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--
