Received: from eggs.gnu.org ([2001:4830:134:3::10]:42123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eI15W-0006QE-RS
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 18:39:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eI15T-00056l-1g
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 18:39:22 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:39151)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eI15S-000555-NE
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 18:39:18 -0500
Received: by mail-wm0-f47.google.com with SMTP id x63so19312862wmf.4
	for <qemu-devel@nongnu.org>; Thu, 23 Nov 2017 15:39:18 -0800 (PST)
References: <20171123190131.5138-1-ppandit@redhat.com>
	<20171123190131.5138-2-ppandit@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <adb78e77-491a-c899-8454-d628b845cd29@redhat.com>
Date: Fri, 24 Nov 2017 00:39:15 +0100
MIME-Version: 1.0
In-Reply-To: <20171123190131.5138-2-ppandit@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] virtio: check VirtQueue Vring object
 is set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>
Cc: zhangboxian <zhangboxian@huawei.com>, Stefan Hajnoczi <stefanha@redhat.com>, Prasad J Pandit <pjp@fedoraproject.org>

On 23/11/2017 20:01, P J P wrote:
> @@ -182,7 +182,7 @@ void virtio_queue_update_rings(VirtIODevice *vdev, int n)
>  {
>      VRing *vring = &vdev->vq[n].vring;
>  
> -    if (!vring->desc) {
> +    if (!vring->desc || !vring->align) {
>          /* not yet setup -> nothing to do */
>          return;
>      }
> @@ -1414,6 +1414,9 @@ void virtio_config_modern_writel(VirtIODevice *vdev,
>  
>  void virtio_queue_set_addr(VirtIODevice *vdev, int n, hwaddr addr)
>  {
> +    if (!vdev->vq[n].vring.num) {
> +        return;
> +    }

Why not check vring->num in virtio_queue_update_rings too?

Thanks,

Paolo

>      vdev->vq[n].vring.desc = addr;
>      virtio_queue_update_rings(vdev, n);
>  }
