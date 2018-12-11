Received: from eggs.gnu.org ([2001:4830:134:3::10]:57912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=8761f1f8f=anthony.perard@citrix.com>)
	id 1gWjrM-0005CV-38
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 10:22:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=8761f1f8f=anthony.perard@citrix.com>)
	id 1gWjrK-0002MJ-Fl
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 10:22:08 -0500
Date: Tue, 11 Dec 2018 15:21:29 +0000
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20181211152129.GS18875@perard.uk.xensource.com>
References: <1544525238-3527-1-git-send-email-paul.durrant@citrix.com>
	<1544525238-3527-6-git-send-email-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1544525238-3527-6-git-send-email-paul.durrant@citrix.com>
Subject: Re: [Qemu-devel] [PATCH v3 05/18] xen: add xenstore watcher
 infrastructure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <paul.durrant@citrix.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, xen-devel@lists.xenproject.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>

On Tue, Dec 11, 2018 at 10:47:05AM +0000, Paul Durrant wrote:
> A Xen PV frontend communicates its state to the PV backend by writing to
> the 'state' key in the frontend area in xenstore. It is therefore
> necessary for a XenDevice implementation to be notified whenever the
> value of this key changes.
> 
> This patch adds code to do this as follows:
> 
> - an 'fd handler' is registered on the libxenstore handle which will be
>   triggered whenever a 'watch' event occurs
> - primitives are added to xen-bus-helper to add or remove watch events
> - a list of Notifier objects is added to XenBus to provide a mechanism
>   to call the appropriate 'watch handler' when its associated event
>   occurs
> 
> The xen-block implementation is extended with a 'frontend_changed' method,
> which calls as-yet stub 'connect' and 'disconnect' functions when the
> relevant frontend state transitions occur. A subsequent patch will supply
> a full implementation for these functions.
> 
> Signed-off-by: Paul Durrant <paul.durrant@citrix.com>

Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>

-- 
Anthony PERARD
