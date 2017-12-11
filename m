Received: from eggs.gnu.org ([2001:4830:134:3::10]:42771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eORhk-0007sk-Bh
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 12:17:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eORhj-0005dy-F8
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 12:17:24 -0500
References: <20171123020832.8165-1-mreitz@redhat.com>
	<20171123020832.8165-9-mreitz@redhat.com>
	<20171130031803.GL16237@lemon>
	<105361ec-21d2-e0dc-d480-ef3c9910dd12@redhat.com>
	<a514dad6-3d29-4a45-025e-ecd2f940747d@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <d9365491-7cb8-2349-f068-35da000ea0bd@redhat.com>
Date: Mon, 11 Dec 2017 18:17:08 +0100
MIME-Version: 1.0
In-Reply-To: <a514dad6-3d29-4a45-025e-ecd2f940747d@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Buggo3sHQDnCQWfXvg4TchPCCGqktDMi9"
Subject: Re: [Qemu-devel] [PATCH 08/17] iotests: Skip 103 for refcount_bits=1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, Fam Zheng <famz@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Buggo3sHQDnCQWfXvg4TchPCCGqktDMi9
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, Fam Zheng <famz@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Message-ID: <d9365491-7cb8-2349-f068-35da000ea0bd@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 08/17] iotests: Skip 103 for refcount_bits=1
References: <20171123020832.8165-1-mreitz@redhat.com>
 <20171123020832.8165-9-mreitz@redhat.com> <20171130031803.GL16237@lemon>
 <105361ec-21d2-e0dc-d480-ef3c9910dd12@redhat.com>
 <a514dad6-3d29-4a45-025e-ecd2f940747d@redhat.com>
In-Reply-To: <a514dad6-3d29-4a45-025e-ecd2f940747d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-12-09 02:36, John Snow wrote:
>=20
>=20
> On 11/30/2017 08:23 AM, Max Reitz wrote:
>> On 2017-11-30 04:18, Fam Zheng wrote:
>>> On Thu, 11/23 03:08, Max Reitz wrote:
>>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>>> ---
>>>>  tests/qemu-iotests/103 | 2 ++
>>>>  1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/tests/qemu-iotests/103 b/tests/qemu-iotests/103
>>>> index ecbd8ebd71..d0cfab8844 100755
>>>> --- a/tests/qemu-iotests/103
>>>> +++ b/tests/qemu-iotests/103
>>>> @@ -40,6 +40,8 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>>>>  _supported_fmt qcow2
>>>>  _supported_proto file nfs
>>>>  _supported_os Linux
>>>> +# Internal snapshots are (currently) impossible with refcount_bits=3D=
1
>>>> +_unsupported_imgopts 'refcount_bits=3D1[^0-9]'
>>>
>>> What is the "[^0-9]" part for?
>>
>> It's so you can specify refcount_bits=3D16, but not
>> refcount_bits=3D1,compat=3D0.10 or just refcount_bits=3D1.
>>
>> Max
>>
>=20
> Worth a comment?

There is a comment above it that says that refcount_bits=3D1 is the
disallowed option. :-)

I could add a "(refcount_bits=3D16 is OK, though)" if that would have bee=
n
enough for you (or any proposal of yours).

Max


--Buggo3sHQDnCQWfXvg4TchPCCGqktDMi9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlouvZQSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AdsgH/R2oab3ntLBHymcldnTRgsyv5VLIgZvl
UkVfD/jx7XKAhEik64ogPtLhMI4+n9qFs88JrSpWTin0rjfQRYl3HPgpaJkThuEQ
jic40m9Leu3WFk/YJNPbq0vsqwhXZ07hiFAAZmrF9/t3SKywG311REvZuOBvkmPV
fs5c+C2PduRQEf6u1mfh4YwfHBjOXAtjEDhmdLAUiY+FKiPq6NdoHTbuicFebFSZ
YEj3H4+QdBbSj40Adum/pyqhShEbKDkQ47i9U667B6nqV5JpeKjIHRyeMO0oF5f7
+ksZrR62iqBOI7eL27nvs+KkP8UeSTtOq/HFbcJqby60895wCC8ylqA=
=FDlF
-----END PGP SIGNATURE-----

--Buggo3sHQDnCQWfXvg4TchPCCGqktDMi9--
