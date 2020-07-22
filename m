Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF32C433E3
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 16:48:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4C82206C1
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 16:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CfsvfXy5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4C82206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyHux-00067C-4N
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 12:48:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43650)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jyHuI-0005fS-GQ; Wed, 22 Jul 2020 12:47:50 -0400
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144]:39299)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jyHuG-00014h-W5; Wed, 22 Jul 2020 12:47:50 -0400
Received: by mail-il1-x144.google.com with SMTP id k6so1885741ili.6;
 Wed, 22 Jul 2020 09:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GuQ4sDegdpnxWj225poLyKadOWZodmsmX0QI/j9lJBQ=;
 b=CfsvfXy5hiQH/hJdn0/sV50ilsNh1yOT1L/1aaoyPZ3Ix5M3PVQvFsMSnCP3AD8JDS
 rRD828qXbbaW1h5N5xQtCleRHUCefvtxvOb4zxq8kY3tZUR5Z8WLORDZrnVGSW5VvYnj
 uv6H5xD04Q+c8mCXpXhSwDkp7SFvKSQzGrAW+mRjo/d+2SBgIgi1EjrP4LO9zJB5SqGp
 mr0ksIl+/rgasFdTcq85aX7Ym+X7rUoUJlpFloKL2//DvUS7ZFYQuDGIkJiQGM+XIyqg
 QBK0bdhmwUp/fWe+o3UTevangIQtyBE1wMCpWfiybyYHPXikvup2vJFRCum749HbgkyD
 72ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GuQ4sDegdpnxWj225poLyKadOWZodmsmX0QI/j9lJBQ=;
 b=EkfTx2jyPVVOmJCYiIChFBc9wDwaHlP0qvIagbOssHFJ/GfPkQc5i2PQfFf/r//C47
 BiVG6qRP5XMMl2hum565A4mfv9PKJrc3LSF4Ar6Qt7Xm+/62xlAVcy5fOgKZHFiSpAqt
 xzZz8J74J7ZxcAwOPlnH04FmkgWV5rkNqwvTNXCQB1BBbbD+NqTPUVQHC7eVtdrWx0NP
 PP5ivPPg4eHR/gVnNe6aNUfB1G6Zm6wh8/tc76eAmSIWJOI/qBdD7dmRJvhCNkZ0VCSp
 hv7dveoVvWG+xJvnq6/u7pmU3NWPxmXVOWYNk/ch5nT0EFXH0/eIUTHhmPgjsPkcDPmf
 UYQA==
X-Gm-Message-State: AOAM5304/XhU7faYYtp6+ZOpseUv4cuviM3Cz3P3PUz15MIy2nwWQoIu
 NybtEc2+zgt1YL+mBXLSSnlRu/9rsLw5XbHiu4g=
X-Google-Smtp-Source: ABdhPJzbQcQlwhKmjZtjLdYbsTgkt7+Z/HRL5xGG5Gy8aMIe8rNeVzLhmBMH6ySfT1Y5Ibyck/m0P/uW2aTrRVXnDAQ=
X-Received: by 2002:a92:c213:: with SMTP id j19mr830112ilo.40.1595436466924;
 Wed, 22 Jul 2020 09:47:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200722091641.8834-1-frank.chang@sifive.com>
 <20200722091641.8834-2-frank.chang@sifive.com>
In-Reply-To: <20200722091641.8834-2-frank.chang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 22 Jul 2020 09:37:39 -0700
Message-ID: <CAKmqyKP5CxKRnaL3bwrT5LrGZWS=xUjxnuTRXujgZ2ywKV_D2A@mail.gmail.com>
Subject: Re: [RFC v2 01/76] target/riscv: drop vector 0.7.1 support
To: Frank Chang <frank.chang@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::144;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x144.google.com
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 22, 2020 at 2:18 AM <frank.chang@sifive.com> wrote:
>
> From: Frank Chang <frank.chang@sifive.com>
>
> Signed-off-by: Frank Chang <frank.chang@sifive.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c | 24 ++++++------------------
>  target/riscv/cpu.h |  2 --
>  2 files changed, 6 insertions(+), 20 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 228b9bdb5d..2800953e6c 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -106,11 +106,6 @@ static void set_priv_version(CPURISCVState *env, int priv_ver)
>      env->priv_ver = priv_ver;
>  }
>
> -static void set_vext_version(CPURISCVState *env, int vext_ver)
> -{
> -    env->vext_ver = vext_ver;
> -}
> -
>  static void set_feature(CPURISCVState *env, int feature)
>  {
>      env->features |= (1ULL << feature);
> @@ -339,7 +334,6 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
>      CPURISCVState *env = &cpu->env;
>      RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(dev);
>      int priv_version = PRIV_VERSION_1_11_0;
> -    int vext_version = VEXT_VERSION_0_07_1;
>      target_ulong target_misa = 0;
>      Error *local_err = NULL;
>
> @@ -363,7 +357,6 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
>      }
>
>      set_priv_version(env, priv_version);
> -    set_vext_version(env, vext_version);
>
>      if (cpu->cfg.mmu) {
>          set_feature(env, RISCV_FEATURE_MMU);
> @@ -455,19 +448,14 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
>                  return;
>              }
>              if (cpu->cfg.vext_spec) {
> -                if (!g_strcmp0(cpu->cfg.vext_spec, "v0.7.1")) {
> -                    vext_version = VEXT_VERSION_0_07_1;
> -                } else {
> -                    error_setg(errp,
> -                           "Unsupported vector spec version '%s'",
> -                           cpu->cfg.vext_spec);
> -                    return;
> -                }
> +                error_setg(errp,
> +                       "Unsupported vector spec version '%s'",
> +                       cpu->cfg.vext_spec);
> +                return;
>              } else {
> -                qemu_log("vector verison is not specified, "
> -                        "use the default value v0.7.1\n");
> +                qemu_log("vector version is not specified\n");
> +                return;
>              }
> -            set_vext_version(env, vext_version);
>          }
>
>          set_misa(env, RVXLEN | target_misa);
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index eef20ca6e5..6766dcd914 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -79,8 +79,6 @@ enum {
>  #define PRIV_VERSION_1_10_0 0x00011000
>  #define PRIV_VERSION_1_11_0 0x00011100
>
> -#define VEXT_VERSION_0_07_1 0x00000701
> -
>  #define TRANSLATE_PMP_FAIL 2
>  #define TRANSLATE_FAIL 1
>  #define TRANSLATE_SUCCESS 0
> --
> 2.17.1
>
>

