Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2CF0C49ED7
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 15:04:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C799E20863
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 15:04:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C799E20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7hgx-0008L1-ED
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 11:04:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54881)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1i7hRH-0000Q3-PM
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 10:48:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1i7hRF-0006Ra-2j
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 10:48:15 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46193)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1i7hRE-0006Qm-EM
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 10:48:12 -0400
Received: by mail-wr1-f68.google.com with SMTP id d17so8092519wrq.13
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 07:48:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=sX5dnt1H0NPzA1MYbZxhDL297HTdjTWHoyxd1DtQJi0=;
 b=TLdaYrLS77uFfCNsWg8xkpjEraimzp0YBRQFreK4dymSXm5gn+zDM9QgzVb6jK1gqT
 Ml3/wxHDK21yFEqNyCn3/SgMvcRoCP6Kt2yUSF3K+A0EelbjT4Hd6XAkvesZue9HK+iD
 S47dc40jg2IBYD2Z030oRjz81DNIiYHyVCwvR3Xt0FRQaBnhP298HkHJodDUov2QqPgV
 DmIMrjkn0iUgtr18tnLuyGHvr4av+4R3LRHEiqqdrI5INBMYuMTpgCScVIYGZ78t/VNb
 +lEEdJmh9Pkq4mhpVsMfOnIf8MVYo0fzdbVXxGKMyD3m0NiUFUEi69RA+EyLXTYf/lWC
 kdDQ==
X-Gm-Message-State: APjAAAWret3U15hxdjw8ebEplkCGEvTobNoWz/TPij8p9VsJbGjuOg7R
 w9aD/4tDOjYCum4NDuABEau3nvqO8JJfTA==
X-Google-Smtp-Source: APXvYqy2OaAQT8quyLVWn0c0t6YpVOHaynKV1QGiG1AE+5k7B8QeSG+SEh9KhTHOkhK1ZtgQsvGtww==
X-Received: by 2002:a5d:6585:: with SMTP id q5mr25320303wru.162.1568126890787; 
 Tue, 10 Sep 2019 07:48:10 -0700 (PDT)
Received: from localhost ([148.69.85.38])
 by smtp.gmail.com with ESMTPSA id p23sm3240563wma.18.2019.09.10.07.48.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 07:48:10 -0700 (PDT)
Date: Tue, 10 Sep 2019 07:48:10 -0700 (PDT)
X-Google-Original-Date: Tue, 10 Sep 2019 07:44:36 PDT (-0700)
In-Reply-To: <bc32540efd592bc56ef8c4a59ecc142d8dc594a0.1566603412.git.alistair.francis@wdc.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: Alistair Francis <Alistair.Francis@wdc.com>
Message-ID: <mhng-295434c5-b526-4ca5-ae7a-107a7126954f@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH v1 08/28] target/riscv: Add Hypervisor CSR
 access functions
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

On Fri, 23 Aug 2019 16:38:10 PDT (-0700), Alistair Francis wrote:
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/csr.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 471f23a1d0..388775d45a 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -98,6 +98,20 @@ static int smode(CPURISCVState *env, int csrno)
>      return -!riscv_has_ext(env, RVS);
>  }
>
> +static int hmode(CPURISCVState *env, int csrno)
> +{
> +    if (riscv_has_ext(env, RVS) &&
> +        riscv_has_ext(env, RVH)) {
> +        /* Hypervisor extension is supported */
> +        if ((env->priv == PRV_S && !riscv_cpu_virt_enabled(env)) ||
> +            env->priv == PRV_M) {
> +            return 0;
> +        }
> +    }
> +
> +    return -1;
> +}
> +
>  static int pmp(CPURISCVState *env, int csrno)
>  {
>      return -!riscv_feature(env, RISCV_FEATURE_PMP);
> @@ -754,6 +768,55 @@ static int write_satp(CPURISCVState *env, int csrno, target_ulong val)
>      return 0;
>  }
>
> +/* Hypervisor Extensions */
> +static int read_hstatus(CPURISCVState *env, int csrno, target_ulong *val)
> +{
> +    *val = env->hstatus;
> +    return 0;
> +}
> +
> +static int write_hstatus(CPURISCVState *env, int csrno, target_ulong val)
> +{
> +    env->hstatus = val;
> +    return 0;
> +}
> +
> +static int read_hedeleg(CPURISCVState *env, int csrno, target_ulong *val)
> +{
> +    *val = env->hedeleg;
> +    return 0;
> +}
> +
> +static int write_hedeleg(CPURISCVState *env, int csrno, target_ulong val)
> +{
> +    env->hedeleg = val;
> +    return 0;
> +}
> +
> +static int read_hideleg(CPURISCVState *env, int csrno, target_ulong *val)
> +{
> +    *val = env->hideleg;
> +    return 0;
> +}
> +
> +static int write_hideleg(CPURISCVState *env, int csrno, target_ulong val)
> +{
> +    env->hideleg = val;
> +    return 0;
> +}
> +
> +static int read_hgatp(CPURISCVState *env, int csrno, target_ulong *val)
> +{
> +    *val = env->hgatp;
> +    return 0;
> +}
> +
> +static int write_hgatp(CPURISCVState *env, int csrno, target_ulong val)
> +{
> +    env->hgatp = val;
> +    return 0;
> +}
> +
>  /* Physical Memory Protection */
>  static int read_pmpcfg(CPURISCVState *env, int csrno, target_ulong *val)
>  {
> @@ -950,6 +1013,11 @@ static riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
>      /* Supervisor Protection and Translation */
>      [CSR_SATP] =                { smode, read_satp,        write_satp        },
>
> +    [CSR_HSTATUS] =             { hmode,   read_hstatus,     write_hstatus    },
> +    [CSR_HEDELEG] =             { hmode,   read_hedeleg,     write_hedeleg    },
> +    [CSR_HIDELEG] =             { hmode,   read_hideleg,     write_hideleg    },
> +    [CSR_HGATP] =               { hmode,   read_hgatp,       write_hgatp      },
> +
>      /* Physical Memory Protection */
>      [CSR_PMPCFG0  ... CSR_PMPADDR9] =  { pmp,   read_pmpcfg,  write_pmpcfg   },
>      [CSR_PMPADDR0 ... CSR_PMPADDR15] = { pmp,   read_pmpaddr, write_pmpaddr  },

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>

