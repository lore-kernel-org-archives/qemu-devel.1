Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB4BC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 02:42:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09597206E9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 02:42:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nof6jWSy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09597206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxiES-0008Rw-8w
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 22:42:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41856)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jxiDh-0007wz-KU; Mon, 20 Jul 2020 22:41:29 -0400
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42]:45222)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jxiDf-0007Kz-VK; Mon, 20 Jul 2020 22:41:29 -0400
Received: by mail-yb1-xb42.google.com with SMTP id y17so9281978ybm.12;
 Mon, 20 Jul 2020 19:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=skdlpQWisCSvavXYO5NtnKlNfgt0dNyO8LrUOpShm8g=;
 b=nof6jWSymmYFyPBzt+BkvrYKBwkGbxzNO2qYUBraeIuD9PMm3zNVR1TQPv02vnEHVy
 m2hJjyjX+UofQcWwcNiEmBjsRdg8l7/WGI7ktA6DXLh2vuDMn1wK1s5XHfdnqhT/tkcf
 7jNcpTExvbUuwx+9FqGUbzizlkAHww5ga/PMfMGLteYNzKRxx2usnFxC5Q5Glk34JfeY
 pBBEKetYYr9Nte9H/NGoLxuiI1g19E8vFxpY++mZ2K2sGpkNf8OrSChxmUozee5wumSH
 743WRT1Ofk0nLPQAhDTMZUYWhkuV4qWjZtSnNFkDNPkQnP6uMT7MleEVKLZDYUtWAaYc
 pz9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=skdlpQWisCSvavXYO5NtnKlNfgt0dNyO8LrUOpShm8g=;
 b=fEwwcneF/aj7GtcAM4kQCM2fnH/uSRl0s8hXDxQmtb7NNrJ85MYaWL08OFjuzQgtXA
 3gigcyiMGYHYG9UV3binmJ1W46A3joBryTxZpjSci0LLM1nACFT3JFz8rBEps6Kp8hzi
 LtW4YO7plQqi/PeboH0cRcoYMv/Gx3ASC3bbcpOK2o3GFmDR1GaioDglNNVgMsvOOOqF
 fh6W8xVhzcUBlph1XMFqL1CxCEXEMIryJVyp3USRVrng2lTR39e6aU6UmqxlqbXQSzdg
 RfE9M8Glz7VeGW275BLuw5JNKPyw2F5B26yj0Atpw+9qdnrdm+PE9sxT7DI2CwN5F01P
 T3Tg==
X-Gm-Message-State: AOAM531MqUBi+HBkVWYhB8bOzqO76bimyWWnSclmwhPpKg4Kk/NCQsF6
 NMmXHv9dpG4g20Jei+4/TzqAo7vZPZUyftxnUuo=
X-Google-Smtp-Source: ABdhPJwR3st8za6kc/TESahH9UQMdzatrfvwg57EnTfrYgs6gNN08/0szFq4t1ugSr2PzmoegXxl83aNXs3tkvmZZ7I=
X-Received: by 2002:a25:aea5:: with SMTP id b37mr39260336ybj.239.1595299286508; 
 Mon, 20 Jul 2020 19:41:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1595234208.git.zong.li@sifive.com>
 <658e49284fc564d4114307cb559cf23ea3e751fd.1595234208.git.zong.li@sifive.com>
In-Reply-To: <658e49284fc564d4114307cb559cf23ea3e751fd.1595234208.git.zong.li@sifive.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Tue, 21 Jul 2020 10:41:15 +0800
Message-ID: <CAEUhbmWz0Afs4YotbQi-t96A-eEcQzxzwkYjHtQ4BZxJ7SCgxw@mail.gmail.com>
Subject: Re: [PATCH 2/2] target/riscv/pmp.c: Fix the index offset on RV64
To: Zong Li <zong.li@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b42;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yb1-xb42.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Zong,

On Mon, Jul 20, 2020 at 5:46 PM Zong Li <zong.li@sifive.com> wrote:
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
> ---
>  target/riscv/pmp.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
> index 2a2b9f5363..adcdd411e6 100644
> --- a/target/riscv/pmp.c
> +++ b/target/riscv/pmp.c
> @@ -320,8 +320,13 @@ void pmpcfg_csr_write(CPURISCVState *env, uint32_t reg_index,
>
>      for (i = 0; i < sizeof(target_ulong); i++) {
>          cfg_val = (val >> 8 * i)  & 0xff;
> +#if defined(TARGET_RISCV32)
>          pmp_write_cfg(env, (reg_index * sizeof(target_ulong)) + i,
>              cfg_val);
> +#elif defined(TARGET_RISCV64)
> +        pmp_write_cfg(env, ((reg_index >> 1) * sizeof(target_ulong)) + i,
> +            cfg_val);
> +#endif

Can you please simplify this by shifting reg_index outside the for
loop for RV64?

>      }
>  }
>
> @@ -336,7 +341,11 @@ target_ulong pmpcfg_csr_read(CPURISCVState *env, uint32_t reg_index)
>      target_ulong val = 0;
>
>      for (i = 0; i < sizeof(target_ulong); i++) {
> +#if defined(TARGET_RISCV32)
>          val = pmp_read_cfg(env, (reg_index * sizeof(target_ulong)) + i);
> +#elif defined(TARGET_RISCV64)
> +        val = pmp_read_cfg(env, ((reg_index >> 1) * sizeof(target_ulong)) + i);
> +#endif
>          cfg_val |= (val << (i * 8));
>      }
>      trace_pmpcfg_csr_read(env->mhartid, reg_index, cfg_val);

Regards,
Bin

