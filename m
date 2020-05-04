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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48296C4724C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 16:16:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15F31206E6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 16:16:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g5b5WWL+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15F31206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVdlE-00035V-3x
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 12:16:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38652)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jVdY4-0003wg-Eh; Mon, 04 May 2020 12:02:28 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:42268)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jVdY3-0006g1-Gn; Mon, 04 May 2020 12:02:28 -0400
Received: by mail-io1-xd43.google.com with SMTP id e9so12829951iok.9;
 Mon, 04 May 2020 09:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nGRYcfLoXvV9mm8UpZ3aW+48QhFD1kMWT/jo9NzgePk=;
 b=g5b5WWL+15VEbUfQ5edTcEx5xH2rEaLduLrYZI5pEyS9bMwHXPY+ouJMrhScbqotTH
 gmaZbkol5G18v82zir5bq/v7jtWBqY7svOkLKHMqv+Czrfu+XUHJkw+uaIP/zz9dovyT
 TXJdaTgWCVp5QCPCaXoj4hcKQMj5D3KshG81TSJUDP1RTz5F/jZQq6YduIpzC6Rbq511
 VoYGaSzhm5SlKupccHtKIK/vjyp6ICP+vCo7SINTCRhTIeqbu09Pwm4tdboxefFtcuUM
 uV+6lI7r8hwvv0sbw87a2mSq5nxciXHzuUHFaqWCxccHvQBynkChk7L44amKLbsJyCGd
 tdcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nGRYcfLoXvV9mm8UpZ3aW+48QhFD1kMWT/jo9NzgePk=;
 b=KmGZLa+MECpv3JlnIXLjtdLpbxU0lO94fnwFMzsGHDVu0+8SW3b+Wk+J65ZdcWlNu+
 vBjH/LxniVjFdt9cEOuuF6IMD6yfd/YuRTvMSZ8Bbhl8RjvLhLC02TCiJDs1vFN24Yfv
 bOhg6o9hV0COWzXeufeCe91gbZIwy55ziKDJ3h0Mw3Z+YdZAZgeOsf1ZirHeQN+5aOgW
 b7cFpcJhuSSVFCsET8KsaU6RByZUcQocnxXPHfVoCSItzzCYDoKSeG2Qa3hYsJ6IQmkt
 uIf1xPFfw/DGfkKdrW4brrba6DbvnQRPHlYmx/0lQZ0Ymldg9EiQAS2Xs9XzIzA7/ZL/
 Yzjg==
X-Gm-Message-State: AGi0PubZqYqPXMlRC369qeRnd03LcXjIdYwNYF2mllO/YFJoNfR4XK/1
 Y8396puMaCCrkYdRiCCtAs7tunAsc/QnPLrP0PU=
X-Google-Smtp-Source: APiQypKvrJdisVgdczFKg77NmK/4AakWDP3QV286ld2c18gQxmhwM5mvToWcZgq1+tYxvL+uckS+Wnan3GaqUgLSU3w=
X-Received: by 2002:a6b:bf83:: with SMTP id
 p125mr16138357iof.118.1588608144098; 
 Mon, 04 May 2020 09:02:24 -0700 (PDT)
MIME-Version: 1.0
References: <1588348254-7241-1-git-send-email-bmeng.cn@gmail.com>
 <1588348254-7241-4-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1588348254-7241-4-git-send-email-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 4 May 2020 08:53:43 -0700
Message-ID: <CAKmqyKMc+ALebg4wBJM8mv=x_XeS-E1bdo8YgbSzXdeiokYHXg@mail.gmail.com>
Subject: Re: [PATCH 3/5] riscv: Use pre-built bios image of generic platform
 for virt & sifive_u
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d43;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd43.google.com
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

