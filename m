Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D57C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 14:56:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C2A720719
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 14:56:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NHF2U+dq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C2A720719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kClEj-0003ZT-Gd
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 10:56:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42590)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kClDv-0002XI-9N
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 10:55:55 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:55070)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kClDt-0003cw-N8
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 10:55:54 -0400
Received: by mail-pj1-x1042.google.com with SMTP id mm21so761094pjb.4
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 07:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Q3qqEumtpcKe+NzD5BpfBt8Unr/mc/TMx0+JL6z8Q5U=;
 b=NHF2U+dqDcwAjZAIonPeTm7Y6SgtW7B94ZxePJejYq6/trTGgLQpIkZQW7tg/lO9+D
 6x/ffDonTcSCEX1FGORlyedWshuhrh3N0n6Z5R4Sp1b5c6Vzp9cEF0MTECfjlxTvTM3S
 yzHoNU8gDGFpdL0gOKT0rLun4PBec4ChFgRCrkzbPncMhbt4uHe42ItbaYbTdbhJp36N
 xIn06dTc+E8PRFAxUBu8PIXa1yNTDPBmL9T4SZYZTWpT9DPfZ7wOybBvH9FbKRUq/GLS
 ldcmMMti5z9QZxNc0R2Q3QyVRpNIk177oKmrRqqIKkFn4q4N/AuDYyT4gEu6TQcyUGxa
 7AlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Q3qqEumtpcKe+NzD5BpfBt8Unr/mc/TMx0+JL6z8Q5U=;
 b=bRcL83nst5Nm9UwR8aYYvyC6kS93LqYbjlnOOy88bwcJuQgLy+GaX0X5vp/gfZU0cg
 JoqijrRVy6FxpHkM3MN9IoTPP+4Pbe/Pgg92Jb0q0ZV0vZUhCG2vND420fh401ZvoOLg
 +is7Vv5w62acuw3AA+M1vUF0s5e21OLM8b+DwlZ3dyW8ec9kNe2airjUwPqGSETbU3AU
 cDIc5YjPpVlnN24FA1JavwR8voGWZTUPgbJLlAEe+s56maQB8gkLr0BZKH2Uu1UBOd0h
 Y8L2IseLiN+yS0Binc0pNb2Q919ejtSaxOKzBpeow54CbH7vNnI4l5byRuTq0JUthLco
 iZLQ==
X-Gm-Message-State: AOAM530q6NtPWjVc67+WbudyUtZwXYdDk9FizeQmSm2UilUbyOb8KIWc
 iMx2cFI3+niFojqaW73Yh5eEue/ht6lg1w==
X-Google-Smtp-Source: ABdhPJxZiHCOi/eCKCAjFby0jr9Ie0ud6ANlaCfCUU7oMJF+RqeKPhcVVex0NjLoYbcxGsL1d6i3Jg==
X-Received: by 2002:a17:90b:3750:: with SMTP id
 ne16mr1708245pjb.6.1598885751108; 
 Mon, 31 Aug 2020 07:55:51 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id p17sm8072562pfn.147.2020.08.31.07.55.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Aug 2020 07:55:50 -0700 (PDT)
Subject: Re: [PATCH v2 27/76] target/microblaze: Check singlestep_enabled in
 gen_goto_tb
To: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
References: <20200828141929.77854-1-richard.henderson@linaro.org>
 <20200828141929.77854-28-richard.henderson@linaro.org>
 <20200831135416.GC14249@toto>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <bd6b8e33-c718-c5a8-c196-41f1c4191354@linaro.org>
Date: Mon, 31 Aug 2020 07:55:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200831135416.GC14249@toto>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1042.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.13,
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

On 8/31/20 6:54 AM, Edgar E. Iglesias wrote:
>> +        TCGv_i32 tmp = tcg_const_i32(EXCP_DEBUG);
>> +        tcg_gen_movi_i64(cpu_SR[SR_PC], dest);
> 
> This needs to be i32 cpu_pc to avoid breaking bisection. Looks like this
> part slipped over to the next patch.
> 
> With that fixed:
> Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Whoops, yes.  Thanks.


r~

