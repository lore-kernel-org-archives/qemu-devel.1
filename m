Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3846CC46499
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 17:07:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AB49216E3
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 17:07:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AB49216E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjRgJ-0002CN-En
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 13:07:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53551)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hjRfD-0001QV-15
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 13:06:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hjRfB-00047N-6T
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 13:06:22 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44915)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hjRfA-00045C-W5
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 13:06:21 -0400
Received: by mail-wr1-f68.google.com with SMTP id b2so9377808wrx.11
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2019 10:06:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=g7Zjgn9ccbxMWD7R6vbyKhMxyc8I0phsWXHyjwKi3Bg=;
 b=S0fx3u+ufW/zIGD0SOUIPECzd/zNqcFwrYXOZVXESWGeDmFY3dixLaEQbXApBYfiVu
 ilbn3KX8l6nowj1AJQkGkmqz4wBHryoGwHQZHB/E3tl3uAFgxyk011rdj/WntprF1SpY
 HBjocBLDmOf83N6Ipj/OxNKlbdAgZbtEkQ9LiUPepiR1qSTt+3wiPeUKAGKvHR4l9Ws4
 56nU0Us0yYk2AfWumLSfAcjnbNfSTKGKfZt2rn+DCQ3qk3qgND2M3PkN+1lLbHCqfaIv
 dp4nfIz8Qi4WrZvhEoGsJBwIVdFiW1Bgrz342CFIF5/C7x7zTxLfLYaVAQWCTUFMCb5k
 lIdg==
X-Gm-Message-State: APjAAAXKZJPshqpIWMD/fIdaYERqoQXsvxSG2pNIGR9EeRzDZxXUFHZM
 jdv+v/T4rxmoqtGAFpjEk6xytw==
X-Google-Smtp-Source: APXvYqw9j3Ol+WNJZcg/6X3bvovItST9nM9FigpNe0ldrE1zNzuiXDV+EW0NCHiYER5pf773tRIkyw==
X-Received: by 2002:a5d:4a46:: with SMTP id v6mr4810283wrs.105.1562346379327; 
 Fri, 05 Jul 2019 10:06:19 -0700 (PDT)
Received: from [192.168.1.38] (56.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.56])
 by smtp.gmail.com with ESMTPSA id f7sm8247894wrv.38.2019.07.05.10.06.18
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Jul 2019 10:06:18 -0700 (PDT)
To: Francisco Iglesias <frasse.iglesias@gmail.com>
References: <20190705150850.4967-1-philmd@redhat.com>
 <20190705150850.4967-2-philmd@redhat.com>
 <20190705155338.duhw5hw4tnaixyp4@fralle-msi>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <a6a359ac-6cbf-b7bf-ab18-096976110483@redhat.com>
Date: Fri, 5 Jul 2019 19:06:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190705155338.duhw5hw4tnaixyp4@fralle-msi>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH v3 1/2] hw/ssi/xilinx_spips: Convert
 lqspi_read() to read_with_attrs
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, qemu-devel@nongnu.org,
 Prasad J Pandit <ppandit@redhat.com>, Lei Sun <slei.casper@gmail.com>,
 qemu-arm@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/5/19 5:53 PM, Francisco Iglesias wrote:
> Hi Philippe,
> 
> On [2019 Jul 05] Fri 17:08:49, Philippe Mathieu-Daudé wrote:
>> In the next commit we will implement the write_with_attrs()
>> handler. To avoid using different APIs, convert the read()
>> handler first.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  hw/ssi/xilinx_spips.c | 20 ++++++++++----------
>>  1 file changed, 10 insertions(+), 10 deletions(-)
>>
>> diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
>> index 8115bb6d46..e80619aece 100644
>> --- a/hw/ssi/xilinx_spips.c
>> +++ b/hw/ssi/xilinx_spips.c
>> @@ -1202,27 +1202,27 @@ static void lqspi_load_cache(void *opaque, hwaddr addr)
>>      }
>>  }
>>  
>> -static uint64_t
>> -lqspi_read(void *opaque, hwaddr addr, unsigned int size)
>> +static MemTxResult lqspi_read(void *opaque, hwaddr addr, uint64_t *value,
>> +                              unsigned size, MemTxAttrs attrs)
>>  {
>> -    XilinxQSPIPS *q = opaque;
>> -    uint32_t ret;
>> +    XilinxQSPIPS *q = XILINX_QSPIPS(opaque);
>>  
>>      if (addr >= q->lqspi_cached_addr &&
>>              addr <= q->lqspi_cached_addr + LQSPI_CACHE_SIZE - 4) {
>>          uint8_t *retp = &q->lqspi_buf[addr - q->lqspi_cached_addr];
>> -        ret = cpu_to_le32(*(uint32_t *)retp);
>> -        DB_PRINT_L(1, "addr: %08x, data: %08x\n", (unsigned)addr,
>> -                   (unsigned)ret);
>> -        return ret;
>> +        *value = cpu_to_le32(*(uint32_t *)retp);
>> +        DB_PRINT_L(1, "addr: %08" HWADDR_PRIx ", data: %08" PRIx64 "\n",
>> +                   addr, *value);
>>      } else {
>>          lqspi_load_cache(opaque, addr);
>> -        return lqspi_read(opaque, addr, size);
>> +        lqspi_read(opaque, addr, value, size, attrs);
> 
> If you don't want to leave the return value floating you can always keep the
> 'return' (I'm unsure if coverity will complain about that).

Ah, I missed that, I'll fix.

> 
> Either way:
> 
> Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>

Thanks!

I'll wait some more time of other want to review, then I'll respin with
the typo you corrected in the 2nd patch fixed.

> 
>>      }
>> +
>> +    return MEMTX_OK;
>>  }
>>  
>>  static const MemoryRegionOps lqspi_ops = {
>> -    .read = lqspi_read,
>> +    .read_with_attrs = lqspi_read,
>>      .endianness = DEVICE_NATIVE_ENDIAN,
>>      .valid = {
>>          .min_access_size = 1,
>> -- 
>> 2.20.1
>>

