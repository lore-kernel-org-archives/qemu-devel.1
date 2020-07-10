Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFBC2C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 20:35:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 947A62075D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 20:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nnAxulEm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 947A62075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtzkO-0001ZT-Sh
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 16:35:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43488)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jtzje-0000uT-3G; Fri, 10 Jul 2020 16:35:06 -0400
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144]:38254)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jtzjc-0004om-FF; Fri, 10 Jul 2020 16:35:05 -0400
Received: by mail-il1-x144.google.com with SMTP id s21so6181344ilk.5;
 Fri, 10 Jul 2020 13:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HnWt/hZyXezbEvChdfViIOo9Shdhe49a4Ah1talr3l4=;
 b=nnAxulEmMkjY6Ol0s/3wlndPpSkluD6+Sp6yLIhgFf+iElI9H3nU5OFqHncs9TT1Ad
 SL8Z3fkKojAlPAMNMta+5vS80f5rhIIdRIhuvcu8AH2qCLV3s0brkZ9/EmjqpuQOMhJ6
 35rxICSIA0inRra61PtTECM2fYmP8HMSf3c9UTgfNwMgoDV0tMx2qp3Mqvt97pv2sns7
 nhcutk7xJvWWea+V5ecThTS1CVtfptLvcFvOAWUWXgPYK0ZKlC0pjSbV+lZK1IplIELZ
 LR5U8PqWQdirQ89BspCJrWILIiR/R2fTmXx3FpuQIJlguVzkrDqSDDDENsmRBZhH+5gX
 JEjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HnWt/hZyXezbEvChdfViIOo9Shdhe49a4Ah1talr3l4=;
 b=DTav/3Qt7jaYhEPybK0s8Ph40QR26jZAdtxsPpP6Lvj34STLxHRSiedjXLdp2qAOsn
 drsRmB9UmHD2XmHcjZKq6PJK9lzmFb4DDTLcxWmWfyBLwZXjIlq1kWbuYsv4XvpgaG3a
 0ah/u8aoSXrrEgpWX97v9US5nARSK9AHsRwv+RZpbVC4T2Kp0ttsDvU9RKk0pPOZbCu3
 fzmisysUGw9PoRuqTe6Fl5lG0Wm3rCsrxbMMODqUm5Qxp23DWNw31EXzfZi2/1vF9FZr
 pchMkF/J+vkgaUjfPPEDAKnN6Qz0zwedc0FpsuBOSf8dOVo/82t7kfmce0IKCbTDx8nO
 Z0Iw==
X-Gm-Message-State: AOAM531wTG1KyoprMODNNHDGXJ2LzbIoXvlf3f5HjrSu1ovCCBa5l92q
 IP91t5VAOGwzv7L9Xc4s11IPgVrH5bhVInVBCwc=
X-Google-Smtp-Source: ABdhPJxqpo0KmBFUFdLCF6fk25q5v2rNyvK0p9YKTAWaNoTqC2lwQzbJMmKZjeY9QmZ9F/+7TU2Nn7XcK+8fDit6Dks=
X-Received: by 2002:a92:d186:: with SMTP id z6mr56934791ilz.227.1594413302684; 
 Fri, 10 Jul 2020 13:35:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200706084550.24117-1-amergnat@baylibre.com>
In-Reply-To: <20200706084550.24117-1-amergnat@baylibre.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 10 Jul 2020 13:25:09 -0700
Message-ID: <CAKmqyKMhsF+X4L2Eahn3f-f-_F6ZUeTTimKWGibYo2VxVbFSiw@mail.gmail.com>
Subject: Re: [PATCH v1] target/riscv: fix pmp implementation
To: Alexandre Mergnat <amergnat@baylibre.com>
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, baylibre-upstreaming@groups.io,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 nroyer@baylibre.com, Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 6, 2020 at 2:45 AM Alexandre Mergnat <amergnat@baylibre.com> wrote:
>
> The end address calculation for NA4 mode is wrong because the address
> used isn't shifted.
>
> That imply all NA4 setup are not applied by the PMP.

I'm not sure what you mean here, can you clarify this?

>
> The solution is to use the shifted address calculated for start address
> variable.
>
> Modifications are tested on Zephyr OS userspace test suite which works
> for other RISC-V boards (E31 and E34 core).
>
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>

Otherwise:

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/pmp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
> index 9418660f1b..2a2b9f5363 100644
> --- a/target/riscv/pmp.c
> +++ b/target/riscv/pmp.c
> @@ -171,7 +171,7 @@ static void pmp_update_rule(CPURISCVState *env, uint32_t pmp_index)
>
>      case PMP_AMATCH_NA4:
>          sa = this_addr << 2; /* shift up from [xx:0] to [xx+2:2] */
> -        ea = (this_addr + 4u) - 1u;
> +        ea = (sa + 4u) - 1u;
>          break;
>
>      case PMP_AMATCH_NAPOT:
> --
> 2.17.1
>
>

