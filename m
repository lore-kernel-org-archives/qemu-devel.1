Received: from eggs.gnu.org ([2001:4830:134:3::10]:44373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dave.hansen@intel.com>) id 1dKQ0L-00058j-1z
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 10:07:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dave.hansen@intel.com>) id 1dKQ0H-0005wT-27
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 10:07:41 -0400
Received: from mga04.intel.com ([192.55.52.120]:60551)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dave.hansen@intel.com>)
	id 1dKQ0G-0005vv-Pq
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 10:07:36 -0400
References: <1497004901-30593-1-git-send-email-wei.w.wang@intel.com>
	<1497004901-30593-7-git-send-email-wei.w.wang@intel.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <db8cc3d1-50fc-2412-af2f-1070dda38be3@intel.com>
Date: Mon, 12 Jun 2017 07:07:15 -0700
MIME-Version: 1.0
In-Reply-To: <1497004901-30593-7-git-send-email-wei.w.wang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v11 6/6] virtio-balloon:
 VIRTIO_BALLOON_F_CMD_VQ
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>, virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, david@redhat.com, cornelia.huck@de.ibm.com, akpm@linux-foundation.org, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com

On 06/09/2017 03:41 AM, Wei Wang wrote:
> +	for_each_populated_zone(zone) {
> +		for (order = MAX_ORDER - 1; order > 0; order--) {
> +			for (migratetype = 0; migratetype < MIGRATE_TYPES;
> +			     migratetype++) {
> +				do {
> +					ret = report_unused_page_block(zone,
> +						order, migratetype, &page);
> +					if (!ret) {
> +						pfn = (u64)page_to_pfn(page);
> +						add_one_chunk(vb, vq,
> +						PAGE_CHNUK_UNUSED_PAGE,
> +						pfn << VIRTIO_BALLOON_PFN_SHIFT,
> +						(u64)(1 << order) *
> +						VIRTIO_BALLOON_PAGES_PER_PAGE);
> +					}
> +				} while (!ret);
> +			}
> +		}
> +	}

This is pretty unreadable.    Please add some indentation.  If you go
over 80 cols, then you might need to break this up into a separate
function.  But, either way, it can't be left like this.
