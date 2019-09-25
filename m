Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D1CCC432C1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 09:59:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AADE214D9
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 09:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QN4Mu7G0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AADE214D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD456-0004Uy-5f
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 05:59:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36931)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1iD44B-0003tu-55
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 05:58:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1iD44A-0008S3-1g
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 05:58:35 -0400
Received: from mail-yw1-xc41.google.com ([2607:f8b0:4864:20::c41]:42535)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1iD449-0008Rg-SC; Wed, 25 Sep 2019 05:58:34 -0400
Received: by mail-yw1-xc41.google.com with SMTP id i207so1778482ywc.9;
 Wed, 25 Sep 2019 02:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8jNHHqTNXkqX0eXwTVH5nEoQRCcUSRmsudoY9Aq7OdE=;
 b=QN4Mu7G0MZ9Xj5nFz7BtCKzBRB6Y82ADE43Nea1qqG4mT6vkD/bdvbZNbDD+l5/Wsa
 e4tw/GinEEnX72V3qfiR6gWf0TztZIjKEVqc0tjO3Z1lA8SAXu0C23v7hfbLtuC4+jqb
 9ZBYONkAz7jY/LSAdpjax20l0jzdKreELdeLYkvzH87cF3AO3ieULwTbR5ao8EhOP+nG
 eT8IqHVMTpweECxRjfBSan0oom4o2nh2eM/7x5tXNUCAeAH2T1RhOmzvUNqhTZAJxGOk
 kvCDy+KNGHor3Tt/Jq9T/hHabHzdInqS0Qn7i0KPD0SGEaCB2bAIm5F8eLph2ZnIrqge
 SeWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8jNHHqTNXkqX0eXwTVH5nEoQRCcUSRmsudoY9Aq7OdE=;
 b=oBjxGTCjia5wjHS6jmuvCKtQFJvKZCPpv5vjFJwOI6pfBighHF6hs624syUuqsrOzz
 7cEnIyrVS6KbTafkO5wsr6SFIi1JHMYWYiuED8MQfOs0EdlOHTlvzJKilvdgqGoNBNUV
 fOYegjNUnFqF5kk3nks6gfsP7uMlvYYQrqJz6INBiFJanLPwhAP/XHI+xZlix7LqIzQp
 +JUIjPyWYIwcm+EUBVu6cbFpXFPv1eMuQi78eolylUBbNJs64GgA1yYb88sgSy7mzBNy
 FZ/pwoe/w8AUB1OQJ538mq8mA47xvW5DAnK56y1hzMJEYEXpqXYHBbIyttfX2/3tYmpM
 TrAQ==
X-Gm-Message-State: APjAAAVJTJOpAZ76dYCyLMriR0p8yCYRY197BJNOKlLuv45pwzo+8n9F
 rR744ac7fwE0nQgMA7BpkyKvCgk2OrNrB8H8DjI=
X-Google-Smtp-Source: APXvYqyRekIQ5A1TJXe5qzHxBO04a6IszwOixMsJyV4X2WCUD7xPcNMpz1j3uZZYbJF2/gMq7FJlMol9032wz2VRX7I=
X-Received: by 2002:a0d:ca03:: with SMTP id m3mr4923560ywd.209.1569405513177; 
 Wed, 25 Sep 2019 02:58:33 -0700 (PDT)
MIME-Version: 1.0
References: <1569403262-23523-1-git-send-email-guoren@kernel.org>
In-Reply-To: <1569403262-23523-1-git-send-email-guoren@kernel.org>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Wed, 25 Sep 2019 17:58:21 +0800
Message-ID: <CAEUhbmUb=KOBje_X_hnmHz9LFDLyE+eb7iJhGkns2WMAsBRCpQ@mail.gmail.com>
Subject: Re: [PATCH V4] target/riscv: Ignore reserved bits in PTE for RV64
To: guoren@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c41
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
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <alistair.francis@wdc.com>, Guo Ren <ren_guo@c-sky.com>,
 Alistair Francis <alistair23@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 25, 2019 at 5:21 PM <guoren@kernel.org> wrote:
>
> From: Guo Ren <ren_guo@c-sky.com>
>
> Highest 10 bits of PTE are reserved in riscv-privileged, ref: [1], so we
> need to ignore them. They cannot be a part of ppn.
>
> 1: The RISC-V Instruction Set Manual, Volume II: Privileged Architecture
>    4.4 Sv39: Page-Based 39-bit Virtual-Memory System
>    4.5 Sv48: Page-Based 48-bit Virtual-Memory System
>
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> Reviewed-by: Liu Zhiwei <zhiwei_liu@c-sky.com>
> ---
>  target/riscv/cpu_bits.h   | 7 +++++++
>  target/riscv/cpu_helper.c | 2 +-
>  2 files changed, 8 insertions(+), 1 deletion(-)
>
> Changelog V4:
>  - Change title to Ignore not Bugfix
>  - Use PTE_PPN_MASK for RV32 and RV64
>
> Changelog V3:
>  - Use UUL define for PTE_RESERVED
>  - Keep ppn >> PTE_PPN_SHIFT
>
> Changelog V2:
>  - Bugfix pte destroyed cause boot fail
>  - Change to AND with a mask instead of shifting both directions
>

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
Tested-by: Bin Meng <bmeng.cn@gmail.com>

