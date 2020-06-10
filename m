Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01418C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 16:09:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF90A2063A
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 16:09:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yj3oLfni"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF90A2063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj3I2-0001uF-1y
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 12:09:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59130)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jj3HJ-0001Co-Ul
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 12:08:37 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:34671)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jj3HJ-000080-0y
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 12:08:37 -0400
Received: by mail-pf1-x442.google.com with SMTP id z63so366698pfb.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2020 09:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=wN5FgRcsZhuoIfX7RS++o/h5SaQVsOf2hBv+LDrkvaQ=;
 b=yj3oLfni1eMpPCQXRIZWOVGWPj3MhZAb9COpuDKOj3KYzAfJ0fON/sUr5+3eRW25ey
 rghtosoHFQ+O/rc2JXKSMr3Tw22o30p1AFwwAWlyX3PUxeo1G6km3lorYG9sPew2SJxM
 +f4XHTqB78/mMx142Syc0JTl9E+vDOscvorTCM8oRprEgPnJMWEeHvrJRc2jbrHdCXE8
 C+U6ffcnnKlUJlMeQAdULMLCcb7cSwVMI0gVbzkm8ei16JrwT7rYRj0UEX8MjZ7rdw59
 c4J7ANYBeUCBg5UAsaSRm6F0qXPehmz6XN6g0Tc6ThzT0VZS28DlmWO6ZlOou8O0j1tp
 fLjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wN5FgRcsZhuoIfX7RS++o/h5SaQVsOf2hBv+LDrkvaQ=;
 b=WrUq6xAbnamtQOmb7XSq2slP+92pW/zJuGQ/kUSlyK44hJLR5L8zJ26lcu3hw+KqSS
 9yolyAdpQoxlTL+cGySLKGVvF6CVSxFLlLE1oRvgidj3bvENpRgTgsw8kfGgZbncqq8B
 0Axq819ywA+QeiYD7nUy1jg1Xdk4lza7HEs1FbuWrZEc4H6oRZ/8RyNtTUDKjk+sdw8V
 MlxD3v2PnyCLVfCfpmfbEtkeOA01ekUJA7MEwW9pKw4/suJD4+zFzHuukswB/g9j6l5p
 c7Qn2KjC60AMTmEKsjdWUksq3jVqFldrDqYJkZSvS/Vwi5CoUGSlxwSdQs7d6H69E2/D
 jCGA==
X-Gm-Message-State: AOAM533ixselNuiXdFQ5mdX0LUxd/81sUyHTdtubTLiP50uT5G2ivctV
 NfjPlzzn1CtqzlvfJ8H/NfYp9A==
X-Google-Smtp-Source: ABdhPJy278yPjnsWbxhzqIjtGDqxsXgZVa3FYtQ5A+RnhGGDDHKz9SrTB3qBbmiK1RDsHDQKZXWkcA==
X-Received: by 2002:a63:cc4a:: with SMTP id q10mr3189126pgi.441.1591805315235; 
 Wed, 10 Jun 2020 09:08:35 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id a11sm351395pff.39.2020.06.10.09.08.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jun 2020 09:08:34 -0700 (PDT)
Subject: Re: [PATCH] migration: fix xbzrle encoding rate calculation
To: Wei Wang <wei.w.wang@intel.com>, qemu-devel@nongnu.org, dgilbert@redhat.com
References: <1591577607-13998-1-git-send-email-wei.w.wang@intel.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d859347e-ef56-46a2-ece5-e8bcd6753f0b@linaro.org>
Date: Wed, 10 Jun 2020 09:08:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1591577607-13998-1-git-send-email-wei.w.wang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: yi.y.sun@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/7/20 5:53 PM, Wei Wang wrote:
> It's reported an error of implicit conversion from "unsigned long" to
> "double" when compiling with Clang 10. Simply make the encoding rate 0
> when the encoded_size is 0.
> 
> Fixes: e460a4b1a4
> Reported-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> ---
>  migration/ram.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Queuing to a clang 10 fixes branch.


r~

