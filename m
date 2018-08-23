Received: from eggs.gnu.org ([2001:4830:134:3::10]:56011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fsqGQ-00020Z-Mc
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 10:07:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fsqGL-0006QK-9P
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 10:07:04 -0400
Date: Thu, 23 Aug 2018 22:06:47 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180823140647.GC6960@lemon.usersys.redhat.com>
References: <20180823122123.18278-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180823122123.18278-1-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] virtio: update MemoryRegionCaches when
 guest negotiates features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, jasowang@redhat.com, qemu-stable@nongnu.org

On Thu, 08/23 14:21, Paolo Bonzini wrote:
> Because the cache is sized to include the rings and the event indices,
> negotiating the VIRTIO_RING_F_EVENT_IDX feature will result in the size
> of the cache changing.  And because MemoryRegionCache accesses are
> range-checked, if we skip this we end up with an assertion failure.
> This happens with OpenBSD 6.3.
> 
> Reported-by: Fam Zheng <famz@redhat.com>
> Fixes: 97cd965c070152bc626c7507df9fb356bbe1cd81
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Tested-by: Fam Zheng <famz@redhat.com>
