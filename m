Received: from eggs.gnu.org ([2001:4830:134:3::10]:50162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gTgTG-0001uR-VA
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 00:08:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gTgTD-0000AW-SZ
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 00:08:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46492)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1gTgTD-00008z-NL
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 00:08:35 -0500
Date: Mon, 3 Dec 2018 13:08:23 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20181203050823.GA27620@xz-x1>
References: <1543803511-34793-1-git-send-email-wei.w.wang@intel.com>
	<1543803511-34793-4-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1543803511-34793-4-git-send-email-wei.w.wang@intel.com>
Subject: Re: [Qemu-devel] [PATCH v10 3/7] migration: use bitmap_mutex in
 migration_bitmap_clear_dirty
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

On Mon, Dec 03, 2018 at 10:18:27AM +0800, Wei Wang wrote:
> The bitmap mutex is used to synchronize threads to update the dirty
> bitmap and the migration_dirty_pages counter. For example, the free
> page optimization clears bits of free pages from the bitmap in an
> iothread context. This patch makes migration_bitmap_clear_dirty update
> the bitmap and counter under the mutex.
> 
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
> CC: Juan Quintela <quintela@redhat.com>
> CC: Michael S. Tsirkin <mst@redhat.com>
> CC: Peter Xu <peterx@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu
