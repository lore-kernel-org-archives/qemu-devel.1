Received: from eggs.gnu.org ([2001:4830:134:3::10]:51763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gTgew-0007W7-Q0
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 00:20:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gTget-0006pL-Mp
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 00:20:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:22840)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1gTget-0006op-Gy
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 00:20:39 -0500
Date: Mon, 3 Dec 2018 13:20:21 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20181203052021.GC27620@xz-x1>
References: <1543803511-34793-1-git-send-email-wei.w.wang@intel.com>
	<1543803511-34793-6-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1543803511-34793-6-git-send-email-wei.w.wang@intel.com>
Subject: Re: [Qemu-devel] [PATCH v10 5/7] migration/ram.c: add a notifier
 chain for precopy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, quintela@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, nilal@redhat.com, riel@redhat.com

On Mon, Dec 03, 2018 at 10:18:29AM +0800, Wei Wang wrote:
> This patch adds a notifier chain for the memory precopy. This enables various
> precopy optimizations to be invoked at specific places.
> 
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
> CC: Juan Quintela <quintela@redhat.com>
> CC: Michael S. Tsirkin <mst@redhat.com>
> CC: Peter Xu <peterx@redhat.com>
> ---

[...]

> +int precopy_notify(PrecopyNotifyReason reason, Error **errp);

This function could be hidden from include/migration/misc.h, but I
don't know whether that is a reason for a repost.

And what I meant was that we fail precopy if notifier failed the
hooks, but warning is fine too anyway no real use case there.

Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks,

-- 
Peter Xu
