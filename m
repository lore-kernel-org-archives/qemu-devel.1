Received: from eggs.gnu.org ([2001:4830:134:3::10]:48271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eOOcX-00087s-NI
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 08:59:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eOOcT-0000Fx-S2
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 08:59:49 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:45225)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1eOOcT-0000Em-Lr
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 08:59:45 -0500
Received: by mail-wm0-x242.google.com with SMTP id 9so14607927wme.4
	for <qemu-devel@nongnu.org>; Mon, 11 Dec 2017 05:59:45 -0800 (PST)
Date: Mon, 11 Dec 2017 13:59:42 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171211135942.GC5962@stefanha-x1.localdomain>
References: <1512455239-8296-1-git-send-email-changpeng.liu@intel.com>
	<1512455239-8296-4-git-send-email-changpeng.liu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oJ71EGRlYNjSvfq7"
Content-Disposition: inline
In-Reply-To: <1512455239-8296-4-git-send-email-changpeng.liu@intel.com>
Subject: Re: [Qemu-devel] [PATCH v6 3/4] contrib/libvhost-user: enable
 virtio config space messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Changpeng Liu <changpeng.liu@intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mst@redhat.com, marcandre.lureau@redhat.com, felipe@nutanix.com, james.r.harris@intel.com


--oJ71EGRlYNjSvfq7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 05, 2017 at 02:27:18PM +0800, Changpeng Liu wrote:
> @@ -798,6 +801,70 @@ vu_set_slave_req_fd(VuDev *dev, VhostUserMsg *vmsg)
>  }
> =20
>  static bool
> +vu_get_config(VuDev *dev, VhostUserMsg *vmsg)
> +{
> +    int ret =3D -1;
> +
> +    if (dev->iface->get_config) {
> +        ret =3D dev->iface->get_config(dev, vmsg->payload.config.region,
> +                                     vmsg->payload.config.size);
> +    }
> +
> +    if (ret) {
> +        /* resize to zero to indicate an error to master */
> +        vmsg->size =3D 0;
> +    }

Please document this error case in vhost-user.txt.  I don't remember
reading about it.

--oJ71EGRlYNjSvfq7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaLo9OAAoJEJykq7OBq3PIl7YH/3jPwF6FkmF8Cne0rheQHG81
wrHKjBMAm9cBBb9lbbPJiT0PNhuWvuFXe5j0mSpyYww1wsUlnyyeRfcb0wOLYmaR
+Kuqm8NeWGjcTZHnZD5dlRmDdML/2XXD/6bLsiedV+7RjCmJX5F7MBtg4SEUDgb0
cmfxLq8JbH/d02BhGEcLpVeUubPuhDMQp880UZo3OQhPC3G3YZUN3vFDBhjyE1jx
BtDe49LOfZYCOAHjYHymcdl9YXYwSO18iPWYR+CW96Izixxg/qZMZfvttIcWDpkg
knjyEzbucD4zk+A5ahENfpTv28w4cNWrZqdi8OWhwvY2fTsyYO8QVnj6e3JwUuQ=
=/hia
-----END PGP SIGNATURE-----

--oJ71EGRlYNjSvfq7--
