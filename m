Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89870C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 18:53:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BA4C2086A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 18:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HvYqHk/P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BA4C2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBO2N-0007kS-7f
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 14:53:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54234)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iBO0X-00032N-Kn
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 14:51:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iBO0W-0005eS-7q
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 14:51:53 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:39705)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iBO0V-0005dD-VZ; Fri, 20 Sep 2019 14:51:52 -0400
Received: by mail-lj1-x241.google.com with SMTP id y3so6664651ljj.6;
 Fri, 20 Sep 2019 11:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YfY/MAu7KDMGu08UFK1jfhgN3b/WKiIdCyVpMt7B7Kk=;
 b=HvYqHk/PcdlqDEtCBu5YD3lzfkMGKCyWox0WHoleYnfEOw2Gl04WRdthBXcEejI2vd
 BPRVeSbZteBIJj88phIKXgA+nnWUA/cwgvg0kx9br3w21bFmnL2brqIHJLCx/4+vh9M2
 UgeXT2Y5hdQj8HNhYoS7JuZNUAZY0Ql9NVQasBpom1uNqn/0krVyEGnmKVvoW27SNXA9
 1YK8knOtqRLQf16e8PXuRifE2PR1V2ZgPz35MwOdg66mLBjz4tvbGLSopuMhinqPDTsZ
 e8B+obEODv5RJZZ8c4stmP87fYt28ssMfpFK2ZR6QZpeDzk2DiFHc8zSGEVUesEqKGqb
 k4Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YfY/MAu7KDMGu08UFK1jfhgN3b/WKiIdCyVpMt7B7Kk=;
 b=SScrUYsN9NyuTvNsdMPvf/1dvCr6S0SYrPVx8VPYYNfOc5aaRKy2H0MgZUrOsq5Cgl
 rblB6CyTnVNhDrgM2Jlpv4as9F5aHpFvH3czicQkfvJMR2Ql9FX6UkbO6ymFniTYJIFT
 WaHG3c/IZGd8mFy1tj7ZszBOrE6V2KCBgZDX0y9KTeFQkDBmNWD0NRiStlGE51hWRinH
 8XtyPOtYoC4wSuWW2P3qjauDCf29zoSYViZAWFVbK83nOYX+RqtZM3BQB97rRDDDyGsL
 dfgY1pg/XBsvx0UTQCiE+MK864MlmauCBGRlxIiK3cB+JYzrWzZVRm7Y8nrAosJ6OJgD
 wQmA==
X-Gm-Message-State: APjAAAWPU7qGmJ5QtC1+BMvORa5gJpQscPdUJYReZDNQE3c9dQg6/pVM
 bq5cxTI/7E4BqM02ZZMKXsEVUFnKhiFhCER1btk=
X-Google-Smtp-Source: APXvYqyyP+S/UirJziZXPKIUaDiCqQTcYWyk9smUG90K6M8ySDBJxr0AjC1GKCzuMQfyUDIHWBFDIh/NqbjC9pUHQp4=
X-Received: by 2002:a2e:890c:: with SMTP id d12mr6732141lji.85.1569005510831; 
 Fri, 20 Sep 2019 11:51:50 -0700 (PDT)
MIME-Version: 1.0
References: <1568971142-27979-1-git-send-email-bmeng.cn@gmail.com>
 <1568971142-27979-2-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1568971142-27979-2-git-send-email-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 20 Sep 2019 11:47:15 -0700
Message-ID: <CAKmqyKOz=5b6_7AOGDp=4VvmynUvWZB-N8KudkwwOGUtGgFhog@mail.gmail.com>
Subject: Re: [PATCH 2/2] riscv: sifive_u: Add ethernet0 to the aliases node
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::241
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
 Palmer Dabbelt <palmer@sifive.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 20, 2019 at 2:26 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> U-Boot expects this alias to be in place in order to fix up the mac
> address of the ethernet node.
>
> This is to keep in sync with Linux kernel commit below:
> https://patchwork.kernel.org/patch/11133033/
>
> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>
>  hw/riscv/sifive_u.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index 02dd761..1ac51e3 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -270,6 +270,10 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
>          s->soc.gem.conf.macaddr.a, ETH_ALEN);
>      qemu_fdt_setprop_cell(fdt, nodename, "#address-cells", 1);
>      qemu_fdt_setprop_cell(fdt, nodename, "#size-cells", 0);
> +
> +    qemu_fdt_add_subnode(fdt, "/aliases");
> +    qemu_fdt_setprop_string(fdt, "/aliases", "ethernet0", nodename);
> +
>      g_free(nodename);
>
>      nodename = g_strdup_printf("/soc/ethernet@%lx/ethernet-phy@0",
> @@ -297,7 +301,6 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
>          qemu_fdt_setprop_string(fdt, "/chosen", "bootargs", cmdline);
>      }
>
> -    qemu_fdt_add_subnode(fdt, "/aliases");
>      qemu_fdt_setprop_string(fdt, "/aliases", "serial0", nodename);
>
>      g_free(nodename);
> --
> 2.7.4
>
>

