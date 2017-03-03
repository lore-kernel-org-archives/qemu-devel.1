Received: from eggs.gnu.org ([2001:4830:134:3::10]:37533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cjteI-0000Y6-DX
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 15:17:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cjteH-0005eb-DS
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 15:17:58 -0500
References: <1488491046-2549-1-git-send-email-armbru@redhat.com>
	<1488491046-2549-10-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4beb50ce-6d43-2a42-edb1-1e317f3d262a@redhat.com>
Date: Fri, 3 Mar 2017 14:17:47 -0600
MIME-Version: 1.0
In-Reply-To: <1488491046-2549-10-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="VtcholdqL91spOvtD26474guFE9eiHAT7"
Subject: Re: [Qemu-devel] [PATCH 09/15] sheepdog: Implement
 bdrv_parse_filename()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mitake.hitoshi@lab.ntt.co.jp, jcody@redhat.com, qemu-block@nongnu.org, namei.unix@gmail.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VtcholdqL91spOvtD26474guFE9eiHAT7
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mitake.hitoshi@lab.ntt.co.jp, jcody@redhat.com,
 qemu-block@nongnu.org, namei.unix@gmail.com
Message-ID: <4beb50ce-6d43-2a42-edb1-1e317f3d262a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 09/15] sheepdog: Implement
 bdrv_parse_filename()
References: <1488491046-2549-1-git-send-email-armbru@redhat.com>
 <1488491046-2549-10-git-send-email-armbru@redhat.com>
In-Reply-To: <1488491046-2549-10-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/02/2017 03:44 PM, Markus Armbruster wrote:
> This permits configuration with driver-specific options in addition to
> pseudo-filename parsed as URI.  For instance,
>=20
>     --drive driver=3Dsheepdog,host=3Dfido,vdi=3Ddolly
>=20
> instead of
>=20
>     --drive driver=3Dsheepdog,file=3Dsheepdog://fido/dolly
>=20
> It's also a first step towards supporting blockdev-add.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  block/sheepdog.c | 233 +++++++++++++++++++++++++++++++++++++++++------=
--------
>  1 file changed, 176 insertions(+), 57 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--VtcholdqL91spOvtD26474guFE9eiHAT7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYuc9rAAoJEKeha0olJ0NqoVYH/26JTsHYAmOEeN4qWjnKj4MU
oZoyy/8pwpvMcMiXkiGG+vwS3dM2YQFRvwfCxqcq26f7/azTm8nmO9IJ7o3/lq/k
CyUfzBP6llHGvZWo10UTO7XpHZUu3DceYVtTA1Q68FgyLfxWXFrAp+zs6hmIoPX4
Tuq2v/mnP1s5skMTmiqk/ft1ixCbBA33qzS7U4yDUbmGmRHbgZUD5JnevOMGpT8V
aofw3me8BFwj+6RrmXUJnkbASF+NSrw0ajHpRLyny4kq4R2pM20RP3tAyIm7LQyN
SXhvRCXBGmEsSVzjd2XeU3ByKdIQCFM0KOAb3qwzIOZjUKImGNuAW2MGupXvnLw=
=mQoK
-----END PGP SIGNATURE-----

--VtcholdqL91spOvtD26474guFE9eiHAT7--
