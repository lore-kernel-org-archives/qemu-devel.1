Received: from eggs.gnu.org ([2001:4830:134:3::10]:52069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cYgzs-000755-M9
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 17:33:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cYgzr-0005l9-U8
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 17:33:56 -0500
References: <cover.1485878688.git.berto@igalia.com>
	<79f66648c685929a144396bda24d13a207131dcf.1485878688.git.berto@igalia.com>
	<f9e9efcc-2a59-db47-a048-763eed52d92f@redhat.com>
	<w51efzjnq49.fsf@maestria.local.igalia.com>
	<b64ed84b-ecb9-ad76-28d5-7b5d2d235f7d@redhat.com>
	<w5160kvgkw0.fsf@maestria.local.igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <c60d79b0-2b82-2252-c861-f682fe3dcb5f@redhat.com>
Date: Tue, 31 Jan 2017 23:33:47 +0100
MIME-Version: 1.0
In-Reply-To: <w5160kvgkw0.fsf@maestria.local.igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="uxijD1bVpUm55I64slwTi3gQvK8H7Uiho"
Subject: Re: [Qemu-devel] [PATCH 1/2] qemu-io: don't allow I/O operations
 larger than INT_MAX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uxijD1bVpUm55I64slwTi3gQvK8H7Uiho
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, Eric Blake <eblake@redhat.com>,
 qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Message-ID: <c60d79b0-2b82-2252-c861-f682fe3dcb5f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] qemu-io: don't allow I/O operations
 larger than INT_MAX
References: <cover.1485878688.git.berto@igalia.com>
 <79f66648c685929a144396bda24d13a207131dcf.1485878688.git.berto@igalia.com>
 <f9e9efcc-2a59-db47-a048-763eed52d92f@redhat.com>
 <w51efzjnq49.fsf@maestria.local.igalia.com>
 <b64ed84b-ecb9-ad76-28d5-7b5d2d235f7d@redhat.com>
 <w5160kvgkw0.fsf@maestria.local.igalia.com>
In-Reply-To: <w5160kvgkw0.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 31.01.2017 19:11, Alberto Garcia wrote:
> On Tue 31 Jan 2017 05:41:23 PM CET, Eric Blake <eblake@redhat.com> wrot=
e:
>=20
>>>> Ideally, it would be nice to fix the block layer to allow larger
>>>> requests (since we already have code to auto-fragment down to device=

>>>> limits, we should be able to rely on that code instead of having to
>>>> duplicate artificial constraints everywhere else in the tree).  But
>>>> that's a bigger task, and this is a good patch in the interim.
>>>
>>> Related question: what's the largest request than a guest can
>>> theoretically submit?
>>
>> off_t supports up to 2^63 (not 2^64, because it is a signed type).
>> Ideally, we should be constrained only by the disk size (as no one
>> actually has 2^63 bytes of storage available), by using uint64_t
>> offset AND length in all our APIs; but right now, we still have a lot
>> of 32-bit length issues, and often signed length limiting us to 2^31
>> depending on the API.
>=20
> My question was more like: what happens if the guest submits a request
> with the maximum possible size? Does QEMU handle that correctly?

As far as I'm aware we rely on the device emulation code to split the
request.

Max


--uxijD1bVpUm55I64slwTi3gQvK8H7Uiho
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliREMsSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AtU8IAKdLLgdVasZ6K3B46YXbNppPMlB9aIMW
QrZ3bvZWTCPr+cUYfCUsg3mI6dV10yC6A0SR3YHe4KNq3xb/HYdwj93cNfRxHJ0i
edWoi+ZPO91k/SEgE3IlkqhiT6fgf7IJPkS9sn6V+I3m4vBQz6nLOoPmEpmHx031
tbs6zSVJiQ9xV30NDt2oYtUOkANODMhjsoby9pnUGzWIqV2ukSoTBN5SRvsafwFW
B1zCXr70c18++B0B73E9yGPi8SeQu5MhTp2k5BHGC9pXSkCzy4uYUn4LTWLkFywF
OfUh/oKwNB/BDQdLy3Uoks519+qfhIEf8aBJwMUMobRRW1lBubIurcE=
=f+f9
-----END PGP SIGNATURE-----

--uxijD1bVpUm55I64slwTi3gQvK8H7Uiho--
