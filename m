Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85FD9C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 21:05:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45C17208C4
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 21:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qhToaeSe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45C17208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgy3g-0004w5-RU
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 17:05:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53109)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hgy2M-0004Vh-Lg
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 17:04:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hgy2L-0004ES-EP
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 17:04:02 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:41794)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hgy2I-0003mj-4i; Fri, 28 Jun 2019 17:03:58 -0400
Received: by mail-lj1-x241.google.com with SMTP id 205so7284197ljj.8;
 Fri, 28 Jun 2019 14:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WADTzPMgYUPy7V7EOSUQxb+kwM0UFCJ0xF4GZYoSD4c=;
 b=qhToaeSejP3EYnxiCKlUl5aPw0CiAvjm0e5coE8+Ud0iwqQvqQVM4bVhEKcyFsyh9R
 JsYYgj2d5cwGsSM5K9d3w3i/yYRZjVPxViijCVIFR/EHaWxcVIcFU+2+PFkiUhZSt2Uu
 4F4IsKndz/9z8Yw6IYsFmGt+rW5YJFjxcFHWZNgEEGCAz4Bh/3KqAuIg6I1AJ8GQwmXX
 VDHjV/RZQE6AY6wN0afOdbKDFxO0pooYbJ3PCDM31zYBqn35bS4f93nh0ciJp0nggXMj
 4XWZO4FTmp9rcZVTVdsySDVeVJHfaa98a3TIih/K5j0vNwTV38nQBbaGqqyYoJGVlh7B
 3DzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WADTzPMgYUPy7V7EOSUQxb+kwM0UFCJ0xF4GZYoSD4c=;
 b=CL5vwdI9t5thtT1bKlM0YTz0/O5Osuuc5BGNGQwRNmjvTk3bmEQ2cQCGbo4ciPpH5x
 iLVQn8Ak701difry4NyH99JMeFklwzWtEmVnBkYFln+CL8jhAU4LCJAv0hAyxtDg4e67
 TgHD+BDkZkxiL6e3QtVzI1nPvYtyvQ5+i2eTq1EkyaIIAJdP5Gwzj5nWlGX+h5aTzbsX
 l7u/3KcYjsO0OHVthMTFu2LQPcfoFIrfoaVZ9VLHWMw2kmOmgX+8/Rtpi5FFqmEKZt0W
 iMlS4Q8XJlfNzdzDh2x6mc7SISOdmZMIXMAhJUwZEzPvu92ZNnzwwLi2uqu7eP4IXrnh
 RJmw==
X-Gm-Message-State: APjAAAUW6gmvCIB99wjLcY+bM272S2dA/yg2HoW43DulGMJPeF6dBFok
 RKtrsI6yASL5gZshKckjvV4Ot8DhkbI5Wm36V58=
X-Google-Smtp-Source: APXvYqz86jv82ihenGfCd5W+EFolDGdoCpw0nIfTn/n8HxozGVnGLRqWH+DFMgaE1IU0hE/gnJHV39bfZ+BETFQ6yQw=
X-Received: by 2002:a2e:9758:: with SMTP id f24mr7441609ljj.58.1561755817818; 
 Fri, 28 Jun 2019 14:03:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190628201133.14235-1-jonathan@fintelia.io>
In-Reply-To: <20190628201133.14235-1-jonathan@fintelia.io>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 28 Jun 2019 14:00:36 -0700
Message-ID: <CAKmqyKNKD4k-Z=-cbFwqnqRQV3e+EO0V0G-brYGeHW4ir0Z+yA@mail.gmail.com>
To: Jonathan Behrens <jonathan@fintelia.io>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::241
Subject: Re: [Qemu-devel] [PATCH] target/riscv: Hardwire mcounter.TM and
 upper bits of [m|s]counteren
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
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 28, 2019 at 1:12 PM <jonathan@fintelia.io> wrote:
>
> From: Jonathan Behrens <jonathan@fintelia.io>
>
> QEMU currently always triggers an illegal instruction exception when code
> attempts to read the time CSR. This is valid behavor, but only if the TM bit in
> mcounteren is hardwired to zero. This change also corrects mcounteren and scounteren CSRs to be 32-bits on both
> 32-bit and 64-bit targets.

Thanks for the patch.

Can you wrap your commit message at ~70 lines?

>
> Signed-off-by: Jonathan Behrens <jonathan@fintelia.io>
> ---
>  target/riscv/cpu.h | 4 ++--
>  target/riscv/csr.c | 3 ++-
>  2 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 0adb307f32..2d0cbe9c78 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -151,8 +151,8 @@ struct CPURISCVState {
>      target_ulong mcause;
>      target_ulong mtval;  /* since: priv-1.10.0 */
>
> -    target_ulong scounteren;
> -    target_ulong mcounteren;
> +    uint32_t scounteren;
> +    uint32_t mcounteren;
>
>      target_ulong sscratch;
>      target_ulong mscratch;
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index e0d4586760..89cf9734c3 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -473,7 +473,8 @@ static int write_mcounteren(CPURISCVState *env, int csrno, target_ulong val)
>      if (env->priv_ver < PRIV_VERSION_1_10_0) {
>          return -1;
>      }
> -    env->mcounteren = val;
> +    /* mcounteren.TM is hardwired to zero, all other bits are writable */
> +    env->mcounteren = val & ~(1 << (CSR_TIME & 31));

Isn't CSR_TIME & 31 just 0? Can this just be changed 1 << 1 or even
better add a macro?

Otherwise this patch looks good :)

Alistair

>      return 0;
>  }
>
> --
> 2.22.0
>

