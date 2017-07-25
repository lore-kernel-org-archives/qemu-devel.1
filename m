Received: from eggs.gnu.org ([2001:4830:134:3::10]:42527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1da6x5-0007UQ-JM
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 17:01:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1da6x4-00067L-J9
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 17:01:11 -0400
References: <1500993699-19299-1-git-send-email-pl@kamp.de>
	<1500993699-19299-2-git-send-email-pl@kamp.de>
	<e4639625-7674-dfa8-8597-3e142b9931a0@redhat.com>
	<8f1f2bd2-4509-e603-218d-942859d6316f@kamp.de>
From: Eric Blake <eblake@redhat.com>
Message-ID: <89ad7fdf-b6fe-cd96-10e4-7384cdcb1c77@redhat.com>
Date: Tue, 25 Jul 2017 16:01:04 -0500
MIME-Version: 1.0
In-Reply-To: <8f1f2bd2-4509-e603-218d-942859d6316f@kamp.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ng3dEM8mNRa9VkOTiuX76sElc2B0cJBNw"
Subject: Re: [Qemu-devel] [PATCH V5 01/10] specs/qcow2: add compress format
 extension
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, lersek@redhat.com, den@openvz.org, mreitz@redhat.com, berrange@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ng3dEM8mNRa9VkOTiuX76sElc2B0cJBNw
From: Eric Blake <eblake@redhat.com>
To: Peter Lieven <pl@kamp.de>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, lersek@redhat.com,
 den@openvz.org, mreitz@redhat.com, berrange@redhat.com
Message-ID: <89ad7fdf-b6fe-cd96-10e4-7384cdcb1c77@redhat.com>
Subject: Re: [PATCH V5 01/10] specs/qcow2: add compress format extension
References: <1500993699-19299-1-git-send-email-pl@kamp.de>
 <1500993699-19299-2-git-send-email-pl@kamp.de>
 <e4639625-7674-dfa8-8597-3e142b9931a0@redhat.com>
 <8f1f2bd2-4509-e603-218d-942859d6316f@kamp.de>
In-Reply-To: <8f1f2bd2-4509-e603-218d-942859d6316f@kamp.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/25/2017 03:29 PM, Peter Lieven wrote:

>>> +                   deflate: Standard zlib deflate compression withou=
t
>>> +                            compression header
>> Why did you name it "deflate" instead of "zlib" again?
>=20
> zlib provides raw deflate encoding and gzip encoding both with and with=
out header afaik.
> We use raw deflate encoding without header in QEMU. And the name of the=
 algorithm is deflate.
> I found it more appropriate than zlib.

Okay, I can live with that.

>=20
>>
>>> +
>>> +              14:  compress_level (uint8_t)
>>> +
>>> +                   0 =3D default compress level (valid for all forma=
ts, default)
>>> +
>>> +                   Additional valid compression levels for deflate c=
ompression:
>>> +
>>> +                   All values between 1 and 9. 1 gives best speed, 9=
 gives best
>>> +                   compression. The default compression level is def=
ined by zlib
>>> +                   and currently defaults to 6.
>>> +
>>> +              15:  compress_window_size (uint8_t)
>>> +
>>> +                   Window or dictionary size used by the compression=
 format.
>>> +                   Currently only used by the deflate compression al=
gorithm.
>> What must this be set to for other algorithms?  I guess we get to that=

>> in later patches.
>=20
> Its only used by the deflate algorithm. At this point we only have that=
 algorithm.
> lzo has no such encoding. If we add e.g. lzma it has a dictionary size =
which is
> a power of two (typcial value would be 2^20).

So for lzo, we should document that the field must be 0 (when we get to
adding it).

>=20
> Can you also have a look at the remainder of the series?

It's on my list for 2.11 reviews, although 2.10 freeze stuff is taking
priority, so it may be a few days yet.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--ng3dEM8mNRa9VkOTiuX76sElc2B0cJBNw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll3sZAACgkQp6FrSiUn
Q2q7SQf/U3hfdMRIlg4Yw0+KNuRJNhTQ1/4FNGEJk5I/isO6iOEHQoPJZByxLpeo
ODgk93i0CnSSEUMCQcJgCxjDUOEnm9lPCaI+LlSV0NtzlKeTabirPp1RdHdNpnjn
TGN/PfqIRj5RG1zx7SVO3gUqE0+YKROqtz2qFjGZhwe6AiYdYwWNUUabYYpEJ2qu
KeimI9bosEnOtj+eZ0aibnIF9n4pE3M4okbdaUxWmco+9Sc8PY7TA0Cq/K/qszdo
XPNWsbO/KhpB8PtoM0A2sPkgpTkHzR9+SuGBPlJg81oixrotHAF8EoWfXcY2NxQS
UOLZOJYONGnJfasyWds/TD9Haoge7Q==
=KQpe
-----END PGP SIGNATURE-----

--ng3dEM8mNRa9VkOTiuX76sElc2B0cJBNw--
