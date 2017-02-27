Received: from eggs.gnu.org ([2001:4830:134:3::10]:48207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ciR4V-0007ga-QO
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 14:35:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ciR4U-0000d4-TC
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 14:34:59 -0500
References: <1488200143-2140-1-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8e3d659d-1619-ce23-e427-7e8b15a9c447@redhat.com>
Date: Mon, 27 Feb 2017 13:34:49 -0600
MIME-Version: 1.0
In-Reply-To: <1488200143-2140-1-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="lrIf9jA0Ia7XWskfr46ahiVf8mqa78qsX"
Subject: Re: [Qemu-devel] [PATCH] option: Tweak invalid size error message
 and unbreak iotest 049
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, thuth@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lrIf9jA0Ia7XWskfr46ahiVf8mqa78qsX
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, thuth@redhat.com, qemu-block@nongnu.org,
 mreitz@redhat.com
Message-ID: <8e3d659d-1619-ce23-e427-7e8b15a9c447@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] option: Tweak invalid size error message and
 unbreak iotest 049
References: <1488200143-2140-1-git-send-email-armbru@redhat.com>
In-Reply-To: <1488200143-2140-1-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/27/2017 06:55 AM, Markus Armbruster wrote:
> Commit 75cdcd1 neglected to update tests/qemu-iotests/049.out, and
> made the error message for negative size worse.  Fix that.
>=20
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  tests/qemu-iotests/049.out | 14 +++++++++-----
>  util/qemu-option.c         |  2 +-

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--lrIf9jA0Ia7XWskfr46ahiVf8mqa78qsX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYtH9ZAAoJEKeha0olJ0NqCCEIAJpZbEIBDT+RN2eS/AOtlNWB
YcboL9pD/sePCYuRYDEikUzY45yRwzzZR8OZ4V0N6qeMQkR8yOLtdZ0od1StZPOp
cn/Qss5hB+J0aUFpiiOMYKRz9gp4uAnak51P49kx6C4LuA0mxcixHfWLREE9hgf1
9dy3R5rQT1HptAa8q9KV3W1Y9B080wDLrLBASPVkmvzYkkt6qZWP55AgVdalQQKr
Ew9jZFOBH0EUwHYDmXNMl10GjKyYoXeiwVuUym8Hg3gXA5wIhvnYJpie5/HaP43o
FkYmpIpUFlduzW+r0LfmmjR49YRG4TQUZfX+ql+0c1M6Z6mOy/kN5xeU3frYdiI=
=0wpS
-----END PGP SIGNATURE-----

--lrIf9jA0Ia7XWskfr46ahiVf8mqa78qsX--
