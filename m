Received: from eggs.gnu.org ([2001:4830:134:3::10]:36106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1dKir5-0006T4-5a
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 06:15:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1dKir1-0002wV-7O
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 06:15:23 -0400
Received: from mga07.intel.com ([134.134.136.100]:39496)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1dKir0-0002wP-UX
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 06:15:19 -0400
Message-ID: <593FBBBC.3060603@intel.com>
Date: Tue, 13 Jun 2017 18:17:32 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1497004901-30593-1-git-send-email-wei.w.wang@intel.com>
	<1497004901-30593-7-git-send-email-wei.w.wang@intel.com>
	<db8cc3d1-50fc-2412-af2f-1070dda38be3@intel.com>
In-Reply-To: <db8cc3d1-50fc-2412-af2f-1070dda38be3@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: Dave Hansen <dave.hansen@intel.com>, virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, david@redhat.com, cornelia.huck@de.ibm.com, akpm@linux-foundation.org, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com

On 06/12/2017 10:07 PM, Dave Hansen wrote:
> On 06/09/2017 03:41 AM, Wei Wang wrote:
>> +	for_each_populated_zone(zone) {
>> +		for (order = MAX_ORDER - 1; order > 0; order--) {
>> +			for (migratetype = 0; migratetype < MIGRATE_TYPES;
>> +			     migratetype++) {
>> +				do {
>> +					ret = report_unused_page_block(zone,
>> +						order, migratetype, &page);
>> +					if (!ret) {
>> +						pfn = (u64)page_to_pfn(page);
>> +						add_one_chunk(vb, vq,
>> +						PAGE_CHNUK_UNUSED_PAGE,
>> +						pfn << VIRTIO_BALLOON_PFN_SHIFT,
>> +						(u64)(1 << order) *
>> +						VIRTIO_BALLOON_PAGES_PER_PAGE);
>> +					}
>> +				} while (!ret);
>> +			}
>> +		}
>> +	}
> This is pretty unreadable.    Please add some indentation.  If you go
> over 80 cols, then you might need to break this up into a separate
> function.  But, either way, it can't be left like this.

OK, I'll re-arrange it.

Best,
Wei
