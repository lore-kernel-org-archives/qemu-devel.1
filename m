Received: from eggs.gnu.org ([209.51.188.92]:37325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ghyon-0006z1-K6
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 10:33:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ghyon-0001GS-16
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 10:33:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39600)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ghyom-0001DC-N4
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 10:33:56 -0500
References: <20190111093116.17188-1-kraxel@redhat.com>
	<20190111093116.17188-6-kraxel@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <06341f73-6063-8cc3-dc1a-e5022ef2e032@redhat.com>
Date: Fri, 11 Jan 2019 09:33:40 -0600
MIME-Version: 1.0
In-Reply-To: <20190111093116.17188-6-kraxel@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="YYyj60MWhRyPA4IGQSCM1lILQh3gSQHHz"
Subject: Re: [Qemu-devel] [PATCH 5/5] [debug] some logging
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, intel-gvt-dev@lists.freedesktop.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--YYyj60MWhRyPA4IGQSCM1lILQh3gSQHHz
From: Eric Blake <eblake@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 intel-gvt-dev@lists.freedesktop.org
Message-ID: <06341f73-6063-8cc3-dc1a-e5022ef2e032@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 5/5] [debug] some logging
References: <20190111093116.17188-1-kraxel@redhat.com>
 <20190111093116.17188-6-kraxel@redhat.com>
In-Reply-To: <20190111093116.17188-6-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/11/19 3:31 AM, Gerd Hoffmann wrote:
> ---
>  hw/vfio/display.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>=20
> diff --git a/hw/vfio/display.c b/hw/vfio/display.c
> index a3a710b3ee..96b5474243 100644
> --- a/hw/vfio/display.c
> +++ b/hw/vfio/display.c
> @@ -42,6 +42,8 @@ static void vfio_display_edid_link_up(void *opaque)
>      VFIOPCIDevice *vdev =3D opaque;
>      VFIODisplay *dpy =3D vdev->dpy;
> =20
> +    fprintf(stderr, "%s:\n", __func__);

Why fprintf() instead of trace points?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--YYyj60MWhRyPA4IGQSCM1lILQh3gSQHHz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlw4t1QACgkQp6FrSiUn
Q2q5rQf+Ou7cGwv633TGNXHKc9n02pTLuIxoZgP3MjwRK8qyYTLnBwm6l6TuP9D5
89h1e4hoY4DjUmUgOMznXCTNJXWRqBJT05T0SBBexAI3dHBKyydYd0JKtnhde16b
KQyug2FINun1xSvMSo5iYix8u7DdTcLw5KhmSBatnAu+Fd+W3ej7s7nOv9uAd68b
Wbo1CMGvIyZSKvaMN+F3I/NhNCPKN0EM5VX1J6l2gu4G4k934qede7cE94+u68/l
sNMFzxLjhVeaMY3szcQg//8GLK+GTRMhIMH7XpGRdCshNKjFfeymW//PqAwCW8x9
YJcMDyjVs4T5A6X4Kgy9UCg/+foGiA==
=tCiM
-----END PGP SIGNATURE-----

--YYyj60MWhRyPA4IGQSCM1lILQh3gSQHHz--
