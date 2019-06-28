Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C22ADC4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 17:32:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AF11208C4
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 17:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="diDOgfhG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AF11208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgujN-0007Ap-Mm
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 13:32:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41706)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hgtoD-0006NB-Dl
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 12:33:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hgtoC-0002q5-6D
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 12:33:09 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:41795)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hgtoB-0002pG-Tm
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 12:33:08 -0400
Received: by mail-wr1-x442.google.com with SMTP id c2so6935262wrm.8
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2019 09:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=DV5eM2hZO7loL7XyJ1Uje8aQ8PQRysH709GS9FjiqY4=;
 b=diDOgfhGqyPiZKBW89H/nrihEb3Tyt/3v5fk7WWI4snXItCvxNyjFWyj2uIh6ZDKkZ
 /N7Ml8xi4IYysXtXIOfCODWhev2FmBZ4fzSDqi0t9XdOwI+ou9+EvBKfwd8cwNiB6n9g
 D4veP7zccqv2cpcJVfUYeMgyHdy67BseogVBIH6uKiU32dUjpR3yyYZtB20Yo1/KUB3n
 29O5lM/+R5RhLMCEqJ24IO9xDlYPNbr5fxOtturVtWHOJGNEipUAJxC9VCySKSMYHORP
 3i1NLjYuK/dAdyHvVrULXn4LqMIjH91V4d4TvYe1xwhcwPlRAhZUhnKo9u+90NovJAzv
 syxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=DV5eM2hZO7loL7XyJ1Uje8aQ8PQRysH709GS9FjiqY4=;
 b=GIDaw2oWErNWyTnGTFw+Hcys34VQBaY8tM0nrMiyjaFOtvnzeC/WiGwVE20YuDzjbe
 vRm8zgFCkIFLECfj7bcMnmy26t+gyjy6TK9yX6pZI7snXXoYhdMHUH57xWt2G6i3dSAL
 qm0wETATcCpPohbg2JNJwbfmfwiSJd5nttuujpa5NN6bqbXWBeOU0Qms6gedB8YOPZdF
 5L1/mDXVxTq5xKtsOpMFarrErHAt9J+5EUcFsJke3o52/oDFXuX8W2TJNVj+ZIpgOVwY
 Ytr314RD4MiEQ/voZpfftnIucnIOUOmZA0+wyKXNBGL9TTwx1aTZcVoQwfvJxDBw/uEX
 cx6w==
X-Gm-Message-State: APjAAAU6OPfVz0A4plgW8mBkHU4Ngi5zsndgBcOFtcfeWZEihCF4iAjy
 /kQ5u4Ni/nhlTUQGv0yxELNdtw==
X-Google-Smtp-Source: APXvYqwtlsuG1ptrWttEZvTCIAYZVQ4PLaBVFLeiuMBgcKy8BaKIi5EhntBWxD0OEV2oRBHcqxerWQ==
X-Received: by 2002:adf:ebc3:: with SMTP id v3mr3664146wrn.61.1561739586334;
 Fri, 28 Jun 2019 09:33:06 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id 5sm2991613wmg.42.2019.06.28.09.33.05
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 28 Jun 2019 09:33:05 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 691E81FF87;
 Fri, 28 Jun 2019 17:33:05 +0100 (BST)
References: <20190628113917.15869-1-luc.michel@greensocs.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190628113917.15869-1-luc.michel@greensocs.com>
Date: Fri, 28 Jun 2019 17:33:05 +0100
Message-ID: <87o92hacvy.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [RFC PATCH] accel/tcg/translator: add tb_enter TCG
 trace
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
Cc: damien.hedde@greensocs.com, mark.burton@greensocs.com, sakisp@xilinx.com,
 edgari@xilinx.com, Paolo Bonzini <pbonzini@redhat.com>,
 Luc Michel <luc.michel@greensocs.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Luc Michel <luc.michel@greensocs.com> writes:

> Add a TCG trace at the begining of a translation block recording the
> first and last (past-the-end) PC values.
>
> Signed-off-by: Luc Michel <luc.michel@greensocs.com>
> ---
> This can be used to trace the execution of the guest quite efficiently.
> It will report each time a TB is entered (using the tb_enter_exec
> trace). The traces arguments give the PC start and past-the-end values.
> It has very little to no performance impact since the trace is actually
> emitted in the generated code only when it is enabled at run time.
>
> It works already quite well on its own to trace guest execution.

You could just remove the disable from:

disable exec_tb(void *tb, uintptr_t pc) "tb:%p pc=3D0x%"PRIxPTR

And call qemu with -d nochain,trace:exec_tb

