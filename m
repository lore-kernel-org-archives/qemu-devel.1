Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 225EEC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 05:43:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 810322222C
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 05:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OScpa8t/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 810322222C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSZZg-00060J-EF
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 01:43:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33642)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kSZY2-0005Uv-5l; Wed, 14 Oct 2020 01:42:04 -0400
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:33219)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kSZXv-00017X-Ms; Wed, 14 Oct 2020 01:42:01 -0400
Received: by mail-yb1-xb41.google.com with SMTP id c3so1689938ybl.0;
 Tue, 13 Oct 2020 22:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=EbRekD8cYxBeSOo53KhOrLUIIOG4ngy/n48+yXoVrhQ=;
 b=OScpa8t/7ymdHijqQYZKpAyeYZoWbwXhnGFspMLkVZjudxshUnXOCLXUDT5MRZD68l
 jtd3GsWvXGnXFK7TdghRLAGz2nvX55xHcIM19MQmizt8/d6PSW3HaVx3226TRq5GIonH
 DOlD3kNQwTUKKtuD9GmBTnetEuCZIZF0+4x7g2tshr92EHwph34Dm1NmdtSYyXXUi+3q
 37TJqR4/Pc/Kb55LVeLuwHwjb6mxSgwgJ4LdJHO1F10BH0e1LuedGFPtVQY+sNypuiB7
 hgyqSIBs55uZbfW1hGTRjfkfAUH5lakTpD4vWG0TFagaA566DQYEeiuggtN876BuyCD7
 eZkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EbRekD8cYxBeSOo53KhOrLUIIOG4ngy/n48+yXoVrhQ=;
 b=Ecmqm0mCFhtoxKrCN0CvmP51t2Kix+5jXan5ec3HjasvEaOwGlQrfkNtVR4LHHjedI
 XF9bbgHEMROMzfsDuT9ulCAY3yaGshqq0NPbu1N/Nhot7g1sEp0YLPomhM9zChrl0j25
 paTXVinIpFHNVcjxyoB+qQX8vrXEx6KyBbRxbp3guGDXWYSGX6+c71aAvTM4zw6Coi4f
 Jt2veyaynp9O+nNCB7X0HB7hRHMcDc2hQHvKpcUlJULDjI4+8+EAcGAKFaOK7XcFqM1w
 Xl0IOVjramq/OL3wYaDwsUU9N6b62uPLyBBJfn5JZ8VJsWg/Rhm4pmNv0u4nX0CZFNuM
 Xxmg==
X-Gm-Message-State: AOAM531KLn/XeiCitID4LSfzuwIAIiQO93MJb33KWwi6dkvLFQK1PtIc
 o7Xi4JnTBd6LH/k0MVk35a5vsPsRnyzn2BMOfyE=
X-Google-Smtp-Source: ABdhPJxsQdXhQ9dRjYSUhn2uCF1315Eg4ZNiAgNT+nMTw+w0VnqVVdk6Zw1xnF8DSlH9FcdyIAJLIEs+4KKjy6jGR+I=
X-Received: by 2002:a25:c1c1:: with SMTP id r184mr281398ybf.517.1602654113271; 
 Tue, 13 Oct 2020 22:41:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200928101146.12786-1-green.wan@sifive.com>
 <20200928101146.12786-3-green.wan@sifive.com>
In-Reply-To: <20200928101146.12786-3-green.wan@sifive.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Wed, 14 Oct 2020 13:41:42 +0800
Message-ID: <CAEUhbmXxRB55E4fMwyG6LUFS9Qz4Enme_Ht_K7ZchnLZfAT11g@mail.gmail.com>
Subject: Re: [RFC PATCH v6 2/2] hw/misc/sifive_u_otp: Add backend drive support
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
Cc: Alistair Francis <alistair23@gmail.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Sep 28, 2020 at 6:12 PM Green Wan <green.wan@sifive.com> wrote:
>
> Add '-drive' support to OTP device. Allow users to assign a raw file
> as OTP image.
>
> test commands for 16k otp.img filled with zero:
>
> dd if=/dev/zero of=./otp.img bs=1k count=16

nits: please prefix the command with a leading "$ ", like

$ dd if=/dev/zero of=./otp.img bs=1k count=16

> ./qemu-system-riscv64 -M sifive_u -m 256M -nographic -bios none \
> -kernel ../opensbi/build/platform/sifive/fu540/firmware/fw_payload.elf \
> -d guest_errors -drive if=none,format=raw,file=otp.img
>
> Signed-off-by: Green Wan <green.wan@sifive.com>
> ---
>  hw/misc/sifive_u_otp.c         | 51 ++++++++++++++++++++++++++++++++++
>  include/hw/misc/sifive_u_otp.h |  2 ++
>  2 files changed, 53 insertions(+)
>
> diff --git a/hw/misc/sifive_u_otp.c b/hw/misc/sifive_u_otp.c
> index 685c1f8e07..f2585c1ed7 100644
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
> +                blk_pwrite(s->blk, s->pa * SIFIVE_U_OTP_FUSE_WORD, &val32,
> +                           SIFIVE_U_OTP_FUSE_WORD, 0);
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

Please add the serial number initialization for the block backend as
well in sifive_u_otp_reset().

The logic should be something like testing offset 0x3f0 and 0x3f4
numbers to see if they follow the rule: value 0x3f0 == ~(value 0x3f4).
If not, the data should be initialized per the `serial` property from
the QEMU object.

Regards,
Bin

