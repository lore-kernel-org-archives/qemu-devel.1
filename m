Received: from eggs.gnu.org ([2001:4830:134:3::10]:60746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cFE2T-0005eL-JX
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 00:48:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cFE2P-0006lo-7T
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 00:48:09 -0500
Received: from [45.249.212.189] (port=2370 helo=dggrg03-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cFE2M-0006k7-Nz
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 00:48:05 -0500
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Fri, 9 Dec 2016 05:47:34 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA158262@DGGEMA505-MBX.china.huawei.com>
References: <1481165546-203200-1-git-send-email-longpeng2@huawei.com>
In-Reply-To: <1481165546-203200-1-git-send-email-longpeng2@huawei.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH for-2.9] cryptodev: add 3des-ede support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: longpeng <longpeng2@huawei.com>
Cc: "Wubin (H)" <wu.wubin@huawei.com>, "Zhoujian (jay, Euler)" <jianjay.zhou@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>



> -----Original Message-----
> From: longpeng
> Sent: Thursday, December 08, 2016 10:52 AM
> To: Gonglei (Arei)
> Cc: Wubin (H); Zhoujian (jay, Euler); qemu-devel@nongnu.org; longpeng
> Subject: [PATCH for-2.9] cryptodev: add 3des-ede support
>=20
> This patch add 3des-ede support for cryptodev. However this is effective
> only when backend using libgcrypt/nettle, because cipher-builtin doesn't
> support 3des-ede yet.
>=20
> Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
> ---
> Changes since v1:
>     - split the original pathset. [Gonglei]
>=20
> ---
>  backends/cryptodev-builtin.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/backends/cryptodev-builtin.c b/backends/cryptodev-builtin.c
> index 5fb2836..486b4a6 100644
> --- a/backends/cryptodev-builtin.c
> +++ b/backends/cryptodev-builtin.c
> @@ -205,6 +205,18 @@ static int cryptodev_builtin_create_cipher_session(
>              return -1;
>          }
>          break;
> +    case VIRTIO_CRYPTO_CIPHER_3DES_ECB:
> +        mode =3D QCRYPTO_CIPHER_MODE_ECB;
> +        algo =3D QCRYPTO_CIPHER_ALG_3DES;
> +        break;
> +    case VIRTIO_CRYPTO_CIPHER_3DES_CBC:
> +        mode =3D QCRYPTO_CIPHER_MODE_CBC;
> +        algo =3D QCRYPTO_CIPHER_ALG_3DES;
> +        break;
> +    case VIRTIO_CRYPTO_CIPHER_3DES_CTR:
> +        mode =3D QCRYPTO_CIPHER_MODE_CTR;
> +        algo =3D QCRYPTO_CIPHER_ALG_3DES;
> +        break;
>      default:
>          error_setg(errp, "Unsupported cipher alg :%u",
>                     sess_info->cipher_alg);
> --
> 1.8.3.1
>=20

Queued, thanks.

Regards,
-Gonglei
