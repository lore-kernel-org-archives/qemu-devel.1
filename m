Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB8EC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 12:55:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2FAD2086A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 12:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fDneK6Hz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2FAD2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBdud-00006V-Vx
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 08:55:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43256)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kBdtx-00083g-Eo; Fri, 28 Aug 2020 08:54:41 -0400
Received: from mail-yb1-xb43.google.com ([2607:f8b0:4864:20::b43]:36574)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kBdtv-0007W7-M1; Fri, 28 Aug 2020 08:54:41 -0400
Received: by mail-yb1-xb43.google.com with SMTP id 189so481792ybw.3;
 Fri, 28 Aug 2020 05:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=RJWERyVloyJGtlnk41IfZJGiOTaDdKFPngYVc79VY2o=;
 b=fDneK6Hz7UqHwZ8FPNfKUZ++wvUS/7+ipE5UEPHZrMB51GbX77jPtPPochYu3+2u8m
 4DoNd9/H+hm0LOiQA6squF500pDH0Gc+B7Gg9SliDcEwv2lF7ZZmOAZnCltNfqD9nwzv
 do+RBb+ZALv95R0f+UgsIQndJGS5eEz1QAd7e2BgkhiKDFWiF6M+zt5Ohk6RZ7RX/rqw
 Cpq3Sh+f1C1R/cCEMwc652ghaOSptBZqMqsErsqHEzAv6TPyqnkMc1h7SaoeIXhVxacs
 dnJ1p7CDy10yWRILfFtZoN8zr8fQcY/suYMAZmrEvmIA5SmIfFx83rs2b5uqiBs3jyTJ
 QZXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RJWERyVloyJGtlnk41IfZJGiOTaDdKFPngYVc79VY2o=;
 b=pK7UGIGnFQ1w4Mlu2R6arUoKRhzulhZnrLSgaE2j0Vbk7sl3uFucL4ByiXh4t8flEV
 UO4J/FlAEQvbYmdInc4xdKTQ+Wrb+So0ucbo69rVRnQqc88TcumfJyvjehPIb+4cQG2m
 gvF7JodkKNbSbivgWf6KYWkm35VHhNqma7eT1UIEGeDXkdQukeU+X8u6Si8iMLjXjYXF
 N8y5d+jTDLn6LKpihCrxfdzvXeGstSGL9kmAdsYs04ejtv8I/s1qbRXX7xH4Mri4biua
 AMZUe6B30ghmUHAPEnMRD97lO0rslLzeZUazo8+VK4Huwf8M8om+7oq2pjKoeniZb3iv
 n1WA==
X-Gm-Message-State: AOAM531/IIlksdd39eqYYdEI4kGCVePrkwOSrfKdK3fO6EEDrM+J0eMO
 RpFcBlZLLl7D2sp9/4BtQA68nEyuQvu9pv6YPvs=
X-Google-Smtp-Source: ABdhPJxtEOchSRKwVThqFQuU9RGQMVGYmdLieMKyD3xWj0++K+Y6x0vKAaqZ9Xhep/l1Ed7eVL2NnNy9Rgf8G3Al+mQ=
X-Received: by 2002:a25:810a:: with SMTP id o10mr2256394ybk.239.1598619277418; 
 Fri, 28 Aug 2020 05:54:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200827074638.21451-1-green.wan@sifive.com>
 <20200827074638.21451-2-green.wan@sifive.com>
In-Reply-To: <20200827074638.21451-2-green.wan@sifive.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Fri, 28 Aug 2020 20:54:26 +0800
Message-ID: <CAEUhbmUXDiBHzy=CMQAYVzt0NY-JK_KVn-QL-Equw6pRxEiu8w@mail.gmail.com>
Subject: Re: [RFC PATCH v4 1/2] hw/riscv: sifive_u: Add backend drive support
To: Green Wan <green.wan@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b43;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yb1-xb43.google.com
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

Hi Green,

On Thu, Aug 27, 2020 at 3:47 PM Green Wan <green.wan@sifive.com> wrote:
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
> index f6ecbaa2ca..aab2220494 100644
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
> +            /* read from backend */
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

The logic looks wrong to me. According to the U-Boot driver
(sifive-otp.c) the content to be written to the OTP memory comes from
s->pdin bit by bit. Here val32 represents whether to disable write or
enable write.

I think we should arrange patches like this:

patch 1 to add OTP write functionality, to the existing s->fuse[] mechanism
patch 2 to add file based backend write support

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
> +        BlockBackend *blk;
> +
> +        blk = blk_by_legacy_dinfo(dinfo);
> +        filesize = SIFIVE_U_OTP_NUM_FUSES * SIFIVE_U_OTP_FUSE_WORD;
> +        if (blk_getlength(blk) < filesize) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "OTP drive size < 16K\n");
> +            return;
> +        }
> +
> +        qdev_prop_set_drive(dev, "drive", blk);
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
> index 639297564a..13d2552e43 100644
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
> +    BlockBackend *blk;
>  } SiFiveUOTPState;
>
>  #endif /* HW_SIFIVE_U_OTP_H */
> --

Regards,
Bin

