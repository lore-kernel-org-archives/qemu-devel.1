Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B133C04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 16:39:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 599F527290
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 16:39:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i3bzZfYP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 599F527290
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37822 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXpze-00036U-G9
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 12:39:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hXpxH-0001K9-Dg
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 12:37:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hXpxG-0008Vn-5U
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 12:37:03 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:40880)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hXpxF-0008TM-Vw
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 12:37:02 -0400
Received: by mail-ot1-x344.google.com with SMTP id u11so16651481otq.7
	for <qemu-devel@nongnu.org>; Mon, 03 Jun 2019 09:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=+hJVmNCcsydsN0TfjYwt9CYBJrxjatoQ2AWAKd8J6z0=;
	b=i3bzZfYPY+erLGGWAB9RoIGDWLLaSIn7Oo0Wda5BTd9UbU6M23j/0XZX5UFy77ZhS5
	ok7mEiDa2YOqiEFipdO5HwAMzpsXM3s/VF/W0zRuRAvdtPfJ4YOT2L8AyiUt+Gk4Q8nd
	mfmGxYf3WiouBFgK+hwKFpR3A1REBRbE8crsJ0V0wxYVDZgCooR9SWstGnA7vtXD6Mb/
	fqJJKJvuwljE6wlpyz1gaib2VZ22Hnb+HX75fmxKt5sDGFOy3t1gaKaQRGmATWDQC/28
	FO08qKKWJf89Ouc4qzWsz25ein5hcMe1UhZzTaJPIDFJ9UCi3OWwmOMOlJK9ngNoGkUA
	44bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=+hJVmNCcsydsN0TfjYwt9CYBJrxjatoQ2AWAKd8J6z0=;
	b=KjdLUbqH+V4Je28d0rzteUJmBnm1L88OoUDC+/RIWr3ebJjBfAssKArgRScRGfe/8H
	4/kqzxMqyqjeHs8zqkw5eKfbK7n00GfGKPt1uLPmtDm+rD6NIdayMGkEd64onmqf4o/O
	bMhVNbZcUSME5pYHVRQrslqGjyrs0yOdozkgbCIPlLjqnL9M85J8EiPaM4oDyfIAbF4k
	Ql9BVK6weTkqU5NigGYlcgavz6wjikzUag4IB0+Cpa430aqnqKwU5AmeI4ptrwxq2tx8
	RfsMes7HJfwcKiU+4siy7u2XY24k4d6TiU5javCmeUseGbM1YvfLf9VqO5a3cWlJaKs6
	k3SQ==
X-Gm-Message-State: APjAAAUzaFxNm/Ms10RnC44glWjwRmosjoCFqIF0xaKDxsBmsuoFsBFC
	wjk5/k2Q31oAHD5NtMqSjT6RBA==
X-Google-Smtp-Source: APXvYqzJFleHaGsgtdDpPo1eCjs/HkrDiQjyqj/ZQ5lWtyZ4hkdfP2GQgIcKcW74EXVcJnoiW4IWMA==
X-Received: by 2002:a9d:6f01:: with SMTP id n1mr160251otq.276.1559579820282;
	Mon, 03 Jun 2019 09:37:00 -0700 (PDT)
Received: from [192.168.3.43] (200-56-192-86-cable.cybercable.net.mx.
	[200.56.192.86]) by smtp.gmail.com with ESMTPSA id
	m13sm4958062ote.68.2019.06.03.09.36.58
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 03 Jun 2019 09:36:59 -0700 (PDT)
To: Michael Rolnik <mrolnik@gmail.com>
References: <20190530190738.22713-1-mrolnik@gmail.com>
	<20190530190738.22713-4-mrolnik@gmail.com>
	<402ba0b2-e2e0-6b7a-1862-4588e5f83357@linaro.org>
	<CAK4993iXV9oRr_VfabJHg4fCYEppW49i_PE9R0X_TBqk7TDkrQ@mail.gmail.com>
	<9e2acbbe-7ede-c45d-5e9f-bb269aa25fcc@linaro.org>
	<CAK4993hXTOSoW5FFjeur+pLzT18c-C=vwao-904ASyqMsT5eMQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <3bc0d426-bd59-055d-a010-b136cba555bf@linaro.org>
Date: Mon, 3 Jun 2019 11:36:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAK4993hXTOSoW5FFjeur+pLzT18c-C=vwao-904ASyqMsT5eMQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PATCH RFC v20 3/8] target/avr: Add mechanism to
 check for active debugger connection
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/3/19 11:29 AM, Michael Rolnik wrote:
> 1. There's a break
> instruction https://www.microchip.com/webdoc/avrassembler/avrassembler.wb_BREAK.html
> 2. There's a set of tests that use break. 
> 
> So I assume I have to implement this instruction as described in the spec.

The spec talks about fuses, not gdb.  A valid implementation of this
instruction is a no-op -- it say so right there in the spec.

What does it mean to "test" break?  AFAIK, you can't test this at all from
within the cpu itself, since it does not generate a cpu-level exception.

If gdb is setting a breakpoint via -S, it should be done via cpu_breakpoint_test.



> On Mon, Jun 3, 2019, 6:44 PM Richard Henderson <richard.henderson@linaro.org
> <mailto:richard.henderson@linaro.org>> wrote:
> 
>     On 6/1/19 4:12 PM, Michael Rolnik wrote:
>     > Hi Richard.
>     >
>     > If I implement it this way
>     >
>     > ```
>     >  static bool trans_BREAK(DisasContext *ctx, arg_BREAK *a)
>     >  {
>     >      if (avr_feature(ctx->env, AVR_FEATURE_BREAK) == false) {
>     >          gen_helper_unsupported(cpu_env);
>     >      } else {
>     >          tcg_gen_movi_tl(cpu_pc, ctx->inst[0].npc);
>     >          gen_helper_debug(cpu_env);
>     >      }
>     >
>     >      ctx->bstate = BS_EXCP;
>     >
>     >      return true;
>     >  }
>     > ```
>     >
>     > qemu (without -s -S flags) crashes when debugger is not connected
> 
>     I was not suggesting using the internal qemu EXCP_DEBUG, but another AVR
>     specific exception, much the same way as every other cpu has a cpu-specific
>     debug exception.
> 
>     Or perhaps always do nothing.  Why is gdb insertting BREAK in the first place?
>      It should be using the "hardware breakpoint" support that qemu advertises as
>     part of the gdbstub protocol, and that you support here:
> 
>     > +        if (unlikely(cpu_breakpoint_test(cs, OFFSET_CODE + cpc * 2, BP_ANY))
>     > +                 || cpu_breakpoint_test(cs, OFFSET_DATA + cpc * 2,
>     BP_ANY)) {
>     > +            tcg_gen_movi_i32(cpu_pc, cpc);
>     > +            gen_helper_debug(cpu_env);
>     > +            ctx.bstate = BS_EXCP;
>     > +            goto done_generating;
>     > +        }


