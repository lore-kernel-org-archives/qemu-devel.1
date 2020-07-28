Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80DD9C433F1
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 15:38:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C0422078E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 15:38:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="abkk2UTz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C0422078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0RgF-00051q-9g
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 11:38:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50364)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1k0Rfe-0004a7-T3; Tue, 28 Jul 2020 11:37:38 -0400
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141]:33530)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1k0Rfb-0004Hu-Rj; Tue, 28 Jul 2020 11:37:38 -0400
Received: by mail-il1-x141.google.com with SMTP id p16so5762514ile.0;
 Tue, 28 Jul 2020 08:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZzqjNDHjyBP72RmWzIfEhocBh3SxGafaKx89XkWeqb8=;
 b=abkk2UTz6XGzoCZenSFYzUR2bd4W6Lv2Mm31X0sjjg5ZJnwGziSzgo8meiEs6LArGo
 AAEB/FGwe6kWtSJJDuhe5GAODmAQgDMmdiHXLLtyEiMZKGYgylSTKnaTreseszUGhLtl
 WASjHB9QtOc9dbstSf+luZTJeQq2QswC2rwlXHYMeOLyIQZUa01z3HN18hpbFLjp1TMU
 uDoLDyOvCnj33EY6w/IGGHazVTvqMWxEZjugAdn8s9WXAPJW1JAuE/H+NcShFBrqa2Ri
 Fonkdei8BHSrqyheLi9USO0ql7a+d53QIGxyDjWPUrtRE0GVnr2mOrDRwDOXFTdZS77y
 XZpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZzqjNDHjyBP72RmWzIfEhocBh3SxGafaKx89XkWeqb8=;
 b=diMmpYNzmDJkQJQ/v8gTpGMeAivjrSmGScxwfJoHYahdmfw5uJq05wBg2DM3F15jxu
 WCgLi40At/I8e5RvjZ1c3JdS+K4SP5G3SeMRW6m7mowZiBa1yWuiPcNUM1iYDZWBD/ge
 zJuXr1DvrecPf0G1oGHf20Urw7eSCDDD2/iS9YLfkNcIB1bvw8Apqrvzt98Gi+YkK/ik
 WbRkevIPIOzSXX+hcsfzn8s69mCqSMkpw0qTm4z+NhmTWAuZcPBLecdp9/6fg0XQuALR
 LAo6/Bmlkur7l3h/JKlo/ejYxojxix+wVNV00MKSfECcszrhu0LtzvnYTfKi0dqohiCG
 sv9g==
X-Gm-Message-State: AOAM5331FHRLNos6GlQVT3+nhVdSPh+UdUc7gHGDfzahn4w4I1HrKMS0
 fWy8r9IiXmnu3RsbiD+l74TzM83FP6bTiosAyYA=
X-Google-Smtp-Source: ABdhPJwWxjePzJ66TEsbJxkga/vT72cLAojkLfoiwgnSrghQ+7q38Uj6AeAdcv+XrWf1ohFYInZrGKGkTgPZ/EsZG10=
X-Received: by 2002:a92:cf50:: with SMTP id c16mr9482823ilr.131.1595950654700; 
 Tue, 28 Jul 2020 08:37:34 -0700 (PDT)
MIME-Version: 1.0
References: <1594878971-26050-1-git-send-email-bmeng.cn@gmail.com>
 <1594878971-26050-8-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1594878971-26050-8-git-send-email-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 28 Jul 2020 08:27:16 -0700
Message-ID: <CAKmqyKOFXGbW3ubNc4RHOh_4ujDSqKS_3GGMnyno2S7gDL-+Ow@mail.gmail.com>
Subject: Re: [PATCH v5 7/7] Makefile: Ship the generic platform bios ELF
 images for RISC-V
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::141;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x141.google.com
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
Cc: Bin Meng <bin.meng@windriver.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>, Anup Patel <anup@brainfault.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 15, 2020 at 11:01 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> From: Bin Meng <bin.meng@windriver.com>
>
> At present only the generic platform fw_dynamic bios BIN images
> are included in the 'make install' target for 'virt' and 'sifive_u'
> machines. This updates the install blob list to include ELF images
> which are needed by the 'spike' machine.
>
> Signed-off-by: Bin Meng <bin.meng@windriver.com>

This commit should be squashed into patch 5.

Do you want me to do that when applying?

Alistair

>
> ---
>
> Changes in v5:
> - Ship generic fw_dynamic.elf images in the Makefile
>
> Changes in v3:
> - change fw_jump to fw_dynamic in the Makefile
>
> Changes in v2:
> - new patch: Makefile: Ship the generic platform bios images for RISC-V
>
>  Makefile | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index a6d6234..142c545 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -841,7 +841,8 @@ u-boot.e500 u-boot-sam460-20100605.bin \
>  qemu_vga.ndrv \
>  edk2-licenses.txt \
>  hppa-firmware.img \
> -opensbi-riscv32-generic-fw_dynamic.bin opensbi-riscv64-generic-fw_dynamic.bin
> +opensbi-riscv32-generic-fw_dynamic.bin opensbi-riscv64-generic-fw_dynamic.bin \
> +opensbi-riscv32-generic-fw_dynamic.elf opensbi-riscv64-generic-fw_dynamic.elf
>
>
>  DESCS=50-edk2-i386-secure.json 50-edk2-x86_64-secure.json \
> --
> 2.7.4
>
>

