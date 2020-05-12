Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CABAC54E8F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 07:09:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B9B42082E
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 07:09:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y8ovyKdm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B9B42082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYP37-0000EP-KD
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 03:09:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54126)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jYP2G-0007Ub-AA
 for qemu-devel@nongnu.org; Tue, 12 May 2020 03:09:04 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:38020)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jYP2F-0008RF-C2
 for qemu-devel@nongnu.org; Tue, 12 May 2020 03:09:04 -0400
Received: by mail-wm1-x344.google.com with SMTP id g12so21994493wmh.3
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 00:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=9F9VLmtxyUsPG0AZGPw1KPbx9L6outE5uljpchHOvvw=;
 b=Y8ovyKdmwESylpn0dYVAWk9N7z+iA93gYKGoYThXCQ7Vmb50WkYfbw0ybk7nx8q5Jb
 LV3Ha+84HjCZV8+ytdB//4RulsUZY6QdZmm13ENGoHlGZZHCJwc4RwFPvDwKLItoa06k
 PyJzvVfIBfC0QkYO4LrVtug8S4AYTmekcFWEHwk4Y9elclElB+ZI/xhY5ZhdsJIB01b7
 hAOziNPVpYOKnEDGpc/CGPMuI/Ns6fiLE4gZ//DVSGaHqrLOd5AFM7PCYTM6/XPXI0uE
 bilZM/4OfQdmwIupQL66f0EdOQkS95KQzahVzGMLQSooSo2m4nHnQh37iegmxq1SuDis
 OFIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9F9VLmtxyUsPG0AZGPw1KPbx9L6outE5uljpchHOvvw=;
 b=Oj8GHVVdgpEgXtJUgfLE+nwXTu9lJHnU4maOR50hURW2E8y/ZzF7QTOGJK6Ve2tD0w
 HI2xg69z8FdqZxmSonTP5yNOkCqwweQA0/NNDQYcUsdcV5xrnmlbp0vPNiLyXkP+/5c5
 tyzFE58/FBe3xv562j4ZB58/WsJdarTsbV66OywVryR33acu0YlTsEJz/HwacAWlkSWX
 /b6ExKvowfdlTWcNd1ir5i5bFwIjAoSH4iZdG1bkbZMBLiFXxwzB9D9nYvlcqZ6fqXPc
 4Gh6VGkrpJJiZyR29JdeA31vc2m1pj4yCKSVQ4Vx6f+aqyabXDa1eRsNrqwLkvzLO+V9
 JZRA==
X-Gm-Message-State: AGi0PuYirwFw62eknEQBBxxCsriuRNAF4P+x7LisyEkLHg1tMV819CLe
 B9b3LAJjJ76yGrWEUTcFcVY=
X-Google-Smtp-Source: APiQypKbA7GYrSnLEXgIFkKe78A1EP6EVEoBWLxtoSMIj9FB9Cdl0dL3Xh3GxX2TXT4DJhiikH8iXQ==
X-Received: by 2002:a7b:c399:: with SMTP id s25mr34428758wmj.169.1589267341862; 
 Tue, 12 May 2020 00:09:01 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id t71sm31657524wmt.31.2020.05.12.00.09.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2020 00:09:01 -0700 (PDT)
Subject: Re: [PATCH 1/2] hw/mips/mips_int: De-duplicate KVM interrupt delivery
To: chen huacai <zltjiangshi@gmail.com>
References: <20200429082916.10669-1-f4bug@amsat.org>
 <20200429082916.10669-2-f4bug@amsat.org>
 <CABDp7VoyvX2vD6awEC-GwnEu8SW=pMPPR7mrfKCSzamrnomPKg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <dc94a9f4-b6c9-97fa-4515-3e51ef9b816a@amsat.org>
Date: Tue, 12 May 2020 09:08:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CABDp7VoyvX2vD6awEC-GwnEu8SW=pMPPR7mrfKCSzamrnomPKg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
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
Cc: Huacai Chen <chenhuacai@gmail.com>, qemu-level <qemu-devel@nongnu.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Huacai Chen <chenhc@lemote.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/29/20 10:48 AM, chen huacai wrote:
> Hi, Philippe,
> 
> On Wed, Apr 29, 2020 at 4:30 PM Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>
>> Refactor duplicated code in a single place.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>   hw/mips/mips_int.c | 11 +++--------
>>   1 file changed, 3 insertions(+), 8 deletions(-)
>>
>> diff --git a/hw/mips/mips_int.c b/hw/mips/mips_int.c
>> index 796730b11d..4a1bf846da 100644
>> --- a/hw/mips/mips_int.c
>> +++ b/hw/mips/mips_int.c
>> @@ -47,17 +47,12 @@ static void cpu_mips_irq_request(void *opaque, int irq, int level)
>>
>>       if (level) {
>>           env->CP0_Cause |= 1 << (irq + CP0Ca_IP);
>> -
>> -        if (kvm_enabled() && irq == 2) {
>> -            kvm_mips_set_interrupt(cpu, irq, level);
>> -        }
>> -
>>       } else {
>>           env->CP0_Cause &= ~(1 << (irq + CP0Ca_IP));
>> +    }
> Since the if-else has become one line, so can we remove { and } here?

This is the QEMU coding style, see CODING_STYLE.rst:

Block structure
===============

Every indented statement is braced; even if the block contains just one
statement.  The opening brace is on the line that contains the control
flow statement that introduces the new block; the closing brace is on the
same line as the else keyword, or on a line by itself if there is no else
keyword.  Example:

.. code-block:: c

     if (a == 5) {
         printf("a was 5.\n");
     } else if (a == 6) {
         printf("a was 6.\n");
     } else {
         printf("a was something else entirely.\n");
     }

Rationale: a consistent (except for functions...) bracing style reduces
ambiguity and avoids needless churn when lines are added or removed.
Furthermore, it is the QEMU coding style.

> 
>>
>> -        if (kvm_enabled() && irq == 2) {
>> -            kvm_mips_set_interrupt(cpu, irq, level);
>> -        }
>> +    if (kvm_enabled() && irq == 2) {
>> +        kvm_mips_set_interrupt(cpu, irq, level);
>>       }
>>
>>       if (env->CP0_Cause & CP0Ca_IP_mask) {
>> --
>> 2.21.1
>>
>>
> 
> 

