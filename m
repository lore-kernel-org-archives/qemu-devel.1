Received: from eggs.gnu.org ([2001:4830:134:3::10]:42381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1gXh1W-0004xQ-0q
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 01:32:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1gXh1S-0008V8-Tv
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 01:32:34 -0500
Received: from mga04.intel.com ([192.55.52.120]:47504)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1gXh1S-0008Pj-CS
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 01:32:30 -0500
Message-ID: <5C134FAE.9030300@intel.com>
Date: Fri, 14 Dec 2018 14:37:34 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1544516693-5395-1-git-send-email-wei.w.wang@intel.com>
	<1544516693-5395-2-git-send-email-wei.w.wang@intel.com>
	<20181213142800.GO2313@work-vm>
In-Reply-To: <20181213142800.GO2313@work-vm>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v11 1/7] bitmap: fix bitmap_count_one
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, quintela@redhat.com, peterx@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, nilal@redhat.com, riel@redhat.com

On 12/13/2018 10:28 PM, Dr. David Alan Gilbert wrote:
> * Wei Wang (wei.w.wang@intel.com) wrote:
>> BITMAP_LAST_WORD_MASK(nbits) returns 0xffffffff when "nbits=0", which
>> makes bitmap_count_one fail to handle the "nbits=0" case. It appears to be
>> preferred to remain BITMAP_LAST_WORD_MASK identical to the kernel
>> implementation that it is ported from.
>>
>> So this patch fixes bitmap_count_one to handle the nbits=0 case.
> OK; it's a little odd that it's only bitmap_count_one that's being fixed
> for this case; but OK.
>
>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Thanks.

We could also help fix other callers outside this series.
(this one is put here as it helps this optimization feature avoid that 
issue).

Best,
Wei
