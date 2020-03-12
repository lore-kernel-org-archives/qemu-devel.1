Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE04AC10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 21:03:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8967920674
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 21:03:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s2As3tA1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8967920674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCUz8-0006IF-Mb
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 17:03:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40149)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jCUxp-0006cd-PL
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 17:01:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1jCUxn-0005OW-58
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 17:01:57 -0400
Received: from mail-vs1-xe41.google.com ([2607:f8b0:4864:20::e41]:44985)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1jCUxn-0005Nz-0M; Thu, 12 Mar 2020 17:01:55 -0400
Received: by mail-vs1-xe41.google.com with SMTP id u24so4670233vso.11;
 Thu, 12 Mar 2020 14:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4R41MEPk2ZA0gTOfPqSHaj1gYm86lxSKrDCKmboxA/A=;
 b=s2As3tA1VQvX/vLuQ8CNVJH8zVd/2RYK/b2aVles4/6eKtvSsEg23dQRILNIgE5j/B
 lH1KIVOEhqV6Y55tRhTH1VDsvDN3ZP6MxCaJ6NMaqI1e98kulVnH9froHo8PkBhCbxH5
 D/o8Vu+4VuCN/XPrFTgHRzE56sfhHwAQww+4g3IFcsxZVVzyJJjfGEgSSiWcVQWq+WOb
 zPv6znnfdQcyWbnIMtf16n2EIrxGKZi1kabF6ri057MSHhMXav2Pfd7eHVtyfmJqPtTr
 CNdagOqe9OtllIVJFDo77b9C6Ft1fExWhPE783A67YRHlbHkSgxUGYfQ2DMQeQyMXxx4
 MKPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4R41MEPk2ZA0gTOfPqSHaj1gYm86lxSKrDCKmboxA/A=;
 b=AqMC9e/CoLtMb891ryWkE2QRoywgMN4b0lEOQbAGHf2zPu2uQZ2FZSfiwPBpqpFIki
 +6HuqzaTwNc3iDksgFsxM1kwTAUaueP8r+XkmhOv/1ixAay1AOfHuOHFBzYWJ7+UTlTg
 H/5HrXU6Hx4BbRFrJ9Fpqo1FfkqQVviDlrFU9pussgUDRlfaz+SeApTf92yNyNPbzqX7
 6dwIwjHsflQJ03p006xcYUOmviQNUgp0zr42vI2fZpidgmnjTXfjF1PP+2l2fVmljSgv
 0cOjQsSfw3/VOT8wfTsNzWaGyjjuTANcoiL2n7LFmRd9n9N1huAljFM4hKavkkqapWC3
 xtgg==
X-Gm-Message-State: ANhLgQ3VsBboqUuVS0+ozUpDr2vED5LTJtpjB2qXLG8N+4I8V7isv8En
 L1gxfzl89ko0YDJAC6QwtbgvyOL70m8pWc2ornc=
X-Google-Smtp-Source: ADFU+vsI2nCNUn9N0kA07Bb0eE5jV8UDT/UlID6BHOCTgXO+oX0XB8gL4MyDd8cPTIEp6GhHi9RasoykEdvE00MVesU=
X-Received: by 2002:a67:902:: with SMTP id 2mr6895190vsj.133.1584046913772;
 Thu, 12 Mar 2020 14:01:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200312145900.2054-1-zhiwei_liu@c-sky.com>
 <20200312145900.2054-4-zhiwei_liu@c-sky.com>
In-Reply-To: <20200312145900.2054-4-zhiwei_liu@c-sky.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 12 Mar 2020 13:54:02 -0700
Message-ID: <CAKmqyKPzAOHRmuDUygxmS2DYu=ymDopa8tqUA79UKa2Pm+wVwg@mail.gmail.com>
Subject: Re: [PATCH v5 03/60] target/riscv: support vector extension csr
To: LIU Zhiwei <zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::e41
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
Cc: guoren@linux.alibaba.com, "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 wxy194768@alibaba-inc.com, Chih-Min Chao <chihmin.chao@sifive.com>,
 wenmeng_zhang@c-sky.com, Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Mar 12, 2020 at 8:05 AM LIU Zhiwei <zhiwei_liu@c-sky.com> wrote:
