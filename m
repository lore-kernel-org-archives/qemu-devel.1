Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D39A5C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 17:32:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97E27208B8
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 17:32:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BctRJGFs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97E27208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlyOu-00088h-Uq
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 13:32:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40096)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlyNv-00076Y-7n
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 13:31:31 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:36087)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlyNs-000658-RH
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 13:31:30 -0400
Received: by mail-oi1-x242.google.com with SMTP id a137so5821702oii.3
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 10:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=RYo/8dEkQPbznU3Hgsd/Q+vVlaDQBNLUYuA7Gg5b94o=;
 b=BctRJGFsemWIdjZOarhzxgAQNoZ56ipMhjy0chZV7rJykt1ISVj6oPbk2HiKIKhb3P
 KUUwIJjdbr6G52UGdmqdgZroszUa6q3liPQIDa6Obb6ij2Ta6/g9mTQKZvbxVkD0KevP
 xshQzoMT4hFj+D6UN4Dmg8JpRoVVaYO9soi9IGaEdlCEXaR/pfe6slX7Xxv1wUiQ3M5l
 awqPwVt09vgYvTzaX1ZTaKMV6CACT4KooqR93sbijCCjZM7eU4oi6hx603Zmqd62WHR+
 rwGfcXfxGvSDlonm2SBlGrwtlmu1qhGEo0spBBMw985eARCEMFBsEI46c+ImAUykxr7u
 QznQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RYo/8dEkQPbznU3Hgsd/Q+vVlaDQBNLUYuA7Gg5b94o=;
 b=h1qM99rZ+pwkSvqPG12XaEoiTZfhzv3ZjQ598tFUYEu5tmnNhE8EAEO48Z7CqGGInc
 nt0SugaJH2L2Y4sufnGvBA9YuBryxy4NKRxOVdDvDgcSIvu2RldlSuoToKMZ+6eTkXFB
 Nuln6vKeLxehT2D4ZnY3MrXu1H49GJPLgIazpF4zcicY0b5/YY5C++Hpk4EypRpioyLg
 x82Nl60J62vdyjeTJ8S0SzbAe3VCvJO33mkGoazVM3wg/CYQ4ZClQs5ct5FeUeTxDF9T
 c9htEXNDWG+b0aMl2HpsfAf0vV2DBztiCc1PSb2SHg6y/vhfZOITX8zKqxkXnHrjTBZZ
 Mang==
X-Gm-Message-State: AOAM530gIe5N+lQ3IsXufagEyv4PeSpW8Q+BL0EDbm9IA2XIFCviSZfx
 3LU1DYXdd2TXHKjw7OUrT/qpM130hl1ctOHIZvN2Yg==
X-Google-Smtp-Source: ABdhPJxjogvK7Xqv7n/JQlHZVniXRZtSqVeee/nHU76UYb7t7+qdfkUZ+stKmPitV5/41knz4YR9222cPeVWTsWQ5Kc=
X-Received: by 2002:aca:568c:: with SMTP id k134mr3713036oib.48.1592501487423; 
 Thu, 18 Jun 2020 10:31:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200618114129.5636-1-wentong.wu@intel.com>
In-Reply-To: <20200618114129.5636-1-wentong.wu@intel.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Jun 2020 18:31:16 +0100
Message-ID: <CAFEAcA9-HH44cXohDGAVeidN48n8LgDEkhbnmcnqKVTsEN=hOg@mail.gmail.com>
Subject: Re: [PATCH] target/nios2: Use gen_io_start/end around wrctl
 instruction.
To: wentongw <wentong.wu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::242;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x242.google.com
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

On Thu, 18 Jun 2020 at 04:50, wentongw <wentong.wu@intel.com> wrote:
>
> From: Wentong Wu <wentong.wu@intel.com>
>
> wrctl instruction on nios2 target will cause checking cpu interrupt,
> but tcg_handle_interrupt() will call cpu_abort() if the CPU gets an
> interrupt while it's not in a 'can do IO' state, so around wrctl
> instruction add gen_io_start/end.
>
> Signed-off-by: Wentong Wu <wentong.wu@intel.com>
> ---
>  target/nios2/translate.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/target/nios2/translate.c b/target/nios2/translate.c
> index e17656e6..deaefcaf 100644
> --- a/target/nios2/translate.c
> +++ b/target/nios2/translate.c
> @@ -32,6 +32,7 @@
>  #include "exec/cpu_ldst.h"
>  #include "exec/translator.h"
>  #include "qemu/qemu-print.h"
> +#include "exec/gen-icount.h"
>
>  /* is_jmp field values */
>  #define DISAS_JUMP    DISAS_TARGET_0 /* only pc was modified dynamically */
> @@ -518,7 +519,13 @@ static void wrctl(DisasContext *dc, uint32_t code, uint32_t flags)
>      /* If interrupts were enabled using WRCTL, trigger them. */
>  #if !defined(CONFIG_USER_ONLY)
>      if ((instr.imm5 + CR_BASE) == CR_STATUS) {
> +        if (tb_cflags(dc->tb) & CF_USE_ICOUNT) {
> +            gen_io_start();
> +        }
>          gen_helper_check_interrupts(dc->cpu_env);
> +        if (tb_cflags(dc->tb) & CF_USE_ICOUNT) {
> +            gen_io_end();
> +        }

You also need to end the TB, which we should do whether
we're using icount or not. This is awkward because nios2 has
not correctly implemented the DISAS_UPDATE that is the right
way to do that. So you'll need some preliminary patches:

Patch 1: Implement and use DISAS_NORETURN
 + the current places in t_gen_helper_raise_exception() and
   gen_exception() that set dc->is_jmp = DISAS_UPDATE
   should instead set it to DISAS_NORETURN. (This is because
   they both call gen_helper_raise_exception() and at runtime
   execution will never return from that helper call.)
 + In gen_intermediate_code(), in the "switch (dc->is_jmp)"
   you need a new "case DISAS_NORETURN:" which goes with
   DISAS_TB_JUMP as another kind of "nothing more to generate".

Patch 2: Make DISAS_UPDATE write PC back to CPU state
 + Move the "case DISAS_UPDATE:" from being like DISAS_JUMP
   up so it does the same thing as DISAS_NEXT (ie explicitly
   writes the PC back into the cpu state before doing a
   tcg_gen_exit_tb()). This is OK because patch 1 removed
   the only two previous users of it, so we don't break
   anything by bringing its semantics into line with how
   most targets use it.

Patch 3: this patch to use gen_io_start/end
 + You can now put "dc->is_jmp = DISAS_UPDATE;" inside the
   "is this a CR_STATUS write" if() block, which should
   cause the wrctl to always end the TB.

thanks
-- PMM

