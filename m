Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80915C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 22:37:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 496D8206D7
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 22:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JhxkW20g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 496D8206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0Bkf-0005Wn-GB
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 18:37:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55314)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1k0Bk3-0004ub-7q; Mon, 27 Jul 2020 18:37:07 -0400
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141]:46653)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1k0Bk1-0000v8-5l; Mon, 27 Jul 2020 18:37:06 -0400
Received: by mail-il1-x141.google.com with SMTP id l17so4312526ilq.13;
 Mon, 27 Jul 2020 15:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZDwVYMRN6PXjA735pEdIR4fqv2Bs46W3UJXGcYcYV0Y=;
 b=JhxkW20gjiOygC5kJjz57XqOUc8EM2U5UxtA3KK/Tsyz8FuEeK9OGE0hz11UECp7QQ
 ojrQ3WK3yowM/nK8KInhZca3ABfejGqQEKzawTpk8hCXSBN/LnT/JZidWSoUBtl5jH/B
 yyUmAfy3cO5cSJ4/78JW8A2jQ14/OahQELDYwTzKJhBFOAMB33X5YWTkBU7EuXbgpStA
 8RHDoSP45xVvuJB3acf7XJfVpXsy0sY3derayf2TgRRtiIq/20y82s0+1gQRPsPvqN6F
 vcxouSd6rSnn3JYMvAy9yCDy6nLxT3g05/0QJHpkUHxtm6ttI/RXbKVg/CXkk/N3C1+8
 8n5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZDwVYMRN6PXjA735pEdIR4fqv2Bs46W3UJXGcYcYV0Y=;
 b=RU7z1Ubj8TeG0WbHwfSOblnOIuGUiXkJWkD6In2iT5KZBqOHkEeDKcPnDcG0UfY6Mr
 v2k7n/XJz/BvUbR7DrqyVF60p/DLKIcAA1exkP4EesXMZMNX9wF+m3ZNLsLY9TLCJmpg
 AIFr5YrIClKlgR+yqTymx+4ps2sF/1ICYn/inzWFD2EsqmHRfTUxraFs9yDoLSelpvqu
 GAUlIH92/O+sZpmBgUIuVspvsLerfldXQF8VKbSHbxoULnTdUHHGQoIwakX9MHwW/oul
 FByyIstXU6L9LednMbiUMF8OcIhHIwA4xQUkTxd3zGDs681LsTeszug+xf5nAdqei10T
 pblA==
X-Gm-Message-State: AOAM533goURs8FooydMU0aA9kRNSD5yRrDzun7dU6+JF5B/DXXwsmuhk
 K767IAgm1EBaYJmJgnB8sU4fxMEhQBgQKCBccQU=
X-Google-Smtp-Source: ABdhPJyCEqip9ZtAJaO1ZEnF9iD8Tn4gTI5Ccq1YjF+5o+a4yEadXA3u6MPrdDDDZMfMSHIu8FzJfN7bItbM4gWxTaA=
X-Received: by 2002:a92:cf50:: with SMTP id c16mr5817019ilr.131.1595889423708; 
 Mon, 27 Jul 2020 15:37:03 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1595689201.git.zong.li@sifive.com>
 <a1ddde7963423df8e62e98fcf3dc75ae092186b2.1595689201.git.zong.li@sifive.com>
In-Reply-To: <a1ddde7963423df8e62e98fcf3dc75ae092186b2.1595689201.git.zong.li@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 27 Jul 2020 15:26:47 -0700
Message-ID: <CAKmqyKNiYMmWMpphNJcg8bOpVWKVFO53i9+QxW8a5Herw3v15g@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] target/riscv/pmp.c: Fix the index offset on RV64
To: Zong Li <zong.li@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::141;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x141.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Bin Meng <bmeng.cn@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Jul 25, 2020 at 8:04 AM Zong Li <zong.li@sifive.com> wrote:
>
> On RV64, the reg_index is 2 (pmpcfg2 CSR) after the seventh pmp
> entry, it is not 1 (pmpcfg1 CSR) like RV32. In the original
> implementation, the second parameter of pmp_write_cfg is
> "reg_index * sizeof(target_ulong)", and we get the the result
> which is started from 16 if reg_index is 2, but we expect that
> it should be started from 8. Separate the implementation for
> RV32 and RV64 respectively.
>
> Signed-off-by: Zong Li <zong.li@sifive.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/pmp.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
> index 2a2b9f5363..aeba796484 100644
> --- a/target/riscv/pmp.c
> +++ b/target/riscv/pmp.c
> @@ -318,6 +318,10 @@ void pmpcfg_csr_write(CPURISCVState *env, uint32_t reg_index,
>          return;
>      }
>
> +#if defined(TARGET_RISCV64)
> +    reg_index >>= 1;
> +#endif
> +
>      for (i = 0; i < sizeof(target_ulong); i++) {
>          cfg_val = (val >> 8 * i)  & 0xff;
>          pmp_write_cfg(env, (reg_index * sizeof(target_ulong)) + i,
> @@ -335,11 +339,16 @@ target_ulong pmpcfg_csr_read(CPURISCVState *env, uint32_t reg_index)
>      target_ulong cfg_val = 0;
>      target_ulong val = 0;
>
> +    trace_pmpcfg_csr_read(env->mhartid, reg_index, cfg_val);
> +
> +#if defined(TARGET_RISCV64)
> +    reg_index >>= 1;
> +#endif
> +
>      for (i = 0; i < sizeof(target_ulong); i++) {
>          val = pmp_read_cfg(env, (reg_index * sizeof(target_ulong)) + i);
>          cfg_val |= (val << (i * 8));
>      }
> -    trace_pmpcfg_csr_read(env->mhartid, reg_index, cfg_val);
>
>      return cfg_val;
>  }
> --
> 2.27.0
>
>

