Received: from eggs.gnu.org ([2001:4830:134:3::10]:40723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1dJ5qu-0005s8-BX
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 18:24:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1dJ5qp-0007Cf-6G
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 18:24:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:49198)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1dJ5qo-0007C0-VQ
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 18:24:23 -0400
Date: Thu, 8 Jun 2017 15:24:19 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <1496927734-29174-1-git-send-email-owen.smith@citrix.com>
Message-ID: <alpine.DEB.2.10.1706081523240.26108@sstabellini-ThinkPad-X260>
References: <1496927734-29174-1-git-send-email-owen.smith@citrix.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH 0/4] xenfb: Add vkbd-only option
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
> Adds the ability for a vkbd device to connect without the
> QemuConsole, in order to support a standalone PV mouse and
> keyboard frontend.
> This series adds a new feature flag, which will need adding
> to the xen's include/public/io/kbdif.h

Please do so, I would like that change to be applied to xen before this
series is applied to QEMU.


> "feature-vkbd-standalone" is set to 1 by backends that allow 
> the vkbd device model to connect without requiring a vfb device
> connected. The vkbd device will only bypass the check for
> the vfb device if the frontend sets "request-vkbd-standalone"
> to 1.
> The last 2 patches add a couple of missing input handler
> functions, and uses these to remove a leak in the vkbd device
> model.
> 
> Owen Smith (4):
>   xenfb: Add feature-vkbd-standalone
>   xenfb: Activate mouse handler
>   ui/input: Add activate/remove for keyboard handlers
>   xenfb: Fix leak by adding/removing keyboard handler
> 
>  hw/display/xenfb.c   | 44 ++++++++++++++++++++++++++++++++------------
>  include/ui/console.h |  2 ++
>  ui/input-legacy.c    | 12 ++++++++++++
>  3 files changed, 46 insertions(+), 12 deletions(-)
> 
> -- 
> 2.1.4
> 
