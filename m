Received: from eggs.gnu.org ([2001:4830:134:3::10]:40215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ckz0U-0003U3-Mx
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 15:13:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ckz0T-00012s-Hp
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 15:13:22 -0500
References: <1488817322-11397-1-git-send-email-kwolf@redhat.com>
	<1488817322-11397-4-git-send-email-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0e51c7fa-cacd-e4e8-1c5f-5b24da13f028@redhat.com>
Date: Mon, 6 Mar 2017 14:13:13 -0600
MIME-Version: 1.0
In-Reply-To: <1488817322-11397-4-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="PqaB9o7NtopBBexcRH4K0UksAXoRDt1mu"
Subject: Re: [Qemu-devel] [PATCH 03/10] mirror: Fix permissions for removing
 mirror_top_bs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PqaB9o7NtopBBexcRH4K0UksAXoRDt1mu
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Message-ID: <0e51c7fa-cacd-e4e8-1c5f-5b24da13f028@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 03/10] mirror: Fix permissions for removing
 mirror_top_bs
References: <1488817322-11397-1-git-send-email-kwolf@redhat.com>
 <1488817322-11397-4-git-send-email-kwolf@redhat.com>
In-Reply-To: <1488817322-11397-4-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/06/2017 10:21 AM, Kevin Wolf wrote:
> mirror_top_bs takes write permissions on its backing file, which can
> make it impossible to attach that backing file node to another parent.
> However, this is exactly what needs to be done in order to remove
> mirror_top_bs from the backing chain. So give up the write permission
> first.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/mirror.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--PqaB9o7NtopBBexcRH4K0UksAXoRDt1mu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYvcLZAAoJEKeha0olJ0Nq5ncH/jA68ilrGbwWFwd7mqbuZbx6
ZRhueM8wF/HYfVTTOc4iakUtTH8UsnSMTjEd+sbG2Z154+RtLqRNPdi6LRHLPYh1
U9VEkLaEKezpMfTwWuns/e8lQm7hud+RAKOkyiw4HgPDoCSZ+jzw/kd5BaYsssIZ
7Soy1FzYVIcRQq9TEWYPmxyDpckPeAC1PXeDSboes1Lz81D/i4l33efqb7eFZdJz
vdmzPJDBHsdhZO8R8DJzvjbFP85Ve/3LH4RsxHX9h13zwbFHmtCecNcIj28Z3nw2
FQOH0fQDV1z+Hrv4HlSx7bIzj4gkhC16/phO0GZuYeMwtAqnGck97A3g8CjRxJ4=
=EmhW
-----END PGP SIGNATURE-----

--PqaB9o7NtopBBexcRH4K0UksAXoRDt1mu--
