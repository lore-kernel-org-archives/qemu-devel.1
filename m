Received: from eggs.gnu.org ([2001:4830:134:3::10]:33300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eK3CP-0001Cy-O5
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 09:18:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eK3CL-0006Lm-OS
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 09:18:53 -0500
Received: from mga04.intel.com ([192.55.52.120]:30118)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1eK3CL-0006LQ-EU
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 09:18:49 -0500
Message-ID: <5A1EC23A.5090900@intel.com>
Date: Wed, 29 Nov 2017 22:20:42 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1509696786-1597-1-git-send-email-wei.w.wang@intel.com>
	<1509696786-1597-3-git-send-email-wei.w.wang@intel.com>
	<20171106170000.GA1195@bombadil.infradead.org>
In-Reply-To: <20171106170000.GA1195@bombadil.infradead.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v17 2/6] radix tree test suite: add tests
 for xbitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Matthew Wilcox <willy@infradead.org>
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org, mawilcox@microsoft.com, david@redhat.com, penguin-kernel@I-love.SAKURA.ne.jp, cornelia.huck@de.ibm.com, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu@aliyun.com

On 11/07/2017 01:00 AM, Matthew Wilcox wrote:
> On Fri, Nov 03, 2017 at 04:13:02PM +0800, Wei Wang wrote:
>> From: Matthew Wilcox <mawilcox@microsoft.com>
>>
>> Add the following tests for xbitmap:
>> 1) single bit test: single bit set/clear/find;
>> 2) bit range test: set/clear a range of bits and find a 0 or 1 bit in
>> the range.
>>
>> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
>> Cc: Matthew Wilcox <mawilcox@microsoft.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Michael S. Tsirkin <mst@redhat.com>
>> ---
>>   tools/include/linux/bitmap.h            |  34 ++++
>>   tools/include/linux/kernel.h            |   2 +
>>   tools/testing/radix-tree/Makefile       |   7 +-
>>   tools/testing/radix-tree/linux/kernel.h |   2 -
>>   tools/testing/radix-tree/main.c         |   5 +
>>   tools/testing/radix-tree/test.h         |   1 +
>>   tools/testing/radix-tree/xbitmap.c      | 278 ++++++++++++++++++++++++++++++++
> Umm.  No.  You've duplicated xbitmap.c into the test framework, so now it can
> slowly get out of sync with the one in lib/.  That's not OK.
>
> Put it back the way it was, with the patch I gave you as patch 1/n
> (relocating xbitmap.c from tools/testing/radix-tree to lib/).
> Then add your enhancements as patch 2/n.  All you should need to
> change in your 1/n from
> http://git.infradead.org/users/willy/linux-dax.git/commit/727e401bee5ad7d37e0077291d90cc17475c6392
> is a bit of Makefile tooling.  Leave the test suite embedded in the file;
> that way people might remember to update the test suite when adding
> new functionality.
>

Thanks for you suggestions. Please have a check the v18 patches:
The original implementation is put in patch 4, and the proposed changes 
are separated into patch 5 (we can merge them to patch 4 later if they 
look good to you), and the new APIs are in patch 6.

Best,
Wei
