Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAEE8C04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 15:32:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 928E524802
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 15:32:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mYaLrYM+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 928E524802
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45284 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWjW9-0002Et-SL
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 11:32:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hWjVH-0001fe-7w
	for qemu-devel@nongnu.org; Fri, 31 May 2019 11:31:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hWjVG-0004MH-7R
	for qemu-devel@nongnu.org; Fri, 31 May 2019 11:31:35 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:41910)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hWjVF-0004LK-VC
	for qemu-devel@nongnu.org; Fri, 31 May 2019 11:31:34 -0400
Received: by mail-ot1-x344.google.com with SMTP id 107so3764386otj.8
	for <qemu-devel@nongnu.org>; Fri, 31 May 2019 08:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=bmR9APJdfWQMX/sQPHBUNGGw4rfDyQZdEujV3s4iraE=;
	b=mYaLrYM+pov4ySclr1FI08uOy+7TF+7sSYGZhx9w4DHdCrmf46sOgT4RDWXZtdxnJn
	fLQ53N15pxjmDvx/N7FAycNAWkaWv6oCaNi90k2JLR07TY/zFvqogH/J5EzFyd0Xeelv
	UqB4ft5Jr8THa7tj3cNrnccf7fuCA1SCh5ZxdCuMQ1Y3RcyFv56goS57Q34OqHYVf5we
	7/w2mx9Sj/BhHVISiAg/RcFhTKVGRSVfR+f/rX/F1gMod604nGKjBSHTVYu3oxylv4Mh
	MB+Rh2oCPf12W/ibN+8GydmPIDsPHXvR25lwCN7NBOVD8CLe2mqt3DZCz5DsG2WNBo7F
	Wmww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=bmR9APJdfWQMX/sQPHBUNGGw4rfDyQZdEujV3s4iraE=;
	b=FhfvGMIEbTIIfSWn6Vbp/AJlla4K2lVd7K9yiTBYYZHWHcURvA2t3jD2D/g/jPY0WA
	2h2yzyBRuqUDb87S2RK9AOmGE0Mt7yNCBpb9oLjBZOQ0EuIbjx1rQ8MRJMEw9qPb9xdI
	7YKhSu3O3vT4jzqjCGjkEgjwVqxd8SdWm05tYEB21bqANIm1McRcsOJ/G3QNONFZ0XdK
	otSNRLQZi3c0fdAxItYcBkzY2gEGDjjfJ3WoL7Aypn+KkZEVcMo5/SJ2Ww1IyBWAPE3S
	h6GGJSoHANf9QDBoNLtEn4ni7NKwqgDoEIWzUNrQ8QXZiazLHwdlwXTu7cjICN6UNl12
	SlEw==
X-Gm-Message-State: APjAAAUg36EaWsGyzR0RMLhFd4qQv/uk0M5/O8VT6dhdTXS6NGO1z2qu
	Pe3dMJg+aHK7wX0BiSgtDDK1Bw==
X-Google-Smtp-Source: APXvYqyql74p3r1WeaG5CfcPrAt8c2hLjgbw+Y/hkVWNMfbef4D+gXPrmsGoYfk5BGGR2lGuT2uoPQ==
X-Received: by 2002:a9d:3ee:: with SMTP id f101mr2348598otf.311.1559316692453; 
	Fri, 31 May 2019 08:31:32 -0700 (PDT)
Received: from [172.24.12.210] (168.189-204-159.bestelclientes.com.mx.
	[189.204.159.168]) by smtp.gmail.com with ESMTPSA id
	r205sm2237818oig.0.2019.05.31.08.31.29
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 31 May 2019 08:31:30 -0700 (PDT)
To: Michael Rolnik <mrolnik@gmail.com>, qemu-devel@nongnu.org
References: <20190530190738.22713-1-mrolnik@gmail.com>
	<20190530190738.22713-6-mrolnik@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <89ce6f5b-17d6-5a11-c8c6-da23f1245162@linaro.org>
Date: Fri, 31 May 2019 10:31:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190530190738.22713-6-mrolnik@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PATCH RFC v20 5/8] target/avr: Add instruction
 translation
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/30/19 2:07 PM, Michael Rolnik wrote:
> +    /* decode first instruction */
> +    ctx.inst[0].cpc = pc_start;
> +    decode_opc(&ctx, &ctx.inst[0]);
> +    do {
> +        /* set curr/next PCs */
> +        cpc = ctx.inst[0].cpc;
> +        npc = ctx.inst[0].npc;
> +
> +        /* decode next instruction */
> +        ctx.inst[1].cpc = ctx.inst[0].npc;
> +        decode_opc(&ctx, &ctx.inst[1]);
> +
> +        /* translate current instruction */
> +        tcg_gen_insn_start(cpc);
> +        num_insns++;

I don't believe that this simultaneous decode of two instructions is correct.

Consider if ctx.inst[0] is a branch instruction that is placed as the very last
word of memory.  Ordinarily, the branch would be executed and the
TranslationBlock ended.

However, the advance read of ctx.inst[1] will cause a read from unmapped
address space (causing an exception), or read from a device (causing "Bad ram
pointer" and an abort from qemu_ram_addr_from_host_nofail).

I believe that the feature that you're attempting to support with this, skip
the next instruction, should be handled via an internal flag bit.  This would
end up looking a lot like the HPPA nullify bit, or somewhat like the ARM thumb
condexec_mask.  I can go into specifics if needed.

Such a change would also allow you to structure this code to use
"exec/translator.h", which in the future will likely be mandatory.


r~

