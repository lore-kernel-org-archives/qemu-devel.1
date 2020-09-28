Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A22AC2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 09:26:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1AD121D95
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 09:26:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="JF3ZR2PV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1AD121D95
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMpQ7-0005kv-Rs
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 05:26:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47554)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <green.wan@sifive.com>)
 id 1kMpIh-000640-7H
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 05:18:28 -0400
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:38419)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <green.wan@sifive.com>)
 id 1kMpIf-0002ih-6M
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 05:18:26 -0400
Received: by mail-qk1-x743.google.com with SMTP id d20so304883qka.5
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2020 02:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zydUDfHqvBBYKXIwxde4mSeIqQaIEeuMG9Pyz0aVv9Q=;
 b=JF3ZR2PVmpxinZYu92P1VJ9K13Q7tzg5PvaNqER/L8KMxwGceNTZO7neGuD+qW7jR3
 qLV3i5J+nr8SCBULEIMMps2urVoN2hUf1xKNR3duRFc5a63D1zOL+/ZF0GkiGgDllHKS
 HUyhKjzI7ZdV6zR/TIZjMij5PN64H6c6cEQ3Ji5QpUI6boblLw9aN37oKodIUP773BPF
 tYkklLozXmnrQHRkgh0DcnSb/jCYni5XJY4BMzqAjmiMwnaOWYpngtcw2+Vfva2W24Xf
 7BWg/8idwyupvs7QtXAfHgydlDNZPc+UkU8po2c9/1V5B9HBL2M6gneY1+mHqaOdYTge
 MnVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zydUDfHqvBBYKXIwxde4mSeIqQaIEeuMG9Pyz0aVv9Q=;
 b=BD5Z3OFeMubTjpyc32XacI37wG8PKCdPdIbST56JQ2+k8+m/gUKQqPZuDDDKmPnW60
 9JiD7bH9satkMk3oIiZKWWImmTkRDcGbY63Z0YnlXRIApupbXrzqc9pv+2dh1gTg1H5Y
 BZ1gVpCXgiuuxPX7l2EQi8RAMiM4tRm/op/pGb2dqofA4vl085HVw67NuQH4UtXwjqwU
 SA6tvleld53yDL3esw5smygO69I2XFeY4vl/ngNyhdmCR5ufx34hFLAimbb+HNnocI/y
 tcCHAsmv6PX09FLCDi/Z2o6eN9Px67imJMiZGgfJWx9RFcZcWbti//qtNW70u9VOT7Da
 27DQ==
X-Gm-Message-State: AOAM532RoYnb7ql/doxebGTpHSGwJhF9QSxX+VcTEfLSQS8MsTackuBK
 zKt58C1ZN4Gr3MB8CK+IRNOX5T0cVP7DN6+3W3+asg==
X-Google-Smtp-Source: ABdhPJxd9ogz4hpvfQ2DAEO7nBUIkN6Z1qOxwylFBzaBEypn1PVDfNfliDriLwSmWBSWHEal8Q16+gDdAUQzZqLC2J0=
X-Received: by 2002:a37:5a47:: with SMTP id o68mr505918qkb.234.1601284702925; 
 Mon, 28 Sep 2020 02:18:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200901154711.18457-1-green.wan@sifive.com>
 <20200901154711.18457-3-green.wan@sifive.com>
 <CAKmqyKOqQgE0X3T100Zzi6_8X5d9XVEjam01bhCZSU=-FL-ecw@mail.gmail.com>
In-Reply-To: <CAKmqyKOqQgE0X3T100Zzi6_8X5d9XVEjam01bhCZSU=-FL-ecw@mail.gmail.com>
From: Green Wan <green.wan@sifive.com>
Date: Mon, 28 Sep 2020 17:18:11 +0800
Message-ID: <CAJivOr4xLP1n4eVFyWHi=ckg17C_j76f=+o+YPztsYuaPDwCCw@mail.gmail.com>
Subject: Re: [RFC PATCH v5 2/2] hw/riscv: sifive_u: Add backend drive support
To: Alistair Francis <alistair23@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::743;
 envelope-from=green.wan@sifive.com; helo=mail-qk1-x743.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi Alistair,

