Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18740C4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 18:45:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 676B624630
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 18:45:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nbGjXqep"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 676B624630
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVfaO-00042U-NJ
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 14:45:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54494)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kVfXI-0002Ci-D8; Thu, 22 Oct 2020 14:42:05 -0400
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144]:36032)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kVfXG-0005ep-7O; Thu, 22 Oct 2020 14:42:04 -0400
Received: by mail-il1-x144.google.com with SMTP id p10so2665476ile.3;
 Thu, 22 Oct 2020 11:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=RRQirIiF1yuIgWCad5dqcb+mARLJmIJ+lMNO+sRWVAg=;
 b=nbGjXqepvlht+dXj31z3XCL9Fbv681ZdI6mJDcocc+chH9ZcKRwH02I5gCsJxmIfQ4
 /0NnumDDpEsROIEyO76BVKbLB2BMz8cvw5wbyq82QvL6xZ9iEJ70BPaF2MtpeDYN5O3u
 elYogTPq51izcVxEsHqSOwb68MRVqrACoKxGEmOgXItn71NEJVY2T05UPMwpyKbTIYv2
 czcDiDNPEVRL4643QYHw3qVrqmjh79TJ/ivjOjhrvfzl4M3Tlq7D0u/h24cgLcqIu+AY
 DKIecIuHhbxx5R4n9gtRtf+AmaEU+78bEOEE99RrQoCZp36fXPlB1eH1LmsCDluGlL4W
 VuMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RRQirIiF1yuIgWCad5dqcb+mARLJmIJ+lMNO+sRWVAg=;
 b=R+iz2+9HTytn4wNMGPTisSXlnC2fj8sCDLfremgrCC7Vqj0f8uGFManu4ja4wKEpLU
 3ipoV74+ABE56oGTEbbtlSQEicFj7SbPgJXWZcgloZB5hGTN4tgUAxZbF+4yEkY/U9PU
 kOO54hjXoPTDRqjy3NnAc1pyJNTZI7B2K7zO8FqL94AiNbX0fXHvsG71pCzFrr/OBpe4
 3oHgOCfGRPg2FqEe1DhUwpPFj9DF5KjilV5f69Igpy3AskGY7Ppab1s37t6+QBebwTXv
 bu0VI62X/ulWbzrUz7QRH6dYUpVtX5SQcPBNjeMTYkpa10LVlgDIiqbEQZqAdO0+/S8I
 tkqA==
X-Gm-Message-State: AOAM530enPMnYcV6+qHKG6eyl/r3z85M1D46/Ej7e3gDccMfGfNof/Z4
 1paUxOZjLApscWOkd08vWg+JeyMOzEx6urEEADg=
X-Google-Smtp-Source: ABdhPJwM8/mRl8r/0YBqv6FC8eh8NbuLzL3gvpPHq18u5hsC643Ug+xMDdmtyLcOVBw3fiksD9nXmlCIafL0EBPe6Hs=
X-Received: by 2002:a92:dd0f:: with SMTP id n15mr3069665ilm.227.1603392119593; 
 Thu, 22 Oct 2020 11:41:59 -0700 (PDT)
MIME-Version: 1.0
References: <20201020033732.12921-1-green.wan@sifive.com>
 <20201020033732.12921-3-green.wan@sifive.com>
