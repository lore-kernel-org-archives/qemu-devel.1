Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C7BBC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 08:01:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2945B2073E
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 08:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ChAoFenx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2945B2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqXgV-0006KH-D2
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 04:01:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58958)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqXfl-0005tI-Vt
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 04:00:51 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:39226)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqXff-0007Qw-J9
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 04:00:49 -0400
Received: by mail-wr1-x441.google.com with SMTP id q5so22776357wru.6
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 01:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:from:to:cc:references:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Vw9wSuKAFVQGZnys/rfuIJ6kqUP630Zp034UbfAD37o=;
 b=ChAoFenx7srAx+i6QMTaRrMBwQZjnoRA4mbAyQpJSZK674vkEdqS/TxGYyswS5+v8v
 T3hSfDpc/Vn7oo/8Xkzo2fwi06PyjWh20XT0VIFoRM7hMpTxezcg8IzSO5LO9+SzIAon
 jwtcVoHhV4QEwALSmkrfafkK0jaAXHLHihVfIYc3yuowA7m5WssIwjI8FML/pOBlDHEH
 fD7y5FsgAsv0pZqoG2ysUQxFBDOShhzcmnNVdQUUaQ7xJnpOb0NKy4hphIOZrRa8q/Mo
 r9bmZtZ8qgXBy0qnRBBGRCsh2XN37j4qpT4A4/FEeOW+jpp7n+v02VGGbLb0Ej+1oa7C
 7weA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:from:to:cc:references:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=Vw9wSuKAFVQGZnys/rfuIJ6kqUP630Zp034UbfAD37o=;
 b=Ov0ASpV1fVPvZwwnRkCXGqQps5a9cREIYG8yBdDjlVMPzryKSTGoBsHg76shGEQ6Lq
 V/mYKQSnto9IbYmqPVnKFJ054y/jjtP8MHVhlY4uHH4vGD2EDZ8vZefyOL+q2/JaD+w5
 gspMIXpf9YIvnycoX4uRGatc/xmoecgUmawZ7seVqNqVLV4D4nN+gRCsXmJ8Ho99LTw3
 StGJx+neNQaTaDQgU7Ox7AaudnFkquHin3Q3kr6gdCxecolT09tFHafT2+kAaF25Dw3k
 sPCXwz53B3yQ1dDXAolQjszch93m0Xl2q4d8hIIT0z5zPluC7G4JAQLhvNmBqxf67RNQ
 8aTg==
X-Gm-Message-State: AOAM533Vl5hMN8sBeccPe2zqArkLJ3Cw9krnX8PmicTNLgFUaB7jAwC3
 bfeUyhzs2BzYZoF7CQS/QQg=
X-Google-Smtp-Source: ABdhPJwSIWojtrKc1Pm9UTdFlWaEmUI+e2OIHplQnDwVcbxWvaZOhJ7WsR4P+Co8tSi3xIoaKD9U/A==
X-Received: by 2002:a5d:464e:: with SMTP id j14mr25485641wrs.393.1593590441879; 
 Wed, 01 Jul 2020 01:00:41 -0700 (PDT)
Received: from [192.168.1.40] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id u2sm5849532wml.16.2020.07.01.01.00.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Jul 2020 01:00:41 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] MAINTAINERS: Adjust MIPS maintainership
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 qemu-devel@nongnu.org
References: <20200630164653.24880-1-aleksandar.qemu.devel@gmail.com>
 <20200630164653.24880-3-aleksandar.qemu.devel@gmail.com>
 <1fdab6eb-9258-7df1-75ea-b4717a9c2b87@amsat.org>
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
Message-ID: <3ae1ef05-8caa-b5ce-a1ce-9670fc0a7cd3@amsat.org>
Date: Wed, 1 Jul 2020 10:00:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1fdab6eb-9258-7df1-75ea-b4717a9c2b87@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: aleksandar.rikalo@syrmia.com, Aurelien Jarno <aurelien@aurel32.net>,
 Paul Burton <paulburton@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/30/20 7:19 PM, Philippe Mathieu-Daudé wrote:
