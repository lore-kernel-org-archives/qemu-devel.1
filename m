Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF90DC4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 18:55:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD99321721
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 18:55:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD99321721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHudt-0002Jq-Vb
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 14:55:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42102)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1iHuc3-0001Of-LD
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 14:53:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1iHuc2-0005Kf-H0
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 14:53:35 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37249)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1iHuc2-0005KN-C1
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 14:53:34 -0400
Received: by mail-pg1-f194.google.com with SMTP id p1so8989202pgi.4
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 11:53:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=fsDW0tzjaqiDnhtIyUGrjXSiZZAdOdLAXXd67hwHzks=;
 b=DhErZEKGfZFRhPf4C9J9rgJE/pnVNo9ZPmf3Th4QhscMDMTJNb7CJYTR43EBQq3F8a
 cNTeUMJHw3KP5IgAe+P/ZDL0c84pRt4IDCYCISY71rHd1z6Y8yzIfnCEBchQILQYMyRn
 MUkaQMnHSOAuHM73XplrLDONZu3C3nnseXYZRZWOnoqzRsPvTRDyO3M7GE/rCTrYca84
 uru3Nw+c7dVd0ymPJ2QUQ3ty3NBRovCsIGCm4+ZmmXoLUaDh91VX02ouNmKofzbHbCQ6
 BL5VnvUTOw36VuBfwYv6g49227uQH4UgLmjNDoTMVb78isDI5UO9Sb2KtNeO5vVRzMGU
 s79Q==
X-Gm-Message-State: APjAAAWaGN8sI4EWMt0a4UVmHUQyfpSnkC14PceafMT5JbnHFjv/t1mH
 pAtDuAmOKX1nxzjzOgTyf9tYFJK741I=
X-Google-Smtp-Source: APXvYqyG4GaI+j7ZvTsqBI3G2MSIJr8zxra2N/j6k0XRZEozeCkWF7y97oXktcddE3tRXrGS/IkznA==
X-Received: by 2002:a63:881:: with SMTP id 123mr9879229pgi.227.1570560812484; 
 Tue, 08 Oct 2019 11:53:32 -0700 (PDT)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id 22sm17454478pfo.131.2019.10.08.11.53.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2019 11:53:32 -0700 (PDT)
Date: Tue, 08 Oct 2019 11:53:32 -0700 (PDT)
X-Google-Original-Date: Tue, 08 Oct 2019 11:39:34 PDT (-0700)
Subject: Re: [PATCH v1 28/28] target/riscv: Allow enabling the Hypervisor
 extension
In-Reply-To: <8dae4338c8938696dfcecee6e736f6b09cc82877.1566603412.git.alistair.francis@wdc.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: Alistair Francis <Alistair.Francis@wdc.com>
Message-ID: <mhng-f658dc0f-4818-44d6-ae06-22a24fc09624@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.215.194
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

On Fri, 23 Aug 2019 16:39:03 PDT (-0700), Alistair Francis wrote:
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/cpu.c | 5 +++++
>  target/riscv/cpu.h | 1 +
>  2 files changed, 6 insertions(+)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 06ee551ebe..39e1c130df 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -447,6 +447,9 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
>          if (cpu->cfg.ext_u) {
>              target_misa |= RVU;
>          }
> +        if (cpu->cfg.ext_h) {
> +            target_misa |= RVH;
> +        }
>
>          set_misa(env, RVXLEN | target_misa);
>      }
> @@ -493,6 +496,8 @@ static Property riscv_cpu_properties[] = {
>      DEFINE_PROP_BOOL("c", RISCVCPU, cfg.ext_c, true),
>      DEFINE_PROP_BOOL("s", RISCVCPU, cfg.ext_s, true),
>      DEFINE_PROP_BOOL("u", RISCVCPU, cfg.ext_u, true),
> +    /* This is experimental so mark with 'x-' */
> +    DEFINE_PROP_BOOL("x-h", RISCVCPU, cfg.ext_h, false),
>      DEFINE_PROP_BOOL("Counters", RISCVCPU, cfg.ext_counters, true),
>      DEFINE_PROP_BOOL("Zifencei", RISCVCPU, cfg.ext_ifencei, true),
>      DEFINE_PROP_BOOL("Zicsr", RISCVCPU, cfg.ext_icsr, true),
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index b63f1f3cdc..500496a3be 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -268,6 +268,7 @@ typedef struct RISCVCPU {
>          bool ext_c;
>          bool ext_s;
>          bool ext_u;
> +        bool ext_h;
>          bool ext_counters;
>          bool ext_ifencei;
>          bool ext_icsr;

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>

