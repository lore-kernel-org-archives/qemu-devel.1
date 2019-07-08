Return-Path: <SRS0=vrBk=VF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF33C606BD
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 15:00:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1527D21537
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 15:00:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1527D21537
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkV8D-0002gP-Eb
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 11:00:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49878)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hkV6F-0001DM-IB
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 10:58:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hkV6B-00016T-QT
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 10:58:39 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37875)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hkV69-0000v1-SO
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 10:58:34 -0400
Received: by mail-wm1-f66.google.com with SMTP id f17so16806737wme.2
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2019 07:58:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MPOXltMNn0A0LDsHI3omgXItWm/Wma0B48sJlQV4kqQ=;
 b=V9u260BpB3SEawI1u+CGydJMNfh4LPWjZ8/6iH25BI1CoUsV75ssR7oyZmx2Nvw4m8
 Oj7purHfZ9keGwHxImU8c60ZAES3SLs5VOWg9MJ6ItEMYL65RtL3VmkzMGBUTZWSMgba
 CZKyR5a3/bxLgjxvMkSJCS1vqIdWJhK1OSIThXirkZ5ex2Vog69avzebQ08y096nLyfK
 P6FXsSqSzXh7fSwyFXypjWXWDuHct+j3iZr1LG/XIKHeTfXph1HJkM3wsOoBofTzEKbg
 ZXXgR+o2cieG2nWKxdOyCHskN8VgJ+O0ogmPwQ9uO2T9wk805k3LnOPQh5m+2DOllDXc
 FKaw==
X-Gm-Message-State: APjAAAXdhFf+ldEOD0VtKNZBAyCxS1HepV3/NnR3KibSZEQOfV0xSKlf
 do6fwumfpZKZdwFzAySL21oY/g==
X-Google-Smtp-Source: APXvYqxanYZOImLVojI2rBoimA+rhWjQhpCbm71pX1TpagznQkpoxxb6sGQW+Vqe9GKYmUeSTKFvww==
X-Received: by 2002:a1c:6555:: with SMTP id z82mr17735703wmb.129.1562597911299; 
 Mon, 08 Jul 2019 07:58:31 -0700 (PDT)
Received: from [192.168.1.38] (56.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.56])
 by smtp.gmail.com with ESMTPSA id s3sm18308839wmh.27.2019.07.08.07.58.30
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 08 Jul 2019 07:58:30 -0700 (PDT)
To: Francisco Iglesias <frasse.iglesias@gmail.com>
References: <20190708104750.1071-1-philmd@redhat.com>
 <20190708104750.1071-4-philmd@redhat.com>
 <20190708142622.k4s5oknmzzj4brxd@fralle-msi>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <41f075ef-9b80-cb66-0fb1-d03079cd93a4@redhat.com>
Date: Mon, 8 Jul 2019 16:58:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190708142622.k4s5oknmzzj4brxd@fralle-msi>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH-for-4.1 v5 3/3] hw/ssi/xilinx_spips: Avoid
 out-of-bound access to lqspi_buf[]
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-stable@nongnu.org,
 Alistair Francis <alistair@alistair23.me>, qemu-devel@nongnu.org,
 Prasad J Pandit <ppandit@redhat.com>, Lei Sun <slei.casper@gmail.com>,
 qemu-arm@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Francisco,

On 7/8/19 4:26 PM, Francisco Iglesias wrote:
> Hi Philippe,
> 
> On [2019 Jul 08] Mon 12:47:50, Philippe Mathieu-Daudé wrote:
>> Both lqspi_read() and lqspi_load_cache() expect a 32-bit
>> aligned address.
>>
>> From UG1085 datasheet [*] Chapter 22: Quad-SPI Controller:
> 
> s/22/24/

I'm confuse, Chapter 24 is "SD/SDIO Controller", so it seems this Xilinx
datasheet is not stable to refer to. Maybe I should simply use:

  From UG1085 datasheet [*] Chapter on 'Quad-SPI Controller':

> 
> After above change:
> 
> Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com> 
> Tested-by: Francisco Iglesias <frasse.iglesias@gmail.com>
> 
> (I tested all three patches so the Tested-by tag can also be appended on the
> other two)

Thanks!

> 
> Best regards,
> Francisco Iglesias
> 
>>
>>   Transfer Size Limitations
>>
>>     Because of the 32-bit wide TX, RX, and generic FIFO, all
>>     APB/AXI transfers must be an integer multiple of 4-bytes.
>>     Shorter transfers are not possible.
>>
>> Set MemoryRegionOps.impl values to force 32-bit accesses,
>> this way we are sure we do not access the lqspi_buf[] array
>> out of bound.
>>
>> [*] https://www.xilinx.com/support/documentation/user_guides/ug1085-zynq-ultrascale-trm.pdf
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>> v5: add datasheet reference, drop RFC prefix, fix build (Francisco)
>> ---
>>  hw/ssi/xilinx_spips.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
>> index 3c4e8365ee..b29e0a4a89 100644
>> --- a/hw/ssi/xilinx_spips.c
>> +++ b/hw/ssi/xilinx_spips.c
>> @@ -1239,6 +1239,10 @@ static const MemoryRegionOps lqspi_ops = {
>>      .read_with_attrs = lqspi_read,
>>      .write_with_attrs = lqspi_write,
>>      .endianness = DEVICE_NATIVE_ENDIAN,
>> +    .impl = {
>> +        .min_access_size = 4,
>> +        .max_access_size = 4,
>> +    },
>>      .valid = {
>>          .min_access_size = 1,
>>          .max_access_size = 4
>> -- 
>> 2.20.1
>>

