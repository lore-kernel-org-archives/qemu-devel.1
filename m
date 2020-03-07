Return-Path: <SRS0=oVW3=4Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13CC0C10F00
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2020 17:45:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D43E62051A
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2020 17:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HTat6H2j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D43E62051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAdVV-00071Q-2J
	for qemu-devel@archiver.kernel.org; Sat, 07 Mar 2020 12:45:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55170)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jAdUn-0006Ma-Qs
 for qemu-devel@nongnu.org; Sat, 07 Mar 2020 12:44:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jAdUm-0000JT-Ko
 for qemu-devel@nongnu.org; Sat, 07 Mar 2020 12:44:17 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:39673)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jAdUm-0000I1-Di
 for qemu-devel@nongnu.org; Sat, 07 Mar 2020 12:44:16 -0500
Received: by mail-pf1-x441.google.com with SMTP id w65so2204006pfb.6
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2020 09:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=95OZDX63l38IDOcVyZsmX82oiPYU78nsEnv9BrPfj+w=;
 b=HTat6H2joNOKsKRXW3If4etMx+SoBwmSpq1YJFq0xo4RcAS8SsllYs9qiR84rWWfjp
 fbMbJ1lntK7CBIR3+v8fp4U81VmC8hTVh+V0g0QSClhAwbXguUthNfxwQFfkp1UUvy8O
 7RBVSfATGau4BCyOdNbOhqufRP47lGc8kpLqjl0lBRVkHpMkFCZm3c1mEMzllVEgGKiQ
 LHhzt2vMqQSfKpKEVY5FZq4DlDU6a2SxMQsgpNRg6Jby27mhyru4+HShaY8xBv7T+jNj
 l3KntayFSIRSCMn8HszTUdkLCC907aCi/mI2rmOWjn2fFyH9JJouctt8H9ICbGR0nR8M
 megQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=95OZDX63l38IDOcVyZsmX82oiPYU78nsEnv9BrPfj+w=;
 b=CHW0LCRCIJoadlmCQM/BQeYC2QMhpSs0XC3cEwaWX0yUbJybNH1mfJP2yuIR/5q9C2
 OHTzj994ey4dDuR0h13ZdXC/Wtf3pkHfRCOT3X/Ro6Vp9QbS62pxbiljC1TkdTa4lefW
 QUBLOClMfmDW6jmeVV+Kk0Up48UiEoFIgHm3M5RD3+gQ2DhsvMwDem6JVx5Z2fSF1fBB
 77Ff5tMTMZvn62Iaxyd+wmjIkfj7hYr56gfC1K3dwDG3XxRs5a+HDVRdkcz/hmdSLSf1
 sUEbU0fzWgIEtnD8HxGrCKNjmUKntf/bYxaHQM+9KyL52fa/AftFOSKuEf/ph8XNA3+2
 M0Jg==
X-Gm-Message-State: ANhLgQ04rtS5lQS32TmS41sV3o/ru9TRiBo7YI2HaYm6NsRATUd7aFZv
 pHclo3Lt8ZmrSfXZuqLxjFj2eg==
X-Google-Smtp-Source: ADFU+vsBV9LrfSZQ3f3gwO6m+vqnYHrm/8s4GUrwu9bbzDrxcUJzH4U6cI54goghGGWs732183djbg==
X-Received: by 2002:a63:309:: with SMTP id 9mr8722586pgd.193.1583603054737;
 Sat, 07 Mar 2020 09:44:14 -0800 (PST)
Received: from ?IPv6:2601:1c0:6100:5580:6886:21be:91dd:78be?
 ([2601:1c0:6100:5580:6886:21be:91dd:78be])
 by smtp.gmail.com with ESMTPSA id u13sm13229747pjn.29.2020.03.07.09.44.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 07 Mar 2020 09:44:14 -0800 (PST)
Subject: Re: [PATCH v4 1/5] target/riscv: add vector unit stride load and
 store instructions
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200225103508.7651-1-zhiwei_liu@c-sky.com>
 <20200225103508.7651-2-zhiwei_liu@c-sky.com>
 <4cfb56d6-34a5-0e35-87a0-2aefaafa4221@linaro.org>
 <a225d9e7-f7ee-71c4-db90-cc27f25470ed@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4253d616-3d28-c848-d559-86407e4fc313@linaro.org>
Date: Sat, 7 Mar 2020 09:44:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <a225d9e7-f7ee-71c4-db90-cc27f25470ed@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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
Cc: wenmeng_zhang@c-sky.com, qemu-riscv@nongnu.org, linux-csky@vger.kernel.org,
 wxy194768@alibaba-inc.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/6/20 8:36 PM, LIU Zhiwei wrote:
> I define fields shared between vector helpers and decode code.
> FIELD(VDATA, MLEN, 0, 8)
> FIELD(VDATA, VM, 8, 1)
> FIELD(VDATA, LMUL, 9, 2)
> FIELD(VDATA, NF， 11， 4）
> 
> But I can't find a  good place to place the fields. There is not a
> "translate.h" in target/riscv.
>  Is cpu.h OK？

Perhaps "internals.h" would be better.  About 4 of the targets have one of
these.  It keeps things that are not relevant to the actual architecture, only
to the implementation, separate.

r~

