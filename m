Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE411C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 10:39:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 806D0207CB
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 10:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hDQSJR6X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 806D0207CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdWzd-0000vV-Nq
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 06:39:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37906)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdWz5-0000U0-CL
 for qemu-devel@nongnu.org; Tue, 26 May 2020 06:38:59 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:41036)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdWz4-0000XK-Ky
 for qemu-devel@nongnu.org; Tue, 26 May 2020 06:38:59 -0400
Received: by mail-ej1-x641.google.com with SMTP id x1so23244782ejd.8
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 03:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=8JphV0ZJjhKid4ogCqZP24XQrmhamHKUyFNgMSImL8s=;
 b=hDQSJR6XDJSwMNAskGyPZ8FBiqvwsDqacpKY76Kj2RgyvvviMcIpKdUFtL1J3Rrqzp
 t0b11cGvmt5xPioQ6aF5ewLDm2gFHTM0IkcP6Xbracok8yZlLmrdqSlTW7yvmlQpoaPh
 nrMI7xPYmkwFDarWYDojNkymi34IZdU21z0OGIIFIu7uifQGY3dExpr2Zzza6zHLrRYP
 e1PbV1aqHiuZAqskX5tU6x4L9LwlmA2nqicxdU+roAms2tOh34XeFdGfaPPeWBQp9QAA
 HZKuHhx9If9QemPnuZVefh/drKRKsaLB9B7A5mWQ7HxhvTnlRIZ6maE+FwCnc/RoQxig
 aCBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8JphV0ZJjhKid4ogCqZP24XQrmhamHKUyFNgMSImL8s=;
 b=OJjw6ZXh/f+a7rE7MBm40y1q9W+HEAHFufQpXmZeddnatXOQIS8IhfNbqEswPe2cYO
 dJE+PLjLBfr9KdD5bUf/XfVHH8j0OMfMniQvQzWtgpLGqfcIej5me9mpXOjENqNUAcr3
 W5EZ6Egn28sz7zcaL2ZEFSyoYKopejSE0HYgfT2Ri0QGEYeCVBZfhxmEUPfFeBZ9kPN3
 nzwccSJBITxkd4SEiZ1w+1siFNczSmpiuSavxmcHiNHLR9zs6DP7ATHCW7wX4HeNxAa9
 tQfRwxec49yRULnfzLA+5diBxfyus7dRgCWA4NVHAkm/QMBp7jPYmXm8O04KcksqMSGZ
 fxQQ==
X-Gm-Message-State: AOAM530TWNLbGqR5lRBoOif1jppnbciWz+pG0pnIegcVUFA8JME+sBlM
 gz1sGO8hG3eSv2YwECADE/vWmNT7PwI=
X-Google-Smtp-Source: ABdhPJw/E7lIdRek6C4vtN646LnyZsiwrcT4g4ur7yeOZJ+WXzej7nn5g07xi4modDxFYqkGb+h2vg==
X-Received: by 2002:a17:906:2b88:: with SMTP id
 m8mr510229ejg.514.1590489536801; 
 Tue, 26 May 2020 03:38:56 -0700 (PDT)