In-Reply-To: <20201020033732.12921-3-green.wan@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 22 Oct 2020 11:30:14 -0700
Message-ID: <CAKmqyKM=ePemA8XL8fY_VnuGp+_B7YySa+Dw524o-PWYuWw8mA@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] hw/misc/sifive_u_otp: Add backend drive support
To: Green Wan <green.wan@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::144;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x144.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
Cc: Bin Meng <bmeng.cn@gmail.com>, "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 19, 2020 at 8:37 PM Green Wan <green.wan@sifive.com> wrote:
>
> Add '-drive' support to OTP device. Allow users to assign a raw file
> as OTP image.
>
> test commands for 16k otp.img filled with zero:
>
> $ dd if=/dev/zero of=./otp.img bs=1k count=16
> $ ./qemu-system-riscv64 -M sifive_u -m 256M -nographic -bios none \
> -kernel ../opensbi/build/platform/sifive/fu540/firmware/fw_payload.elf \
> -d guest_errors -drive if=none,format=raw,file=otp.img
>
> Signed-off-by: Green Wan <green.wan@sifive.com>
> Reviewed-by: Bin Meng <bin.meng@windriver.com>
> Tested-by: Bin Meng <bin.meng@windriver.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/misc/sifive_u_otp.c         | 65 ++++++++++++++++++++++++++++++++++
>  include/hw/misc/sifive_u_otp.h |  2 ++
>  2 files changed, 67 insertions(+)
>
> diff --git a/hw/misc/sifive_u_otp.c b/hw/misc/sifive_u_otp.c
> index b9238d64cb..60066375ab 100644
> --- a/hw/misc/sifive_u_otp.c
> +++ b/hw/misc/sifive_u_otp.c
> @@ -19,11 +19,14 @@
>   */
>
>  #include "qemu/osdep.h"
> +#include "qapi/error.h"
>  #include "hw/qdev-properties.h"
>  #include "hw/sysbus.h"
>  #include "qemu/log.h"
>  #include "qemu/module.h"
>  #include "hw/misc/sifive_u_otp.h"
> +#include "sysemu/blockdev.h"
> +#include "sysemu/block-backend.h"
>
>  #define WRITTEN_BIT_ON 0x1
>
> @@ -54,6 +57,16 @@ static uint64_t sifive_u_otp_read(void *opaque, hwaddr addr, unsigned int size)
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
> @@ -145,6 +158,12 @@ static void sifive_u_otp_write(void *opaque, hwaddr addr,
>              /* write bit data */
>              SET_FUSEARRAY_BIT(s->fuse, s->pa, s->paio, s->pdin);
>
> +            /* write to backend */
> +            if (s->blk) {
> +                blk_pwrite(s->blk, s->pa * SIFIVE_U_OTP_FUSE_WORD,
> +                           &s->fuse[s->pa], SIFIVE_U_OTP_FUSE_WORD, 0);
> +            }
> +
>              /* update written bit */
>              SET_FUSEARRAY_BIT(s->fuse_wo, s->pa, s->paio, WRITTEN_BIT_ON);
>          }
> @@ -168,16 +187,48 @@ static const MemoryRegionOps sifive_u_otp_ops = {
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
> +            error_setg(errp, "OTP drive size < 16K");
> +            return;
> +        }
> +
> +        qdev_prop_set_drive_err(dev, "drive", blk, errp);
> +
> +        if (s->blk) {
> +            perm = BLK_PERM_CONSISTENT_READ |
> +                   (blk_is_read_only(s->blk) ? 0 : BLK_PERM_WRITE);
> +            ret = blk_set_perm(s->blk, perm, BLK_PERM_ALL, errp);
> +            if (ret < 0) {
> +                return;
> +            }
> +
> +            if (blk_pread(s->blk, 0, s->fuse, filesize) != filesize) {
> +                error_setg(errp, "failed to read the initial flash content");
> +            }
> +        }
> +    }
>  }
>
>  static void sifive_u_otp_reset(DeviceState *dev)
> @@ -191,6 +242,20 @@ static void sifive_u_otp_reset(DeviceState *dev)
>      s->fuse[SIFIVE_U_OTP_SERIAL_ADDR] = s->serial;
>      s->fuse[SIFIVE_U_OTP_SERIAL_ADDR + 1] = ~(s->serial);
>
> +    if (s->blk) {
> +        /* Put serial number to backend as well*/
> +        uint32_t serial_data;
> +        int index = SIFIVE_U_OTP_SERIAL_ADDR;
> +
> +        serial_data = s->serial;
> +        blk_pwrite(s->blk, index * SIFIVE_U_OTP_FUSE_WORD,
> +                   &serial_data, SIFIVE_U_OTP_FUSE_WORD, 0);
> +
> +        serial_data = ~(s->serial);
> +        blk_pwrite(s->blk, (index + 1) * SIFIVE_U_OTP_FUSE_WORD,
> +                   &serial_data, SIFIVE_U_OTP_FUSE_WORD, 0);
> +    }
> +
>      /* Initialize write-once map */
>      memset(s->fuse_wo, 0x00, sizeof(s->fuse_wo));
>  }
> diff --git a/include/hw/misc/sifive_u_otp.h b/include/hw/misc/sifive_u_otp.h
> index ebffbc1fa5..5d0d7df455 100644
> --- a/include/hw/misc/sifive_u_otp.h
> +++ b/include/hw/misc/sifive_u_otp.h
> @@ -46,6 +46,7 @@
>
>  #define SIFIVE_U_OTP_PA_MASK        0xfff
>  #define SIFIVE_U_OTP_NUM_FUSES      0x1000
> +#define SIFIVE_U_OTP_FUSE_WORD      4
>  #define SIFIVE_U_OTP_SERIAL_ADDR    0xfc
>
>  #define SIFIVE_U_OTP_REG_SIZE       0x1000
> @@ -80,6 +81,7 @@ struct SiFiveUOTPState {
>      uint32_t fuse_wo[SIFIVE_U_OTP_NUM_FUSES];
>      /* config */
>      uint32_t serial;
> +    BlockBackend *blk;
>  };
>
>  #endif /* HW_SIFIVE_U_OTP_H */
> --
> 2.17.1
>

