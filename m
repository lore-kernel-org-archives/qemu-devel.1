Received: from eggs.gnu.org ([2001:4830:134:3::10]:37382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dHsdv-0005BV-Mi
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 10:06:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dHsdu-0006I0-Gs
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 10:06:03 -0400
References: <1496670954-664-1-git-send-email-peter.maydell@linaro.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7edbb702-2b42-c450-36cf-72d4e9211081@redhat.com>
Date: Mon, 5 Jun 2017 09:05:53 -0500
MIME-Version: 1.0
In-Reply-To: <1496670954-664-1-git-send-email-peter.maydell@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6bWMBbVkCtXbosIh8COLLOE3HgWAErLtl"
Subject: Re: [Qemu-devel] [PATCH] block/qcow.c: Fix memory leak in
 qcow_create()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, patches@linaro.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6bWMBbVkCtXbosIh8COLLOE3HgWAErLtl
From: Eric Blake <eblake@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 qemu-block@nongnu.org, patches@linaro.org
Message-ID: <7edbb702-2b42-c450-36cf-72d4e9211081@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] block/qcow.c: Fix memory leak in
 qcow_create()
References: <1496670954-664-1-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1496670954-664-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/05/2017 08:55 AM, Peter Maydell wrote:
> Coverity points out that the code path in qcow_create() for
> the magic "fat:" backing file name leaks the memory used to
> store the filename (CID 1307771). Free the memory before
> we overwrite the pointer.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  block/qcow.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/block/qcow.c b/block/qcow.c
> index 95ab123..7bd94dc 100644
> --- a/block/qcow.c
> +++ b/block/qcow.c
> @@ -852,6 +852,7 @@ static int qcow_create(const char *filename, QemuOp=
ts *opts, Error **errp)
>              header_size +=3D backing_filename_len;
>          } else {
>              /* special backing file for vvfat */
> +            g_free(backing_file);
>              backing_file =3D NULL;
>          }
>          header.cluster_bits =3D 9; /* 512 byte cluster to avoid copyin=
g
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--6bWMBbVkCtXbosIh8COLLOE3HgWAErLtl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZNWVBAAoJEKeha0olJ0NqxIsH/iyYHVBv7HD6RTxM3xEkhkE1
tZVGaWm6fQ1RxS63nV3oebiHQXqJvOTrNbIrEhbV4899/YaN4uRgUY7a+7W6XNvt
G/xOML0jA0szNfkkRkwXFjFWmo0SGPIDXH/G2l6w0usUkPriyqBzW2uwLX8xylgt
DQx+4vP/S5mtXMmo9DGTQSaGkxBcGCcspFCqTqnqKaxTWykhhmb2FfmKjIwDRV1i
4zXFYv5YKweGESbEL0MytwGyo94jAHw7nBvjmtUunQFFNNxVCUNejw1xAHQeEa/K
jS7OKfLM5caaZ1u7SXBXdPd9Gdr5jV7GdfZFQHS5uwH9JB+4JtwyqRaSeoA4qDk=
=J7tw
-----END PGP SIGNATURE-----

--6bWMBbVkCtXbosIh8COLLOE3HgWAErLtl--
