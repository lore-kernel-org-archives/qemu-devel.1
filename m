Received: from eggs.gnu.org ([2001:4830:134:3::10]:49228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1cHAeh-0007rF-Ad
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 09:35:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1cHAeb-0008Q2-QR
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 09:35:39 -0500
References: <20161214142518.10504-1-stefanha@redhat.com>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <0d2c1d9f-dbfd-6e7f-ee26-aca391e02376@weilnetz.de>
Date: Wed, 14 Dec 2016 15:35:24 +0100
MIME-Version: 1.0
In-Reply-To: <20161214142518.10504-1-stefanha@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.8] ui/gtk: fix "Copy" menu item
 segfault
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-stable <qemu-stable@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>

Am 14.12.2016 um 15:25 schrieb Stefan Hajnoczi:
> The "Copy" menu item copies VTE terminal text to the clipboard.  This
> only works with VTE terminals, not with graphics consoles.
> 
> Disable the menu item when the current notebook page isn't a VTE
> terminal.
> 
> This patch fixes a segfault.  Reproducer: Start QEMU and click the Copy
> menu item when the guest display is visible.
> 
> Reported-by: Kevin Wolf <kwolf@redhat.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  ui/gtk.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> Gerd, Michael: if you post Reviewed-by I can merge this directly without
> requiring you to send a pull request.  It's a user interface segfault so it
> would be nice to resolve it in QEMU 2.8.
> 

Tested-by: Stefan Weil <sw@weilnetz.de>

CC'ing QEMU-stable because I think that 2.7 needs that fix, too.

Stefan
