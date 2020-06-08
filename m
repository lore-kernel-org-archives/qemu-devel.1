Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F36C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 14:46:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAFF020659
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 14:46:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zkqw+k3D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAFF020659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiJ2I-0002UZ-SQ
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 10:46:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56856)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jiJ18-0001kf-G0
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 10:44:50 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:54979)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jiJ0r-0000RS-Kj
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 10:44:50 -0400
Received: by mail-wm1-x342.google.com with SMTP id g10so15587091wmh.4
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 07:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=eSU85IXFhR+fzsS/KzTgi+IpaD4qRD5rYxt04HIKxgU=;
 b=zkqw+k3DrwjJnF6/dk9vW7v0yo/rJ9VMZ/ZI8+0XGGv1XSMIi/tyDj/eXxlIL5Z/ms
 4zFuKSSZMePaGaQkhJ+WueID49UF1zXGvHLo6ZKpaA7ngwZPnHYIoGaG0bl5YWgOr+wp
 BltICBZlnQs+aaVh8Z1Rnp1XrPggDScHs2pDtV5s0mCP3ek5bzYSgqvwhD2kTolYwam8
 SmS4LyLkRVuRj6DCucj9j6OPbaBLkVznzs078Kd78lR9asxMN1lkn2XlCxcLNwD+VWJ5
 RDqlJdNU3a8ncKSowg7uILvhLRReDGAqvjvgBDp5IJMlxVZDsSil99CCVaOwgdDhfrL1
 wgGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=eSU85IXFhR+fzsS/KzTgi+IpaD4qRD5rYxt04HIKxgU=;
 b=gPzdGZX2Xqu7PRNDu0GEQkjQsncoZsuNy22Eqsh/EzP17D0Cxp8Sjp/zvfmupsDnsz
 Wuz/8iXO6avr4HUm4y4TwVa5y0sv63dsVGFoRMM7+syULVl8k3xuQ8PFCKXmXigYFGf2
 htau0nQgjbJmnd9U5KCJFcxzAYqArjlCNlNMzcFzij5BDMyqtgcJgZ1j/IrX7PmzGgwk
 IBGhGFZiGQuK3rDgDu1JwjwZAtBO/J6h01OpD0UQbP2vs9tJGpEl2jRJEBQYSUPFSLdI
 QCRQwXYwR9GF5q7Ewfj8cZz/vCDeXDpEvegtC+HQY+j/61hwPFT90Q2upov66oWM4GEk
 HKRA==
X-Gm-Message-State: AOAM533uQrqHXG7bJ4ZWfmJiScXBZgkIDQwnRmOtTqug5xs7vlKoHHFs
 xxxP5adllZQ0D035W0nPHSqXhA==
X-Google-Smtp-Source: ABdhPJwNB/tXBPyom7eLH6R+MsRYgrmWu4OfSzSZs30dtsvY62gEWw32NYuz9q16PARB6hL8FE2MyQ==
X-Received: by 2002:a1c:7f44:: with SMTP id a65mr17684313wmd.53.1591627470959; 
 Mon, 08 Jun 2020 07:44:30 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q8sm5365374wmq.1.2020.06.08.07.44.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 07:44:29 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E76871FF7E;
 Mon,  8 Jun 2020 15:44:28 +0100 (BST)
References: <20200605173422.1490-1-robert.foley@linaro.org>
 <20200605173422.1490-7-robert.foley@linaro.org>
User-agent: mu4e 1.5.2; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Robert Foley <robert.foley@linaro.org>
Subject: Re: [PATCH v2 06/13] tcg: call qemu_spin_destroy for tb->jmp_lock
In-reply-to: <20200605173422.1490-7-robert.foley@linaro.org>
Date: Mon, 08 Jun 2020 15:44:28 +0100
Message-ID: <87zh9d62ib.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 SPF_PASS=-0.001, T_DKIM_INVALID=0.01 autolearn=_AUTOLEARN
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
Cc: peter.puhov@linaro.org, cota@braap.org, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Robert Foley <robert.foley@linaro.org> writes:

