Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C7BEC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 16:17:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB75F20721
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 16:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aPYC3k3I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB75F20721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVdm6-0004ac-PI
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 12:16:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38798)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jVdYb-00055c-5s; Mon, 04 May 2020 12:03:01 -0400
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144]:44032)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jVdYa-0006sL-80; Mon, 04 May 2020 12:03:00 -0400
Received: by mail-il1-x144.google.com with SMTP id s10so11717092iln.11;
 Mon, 04 May 2020 09:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9iW+ohN/8VaKTtFNKkF+ADG5q3Qu3gUEbTJUatSDWug=;
 b=aPYC3k3I7SSEr5lpgcPd1AmFeX9yzhDw+44rFWvUXxJSTMEIC2xkiCjuy0jZs3qXkt
 rJqRwOwiHYvdJT+QyX2mMazbzHkDRTLqCqZHLSeoBv3Pw0AC8mA8pRi/yu+EjILE+9Ol
 HFcMV1mUGkLQ3IdxZYeui/Zmjs+EuvjpHH+O7E4LJ+L27Sts2H5CxmqzauXR40L3KpDB
 A0LcYWWMTb/ve112YKi5KlSEZ70+mWO/4ES0L4RMK0jzK+RrhJPbUjoYLPISU4t+M+2+
 Nvrc4VO1qCONOW2ggibQobytdkivUZzccx2XLm1KLyic19DjjbG0sT3Vo9ygocWazK7D
 +JQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9iW+ohN/8VaKTtFNKkF+ADG5q3Qu3gUEbTJUatSDWug=;
 b=eUHqf4j9p/0epyCbyjWAmgae8C391STEQIoAehHQYwAP7ey+nuUTmRsOZ3JYB3f2Qa
 XPG983eQiqdM3WF5fD1fNnvFspIuX7uWniZu4j815K2Z4mRzwKA2bFEAHSGxpm785Dor
 o8US3sBK+0Krf5CFkWk/Ib344ZwmCxjYQ4VN+dGXd4XNukyDduHkC2WAYq5tl4v80HLH
 xWGNAaS0/DIDMxc9Bu4HcuAUByfhiO6DCc7dqlZ+hoEzWtI/37pAENuDKNM9/ZJb9a89
 JMZxFYXxzn4o2+kwWjmGdUw50SFw1ct8GElIkc6I8BLMHWrnSpJRG+QvfOLDf9pxLkIO
 wI4A==
X-Gm-Message-State: AGi0Puagwt0rLFUGzFL35XuxJjDinftSREiDYzJ4otFkgyA8WsXml2c0
 P4tAWpftGrsHUPGPW5dR+h6VbS2qcNVctk61eWU=
X-Google-Smtp-Source: APiQypJCab4JzwbpRy1i8hdaPdLClJTkpUgMCA/sCJZ4eFYv6AibLO2434MRFZJPxBZeWfekSTZ/4iQrP5YN1HIZgQo=
X-Received: by 2002:a92:d0c6:: with SMTP id y6mr17917960ila.227.1588608178965; 
 Mon, 04 May 2020 09:02:58 -0700 (PDT)
MIME-Version: 1.0
References: <1588348254-7241-1-git-send-email-bmeng.cn@gmail.com>
 <1588348254-7241-5-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1588348254-7241-5-git-send-email-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 4 May 2020 08:54:18 -0700
Message-ID: <CAKmqyKP-+ns6UC=QxaNJfisjjYq++CyW86h8pPwhJhaeH5Jc=w@mail.gmail.com>
Subject: Re: [PATCH 4/5] riscv/spike: Change the default bios to use generic
 platform image
To: Bin Meng <bmeng.cn@gmail.com>
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
Cc: Bin Meng <bin.meng@windriver.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Anup Patel <Anup.Patel@wdc.com>, Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 1, 2020 at 8:51 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> From: Bin Meng <bin.meng@windriver.com>
>
> To keep sync with other RISC-V machines, change the default bios
> to use generic platform image.
>
> While we are here, add some comments to mention that keeping ELF
> files here was intentional.
>
> Signed-off-by: Bin Meng <bin.meng@windriver.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>
>  hw/riscv/spike.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
> index d0c4843..6f26fcf 100644
> --- a/hw/riscv/spike.c
> +++ b/hw/riscv/spike.c
> @@ -45,10 +45,15 @@
>
>  #include <libfdt.h>
>
> +/*
> + * Not like other RISC-V machines that use plain binary bios images,
> + * keeping ELF files here was intentional because BIN files don't work
> + * for the Spike machine as HTIF emulation depends on ELF parsing.
> + */
>  #if defined(TARGET_RISCV32)
> -# define BIOS_FILENAME "opensbi-riscv32-spike-fw_jump.elf"
> +# define BIOS_FILENAME "opensbi-riscv32-generic-fw_jump.elf"
>  #else
> -# define BIOS_FILENAME "opensbi-riscv64-spike-fw_jump.elf"
> +# define BIOS_FILENAME "opensbi-riscv64-generic-fw_jump.elf"
>  #endif
>
>  static const struct MemmapEntry {
> --
> 2.7.4
>
>

