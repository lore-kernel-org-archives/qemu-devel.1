Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3466BC432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 18:19:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0604820727
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 18:19:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yfPsN/+i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0604820727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVJiD-00062u-6f
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 13:19:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45546)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iVJhE-0005aq-S5
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 13:18:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iVJhD-0000Fn-7C
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 13:18:20 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:35575)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iVJh9-0000BO-S8
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 13:18:17 -0500
Received: by mail-ot1-x344.google.com with SMTP id n19so1899463otk.2
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2019 10:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=m1+ICzSxg8IBOeQO9d8FWx4l7X8sUWEv3UCg7IYtMHQ=;
 b=yfPsN/+i5eOJ4bFvEnt3NyiuSiKjHTj3Zxw9DOmn3bVhMYdoYmg4IG6gclViEFL51Z
 xvRXMOSXkRwuf56QfMheo67My0DsYF6FuMcoSAairQmLWQGT/1O3VASH6PSCFYu9ihH4
 mMj1pn1/i6uKEqVyswm4kbI4Pd6XgBqZwC8EApm/Panx/VyWhGhhLK2EtHK6CPPmbz59
 0htuJ9q/FB7BcMBn+r3nMhIYeIf/MBHPGYm/+wQeralcrx7Uj7TU0NvGKjFCRypxtn2b
 7ofPRfzFiW1hRa7vvcpdp7fvxToNX5Ab3TCFpX+9LV99yte2IxgBrQ8DJwcLiFg0bdfc
 Hspw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=m1+ICzSxg8IBOeQO9d8FWx4l7X8sUWEv3UCg7IYtMHQ=;
 b=m+dCNV+HbX6fsfSvjFLDquWXZFiNU6neO7KOrKzTpRyE22u1IANk6PjFOXpAunrFHp
 TQcjLI02eq6DU3N+adn0YVZ/qJWobatSLMPmGB5ZUj5QHJpwnkrVWmw6rG6WJ0dfNLoA
 DR/dnQlDpxucMN2e4d8/G2DnHh+8G1V2u21t6jMvglAWPruUdJULuvwURy4HjC4cttXZ
 hNloqQL6a/j7nmUGazpW5w6gIgLcOGEK7yidwJGs44p+ZClwkRoLUucU3PQGQrCYo373
 oYpmG8FcEHLyiZ7MPwMq2s/+O9QtNyBVvJzntQo/ReXPSmeSL6RZ+jlZvWqxUyciquS4
 vWKg==
X-Gm-Message-State: APjAAAVHkei4tP34/dRR0z0qtdu3BoqUudRazgDFZnub1+eSl4l0SVYu
 rg7EwU7JymouVqYehe5FMJB05TlheLvbETsqoSWCcQ==
X-Google-Smtp-Source: APXvYqyv8O1kUgWWAY68lWZsKhLdYXW2/fM/B/wwP336hSJ33aT+LrJSQ6zEEMHcyINIjq5vmkpzhpJwScujr8DqGRY=
X-Received: by 2002:a9d:7ac2:: with SMTP id m2mr8617306otn.135.1573755492491; 
 Thu, 14 Nov 2019 10:18:12 -0800 (PST)
MIME-Version: 1.0
References: <89ada4b1-ee3d-a512-07c2-9bc1ba5806da@redhat.com>
 <20191024224622.12371-1-keithp@keithp.com> <8736fhm9tw.fsf@linaro.org>
 <87pnik4w9n.fsf@keithp.com>
 <CAFEAcA-g+RkvYjseDE=1Z=gnLum0Cjvn_7bqB3ti+cBq9UZ3Eg@mail.gmail.com>
 <87mudo4owu.fsf@keithp.com>
 <CAFEAcA-MRtr9WUpqqwJiX9kc+ybGdgfv7ZB5Tc6_q9xwHwebsQ@mail.gmail.com>
 <87zhgytjt7.fsf@keithp.com>
In-Reply-To: <87zhgytjt7.fsf@keithp.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Nov 2019 18:18:01 +0000
Message-ID: <CAFEAcA8CO5gcVoEq+H=WnhafOf5XoUj2hCrXasrCamMY3QpO8A@mail.gmail.com>
Subject: Re: [PATCH] Semihost SYS_READC implementation (v4)
To: Keith Packard <keithp@keithp.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 14 Nov 2019 at 18:05, Keith Packard <keithp@keithp.com> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > I had an idle glance at this implementation, and this:
> >
> >    uint32_t pre = opcode_at(&ctx->base, ctx->base.pc_next - 4);
> >    uint32_t ebreak = opcode_at(&ctx->base, ctx->base.pc_next);
> >    uint32_t post = opcode_at(&ctx->base, ctx->base.pc_next + 4);
> >
> > (where opcode_at() is a wrapper for cpu_ldl_code()) has
> > some unfortunate side effects: if the previous instruction
> > is in the previous MMU page, or the following instruction
> > is in the next MMU page, you might incorrectly trigger
> > an exception (where QEMU will just longjmp straight out of
> > the cpu_ldl_code()) if that other page isn't actually mapped
> > in the guest's page table. You need to be careful not to access
> > code outside the page you're actually on unless you're really
> > going to execute it and are OK with it faulting.
>
> I can't even find the implementation of cpu_ldl_code; the qemu source
> code is somewhat obscure in this area. But, longjmp'ing out of the
> middle of that seems like a bad idea.

It's the way QEMU works -- generally load/store operations
that work on virtual addresses are expected to only return
in the success case; on failure they longjmp out to cause
the guest exception. (Load/stores on physical addresses
generally return a memory transaction status for the caller
to check and handle.) I agree that within the translation code
it's a bit weird and it might be nicer for the translate.c
code to explicitly handle failures to load an insn, but it
would be a bit of an upheaval to try to rewrite it at this point.

cpu_ldl_code() is provided by include/exec/cpu_ldst.h, incidentally
(via preprocessor macros and repeated inclusion of some template
.h files, which is why a grep for the function name misses it).

> > Does your semihosting spec expect to have the semihosting
> > call work if the sequence crosses a page boundary, the
> > code is being executed by a userspace process, and one of
> > the two pages has been paged out by the OS ?
>
> You've seen the entirety of the RISC-V semihosting spec already.  For
> now, perhaps we should limit RISC-V semihosting support to devices
> without paging support and await a more complete spec.
>
> As you suggest, disallowing the sequence from crossing a page boundary
> would be a simple fix, but that would require wording changes to the
> spec.

Yeah, I'm implicitly suggesting that a bit more thought/revision
of the spec might not be a bad idea. Things that are
effectively supposed to be treated like a single instruction
but which can cross cacheline or page boundaries turn out
to be a fertile source of implementation bugs. (The arm
translate.c code has to be quite careful about handling
32-bit Thumb insns that cross pages. The x86 translate.c
code is less careful and may well be buggy in this area.)

thanks
-- PMM

