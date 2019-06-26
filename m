Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E1EC48BD3
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 08:58:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9205D20645
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 08:58:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9205D20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hg3l8-0001Jd-Nx
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 04:58:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54658)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hg3kc-0000qR-02
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 04:57:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hg3ka-0006XS-Sh
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 04:57:57 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55269)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hg3ka-0006WW-0b
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 04:57:56 -0400
Received: by mail-wm1-f66.google.com with SMTP id g135so1215390wme.4
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2019 01:57:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=C3QAdTD0IyCFeXSwA3EU7WzuJv9M0hcDk4B41m5EOEs=;
 b=Uw33I+4jxiTj+gbmNY6NgMRRUfmBrqm9bxPfumSPwtdLKkCeyg8EyXhoXOZeQrVl2j
 jSu9AfFZ6fsvi0SakSIvxxwSBHGRmY2lsF+UU3TWUPYp5y3x2E//q+HggocKqRtIzo+D
 m0APWejhslh7Wcp6ivuLIQ8cRbAoCV40G3IRK0v0aO2udzZ+/2B8m74Q8Dsnm7FVfqHY
 R+E5vh4FEu/Bf6WjzdNk+/aRU1tSKpXWtEPznSF0zKEugDD+WFaslokZCe+SCgSEgx9e
 l0aqLHqlA2xETlfMPJeqFDkXb1lOW4oN1U7V0s6qVuXMVIrQbcb0mTKaVjznEqGfmmgB
 uv9w==
X-Gm-Message-State: APjAAAVo9H8tjI/J/vRPlp5WMVRxt6J/bMeXGsnY7JIGhZpY3XkgGcuq
 ALiihAqsvm8Ifz9as5w7bfzWyw==
X-Google-Smtp-Source: APXvYqyOPCDb4WyeOnelHadUWhgNKm3e6yhsfSAwFhOLIECJVvuCLFXUfFdjRO8mSRBNPIOJnDMGjg==
X-Received: by 2002:a1c:21c6:: with SMTP id h189mr1871752wmh.79.1561539474851; 
 Wed, 26 Jun 2019 01:57:54 -0700 (PDT)
Received: from [10.201.33.53] ([195.166.127.210])
 by smtp.gmail.com with ESMTPSA id n10sm15392095wrw.83.2019.06.26.01.57.53
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 26 Jun 2019 01:57:54 -0700 (PDT)
To: Laurent Vivier <laurent@vivier.eu>, Jason Wang <jasowang@redhat.com>
References: <20190619221933.1981-1-laurent@vivier.eu>
 <20190619221933.1981-4-laurent@vivier.eu>
 <f302ca04-e517-f72a-0067-2ab85ef238f0@vivier.eu>
 <e9ccdbf4-3703-b6a2-7f58-0739a4cfe7bd@redhat.com>
 <81f9a447-8305-9de5-8a81-3e29299dfa2a@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <95e2e7c1-962d-3ac7-baba-467f0f6c4041@redhat.com>
Date: Wed, 26 Jun 2019 10:57:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <81f9a447-8305-9de5-8a81-3e29299dfa2a@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.66
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

On 6/25/19 7:09 PM, Laurent Vivier wrote:
> Le 25/06/2019 à 17:57, Philippe Mathieu-Daudé a écrit :
>> On 6/24/19 10:07 PM, Laurent Vivier wrote:
>>> Hi,
>>>
>>> Jason, Can I have an Acked-by from you (as network devices maintainer)?
>>
>> Hmm something seems odd here indeed...
>>
>> What a stable model! This file has no logical modification since its
>> introduction, a65f56eeba "Implement sonic netcard (MIPS Jazz)"
>>
>> Here we had:
>>
>> static void dp8393x_writeb(void *opaque, hwaddr addr, uint32_t val)
>> {
>>     uint16_t old_val = dp8393x_readw(opaque, addr & ~0x1);
>>
>>     switch (addr & 3) {
>>     case 0:
>>         val = val | (old_val & 0xff00);
>>         break;
>>     case 1:
>>         val = (val << 8) | (old_val & 0x00ff);
>>         break;
>>     }
>>     dp8393x_writew(opaque, addr & ~0x1, val);
>> }
>>
>> So we had 16-bit endian shifting there.
>>
>> And few lines below:
>>
>>     /* XXX: Check byte ordering */
>>     ...
>>     /* Calculate the ethernet checksum */
>>     #ifdef SONIC_CALCULATE_RXCRC
>>         checksum = cpu_to_le32(crc32(0, buf, rx_len));
>>     #else
>>         checksum = 0;
>>     #endif
>>
>> After various housekeeping, we get:
>>
>> 84689cbb97 "net/dp8393x: do not use old_mmio accesses"
>>
>> The MIPS Jazz is known to run in both endianess, but I haven't checked
>> if at that time both were available.
>>
>> Have you tried this patch?
>>
>> -- >8 --
>> diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
>> index bdb0b3b2c2..646e11206f 100644
>> @@ -651,7 +651,7 @@ static const MemoryRegionOps dp8393x_ops = {
>>      .write = dp8393x_write,
>>      .impl.min_access_size = 2,
>>      .impl.max_access_size = 2,
>> -    .endianness = DEVICE_NATIVE_ENDIAN,
>> +    .endianness = DEVICE_LITTLE_ENDIAN,
>>  };
>> ---
>>
>> (but then mips64-softmmu Jazz would have networking broken).
>>
> 
> I doesn't help, the endianness is a MemoryRegion property (see
> memory_region_wrong_endianness()) so it is used when the CPU writes to
> the device MMIO, not when the device accesses the other memory.
> In this case, it reads from system_memory. Perhaps we can create the
> address_space with a system_memory in big endian mode?

Ah I missed that...

What about not using address_space_rw(data) but directly use
address_space_lduw_le() and address_space_stw_le() instead?

