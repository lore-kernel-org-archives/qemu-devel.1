Received: from eggs.gnu.org ([209.51.188.92]:42473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gn7aN-0006cL-6Y
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 14:56:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gn7VK-0000uB-9N
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 14:51:07 -0500
References: <cover.1548160772.git.balaton@eik.bme.hu>
	<c323f08c59b9931310c5d92503d370f77ce3a557.1548160772.git.balaton@eik.bme.hu>
	<1485cc74-b10e-bd62-3b42-9dfe9f587d1e@redhat.com>
	<alpine.BSF.2.21.9999.1901240220470.16385@zero.eik.bme.hu>
	<alpine.BSF.2.21.9999.1901251323200.23274@zero.eik.bme.hu>
From: John Snow <jsnow@redhat.com>
Message-ID: <d5d3b195-52eb-aad6-76db-0ed59890732f@redhat.com>
Date: Fri, 25 Jan 2019 14:51:01 -0500
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.21.9999.1901251323200.23274@zero.eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/3] ide/via: Implement and use native PCI
 IDE mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org



On 1/25/19 7:25 AM, BALATON Zoltan wrote:
> On Thu, 24 Jan 2019, BALATON Zoltan wrote:
>> On Wed, 23 Jan 2019, John Snow wrote:
>>> I guess this is technically an external change in behavior... I have no
>>> real read on if this will break anything for anyone, or if anyone was
>>> even using it.
>>
>> Currently nothing but the mips_fulong2e board seems to use this device
>> and I don't think there's anything even on that board that would
>> depend on (or would work with) legacy only IDE mode of this device but
>> I could not find a test image to try. That board seems to be quite
>> unfinished, I've tried to get it in better shape but haven't succeeded
>> yet. So I don't think this change in the IDE device would break
>> anything for anyone as it does not seem to be usable yet but I plan to
>> use this IDE part in subsequent patches and PCI native mode works better.
>>
>>> Any thoughts on why it's okay to switch?
>>
>> As said above it's unlikely anyone would depend on it now and all
>> drivers I know about prefer native mode anyway so likely it would work
>> better after this change. If not and it turns out someone is using the
>> current behaviour I can look at implementing switching between the two
>> modes but that would be more difficult (the ISA ports would need to be
>> mapped and unmapped based on bits in PCI_PROG_INTERFACE but there's no
>> API to do this currently, ide/core.c only has ide_init_ioport to add
>> mapping but not the counterpart to remove it; this could be
>> implemented but unless found to be needed it probably does not worth
>> it). So I suggest to switch based on that this is a quite unused part
>> that's not likely to break anything and if it still found to break
>> something I'll look at fixing it or it could be reverted, but I don't
>> want to spend time now on something that's not actually used.
> 
> I'd appreciated if this could be included now based on the above as I
> have some pathces in the works that will need this, unless there's a
> strong reason to not apply it.
> 
> Thank you,
> BALATON Zoltan

I'll stage it. If anyone disagrees we can roll it back before release if
we are breaking legacy behavior, but I really strongly suspect nobody is
relying on this in any kind of production environment, so I'll take the
risk to just merge the improvement.

--js
