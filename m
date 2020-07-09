Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A53CC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 13:39:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 586D1207BB
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 13:39:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GwITJ2Ch"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 586D1207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtWmB-0007Mb-LO
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 09:39:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40012)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jtWlU-0006RA-3n; Thu, 09 Jul 2020 09:39:04 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:56028)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jtWlS-0004R3-EC; Thu, 09 Jul 2020 09:39:03 -0400
Received: by mail-wm1-x341.google.com with SMTP id g75so1835333wme.5;
 Thu, 09 Jul 2020 06:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=IMAkJsQQS63Q07JJMyqhaX6Y/9enYz61VenxRjMy40c=;
 b=GwITJ2Chbft3/qxp5OL2M0q4asDG0nPH42mL2uvWLSoh9xhWA/sD2lh0+WmbI+Kpbm
 OcxTuN1JIxqOu1Kg5ruXD5Es854msFPJH8dLUbt6/kM4XMwa72ehURnSNzMnTnQMzr+W
 Oku7dVDdxZxvp2sIgD0yzIr8q2nTtBDqR3CJ/1Qo1BZ2Wcdb6Izsp99HKMH6y2im+mW0
 d49ubplfCshZwmNIQXikFUUqjPEdzuAcaFydYSBmCQpVQA2UQor2NS3glgBQ25QSKCHf
 HVflyRmFGjOlT4qZLdCeNBJPg7BMrJgCwBS50zyG1KSP4Zxrp/adaJza5fx/A1RjDxOf
 GTXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IMAkJsQQS63Q07JJMyqhaX6Y/9enYz61VenxRjMy40c=;
 b=ehMianQI8pkKr5yPlsukCWjA/tAk5kJM1F8lsLc3J6jiigLuppFvpfd5UWQ2g8CM5N
 zc9r/rbyBtY4YOdcqdKdsBV3YztwcslH2KEoueqk8iMbl1XcYkdJHbv5kg34uZaKfpiS
 pu4gALhE+vTYoUeRfVrBAZazLzoXogYn314OOFnBG1xRS4JVla5wNAtXAXFq4hCftTbk
 Q7lZIKJ6YnUAsCelOQ4jIzEruwV7avgqoZbx4A2xtRo1GOo0Bshcpc8A7riDIrgmyxhb
 Ul87dhqhysPuUFLSqdyca+szfv7u9bjLnTqLVzsrcoqQqueiUzwIFzbkGZB5CKZr+X45
 OJng==
X-Gm-Message-State: AOAM531mr0vJbgF7N2KfJcaHWnQ/g1QGPNVV5ya33s1svkQ9tk1AdjXT
 lCgcBFWYxNqE4afHcd757XwUdNUTV8E=
X-Google-Smtp-Source: ABdhPJxXPjk99ZIrLW7Z3jxWnHgoT2fh0qmhvHStHHXIUx6XPzr/uzLcMAV3FnCq7NXSRfG9WHSrwQ==
X-Received: by 2002:a1c:2e58:: with SMTP id u85mr6597wmu.123.1594301940287;
 Thu, 09 Jul 2020 06:39:00 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id q7sm5973238wrs.27.2020.07.09.06.38.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jul 2020 06:38:59 -0700 (PDT)
Subject: Re: [PATCH] Fix MIPS add.s after
 1ace099f2acb952eaaef0ba7725879949a7e4406
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 Alex Richardson <Alexander.Richardson@cl.cam.ac.uk>
References: <20200703161515.25966-1-Alexander.Richardson@cl.cam.ac.uk>
 <CAL1e-=huJ8hLCb7gG=cZ6bXcqMOUSA17NHpnCEED18MR4mKXhw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <7449e90a-7d04-5a4c-d301-21a46242a1a6@amsat.org>
Date: Thu, 9 Jul 2020 15:38:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAL1e-=huJ8hLCb7gG=cZ6bXcqMOUSA17NHpnCEED18MR4mKXhw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Aleksandar,

On 7/7/20 6:26 PM, Aleksandar Markovic wrote:
> On Fri, Jul 3, 2020 at 6:33 PM Alex Richardson
> <Alexander.Richardson@cl.cam.ac.uk> wrote:
>>
>> After merging latest QEMU upstream into our CHERI fork, I noticed that
>> some of the FPU tests in our MIPS baremetal testsuite
>> (https://github.com/CTSRD-CHERI/cheritest) started failing. It turns out
>> this commit accidentally changed add.s into a subtract.
>>
>> Signed-off-by: Alex Richardson <Alexander.Richardson@cl.cam.ac.uk>
>> ---
> 
> Applied to MIPS + TCG Continuous Benchmarking queue.

If you don't mind I'll include this patch for the mips pull request I
plan to send before hard freeze (on the list). I'm keeping your S-o-b.

> 
>>  target/mips/fpu_helper.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/target/mips/fpu_helper.c b/target/mips/fpu_helper.c
>> index 7a3a61cab3..56beda49d8 100644
>> --- a/target/mips/fpu_helper.c
>> +++ b/target/mips/fpu_helper.c
>> @@ -1221,7 +1221,7 @@ uint32_t helper_float_add_s(CPUMIPSState *env,
>>  {
>>      uint32_t wt2;
>>
>> -    wt2 = float32_sub(fst0, fst1, &env->active_fpu.fp_status);
>> +    wt2 = float32_add(fst0, fst1, &env->active_fpu.fp_status);
>>      update_fcr31(env, GETPC());
>>      return wt2;
>>  }
>> --
>> 2.27.0
>>
>>
> 


