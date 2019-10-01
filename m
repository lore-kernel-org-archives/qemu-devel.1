Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36144C352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 18:38:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01D2F2133F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 18:38:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Kp/vdRSi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01D2F2133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFN2P-000432-5W
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 14:38:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41607)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@sifive.com>) id 1iFMyw-0000QL-0v
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 14:34:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@sifive.com>) id 1iFMyt-00030n-Nw
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 14:34:41 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:42922)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@sifive.com>) id 1iFMyr-0002zK-RK
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 14:34:37 -0400
Received: by mail-pg1-x543.google.com with SMTP id z12so10255820pgp.9
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2019 11:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
 :content-transfer-encoding;
 bh=OQi8CqLf3Tb5M+LSz1qzY7Pv1ZfhCTbNTGqS3rwVxX4=;
 b=Kp/vdRSiqArrA5SkRH8eV0CAzQp1ZegVPyzGK9YO/JiUom8yVMHS3zvJfwTQqbk7fg
 KTgMsdSIPvwo1s3/hTlUiXGojditaHxHhltRlx6AmmnvNqQ0uIrhusfknpJJT5iiSp8S
 4wzvON3tORrseAf2fPF3VpWY62vLcBdQJoj+hx9z9PpHo7wqj5ugdJAM0HU62BNblZLe
 cBz3v6kvUDtBaoZKXqoCzO0ow8y7G1QjYt179ChJcokZLbiQf0w0HqTujJ+3xfEKOy/5
 RcExy65nEvWy5dKIG7FmWoigZacbq0UU8TasrDwTa8Se6ojsFpUSqB14xhalUxehHL+P
 K+Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=OQi8CqLf3Tb5M+LSz1qzY7Pv1ZfhCTbNTGqS3rwVxX4=;
 b=h6R0DguR+WKSt2+8exIZPn0PQb5dnaljXYTTyshxb3Vv4FNe6Qbsr+cPAjXcJ8S4dP
 vqTuyb6nEEug97iV9TGwtyjUzZoGl9H4H60CTs9TW5a+RunzxFNP/K9lpjTiPry709PH
 AYrirTSgzuis2QPXf3IJCqrdoM+CKd1aaFfvC8/TOXFcrs+Dv0MS0vSMuvfcoj5KCg0M
 DcK770cv19p5SLGdDP1t0SF1OqlMMs7Wlbn3qahPuGRDWxv7IS/XA+kaNAqbwlqnIxoA
 IOV2PDIi3XCGeBrzg41YZ9w4daeD4LiDDCM4/5hzRfTe5WTx9w7g25MQK51+jerqeMaq
 oeZg==
X-Gm-Message-State: APjAAAXHipRygy0KCSr320T8dfX0JvRs2qwcssP01MO+wq0/N+2ao63b
 ua0009bZLmfpYE/9Q68moiiO1oqOKZWbEg==
X-Google-Smtp-Source: APXvYqxYvkk9MUEcdlMnSf2Nc4OHtWzpFc5Lct4D1ZB5TqSDApfpimxMUgCzWQ6EJc3Ao3bNmtVAsg==
X-Received: by 2002:a65:4785:: with SMTP id e5mr30973147pgs.407.1569954875513; 
 Tue, 01 Oct 2019 11:34:35 -0700 (PDT)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id f15sm16250203pfd.141.2019.10.01.11.34.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2019 11:34:34 -0700 (PDT)
Date: Tue, 01 Oct 2019 11:34:34 -0700 (PDT)
X-Google-Original-Date: Tue, 01 Oct 2019 11:34:23 PDT (-0700)
Subject: Re: [PATCH v1 20/28] target/riscv: Mark both sstatus and vsstatus as
 dirty
In-Reply-To: <035e50d6438660130233c472de56b883e369f6d4.1566603412.git.alistair.francis@wdc.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: Alistair Francis <Alistair.Francis@wdc.com>
Message-ID: <mhng-de7a25b6-4610-45a6-9718-25ceeed0429f@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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
Cc: qemu-riscv@nongnu.org, Anup Patel <Anup.Patel@wdc.com>,
 qemu-devel@nongnu.org, Atish Patra <Atish.Patra@wdc.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 23 Aug 2019 16:38:42 PDT (-0700), Alistair Francis wrote:
> Mark both sstatus and vsstatus as dirty (3).
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/translate.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index 8ac72c6470..19771904f4 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -44,6 +44,7 @@ typedef struct DisasContext {
>      /* pc_succ_insn points to the instruction following base.pc_next */
>      target_ulong pc_succ_insn;
>      target_ulong priv_ver;
> +    bool virt_enabled;
>      uint32_t opcode;
>      uint32_t mstatus_fs;
>      uint32_t misa;
> @@ -398,6 +399,12 @@ static void mark_fs_dirty(DisasContext *ctx)
>      tcg_gen_ld_tl(tmp, cpu_env, offsetof(CPURISCVState, mstatus));
>      tcg_gen_ori_tl(tmp, tmp, MSTATUS_FS);
>      tcg_gen_st_tl(tmp, cpu_env, offsetof(CPURISCVState, mstatus));
> +
> +    if (ctx->virt_enabled) {
> +        tcg_gen_ld_tl(tmp, cpu_env, offsetof(CPURISCVState, vsstatus));
> +        tcg_gen_ori_tl(tmp, tmp, MSTATUS_FS);
> +        tcg_gen_st_tl(tmp, cpu_env, offsetof(CPURISCVState, vsstatus));
> +    }
>      tcg_temp_free(tmp);
>  }
>  #else
> @@ -742,6 +749,11 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
>      ctx->mem_idx = ctx->base.tb->flags & TB_FLAGS_MMU_MASK;
>      ctx->mstatus_fs = ctx->base.tb->flags & TB_FLAGS_MSTATUS_FS;
>      ctx->priv_ver = env->priv_ver;
> +#if !defined(CONFIG_USER_ONLY)
> +    ctx->virt_enabled = riscv_cpu_virt_enabled(env);
> +#else
> +    ctx->virt_enabled = false;
> +#endif
>      ctx->misa = env->misa;
>      ctx->frm = -1;  /* unknown rounding mode */
>      ctx->ext_ifencei = cpu->cfg.ext_ifencei;

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>

