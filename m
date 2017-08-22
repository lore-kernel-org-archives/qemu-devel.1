Received: from eggs.gnu.org ([2001:4830:134:3::10]:43830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1dkH81-00037m-0I
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 17:54:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1dkH7x-0001HC-UZ
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 17:54:29 -0400
Date: Tue, 22 Aug 2017 23:54:23 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <22b8feef-4fd8-88fa-a5ad-a294c5749be4@redhat.com>
Message-ID: <alpine.BSF.2.21.1708222343250.52975@zero.eik.bme.hu>
References: <cover.1503249785.git.balaton@eik.bme.hu>
	<1815e11378b48532e902e0138a58557c297c3eb2.1503249785.git.balaton@eik.bme.hu>
	<088c08f0-d4cd-e1c2-6715-3aeb33b7f4b9@redhat.com>
	<alpine.BSF.2.21.1708221158550.67133@zero.eik.bme.hu>
	<af0775b0-401b-81a6-7178-40e32680dc01@redhat.com>
	<alpine.BSF.2.21.1708222152440.14770@zero.eik.bme.hu>
	<22b8feef-4fd8-88fa-a5ad-a294c5749be4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [PATCH 09/15] hw/ide: Emulate SiI3112 SATA
 controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Francois Revol <revol@free.fr>, Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, Peter Maydell <peter.maydell@linaro.org>

On Tue, 22 Aug 2017, John Snow wrote:
> On 08/22/2017 04:15 PM, BALATON Zoltan wrote:
>> On Tue, 22 Aug 2017, John Snow wrote:
>>> On 08/22/2017 07:08 AM, BALATON Zoltan wrote:
>>>> On Mon, 21 Aug 2017, John Snow wrote:
>>>
>>> Sure, but be advised that if the device causes problems outside of this
>>> use case and there's nobody willing or able to review it, that it may
>>> get removed again.
>>>
>>> I don't have a lot of free time to go through the register list point by
>>> point and make sure this is implemented correctly either, but if this
>>> helps your work I'm OK not holding it up.
>>
>> No problem, of course if a bug is reported I'll try to fix it or if I
>> can't it's OK to remove it again. I just hope it gets more testing and
>> maybe others could contribute fixes if it's in the main line.
>>
>
> Yep, just a "warning"!
>
> Thanks, it looks sane enough to me in general, If you have instructions
> for installing and testing a machine using this advice I'd like to check
> it out later this week and I'll sign off on the re-spin.

I'll probably won't have time to send an updated version before the end of 
the week but since the modifications requested are about DPRINTFs and 
comments (nothing changing functionality) at this point, you could test 
this version if you'll have time.

Since this card is a generic PCI device and not specific to the machine my 
series aims to emulate, I think it could be tested alone in any other 
machine such as pc or some other emulated machine. Linux has a driver 
(sata_sil I think) and a lot of other OSes too so if you can try adding 
this device with an ide-hd and an ide-cd and install any of these OSes 
this could verify if it's working or could uncover some bugs. I don't know 
a better test now because of the bugs in the Sam460ex that prevents it 
from working reliably at the moment.

Thank you for your support.
