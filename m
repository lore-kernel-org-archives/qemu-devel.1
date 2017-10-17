Received: from eggs.gnu.org ([2001:4830:134:3::10]:59608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joeclifford@gmail.com>) id 1e4FOd-000470-TO
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 20:06:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joeclifford@gmail.com>) id 1e4FOc-0000Pn-So
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 20:06:11 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:49536)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <joeclifford@gmail.com>)
	id 1e4FOc-0000PX-MQ
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 20:06:10 -0400
Received: by mail-pg0-x242.google.com with SMTP id g6so5641pgn.6
	for <qemu-devel@nongnu.org>; Mon, 16 Oct 2017 17:06:10 -0700 (PDT)
References: <20171016144302.24284-1-david@redhat.com>
	<3fea07b0-e3b6-c880-f7d2-ca152874ac7e@redhat.com>
From: Joe Clifford <joeclifford@gmail.com>
Message-ID: <aa684e24-d432-7cb9-3638-0ac802dffdda@gmail.com>
Date: Tue, 17 Oct 2017 01:06:01 +0100
MIME-Version: 1.0
In-Reply-To: <3fea07b0-e3b6-c880-f7d2-ca152874ac7e@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 0/7] kvm: slot handling fixes (and small
 cleanups)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>

On 16/10/17 17:20, Paolo Bonzini wrote:
> On 16/10/2017 16:42, David Hildenbrand wrote:
>> Hopefully this is the last bunch of fixes for the cleanup series.
>>
>> 1. log_start() was called before region_add(), which is wrong.
>> 2. I messed up the calculation of the delta when aligning the ram address
>>     (maybe we should simply also use ROUND_UP there ...).
>> 3. I think we could get log_start/log_stop/log_sync when we actually
>>     haven't registered a slot (due to trapping).
>> 4. Some further cleanups
>>
>> Available on: https://github.com/davidhildenbrand/qemu/commits/kvm_slot
>>
>> @Joe, if you could retest, this would be great! I updated the branch.
>>
>> David Hildenbrand (7):
>>    memory: call log_start after region_add
>>    kvm: fix alignment of ram address
>>    kvm: tolerate non-existing slot for log_start/log_stop/log_sync
>>    kvm: fix error message when failing to unregister slot
>>    kvm: region_add and region_del is not called on updates
>>    kvm: simplify kvm_align_section()
>>    memory: reuse section_from_flat_range()
>>
>>   accel/kvm/kvm-all.c | 39 ++++++++++++++-------------------------
>>   memory.c            | 16 +++++-----------
>>   2 files changed, 19 insertions(+), 36 deletions(-)
>>
> 
> Looks good!  I'll wait for testing results if they come soon.
> 
> Paolo
> 

Hi,

I've pulled the updates from David's repo and tested the same branch 
(kvm_slot) and they work beautifully for me. Thanks for fixing this David!

Joe
