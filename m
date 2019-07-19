Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDBE4C7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 16:23:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9984321872
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 16:23:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LaSkSh0C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9984321872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoVff-0003wH-Py
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 12:23:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42315)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hoVfT-0003LQ-Dk
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 12:23:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hoVfS-0007pZ-FA
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 12:23:35 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:39767)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hoVfF-0007es-HW; Fri, 19 Jul 2019 12:23:24 -0400
Received: by mail-lj1-x242.google.com with SMTP id v18so31292385ljh.6;
 Fri, 19 Jul 2019 09:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=U2FoDvxwYpZz91FpH+ibEZmibBKp77P3sh+A7zYKTeY=;
 b=LaSkSh0CWXe5vN91mFjnnW3IxpfsS8MJostmOwzWxcKj3RNH4yTvAliJlRGc/RkpWV
 89mZdiQG3g8rQjGbZ+/04r7B9VDBlegp5rXr18Cs4pz8PYkrXx/6XBoKWAqng378dRfH
 BbZ77Y17bE/0MXqP7zt55PJU0qxrJWOAeu2mshcectLGIZSRxGfI1CwNHMcRyKzoe3AO
 tU8RZJM/yF5DLQL29yYlo50fQQLXvykbGwsGJVVoX21aDdGYA9UndyOCzQelvuvjaiM8
 gphRL1e+NMktGLnURxqlXMoKHNH2J3B9eh1gWPDK1SQNmfS8mGPh/4eclb+oGAHmwgaD
 bngQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=U2FoDvxwYpZz91FpH+ibEZmibBKp77P3sh+A7zYKTeY=;
 b=SGY5iERjg0gbYhgWBZ7y3t4d/rakQx0bJih1WOUEWM54lc3yoqadx5lKeIoYb8B/RC
 BrfzuRwLThsYlMN/sII1+bz9kIdXPhVPPq+0mDakHsPlc+lM59jkTWi/Ji3onMCXfI3R
 gbMFiG73OizwmA4smlKR8aQiJFxIuxZKr+X8aESoyAzeb+lRpo7emivhrm8KViorMmFC
 zqRIx7/PdW5a9sPR+b0MKrmShprYK90EgiynOg1tnEyJQR3gXGZDJKA5fpvQkYzTtSMV
 oIBmF1I9jznIkpuOUJV0UmvQhiOip7RlOgHVypTWWjjtlfZhzal434iaxXbMyP/URPHq
 PZjw==
X-Gm-Message-State: APjAAAUsBgPSwg3VexkNOn12ff4WHyG5z8xaTRoO0NhQryEWoXyxUTAX
 U9pxCCaq6duJ+E31fu/2jQNNtS+MzlKtupKFWeg=
X-Google-Smtp-Source: APXvYqzfsXZR/qOwIfTJzMSZwWVX3H85rBCdyTceRVmiZORnum5z8unc/ngaAmHkPKglOcGY2BBjtrfU5DuprBFgmCo=
X-Received: by 2002:a2e:86cc:: with SMTP id n12mr3849328ljj.146.1563553392339; 
 Fri, 19 Jul 2019 09:23:12 -0700 (PDT)
MIME-Version: 1.0
References: <1563543645-20804-1-git-send-email-linux@roeck-us.net>
 <1563543645-20804-3-git-send-email-linux@roeck-us.net>
In-Reply-To: <1563543645-20804-3-git-send-email-linux@roeck-us.net>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 19 Jul 2019 09:19:50 -0700
Message-ID: <CAKmqyKM+wiTz3oX1G7gdJE9z+Hy0ZEWeO2aWW1u1m_Uc9THmcg@mail.gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::242
Subject: Re: [Qemu-devel] [PATCH 3/3] riscv: sifive_u: Fix clock-names
 property for ethernet node
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
 Palmer Dabbelt <palmer@sifive.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 19, 2019 at 6:41 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> The correct property name is clock-names, not clocks-names.
>
> Without this patch, the Ethernet driver fails to instantiate with
> the following error.
>
> macb 100900fc.ethernet: failed to get macb_clk (-2)
> macb: probe of 100900fc.ethernet failed with error -2
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/sifive_u.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index 5a221c6..64e233d 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -215,7 +215,7 @@ static void *create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
>      qemu_fdt_setprop_cells(fdt, nodename, "interrupts", SIFIVE_U_GEM_IRQ);
>      qemu_fdt_setprop_cells(fdt, nodename, "clocks",
>          ethclk_phandle, ethclk_phandle, ethclk_phandle);
> -    qemu_fdt_setprop(fdt, nodename, "clocks-names", ethclk_names,
> +    qemu_fdt_setprop(fdt, nodename, "clock-names", ethclk_names,
>          sizeof(ethclk_names));
>      qemu_fdt_setprop_cells(fdt, nodename, "#address-cells", 1);
>      qemu_fdt_setprop_cells(fdt, nodename, "#size-cells", 0);
> --
> 2.7.4
>
>

