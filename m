Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 637E4C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 04:28:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E57D20772
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 04:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aDnQtyCw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E57D20772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgL1I-0004oE-D2
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 00:28:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48486)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgL0P-0004Fd-VS
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 00:27:57 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:35574)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgL0O-0007e5-VT
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 00:27:57 -0400
Received: by mail-pf1-x443.google.com with SMTP id h185so745286pfg.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 21:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=quRMxeImeQm2SMl7+Ls1gDvxLR0VJAl5Zjikf87gu4E=;
 b=aDnQtyCw+hwlEXHzvL4/Nmsz0UyEadqm9x4fHGOM7egXBU0P/NuhuMJOyvTD2gggJP
 8p3ZbeazptAv7ZMs+GoIuB7uc5ygufdvC0PiqXMNJZc1iKk1RXmauAhLD0kiEjidAFEH
 kcszv8H1pjKzhw2XkFoeMYrr6HWDTMzn9OYLtHHw6sM1XktNQ4FGlY9NZt41zdJu4qe8
 3c0FDnY+hmwMikzaTgiAr07XMjvtTJMeLht5ucwcpQBhB+5e2vCY0YKhWC1cC2+T3e4C
 hlOFpsRfW12+37JisaWuMZZDwkkCHlHhkx++r64vpCHnex5lFyK2I9X6KYHHiv4QEsHt
 KmlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=quRMxeImeQm2SMl7+Ls1gDvxLR0VJAl5Zjikf87gu4E=;
 b=Tfh9V7BXt4cdn7iW88WhNZAgMjnZbiXstg8UI7P5j8yVXIeZjaM/aTk12kYOFJ/Fp9
 W+J67NX4DYr02bNVW1sxV+ALMTM9ZQNCpNo3na0nt7tehuE2o9VZ6aEcDMQRYQBkM2a8
 zVTjTz4ZUhEy1t/ax8YWeViD2c29RO8XzWd3NcJwOn1/NP9xLd83TYvW4oBvS50lMVhP
 3H+LfbTjIB5UyevA0FOiY4S+KyAuGLywKcNGNWGdl4gUFWTRKWKw8fajL1IGf5trPwe8
 S4L3xp9i/FCAB7p6aKDQWW1S01APUmg+Tq4Asxn+YCOiEd5VZ3ZIHCEasUVb/tZxB1qA
 doWQ==
X-Gm-Message-State: AOAM531znY0Ik6RGlczz8I0XmiQkW42NiGoTo1pEQjjNcOlWr8TagPbU
 svV7Jyjoc0FsLj9048kr8BGQqg==
X-Google-Smtp-Source: ABdhPJwPOavZ0nv14HgofDBk5No3GTGJEIab629qI73swrUebQ3Rz06fy0akY5O4JSzzoHEUifqr7A==
X-Received: by 2002:a05:6a00:2b0:: with SMTP id
 q16mr12545305pfs.104.1591158474292; 
 Tue, 02 Jun 2020 21:27:54 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id 2sm577877pfd.163.2020.06.02.21.27.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jun 2020 21:27:53 -0700 (PDT)
Subject: Re: [PATCH v8 30/62] target/riscv: Update fp_status when float
 rounding mode changes
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <20200521094413.10425-1-zhiwei_liu@c-sky.com>
 <20200521094413.10425-31-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7cb2aa5d-833a-8544-dadc-5aabba06ecd2@linaro.org>
Date: Tue, 2 Jun 2020 21:27:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200521094413.10425-31-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x443.google.com
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
Cc: palmer@dabbelt.com, wenmeng_zhang@c-sky.com, alistair.francis@wdc.com,
 wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/21/20 2:43 AM, LIU Zhiwei wrote:
> @@ -174,6 +175,9 @@ static int write_frm(CPURISCVState *env, int csrno, target_ulong val)
>      env->mstatus |= MSTATUS_FS;
>  #endif
>      env->frm = val & (FSR_RD >> FSR_RD_SHIFT);
> +    if (!riscv_cpu_set_rounding_mode(env, env->frm)) {
> +        return -1;
> +    }

This will raise an exception immediately in helper_csrrw().

According to Section 8.2, the no exception should occur until the next fp
operation that uses the invalid frm.

You're doing this just fine in helper_set_rounding_mode(), which is sufficient
for scalar fp ops.  Without looking forward to later patches, I suppose we'll
need to do something else for vector fp ops.


r~

