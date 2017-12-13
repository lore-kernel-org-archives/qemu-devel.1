Received: from eggs.gnu.org ([2001:4830:134:3::10]:60306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eP44k-0001uZ-2A
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 05:15:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eP44e-0005ho-UR
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 05:15:42 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:43601)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1eP44e-0005hV-N0
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 05:15:36 -0500
Received: by mail-wm0-x243.google.com with SMTP id n138so3880706wmg.2
	for <qemu-devel@nongnu.org>; Wed, 13 Dec 2017 02:15:36 -0800 (PST)
Date: Wed, 13 Dec 2017 10:15:33 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171213101533.GC16782@stefanha-x1.localdomain>
References: <1513132143-10758-1-git-send-email-changpeng.liu@intel.com>
	<1513132143-10758-2-git-send-email-changpeng.liu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="raC6veAxrt5nqIoY"
Content-Disposition: inline
In-Reply-To: <1513132143-10758-2-git-send-email-changpeng.liu@intel.com>
Subject: Re: [Qemu-devel] [PATCH v7 1/4] vhost-user: add new vhost user
 messages to support virtio config space
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


--raC6veAxrt5nqIoY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2017 at 10:29:00AM +0800, Changpeng Liu wrote:
> Add VHOST_USER_GET_CONFIG/VHOST_USER_SET_CONFIG messages which can be
> used for live migration of vhost user devices, also vhost user devices
> can benefit from the messages to get/set virtio config space from/to the
> I/O target. For the purpose to support virtio config space change,
> VHOST_USER_SET_CONFIG_FD message is added as the event notifier
> in case virtio config space change in the I/O target.
>=20
> Signed-off-by: Changpeng Liu <changpeng.liu@intel.com>
> ---
>  docs/interop/vhost-user.txt       |  45 ++++++++++++++++
>  hw/virtio/vhost-user.c            | 107 ++++++++++++++++++++++++++++++++=
++++++
>  hw/virtio/vhost.c                 |  64 +++++++++++++++++++++++
>  include/hw/virtio/vhost-backend.h |  14 +++++
>  include/hw/virtio/vhost.h         |  16 ++++++
>  5 files changed, 246 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--raC6veAxrt5nqIoY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaMP3FAAoJEJykq7OBq3PIzCIIAMrmi8JY8LV9ufB+PXl/6UDi
P43aD83E0Scmflrwcq/VtyHcC8K9QbBwwMlO92wBul6IhFmh4didIBZ8+YLpV9XN
GIspiTu/on1q1VoNEwZZ4pu33zTq406GvzYlik+wHnlPJQF8E+dJpW7MOlhAdTBP
/3ZIuSN0QJJCME+0hvxWyQcXbBQTd0Q1FTaDdXEU6LelPM/Hd5ecxgSHBHOtVWji
ahrg1LOfTAVpj09reHU3Y/KmxkfLbTVU3WxaTtCoweM2oR0l5yeJmqe+Ku+t94MZ
ViJK9SDsJPtCzm8/0q/hQ4u1JNOLcRV/6uqOllgZOaq4UPjNR4t//RkJVGSNxqQ=
=Pejo
-----END PGP SIGNATURE-----

--raC6veAxrt5nqIoY--
