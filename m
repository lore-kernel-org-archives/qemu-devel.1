Received: from eggs.gnu.org ([2001:4830:134:3::10]:47120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYGEe-0005GH-Dq
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 14:31:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYGEd-0005Je-Gn
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 14:31:40 -0400
References: <1500560441-5670-1-git-send-email-pl@kamp.de>
	<1500560441-5670-2-git-send-email-pl@kamp.de>
	<72303744-31bc-1c28-2d34-5926975b0b2d@redhat.com>
	<2177e9ee-73c6-cc7d-76a4-e56749be5815@kamp.de>
From: Eric Blake <eblake@redhat.com>
Message-ID: <79e8a12e-8446-9031-46bb-0df32e2c22af@redhat.com>
Date: Thu, 20 Jul 2017 13:31:27 -0500
MIME-Version: 1.0
In-Reply-To: <2177e9ee-73c6-cc7d-76a4-e56749be5815@kamp.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="xeSmbWTFgJ8gNKXKLVSN44mGo4lf3OvJ9"
Subject: Re: [Qemu-devel] [PATCH V4 01/10] specs/qcow2: add compress format
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
--xeSmbWTFgJ8gNKXKLVSN44mGo4lf3OvJ9
From: Eric Blake <eblake@redhat.com>
To: Peter Lieven <pl@kamp.de>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, lersek@redhat.com,
 den@openvz.org, mreitz@redhat.com, berrange@redhat.com
Message-ID: <79e8a12e-8446-9031-46bb-0df32e2c22af@redhat.com>
Subject: Re: [PATCH V4 01/10] specs/qcow2: add compress format extension
References: <1500560441-5670-1-git-send-email-pl@kamp.de>
 <1500560441-5670-2-git-send-email-pl@kamp.de>
 <72303744-31bc-1c28-2d34-5926975b0b2d@redhat.com>
 <2177e9ee-73c6-cc7d-76a4-e56749be5815@kamp.de>
In-Reply-To: <2177e9ee-73c6-cc7d-76a4-e56749be5815@kamp.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/20/2017 11:26 AM, Peter Lieven wrote:
>> I haven't yet checked your code implementation to see where you are
>> setting window sizes, to know if window size is something that should =
be
>> a tunable in the file format.
>>
> You don't have to know the window size that was used. The docs of zlib
>=20
> just say, that the windowSize specified at inflate must be greater or e=
qual
>=20
> to the one used at deflate. So if we change the code to use 15 we can s=
afely
>=20
> decompress old clusters that where compressed with 12.

Then you DO have to know the window size.  If I write my own qcow2
parser, and don't know what size you picked on compression, then how do
I know that the size I pick is >=3D your size during my decompression?

Even if you DON'T want size to be a tunable (and I'm on the fence on
that one), you STILL need the spec to state that for maximum
compatibility, when the incompatible feature is off, implementations
MUST use window size 12 for compression; and that when the compression
extension is used, implementations MUST use window size 15.

Or, by having window size be a tunable in the extension header allows
implementations to record window size, then you allow implemenations to
explicitly KNOW what window size they must meet or exceed.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--xeSmbWTFgJ8gNKXKLVSN44mGo4lf3OvJ9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAllw9v8ACgkQp6FrSiUn
Q2pXeQf+Iot3N9Z5ipuAVeAoYvtxdPT32GdWG8lmTdxrYRbJIV7TFChFwp9jfKek
Nw2tsK9YYczh5KS43r8EQ35D+/yw4Sqai4Xm8pE2MxQogZ+ooMW9TndYAakcBZSo
K0Q23TjAaD+N1JiE9mNq4NmsOkLI5lfPOnTJ5HjxYML8R6MNhRyQsqtRu1dpXdB0
5qSgQr86NGuEO5oHGAHTl6dY9GnfmBWGnOcmj3zjaH6iQxdjRcxCvLL0uwBBjzZS
FtkHsdL3PQxJC0b34wuF5rJro4ogKrcfygEo38ZzreC+v5t4rNk325wgLGOMzBIc
A+KzLwUUA0MCq6V4wIfkxUQgp5wcJw==
=DABz
-----END PGP SIGNATURE-----

--xeSmbWTFgJ8gNKXKLVSN44mGo4lf3OvJ9--
