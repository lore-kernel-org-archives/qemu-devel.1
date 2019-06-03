Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 779E9C04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 16:36:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 423CB272E7
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 16:36:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CVc5RXaf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 423CB272E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37784 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXpwQ-0000Gv-77
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 12:36:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mrolnik@gmail.com>) id 1hXpug-0007Mh-8o
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 12:34:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mrolnik@gmail.com>) id 1hXpq4-00015s-J7
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 12:29:41 -0400
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:38045)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1hXpq0-0000un-Pg
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 12:29:34 -0400
Received: by mail-qt1-x844.google.com with SMTP id l3so10131480qtj.5
	for <qemu-devel@nongnu.org>; Mon, 03 Jun 2019 09:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=lRuIkeul+qqgsLppUx57B3WUblp1ykcJJeI+hoHIZ2o=;
	b=CVc5RXaf/VrBrfgBfAv+t5jTKh1tdrEm6HHaGdvdHx7plZD/DnFnN+pFvcjXaJPdFy
	F91k8G5wUdSktcz0tDSono8lt62ya7LGeUe12TmjNDpHaNnGp/8NOG/fBAwQRjK2j60e
	RI8q/uaetBwTJooRjc37I9vT/Gk/krVcRouUWD2Icz7nSUylkFG0SDtENt4oaqVK8aLv
	bVeyW8cos3yaJpLep4iPMKx1m6qi4LqI6igQCRwTu0uNQwhDnaLwA6Z0Zb06AapsNf7b
	rEgR3tK9OxMuCQsuIYmEYdchaYbDzk8hn1szhhrIyZnU60h2FXVj5I1ysAagYA4eSaRM
	31bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=lRuIkeul+qqgsLppUx57B3WUblp1ykcJJeI+hoHIZ2o=;
	b=gyEBmYaxAvTgMGv+AdK8kfDhhEvUmK1+VY9RVa64a3Bp4UGJ1yAEkjjLASC1HK3mIW
	gjIvZrSsYbpGD/vNmU0H18H+T60VNpMUvndp5oxt3aiplHivX8TQGItfkBkRp8mxa2i5
	Z7GmBj6yVE0+TLC/TIJfCfg1pgkm01O/K922EHi+88vATpnD10oOs3dGFzcKlTR3yjfU
	YQGz8psyzXRHJcwKcDfMGHhyHEZ2lRdTSawcOOXdKS2SWUUxk3eNA0U/90S9jEyknfXM
	9EmNsV4sERScYcnI+BT3Pyr0z3uli1fM+O56L9DshzDWVzD3TnxVCC4CFUH/PdfUvcOT
	1yxA==
X-Gm-Message-State: APjAAAUtV5UJ+CZER+76+pzHu0cgWlycJSM4fFolNE9MnCFkaKcr6KlE
	ROX/UZaNcGBuKy2FldkIIGIjq6qiyItR1w64/is=
X-Google-Smtp-Source: APXvYqwynpIpgifDnplqJd5xx/aXE9wLL0ZAGSAdwgD1sTQgNIKoy22JSYWy6FCdYykGphh2XZr4lPUQrlr0NqsySpI=
X-Received: by 2002:ac8:5315:: with SMTP id t21mr14106729qtn.229.1559579370510;
	Mon, 03 Jun 2019 09:29:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190530190738.22713-1-mrolnik@gmail.com>
	<20190530190738.22713-4-mrolnik@gmail.com>
	<402ba0b2-e2e0-6b7a-1862-4588e5f83357@linaro.org>
	<CAK4993iXV9oRr_VfabJHg4fCYEppW49i_PE9R0X_TBqk7TDkrQ@mail.gmail.com>
	<9e2acbbe-7ede-c45d-5e9f-bb269aa25fcc@linaro.org>
In-Reply-To: <9e2acbbe-7ede-c45d-5e9f-bb269aa25fcc@linaro.org>
From: Michael Rolnik <mrolnik@gmail.com>
Date: Mon, 3 Jun 2019 19:29:17 +0300
Message-ID: <CAK4993hXTOSoW5FFjeur+pLzT18c-C=vwao-904ASyqMsT5eMQ@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::844
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
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

1. There's a break instruction
https://www.microchip.com/webdoc/avrassembler/avrassembler.wb_BREAK.html
2. There's a set of tests that use break.

So I assume I have to implement this instruction as described in the spec.

Sent from my cell phone, please ignore typos

On Mon, Jun 3, 2019, 6:44 PM Richard Henderson <richard.henderson@linaro.org>
wrote:

> On 6/1/19 4:12 PM, Michael Rolnik wrote:
> > Hi Richard.
> >
> > If I implement it this way
> >
> > ```
> >  static bool trans_BREAK(DisasContext *ctx, arg_BREAK *a)
> >  {
> >      if (avr_feature(ctx->env, AVR_FEATURE_BREAK) == false) {
> >          gen_helper_unsupported(cpu_env);
> >      } else {
> >          tcg_gen_movi_tl(cpu_pc, ctx->inst[0].npc);
> >          gen_helper_debug(cpu_env);
> >      }
> >
> >      ctx->bstate = BS_EXCP;
> >
> >      return true;
> >  }
> > ```
> >
> > qemu (without -s -S flags) crashes when debugger is not connected
>
> I was not suggesting using the internal qemu EXCP_DEBUG, but another AVR
> specific exception, much the same way as every other cpu has a cpu-specific
> debug exception.
>
> Or perhaps always do nothing.  Why is gdb insertting BREAK in the first
> place?
>  It should be using the "hardware breakpoint" support that qemu advertises
> as
> part of the gdbstub protocol, and that you support here:
>
> > +        if (unlikely(cpu_breakpoint_test(cs, OFFSET_CODE + cpc * 2,
> BP_ANY))
> > +                 || cpu_breakpoint_test(cs, OFFSET_DATA + cpc * 2,
> BP_ANY)) {
> > +            tcg_gen_movi_i32(cpu_pc, cpc);
> > +            gen_helper_debug(cpu_env);
> > +            ctx.bstate = BS_EXCP;
> > +            goto done_generating;
> > +        }
>
>
>
> r~
>
