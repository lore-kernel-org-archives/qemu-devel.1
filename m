Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0EB1C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 02:33:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A8A32078D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 02:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a5exzk+O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A8A32078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kB7je-0004Kp-TZ
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 22:33:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59734)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kB7j7-0003tE-NL; Wed, 26 Aug 2020 22:33:21 -0400
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:41811)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kB7j5-00053D-OP; Wed, 26 Aug 2020 22:33:21 -0400
Received: by mail-yb1-xb41.google.com with SMTP id h20so1703728ybj.8;
 Wed, 26 Aug 2020 19:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JaIALXa3Yqh7HoWf+tXyHuWsEwvfL5/e0TESHFzfbjA=;
 b=a5exzk+OM1ADkjFCY4hEqnioqtsyUHqAY4J0R0uTS83iSMllBEVfFchvWB3awYNE9q
 wVGY0++sf/dfizrHtLLIwsO88QKgtgSIKZaYTarAttLPOZ65Eg8eWoEKQdILkqAvdjwH
 CioJ/Kygnl2hfHNC2psbPGmpvrA/TCnbfSE5hBVzPUHfTEsbhh8gXRx7IWxsjU8J6txm
 /SOp4+t/uQgL65IgQnz/3wpKtvNWQGkm27s9pieiqthpfZLYnkTTTKxeNiLS22LAVKQt
 ttybqfDjxcVvfZ5EIC+c46TYU7WZBpARF3V6PaqG2Fk/opTewbhhOXmXlSykHPepUY0g
 eCXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JaIALXa3Yqh7HoWf+tXyHuWsEwvfL5/e0TESHFzfbjA=;
 b=hDsAd4ab2PS317JWm6lpxJD6eKybmhN2K6i8X0uzv8HQZy6uLVkjXq9zXRwMBEnrog
 CquAN5lJoQiIKUaqXXMYWPsJgXHXKWoSaVQkb+bxgheOWiWqTPtIP96Z49dh1HL/ct1M
 C3lhTajxrwXMJwL8smiJdnnbWf8vpBNxmxiyU6NtpoUrxxBCKtA+lwjYMTdX9X7Psa4d
 Xo4qMh09V4x1YJFnn+4Lie5UcuHB47n5FhhdJ/cAM0yNs+LN+vu+4AzPKJo0ruXM8nvV
 SwUDxlTTxF/sXHp9dmC24qECxvcJlv68QRfXvIZeSnD6AMGnsy6zvDX0VQ6zpv1x9T3P
 XB5Q==
X-Gm-Message-State: AOAM531nDYi5ckl7BvhPngLBV4Fa+1tMioRQbczKvs4cvbZwzwvae/UF
 3YuI73zkIL+hRMJwGOsW20iHq91fCKNGzrK+RrQ=
X-Google-Smtp-Source: ABdhPJwKaKfhQHihAJCrtnKRWqQ7AcpzNXOnMfEEhRhI3EaT/hH2ymFQPC+mfvUE27IFw6CnaHVKvLFFptXXENLQ6z8=
X-Received: by 2002:a25:4251:: with SMTP id p78mr24850181yba.306.1598495598354; 
 Wed, 26 Aug 2020 19:33:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200818170839.20258-1-green.wan@sifive.com>
 <20200818170839.20258-2-green.wan@sifive.com>
