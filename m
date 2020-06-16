Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E39C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 17:24:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A08D20707
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 17:24:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t/B0ZjAx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A08D20707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlFJo-0006ib-OY
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 13:24:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49618)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jlFEE-0006pl-Ad; Tue, 16 Jun 2020 13:18:30 -0400
Received: from mail-il1-x142.google.com ([2607:f8b0:4864:20::142]:46949)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jlFEC-0000s3-Cf; Tue, 16 Jun 2020 13:18:30 -0400
Received: by mail-il1-x142.google.com with SMTP id h3so19631050ilh.13;
 Tue, 16 Jun 2020 10:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eTeDv+iweEDv9x5elUTnIsx6T3dE4kyStaL8ddv8Pg8=;
 b=t/B0ZjAxk+hbSFxd49NGZ7V+mKCcOCfE0ObkAze2G+qnudOY49rOCNzENYXjy7gPen
 xbXcWE29afeo4+TL1Xfnp5+WRJrU4CEYHUFLqV8zm+efUXRkCt8LVOuzRWvO2hRwIDSO
 w/0CcUsw4LxWPZs2lmKEFCRmTjWl/h91b3d7BT+9ZuK8ryrw1CWvm2GRsFfi3gWvePzx
 K8a3R4zJt0Zy7zgqaqhUWr9wRXHPU+VZwhFbLDbN44jZ+Vp0/YAGksn5UPcCn5waPPQn
 SKxHiAObTd5a1edifXTuLXlNgR6Fdj0wTbgfOuZ81x5LEm33nM5pKswKQYO7O1fEO9et
 4B7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eTeDv+iweEDv9x5elUTnIsx6T3dE4kyStaL8ddv8Pg8=;
 b=sk4XBtKiRSzk5LvQo0VqD+eORaWlF6Kjaq3tN4NFc6GxJ+ETpZu1yyB/QMnopM0FUB
 UBokuuG+GHzWH3qLWhprs2XkNCKsVVG13eSSC872wscUIEz2GqWns/IT1dmxxfrp138W
 w032f4fDrPVIfh0Tanba/89OyIUbupcksmk1b+754U+rfeInKin6j3yfSKGtzVjsF+U4
 /qrInim4VqvfMLWynbKj5UqaPWFb+46+uApKIrMYBBdZn/EoSBkoSX9EIdvNEfb1kB6t
 wgOuLz7w5IgnHAKtmJP1mcoqgGKdEYJPhvk04YnW6MwuztPN6krfsYHG6VEhj03XCBb9
 q7BQ==
X-Gm-Message-State: AOAM530z7EQpPNOqejfBE9rRWboCMw6MAFeepTsIn65tx97CCJhf4jZ5
 NpToQ0T4r7T+ukOZR4+Wiwfhqpj2u18b2zrLVGrApqfT
X-Google-Smtp-Source: ABdhPJzGgQ0cA/xNJaJQyUqpP2sLNZWjHHZMsRUMFdwYKCCDnQ9xokyZfwcKF41luzI4flG/67VIIe511UA1XhPQILk=
X-Received: by 2002:a92:bb45:: with SMTP id w66mr4333233ili.131.1592327906913; 
 Tue, 16 Jun 2020 10:18:26 -0700 (PDT)
MIME-Version: 1.0
References: <1592268641-7478-1-git-send-email-bmeng.cn@gmail.com>
 <1592268641-7478-3-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1592268641-7478-3-git-send-email-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 16 Jun 2020 10:09:02 -0700
Message-ID: <CAKmqyKMNWOeOySNMNfUHGu0A3-DOr1riE4394_upsGuRz5DuCA@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] hw/riscv: sifive: Change SiFive E/U CPU reset
 vector to 0x1004
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::142;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x142.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

On Mon, Jun 15, 2020 at 5:51 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> From: Bin Meng <bin.meng@windriver.com>
>
> Per the SiFive manual, all E/U series CPU cores' reset vector is
> at 0x1004. Update our codes to match the hardware.
>
> Signed-off-by: Bin Meng <bin.meng@windriver.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

