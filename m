Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B6C4C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 04:13:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 138C32076C
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 04:13:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="j/5uXXK9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 138C32076C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k64c9-0007jd-9R
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 00:13:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37492)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <green.wan@sifive.com>)
 id 1k64bU-0007I7-HK
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 00:12:36 -0400
Received: from mail-qv1-xf42.google.com ([2607:f8b0:4864:20::f42]:43119)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <green.wan@sifive.com>)
 id 1k64bR-00059t-VM
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 00:12:36 -0400
Received: by mail-qv1-xf42.google.com with SMTP id l13so2079502qvt.10
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2020 21:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HaBRVXWcmD6SGOAr8JDM5oBgH64KpvhfAt+vjdFZVA8=;
 b=j/5uXXK9DdaQBFYpJFvfzvkJ7aY3rOYYO4qrcxlHURWvOCdP1ND70MF9HsWx8gcDKi
 ROtvDwFQ6OfdBAKyzzYA1LOsHQ4zsuNGDMV94z2Gpu+QcaI+tJxifvjfJ9MnRy19G5kp
 0I8aNAulEV08OYnypiQjSHgk8VGbuvVBTjSl3OIVk49QIZoWrrXl8UHEwXS0RKqcIcMo
 PP1rw0pBYh3HiilV7gI8P2IN+fRRYJcYJThJ6AnvjbtiBBa+9EYxl3uPBxj9b78hc0eP
 Trv09fw3Pi0paYNv45cC1O+rO5cdLgfhvBmD4lEKGWSgcjfKS5il/UyWzJU9B9M31F4e
 pOQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HaBRVXWcmD6SGOAr8JDM5oBgH64KpvhfAt+vjdFZVA8=;
 b=b5bnTc+uhNwwcp6vNdt/ZzQSomfvzoFmITPYs1CZGu5eDR8U0bSYw6fUZYIdOE0Ruc
 aEv0OHpwzPQN93P6HvBnNkLcO8dXPry4Mh6hMk4CJI7MUqDjiquVj+/iK4HBphCfDDAu
 IHmva+VqgIYT7CL6k4FlPtPz9n8EnG14O3+4dCDyAzINo6CiofLneTTO5bCitO0hdojO
 +/E4+W6rLSn+BN7kaG/BCTXV17oyxIp16+gGN38xVXaIjA/riDOjsDCRnx/vuUMHih+u
 N5QBQyniEY8aTKQ5+eEkcu84iSkMuhNhedVynFPCm35mhCCPhPkdFR0/zGn/uJZ5JtDn
 fL3A==
X-Gm-Message-State: AOAM5320IKX827VYMyKABMGY+bNw2NaLpTJ44Cx+056iHthMLLbpCDqt
 EIy9wTe5s4wYWrs/jBBaqey/7u1Ge5ngPb/0ViGwOA==
X-Google-Smtp-Source: ABdhPJxKnB+Xhq/0L2vfOKdDexK/zjyY2gatqKK19NPayUlht/sJemSHThfDojg1hug+nuD1SmzUryZ+WVEQTGOiyIY=
X-Received: by 2002:a05:6214:b34:: with SMTP id
 w20mr2753878qvj.215.1597291952101; 
 Wed, 12 Aug 2020 21:12:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200731024708.32725-1-green.wan@sifive.com>
 <20200731024708.32725-2-green.wan@sifive.com>
 <CAKmqyKP=P92SzwnLh-UmBcvt20_PTjMNZpTVKE6w-KyDd0PDMQ@mail.gmail.com>
In-Reply-To: <CAKmqyKP=P92SzwnLh-UmBcvt20_PTjMNZpTVKE6w-KyDd0PDMQ@mail.gmail.com>
From: Green Wan <green.wan@sifive.com>
Date: Thu, 13 Aug 2020 12:12:20 +0800
Message-ID: <CAJivOr4pqLnh_46KT7YsuENOVkmnn39_NOG8cyUYSsT3H5cVwA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/2] hw/riscv: sifive_u: Add file-backed OTP.
To: Alistair Francis <alistair23@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000687b7605acba8315"
Received-SPF: pass client-ip=2607:f8b0:4864:20::f42;
 envelope-from=green.wan@sifive.com; helo=mail-qv1-xf42.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

