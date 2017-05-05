Received: from eggs.gnu.org ([2001:4830:134:3::10]:33812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d6m1o-0002oM-3H
	for qemu-devel@nongnu.org; Fri, 05 May 2017 18:48:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d6m1n-0006NV-3g
	for qemu-devel@nongnu.org; Fri, 05 May 2017 18:48:48 -0400
References: <20170429191419.30051-1-eblake@redhat.com>
	<20170429191419.30051-10-eblake@redhat.com>
	<9ba6f9fa-5ac7-894c-4112-ec0ca36eb82c@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <adebff53-1879-1047-7778-3e05b3426d2b@redhat.com>
Date: Fri, 5 May 2017 17:48:38 -0500
MIME-Version: 1.0
In-Reply-To: <9ba6f9fa-5ac7-894c-4112-ec0ca36eb82c@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="THpNuVmPOtIcTtE1XaDQn3FwJd8IsXXi8"
Subject: Re: [Qemu-devel] [PATCH v11 9/9] tests: Add coverage for recent
 block geometry fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--THpNuVmPOtIcTtE1XaDQn3FwJd8IsXXi8
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Message-ID: <adebff53-1879-1047-7778-3e05b3426d2b@redhat.com>
Subject: Re: [PATCH v11 9/9] tests: Add coverage for recent block geometry
 fixes
References: <20170429191419.30051-1-eblake@redhat.com>
 <20170429191419.30051-10-eblake@redhat.com>
 <9ba6f9fa-5ac7-894c-4112-ec0ca36eb82c@redhat.com>
In-Reply-To: <9ba6f9fa-5ac7-894c-4112-ec0ca36eb82c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/05/2017 05:34 PM, Max Reitz wrote:
> On 29.04.2017 21:14, Eric Blake wrote:
>> Use blkdebug's new geometry constraints to emulate setups that
>> have needed past regression fixes: write zeroes asserting
>> when running through a loopback block device with max-transfer
>> smaller than cluster size, and discard rounding away portions
>> of requests not aligned to preferred boundaries.  Also, add
>> coverage that the block layer is honoring max transfer limits.
>>

>> +function verify_io()
>> +{
>> +    if ($QEMU_IMG info -f "$IMGFMT" "$TEST_IMG" |

>> +
>> +verify_io | $QEMU_IO "$TEST_IMG" | _filter_qemu_io
>=20
> This conflicts with Fam's image locking series that has been introduced=

> in the meantime (and unfortunately I'm the one who has to base his bloc=
k
> queue on Kevin's...). I suppose it's because the qemu_io process is
> launched before the qemu_img info process.

Indeed. My test was heavily modeled after 046; there, our solution
(currently commit 64ace79 on Kevin's tree) was to add -U, not -r.

>=20
> Simply adding an -r to the qemu_io command fixes this, however. I'll do=

> so in my branch, assuming you're OK with that. :-)

I'd lean towards -U, but yes, I'm fine if you make whatever one-line
tweak is needed to obey the rules.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--THpNuVmPOtIcTtE1XaDQn3FwJd8IsXXi8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZDQFGAAoJEKeha0olJ0NqYPAH/i595He/DK0mBapT2njYvA0u
BpIGzzvXOP8wVtbJ6PFxjz/rt8sEyxHH5k9QIX+HVB1fL6iSlnZwDKPoBrj3h1Vz
84YlfSpW5pBYpJns8Jih5tsoHnTvYYdgawtRfkOMefFu7tKXnpn7Vi2xRQTD+nxk
uq+g2NhhLhgZHp0y3DQd2UslFnvVE4N4M3N+tWoFyMXhszAH2VBkcsOIsotbUiqS
FywhlxoVWGGM6BKlaswg+Hn8qkTU6/ocU0im6ENx8jz0TmIhDc13+t1mzDpoPPzd
iwAHp7q9AgFMT3cIU1ViZg+kIK+gaHrccdRQyBPnwJMYYBSUSb5XmZEngJVggAQ=
=ONve
-----END PGP SIGNATURE-----

--THpNuVmPOtIcTtE1XaDQn3FwJd8IsXXi8--
