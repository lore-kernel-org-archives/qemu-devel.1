Return-Path: <SRS0=OYoK=CH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7817C433E6
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 15:34:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 870F520791
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 15:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vaVncUlY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 870F520791
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kC2ry-0002rL-P8
	for qemu-devel@archiver.kernel.org; Sat, 29 Aug 2020 11:34:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46056)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kC2lz-0006rJ-8y
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 11:28:07 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:37325)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kC2lx-0006Qv-6Q
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 11:28:06 -0400
Received: by mail-pj1-x1042.google.com with SMTP id mw10so887127pjb.2
 for <qemu-devel@nongnu.org>; Sat, 29 Aug 2020 08:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Bf+K9Z9xmGvjQb8nFKST0v197yf7vY++myTg2dcX7j4=;
 b=vaVncUlY7wbfJ/b8MBlgjhigQycLWrAFlSn1op6tisv5XXLCRcNjfj2Jwor9PI88qT
 Fy9E6kcts++qfsShFOpUkQAOchXIjcWDbMuS59BiOZNLYEomulmTXEg/TUCzoNxtvmKe
 VHYKG4a/QiZQVVPlsNDSGXl0zjLn1gFGh4mpX5PtS+zLteKHJITgU/pPeqbo/hLBAtE7
 KFCMrouJGbwI35trUIF0I3q/A6Dl6bs/AmOVPycvMzU++kfk/8YxsYIi+MKANCFUjpzH
 lv4Vyrwev7siawDrCeJU0o0PyeEbGWuBH8nZKyxu7D7cBeri2d6/beCH+V/3ReQedpTV
 eR4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Bf+K9Z9xmGvjQb8nFKST0v197yf7vY++myTg2dcX7j4=;
 b=DfCLp8CmOcJGeu49lq6tCBKQqRa9IUekX/KWx6/zgQi9JCc+EHWXV4AJOX7q8MfFcg
 h49ZpHqTnnnDg5SQEu8XKQLce/PNLvwf4Z6jjLt3nvv2H3F8nKunCi9x0F4IvaFrHCli
 wH0lzGAC+HW54EAqOHazgz9ajYuPyCFKAZ6hNG2DiE99U4VMzjLzpWSCsYzOqUDimpDt
 isJkWjA6xevnId4aMaajx3YSTzMR0UN6tBJ6oMN36t8LLUCMFAzhzMzZlElY/ZofOmT/
 R4BT8mzf1D61pIGrN4hiIY2xfcI3Foy81aFUN9xTuXH0YAgXCF4tDorNxv0MH0FSjTW6
 5oYg==
X-Gm-Message-State: AOAM533B1jCcjqgaRAw7UXUUmWgzvBqXUL4QiJXP1UXsB0eeqVodbeNw
 uaVsewA4cZobZRvUqCQJWyfFbjYMFoBPxw==
X-Google-Smtp-Source: ABdhPJy4UEQLjQhGMrO75YOW9I3PuVStmaX4BNNRfIjqFJOCNo7trqb0frRFeBR4Xzecjlthly+S2Q==
X-Received: by 2002:a17:90b:384b:: with SMTP id
 nl11mr3405045pjb.91.1598714883041; 
 Sat, 29 Aug 2020 08:28:03 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id e142sm3179665pfh.108.2020.08.29.08.28.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 29 Aug 2020 08:28:02 -0700 (PDT)
Subject: Re: [PATCH 62/77] target/microblaze: Try to keep imm and delay slot
 together
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20200825205950.730499-1-richard.henderson@linaro.org>
 <20200825205950.730499-63-richard.henderson@linaro.org>
 <20200827191722.GP2954729@toto>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b5871fb3-5bb9-1ea6-4412-b99530c3618b@linaro.org>
Date: Sat, 29 Aug 2020 08:27:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200827191722.GP2954729@toto>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1042.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.809,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/27/20 12:17 PM, Edgar E. Iglesias wrote:
> On Tue, Aug 25, 2020 at 01:59:35PM -0700, Richard Henderson wrote:
>> If the last insn on a page is imm, or a branch with delay slot,
>> then end a tb early if this has not begun the tb.  If it has
>> begun the tb, then we can allow the tb to span two pages as if
>> the imm plus its consumer, or branch plus delay, or imm plus
>> branch plus delay, are a single insn.
>>
>> If the insn in the delay slot faults, then the exception handler
>> will have reset the PC to the beginning of this sequence anyway,
>> via the stored D_FLAG and BIMM_FLAG bits.
>>
>> Disable all of this when single-stepping.
> 
> 
> Hi Richard,
> 
> We've got a Linux boot that fails after applying this patch.
> It goes from always working to only working like 1 out of 3 times.
> It fails deep in user-space so I don't have a good log for it.

I think I've found it: do_rti, do_rtb, do_rte are acting as normal jumps.  They
need to set DISAS_UPDATE so that they return to the main loop to re-evaluate
interrupts.

I'll come back to this after we deal with the other 76 patches.


r~