--000000000000687b7605acba8315
Content-Type: text/plain; charset="UTF-8"

Hi Alistair,

Thanks for the feedback and tips. Not sure whether I get it right. I gave a
try with -drive and -device options as below.

$ qemu-system-riscv64 -M sifive_u -drive if=none,format=raw,file=otp.img
-device riscv.sifive.u.otp
qemu-system-riscv64: -device riscv.sifive.u.otp: Parameter 'driver' expects
pluggable device type

Then I dump "info qtree". The device, "riscv.sifive.u.otp", belongs to
'System' bus. (dump list by 'info qdm') and all devices on 'System' bus
seem not available with "-device". Any suggestions for specifying the
device?

Thanks,
- Green

On Tue, Aug 11, 2020 at 6:24 AM Alistair Francis <alistair23@gmail.com>
wrote:

> ,()On Thu, Jul 30, 2020 at 7:49 PM Green Wan <green.wan@sifive.com> wrote:
> >
> > Add a file-backed implementation for OTP of sifive_u machine. The
> > machine property for file-backed is disabled in default. Do file
> > open, mmap and close for every OTP read/write in case keep the
> > update-to-date snapshot of OTP.
>
> I don't think this is the correct way to write to the file.
>
> QEMU has backends that should do this for you. For example QEMU
> includes the -blockdev/-driver or -mtdblock command line arguments.
>
> This implementation should look more like an SD card in terms of
> interface. You will probably want to call drive_get_next() (probably
> with IF_MTD, but that's up to you).
>
> The hw/arm/xlnx-zcu102.c file has a good example of attaching an SD
> card by setting the drive property.
>
> Alistair
>
> >
> > Signed-off-by: Green Wan <green.wan@sifive.com>
> > ---
> >  hw/riscv/sifive_u.c             | 26 +++++++++++
> >  hw/riscv/sifive_u_otp.c         | 83 +++++++++++++++++++++++++++++++++
> >  include/hw/riscv/sifive_u.h     |  2 +
> >  include/hw/riscv/sifive_u_otp.h |  1 +
> >  4 files changed, 112 insertions(+)
> >
> > diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> > index e5682c38a9..c818496918 100644
> > --- a/hw/riscv/sifive_u.c
> > +++ b/hw/riscv/sifive_u.c
> > @@ -87,6 +87,7 @@ static const struct MemmapEntry {
> >  };
> >
> >  #define OTP_SERIAL          1
> > +#define OTP_FILE            "NULL"
> >  #define GEM_REVISION        0x10070109
> >
> >  static void create_fdt(SiFiveUState *s, const struct MemmapEntry
> *memmap,
> > @@ -387,6 +388,8 @@ static void sifive_u_machine_init(MachineState
> *machine)
> >      object_initialize_child(OBJECT(machine), "soc", &s->soc,
> TYPE_RISCV_U_SOC);
> >      object_property_set_uint(OBJECT(&s->soc), "serial", s->serial,
> >                               &error_abort);
> > +    object_property_set_str(OBJECT(&s->soc), "otp-file", s->otp_file,
> > +                             &error_abort);
> >      qdev_realize(DEVICE(&s->soc), NULL, &error_abort);
> >
> >      /* register RAM */
> > @@ -526,6 +529,21 @@ static void sifive_u_machine_set_uint32_prop(Object
> *obj, Visitor *v,
> >      visit_type_uint32(v, name, (uint32_t *)opaque, errp);
> >  }
> >
> > +static void sifive_u_machine_get_str_prop(Object *obj, Visitor *v,
> > +                                             const char *name, void
> *opaque,
> > +                                             Error **errp)
> > +{
> > +    visit_type_str(v, name, (char **)opaque, errp);
> > +}
> > +
> > +static void sifive_u_machine_set_str_prop(Object *obj, Visitor *v,
> > +                                             const char *name, void
> *opaque,
> > +                                             Error **errp)
> > +{
> > +    visit_type_str(v, name, (char **)opaque, errp);
> > +}
> > +
> > +
> >  static void sifive_u_machine_instance_init(Object *obj)
> >  {
> >      SiFiveUState *s = RISCV_U_MACHINE(obj);
> > @@ -551,6 +569,12 @@ static void sifive_u_machine_instance_init(Object
> *obj)
> >                          sifive_u_machine_get_uint32_prop,
> >                          sifive_u_machine_set_uint32_prop, NULL,
> &s->serial);
> >      object_property_set_description(obj, "serial", "Board serial
> number");
> > +
> > +    s->otp_file = (char *)OTP_FILE;
> > +    object_property_add(obj, "otp-file", "string",
> > +                        sifive_u_machine_get_str_prop,
> > +                        sifive_u_machine_set_str_prop, NULL,
> &s->otp_file);
> > +    object_property_set_description(obj, "otp-file", "file-backed otp
> file");
> >  }
> >
> >  static void sifive_u_machine_class_init(ObjectClass *oc, void *data)
> > @@ -709,6 +733,7 @@ static void sifive_u_soc_realize(DeviceState *dev,
> Error **errp)
> >      }
> >
> >      qdev_prop_set_uint32(DEVICE(&s->otp), "serial", s->serial);
> > +    qdev_prop_set_string(DEVICE(&s->otp), "otp-file", s->otp_file);
> >      if (!sysbus_realize(SYS_BUS_DEVICE(&s->otp), errp)) {
> >          return;
> >      }
> > @@ -737,6 +762,7 @@ static void sifive_u_soc_realize(DeviceState *dev,
> Error **errp)
> >
> >  static Property sifive_u_soc_props[] = {
> >      DEFINE_PROP_UINT32("serial", SiFiveUSoCState, serial, OTP_SERIAL),
> > +    DEFINE_PROP_STRING("otp-file", SiFiveUSoCState, otp_file),
> >      DEFINE_PROP_END_OF_LIST()
> >  };
> >
> > diff --git a/hw/riscv/sifive_u_otp.c b/hw/riscv/sifive_u_otp.c
> > index f6ecbaa2ca..e359f30fdb 100644
> > --- a/hw/riscv/sifive_u_otp.c
> > +++ b/hw/riscv/sifive_u_otp.c
> > @@ -24,6 +24,62 @@
> >  #include "qemu/log.h"
> >  #include "qemu/module.h"
> >  #include "hw/riscv/sifive_u_otp.h"
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <sys/types.h>
> > +#include <sys/stat.h>
> > +#include <unistd.h>
> > +#include <fcntl.h>
> > +#include <sys/mman.h>
> > +#include <string.h>
> > +
> > +#define TRACE_PREFIX            "FU540_OTP: "
> > +#define SIFIVE_FU540_OTP_SIZE   (SIFIVE_U_OTP_NUM_FUSES * 4)
> > +
> > +static int32_t sifive_u_otp_backed_open(const char *filename, int32_t
> *fd,
> > +                                        uint32_t **map)
> > +{
> > +    /* open and mmap OTP image file */
> > +    if (filename && strcmp(filename, "NULL") != 0) {
> > +        *fd = open(filename, O_RDWR);
> > +
> > +        if (*fd < 0) {
> > +            qemu_log_mask(LOG_TRACE,
> > +                          TRACE_PREFIX "Warning: can't open otp
> file<%s>\n",
> > +                          filename);
> > +            return -1;
> > +        } else {
> > +
> > +            *map = (unsigned int *)mmap(0,
> > +                                         SIFIVE_FU540_OTP_SIZE,
> > +                                         PROT_READ | PROT_WRITE |
> PROT_EXEC,
> > +                                         MAP_FILE | MAP_SHARED,
> > +                                         *fd,
> > +                                         0);
> > +
> > +            if (*map == MAP_FAILED) {
> > +                qemu_log_mask(LOG_TRACE,
> > +                              TRACE_PREFIX "Warning: can't mmap otp
> file<%s>\n",
> > +                              filename);
> > +                close(*fd);
> > +                return -2;
> > +            }
> > +        }
> > +    } else {
> > +        /* filename is 'NULL' */
> > +        return -3;
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> > +static int32_t sifive_u_otp_backed_close(int fd, unsigned int *map)
> > +{
> > +    munmap(map, SIFIVE_FU540_OTP_SIZE);
> > +    close(fd);
> > +
> > +    return 0;
> > +}
> >
> >  static uint64_t sifive_u_otp_read(void *opaque, hwaddr addr, unsigned
> int size)
> >  {
> > @@ -46,6 +102,20 @@ static uint64_t sifive_u_otp_read(void *opaque,
> hwaddr addr, unsigned int size)
> >          if ((s->pce & SIFIVE_U_OTP_PCE_EN) &&
> >              (s->pdstb & SIFIVE_U_OTP_PDSTB_EN) &&
> >              (s->ptrim & SIFIVE_U_OTP_PTRIM_EN)) {
> > +
> > +            int32_t fd;
> > +            uint32_t *map;
> > +            uint64_t val;
> > +
> > +            /* open and mmap OTP image file */
> > +            if (0 == sifive_u_otp_backed_open(s->otp_file, &fd, &map)) {
> > +                val = (uint64_t)(map[s->pa]);
> > +
> > +                /* close and unmmap */
> > +                sifive_u_otp_backed_close(fd, map);
> > +                return val;
> > +            }
> > +
> >              return s->fuse[s->pa & SIFIVE_U_OTP_PA_MASK];
> >          } else {
> >              return 0xff;
> > @@ -78,6 +148,8 @@ static void sifive_u_otp_write(void *opaque, hwaddr
> addr,
> >  {
> >      SiFiveUOTPState *s = opaque;
> >      uint32_t val32 = (uint32_t)val64;
> > +    int32_t fd;
> > +    uint32_t *map;
> >
> >      switch (addr) {
> >      case SIFIVE_U_OTP_PA:
> > @@ -123,6 +195,16 @@ static void sifive_u_otp_write(void *opaque, hwaddr
> addr,
> >          s->ptrim = val32;
> >          break;
> >      case SIFIVE_U_OTP_PWE:
> > +        /* open and mmap OTP image file */
> > +        if (0 == sifive_u_otp_backed_open(s->otp_file, &fd, &map)) {
> > +            /* store value */
> > +            map[s->pa] &= ~(s->pdin << s->paio);
> > +            map[s->pa] |= (s->pdin << s->paio);
> > +
> > +            /* close and unmmap */
> > +            sifive_u_otp_backed_close(fd, map);
> > +        }
> > +
> >          s->pwe = val32;
> >          break;
> >      default:
> > @@ -143,6 +225,7 @@ static const MemoryRegionOps sifive_u_otp_ops = {
> >
> >  static Property sifive_u_otp_properties[] = {
> >      DEFINE_PROP_UINT32("serial", SiFiveUOTPState, serial, 0),
> > +    DEFINE_PROP_STRING("otp-file", SiFiveUOTPState, otp_file),
> >      DEFINE_PROP_END_OF_LIST(),
> >  };
> >
> > diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
> > index aba4d0181f..966723da1d 100644
> > --- a/include/hw/riscv/sifive_u.h
> > +++ b/include/hw/riscv/sifive_u.h
> > @@ -46,6 +46,7 @@ typedef struct SiFiveUSoCState {
> >      CadenceGEMState gem;
> >
> >      uint32_t serial;
> > +    char *otp_file;
> >  } SiFiveUSoCState;
> >
> >  #define TYPE_RISCV_U_MACHINE MACHINE_TYPE_NAME("sifive_u")
> > @@ -65,6 +66,7 @@ typedef struct SiFiveUState {
> >      bool start_in_flash;
> >      uint32_t msel;
> >      uint32_t serial;
> > +    char *otp_file;
> >  } SiFiveUState;
> >
> >  enum {
> > diff --git a/include/hw/riscv/sifive_u_otp.h
> b/include/hw/riscv/sifive_u_otp.h
> > index 639297564a..f3d71ce82d 100644
> > --- a/include/hw/riscv/sifive_u_otp.h
> > +++ b/include/hw/riscv/sifive_u_otp.h
> > @@ -75,6 +75,7 @@ typedef struct SiFiveUOTPState {
> >      uint32_t fuse[SIFIVE_U_OTP_NUM_FUSES];
> >      /* config */
> >      uint32_t serial;
> > +    char *otp_file;
> >  } SiFiveUOTPState;
> >
> >  #endif /* HW_SIFIVE_U_OTP_H */
> > --
> > 2.17.1
> >
> >
>

--000000000000687b7605acba8315
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Alistair,<br><br>Thanks for the feedback and tips. Not =
sure whether I get it right. I gave a try with -drive and -device options a=
s below.<br><br>$ qemu-system-riscv64 -M sifive_u -drive if=3Dnone,format=
=3Draw,file=3Dotp.img -device riscv.sifive.u.otp<br>qemu-system-riscv64: -d=
evice riscv.sifive.u.otp: Parameter &#39;driver&#39; expects pluggable devi=
ce type<br><br>Then I dump &quot;info qtree&quot;. The device, &quot;riscv.=
sifive.u.otp&quot;, belongs to &#39;System&#39; bus. (dump list by &#39;inf=
o qdm&#39;) and all devices on &#39;System&#39;=C2=A0bus seem not available=
 with &quot;-device&quot;. Any suggestions for specifying the device?<br><b=
r>Thanks,<br>- Green</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" c=
lass=3D"gmail_attr">On Tue, Aug 11, 2020 at 6:24 AM Alistair Francis &lt;<a=
 href=3D"mailto:alistair23@gmail.com">alistair23@gmail.com</a>&gt; wrote:<b=
r></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">,()On Thu, Jul 30=
, 2020 at 7:49 PM Green Wan &lt;<a href=3D"mailto:green.wan@sifive.com" tar=
get=3D"_blank">green.wan@sifive.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Add a file-backed implementation for OTP of sifive_u machine. The<br>
&gt; machine property for file-backed is disabled in default. Do file<br>
&gt; open, mmap and close for every OTP read/write in case keep the<br>
&gt; update-to-date snapshot of OTP.<br>
<br>
I don&#39;t think this is the correct way to write to the file.<br>
<br>
QEMU has backends that should do this for you. For example QEMU<br>
includes the -blockdev/-driver or -mtdblock command line arguments.<br>
<br>
This implementation should look more like an SD card in terms of<br>
interface. You will probably want to call drive_get_next() (probably<br>
with IF_MTD, but that&#39;s up to you).<br>
<br>
The hw/arm/xlnx-zcu102.c file has a good example of attaching an SD<br>
card by setting the drive property.<br>
<br>
Alistair<br>
<br>
&gt;<br>
&gt; Signed-off-by: Green Wan &lt;<a href=3D"mailto:green.wan@sifive.com" t=
arget=3D"_blank">green.wan@sifive.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 hw/riscv/sifive_u.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| 26 +++++++++++<br>
&gt;=C2=A0 hw/riscv/sifive_u_otp.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 83 ++=
+++++++++++++++++++++++++++++++<br>
&gt;=C2=A0 include/hw/riscv/sifive_u.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 2 +<br>
&gt;=C2=A0 include/hw/riscv/sifive_u_otp.h |=C2=A0 1 +<br>
&gt;=C2=A0 4 files changed, 112 insertions(+)<br>
&gt;<br>
&gt; diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c<br>
&gt; index e5682c38a9..c818496918 100644<br>
&gt; --- a/hw/riscv/sifive_u.c<br>
&gt; +++ b/hw/riscv/sifive_u.c<br>
&gt; @@ -87,6 +87,7 @@ static const struct MemmapEntry {<br>
&gt;=C2=A0 };<br>
&gt;<br>
&gt;=C2=A0 #define OTP_SERIAL=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1<br>
&gt; +#define OTP_FILE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;NULL&=
quot;<br>
&gt;=C2=A0 #define GEM_REVISION=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x10070109<br>
&gt;<br>
&gt;=C2=A0 static void create_fdt(SiFiveUState *s, const struct MemmapEntry=
 *memmap,<br>
&gt; @@ -387,6 +388,8 @@ static void sifive_u_machine_init(MachineState *ma=
chine)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 object_initialize_child(OBJECT(machine), &quot;soc=
&quot;, &amp;s-&gt;soc, TYPE_RISCV_U_SOC);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 object_property_set_uint(OBJECT(&amp;s-&gt;soc), &=
quot;serial&quot;, s-&gt;serial,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;error_abort);<br>
&gt; +=C2=A0 =C2=A0 object_property_set_str(OBJECT(&amp;s-&gt;soc), &quot;o=
tp-file&quot;, s-&gt;otp_file,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;error_abort);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 qdev_realize(DEVICE(&amp;s-&gt;soc), NULL, &amp;er=
ror_abort);<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 /* register RAM */<br>
&gt; @@ -526,6 +529,21 @@ static void sifive_u_machine_set_uint32_prop(Obje=
ct *obj, Visitor *v,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 visit_type_uint32(v, name, (uint32_t *)opaque, err=
p);<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt; +static void sifive_u_machine_get_str_prop(Object *obj, Visitor *v,<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0const char *name, void *opaque,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0Error **errp)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 visit_type_str(v, name, (char **)opaque, errp);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void sifive_u_machine_set_str_prop(Object *obj, Visitor *v,<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0const char *name, void *opaque,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0Error **errp)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 visit_type_str(v, name, (char **)opaque, errp);<br>
&gt; +}<br>
&gt; +<br>
&gt; +<br>
&gt;=C2=A0 static void sifive_u_machine_instance_init(Object *obj)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 SiFiveUState *s =3D RISCV_U_MACHINE(obj);<br>
&gt; @@ -551,6 +569,12 @@ static void sifive_u_machine_instance_init(Object=
 *obj)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 sifive_u_machine_get_uint32_prop,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 sifive_u_machine_set_uint32_prop, NULL, &amp;s-&gt;ser=
ial);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 object_property_set_description(obj, &quot;serial&=
quot;, &quot;Board serial number&quot;);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 s-&gt;otp_file =3D (char *)OTP_FILE;<br>
&gt; +=C2=A0 =C2=A0 object_property_add(obj, &quot;otp-file&quot;, &quot;st=
ring&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 sifive_u_machine_get_str_prop,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 sifive_u_machine_set_str_prop, NULL, &amp;s-&gt;otp_file);<b=
r>
&gt; +=C2=A0 =C2=A0 object_property_set_description(obj, &quot;otp-file&quo=
t;, &quot;file-backed otp file&quot;);<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 static void sifive_u_machine_class_init(ObjectClass *oc, void *d=
ata)<br>
&gt; @@ -709,6 +733,7 @@ static void sifive_u_soc_realize(DeviceState *dev,=
 Error **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 qdev_prop_set_uint32(DEVICE(&amp;s-&gt;otp), &quot=
;serial&quot;, s-&gt;serial);<br>
&gt; +=C2=A0 =C2=A0 qdev_prop_set_string(DEVICE(&amp;s-&gt;otp), &quot;otp-=
file&quot;, s-&gt;otp_file);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (!sysbus_realize(SYS_BUS_DEVICE(&amp;s-&gt;otp)=
, errp)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; @@ -737,6 +762,7 @@ static void sifive_u_soc_realize(DeviceState *dev,=
 Error **errp)<br>
&gt;<br>
&gt;=C2=A0 static Property sifive_u_soc_props[] =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 DEFINE_PROP_UINT32(&quot;serial&quot;, SiFiveUSoCS=
tate, serial, OTP_SERIAL),<br>
&gt; +=C2=A0 =C2=A0 DEFINE_PROP_STRING(&quot;otp-file&quot;, SiFiveUSoCStat=
e, otp_file),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 DEFINE_PROP_END_OF_LIST()<br>
&gt;=C2=A0 };<br>
&gt;<br>
&gt; diff --git a/hw/riscv/sifive_u_otp.c b/hw/riscv/sifive_u_otp.c<br>
&gt; index f6ecbaa2ca..e359f30fdb 100644<br>
&gt; --- a/hw/riscv/sifive_u_otp.c<br>
&gt; +++ b/hw/riscv/sifive_u_otp.c<br>
&gt; @@ -24,6 +24,62 @@<br>
&gt;=C2=A0 #include &quot;qemu/log.h&quot;<br>
&gt;=C2=A0 #include &quot;qemu/module.h&quot;<br>
&gt;=C2=A0 #include &quot;hw/riscv/sifive_u_otp.h&quot;<br>
&gt; +#include &lt;stdio.h&gt;<br>
&gt; +#include &lt;stdlib.h&gt;<br>
&gt; +#include &lt;sys/types.h&gt;<br>
&gt; +#include &lt;sys/stat.h&gt;<br>
&gt; +#include &lt;unistd.h&gt;<br>
&gt; +#include &lt;fcntl.h&gt;<br>
&gt; +#include &lt;sys/mman.h&gt;<br>
&gt; +#include &lt;string.h&gt;<br>
&gt; +<br>
&gt; +#define TRACE_PREFIX=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;F=
U540_OTP: &quot;<br>
&gt; +#define SIFIVE_FU540_OTP_SIZE=C2=A0 =C2=A0(SIFIVE_U_OTP_NUM_FUSES * 4=
)<br>
&gt; +<br>
&gt; +static int32_t sifive_u_otp_backed_open(const char *filename, int32_t=
 *fd,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint=
32_t **map)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 /* open and mmap OTP image file */<br>
&gt; +=C2=A0 =C2=A0 if (filename &amp;&amp; strcmp(filename, &quot;NULL&quo=
t;) !=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 *fd =3D open(filename, O_RDWR);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (*fd &lt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_TRACE,<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 TRACE_PREFIX &quot;Warning: can&#39;t open otp file&l=
t;%s&gt;\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 filename);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *map =3D (unsigned int *)mm=
ap(0,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0SIFIVE_FU540_OTP_SIZE,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0PROT_READ | PROT_WRITE | PROT_EXEC,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0MAP_FILE | MAP_SHARED,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0*fd,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A00);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (*map =3D=3D MAP_FAILED)=
 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask=
(LOG_TRACE,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TRACE_PREFIX &quot;Warning: can&#39;t m=
map otp file&lt;%s&gt;\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 filename);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 close(*fd);<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -2;<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* filename is &#39;NULL&#39; */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -3;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int32_t sifive_u_otp_backed_close(int fd, unsigned int *map)<b=
r>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 munmap(map, SIFIVE_FU540_OTP_SIZE);<br>
&gt; +=C2=A0 =C2=A0 close(fd);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return 0;<br>
&gt; +}<br>
&gt;<br>
&gt;=C2=A0 static uint64_t sifive_u_otp_read(void *opaque, hwaddr addr, uns=
igned int size)<br>
&gt;=C2=A0 {<br>
&gt; @@ -46,6 +102,20 @@ static uint64_t sifive_u_otp_read(void *opaque, hw=
addr addr, unsigned int size)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((s-&gt;pce &amp; SIFIVE_U_OTP_PC=
E_EN) &amp;&amp;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (s-&gt;pdstb &amp; SIF=
IVE_U_OTP_PDSTB_EN) &amp;&amp;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (s-&gt;ptrim &amp; SIF=
IVE_U_OTP_PTRIM_EN)) {<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int32_t fd;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t *map;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t val;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* open and mmap OTP image =
file */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (0 =3D=3D sifive_u_otp_b=
acked_open(s-&gt;otp_file, &amp;fd, &amp;map)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D (uint=
64_t)(map[s-&gt;pa]);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* close and =
unmmap */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sifive_u_otp_=
backed_close(fd, map);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return val;<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return s-&gt;fuse[s-&g=
t;pa &amp; SIFIVE_U_OTP_PA_MASK];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0xff;<br>
&gt; @@ -78,6 +148,8 @@ static void sifive_u_otp_write(void *opaque, hwaddr=
 addr,<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 SiFiveUOTPState *s =3D opaque;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 uint32_t val32 =3D (uint32_t)val64;<br>
&gt; +=C2=A0 =C2=A0 int32_t fd;<br>
&gt; +=C2=A0 =C2=A0 uint32_t *map;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 switch (addr) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 case SIFIVE_U_OTP_PA:<br>
&gt; @@ -123,6 +195,16 @@ static void sifive_u_otp_write(void *opaque, hwad=
dr addr,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;ptrim =3D val32;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 case SIFIVE_U_OTP_PWE:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* open and mmap OTP image file */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (0 =3D=3D sifive_u_otp_backed_open(s-&=
gt;otp_file, &amp;fd, &amp;map)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* store value */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 map[s-&gt;pa] &amp;=3D ~(s-=
&gt;pdin &lt;&lt; s-&gt;paio);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 map[s-&gt;pa] |=3D (s-&gt;p=
din &lt;&lt; s-&gt;paio);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* close and unmmap */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sifive_u_otp_backed_close(f=
d, map);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;pwe =3D val32;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 default:<br>
&gt; @@ -143,6 +225,7 @@ static const MemoryRegionOps sifive_u_otp_ops =3D =
{<br>
&gt;<br>
&gt;=C2=A0 static Property sifive_u_otp_properties[] =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 DEFINE_PROP_UINT32(&quot;serial&quot;, SiFiveUOTPS=
tate, serial, 0),<br>
&gt; +=C2=A0 =C2=A0 DEFINE_PROP_STRING(&quot;otp-file&quot;, SiFiveUOTPStat=
e, otp_file),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 DEFINE_PROP_END_OF_LIST(),<br>
&gt;=C2=A0 };<br>
&gt;<br>
&gt; diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h=
<br>
&gt; index aba4d0181f..966723da1d 100644<br>
&gt; --- a/include/hw/riscv/sifive_u.h<br>
&gt; +++ b/include/hw/riscv/sifive_u.h<br>
&gt; @@ -46,6 +46,7 @@ typedef struct SiFiveUSoCState {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 CadenceGEMState gem;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 uint32_t serial;<br>
&gt; +=C2=A0 =C2=A0 char *otp_file;<br>
&gt;=C2=A0 } SiFiveUSoCState;<br>
&gt;<br>
&gt;=C2=A0 #define TYPE_RISCV_U_MACHINE MACHINE_TYPE_NAME(&quot;sifive_u&qu=
ot;)<br>
&gt; @@ -65,6 +66,7 @@ typedef struct SiFiveUState {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 bool start_in_flash;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 uint32_t msel;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 uint32_t serial;<br>
&gt; +=C2=A0 =C2=A0 char *otp_file;<br>
&gt;=C2=A0 } SiFiveUState;<br>
&gt;<br>
&gt;=C2=A0 enum {<br>
&gt; diff --git a/include/hw/riscv/sifive_u_otp.h b/include/hw/riscv/sifive=
_u_otp.h<br>
&gt; index 639297564a..f3d71ce82d 100644<br>
&gt; --- a/include/hw/riscv/sifive_u_otp.h<br>
&gt; +++ b/include/hw/riscv/sifive_u_otp.h<br>
&gt; @@ -75,6 +75,7 @@ typedef struct SiFiveUOTPState {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 uint32_t fuse[SIFIVE_U_OTP_NUM_FUSES];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 /* config */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 uint32_t serial;<br>
&gt; +=C2=A0 =C2=A0 char *otp_file;<br>
&gt;=C2=A0 } SiFiveUOTPState;<br>
&gt;<br>
&gt;=C2=A0 #endif /* HW_SIFIVE_U_OTP_H */<br>
&gt; --<br>
&gt; 2.17.1<br>
&gt;<br>
&gt;<br>
</blockquote></div>

--000000000000687b7605acba8315--