> From: "Emilio G. Cota" <cota@braap.org>
>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> Signed-off-by: Robert Foley <robert.foley@linaro.org>
> [RF: Minor changes to fix some checkpatch errors]
> ---
>  accel/tcg/translate-all.c | 10 +++++++++-
>  include/tcg/tcg.h         |  3 ++-
>  tcg/tcg.c                 | 19 ++++++++++++++++---
>  3 files changed, 27 insertions(+), 5 deletions(-)
>
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index 42ce1dfcff..3708aab36b 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -384,6 +384,11 @@ static int cpu_restore_state_from_tb(CPUState *cpu, =
TranslationBlock *tb,
>      return 0;
>  }
>=20=20
> +static void tb_destroy(TranslationBlock *tb)
> +{
> +    qemu_spin_destroy(&tb->jmp_lock);
> +}
> +
>  bool cpu_restore_state(CPUState *cpu, uintptr_t host_pc, bool will_exit)
>  {
>      TranslationBlock *tb;
> @@ -413,6 +418,7 @@ bool cpu_restore_state(CPUState *cpu, uintptr_t host_=
pc, bool will_exit)
>                  /* one-shot translation, invalidate it immediately */
>                  tb_phys_invalidate(tb, -1);
>                  tcg_tb_remove(tb);
> +                tb_destroy(tb);
>              }
>              r =3D true;
>          }
> @@ -1230,7 +1236,7 @@ static void do_tb_flush(CPUState *cpu, run_on_cpu_d=
ata tb_flush_count)
>      qht_reset_size(&tb_ctx.htable, CODE_GEN_HTABLE_SIZE);
>      page_flush_tb();
>=20=20
> -    tcg_region_reset_all();
> +    tcg_region_reset_all(tb_destroy);
>      /* XXX: flush processor icache at this point if cache flush is
>         expensive */
>      atomic_mb_set(&tb_ctx.tb_flush_count, tb_ctx.tb_flush_count + 1);
> @@ -1886,6 +1892,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
>=20=20
>          orig_aligned -=3D ROUND_UP(sizeof(*tb), qemu_icache_linesize);
>          atomic_set(&tcg_ctx->code_gen_ptr, (void *)orig_aligned);
> +        tb_destroy(tb);
>          return existing_tb;
>      }
>      tcg_tb_insert(tb);
> @@ -2235,6 +2242,7 @@ void cpu_io_recompile(CPUState *cpu, uintptr_t reta=
ddr)
>              tb_phys_invalidate(tb->orig_tb, -1);
>          }
>          tcg_tb_remove(tb);
> +        tb_destroy(tb);
>      }
>=20=20
>      /* TODO: If env->pc !=3D tb->pc (i.e. the faulting instruction was n=
ot
> diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
> index 380014ed80..c8313fdcf0 100644
> --- a/include/tcg/tcg.h
> +++ b/include/tcg/tcg.h
> @@ -818,8 +818,9 @@ void *tcg_malloc_internal(TCGContext *s, int size);
>  void tcg_pool_reset(TCGContext *s);
>  TranslationBlock *tcg_tb_alloc(TCGContext *s);
>=20=20
> +typedef void (*tb_destroy_func)(TranslationBlock *tb);
>  void tcg_region_init(void);
> -void tcg_region_reset_all(void);
> +void tcg_region_reset_all(tb_destroy_func tb_destroy);
>=20=20
>  size_t tcg_code_size(void);
>  size_t tcg_code_capacity(void);
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index 1aa6cb47f2..7ae9dd7cf8 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -502,7 +502,16 @@ size_t tcg_nb_tbs(void)
>      return nb_tbs;
>  }
>=20=20
> -static void tcg_region_tree_reset_all(void)
> +static gboolean tcg_region_tree_traverse(gpointer k, gpointer v, gpointe=
r data)
> +{
> +    TranslationBlock *tb =3D v;
> +    tb_destroy_func tb_destroy =3D data;
> +
> +    tb_destroy(tb);
> +    return FALSE;
> +}
> +
> +static void tcg_region_tree_reset_all(tb_destroy_func tb_destroy)
>  {
>      size_t i;
>=20=20
> @@ -510,6 +519,10 @@ static void tcg_region_tree_reset_all(void)
>      for (i =3D 0; i < region.n; i++) {
>          struct tcg_region_tree *rt =3D region_trees + i * tree_size;
>=20=20
> +        if (tb_destroy !=3D NULL) {
> +            g_tree_foreach(rt->tree, tcg_region_tree_traverse, tb_destro=
y);
> +        }
> +

Isn't tb_destroy always set? We could assert that is the case rather
than make the cleaning up conditional.

>          /* Increment the refcount first so that destroy acts as a reset =
*/
>          g_tree_ref(rt->tree);
>          g_tree_destroy(rt->tree);
> @@ -586,7 +599,7 @@ static inline bool tcg_region_initial_alloc__locked(T=
CGContext *s)
>  }
>=20=20
>  /* Call from a safe-work context */
> -void tcg_region_reset_all(void)
> +void tcg_region_reset_all(tb_destroy_func tb_destroy)
>  {
>      unsigned int n_ctxs =3D atomic_read(&n_tcg_ctxs);
>      unsigned int i;
> @@ -603,7 +616,7 @@ void tcg_region_reset_all(void)
>      }
>      qemu_mutex_unlock(&region.lock);
>=20=20
> -    tcg_region_tree_reset_all();
> +    tcg_region_tree_reset_all(tb_destroy);

Could you name the variables of type tb_destroy_func differently as
although the variable is only ever tb_destroy the function it gets
confusing real quick when trying to grep for stuff. Maybe tbd_fn?

That said given the single usage why a function pointer? Would we be
just as well served by an exposed public function call from the
appropriate places?

Richard do you have a view here?

--=20
Alex Benn=C3=A9e

