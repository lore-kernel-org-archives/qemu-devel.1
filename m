Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 182C4C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 16:21:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D981420657
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 16:21:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rg2BZ3Zc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D981420657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7htP-0006tS-3i
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 12:21:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41548)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1k7hoB-0005rJ-FK; Mon, 17 Aug 2020 12:16:27 -0400
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:34656)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1k7ho9-0004mk-AC; Mon, 17 Aug 2020 12:16:27 -0400
Received: by mail-il1-x143.google.com with SMTP id t4so15018324iln.1;
 Mon, 17 Aug 2020 09:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qZE1Tuyn+M7SjfNc5uSihI4JjDR7JOckLeyw6fkGEaI=;
 b=rg2BZ3ZcopPzPzopsNcGe8lJ/InuNZ6PDTyFB0fNfhsbAEXgHepboMwtlfMh0w8FIv
 sTd5xQIHiWwMcEGToko4EeBMe3InZEKDNSpnj9Q/3Ui5PY432EIjXWMTVs605T53LlEg
 2NvwpcrpczZh/6dQq8EHByCC1xCbRkMh/5m1Sq9D5KER7tvyg2HtfRakoEhF8zf6XAsL
 U8EwULIvT5e61RH8hYcM6V8TB0aRCnND7wbR9bacQrSeHdBsMpcXQZmVsF8Oy6quS6wl
 XXlvP1nTIFwFgtDcqaDJzMBJ0BZrWBPcyBz+Ytdt7L+XCh1vTKQT+T8kCop0DtxxEwvD
 ie5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qZE1Tuyn+M7SjfNc5uSihI4JjDR7JOckLeyw6fkGEaI=;
 b=WubyUnw20kwm4LXHCJ5makeTSzcvBXh3ZpJ/V0Cn4PNA1NAA4DkRNo/O7hILnPrICY
 Q0FO4xg3rV41EytVDAOZO5G6C4wgzPjwpNk72c8BXyDJjnI1s+LrWSPuhoOQdszPHTtM
 +kVG80/sDDbjteQEhLd2R5/CYAymugQGvnQ3NBQ0QQZEecbdmLBY1EliMbMOrZFl/Ads
 9pAX3nyS3gkvbGuITmhSXbTgS1CnD0Zt5W3mzp3c/PnLZmsbY8iVMWYNmXsR9SWEGGIk
 R6jv14KgWU5CVJKea48+kOuy8bbAh5s4sacadMqSiPZs9m8oz8SWjCwyNmN6Z7Rdcj7t
 5Pxw==
X-Gm-Message-State: AOAM5327TvbAdcyV5pRFo4zLn1NOQn2+anR8NbeMmEHJSwszmskXwADw
 yB/QcxvRFrTMo6bQAPHUm/BmcwOcjqVX18mgxTA=
X-Google-Smtp-Source: ABdhPJxOzm52uXgvi/FcdWz0ZMHJlKw35HucRYt3LEsKePPMiL+Ym1QU54q+sd3m49UEdJJK5iNxwVKgs2Iu6Cmjl3w=
X-Received: by 2002:a05:6e02:ed4:: with SMTP id
 i20mr14536879ilk.267.1597680983610; 
 Mon, 17 Aug 2020 09:16:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200814035819.1214-1-jiangyifei@huawei.com>
In-Reply-To: <20200814035819.1214-1-jiangyifei@huawei.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 17 Aug 2020 09:05:52 -0700
Message-ID: <CAKmqyKMmvjdR2GutBvmmyk5C-CMSB-ZUrOsGeV=eAR0h8bFyOw@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: Fix bug in getting trap cause name for
 trace_riscv_trap
To: Yifei Jiang <jiangyifei@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::143;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x143.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>, zhang.zhanghailiang@huawei.com,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 victor.zhangxiaofeng@huawei.com,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>, yinyipeng1@huawei.com,
 Palmer Dabbelt <palmer@dabbelt.com>, wu.wubin@huawei.com,
 "dengkai \(A\)" <dengkai1@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 13, 2020 at 9:00 PM Yifei Jiang <jiangyifei@huawei.com> wrote:
>
> When the cause number is equal to or greater than 23, print "(unknown)" in
> trace_riscv_trap. The max valid number of riscv_excp_names is 23, so the last
> excpetion "guest_store_page_fault" can not be printed.
>
> In addition, the current check of cause is invalid for riscv_intr_names. So
> introduce riscv_cpu_get_trap_name to get the trap cause name.
>
> Signed-off-by: Yifei Jiang <jiangyifei@huawei.com>
> Signed-off-by: Yipeng Yin <yinyipeng1@huawei.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Applied to riscv-to-apply.next

Alistair

> ---
>  target/riscv/cpu.c        | 11 +++++++++++
>  target/riscv/cpu.h        |  1 +
>  target/riscv/cpu_helper.c |  4 ++--
>  3 files changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 228b9bdb5d..bcdce85c5e 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -96,6 +96,17 @@ const char * const riscv_intr_names[] = {
>      "reserved"
>  };
>
> +const char *riscv_cpu_get_trap_name(target_ulong cause, bool async)
> +{
> +    if (async) {
> +        return (cause < ARRAY_SIZE(riscv_intr_names)) ?
> +               riscv_intr_names[cause] : "(unknown)";
> +    } else {
> +        return (cause < ARRAY_SIZE(riscv_excp_names)) ?
> +               riscv_excp_names[cause] : "(unknown)";
> +    }
> +}
> +
>  static void set_misa(CPURISCVState *env, target_ulong misa)
>  {
>      env->misa_mask = env->misa = misa;
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index a804a5d0ba..7c72979f6a 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -312,6 +312,7 @@ extern const char * const riscv_fpr_regnames[];
>  extern const char * const riscv_excp_names[];
>  extern const char * const riscv_intr_names[];
>
> +const char *riscv_cpu_get_trap_name(target_ulong cause, bool async);
>  void riscv_cpu_do_interrupt(CPUState *cpu);
>  int riscv_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
>  int riscv_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 75d2ae3434..2e047f0948 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -877,8 +877,8 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>          }
>      }
>
> -    trace_riscv_trap(env->mhartid, async, cause, env->pc, tval, cause < 23 ?
> -        (async ? riscv_intr_names : riscv_excp_names)[cause] : "(unknown)");
> +    trace_riscv_trap(env->mhartid, async, cause, env->pc, tval,
> +        riscv_cpu_get_trap_name(cause, async));
>
>      if (env->priv <= PRV_S &&
>              cause < TARGET_LONG_BITS && ((deleg >> cause) & 1)) {
> --
> 2.19.1
>
>
>

