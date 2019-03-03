Received: from eggs.gnu.org ([209.51.188.92]:55117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h0SqG-0004GI-A2
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 10:15:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h0SqF-0004dm-A5
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 10:15:51 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35575)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h0SqE-0004cm-HD
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 10:15:51 -0500
Received: by mail-wr1-f65.google.com with SMTP id t18so2772933wrx.2
	for <qemu-devel@nongnu.org>; Sun, 03 Mar 2019 07:15:49 -0800 (PST)
References: <20190303000025.3496D7456A0@zero.eik.bme.hu>
	<0ba3b4c7-c0bc-f8d8-66d5-1f3b15eed6ce@redhat.com>
	<alpine.BSF.2.21.9999.1903031316220.1059@zero.eik.bme.hu>
	<2586687c-9f69-1c26-6f7f-841c5300ee0e@redhat.com>
	<alpine.BSF.2.21.9999.1903031436530.20570@zero.eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <087c96b3-6b23-8610-0d39-af5fae2a5c8d@redhat.com>
Date: Sun, 3 Mar 2019 16:15:47 +0100
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.21.9999.1903031436530.20570@zero.eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4] hw/display: Add basic ATI VGA emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>


On 3/3/19 3:04 PM, BALATON Zoltan wrote:
> On Sun, 3 Mar 2019, Philippe Mathieu-Daudé wrote:
>> On 3/3/19 1:46 PM, BALATON Zoltan wrote:
>>> On Sun, 3 Mar 2019, Philippe Mathieu-Daudé wrote:
>>>>> diff --git a/hw/display/trace-events b/hw/display/trace-events
>>>>> index 37d3264bb2..6aed33eeaa 100644
>>>>> --- a/hw/display/trace-events
>>>>> +++ b/hw/display/trace-events
>>>>> @@ -138,3 +138,7 @@ vga_cirrus_write_blt(uint32_t offset, uint32_t
>>>>> val) "offset 0x%x, val 0x%x"
>>>>> ?sii9022_read_reg(uint8_t addr, uint8_t val) "addr 0x%02x, val 0x%02x"
>>>>> ?sii9022_write_reg(uint8_t addr, uint8_t val) "addr 0x%02x, val
>>>>> 0x%02x"
>>>>> ?sii9022_switch_mode(const char *mode) "mode: %s"
>>>>> +
>>>>> +# hw/display/ati*.c
>>>>> +ati_mm_read(unsigned int size, uint64_t addr, const char *name,
>>>>> uint64_t val) "%d 0x%"HWADDR_PRIx " %s -> 0x%"PRIx64
>>>>> +ati_mm_write(unsigned int size, uint64_t addr, const char *name,
>>>>> uint64_t val) "%d 0x%"HWADDR_PRIx " %s <- 0x%"PRIx64
>>>>
>>>> "%u ...
>>>
>>> Should not matter as size that can only be 1 to 4 but %u is more correct
>>> to print unsigned variable so I'll change this.
>>
>> The argument is unsigned, so the correct format is %u.
>>
>> This help reducing the thousands of warnings in QEMU about incorrect
>> formatstring.
> 
> Yes, I've corrected this. I did not get warnings for it but maybe some
> compilers are pickier about this.

We currently don't use this warning (yet) because there are plenty of
incorrect formatstring, simply because we never cared.
One day we might care. Or we could enable these warnings on a subsystem
basis (but we'd still need to clean the headers first).
