Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C12C33C9E
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 02:34:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4C902067D
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 02:34:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vtb6BQbG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4C902067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipNew-00061B-U3
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 21:34:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59993)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ipNdw-0004og-OM
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 21:33:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ipNdr-0008Dv-Ud
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 21:33:51 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:36602)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ipNdr-00089v-2B
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 21:33:47 -0500
Received: by mail-pf1-x443.google.com with SMTP id x184so2596008pfb.3
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 18:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=dzbZeJ1AmuhqCmb+aBieEB+CAtkvNLr1xBssq6CpAf0=;
 b=Vtb6BQbGYLY2s+0W7WooxVUejGgs6eHG2iQBswd40q2aawdXKcYNUd+rLiI4qF6D+V
 cQwLh2Ud0yimPHVsmEpVTLvl3g6Es2YwmBSUTYDhNE8XBLgaKbY4OTNufpNWrWqqtK1J
 3rU24YUqN8567GCZaT/W+sWnmwHWO48/2bl+BNQzhB32PjS1Tn8pcyYJpb9Q4XDoXLB4
 TlpFS1Cbbd5tNA/2edFIoY1UxnwDT9OM3hzlYaVqgyDMDn5HBYB9E27arV8NkBNzngbg
 Wx5t3MuXDnR2Lyq92k7BBJ8MqpNz3BYHHWN5jjMCvet+/mfpkj4sC5klo1t0lZt6bFXw
 ebEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dzbZeJ1AmuhqCmb+aBieEB+CAtkvNLr1xBssq6CpAf0=;
 b=k3kPq9hYAmjiDOxzP3r+OQU3uQcoMa7DeE6MP2B7JNZau9tRfaAGc1HUrpR/szVZlN
 r3FDabSG2cPu0lD1/buDl5zw1qN0lk4aHtGRcxCv7HEQi1PtxZm90X6gOakxjvlJzn3I
 uhkx4CafkkMnXLDH4yqIfPn6ulJnk9VLNr1mChR3JD6GLTMbkovgYyj/NlJLrdiiuD4V
 THtUMS38gydFPBNEQedoywDBsaPO9dp+DPxvAyynFjXzV6GMpkTmCRIawT2tZREDXerX
 91YGA9m6KByLYwKjQS7r7JewJi0bCYpU0MUZPYQhUj3rBsTE4kBfqS51ATjMFK7E1Qur
 1q6w==
X-Gm-Message-State: APjAAAVucBjAJIsUg2jvI4lSO8OS0kf33kilnD18Ac/D+fT0S2aggG+P
 y4Jlgu6Nr21+FlCwh/VENPu1Qw==
X-Google-Smtp-Source: APXvYqy13ScqvGzA0BpAqddmBg1gNyMf6JOmLtEHTs34w37xSfEg25z2i9/aaJrlOzcTah1Uz9OVdg==
X-Received: by 2002:a63:5818:: with SMTP id m24mr8733836pgb.358.1578537225660; 
 Wed, 08 Jan 2020 18:33:45 -0800 (PST)
Received: from [192.168.15.12] (alanje.lnk.telstra.net. [120.151.179.201])
 by smtp.gmail.com with ESMTPSA id k12sm4853409pgm.65.2020.01.08.18.33.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2020 18:33:45 -0800 (PST)
Subject: Re: [PATCH v1 20/36] target/riscv: Add support for virtual interrupt
 setting
To: Palmer Dabbelt <palmerdabbelt@google.com>,
 Alistair Francis <Alistair.Francis@wdc.com>
References: <2389483485d4642a6e5670e2546c62e493e91fd6.1575914822.git.alistair.francis@wdc.com>
 <cover.1575914822.git.alistair.francis@wdc.com>
 <mhng-6814f8b9-d54a-4663-900c-83023307a658@palmerdabbelt-glaptop>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <200650e5-cb77-0518-8f27-30d0cf23de22@linaro.org>
Date: Thu, 9 Jan 2020 13:33:40 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <mhng-6814f8b9-d54a-4663-900c-83023307a658@palmerdabbelt-glaptop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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
Cc: alistair23@gmail.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/9/20 11:49 AM, Palmer Dabbelt wrote:
>> +    irqs = (pending & ~env->mideleg & -mie) | (pending &  env->mideleg & -sie);
> 
> Isn't "-unsigned" implementation defined?  I can't get GCC to throw a warning
> and it was already there, so maybe I'm just wrong?

(1) You're confusing implementation defined with undefined, and unsigned
arithmetic is the former not the latter.

(2) There is no such thing as ones-compliment or sign-magnitude integer
hardware anymore, so for this case "implementation defined" is in fact universal.

(3) We build with -fwrapv, so we're explicitly asking for sane behaviour from
our signed types as well.


r~