Thanks for the review. See the reply inline below.


On Sat, Sep 26, 2020 at 5:52 AM Alistair Francis <alistair23@gmail.com> wrote:
>
> On Tue, Sep 1, 2020 at 8:49 AM Green Wan <green.wan@sifive.com> wrote:
> >
> > Add '-drive' support to OTP device. Allow users to assign a raw file
> > as OTP image.
>
> Do you mind writing an example command line argument in the commit message?
>
> Also, do you have a test case for this? I would like to add it to my CI.
>

Do you mean qtest? I run uboot and use uboot driver to test it and
didn't create a qemu test case.
Here is the command I use:

$ qemu-system-riscv64 -M sifive_u -m 256M -nographic -bios none
-kernel ../opensbi/build/platform/sifive/fu540/firmware/fw_payload.elf
-d guest_errors -drive if=none,format=raw,file=otp.img

I'll check how to create a test case but maybe not that soon in the next patch.

> >
> > Signed-off-by: Green Wan <green.wan@sifive.com>
> > ---
> >  hw/riscv/sifive_u_otp.c         | 50 +++++++++++++++++++++++++++++++++
> >  include/hw/riscv/sifive_u_otp.h |  2 ++
> >  2 files changed, 52 insertions(+)
> >
> > diff --git a/hw/riscv/sifive_u_otp.c b/hw/riscv/sifive_u_otp.c
> > index b8369e9035..477c54c7b8 100644
> > --- a/hw/riscv/sifive_u_otp.c
> > +++ b/hw/riscv/sifive_u_otp.c
> > @@ -24,6 +24,8 @@
> >  #include "qemu/log.h"
> >  #include "qemu/module.h"
> >  #include "hw/riscv/sifive_u_otp.h"
> > +#include "sysemu/blockdev.h"
> > +#include "sysemu/block-backend.h"
> >
> >  #define WRITTEN_BIT_ON 0x1
> >
> > @@ -54,6 +56,16 @@ static uint64_t sifive_u_otp_read(void *opaque, hwaddr addr, unsigned int size)
> >          if ((s->pce & SIFIVE_U_OTP_PCE_EN) &&
> >              (s->pdstb & SIFIVE_U_OTP_PDSTB_EN) &&
> >              (s->ptrim & SIFIVE_U_OTP_PTRIM_EN)) {
> > +
> > +            /* read from backend */
> > +            if (s->blk) {
> > +                int32_t buf;
> > +
> > +                blk_pread(s->blk, s->pa * SIFIVE_U_OTP_FUSE_WORD, &buf,
> > +                          SIFIVE_U_OTP_FUSE_WORD);
> > +                return buf;
> > +            }
> > +
> >              return s->fuse[s->pa & SIFIVE_U_OTP_PA_MASK];
> >          } else {
> >              return 0xff;
> > @@ -145,6 +157,12 @@ static void sifive_u_otp_write(void *opaque, hwaddr addr,
> >              /* write bit data */
> >              SET_FUSEARRAY_BIT(s->fuse, s->pa, s->paio, s->pdin);
> >
> > +            /* write to backend */
> > +            if (s->blk) {
> > +                blk_pwrite(s->blk, s->pa * SIFIVE_U_OTP_FUSE_WORD, &val32,
> > +                           SIFIVE_U_OTP_FUSE_WORD, 0);
> > +            }
> > +
> >              /* update written bit */
> >              SET_FUSEARRAY_BIT(s->fuse_wo, s->pa, s->paio, WRITTEN_BIT_ON);
> >          }
> > @@ -168,16 +186,48 @@ static const MemoryRegionOps sifive_u_otp_ops = {
> >
> >  static Property sifive_u_otp_properties[] = {
> >      DEFINE_PROP_UINT32("serial", SiFiveUOTPState, serial, 0),
> > +    DEFINE_PROP_DRIVE("drive", SiFiveUOTPState, blk),
> >      DEFINE_PROP_END_OF_LIST(),
> >  };
> >
> >  static void sifive_u_otp_realize(DeviceState *dev, Error **errp)
> >  {
> >      SiFiveUOTPState *s = SIFIVE_U_OTP(dev);
> > +    DriveInfo *dinfo;
> >
> >      memory_region_init_io(&s->mmio, OBJECT(dev), &sifive_u_otp_ops, s,
> >                            TYPE_SIFIVE_U_OTP, SIFIVE_U_OTP_REG_SIZE);
> >      sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mmio);
> > +
> > +    dinfo = drive_get_next(IF_NONE);
> > +    if (dinfo) {
> > +        int ret;
> > +        uint64_t perm;
> > +        int filesize;
> > +        BlockBackend *blk;
> > +
> > +        blk = blk_by_legacy_dinfo(dinfo);
>
> I think this should be:
>
> blk = dinfo ? blk_by_legacy_dinfo(dinfo) : NULL;
>

The previous code, "if (dinfo)", should check NULL already. But we can
add more checks for blk such as qdev_prop_set_drive_err().

> > +        filesize = SIFIVE_U_OTP_NUM_FUSES * SIFIVE_U_OTP_FUSE_WORD;
> > +        if (blk_getlength(blk) < filesize) {
> > +            qemu_log_mask(LOG_GUEST_ERROR, "OTP drive size < 16K\n");
>
> You should probably be setting errp instead.
>
> If a user specified a -drive argument, they probably want to error if
> we aren't going to use it.
>

Will set an errp.

> > +            return;
> > +        }
> > +
> > +        qdev_prop_set_drive(dev, "drive", blk);
> > +
> > +        perm = BLK_PERM_CONSISTENT_READ |
> > +                        (blk_is_read_only(s->blk) ? 0 : BLK_PERM_WRITE);
> > +        ret = blk_set_perm(s->blk, perm, BLK_PERM_ALL, errp);
> > +        if (ret < 0) {
> > +            qemu_log_mask(LOG_GUEST_ERROR, "set perm error.");
>
> Is it worth printing the error?
>
Probably add it when I test it. Will remove it.

> > +        }
> > +
> > +        if (blk_pread(s->blk, 0, s->fuse, filesize) != filesize) {
> > +            qemu_log_mask(LOG_GUEST_ERROR,
> > +                          "failed to read the initial flash content");
> > +            return;
>
> You don't need a return here.
>
k, will remove it and set errp.

> Is this error fatal?
>
This shouldn't be fatal but it might lead to unknown state if the
content is read partially.
But the checking, "filesize < 16K", is fatal. It leads qemu to abort.


> Alistair
>
> > +        }
> > +    }
> >  }
> >
> >  static void sifive_u_otp_reset(DeviceState *dev)
> > diff --git a/include/hw/riscv/sifive_u_otp.h b/include/hw/riscv/sifive_u_otp.h
> > index 4a5a0acf48..9bc781fd4f 100644
> > --- a/include/hw/riscv/sifive_u_otp.h
> > +++ b/include/hw/riscv/sifive_u_otp.h
> > @@ -45,6 +45,7 @@
> >
> >  #define SIFIVE_U_OTP_PA_MASK        0xfff
> >  #define SIFIVE_U_OTP_NUM_FUSES      0x1000
> > +#define SIFIVE_U_OTP_FUSE_WORD      4
> >  #define SIFIVE_U_OTP_SERIAL_ADDR    0xfc
> >
> >  #define SIFIVE_U_OTP_REG_SIZE       0x1000
> > @@ -78,6 +79,7 @@ typedef struct SiFiveUOTPState {
> >      uint32_t fuse_wo[SIFIVE_U_OTP_NUM_FUSES];
> >      /* config */
> >      uint32_t serial;
> > +    BlockBackend *blk;
> >  } SiFiveUOTPState;
> >
> >  #endif /* HW_SIFIVE_U_OTP_H */
> > --
> > 2.17.1
> >
> >