Received: from [192.168.1.36] (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id kq5sm17657727ejb.20.2020.05.26.03.38.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2020 03:38:55 -0700 (PDT)
Subject: Re: [PATCH v6 20/21] hw/mips: Add some logging for bad register
 offset cases
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
References: <20200518200920.17344-1-aleksandar.qemu.devel@gmail.com>
 <20200518200920.17344-21-aleksandar.qemu.devel@gmail.com>
 <dba8f844-e28a-bd13-9655-75f8004ad21f@amsat.org>
 <CAHiYmc6DMA2LRXama80zaPi+7RqFQYWL5OwtRn_Xk-ueASAi_A@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3cc6c3d2-19f6-8502-a460-67c5853ff953@amsat.org>
Date: Tue, 26 May 2020 12:38:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAHiYmc6DMA2LRXama80zaPi+7RqFQYWL5OwtRn_Xk-ueASAi_A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: aleksandar.rikalo@syrmia.com, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/26/20 12:05 PM, Aleksandar Markovic wrote:
> уто, 26. мај 2020. у 09:42 Philippe Mathieu-Daudé <f4bug@amsat.org> је
> написао/ла:
>>
>> On 5/18/20 10:09 PM, Aleksandar Markovic wrote:
>>> Log the cases where a guest attempts read or write using bad
>>> register offset.
>>>
>>> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>> Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>
>> Not well tested apparently, because it doesn't build with GCC 5.4.0
>> (Ubuntu):
>>
>> hw/mips/malta.c: In function ‘malta_fpga_read’:
>> hw/mips/malta.c:430:85: error: format ‘%x’ expects argument of type
>> ‘unsigned int’, but argument 2 has type ‘hwaddr {aka long unsigned int}’
>> [-Werror=format=]
>> hw/mips/malta.c: In function ‘malta_fpga_write’:
>> hw/mips/malta.c:517:85: error: format ‘%x’ expects argument of type
>> ‘unsigned int’, but argument 2 has type ‘hwaddr {aka long unsigned int}’
>> [-Werror=format=]
>> cc1: all warnings being treated as errors
>>
>> I amended this snippet ...:
>>
>> -- >8 --
>> @@ -428,8 +428,8 @@ static uint64_t malta_fpga_read(void *opaque, hwaddr
>> addr,
>>
>>      default:
>>          qemu_log_mask(LOG_GUEST_ERROR,
>> -                      "malta_fpga_read: Bad register offset 0x"
>> -                      TARGET_FMT_lx "\n", addr);
>> +                      "malta_fpga_read: Bad register addr
>> 0x%"HWADDR_PRIX"\n",
>> +                      addr);
>>          break;
>>      }
>>      return val;
>> @@ -515,8 +515,8 @@ static void malta_fpga_write(void *opaque, hwaddr addr,
>>
>>      default:
>>          qemu_log_mask(LOG_GUEST_ERROR,
>> -                      "malta_fpga_write: Bad register offset 0x"
>> -                      TARGET_FMT_lx "\n", addr);
>> +                      "malta_fpga_write: Bad register addr
>> 0x%"HWADDR_PRIX"\n",
>> +                      addr);
>>          break;
>>      }
>>  }
>> ---
>>
>> ... and queued to mips-next,
>>
> 
> Hi, Philippe,
> 
> Many thanks for correcting my mistake in this patch!
> May I ask you to refer to your queue as hw/mips-next, rather than
> mips-next, for the sake of clarity?

Tags with '/' are hard to manage, let's use mips-hw-next,
mips-target-next for your pull requests and mips-kvm-next for Huacai's ones.

> And, when do you plan to send the pull request?

Waiting for Gerd's audio-next one to get merged because he took my
"mips_fulong2e: Remove unused 'audio/audio.h' include" patch and I don't
want Peter to have to manually resolve conflicts (there shouldn't be,
but I don't want to risk bother him with a "automatic 3-way merge" warning).

> 
> Thanks,
> Aleksandar
> 
> 
>> Thanks,
>>
>> Phil.
>>
>>> Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
>>> ---
>>>  hw/mips/mips_malta.c | 14 ++++++--------
>>>  1 file changed, 6 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
>>> index e4c4de1b4e..88869b828e 100644
>>> --- a/hw/mips/mips_malta.c
>>> +++ b/hw/mips/mips_malta.c
>>> @@ -427,10 +427,9 @@ static uint64_t malta_fpga_read(void *opaque, hwaddr addr,
>>>          break;
>>>
>>>      default:
>>> -#if 0
>>> -        printf("malta_fpga_read: Bad register offset 0x" TARGET_FMT_lx "\n",
>>> -               addr);
>>> -#endif
>>> +        qemu_log_mask(LOG_GUEST_ERROR,
>>> +                      "malta_fpga_read: Bad register offset 0x"
>>> +                      TARGET_FMT_lx "\n", addr);
>>>          break;
>>>      }
>>>      return val;
>>> @@ -515,10 +514,9 @@ static void malta_fpga_write(void *opaque, hwaddr addr,
>>>          break;
>>>
>>>      default:
>>> -#if 0
>>> -        printf("malta_fpga_write: Bad register offset 0x" TARGET_FMT_lx "\n",
>>> -               addr);
>>> -#endif
>>> +        qemu_log_mask(LOG_GUEST_ERROR,
>>> +                      "malta_fpga_write: Bad register offset 0x"
>>> +                      TARGET_FMT_lx "\n", addr);
>>>          break;
>>>      }
>>>  }
>>>
> 

