Received: from eggs.gnu.org ([2001:4830:134:3::10]:42756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1dJ5zJ-0000Xk-Q1
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 18:33:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1dJ5zF-0001oD-Q6
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 18:33:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:49702)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1dJ5zF-0001nw-Iz
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 18:33:05 -0400
Date: Thu, 8 Jun 2017 15:33:03 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <1496927734-29174-3-git-send-email-owen.smith@citrix.com>
Message-ID: <alpine.DEB.2.10.1706081532310.26108@sstabellini-ThinkPad-X260>
References: <1496927734-29174-1-git-send-email-owen.smith@citrix.com>
	<1496927734-29174-3-git-send-email-owen.smith@citrix.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH 2/4] xenfb: Activate mouse handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Owen Smith <owen.smith@citrix.com>
Cc: qemu-devel@nongnu.org, sstabellini@kernel.org, anthony.perard@citrix.com, kraxel@redhat.com, xen-devel@lists.xenproject.org

On Thu, 8 Jun 2017, Owen Smith wrote:
> Mouse events are only delivered to the first handler in the chain.
> Activating the xenfb mouse event handler so that mouse events can
> be passed over the shared ring protocol.
> Note: The keyboard handler is activated internally by the add
> call.

I am not sure I follow: why do we need this now? How is it working
today?


> Signed-off-by: Owen Smith <owen.smith@citrix.com>
> ---
>  hw/display/xenfb.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/display/xenfb.c b/hw/display/xenfb.c
> index 2ebc81b..b0a5726 100644
> --- a/hw/display/xenfb.c
> +++ b/hw/display/xenfb.c
> @@ -385,6 +385,7 @@ static void input_connected(struct XenDevice *xendev)
>      in->qmouse = qemu_add_mouse_event_handler(xenfb_mouse_event, in,
>  					      in->abs_pointer_wanted,
>  					      "Xen PVFB Mouse");
> +    qemu_activate_mouse_event_handler(in->qmouse);
>  }
>  
>  static void input_disconnect(struct XenDevice *xendev)
> -- 
> 2.1.4
> 
