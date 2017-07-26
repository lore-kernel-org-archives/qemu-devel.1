Received: from eggs.gnu.org ([2001:4830:134:3::10]:38329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1daRNj-00033M-Ni
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 14:50:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1daRNh-0004UZ-Qe
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 14:50:02 -0400
References: <20170721183243.22706-1-eblake@redhat.com>
	<20170721183243.22706-2-eblake@redhat.com>
	<76a5ebbd-5261-a3f0-2dc1-a236c6c3f97a@redhat.com>
	<7c61246c-3098-3b8f-bb1a-fec58d80961d@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <98e135f6-fe4e-d572-5567-bddbf8ef86c0@redhat.com>
Date: Wed, 26 Jul 2017 14:49:46 -0400
MIME-Version: 1.0
In-Reply-To: <7c61246c-3098-3b8f-bb1a-fec58d80961d@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] dirty-bitmap: Report
 BlockDirtyInfo.count in bytes, as documented
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, qemu-stable@nongnu.org, Max Reitz <mreitz@redhat.com>, stefanha@redhat.com



On 07/25/2017 05:37 PM, Eric Blake wrote:
> On 07/25/2017 04:28 PM, John Snow wrote:
>>
>>
>> On 07/21/2017 02:32 PM, Eric Blake wrote:
>>> We've been documenting the value in bytes since its introduction
>>> in commit b9a9b3a4 (v1.3), where it was actually reported in bytes.
>>>
>>> Commit e4654d2 (v2.0) then removed things from block/qapi.c, in
>>> preparation for a rewrite to a list of dirty sectors in the next
>>> commit 21b5683 in block.c, but the new code mistakenly started
>>> reporting in sectors.
>>>
>>> Fixes: https://bugzilla.redhat.com/1441460
>>>
>>> CC: qemu-stable@nongnu.org
>>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>> Reviewed-by: John Snow <jsnow@redhat.com>
>>>
>>
>> I must have forgotten about this -- Didn't this get reviewed as part of
>> your byte series? Is this a resend for a stable branch?
> 
> Yes, it was reviewed during my part 2-of-4 series on byte-base block
> status (the dirty bitmap series).  Series 1 made it into 2.10, but
> series 2-4 did not; ergo, I filtered out the true bug-fixes that were
> still worthy post-freeze.
> 

Thanks for the clarification. Short term memory is a little strapped 
right now due to my move.

ACK
