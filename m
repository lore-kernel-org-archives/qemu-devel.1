Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A013DC31E5B
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 15:22:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EFDA2187F
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 15:22:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OBzQ9/kp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EFDA2187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39344 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdcQJ-0008V4-Gg
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 11:22:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40048)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bmeng.cn@gmail.com>) id 1hdcK1-0004NB-1W
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 11:16:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hdcK0-0005CP-5B
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 11:16:24 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:43007)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hdcJz-0005CB-Ve; Wed, 19 Jun 2019 11:16:24 -0400
Received: by mail-ed1-x542.google.com with SMTP id z25so27719497edq.9;
 Wed, 19 Jun 2019 08:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZmOayp97dTILQ2V5VnPYKdnTM/WfPEcqF+03l5Eol6g=;
 b=OBzQ9/kpTyiDdU7jSGRCEC0uTn06F/zWtllZe1joLTGpV0nliFMYXkbZcg+DMoTeIE
 /nmesKxVYiGpqW0jfV5+pGyDPhUR5/zubK82/b5L77OKLwghdFQjbhwkAbrRAM4c6wAz
 HBYI7TNiMo1fTZcsVBF7cL3Wbbxb+OSXuI+kuZ/5SFkC3J01wuLozLTvAZJFI3O0T2ci
 cSC1mH63nvUDnxsqbAiwpPS2oQL2nWzY58oQcC9J1/lS2Dcyb3KetbkSG1XBlOVD4R4c
 1zpfxnuMLQsXgVa1C0Xk2OBk4PK6Wt9ISKELW4mcI+PYm6JAJJLNMeCB68PYAggy2ecu
 /8Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZmOayp97dTILQ2V5VnPYKdnTM/WfPEcqF+03l5Eol6g=;
 b=huJ9mJO3wwry947F4Emkn/zie5j9mWZkiMNA4CuKs6YPfLrUAh56JF1cVEBJRIVSND
 b1L3CnxMnyTssqb+oY037W+t/TwEGx216beDNvKvPviubbMQ6fk4BJWjAiqSi05Kp9zT
 SEmMydRpWjbhhq9raXeF56vjCcvTfV8P+pdGgl5t/y8HByB1nK7x26I1fdX9e42DeLEq
 7DRloD+vtZa55Bro9UQ4kJ6rf7Q5sc2z6WnvprjBpiFP6k233nx4rkEYU6JrLg/EjUsk
 267Whx+cJC4eCvwEF050AORW3zlQstw1bM9cT9CiVGzqMC1iqU8Z6bgdKwAprdNoxB+h
 zJxA==
X-Gm-Message-State: APjAAAVTQshsLADw4r0TmjmtRr9OPHyP7mL9gawkk746Iv9OXaslqmj6
 BKHCHblwkHu6+8rS+x5RUkV6QGiyDeNAd2r682xt0Hsf
X-Google-Smtp-Source: APXvYqzs/RaRVJ/3j4phMtEU1Z5obxOY3xze7lf+XFvltawWY7UuWF9sSktMyxnWq3motFyjl/ECuLdRSnHJywhOdA4=
X-Received: by 2002:a17:906:ad86:: with SMTP id
 la6mr9413414ejb.43.1560957383081; 
 Wed, 19 Jun 2019 08:16:23 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1560904640.git.alistair.francis@wdc.com>
 <99fc8fe28f2a0493f248d50d32d4b1bc649536ab.1560904640.git.alistair.francis@wdc.com>
In-Reply-To: <99fc8fe28f2a0493f248d50d32d4b1bc649536ab.1560904640.git.alistair.francis@wdc.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Wed, 19 Jun 2019 23:16:11 +0800
Message-ID: <CAEUhbmXKv7-r3KyDGnq8ysmyccy1tVgBDqwLcf46U96BZOiKYw@mail.gmail.com>
To: Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::542
Subject: Re: [Qemu-devel] [RFC v1 3/5] hw/riscv: Extend the kernel loading
 support
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

On Wed, Jun 19, 2019 at 8:56 AM Alistair Francis
<alistair.francis@wdc.com> wrote:
>
> Extend the RISC-V kernel loader to support uImage and Image files.
> A Linux kernel can now be booted with:
>
>     qemu-system-riscv64 -machine virt -bios fw_jump.elf -kernel Image
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  hw/riscv/boot.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
>
> diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
> index 392ca0cb2e..7f68035a3f 100644
> --- a/hw/riscv/boot.c
> +++ b/hw/riscv/boot.c
> @@ -67,13 +67,22 @@ target_ulong riscv_load_kernel(MachineState *machine,
>      uint64_t kernel_entry, kernel_high;
>
>      if (load_elf(kernel_filename, NULL, kernel_translate, machine,
> -                 &kernel_entry, NULL, &kernel_high,
> -                 0, EM_RISCV, 1, 0) < 0) {
> -        error_report("could not load kernel '%s'", kernel_filename);
> -        exit(1);
> +                 &kernel_entry, NULL, &kernel_high, 0, EM_RISCV, 1, 0) > 0) {
> +        return kernel_entry;
> +    }
> +
> +    if (load_uimage_as(kernel_filename, &kernel_entry, NULL, NULL,
> +                       kernel_translate, machine, NULL) > 0) {

We should not set the 'kernel_translate' here for uImage.

In fact, the whole kernel_translate() is not necessary.

> +        return kernel_entry;
> +    }
> +

Regards,
Bin

