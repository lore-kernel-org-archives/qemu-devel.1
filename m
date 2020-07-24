Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C6A9C433E8
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 09:38:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05A03206D7
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 09:38:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k1GEK1YD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05A03206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyuA7-0004KS-A7
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 05:38:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55778)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jyu9X-0003si-H9
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 05:38:07 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:47007)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jyu9V-0008Q0-2F
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 05:38:07 -0400
Received: by mail-wr1-x442.google.com with SMTP id r12so7658406wrj.13
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2020 02:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Nmq8mnTHVadgImNJjn1g+x4Sv4Nnb9lEVdkPr1n3lgA=;
 b=k1GEK1YDVepVlY73/S5Jkd8D9e/jP8S40wGN9gkriVQNrZPzxBnyknYDcjCXBcn54o
 7Y5pEaYoaxMkeLSNcobZ9CB8Cls9FjkGacNM3zyHiahiATAzFnW2uCtnrfXVndQBdNwp
 1GbEpGw+bY4ZPbWjpgEUFwpHSRwbL+C3pAf6a7w51hRCN9Yl+3XNTvb5pYuezkVelsmZ
 Fa+IKtIEK64NPoWsUysVhmV7rY/jylQvoVAt/i+gQUJsEnUjjWvN2NpMd8TmUcvltDAd
 IPZUM5rUebdRPLae4yArU9nqCr7UxVR57+gYwxlEh1PL0q1YFzKc+iUBTpEZIM7Yzctv
 TKdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Nmq8mnTHVadgImNJjn1g+x4Sv4Nnb9lEVdkPr1n3lgA=;
 b=H4513dLGS1I+t07lA5n3azZgZcwsEE1QpIotFgQCDrkwc6R04TcIHIpFkw7P4EhSPb
 BH+5ZfS//wtZcT0LSviwCrDNGi9fK5vCfDhBCbqw5HSgaZhhufBgcs/+IfJNvnrX53GG
 F6SUlQE5u9tvXd+DCTr3aRDkZpELcnlg1DnIUO9533kAL/R84unzW2oBELdpvm2irCUw
 IH3zV2KVEiXXM5weIEfvno4fvAvPkkO8gIgD4bUiLmatjhFIBV0fEwL6CA5W8v4Sl7yB
 kACEmXQExoPnFvwsGcgOJJmrY+Ze7FQQ5ZaiUBNMVfeslXiELMB8biO8sNowZ+r+FQK/
 fcoA==
X-Gm-Message-State: AOAM531Rvrb01Iyen8HPKqym4ME7SANxuopTcOuPW/kDkDXiLnn/UPRT
 70YieKDO6kU7dwoE5NYfpWc=
X-Google-Smtp-Source: ABdhPJwdVAZ13xaRAb6PsYVlxJzn1QBDW8qBuXVhiOFyt87ThGAbSTmAk6JA234Pqx5ENBMnCttbzw==
X-Received: by 2002:a5d:490c:: with SMTP id x12mr7492705wrq.238.1595583482189; 
 Fri, 24 Jul 2020 02:38:02 -0700 (PDT)
Received: from [192.168.1.36] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id s19sm733105wrb.54.2020.07.24.02.38.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jul 2020 02:38:01 -0700 (PDT)
Subject: Re: [RFC PATCH] buildsys: Only build capstone if softmmu/user mode is
 enabled
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20200724071657.21508-1-f4bug@amsat.org>
 <5d8ade29-c085-9f6d-b896-fda48c1f5666@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <0ce8f279-1ef0-6d93-5fff-032783fba2b6@amsat.org>
Date: Fri, 24 Jul 2020 11:38:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <5d8ade29-c085-9f6d-b896-fda48c1f5666@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/24/20 9:56 AM, Thomas Huth wrote:
> On 24/07/2020 09.16, Philippe Mathieu-Daudé wrote:
>> At least one of softmmu or user mode has to be enabled to use
>> capstone. If not, don't clone/built it.
>>
>> This save CI time for the tools/documentation-only build jobs.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  configure | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/configure b/configure
>> index 4bd80ed507..bc5757159a 100755
>> --- a/configure
>> +++ b/configure
>> @@ -5381,6 +5381,10 @@ fi
>>  ##########################################
>>  # capstone
>>  
>> +if test -z "$capstone" && test $tcg = 'no' ; then # !tcg implies !softmmu
>> +  capstone="no"
>> +fi
> 
> I don't think this is right. You could have a KVM-only build where you
> still want to use the disassembler for the human monitor.

I had the same question with KVM, I agree this is unclear, this is why
I added RFC.

Don't we have !softmmu implies !kvm?

> 
> But maybe it could be disabled if softmmu="no", linux_user="no" and
> bsd_user="no" ?
> 
>  Thomas
> 
> 

