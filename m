Received: from eggs.gnu.org ([2001:4830:134:3::10]:41855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gTr3h-0004Ja-VX
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 11:26:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gTr3d-0002EM-AS
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 11:26:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37792)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gTr3d-0002Dy-3p
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 11:26:53 -0500
References: <20181203100608.28538-1-jasowang@redhat.com>
	<20181203100608.28538-4-jasowang@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3b1e4aed-84e8-1541-6fd3-5c69a0fdd945@redhat.com>
Date: Mon, 3 Dec 2018 10:26:02 -0600
MIME-Version: 1.0
In-Reply-To: <20181203100608.28538-4-jasowang@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V4 for 3.1 3/4] virtio-net-test: remove
 unused macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: mst@redhat.com, ppandit@redhat.com, liq3ea@163.com, liq3ea@gmail.com, pbonzini@redhat.com, thuth@redhat.com

On 12/3/18 4:06 AM, Jason Wang wrote:
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>   tests/virtio-net-test.c | 1 -
>   1 file changed, 1 deletion(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

> diff --git a/tests/virtio-net-test.c b/tests/virtio-net-test.c
> index 587a043e67..bdd6af9999 100644
> --- a/tests/virtio-net-test.c
> +++ b/tests/virtio-net-test.c
> @@ -24,7 +24,6 @@
>   
>   #define PCI_SLOT_HP             0x06
>   #define PCI_SLOT                0x04
> -#define PCI_FN                  0x00
>   
>   #define QVIRTIO_NET_TIMEOUT_US (30 * 1000 * 1000)
>   #define VNET_HDR_SIZE sizeof(struct virtio_net_hdr_mrg_rxbuf)
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
