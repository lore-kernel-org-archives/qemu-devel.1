Received: from eggs.gnu.org ([2001:4830:134:3::10]:36676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXRb6-0000yy-1e
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 08:27:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXRb4-0006ek-Vx
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 08:27:28 -0400
References: <20170718003422.4497-1-jsnow@redhat.com>
	<20170718003422.4497-2-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <042edc3e-2d55-7f06-b389-6d3753bda76b@redhat.com>
Date: Tue, 18 Jul 2017 07:27:14 -0500
MIME-Version: 1.0
In-Reply-To: <20170718003422.4497-2-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="UoPTuuBODO9QOF6ISBPw6BhfbpWu8xEbo"
Subject: Re: [Qemu-devel] [PATCH v5 1/2] blockdev: move BDRV_O_NO_BACKING
 option forward
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UoPTuuBODO9QOF6ISBPw6BhfbpWu8xEbo
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Message-ID: <042edc3e-2d55-7f06-b389-6d3753bda76b@redhat.com>
Subject: Re: [PATCH v5 1/2] blockdev: move BDRV_O_NO_BACKING option forward
References: <20170718003422.4497-1-jsnow@redhat.com>
 <20170718003422.4497-2-jsnow@redhat.com>
In-Reply-To: <20170718003422.4497-2-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/17/2017 07:34 PM, John Snow wrote:
> For both external_snapshot_prepare and qmp_drive_mirror, we eventually
> append the option BDRV_O_NO_BACKING. However, we generally do so after
> we create the image.
>=20
> To accommodate image creation wanting to verify that a backing file
> exists or not, add this option prior to create to override checking
> the existence of the backing file. This prevents QEMU from trying to
> re-open a backing file that's already in use (thanks to qcow2 locking).=

>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  blockdev.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--UoPTuuBODO9QOF6ISBPw6BhfbpWu8xEbo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAllt/qMACgkQp6FrSiUn
Q2rifggAh3T0hGjGE2HRu4nOpVgqFLEOk2LQ4sKeVgmqeSn82M64sJHkfFA41kiC
0utp4T2QtEh2dBXY67ZS2jrA/lrLgvlFqQgQTaiXz7Nhrczgh/JBei2Iu0D52yV1
oBHKv5Kj+ep4oReTld7LcEoI3PJY1cgdxOHnoRVD/aWcaYhkVSU8T111yrHxQpMk
pmiMp251eJ64MyxuyOSiLgXuo/9YrZqo0y0/N+yBvDR6mdcXY5gvd9e/Rh0E6KCW
tgKEUVCcXs4qIiv5JH9YRZpcp6cYZpeRI72n1PXDPz/y4LGBaFPUTYYjpz7g18cr
IrUV1UptwCz7+4BVszDGy3UVf+Cyrw==
=Pxwl
-----END PGP SIGNATURE-----

--UoPTuuBODO9QOF6ISBPw6BhfbpWu8xEbo--
