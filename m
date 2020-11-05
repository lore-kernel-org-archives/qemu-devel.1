Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E71C388F7
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 22:16:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE7952068E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 22:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t+Abl4zp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE7952068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kanYj-0005qq-Jf
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 17:16:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39048)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kanXm-0005O2-DM
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 17:15:47 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:34382)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kanXj-0003kR-Jn
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 17:15:45 -0500
Received: by mail-pg1-x544.google.com with SMTP id t14so2346651pgg.1
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 14:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=GcBcNRfJUezucSvg8wgF7t0aSV5KGLal68AET7W+8go=;
 b=t+Abl4zpvTh63tilk0dZqDtEPy08VP+07fVY1ugh+e+NZElGrMx1LrxqUkLQKw2nnW
 N8XoKbor6AsOnDGW0xlgPtPtBLwOpmh0nJS95YhVwiHGHCRVEAwDvMO8WGKIoJ/I6ac3
 +IZmzRhnYg1/uDKeUcOrbCma3xUbKO+bu524q/6IWLfHte7rdMFAVP7cM5r3tkslGyUv
 ZO6uANiBdp2NdhgEuhSb5DtZrp9Uw6OwqZ8Waqdui5jmTLEBPCkl6qQO5sa16T3C8Rq1
 F69oIbDO+1cEKvqHuhGS5mVaqhM1z9HZzQ8/bn4r/TUdhXAiHaXz+X9W8DOzXoDbJAh5
 Jbdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GcBcNRfJUezucSvg8wgF7t0aSV5KGLal68AET7W+8go=;
 b=pjs3i7f3chGBDmtU3PCB651vJ1eU3X4zdK36Z6iEoh98/2u7smT118jW/YJQnkCdC0
 RqXiVpKWshIuiR+NaVPzUGrLyweH5zgu61Z0b/q8YpA6D7TWOBaHDX1Grim1kKPux8wt
 HJFbV7pXg8FzHAyBBYzQlwXTtFBPuFByNEJhPZXQNlsuiGfahJqByP9LUFR4YksTNCe3
 zu2SkimdkYmowAuA33Hs+FsT6tF1XJ0u56Jpi3AFw/9Z3jYxN3yeAGnCguzMPm2xe4YZ
 b6pJDiXwjNTagBlMb7yabNClGiDQXhwzlPs+WZQQCWfP8g9HqRGrMKsMpVVSo0NT2NE+
 Wi0w==
X-Gm-Message-State: AOAM530tr5HUBDpXlUYF/svReX+W6gUgvk2EPSPJTmJbF00PPVwjrtW6
 ABeyRfXzfgqCl5aJvXEGwFFvCA==
X-Google-Smtp-Source: ABdhPJxG3dTFJSnJB8JawzmcW6JqJoSUvx8cuNp4SQpWFphJChuBueFJcr7sUH+OH7xVLshcGjee1g==
X-Received: by 2002:a17:90a:c683:: with SMTP id
 n3mr4395518pjt.163.1604614541780; 
 Thu, 05 Nov 2020 14:15:41 -0800 (PST)
Received: from [172.16.1.221] (76-14-210-194.or.wavecable.com. [76.14.210.194])
 by smtp.gmail.com with ESMTPSA id gf17sm3153132pjb.15.2020.11.05.14.15.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2020 14:15:41 -0800 (PST)
Subject: Re: [PATCH for-5.2 1/3] linux-user/sparc: Fix errors in
 target_ucontext structures
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20201105212314.9628-1-peter.maydell@linaro.org>
 <20201105212314.9628-2-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6bdc7371-58a8-a4a8-a948-8e7fce921fdb@linaro.org>
Date: Thu, 5 Nov 2020 14:15:38 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201105212314.9628-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
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
Cc: Giuseppe Musacchio <thatlemon@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/5/20 1:23 PM, Peter Maydell wrote:
> The various structs that make up the SPARC target_ucontext had some
> errors:
>  * target structures must not include fields which are host pointers,
>    which might be the wrong size.  These should be abi_ulong instead
>  * because we don't have the 'long double' part of the mcfpu_fregs
>    union in our version of the target_mc_fpu struct, we need to
>    manually force it to be 16-aligned
> 
> In particular, the lack of 16-alignment caused sparc64_get_context()
> and sparc64_set_context() to read and write all the registers at the
> wrong offset, which triggered a guest glibc stack check in
> siglongjmp:
>   *** longjmp causes uninitialized stack frame ***: terminated
> when trying to run bash.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

> +} __attribute__((aligned(16)));

Hmph, 96 uses of the attribute directly, 20 uses of QEMU_ALIGNED.  I suppose we
should just remove the wrapper...


r~

