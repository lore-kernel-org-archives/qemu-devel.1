Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3591BC49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 14:03:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0071F20644
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 14:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="YJh9N4qF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0071F20644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBJV0-0003OE-PX
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 10:03:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58177)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@sifive.com>) id 1iBJTM-0002rM-N4
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 10:01:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@sifive.com>) id 1iBJTJ-0006pO-Sq
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 10:01:19 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:47046)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@sifive.com>) id 1iBJTJ-0006ox-Nn
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 10:01:17 -0400
Received: by mail-io1-xd43.google.com with SMTP id c6so3190997ioo.13
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 07:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
 :content-transfer-encoding;
 bh=rKgJEebPfoisKf23Nda39qUbX8jwzUziPhdGX0qWHzo=;
 b=YJh9N4qF7eJPp5t3vOmqxe8/Jp8w6lZVLPDt/7LfrUPvScTeG6pJ8OBuTWV68Z9rAj
 kTGLEWL8cUA4IjALGfPUk68WOhpjgj9O0e2hNsDHB1KnHaVSp09IqkmtUUNJf28DU/mp
 Py7iTnp/m8Lb0ayXnw+ZBoqI6MA9wfv0BIgvbpbwxpmUxlJkbFBW9VMlhQqJPMnUQEzh
 BgTMGQvjpi6N/XSzJgmKWiE3ibmE71PqofKh8N+CT4JzR0+lUs5R7lEl3tlh8RSme63+
 a6d/qUXxrdhgfN/fPk9w6FI/Mv6XeItALtbVBBQ06XTSUvx+lJ08kuErsj3FXNUdNcZW
 zrCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=rKgJEebPfoisKf23Nda39qUbX8jwzUziPhdGX0qWHzo=;
 b=lPpVqJ+rf/1CmpS0U7uoD304fyLzgaQnmAl3KuFU8yIhIaV8aDotb+xqOKzVHI34Dq
 OQYkp7J8+pPwiL6Aeb8rQuBSKEtW2xbxfwt3yewphpkyRJO5aAvWyhOzO7jRy6hd0tvD
 qbSCWencC8IMQFfjeiQdcuYsKSwr7W7bCvzYsvQWgNjdZwHGx90JXsj9dd+L0g63+SAL
 3J9x18Goa4N/XMErVirYTaJjx56CYF5ZLmT3OLbIesV2aemmx3KuPLwShBlhMrFkb++f
 vI3bZdIQLkYAEu3sBbauDmJX+Ck428ribgdUmzqygg+ol6/XgaLFNzTTPUsu1k03Sn0K
 hCdQ==
X-Gm-Message-State: APjAAAUiAf3o/hDqYSc7RbWzzgbOXEzLCTLAx/5vbjWf8qNzdOAY6dIB
 K/mC4OXmQTUgYW4F+ni/S9eyvxX8Quk=
X-Google-Smtp-Source: APXvYqwKq1AoxmE9Dl1WwGDzPQL659l21iSB1oxH4vPg7QvsK7zTxghSHD3aQ4mnc4nGgas0/gEVcA==
X-Received: by 2002:a6b:9085:: with SMTP id s127mr14715737iod.26.1568988076212; 
 Fri, 20 Sep 2019 07:01:16 -0700 (PDT)
Received: from localhost ([8.46.73.109])
 by smtp.gmail.com with ESMTPSA id f12sm3439165iob.58.2019.09.20.07.01.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2019 07:01:15 -0700 (PDT)
Date: Fri, 20 Sep 2019 07:01:15 -0700 (PDT)
X-Google-Original-Date: Fri, 20 Sep 2019 07:01:07 PDT (-0700)
Subject: Re: [PATCH v1 16/28] target/riscv: Add hypvervisor trap support
In-Reply-To: <f8cb17bfb8abe59261394c36d915c2eabd2f4703.1566603412.git.alistair.francis@wdc.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: Alistair Francis <Alistair.Francis@wdc.com>
Message-ID: <mhng-5090a31d-34ee-455b-bb77-965a09e5bd94@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d43
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

