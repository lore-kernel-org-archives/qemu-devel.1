Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A66C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 07:59:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 410C22075D
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 07:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sr1IgLpP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 410C22075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDl9e-0007vP-PT
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 03:59:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40295)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1iDl7g-0006Ie-6X
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 03:57:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1iDl7f-0000pG-1g
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 03:57:04 -0400
Received: from mail-yw1-xc44.google.com ([2607:f8b0:4864:20::c44]:38990)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1iDl7e-0000oV-Q2; Fri, 27 Sep 2019 03:57:02 -0400
Received: by mail-yw1-xc44.google.com with SMTP id n11so608539ywn.6;
 Fri, 27 Sep 2019 00:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=MDlIcQvG0sBTRVNF3tCQBU01IG04beRStYQE7JqLpvk=;
 b=sr1IgLpPdL3mlpvIw9OXHbQON/aRLu012eB8oaFEqpzJpgwT0tbh6XlIHX6ZgMyjyH
 fcNwkqtXBGoWlgOxKxargtviOOWSGDwSyxvMzpS7j1KUF4A1oGYJfCoaKtJatDrXmhzi
 2/ubEaBN+f+4vKS1wDsEz00VsK4ibYYkqnEImZIBfWoRy2ZxMuYdVQWGf/3EsN2SUjsu
 xghUMM8um4WE01xW3Tshf7bSvC8379rZBec1R5JBZzcHOkP6pxMnzouta/K8xCw3ZimC
 dmBGR8+iLsbKlODJ5Zgs5EwnPWbunYK9FWibw5yDpa/G9YK4YMeKj08kz/Xy1jLByFe0
 Hu0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MDlIcQvG0sBTRVNF3tCQBU01IG04beRStYQE7JqLpvk=;
 b=hNniqHPQEa6QSAvLE5FxP5r96O7/nFxKIKB9Jh4krO4F9hR1Iy5SvVLU21BAUUdDT4
 5XVRIe/Qg7dpVxVG6aA7XrypYoBhV9Clv/F2JSbelMNMw7WnmS5ouYurpzZkPdSUYjO5
 fGkPLL0HBLWwWvGq4k2Xf8Jc/duN1O2cuYAyJhk3KbU0YUcb7TPnz7T0DbjUVGikZk6T
 b2dxzRL4lLh9/ja/bEIvYzDkmGwCgf6Rxcp7oMx7ZU0a5dL+OWNhkxhCAdOqK6LpRbjy
 Tenu6yqRPE/LspB2K3KHVet0oTJvGYJz64yKpZL8EGpekTHGKpIrFNT5McutlIi+onZd
 C/7g==
X-Gm-Message-State: APjAAAV1B8HYcS495eJr3PhW5qo3fTmX99QWsUKGz+UaC4wOzzMwTJst
 5FXotI5YSg9aoPVY+Dl2ndUcQ1+Q4ItFB8bU7D4=
X-Google-Smtp-Source: APXvYqzDEov2Dksb0P0skBsQW4m2PJ4BcXPOrjiNHw3pX8YLAZl/Z7p1C/c96tFkDYmmko3HG4iUSlmhVWLvJGHQzzE=
X-Received: by 2002:a81:4cc8:: with SMTP id z191mr1648050ywa.137.1569571022143; 
 Fri, 27 Sep 2019 00:57:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1569545046.git.alistair.francis@wdc.com>
 <bf4f869cab915364855a1c9ffadfeac16b151e4b.1569545046.git.alistair.francis@wdc.com>
In-Reply-To: <bf4f869cab915364855a1c9ffadfeac16b151e4b.1569545046.git.alistair.francis@wdc.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Fri, 27 Sep 2019 15:56:50 +0800
Message-ID: <CAEUhbmVBDs5dNH06BjA=Xsa_AEtqoaA6Nm04VtY9-nxJUhmkPQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] riscv/sifive_u: Add L2-LIM cache memory
To: Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c44
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
Cc: Alistair Francis <alistair23@gmail.com>, Palmer Dabbelt <palmer@sifive.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 27, 2019 at 8:52 AM Alistair Francis
<alistair.francis@wdc.com> wrote:
>
> On reset only a single L2 cache way is enabled, the others are exposed
> as memory that can be used by early boot firmware. This L2 region is
> generally disabled using the WayEnable register at a later stage in the
> boot process. To allow firmware to target QEMU and the HiFive Unleashed
> let's add the L2 LIM (LooselyIntegrated Memory).
>
> Ideally we would want to adjust the size of this chunk of memory as the
> L2 Cache Controller WayEnable register is incremented. Unfortunately I
> don't see a nice way to handle reducing or blocking out the L2 LIM while
> still allowing it be re returned to all enabled from a reset.
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---

Please include a changelog in the future. otherwise it's hard to track
what is changed between patch versions.

>  hw/riscv/sifive_u.c         | 16 ++++++++++++++++
>  include/hw/riscv/sifive_u.h |  1 +
>  2 files changed, 17 insertions(+)
>

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>

