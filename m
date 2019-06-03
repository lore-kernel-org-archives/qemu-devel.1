Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 582DCC04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 17:05:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26F62274B9
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 17:05:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+5/Pe2e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26F62274B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38188 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXqOx-0004d4-7N
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 13:05:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mrolnik@gmail.com>) id 1hXqNm-0004GS-Vj
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 13:04:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mrolnik@gmail.com>) id 1hXqNl-0001WO-Jl
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 13:04:26 -0400
Received: from mail-qt1-x82a.google.com ([2607:f8b0:4864:20::82a]:46618)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1hXqNl-0001T9-Dr
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 13:04:25 -0400
Received: by mail-qt1-x82a.google.com with SMTP id z19so10215549qtz.13
	for <qemu-devel@nongnu.org>; Mon, 03 Jun 2019 10:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=QEtVKPOGCTSdY31AqEu8FvNmuIk1yer5QGLOCHmJTJE=;
	b=b+5/Pe2et3TTe2WIPduo0+WnLhgkFzP5ONarXlu4R2jdXWWjNPPtvHfd8kGcN/x4C6
	GiFgYWdq6+yqG4hm4QYD7IdTLpL4l48EsGNrTbigCSGteaKXoZaGjV2cXuV4OrIxFqd4
	xcIcfI+BNCuzN2F+VoYyWLQTEjrXIttNSzTk/Fvyb20o+ajzgHtcIrp8MXsy5wBNdc6n
	0WV1/pXUylNKTvp6PBDu8f/XhuRd7vzmL9vcKGbLYVRI5gnXlbjxh8zwheQ1SAWJVpxi
	g7r5ou7lhJ9b22B6qE0gmSYP4YG2YKL1lvHsLH3HBgcaQS0NrLH1d1NjtpubxAvuIKmr
	9dYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=QEtVKPOGCTSdY31AqEu8FvNmuIk1yer5QGLOCHmJTJE=;
	b=UcOIUBaDqS+s/mXaJwdJ1/aO1GlkeTi8w31omoiB4s66ad9RJLcv7rHO+mfdR56uht
	6fLR9Y7hIAYXZsIYuwAkgwWs3fhNNH8Qnd96fo70LG+V5/0x/JNkG147jv712BWqeOQF
	k/exOdjFd9p+/FBCL0q9c03FRvCyLOkdhtQ5QWgY7kvoUefI8vS+teTSsONohHfENpzB
	Fb0gOayhff2llAUB6UR2ceAzGXtcohPwCOwP57+CatfCA/A2c8x61WIlyrT26WILol6v
	XG310Mx1GoSbnDdta3lysCFlN4X+T50ZgQPpr46zBSwFLimIgXLeS5+AK8vVgtEyLVlE
	34NQ==
X-Gm-Message-State: APjAAAVJGxP2ayoa8AYV1P5kc6QsTq8G1Jbo06TI9GGizvwcKXsxMs0N
	gmy2sqhzckVq7E43oEqv49o5fG6dFYo5JBgS5jI=
X-Google-Smtp-Source: APXvYqxk9YuTDa0dgn4WF6Q3pVxM7+Ej/3wXmtBoxiLRdf9Dhqqc7iyPIjI+LaRgnN9eE4B5BIU1p4boA4+7SBOp3eg=
X-Received: by 2002:ac8:3a63:: with SMTP id w90mr23104163qte.371.1559581463090;
	Mon, 03 Jun 2019 10:04:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190530190738.22713-1-mrolnik@gmail.com>
	<20190530190738.22713-4-mrolnik@gmail.com>
	<402ba0b2-e2e0-6b7a-1862-4588e5f83357@linaro.org>
	<CAK4993iXV9oRr_VfabJHg4fCYEppW49i_PE9R0X_TBqk7TDkrQ@mail.gmail.com>
	<9e2acbbe-7ede-c45d-5e9f-bb269aa25fcc@linaro.org>
	<CAK4993hXTOSoW5FFjeur+pLzT18c-C=vwao-904ASyqMsT5eMQ@mail.gmail.com>
	<3bc0d426-bd59-055d-a010-b136cba555bf@linaro.org>
In-Reply-To: <3bc0d426-bd59-055d-a010-b136cba555bf@linaro.org>
From: Michael Rolnik <mrolnik@gmail.com>
Date: Mon, 3 Jun 2019 20:04:09 +0300
Message-ID: <CAK4993j5JXgV9CYDckt99kwgQaG6w-GN-Tka7r2nahoh33rheQ@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::82a
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

Got it.

Sent from my cell phone, please ignore typos

On Mon, Jun 3, 2019, 7:37 PM Richard Henderson <richard.henderson@linaro.org>
wrote:

> On 6/3/19 11:29 AM, Michael Rolnik wrote:
> > 1. There's a break
> > instruction
> https://www.microchip.com/webdoc/avrassembler/avrassembler.wb_BREAK.html
> > 2. There's a set of tests that use break.
> >
> > So I assume I have to implement this instruction as described in the
> spec.
>
> The spec talks about fuses, not gdb.  A valid implementation of this
> instruction is a no-op -- it say so right there in the spec.
>
> What does it mean to "test" break?  AFAIK, you can't test this at all from
> within the cpu itself, since it does not generate a cpu-level exception.
>
> If gdb is setting a breakpoint via -S, it should be done via
> cpu_breakpoint_test.
>
>
>
> > On Mon, Jun 3, 2019, 6:44 PM Richard Henderson <
> richard.henderson@linaro.org
> > <mailto:richard.henderson@linaro.org>> wrote:
> >
> >     On 6/1/19 4:12 PM, Michael Rolnik wrote:
> >     > Hi Richard.
> >     >
> >     > If I implement it this way
> >     >
> >     > ```
> >     >  static bool trans_BREAK(DisasContext *ctx, arg_BREAK *a)
> >     >  {
> >     >      if (avr_feature(ctx->env, AVR_FEATURE_BREAK) == false) {
> >     >          gen_helper_unsupported(cpu_env);
> >     >      } else {
> >     >          tcg_gen_movi_tl(cpu_pc, ctx->inst[0].npc);
> >     >          gen_helper_debug(cpu_env);
> >     >      }
> >     >
> >     >      ctx->bstate = BS_EXCP;
> >     >
> >     >      return true;
> >     >  }
> >     > ```
> >     >
> >     > qemu (without -s -S flags) crashes when debugger is not connected
> >
> >     I was not suggesting using the internal qemu EXCP_DEBUG, but another
> AVR
> >     specific exception, much the same way as every other cpu has a
> cpu-specific
> >     debug exception.
> >
> >     Or perhaps always do nothing.  Why is gdb insertting BREAK in the
> first place?
> >      It should be using the "hardware breakpoint" support that qemu
> advertises as
> >     part of the gdbstub protocol, and that you support here:
> >
> >     > +        if (unlikely(cpu_breakpoint_test(cs, OFFSET_CODE + cpc *
> 2, BP_ANY))
> >     > +                 || cpu_breakpoint_test(cs, OFFSET_DATA + cpc * 2,
> >     BP_ANY)) {
> >     > +            tcg_gen_movi_i32(cpu_pc, cpc);
> >     > +            gen_helper_debug(cpu_env);
> >     > +            ctx.bstate = BS_EXCP;
> >     > +            goto done_generating;
> >     > +        }
>
>
