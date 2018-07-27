Received: from eggs.gnu.org ([2001:4830:134:3::10]:41293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fj4ON-0004TZ-An
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 11:10:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fj4OI-0005E2-BU
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 11:10:55 -0400
Received: from chuckie.co.uk ([82.165.15.123]:35779
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1fj4OI-0005DR-3S
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 11:10:50 -0400
References: <20180727123112.13707-1-dgilbert@redhat.com>
	<d09b7607-a23b-7c05-9faf-7ec0000684af@ilande.co.uk>
	<20180727134453.GB2498@work-vm>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <c8608e2e-35da-d095-193a-626d0d47c036@ilande.co.uk>
Date: Fri, 27 Jul 2018 16:10:28 +0100
MIME-Version: 1.0
In-Reply-To: <20180727134453.GB2498@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] macio/pmu: Fix missing vmsd terminator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, agraf@suse.de

On 27/07/18 14:44, Dr. David Alan Gilbert wrote:

> * Mark Cave-Ayland (mark.cave-ayland@ilande.co.uk) wrote:
>> On 27/07/18 13:31, Dr. David Alan Gilbert (git) wrote:
>>
>>> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>>>
>>> Fix missing terminator in VMStateDescription
>>>
>>> Fixes: d811d61fbc6ca5f2be2185fd7cfa916e7ba613ce
>>> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>>> ---
>>>    hw/misc/macio/pmu.c | 1 +
>>>    1 file changed, 1 insertion(+)
>>>
>>> diff --git a/hw/misc/macio/pmu.c b/hw/misc/macio/pmu.c
>>> index e246b0fd41..27dfaf8a74 100644
>>> --- a/hw/misc/macio/pmu.c
>>> +++ b/hw/misc/macio/pmu.c
>>> @@ -686,6 +686,7 @@ static const VMStateDescription vmstate_pmu_adb = {
>>>            VMSTATE_TIMER_PTR(adb_poll_timer, PMUState),
>>>            VMSTATE_UINT8(adb_reply_size, PMUState),
>>>            VMSTATE_BUFFER(adb_reply, PMUState),
>>> +        VMSTATE_END_OF_LIST()
>>>        }
>>>    };
>>
>> Gah, yes indeed it certainly looks like I missed this whilst working on the
>> PMU code :(
>>
>> Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>
>> Just out of interest does a savevm/loadvm migration still succeed once this
>> has been added?
> 
> Have you got a suggested command line to test it with?

I'm effectively AFK until tomorrow now, but just quickly:

$ ./qemu-system-ppc -M mac99,via=pmu

Note that PMU support is new for 3.0 so there shouldn't be any backward 
compatibility issue here.


ATB,

Mark.
