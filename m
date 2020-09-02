Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4719FC433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 15:39:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11E9320678
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 15:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="As71ZOes"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11E9320678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDUrb-0003Zt-5B
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 11:39:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51490)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDUq7-00036U-7r
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 11:38:23 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:38831)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDUq4-0003iX-VJ
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 11:38:22 -0400
Received: by mail-pf1-x443.google.com with SMTP id d22so3044748pfn.5
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 08:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=hF4zxUnnqKT5o1sGmYuf6DIwO08YQLTI/MNtj4RAejQ=;
 b=As71ZOesK3wDJ9leyIm41Zlh4j+hjZaMMKhFXTrSN5dQ2uMZj781QeXDb0H1wGLHRO
 4XtvBFod/ooI6oWJ4E/V9Zx8an9LBTxu3st+hEnXjmDXGccPm9IO7E/ogww2ejrc3meD
 /3xohPKfE6pknVVBsWwZlV9ZQJoSr4+ANgZL5V3Dw7C0w6fy71u5m+WSjQEA5VFQU95s
 xdlAiEasrmxb347WKGUEEnuKE72H7r65m5/kIRRbMifOJKrhm82ugRA+vfjzJtssP1xF
 46t5vY/siyCZm4qKVoPkOcO+zjcReqWkA/Ty2db9iMtTwQkGVEAI6rFioYHNPFG1HkkA
 5wgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hF4zxUnnqKT5o1sGmYuf6DIwO08YQLTI/MNtj4RAejQ=;
 b=C4UjFsBjeI2K8Uppb0IutNRZYvMhRoXXVgPZh+ZKV0trPtJwKSDhVsAIljGf/IWRWZ
 KJnk5YltEHcwWn7OuBxstpHqyZSkfenhdAXFtd7g+wSND8q+/NABPZpJ5br534d/i2vn
 Z86rjK0UNuSUBUzuSEADKlVB7OKBYtiD8ljJfWfOPFD3XBODfQXqzS26J5NHRv3IRl4f
 xD0ny5BZw50Lu1x/FplXX4sgY+fVMRLn/sTWwEG+Mc0SKi0VyVpXguqVLOf7kBN8lgF7
 kyO/+OxjSGDTOimefB7jFcAd4RDbv0HQIMbYzSTLZbRwJJGdfVKU679lMeUK95+4Smkh
 qgHA==
X-Gm-Message-State: AOAM533lrwxnZEtyyw17jcwd1Yc9SSe0feUUY4JTDbsyZmjtfq/ESuGI
 fQmJD2Tf50I1tM4IfjdSM/YPKg==
X-Google-Smtp-Source: ABdhPJx5wcKfsugnrO2FJNGFACf66KkZUT1j7QRPdYHx1LYeiQB7He96/mQD6xFh9ZkmL/lV/z0CEA==
X-Received: by 2002:a63:6782:: with SMTP id b124mr2467275pgc.308.1599061096631; 
 Wed, 02 Sep 2020 08:38:16 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id o1sm6092671pfg.83.2020.09.02.08.38.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2020 08:38:15 -0700 (PDT)
Subject: Re: [PATCH 2/2] hw/core: Move hw_error() out of cpus.c
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <f4bug@amsat.org>, qemu-devel@nongnu.org
References: <20200901112323.94969-1-f4bug@amsat.org>
 <20200901112323.94969-3-f4bug@amsat.org>
 <6e4fd230-1515-f82e-67f4-87494898c6cd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3d1b6cc7-5101-9885-8288-fa1a66037c1f@linaro.org>
Date: Wed, 2 Sep 2020 08:38:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <6e4fd230-1515-f82e-67f4-87494898c6cd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.324,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Claudio Fontana <cfontana@suse.de>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/1/20 11:37 PM, Thomas Huth wrote:
> - Move the function as "static inline" into the header file
>   instead - it's not so big, so an inline function should be
>   ok here.

stdarg and inline do not mix.

> - Add a big fat warning comment to the header that this
>   function should not be used for new code anymore.

But certainly this.


r~

