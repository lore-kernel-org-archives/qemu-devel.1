Received: from eggs.gnu.org ([2001:4830:134:3::10]:34645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1dKLLI-00043I-Hk
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 05:09:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1dKLLH-0004FP-7f
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 05:09:00 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:35804)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <atar4qemu@gmail.com>) id 1dKLLH-0004F5-0Z
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 05:08:59 -0400
Received: by mail-oi0-x241.google.com with SMTP id v74so8199294oie.2
	for <qemu-devel@nongnu.org>; Mon, 12 Jun 2017 02:08:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <3c220ed8-ded2-bb6e-06c9-9978b4177cbc@ilande.co.uk>
References: <1497099616-2615-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1497099616-2615-4-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1ba105d2-be1d-c05b-bc99-6426f6d9c487@amsat.org>
	<3c220ed8-ded2-bb6e-06c9-9978b4177cbc@ilande.co.uk>
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Mon, 12 Jun 2017 11:08:36 +0200
Message-ID: <CACXAS8AB=tqQriuyyte2Cn_Mp2fFx1GtQLryaUE-ymdb8_6MMA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/3] sun4u: expose NVRAM on ebus PCI IO
 address space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, qemu-devel <qemu-devel@nongnu.org>

On Sun, Jun 11, 2017 at 4:58 PM, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
> On 10/06/17 19:05, Philippe Mathieu-Daud=C3=A9 wrote:
>
>> Hi Mark,
>>
>> I'm not sure having this patch split from the previous (2/3) really
>> helps bisecting, I'd rather squash them altogether.
>>
>> Either way:
>>
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>
>> On 06/10/2017 10:00 AM, Mark Cave-Ayland wrote:
>>> To allow future changes to the sun4u PCI topology.
>>>
>>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>> ---
>>>  hw/sparc64/sun4u.c |    2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
>>> index 19e64be..bf738f8 100644
>>> --- a/hw/sparc64/sun4u.c
>>> +++ b/hw/sparc64/sun4u.c
>>> @@ -492,7 +492,7 @@ static void sun4uv_init(MemoryRegion
>>> *address_space_mem,
>>>      /* Map NVRAM into I/O (ebus) space */
>>>      nvram =3D m48t59_init(NULL, 0, 0, NVRAM_SIZE, 1968, 59);
>>>      s =3D SYS_BUS_DEVICE(nvram);
>>> -    memory_region_add_subregion(get_system_io(), 0x2000,
>>> +    memory_region_add_subregion(pci_address_space_io(ebus), 0x2000,
>>>                                  sysbus_mmio_get_region(s, 0));
>>>
>>>      initrd_size =3D 0;
>>>
>
> Yes I could probably do that (unless Artyom objects).

I won't object einther way.

Acked-By: Artyom Tarasenko <atar4qemu@gmail.com>


Artyom

> I agree there
> isn't that much in to the patch, and until the PCI topology changes it's
> effectively a no-op.
>
>
> ATB,
>
> Mark.
>


--=20
Regards,
Artyom Tarasenko

SPARC and PPC PReP under qemu blog: http://tyom.blogspot.com/search/label/q=
emu
