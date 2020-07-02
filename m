Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B13C433E1
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 19:18:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D46A21D80
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 19:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cD1+1pML"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D46A21D80
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr4jU-0007RB-St
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 15:18:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46092)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jr4is-00070h-3y
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 15:18:14 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:37189)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jr4iq-00051i-GQ
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 15:18:13 -0400
Received: by mail-wr1-x441.google.com with SMTP id a6so29778087wrm.4
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2020 12:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=wS7n8gpLeKUY8RcU7hgTEH7bUJVcrITgeiFBuFRYDMQ=;
 b=cD1+1pMLEeIUWvuhy+Ei7gK+W+P4kEn6yuPhVv48BX+liRw5/zKt5jbhEIW/h23FDj
 uWRFJAk+IgmwAZn1sk4b/SEqif9aqU/Uuqa97Y2MgLATO39b/w4trbajZF4CQLmAUPLX
 WyueioUYgw8tyNO8/sv3NON2eN+Sw0P3LXf9wSm6g8Xi/CYzVzDchVVgnGNlxu2o37S/
 wx9PilUp31H03WjWjAevy3ZDDti5uspkuNi0zNC2ij+1GfNsmbI5/XIIBd0yfv7wSzT0
 HAvXOeyW5WmGXT8CZhwR12XhL6F+wbyXKnzlFuvCCXAiK8m+mbJk/uqmnvt+e+9wYjES
 eK2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wS7n8gpLeKUY8RcU7hgTEH7bUJVcrITgeiFBuFRYDMQ=;
 b=Uciikvqq/d1n4jEXKBz6LhSXJt0OO8qe+Ql43skkaVTugpIObSCHc5xBIlSeM4NySO
 PmwXqTpZqf2N4SzRVSA5Xv35JtNdkpFKYAq05Mi/RGhDnhrf4a/lFvfa8VkeEl/HWI73
 C6JnLdn2sMAQsJtvMsbGSKbVmyfFa0/MRsTFD0R1zN1QHhEzzpe3j0qUTmQUHQ77sO1U
 g4lqRAJHwdGJSf27w2PP6xxp87mVIoEGh1ATSgkra3ya6SQOlegXxsPaCJ7si4KDTOe0
 Np85uXoXjkKTuXsj/Msgkq8+54NpwmPCUVd8QYiOlBSspAOan2RKMCFctE6mZ0EXY1E5
 UxxQ==
X-Gm-Message-State: AOAM533goO6GNKj0JMLagOm9rOiC8mMykEl0JcJ06Prz/x4MZUk4oUxx
 bk9FYmxi0Q1w6ZPv/oECY9c=
X-Google-Smtp-Source: ABdhPJxZ7D+fj9yHc/ku3uTCXKPqdoUU7+6mFIsq9Kix6iwzGu/IkhqPtDmGrd21+tx8kMSb+yT7Sg==
X-Received: by 2002:a05:6000:86:: with SMTP id m6mr477113wrx.173.1593717491051; 
 Thu, 02 Jul 2020 12:18:11 -0700 (PDT)
Received: from [192.168.1.39] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id r67sm12008939wmr.9.2020.07.02.12.18.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2020 12:18:10 -0700 (PDT)
Subject: Re: [PATCH] target/arm: Fix temp double-free in sve ldr/str
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200702175605.1987125-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <66b1c049-95ed-2c76-0ebe-75b0defbd60a@amsat.org>
Date: Thu, 2 Jul 2020 21:18:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200702175605.1987125-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/2/20 7:56 PM, Richard Henderson wrote:
> The temp that gets assigned to clean_addr has been allocated with
> new_tmp_a64, which means that it will be freed at the end of the
> instruction.  Freeing it earlier leads to assertion failure.
> 
> The loop creates a complication, in which we allocate a new local
> temp, which does need freeing, and the final code path is shared
> between the loop and non-loop.
> 
> Fix this complication by adding new_tmp_a64_local so that the new
> local temp is freed at the end, and can be treated exactly like
> the non-loop path.
> 
> Fixes: bba87d0a0f4
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate-a64.h | 1 +
>  target/arm/translate-a64.c | 6 ++++++
>  target/arm/translate-sve.c | 8 ++------
>  3 files changed, 9 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