>
> The v0.7.1 specification does not define vector status within mstatus.
> A future revision will define the privileged portion of the vector status.
>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu_bits.h | 15 +++++++++
>  target/riscv/csr.c      | 75 ++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 89 insertions(+), 1 deletion(-)
>
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index 7f64ee1174..8117e8b5a7 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -29,6 +29,14 @@
>  #define FSR_NXA             (FPEXC_NX << FSR_AEXC_SHIFT)
>  #define FSR_AEXC            (FSR_NVA | FSR_OFA | FSR_UFA | FSR_DZA | FSR_NXA)
>
> +/* Vector Fixed-Point round model */
> +#define FSR_VXRM_SHIFT      9
> +#define FSR_VXRM            (0x3 << FSR_VXRM_SHIFT)
> +
> +/* Vector Fixed-Point saturation flag */
> +#define FSR_VXSAT_SHIFT     8
> +#define FSR_VXSAT           (0x1 << FSR_VXSAT_SHIFT)
> +
>  /* Control and Status Registers */
>
>  /* User Trap Setup */
> @@ -48,6 +56,13 @@
>  #define CSR_FRM             0x002
>  #define CSR_FCSR            0x003
>
> +/* User Vector CSRs */
> +#define CSR_VSTART          0x008
> +#define CSR_VXSAT           0x009
> +#define CSR_VXRM            0x00a
> +#define CSR_VL              0xc20
> +#define CSR_VTYPE           0xc21
> +
>  /* User Timers and Counters */
>  #define CSR_CYCLE           0xc00
>  #define CSR_TIME            0xc01
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 11d184cd16..d71c49dfff 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -46,6 +46,10 @@ void riscv_set_csr_ops(int csrno, riscv_csr_operations *ops)
>  static int fs(CPURISCVState *env, int csrno)
>  {
>  #if !defined(CONFIG_USER_ONLY)
> +    /* loose check condition for fcsr in vector extension */
> +    if ((csrno == CSR_FCSR) && (env->misa & RVV)) {
> +        return 0;
> +    }
>      if (!env->debugger && !riscv_cpu_fp_enabled(env)) {
>          return -1;
>      }
> @@ -53,6 +57,14 @@ static int fs(CPURISCVState *env, int csrno)
>      return 0;
>  }
>
> +static int vs(CPURISCVState *env, int csrno)
> +{
> +    if (env->misa & RVV) {
> +        return 0;
> +    }
> +    return -1;
> +}
> +
>  static int ctr(CPURISCVState *env, int csrno)
>  {
>  #if !defined(CONFIG_USER_ONLY)
> @@ -174,6 +186,10 @@ static int read_fcsr(CPURISCVState *env, int csrno, target_ulong *val)
>  #endif
>      *val = (riscv_cpu_get_fflags(env) << FSR_AEXC_SHIFT)
>          | (env->frm << FSR_RD_SHIFT);
> +    if (vs(env, csrno) >= 0) {
> +        *val |= (env->vxrm << FSR_VXRM_SHIFT)
> +                | (env->vxsat << FSR_VXSAT_SHIFT);
> +    }
>      return 0;
>  }
>
> @@ -186,10 +202,62 @@ static int write_fcsr(CPURISCVState *env, int csrno, target_ulong val)
>      env->mstatus |= MSTATUS_FS;
>  #endif
>      env->frm = (val & FSR_RD) >> FSR_RD_SHIFT;
> +    if (vs(env, csrno) >= 0) {
> +        env->vxrm = (val & FSR_VXRM) >> FSR_VXRM_SHIFT;
> +        env->vxsat = (val & FSR_VXSAT) >> FSR_VXSAT_SHIFT;
> +    }
>      riscv_cpu_set_fflags(env, (val & FSR_AEXC) >> FSR_AEXC_SHIFT);
>      return 0;
>  }
>
> +static int read_vtype(CPURISCVState *env, int csrno, target_ulong *val)
> +{
> +    *val = env->vtype;
> +    return 0;
> +}
> +
> +static int read_vl(CPURISCVState *env, int csrno, target_ulong *val)
> +{
> +    *val = env->vl;
> +    return 0;
> +}
> +
> +static int read_vxrm(CPURISCVState *env, int csrno, target_ulong *val)
> +{
> +    *val = env->vxrm;
> +    return 0;
> +}
> +
> +static int write_vxrm(CPURISCVState *env, int csrno, target_ulong val)
> +{
> +    env->vxrm = val;
> +    return 0;
> +}
> +
> +static int read_vxsat(CPURISCVState *env, int csrno, target_ulong *val)
> +{
> +    *val = env->vxsat;
> +    return 0;
> +}
> +
> +static int write_vxsat(CPURISCVState *env, int csrno, target_ulong val)
> +{
> +    env->vxsat = val;
> +    return 0;
> +}
> +
> +static int read_vstart(CPURISCVState *env, int csrno, target_ulong *val)
> +{
> +    *val = env->vstart;
> +    return 0;
> +}
> +
> +static int write_vstart(CPURISCVState *env, int csrno, target_ulong val)
> +{
> +    env->vstart = val;
> +    return 0;
> +}
> +
>  /* User Timers and Counters */
>  static int read_instret(CPURISCVState *env, int csrno, target_ulong *val)
>  {
> @@ -1269,7 +1337,12 @@ static riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
>      [CSR_FFLAGS] =              { fs,   read_fflags,      write_fflags      },
>      [CSR_FRM] =                 { fs,   read_frm,         write_frm         },
>      [CSR_FCSR] =                { fs,   read_fcsr,        write_fcsr        },
> -
> +    /* Vector CSRs */
> +    [CSR_VSTART] =              { vs,   read_vstart,      write_vstart      },
> +    [CSR_VXSAT] =               { vs,   read_vxsat,       write_vxsat       },
> +    [CSR_VXRM] =                { vs,   read_vxrm,        write_vxrm        },
> +    [CSR_VL] =                  { vs,   read_vl                             },
> +    [CSR_VTYPE] =               { vs,   read_vtype                          },
>      /* User Timers and Counters */
>      [CSR_CYCLE] =               { ctr,  read_instret                        },
>      [CSR_INSTRET] =             { ctr,  read_instret                        },
> --
> 2.23.0
>

