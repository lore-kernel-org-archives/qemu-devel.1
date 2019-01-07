Received: from eggs.gnu.org ([209.51.188.92]:40539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1ggPls-0003La-GW
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 02:56:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1ggPlr-0006xE-Jp
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 02:56:28 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40635)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ggPlr-0006uL-B0
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 02:56:27 -0500
Received: by mail-wm1-f67.google.com with SMTP id f188so6511584wmf.5
	for <qemu-devel@nongnu.org>; Sun, 06 Jan 2019 23:56:25 -0800 (PST)
References: <20190104175847.6290-1-philmd@redhat.com>
	<20190104175847.6290-4-philmd@redhat.com>
	<5d940a10-85c9-7361-86e0-99f9e1e8e737@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2d38b4b7-5275-7e5e-3293-c793d3dcebe7@redhat.com>
Date: Mon, 7 Jan 2019 08:56:22 +0100
MIME-Version: 1.0
In-Reply-To: <5d940a10-85c9-7361-86e0-99f9e1e8e737@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 03/16] hw/devices: Remove unused
 TC6393XB_RAM definition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Joel Stanley <joel@jms.id.au>, Peter Maydell <peter.maydell@linaro.org>, Andrzej Zaborowski <balrogg@gmail.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Beniamino Galvani <b.galvani@gmail.com>, Michael Walle <michael@walle.cc>, Richard Henderson <rth@twiddle.net>, Jan Kiszka <jan.kiszka@web.de>, Jason Wang <jasowang@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Peter Chubb <peter.chubb@nicta.com.au>, Aurelien Jarno <aurelien@aurel32.net>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Rob Herring <robh@kernel.org>

On 1/7/19 7:32 AM, Thomas Huth wrote:
> On 2019-01-04 18:58, Philippe Mathieu-Daudé wrote:
>> Introduced in 64b40bc54a9, this definition is no more used since
>> a0b753dfd39. Remove it.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  include/hw/devices.h | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/include/hw/devices.h b/include/hw/devices.h
>> index 0e27feb0c2..4019b3be17 100644
>> --- a/include/hw/devices.h
>> +++ b/include/hw/devices.h
>> @@ -51,7 +51,6 @@ void retu_key_event(void *retu, int state);
>>  
>>  /* tc6393xb.c */
>>  typedef struct TC6393xbState TC6393xbState;
>> -#define TC6393XB_RAM	0x110000 /* amount of ram for Video and USB */
>>  TC6393xbState *tc6393xb_init(struct MemoryRegion *sysmem,
>>                               uint32_t base, qemu_irq irq);
>>  void tc6393xb_gpio_out_set(TC6393xbState *s, int line,
>>
> 
> I think I'd simply squash this into the next patch and mention it in the
> patch description there that you removed the #define.

OK.
