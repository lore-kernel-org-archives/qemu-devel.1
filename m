Return-Path: <SRS0=Z2zD=34=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E09C35250
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 08:47:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65FC521741
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 08:47:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TxNM4kVP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65FC521741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0Lld-0007Hj-LR
	for qemu-devel@archiver.kernel.org; Sat, 08 Feb 2020 03:47:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54378)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j0LkP-0006NQ-Kf
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 03:45:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j0LkO-0006oT-DL
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 03:45:53 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:54160)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j0LkK-0006iq-Tl
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 03:45:49 -0500
Received: by mail-wm1-x342.google.com with SMTP id s10so4808315wmh.3
 for <qemu-devel@nongnu.org>; Sat, 08 Feb 2020 00:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=N2g4fsPzCNnL85xTKb4M6or2V8VUzHKfyw3jpRknYkw=;
 b=TxNM4kVPV+NbgliSJyAOcnGCt2VhY+06YAPEbLIzqMNCTjpXrez/bPr7hfzs71amH6
 tPuRHZ0t842H0sxYA97It/D4A9xA1hCVsxVlxb2/I8kwgCOzOrHYmvYQicfg8GN9xsI4
 m21kN1H9z0kB93UYqHxz9OjY6Vaxh401QTOCkJhTqqpEeT4ZucvEwaBdv2dkORpxZqMs
 T6Ed7VGX4jgY1iYcsvJairh7WsTO0CY8e2BKJRdEULaJLFANYUzrmZRIaYVbeERd0JAX
 fxwIVVqRf6jy760pdnbUXmO94nPix5PvIgvqE+o+b6wmXqscr4abDKgFdV8kiKMPmnEY
 HOFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=N2g4fsPzCNnL85xTKb4M6or2V8VUzHKfyw3jpRknYkw=;
 b=mQjPIqvbEZ8MwCSmbo9cnh7RoHON95hOVSwFj0xuHkw8oEyDYfAQOwdERn97TevoXZ
 eyzRQ1eNPDuK4kIkxhQh8xFf9P5ddvHI+Q1CvwKN9QYWKTbaUMydc1P3HD7AR6pZrAM6
 eGj74f0AgrxF4JXcUalAfxsnNU2lqgX9YxPSp10rwR8FS6gR+4bk5V/21CHM7ztiZAom
 U9coQXtWEZCaME+cEdTob7/pz5oVJZY9RZkooPd9n07que2ASWCr5waRxV/8Y/rru31p
 k8ynQ+mOZxOBa76vQmsRSFzR437Q0E/FVJo9MgyH1G7BGRj4gGNY1y8BZ6KKqwAJOUlv
 RSSg==
X-Gm-Message-State: APjAAAWrsUKHWkHS0rK/8UFT5JLYlDgoPWOHi3vpQejG4PkfmjLm/gyE
 vZgR48SCKE2uunCUMcVuzay2cA==
X-Google-Smtp-Source: APXvYqy8DCnmzJ/HxaPFolVB0WjB3h0AUnZyTa6EDRMv03rpjbKteQWvTFb5ExrfdbeE0Umdt0LWTA==
X-Received: by 2002:a05:600c:21c5:: with SMTP id
 x5mr3504682wmj.72.1581151547336; 
 Sat, 08 Feb 2020 00:45:47 -0800 (PST)
Received: from [10.43.13.93] ([135.196.99.211])
 by smtp.gmail.com with ESMTPSA id w19sm6373387wmc.22.2020.02.08.00.45.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 08 Feb 2020 00:45:46 -0800 (PST)
Subject: Re: [PATCH v3 14/20] target/arm: Set PAN bit as required on exception
 entry
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200203144716.32204-1-richard.henderson@linaro.org>
 <20200203144716.32204-15-richard.henderson@linaro.org>
 <CAFEAcA9mkjeis8mavOSQsxvnH3pLv=WpwcKsNKzOONzMB6=+Ww@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <848885b6-ee56-d38d-e77e-5bf17a2af3e2@linaro.org>
Date: Sat, 8 Feb 2020 08:45:45 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9mkjeis8mavOSQsxvnH3pLv=WpwcKsNKzOONzMB6=+Ww@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/7/20 6:01 PM, Peter Maydell wrote:
>> +        /* CPSR.PAN is preserved unless target is EL1 and SCTLR.SPAN == 0. */
>> +        if (cpu_isar_feature(aa64_pan, env_archcpu(env))
>> +            && new_el == 1
>> +            && !(env->cp15.sctlr_el[1] & SCTLR_SPAN)) {
>> +            env->uncached_cpsr |= CPSR_PAN;
>> +        }
> This doesn't catch the "taking exception to EL3 and AArch32 is EL3"
> case, which is also supposed to honour SCTLR.SPAN.
> 
> Given where this code is, we know we're taking an exception to
> AArch32 and that we're not going to Hyp mode, so in fact every
> case where we get here is one where we should honour SCTLR.SPAN
> and I think we can just drop the "new_el == 1" part of the condition.

Presumably that becomes env->cp15.sctlr_el[new_el] as well, so that we get the
secure version of the sctlr.


r~

