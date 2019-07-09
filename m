Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8103C606B0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 10:58:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80C5C20861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 10:58:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80C5C20861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hknpq-0001Dq-JJ
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 06:58:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37718)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hknp4-0000Yw-1Z
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 06:58:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hknp2-0001S0-E9
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 06:58:09 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43]:51733)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hknp2-0001R5-6e
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 06:58:08 -0400
Received: by mail-wm1-f43.google.com with SMTP id 207so2607701wma.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2019 03:58:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Z8hYKaJbb7aXSEPRaWxLzxjPo7uPaR+nb5R6CHij39Y=;
 b=PQE0SeC0kpDEu9adPKNjuzltOOBo8wxLtNf3IOMcw3FA81wznGUi450jWrNyhT2AIF
 v56x7H0JxXWzGVQdzKH8M8PzAwD40EXXVIeoJW8VAZ4d5gX2gWGhl78l8N6CiD4ptVjC
 /ys2APNiXenwUYzVEsQkdMNEzGC+YwsMDnFShdFtyUjVpD91YJ1pvOLx60bUObIMaHqg
 bm3sEVoFhvCAE0l3ZldG/kNv8r2pl5n/NT8bF7bs2/AKD5u1iA7Ykj1XfMP2PGJK2Uqx
 wUSDV9KtO6cc0MBr1a4KKDk/0HBrG4K2AD9NpMeSz+3lS17L+fPORmF3a4mYm1AO7WDA
 0lLw==
X-Gm-Message-State: APjAAAVEvgB7PiJsgUzkgCPfCejG7OPg5xJnFanu++NFMh+FcB/w8qX2
 bk0EmneG8rn+kcfxMjP/N9PV5Q==
X-Google-Smtp-Source: APXvYqyQvgP7QKyAQYqab1xU3ac2x3DypxAan0sHlrjFgkWORKqOztgzdnc09dIsUtsjtORXQvirHw==
X-Received: by 2002:a7b:cae9:: with SMTP id t9mr21909260wml.126.1562669887218; 
 Tue, 09 Jul 2019 03:58:07 -0700 (PDT)
Received: from [192.168.1.38] (62.red-83-42-61.dynamicip.rima-tde.net.
 [83.42.61.62])
 by smtp.gmail.com with ESMTPSA id s18sm4128416wra.47.2019.07.09.03.58.06
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 09 Jul 2019 03:58:06 -0700 (PDT)
To: Francisco Iglesias <frasse.iglesias@gmail.com>
References: <20190708104750.1071-1-philmd@redhat.com>
 <20190708104750.1071-4-philmd@redhat.com>
 <20190708142622.k4s5oknmzzj4brxd@fralle-msi>
 <41f075ef-9b80-cb66-0fb1-d03079cd93a4@redhat.com>
 <20190708160335.u3zamevyrbnx6nvb@fralle-msi>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <19334c43-22eb-8476-4f6b-59f5ca347958@redhat.com>
Date: Tue, 9 Jul 2019 12:58:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190708160335.u3zamevyrbnx6nvb@fralle-msi>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.43
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

Hi Peter,

On 7/8/19 6:03 PM, Francisco Iglesias wrote:
> Hi Philippe,
> 
> On [2019 Jul 08] Mon 16:58:29, Philippe Mathieu-Daudé wrote:
>> Hi Francisco,
>>
>> On 7/8/19 4:26 PM, Francisco Iglesias wrote:
>>> Hi Philippe,
>>>
>>> On [2019 Jul 08] Mon 12:47:50, Philippe Mathieu-Daudé wrote:
>>>> Both lqspi_read() and lqspi_load_cache() expect a 32-bit
>>>> aligned address.
>>>>
>>>> From UG1085 datasheet [*] Chapter 22: Quad-SPI Controller:
>>>
>>> s/22/24/
>>
>> I'm confuse, Chapter 24 is "SD/SDIO Controller", so it seems this Xilinx
>> datasheet is not stable to refer to. Maybe I should simply use:
>>
>>   From UG1085 datasheet [*] Chapter on 'Quad-SPI Controller':
> 
> I just clicked on the link and ended up into this version of the UG1085:
> 
> 'UG1085 (v1.9) January 17, 2019'
> 
> But your right its probably better to refer to a specific version of the
> UG1085 instead? Then both should be ok, either to write the way you
> suggest above or refer to the chapter number in that UG1085 version (as it
> was before).
> 
> Best regards,
> Francisco
> 
>>
>>>
>>> After above change:
>>>
>>> Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com> 
>>> Tested-by: Francisco Iglesias <frasse.iglesias@gmail.com>
>>>
>>> (I tested all three patches so the Tested-by tag can also be appended on the
>>> other two)

Are you OK to take this series via your ARM tree?

If so, do you want me to respin fixing the comment and adding Francisco
tags?

Thanks,

Phil.

>>
>> Thanks!
>>
>>>
>>> Best regards,
>>> Francisco Iglesias
>>>
>>>>
>>>>   Transfer Size Limitations
>>>>
>>>>     Because of the 32-bit wide TX, RX, and generic FIFO, all
>>>>     APB/AXI transfers must be an integer multiple of 4-bytes.
>>>>     Shorter transfers are not possible.
>>>>
>>>> Set MemoryRegionOps.impl values to force 32-bit accesses,
>>>> this way we are sure we do not access the lqspi_buf[] array
>>>> out of bound.
>>>>
>>>> [*] https://www.xilinx.com/support/documentation/user_guides/ug1085-zynq-ultrascale-trm.pdf
>>>>
>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>>> ---
>>>> v5: add datasheet reference, drop RFC prefix, fix build (Francisco)
>>>> ---
>>>>  hw/ssi/xilinx_spips.c | 4 ++++
>>>>  1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
>>>> index 3c4e8365ee..b29e0a4a89 100644
>>>> --- a/hw/ssi/xilinx_spips.c
>>>> +++ b/hw/ssi/xilinx_spips.c
>>>> @@ -1239,6 +1239,10 @@ static const MemoryRegionOps lqspi_ops = {
>>>>      .read_with_attrs = lqspi_read,
>>>>      .write_with_attrs = lqspi_write,
>>>>      .endianness = DEVICE_NATIVE_ENDIAN,
>>>> +    .impl = {
>>>> +        .min_access_size = 4,
>>>> +        .max_access_size = 4,
>>>> +    },
>>>>      .valid = {
>>>>          .min_access_size = 1,
>>>>          .max_access_size = 4
>>>> -- 
>>>> 2.20.1
>>>>

