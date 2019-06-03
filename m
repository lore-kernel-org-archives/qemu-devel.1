Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F27CCC04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 20:15:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDE5A26CE0
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 20:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KgYGZOZm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDE5A26CE0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40360 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXtMc-0004pJ-UB
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 16:15:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mrolnik@gmail.com>) id 1hXtLq-0004S3-NQ
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 16:14:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mrolnik@gmail.com>) id 1hXtLp-0004Vb-Hy
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 16:14:38 -0400
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:44483)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1hXtLp-0004Tb-CQ
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 16:14:37 -0400
Received: by mail-qt1-x842.google.com with SMTP id x47so10995276qtk.11
	for <qemu-devel@nongnu.org>; Mon, 03 Jun 2019 13:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=7xlfSkjM9Vrx3/KcN7c7SUxUDFw+s50Xht8zDa712GM=;
	b=KgYGZOZmNk+PxMUijYvYHtQ8+jIcA2lfwgb0FtBPvgT49z1UaASylB5JFQOYdzNFun
	23Dw3jC2oP97V+lS/J78Nx5YQj5Tfi1WOp/0jPUPYYEFFDDT3eU7N6sSLrqMDGVXY+P7
	LKf9iKRyhKUSq7fXgra6WrbIA40N3rVk78rAsImtPdI1fyupJZxWsL8mOwaqfkAiNOPZ
	jSTDRQ/RTEu4k1s3S3vd4EL4DLJri+GH0/opAQ5qO0U25kJzOiURPFaDQPvspaK7dCTP
	b7OAh6OZ1xVeGT+634GYz2rAXZCbJYJdiYpekZWjMnNbsb913fUELHh07nZvqxzQNlOq
	sX0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=7xlfSkjM9Vrx3/KcN7c7SUxUDFw+s50Xht8zDa712GM=;
	b=ZJQqRdrDBGkgeYCxYfVCQ/eBYTBPLetu8DMJ0tUoA+I0KZA61yPxhdDqaB3uDKlhmf
	KHcDbPOymavC6v5//6LxvYEbUt99Ozgvn6SphnHU40d9afyjURQIpTGGCWvIKfvo4mDI
	8cZ0nJaOIS7KLO4N5Tsodby17zyHNJlgb64T5l+f24I3YO+iQafyV97J5I5rrgDBVhxJ
	bpYqHVa8Gtz/4bc0AsMTxlDwfXUKBurbMM49yECJOvKZNa2t3HLWt5gTFgrw93cqavz4
	31ttJRnzTzvZiqwIcmoLNYe70HUlZHDJ62ffVy/Ou647THktZrCsW4BUSFdsCIk1IEqC
	hquw==
X-Gm-Message-State: APjAAAV+rKl7KKYK3F7eOcrzr9KJ6G/JumNWGf7LyifdqFokNCDFiDA6
	jUPBIHcRWDUD1zXzrf1pbi1TjG4tBA3u6i5c1eA=
X-Google-Smtp-Source: APXvYqwiFDD0Iaava/bzUbbR30s+hRTTJyaf02rdKmjU+qepgTPvK+xYq+70pwM3dqIgsCv3w+tIrjOX8GsdwZstYjI=
X-Received: by 2002:ac8:5315:: with SMTP id t21mr15068938qtn.229.1559592876083;
	Mon, 03 Jun 2019 13:14:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190530190738.22713-1-mrolnik@gmail.com>
	<20190530190738.22713-5-mrolnik@gmail.com>
	<17b55a6e-af48-861d-6c2c-20bab1e45155@linaro.org>
In-Reply-To: <17b55a6e-af48-861d-6c2c-20bab1e45155@linaro.org>
From: Michael Rolnik <mrolnik@gmail.com>
Date: Mon, 3 Jun 2019 23:13:59 +0300
Message-ID: <CAK4993i6gM4v_dmOUbhHZOpDxXxKTueqRd-6COVk+z5U7VXK6w@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::842
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH RFC v20 4/8] target-avr: Add instruction
 decoding
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Richard,
I don't understand what I should do. Do you want me to merge decode files?

On Fri, May 31, 2019 at 5:45 PM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 5/30/19 2:07 PM, Michael Rolnik wrote:
> > This includes:
> > - encoding of all 16 bit instructions
> > - encoding of all 32 bit instructions
> >
> > Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
> > ---
> >  target/avr/insn16.decode | 160 +++++++++++++++++++++++++++++++++++++++
> >  target/avr/insn32.decode |  10 +++
> >  2 files changed, 170 insertions(+)
> >  create mode 100644 target/avr/insn16.decode
> >  create mode 100644 target/avr/insn32.decode
>
> Two things:
>
> (1) decodetree can handle variable-width ISA now.
>
> It's slightly ugly in that the %field numbering is little-endian and thus
> varies for each insn size.  But the in-flight patch set for target/rx shows
> that it works.
>
> That said, I don't think you need that because,
>
> (2) The four instructions that are 32-bits do not have
>     any opcode bits in the second 16-bits.
>
> E.g.
>
> # The 22-bit immediate is partially in the opcode word,
> # and partially in the next.  Use append_16 to build the
> # complete 22-bit value.
> %imm_call       4:5 0:1                 !function=append_16
> CALL            1001 010. .... 111.     imm=%imm_call
> JMP             1001 010. .... 110.     imm=%imm_call
>
> # The 16-bit immediate is completely in the next word.
> # Fields cannot be defined with no bits, so we cannot play
> # the same trick and append to a zero-bit value.
> # Defer reading the immediate until trans_{LDS,STS}.
> @ldst_s         .... ... rd:5 ....      imm=0
> LDS             1001 000 ..... 0000     @ldst_s
> STS             1001 001 ..... 0000     @ldst_s
>
>
> static uint16_t next_word(DisasContext *ctx)
> {
>     return cpu_lduw_code(ctx->env, ctx->npc++ * 2);
> }
>
> static int append_16(DisasContext *ctx, int x)
> {
>     return x << 16 | next_word(ctx);
> }
>
> static bool trans_LDS(DisasContext *ctx, arg_ldst_s *a)
> {
>     a->imm = next_word(ctx);
>     // other stuff
> }
>
> I realize that next_word as written does not fit in to how you currently
> process instructions in the loop, but I also think that's a mistake.  I'll
> respond to that in its place in the next patch.
>
> That said, next_word *could* be written to use ctx->inst[0].opcode.
>
>
> r~
>


-- 
Best Regards,
Michael Rolnik
