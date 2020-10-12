Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F02CAC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 19:57:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18644206CA
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 19:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T9p4+Cks"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18644206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS3x1-0006We-OJ
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 15:57:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57436)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kS3wE-0005vj-3r
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 15:56:54 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:45056)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kS3wB-0006gi-LQ
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 15:56:53 -0400
Received: by mail-ed1-x541.google.com with SMTP id dg9so15986304edb.12
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 12:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=v5etaDJNkqSqjPrSQFI0iDavDx4rNRv/5D8BugcNJek=;
 b=T9p4+Cks4CoZNHt4dMGwQVrSndKQKk1WRpTUD/fuuJRjmcd429tPrhBkPs0o5oDZhw
 RK2fKp68TVLH3oW+kLgudi4qrOzH/MfBTTyG6kbhsJiQcG0xROmryHC8OnH7QV0Vpoqd
 zqafuc9bIGcqpfn7HEPDCvchaX4BYuwuw4hF+fISxG9oqOAxH994jcN+l+7cC/DgMeKP
 W7D1yRIBj6wV5giNqEwzCbX1sI86mVYHZ573IQkkBj+9fSYvxp107Ij/V1ppnS7+8jER
 085OJoPD9/X/EBfhUUSNYIYMhwQJoIBxLhg5oCDEYM9dLYBSVA4mruyhd7fGXVoOW4Iu
 y+AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=v5etaDJNkqSqjPrSQFI0iDavDx4rNRv/5D8BugcNJek=;
 b=Njg+xrypgLfOhzrrd6l2c98nBhqunPDfgAwHg5hoJuG46zLWBLdImyfiTgwxiM0bSi
 IGRd8WAAOAbTL3fa8FusTUpX4gkLrjFZ9d5G+95mudtGyLyUR7IDCB4hatOWIkcxdtql
 3t9CXwYJEvYbyPS9t5eGtgM33ZV9FaJuiX5aDUf2BnPpZfEe6tu+ZvvQaH/26rV0qCKF
 dE1RWm8vmD047z1qQXkfAkwRug/qVMgsYVD9xORzsRlGLO+oRcrGK1XFawurR9VuzC69
 FNeVzpmowwTn05Hehb5NrrGkcrMZN7k4m3zOxQJZCwhYoDvN8VWp/B5RHMm0yI4rhj+W
 Vzdg==
X-Gm-Message-State: AOAM533w/kzz/WrYwpW9OPAsdZNoozvjRr1PeewAyz0WNVw/ksfLO5yP
 pakpK5n1twCXufubGNluK0Ja8yqbkH5IOsRMWVKP+g==
X-Google-Smtp-Source: ABdhPJwuycqjLxMBG9If2LyqnOmA3dEKzWYQJ/iIvskrwlKpz5lkTIvF7o+hYaD9fFA7cQduI0vJL+78AvyUidSix38=
X-Received: by 2002:aa7:c7d7:: with SMTP id o23mr15892793eds.44.1602532609709; 
 Mon, 12 Oct 2020 12:56:49 -0700 (PDT)
MIME-Version: 1.0
References: <20201012153746.9996-1-peter.maydell@linaro.org>
 <20201012153746.9996-8-peter.maydell@linaro.org>
In-Reply-To: <20201012153746.9996-8-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Oct 2020 20:56:38 +0100
Message-ID: <CAFEAcA_MN4pzkWV65+2VtUgMdayf6pa-RCLXiomCsntF+38hNQ@mail.gmail.com>
Subject: Re: [PATCH 07/10] target/arm: Implement v8.1M low-overhead-loop
 instructions
To: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::541;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 12 Oct 2020 at 16:37, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> v8.1M's "low-overhead-loop" extension has three instructions
> for looping:
>  * DLS (start of a do-loop)
>  * WLS (start of a while-loop)
>  * LE (end of a loop)
>
> +static bool trans_WLS(DisasContext *s, arg_WLS *a)
> +{
> +    /* M-profile low-overhead while-loop start */
> +    TCGv_i32 tmp;
> +    TCGLabel *nextlabel;
> +
> +    if (!dc_isar_feature(aa32_lob, s)) {
> +        return false;
> +    }
> +    if (a->rn == 13 || a->rn == 15) {
> +        /* CONSTRAINED UNPREDICTABLE: we choose to UNDEF */
> +        return false;
> +    }
> +
> +    nextlabel = gen_new_label();
> +    tcg_gen_brcondi_i32(TCG_COND_NE, cpu_R[a->rn], 0, nextlabel);
> +    gen_jmp(s, read_pc(s) + a->imm);
> +
> +    gen_set_label(nextlabel);
> +    tmp = load_reg(s, a->rn);
> +    store_reg(s, 14, tmp);
> +    gen_jmp(s, s->base.pc_next);
> +    return true;
> +}

This turns out not to work, because gen_jmp() always generates
a goto-tb for tb exit 0, and we hit the assert() that exit 0
was not used twice. Here's a fixup to fold into this patch:

--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -2490,17 +2490,23 @@ static void gen_goto_tb(DisasContext *s, int
n, target_ulong dest)
     s->base.is_jmp = DISAS_NORETURN;
 }

-static inline void gen_jmp (DisasContext *s, uint32_t dest)
+/* Jump, specifying which TB number to use if we gen_goto_tb() */
+static inline void gen_jmp_tb(DisasContext *s, uint32_t dest, int tbno)
 {
     if (unlikely(is_singlestepping(s))) {
         /* An indirect jump so that we still trigger the debug exception.  */
         gen_set_pc_im(s, dest);
         s->base.is_jmp = DISAS_JUMP;
     } else {
-        gen_goto_tb(s, 0, dest);
+        gen_goto_tb(s, tbno, dest);
     }
 }

+static inline void gen_jmp(DisasContext *s, uint32_t dest)
+{
+    gen_jmp_tb(s, dest, 0);
+}
+
 static inline void gen_mulxy(TCGv_i32 t0, TCGv_i32 t1, int x, int y)
 {
     if (x)
@@ -8023,7 +8029,16 @@ static bool trans_WLS(DisasContext *s, arg_WLS *a)
         /* CONSTRAINED UNPREDICTABLE: we choose to UNDEF */
         return false;
     }
-
+    if (s->condexec_mask) {
+        /*
+         * WLS in an IT block is CONSTRAINED UNPREDICTABLE;
+         * we choose to UNDEF, because otherwise our use of
+         * gen_goto_tb(1) would clash with the use of TB exit 1
+         * in the dc->condjmp condition-failed codepath in
+         * arm_tr_tb_stop() and we'd get an assertion.
+         */
+        return false;
+    }
     nextlabel = gen_new_label();
     tcg_gen_brcondi_i32(TCG_COND_NE, cpu_R[a->rn], 0, nextlabel);
     gen_jmp(s, read_pc(s) + a->imm);
@@ -8031,7 +8046,7 @@ static bool trans_WLS(DisasContext *s, arg_WLS *a)
     gen_set_label(nextlabel);
     tmp = load_reg(s, a->rn);
     store_reg(s, 14, tmp);
-    gen_jmp(s, s->base.pc_next);
+    gen_jmp_tb(s, s->base.pc_next, 1);
     return true;
 }

thanks
-- PMM

