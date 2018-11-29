Received: from eggs.gnu.org ([2001:4830:134:3::10]:39921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gSFeG-0002Jq-Ab
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 01:18:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gSFeE-0005Dz-Rx
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 01:18:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33588)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gSFeD-00051t-T3
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 01:18:02 -0500
References: <20181129031230.31082-1-jasowang@redhat.com>
	<20181129031230.31082-3-jasowang@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <963d3ae1-33b0-4403-09ff-46b2e24e1400@redhat.com>
Date: Thu, 29 Nov 2018 07:17:48 +0100
MIME-Version: 1.0
In-Reply-To: <20181129031230.31082-3-jasowang@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for 3.1 2/4] virtio-net-test: remove unused
 macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: mst@redhat.com, liq3ea@163.com, liq3ea@gmail.com, ppandit@redhat.com, pbonzini@redhat.com

On 2018-11-29 04:12, Jason Wang wrote:
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  tests/virtio-net-test.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/tests/virtio-net-test.c b/tests/virtio-net-test.c
> index dcb87a8b6e..231e7c767e 100644
> --- a/tests/virtio-net-test.c
> +++ b/tests/virtio-net-test.c
> @@ -24,7 +24,6 @@
>  
>  #define PCI_SLOT_HP             0x06
>  #define PCI_SLOT                0x04
> -#define PCI_FN                  0x00
>  
>  #define QVIRTIO_NET_TIMEOUT_US (30 * 1000 * 1000)
>  #define VNET_HDR_SIZE sizeof(struct virtio_net_hdr_mrg_rxbuf)
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
