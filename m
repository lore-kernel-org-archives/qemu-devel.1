Received: from eggs.gnu.org ([2001:4830:134:3::10]:46949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1duiag-0007qj-7S
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 13:15:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1duiad-0000rf-Gw
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 13:15:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:35644)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1duiad-0000p4-BA
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 13:15:11 -0400
Date: Wed, 20 Sep 2017 10:15:08 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <20170907145618.GD1655@perard.uk.xensource.com>
Message-ID: <alpine.DEB.2.10.1709201014390.2968@sstabellini-ThinkPad-X260>
References: <1501081831-9587-1-git-send-email-owen.smith@citrix.com>
	<1501081831-9587-2-git-send-email-owen.smith@citrix.com>
	<alpine.DEB.2.10.1708211556570.12143@sstabellini-ThinkPad-X260>
	<20170907145618.GD1655@perard.uk.xensource.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH 1/2 v3] xenfb: Use Input Handlers directly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: owen.smith@citrix.com
Cc: Stefano Stabellini <sstabellini@kernel.org>, qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, anthony.perard@citrix.com

Ping?

On Thu, 7 Sep 2017, Anthony PERARD wrote:
> On Mon, Aug 21, 2017 at 04:12:27PM -0700, Stefano Stabellini wrote:
> > Anthony,
> > 
> > The code looks good. I tested this patch with Linux guests and seems to
> > work OK, can you also confirm?
> 
> I've tested with Linux as well, an HVM guess, I did not spot any issue.
> 
> But, the code compiles with warnings...
> 
> In file included from /root/build/qemu/include/standard-headers/linux/input.h:16:0,
>                  from hw/display/xenfb.c:41:
> /root/build/qemu/include/standard-headers/linux/input-event-codes.h:88:0: error: "KEY_BACKSPACE" redefined [-Werror]
>  #define KEY_BACKSPACE  14
>  
> In file included from /root/build/qemu/include/ui/console.h:342:0,
>                  from hw/display/xenfb.c:31:
> /usr/include/curses.h:1494:0: note: this is the location of the previous definition
>  #define KEY_BACKSPACE 0407  /* backspace key */
>  
> In file included from /root/build/qemu/include/standard-headers/linux/input.h:16:0,
>                  from hw/display/xenfb.c:41:
> /root/build/qemu/include/standard-headers/linux/input-event-codes.h:102:0: error: "KEY_ENTER" redefined [-Werror]
>  #define KEY_ENTER  28
>  
> In file included from /root/build/qemu/include/ui/console.h:342:0,
>                  from hw/display/xenfb.c:31:
> /usr/include/curses.h:1512:0: note: this is the location of the previous definition
>  #define KEY_ENTER 0527  /* enter/send key */
>  
> In file included from /root/build/qemu/include/standard-headers/linux/input.h:16:0,
>                  from hw/display/xenfb.c:41:
> /root/build/qemu/include/standard-headers/linux/input-event-codes.h:107:0: error: "KEY_F" redefined [-Werror]
>  #define KEY_F   33
>  
> In file included from /root/build/qemu/include/ui/console.h:342:0,
>                  from hw/display/xenfb.c:31:
> /usr/include/curses.h:1496:0: note: this is the location of the previous definition
>  #define KEY_F(n) (KEY_F0+(n)) /* Value of function key n */
> [...]
> 
> And a lot more...
> 
> -- 
> Anthony PERARD
> 
