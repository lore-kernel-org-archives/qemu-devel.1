Return-Path: <SRS0=KEGy=6R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C5FEC28CBC
	for <qemu-devel@archiver.kernel.org>; Sun,  3 May 2020 04:42:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 664F82073E
	for <qemu-devel@archiver.kernel.org>; Sun,  3 May 2020 04:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="T50JLXcx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 664F82073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jV6Se-0000OW-LC
	for qemu-devel@archiver.kernel.org; Sun, 03 May 2020 00:42:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48974)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anup@brainfault.org>)
 id 1jV6S7-0008Oc-0A
 for qemu-devel@nongnu.org; Sun, 03 May 2020 00:42:07 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:37466)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anup@brainfault.org>)
 id 1jV6S5-0000Db-Qr
 for qemu-devel@nongnu.org; Sun, 03 May 2020 00:42:06 -0400
Received: by mail-wm1-x343.google.com with SMTP id z6so4923243wml.2
 for <qemu-devel@nongnu.org>; Sat, 02 May 2020 21:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=brainfault-org.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vF8VFq5Qsbt5WQdDilLmnB4xmsmF+yCtyKsS/XLhhkU=;
 b=T50JLXcxGwNnDsKbtrfHZeqKE9qtWPTj/ZvaUsGiLsYp00jqQ8VKfd1PT+LfdseQKa
 rEXtg0U18gOlKUhlYZVhG4VnWWp56n40/EsZldfWqdBSbKe0++v0l3RpKLpUAZo0HT4P
 eah7eRYIFjJJV7pPORJYyNZKX9f4kA/Zj5l17dXNNEjMcNy/x0vt4fpb0Yjkx3vCITCM
 /U3GlXxhT0/o0j3erF+A/tq/8dkXIWbJS6jv1B1gIsanYFcAE1oL6IQe0d6jwxnVCmNj
 5f7lsEDxcMNE2cNmGNyWoOGMi9dJWCr6fxqYaFFQM+yNhm8B5Nrn7kvBae4vXT+r2j1x
 HaaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vF8VFq5Qsbt5WQdDilLmnB4xmsmF+yCtyKsS/XLhhkU=;
 b=JEimEasKeypTcQjRjO4ce/C6TTWJK3vRonspgI9RvODMhGFnSJFRHEs2PRjB5PWY5z
 gf/wqMxYERpH7h7MyVS6ZVfjOKth2FZk2v9M/AivLqvRsW/LFFQgBrlEhNxR3O/id6OH
 TU6aNgozHrYeNRQ0yH4m4SGLHDWVZe8z5V+xqCvmxpOPGBp1SM0HoVNyHLxtMkZU3POd
 d1xh7r0PDe60vrQsqMMlB6jJPxDGuuuzKlCTEG3ZtVS0Ylm94SR5MHLiuwf0AZn3CGr5
 GI6psNExM509T690KZaIQtmUBmWk1drT4q4xss8pfJdcu/+n6NyXldMfxu1UNOTnnnqm
 SWtw==
X-Gm-Message-State: AGi0PuawRAnT9Eh3pMk8SJv1t1gUYTyVdg63ccNgwb4KZELzOsgPkXQQ
 CEtzTCmWoHHr3soXy6LJ3ut3E1mNUqj2VFZNOqtspA==
X-Google-Smtp-Source: APiQypL7aDOQPD6rYKPBuM+O/gupsel4rX1e8pOKNCAo3NLGbju02VgLLqkuZ25x9rNhEwjlm/wQI42se+rngzzXsrA=
X-Received: by 2002:a1c:4144:: with SMTP id o65mr8044675wma.78.1588480924523; 
 Sat, 02 May 2020 21:42:04 -0700 (PDT)
MIME-Version: 1.0
References: <1588348254-7241-1-git-send-email-bmeng.cn@gmail.com>
 <1588348254-7241-5-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1588348254-7241-5-git-send-email-bmeng.cn@gmail.com>
From: Anup Patel <anup@brainfault.org>
Date: Sun, 3 May 2020 10:11:53 +0530
Message-ID: <CAAhSdy3hfktuhOg36=8dOM06VLURefcf1gVxw_bKrWzmAwpGnA@mail.gmail.com>
Subject: Re: [PATCH 4/5] riscv/spike: Change the default bios to use generic
 platform image
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: none client-ip=2a00:1450:4864:20::343;
 envelope-from=anup@brainfault.org; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
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
 QEMU Developers <qemu-devel@nongnu.org>, Anup Patel <Anup.Patel@wdc.com>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 1, 2020 at 9:25 PM Bin Meng <bmeng.cn@gmail.com> wrote:
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

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

