Received: from eggs.gnu.org ([2001:4830:134:3::10]:38389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=4168130ab=anthony.perard@citrix.com>)
	id 1dpyEH-0007WZ-7C
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 10:56:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=4168130ab=anthony.perard@citrix.com>)
	id 1dpyEC-0002jp-LS
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 10:56:29 -0400
Received: from smtp02.citrix.com ([66.165.176.63]:14145)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=4168130ab=anthony.perard@citrix.com>)
	id 1dpyEC-0002hp-E4
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 10:56:24 -0400
Date: Thu, 7 Sep 2017 15:56:18 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20170907145618.GD1655@perard.uk.xensource.com>
References: <1501081831-9587-1-git-send-email-owen.smith@citrix.com>
	<1501081831-9587-2-git-send-email-owen.smith@citrix.com>
	<alpine.DEB.2.10.1708211556570.12143@sstabellini-ThinkPad-X260>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.10.1708211556570.12143@sstabellini-ThinkPad-X260>
Subject: Re: [Qemu-devel] [PATCH 1/2 v3] xenfb: Use Input Handlers directly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: Owen Smith <owen.smith@citrix.com>, qemu-devel@nongnu.org, xen-devel@lists.xenproject.org

On Mon, Aug 21, 2017 at 04:12:27PM -0700, Stefano Stabellini wrote:
> Anthony,
> 
> The code looks good. I tested this patch with Linux guests and seems to
> work OK, can you also confirm?

I've tested with Linux as well, an HVM guess, I did not spot any issue.

But, the code compiles with warnings...

In file included from /root/build/qemu/include/standard-headers/linux/input.h:16:0,
                 from hw/display/xenfb.c:41:
/root/build/qemu/include/standard-headers/linux/input-event-codes.h:88:0: error: "KEY_BACKSPACE" redefined [-Werror]
 #define KEY_BACKSPACE  14
 
In file included from /root/build/qemu/include/ui/console.h:342:0,
                 from hw/display/xenfb.c:31:
/usr/include/curses.h:1494:0: note: this is the location of the previous definition
 #define KEY_BACKSPACE 0407  /* backspace key */
 
In file included from /root/build/qemu/include/standard-headers/linux/input.h:16:0,
                 from hw/display/xenfb.c:41:
/root/build/qemu/include/standard-headers/linux/input-event-codes.h:102:0: error: "KEY_ENTER" redefined [-Werror]
 #define KEY_ENTER  28
 
In file included from /root/build/qemu/include/ui/console.h:342:0,
                 from hw/display/xenfb.c:31:
/usr/include/curses.h:1512:0: note: this is the location of the previous definition
 #define KEY_ENTER 0527  /* enter/send key */
 
In file included from /root/build/qemu/include/standard-headers/linux/input.h:16:0,
                 from hw/display/xenfb.c:41:
/root/build/qemu/include/standard-headers/linux/input-event-codes.h:107:0: error: "KEY_F" redefined [-Werror]
 #define KEY_F   33
 
In file included from /root/build/qemu/include/ui/console.h:342:0,
                 from hw/display/xenfb.c:31:
/usr/include/curses.h:1496:0: note: this is the location of the previous definition
 #define KEY_F(n) (KEY_F0+(n)) /* Value of function key n */
[...]

And a lot more...

-- 
Anthony PERARD
