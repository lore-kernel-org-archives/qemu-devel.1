Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BCBCC43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 00:34:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3700821D40
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 00:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V7QvBYZm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3700821D40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGAXW-00034v-D8
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 20:34:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42360)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kGAWx-0002fI-VB
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 20:33:39 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:34143)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kGAWt-0005SB-QA
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 20:33:39 -0400
Received: by mail-pl1-x642.google.com with SMTP id r24so52705pls.1
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2020 17:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=+CAnJ6K51a/Q1rf8+zN1lXgwBk9dz+8lbDuUR7mG78A=;
 b=V7QvBYZmjvIIciOiQahLDEhlA7JmdBMFkTGy7ZcJvHaxxSi0KpQ9P+trKUr4dD/1LG
 vxHXMt5Dp9uGDeOir+ebQe/qCtzp5FJTE9V3PfAiCfqYqwPOUK9ZWApBTsZpBhH6O3Tk
 g5N411ocAl+fZi1I1Wwk2ruc63dkWhLGwSsH8KDxulR8wsRnHIwcZh9IgnxNsYNZLjIk
 ZUG4xJ9Y4WNRiriQzdRqBWZ9wTfPnBbpRLj9OAu2oA+OYzQ5pfsGHH3qXY1ynwpPu8Hu
 ObQOfa/oXsi1zp7YAA3ijGpqIS/O0Vi5mc1/n52k4cb0l469pAy1VF5tQAef6qHA4c+2
 QRag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+CAnJ6K51a/Q1rf8+zN1lXgwBk9dz+8lbDuUR7mG78A=;
 b=ad+N9YkrWSn0PRpHTc8s1xMJ+Z3EgUlsOBNbKKAq8a9jXn+oCqH65ToIiLOOhef0Ef
 EsZcb5NeMKvGGZkaQI8nJPhduUJA/JN4aL1Ppk8vukIJPpd9f2L04h3z6WtnpgF23ny8
 wBsaCSg6MXEFwj1Z11+7GukWlJ8qk0I3enm6/gdolKKIzn8O3Tn4pwhzHJO7iq2siuQo
 8tWI0y/3RZ2cyA4khfU/C/zJ7TaPZTwmGqlLteT5OlulJkoHvG6UyfPxYCLW5LC15esA
 abEnMrawD5GVCTrw/VzrFXvrDf+du3+5xJ53chcyxN4e+C2GfQBgIdcbiaS8ZbPdI6tb
 IPNw==
X-Gm-Message-State: AOAM533uNGajh3WVsUOrEASwpyal09C8YyHEGNcHINx8pzsKBLH3kdFm
 ZLXEVxpHpS7BXppZdpPkilaOnQ==
X-Google-Smtp-Source: ABdhPJzSlIZZ0t/eR2XoepX7ZXStzafMl25vu8/vN0U+R8icUnYxOx9GHDnC+lOspzzpvRs1LkJaHg==
X-Received: by 2002:a17:90a:b78b:: with SMTP id
 m11mr1684889pjr.13.1599698013824; 
 Wed, 09 Sep 2020 17:33:33 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id x20sm3769882pfr.190.2020.09.09.17.33.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Sep 2020 17:33:32 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] MTE support for KVM guest
To: Steven Price <steven.price@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>
References: <20200904160018.29481-1-steven.price@arm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8e661984-70bc-790c-8636-39dcd8b00131@linaro.org>
Date: Wed, 9 Sep 2020 17:33:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200904160018.29481-1-steven.price@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.576,
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Peter Maydell <Peter.Maydell@arm.com>, Haibo Xu <Haibo.Xu@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, qemu-devel@nongnu.org,
 Juan Quintela <quintela@redhat.com>, linux-kernel@vger.kernel.org,
 Dave Martin <Dave.Martin@arm.com>, James Morse <james.morse@arm.com>,
 Julien Thierry <julien.thierry.kdev@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/4/20 9:00 AM, Steven Price wrote:
>  3. Doesn't provide any new methods for the VMM to access the tags on
>     memory.
...
> (3) may be problematic and I'd welcome input from those familiar with
> VMMs. User space cannot access tags unless the memory is mapped with the
> PROT_MTE flag. However enabling PROT_MTE will also enable tag checking
> for the user space process (assuming the VMM enables tag checking for
> the process)...

The latest version of the kernel patches for user mte support has separate
controls for how tag check fail is reported.  Including

> +- ``PR_MTE_TCF_NONE``  - *Ignore* tag check faults

That may be less than optimal once userland starts uses tags itself, e.g.
running qemu itself with an mte-aware malloc.

Independent of that, there's also the TCO bit, which can be toggled by any
piece of code that wants to disable checking locally.

However, none of that is required for accessing tags.  User space can always
load/store tags via LDG/STG.  That's going to be slow, though.

It's a shame that LDGM/STGM are privileged instructions.  I don't understand
why that was done, since there's absolutely nothing that those insns can do
that you can't do with (up to) 16x LDG/STG.

I think it might be worth adding some sort of kernel entry point that can bulk
copy tags, e.g. page aligned quantities.  But that's just a speed of migration
thing and could come later.


r~

