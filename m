Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE7EC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 19:32:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FA0F22208
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 19:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VP9tR9Vs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FA0F22208
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGomE-00014F-V7
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 15:32:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44214)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kGolP-0008W7-9B
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 15:31:15 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:39503)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kGolN-0000Ov-Qu
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 15:31:14 -0400
Received: by mail-pl1-x644.google.com with SMTP id x18so1330349pll.6
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2020 12:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=usATbnsxBfyROwMGhdRNBcqSCczeQ7SDXK+1UdsLuw0=;
 b=VP9tR9Vsj4q8Gt1vEUsUOhXv/O0kOP7r5ciWbVHII1aJKr8nUnJ4hTqaB+nBxThsmb
 HHGEqjvZ9efz8DVJMMsmKsGReWqM8sYZ/9ovb6kVMia6ZWb999nZF4O9dMrnSlBJ34Zd
 9qHQa7klgmjA3Gyjlf2Kqg9zJC+LGIQoMqwPyTpLA6bdhS2gGJno95whSwNYbFIb5j8a
 KHA4KW3rGCEliw0EiEh4SgOViz2O7q6TkefO5zuaQMq1yAStxeuV9ME8CKfO02JejfLt
 /EPedbfcLYPZl642AECWqmOJx5phGLQaXgW9mrU9o/UTXLrI1a+QleqJc6K8DyJD5NLB
 EzRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=usATbnsxBfyROwMGhdRNBcqSCczeQ7SDXK+1UdsLuw0=;
 b=SmK0vJvnr3I3vm/Vs7jh0L6qFUrFr1zoBFgcOdCUSlN4WRB1F38T54stYxKu3uAeFz
 w0Ij6Ov5ckQ8SxvgWVJyozD9skUTbLCrQ7ugS78xl2Hj7uoi+PotOYL8F8Pr31HSRQff
 v6RbW9zCheFP47jkml1qeCW0q6kEjwemLpPa5fIGBPI69kI+0c6+KPaqDZc1mgZlbIrL
 G4DhIltjto12nO0d3POdSfsW85AqqM21Y41jqdxfaGqlKP0Fu0mC8wBf4xU68w2uAj6T
 SB1/uh4YKY/pKz0fuHnoymRVdcM8diVskiHZ4fiiFvFNRFf7eh5A3m1HhUcArHd4GlnD
 TxGg==
X-Gm-Message-State: AOAM5328NZD2it/UFOVezC/Qthlqx/025wJIcuzxduEupQLiAuZHNehG
 cTmQ5s4mHNdvEpaZR+odIRRkumHuZkOBlw==
X-Google-Smtp-Source: ABdhPJyM2iBeUT2Yt6/7HB1qFYRHhXwU6/sb90uUXlbpIlTNceUAM2jsWg9CObkayJuOyG5zaJfyEw==
X-Received: by 2002:a17:90a:1f43:: with SMTP id
 y3mr3524245pjy.28.1599852672150; 
 Fri, 11 Sep 2020 12:31:12 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id nl10sm2417049pjb.11.2020.09.11.12.31.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Sep 2020 12:31:11 -0700 (PDT)
Subject: Re: [PATCH 4/5] target/arm: Add ID register values for Cortex-M0
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200910173855.4068-1-peter.maydell@linaro.org>
 <20200910173855.4068-5-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b22fcb17-f38b-e699-0c33-a3055d2427b7@linaro.org>
Date: Fri, 11 Sep 2020 12:31:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200910173855.4068-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.469,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/10/20 10:38 AM, Peter Maydell wrote:
> Give the Cortex-M0 ID register values corresponding to its
> implemented behaviour.  These will not be guest-visible but will be
> used to govern the behaviour of QEMU's emulation.  We use the same
> values that the Cortex-M3 does.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/cpu_tcg.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

