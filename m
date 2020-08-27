Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CED9C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 02:41:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 513A02078D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 02:41:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AUFt9Xvb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 513A02078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kB7rA-0006Le-JZ
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 22:41:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60826)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kB7qN-0005ZU-L9; Wed, 26 Aug 2020 22:40:51 -0400
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42]:44121)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kB7qL-0006wr-QP; Wed, 26 Aug 2020 22:40:51 -0400
Received: by mail-yb1-xb42.google.com with SMTP id i10so2113504ybt.11;
 Wed, 26 Aug 2020 19:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=k9Sf7sLH0JfupEb63RkIfhLSaD3Vx8d23mxSa7CNzHU=;
 b=AUFt9XvbjAJfAAJmmMC3ZDBivhTioEYw8B4LEMc53LVDHLd9KbVzS+hG9JGpMuikyl
 IT3zu2rs3yUAF2iL9Bw/vzakeE+tEIThnZHNvUdk2Xm5flw5fj0Vv1My8JhP98sDgQKq
 KmxH9daDKH6AobrVf27loFhyNk5ydNIvh5FVgXggXGAgOgNoUwnRXw4NqiN3+/mokX1r
 Qo3QB2/gu/67p/kByOZw9eOEp69IC29y7OGcdHt+Cj6BBJgT1B4yOWWejv0Zl3IYA1PO
 Dg8hKK2jU3kqNRWw++4wFPFJPpO6oRKyc+eKmL8zdcNr21mIQEM4gh4w0e0KY6M8u90y
 hr5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=k9Sf7sLH0JfupEb63RkIfhLSaD3Vx8d23mxSa7CNzHU=;
 b=Vtp7V+T7RdGrBkAD6NRHuhCCvKq6j4bD0+BPeiCWQlw/VqDMYaPuh7Xa/208n6+Nlg
 mMznFYdWOoPcOsqYmkr8kiFXUySm6qpiu86mfOCEMbnPY1bm+RXLnd5y1L2GU7SDjkDq
 BPIdNLBXqtr1tW6KXJBQcO9O3rzS33HTeTEgkv5UUrjWJR5ZvKLKk0bCbpX7dXZ7lv5s
 aP7J2soeRTdmb+CAz9WndMurve3AE6SMhuSrM1pWc/YHEnXnAnAfwDWtv3y5UZgBso0c
 d48Cv27l7sc20o/9tCvQ0cpKf78kYJgldqoPuobWGnnSYk2nv5R9yXkAygvJLO+e8lba
 wU+Q==
X-Gm-Message-State: AOAM533Q1cfMaXl7Q5+VGT2i2ICeKe4Z8PUCpVTOTYPWpGTbIFlvNUdQ
 AWzHQoXbUdjuxhdv/KG+zYc+SfnJoFHBjtvWo/E=
X-Google-Smtp-Source: ABdhPJx0rBWiDQILDFNWPe5KlmQHARuZG/O14zToouz1XI7zdJiEOqZ0JujMwP379YP60IqC7ykPfiklKIr0FAe8f6M=
X-Received: by 2002:a25:d946:: with SMTP id q67mr23132176ybg.517.1598496048168; 
 Wed, 26 Aug 2020 19:40:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200818170839.20258-1-green.wan@sifive.com>
 <20200818170839.20258-3-green.wan@sifive.com>
In-Reply-To: <20200818170839.20258-3-green.wan@sifive.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Thu, 27 Aug 2020 10:39:24 +0800
Message-ID: <CAEUhbmXAcN2zbM2VrtX5ZEB3BJ8SM9ZRc1aN1cG=ex6BaKQ_-A@mail.gmail.com>
Subject: Re: [RFC PATCH v3 2/2] hw/riscv: sifive_u: Add write-once protection.
To: Green Wan <green.wan@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b42;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yb1-xb42.google.com
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 19, 2020 at 1:09 AM Green Wan <green.wan@sifive.com> wrote:
>
> Add array to store the 'written' status for all bit of OTP to block
> the write operation to the same bit. Ignore the control register
> offset from 0x0 to 0x38 of OTP memory mapping.

nits: please remove the ending period in the commit title

>
> Signed-off-by: Green Wan <green.wan@sifive.com>
> ---
>  hw/riscv/sifive_u_otp.c         | 21 +++++++++++++++++++++
>  include/hw/riscv/sifive_u_otp.h |  1 +
>  2 files changed, 22 insertions(+)
>
> diff --git a/hw/riscv/sifive_u_otp.c b/hw/riscv/sifive_u_otp.c
> index 4552b2409e..3a25652735 100644
> --- a/hw/riscv/sifive_u_otp.c
> +++ b/hw/riscv/sifive_u_otp.c
> @@ -27,6 +27,12 @@
>  #include "sysemu/blockdev.h"
>  #include "sysemu/block-backend.h"
>
> +#define SET_WRITTEN_BIT(map, idx, bit)    \
> +    (map[idx] |= (0x1 << bit))
> +
> +#define GET_WRITTEN_BIT(map, idx, bit)    \
> +    ((map[idx] >> bit) & 0x1)
> +
>  static uint64_t sifive_u_otp_read(void *opaque, hwaddr addr, unsigned int size)
>  {
>      SiFiveUOTPState *s = opaque;
> @@ -135,6 +141,18 @@ static void sifive_u_otp_write(void *opaque, hwaddr addr,
>          s->ptrim = val32;
>          break;
>      case SIFIVE_U_OTP_PWE:
> +        /* Keep written state for data only and PWE is enabled. Ignore PAS=1 */
> +        if ((s->pa > SIFIVE_U_OTP_PWE) && (val32 & 0x1) && !s->pas) {
> +            if (GET_WRITTEN_BIT(s->fuse_wo, s->pa, s->paio)) {
> +                qemu_log_mask(LOG_GUEST_ERROR,
> +                              "Error: write idx<%u>, bit<%u>\n",
> +                              s->pa, s->paio);
> +                break;
> +            } else {
> +                SET_WRITTEN_BIT(s->fuse_wo, s->pa, s->paio);

Shouldn't the write operation below be moved to this else branch?

> +            }
> +        }
> +
>          /* write to backend */
>          if (s->blk) {
>              blk_pwrite(s->blk, s->pa * SIFIVE_U_OTP_FUSE_WORD, &val32,
> @@ -215,6 +233,9 @@ static void sifive_u_otp_reset(DeviceState *dev)
>      /* Make a valid content of serial number */
>      s->fuse[SIFIVE_U_OTP_SERIAL_ADDR] = s->serial;
>      s->fuse[SIFIVE_U_OTP_SERIAL_ADDR + 1] = ~(s->serial);
> +
> +    /* Initialize write-once map */
> +    memset(s->fuse_wo, 0x00, sizeof(s->fuse_wo));
>  }
>
>  static void sifive_u_otp_class_init(ObjectClass *klass, void *data)
> diff --git a/include/hw/riscv/sifive_u_otp.h b/include/hw/riscv/sifive_u_otp.h
> index dea1df6f6c..ab6e46b013 100644
> --- a/include/hw/riscv/sifive_u_otp.h
> +++ b/include/hw/riscv/sifive_u_otp.h
> @@ -74,6 +74,7 @@ typedef struct SiFiveUOTPState {
>      uint32_t ptrim;
>      uint32_t pwe;
>      uint32_t fuse[SIFIVE_U_OTP_NUM_FUSES];
> +    uint32_t fuse_wo[SIFIVE_U_OTP_NUM_FUSES];
>      /* config */
>      uint32_t serial;
>      BlockBackend   *blk;
> --

Regards,
Bin

