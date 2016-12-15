Received: from eggs.gnu.org ([2001:4830:134:3::10]:53440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cHRhW-0007gb-9R
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 03:47:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cHRhV-0007b2-Ep
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 03:47:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39536)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1cHRhV-0007ai-8o
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 03:47:41 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6146DC0A8041
	for <qemu-devel@nongnu.org>; Thu, 15 Dec 2016 08:47:40 +0000 (UTC)
Date: Thu, 15 Dec 2016 09:47:38 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20161215084738.GA5484@noname.redhat.com>
References: <20161214142518.10504-1-stefanha@redhat.com>
	<20161215004752-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161215004752-mutt-send-email-mst@kernel.org>
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>

Am 14.12.2016 um 23:49 hat Michael S. Tsirkin geschrieben:
> On Wed, Dec 14, 2016 at 02:25:18PM +0000, Stefan Hajnoczi wrote:
> > The "Copy" menu item copies VTE terminal text to the clipboard.  This
> > only works with VTE terminals, not with graphics consoles.
> > 
> > Disable the menu item when the current notebook page isn't a VTE
> > terminal.
> > 
> > This patch fixes a segfault.  Reproducer: Start QEMU and click the Copy
> > menu item when the guest display is visible.
> > 
> > Reported-by: Kevin Wolf <kwolf@redhat.com>
> > Cc: Michael S. Tsirkin <mst@redhat.com>
> > Cc: Gerd Hoffmann <kraxel@redhat.com>
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> 
> I don't think it's 2.8 personally, patch just disables an
> illegal action. Similar to the hotplug crash fix I
> have queued. Just document this as a known issue.

This is an immediate crash for selecting a menu entry in the default
view (which means killing a VM accidentally), we know the patch to fix
it, and it is really small. Why would we not merge something like this?
Are we making intentionally shitty releases these days?

I don't know your hotplug problem, but if it's a crash that isn't a
real corner case, that suggests that it should have been fixed. I mean,
fixing bugs is exactly what the freeze is for.

Kevin
