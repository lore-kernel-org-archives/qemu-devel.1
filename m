Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A18C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 09:22:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 416ED2063A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 09:22:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y/FLH/6u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 416ED2063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jytup-000645-H3
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 05:22:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49768)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jytuC-0005b5-2R; Fri, 24 Jul 2020 05:22:16 -0400
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42]:38788)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jytuA-0005l1-D6; Fri, 24 Jul 2020 05:22:15 -0400
Received: by mail-yb1-xb42.google.com with SMTP id d133so2411632ybh.5;
 Fri, 24 Jul 2020 02:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JNM8E9/+q8IKpeRrn7ZU7uK706DUw8E2QRawmufOm1g=;
 b=Y/FLH/6uoI9xr/ZmYVoS1uEG7N/JHfxupqqrJGiIv/AzT8zBW4KEUdPdOQHp3AXaDF
 +xEUciG+PZw+RLOOe0sQcOZX99Pf5xhMxH36lRQBnOmIShmV9Tw/Tv5O/yRLLIIJB6n7
 9Hoj39vhvQS91Y5R1KliZo+YVettEQ+DyBTIwF6WjIXlDgqffLTZq2HNNMj+gMffkbLk
 kExAWXAazskksHRbUpe+HnXg+r8wEUy4Rfg4qS+cvf4EliOsWIvR8psAbC2trJB0o+gX
 BPLLjsgSOWmSV5wCOPR1pZom/ERNI0rgGwZSuQv/SgNcyoERSRGtEQ4l9MJvXF5glvc9
 l0XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JNM8E9/+q8IKpeRrn7ZU7uK706DUw8E2QRawmufOm1g=;
 b=Oai+Pldizz0MMeXYVuIrhHzVC8YE/ctymABNWJiDdGyYbt8inAgj5EtbEZj8BHl0IF
 MZGJnKizIxmJwt5FvQ8NDHsUPbqtKoU8q+UI8k0Q8StJVUxInwOqSDejUxEGbx8O5QlB
 jEVpsUIoBaCE1PzDe8XVlFk02BEtAGYQkjB/Xa1SABBudnCvzsmlQHAtcBaeYtrNcI4+
 QQrC3DuNkEiZ4n/jBGGt3Okdo+2x4pC/wfhXsdrHBzlx/xADEgQfpe0jzvRPzVTDhdSe
 lb2B4YqTuaO/YbtQBkOLQXn1Ihp/nvD3DADzq0CoY+GbYvKq28kSNcu7Q+cBOcqPc4M5
 /6ow==
X-Gm-Message-State: AOAM532f1myH99AnYdEO/Gz5Tz8QDmW5WCC8YDPYAJ/ISVCgg46pS5bj
 eL9oRJZYgkJqRhzGlm38E65qZPYfGkCd3rGyuMA=
X-Google-Smtp-Source: ABdhPJx4cVEzPOe5QoZ3tlBgTKHTb2NRrrHNKpoZoHCYemtY/FoiHfwr48SsPkZ90TMmYMUWmraGahiNTMj/B4HpxNE=
X-Received: by 2002:a25:d953:: with SMTP id q80mr2013136ybg.387.1595582532596; 
 Fri, 24 Jul 2020 02:22:12 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1595581140.git.zong.li@sifive.com>
 <56c2770fc75e1e0c833248ea5d9faa038b69e328.1595581140.git.zong.li@sifive.com>
In-Reply-To: <56c2770fc75e1e0c833248ea5d9faa038b69e328.1595581140.git.zong.li@sifive.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Fri, 24 Jul 2020 17:22:00 +0800
Message-ID: <CAEUhbmX-va3wLY_aU7QYXE0ke0sn-4mfenz5Mszy+2k9NMib9A@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] target/riscv/pmp.c: Fix the index offset on RV64
To: Zong Li <zong.li@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b42;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yb1-xb42.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Zong,

On Fri, Jul 24, 2020 at 5:08 PM Zong Li <zong.li@sifive.com> wrote:
>
> On RV64, the reg_index is 2 (pmpcfg2 CSR) after the seventh pmp
> entry, it is not 1 (pmpcfg1 CSR) like RV32. In the original
> implementation, the second parameter of pmp_write_cfg is
> "reg_index * sizeof(target_ulong)", and we get the the result
> which is started from 16 if reg_index is 2, but we expect that
> it should be started from 8. Separate the implementation for
> RV32 and RV64 respectively.
>
> Signed-off-by: Zong Li <zong.li@sifive.com>
> ---
>  target/riscv/pmp.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
> index 2a2b9f5363..e0161d6aab 100644
> --- a/target/riscv/pmp.c
> +++ b/target/riscv/pmp.c
> @@ -310,6 +310,10 @@ void pmpcfg_csr_write(CPURISCVState *env, uint32_t reg_index,
>      int i;
>      uint8_t cfg_val;
>
> +#if defined(TARGET_RISCV64)
> +    reg_index >>= 1;
> +#endif
> +
>      trace_pmpcfg_csr_write(env->mhartid, reg_index, val);
>
>      if ((reg_index & 1) && (sizeof(target_ulong) == 8)) {
> @@ -335,6 +339,10 @@ target_ulong pmpcfg_csr_read(CPURISCVState *env, uint32_t reg_index)
>      target_ulong cfg_val = 0;
>      target_ulong val = 0;
>
> +#if defined(TARGET_RISCV64)
> +    reg_index >>= 1;
> +#endif
> +
>      for (i = 0; i < sizeof(target_ulong); i++) {
>          val = pmp_read_cfg(env, (reg_index * sizeof(target_ulong)) + i);
>          cfg_val |= (val << (i * 8));
> --

It seems you missed to address my review comments in v3? reg_index
should be shifted after we call the trace function.

Regards,
Bin

