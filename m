Return-Path: <SRS0=zt/K=T3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7118CC04AB3
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 17:48:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C44C208C3
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 17:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kbvJsjMr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C44C208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48935 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVJjf-0003f7-IX
	for qemu-devel@archiver.kernel.org; Mon, 27 May 2019 13:48:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hVJip-0003M6-C6
	for qemu-devel@nongnu.org; Mon, 27 May 2019 13:47:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hVJio-0001dS-5A
	for qemu-devel@nongnu.org; Mon, 27 May 2019 13:47:43 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:38284)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
	id 1hVJio-0001cn-1E
	for qemu-devel@nongnu.org; Mon, 27 May 2019 13:47:42 -0400
Received: by mail-ot1-x341.google.com with SMTP id s19so15463732otq.5
	for <qemu-devel@nongnu.org>; Mon, 27 May 2019 10:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=FnJfpuDK++zY2c4ERgQ3/1CVPaiA1NG6dplfrezKayc=;
	b=kbvJsjMr/rL+6K+imhNvrs2WJCi2YRrfcKyZJaS1DzcKjopibsZA1IfiLwyCRGCcPT
	nEM49Wad9JP989Q5t07qMjWhF5lYAN7A1mZv6Y2PHiFuSLV0plCuTF70+pvRs8kK3D8z
	uuj0oqmsbQ7onGxH4w6Rr4aHWPFegffLbfHizihNCLbFqpCcNAwa72HT6iY8Yf89Vd4I
	+t4z2Y2M08F4g0wkDJGXRB1PpkUR82+OnILZc9nOSASkAHIt+3VcqPGNg5va+dhEDDLB
	dCBU8BfikXNJinAk1IoFSimN2w/wGNt8azeXFpNuDzHzJJNntBnR2TMN0lhvZqC87Jj5
	auyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=FnJfpuDK++zY2c4ERgQ3/1CVPaiA1NG6dplfrezKayc=;
	b=c72FIVIW8EHcSaIU9qVitbX1MsQ2igxdFFXfJmEmYjjh4M0o/yufqtmACZHEJF5deO
	gJuybaytR0kwjbLOqMvxT0+1aQ4ovSL0bDYN+eC/oURAGYZR/qeKEHy6Qa57E11F66Nf
	CWBRLzt93smiw+TlPsbX2cNZojKcOwUhhI6k4ebJSBJB/6AqFVE/iX3l+RG7NEUv7V99
	rxJBo+SeVpk/8EN9NasMpUpZFWnJ0aR8qersLnRJOvi6oh8w3ZCeu2t+GsL55q76/W1j
	olGJzud02pb31iwlevMK1m6p4ClpOt8mSy64vf1ieHyHs8XTgSOHnzxZEY9JcGsSGgz0
	cRKg==
X-Gm-Message-State: APjAAAXFfYDSvfLPa4k8y5LHLF+KbYhMUkxQi0T4mA5KjRxHlRhItP2L
	EjbSr58zP0tQj/KJHs+2V8WFTN+RnKrgkw/51oo=
X-Google-Smtp-Source: APXvYqyVhqXmumqbpA7TfbKNQTLo+Q7yFIHV0z8glO7rwKp+TsF0QjTijyLb7fEir3mWw/H522ZmBSPLGmfaUEu8E60=
X-Received: by 2002:a9d:588b:: with SMTP id x11mr126993otg.295.1558979261054; 
	Mon, 27 May 2019 10:47:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:410f:0:0:0:0:0 with HTTP; Mon, 27 May 2019 10:47:40
	-0700 (PDT)
Received: by 2002:a9d:410f:0:0:0:0:0 with HTTP; Mon, 27 May 2019 10:47:40
	-0700 (PDT)
In-Reply-To: <87woib6h5z.wl-ysato@users.sourceforge.jp>
References: <20190523150803.31504-1-richard.henderson@linaro.org>
	<87woib6h5z.wl-ysato@users.sourceforge.jp>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 27 May 2019 19:47:40 +0200
Message-ID: <CAL1e-=htcqmvHF_sHbW+-xgfqT6FCeVE0eCr8TOfapov5VVQWA@mail.gmail.com>
To: Yoshinori Sato <ysato@users.sourceforge.jp>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::341
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH 0/6] target/rx: Improvements to disassembly
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
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On May 27, 2019 5:44 PM, "Yoshinori Sato" <ysato@users.sourceforge.jp>
wrote:
>
> On Fri, 24 May 2019 00:07:57 +0900,
> Richard Henderson wrote:
> >
> > Here's a sample of the new output, taken from u-boot.bin:
> >
> > IN:
> > 0xfff8000a:  fb 12 00 01 00 00          mov.l   #0x00000100, r1
> > 0xfff80010:  fb 32 f0 13 00 00          mov.l   #0x000013f0, r3
> > 0xfff80016:  43 13                      sub     r1, r3
> > 0xfff80018:  fb 22 00 ea f9 ff          mov.l   #-398848, r2
> > 0xfff8001e:  7f 8f                      smovf
> > 0xfff80020:  ef 01                      mov.l   r0, r1
> > 0xfff80022:  05 1e 32 00                bsr.a   fff83240
> >
> > IN:
> > 0xfff83240:  72 11 5c fb                add     #-1188, r1
> > 0xfff83244:  75 21 f0                   and     #-16, r1
> > 0xfff83247:  02                         rts
> >
> > Obviously there are still a few inconsistencies in the
> > format strings used for the immediates, but the format
> > is readable and it is easy to look at the opcode to see
> > how our decode compares to the manual.
> >
>
> Hmm.
> The output of the immediate value should be the same as the output of
objdump.
> I do not think that it is the proper format, but I did that because
> it was useful for comparing the results.
>

We in MIPS also use objdump output as the reference and desired output for
QEMU disassembler (not that we are always succeeding in doing that)

Inventing propriatery QEMU output for some instructions is in my view
counterproductive and confusing.

Sincerely,
Aleksandar

> >
> > r~
> >
> >
> > Richard Henderson (6):
> >   target/rx: Disassemble rx_index_addr into a string
> >   target/rx: Replace operand with prt_ldmi in disassembler
> >   target/rx: Use prt_ldmi for XCHG_mr disassembly
> >   target/rx: Emit all disassembly in one prt()
> >   target/rx: Collect all bytes during disassembly
> >   target/rx: Dump bytes for each insn during disassembly
> >
> >  target/rx/disas.c | 366 +++++++++++++++++++++-------------------------
> >  1 file changed, 166 insertions(+), 200 deletions(-)
> >
> > --
> > 2.17.1
> >
>
> --
> Yosinori Sato
>
