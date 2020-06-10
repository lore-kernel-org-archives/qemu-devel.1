Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20FB7C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 23:02:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB0BF2074B
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 23:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2HkNGFn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB0BF2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj9kB-0003OH-4Y
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 19:02:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51590)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jj9jH-0002mm-VR; Wed, 10 Jun 2020 19:01:55 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:38260)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jj9jH-0001ct-2H; Wed, 10 Jun 2020 19:01:55 -0400
Received: by mail-io1-xd44.google.com with SMTP id w18so4247240iom.5;
 Wed, 10 Jun 2020 16:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DM2as4a/ses8P7TbuFrFQ8LOp8s+74z3O2LqRdxe9LE=;
 b=g2HkNGFn3n1bDlpzstzNIx35sGjeFSdOERd+48mdvIcvvhzjB9VLtr4jLqwqoIlM2o
 wyjHfzz+rBCCrIZyIB/2kdtcwQAksQBJZDFgAsPRywJakVnrycA2OztWHg/R0XilnmXh
 /JD8NUe2ICdx/Hsfum85Iievk4ZTaq2j9LR0DY6eF4JGQLCNDk/RbI6wv8KERZ4evQCF
 JAU0sSCqFcdyTBFQo3wQL59PflXxaB6xLBQeuNH9u5565kzs+TcJwRi1JQUVkHkaBgMk
 FfMuC6g3+Y7ll8io6485cai3eIcUsm0grAeH5bwcS7YV00/dELCpoUZiPzal6d74HK7q
 Qhfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DM2as4a/ses8P7TbuFrFQ8LOp8s+74z3O2LqRdxe9LE=;
 b=rAuLAqCfIHzTtlAYRJwIMNaceJhxqyDISmdfhBie6iOvD8s3qpa4jZ+TIczX6/CudS
 693z5DrvjM1/TJTGYYCQuG5DWlL9VarWn5XO4FvkfDnVjs7U3TfbBnDCNpFyj5o19Mw6
 RJhDKE0jG141QAWcamwTy3SsRf87miEVin9toZ3e9XdyytL386+u/W8xElymKR2R4rjs
 pJKFQge8IS5eTRkLimfmxw80hkiEWK5+fpc3V2UJ+ddyeACtTuXiWvRiGbtEeq5VrBYy
 evASVlgwtmc/UAAPIvorEMzeq47Ra/Ue8VUnrtV4eq1p6AYS9alr2GRDwPEUJItgD36q
 /qSg==
X-Gm-Message-State: AOAM5332USaTP/QU9hqsDqjS7tWz/HMGhLLe5bYnI9m/xg94dOE72S+3
 Z7i34tN64omFG91PAhiIH9yMLNe1qXaLpCYMP64=
X-Google-Smtp-Source: ABdhPJzKDsTSsCa+U2XAk3lgVVfVt5i4Y9s6WOy08yV/1QMkbZYeNnjrn9n8QeJ15udeTXEHS+vJa1JOaxjipZNGp9w=
X-Received: by 2002:a5d:9cc2:: with SMTP id w2mr5698062iow.42.1591830101582;
 Wed, 10 Jun 2020 16:01:41 -0700 (PDT)
MIME-Version: 1.0
References: <1591342707-9729-1-git-send-email-bmeng.cn@gmail.com>
 <1591342707-9729-2-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1591342707-9729-2-git-send-email-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 10 Jun 2020 15:52:19 -0700
Message-ID: <CAKmqyKOdoE7-8LQmVw1AQJHgHuPABuqRVqjiYbSM_6HQ3SBirA@mail.gmail.com>
Subject: Re: [PATCH 2/4] riscv: Generalize CPU init routine for the gcsu CPU
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d44;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd44.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
Cc: Bin Meng <bin.meng@windriver.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 5, 2020 at 12:42 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> From: Bin Meng <bin.meng@windriver.com>
>
> There is no need to have two functions that have almost the same
> codes for 32-bit and 64-bit gcsu CPUs.
>
> Signed-off-by: Bin Meng <bin.meng@windriver.com>
> ---
>
>  target/riscv/cpu.c | 20 ++++++--------------
>  1 file changed, 6 insertions(+), 14 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index d38d829..e66488f 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -134,16 +134,16 @@ static void riscv_base_cpu_init(Object *obj)
>      set_resetvec(env, DEFAULT_RSTVEC);
>  }
>
> -#if defined(TARGET_RISCV32)
> -
> -static void rv32gcsu_priv1_10_0_cpu_init(Object *obj)
> +static void rvnn_gcsu_priv1_10_0_cpu_init(Object *obj)

Could we change the function names to rvxx_*?

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

>  {
>      CPURISCVState *env = &RISCV_CPU(obj)->env;
> -    set_misa(env, RV32 | RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU);
> +    set_misa(env, RVXLEN | RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU);
>      set_priv_version(env, PRIV_VERSION_1_10_0);
>      set_resetvec(env, DEFAULT_RSTVEC);
>  }
>
> +#if defined(TARGET_RISCV32)
> +
>  static void rv32imcu_nommu_cpu_init(Object *obj)
>  {
>      CPURISCVState *env = &RISCV_CPU(obj)->env;
> @@ -173,14 +173,6 @@ static void rv32imafcu_nommu_cpu_init(Object *obj)
>
>  #elif defined(TARGET_RISCV64)
>
> -static void rv64gcsu_priv1_10_0_cpu_init(Object *obj)
> -{
> -    CPURISCVState *env = &RISCV_CPU(obj)->env;
> -    set_misa(env, RV64 | RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU);
> -    set_priv_version(env, PRIV_VERSION_1_10_0);
> -    set_resetvec(env, DEFAULT_RSTVEC);
> -}
> -
>  static void rv64imacu_nommu_cpu_init(Object *obj)
>  {
>      CPURISCVState *env = &RISCV_CPU(obj)->env;
> @@ -597,11 +589,11 @@ static const TypeInfo riscv_cpu_type_infos[] = {
>      DEFINE_CPU(TYPE_RISCV_CPU_IBEX,             rv32imcu_nommu_cpu_init),
>      DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E31,       rv32imacu_nommu_cpu_init),
>      DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E34,       rv32imafcu_nommu_cpu_init),
> -    DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_U34,       rv32gcsu_priv1_10_0_cpu_init),
> +    DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_U34,       rvnn_gcsu_priv1_10_0_cpu_init),
>  #elif defined(TARGET_RISCV64)
>      DEFINE_CPU(TYPE_RISCV_CPU_BASE64,           riscv_base_cpu_init),
>      DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E51,       rv64imacu_nommu_cpu_init),
> -    DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_U54,       rv64gcsu_priv1_10_0_cpu_init),
> +    DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_U54,       rvnn_gcsu_priv1_10_0_cpu_init),
>  #endif
>  };
>
> --
> 2.7.4
>
>

