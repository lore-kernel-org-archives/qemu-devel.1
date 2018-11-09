Received: from eggs.gnu.org ([2001:4830:134:3::10]:51016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gL238-0007rN-1k
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 03:21:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gL236-0006KK-00
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 03:21:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38120)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1gL235-00063T-CF
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 03:21:51 -0500
References: <1541751214-17515-1-git-send-email-liq3ea@gmail.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <7d20734d-f43a-957c-9cb5-4644320037aa@redhat.com>
Date: Fri, 9 Nov 2018 09:21:19 +0100
MIME-Version: 1.0
In-Reply-To: <1541751214-17515-1-git-send-email-liq3ea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw: set_netdev: remove useless code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>, stefanha@redhat.com, marcandre.lureau@redhat.com, thuth@redhat.com
Cc: qemu-devel@nongnu.org

On 09/11/2018 09:13, Li Qiang wrote:
> In set_netdev(), the peers[i] is initialized
> qemu_find_net_clients_except() when i is in
> 0 between 'queues' it can't be NULL.
> 
> Signed-off-by: Li Qiang <liq3ea@gmail.com>
> ---
>  hw/core/qdev-properties-system.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
> index 8b22fb5..b45a7ef 100644
> --- a/hw/core/qdev-properties-system.c
> +++ b/hw/core/qdev-properties-system.c
> @@ -288,10 +288,6 @@ static void set_netdev(Object *obj, Visitor *v, const char *name,
>      }
>  
>      for (i = 0; i < queues; i++) {
> -        if (peers[i] == NULL) {
> -            err = -ENOENT;
> -            goto out;
> -        }
>  
>          if (peers[i]->peer) {
>              err = -EEXIST;
> 

Reviewed-by: Laurent Vivier <lvivier@redhat.com>
