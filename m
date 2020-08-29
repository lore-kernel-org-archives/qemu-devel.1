Return-Path: <SRS0=OYoK=CH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ABBEC433E2
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 15:36:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 273C720E65
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 15:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u4Xrsq7K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 273C720E65
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kC2uS-0005zY-C1
	for qemu-devel@archiver.kernel.org; Sat, 29 Aug 2020 11:36:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47126)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kC2t9-0004du-GL
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 11:35:31 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:34168)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kC2t7-0007Fl-Pb
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 11:35:31 -0400
Received: by mail-pl1-x642.google.com with SMTP id v16so1036746plo.1
 for <qemu-devel@nongnu.org>; Sat, 29 Aug 2020 08:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=R0T+3bFK4Lkmdk50p2Zrsx8zSBwhDlCtjm74GpLFRUc=;
 b=u4Xrsq7Kr6uGkzeP74QrkKt2fR4N3Ud4GtjbNz0BYco3Sj4mfN2xu0Va2QKqQRGDEe
 NjflCHrqw+ycffL0IirMD1fkm51l3ogWVgU5QqzOaZCxx4+MZ5J/ufDZoicqIXHua0P3
 ak1ugHnRROz351bF2++qcep3w2rnI8PvA2sIIm9YQEU7WZufjws5cDwiitkjZ8wQSsSz
 dzs4+YjonmH0XliYzGZpbRbkL5b/GT5lyQxx9kFeMYH+wdRopPxAlLxgfKNiisbxyJkT
 wdBpFRZX9z4YFhQzxSxYUokOwsMk36VEwMdZ+8bidr03ciktB6rOCSPAZJoVGZkm2RSC
 7g7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=R0T+3bFK4Lkmdk50p2Zrsx8zSBwhDlCtjm74GpLFRUc=;
 b=dLuM1tQ+bCSQlGKL4sHdNTXXCMpM+HpuqVLxJpMW4xivfN6KizFTec1FQhg8iwCn3t
 NnNR1hrXsovs2CTU3ZVidV8mDVIonlg+pgUelSPkCgleoNH+hqAffpEQvpKIKEmdevGO
 xcdy4qsvzjSpyUq62ov3oSGx7a/grgnu9zY5v3LgDiy4mQ8QX/+D3zAyOHArTpADxDED
 kYjzVCQLihBmHcWzY7h+0EevTWPiHA9mxbqg7vHIS6WUiC4yHF232Mx0kbFFk2kn8lKs
 flk6JtCsPuLOCA95l5KXzAwhS6AGjmsqQhfzQR9xnl8bXUEYJUOM24V/9XyLa1Tfqmv5
 /X1g==
X-Gm-Message-State: AOAM533ozvbxBgacDmLOcoNmjnJH/lXUcCahpnYS2OwkRgQSs89ME8Va
 aEKQ/OQDtU9uKRSx4qGOtQ55Vn1v3TjF4g==
X-Google-Smtp-Source: ABdhPJwY0EfeEM2k7124S1HjAiKV75U4WDV9ZowvwGopMqfJ09FDyMAD5ae2UECUYnMQ+hHEoyjRUA==
X-Received: by 2002:a17:90a:fd03:: with SMTP id
 cv3mr3393161pjb.111.1598715327779; 
 Sat, 29 Aug 2020 08:35:27 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id p11sm3060109pfn.109.2020.08.29.08.35.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 29 Aug 2020 08:35:27 -0700 (PDT)
Subject: Re: [PATCH] target/xtensa: enable all coprocessors for linux-user
To: Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org
References: <20200829104758.22337-1-jcmvbkbc@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <dd1fef75-1175-bd8d-4e68-a4101ab588e4@linaro.org>
Date: Sat, 29 Aug 2020 08:35:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200829104758.22337-1-jcmvbkbc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x642.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/29/20 3:47 AM, Max Filippov wrote:
> Linux userspace always sees coprocessors as enabled. CPENABLE register
> and coprocessor exceptions are used internally by the kernel to manage
> lazy coprocessor context switch. None of it is needed for linux-user.
> Always enable all coprocessors for user emulation.
> 
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

