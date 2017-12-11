Received: from eggs.gnu.org ([2001:4830:134:3::10]:33594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eOP6c-0007SD-Si
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 09:31:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eOP6W-0001mA-Be
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 09:30:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58254)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eOP6W-0001ka-38
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 09:30:48 -0500
References: <20171211001950.27843-1-samuel.thibault@ens-lyon.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f0cb9660-757c-385f-ace7-73330014e733@redhat.com>
Date: Mon, 11 Dec 2017 08:30:39 -0600
MIME-Version: 1.0
In-Reply-To: <20171211001950.27843-1-samuel.thibault@ens-lyon.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="8kMNTRS6gxRJU3BiMMqd6L45lOfKPNQen"
Subject: Re: [Qemu-devel] [PATCH] baum: Truncate braille device size to 84x1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>, qemu-devel@nongnu.org, pbonzini@redhat.com, marcandre.lureau@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8kMNTRS6gxRJU3BiMMqd6L45lOfKPNQen
From: Eric Blake <eblake@redhat.com>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, marcandre.lureau@redhat.com
Message-ID: <f0cb9660-757c-385f-ace7-73330014e733@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] baum: Truncate braille device size to 84x1
References: <20171211001950.27843-1-samuel.thibault@ens-lyon.org>
In-Reply-To: <20171211001950.27843-1-samuel.thibault@ens-lyon.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/10/2017 06:19 PM, Samuel Thibault wrote:
> Baum device bigger than 84 do not actually exist, some guest drivers
> would be upset by such sizes.
>=20
> Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> ---
>  chardev/baum.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>=20

> @@ -239,6 +239,12 @@ static int baum_deferred_init(BaumChardev *baum)
>          brlapi_perror("baum: brlapi__getDisplaySize");
>          return 0;
>      }
> +    if (baum->y > 1) {
> +        baum->y =3D 1;
> +    }
> +    if (baum->x > 84) {
> +        baum->x =3D 84;
> +    }

Is magic clamping desirable, or is it better to make it a hard error if
the user configured a size that is not possible?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--8kMNTRS6gxRJU3BiMMqd6L45lOfKPNQen
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloulo8ACgkQp6FrSiUn
Q2qLtAf/SxiTfOh36s3AbqItiPbk9hM+6hkx+WILbfwDNmH3uY/Iem1HkoTnbEQ4
CLkvWpnMdrBTPzhOF7iE8v8ErxuenRz/TxPJbiaG5rfs/dYgwfYVSbHuiDj4bIWu
IQEU2GcNhTrUyH23A1aGpIGmeCA96WYI6GY/Qp4+QVoNg2TWJKZVw5IijnUj87e6
/VuJybKk7b2MWiXkFO0mh4xIs1cZdSlSThSQeYUve6vAzZokyV8nZIdCT9NdTjdt
hMpk7ibTJzK2FiO1w5Ucfj45pWETz4308tL9HTsaGh/bc3ot3e32Q9NhNvPgyN85
hNmhYq957XRzYFLhJr+1WRHaLq4yeA==
=f2Gl
-----END PGP SIGNATURE-----

--8kMNTRS6gxRJU3BiMMqd6L45lOfKPNQen--
