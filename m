Return-Path: <SRS0=fVwN=XJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B99C4CEC9
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Sep 2019 20:34:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5829420692
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Sep 2019 20:34:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5829420692
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9Ekf-0007xV-CS
	for qemu-devel@archiver.kernel.org; Sat, 14 Sep 2019 16:34:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37868)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1i9Ej6-00061h-V5
 for qemu-devel@nongnu.org; Sat, 14 Sep 2019 16:33:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1i9Ej6-0008NZ-0Z
 for qemu-devel@nongnu.org; Sat, 14 Sep 2019 16:33:00 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36334)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1i9Ej5-0008NJ-S9
 for qemu-devel@nongnu.org; Sat, 14 Sep 2019 16:32:59 -0400
Received: by mail-pg1-f196.google.com with SMTP id m29so802198pgc.3
 for <qemu-devel@nongnu.org>; Sat, 14 Sep 2019 13:32:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=4SGplVlvAeilU0vnEoPWo2vlTvRUOb+zpOK1n3ckaTU=;
 b=b0v8iWAEE+SHkiDAAS0E5zLkzXJsLKPG+UWZ0cmSN2RwPexofUYYMZ11QuLzAmEsRE
 ERBmOSMuSDCf9EqQp4YAG6MoSg3m3aefLFPDI/lqazOTkQlLP7TA4obYrq0QkEP2CzMF
 uW3BnLi2IqGjC1SXOdI6a6AKXMAXipdaQJ8FAj4wlChGIvKJzU8KoWR/BxwW8GzMHrCz
 rdDG0hv9FxmB767gsh24/wLm4mKebdFaUq4SbtaTaDZBbQ6wLI6qxcp3wu/vhHop/hA3
 L95pONXP82avZ4nA8wywzBEGkyQm8W6vrZw5d16NAoyzAxlm1r9LMzOhcgjDe1oxuu9B
 fGaQ==
X-Gm-Message-State: APjAAAX5XqktY9M9OHNM3wWRZo0Xv3jDhnjZbRH7ur2drlqPh4NPAuIo
 +PKfJrsby1iFloBE69Zqh9hYEjI9zcsbGGQj
X-Google-Smtp-Source: APXvYqzaFiG0Q2zvZBtvLQwY1OANzKpl3xy5CYW/2EijJSfYOebkvpSVe/NbtL5gEVv/MJThMu/hYg==
X-Received: by 2002:a65:62cd:: with SMTP id m13mr48953385pgv.437.1568493178490; 
 Sat, 14 Sep 2019 13:32:58 -0700 (PDT)
Received: from localhost (amx-tls3.starhub.net.sg. [203.116.164.13])
 by smtp.gmail.com with ESMTPSA id ck13sm4975609pjb.29.2019.09.14.13.32.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Sep 2019 13:32:58 -0700 (PDT)
Date: Sat, 14 Sep 2019 13:32:58 -0700 (PDT)
X-Google-Original-Date: Sat, 14 Sep 2019 13:32:40 PDT (-0700)
In-Reply-To: <2b2e042b3c80d4f37cf150853a0a040581feb403.1566603412.git.alistair.francis@wdc.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: Alistair Francis <Alistair.Francis@wdc.com>
Message-ID: <mhng-bfe535ba-174e-466d-9ee4-0c8d98be850b@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.215.196
Subject: Re: [Qemu-devel] [PATCH v1 15/28] riscv: plic: Always set sip.SEIP
 bit for HS
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

On Fri, 23 Aug 2019 16:38:29 PDT (-0700), Alistair Francis wrote:
> When the PLIC generates an interrupt ensure we always set it for the SIP
> CSR that corresponds to the HS (V=0) register.
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  hw/riscv/sifive_plic.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/hw/riscv/sifive_plic.c b/hw/riscv/sifive_plic.c
> index 98e4304b66..8309e96f64 100644
> --- a/hw/riscv/sifive_plic.c
> +++ b/hw/riscv/sifive_plic.c
> @@ -150,7 +150,17 @@ static void sifive_plic_update(SiFivePLICState *plic)
>              riscv_cpu_update_mip(RISCV_CPU(cpu), MIP_MEIP, BOOL_TO_MASK(level));
>              break;
>          case PLICMode_S:
> -            riscv_cpu_update_mip(RISCV_CPU(cpu), MIP_SEIP, BOOL_TO_MASK(level));
> +            if (riscv_cpu_virt_enabled(env)) {
> +                if (level) {
> +                    atomic_or(&env->mip_novirt, MIP_SEIP);
> +                    g_assert(riscv_cpu_virt_enabled(env));
> +                } else {
> +                    atomic_and(&env->mip_novirt, ~MIP_SEIP);
> +                    g_assert(riscv_cpu_virt_enabled(env));
> +                }
> +            } else {
> +                riscv_cpu_update_mip(RISCV_CPU(cpu), MIP_SEIP, BOOL_TO_MASK(level));
> +            }
>              break;
>          default:
>              break;

This is going to go when we change the interrupt delivery mechanism.

