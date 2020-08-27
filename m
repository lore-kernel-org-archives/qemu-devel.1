Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 882F3C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 10:09:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53373207F7
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 10:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s1sQ2k6J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53373207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBEqh-00081h-Gy
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 06:09:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38736)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1kBEpl-00074d-MR
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 06:08:41 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:34717)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1kBEph-0000ck-7W
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 06:08:41 -0400
Received: by mail-lf1-x141.google.com with SMTP id d2so2612568lfj.1
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 03:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=ptOYtMy0gK7P0avq5N/LI+cM9H0OymG6o1WhyCnKA/g=;
 b=s1sQ2k6JmlsupsfLQveA0JtrM29Q5ao0jA04JbsE40IoRQjTkczMOXpjsxvzTrvZfg
 AZ7H4wMS53n7r81urqp+1GvsH4R8wZGjnaQHWEKT3XUBqucEEqx/sF0ZnlvGh+0PthML
 Pp4NeBfTrEWSCi8EpM1NEqFd+LJlgxGgVTuppC4DVvKpaUOfw2hxoboLds1VRzyTzd0k
 +E0TdvN1JM7ogD4L1/tTcH6wT23XROfumTRTyZcUXo3HKAmSfmUY2xUK4bWQ2hl2uKs+
 D1bhcXn7oHTMIC+JKG46ks2pIIzhRQqZ9d3MDz41h2YFpxcRcChFMMlGDBagHCz9nWHX
 FuMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ptOYtMy0gK7P0avq5N/LI+cM9H0OymG6o1WhyCnKA/g=;
 b=rhV2vFB4nrtjvLi2XQ340FD6wYp6MCR2M/Gt/28ytlY6+FjuNWUkWPASnFpgG8pEZh
 COOwMCB6ojMirutFx09ixssTWDM3Lba/ksEdllbCYVxS5En04TTYOG0Pvak08eZHa1+W
 ZVc592HFc2KUyx7Koi4CqKA6BUBGWUQ8nARZMYuF64zwqGen4716MYbyBFR52s3k/ZXS
 g3+3vXj4Ff5Jc80a98vh1BZCg3fJPblfYujs7waRiWxa9hnSCmLZBklRkpJPNt4w0JRr
 ev2usfumNahey2r3s8r3Wc3OQP8hZaC691ESReDU1z0zIdaQWN+kyYsGCHdiT0iaDRTM
 hGvA==
X-Gm-Message-State: AOAM5312jAnul1DA5V4uJphLVsqFTYPai6ehT8UwlR3hmpLK8biAZaZu
 UDFIfDTFv+JfQuJXt5E9hG8=
X-Google-Smtp-Source: ABdhPJzkgOQyAFizjs0U6Gg1K1mqScWe9AP9FekrOx3lEc0QPl+XmZbxY+ecoNohexg4dgAr1BgQLw==
X-Received: by 2002:ac2:58c6:: with SMTP id u6mr9556062lfo.105.1598522915436; 
 Thu, 27 Aug 2020 03:08:35 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id n24sm368923lji.83.2020.08.27.03.08.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2020 03:08:34 -0700 (PDT)
Date: Thu, 27 Aug 2020 12:08:34 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 64/77] target/microblaze: Convert mbar to decodetree
Message-ID: <20200827100834.GM2954729@toto>
References: <20200825205950.730499-1-richard.henderson@linaro.org>
 <20200825205950.730499-65-richard.henderson@linaro.org>
 <20200827092413.GL2954729@toto>
 <7e242b2a-d582-059c-f282-9e001653b627@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e242b2a-d582-059c-f282-9e001653b627@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::141;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x141.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FSL_HELO_FAKE=3.066, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 27, 2020 at 02:58:06AM -0700, Richard Henderson wrote:
> On 8/27/20 2:24 AM, Edgar E. Iglesias wrote:
> >> +    /*
> >> +     * Instruction access memory barrier.
> >> +     * End the TB so that we recognize self-modified code immediately.
> >> +     */
> >> +    if (mbar_imm & 1) {
> >> +        dc->cpustate_changed = 1;
> >> +    }
> > 
> > This should be (mbar_imm & 1) == 0
> > But even with that fixed it fails some of our tests because interrupts
> > that should become visible within a couple of cycles after a
> > memory data barrier can now be delayed longer.
> > 
> > I think we should always break the TB.
> 
> Ok.  I assume this follows a write to something like an interrupt controller
> register?

yes, kind of. It's a memory store to a device that raises an interrupt as a
result of that store. The interrupt propagates to the CPU and on real HW if
the pipeline depth of the core is small, it gets taken within a couple of
cycles after the barrier completes. In QEMU, that delay can become very long
if we don't break the TB.

Architecturally, it would be wrong to make such assumptions about the pipeline
but there's code out there already..



> 
> > 
> >> +    /* Data access memory barrier.  */
> >> +    if (mbar_imm & 2) {
> >> +        tcg_gen_mb(TCG_BAR_SC | TCG_MO_ALL);
> >> +    }
> > 
> > This should be (mbar_imm & 2) == 0
> 
> Oops.  ;-)
> 
> Applying the following incremental patch.

Thanks! With your incremental patch:

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>



> 
> 
> r~
> 
> 
> diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
> index a391e80fb9..1e2bb529ac 100644
> --- a/target/microblaze/translate.c
> +++ b/target/microblaze/translate.c
> @@ -1170,16 +1170,8 @@ static bool trans_mbar(DisasContext *dc, arg_mbar *arg)
>  {
>      int mbar_imm = arg->imm;
> 
> -    /*
> -     * Instruction access memory barrier.
> -     * End the TB so that we recognize self-modified code immediately.
> -     */
> -    if (mbar_imm & 1) {
> -        dc->cpustate_changed = 1;
> -    }
> -
>      /* Data access memory barrier.  */
> -    if (mbar_imm & 2) {
> +    if ((mbar_imm & 2) == 0) {
>          tcg_gen_mb(TCG_BAR_SC | TCG_MO_ALL);
>      }
> 
> @@ -1204,6 +1196,19 @@ static bool trans_mbar(DisasContext *dc, arg_mbar *arg)
> 
>          gen_raise_exception(dc, EXCP_HLT);
>      }
> +
> +    /*
> +     * If !(mbar_imm & 1), this is an instruction access memory barrier
> +     * and we need to end the TB so that we recognize self-modified
> +     * code immediately.
> +     *
> +     * However, there are some data mbars that need the TB break
> +     * (and return to main loop) to recognize interrupts right away.
> +     * E.g. recognizing a change to an interrupt controller register.
> +     *
> +     * Therefore, choose to end the TB always.
> +     */
> +    dc->cpustate_changed = 1;
>      return true;
>  }
> 

