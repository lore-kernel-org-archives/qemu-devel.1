Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9554C4727E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 21:53:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23B51206FB
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 21:53:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uaTst04V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23B51206FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLvfC-0003Tt-2H
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 17:53:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34758)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kLvda-0002uK-TS; Fri, 25 Sep 2020 17:52:18 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:40969)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kLvdX-0005eF-8U; Fri, 25 Sep 2020 17:52:18 -0400
Received: by mail-io1-xd41.google.com with SMTP id z13so4610754iom.8;
 Fri, 25 Sep 2020 14:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vnjBjOjRVaSnLVBQhjV++AQlhblvtg/PLJMNfS8vqE8=;
 b=uaTst04Vuz5mMUZOI1EamXkABaCUYuo8BY61s+zRenluBCbPlZ1croikSmkPWtHNx1
 0ghHEUPsVkZ41yD81f1MnWeEHT45Kiplaao6NEMdaxIS5zPhhZntqJ6dJFn2n2SLuPEM
 ITvnBjedg21wUnVvMd3+FX/pWsssJpKOn86z8xXY3rFAzY253zSQXPKKnDvKw2Acbn2n
 T+XA36CD48hhItuLzOCzNbhKkzpbDROfUSpZEDr02/2gokmsGEk/JyUQAg8qzvLWfLxk
 YuzR6/o2Fy3XGmL1jt+9+9Buk3I1XRPz3sSNM3cecg/38YY2l7HXC7LJhefmJZb1cgA4
 p6Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vnjBjOjRVaSnLVBQhjV++AQlhblvtg/PLJMNfS8vqE8=;
 b=XIgsMg0MV1EoGAlSuJuopbC0neSrh8TORrdiZO/r7JUEaoH1GGNoFplH4/Qqghuovo
 ZbmLAJdeFQ4FnnDTZwefPUpIhQkhecsS3g6/K/qEkhSbjK9B7C6V6/hV6QGz5i/rPGJN
 cpZRmFYYmgUSnF77PrNxXRHsjs/bz2/7uKcu+QPOlVLHwNnirCSYNbuDem5b9MFkjkvK
 tBvvhKDv16vzVUUkuRTm7Q3Nvg5QFUMSXGVbVae1PyvvOOkkvHEEy7qJjBpxu23Vhej9
 y/1dC0yBoZuZZfh7bnitP9ehVvoKm6FzO7jCxKa+R9UsStIQtWnJHO2f/7FULSgzj38w
 g9rQ==
X-Gm-Message-State: AOAM533lXzTEZeyvxkU+7VIWCrYFTG3mt3lTtiHDM8anHv0ngyt2JWtX
 99Z2H53Tjs/+yx3sclNY2Z46Mp/R9swLyCLTn34=
X-Google-Smtp-Source: ABdhPJxpA9Q/UBxJ1VfaUXm1o3k4XyCtLdKifMGOkYHF2RPoL1lOgwSSxbE5zTHo79RBylQy4pFGe4d0m4EnlWUSJYc=
X-Received: by 2002:a05:6602:2f88:: with SMTP id
 u8mr437873iow.175.1601070728208; 
 Fri, 25 Sep 2020 14:52:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200901154711.18457-1-green.wan@sifive.com>
 <20200901154711.18457-3-green.wan@sifive.com>
In-Reply-To: <20200901154711.18457-3-green.wan@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 25 Sep 2020 14:40:49 -0700
Message-ID: <CAKmqyKOqQgE0X3T100Zzi6_8X5d9XVEjam01bhCZSU=-FL-ecw@mail.gmail.com>
Subject: Re: [RFC PATCH v5 2/2] hw/riscv: sifive_u: Add backend drive support
To: Green Wan <green.wan@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d41;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd41.google.com
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Bin Meng <bmeng.cn@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 1, 2020 at 8:49 AM Green Wan <green.wan@sifive.com> wrote:
>
> Add '-drive' support to OTP device. Allow users to assign a raw file
> as OTP image.

Do you mind writing an example command line argument in the commit message?

Also, do you have a test case for this? I would like to add it to my CI.

>
> Signed-off-by: Green Wan <green.wan@sifive.com>
> ---
>  hw/riscv/sifive_u_otp.c         | 50 +++++++++++++++++++++++++++++++++
>  include/hw/riscv/sifive_u_otp.h |  2 ++
>  2 files changed, 52 insertions(+)
>
> diff --git a/hw/riscv/sifive_u_otp.c b/hw/riscv/sifive_u_otp.c
> index b8369e9035..477c54c7b8 100644
> --- a/hw/riscv/sifive_u_otp.c
> +++ b/hw/riscv/sifive_u_otp.c
> @@ -24,6 +24,8 @@
>  #include "qemu/log.h"
>  #include "qemu/module.h"
>  #include "hw/riscv/sifive_u_otp.h"
> +#include "sysemu/blockdev.h"
> +#include "sysemu/block-backend.h"
>
>  #define WRITTEN_BIT_ON 0x1
>
> @@ -54,6 +56,16 @@ static uint64_t sifive_u_otp_read(void *opaque, hwaddr addr, unsigned int size)
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
> @@ -145,6 +157,12 @@ static void sifive_u_otp_write(void *opaque, hwaddr addr,
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
> @@ -168,16 +186,48 @@ static const MemoryRegionOps sifive_u_otp_ops = {
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

I think this should be:

blk = dinfo ? blk_by_legacy_dinfo(dinfo) : NULL;

> +        filesize = SIFIVE_U_OTP_NUM_FUSES * SIFIVE_U_OTP_FUSE_WORD;
> +        if (blk_getlength(blk) < filesize) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "OTP drive size < 16K\n");

You should probably be setting errp instead.

If a user specified a -drive argument, they probably want to error if
we aren't going to use it.

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

Is it worth printing the error?

> +        }
> +
> +        if (blk_pread(s->blk, 0, s->fuse, filesize) != filesize) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "failed to read the initial flash content");
> +            return;

You don't need a return here.

Is this error fatal?

Alistair

> +        }
> +    }
>  }
>
>  static void sifive_u_otp_reset(DeviceState *dev)
> diff --git a/include/hw/riscv/sifive_u_otp.h b/include/hw/riscv/sifive_u_otp.h
> index 4a5a0acf48..9bc781fd4f 100644
> --- a/include/hw/riscv/sifive_u_otp.h
> +++ b/include/hw/riscv/sifive_u_otp.h
> @@ -45,6 +45,7 @@
>
>  #define SIFIVE_U_OTP_PA_MASK        0xfff
>  #define SIFIVE_U_OTP_NUM_FUSES      0x1000
> +#define SIFIVE_U_OTP_FUSE_WORD      4
>  #define SIFIVE_U_OTP_SERIAL_ADDR    0xfc
>
>  #define SIFIVE_U_OTP_REG_SIZE       0x1000
> @@ -78,6 +79,7 @@ typedef struct SiFiveUOTPState {
>      uint32_t fuse_wo[SIFIVE_U_OTP_NUM_FUSES];
>      /* config */
>      uint32_t serial;
> +    BlockBackend *blk;
>  } SiFiveUOTPState;
>
>  #endif /* HW_SIFIVE_U_OTP_H */
> --
> 2.17.1
>
>

