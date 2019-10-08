Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D38C4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 09:34:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 847232070B
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 09:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jHagaC50"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 847232070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHlt0-0003td-Of
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 05:34:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36872)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iHlr7-0002eT-5S
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 05:32:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iHlr5-0007rx-TJ
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 05:32:33 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:54555)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iHlqz-0007f6-Vs; Tue, 08 Oct 2019 05:32:26 -0400
Received: by mail-wm1-x344.google.com with SMTP id p7so2346160wmp.4;
 Tue, 08 Oct 2019 02:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=P+B3K0bYmHVQcU6q8HEDPTHDanRKFNgYUp2qV8rsgrA=;
 b=jHagaC50a7A7FOsPfZKAr6Q7Dc38Zo5JLaCJK/MZXsrMzWqeI1TaIggnaoDKfTW0hQ
 YmxByuvB9mNQ31jqTxTtHTBP+9OINBNZi6K3N86UUuzLbu9dhPT3C94Wo8McXJDdV6Ei
 STlppCPbGCKu+EuXFwURoJ7y5kuVXbVcjmGUvC7tb5NwSI039R0pFpYz+kefT2c0Ha4O
 peonbv3cP/awtvPHzUkxZOhGdl5D0yxTeP14EZwsaTcpXeD8XJUzRXD55zDv9GY48phE
 KLASowH3wZ5xgRCuCmZ5bzV5PusuAHiI0c9ukgTJxWukSQ9hofWR/y/3CsSfzZInd/2b
 Ejsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=P+B3K0bYmHVQcU6q8HEDPTHDanRKFNgYUp2qV8rsgrA=;
 b=gGOn4nyx3rPF2A8e3V/GiLsdEe5VNK2dE71GWezUDuXA4WDEU0ObMdqOHrnSjsJuRx
 9E8X0Srku8ngqMmegF6sBgWr9/SJOe26NVT8v2oFDjMGHmWc7bU+xKkub8BqWQCgUM3G
 7Oyop04cP+HMu1LZ9mZYJtIEAvYWeziabZvqtsA2MsD+jwRidLiH2nOPC683l7CtysMy
 BHgha2VYqYfBdVgTNg4azR+WhTs7BoUm7wWjyrCpwP8dDeWwbm8qt96w75yZXLGqXMgb
 7dJyVWm5NEUcZeDt5kUW5rWaGBBWt6CwQVtLsCC5G3RtbJynGwBLuBStaNN95WD8OaKo
 QERA==
X-Gm-Message-State: APjAAAVinFEosZ/40+CooeIhOMOpTanPCXSNxZyh4Ml7kOKZFiTPy9Kj
 nCT0OeQYDeILgvzRmN3QJOc=
X-Google-Smtp-Source: APXvYqwe30SsnhOuJatEGw9l940iFDaaEpKsv3Lxd4dqg9erw5Fq8kOifTUDh6WXXcmpuCQPS36Wng==
X-Received: by 2002:a1c:5f82:: with SMTP id t124mr3167489wmb.114.1570527144581; 
 Tue, 08 Oct 2019 02:32:24 -0700 (PDT)
Received: from [192.168.1.35] (46.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.46])
 by smtp.gmail.com with ESMTPSA id f13sm2489636wmj.17.2019.10.08.02.32.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Oct 2019 02:32:23 -0700 (PDT)
Subject: Re: [RFC PATCH 03/14] hw/misc/bcm2835_property: Handle the 'domain
 state' property
To: Esteban Bosse <estebanbosse@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-devel@nongnu.org,
 Pekka Enberg <penberg@iki.fi>, =?UTF-8?Q?Zolt=c3=a1n_Baldaszti?=
 <bztemail@gmail.com>
References: <20190904171315.8354-1-f4bug@amsat.org>
 <20190904171315.8354-4-f4bug@amsat.org>
 <d02a29663183b8963bc34a0d1b031442d997ab62.camel@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <7023ba2c-edfa-8313-8138-0556f4a03023@amsat.org>
Date: Tue, 8 Oct 2019 11:32:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <d02a29663183b8963bc34a0d1b031442d997ab62.camel@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: qemu-arm@nongnu.org, Clement Deschamps <clement.deschamps@antfield.fr>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/29/19 9:01 AM, Esteban Bosse wrote:
> El mié, 04-09-2019 a las 19:13 +0200, Philippe Mathieu-Daudé escribió:
>> The kernel is happy with this change, so we don't need
>> to do anything more sophisticated.
>>
>> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>   hw/misc/bcm2835_property.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/hw/misc/bcm2835_property.c b/hw/misc/bcm2835_property.c
>> index 399f0d9dd5..d8eb28f267 100644
>> --- a/hw/misc/bcm2835_property.c
>> +++ b/hw/misc/bcm2835_property.c
>> @@ -127,6 +127,14 @@ static void
>> bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
>>               resplen = 8;
>>               break;
>>   
>> +        case 0x00030030: /* Get domain state */
>> +            qemu_log_mask(LOG_UNIMP,
>> +                          "bcm2835_property: 0x%08x get domain state
>> NYI\n",
>> +                          tag);
>> +            /* FIXME returning uninitialized memory */
>> +            resplen = 8;
>> +            break;
>> +
>>           case 0x00038002: /* Set clock rate */
>>           case 0x00038004: /* Set max clock rate */
>>           case 0x00038007: /* Set min clock rate */
> 
> Searching this property in the kernel, I found a lot of properties not
> implemented.
> https://github.com/raspberrypi/linux/blob/rpi-4.19.y/include/soc/bcm2835/raspberrypi-firmware.h#L41
> Are the properties only added when they are necessaries for the
> standard kernel use?

Yes, the idea is to emulate the bare minimum required to run your guest 
code. To test this series I used the closed source kernel provided by 
the Raspberry Pi foundation [1] which the one that does the most of 
UNIMP accesses, the Debian trunk one and I build one from [2].

The problem is old kernels don't support the raspi4, and recent kernels 
do a lot of property calls to use recent features.

A "property call" is a call from the ARM core to the VideoCore firmware, 
like a Remote Procedure Call. The ARM core write some 
arguments/structure to a memory space shared with the VideoCore, use a 
MailBox to send a 'property' key to the VideoCore and wait/poll for a 
response from the VC. The VC handles the 'property' call, if required 
fills the structure in the same memory space the ARM used, then reply 
via another MailBox channel to notify the ARM core.

QEMU does not model the VideoCore. Instead we directly fill the memory 
from the ARM property call. We fake the VC firmware.

[1] https://github.com/raspberrypi/firmware/blob/master/boot/kernel8.img
[2] https://github.com/raspberrypi/linux/tree/rpi-5.3.y