> However
> it does not handle the case where a TB is exited in the middle of
> execution. I'm not sure how to properly trace that. A trace could be
> added when `cpu_loop_exit()' is called to report the current PC, but in
> most cases the interesting value (the PC of the instruction that
> caused the exit) is already lost at this stage.
>
> I'm not sure there is a generic (i.e. not target specific) way of
> recovering the last PC executed when cpu_loop_exit() is called. Do you
> think of a better way?
>
> Thanks to the Xilinx's QEMU team who sponsored this work.
> ---
>  accel/tcg/translator.c | 24 ++++++++++++++++++++++++
>  trace-events           |  3 +++
>  2 files changed, 27 insertions(+)
>
> diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
> index 9226a348a3..c55377aa18 100644
> --- a/accel/tcg/translator.c
> +++ b/accel/tcg/translator.c
> @@ -14,10 +14,11 @@
>  #include "tcg/tcg-op.h"
>  #include "exec/exec-all.h"
>  #include "exec/gen-icount.h"
>  #include "exec/log.h"
>  #include "exec/translator.h"
> +#include "trace-tcg.h"
>
>  /* Pairs with tcg_clear_temp_count.
>     To be called by #TranslatorOps.{translate_insn,tb_stop} if
>     (1) the target is sufficiently clean to support reporting,
>     (2) as and when all temporaries are known to be consumed.
> @@ -28,14 +29,31 @@ void translator_loop_temp_check(DisasContextBase *db)
>          qemu_log("warning: TCG temporary leaks before "
>                   TARGET_FMT_lx "\n", db->pc_next);
>      }
>  }
>
> +static TCGOp *gen_trace_tb_enter(TranslationBlock *tb)
> +{
> +    TCGOp *last_pc_op;
> +
> +    TCGv pc_end =3D tcg_temp_new();
> +
> +    /* The last PC value is not known yet */
> +    tcg_gen_movi_tl(pc_end, 0xdeadbeef);
> +    last_pc_op =3D tcg_last_op();
> +
> +    trace_tb_enter_tcg(tcg_ctx->cpu, cpu_env, tb->pc, pc_end);
> +    tcg_temp_free(pc_end);
> +
> +    return last_pc_op;
> +}
> +
>  void translator_loop(const TranslatorOps *ops, DisasContextBase *db,
>                       CPUState *cpu, TranslationBlock *tb, int max_insns)
>  {
>      int bp_insn =3D 0;
> +    TCGOp *trace_pc_end;
>
>      /* Initialize DisasContext */
>      db->tb =3D tb;
>      db->pc_first =3D tb->pc;
>      db->pc_next =3D db->pc_first;
> @@ -50,10 +68,13 @@ void translator_loop(const TranslatorOps *ops, DisasC=
ontextBase *db,
>      /* Reset the temp count so that we can identify leaks */
>      tcg_clear_temp_count();
>
>      /* Start translating.  */
>      gen_tb_start(db->tb);
> +
> +    trace_pc_end =3D gen_trace_tb_enter(tb);
> +
>      ops->tb_start(db, cpu);
>      tcg_debug_assert(db->is_jmp =3D=3D DISAS_NEXT);  /* no early exit */
>
>      while (true) {
>          db->num_insns++;
> @@ -110,10 +131,13 @@ void translator_loop(const TranslatorOps *ops, Disa=
sContextBase *db,
>
>      /* Emit code to exit the TB, as indicated by db->is_jmp.  */
>      ops->tb_stop(db, cpu);
>      gen_tb_end(db->tb, db->num_insns - bp_insn);
>
> +    /* Fixup the last PC value in the tb_enter trace now that we know it=
 */
> +    tcg_set_insn_param(trace_pc_end, 1, db->pc_next);
> +
>      /* The disas_log hook may use these values rather than recompute.  */
>      db->tb->size =3D db->pc_next - db->pc_first;
>      db->tb->icount =3D db->num_insns;
>
>  #ifdef DEBUG_DISAS
> diff --git a/trace-events b/trace-events
> index aeea3c2bdb..e37fa12ef0 100644
> --- a/trace-events
> +++ b/trace-events
> @@ -157,10 +157,13 @@ vcpu guest_cpu_reset(void)
>  #
>  # Mode: user, softmmu
>  # Targets: TCG(all)
>  vcpu tcg guest_mem_before(TCGv vaddr, uint8_t info) "info=3D%d", "vaddr=
=3D0x%016"PRIx64" info=3D%d"
>
> +# translator.c
> +vcpu tcg tb_enter(uint64_t pc_start, TCGv pc_end) "pc_start:0x%"PRIx64, =
"pc:0x%"PRIx64" pc_end:0x%"PRIx64
> +
>  # linux-user/syscall.c
>  # bsd-user/syscall.c
>
>  # @num: System call number.
>  # @arg*: System call argument value.


--
Alex Benn=C3=A9e

