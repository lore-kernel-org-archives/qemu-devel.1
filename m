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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F1B2C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 23:06:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41516206F4
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 23:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W5EJhD+S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41516206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj9nG-0004xm-HN
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 19:06:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52534)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jj9mW-0004Q9-6U; Wed, 10 Jun 2020 19:05:16 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:46203)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jj9mV-0002FX-65; Wed, 10 Jun 2020 19:05:15 -0400
Received: by mail-io1-xd44.google.com with SMTP id t9so4220833ioj.13;
 Wed, 10 Jun 2020 16:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dkorscTSTKNRmxZVGtmlNerM1+Tso05ZZOVhlHS+28M=;
 b=W5EJhD+SgmSey725/U0MNY0078jCteeNSvCq0rOevSUzVQQmKFrnJeuh4JAxlcVA2k
 ookQYhjqwkHXqY3GkuOfPpCinnwMdLtQE7+joD/QTXvVUOHA7OrPhBtIAljNigqHbzv0
 8jgoY1DP9HLrp3mKe9NKeNHfM7a3cc/4d3RBRu+3c0SulXhFcbXGUFxq0W55s14ueV2E
 LEiMVXyJyMdET7lU6+Xfj0CNNGO6AxknCvrepNzrwMZGCUl7LP1nfFVeRXADJLBunlhj
 T4uKPflu5uHeXk/oWoAINMZQnL8h4YCpBHSf3Tq8O9H0Hx1+s2zvoYd3HMIJwWQQwu1f
 D9TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dkorscTSTKNRmxZVGtmlNerM1+Tso05ZZOVhlHS+28M=;
 b=bVGZhFV3pjM1NOrLcdcBrS+XW0AbuvFFh6dBEFqRwb7ThZitUETG/43n0DS2E7cmdf
 4ttEl8rMU0vp+55PcFvED3JP78VoOtwRhHOf0o4l2WC1sRlUTDU4DEV/hlzPCWOwOexT
 y1tzjtB4lfRn6/RdZEtjIeGuSaHsApmyjKtfEV9uLbcGOrtl5aoY1IUXVfQx6AXgM1W0
 0Aw2640r3Kn9L6NO2i0Q3dQ+Rux9mkkTsrB7fxWf4Q4pJnTkwNGiK9AELfwxJYQD+G5c
 vx7+02edh7lBRrdAHN7ZqVDVu/Z6H7ph67vR4eLI7DN1MndQ70T/VL3fh//dPX+XwB9e
 +bFw==
X-Gm-Message-State: AOAM53254FczUn/2z/+q2sFrtxfcpW7WR8cUtQj8kBs2zcZNi/MX0uga
 nB9Hn1DjuPYHPEsNnOLbtW8pfRFDx0288owOuNI=
X-Google-Smtp-Source: ABdhPJwiB1vOcn/pFL0LIgyR674sYfNDPU+6tcSdnn/EzofGMdEPpqlJL0SEwDDayyphKvRiOFjG7trGR9nyfFPtdW8=
X-Received: by 2002:a02:cccd:: with SMTP id k13mr514177jaq.135.1591830301443; 
 Wed, 10 Jun 2020 16:05:01 -0700 (PDT)
MIME-Version: 1.0
References: <1591342707-9729-1-git-send-email-bmeng.cn@gmail.com>
 <1591342707-9729-3-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1591342707-9729-3-git-send-email-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 10 Jun 2020 15:55:38 -0700
Message-ID: <CAKmqyKOTf4iFZ+4vnw-hzcmyXZc1GPHPATfw-icC-+ObGzmm8g@mail.gmail.com>
Subject: Re: [PATCH 3/4] riscv: Generalize CPU init routine for the imacu CPU
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

