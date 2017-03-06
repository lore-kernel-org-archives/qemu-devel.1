Received: from eggs.gnu.org ([2001:4830:134:3::10]:38424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ckw1f-0001re-BL
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 12:02:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ckw1c-0006c8-8R
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 12:02:23 -0500
References: <1488770972-322500-1-git-send-email-zhang.zhanghailiang@huawei.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4c846171-beb1-c085-e482-597e060e6359@redhat.com>
Date: Mon, 6 Mar 2017 18:02:15 +0100
MIME-Version: 1.0
In-Reply-To: <1488770972-322500-1-git-send-email-zhang.zhanghailiang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] virtio-serial-bus: Delete timer from list
 before free it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: zhanghailiang <zhang.zhanghailiang@huawei.com>, amit@kernel.org, mst@redhat.com
Cc: qemu-devel@nongnu.org, qemu-stable <qemu-stable@nongnu.org>



On 06/03/2017 04:29, zhanghailiang wrote:
> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
> ---
>  hw/char/virtio-serial-bus.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
> index d544cd9..d797a67 100644
> --- a/hw/char/virtio-serial-bus.c
> +++ b/hw/char/virtio-serial-bus.c
> @@ -724,6 +724,7 @@ static void virtio_serial_post_load_timer_cb(void *opaque)
>          }
>      }
>      g_free(s->post_load->connected);
> +    timer_del(s->post_load->timer);
>      timer_free(s->post_load->timer);
>      g_free(s->post_load);
>      s->post_load = NULL;
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-stable@nongnu.org