On Fri, May 1, 2020 at 8:56 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> From: Bin Meng <bin.meng@windriver.com>
>
> Update virt and sifive_u machines to use the opensbi bios image
> built for the generic FDT platform.
>
> Remove the out-of-date no longer used bios images.
>
> Signed-off-by: Bin Meng <bin.meng@windriver.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>
>  hw/riscv/sifive_u.c                          |   4 ++--
>  hw/riscv/virt.c                              |   4 ++--
>  pc-bios/opensbi-riscv32-generic-fw_jump.bin  | Bin 0 -> 58032 bytes
>  pc-bios/opensbi-riscv32-sifive_u-fw_jump.bin | Bin 49520 -> 0 bytes
>  pc-bios/opensbi-riscv32-virt-fw_jump.bin     | Bin 49504 -> 0 bytes
>  pc-bios/opensbi-riscv64-generic-fw_jump.bin  | Bin 0 -> 66680 bytes
>  pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin | Bin 57936 -> 0 bytes
>  pc-bios/opensbi-riscv64-virt-fw_jump.bin     | Bin 57920 -> 0 bytes
>  8 files changed, 4 insertions(+), 4 deletions(-)
>  create mode 100644 pc-bios/opensbi-riscv32-generic-fw_jump.bin
>  delete mode 100644 pc-bios/opensbi-riscv32-sifive_u-fw_jump.bin
>  delete mode 100644 pc-bios/opensbi-riscv32-virt-fw_jump.bin
>  create mode 100644 pc-bios/opensbi-riscv64-generic-fw_jump.bin
>  delete mode 100644 pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin
>  delete mode 100644 pc-bios/opensbi-riscv64-virt-fw_jump.bin
>
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index bed10fc..cf015cc 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -58,9 +58,9 @@
>  #include <libfdt.h>
>
>  #if defined(TARGET_RISCV32)
> -# define BIOS_FILENAME "opensbi-riscv32-sifive_u-fw_jump.bin"
> +# define BIOS_FILENAME "opensbi-riscv32-generic-fw_jump.bin"
>  #else
> -# define BIOS_FILENAME "opensbi-riscv64-sifive_u-fw_jump.bin"
> +# define BIOS_FILENAME "opensbi-riscv64-generic-fw_jump.bin"
>  #endif
>
>  static const struct MemmapEntry {
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index daae3eb..0c00d93 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -46,9 +46,9 @@
>  #include <libfdt.h>
>
>  #if defined(TARGET_RISCV32)
> -# define BIOS_FILENAME "opensbi-riscv32-virt-fw_jump.bin"
> +# define BIOS_FILENAME "opensbi-riscv32-generic-fw_jump.bin"
>  #else
> -# define BIOS_FILENAME "opensbi-riscv64-virt-fw_jump.bin"
> +# define BIOS_FILENAME "opensbi-riscv64-generic-fw_jump.bin"
>  #endif
>
>  static const struct MemmapEntry {
> diff --git a/pc-bios/opensbi-riscv32-generic-fw_jump.bin b/pc-bios/opensbi-riscv32-generic-fw_jump.bin
> new file mode 100644
> index 0000000..dc39398
> Binary files /dev/null and b/pc-bios/opensbi-riscv32-generic-fw_jump.bin differ
> diff --git a/pc-bios/opensbi-riscv32-sifive_u-fw_jump.bin b/pc-bios/opensbi-riscv32-sifive_u-fw_jump.bin
> deleted file mode 100644
> index 3e0da54..0000000
> Binary files a/pc-bios/opensbi-riscv32-sifive_u-fw_jump.bin and /dev/null differ
> diff --git a/pc-bios/opensbi-riscv32-virt-fw_jump.bin b/pc-bios/opensbi-riscv32-virt-fw_jump.bin
> deleted file mode 100644
> index bc56ed6..0000000
> Binary files a/pc-bios/opensbi-riscv32-virt-fw_jump.bin and /dev/null differ
> diff --git a/pc-bios/opensbi-riscv64-generic-fw_jump.bin b/pc-bios/opensbi-riscv64-generic-fw_jump.bin
> new file mode 100644
> index 0000000..c8f209a
> Binary files /dev/null and b/pc-bios/opensbi-riscv64-generic-fw_jump.bin differ
> diff --git a/pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin b/pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin
> deleted file mode 100644
> index 1acee86..0000000
> Binary files a/pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin and /dev/null differ
> diff --git a/pc-bios/opensbi-riscv64-virt-fw_jump.bin b/pc-bios/opensbi-riscv64-virt-fw_jump.bin
> deleted file mode 100644
> index c62f2b4..0000000
> Binary files a/pc-bios/opensbi-riscv64-virt-fw_jump.bin and /dev/null differ
> --
> 2.7.4
>
>

