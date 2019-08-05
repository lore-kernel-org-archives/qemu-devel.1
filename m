Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74BF4C0650F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 16:14:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FE63208C3
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 16:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uTktY4F9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FE63208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hufdM-0006eX-JI
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 12:14:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32818)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bmeng.cn@gmail.com>) id 1hufZH-0005lf-1I
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 12:10:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hufZF-0007fO-OQ
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 12:10:38 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:43321)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hufZC-0007c9-3x; Mon, 05 Aug 2019 12:10:34 -0400
Received: by mail-ed1-x542.google.com with SMTP id e3so79260396edr.10;
 Mon, 05 Aug 2019 09:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hSN6j9g/VyJpD5hiJpGJhqK7LSxGuVak9l5GPj/pK5E=;
 b=uTktY4F93yX3f/kz0PWNs5Hg/17xXFr2qYVG1XOU5ZDQvMNtp6gBSLDmpV5f+3+a5N
 aDlnEhGX2wW+bND2L9g864GBUF/Pe6Wk0QLeM3T/Q8DHqWELDJ+A9f9ZbIx1DSl1uwjY
 I3uSQStR6J0IFThTnw/gYm0oblat681xIL9ifoij014uG7RY1OKW7X0JXp0BMj0hIkkm
 NwfeWwWjV8En6462yKSSWNRbvUbCz0FxhN2tKPt+1LmEjdgjfVAZplmyyQHtXDk1INYS
 K0ik9gjI2wFmFSQQJjwQEfwd4QRjCL1KUrOidjyHeU8nCwQ/tUZrLsocE5f4ZPcpJoqF
 zPmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hSN6j9g/VyJpD5hiJpGJhqK7LSxGuVak9l5GPj/pK5E=;
 b=Lnho1nTlOpyZP+I8G3xcm826SbzxzGf49ZWmdsb2/rso2oKfhWQQcfeX8Z0vaubpkM
 j7Qb35ghcXXzn29C9tyOmCqXxAyUBkJ7XA1Rh9LHEj8Oym2ZbG0gp8Yc+1vf4PsCPqNJ
 /VBAYRDdwBCL93FJovCRuHc9fiaAFsvaCr0V0Qblq7Joi1n5qFZOiG2+syB3g80QTxDY
 AbC7Yxo9nUSbn03Dej5cvORZIv7cbPmhgsuIOFzeD3tubwKSgAWglQpu/rGTuUIrOZS/
 KpG4gD0CKJ305OynkiR+QJ9jSLcug2RNGJmOpp6Ae9rwyyxZ+ePfsldmcnbcy4iFeadh
 hmaA==
X-Gm-Message-State: APjAAAX9Of/+qVK0ITUkqLN3XG09WKtYFBtRtFYU0lDwpxfhp+opWdy6
 ph/G8Bj6KqkZ7WboWNIVBJ4H3ZloeeY6Em+c8go=
X-Google-Smtp-Source: APXvYqwYSG91gypDbgI6bJ4X2hSePDPIyV5Iu5nYGcsrbEwLhFr1RGh6OPJKAAlwEyEhScx1g+x+PXehpZp40t76keg=
X-Received: by 2002:a50:94e6:: with SMTP id
 t35mr134717167eda.137.1565021432303; 
 Mon, 05 Aug 2019 09:10:32 -0700 (PDT)
MIME-Version: 1.0
References: <1558108285-19571-1-git-send-email-bmeng.cn@gmail.com>
 <1558108285-19571-2-git-send-email-bmeng.cn@gmail.com>
 <9338c7b4-6a05-2189-b93d-25cb2bd4dd54@adacore.com>
In-Reply-To: <9338c7b4-6a05-2189-b93d-25cb2bd4dd54@adacore.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Tue, 6 Aug 2019 00:10:22 +0800
Message-ID: <CAEUhbmVEccyET4+MdRVwP=oy0TNdU2qc2T=2cbxKsTyngpnFgQ@mail.gmail.com>
To: Fabien Chouteau <chouteau@adacore.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::542
Subject: Re: [Qemu-devel] [Qemu-riscv] [PATCH 2/2] riscv: sifive_u: Update
 the plic hart config to support multicore
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Fabien,

On Tue, Jul 9, 2019 at 12:31 AM Fabien Chouteau <chouteau@adacore.com> wrote:
>
> Hi Bin,
>
> Thanks for this patch.
>
> I know I am very late to the game but I have a comment here.
>
> On 17/05/2019 17:51, Bin Meng wrote:
> > +    /* create PLIC hart topology configuration string */
> > +    plic_hart_config_len = (strlen(SIFIVE_U_PLIC_HART_CONFIG) + 1) * smp_cpus;
> > +    plic_hart_config = g_malloc0(plic_hart_config_len);
> > +    for (i = 0; i < smp_cpus; i++) {
> > +        if (i != 0) {
> > +            strncat(plic_hart_config, ",", plic_hart_config_len);
> > +        }
> > +        strncat(plic_hart_config, SIFIVE_U_PLIC_HART_CONFIG,
> > +                plic_hart_config_len);
> > +        plic_hart_config_len -= (strlen(SIFIVE_U_PLIC_HART_CONFIG) + 1);
> > +    }
> > +
>
> This will create up to 4 MS PLIC devices. However on the Unleashed FU540 the PLICs are M,MS,MS,MS,MS because of the monitor hart #0.
>
> This means a different memory layout than the real hardware.
>
> For instance address 0x0C00_2080 will be hart #0 S-Mode interrupt enables in QEMU, instead of #1 M-Mode interrupt enables for the real hardware.
>
> To fix this I suggest to change this loop to:
>
>     for (i = 0; i < smp_cpus; i++) {
>         if (i != 0) {
>             strncat(plic_hart_config, "," SIFIVE_U_PLIC_HART_CONFIG,
>                     plic_hart_config_len);
>         } else {
>             strncat(plic_hart_config, "M", plic_hart_config_len);
>         }
>         plic_hart_config_len -= (strlen(SIFIVE_U_PLIC_HART_CONFIG) + 1);
>     }
>
> This will make hart #0 PLIC in M mode and the others in MS.
>
> What do you think?

Thank you for the suggestion. A patch was created for this:
http://patchwork.ozlabs.org/patch/1142282/

Regards,
Bin

