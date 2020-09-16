Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F65DC433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 08:09:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4855206F7
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 08:09:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E5xbEqoE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4855206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kISVj-0000Va-VP
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 04:09:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55602)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kISUt-0008Fe-Ut
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 04:09:00 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:46441)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kISUr-0003R3-R0
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 04:08:59 -0400
Received: by mail-wr1-x442.google.com with SMTP id o5so5804605wrn.13
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 01:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:from:to:cc:references:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=CFSFcHmjJCCsojOTZdR/+OiyKa24K6U9Gf2e0TswW4k=;
 b=E5xbEqoEjl/FjofJlQtjnWlhpOEDjR9S2SNPDSn2kWxC50aqQ6UHJ/ZP8eu7Ah0gf4
 o99z2HtPko2wK7LhQRbuVojIZ/k8IYWkkUjzj2iiHqZ4eNaBLOUDwfBAcdCP9qmOjgXe
 gnikLlfvjHG9I+KbCS7LjXFhRt8oI9OUGgdta4qkZfPFag5WdssPK9nyCWLANr6+q3ny
 0Dcv53i7GYi+EbNlXrlRFGUObO+Mdm0jlkTjyt/kA7Bh3c/0p8aecGgeJDABdGnKsLV5
 QS0y+eyk4kMr/6zfE3YYhXRVsMCiSxnD6jxfNg97GzvaGhMcFYjzTyk88gQakWWEok17
 k35w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:from:to:cc:references:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=CFSFcHmjJCCsojOTZdR/+OiyKa24K6U9Gf2e0TswW4k=;
 b=aCIgUTDwNcJHMirOYJehM+KWrF+BwFbxFr6Ursiy0bL1vN4q/O26C1vGhIcRqziHIZ
 DEB5gYSh476BD7TTMx0PnMlGmdgIm0P0sRTRR9Y35DjE6d/MqbbTPI2PdpRZKdRMYl4P
 fEkdUgyLZMpTzsK/npsdDZR29isVsGevjapMulnDrXe5/8yK6qf7kGqbNfykrvFrfrBK
 4HG+bjsUbx6E3UBlCQogE6kTMutAWn4JTIc95fVWnhbfY6XBPSl+YdzeG7ITduLbchQa
 bJtHRNLzgxguXUyi0p2vB/1I+2tLq4rhfEphr1frsQjptC8r7EhJn+5n/04UwdZMZzoN
 bi3A==
X-Gm-Message-State: AOAM530azRHO3hBdzQzMBAoRjfoJLqWzAVOvzDaW95zDmMO+8G0hoP+Y
 8Gy+7ObNDiod1eCBHWBqpmU=
X-Google-Smtp-Source: ABdhPJy4LyZWT4qaxSWlLPRnaLR3UA3+7Jh4j3650mfZATzopPssTeJot3B+7UNsiam2pq9COqDXxg==
X-Received: by 2002:adf:d845:: with SMTP id k5mr23617285wrl.285.1600243736256; 
 Wed, 16 Sep 2020 01:08:56 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id b194sm4172729wmd.42.2020.09.16.01.08.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Sep 2020 01:08:55 -0700 (PDT)
Subject: Re: [PATCH V9 6/6] hw/mips: Add Loongson-3 machine support
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Huacai Chen <zltjiangshi@gmail.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
References: <1600222344-16808-1-git-send-email-chenhc@lemote.com>
 <1600222344-16808-7-git-send-email-chenhc@lemote.com>
 <c3804617-7c65-4082-de76-81e718f6d139@amsat.org>
