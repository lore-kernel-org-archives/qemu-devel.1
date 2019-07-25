Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C9F8C76190
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 21:48:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7A11218D4
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 21:48:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t7PB8zxQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7A11218D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqlb0-0003z3-2S
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 17:48:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47403)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <fintelia@gmail.com>) id 1hqlaq-0003ZA-LU
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 17:48:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fintelia@gmail.com>) id 1hqlap-0007wj-Cu
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 17:48:08 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132]:42057)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <fintelia@gmail.com>)
 id 1hqlap-0007tI-1e; Thu, 25 Jul 2019 17:48:07 -0400
Received: by mail-lf1-x132.google.com with SMTP id s19so35614004lfb.9;
 Thu, 25 Jul 2019 14:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KQ9NrAyyE67UHe5LvMVajFoTQKbRA85crMNldZTKBZs=;
 b=t7PB8zxQGS6wSoa4fWtzhi8bg8pAcyhWhDQdyJkyWrohtwbMU5u1yfE6skVMn/J+Dm
 CrXf2O6NXF4Wjm20ZJDH3DGywE0BLvWweTzku3mHito/mo6vcZSQmPZW9HGAMALQyjns
 ZdJcLocJef/aLmd+BNbK7JnToNEB5GcuqIWaWwwPklWwlRpozgvWjXUu6K7PuDQldAz+
 BkTcUiCQdbhmd6OIMv+nsJwLDkIfk4Y+7IboPKC4Hy4ZpJ4otK6eM0XRmd812ZeiLbQw
 Wro1yYUxTfA2chEQraZoFp3k+okzB/bBbnsVPDDhyvJuSWOAwQaigBDrfv3LJCeF+gH0
 hvkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KQ9NrAyyE67UHe5LvMVajFoTQKbRA85crMNldZTKBZs=;
 b=hBW8aGHt8AClz+b+XwcDIrd8Lse2kadKop5idhGn4rIdociQ9Dnz7RzfkWa6BZaU/h
 pd8A12BQ2V+jEVbrau/DMK51DIudCfLGd5nwliBpNBAalVCrgAs2kxgnnPyLSs6Q5aDt
 P5vVmS4OON2VJBjujphgyk+Z02Hmy8BVZJ1FViQKSHRN11KY1BkU54oVKHO8fuiBYvUx
 xAN0vzlOx1q6m1XJHFrFYs3g6wC0GZii42B8Rsd24zTYERdVeIjeM/XW5Nm/3OrVGkrY
 flRLnuGbC9YE6hQaxACzb6BaAqB0yQvKnWOqm1lrzche/3BsrgdnVH2C5Seysebh4hsP
 2j3A==
X-Gm-Message-State: APjAAAWM5Z10ct7rH4aBZnMVNh9+M8hsB5rJ+JUtbVIA0Ohq5pVNh4yQ
 6iXyhvIkwMxMiWOu0rwx4B9dvkjA+MBE2V88Mzs=
X-Google-Smtp-Source: APXvYqxODWyKLClnp8PVPuxX8SxuRov3MhFN8gQaJl2QPMazaDhMVlWZladWksDXVFmyIuaE8tNliya5M2v2BSVqZA4=
X-Received: by 2002:a19:7006:: with SMTP id h6mr41856589lfc.5.1564091285088;
 Thu, 25 Jul 2019 14:48:05 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1564080680.git.alistair.francis@wdc.com>
 <b415f5b51e09418760b95e5c73fad5e68b97f173.1564080680.git.alistair.francis@wdc.com>
In-Reply-To: <b415f5b51e09418760b95e5c73fad5e68b97f173.1564080680.git.alistair.francis@wdc.com>
From: Jonathan Behrens <fintelia@gmail.com>
Date: Thu, 25 Jul 2019 17:47:22 -0400
Message-ID: <CANnJOVEyy7wb74eEucj5t=xonOvUFTPWuty9R+-KP0DLc+L7zQ@mail.gmail.com>
To: Alistair Francis <alistair.francis@wdc.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::132
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [Qemu-riscv] [PATCH-4.2 v1 2/6] target/riscv:
 Remove strict perm checking for CSR R/W
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

Unless I'm missing something, this is the only place that QEMU checks the
privilege level for read and writes to CSRs. The exact computation used
here won't work with the hypervisor extension, but we also can't just get
rid of privilege checking entirely...

Jonathan

On Thu, Jul 25, 2019 at 2:56 PM Alistair Francis <alistair.francis@wdc.com>
wrote:

> The privledge check based on the CSR address mask 0x300 doesn't work
> when using Hypervisor extensions so remove the check
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/csr.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index e0d4586760..af3b762c8b 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -797,9 +797,8 @@ int riscv_csrrw(CPURISCVState *env, int csrno,
> target_ulong *ret_value,
>
>      /* check privileges and return -1 if check fails */
>  #if !defined(CONFIG_USER_ONLY)
> -    int csr_priv = get_field(csrno, 0x300);
>      int read_only = get_field(csrno, 0xC00) == 3;
> -    if ((write_mask && read_only) || (env->priv < csr_priv)) {
> +    if (write_mask && read_only) {
>          return -1;
>      }
>  #endif
> --
> 2.22.0
>
>
>