>
> ---
>
> Changes in v2:
> - rebase on https://github.com/alistair23/qemu riscv-to-apply.next branch
> - rename SiFive E/U CPU init routine names
>
>  hw/riscv/sifive_e.c | 10 ++++++----
>  hw/riscv/sifive_u.c |  6 +++---
>  target/riscv/cpu.c  | 16 ++++++++--------
>  3 files changed, 17 insertions(+), 15 deletions(-)
>
> diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
> index d9a5c7b..d1d3bf1 100644
> --- a/hw/riscv/sifive_e.c
> +++ b/hw/riscv/sifive_e.c
> @@ -98,14 +98,16 @@ static void sifive_e_machine_init(MachineState *machine)
>          memmap[SIFIVE_E_DTIM].base, main_mem);
>
>      /* Mask ROM reset vector */
> -    uint32_t reset_vec[2];
> +    uint32_t reset_vec[4];
>
>      if (s->revb) {
> -        reset_vec[0] = 0x200102b7;        /* 0x1000: lui     t0,0x20010 */
> +        reset_vec[1] = 0x200102b7;  /* 0x1004: lui     t0,0x20010 */
>      } else {
> -        reset_vec[0] = 0x204002b7;        /* 0x1000: lui     t0,0x20400 */
> +        reset_vec[1] = 0x204002b7;  /* 0x1004: lui     t0,0x20400 */
>      }
> -    reset_vec[1] = 0x00028067;        /* 0x1004: jr      t0 */
> +    reset_vec[2] = 0x00028067;      /* 0x1008: jr      t0 */
> +
> +    reset_vec[0] = reset_vec[3] = 0;
>
>      /* copy in the reset vector in little_endian byte order */
>      for (i = 0; i < sizeof(reset_vec) >> 2; i++) {
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index aaa5adb..0a86ffc 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -433,18 +433,18 @@ static void sifive_u_machine_init(MachineState *machine)
>
>      /* reset vector */
>      uint32_t reset_vec[8] = {
> +        0x00000000,
>          0x00000297,                    /* 1:  auipc  t0, %pcrel_hi(dtb) */
> -        0x02028593,                    /*     addi   a1, t0, %pcrel_lo(1b) */
> +        0x01c28593,                    /*     addi   a1, t0, %pcrel_lo(1b) */
>          0xf1402573,                    /*     csrr   a0, mhartid  */
>  #if defined(TARGET_RISCV32)
>          0x0182a283,                    /*     lw     t0, 24(t0) */
>  #elif defined(TARGET_RISCV64)
> -        0x0182b283,                    /*     ld     t0, 24(t0) */
> +        0x0182e283,                    /*     lwu    t0, 24(t0) */
>  #endif
>          0x00028067,                    /*     jr     t0 */
>          0x00000000,
>          start_addr,                    /* start: .dword */
> -        0x00000000,
>                                         /* dtb: */
>      };
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 5f03458..391a0b9 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -134,20 +134,20 @@ static void riscv_base_cpu_init(Object *obj)
>      set_resetvec(env, DEFAULT_RSTVEC);
>  }
>
> -static void rvxx_gcsu_priv1_10_0_cpu_init(Object *obj)
> +static void rvxx_sifive_u_cpu_init(Object *obj)
>  {
>      CPURISCVState *env = &RISCV_CPU(obj)->env;
>      set_misa(env, RVXLEN | RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU);
>      set_priv_version(env, PRIV_VERSION_1_10_0);
> -    set_resetvec(env, DEFAULT_RSTVEC);
> +    set_resetvec(env, 0x1004);
>  }
>
> -static void rvxx_imacu_nommu_cpu_init(Object *obj)
> +static void rvxx_sifive_e_cpu_init(Object *obj)
>  {
>      CPURISCVState *env = &RISCV_CPU(obj)->env;
>      set_misa(env, RVXLEN | RVI | RVM | RVA | RVC | RVU);
>      set_priv_version(env, PRIV_VERSION_1_10_0);
> -    set_resetvec(env, DEFAULT_RSTVEC);
> +    set_resetvec(env, 0x1004);
>      qdev_prop_set_bit(DEVICE(obj), "mmu", false);
>  }
>
> @@ -578,13 +578,13 @@ static const TypeInfo riscv_cpu_type_infos[] = {
>  #if defined(TARGET_RISCV32)
>      DEFINE_CPU(TYPE_RISCV_CPU_BASE32,           riscv_base_cpu_init),
>      DEFINE_CPU(TYPE_RISCV_CPU_IBEX,             rv32_ibex_cpu_init),
> -    DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E31,       rvxx_imacu_nommu_cpu_init),
> +    DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E31,       rvxx_sifive_e_cpu_init),
>      DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E34,       rv32_imafcu_nommu_cpu_init),
> -    DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_U34,       rvxx_gcsu_priv1_10_0_cpu_init),
> +    DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_U34,       rvxx_sifive_u_cpu_init),
>  #elif defined(TARGET_RISCV64)
>      DEFINE_CPU(TYPE_RISCV_CPU_BASE64,           riscv_base_cpu_init),
> -    DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E51,       rvxx_imacu_nommu_cpu_init),
> -    DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_U54,       rvxx_gcsu_priv1_10_0_cpu_init),
> +    DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E51,       rvxx_sifive_e_cpu_init),
> +    DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_U54,       rvxx_sifive_u_cpu_init),
>  #endif
>  };
>
> --
> 2.7.4
>
>

