Received: from eggs.gnu.org ([2001:4830:134:3::10]:48650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cnobn-0005mB-NZ
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 11:43:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cnobi-0004vg-T6
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 11:43:35 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:36841)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cnobi-0004uk-Ms
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 11:43:30 -0400
Received: by mail-wr0-x233.google.com with SMTP id u108so126632977wrb.3
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 08:43:30 -0700 (PDT)
References: <20170303131113.25898-1-pbonzini@redhat.com>
	<20170303131113.25898-6-pbonzini@redhat.com>
	<871su1qfsu.fsf@linaro.org>
	<834de521-e5cc-8857-afeb-8734037f95f3@redhat.com>
	<87y3w9oxff.fsf@linaro.org>
	<2d503aaa-4853-a325-bc13-983528d02e09@redhat.com>
	<bb926742-7dbe-1147-4629-da565146a450@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <bb926742-7dbe-1147-4629-da565146a450@redhat.com>
Date: Tue, 14 Mar 2017 15:43:45 +0000
Message-ID: <87r31zq2xa.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 5/5] icount: process QEMU_CLOCK_VIRTUAL
 timers in vCPU thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org


Paolo Bonzini <pbonzini@redhat.com> writes:

> On 14/03/2017 11:05, Paolo Bonzini wrote:
>>
>>
>> On 13/03/2017 19:15, Alex Bennée wrote:
>>>> Well yeah, it's all those that pass qemu_clock_use_for_deadline.
>>>
>>> Have you done any testing with record/replay? So far I have one
>>> reproducible run and one failure. However it is not entirely clear to me
>>> how I am meant to cleanly halt and stop a machine so I don't corrupt the
>>> replay log.
>>
>> No, I haven't tried RR.
>
> Tried now, it doesn't work but I won't have time to fix it.
>
> I tried "-kernel /path/to/bzImage -icount 3,rr=record,rrfile=replay.bin
> -net none".  record works, replay hangs.  The hang is at a "pause"
> instruction.  With "-d in_asm" it still hangs, but a bit later (still in
> the firmware).

I'm happy to keep digging.

So to be clear when you do the record step how do you save your state
before you replay?

I was just entering the MMI and typing quit but that seems to leave the
log in a broken state.

--
Alex Bennée
