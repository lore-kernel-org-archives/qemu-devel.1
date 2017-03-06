Received: from eggs.gnu.org ([2001:4830:134:3::10]:37502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ckypR-0000Iu-9b
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 15:01:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ckypQ-000612-03
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 15:01:57 -0500
References: <1488817322-11397-1-git-send-email-kwolf@redhat.com>
	<1488817322-11397-3-git-send-email-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a8ae7181-5420-c13b-573f-f912510ced1a@redhat.com>
Date: Mon, 6 Mar 2017 14:01:47 -0600
MIME-Version: 1.0
In-Reply-To: <1488817322-11397-3-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="chl2EEVQXJopOVvDbqh1DSqwi2mIe96Xa"
Subject: Re: [Qemu-devel] [PATCH 02/10] mirror: Fix permission problem with
 'replaces'
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
--chl2EEVQXJopOVvDbqh1DSqwi2mIe96Xa
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Message-ID: <a8ae7181-5420-c13b-573f-f912510ced1a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 02/10] mirror: Fix permission problem with
 'replaces'
References: <1488817322-11397-1-git-send-email-kwolf@redhat.com>
 <1488817322-11397-3-git-send-email-kwolf@redhat.com>
In-Reply-To: <1488817322-11397-3-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/06/2017 10:21 AM, Kevin Wolf wrote:
> The 'replaces' option of drive-mirror can be used to mirror a Quorum
> node to a new image and then let the target image replace one of the
> Quorum children. In order for this graph modification to succeed, the
> mirror job needs to lift its restrictions on the target node first
> before actually replacing the child.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/mirror.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--chl2EEVQXJopOVvDbqh1DSqwi2mIe96Xa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYvcArAAoJEKeha0olJ0NqCNIIAIQ/Bvk/t4jX8KaVr3TTpeX3
xT6pO1JBo7arSIoiuVAaxY0TxBcY0SQUD5hEplzYHUI40jTMfDCgUpNacgZYHjyv
TrDtJvgSfDBmXAaR7rnGZLz1VQPu3QeBIU3MBBrERKaW54EHy3KUSQiO1uREbUyq
YV9WGz2gPnnkvrAmA5GEsQhSCg+g6kwkojgMC2PH9WP7AzsXElFDOIKtVaR1My5f
sjk2YfH4PkWF5ptMmB/8qUq/iMdFcXaoMlkHaHoD3jODhNdvyMzLDAx5SptgZx8c
+rln6ygF1vu3W6VPRuThCcliDYAsl3HA2u9YfNqHRZ0nR6cpVi35irIcgeYc+K0=
=Q6OH
-----END PGP SIGNATURE-----

--chl2EEVQXJopOVvDbqh1DSqwi2mIe96Xa--
