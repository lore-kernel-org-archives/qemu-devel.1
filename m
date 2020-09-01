Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52214C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 07:23:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09DB920684
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 07:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="B27VaGb0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09DB920684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD0dh-0005ph-4Q
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 03:23:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57818)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <green.wan@sifive.com>)
 id 1kD0cv-0004O4-1B
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 03:22:45 -0400
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:34135)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <green.wan@sifive.com>)
 id 1kD0cs-0008NX-Ro
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 03:22:44 -0400
Received: by mail-qk1-x741.google.com with SMTP id w186so105157qkd.1
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 00:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Fzl3V/fzSJoJLMxxy5h00MuVHG+2CUth3EhTKYo7jC4=;
 b=B27VaGb0SeupYxUdMeRH4eyn3Cr9MH4ELQYYy8+7IN/v7jjiA80st+HaRyEeeIqnxx
 wC5tAJr/vfIZX0foCQDVPdsnemvC4vDceNI+JQ3UZgYTASi4TgJtc0U0dNAfH2ZLo6Mm
 6kRKnH4xAwYjGagutLNRYiugbZ8PhWyXcWbegw+NpxqNJ3Z0qbmLa2pXLjAAecKwrCA1
 eyFjir3RlbBXCfVzwLH2SUtjoNmQT25+Je2fw03UWr+Z15strD1cH33kKWXcS3APZxaw
 JRklU5iTtbTnZjDWAe2jPiHY/iumEgnClMNMPwM6x8PR89tMPaKKA59hHV/oufAFcTWU
 fNEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Fzl3V/fzSJoJLMxxy5h00MuVHG+2CUth3EhTKYo7jC4=;
 b=lVTNceaNkOpKoLVdRxwAb2sgsjCeAsUz88IOlATrMBei+sfTJ2po3gPBCy02r8MQ4n
 IfccX4aynNaC125TsDgZmno6ddRRYCccGf/u/upNjVwj4G7M2+nE3T83EJZa0jdWu/5t
 9mQjpOkJu5cLuHN1DfqtmXuevDFZ7TEMnXHMCXzWgY60pk9lZotZJaI/EKPIbkMjwecB
 NvNi23V9AxM9pEF2ekOLzxdW/hDaXPWYaL8HjrDoikS9NyEax7l77iKymgKvMcuqPCJ0
 oCd+sQg87Fuiy1q++B45sxlSOScL0XBKCOFi7x+RP3D3IJZuEPJVfELVG64yTeRMyRUp
 A/Ag==
X-Gm-Message-State: AOAM531bhSSTPL2EI/n7I7APOsSMizx17e319HM1dgJ4Hb4w8gucVGdY
 z00wB10PFaY4fSpN+O+z7egEu2/ARLaU1wgQXCNxWw==
X-Google-Smtp-Source: ABdhPJxiMDGTn1eUGPaccpP1jLAmLec+ihmGiexxVFXJCigwP8cviCxd0AoQbr5WXZirHr1b/Zr3MHARsY6LJi4W0aY=
X-Received: by 2002:a05:620a:15ac:: with SMTP id
 f12mr509657qkk.19.1598944961109; 
 Tue, 01 Sep 2020 00:22:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200827074638.21451-1-green.wan@sifive.com>
 <20200827074638.21451-2-green.wan@sifive.com>
 <CAEUhbmUXDiBHzy=CMQAYVzt0NY-JK_KVn-QL-Equw6pRxEiu8w@mail.gmail.com>
In-Reply-To: <CAEUhbmUXDiBHzy=CMQAYVzt0NY-JK_KVn-QL-Equw6pRxEiu8w@mail.gmail.com>
From: Green Wan <green.wan@sifive.com>
Date: Tue, 1 Sep 2020 15:22:30 +0800
Message-ID: <CAJivOr564gqdmTdFe=3REXYYbW29Sg_1VOOpYZMFP8GPyvascw@mail.gmail.com>
Subject: Re: [RFC PATCH v4 1/2] hw/riscv: sifive_u: Add backend drive support
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::741;
 envelope-from=green.wan@sifive.com; helo=mail-qk1-x741.google.com
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
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Bin,

Thanks for the remindings. I didn't notice the write operation and
will add the write functionality based on bit by bit mechanism.

Regards,
Green


