Received: from eggs.gnu.org ([2001:4830:134:3::10]:34758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dkESQ-0003O7-WF
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 15:03:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dkESQ-0005Fq-5b
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 15:03:23 -0400
References: <20170808183306.27474-1-jsnow@redhat.com>
	<20170808183306.27474-2-jsnow@redhat.com>
	<c0250626-4c3a-fa61-a749-387fbabd6934@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <b8e291d5-e8d6-e928-a1f6-54908234db75@redhat.com>
Date: Tue, 22 Aug 2017 15:03:15 -0400
MIME-Version: 1.0
In-Reply-To: <c0250626-4c3a-fa61-a749-387fbabd6934@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/9] IDE: replace DEBUG_IDE with tracing
 system
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org



On 08/08/2017 04:00 PM, Eric Blake wrote:
> On 08/08/2017 01:32 PM, John Snow wrote:
>> Out with the old, in with the new.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
> 
>>  hw/ide/piix.c             | 11 ++++----
>>  hw/ide/trace-events       | 33 ++++++++++++++++++++++++
>>  hw/ide/via.c              | 10 +++-----
> 
> Hmm - should we tweak scripts/git.orderfile to prioritize trace-events
> over .c files? Then again, right now it prioritizes all .c files before
> anything that didn't match, so that things like trace-events will at
> least avoid falling in the middle of a patch if you use the project's
> orderfile.
> 
>> +++ b/hw/ide/cmd646.c
>> @@ -32,6 +32,7 @@
>>  #include "sysemu/dma.h"
>>  
>>  #include "hw/ide/pci.h"
>> +#include "trace.h"
>>  
>>  /* CMD646 specific */
>>  #define CFR		0x50
>> @@ -195,9 +196,8 @@ static uint64_t bmdma_read(void *opaque, hwaddr addr,
>>          val = 0xff;
>>          break;
>>      }
>> -#ifdef DEBUG_IDE
>> -    printf("bmdma: readb " TARGET_FMT_plx " : 0x%02x\n", addr, val);
>> -#endif
> 
> Yay for killing code prone to bitrot.
> 
>> +++ b/hw/ide/core.c
> 
>> @@ -2054,18 +2044,18 @@ void ide_exec_cmd(IDEBus *bus, uint32_t val)
>>      }
> 
>>      hob = 0;
>> -    switch(addr) {
>> +    switch(reg_num) {
> 
> Worth fixing the style to put space after switch while touching this?
> 
>> +++ b/hw/ide/trace-events
>> @@ -0,0 +1,33 @@
>> +# See docs/devel/tracing.txt for syntax documentation.
>> +
>> +# hw/ide/core.c
> 
>> +
>> +# hw/ide/pci.c
>> +bmdma_reset(void) ""
> 
> An empty trace? Do all the backends support it?
> 

Not the first instance of this, so I'm assuming yes.
