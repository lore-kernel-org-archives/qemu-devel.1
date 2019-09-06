Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51AB7C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 15:23:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D8E02082C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 15:23:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rkzPv7XG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D8E02082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6G54-0005F6-7H
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 11:23:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37791)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1i6G4O-0004mC-Du
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 11:22:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1i6G4N-0004QO-6G
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 11:22:40 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:44378)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>) id 1i6G4M-0004Pe-UB
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 11:22:39 -0400
Received: by mail-ed1-x543.google.com with SMTP id p2so5460250edx.11
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2019 08:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YGID0zQzQ2u6z/9DA/vc9He8qiZ7X8IMkHHBqHWoAYM=;
 b=rkzPv7XGswxlEa012wSTuu7RX+BePQcPTJEm6lDQRrymL6nukLJRUHs9VeVGaIPz8n
 IXrryyGfCWZPViQGWYVF3b+/tJR0LHvrGu4xe91aOQKBu4P3kHyvRr4yuzCPOd4CMLKi
 ei4E3h+6VB85WkJUt2p9U0Dt11PoIVG2gddQiFXikmABApM50Z0ZkbInqXarWm45jCU2
 iWUhI5zIkwNq+tP5yk3N2MX2L8eFaTrHdn/6MpdDjosOxn+xUbqMINPbziL5E8qHNySQ
 NCPCR0H6+XB4N8PpGGKJunbcvIWTNeTSGOPKLBIC4oZaot8ki30Z3hQ7Y70g9prEkB/B
 8NEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YGID0zQzQ2u6z/9DA/vc9He8qiZ7X8IMkHHBqHWoAYM=;
 b=depkxh6/udLYPBIrnOWA8ut9HXo+ndAPZBaQyj4+cyzbD4hWJ9GTCWTPwJIpEhWZfD
 wjePXLewXSMjy9L9NNJUmT05YWd2lCH8D+Fh7+uQbRC5x+vsBKLt9QTu5h0he5B8AnMt
 Vq7ENxr7eW6MBgfp1RRjQSSmnPI/J5/TZjIKzos/wvwhag7nR0ScK1sJfpdwCnAWC/yl
 6whHSdKu080nObIXHA5vMmP7CuEh/XIYJBBLY7V3VNyit86jNhwGMC9WNPxf+1TIGaGg
 fS4Th2t9guNJsa4QLNiFVeX2BHiXBT4GR2c+HfqwtwN6R/f5dx/zR7kiS5yjacwoKbuh
 rC/w==
X-Gm-Message-State: APjAAAUbGzbZ4CQIslaFnoOpfNBB/KIc2esjTUrttdoV63JHn7Vj3Za6
 wvvFEskUgfslw/W8qLJUENWhaB0IrgppOKpEpYI=
X-Google-Smtp-Source: APXvYqyvc49RXhEyjpCvPWtX5RZyjQGMJdvVn2124nTWsiHzLLdqQhXJff8j+ZkRaq3Q/Jk35KIk4Fn83XMwr5Bf86s=
X-Received: by 2002:a17:906:361a:: with SMTP id
 q26mr7889948ejb.43.1567783357318; 
 Fri, 06 Sep 2019 08:22:37 -0700 (PDT)
MIME-Version: 1.0
References: <1567782585-19854-1-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1567782585-19854-1-git-send-email-bmeng.cn@gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Fri, 6 Sep 2019 23:22:26 +0800
Message-ID: <CAEUhbmXJA_L_TwF16sZD9rUsFXAmbg-b6ABCUrbJTOTVfZORgA@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Palmer Dabbelt <palmer@sifive.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::543
Subject: Re: [Qemu-devel] [PATCH] riscv: hw: Remove duplicated "hw/hw.h"
 inclusion
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 6, 2019 at 11:09 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> Commit a27bd6c779ba ("Include hw/qdev-properties.h less") wrongly
> added "hw/hw.h" to sifive_prci.c and sifive_test.c.
>
> Another inclusion of "hw/hw.h" was later added via
> commit 650d103d3ea9 ("Include hw/hw.h exactly where needed"), that
> resulted in duplicated inclusion of "hw/hw.h".
>
> Fixes: a27bd6c779ba ("Include hw/qdev-properties.h less")
> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
> ---
>
>  hw/riscv/sifive_prci.c | 1 -
>  hw/riscv/sifive_test.c | 1 -
>  2 files changed, 2 deletions(-)
>

Sigh, I just realized that this patch has inter-dependencies with the
following patch series:

riscv: sifive_test: Add reset functionality
http://patchwork.ozlabs.org/patch/1158526/

and

riscv: sifive_u: Improve the emulation fidelity of sifive_u machine
http://patchwork.ozlabs.org/project/qemu-devel/list/?series=128443

Thus cannot be applied cleanly on top of qemu/master.

If I create this patch on qemu/master, that means the other 2 series
needs to be rebased again.

Regards,
Bin

