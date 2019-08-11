Return-Path: <SRS0=60Ee=WH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D48C0650F
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Aug 2019 17:08:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CAC72085B
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Aug 2019 17:08:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJR6tagr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CAC72085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwrKz-00063f-Rz
	for qemu-devel@archiver.kernel.org; Sun, 11 Aug 2019 13:08:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58259)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hwrKP-0005RZ-2o
 for qemu-devel@nongnu.org; Sun, 11 Aug 2019 13:08:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hwrKO-0005jj-2C
 for qemu-devel@nongnu.org; Sun, 11 Aug 2019 13:08:21 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:40759)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hwrKN-0005iV-RT; Sun, 11 Aug 2019 13:08:20 -0400
Received: by mail-lf1-x142.google.com with SMTP id b17so72773867lff.7;
 Sun, 11 Aug 2019 10:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=brBf7CwPavz+UTj6xgQHLByXzGEee1PGsqzsLyfKuF8=;
 b=MJR6tagrle5yufZCLqS9mM+LA53Qv5OcX0B+vBMKU1HyFnRUwUi9EB3CZfJesxgX5u
 MyTKMPyW78oGigJEZ3pZm5r5E2uTBNKGV7Z6uIuvKE6gJN/rKAak5lYpU3otbMGfHTyX
 6x106VZBsI3jymwwCfYrFHNzEI5wCFAWE7yLZ19+cBg7FXZHAm6M4VNSJgR/DELXcriQ
 kXhcbpDAEq2JdIUPiswEzbNYcRMtHe7mLZ+k3Yaz3joPWnjpG4I5UQAk/t2Qnl0288Yl
 NdYYWYEQySzq7pUVvICmlTeGLoIUd7ZgRgMzcB+ysQu3DikKR2uigZYOH1yk/BMZshFi
 t2SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=brBf7CwPavz+UTj6xgQHLByXzGEee1PGsqzsLyfKuF8=;
 b=QWiWfzusnCIKqLbP5dcp6vS1RcQfq8wplv3s1aoMDDyPUGeARlf7LIUlYjP46r96Mt
 QazAww1u+I6vNYupQ5U/Puf2dzaJX2msJp8OnLsJZ1qbeMLD0nkMiN3nDXt6v8oBmq/u
 P+HWkI9tOEDHxVBk50F0QucJcf8cXx8R/u9sowWe/nl0DwlPfqlUzRLrztEwE4LR3Hwk
 gy0w26Rt1z+Q4TRX3rYtv5RUxPQItOVZz41xjMRmNAKYTydjH8iUOdD+V0C5cj5YmsPm
 DioFk+YH56T0WurPC/OhMC4GzTbrGUYg+W3enQHaNR7YnV1Z/KtjIRfWT9pmO6/E2tvZ
 de2g==
X-Gm-Message-State: APjAAAUjMB+71y416Uz7VkemFIL2E1BobsYQukhVDnzcfPTbMEhrCOqp
 HwpY0IrCpGwZ5M0y2A5MMh2+iXt2evwPO4pp/ug=
X-Google-Smtp-Source: APXvYqyK0fNXCaepeybt+n0cfnM0/NFtEe3y/NEr82aH0VWRFCou62HVCI632M+ONwPEDHutFAQ1OeY1MYkf4wQ3iuI=
X-Received: by 2002:ac2:5ec3:: with SMTP id d3mr17542449lfq.44.1565543298558; 
 Sun, 11 Aug 2019 10:08:18 -0700 (PDT)
MIME-Version: 1.0
References: <1565510821-3927-1-git-send-email-bmeng.cn@gmail.com>
 <1565510821-3927-14-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1565510821-3927-14-git-send-email-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Sun, 11 Aug 2019 10:07:50 -0700
Message-ID: <CAKmqyKMNzQDZ_MU17FW1OFHOGKzFq6TdEaQ6rDyn5swQR+UBpw@mail.gmail.com>
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::142
Subject: Re: [Qemu-devel] [PATCH v3 13/28] riscv: sifive_e: prci: Update the
 PRCI register block size
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

On Sun, Aug 11, 2019 at 1:11 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> Currently the PRCI register block size is set to 0x8000, but in fact
> 0x1000 is enough, which is also what the manual says.
>
> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
> Reviewed-by: Chih-Min Chao <chihmin.chao@sifive.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>
> Changes in v3: None
> Changes in v2: None
>
>  hw/riscv/sifive_e_prci.c         | 2 +-
>  include/hw/riscv/sifive_e_prci.h | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/hw/riscv/sifive_e_prci.c b/hw/riscv/sifive_e_prci.c
> index c906f11..4cbce48 100644
> --- a/hw/riscv/sifive_e_prci.c
> +++ b/hw/riscv/sifive_e_prci.c
> @@ -85,7 +85,7 @@ static void sifive_prci_init(Object *obj)
>      SiFivePRCIState *s = SIFIVE_E_PRCI(obj);
>
>      memory_region_init_io(&s->mmio, obj, &sifive_prci_ops, s,
> -                          TYPE_SIFIVE_E_PRCI, 0x8000);
> +                          TYPE_SIFIVE_E_PRCI, SIFIVE_E_PRCI_REG_SIZE);
>      sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
>
>      s->hfrosccfg = (SIFIVE_PRCI_HFROSCCFG_RDY | SIFIVE_PRCI_HFROSCCFG_EN);
> diff --git a/include/hw/riscv/sifive_e_prci.h b/include/hw/riscv/sifive_e_prci.h
> index 7932fe7..81e506b 100644
> --- a/include/hw/riscv/sifive_e_prci.h
> +++ b/include/hw/riscv/sifive_e_prci.h
> @@ -47,6 +47,8 @@ enum {
>      SIFIVE_PRCI_PLLOUTDIV_DIV1  = (1 << 8)
>  };
>
> +#define SIFIVE_E_PRCI_REG_SIZE  0x1000
> +
>  #define TYPE_SIFIVE_E_PRCI      "riscv.sifive.e.prci"
>
>  #define SIFIVE_E_PRCI(obj) \
> --
> 2.7.4
>
>

