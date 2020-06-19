Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B07C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 12:42:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FB57207E8
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 12:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O/zdCdgS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FB57207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmGLw-0003KD-Ds
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 08:42:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36006)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jmGKf-0002Eh-4O
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 08:41:21 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:39571)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jmGKc-0005P6-KU
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 08:41:20 -0400
Received: by mail-ot1-x342.google.com with SMTP id g5so7149921otg.6
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2020 05:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8FgOloYroh81hNXQQf34Zmg1+3Jofiehb+dLqymRoUY=;
 b=O/zdCdgSLJt7ZNMitSI02DaND9GeqR7Q3ZuusmJVSY2VFbx4e8fVPdd9Di6FjNJlbj
 HFfTn7ZSsa7PnVwzwhZuLGgCYTSK8/D7ATYIxhQx6ohHbJQGf7sDI6OCtuyKLf/FQJSo
 93zrlQiTrJn5fcSB7KLOIYqZ6zQQg/BNyw7YnJDWt1CDprQa+ceLrrup6J52w+4cQQ1x
 1NUna8eSbBfdWvN7gk6vpNQH+rLUDiLPJT+YYpaTCMr70X3Dpn1s7YwYJSRl/dKTtTU2
 BsJLtlYSDo6ZCtmHzUsQw5YvC20MhVFdj0pO1Bb2LEjFqp/veBB63seYy/19pOd4d7Y9
 Uzow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8FgOloYroh81hNXQQf34Zmg1+3Jofiehb+dLqymRoUY=;
 b=n7CCJgf5R1g0k2yFXoGAYxkqCLlxgDcjMt6fW/QQo0sqn0DJrnynKLDMtdUCuJvrMo
 DyUo0A2Dh0879A1lJdR07jMiLKzCavdXtuKX+oJZrtkzJMCYH47EFtdUp0yZVBuWVXvL
 03AMEfPGloP/JG5iFpWQIEyijvXKp3rBunfJcSpuOZrK1yuGN/p9nPm+AmL59w+jFRcz
 EyGV4YfVK6sXpqcxLOTV+pH0lovmloMfp77n2sjeNVg9Ob9o5adWqoEGC+k3M/iEV6tX
 2DiTwnoh9ceNVkexV5IAeN/JgsCOknx42fyS4IJ1Kkb94Enmp7ae1xpOEhN3c5koGeY1
 f65A==
X-Gm-Message-State: AOAM533bL3dN2/LEw5dKX9gavX9EuN3uw6X7LVoCjzYdNTvqxQ5m6Z+Y
 cFtDBClVrShNRuwcnepJm5efGDo24Vi5phmsHkwvxw==
X-Google-Smtp-Source: ABdhPJyfNUeY8MWsrQVmvWsMzjHZGnOSRvocsxg6bndRuz3PJ2+PuvbQPN51tjl147eA5bGPdtW64Y5NlYF4uUaPPwE=
X-Received: by 2002:a05:6830:8d:: with SMTP id
 a13mr2787032oto.91.1592570477338; 
 Fri, 19 Jun 2020 05:41:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200618114129.5636-1-wentong.wu@intel.com>
 <CAFEAcA9-HH44cXohDGAVeidN48n8LgDEkhbnmcnqKVTsEN=hOg@mail.gmail.com>
In-Reply-To: <CAFEAcA9-HH44cXohDGAVeidN48n8LgDEkhbnmcnqKVTsEN=hOg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Jun 2020 13:41:06 +0100
Message-ID: <CAFEAcA_FQy+hMkGf-gkgm=AEBk3HS1R0WT0maQ83fHw6M0WPRw@mail.gmail.com>
Subject: Re: [PATCH] target/nios2: Use gen_io_start/end around wrctl
 instruction.
To: wentongw <wentong.wu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Marek Vasut <marex@denx.de>,
 Chris Wulff <crwulff@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 18 Jun 2020 at 18:31, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Thu, 18 Jun 2020 at 04:50, wentongw <wentong.wu@intel.com> wrote:
> >
> > From: Wentong Wu <wentong.wu@intel.com>
> >
> > wrctl instruction on nios2 target will cause checking cpu interrupt,
> > but tcg_handle_interrupt() will call cpu_abort() if the CPU gets an
> > interrupt while it's not in a 'can do IO' state, so around wrctl
> > instruction add gen_io_start/end.
> >
> > Signed-off-by: Wentong Wu <wentong.wu@intel.com>
> > ---
> >  target/nios2/translate.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/target/nios2/translate.c b/target/nios2/translate.c
> > index e17656e6..deaefcaf 100644
> > --- a/target/nios2/translate.c
> > +++ b/target/nios2/translate.c
> > @@ -32,6 +32,7 @@
> >  #include "exec/cpu_ldst.h"
> >  #include "exec/translator.h"
> >  #include "qemu/qemu-print.h"
> > +#include "exec/gen-icount.h"
> >
> >  /* is_jmp field values */
> >  #define DISAS_JUMP    DISAS_TARGET_0 /* only pc was modified dynamically */
> > @@ -518,7 +519,13 @@ static void wrctl(DisasContext *dc, uint32_t code, uint32_t flags)
> >      /* If interrupts were enabled using WRCTL, trigger them. */
> >  #if !defined(CONFIG_USER_ONLY)
> >      if ((instr.imm5 + CR_BASE) == CR_STATUS) {
> > +        if (tb_cflags(dc->tb) & CF_USE_ICOUNT) {
> > +            gen_io_start();
> > +        }
> >          gen_helper_check_interrupts(dc->cpu_env);
> > +        if (tb_cflags(dc->tb) & CF_USE_ICOUNT) {
> > +            gen_io_end();
> > +        }
>
> You also need to end the TB, which we should do whether
> we're using icount or not. This is awkward because nios2 has
> not correctly implemented the DISAS_UPDATE that is the right
> way to do that.

After some further discussion with other maintainers abotu
the gen_io_start/gen_io_end semantics, it turns out that
I was wrong about the need for gen_io_end -- if you are
going to end the TB after the I/O instruction (which you are
in this case) then you do not need the gen_io_end() call,
it is handled automatically for you by common code. So
you can drop that bit from the next version of this patch.

Sorry for the confusion.

thanks
-- PMM

