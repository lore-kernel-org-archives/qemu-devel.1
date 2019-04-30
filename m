Received: from eggs.gnu.org ([209.51.188.92]:47453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hLORl-0007p3-In
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 04:49:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hLORk-0004ga-HM
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 04:49:05 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44065)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hLORk-0004gJ-BJ
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 04:49:04 -0400
Received: by mail-wr1-f68.google.com with SMTP id c5so19982518wrs.11
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 01:49:04 -0700 (PDT)
References: <1556605773-42019-1-git-send-email-wangjie88@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9bacd55b-4333-28fd-18cb-c0dbd771062c@redhat.com>
Date: Tue, 30 Apr 2019 10:48:56 +0200
MIME-Version: 1.0
In-Reply-To: <1556605773-42019-1-git-send-email-wangjie88@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] vhost: fix incorrect print type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jie Wang <wangjie88@huawei.com>, qemu-devel@nongnu.org
Cc: eric.fangyi@huawei.com, wu.wubin@huawei.com, mst@redhat.com

On 4/30/19 8:29 AM, Jie Wang wrote:
> fix incorrect print type in vhost_virtqueue_stop
> 
> Signed-off-by: Jie Wang <wangjie88@huawei.com>
> ---
>  hw/virtio/vhost.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 7f61018f2a..286bb27c65 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -1081,7 +1081,7 @@ static void vhost_virtqueue_stop(struct vhost_dev *dev,
>  
>      r = dev->vhost_ops->vhost_get_vring_base(dev, &state);
>      if (r < 0) {
> -        VHOST_OPS_DEBUG("vhost VQ %d ring restore failed: %d", idx, r);
> +        VHOST_OPS_DEBUG("vhost VQ %u ring restore failed: %d", idx, r);

'idx' is indeed unsigned.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>          /* Connection to the backend is broken, so let's sync internal
>           * last avail idx to the device used idx.
>           */
> 
