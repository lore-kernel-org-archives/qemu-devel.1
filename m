Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7955BC35661
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 19:52:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 442EA20722
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 19:52:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KT9nhKAt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 442EA20722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5ELd-0006q6-EW
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 14:52:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45559)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1j5EL0-0006FU-8p
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 14:51:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1j5EKz-0001yI-EP
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 14:51:50 -0500
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:34262)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1j5EKz-0001y3-7p; Fri, 21 Feb 2020 14:51:49 -0500
Received: by mail-lj1-x242.google.com with SMTP id x7so3445991ljc.1;
 Fri, 21 Feb 2020 11:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2lWxd2Cf2utlVDiwyYn1+ICBDIjoIfk8vwUgNRBSwFo=;
 b=KT9nhKAtnMPcwLojT7RML7sKCbvcNN6l9KKL6a10PQN0IWMSjSXdiEfe1DZLkRgr4x
 W4kSd+16THWvT3SbD86BXaegfx+vBSF0Htj3wfo/VauEHY/KmPmHVlYtifg+oQv5xVxY
 HQVnF0c7bBBeR2/e3Uf8/1kTWixHbafM2ZSu157OeRMQKkra83hc50ceeBkbzP1tua46
 0wtrFZ6yHCbOVaatVIYIbj39xqJ/7f8iiEXeyEt93RCwkl4U3q0OCbSxRA6U2CmfCjfN
 Hh64Crx6TUPisU5PLJVrwFZpwoxsSXlOkjLWpcgx6dxyXYWYkO2fYm1A20X0GTmWt6q0
 E++g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2lWxd2Cf2utlVDiwyYn1+ICBDIjoIfk8vwUgNRBSwFo=;
 b=rlErq1tWNvlStT1IdjwxPp2E5qK8t6sUgNAvEZQr5tev+SUaFt56hZ0zKHCc3N7xij
 r8vrlDtJcIiyz+Kz+29E8fbQwteP7lZPbP2vl35I4nJAKnWspqLwphpnUcUTlBx5llK7
 F4KF9ubhB0ISDSreeIZRuSZsxhyOpS1LoBfMbH+x8zZh/gcYVepVHWFx9nXufhGqT3Gx
 dpelxgrGOREUh7/marsZsosDiRYbzgFdLlJG0eRd8mXk7yIjUca0uN8AGwr6zqhm4Mt+
 /b9FS91f6UsnUZs594MDTPgXX9On/v4h0J4q54m1FGblWDDQ8KLggGaeRd0XnEL5crYf
 PSGA==
X-Gm-Message-State: APjAAAWoOa7RCk2qOY2mpmbLMtxrX1b8XF4/fUt3xcnMF+Phpoflk7wt
 FAo9K0VITWUKCfrNRrqzaLar+FI7Ppz1I0v9VrSvIxAV
X-Google-Smtp-Source: APXvYqzbOTVqsjLcii2QOPHRimNxgHvDbpASgo96C2uBFIY+qmiKp74qCbxYsLHJqzbTEOokg5FnEK79iM9P4PuD3Dw=
X-Received: by 2002:a2e:7818:: with SMTP id t24mr22451118ljc.195.1582314707655; 
 Fri, 21 Feb 2020 11:51:47 -0800 (PST)
MIME-Version: 1.0
References: <1582209758-2996-1-git-send-email-bmeng.cn@gmail.com>
 <1582209758-2996-2-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1582209758-2996-2-git-send-email-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 21 Feb 2020 11:51:20 -0800
Message-ID: <CAKmqyKOHyix_J-T=sFdwX=jTnxG8TO0r6i6edFixVdMZjZy7yQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] riscv: sifive_u: Update BIOS_FILENAME for 32-bit
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::242
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
 Palmer Dabbelt <palmerdabbelt@google.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Feb 20, 2020 at 6:43 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> Update BIOS_FILENAME to consider 32-bit bios image file name.
>
> Tested booting Linux v5.5 32-bit image (built from rv32_defconfig
> plus CONFIG_SOC_SIFIVE) with the default 32-bit bios image.

Do we really want to support a 32-bit sifive_u machine?

Alistair

>
> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
> ---
>
>  hw/riscv/sifive_u.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index ca561d3..371133e 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -57,7 +57,11 @@
>
>  #include <libfdt.h>
>
> -#define BIOS_FILENAME "opensbi-riscv64-sifive_u-fw_jump.bin"
> +#if defined(TARGET_RISCV32)
> +# define BIOS_FILENAME "opensbi-riscv32-sifive_u-fw_jump.bin"
> +#else
> +# define BIOS_FILENAME "opensbi-riscv64-sifive_u-fw_jump.bin"
> +#endif
>
>  static const struct MemmapEntry {
>      hwaddr base;
> --
> 2.7.4
>
>

