Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13459C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 17:31:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D420D207FF
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 17:31:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JDsbod88"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D420D207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDu5U-0005Ew-3a
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 13:31:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55898)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iDu27-00035V-Tz
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 13:27:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iDu26-0006yR-HP
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 13:27:55 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:37974)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iDu26-0006xF-AG; Fri, 27 Sep 2019 13:27:54 -0400
Received: by mail-lj1-x241.google.com with SMTP id b20so3272980ljj.5;
 Fri, 27 Sep 2019 10:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=IfJzy4terBGPP4bGKhDOLeEhWY8WGZfQa1k269F/Qrg=;
 b=JDsbod88Crk5LQPX4x6Ptn4G632nabUk2tPlPfalQb2N+++57kDwOgYbESsFF7k+ra
 DPNmYALl0slm+A9tGmDEdpI4nK1ArninINzF6Jfg3LNN22r0dcjiFnY7K3uOqGidLQ6w
 npANfmOxBUzGZbmTEqLd5QIB5HSBQDVdIqb5IwHbgpwsJJBi+cjUFnIDHlRzAQsOJkIF
 ZlrdgbZJ3jMk+JOBwdnYpIpN9TGi82g/XWysOSTIUFz8a01j8Oid+6J3FR7QhEyu5BRw
 B8WB9t+v/Q8V5jN8t3ZYBxxTJJZacVAnh3VYiuaAVULoXHSnIlexYPJ8ELzzWbNazlxK
 L2hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IfJzy4terBGPP4bGKhDOLeEhWY8WGZfQa1k269F/Qrg=;
 b=JACq39eo7jTjK6so9tJtat2RtGy5JE+eDNtj5wM4EceW/YKWGazIGNPApb/ALyOmSC
 zHWMBjMcQPbioSzbD12w001a4HcGdX1RtIW9rGkXZYY5gNWIfQKRJBq4ADzxEWlkmTSM
 gcpRfX0SDtajwVhj7a6J/7EawIq4J6hrgCabZgrrnS8NbFd1XFfrX1+yPfPzfExZY8oB
 34OoU0HCf4hfOIVuUaO1VijmwdvwMopVqGJ4hQbI5sIpCAjhqhHVEujynTl8zDUe0Vat
 t0pS9yHo+0LqSRjCXYNw/jfa3KjoUZ2/VSvfcZw1G4qJ8m93/vmlIRpluvnITWE0Pq1c
 JNsA==
X-Gm-Message-State: APjAAAVZn3GAtJQBUpYsJhcbziHAbBY7I9GXlDSYRFzWcn9EvJZ1/NHl
 YouqxgcePNbX3xlj2ZU5wFVbCllAyranvE3PoWY=
X-Google-Smtp-Source: APXvYqyESdFzyiszcyAvTXZckAayxMr6m1ldKkURIYDynORRu+ze/7iZJ9jeZ0xS1fvdHD823oZRNSJTxbloa5Ra3fM=
X-Received: by 2002:a2e:90d9:: with SMTP id o25mr395611ljg.94.1569605272888;
 Fri, 27 Sep 2019 10:27:52 -0700 (PDT)
MIME-Version: 1.0
References: <ab8f108eceb973aaee565bb1fe347fcf8c788f5b.1569545120.git.alistair.francis@wdc.com>
 <960d9622-8241-efe7-cee6-1d4a1307fbc0@linaro.org>
In-Reply-To: <960d9622-8241-efe7-cee6-1d4a1307fbc0@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 27 Sep 2019 10:23:06 -0700
Message-ID: <CAKmqyKP90UDcS4moAYvLVN2q+aZ_cqGwY2fEgfX8dCjsHW1Tfg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] target/riscv: Print CPU and privledge in disas
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::241
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Palmer Dabbelt <palmer@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 27, 2019 at 10:18 AM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 9/26/19 5:45 PM, Alistair Francis wrote:
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >  target/riscv/translate.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> > index adeddb85f6..537af0003e 100644
> > --- a/target/riscv/translate.c
> > +++ b/target/riscv/translate.c
> > @@ -810,7 +810,14 @@ static void riscv_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
> >
> >  static void riscv_tr_disas_log(const DisasContextBase *dcbase, CPUState *cpu)
> >  {
> > +#ifndef CONFIG_USER_ONLY
> > +    RISCVCPU *rvcpu = RISCV_CPU(cpu);
> > +    CPURISCVState *env = &rvcpu->env;
> > +#endif
> >      qemu_log("IN: %s\n", lookup_symbol(dcbase->pc_first));
> > +#ifndef CONFIG_USER_ONLY
> > +    qemu_log("CPU: %d; priv: "TARGET_FMT_ld"\n", cpu->cpu_index, env->priv);
> > +#endif
> >      log_target_disas(cpu, dcbase->pc_first, dcbase->tb->size);
> >  }
>
> I'm curious about the motivation here.
>
> In particular, what difference does it make what cpu the TB is generated for?
> It would seem like the more relevant place to look for this is with -d cpu or
> -d exec where the TB is actually executed, which could well be multiple cpus.

The main reason is that the sifive_u machine now has two RISC-V
clusters so it's useful to see what is happening on each CPU. -d cpu
and -d exec are much more difficult to comprehend so aren't always as
useful.

>
> As for env->priv... is there really anything in the input assembly that depends
> on the privilege?  Or conversely, why priv and not all of the other bits that
> are in tb_flags?  And are you placing that here in -d in_asm because are always
> also using either -d op or -d op_opt, and it somehow looks better to have this
> at the top?

I think it's just clearer to see what privileged mode the instructions
were generated for, it helps with debugging boot issues. Again it
comes back to the other options being difficult to comprehend, in_asm
I find is the clearest to understand (although it has lots of
limitations).

Alistair

>
>
> r~

