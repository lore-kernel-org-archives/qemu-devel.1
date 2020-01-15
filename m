Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F719C32771
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 21:29:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC4762465A
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 21:29:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RgW4x10a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC4762465A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irqDl-0000Tw-0x
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 16:29:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53176)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1irqD9-0008P3-8z
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 16:28:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1irqD7-0005vF-Ut
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 16:28:22 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430]:37648)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1irqD7-0005uO-Ov
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 16:28:21 -0500
Received: by mail-pf1-x430.google.com with SMTP id p14so9120489pfn.4
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2020 13:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=GjlaLraBKsptUGCtLv6cppvVT81pJhdKQc7NnUI8J5U=;
 b=RgW4x10a8OB0jZ4sxX600KFHr8Ds2KuihfKHpPVpDEX2LGqMRONKwNEntfKZ+VaHGd
 9FUQ3FQZD6uTlNd5i3VMH0+pc58GYCT9Y0eRMUcL2TIienFAYwEihViT8xUt06pDQjlM
 a4KST5d9VLGH25rqmTXB58DxJIfy/w0Y7bReVNMiVduYlZ7Yjphk9arkN2bG7TsIw6xv
 UF/7oMajR/J17rnv4H11HrhUcTfGZuE43d+JgEQo4Ez9kki6+qFiXHPOXJBSFgbVNrwH
 XbJJgULslw2AWfodZdLXuVeGkDEifd1TBXhjxzHVf3U9BJMVrFEJtvWTH6cfDL8nxOOP
 Kmfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GjlaLraBKsptUGCtLv6cppvVT81pJhdKQc7NnUI8J5U=;
 b=h5zK36KRIZVVK71iMQf+q00lvUNz7FvezsOCksI+LughJ9iGtvteXGSX0SdxlHHg0o
 wn3K4sS84akPJDuBW2IvKUWBSbVfdqQciIhv0pmwDvz9leYfbCxTC7lCCZbDNpwuGVXg
 iEwApD6MzFHGeamBuxBZ8k9RoxK5EaQ3doOdP/0+HhghePBEf1T5N2jt2GuKA2d0WZLA
 vsBODp36htNxJgC+izmte0C8Z7Qmz+TuKrayrIjR2b484M3ROCdCGvDwYpN3m69R9tWu
 pDv+lSWQAPz8wYWt4duYlZNPIz2EnyHCIS+6OCHwNdSbp0biGH1WDgKWnEuTE8xbdzvr
 0vaw==
X-Gm-Message-State: APjAAAXJfOq/ouqkl0GxVQJlXuHs56hddHPEoDgP1euqsgDXYd5QUfAu
 r8QfUarDY8l2gf1jKNX7OLI42g==
X-Google-Smtp-Source: APXvYqykKFIci5e1pFUm9V0MfNzpNC8l0HY+e7b2U4fuCJoqtBReNv1b5wQr94qkKcdm31R5kJTacA==
X-Received: by 2002:a63:2a49:: with SMTP id q70mr34564054pgq.265.1579123700176; 
 Wed, 15 Jan 2020 13:28:20 -0800 (PST)
Received: from [192.168.3.43] (rrcs-66-91-136-155.west.biz.rr.com.
 [66.91.136.155])
 by smtp.gmail.com with ESMTPSA id s7sm746379pjk.22.2020.01.15.13.28.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2020 13:28:19 -0800 (PST)
Subject: Re: Semihosting, arm, riscv, ppc and common code
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <11d88b2741eac3f634d5aed9e3355c974b533f7b.camel@kernel.crashing.org>
 <AE7841A1-B4D6-4D6D-9AFD-01C4604D7BC4@livius.net>
 <cd9a2de94700a2781f176247131dceba690d8f31.camel@kernel.crashing.org>
 <87sgkimkma.fsf@linaro.org>
 <1309ca0ab6405d88cfd949c73130ad0f2af944a6.camel@kernel.crashing.org>
 <87wo9tkjxz.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <81f25a9e-a52c-ca8d-4d4b-ca36fcee73ed@linaro.org>
Date: Wed, 15 Jan 2020 11:28:14 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <87wo9tkjxz.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::430
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
Cc: Liviu Ionescu <ilg@livius.net>, keithp@keithp.com, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/15/20 2:01 AM, Alex Bennée wrote:
> Hmm, I'm not so sure. QEMU tries to emulate real HW although I
> appreciate that is a somewhat loose definition once you get to things
> like -M virt and other such SW like abstractions. Is semihosting even
> going to be a thing on real RiscV/Power silicon?

For risc-v, the odd nop-full semi-hosting call sequence was chosen to work with
jtag debuggers on real silicon.

As for the rest of the abi, the stuff after the debugger/emulator has gotten
control, they did have the opportunity to do better, and did not.


r~

