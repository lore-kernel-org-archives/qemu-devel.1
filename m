Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF578C43467
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 07:23:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EACB20739
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 07:23:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wi9snhuO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EACB20739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQQGy-00031t-7H
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 03:23:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57384)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1kQQFQ-00028M-Pb
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 03:21:56 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:39793)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1kQQFO-0005Rg-Vx
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 03:21:56 -0400
Received: by mail-lj1-x243.google.com with SMTP id m16so4630075ljo.6
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 00:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=OGoy/OsTQtJiUkbIX5ZaUysqtJePK129YE/DcmD5QiU=;
 b=Wi9snhuO2Me58Yqo4By/EZOcTDIsLkmUq7IgMv/I2WsUJE4Bt/kYh76KRGQYuqDGtr
 R2tbUOsW4nOiHJ0phzUw6F25CKpyfqUplwqpQzx1/oi5wQeC0U++jiku8I0fgVf6zZmX
 IgHlZeDKoRtet5DC3j+0l3Ds2CSDQrCCZJAn6O4RyeB12rkyN5uWPJb0MgTpMJwdfmoe
 rP/IaOmDOS4vYZZEkoAZ57RvW7tf+torMhAVqv0aXg+ll3MRy1OmoUp/j8vIVYEIUO+q
 A2bMcqjpMhyUu7PpziZXKtdFk6ZQ/uKcKnQN3RF0Gut00dn7O8tAN6nck5AZwBezQgLr
 NZLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=OGoy/OsTQtJiUkbIX5ZaUysqtJePK129YE/DcmD5QiU=;
 b=CUy4gQJI7flJDq2QsOpqRHrq8LHf7tFZLCjZOThrU80b4J3mbOvnU7telyeK5f+MZM
 BwG7lCRzgirlyNGRVORYNL8jpkDg+cTJ+63ce7mVUkdGVyWUbbM/v0sa+QN135HSRnUn
 ySmrmjZdEvemQ2+BOJTJ4ysKMSFGtWV1yJPJ6L74RaowNYn71VqDvl459q+kNoJxNWtS
 KxSLAt68yBmfYuRhhCcZyA3F+jS2Mw9XORTrICP08scwTPs0a2MRvd/0S8yrRVSRYqNZ
 zh5X1EV1cHBkFAr1iEyktrj2wnefEsoRDWOxs3VJj64x/c6RZSX4cv5k5Uno/AwQPv6Y
 Db4Q==
X-Gm-Message-State: AOAM530QAQhU6kju+PQZzkmsV9pcawPI6Ta6qVvTfy3A7zjqdRet9ImM
 2H3bjPmGXi3477LcwgDQQJVsibVp6Zr9U7fE+uU=
X-Google-Smtp-Source: ABdhPJw+eO8ItScGERW6cXScbz9jtmNurFqClZNO0EtekSdlu/83JuHogNMEyAmUMvqUYP7rv+meP6uWLD81elqnh2w=
X-Received: by 2002:a2e:a588:: with SMTP id m8mr2501806ljp.210.1602141712769; 
 Thu, 08 Oct 2020 00:21:52 -0700 (PDT)
MIME-Version: 1.0
References: <1602103041-32017-1-git-send-email-aleksandar.qemu.devel@gmail.com>
 <1602103041-32017-6-git-send-email-aleksandar.qemu.devel@gmail.com>
In-Reply-To: <1602103041-32017-6-git-send-email-aleksandar.qemu.devel@gmail.com>
From: chen huacai <zltjiangshi@gmail.com>
Date: Thu, 8 Oct 2020 15:21:38 +0800
Message-ID: <CABDp7VppBsH74X8rvFzYEdQ_nM7dxYndd1SSKqTpZGDNA2w86A@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] MAINTAINERS: Remove myself
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::243;
 envelope-from=zltjiangshi@gmail.com; helo=mail-lj1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 qemu-level <qemu-devel@nongnu.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 hpoussin@reactos.org, Huacai Chen <chenhc@lemote.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi, Aleksandar,

On Thu, Oct 8, 2020 at 4:40 AM Aleksandar Markovic
<aleksandar.qemu.devel@gmail.com> wrote:
>
> I have been working on project other than QEMU for some time, and would
> like to devote myself to that project. It is imposible for me to find
> enough time to perform maintainer's duties with needed meticulousness
> and patience.
>
> I wish prosperous future to QEMU and all colegues in QEMU community.
I'm very sorry to hear that. I hope you can be still here if possible...
I found that there are many reviewers, so, if it is a must that
Aleksandar will leave us, can these reviewers be maintainers?

Huacai
>
> Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> ---
>  MAINTAINERS | 17 +++++------------
>  1 file changed, 5 insertions(+), 12 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e9d85cc..426f52c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -221,11 +221,10 @@ F: hw/microblaze/
>  F: disas/microblaze.c
>
>  MIPS TCG CPUs
> -M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
>  R: Aurelien Jarno <aurelien@aurel32.net>
>  R: Jiaxun Yang <jiaxun.yang@flygoat.com>
>  R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
> -S: Maintained
> +S: Orphaned
>  F: target/mips/
>  F: default-configs/*mips*
>  F: disas/*mips*
> @@ -387,7 +386,6 @@ F: target/arm/kvm.c
>
>  MIPS KVM CPUs
>  M: Huacai Chen <chenhc@lemote.com>
> -M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
>  S: Odd Fixes
>  F: target/mips/kvm.c
>
> @@ -1124,10 +1122,9 @@ F: hw/display/jazz_led.c
>  F: hw/dma/rc4030.c
>
>  Malta
> -M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
>  M: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>  R: Aurelien Jarno <aurelien@aurel32.net>
> -S: Maintained
> +S: Odd Fixes
>  F: hw/isa/piix4.c
>  F: hw/acpi/piix4.c
>  F: hw/mips/malta.c
> @@ -1137,14 +1134,12 @@ F: tests/acceptance/linux_ssh_mips_malta.py
>  F: tests/acceptance/machine_mips_malta.py
>
>  Mipssim
> -M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
>  R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
> -S: Odd Fixes
> +S: Orphaned
>  F: hw/mips/mipssim.c
>  F: hw/net/mipsnet.c
>
>  R4000
> -M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
>  R: Aurelien Jarno <aurelien@aurel32.net>
>  R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
>  S: Obsolete
> @@ -1153,7 +1148,6 @@ F: hw/mips/r4k.c
>  Fuloong 2E
>  M: Huacai Chen <chenhc@lemote.com>
>  M: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> -M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
>  R: Jiaxun Yang <jiaxun.yang@flygoat.com>
>  S: Odd Fixes
>  F: hw/mips/fuloong2e.c
> @@ -2821,12 +2815,11 @@ F: tcg/i386/
>  F: disas/i386.c
>
>  MIPS TCG target
> -M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
>  R: Aurelien Jarno <aurelien@aurel32.net>
>  R: Huacai Chen <chenhc@lemote.com>
>  R: Jiaxun Yang <jiaxun.yang@flygoat.com>
>  R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
> -S: Maintained
> +S: Orphaned
>  F: tcg/mips/
>
>  PPC TCG target
> @@ -3167,7 +3160,7 @@ S: Odd Fixes
>  F: scripts/git-submodule.sh
>
>  UI translations
> -M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> +S: Orphaned
>  F: po/*.po
>
>  Sphinx documentation configuration and build machinery
> --
> 2.7.4
>
>


--=20
Huacai Chen

