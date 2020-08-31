Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5626C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 21:27:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 675CB20719
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 21:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UP+mQycb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 675CB20719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCrKX-00051a-9o
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 17:27:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47236)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCrCK-0002an-Qd
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 17:18:40 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:38548)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCrCJ-0001TG-40
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 17:18:40 -0400
Received: by mail-pf1-x444.google.com with SMTP id d22so1395395pfn.5
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 14:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=lEAC0sSRDk8AHWvjEH7biZuBF1C2T1sYg1EOKUCzcd8=;
 b=UP+mQycbq8qhOGg+R+Nbn2/6U2WQeAY/M+4L5sTvCUWEGJs5avlsdIL0ZL3d4iaX2B
 oGF4ARyvz7NWjpMgm54mhPHBC+3F2pg23Lxdc0BPyWx3/1og8RNy9dtQgRqkgi9sgBvx
 3jwc8MtsKPLmq0T8ODfiPDxIqxcSMpgmflmEuJJluB8pq6RiC8c5fDBR2AOynNmiwB+x
 EEQ3CavDNtNztvgUZM6c3IIn45Ssl/CVwBnwAECTSkyBK+0a4qRdqS9/W+WkCNxO4OgH
 9xf+Fty8ho4tZ7hPUeha12/bEybk3O7JBMx4SHrIQbYdw8bHLIhOUeV4ZRwtVsXVMrm0
 aogg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lEAC0sSRDk8AHWvjEH7biZuBF1C2T1sYg1EOKUCzcd8=;
 b=Fdmyo/Tok/GCsvjW0Vs/nFSG3JidyQvRHG70l8BSDZNj8fkF1r1a55arMZLaI7gDw5
 Mrbi2ITzF9EHg+r0n8q3cvToG96m11UwsU9w/MOTuRMszlfpDW8XmDiYJbukNlIRmain
 gqcnuJzYpksOiGF7E5LhOzDSptny0KgGXq7VXu3R47yP51wiurWbXTyhg55joPrRggvw
 AeznMtZc1JoNXAS6T6/scwjIfcgKM5tKn1u10Vut6GlYsfnRvTWj5K+qNJFwE5oKayhy
 VZG7MIVO/466MBHE+qzvbcVD5glRz8C56RuXxVr08pO5dETJXFdn5kr5aK9W0l5YRR4S
 5Y4g==
X-Gm-Message-State: AOAM532An8oiiMezfGgdAxa82SROs4CHkZ2tnSERPxwu5VdV9Df7gYUt
 1ApkmuTqwm1IhZeOiBTPMRAwk6eMxzkrJg==
X-Google-Smtp-Source: ABdhPJwob5F+J4hvu2kqcbA4eoWCZuUSVY7YjdaQZoFfEXrmRvMHTNh5NloGp+HtCeXEVBBVibWA/g==
X-Received: by 2002:aa7:8c42:: with SMTP id e2mr2776241pfd.181.1598908717468; 
 Mon, 31 Aug 2020 14:18:37 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id 193sm8818709pfu.169.2020.08.31.14.18.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Aug 2020 14:18:36 -0700 (PDT)
Subject: Re: [PATCH v2 2/7] target/arm: add ARMCPUClass->do_interrupt_locked
To: Robert Foley <robert.foley@linaro.org>, qemu-devel@nongnu.org
References: <20200819182856.4893-1-robert.foley@linaro.org>
 <20200819182856.4893-3-robert.foley@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <439e8b14-adc1-b7ea-edaa-d11069863007@linaro.org>
Date: Mon, 31 Aug 2020 14:18:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200819182856.4893-3-robert.foley@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.13,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>, alex.bennee@linaro.org,
 pbonzini@redhat.com, peter.puhov@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/19/20 11:28 AM, Robert Foley wrote:
> Adding ->do_interrupt_locked to ARMCPUClass is preparation for
> pushing the BQL down into the per-arch implementation of ->do_interrupt.
> 
> This is needed since ARM's *_cpu_exec_interrupt calls to *_do_interrupt.
> With the push down of the BQL into *_cpu_exec_interrupt and
> *_do_interrupt, *_cpu_exec_interrupt will call to ->do_interrupt
> with lock held.  Since ->do_interrupt also has the lock, we need a way
> to allow cpu_exec_interrupt to call do_interrupt with lock held.
> This patch solves this issue of *_cpu_exec_interrupt needing
> to call do_interrupt with lock held.
> 
> This patch is part of a series of transitions to move the
> BQL down into the do_interrupt per arch functions.  This set of
> transitions is needed to maintain bisectability.
> 
> This approach was suggested by Paolo Bonzini.
> For reference, here are two key posts in the discussion, explaining
> the reasoning/benefits of this approach.
> https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg00784.html
> https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg01517.html
> https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg08731.html
> https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg00044.html
> 
> Signed-off-by: Robert Foley <robert.foley@linaro.org>
> ---
>  target/arm/cpu-qom.h | 3 +++
>  target/arm/cpu.c     | 5 +++--
>  target/arm/cpu_tcg.c | 5 +++--
>  3 files changed, 9 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

