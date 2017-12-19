Received: from eggs.gnu.org ([2001:4830:134:3::10]:56298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1eR5rC-0007jX-6h
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 19:34:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1eR5r9-0008Vp-0p
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 19:34:06 -0500
Date: Tue, 19 Dec 2017 01:34:00 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <730aec0f-3f10-55ea-eb26-e5740c2fbfe2@redhat.com>
Message-ID: <alpine.BSF.2.21.1712190109110.9867@zero.eik.bme.hu>
References: <20171216224842.EE8C17456B3@zero.eik.bme.hu>
	<20171218040946.GS7753@umbus.fritz.box>
	<alpine.BSF.2.21.1712181329050.96474@zero.eik.bme.hu>
	<730aec0f-3f10-55ea-eb26-e5740c2fbfe2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2] hw/ide: Emulate SiI3112 SATA
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
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Mon, 18 Dec 2017, John Snow wrote:
> On 12/18/2017 07:30 AM, BALATON Zoltan wrote:
>> On Mon, 18 Dec 2017, David Gibson wrote:
>>> On Sat, Dec 16, 2017 at 11:42:39PM +0100, BALATON Zoltan wrote:
>>>> This is a common generic PCI SATA controller that is also used in PCs
>>>> but more importantly guests running on the Sam460ex board prefer this
>>>> card and have a driver for it (unlike for other SATA controllers
>>>> already emulated).
>>>>
>>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>>
>>> I don't know enough about IDE to give this any more than a quick check
>>> for anything obviously bogus looking.? So,
>>>
>>> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
>>>
>>> John, can you take this through your tree, or should I take it through
>>> the ppc tree?
>>
>> I think he said before it can go via ppc tree:
>>
>> http://lists.nongnu.org/archive/html/qemu-devel/2017-08/msg04480.html
>>
>
> Yep, I tend to use Acked-by to indicate that it's okay for you to stage.
> I'll give it another look-over in a minute, but I'm fine with adding the
> model in general, even if it's not quite complete just yet.

Maybe it's not complete yet but it should work to some degree. I've tested 
it with Linux on i386-softmmu and on PPC Sam460ex with u-boot and some 
guests (both on x86_64 host) and these could boot from an ide-cd model 
connected to this controller so at least basic PIO and UDMA modes should 
work. Maybe some more advanced features are missing but don't know if 
there are any drivers using those.

On i386 the bios does not have a driver so one cannot boot from this 
controller only, so I've tested it with -kernel and -initrd options but 
root filesystem was then read from CD connected to this controller and it 
could read it and start. I haven't tested it more than that though. Maybe 
the card's original option ROM that would allow booting from BIOS might 
not work with this device model but I think we could not distribute that 
anyway for legal reasons so I did not try that. On the Sam460ex which is 
my target for this the u-boot firmware has a driver and can boot from this 
controller as well as clients can use it.

As of now this patch only adds it to ppcemb and will only be created by 
default on the sam460ex machine so not very likely someone would try to 
use it on something else without recompiling QEMU.

Regards,
BALATON Zoltan
