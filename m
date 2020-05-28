Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C59C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 02:33:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 624A42084C
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 02:33:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2DfQQhS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 624A42084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1je8M8-00084t-Gi
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 22:33:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47976)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1je8L9-0007Ku-MC; Wed, 27 May 2020 22:32:15 -0400
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42]:38379)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1je8L8-0007y6-62; Wed, 27 May 2020 22:32:15 -0400
Received: by mail-yb1-xb42.google.com with SMTP id s21so6880905ybe.5;
 Wed, 27 May 2020 19:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xqmyTvIe/w0RN7EVJ4Me43s5EgBOteNU32dHTefpLjA=;
 b=H2DfQQhS15abehmxqVh017sOtAxIjNC3P1cHqUcpvVMmHMTVF3I9OT3qNxsHo2z6Z/
 gow1KQENE4ocTEc7al5DR34iYDyH9sWIOnNGgOERtbSRoClElADvPSiXAxjLRtIJrRYh
 Hv+xartYwK880tfcxGifIiSjKzdmRbViK1SJpDcKnsasUmL4D1EtlKmIBcl0wl04w2XJ
 wboU3W241TDQC+IwJ/FEu8XjjG3clPnwFVGpLMfMYBg+W6iLAlu0RenSMdO04lWEng5I
 qrW6aYWmkTY8dBi4sRAZZbR10jGtR+dnJmaFG8zWyTNPuehXWYWKCwu3EdYZoBkdNlQB
 dW8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xqmyTvIe/w0RN7EVJ4Me43s5EgBOteNU32dHTefpLjA=;
 b=kXncN2IcVk37lOo69B5L2BQJ1gIpqwy4eTg7XAbiZWt1nuCWCY8IUsmenJ8OBWZeUu
 3ttzGqBUVhJaFJea8u7H/6FqyY/ztUQzXs/zszuIfQoLuElyNhLBumPWXpCqmr9ywD7B
 Q7LY4kr3kFyMyqvJztQEPu9NC8+/T4PN7CJMaPJVg/fRzvlfkqM76F+OBjN5JH1ruMzw
 UxE+/COoZOISccn1OnhbE3HI7db8jLmjZrM7TV3RAgCQQ8N+kpJq+dejURJty/L6HMoD
 bLIygOZ57sOWE9viEaBpEdoHuRh9AKVA3dLwj7se5T6iLj7DXwXEeWEW5cTrxE6NR+eG
 siEw==
X-Gm-Message-State: AOAM531nF4SLph6Gbd/yQGigErMpQdb07NEBk3u6hGUzLx19t2kYZBZ7
 PpShVp+efe0sYLU+BhBO6hUKvLED2IOqsrvnBBU=
X-Google-Smtp-Source: ABdhPJz+RcUK9amTTkppPleArRKmwpronOCmdOXqABfNxIRD4ANamnb78EO1BnH4naEfpqartr51VNQzUcO4UeVtykQ=
X-Received: by 2002:a25:7a06:: with SMTP id v6mr1967037ybc.152.1590633132659; 
 Wed, 27 May 2020 19:32:12 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1590598125.git.alistair.francis@wdc.com>
 <756439d4816fb3bd7ef84b458bdb6ab3442cdeac.1590598125.git.alistair.francis@wdc.com>
In-Reply-To: <756439d4816fb3bd7ef84b458bdb6ab3442cdeac.1590598125.git.alistair.francis@wdc.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Thu, 28 May 2020 10:32:01 +0800
Message-ID: <CAEUhbmV5Y6xuushwx2QEzdjHgvZA2kov4pakG5BgEXn4is=_=w@mail.gmail.com>
Subject: Re: [PATCH v4 03/10] target/riscv: Disable the MMU correctly
To: Alistair Francis <alistair.francis@wdc.com>
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
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <alistair23@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 28, 2020 at 12:58 AM Alistair Francis
<alistair.francis@wdc.com> wrote:
>
> Previously if we didn't enable the MMU it would be enabled in the
> realize() function anyway. Let's ensure that if we don't want the MMU we
> disable it. We also don't need to enable the MMU as it will be enalbed
> in realize() by default.
>

I think we should do the same for the PMP feature as the logic is the
same as MMU: PMP is always enabled in the realize() function

> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/cpu.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 5eb3c02735..8deba3d16d 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -142,7 +142,6 @@ static void rv32gcsu_priv1_09_1_cpu_init(Object *obj)
>      set_misa(env, RV32 | RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU);
>      set_priv_version(env, PRIV_VERSION_1_09_1);
>      set_resetvec(env, DEFAULT_RSTVEC);
> -    set_feature(env, RISCV_FEATURE_MMU);
>      set_feature(env, RISCV_FEATURE_PMP);
>  }
>
> @@ -152,7 +151,6 @@ static void rv32gcsu_priv1_10_0_cpu_init(Object *obj)
>      set_misa(env, RV32 | RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU);
>      set_priv_version(env, PRIV_VERSION_1_10_0);
>      set_resetvec(env, DEFAULT_RSTVEC);
> -    set_feature(env, RISCV_FEATURE_MMU);
>      set_feature(env, RISCV_FEATURE_PMP);
>  }
>
> @@ -163,6 +161,7 @@ static void rv32imacu_nommu_cpu_init(Object *obj)
>      set_priv_version(env, PRIV_VERSION_1_10_0);
>      set_resetvec(env, DEFAULT_RSTVEC);
>      set_feature(env, RISCV_FEATURE_PMP);
> +    qdev_prop_set_bit(DEVICE(obj), "mmu", false);
>  }
>
>  static void rv32imafcu_nommu_cpu_init(Object *obj)
> @@ -172,6 +171,7 @@ static void rv32imafcu_nommu_cpu_init(Object *obj)
>      set_priv_version(env, PRIV_VERSION_1_10_0);
>      set_resetvec(env, DEFAULT_RSTVEC);
>      set_feature(env, RISCV_FEATURE_PMP);
> +    qdev_prop_set_bit(DEVICE(obj), "mmu", false);
>  }
>
>  #elif defined(TARGET_RISCV64)
> @@ -190,7 +190,6 @@ static void rv64gcsu_priv1_09_1_cpu_init(Object *obj)
>      set_misa(env, RV64 | RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU);
>      set_priv_version(env, PRIV_VERSION_1_09_1);
>      set_resetvec(env, DEFAULT_RSTVEC);
> -    set_feature(env, RISCV_FEATURE_MMU);
>      set_feature(env, RISCV_FEATURE_PMP);
>  }
>
> @@ -200,7 +199,6 @@ static void rv64gcsu_priv1_10_0_cpu_init(Object *obj)
>      set_misa(env, RV64 | RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU);
>      set_priv_version(env, PRIV_VERSION_1_10_0);
>      set_resetvec(env, DEFAULT_RSTVEC);
> -    set_feature(env, RISCV_FEATURE_MMU);
>      set_feature(env, RISCV_FEATURE_PMP);
>  }
>
> @@ -211,6 +209,7 @@ static void rv64imacu_nommu_cpu_init(Object *obj)
>      set_priv_version(env, PRIV_VERSION_1_10_0);
>      set_resetvec(env, DEFAULT_RSTVEC);
>      set_feature(env, RISCV_FEATURE_PMP);
> +    qdev_prop_set_bit(DEVICE(obj), "mmu", false);
>  }
>

Regards,
Bin

