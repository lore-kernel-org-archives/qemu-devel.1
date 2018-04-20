Received: from eggs.gnu.org ([2001:4830:134:3::10]:44644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9UjY-0008JC-Mc
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 08:01:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9UjX-0006iM-Ro
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 08:01:44 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180420084820.3873-1-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <fdcbfea9-04d7-b994-829e-59b40f9cf018@amsat.org>
Date: Fri, 20 Apr 2018 09:01:25 -0300
MIME-Version: 1.0
In-Reply-To: <20180420084820.3873-1-kraxel@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="D58aLwfQos2zCSP3PcuCtpnN1c1IHoEKI"
Subject: Re: [Qemu-devel] [PATCH] vnc: fix use-after-free
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, qemu-stable <qemu-stable@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--D58aLwfQos2zCSP3PcuCtpnN1c1IHoEKI
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, qemu-stable <qemu-stable@nongnu.org>
Message-ID: <fdcbfea9-04d7-b994-829e-59b40f9cf018@amsat.org>
Subject: Re: [PATCH] vnc: fix use-after-free
References: <20180420084820.3873-1-kraxel@redhat.com>
In-Reply-To: <20180420084820.3873-1-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Cc'ing qemu-stable

On 04/20/2018 05:48 AM, Gerd Hoffmann wrote:
> When vnc_client_read() return value is -1
> vs is not valid any more.
>=20
> Fixes: d49b87f0d1e0520443a990fc610d0f02bc63c556
> Reported-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

> ---
>  ui/vnc.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/ui/vnc.c b/ui/vnc.c
> index e164eb798c..5526e54f48 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -1539,13 +1539,14 @@ gboolean vnc_client_io(QIOChannel *ioc G_GNUC_U=
NUSED,
>      VncState *vs =3D opaque;
>      if (condition & G_IO_IN) {
>          if (vnc_client_read(vs) < 0) {
> -            goto end;
> +            /* vs is free()ed here */
> +            return TRUE;
>          }
>      }
>      if (condition & G_IO_OUT) {
>          vnc_client_write(vs);
>      }
> -end:
> +
>      if (vs->disconnecting) {
>          if (vs->ioc_tag !=3D 0) {
>              g_source_remove(vs->ioc_tag);
>=20


--D58aLwfQos2zCSP3PcuCtpnN1c1IHoEKI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAlrZ1pUACgkQ4+MsLN6t
wN5CtRAAvzx04W4snvmNlK7vnzyH+dKZi56LXe2POnovk75WTYmbv0Insv2jXB3I
zBsp4r0IJc9SL/n/iuGhJ7BVlMxOTAGw88cN4ZFU9gwrmKkKSDdqNc+0I25G/EAE
886S/I1WW8N68TVMiqDO4GPmby3+X2WxKxlolLC2rYF9Zu8IyVCT3gbHrfxhpF4w
kGcvM02OrwBPULGfZg6N8M6C9KKRQJz+LWwcY8kYP3fwkuyu2qOjFHXqNVBOkRau
QFsFLbuQhWOLEXMR/CnugY2bD04ZXwuzqmfHwpmvKx/9kmYM6F6MyZ4yKH/+PVIm
8hRSQPQMcRTBhe0vxfbG6DJ5NblQdhICea+h3wjNgNx0I+AypkoT5KPxGlWLqk7D
W2GIAanyIYY0JjlEilVfscndgylD5mtxzRzTnuaXx+1c+lpCT7yEo4b9O25OUyOu
PThHCcroM1BesXvnN2TGDGdBqwpYUdKSk2j2pHROL7op/JapG6VqiSLO7NxYevSE
jRxudu+70ZG66LiEvDsveXbyvLO6VHXSnhA8IVtqORHc/G+COTpyd45XQgvyysXO
83sPtQwt7RHFSMaV45acV0jyBN3fG/RckbInSUlhGAHJtDWqopBF9k5FLTyLzL9P
UxFh+HYomeV/SlpgbQ+/F/a/XI1JS2lbre3VLZHVyBUz2G/Wzk4=
=ji/g
-----END PGP SIGNATURE-----

--D58aLwfQos2zCSP3PcuCtpnN1c1IHoEKI--
