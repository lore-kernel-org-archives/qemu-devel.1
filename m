Received: from eggs.gnu.org ([2001:4830:134:3::10]:32808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fBLWS-00084V-Sm
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 10:35:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fBLWP-0007Yr-Mk
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 10:35:52 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180306203103.25563-1-mark.cave-ayland@ilande.co.uk>
	<20180306203103.25563-18-mark.cave-ayland@ilande.co.uk>
	<20180321032924.GP3905@umbus.fritz.box>
	<08c7c486-850c-ce0b-71f8-1cb505028d5c@amsat.org>
	<16bbd1be-1d4a-b158-884b-9cda30502816@ilande.co.uk>
	<a16e6be7-a927-3ede-b5c4-c75d440d3213@ilande.co.uk>
	<a4f18bda-f67c-197c-c7fd-9bfc31c26f36@ilande.co.uk>
	<20180425063424.GU19804@umbus.fritz.box>
	<1e426fef-9504-f53b-2e5d-3376ed9b6032@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <781ba630-4708-fae2-9545-5355cddda875@amsat.org>
Date: Wed, 25 Apr 2018 11:35:45 -0300
MIME-Version: 1.0
In-Reply-To: <1e426fef-9504-f53b-2e5d-3376ed9b6032@ilande.co.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 17/19] uninorth: create new uninorth device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 04/25/2018 03:58 AM, Mark Cave-Ayland wrote:
> On 25/04/18 07:34, David Gibson wrote:
>> On Wed, Apr 25, 2018 at 07:06:03AM +0100, Mark Cave-Ayland wrote:
>>> On 06/04/18 06:33, Mark Cave-Ayland wrote:
>>>> On 25/03/18 22:11, Mark Cave-Ayland wrote:
>>>>
>>>>> Just to follow up on this, I spent a bit looking at what this
>>>>> register is trying to do and from the Darwin source I can see that
>>>>> in fact it is simply a hard-wired hardware register which should
>>>>> return the revision of the UniNorth hardware.
>>>>>
>>>>> So in fact the code in its current form is completely bogus which is
>>>>> visible when trying to boot FreeBSD, which as the register is never
>>>>> written to, returns a completely different random number each time.

This is scary...

>>>>>
>>>>> David - are you okay to change DEVICE_NATIVE_ENDIAN to
>>>>> DEVICE_BIG_ENDIAN and then apply this and the final patch to your
>>>>> for-2.13 queue? I can then follow up with another patch later that
>>>>> will implement this register (and also the matching PCI revision ID)
>>>>> correctly.
>>>>
>>>> Ping? I can see that more patches are being added to the for-2.13
>>>> branch
>>>> so I was just wondering if there is now anything else needed from me in
>>>> order to get the last 3 patches from this patchset queued?
>>>
>>> Ping again? The reason for asking is because my next set of Mac
>>> branches are
>>> all rebased on this patchset since they rely on this, plus the final two
>>> patches in this series which remove the need for qdev_connect_gpio_out()
>>> when wiring up macio devices.
>>
>> Uh... sorry.  I completely missed this series.  And, apparently, your
>> earlier ping.  Can you resend, please.  Make sure you explicitly CC
>> me, I occasionally go through the lists but it's easy for me to miss
>> stuff there.
> 
> No it's okay - you've already got the majority of the patchset applied
> to ppc-for-2.13 (see
> https://lists.gnu.org/archive/html/qemu-devel/2018-03/msg04312.html) but
> it's the last 3 patches which are still missing, presumably because
> Philippe had some questions about them at
> https://lists.gnu.org/archive/html/qemu-devel/2018-03/msg06026.html and
> you queried the DEVICE_NATIVE_ENDIAN at
> https://lists.gnu.org/archive/html/qemu-devel/2018-03/msg05597.html.
> 
> If you're happy to consider patch 17 as just code movement and touch it
> up locally to use DEVICE_BIG_ENDIAN rather than have me resend, then
> does that allow the remaining patches 17-19 to be applied to ppc-for-2.13?
> 
> Once they are there I can send a follow-up patch which will completely
> remove the original implementation in patch 17 and replace it with a
> proper versioned register, updating the PCI config space to match
> accordingly.
> 
> In short: without the follow-up patch the code for the uninorth register
> both before and after patch 17 is wrong regardless of which endian is
> used, so that itself doesn't affect whether or not it can be applied.

With this explanation you have my blessing :)

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
