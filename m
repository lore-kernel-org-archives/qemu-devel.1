Received: from eggs.gnu.org ([209.51.188.92]:51013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h1XxX-0004Lp-Ac
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 09:55:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h1XxW-0008JK-Eu
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 09:55:51 -0500
Date: Wed, 6 Mar 2019 15:55:31 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190306145531.GJ6818@localhost.localdomain>
References: <20190305182908.13557-1-eblake@redhat.com>
	<w51imww5f5f.fsf@maestria.local.igalia.com>
	<9128e864-46d9-66d9-dc86-def77d09bae3@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline
In-Reply-To: <9128e864-46d9-66d9-dc86-def77d09bae3@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] iotests: Wait for qemu to end in 223
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 06.03.2019 um 14:04 hat Eric Blake geschrieben:
> On 3/6/19 7:03 AM, Alberto Garcia wrote:
> > On Tue 05 Mar 2019 07:29:08 PM CET, Eric Blake wrote:
> >> When iotest 223 was first written, it didn't matter if we waited for
> >> the qemu process to clean up. But with the introduction of a later
> >> qemu-nbd process trying to reuse the same file, there is a race where
> >> even though the asynchronous qemu process has responded to "quit", it
> >> has not yet had time to unlock the file and exit, resulting in:
> >>
> >> -[{ "start": 0, "length": 65536, "depth": 0, "zero": false, "data": fa=
lse},
> >> -{ "start": 65536, "length": 2031616, "depth": 0, "zero": false, "data=
": true},
> >> -{ "start": 2097152, "length": 2097152, "depth": 0, "zero": false, "da=
ta": false}]
> >> +qemu-nbd: Failed to blk_new_open 'tests/qemu-iotests/scratch/t.qcow2'=
: Failed to get shared "write" lock
> >> +Is another process using the image [tests/qemu-iotests/scratch/t.qcow=
2]?
> >> +qemu-img: Could not open 'driver=3Dnbd,server.type=3Dunix,server.path=
=3Dtests/qemu-iotests/scratch/qemu-nbd.sock,x-dirty-bitmap=3Dqemu:dirty-bit=
map:b': Failed to connect socket tests/qemu-iotests/scratch/qemu-nbd.sock: =
Connection refused
> >> +./common.nbd: line 33: kill: (11122) - No such process
> >>
> >> Fixes: ddd09448
> >> Reported-by: Alberto Garcia <berto@igalia.com>
> >> Signed-off-by: Eric Blake <eblake@redhat.com>
> >=20
> > Tested-by: Alberto Garcia <berto@igalia.com>
>=20
> Thanks; will queue through my NBD tree this week.

Ah, if it doesn't go through my tree, you get my explicit:

Reviewed-by: Kevin Wolf <kwolf@redhat.com>

--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcf99jAAoJEH8JsnLIjy/WjZQP/jhLIam+tE02vEw/SfbIcL1q
dnQpM2QiN9w84Ahw+YJZmvi4L7pEdZIXIWfm8GKtcwepDyWwKv+Igs5EihpE+xV6
dvjCJOaDvkIigpawHStTeKLcqOx5VJ19lE+zJ/5YDpQv6eghvqmxbO3vHu8d0eyp
93POVbH+tJQvxaR5tB/ZsJh2gBixyzcxHhuTVwjAijAPqtoyLmOqxaZ8jV/+to4I
n95hzjA7+Ukw6QUfoBFvvycayWjeTmPQLStNa9JfOkUx3SLurf2lKQe9IVoPRy7n
rf7GAFy7TdP/Mo6rA2g1rsUJvPf+O3ipF8MzCbCLb2le5OLYvfa4ID4zplBDkbT5
MH+/7LiVuvI8Sk4CzwfYRwMBR8pq3vB1j1TLGOEw42GyY9si+n7gd4/o58QujFPh
X84DaQL0d6pyjPZpUgCMbbz1qZ1B+OX3A0HOhzpQNMnPTSIpaEXlmYsiMok1UBZk
l1wsF4aghja+PnBzAMo2w9oYCuX8hB7zM6Iyfcn+j1ygoIM5JslhH1XXMHWWc7Rj
ZFcSZm7nBbnpKfEddHg2h074fwU1e+n4io2qO2lz0CA8wLI6do+NVN86PffedXVu
4u8ev6YD8n9twoWy24nqt4cLa5w4ssNZC1x0eCdWcmbUcciXsX8dC6jDW3VXkYU6
YFJtYBrkMv4i4sVY0Upr
=YV1J
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--
