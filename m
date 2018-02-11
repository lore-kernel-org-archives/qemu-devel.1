Received: from eggs.gnu.org ([2001:4830:134:3::10]:41511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ekpM2-00045u-1Q
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 05:59:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ekpLz-0003Br-C6
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 05:59:30 -0500
References: <20180209185142.17151-1-mark.cave-ayland@ilande.co.uk>
	<20180209185142.17151-6-mark.cave-ayland@ilande.co.uk>
	<20180210223214.GS11634@umbus.fritz.box>
	<20180210231103.GV11634@umbus.fritz.box>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <ccd8f330-6ab2-977b-09a6-0c259398052e@ilande.co.uk>
Date: Sun, 11 Feb 2018 10:59:05 +0000
MIME-Version: 1.0
In-Reply-To: <20180210231103.GV11634@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCHv2 05/12] cuda: rename frequency property to
 tb_frequency
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: lvivier@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 10/02/18 23:11, David Gibson wrote:

> On Sun, Feb 11, 2018 at 09:32:14AM +1100, David Gibson wrote:
>> On Fri, Feb 09, 2018 at 06:51:35PM +0000, Mark Cave-Ayland wrote:
>>> This allows us to more easily differentiate between the timebase frequency used
>>> to calibrate the MacOS timers and the actual frequency of the hardware clock as
>>> indicated by CUDA_TIMER_FREQ.
>>>
>>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>
>> Applied, thanks.
> 
> Actually, this patch doesn't compile, because you've changed
> ti->frequency in a couple of places where you should only be changing
> s->frequency.  I've fixed it up in my tree.

Ah apologies there - this was a mistake I made quite early on in the 
patchset which I must have accidentally brought back in during a 
subsequent rebase :(

I've just done a check on patch 7 ("cuda: set timer 1 frequency property 
to CUDA_TIMER_FREQ") and confirmed that the cuda.c version in your 
ppc-for-2.12 branch matches that in my local branch, so your fixups are 
good.

Any thoughts on the last few patches? I know Philippe had a question for 
Stefan re: the trace-events patch, however it would be useful for 
patches 10/11 to be applied as they complete the transition from CUDA 
over to using the mos6522 device (also providing an initial example as 
to how it can be used).


ATB,

Mark.
