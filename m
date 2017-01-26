Received: from eggs.gnu.org ([2001:4830:134:3::10]:46195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1cWexC-0003e7-3k
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 02:58:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1cWex8-0001Ys-6i
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 02:58:46 -0500
References: <1476117341-32690-1-git-send-email-drjones@redhat.com>
	<1476117341-32690-3-git-send-email-drjones@redhat.com>
	<CAFEAcA92X+oCMji_bnWkjRWvqQ+CyqrR0ogy-SKOGW7TRYsZ3g@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <6442c7ab-a539-c1e2-bb54-23d4643bba65@redhat.com>
Date: Thu, 26 Jan 2017 08:58:31 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA92X+oCMji_bnWkjRWvqQ+CyqrR0ogy-SKOGW7TRYsZ3g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] hw/arm/virt: no ITS on older machine
 types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

Hi Peter,

On 20/01/2017 16:52, Peter Maydell wrote:
> On 10 October 2016 at 17:35, Andrew Jones <drjones@redhat.com> wrote:
>> We should avoid exposing new hardware (through DT and ACPI) on older
>> machine types. This patch keeps 2.7 and older from changing, despite
>> the introduction of ITS support for 2.8.
>>
>> Signed-off-by: Andrew Jones <drjones@redhat.com>
>> ---
>>
>> As Eduardo pointed out long ago for a different reason, we should
>> probably replace VirtGuestInfo with direct use of VirtMachineClass,
>> like x86 has done to replace PcGuestInfo with direct use of
>> PCMachineClass. I'll work on that, but wanted to get this ITS
>> fixup in sooner than later, so I'm posting this patch now, which
>> requires 'no_its' to be duplicated.
> 
> So this patch added a no_its flag which gets set for virt-2.7
> and earlier, but there's no user-facing way to say "I'd like
> a virt-2.8 board with no ITS", right? That's a bit unfortunate
> because the ITS can't be migrated, which means there's no way
> to ask for a post-2.7 virt board which can be migrated...

Sorry for the delay.

For 2.9 machine I can add a new property that would allow the user to
deselect the ITS. Would that make sense?

Thanks

Eric


> thanks
> -- PMM
> 
