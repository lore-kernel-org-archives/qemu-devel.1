Received: from eggs.gnu.org ([2001:4830:134:3::10]:50666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dCtlz-0003Lu-Aj
	for qemu-devel@nongnu.org; Mon, 22 May 2017 16:17:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dCtly-0006EH-7F
	for qemu-devel@nongnu.org; Mon, 22 May 2017 16:17:47 -0400
References: <20170522195217.12991-1-mreitz@redhat.com>
	<20170522195217.12991-4-mreitz@redhat.com>
	<8792c1f3-b079-2f0f-bf35-b3f3843da5c7@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <eb9f70e3-5766-60c0-8d8d-6fe76c1f170e@redhat.com>
Date: Mon, 22 May 2017 22:17:34 +0200
MIME-Version: 1.0
In-Reply-To: <8792c1f3-b079-2f0f-bf35-b3f3843da5c7@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="mX0QG0Nx16kUocpR3Thi6tLJKvViE7gmc"
Subject: Re: [Qemu-devel] [PATCH v2 3/3] iotests: Add test for colon handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mX0QG0Nx16kUocpR3Thi6tLJKvViE7gmc
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <eb9f70e3-5766-60c0-8d8d-6fe76c1f170e@redhat.com>
Subject: Re: [PATCH v2 3/3] iotests: Add test for colon handling
References: <20170522195217.12991-1-mreitz@redhat.com>
 <20170522195217.12991-4-mreitz@redhat.com>
 <8792c1f3-b079-2f0f-bf35-b3f3843da5c7@redhat.com>
In-Reply-To: <8792c1f3-b079-2f0f-bf35-b3f3843da5c7@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-05-22 22:06, Eric Blake wrote:
> On 05/22/2017 02:52 PM, Max Reitz wrote:
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  tests/qemu-iotests/126     | 105 ++++++++++++++++++++++++++++++++++++=
+++++++++
>>  tests/qemu-iotests/126.out |  23 ++++++++++
>>  tests/qemu-iotests/group   |   1 +
>>  3 files changed, 129 insertions(+)
>>  create mode 100755 tests/qemu-iotests/126
>>  create mode 100644 tests/qemu-iotests/126.out
>>
>=20
>> +# Note that we could also do the same test with BASE_IMG=3Dfile:image=
:base.$IMGFMT
>> +# -- but behavior for that case is a bit strange. Protocol-prefixed p=
aths are
>> +# in a sense always absolute paths, so such paths will never be combi=
ned with
>> +# the path of the overlay. But since "image:base.$IMGFMT" is actually=
 a
>> +# relative path, it will always be evaluated relative to qemu's CWD (=
but not
>> +# relative to the overlay!). While this is more or less intended, it =
is still
>> +# pretty strange and thus not something that is tested here.
>> +# (The root of the issue is to use a relative path with a protocol pr=
efix. This
>=20
> s/to/the/

Then it will also have to be s/use a/use of a/.

>> +#  may always give you weird results because in one sense, qemu consi=
ders such
>> +#  paths absolute, whereas in another, they are still relative.)
>=20
> Should we tighten qemu to forbid the use of a protocol prefix with a
> non-absolute path?  But that can be a subsequent patch, I don't see it
> as a reason to hold up this one.

Hm. I'd rather not do this. It could be considered a bug fix (and it
would make patch 2 obsolete, so it would definitely have a use there),
but it would break compatibility.

The whole filename handling in qemu is a mess, and that's mostly because
users expect it to be a mess. It would be great if we didn't have to
handle filenames at all, or at least only absolute filenames, but that
would not be something that users like. And having little weird things
like these in some corner cases (it's not like many people are using an
explicit "file:" prefix anyway) is better than not supporting relative
filenames at all...

> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!

Max


--mX0QG0Nx16kUocpR3Thi6tLJKvViE7gmc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZI0deEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQBFG
B/9sYOFdlYWk4Qs9XfyNVxj71HVEVuBYqWBlEntZ2oBZVtQsofhLWrL6NIg4mlZO
YQkoE6LTE+jVx+EcRn4ePr8bKGa/7GoZBbPiULlQWdHb+nB8miycbDCFTBSkXaWW
WdP3NxQCBzqXXrPf5P9x3+mfw0c8OS9tYjXe/R/UowzZ0XXEM6aiNnbHGxmNHkYT
G7v2YaH88uwwWOwC3b0ozSeGHy745H4wiPaFJSM+U9776xeiPYzJctS+PjBuGTWB
bPp9XHLuiyzWvZPbzAvKVZjk2Ok6ouE2ZNu+K9rqiOKtiVJgo652hZCo8oK0M47X
7GNsonWdpUx9drQurQdTcKqz
=HOhG
-----END PGP SIGNATURE-----

--mX0QG0Nx16kUocpR3Thi6tLJKvViE7gmc--