Autocrypt: addr=f4bug@amsat.org; keydata=
 mQINBDU8rLoBEADb5b5dyglKgWF9uDbIjFXU4gDtcwiga9wJ/wX6xdhBqU8tlQ4BroH7AeRl
 u4zXP0QnBDAG7EetxlQzcfYbPmxFISWjckDBFvDbFsojrZmwF2/LkFSzlvKiN5KLghzzJhLO
 HhjGlF8deEZz/d/G8qzO9mIw8GIBS8uuWh6SIcG/qq7+y+2+aifaj92EdwU79apZepT/U3vN
 YrfcAuo1Ycy7/u0hJ7rlaFUn2Fu5KIgV2O++hHYtCCQfdPBg/+ujTL+U+sCDawCyq+9M5+LJ
 ojCzP9rViLZDd/gS6jX8T48hhidtbtsFRj/e9QpdZgDZfowRMVsRx+TB9yzjFdMO0YaYybXp
 dg/wCUepX5xmDBrle6cZ8VEe00+UQCAU1TY5Hs7QFfBbjgR3k9pgJzVXNUKcJ9DYQP0OBH9P
 ZbZvM0Ut2Bk6bLBO5iCVDOco0alrPkX7iJul2QWBy3Iy9j02GnA5jZ1Xtjr9kpCqQT+sRXso
 Vpm5TPGWaWljIeLWy/qL8drX1eyJzwTB3A36Ck4r3YmjMjfmvltSZB1uAdo1elHTlFEULpU/
 HiwvvqXQ9koB15U154VCuguvx/Qnboz8GFb9Uw8VyawzVxYVNME7xw7CQF8FYxzj6eI7rBf2
 Dj/II6wxWPgDEy3oUzuNOxTB7sT3b/Ym76yOJzWX5BylXQIJ5wARAQABtDFQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoRjRCVUcpIDxmNGJ1Z0BhbXNhdC5vcmc+iQJVBBMBCAA/AhsPBgsJ
 CAcDAgYVCAIJCgsEFgIDAQIeAQIXgBYhBPqr514SkXIh3P1rsuPjLCzercDeBQJd660aBQks
 klzgAAoJEOPjLCzercDe2iMP+gMG2dUf+qHz2uG8nTBGMjgK0aEJrKVPodFA+iedQ5Kp3BMo
 jrTg3/DG1HMYdcvQu/NFLYwamUfUasyor1k+3dB23hY09O4xOsYJBWdilkBGsJTKErUmkUO2
 3J/kawosvYtJJSHUpw3N6mwz/iWnjkT8BPp7fFXSujV63aZWZINueTbK7Y8skFHI0zpype9s
 loU8xc4JBrieGccy3n4E/kogGrTG5jcMTNHZ106DsQkhFnjhWETp6g9xOKrzZQbETeRBOe4P
 sRsY9YSG2Sj+ZqmZePvO8LyzGRjYU7T6Z80S1xV0lH6KTMvq7vvz5rd92f3pL4YrXq+e//HZ
 JsiLen8LH/FRhTsWRgBtNYkOsd5F9NvfJtSM0qbX32cSXMAStDVnS4U+H2vCVCWnfNug2TdY
 7v4NtdpaCi4CBBa3ZtqYVOU05IoLnlx0miKTBMqmI05kpgX98pi2QUPJBYi/+yNu3fjjcuS9
 K5WmpNFTNi6yiBbNjJA5E2qUKbIT/RwQFQvhrxBUcRCuK4x/5uOZrysjFvhtR8YGm08h+8vS
 n0JCnJD5aBhiVdkohEFAz7e5YNrAg6kOA5IVRHB44lTBOatLqz7ntwdGD0rteKuHaUuXpTYy
 CRqCVAKqFJtxhvJvaX0vLS1Z2dwtDwhjfIdgPiKEGOgCNGH7R8l+aaM4OPOd
Message-ID: <f026d135-7377-e6ea-dadd-850ab3e7c133@amsat.org>
Date: Wed, 16 Sep 2020 10:08:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <c3804617-7c65-4082-de76-81e718f6d139@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Huacai Chen <chenhuacai@gmail.com>, qemu-devel@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhc@lemote.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/16/20 9:56 AM, Philippe Mathieu-Daudé wrote:
> On 9/16/20 4:12 AM, Huacai Chen wrote:
[...]
>> diff --git a/default-configs/mips64el-softmmu.mak b/default-configs/mips64el-softmmu.mak
>> index 9f8a3ef..26c660a 100644
>> --- a/default-configs/mips64el-softmmu.mak
>> +++ b/default-configs/mips64el-softmmu.mak
>> @@ -3,6 +3,7 @@
>>  include mips-softmmu-common.mak
>>  CONFIG_IDE_VIA=y
>>  CONFIG_FULOONG=y
>> +CONFIG_LOONGSON3V=y
>>  CONFIG_ATI_VGA=y
>>  CONFIG_RTL8139_PCI=y
>>  CONFIG_JAZZ=y
>> diff --git a/hw/mips/Kconfig b/hw/mips/Kconfig
>> index 67d39c5..cc5609b 100644
>> --- a/hw/mips/Kconfig
>> +++ b/hw/mips/Kconfig
>> @@ -45,6 +45,17 @@ config FULOONG
>>      bool
>>      select PCI_BONITO
>>  
>> +config LOONGSON3V
>> +    bool
>> +    select PCKBD
>> +    select SERIAL
>> +    select GOLDFISH_RTC
>> +    select LOONGSON_LIOINTC
>> +    select PCI_EXPRESS_GENERIC_BRIDGE
>> +    select VIRTIO_VGA
>> +    select QXL if SPICE
>> +    select MSI_NONBROKEN

Another error:

../meson.build:577:4: ERROR: Running configure command failed.
The following clauses were found for VIRTIO_VGA
    config VIRTIO_VGA depends on VIRTIO_PCI
    select VIRTIO_VGA if LOONGSON3V
Traceback (most recent call last):
  File "scripts/minikconf.py", line 703, in <module>
    config = data.compute_config()
  File "scripts/minikconf.py", line 253, in compute_config
    clause.process()
  File "scripts/minikconf.py", line 200, in process
    self.dest.set_value(True, self)
  File "scripts/minikconf.py", line 118, in set_value
    raise KconfigDataError('contradiction between clauses when setting
%s' % self)
__main__.KconfigDataError: contradiction between clauses when setting
VIRTIO_VGA

>> +
>>  config MIPS_CPS
>>      bool
>>      select PTIMER