On Fri, 23 Aug 2019 16:38:31 PDT (-0700), Alistair Francis wrote:
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/cpu_bits.h   |  4 +--
>  target/riscv/cpu_helper.c | 71 +++++++++++++++++++++++++++++++++------
>  target/riscv/csr.c        |  4 +--
>  3 files changed, 65 insertions(+), 14 deletions(-)
>
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index 5cee72b726..353fc9a24a 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -513,8 +513,8 @@
>  #define RISCV_EXCP_STORE_AMO_ADDR_MIS      0x6
>  #define RISCV_EXCP_STORE_AMO_ACCESS_FAULT  0x7
>  #define RISCV_EXCP_U_ECALL                 0x8
> -#define RISCV_EXCP_S_ECALL                 0x9
> -#define RISCV_EXCP_H_ECALL                 0xa
> +#define RISCV_EXCP_HS_ECALL                0x9
> +#define RISCV_EXCP_VS_ECALL                0xa
>  #define RISCV_EXCP_M_ECALL                 0xb
>  #define RISCV_EXCP_INST_PAGE_FAULT         0xc /* since: priv-1.10.0 */
>  #define RISCV_EXCP_LOAD_PAGE_FAULT         0xd /* since: priv-1.10.0 */
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 8e8b156fc0..17eec6217b 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -668,6 +668,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>
>      RISCVCPU *cpu = RISCV_CPU(cs);
>      CPURISCVState *env = &cpu->env;
> +    target_ulong s;
>
>      /* cs->exception is 32-bits wide unlike mcause which is XLEN-bits wide
>       * so we mask off the MSB and separate into trap type and cause.
> @@ -677,13 +678,6 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>      target_ulong deleg = async ? env->mideleg : env->medeleg;
>      target_ulong tval = 0;
>
> -    static const int ecall_cause_map[] = {
> -        [PRV_U] = RISCV_EXCP_U_ECALL,
> -        [PRV_S] = RISCV_EXCP_S_ECALL,
> -        [PRV_H] = RISCV_EXCP_H_ECALL,
> -        [PRV_M] = RISCV_EXCP_M_ECALL
> -    };
> -
>      if (!async) {
>          /* set tval to badaddr for traps with address information */
>          switch (cause) {
> @@ -704,7 +698,16 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>          /* ecall is dispatched as one cause so translate based on mode */
>          if (cause == RISCV_EXCP_U_ECALL) {
>              assert(env->priv <= 3);
> -            cause = ecall_cause_map[env->priv];
> +
> +            if (env->priv == PRV_M) {
> +                cause = RISCV_EXCP_M_ECALL;
> +            } else if (env->priv == PRV_S && riscv_cpu_virt_enabled(env)) {
> +                cause = RISCV_EXCP_VS_ECALL;
> +            } else if (env->priv == PRV_S && !riscv_cpu_virt_enabled(env)) {
> +                cause = RISCV_EXCP_HS_ECALL;
> +            } else if (env->priv == PRV_U) {
> +                cause = RISCV_EXCP_U_ECALL;
> +            }
>          }
>      }
>
> @@ -714,7 +717,42 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>      if (env->priv <= PRV_S &&
>              cause < TARGET_LONG_BITS && ((deleg >> cause) & 1)) {
>          /* handle the trap in S-mode */
> -        target_ulong s = *env->mstatus;
> +        if (riscv_has_ext(env, RVH)) {
> +            target_ulong hdeleg = async ? env->hideleg : env->hedeleg;
> +
> +            if (riscv_cpu_virt_enabled(env) && ((hdeleg >> cause) & 1) &&
> +                !riscv_cpu_force_hs_excep_enabled(env)) {
> +                /* Trap to VS mode */
> +            } else if (riscv_cpu_virt_enabled(env)) {
> +                /* Trap into HS mode, from virt */
> +                riscv_cpu_swap_hypervisor_regs(env);
> +                env->hstatus = set_field(env->hstatus, HSTATUS_SP2V,
> +                                         get_field(env->hstatus, HSTATUS_SPV));
> +                env->hstatus = set_field(env->hstatus, HSTATUS_SP2P,
> +                                         get_field(*env->mstatus, SSTATUS_SPP));
> +                env->hstatus = set_field(env->hstatus, HSTATUS_SPV,
> +                                         riscv_cpu_virt_enabled(env));
> +
> +                if (riscv_cpu_force_hs_excep_enabled(env)) {
> +                    env->hstatus = set_field(env->hstatus, HSTATUS_STL, 1);
> +                } else {
> +                    env->hstatus = set_field(env->hstatus, HSTATUS_STL, 0);
> +                }
> +
> +                riscv_cpu_set_virt_enabled(env, VIRT_OFF);
> +                riscv_cpu_set_force_hs_excep(env, CLEAR_HS_EXCEP);
> +            } else {
> +                /* Trap into HS mode */
> +                env->hstatus = set_field(env->hstatus, HSTATUS_SP2V,
> +                                         get_field(env->hstatus, HSTATUS_SPV));
> +                env->hstatus = set_field(env->hstatus, HSTATUS_SP2P,
> +                                         get_field(*env->mstatus, SSTATUS_SPP));
> +                env->hstatus = set_field(env->hstatus, HSTATUS_SPV,
> +                                         riscv_cpu_virt_enabled(env));
> +            }
> +        }
> +
> +        s = *env->mstatus;
>          s = set_field(s, MSTATUS_SPIE, env->priv_ver >= PRIV_VERSION_1_10_0 ?
>              get_field(s, MSTATUS_SIE) : get_field(s, MSTATUS_UIE << env->priv));
>          s = set_field(s, MSTATUS_SPP, env->priv);
> @@ -728,7 +766,20 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>          riscv_cpu_set_mode(env, PRV_S);
>      } else {
>          /* handle the trap in M-mode */
> -        target_ulong s = *env->mstatus;
> +        if (riscv_has_ext(env, RVH)) {
> +            if (riscv_cpu_virt_enabled(env)) {
> +                riscv_cpu_swap_hypervisor_regs(env);
> +            }
> +            *env->mstatus = set_field(*env->mstatus, MSTATUS_MPV,
> +                                      riscv_cpu_virt_enabled(env));
> +            *env->mstatus = set_field(*env->mstatus, MSTATUS_MTL,
> +                                      riscv_cpu_force_hs_excep_enabled(env));
> +
> +            /* Trapping to M mode, virt is disabled */
> +            riscv_cpu_set_virt_enabled(env, VIRT_OFF);
> +        }
> +
> +        s = *env->mstatus;
>          s = set_field(s, MSTATUS_MPIE, env->priv_ver >= PRIV_VERSION_1_10_0 ?
>              get_field(s, MSTATUS_MIE) : get_field(s, MSTATUS_UIE << env->priv));
>          s = set_field(s, MSTATUS_MPP, env->priv);
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 30ec8c0a8e..47be4b1d42 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -255,8 +255,8 @@ static const target_ulong delegable_excps =
>      (1ULL << (RISCV_EXCP_STORE_AMO_ADDR_MIS)) |
>      (1ULL << (RISCV_EXCP_STORE_AMO_ACCESS_FAULT)) |
>      (1ULL << (RISCV_EXCP_U_ECALL)) |
> -    (1ULL << (RISCV_EXCP_S_ECALL)) |
> -    (1ULL << (RISCV_EXCP_H_ECALL)) |
> +    (1ULL << (RISCV_EXCP_VS_ECALL)) |
> +    (1ULL << (RISCV_EXCP_HS_ECALL)) |
>      (1ULL << (RISCV_EXCP_M_ECALL)) |
>      (1ULL << (RISCV_EXCP_INST_PAGE_FAULT)) |
>      (1ULL << (RISCV_EXCP_LOAD_PAGE_FAULT)) |

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>