> On 6/30/20 6:46 PM, Aleksandar Markovic wrote:
>> Paul Burton and Aurelien Jarno removed for not being present.
>>
>> Huacai Chen and Jiaxun Yang step in as new energy.
>>
>> CC: Paul Burton <paulburton@kernel.org>
>> CC: Aurelien Jarno <aurelien@aurel32.net>
>> Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
>> ---
>>  MAINTAINERS | 15 ++++++++++-----
>>  1 file changed, 10 insertions(+), 5 deletions(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 5d8acf8d31..7fc16e21c9 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -213,7 +213,8 @@ F: disas/microblaze.c
>>  
>>  MIPS TCG CPUs
>>  M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
>> -R: Aurelien Jarno <aurelien@aurel32.net>
>> +M: Huacai Chen <chenhc@lemote.com>
>> +R: Jiaxun Yang <jiaxun.yang@flygoat.com>
>>  R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
>>  S: Maintained
>>  F: target/mips/
>> @@ -377,6 +378,7 @@ F: target/arm/kvm.c
>>  
>>  MIPS KVM CPUs
>>  M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
>> +M: Huacai Chen <chenhc@lemote.com>
>>  S: Odd Fixes
>>  F: target/mips/kvm.c
>>  
>> @@ -1052,6 +1054,7 @@ MIPS Machines
>>  -------------
>>  Jazz
>>  M: Hervé Poussineau <hpoussin@reactos.org>
>> +M: Huacai Chen <chenhc@lemote.com>

Hmm this is the Jazz hobbyist machine, Huacai are you sure this
the correct section you want to be?

Anyway Hervé Poussineau has to ack that, Aleksandar, it would
be easier if you split this as a separate patch.

>>  R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
>>  S: Maintained
>>  F: hw/mips/jazz.c
>> @@ -1060,8 +1063,8 @@ F: hw/dma/rc4030.c
>>  
>>  Malta
>>  M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
>> +M: Huacai Chen <chenhc@lemote.com>
>>  M: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> -R: Aurelien Jarno <aurelien@aurel32.net>

Last time Aurelien commented on the Malta machine, was on March 23,
3 months ago, then there hasn't been Malta patches. As a reviewer
he is present and provides valuable feedback, why are you kicking
him out? See:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg691406.html

Huacai, has Jiangsu Lemote Tech Co., Ltd real interest to paid
employees to maintain the Malta board?

>>  S: Maintained
>>  F: hw/isa/piix4.c
>>  F: hw/acpi/piix4.c
>> @@ -1073,6 +1076,7 @@ F: tests/acceptance/machine_mips_malta.py
>>  
>>  Mipssim
>>  M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
>> +M: Huacai Chen <chenhc@lemote.com>
>>  R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
>>  S: Odd Fixes

Now that you have 2 maintainers, you can raise the status to Maintained.

>>  F: hw/mips/mipssim.c
>> @@ -1080,7 +1084,6 @@ F: hw/net/mipsnet.c
>>  
>>  R4000
>>  M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
>> -R: Aurelien Jarno <aurelien@aurel32.net>

I'm sure Aurelien will agree with this part. But let's wait
for his feedback.

>>  R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
>>  S: Obsolete
>>  F: hw/mips/r4k.c
>> @@ -1103,7 +1106,8 @@ S: Maintained
>>  F: hw/intc/loongson_liointc.c
>>  
>>  Boston
>> -M: Paul Burton <pburton@wavecomp.com>
>> +M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> 
> Missing in the patch description that you are taking this
> machine over.

After some rest I remember Paul said he'd come back on QEMU,
so it doesn't look right to kick him out that way.

Also in this thread you said you never saw a Boston board:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg691778.html

Paul might welcome you as a co-maintainer, but I rather keep
him for his expertise.

> 
>> +M: Huacai Chen <chenhc@lemote.com>

Huacai, similarly does Jiangsu Lemote Tech Co., Ltd have real
interest in time to provide developers to maintain the Boston
machine?

>>  R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
>>  S: Maintained
>>  F: hw/core/loader-fit.c
>> @@ -2677,7 +2681,8 @@ F: disas/i386.c
>>  
>>  MIPS TCG target
>>  M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
>> -R: Aurelien Jarno <aurelien@aurel32.net>
>> +M: Huacai Chen <chenhc@lemote.com>

$ git log --author='Huacai Chen <chenhc@lemote.com>' tcg/mips/ | wc -l
0

$ git log --grep='Reviewed-by: Huacai Chen <chenhc@lemote.com>'
tcg/mips/ | wc -l
0

git log --grep='Acked-by: Huacai Chen <chenhc@lemote.com>' tcg/mips/ | wc -l
0

>> +R: Jiaxun Yang <jiaxun.yang@flygoat.com>

$ git log --grep='Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>'
tcg/mips/ | wc -l
0

$ git log --grep='Acked-by: Jiaxun Yang <jiaxun.yang@flygoat.com>'
tcg/mips/ | wc -l
0

I think you are confusing sections, Since Huacai and Jiaxun never showed
interest in the TCG target code, how can they become maintainers?

>>  R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>

$ git log --grep='Reviewed-by: Aleksandar Rikalo' tcg/mips/ | wc -l
0
$ git log --grep='Acked-by: Aleksandar Rikalo' tcg/mips/ | wc -l
0

Apparently Aleksandar Rikalo can be "removed for not being present."

OTOH FWIW:
$ git log --author='Philippe Mathieu-Daudé' tcg/mips/ | wc -l
25
$ git log --grep='Reviewed-by: Philippe Mathieu-Daudé' tcg/mips/ | wc -l
99

So for this section changes:
NAcked-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

The rest is conditional of Paul Burton and Aurelien Jarno Ack-by.

>>  S: Maintained
>>  F: tcg/mips/
>>
> 
> 

