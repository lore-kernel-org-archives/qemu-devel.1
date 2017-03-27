Received: from eggs.gnu.org ([2001:4830:134:3::10]:42771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1csXuy-0008JS-J7
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 12:54:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1csXux-0002R6-LA
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 12:54:56 -0400
References: <20170327165005.22038-1-stefanha@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3aa0768c-8378-99b3-2c2c-1188773a3a3b@redhat.com>
Date: Mon, 27 Mar 2017 11:54:42 -0500
MIME-Version: 1.0
In-Reply-To: <20170327165005.22038-1-stefanha@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="qV6vq7Fi9CMJIoMwXhdDfPx3RKKffmpvg"
Subject: Re: [Qemu-devel] [PATCH] iscsi: drop unused IscsiAIOCB.qiov field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>, qemu-block@nongnu.org, qemu-trivial@nongnu.org, Peter Lieven <pl@kamp.de>, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qV6vq7Fi9CMJIoMwXhdDfPx3RKKffmpvg
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>, qemu-block@nongnu.org,
 qemu-trivial@nongnu.org, Peter Lieven <pl@kamp.de>,
 Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3aa0768c-8378-99b3-2c2c-1188773a3a3b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] iscsi: drop unused IscsiAIOCB.qiov field
References: <20170327165005.22038-1-stefanha@redhat.com>
In-Reply-To: <20170327165005.22038-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/27/2017 11:50 AM, Stefan Hajnoczi wrote:
> The IscsiAIOCB.qiov field has been unused since commit
> 063c3378a9e3c25cc0afac3c72e4823d0621e352 ("block/iscsi: introduce
> bdrv_co_{readv, writev, flush_to_disk}") back in 2013.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  block/iscsi.c | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/block/iscsi.c b/block/iscsi.c
> index 75d8905..716e74a 100644
> --- a/block/iscsi.c
> +++ b/block/iscsi.c
> @@ -103,7 +103,6 @@ typedef struct IscsiTask {
> =20
>  typedef struct IscsiAIOCB {
>      BlockAIOCB common;
> -    QEMUIOVector *qiov;
>      QEMUBH *bh;
>      IscsiLun *iscsilun;
>      struct scsi_task *task;
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--qV6vq7Fi9CMJIoMwXhdDfPx3RKKffmpvg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY2UPSAAoJEKeha0olJ0NqR0UIAIqvvhKMxzh3ewbNbQS21EFe
4XiFXrT+YOOBN4V2FUY33aRUyjNJsSWrzCKAgDVHPxvgb+t6U95bnSSYPOYsSzZr
q2prKmFv/OK+l+CKXaHKukZFPEbtRGCMP9qocOUI4bijqsDXy0awvmy23UauU+zq
9Hf9h6qW2iYfcVco0HERTt0n6C/8/vk5w/ebucE4k+uDOSgDWrFkhRgnjDSPNZjC
hoWaqmFOTvaAjhKvkAvUcYDzIeYMPqgZaRLeLJUQD0WZc2tsr9/kNT6UvkIDl6bE
YtRIwj+hmsCrADyqX3esCa6lZQyyGMGJdm0lV5oT5K9sUACZyUs/yEHgMugmEZY=
=RWpf
-----END PGP SIGNATURE-----

--qV6vq7Fi9CMJIoMwXhdDfPx3RKKffmpvg--
