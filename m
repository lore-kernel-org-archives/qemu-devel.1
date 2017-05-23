Received: from eggs.gnu.org ([2001:4830:134:3::10]:60551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dDFzw-0001dc-HP
	for qemu-devel@nongnu.org; Tue, 23 May 2017 16:01:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dDFzt-0007dS-Ft
	for qemu-devel@nongnu.org; Tue, 23 May 2017 16:01:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58206)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dDFzt-0007d9-Aa
	for qemu-devel@nongnu.org; Tue, 23 May 2017 16:01:37 -0400
References: <20170523030312.6360-1-rth@twiddle.net>
	<20170523030312.6360-3-rth@twiddle.net>
	<20170523104851.37tseiq5zlpwevr6@aurel32.net>
	<d059a3b3-ac6c-27d2-5270-b6d5b32cc41d@twiddle.net>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ed13c091-3f0f-db86-861f-01a0823d117d@redhat.com>
Date: Tue, 23 May 2017 22:01:31 +0200
MIME-Version: 1.0
In-Reply-To: <d059a3b3-ac6c-27d2-5270-b6d5b32cc41d@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 02/31] target/s390x: Implement EXECUTE via
 new TranslationBlock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>
Cc: qemu-devel@nongnu.org

On 23.05.2017 17:54, Richard Henderson wrote:
> On 05/23/2017 03:48 AM, Aurelien Jarno wrote:
>> On 2017-05-22 20:02, Richard Henderson wrote:
>>> Previously, helper_ex would construct the insn and then implement
>>> the insn via direct calls other helpers.  This was sufficient to
>>> boot Linux but that is all.
>>>
>>> It is easy enough to go the whole nine yards by stashing state for
>>> EXECUTE within the cpu, and then relying on a new TB to be created
>>> that properly and completely interprets the insn.
>>>
>>> Signed-off-by: Richard Henderson <rth@twiddle.net>
>>> ---
>>>   target/s390x/cpu.h         |   4 +-
>>>   target/s390x/helper.h      |   2 +-
>>>   target/s390x/insn-data.def |   4 +-
>>>   target/s390x/machine.c     |  19 +++++++
>>>   target/s390x/mem_helper.c  | 136
>>> +++++++++++----------------------------------
>>>   target/s390x/translate.c   | 124
>>> +++++++++++++++++++++++++----------------
>>>   6 files changed, 133 insertions(+), 156 deletions(-)
>>
>> This looks good on the principle, and finally removes a big hack. That
>> said it prevent my test system to boot. I haven't investigated why yet.
> 
> Hmm.  I've not got a complete environment -- merely booting a kernel up
> to the point it fails to find a rootfs.  Which did find several problems
> with my first attempts at this, but wouldn't have exercised paging. 
> I'll try again to get a full install working...

Something nice for a quick test is also:

http://www.qemu-advent-calendar.org/2014/download/s390-moon-buggy.tar.xz

Not sure whether it will trigger your EXECUTE problem, though.

 Thomas
