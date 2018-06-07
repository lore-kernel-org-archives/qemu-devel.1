Received: from eggs.gnu.org ([2001:4830:134:3::10]:50006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fQwDX-0001xI-50
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 10:48:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fQwDU-0000QX-2F
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 10:48:47 -0400
Date: Thu, 7 Jun 2018 16:48:33 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <CAFEAcA8NOAME70Sdv7rEV67rp0NEhMqdRqRm=iLQUKmo3oTvLQ@mail.gmail.com>
Message-ID: <alpine.BSF.2.21.1806071641200.90120@zero.eik.bme.hu>
References: <cover.1528291908.git.balaton@eik.bme.hu>
	<fdb61fc16922f78190f0db04a11dd20519cd2fb5.1528291908.git.balaton@eik.bme.hu>
	<CAFEAcA_GwgmiZPQ9NmY9a7_OwYFCBHFZiVQzk1nZEoxYaD+mwQ@mail.gmail.com>
	<alpine.BSF.2.21.1806061619030.42561@zero.eik.bme.hu>
	<CAFEAcA8NOAME70Sdv7rEV67rp0NEhMqdRqRm=iLQUKmo3oTvLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [PATCH v2 7/8] sm501: Do not clear read only bits
 when writing register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>, Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>

On Wed, 6 Jun 2018, Peter Maydell wrote:
> On 6 June 2018 at 15:28, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>> s->whatever &= ro_bits_mask;
>> s->whatever |= value & rw_bits_mask;
>
> Yes, this works (and I have a feeling it's what we tend to use.)

OK, I'll do this then in next respin.

>>>> @@ -853,7 +853,7 @@ static void sm501_system_config_write(void *opaque,
>>>> hwaddr addr,
>>>>          s->dram_control |=  value & 0x7FFFFFC3;
>
> Hmm, does dram_control also need to behave the same way?

It has one read only bit which we are not emulating so maybe not 
significant but changed it as well for correctness and added some more 
similar registers as well.

>>>>          break;
>>>>      case SM501_ARBTRTN_CONTROL:
>>>> -        s->arbitration_control =  value & 0x37777777;
>>>> +        s->arbitration_control = value & 0x37777777;
>>>
>>>
>>> Was this intended to be changed too?
>>
>>
>> Yes, just a simple white space cleanup. Does that worth a separate patch or
>> enough to mention in commit message to make it clear it's intended change?
>
> I would personally put it in its own patch, but if you put it
> in this one do mention it in the commit message. Otherwise
> given the patch is changing four 'foo_control' registers it
> looks like this one was typoed. (It will look less so if
> the change for the others isn't just "add a '|'", though.)

I've left it in one patch to avoid having two many patches in the series 
but added it to commit message together with dram_control which also had 
a whitespace removed in same patch.

Before sending v3 I'm waiting if there are any more comments for other 
patches in this series 
(http://patchew.org/QEMU/cover.1528291908.git.balaton@eik.bme.hu/) but 
looks like David is busy and could not look at them yet. Not sure if 
you've seen these patches but if you have a moment your comments are 
welcome. If no other changes are suggested I'll submit v3 in the coming 
days.

Thank you,
BALATON Zoltan
