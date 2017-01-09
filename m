Received: from eggs.gnu.org ([2001:4830:134:3::10]:36343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cQPU7-0005xh-CD
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 21:14:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cQPU4-0002iO-8V
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 21:14:55 -0500
Received: from [45.249.212.187] (port=2511 helo=dggrg01-dlp.huawei.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cQPU3-0002hG-FO
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 21:14:52 -0500
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Mon, 9 Jan 2017 02:09:45 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA1803F7@DGGEMA505-MBX.china.huawei.com>
References: <1482377823-20184-1-git-send-email-arei.gonglei@huawei.com>
In-Reply-To: <1482377823-20184-1-git-send-email-arei.gonglei@huawei.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] virtio-crypto: use the correct length for
 cipher operation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "mst@redhat.com" <mst@redhat.com>

Hi Michael,

Ping...



Regards,
-Gonglei


> -----Original Message-----
> From: Gonglei (Arei)
> Sent: Thursday, December 22, 2016 11:37 AM
> To: qemu-devel@nongnu.org
> Cc: mst@redhat.com; Gonglei (Arei)
> Subject: [PATCH] virtio-crypto: use the correct length for cipher operati=
on
>=20
> In some modes of cipher algorithms, the length of destination data
> maybe larger then source data, such as ciphertext stealing (CTS).
>=20
> For symmetric algorithms, the length of ciphertext is definitly
> equal to the plaintext for each crypto operation. So we should
> use the src_len instead of dst_len avoid to pass the incorrect
> cryptographical results to the frontend driver.
>=20
> Signed-off-by: Gonglei <arei.gonglei@huawei.com>
> ---
>  hw/virtio/virtio-crypto.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
> index 4f11fee..978bb98 100644
> --- a/hw/virtio/virtio-crypto.c
> +++ b/hw/virtio/virtio-crypto.c
> @@ -355,7 +355,7 @@ virtio_crypto_sym_input_data_helper(VirtIODevice
> *vdev,
>          return;
>      }
>=20
> -    len =3D sym_op_info->dst_len;
> +    len =3D sym_op_info->src_len;
>      /* Save the cipher result */
>      s =3D iov_from_buf(req->in_iov, req->in_num, 0, sym_op_info->dst, le=
n);
>      if (s !=3D len) {
> --
> 1.8.3.1
>=20
