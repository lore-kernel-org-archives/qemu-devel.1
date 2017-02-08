Received: from eggs.gnu.org ([2001:4830:134:3::10]:36831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cbSUq-0000pO-OB
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 08:41:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cbSUp-0007fL-JC
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 08:41:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43648)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cbSUp-0007f7-BJ
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 08:41:19 -0500
References: <20170206024535.14624.3001.malonedeb@soybean.canonical.com>
	<20170208081618.29788.55361.malone@gac.canonical.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c0117585-f104-14ee-ba85-f2426c1553e0@redhat.com>
Date: Wed, 8 Feb 2017 07:41:16 -0600
MIME-Version: 1.0
In-Reply-To: <20170208081618.29788.55361.malone@gac.canonical.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="JPu7J5kiN5KRGe8lQ4sKSnJGmN2XCObCk"
Subject: Re: [Qemu-devel] [Bug 1662050] Re: qemu-img convert a overlay qcow2
 image into a entire image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1662050 <1662050@bugs.launchpad.net>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JPu7J5kiN5KRGe8lQ4sKSnJGmN2XCObCk
From: Eric Blake <eblake@redhat.com>
To: Bug 1662050 <1662050@bugs.launchpad.net>, qemu-devel@nongnu.org
Message-ID: <c0117585-f104-14ee-ba85-f2426c1553e0@redhat.com>
Subject: Re: [Qemu-devel] [Bug 1662050] Re: qemu-img convert a overlay qcow2
 image into a entire image
References: <20170206024535.14624.3001.malonedeb@soybean.canonical.com>
 <20170208081618.29788.55361.malone@gac.canonical.com>
In-Reply-To: <20170208081618.29788.55361.malone@gac.canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/08/2017 02:16 AM, wayen wrote:
> @Thomas Huth, I just want to reduce the file size of qcow2 overlay imag=
e
> by this conversion.

Are you merely trying to sparsify the file (punch holes on the portion
of the file that is not mapped to disk), so that the apparent file size
is unchanged, but the actual disk usage is minimized? That's probably
already possible (virt-sparsify from libguestfs seems to be able to do
it; look at what steps it uses).

Or are you asking for a way to defragment the file, so that the apparent
size shrinks because all occupied clusters are now contiguous, so that
there are no longer any need for holes?  The end result is the same
amount of disk usage, but right now, the only way to defragment is to
convert from one image to a copy; we don't support in-place
defragmentation yet.  So far, no one has come up with a compelling
reason why it is needed, or a patch to implement it, but there's no
technical reason why it can't be done.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--JPu7J5kiN5KRGe8lQ4sKSnJGmN2XCObCk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYmx/8AAoJEKeha0olJ0Nq6BkH/0t2Iw5HlEHzauv0QFAvZMYg
OFccQAybPwT2PrGhk9/FaEPD3+lfOjAXRl0XTWj929VgLXsH9OfOgAGuGtkstNgC
adTVVs7q2C0XRI+f+fZyYM0zGHMvbbt2uR3c3sqaC9KVY5yYLlnVMci1I0D1a6w8
Sxxl11mkX0kW1uWi2DaQi7+9+Da7fAUnaqL5+UXjiONlOh82gl9aD72sEgP57WaK
ir/mKJ0LEOvYWufFjWnVj+XlA0K1bG5cGsZzwPvReivOptlI9fgiExqOiDUP+ZjA
Cs7H3CZXU6gs9fTJczJPUyQlQ6H3iip+yvjm+fBEeEXdnyb+CYaFXeDmtsD7kvg=
=O2oy
-----END PGP SIGNATURE-----

--JPu7J5kiN5KRGe8lQ4sKSnJGmN2XCObCk--
