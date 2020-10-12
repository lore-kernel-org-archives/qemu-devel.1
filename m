Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F93C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 11:10:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F0882076E
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 11:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Je350kYA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F0882076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRviT-0006Ue-8D
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 07:10:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34874)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRvhn-0005xk-US; Mon, 12 Oct 2020 07:09:27 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:34578)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRvhm-0003nT-3v; Mon, 12 Oct 2020 07:09:27 -0400
Received: by mail-wm1-x341.google.com with SMTP id l15so13542220wmh.1;
 Mon, 12 Oct 2020 04:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Y1DvR9Wu/fFEDAtZ00ZeWHpKTHUHpqy583395dNRKf8=;
 b=Je350kYAX4WQeU4OWCUPzkPvqqeqy+aJr34LpvZwH8G1HL+TSNHKgjuA2VxmgQxZrA
 XqybaSWHT3aYEC4g6nrZzLko26Cm8bBY/7g5IuJAJXUXEFJDNL/ZcuVEdTqFSXeLHWuG
 sfaSwHzh1pW0j8Zh4AdamT/z6LYOFbjvUKS66v5GaQYIQ1MwiBOOT+onpWdPVraCrcXO
 K1IKHz4+KhqJtxuquuddD5vSPU2S2HbGB6/SURPnCi20GbMvlUxinTMK4UJNJnnlmWEJ
 FpniKBI7RLsjG4w6v1u+GcjTNvujpWRcnLe/nt4cu1E3hTBAfWpuj2q74GxEJdeTp+Le
 hvWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Y1DvR9Wu/fFEDAtZ00ZeWHpKTHUHpqy583395dNRKf8=;
 b=DWIVzlfPDd6q3RBNdg1x+86mMIGObKZX2cnWliSk8DLeazXswy1AFtGMfe60b3vL7m
 g+uW6ptQ1cHdAo23ZPRG2rU30pZrlfE5/wHCEVr5DLk5fbKPrk6d5e44FGmY3BzdyVBI
 P/M7m3PAHPbC32IlqZ0GaaNybxYHHSRjfJH2PAMY7+ddsw6LLM+9yaP58Fja/2biLBzr
 0ERtodhJ7230HyJFmKaMww+ojXVObAAfyf9SEaCi0x03dpgvZG/hcGKzpcirnCGmxyRT
 u375oqvIWFJmqbj/c/6uHXZzJavnqoIBNrz84guZSt91Oc6+lSaZollZNg4nuBW098sC
 O9GQ==
X-Gm-Message-State: AOAM530TQqOw6V8/BmlcALqwvvjvGfh/1EAiIkDqGRbHcm659dt7oBYU
 +hLRRp0neGws0J78PJKNHqFKv8ncWKs=
X-Google-Smtp-Source: ABdhPJxY3sZIjPtEx9D45lbWngsID6uFqo7lsh9iqAly3lzdPCjsXiT3bAD0lh43xUXrMp1fDmfOpg==
X-Received: by 2002:a7b:c4cb:: with SMTP id g11mr6093613wmk.88.1602500963394; 
 Mon, 12 Oct 2020 04:09:23 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id o184sm2075334wmo.37.2020.10.12.04.09.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Oct 2020 04:09:22 -0700 (PDT)
Subject: Re: [PATCH] hw/net: move allocation to the heap due to very large
 stack frame
To: David Gibson <david@gibson.dropbear.id.au>,
 Elena Afanasova <eafanasova@gmail.com>
References: <8f07132478469b35fb50a4706691e2b56b10a67b.camel@gmail.com>
 <20201010060745.GK1025389@yekko.fritz.box>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a329006c-ed11-2f1b-5766-7480c19c0462@amsat.org>
Date: Mon, 12 Oct 2020 13:09:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201010060745.GK1025389@yekko.fritz.box>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.001,
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
Cc: qemu-trivial@nongnu.org, jasowang@redhat.com, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/10/20 8:07 AM, David Gibson wrote:
> On Fri, Oct 09, 2020 at 07:02:56AM -0700, Elena Afanasova wrote:
>> >From 09905773a00e417d3a37c12350d9e55466fdce8a Mon Sep 17 00:00:00 2001
>> From: Elena Afanasova <eafanasova@gmail.com>
>> Date: Fri, 9 Oct 2020 06:41:36 -0700
>> Subject: [PATCH] hw/net: move allocation to the heap due to very large stack
>>   frame
> 
> Patch looks fine, but some more details of the motivation would be
> nice.  I wouldn't have thought that the size of a network packet
> counted as a "very large" stack frame by userspace standards.

Maybe academia doing research on "super jumbo frames"?

"Super jumbo frames ... increase the path MTU of high-performance
national research and education networks from 1500 bytes to 9000
bytes or so, a subsequent increase, possibly to 64,000 bytes"

(https://en.wikipedia.org/wiki/Jumbo_frame#Super_jumbo_frames)

> 
>> Signed-off-by: Elena Afanasova <eafanasova@gmail.com>
>> ---
>>   hw/net/spapr_llan.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/net/spapr_llan.c b/hw/net/spapr_llan.c
>> index 2093f1bad0..581320a0e7 100644
>> --- a/hw/net/spapr_llan.c
>> +++ b/hw/net/spapr_llan.c
>> @@ -688,7 +688,8 @@ static target_ulong h_send_logical_lan(PowerPCCPU *cpu,
>>       SpaprVioDevice *sdev = spapr_vio_find_by_reg(spapr->vio_bus, reg);
>>       SpaprVioVlan *dev = VIO_SPAPR_VLAN_DEVICE(sdev);
>>       unsigned total_len;
>> -    uint8_t *lbuf, *p;
>> +    uint8_t *p;
>> +    g_autofree uint8_t *lbuf = NULL;
>>       int i, nbufs;
>>       int ret;
>>   
>> @@ -729,7 +730,7 @@ static target_ulong h_send_logical_lan(PowerPCCPU *cpu,
>>           return H_RESOURCE;
>>       }
>>   
>> -    lbuf = alloca(total_len);
>> +    lbuf = g_malloc(total_len);
>>       p = lbuf;
>>       for (i = 0; i < nbufs; i++) {
>>           ret = spapr_vio_dma_read(sdev, VLAN_BD_ADDR(bufs[i]),
> 


