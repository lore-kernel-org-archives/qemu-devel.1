Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B5F0C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 15:25:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 256A52064B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 15:25:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JX+WGfX5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 256A52064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnknq-0007qm-7H
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 11:25:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45774)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jnkli-00059U-6D
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 11:23:26 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:34648)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jnklg-0007xd-2P
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 11:23:25 -0400
Received: by mail-pg1-x543.google.com with SMTP id t6so2188724pgq.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 08:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=o9V1MuqsW9OY9KmhDxGL2xqVK55QccJLbpUNhAXoZrk=;
 b=JX+WGfX5MsKqitANt1hf5+s2uh86UFCyTxT+yT5uBHUyNVPkNDMWwmK0m3cjszT+mm
 xbr4ekSv/Px0ntssPwOAbQG6KCiGi72HRDnfKF0iyoy7qpmZTcb4tK7aUZG9SOwGi6jq
 882YkXO3GmP8mZbHrAG8uB+4clitqFoldD6Lkaiu5jX81KrsY+SdyuPDW38K8MJvewp5
 mjIq7TcLXStMrcuBAAFgmf/AH+3xQSW11SfFBazK1wwX7Btzr3Ttsava0ewBhTk9hfx/
 cv3nMlgsPDz5fCcXVFKlL97Wt/W6w/O19o2ZIDr5lahyJMCkaX9LDAjiWzRyubKuETYs
 pTHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=o9V1MuqsW9OY9KmhDxGL2xqVK55QccJLbpUNhAXoZrk=;
 b=Z1GdM9gQv0UZDQjQd75+KmtZfTQrni07fD+fj/5uIWPu6+9wohpiKiWvepNcvQjJWP
 3I60uVaX5rlVVxpveMtd/9DfzRxXVHMaYCkTJwskReqxdgF6oBO0Pg9ZCWI6sPcRA3eL
 8EH8GA/wCZTGK7jLVk6vp0jEyEgmyjUto3M4S1in3vtU85mHQ+DvfZVGoChzO800UXRm
 +w6W2/MUovp0n/XVcVR0Q2sU49+v3nEN3vkDpOfAxJfQpRB9B64l6Mv+I4Hw6gKo+QU5
 ecgefxUZFn/ztBe/gxvBYby/EnCCbaOI1aj97knhALJ6Z0iIe3PAD6V1yLT7bhtfZ8Ku
 SJuA==
X-Gm-Message-State: AOAM532cEZvO4mG7nn59rJgky1LJTaLD4BT+xt9G9N4sgv8ckdtocseY
 LDUSCGofY0ZFSC6E8xuRh3b9mjHSOdo=
X-Google-Smtp-Source: ABdhPJxxiuvvvQZq3Xi3FvfWmLM9kdjAh/NfnEqc66DmwqQQ9YaPD7oCK3b5/T/dpxg9rzdM9n7ZVw==
X-Received: by 2002:a63:5013:: with SMTP id e19mr17279391pgb.68.1592925802139; 
 Tue, 23 Jun 2020 08:23:22 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id l195sm17996188pfd.18.2020.06.23.08.23.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2020 08:23:21 -0700 (PDT)
Subject: Re: [PATCH] risu: don't do a full register compare for OP_SIGILL
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200522023440.26261-1-richard.henderson@linaro.org>
 <20200623144446.4243-1-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1cf5e2e6-6fe3-7fdb-30d1-0ce3cce08ee7@linaro.org>
Date: Tue, 23 Jun 2020 08:23:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200623144446.4243-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x543.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/23/20 7:44 AM, Alex Bennée wrote:
> +        } else if (header.pc != get_pc(&ri[APPRENTICE])) {
> +            res = RES_MISMATCH_REG;

You need a new MISMATCH code, because this one implies that you have a reginfo
struct to compare.

But thanks, I'll incorporate this.


r~

