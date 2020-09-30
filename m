Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB88C4727C
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 15:56:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F4EA206F7
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 15:56:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Em9tANLg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F4EA206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNeSY-0006Q9-Gw
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 11:56:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50116)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kNeRe-0005nx-Pm; Wed, 30 Sep 2020 11:55:06 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:37665)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kNeRc-0001c1-Uy; Wed, 30 Sep 2020 11:55:06 -0400
Received: by mail-io1-xd42.google.com with SMTP id y13so2333360iow.4;
 Wed, 30 Sep 2020 08:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bKClRjzFMT0pps90a/PsiFGDtFSBeovqRUJ8PPva6NE=;
 b=Em9tANLgJXKEqA7KDNZkYUI9JFcK2e1A2lgBounII6B9lo+F31SKis7pOOa+tXPAAK
 Jk7PNB9Q9Nz+MSxnaYNEIOrosWamidCxrIka+9B7yfvajZzGbcRAudFBQ0sO5ZW7xo3k
 2+wG/UHzdDLyQM+zyPvFQMnQkhtk5YPVqfsSTiEKDa4Sp8enuN/vSQ9EGau2z4Z07QiT
 TC+85sKtgDenqhB0m6vlWjVeJB0mzID0vuiyx71ZtAu6L/jGTG/kFEyQYfGACXNuCyua
 RMYwQA4Uby24tCH8EejZcpHGgLIeO3brI5DUwWiGTIRFrcb+neAMU3Jl+XIpIkvqDBkh
 sA8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bKClRjzFMT0pps90a/PsiFGDtFSBeovqRUJ8PPva6NE=;
 b=qyYyuSA4wlfzJN/c9vRgo8A8rUuyi1KR7BKCkRkcGr7M9qJMv7C3iKA/ac6hvLSdP3
 wRhYU2VQBkKNPdmIl0Qh3FENN2UgIQnRsVQAJi2qrEB5OznozZvTSPiO8mTF7RPYt5UD
 w2wkwxRNvAeMB+oymocSZjtmM3emTawuhorrXt5qyo48j3Dv3I+GF12jaHCtPAnEwXgU
 fNNgxnYoVB1ivk/NhgY+lH4lJ7aI5Xd7+R5S1fAbu2zdXVdTat0Sodw3S5DbHSTjZHt3
 7PgtcNKiFmh50lV5H2V6BM5zxg6Or3G7oGhhZ1a+AcCoDTII+KaQfeZgkYx8+YV8Yq73
 bTFg==
X-Gm-Message-State: AOAM531YSKKZcMTD5pTCx71e2DFJD56fWT529+rLkhXaglVfQpoHR9GD
 VWvum0nsaYU2wIO89/BcTwgVSLq+HJbi27wQ8EU=
X-Google-Smtp-Source: ABdhPJyN2IzpGqG9Lkhk9mRB+eMXAWHs/qqK4d/p3P94a/UNiZkhE23bKhDtm2ECV75za1pt713Edv7HwVxvGpw7Tno=
X-Received: by 2002:a02:5584:: with SMTP id e126mr2574689jab.26.1601481303401; 
 Wed, 30 Sep 2020 08:55:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200930095321.2006-1-zhaolichang@huawei.com>
 <20200930095321.2006-4-zhaolichang@huawei.com>
In-Reply-To: <20200930095321.2006-4-zhaolichang@huawei.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 30 Sep 2020 08:43:34 -0700
Message-ID: <CAKmqyKMR7eKFmJW=5x1R4X7HObjgZo9Y93jPfsRS+6h=F4TBWg@mail.gmail.com>
Subject: Re: [PATCH RFC 03/14] riscv/: fix some comment spelling errors
To: zhaolichang <zhaolichang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d42;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd42.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 30, 2020 at 2:56 AM zhaolichang <zhaolichang@huawei.com> wrote:
>
> I found that there are many spelling errors in the comments of qemu/target/riscv.
> I used spellcheck to check the spelling errors and found some errors in the folder.
>
> Signed-off-by: zhaolichang <zhaolichang@huawei.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c           | 2 +-
>  target/riscv/cpu_bits.h      | 2 +-
>  target/riscv/csr.c           | 6 +++---
>  target/riscv/vector_helper.c | 2 +-
>  4 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 0bbfd7f..f40a0b2 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -472,7 +472,7 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
>                      return;
>                  }
>              } else {
> -                qemu_log("vector verison is not specified, "
> +                qemu_log("vector version is not specified, "
>                          "use the default value v0.7.1\n");
>              }
>              set_vext_version(env, vext_version);
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index bd36062..6e11555 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -536,7 +536,7 @@
>  /* Leaf page shift amount */
>  #define PGSHIFT             12
>
> -/* Default Reset Vector adress */
> +/* Default Reset Vector address */
>  #define DEFAULT_RSTVEC      0x1000
>
>  /* Exception causes */
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 26ae347..559db11 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -624,7 +624,7 @@ static int write_mcounteren(CPURISCVState *env, int csrno, target_ulong val)
>      return 0;
>  }
>
> -/* This regiser is replaced with CSR_MCOUNTINHIBIT in 1.11.0 */
> +/* This register is replaced with CSR_MCOUNTINHIBIT in 1.11.0 */
>  static int read_mscounteren(CPURISCVState *env, int csrno, target_ulong *val)
>  {
>      if (env->priv_ver < PRIV_VERSION_1_11_0) {
> @@ -634,7 +634,7 @@ static int read_mscounteren(CPURISCVState *env, int csrno, target_ulong *val)
>      return 0;
>  }
>
> -/* This regiser is replaced with CSR_MCOUNTINHIBIT in 1.11.0 */
> +/* This register is replaced with CSR_MCOUNTINHIBIT in 1.11.0 */
>  static int write_mscounteren(CPURISCVState *env, int csrno, target_ulong val)
>  {
>      if (env->priv_ver < PRIV_VERSION_1_11_0) {
> @@ -1278,7 +1278,7 @@ int riscv_csrrw(CPURISCVState *env, int csrno, target_ulong *ret_value,
>          !riscv_cpu_virt_enabled(env)) {
>          /*
>           * We are in S mode without virtualisation, therefore we are in HS Mode.
> -         * Add 1 to the effective privledge level to allow us to access the
> +         * Add 1 to the effective privilege level to allow us to access the
>           * Hypervisor CSRs.
>           */
>          effective_priv++;
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index a156573..fa89a6e 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -709,7 +709,7 @@ typedef void vext_amo_noatomic_fn(void *vs3, target_ulong addr,
>                                    uint32_t wd, uint32_t idx, CPURISCVState *env,
>                                    uintptr_t retaddr);
>
> -/* no atomic opreation for vector atomic insructions */
> +/* no atomic operation for vector atomic insructions */
>  #define DO_SWAP(N, M) (M)
>  #define DO_AND(N, M)  (N & M)
>  #define DO_XOR(N, M)  (N ^ M)
> --
> 2.26.2.windows.1
>
>

