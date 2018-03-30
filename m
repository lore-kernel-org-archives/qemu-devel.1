Received: from eggs.gnu.org ([2001:4830:134:3::10]:39114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <changpeng.liu@intel.com>) id 1f1jz0-0005vs-Is
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 22:41:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <changpeng.liu@intel.com>) id 1f1jyx-0002Fa-Ff
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 22:41:38 -0400
Received: from mga12.intel.com ([192.55.52.136]:13126)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <changpeng.liu@intel.com>)
	id 1f1jyx-0002Dk-7P
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 22:41:35 -0400
From: "Liu, Changpeng" <changpeng.liu@intel.com>
Date: Fri, 30 Mar 2018 02:41:30 +0000
Message-ID: <FF7FC980937D6342B9D289F5F3C7C2625B625B15@SHSMSX103.ccr.corp.intel.com>
References: <1522377977-29623-1-git-send-email-changpeng.liu@intel.com>
In-Reply-To: <1522377977-29623-1-git-send-email-changpeng.liu@intel.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 1/2] contrib/libvhost-user: add the
 protocol feature used for SET/GET message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "mst@redhat.com" <mst@redhat.com>, "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>, "maxime.coquelin@redhat.com" <maxime.coquelin@redhat.com>

The patch serials depend on Maxime's patch "vhost-user: back SET/GET_CONFIG=
 requests with a protocol feature",
which adding the protocol feature bit for SET/GET messages.

> -----Original Message-----
> From: Liu, Changpeng
> Sent: Friday, March 30, 2018 10:46 AM
> To: Liu, Changpeng <changpeng.liu@intel.com>; qemu-devel@nongnu.org
> Cc: mst@redhat.com; marcandre.lureau@redhat.com;
> maxime.coquelin@redhat.com
> Subject: [PATCH 1/2] contrib/libvhost-user: add the protocol feature used=
 for
> SET/GET message
>=20
> Signed-off-by: Changpeng Liu <changpeng.liu@intel.com>
> ---
>  contrib/libvhost-user/libvhost-user.h | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-use=
r/libvhost-
> user.h
> index 79f7a53..b27075e 100644
> --- a/contrib/libvhost-user/libvhost-user.h
> +++ b/contrib/libvhost-user/libvhost-user.h
> @@ -50,6 +50,7 @@ enum VhostUserProtocolFeature {
>      VHOST_USER_PROTOCOL_F_CROSS_ENDIAN =3D 6,
>      VHOST_USER_PROTOCOL_F_CRYPTO_SESSION =3D 7,
>      VHOST_USER_PROTOCOL_F_PAGEFAULT =3D 8,
> +    VHOST_USER_PROTOCOL_F_CONFIG =3D 9,
>=20
>      VHOST_USER_PROTOCOL_F_MAX
>  };
> --
> 1.9.3
