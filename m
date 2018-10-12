Received: from eggs.gnu.org ([2001:4830:134:3::10]:38853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gB1DA-0000DF-JL
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 13:26:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gB1D7-0002Fq-GD
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 13:26:52 -0400
Date: Fri, 12 Oct 2018 13:26:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181012132542-mutt-send-email-mst@kernel.org>
References: <20181012032431.32693-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181012032431.32693-1-david@gibson.dropbear.id.au>
Subject: Re: [Qemu-devel] [RFC 0/5] Improve balloon handling of pagesizes
 other than 4kiB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: dhildenb@redhat.com, imammedo@redhat.com, ehabkost@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

On Fri, Oct 12, 2018 at 02:24:26PM +1100, David Gibson wrote:
> The virtio-balloon devices was never really thought out for cases
> other than 4kiB pagesize on both guest and host.  It works in some
> cases, but in others can be ineffectual or even cause guest memory
> corruption.
> 
> This series makes a handful of preliminary cleanups, then makes a
> change to safely, though not perfectly, handle cases with non 4kiB
> pagesizes.

BTW do you want to add an interface to specify the page size?
I can see either host or guest or both supporting that.

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>


> David Gibson (5):
>   virtio-balloon: Remove unnecessary MADV_WILLNEED on deflate
>   virtio-balloon: Corrections to address verification
>   virtio-balloon: Rework ballon_page() interface
>   virtio-balloon: Use ram_block_discard_range() instead of raw madvise()
>   virtio-balloon: Safely handle BALLOON_PAGE_SIZE < host page size
> 
>  hw/virtio/virtio-balloon.c         | 100 ++++++++++++++++++++++++-----
>  include/hw/virtio/virtio-balloon.h |   3 +
>  2 files changed, 87 insertions(+), 16 deletions(-)
> 
> -- 
> 2.17.1
