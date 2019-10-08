Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F3BAC4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 18:38:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04D6B206C0
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 18:37:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04D6B206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHuMw-00089H-SR
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 14:37:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39418)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1iHuLu-000761-08
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 14:36:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1iHuLs-0001lm-Mi
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 14:36:53 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34437)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1iHuLs-0001lL-HO
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 14:36:52 -0400
Received: by mail-pl1-f193.google.com with SMTP id k7so8852371pll.1
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 11:36:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=WA3BSFZ8RONqPYJHwcelSXyfYIVhgyy/6OnQZPLBwAU=;
 b=W5fRFJp6ebCMSwgTrjKkIR1p287gpeP7nLHP5rrJvUCs4G904qKBbiqorDFOj8UtSM
 QxUgQ22yOM/lqey6lduCn96d09axv4ypMal+/g/SdPp8tfThza/C+v9WycnyIEiv7gN9
 BkV+W5sdwO9Ix7wxmNyYoQAH8QtLIOSSjnPIHbb/KmhWJrEvISPm8tZcBeO5ZJog0bQx
 etI1bgukvPqcuUMdilvsvbYl3rsdOCcYWxEi0/MMZps53Yuh4T7Y7AHgPIF40tRpN4Ba
 x6mw1h7R2oSKQmul0a0lh8445OwcCqsW2AFG9xIIojT+XgfzMuvxri6LMxecmx+lGqvA
 LlWA==
X-Gm-Message-State: APjAAAXUQwqhq/3EFo5foY3M8BqGAvHEsn9xQ7e+5d+bwCyf4wA1syAm
 1gv40YPr9TeCkkP6PH6XFGcd/4Jvvfo=
X-Google-Smtp-Source: APXvYqyxj666HhKRrcZj1h2ZAa1wCZlPOWsUwh7z+cTBoJbkfg6MqQTFPpmjX6MH3fL3P29N2msglg==
X-Received: by 2002:a17:902:ba87:: with SMTP id
 k7mr36911520pls.244.1570559811025; 
 Tue, 08 Oct 2019 11:36:51 -0700 (PDT)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id 2sm19198780pfa.43.2019.10.08.11.36.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2019 11:36:50 -0700 (PDT)
Date: Tue, 08 Oct 2019 11:36:50 -0700 (PDT)
X-Google-Original-Date: Tue, 08 Oct 2019 11:36:39 PDT (-0700)
Subject: Re: [PATCH v1 27/28] target/riscv: Add the MSTATUS_MPV_ISSET helper
 macro
In-Reply-To: <c7961e38284feb8de1180173bf92c78153fd6970.1566603412.git.alistair.francis@wdc.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: Alistair Francis <Alistair.Francis@wdc.com>
Message-ID: <mhng-bbcac2a5-ee88-404e-a755-420242ec0153@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.214.193
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

On Fri, 23 Aug 2019 16:39:00 PDT (-0700), Alistair Francis wrote:
> Add a helper macro MSTATUS_MPV_ISSET() which will determine if the
> MSTATUS_MPV bit is set for both 32-bit and 64-bit RISC-V.
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/cpu_bits.h   | 11 +++++++++++
>  target/riscv/cpu_helper.c |  4 ++--
>  target/riscv/op_helper.c  |  2 +-
>  target/riscv/translate.c  |  2 +-
>  4 files changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index 55e20af6d9..7056d9218b 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -365,8 +365,19 @@
>  #define MSTATUS_TVM         0x00100000 /* since: priv-1.10 */
>  #define MSTATUS_TW          0x20000000 /* since: priv-1.10 */
>  #define MSTATUS_TSR         0x40000000 /* since: priv-1.10 */
> +#if defined(TARGET_RISCV64)
>  #define MSTATUS_MTL         0x4000000000ULL
>  #define MSTATUS_MPV         0x8000000000ULL
> +#elif defined(TARGET_RISCV32)
> +#define MSTATUS_MTL         0x00000040
> +#define MSTATUS_MPV         0x00000080
> +#endif
> +
> +#ifdef TARGET_RISCV32
> +# define MSTATUS_MPV_ISSET(env)  get_field(*env->mstatush, MSTATUS_MPV)
> +#else
> +# define MSTATUS_MPV_ISSET(env)  get_field(*env->mstatus, MSTATUS_MPV)
> +#endif
>
>  #define MSTATUS64_UXL       0x0000000300000000ULL
>  #define MSTATUS64_SXL       0x0000000C00000000ULL
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 8c80486dd0..2b88f756bb 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -351,7 +351,7 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
>              mode = get_field(*env->mstatus, MSTATUS_MPP);
>
>              if (riscv_has_ext(env, RVH) &&
> -                get_field(*env->mstatus, MSTATUS_MPV)) {
> +                MSTATUS_MPV_ISSET(env)) {
>                  use_background = true;
>              }
>          }
> @@ -730,7 +730,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>          m_mode_two_stage = env->priv == PRV_M &&
>                             access_type != MMU_INST_FETCH &&
>                             get_field(*env->mstatus, MSTATUS_MPRV) &&
> -                           get_field(*env->mstatus, MSTATUS_MPV);
> +                           MSTATUS_MPV_ISSET(env);
>
>          hs_mode_two_stage = env->priv == PRV_S &&
>                              !riscv_cpu_virt_enabled(env) &&
> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> index 8dec1aee99..6149cd9c15 100644
> --- a/target/riscv/op_helper.c
> +++ b/target/riscv/op_helper.c
> @@ -146,7 +146,7 @@ target_ulong helper_mret(CPURISCVState *env, target_ulong cpu_pc_deb)
>
>      target_ulong mstatus = *env->mstatus;
>      target_ulong prev_priv = get_field(mstatus, MSTATUS_MPP);
> -    target_ulong prev_virt = get_field(mstatus, MSTATUS_MPV);
> +    target_ulong prev_virt = MSTATUS_MPV_ISSET(env);
>      mstatus = set_field(mstatus,
>          env->priv_ver >= PRIV_VERSION_1_10_0 ?
>          MSTATUS_MIE : MSTATUS_UIE << prev_priv,
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index ea19ba9c5d..f0d9860429 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -754,7 +754,7 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
>          ctx->virt_enabled = riscv_cpu_virt_enabled(env);
>          if (env->priv_ver == PRV_M &&
>              get_field(*env->mstatus, MSTATUS_MPRV) &&
> -            get_field(*env->mstatus, MSTATUS_MPV)) {
> +            MSTATUS_MPV_ISSET(env)) {
>              ctx->virt_enabled = true;
>          } else if (env->priv == PRV_S &&
>                     !riscv_cpu_virt_enabled(env) &&

This should be either ordered before or atomic with the patch that allows 
mstatush.mpv to be set, as otherwise there's point at which QEMU doesn't match 
the ISA.

