Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 731DDC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 19:12:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3638D20739
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 19:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qehk/WqT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3638D20739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkuWa-00086v-D2
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 15:12:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42010)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jkuW2-0007hC-P3; Mon, 15 Jun 2020 15:11:30 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:38742)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jkuW1-00023O-8C; Mon, 15 Jun 2020 15:11:30 -0400
Received: by mail-io1-xd43.google.com with SMTP id w18so19153073iom.5;
 Mon, 15 Jun 2020 12:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=B0a+QLYU8yk8rpZxCeahu7ArgLuOKIggwkFp2e9FmX0=;
 b=Qehk/WqT+e6pZ3Ht/x+0ADMFi1w6jLUKG3FMfOpwKw25qWDs/h1ISaEYKTKy8NhBEQ
 sr7ftrdoCD0Gw1K1y8TlKyv6NsUcVhW0kvTftsEcl0uCEdyI3bzQUbeM8N4cReW9oT3y
 KPzfQi9BtmArZNIPhtCfQSqsdzcoM7mGh6oZBkpa04w+s6dcss8q5wpADlVicty281av
 AHV2H7lY5OPq1gLE4nKbwStaCJl7bQPup7IY46y0Dcti5WMFqswGVTTTD8CkfM1Lwjc1
 kf1+CaXtIij0JvA5vM1iibY403CP3LuODrmxkxvhvHtMDa2yxi099Te9bjovsz/5Qlan
 RofA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=B0a+QLYU8yk8rpZxCeahu7ArgLuOKIggwkFp2e9FmX0=;
 b=cqq9vcVjwP3N1FSCxI8EtyPq28uW9kJztBoCuvu6oJll0g1HTe0A65Bl6Ojop7Uf9r
 DpNcPVnEzWaWdLvpFMaW3KtVBNiJtPvMPf7KyuF1EKqVeb/CmKzJ34eZSt9nXRTYPgCV
 Po6x6aS52PIZP13YYFkthAyC8m1yaqlpGjxLRpxSXXVznpHpTYd/iaZE9dXhDcFG48wu
 vzU1vy6+N2Gx4iKoYPefAj2Wfdu/86ql3uGa1qCnWLRVuT6VtmC/LwFS0weIhlgszw0j
 QOi5iTJAoBPtqcV0mcSlMyoFyiEmv5v3UlvYmtmKYvPfENRivQaeUMo/8TEvYaqeQUkU
 Qxtg==
X-Gm-Message-State: AOAM530U5lmhG89nSFrZrpVKFBHzJ5Otk4LdgCO93oiDDQICol7B9N4z
 d9O/BYdw99X8eZDugucuzLyaxFX9BQGwjLFeNh8=
X-Google-Smtp-Source: ABdhPJzi0NOmnYE2zpx5CfD6Kjh6mYelRr1QlbqbUn07IET0Vcz1cTqnTm45Vpa7lnWh25cLrpiyxviwOB+A0nlOjUc=
X-Received: by 2002:a6b:b503:: with SMTP id e3mr22381032iof.175.1592248287794; 
 Mon, 15 Jun 2020 12:11:27 -0700 (PDT)
MIME-Version: 1.0
References: <1591625864-31494-1-git-send-email-bmeng.cn@gmail.com>
 <1591625864-31494-13-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1591625864-31494-13-git-send-email-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 15 Jun 2020 12:02:04 -0700
Message-ID: <CAKmqyKOGMBhrHU+d1FO4NhPrPuK5tb09xV9SGZP5-xYdKwfSaQ@mail.gmail.com>
Subject: Re: [PATCH 12/15] hw/riscv: sifive: Change SiFive E/U CPU reset
 vector to 0x1004
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d43;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd43.google.com
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

On Mon, Jun 8, 2020 at 7:27 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> From: Bin Meng <bin.meng@windriver.com>
>
> Per the SiFive manual, all E/U series CPU cores' reset vector is
> at 0x1004. Update our codes to match the hardware.
>
> Signed-off-by: Bin Meng <bin.meng@windriver.com>
> ---
>
>  hw/riscv/sifive_e.c | 8 +++++---
>  hw/riscv/sifive_u.c | 6 +++---
>  target/riscv/cpu.c  | 4 ++--
>  3 files changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
> index 8fab152..f05cabd 100644
> --- a/hw/riscv/sifive_e.c
> +++ b/hw/riscv/sifive_e.c
> @@ -98,9 +98,11 @@ static void sifive_e_machine_init(MachineState *machine)
>          memmap[SIFIVE_E_DTIM].base, main_mem);
>
>      /* Mask ROM reset vector */
> -    uint32_t reset_vec[2] = {
> -        0x204002b7,        /* 0x1000: lui     t0,0x20400 */
> -        0x00028067,        /* 0x1004: jr      t0 */
> +    uint32_t reset_vec[4] = {
> +        0x00000000,
> +        0x204002b7,        /* 0x1004: lui     t0,0x20400 */
> +        0x00028067,        /* 0x1008: jr      t0 */
> +        0x00000000,
>      };
>
>      /* copy in the reset vector in little_endian byte order */
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
> index 5060534..1944ad6 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -139,7 +139,7 @@ static void rvnn_gcsu_priv1_10_0_cpu_init(Object *obj)
>      CPURISCVState *env = &RISCV_CPU(obj)->env;
>      set_misa(env, RVXLEN | RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU);
>      set_priv_version(env, PRIV_VERSION_1_10_0);
> -    set_resetvec(env, DEFAULT_RSTVEC);
> +    set_resetvec(env, 0x1004);
>  }
>
>  static void rvnn_imacu_nommu_cpu_init(Object *obj)
> @@ -147,7 +147,7 @@ static void rvnn_imacu_nommu_cpu_init(Object *obj)
>      CPURISCVState *env = &RISCV_CPU(obj)->env;
>      set_misa(env, RVXLEN | RVI | RVM | RVA | RVC | RVU);
>      set_priv_version(env, PRIV_VERSION_1_10_0);
> -    set_resetvec(env, DEFAULT_RSTVEC);
> +    set_resetvec(env, 0x1004);

I know the Ibex CPU does the same thing, but I'm a little worried about this.

At this rate we will have multiple generic (rvx_im*_cpu_init()) CPUs
that don't have generic reset vectors. It might be best to rename the
functions to match the actual CPUs in this case.

Alistair

>      qdev_prop_set_bit(DEVICE(obj), "mmu", false);
>  }
>
> --
> 2.7.4
>
>

