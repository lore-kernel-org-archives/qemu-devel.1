Received: from eggs.gnu.org ([209.51.188.92]:37662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hLHi2-0001jk-9C
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 21:37:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hLHi0-00054s-EE
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 21:37:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57202)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1hLHhy-0004wB-SL
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 21:37:23 -0400
References: <20190429235109.20307-1-brogers@suse.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3dd36ff4-b51f-fde0-7665-f9ad4eda9194@redhat.com>
Date: Mon, 29 Apr 2019 20:37:14 -0500
MIME-Version: 1.0
In-Reply-To: <20190429235109.20307-1-brogers@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="KncdG8bsRcdDtaijikPoCTICegJJYhzRt"
Subject: Re: [Qemu-devel] [PATCH] scsi-disk: handle invalid cdb length
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bruce Rogers <brogers@suse.com>, qemu-devel@nongnu.org
Cc: fam@euphon.net, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KncdG8bsRcdDtaijikPoCTICegJJYhzRt
From: Eric Blake <eblake@redhat.com>
To: Bruce Rogers <brogers@suse.com>, qemu-devel@nongnu.org
Cc: fam@euphon.net, pbonzini@redhat.com
Message-ID: <3dd36ff4-b51f-fde0-7665-f9ad4eda9194@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] scsi-disk: handle invalid cdb length
References: <20190429235109.20307-1-brogers@suse.com>
In-Reply-To: <20190429235109.20307-1-brogers@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/29/19 6:51 PM, Bruce Rogers wrote:
> While investigating link-time-optimization, the compiler flagged this
> case of not handling the error return from scsi_cdb_length(). Handle
> this error case with a trace report.
>=20
> Signed-off-by: Bruce Rogers <brogers@suse.com>
> ---
>  hw/scsi/scsi-disk.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
> index e7e865ab3b..dc13c892ef 100644
> --- a/hw/scsi/scsi-disk.c
> +++ b/hw/scsi/scsi-disk.c
> @@ -2520,6 +2520,10 @@ static void scsi_disk_new_request_dump(uint32_t =
lun, uint32_t tag, uint8_t *buf)
>      int len =3D scsi_cdb_length(buf);
>      char *line_buffer, *p;
> =20
> +    if (len < 0) {
> +        trace_scsi_disk_new_request(lun, tag, "bad cdb length!");

I'd drop the !. We aren't shouting at the trace clients, after all :)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--KncdG8bsRcdDtaijikPoCTICegJJYhzRt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlzHpsoACgkQp6FrSiUn
Q2p8Ygf/a5qLfAO5tK4op2tlx/7Kozlzcvl9LQK296DMipUZhlTlt2RiU0qfSkrz
m2ofVXWM4PEWH+66WA2snmEMnOZDJZsIg5/qzobRHuAZf87GKFKWldMC2e5H8xBq
8paLkgImAIKwvcYBM4clNJWiqHA0uyxXwRomptiAPP7JLxJHwVyuz4FUOIw9nA99
fDuHWLP3RGyGLxYQZ7YxPql/HERnqv2QQpniSWlSc/NRkJ25X/AaZXv+UE7e0LQf
W0y4wJNYbpeTQvAb7v6NRWKplChcAK8YTNiVCran4xa0HtFmq855gz7+BBl9+C+/
Knr03gKZgn14+FJn5+tdQy306YpwrQ==
=f7vp
-----END PGP SIGNATURE-----

--KncdG8bsRcdDtaijikPoCTICegJJYhzRt--