In-Reply-To: <20200818170839.20258-2-green.wan@sifive.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Thu, 27 Aug 2020 10:32:18 +0800
Message-ID: <CAEUhbmUn+vm_qmrko5WKYzu5uwQbCsbQXf9nWxkZVAXaq_+7Bg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 1/2] hw/riscv: sifive_u: Add backend drive support
To: Green Wan <green.wan@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b41;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yb1-xb41.google.com
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
> Add '-drive' support to OTP device. Allow users to assign a raw file
> as OTP image.
>
> Signed-off-by: Green Wan <green.wan@sifive.com>
> ---
>  hw/riscv/sifive_u_otp.c         | 50 +++++++++++++++++++++++++++++++++
>  include/hw/riscv/sifive_u_otp.h |  2 ++
>  2 files changed, 52 insertions(+)
>
> diff --git a/hw/riscv/sifive_u_otp.c b/hw/riscv/sifive_u_otp.c
> index f6ecbaa2ca..4552b2409e 100644
> --- a/hw/riscv/sifive_u_otp.c
> +++ b/hw/riscv/sifive_u_otp.c
> @@ -24,6 +24,8 @@
>  #include "qemu/log.h"
>  #include "qemu/module.h"
>  #include "hw/riscv/sifive_u_otp.h"
> +#include "sysemu/blockdev.h"
> +#include "sysemu/block-backend.h"
>
>  static uint64_t sifive_u_otp_read(void *opaque, hwaddr addr, unsigned int size)
>  {
> @@ -46,6 +48,16 @@ static uint64_t sifive_u_otp_read(void *opaque, hwaddr addr, unsigned int size)
>          if ((s->pce & SIFIVE_U_OTP_PCE_EN) &&
>              (s->pdstb & SIFIVE_U_OTP_PDSTB_EN) &&
>              (s->ptrim & SIFIVE_U_OTP_PTRIM_EN)) {
> +
> +            /* read from backend*/

nits: need a space before */

> +            if (s->blk) {
> +                int32_t buf;
> +
> +                blk_pread(s->blk, s->pa * SIFIVE_U_OTP_FUSE_WORD, &buf,
> +                          SIFIVE_U_OTP_FUSE_WORD);
> +                return buf;
> +            }
> +
>              return s->fuse[s->pa & SIFIVE_U_OTP_PA_MASK];
>          } else {
>              return 0xff;
> @@ -123,6 +135,12 @@ static void sifive_u_otp_write(void *opaque, hwaddr addr,
>          s->ptrim = val32;
>          break;
>      case SIFIVE_U_OTP_PWE:
> +        /* write to backend */
> +        if (s->blk) {
> +            blk_pwrite(s->blk, s->pa * SIFIVE_U_OTP_FUSE_WORD, &val32,
> +                       SIFIVE_U_OTP_FUSE_WORD, 0);
> +        }
> +
>          s->pwe = val32;
>          break;
>      default:
> @@ -143,16 +161,48 @@ static const MemoryRegionOps sifive_u_otp_ops = {
>
>  static Property sifive_u_otp_properties[] = {
>      DEFINE_PROP_UINT32("serial", SiFiveUOTPState, serial, 0),
> +    DEFINE_PROP_DRIVE("drive", SiFiveUOTPState, blk),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>
>  static void sifive_u_otp_realize(DeviceState *dev, Error **errp)
>  {
>      SiFiveUOTPState *s = SIFIVE_U_OTP(dev);
> +    DriveInfo *dinfo;
>
>      memory_region_init_io(&s->mmio, OBJECT(dev), &sifive_u_otp_ops, s,
>                            TYPE_SIFIVE_U_OTP, SIFIVE_U_OTP_REG_SIZE);
>      sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mmio);
> +
> +    dinfo = drive_get_next(IF_NONE);
> +    if (dinfo) {
> +        int ret;
> +        uint64_t perm;
> +        int filesize;
> +        BlockBackend   *blk;

nits: keep one space in between

> +
> +        blk = blk_by_legacy_dinfo(dinfo);
> +        filesize = SIFIVE_U_OTP_NUM_FUSES * SIFIVE_U_OTP_FUSE_WORD;
> +        if (blk_getlength(blk) < filesize) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "OTP drive size < 16K\n");
> +            return;
> +        }
> +
> +        qdev_prop_set_drive(dev, "drive", blk_by_legacy_dinfo(dinfo));

Use blk for blk_by_legacy_dinfo(dinfo)

> +
> +        perm = BLK_PERM_CONSISTENT_READ |
> +                        (blk_is_read_only(s->blk) ? 0 : BLK_PERM_WRITE);
> +        ret = blk_set_perm(s->blk, perm, BLK_PERM_ALL, errp);
> +        if (ret < 0) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "set perm error.");
> +        }
> +
> +        if (blk_pread(s->blk, 0, s->fuse, filesize) != filesize) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "failed to read the initial flash content");
> +            return;
> +        }
> +    }
>  }
>
>  static void sifive_u_otp_reset(DeviceState *dev)
> diff --git a/include/hw/riscv/sifive_u_otp.h b/include/hw/riscv/sifive_u_otp.h
> index 639297564a..dea1df6f6c 100644
> --- a/include/hw/riscv/sifive_u_otp.h
> +++ b/include/hw/riscv/sifive_u_otp.h
> @@ -43,6 +43,7 @@
>
>  #define SIFIVE_U_OTP_PA_MASK        0xfff
>  #define SIFIVE_U_OTP_NUM_FUSES      0x1000
> +#define SIFIVE_U_OTP_FUSE_WORD      4
>  #define SIFIVE_U_OTP_SERIAL_ADDR    0xfc
>
>  #define SIFIVE_U_OTP_REG_SIZE       0x1000
> @@ -75,6 +76,7 @@ typedef struct SiFiveUOTPState {
>      uint32_t fuse[SIFIVE_U_OTP_NUM_FUSES];
>      /* config */
>      uint32_t serial;
> +    BlockBackend   *blk;

nits: keep one space in between

>  } SiFiveUOTPState;
>
>  #endif /* HW_SIFIVE_U_OTP_H */
> --

Regards,
Bin