On Fri, Jun 5, 2020 at 12:40 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> From: Bin Meng <bin.meng@windriver.com>
>
> There is no need to have two functions that have almost the same
> codes for 32-bit and 64-bit imacu CPUs.
>
> Signed-off-by: Bin Meng <bin.meng@windriver.com>
> ---
>
>  target/riscv/cpu.c | 31 ++++++++++---------------------
>  1 file changed, 10 insertions(+), 21 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index e66488f..c5c2abc 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -142,23 +142,23 @@ static void rvnn_gcsu_priv1_10_0_cpu_init(Object *obj)
>      set_resetvec(env, DEFAULT_RSTVEC);
>  }
>
> -#if defined(TARGET_RISCV32)
> -
> -static void rv32imcu_nommu_cpu_init(Object *obj)
> +static void rvnn_imacu_nommu_cpu_init(Object *obj)

Same request with rvxx_*

Otherwise:

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

>  {
>      CPURISCVState *env = &RISCV_CPU(obj)->env;
> -    set_misa(env, RV32 | RVI | RVM | RVC | RVU);
> +    set_misa(env, RVXLEN | RVI | RVM | RVA | RVC | RVU);
>      set_priv_version(env, PRIV_VERSION_1_10_0);
> -    set_resetvec(env, 0x8090);
> +    set_resetvec(env, DEFAULT_RSTVEC);
>      qdev_prop_set_bit(DEVICE(obj), "mmu", false);
>  }
>
> -static void rv32imacu_nommu_cpu_init(Object *obj)
> +#if defined(TARGET_RISCV32)
> +
> +static void rv32imcu_nommu_cpu_init(Object *obj)
>  {
>      CPURISCVState *env = &RISCV_CPU(obj)->env;
> -    set_misa(env, RV32 | RVI | RVM | RVA | RVC | RVU);
> +    set_misa(env, RV32 | RVI | RVM | RVC | RVU);
>      set_priv_version(env, PRIV_VERSION_1_10_0);
> -    set_resetvec(env, DEFAULT_RSTVEC);
> +    set_resetvec(env, 0x8090);
>      qdev_prop_set_bit(DEVICE(obj), "mmu", false);
>  }
>
> @@ -171,17 +171,6 @@ static void rv32imafcu_nommu_cpu_init(Object *obj)
>      qdev_prop_set_bit(DEVICE(obj), "mmu", false);
>  }
>
> -#elif defined(TARGET_RISCV64)
> -
> -static void rv64imacu_nommu_cpu_init(Object *obj)
> -{
> -    CPURISCVState *env = &RISCV_CPU(obj)->env;
> -    set_misa(env, RV64 | RVI | RVM | RVA | RVC | RVU);
> -    set_priv_version(env, PRIV_VERSION_1_10_0);
> -    set_resetvec(env, DEFAULT_RSTVEC);
> -    qdev_prop_set_bit(DEVICE(obj), "mmu", false);
> -}
> -
>  #endif
>
>  static ObjectClass *riscv_cpu_class_by_name(const char *cpu_model)
> @@ -587,12 +576,12 @@ static const TypeInfo riscv_cpu_type_infos[] = {
>  #if defined(TARGET_RISCV32)
>      DEFINE_CPU(TYPE_RISCV_CPU_BASE32,           riscv_base_cpu_init),
>      DEFINE_CPU(TYPE_RISCV_CPU_IBEX,             rv32imcu_nommu_cpu_init),
> -    DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E31,       rv32imacu_nommu_cpu_init),
> +    DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E31,       rvnn_imacu_nommu_cpu_init),
>      DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E34,       rv32imafcu_nommu_cpu_init),
>      DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_U34,       rvnn_gcsu_priv1_10_0_cpu_init),
>  #elif defined(TARGET_RISCV64)
>      DEFINE_CPU(TYPE_RISCV_CPU_BASE64,           riscv_base_cpu_init),
> -    DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E51,       rv64imacu_nommu_cpu_init),
> +    DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E51,       rvnn_imacu_nommu_cpu_init),
>      DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_U54,       rvnn_gcsu_priv1_10_0_cpu_init),
>  #endif
>  };
> --
> 2.7.4
>
>

