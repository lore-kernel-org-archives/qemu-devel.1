Received: from eggs.gnu.org ([2001:4830:134:3::10]:37726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dave.hansen@intel.com>) id 1dKq5y-0001zx-RB
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 13:59:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dave.hansen@intel.com>) id 1dKq5v-0005XX-Qf
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 13:59:14 -0400
Received: from mga14.intel.com ([192.55.52.115]:22156)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dave.hansen@intel.com>)
	id 1dKq5v-0005Wg-I7
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 13:59:11 -0400
References: <1497004901-30593-1-git-send-email-wei.w.wang@intel.com>
	<1497004901-30593-4-git-send-email-wei.w.wang@intel.com>
	<20170613200049-mutt-send-email-mst@kernel.org>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <fb67359c-3d19-f67f-ec47-3cf868b8d9e8@intel.com>
Date: Tue, 13 Jun 2017 10:59:07 -0700
MIME-Version: 1.0
In-Reply-To: <20170613200049-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v11 3/6] virtio-balloon:
 VIRTIO_BALLOON_F_PAGE_CHUNKS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Wei Wang <wei.w.wang@intel.com>
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, david@redhat.com, cornelia.huck@de.ibm.com, akpm@linux-foundation.org, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, Matthew Wilcox <willy@infradead.org>

On 06/13/2017 10:56 AM, Michael S. Tsirkin wrote:
>> +/* The size of one page_bmap used to record inflated/deflated pages. */
>> +#define VIRTIO_BALLOON_PAGE_BMAP_SIZE	(8 * PAGE_SIZE)
> At this size, you probably want alloc_pages to avoid kmalloc
> overhead.

For slub, at least, kmalloc() just calls alloc_pages() basically
directly.  There's virtually no overhead.
