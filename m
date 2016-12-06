Received: from eggs.gnu.org ([2001:4830:134:3::10]:44484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cEO0W-000695-HD
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 17:14:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cEO0V-00038l-Lb
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 17:14:40 -0500
References: <20161202192223.15153-1-eblake@redhat.com>
	<20161202192223.15153-3-eblake@redhat.com>
	<42b3c9e3-7c0d-4ec2-4257-1331f16d2c04@redhat.com>
	<50585dad-8418-f52c-8e19-418d8a064131@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <110c4d8c-c87c-a8b5-04e0-985672e24337@redhat.com>
Date: Tue, 6 Dec 2016 23:14:30 +0100
MIME-Version: 1.0
In-Reply-To: <50585dad-8418-f52c-8e19-418d8a064131@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="LFMUVdOIoB8Mgfo7CORt2f6LnJBWnT3qd"
Subject: Re: [Qemu-devel] [PATCH v3 2/5] blkdebug: Add pass-through
 write_zero and discard support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LFMUVdOIoB8Mgfo7CORt2f6LnJBWnT3qd
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Message-ID: <110c4d8c-c87c-a8b5-04e0-985672e24337@redhat.com>
Subject: Re: [PATCH v3 2/5] blkdebug: Add pass-through write_zero and discard
 support
References: <20161202192223.15153-1-eblake@redhat.com>
 <20161202192223.15153-3-eblake@redhat.com>
 <42b3c9e3-7c0d-4ec2-4257-1331f16d2c04@redhat.com>
 <50585dad-8418-f52c-8e19-418d8a064131@redhat.com>
In-Reply-To: <50585dad-8418-f52c-8e19-418d8a064131@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06.12.2016 23:12, Eric Blake wrote:
> On 12/06/2016 04:00 PM, Max Reitz wrote:
>=20
>>> Tested by setting up an NBD server with export 'foo', then invoking:
>>> $ ./qemu-io
>>> qemu-io> open -o driver=3Dblkdebug blkdebug::nbd://localhost:10809/fo=
o
>=20
> By the way, I'd LOVE to know if there is a way to write a qemu-io
> command line that would do this connection automatically (so that I can=

> batch commands up front and benefit from the shell's history) rather
> than having to issue an 'open' after the fact.  I tried various
> incantations with --object and --image-opts, but got stumped.

Can't you just do qemu-io -c 'open'?

Max


--LFMUVdOIoB8Mgfo7CORt2f6LnJBWnT3qd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlhHOEYSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AKoIH/1Y9TjMHMYmx//SwqY20LgQMcpIaIS6n
eKMlMRiP8E94Q4l5Vx/iMUAf472rWw3UnTtmyMMFuIfwgGnXk6/wHhndDa7oXMGQ
2BzjxEFJQjRkEZIymxTtOqF4T/vdjshsFHXpbWIiF9LPxxZflgz1iiIOpodGc279
JJT49TvE7VarOJQdMMp1BZ1LJPDvpDPLhb8NV+MPefM/mJXlhMFWFD+BJZsr1uO/
I9/I9CGyep6AkmCmplbLdA4MWnh4JLIRv3Al/PyFKLXQ866SU4s9hh8giohxJwMq
3PJJDjm7Eho0U2S0cQuyZ/iYEPLEgrI869mZpDOz1iMJqTpPdc3keLk=
=IrPu
-----END PGP SIGNATURE-----

--LFMUVdOIoB8Mgfo7CORt2f6LnJBWnT3qd--
