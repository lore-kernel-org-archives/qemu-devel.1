Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EFB1C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 19:46:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1868F21582
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 19:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kTfqO40h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1868F21582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihfH6-0001HC-58
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 14:46:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37049)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ihfG6-0000f1-Vz
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 14:45:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ihfG5-0003jo-MM
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 14:45:22 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:35840)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ihfG5-0003fU-CV
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 14:45:21 -0500
Received: by mail-pf1-x442.google.com with SMTP id x184so1792299pfb.3
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 11:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=5yWhXSDHqZ6Ptt+fDE9oY+B4VtUt/ihK9EgFsH/5ncQ=;
 b=kTfqO40hjB86KvVFg8zQOwVp8sikOfTL8G2qFFhxggD2IQlKeyOAh0kV9VrI4OavMl
 r3kuVsAoY9IjxYRX6m6cPgj24bbRGXfUgL1pdY1jtKWSdn3vSAw5r9ZEjejQ9xrvtF+3
 Z/leHGxeWi0xIub3aexwz7404CYR/npQ4tKDoj9nNHD5lmC5/K1k2sEkdqA5GRLGz4L2
 Zg1qE3vFCrjm7Bq9zBAOM/Q0KuwS4CRPrzbWJhLxOy1zp1YcdiyjIuQpXVi8SlBXOPcM
 hbRLeXP9f14lhnyBiH7XXWLdsqOkz519mNOWejdjKFmheYzAiyq0B8VuGZbJjDDSwfX4
 gVpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5yWhXSDHqZ6Ptt+fDE9oY+B4VtUt/ihK9EgFsH/5ncQ=;
 b=mo5ihvTQBaSjoVfb+OG9hqZ9ugj+QaQqlfTn7ZLuXorREwbFMjpio/LdKi2QFob8wj
 lCEnzFGLxofb82XrjCzIf+pP91ay7x+/gyvWz1/nVpgIXorw/10cNuNGObP04NC2Tpf7
 G+05fA69p8P9w+zpFHAKJKRcCeG5sRagsOi2albJ4YvgUfqeIrs9ojbPTNUkBt3KTmEy
 Jt4Qo93wV8v5DlouI0pycTa+nfj5wCU4uG3GvT7KIkj5R8uOuFhiOP31GW0WdgqG3uIx
 darSAtE4kFJOH2Q0YvPmkgwu9SvuY3UMeX8bQLofgQGtuZpIjByPRquAWY9rRun8RnMl
 Fs/A==
X-Gm-Message-State: APjAAAWLBRKFYZlLS+kghKIv0j8pdJVabZgcAAFbT7U5R3hWCqebuZml
 FrY/6E44EN9j+jmvbdqRK5d/ZA==
X-Google-Smtp-Source: APXvYqxxlXTfq6IhZoBP10LCI+WbXwmAPsUr/eltnFJomiXaiCRM4tan07WAGjJVkhIFuqxGKE3WkA==
X-Received: by 2002:a63:e14b:: with SMTP id h11mr4693189pgk.297.1576698319987; 
 Wed, 18 Dec 2019 11:45:19 -0800 (PST)
Received: from ?IPv6:2605:e000:c74f:dc00:6838:d2b2:17e2:8445?
 ([2605:e000:c74f:dc00:6838:d2b2:17e2:8445])
 by smtp.gmail.com with ESMTPSA id h26sm4665845pfr.9.2019.12.18.11.45.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2019 11:45:19 -0800 (PST)
Subject: Re: [PATCH v1 2/4] target/arm: only update pc after semihosting
 completes
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191218180029.6744-1-alex.bennee@linaro.org>
 <20191218180029.6744-3-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <975db858-8470-d2dd-de53-278423984e46@linaro.org>
Date: Wed, 18 Dec 2019 09:45:15 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191218180029.6744-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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
Cc: Peter Maydell <peter.maydell@linaro.org>, keithp@keithp.com,
 Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/18/19 8:00 AM, Alex Bennée wrote:
> Before we introduce blocking semihosting calls we need to ensure we
> can restart the system on semi hosting exception. To be able to do
> this the EXCP_SEMIHOST operation should be idempotent until it finally
> completes. Practically this means ensureing we only update the pc

ensuring.

> after the semihosting call has completed.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  linux-user/aarch64/cpu_loop.c | 1 +
>  linux-user/arm/cpu_loop.c     | 1 +
>  target/arm/helper.c           | 2 ++
>  target/arm/m_helper.c         | 1 +
>  target/arm/translate-a64.c    | 2 +-
>  target/arm/translate.c        | 6 +++---
>  6 files changed, 9 insertions(+), 4 deletions(-)
...
> +++ b/target/arm/m_helper.c
> @@ -2185,6 +2185,7 @@ void arm_v7m_cpu_do_interrupt(CPUState *cs)
>                        "...handling as semihosting call 0x%x\n",
>                        env->regs[0]);
>          env->regs[0] = do_arm_semihosting(env);
> +        env->regs[15] += env->thumb ? 2 : 4;

... although thumb should never be false here, it does match the other instances.

I do wonder if it's worth inventing do_arm{32,64}_semihosting wrappers that
consolidate this register manipulation.

But either way,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

