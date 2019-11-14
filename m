Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D16C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 19:20:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1343020723
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 19:20:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xPGaPbfy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1343020723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVKew-0005bZ-33
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 14:20:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55505)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iVKdm-00059F-EF
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 14:18:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iVKdk-00081g-L5
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 14:18:50 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:35168)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iVKdk-00080C-Cm
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 14:18:48 -0500
Received: by mail-wr1-x442.google.com with SMTP id s5so7900192wrw.2
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2019 11:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=OjnVnioaSSYGgZvdMN2czlk6dTwQn/tEcvA1GrUBUa4=;
 b=xPGaPbfy/kQY5Obu9nSag1y59Jgsrkz6/D5jgs57SX6TIu0al+DEsm1gCz3/kgt9r6
 tQ6NBKnubUwHaSbsdVJpvgw2GIbreQEKJzBAgueIoy04d6o0G2I8qCXRzZ1d/qqJfZxO
 8+MLwRhItXBeB29j+p5rXpXRDbAywisQh/AUyi15xMMy4QMJBBbqbebkF3+BDImRIeEO
 nkujdYXkULH895c3Bwh5DIGA3hbRSxEmZz7Ryc7auYRSwR8i+Z2hTZEHUlTgVEhEKBt1
 /qaEQnusVtgXmY4IsqmrGdq+jHFsjJllZVpqlbkOzD3JFOF3nmb6C/fCA0hJgdJObc6w
 1JDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OjnVnioaSSYGgZvdMN2czlk6dTwQn/tEcvA1GrUBUa4=;
 b=I2htTWEyjePTrDqBsBvyAvs+/9M9Y/x2Fecv+ZqJ6vY7Hp0rzpaKMPJCnLIIjV6NLI
 GWsBM7lVfP1gy3EqVYvKGuICczjQNwlRJZ6q/Ps/vHd3MniYtOqSxbZjdOyIYLX+nx2o
 NNPqPPVXz0DtGcCkDaVekBB3Qhvmx2RDbms1BlwB6jkxBzHu6GhQ7fCMhiTfB8/edaNN
 Ga+RnGWBhOFch5R2gwIpAWbWayQ8yzqirjgOAIQQ4v5Z4TeN4XLjatxsvBZsixRwM7Ky
 s00vCeJtSrgZg1etpwJL6T9C8PGhNiT7axaLhzhJbOw7QB8YibvGxpCCuoyzULOHmlYW
 MVaw==
X-Gm-Message-State: APjAAAWlXljKX2uBjRU2bdZ2ZRQgZjnTON+cP4maWPlk9KcLt/vD3Ibj
 QT+A4hr3B2BwnjYzg+ieyueOcaYbJaIslA==
X-Google-Smtp-Source: APXvYqwJZxkTe7UpV4OFP63msiIMXVBExeS2MtBQwTnYh3mvcRxFs53gOcaVZfaCodx5l+l2DLXt6g==
X-Received: by 2002:a5d:678c:: with SMTP id v12mr2547499wru.116.1573759126880; 
 Thu, 14 Nov 2019 11:18:46 -0800 (PST)
Received: from [192.168.8.102] (184.red-37-158-56.dynamicip.rima-tde.net.
 [37.158.56.184])
 by smtp.gmail.com with ESMTPSA id l1sm8345252wrw.33.2019.11.14.11.18.45
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 14 Nov 2019 11:18:46 -0800 (PST)
Subject: Re: [PATCH] Semihost SYS_READC implementation (v4)
To: Peter Maydell <peter.maydell@linaro.org>, Keith Packard <keithp@keithp.com>
References: <89ada4b1-ee3d-a512-07c2-9bc1ba5806da@redhat.com>
 <20191024224622.12371-1-keithp@keithp.com> <8736fhm9tw.fsf@linaro.org>
 <87pnik4w9n.fsf@keithp.com>
 <CAFEAcA-g+RkvYjseDE=1Z=gnLum0Cjvn_7bqB3ti+cBq9UZ3Eg@mail.gmail.com>
 <87mudo4owu.fsf@keithp.com>
 <CAFEAcA-MRtr9WUpqqwJiX9kc+ybGdgfv7ZB5Tc6_q9xwHwebsQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <d4baa0c3-694a-293a-385a-b3eba7d52d0d@linaro.org>
