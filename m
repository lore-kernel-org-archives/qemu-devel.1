Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 844DEC48BD4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 17:12:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D29D208CA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 17:12:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D29D208CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34172 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfozd-0002KK-Nt
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 13:12:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56248)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hfoyM-00014Z-Hk
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 13:11:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hfoyK-0005x9-Av
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 13:11:10 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:33785)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1hfoyK-0005uw-1R; Tue, 25 Jun 2019 13:11:08 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MF418-1hmRjC470y-00FS9Y; Tue, 25 Jun 2019 19:09:43 +0200
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Jason Wang <jasowang@redhat.com>
References: <20190619221933.1981-1-laurent@vivier.eu>
 <20190619221933.1981-4-laurent@vivier.eu>
 <f302ca04-e517-f72a-0067-2ab85ef238f0@vivier.eu>
 <e9ccdbf4-3703-b6a2-7f58-0739a4cfe7bd@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <81f9a447-8305-9de5-8a81-3e29299dfa2a@vivier.eu>
Date: Tue, 25 Jun 2019 19:09:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <e9ccdbf4-3703-b6a2-7f58-0739a4cfe7bd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:TYFFcrUGC8WtqAMF0cPMqR9wHzoKgexFG3aHNgnDQ4dwsQwHPmx
 hsMSFndVM0WfwsmVfOShK26XskkNdtzu3SLoCf+26+87Y1ifDY1pKAqqeEyqWr0pMCPjpUg
 cwgvMoQZumxR5yk/FrWFIMmxa/qaeV5rIhEloo1ERO/H+ywrK1cLPG2c9FtmN4C6Rask7jv
 pDrQ1XMAv2IynEDus565Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:S9Ma7+Q/ZIc=:tRFVTYBTJ2a0WkRspWDCLf
 +eSQBIZWZsT8GSDOe/zx3My6lOr2BrHVpVSSqGNEYjMyQ3AECQeltw9hgHW2rB1u7AvB709y0
 ClEfWz5ujt6jWNJkcKLQhDcNtdmrkKXuBjhqg/YXgHFL9FjTYkAvVNW/Pvk0F9oh9z8D4bHiq
 v4pG3Tky+f0c0PqsEftFQihkjwdeJsGUQPyupZfjZd+nBhfOW++g7r9hPC7Cjz8SVHr0ANd2L
 8+ZGba5bSQWoQC2q8G/bE7fu30KlKElPnTB4oyaY0xApgQNlVWre4C4LddDAjRGQIx8XBg0H+
 Zi1UlzVYXVBDWe6WOKfAphQzpnn/513qtlvrtzhr1tPQ35ql22PopjocfqMUR2fDbShq46WIE
 3qFb/Ju/mXVlzSpGUkMEeLvhLVokhEYDjcWqRXJAW9KgTh8tchex26+/P3OhoFFS4DicQwKsH
 1YVmtb5zLkIc35LUNMlL6ulyy82En+2ValPEIp3UjtLMGfwjMSQ3+GOgn91ot6/w5RsDuHJ6P
 7UXLUfVrNO4LgQiuXnJNVMshGaMKZ5zjjr2vsqyakdSXPp1xjlbZBogCazEjDpPnGgbDv7Fwr
 XgIeOy2nweaSBuDrXE7jxWjqYO7hBNBYfv52pBzX4yTc4VOqxyQFz2Z1LbvtJOi16lR8M4QTW
 BNwI8tv6Si4RAKmRainsYbGpKkAVI6FOw0iNJ6hWV+dhbyFOauFygy+/fy/GgibHZbrgtJGyM
 m9aDzcUarEQQ7OkvKeuck7PMpVrJ6YAD8oHjbELN0PncQMfODqRXDpaU/JM=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.13
Subject: Re: [Qemu-devel] [PATCH v8 03/10] dp8393x: manage big endian bus
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Thomas Huth <huth@tuxfamily.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 25/06/2019 à 17:57, Philippe Mathieu-Daudé a écrit :
> On 6/24/19 10:07 PM, Laurent Vivier wrote:
>> Hi,
>>
>> Jason, Can I have an Acked-by from you (as network devices maintainer)?
> 
> Hmm something seems odd here indeed...
> 
> What a stable model! This file has no logical modification since its
> introduction, a65f56eeba "Implement sonic netcard (MIPS Jazz)"
> 
> Here we had:
> 
> static void dp8393x_writeb(void *opaque, hwaddr addr, uint32_t val)
> {
>     uint16_t old_val = dp8393x_readw(opaque, addr & ~0x1);
> 
>     switch (addr & 3) {
>     case 0:
>         val = val | (old_val & 0xff00);
>         break;
>     case 1:
>         val = (val << 8) | (old_val & 0x00ff);
>         break;
>     }
>     dp8393x_writew(opaque, addr & ~0x1, val);
> }
> 
> So we had 16-bit endian shifting there.
> 
> And few lines below:
> 
>     /* XXX: Check byte ordering */
>     ...
>     /* Calculate the ethernet checksum */
>     #ifdef SONIC_CALCULATE_RXCRC
>         checksum = cpu_to_le32(crc32(0, buf, rx_len));
>     #else
>         checksum = 0;
>     #endif
> 
> After various housekeeping, we get:
> 
> 84689cbb97 "net/dp8393x: do not use old_mmio accesses"
> 
> The MIPS Jazz is known to run in both endianess, but I haven't checked
> if at that time both were available.
> 
> Have you tried this patch?
> 
> -- >8 --
> diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
> index bdb0b3b2c2..646e11206f 100644
> @@ -651,7 +651,7 @@ static const MemoryRegionOps dp8393x_ops = {
>      .write = dp8393x_write,
>      .impl.min_access_size = 2,
>      .impl.max_access_size = 2,
> -    .endianness = DEVICE_NATIVE_ENDIAN,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
>  };
> ---
> 
> (but then mips64-softmmu Jazz would have networking broken).
> 

I doesn't help, the endianness is a MemoryRegion property (see
memory_region_wrong_endianness()) so it is used when the CPU writes to
the device MMIO, not when the device accesses the other memory.
In this case, it reads from system_memory. Perhaps we can create the
address_space with a system_memory in big endian mode?

Thanks,
Laurent

