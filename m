Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D98EC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 00:29:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51B46206C3
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 00:29:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="caC7P0Zx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51B46206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfuoJ-0005fh-IX
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 20:29:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51670)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jfunV-0005AC-4i
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 20:28:53 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:53692)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jfunU-0000QD-6n
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 20:28:52 -0400
Received: by mail-pj1-x1043.google.com with SMTP id i12so536299pju.3
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 17:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=M0imsz9/sHNDOFivF5joyeOa325xFr0yZnXh4RIvGDE=;
 b=caC7P0ZxUmC8VLggQF675vGd66ECyEOAHB6faIoYmf4G4GvA+Dnktpl54dYvOZPwYF
 xWnEZY9Q7iODchrCF8RrVoI+9+/m9H0M+oqIt+CbPHPGupPxWrrwj1KzVxBt6TleDsm+
 F/2+yYZS18FSfE7CAG6m54K0ZMHoEIVo8ppkUlb/ayKbXPbuNigx+lhKBxY3QWYVKKYo
 iljTaeAJT8UIJqncKWAIX64DXwWvdNMxcpzU5HXDpRwMO3F7Q+/OsQ6vvh2YZASFNv/K
 Jur75bVhOztTEq+KK3L9XaW5TBS/WfMIaRucBWwDWLZQehX4FaOfEfUQQNtz7Yy3jbVA
 j4Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=M0imsz9/sHNDOFivF5joyeOa325xFr0yZnXh4RIvGDE=;
 b=b6fl0Jx6WDqGC8X+Rg8kOLjB9YlssUmFuFQlefw2qX1LHerMpwDy2bnoPzZIi1Vv3x
 /iKcbEevWAhKIS+SmmtQ3bTg55wbAz4P4ZLu8SBLgbQK17dJ9R103Qh8QA8D8r5Zj5Py
 nD2/PWVCRACdELuf2yCx8jWGRR7uu8qtaJzKw8ndLXFagfnElI5LMY5Kmofq2VR/w16u
 LSm5H/PggEvnTnnnZ99yRi1bPVy6p3TJhEl3dq+FLJ2caq++Odp7cl4KMEigqfeuyfzI
 COyo7UXbx6AnJ0FAhjYeDzYgO0khRXeJ7YFTPPCzNWwymumaLn7SjSQ5t13twrdAwzHz
 DF0Q==
X-Gm-Message-State: AOAM531Gbw9req3j1U9qBhgFZlH8pMuJCucF6Tpm/O18DJ/2j47YIyzX
 Si5J0kkbAi/Ga/isDhDvtexMAg==
X-Google-Smtp-Source: ABdhPJz2q6TI/hDHkJdfy22l2v+6jmIL3dfOZ24MkNNqRVe+CTfbVHOpZ7Qr+rKsJJxk63aunX2h5g==
X-Received: by 2002:a17:90a:336c:: with SMTP id
 m99mr2179067pjb.168.1591057730553; 
 Mon, 01 Jun 2020 17:28:50 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id b63sm487440pfg.86.2020.06.01.17.28.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jun 2020 17:28:49 -0700 (PDT)
Subject: Re: [PATCH v1 2/3] linux-user: deal with address wrap for
 ARM_COMMPAGE on 32 bit
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200527100546.29297-1-alex.bennee@linaro.org>
 <20200527100546.29297-3-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <355ff6ba-ed8a-bc1e-4b74-c87a532e47bd@linaro.org>
Date: Mon, 1 Jun 2020 17:28:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200527100546.29297-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bug 1880225 <1880225@bugs.launchpad.net>, qemu-arm@nongnu.org,
 Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/27/20 3:05 AM, Alex Bennée wrote:
> @@ -2145,7 +2145,7 @@ static uintptr_t pgd_find_hole_fallback(uintptr_t guest_size, uintptr_t brk, lon
>  
>  /* Return value for guest_base, or -1 if no hole found. */
>  static uintptr_t pgb_find_hole(uintptr_t guest_loaddr, uintptr_t guest_size,
> -                               long align)
> +                               long align, uintptr_t offset)
>  {
>      GSList *maps, *iter;
>      uintptr_t this_start, this_end, next_start, brk;
> @@ -2171,7 +2171,7 @@ static uintptr_t pgb_find_hole(uintptr_t guest_loaddr, uintptr_t guest_size,
>  
>          this_end = ((MapInfo *)iter->data)->start;
>          next_start = ((MapInfo *)iter->data)->end;
> -        align_start = ROUND_UP(this_start, align);
> +        align_start = ROUND_UP(this_start + offset, align);
>  
>          /* Skip holes that are too small. */

I suppose offset is supposed to mean we start from -offset?  You didn't update
pgb_find_hole_fallback.

> -            loaddr = ARM_COMMPAGE & -align;
> +            offset = (128 * KiB);

Why 128K?  Surely this should be an expression against ARM_COMMPAGE.


r~

