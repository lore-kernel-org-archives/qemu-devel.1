Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A16C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 15:26:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FD8C2075F
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 15:26:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mMRxRrAE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FD8C2075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb486-0002sY-Hz
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 11:26:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45876)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jb3kJ-0004oX-Gg
 for qemu-devel@nongnu.org; Tue, 19 May 2020 11:01:31 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:38716)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jb3kG-0004Pr-GR
 for qemu-devel@nongnu.org; Tue, 19 May 2020 11:01:31 -0400
Received: by mail-pj1-x1043.google.com with SMTP id t40so1558805pjb.3
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 08:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=8WpkpWs8V86Gc8gc77N2XQWTpffdKfWcfxHGbhsMmCc=;
 b=mMRxRrAE4XvnMSqwO2ocdQ1cwhs50eUlpW7oVyzheg9zfDPBBzrIz0xRm5eNNOKkS3
 VledJpczhTgTWGMjo2VMMwC7uoZRgZyDI95WnY+UklkXcPCNM7R7vuNwnVtf7oEeNXqQ
 VaQi/Q71v5qpj48RYWQanQOVwNpjSHBJpsYxdlX5ONy3VqokDx48oePEYfmclBNGNg1f
 vZuyxQ9SJg2SCnP6dCO2Qia18eR47m98EgFQhMY9htjoeglDLUeyR1H4rScs1VUsY3pk
 nIeQd4eSHUatm6R45lJpmYpGjwlaX0IxugTM5aVgNkJPNsqcgTc2y3AJVsiSFuKT+7dF
 ooHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8WpkpWs8V86Gc8gc77N2XQWTpffdKfWcfxHGbhsMmCc=;
 b=sazpmTxOEAdsw9kzhfhPNjz1iwWTP+sJpFqw7h0T6bk9Gp8ZXH6euBOqXpd99DvEWB
 PeZU+O6uTouYI+588bXT5DipJPL4dEUVAB9dd+1zzAlBjWzKHthhcOGSpFqnpV79Zyb7
 E9B87kZopvsp6+tLdlufxqjboYLb384ErVkD4Mpwmf36uJMRrVltvVvIQdBONqshuqX4
 2PoRf/pO9oLysF3hu1QggvZixc0gfjTBw5lTq6n9n6+9asoeSl4Umb4VXAAagb/KMo4g
 a/Pc69LPDZPqbtt99ielBcRgsf6ujYw2herQKs3vu5dDKFkhnFEv5v/QnIAnLzdY413U
 MXVQ==
X-Gm-Message-State: AOAM531uXpuTVF90bYGdd5TcKnbKXAosfxDxF4NMFODpX73GaWCZT9un
 2lI087vGVUQG2W4ZenZfPASBSQ==
X-Google-Smtp-Source: ABdhPJwv4MJ+N6Aq41h3IchD6VNwXiFguhGnL9aazbDEW9fjcoVoxSIs92aiNoYu0g5XBIXFLTdO/A==
X-Received: by 2002:a17:90a:d598:: with SMTP id
 v24mr5095316pju.167.1589900485507; 
 Tue, 19 May 2020 08:01:25 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id b29sm108691pff.176.2020.05.19.08.01.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2020 08:01:23 -0700 (PDT)
Subject: Re: [PATCH v2] target/arm: Allow user-mode code to write CPSR.E via
 MSR
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200518142801.20503-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <dd4cbf09-8f6d-8034-661b-ffa4195e56d7@linaro.org>
Date: Tue, 19 May 2020 08:01:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200518142801.20503-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1043.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Amanieu d'Antras <amanieu@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/18/20 7:28 AM, Peter Maydell wrote:
> Using the MSR instruction to write to CPSR.E is deprecated, but it is
> required to work from any mode including unprivileged code.  We were
> incorrectly forbidding usermode code from writing it because
> CPSR_USER did not include the CPSR_E bit.
> 
> We use CPSR_USER in only three places:
>  * as the mask of what to allow userspace MSR to write to CPSR
>  * when deciding what bits a linux-user signal-return should be
>    able to write from the sigcontext structure
>  * in target_user_copy_regs() when we set up the initial
>    registers for the linux-user process
> 
> In the first two cases not being able to update CPSR.E is a bug, and
> in the third case it doesn't matter because CPSR.E is always 0 there.
> So we can fix both bugs by adding CPSR_E to CPSR_USER.
> 
> Because the cpsr_write() in restore_sigcontext() is now changing
> a CPSR bit which is cached in hflags, we need to add an
> arm_rebuild_hflags() call there; the callsite in
> target_user_copy_regs() was already rebuilding hflags for other
> reasons.
> 
> (The recommended way to change CPSR.E is to use the 'SETEND'
> instruction, which we do correctly allow from usermode code.)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> v2 changes:
>  * fixed wrong variable name in commit message
>  * added arm_rebuild_hflags() call in restore_sigcontext()
> ---
>  target/arm/cpu.h        | 2 +-
>  linux-user/arm/signal.c | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

