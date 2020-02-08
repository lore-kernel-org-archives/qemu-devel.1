Return-Path: <SRS0=Z2zD=34=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66CB6C35250
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 09:28:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF13E21741
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 09:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EgvxRMRg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF13E21741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0MPp-0001iV-18
	for qemu-devel@archiver.kernel.org; Sat, 08 Feb 2020 04:28:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60974)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j0MOs-0000Lm-Bf
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 04:27:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j0MOq-0004JF-OC
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 04:27:41 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:45555)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j0MOq-0004HA-Fz
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 04:27:40 -0500
Received: by mail-wr1-x442.google.com with SMTP id g3so570247wrs.12
 for <qemu-devel@nongnu.org>; Sat, 08 Feb 2020 01:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=QYCidcVEyoXESpu0E/qYSJstu/laEa8EV37LmXuq7Tk=;
 b=EgvxRMRg5ST141T+kHGU20TY3OPi8zbkhugZApLp6A6PC7nC/quRpdLsqbBunbDDya
 zpyloCp8d/PMnIH+OuvGBKswrf5x5P3SCFl3mGBB/8GJMIv2RN+tRYqHKjuSajaavFaz
 nhvzAahiGf0SJayGjFPBWB0XfAY8HREJ4EQ3l9oGwf8vJTkXSoxXQQH9FHlnrw0l+BqW
 Sy7wcIjZ2NvzdOkANfiWgmdSCADfUc9l09LZyoEEb6FaJF04rl9KX7cX4/VR9WD32v6j
 Mp9zKurUocv5+w+271ckxT/RBLqgNPYYf0vS6uhOTLCyu2pnobIapKIuxLlcQeAikIPf
 nvAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QYCidcVEyoXESpu0E/qYSJstu/laEa8EV37LmXuq7Tk=;
 b=CsydTR54ckIzsCZgzOHtMgljEqStPgRW39YFL1kbdwmUjd0mtQdVm+1ZHUE0OzGoWn
 qRtxk8NM46TBBbiJRoLsk1IySbz52YzVO7m/Bocjo5c315KDN87zYVT65uLA8rr1eEar
 P+8YapXzGr0xjpYJYFnfI1fngllfOn60TwPFFly9hbQJerweuE/e+fbkk5LyoFyBr5od
 Wpor1iYNfhjTmI8w0y59Ba9hlxQJ8umUDIfPiWAD6T8zQsv2bIgWeLB3iAmlvn3NL1tH
 VOITQy8/XdbZXyKmNNMhGzBxtgHkcwLT6ulEW7UzeQtfu7wh3zXmITJuqneAWiL9G6Nc
 v2Zw==
X-Gm-Message-State: APjAAAU/5eSrKbDZmiADRZFlDYZrSdRZI8unB93b79cK0DJaACRlwQL7
 UxANFVyDAbNZk8VJ/q5UMGCRvA==
X-Google-Smtp-Source: APXvYqyFRqkrl3OiesK2O/zsrur04XZA+trMQKWdiLPVsM56CuFQCxrv9js6WRIbvjCa/nGT5v3UYA==
X-Received: by 2002:a5d:6191:: with SMTP id j17mr4303482wru.427.1581154058998; 
 Sat, 08 Feb 2020 01:27:38 -0800 (PST)
Received: from [10.43.13.93] ([135.196.99.211])
 by smtp.gmail.com with ESMTPSA id k7sm6490572wmi.19.2020.02.08.01.27.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 08 Feb 2020 01:27:38 -0800 (PST)
Subject: Re: [PATCH v3 14/20] target/arm: Set PAN bit as required on exception
 entry
From: Richard Henderson <richard.henderson@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200203144716.32204-1-richard.henderson@linaro.org>
 <20200203144716.32204-15-richard.henderson@linaro.org>
 <CAFEAcA9mkjeis8mavOSQsxvnH3pLv=WpwcKsNKzOONzMB6=+Ww@mail.gmail.com>
 <848885b6-ee56-d38d-e77e-5bf17a2af3e2@linaro.org>
Message-ID: <5bebe5c3-7dd0-bcdd-546d-32bc392d0f18@linaro.org>
Date: Sat, 8 Feb 2020 09:27:37 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <848885b6-ee56-d38d-e77e-5bf17a2af3e2@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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

On 2/8/20 8:45 AM, Richard Henderson wrote:
> On 2/7/20 6:01 PM, Peter Maydell wrote:
>>> +        /* CPSR.PAN is preserved unless target is EL1 and SCTLR.SPAN == 0. */
>>> +        if (cpu_isar_feature(aa64_pan, env_archcpu(env))
>>> +            && new_el == 1
>>> +            && !(env->cp15.sctlr_el[1] & SCTLR_SPAN)) {
>>> +            env->uncached_cpsr |= CPSR_PAN;
>>> +        }
>> This doesn't catch the "taking exception to EL3 and AArch32 is EL3"
>> case, which is also supposed to honour SCTLR.SPAN.
>>
>> Given where this code is, we know we're taking an exception to
>> AArch32 and that we're not going to Hyp mode, so in fact every
>> case where we get here is one where we should honour SCTLR.SPAN
>> and I think we can just drop the "new_el == 1" part of the condition.
> 
> Presumably that becomes env->cp15.sctlr_el[new_el] as well, so that we get the
> secure version of the sctlr.

Actually, there's another clause that I missed before:

  # When the target of the exception is EL3, from Non-secure
  # state, this bit is set to 0 regardless
  # of the value of the Secure SCTLR.SPAN bit.

See G8.2.33.  Will fix for v4.


r~

