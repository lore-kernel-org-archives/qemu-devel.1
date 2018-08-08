Received: from eggs.gnu.org ([2001:4830:134:3::10]:37379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1fnDF4-0002Bk-HN
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 21:26:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1fnDF1-0007Yp-Cu
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 21:26:26 -0400
Received: from mga02.intel.com ([134.134.136.20]:29806)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1fnDF1-0007UJ-2D
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 21:26:23 -0400
Message-ID: <5B6A47C2.5000008@intel.com>
Date: Wed, 08 Aug 2018 09:30:42 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1533031278-5615-1-git-send-email-wei.w.wang@intel.com>
	<20180807073905.GA7265@xz-mi> <5B69567B.8050309@intel.com>
	<20180807121746.GB7265@xz-mi>
In-Reply-To: <20180807121746.GB7265@xz-mi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] bitmap: fix BITMAP_LAST_WORD_MASK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, quintela@redhat.com, mst@redhat.com

On 08/07/2018 08:17 PM, Peter Xu wrote:
> On Tue, Aug 07, 2018 at 04:21:15PM +0800, Wei Wang wrote:
>> On 08/07/2018 03:39 PM, Peter Xu wrote:
>>> On Tue, Jul 31, 2018 at 06:01:18PM +0800, Wei Wang wrote:
>>>> When "nbits = 0", which means no bits to mask, this macro is expected to
>>>> return 0, instead of 0xffffffff. This patch changes the macro to return
>>>> 0 when there is no bit needs to be masked.
>>>>
>>>> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
>>>> CC: Juan Quintela <quintela@redhat.com>
>>>> CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
>>>> CC: Peter Xu <peterx@redhat.com>
>>> Reviewed-by: Peter Xu <peterx@redhat.com>
>>>
>>> Is there any existing path that can trigger this nbits==0?
>> Not sure about other bitmap APIs which call this macro. But it happens in
>> the patches we are working on, which use bitmap_count_one.
>> It would be good to have the macro itself handle this corner case, so that
>> callers won't need to worry about that.
> Yeah that makes sense.  Asked since that would matter on whether it's
> 3.0 material, then it's possibly not.
>

OK, thanks for checking.

Best,
Wei