On Fri, Aug 28, 2020 at 8:54 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> Hi Green,
>
> On Thu, Aug 27, 2020 at 3:47 PM Green Wan <green.wan@sifive.com> wrote:
> >
> > Add '-drive' support to OTP device. Allow users to assign a raw file
> > as OTP image.
> >
> > Signed-off-by: Green Wan <green.wan@sifive.com>
> > ---
> >  hw/riscv/sifive_u_otp.c         | 50 +++++++++++++++++++++++++++++++++
> >  include/hw/riscv/sifive_u_otp.h |  2 ++
> >  2 files changed, 52 insertions(+)
> >
> > diff --git a/hw/riscv/sifive_u_otp.c b/hw/riscv/sifive_u_otp.c
> > index f6ecbaa2ca..aab2220494 100644
> > --- a/hw/riscv/sifive_u_otp.c
> > +++ b/hw/riscv/sifive_u_otp.c
> > @@ -24,6 +24,8 @@
> >  #include "qemu/log.h"
> >  #include "qemu/module.h"
> >  #include "hw/riscv/sifive_u_otp.h"
> > +#include "sysemu/blockdev.h"
> > +#include "sysemu/block-backend.h"
> >
> >  static uint64_t sifive_u_otp_read(void *opaque, hwaddr addr, unsigned int size)
> >  {
> > @@ -46,6 +48,16 @@ static uint64_t sifive_u_otp_read(void *opaque, hwaddr addr, unsigned int size)
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
> > @@ -123,6 +135,12 @@ static void sifive_u_otp_write(void *opaque, hwaddr addr,
> >          s->ptrim = val32;
> >          break;
> >      case SIFIVE_U_OTP_PWE:
> > +        /* write to backend */
> > +        if (s->blk) {
> > +            blk_pwrite(s->blk, s->pa * SIFIVE_U_OTP_FUSE_WORD, &val32,
>
> The logic looks wrong to me. According to the U-Boot driver
> (sifive-otp.c) the content to be written to the OTP memory comes from
> s->pdin bit by bit. Here val32 represents whether to disable write or
> enable write.
>
> I think we should arrange patches like this:
>
> patch 1 to add OTP write functionality, to the existing s->fuse[] mechanism
> patch 2 to add file based backend write support
>
> > +                       SIFIVE_U_OTP_FUSE_WORD, 0);
> > +        }
> > +
> >          s->pwe = val32;
> >          break;
> >      default:
> > @@ -143,16 +161,48 @@ static const MemoryRegionOps sifive_u_otp_ops = {
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
> > +        filesize = SIFIVE_U_OTP_NUM_FUSES * SIFIVE_U_OTP_FUSE_WORD;
> > +        if (blk_getlength(blk) < filesize) {
> > +            qemu_log_mask(LOG_GUEST_ERROR, "OTP drive size < 16K\n");
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
> > +        }
> > +
> > +        if (blk_pread(s->blk, 0, s->fuse, filesize) != filesize) {
> > +            qemu_log_mask(LOG_GUEST_ERROR,
> > +                          "failed to read the initial flash content");
> > +            return;
> > +        }
> > +    }
> >  }
> >
> >  static void sifive_u_otp_reset(DeviceState *dev)
> > diff --git a/include/hw/riscv/sifive_u_otp.h b/include/hw/riscv/sifive_u_otp.h
> > index 639297564a..13d2552e43 100644
> > --- a/include/hw/riscv/sifive_u_otp.h
> > +++ b/include/hw/riscv/sifive_u_otp.h
> > @@ -43,6 +43,7 @@
> >
> >  #define SIFIVE_U_OTP_PA_MASK        0xfff
> >  #define SIFIVE_U_OTP_NUM_FUSES      0x1000
> > +#define SIFIVE_U_OTP_FUSE_WORD      4
> >  #define SIFIVE_U_OTP_SERIAL_ADDR    0xfc
> >
> >  #define SIFIVE_U_OTP_REG_SIZE       0x1000
> > @@ -75,6 +76,7 @@ typedef struct SiFiveUOTPState {
> >      uint32_t fuse[SIFIVE_U_OTP_NUM_FUSES];
> >      /* config */
> >      uint32_t serial;
> > +    BlockBackend *blk;
> >  } SiFiveUOTPState;
> >
> >  #endif /* HW_SIFIVE_U_OTP_H */
> > --
>
> Regards,
> Bin

