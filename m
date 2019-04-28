Received: from eggs.gnu.org ([209.51.188.92]:49840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hKjuk-00080S-Tq
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 09:32:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hKjuj-0006bA-3b
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 09:32:18 -0400
References: <dd85fab0-52df-9c2d-e402-28d7ce9867f1@redhat.com>
	<20190426105301.GA20769@localhost.localdomain>
	<eca8f98a-6f39-837a-6d55-606d881c44ed@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <1a0a2413-0858-7722-1a25-cbd36f563af1@redhat.com>
Date: Sun, 28 Apr 2019 15:32:01 +0200
MIME-Version: 1.0
In-Reply-To: <eca8f98a-6f39-837a-6d55-606d881c44ed@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="IOVGY1Kmh5SMMqCSX7Xlfn931guTI8uCo"
Subject: Re: [Qemu-devel] Failing qemu-iotest 005 with raw
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: hch@lst.de, QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IOVGY1Kmh5SMMqCSX7Xlfn931guTI8uCo
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 28/04/2019 04.36, Eric Blake wrote:
> On 4/26/19 5:53 AM, Kevin Wolf wrote:
>=20
>>>  creating large image
>>> +qemu-img: TEST_DIR/t.IMGFMT: The image size is too large for file
>>> format 'IMGFMT'
>>>  Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D5368709120000
>>> [...]
>>>
>>> Could this be fixed somehow, or should the test rather be skipped for=

>>> IMGFMT=3Draw?
>>
>> The test passes for me on XFS. Looks like the raw driver can handle
>> large image files, but your host filesystem can't.
>>
>> We would have to check whether the host filesystem can support large
>> files and skip the test if it can't. I'm not sure how to do that. But
>> actually, this isn't testing anything interesting for raw, so just
>> unconditionally disabling the test for raw could be reasonable enough.=

>=20
> iotest 220 in commit 3b94c343 can serve as such an example (it skips th=
e
> test on at least ext4, while passing on tmpfs which allows larger spars=
e
> files).

That should do the trick, thanks. I'll send a patch.

 Thomas


--IOVGY1Kmh5SMMqCSX7Xlfn931guTI8uCo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJcxatYAAoJEC7Z13T+cC21bTQP/jKQvjGfJv+f5CzVwJtpU6z4
JLPE3kWtNW0QgaFRnuP93gQE53/VldJeB9Hdc7+22Y9Cb1yO8Ps5kcNaa0+Ciflb
4x0vfI890kBv5H0aR5vJLHvSwP4i4l/Nk/lRTYnucK2vEuSbOcJniDeILt4pJEOs
smSjLd0xxLvuxL2kdx05Tvoc34hrc7qiDvdeuet1XtCoQzqjAjDmCJzDAKmvmiDl
ichpbqwyHvHXdD3novPPC+HZcND29GqDj12pgZxlmwU3G2DR/tOUFPt7UqiPP7Hl
SnZfUfB1RLWexxctWZ+2/ICRP3DqhgM7dObxiySB3qBKDBJbmwDIhVofW+1RlnKl
e121CmMF2j9lZOGjmKMTJLVv5wWHzWRjXXeOkBAL/TsSv0t6UzGkQBRJEiNfZh94
G2/OlGDEXnAFkoYRPJm9/1/esYKys3eej/rTr4j94bxB3TElSajASTzgbmvS7D4y
7ehsWz29mWRgqfsORiH6guOeQonfnqOimZ0uLugr6b3+jm36Db3NugJArU797AtX
TdYG5py9VVLeA0/1RbuAICWzNaN0TVjG3r5NCQty6Lss9YdBj8cdm9S4qV3ErCGW
gFv2zc3j8g8GglA2Nj3KponS741BLf8suPv6XYsHTnfymReSKnMd9Zj1VLlMTIuv
yUkjZbuHwP7pLEMsPJSB
=5CK2
-----END PGP SIGNATURE-----

--IOVGY1Kmh5SMMqCSX7Xlfn931guTI8uCo--