Date: Thu, 14 Nov 2019 20:18:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-MRtr9WUpqqwJiX9kc+ybGdgfv7ZB5Tc6_q9xwHwebsQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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

On 11/14/19 5:14 PM, Peter Maydell wrote:
> On Fri, 25 Oct 2019 at 20:15, Keith Packard <keithp@keithp.com> wrote:
>> There seems to be convergence on a pretty simple interface which uses
>> ebreak surrounded by a couple of specific no-ops:
>>
>>       slli x0, x0, 0x1f
>>       ebreak
>>       srai x0, x0, 0x7
>>
>> There are implementations in rust and openocd, and I've got one for
>> picolibc. The risc-v semihosting code is sitting on a branch in my repo
>> on github:
>>
>>         https://github.com/keith-packard/qemu/tree/riscv-semihost
> 
> I had an idle glance at this implementation, and this:
> 
>    uint32_t pre = opcode_at(&ctx->base, ctx->base.pc_next - 4);
>    uint32_t ebreak = opcode_at(&ctx->base, ctx->base.pc_next);
>    uint32_t post = opcode_at(&ctx->base, ctx->base.pc_next + 4);
> 
> (where opcode_at() is a wrapper for cpu_ldl_code()) has
> some unfortunate side effects: if the previous instruction
> is in the previous MMU page, or the following instruction
> is in the next MMU page, you might incorrectly trigger
> an exception (where QEMU will just longjmp straight out of
> the cpu_ldl_code()) if that other page isn't actually mapped
> in the guest's page table. You need to be careful not to access
> code outside the page you're actually on unless you're really
> going to execute it and are OK with it faulting.
> 
> I'm not sure what the best way on QEMU to identify this kind
> of multiple-instruction-sequence is -- Richard might have an
> idea. One approach would be to always take an exception
> (or call a helper function) for the 'ebreak', and then
> distinguish semihosting from other kinds of ebreak by doing
> the load of the preceding/succeeding instructions at runtime
> rather than translate time.

It's irritating that this 3 insn sequence is already a thing, baked into other
sim/emulators.  Seems to me that it would have been easier to abscond with

    ebreak + func3 field != 0.

For semi-hosting, it seems even better if the semi-hosting syscall instruction
is not "real", because you're explicitly requesting services from "unreal"
hardware.  It should be specified to generate a SIGILL type of exception
anywhere semi-hosting is not enabled.

That said, it is possible to do this in the translator, by considering this
sequence to be one 12-byte instruction.

You'd build in a recognizer into the decoder such that, when semi-hosting is
enabled, seeing the entry nop starts looking ahead:

  - If this is not the first insn in the TB, and there are
    not 8 more bytes remaining on the page, terminate the
    current TB.  This will re-start the machine in the next TB.

  - If the complete sequence is not found, then advance the pc
    past the entry nop and let nature take its course wrt the
    subsequent instructions.

  - If the sequence crosses a page, then so be it.  Because of
    step 1, this only happens when we *must* cross a page, and
    will have recognized any paging exception anyway.
    The generic parts of qemu will handle proper invalidation of
    a TB that crosses a page boundary.

  - This is kinda similar to the target/sh4 code to handle
    generic user-space atomic sequences: c.f. decode_gusa().

  - This implementation does mean that you can't jump directly
    to the ebreak insn and have the sequence be recognized.
    Control must flow through the entry nop.
    This is a bug or a feature depending on the reviewer.  ;-)

With that in mind, it may be simpler to handle all of this not in the
translator, but in the function that delivers the ebreak exception.  At that
point one can arrange to read memory without raising additional exceptions.


r~

