Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3972EC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 20:09:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00C732074D
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 20:09:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DlOs3p/Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00C732074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jelJN-0007ve-5h
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 16:09:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40608)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jelIl-0007OM-0j; Fri, 29 May 2020 16:08:23 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:32934)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jelIj-0004YH-LM; Fri, 29 May 2020 16:08:22 -0400
Received: by mail-io1-xd44.google.com with SMTP id k18so722334ion.0;
 Fri, 29 May 2020 13:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=g6NWAGbMNWCjgJnmzLtfEzZyHQxkIhxKEMUer2bkSwQ=;
 b=DlOs3p/ZOqX7Rb1iys1ATt7tk60heiUGAs892MkLwMhJ6OM8d+xiAGUsEyMO5Fw/OJ
 vLmk+hLkDI2fb//hDkYAXN7GMsYcK2DmitBTf4JI+y7bDSJVFSjY1u7FCT8SmOA8Oo65
 5UUlasJpvJLBZ5sH9w/vKCFmr4AB5faanqCtMKMHbJnDk0O9QM9wL6q20hatDXuOGOpz
 9PTSgwN99SGMB2Y6cJKB/zQigf6An6eml6lA6I7f905bpnDLh9DFiND53e1jiBzxehDn
 NEENJiuvtmDKRToclXDjwRDTSHOXv9jsboyWCOQMwKVzL36hGbTSa9/0axS9a9Lhj6qC
 qaMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=g6NWAGbMNWCjgJnmzLtfEzZyHQxkIhxKEMUer2bkSwQ=;
 b=E8yr/64hnwJe/aKTut3jj0HF457lTjWTS8l6cA6e53AyYsPkVpv0zKkcAB++NCOwmQ
 CQm2efdZPA6sfBgick7XHrLSjbLSUhfpWLl7kdRVGmSkslE/leuUJQVDZYYkaDO1lX9a
 Mwf1Zdd4p/YOWvloy1tXpsV3VZopsy7daRfN17svBFaWV0fY0pUhgCUJvaAZCBNfC3en
 XNnRgM4Y74y+Rx+MoqjwUDjllZSVxHFSIBNmOeSEgTEnBdTFITEC7yvaEdt8KnJYb4hD
 oPchqnsZuSMzY2apbxcMLub9YW3lI9gnlhWVvwjwfTSU5SsFdoD/UmSP3s2AQYzz6cYw
 t0zA==
X-Gm-Message-State: AOAM532qy2qfCG4Ekhq/5WfnhLmmpCj70L1HbNIqOw3NeDZUrc1gtUa/
 8wA+0fts1TRWsZKX0mAG/sYdc7BGdsazALq8lFw=
X-Google-Smtp-Source: ABdhPJz7sUiOSfNpcqZJY5hZcKvw1FTvR/QzjCNIHK0LYCvOL+OVEpLbCjcICtRQt5vEhst6/7+Bmgj6Ja+itebY7MY=
X-Received: by 2002:a02:6543:: with SMTP id u64mr9152067jab.26.1590782899971; 
 Fri, 29 May 2020 13:08:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200521094413.10425-1-zhiwei_liu@c-sky.com>
 <20200521094413.10425-31-zhiwei_liu@c-sky.com>
In-Reply-To: <20200521094413.10425-31-zhiwei_liu@c-sky.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 29 May 2020 12:59:16 -0700
Message-ID: <CAKmqyKPvOpVuPXnurXktwALmSDfYaGa-NMYwCngMySuH=ARVXg@mail.gmail.com>
Subject: Re: [PATCH v8 30/62] target/riscv: Update fp_status when float
 rounding mode changes
To: LIU Zhiwei <zhiwei_liu@c-sky.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 wxy194768@alibaba-inc.com, wenmeng_zhang@c-sky.com,
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 21, 2020 at 3:45 AM LIU Zhiwei <zhiwei_liu@c-sky.com> wrote:
>
> For scalar float instruction, round mode is encoded in instruction,
> so fp_status is updating dynamiclly.
>
> For vector float instruction, round mode is always frm, so
> update fp_status when frm changes is enough.
>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/csr.c        |  7 +++++++
>  target/riscv/fpu_helper.c | 19 ++++++++++++++-----
>  target/riscv/internals.h  |  3 +++
>  3 files changed, 24 insertions(+), 5 deletions(-)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index d71c49dfff..438093152b 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -22,6 +22,7 @@
>  #include "cpu.h"
>  #include "qemu/main-loop.h"
>  #include "exec/exec-all.h"
> +#include "internals.h"
>
>  /* CSR function table */
>  static riscv_csr_operations csr_ops[];
> @@ -174,6 +175,9 @@ static int write_frm(CPURISCVState *env, int csrno, target_ulong val)
>      env->mstatus |= MSTATUS_FS;
>  #endif
>      env->frm = val & (FSR_RD >> FSR_RD_SHIFT);
> +    if (!riscv_cpu_set_rounding_mode(env, env->frm)) {
> +        return -1;
> +    }
>      return 0;
>  }
>
> @@ -207,6 +211,9 @@ static int write_fcsr(CPURISCVState *env, int csrno, target_ulong val)
>          env->vxsat = (val & FSR_VXSAT) >> FSR_VXSAT_SHIFT;
>      }
>      riscv_cpu_set_fflags(env, (val & FSR_AEXC) >> FSR_AEXC_SHIFT);
> +    if (!riscv_cpu_set_rounding_mode(env, env->frm)) {
> +        return -1;
> +    }
>      return 0;
>  }
>
> diff --git a/target/riscv/fpu_helper.c b/target/riscv/fpu_helper.c
> index 0b79562a69..262610e837 100644
> --- a/target/riscv/fpu_helper.c
> +++ b/target/riscv/fpu_helper.c
> @@ -50,13 +50,10 @@ void riscv_cpu_set_fflags(CPURISCVState *env, target_ulong hard)
>      set_float_exception_flags(soft, &env->fp_status);
>  }
>
> -void helper_set_rounding_mode(CPURISCVState *env, uint32_t rm)
> +bool riscv_cpu_set_rounding_mode(CPURISCVState *env, uint32_t rm)
>  {
>      int softrm;
>
> -    if (rm == 7) {
> -        rm = env->frm;
> -    }
>      switch (rm) {
>      case 0:
>          softrm = float_round_nearest_even;
> @@ -74,10 +71,22 @@ void helper_set_rounding_mode(CPURISCVState *env, uint32_t rm)
>          softrm = float_round_ties_away;
>          break;
>      default:
> -        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
> +        return false;
>      }
>
>      set_float_rounding_mode(softrm, &env->fp_status);
> +    return true;
> +}
> +
> +void helper_set_rounding_mode(CPURISCVState *env, uint32_t rm)
> +{
> +    if (rm == 7) {
> +        rm = env->frm;
> +    }
> +
> +    if (!riscv_cpu_set_rounding_mode(env, rm)) {
> +        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
> +    }
>  }
>
>  uint64_t helper_fmadd_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
> diff --git a/target/riscv/internals.h b/target/riscv/internals.h
> index f699d80c41..52f6af2513 100644
> --- a/target/riscv/internals.h
> +++ b/target/riscv/internals.h
> @@ -27,4 +27,7 @@ FIELD(VDATA, VM, 8, 1)
>  FIELD(VDATA, LMUL, 9, 2)
>  FIELD(VDATA, NF, 11, 4)
>  FIELD(VDATA, WD, 11, 1)
> +
> +/* set float rounding mode */
> +bool riscv_cpu_set_rounding_mode(CPURISCVState *env, uint32_t rm);
>  #endif
> --
> 2.23.0
>
>

