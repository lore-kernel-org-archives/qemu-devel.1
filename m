Received: from eggs.gnu.org ([209.51.188.92]:36699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=9966e4c82=anthony.perard@citrix.com>)
	id 1hEBYE-00088a-0c
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 07:37:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=9966e4c82=anthony.perard@citrix.com>)
	id 1hEBYC-0003pe-Ux
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 07:37:57 -0400
Date: Wed, 10 Apr 2019 12:37:42 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20190410113742.GD1435@perard.uk.xensource.com>
References: <20190408151617.13025-1-paul.durrant@citrix.com>
	<20190408151617.13025-2-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190408151617.13025-2-paul.durrant@citrix.com>
Subject: Re: [Qemu-devel] [PATCH 1/3] xen-bus: use a separate fd for each
 event channel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <paul.durrant@citrix.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, xen-devel@lists.xenproject.org, Stefano Stabellini <sstabellini@kernel.org>

On Mon, Apr 08, 2019 at 04:16:15PM +0100, Paul Durrant wrote:
> To better support use of IOThread-s it will be necessary to be able to set
> the AioContext for each XenEventChannel and hence it is necessary to open a
> separate handle to libxenevtchan for each channel.
> 
> This patch stops using NotifierList for event channel callbacks, replacing
> that construct by a list of complete XenEventChannel structures. Each of
> these now has a xenevtchn_handle pointer in place of the single pointer
> previously held in the XenDevice structure. The individual handles are
> opened/closed in xen_device_bind/unbind_event_channel(), replacing the
> single open/close in xen_device_realize/unrealize().
> 
> NOTE: This patch does not add an AioContext parameter to
>       xen_device_bind_event_channel(). That will be done in a subsequent
>       patch.
> 
> Signed-off-by: Paul Durrant <paul.durrant@citrix.com>

Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>

There are a few places were I would have like to add an assert, but they
can't be compiled-out in QEMU :-(.

Thanks,

-- 
Anthony PERARD
