Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69019C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 17:14:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 248DB2067C
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 17:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="JxTMV7vX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 248DB2067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k85Bj-0003x3-ED
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 13:14:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56056)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <green.wan@sifive.com>)
 id 1k85Ae-0002LD-D7
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 13:13:12 -0400
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:37012)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <green.wan@sifive.com>)
 id 1k85AY-0003cu-JW
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 13:13:09 -0400
Received: by mail-qk1-x744.google.com with SMTP id b14so18959277qkn.4
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2020 10:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wc+6uylRK1t4MMgRQeTUnHicEeTnTrg5SGhzCMb6vVU=;
 b=JxTMV7vXdQ9xbuJeJpUqpqE7Oto6DaVcPiVGN+dDcryzG1tUmTtkhv1XxhxmUISsMV
 HwbiycAslE66Ze6AyC6eJmWzcAKmmVc8m189xkHnPlf3Z5RWt/bWmts7DWdPr74LsMb4
 GNzuEE/xsSDZNcDEYUVB3gAQR9sEvFhbfRYGR1G2RK+e2AwfTFEaAtsyQvhRZ23d/tBc
 Ai6prpmV5SbMln/kX2Wgao8byc+fCDmg/+T93i77cAlkW1XGwOOaIVpFpc6pDunb/7w8
 E/USErpW9xqLBpjSrANslAJDkQbc3ZXdK1ptr8QGO5cN1XoF9ebHEQrB7duVhHFq1o60
 3r7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wc+6uylRK1t4MMgRQeTUnHicEeTnTrg5SGhzCMb6vVU=;
 b=PwzMGiq+5Wx/qsBYpVV+OL8/Sb+W/9J1jTeEeDLj3KmS71Akp7UWO43S4m2NcrkkG5
 xLAEkytGwD+GDrrXj5BY4wVTFMjEM6XYHsGSd6PF7rn/n4RiRKT2cSiS0AoNdDFOwjmD
 D1UDffGwxwd2tRFFRmNgu9L1BBfm0yYrZCF2rTZpIvLb0yli/TQ4S2PgDorlxtFcDoqZ
 O4BLpVi01bqvdJBJvSiA3HkOInsyqrqBdhnRibOHltc77yAHWs+HAPPMK1zoEperURI1
 J9O7nMNMc8ALsAa6eD5svYt4QUTtZAB09SgKp7UDunOJ8ueAdwoz838rDFJ4WT4FXRWn
 ScOw==
X-Gm-Message-State: AOAM530IXbeP/v2H9gukoPNAGQBV2OWbIcFaZJKe9aJ7RmtGgNWYDJp2
 8J9ZEAy3PbzPWDbYpgAK8uQkRzk0UTmVjCE+lxUjiw==
X-Google-Smtp-Source: ABdhPJzDIjNhUa67cA6gbLpZPZC8W1qT+Qtulmkmmhjy7TuRA/Vmz3pm+vqDeaJULhJSJKAYRrWXBpzZ2gCwr1noGiM=
X-Received: by 2002:a37:a758:: with SMTP id q85mr17851642qke.325.1597770784798; 
 Tue, 18 Aug 2020 10:13:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200731024708.32725-1-green.wan@sifive.com>
 <20200731024708.32725-2-green.wan@sifive.com>
 <CAKmqyKP=P92SzwnLh-UmBcvt20_PTjMNZpTVKE6w-KyDd0PDMQ@mail.gmail.com>
 <CAJivOr4pqLnh_46KT7YsuENOVkmnn39_NOG8cyUYSsT3H5cVwA@mail.gmail.com>
 <CAKmqyKOa6T0BE=AuJcQRfe-WSGMuiCgCis7JweKzarR30Ga0nA@mail.gmail.com>
In-Reply-To: <CAKmqyKOa6T0BE=AuJcQRfe-WSGMuiCgCis7JweKzarR30Ga0nA@mail.gmail.com>
From: Green Wan <green.wan@sifive.com>
Date: Wed, 19 Aug 2020 01:12:52 +0800
Message-ID: <CAJivOr4Y2FRxdnmH44Y1fqkLwOf6_rMh3yOaebfH=RpKjE7amQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/2] hw/riscv: sifive_u: Add file-backed OTP.
To: Alistair Francis <alistair23@gmail.com>
Content-Type: multipart/alternative; boundary="0000000000000f940005ad2a00c2"
Received-SPF: pass client-ip=2607:f8b0:4864:20::744;
 envelope-from=green.wan@sifive.com; helo=mail-qk1-x744.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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

--0000000000000f940005ad2a00c2
Content-Type: text/plain; charset="UTF-8"

Hi Alistair,

You're right. I can get drive without -device. Now it looks much better.
Sent v3 patch.

Thanks a lot,
- Green

On Fri, Aug 14, 2020 at 5:34 AM Alistair Francis <alistair23@gmail.com>
wrote:

> On Wed, Aug 12, 2020 at 9:12 PM Green Wan <green.wan@sifive.com> wrote:
> >
> > Hi Alistair,
> >
> > Thanks for the feedback and tips. Not sure whether I get it right. I
> gave a try with -drive and -device options as below.
> >
> > $ qemu-system-riscv64 -M sifive_u -drive if=none,format=raw,file=otp.img
> -device riscv.sifive.u.otp
> > qemu-system-riscv64: -device riscv.sifive.u.otp: Parameter 'driver'
> expects pluggable device type
>
> You don't need the -device, -drive should be enough (and then the OTP
> device needs to be re-written to support it).
>
> Alistair
>
> >
> > Then I dump "info qtree". The device, "riscv.sifive.u.otp", belongs to
> 'System' bus. (dump list by 'info qdm') and all devices on 'System' bus
> seem not available with "-device". Any suggestions for specifying the
> device?
> >
> > Thanks,
> > - Green
> >
> > On Tue, Aug 11, 2020 at 6:24 AM Alistair Francis <alistair23@gmail.com>
> wrote:
> >>
> >> ,()On Thu, Jul 30, 2020 at 7:49 PM Green Wan <green.wan@sifive.com>
> wrote:
> >> >
> >> > Add a file-backed implementation for OTP of sifive_u machine. The
> >> > machine property for file-backed is disabled in default. Do file
> >> > open, mmap and close for every OTP read/write in case keep the
> >> > update-to-date snapshot of OTP.
> >>
> >> I don't think this is the correct way to write to the file.
> >>
> >> QEMU has backends that should do this for you. For example QEMU
> >> includes the -blockdev/-driver or -mtdblock command line arguments.
> >>
> >> This implementation should look more like an SD card in terms of
> >> interface. You will probably want to call drive_get_next() (probably
> >> with IF_MTD, but that's up to you).
> >>
> >> The hw/arm/xlnx-zcu102.c file has a good example of attaching an SD
> >> card by setting the drive property.
> >>
> >> Alistair
> >>
> >> >
> >> > Signed-off-by: Green Wan <green.wan@sifive.com>
> >> > ---
> >> >  hw/riscv/sifive_u.c             | 26 +++++++++++
> >> >  hw/riscv/sifive_u_otp.c         | 83
> +++++++++++++++++++++++++++++++++
> >> >  include/hw/riscv/sifive_u.h     |  2 +
> >> >  include/hw/riscv/sifive_u_otp.h |  1 +
> >> >  4 files changed, 112 insertions(+)
> >> >
> >> > diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> >> > index e5682c38a9..c818496918 100644
> >> > --- a/hw/riscv/sifive_u.c
> >> > +++ b/hw/riscv/sifive_u.c
> >> > @@ -87,6 +87,7 @@ static const struct MemmapEntry {
> >> >  };
> >> >
> >> >  #define OTP_SERIAL          1
> >> > +#define OTP_FILE            "NULL"
> >> >  #define GEM_REVISION        0x10070109
> >> >
> >> >  static void create_fdt(SiFiveUState *s, const struct MemmapEntry
> *memmap,
> >> > @@ -387,6 +388,8 @@ static void sifive_u_machine_init(MachineState
> *machine)
> >> >      object_initialize_child(OBJECT(machine), "soc", &s->soc,
> TYPE_RISCV_U_SOC);
> >> >      object_property_set_uint(OBJECT(&s->soc), "serial", s->serial,
> >> >                               &error_abort);
> >> > +    object_property_set_str(OBJECT(&s->soc), "otp-file", s->otp_file,
> >> > +                             &error_abort);
> >> >      qdev_realize(DEVICE(&s->soc), NULL, &error_abort);
> >> >
> >> >      /* register RAM */
> >> > @@ -526,6 +529,21 @@ static void
> sifive_u_machine_set_uint32_prop(Object *obj, Visitor *v,
> >> >      visit_type_uint32(v, name, (uint32_t *)opaque, errp);
> >> >  }
> >> >
> >> > +static void sifive_u_machine_get_str_prop(Object *obj, Visitor *v,
> >> > +                                             const char *name, void
> *opaque,
> >> > +                                             Error **errp)
> >> > +{
> >> > +    visit_type_str(v, name, (char **)opaque, errp);
> >> > +}
> >> > +
> >> > +static void sifive_u_machine_set_str_prop(Object *obj, Visitor *v,
> >> > +                                             const char *name, void
> *opaque,
> >> > +                                             Error **errp)
> >> > +{
> >> > +    visit_type_str(v, name, (char **)opaque, errp);
> >> > +}
> >> > +
> >> > +
> >> >  static void sifive_u_machine_instance_init(Object *obj)
> >> >  {
> >> >      SiFiveUState *s = RISCV_U_MACHINE(obj);
> >> > @@ -551,6 +569,12 @@ static void
> sifive_u_machine_instance_init(Object *obj)
> >> >                          sifive_u_machine_get_uint32_prop,
> >> >                          sifive_u_machine_set_uint32_prop, NULL,
> &s->serial);
> >> >      object_property_set_description(obj, "serial", "Board serial
> number");
> >> > +
> >> > +    s->otp_file = (char *)OTP_FILE;
> >> > +    object_property_add(obj, "otp-file", "string",
> >> > +                        sifive_u_machine_get_str_prop,
> >> > +                        sifive_u_machine_set_str_prop, NULL,
> &s->otp_file);
> >> > +    object_property_set_description(obj, "otp-file", "file-backed
> otp file");
> >> >  }
> >> >
> >> >  static void sifive_u_machine_class_init(ObjectClass *oc, void *data)
> >> > @@ -709,6 +733,7 @@ static void sifive_u_soc_realize(DeviceState
> *dev, Error **errp)
> >> >      }
> >> >
> >> >      qdev_prop_set_uint32(DEVICE(&s->otp), "serial", s->serial);
> >> > +    qdev_prop_set_string(DEVICE(&s->otp), "otp-file", s->otp_file);
> >> >      if (!sysbus_realize(SYS_BUS_DEVICE(&s->otp), errp)) {
> >> >          return;
> >> >      }
> >> > @@ -737,6 +762,7 @@ static void sifive_u_soc_realize(DeviceState
> *dev, Error **errp)
> >> >
> >> >  static Property sifive_u_soc_props[] = {
> >> >      DEFINE_PROP_UINT32("serial", SiFiveUSoCState, serial,
> OTP_SERIAL),
> >> > +    DEFINE_PROP_STRING("otp-file", SiFiveUSoCState, otp_file),
> >> >      DEFINE_PROP_END_OF_LIST()
> >> >  };
> >> >
> >> > diff --git a/hw/riscv/sifive_u_otp.c b/hw/riscv/sifive_u_otp.c
> >> > index f6ecbaa2ca..e359f30fdb 100644
> >> > --- a/hw/riscv/sifive_u_otp.c
> >> > +++ b/hw/riscv/sifive_u_otp.c
> >> > @@ -24,6 +24,62 @@
> >> >  #include "qemu/log.h"
> >> >  #include "qemu/module.h"
> >> >  #include "hw/riscv/sifive_u_otp.h"
> >> > +#include <stdio.h>
> >> > +#include <stdlib.h>
> >> > +#include <sys/types.h>
> >> > +#include <sys/stat.h>
> >> > +#include <unistd.h>
> >> > +#include <fcntl.h>
> >> > +#include <sys/mman.h>
> >> > +#include <string.h>
> >> > +
> >> > +#define TRACE_PREFIX            "FU540_OTP: "
> >> > +#define SIFIVE_FU540_OTP_SIZE   (SIFIVE_U_OTP_NUM_FUSES * 4)
> >> > +
> >> > +static int32_t sifive_u_otp_backed_open(const char *filename,
> int32_t *fd,
> >> > +                                        uint32_t **map)
> >> > +{
> >> > +    /* open and mmap OTP image file */
> >> > +    if (filename && strcmp(filename, "NULL") != 0) {
> >> > +        *fd = open(filename, O_RDWR);
> >> > +
> >> > +        if (*fd < 0) {
> >> > +            qemu_log_mask(LOG_TRACE,
> >> > +                          TRACE_PREFIX "Warning: can't open otp
> file<%s>\n",
> >> > +                          filename);
> >> > +            return -1;
> >> > +        } else {
> >> > +
> >> > +            *map = (unsigned int *)mmap(0,
> >> > +                                         SIFIVE_FU540_OTP_SIZE,
> >> > +                                         PROT_READ | PROT_WRITE |
> PROT_EXEC,
> >> > +                                         MAP_FILE | MAP_SHARED,
> >> > +                                         *fd,
> >> > +                                         0);
> >> > +
> >> > +            if (*map == MAP_FAILED) {
> >> > +                qemu_log_mask(LOG_TRACE,
> >> > +                              TRACE_PREFIX "Warning: can't mmap otp
> file<%s>\n",
> >> > +                              filename);
> >> > +                close(*fd);
> >> > +                return -2;
> >> > +            }
> >> > +        }
> >> > +    } else {
> >> > +        /* filename is 'NULL' */
> >> > +        return -3;
> >> > +    }
> >> > +
> >> > +    return 0;
> >> > +}
> >> > +
> >> > +static int32_t sifive_u_otp_backed_close(int fd, unsigned int *map)
> >> > +{
> >> > +    munmap(map, SIFIVE_FU540_OTP_SIZE);
> >> > +    close(fd);
> >> > +
> >> > +    return 0;
> >> > +}
> >> >
> >> >  static uint64_t sifive_u_otp_read(void *opaque, hwaddr addr,
> unsigned int size)
> >> >  {
> >> > @@ -46,6 +102,20 @@ static uint64_t sifive_u_otp_read(void *opaque,
> hwaddr addr, unsigned int size)
> >> >          if ((s->pce & SIFIVE_U_OTP_PCE_EN) &&
> >> >              (s->pdstb & SIFIVE_U_OTP_PDSTB_EN) &&
> >> >              (s->ptrim & SIFIVE_U_OTP_PTRIM_EN)) {
> >> > +
> >> > +            int32_t fd;
> >> > +            uint32_t *map;
> >> > +            uint64_t val;
> >> > +
> >> > +            /* open and mmap OTP image file */
> >> > +            if (0 == sifive_u_otp_backed_open(s->otp_file, &fd,
> &map)) {
> >> > +                val = (uint64_t)(map[s->pa]);
> >> > +
> >> > +                /* close and unmmap */
> >> > +                sifive_u_otp_backed_close(fd, map);
> >> > +                return val;
> >> > +            }
> >> > +
> >> >              return s->fuse[s->pa & SIFIVE_U_OTP_PA_MASK];
> >> >          } else {
> >> >              return 0xff;
> >> > @@ -78,6 +148,8 @@ static void sifive_u_otp_write(void *opaque,
> hwaddr addr,
> >> >  {
> >> >      SiFiveUOTPState *s = opaque;
> >> >      uint32_t val32 = (uint32_t)val64;
> >> > +    int32_t fd;
> >> > +    uint32_t *map;
> >> >
> >> >      switch (addr) {
> >> >      case SIFIVE_U_OTP_PA:
> >> > @@ -123,6 +195,16 @@ static void sifive_u_otp_write(void *opaque,
> hwaddr addr,
> >> >          s->ptrim = val32;
> >> >          break;
> >> >      case SIFIVE_U_OTP_PWE:
> >> > +        /* open and mmap OTP image file */
> >> > +        if (0 == sifive_u_otp_backed_open(s->otp_file, &fd, &map)) {
> >> > +            /* store value */
> >> > +            map[s->pa] &= ~(s->pdin << s->paio);
> >> > +            map[s->pa] |= (s->pdin << s->paio);
> >> > +
> >> > +            /* close and unmmap */
> >> > +            sifive_u_otp_backed_close(fd, map);
> >> > +        }
> >> > +
> >> >          s->pwe = val32;
> >> >          break;
> >> >      default:
> >> > @@ -143,6 +225,7 @@ static const MemoryRegionOps sifive_u_otp_ops = {
> >> >
> >> >  static Property sifive_u_otp_properties[] = {
> >> >      DEFINE_PROP_UINT32("serial", SiFiveUOTPState, serial, 0),
> >> > +    DEFINE_PROP_STRING("otp-file", SiFiveUOTPState, otp_file),
> >> >      DEFINE_PROP_END_OF_LIST(),
> >> >  };
> >> >
> >> > diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
> >> > index aba4d0181f..966723da1d 100644
> >> > --- a/include/hw/riscv/sifive_u.h
> >> > +++ b/include/hw/riscv/sifive_u.h
> >> > @@ -46,6 +46,7 @@ typedef struct SiFiveUSoCState {
> >> >      CadenceGEMState gem;
> >> >
> >> >      uint32_t serial;
> >> > +    char *otp_file;
> >> >  } SiFiveUSoCState;
> >> >
> >> >  #define TYPE_RISCV_U_MACHINE MACHINE_TYPE_NAME("sifive_u")
> >> > @@ -65,6 +66,7 @@ typedef struct SiFiveUState {
> >> >      bool start_in_flash;
> >> >      uint32_t msel;
> >> >      uint32_t serial;
> >> > +    char *otp_file;
> >> >  } SiFiveUState;
> >> >
> >> >  enum {
> >> > diff --git a/include/hw/riscv/sifive_u_otp.h
> b/include/hw/riscv/sifive_u_otp.h
> >> > index 639297564a..f3d71ce82d 100644
> >> > --- a/include/hw/riscv/sifive_u_otp.h
> >> > +++ b/include/hw/riscv/sifive_u_otp.h
> >> > @@ -75,6 +75,7 @@ typedef struct SiFiveUOTPState {
> >> >      uint32_t fuse[SIFIVE_U_OTP_NUM_FUSES];
> >> >      /* config */
> >> >      uint32_t serial;
> >> > +    char *otp_file;
> >> >  } SiFiveUOTPState;
> >> >
> >> >  #endif /* HW_SIFIVE_U_OTP_H */
> >> > --
> >> > 2.17.1
> >> >
> >> >
>

--0000000000000f940005ad2a00c2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Alistair,<br><br>You&#39;re right. I can get drive with=
out -device. Now it looks much better. Sent v3 patch.<br><br>Thanks a lot,<=
br>- Green</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gm=
ail_attr">On Fri, Aug 14, 2020 at 5:34 AM Alistair Francis &lt;<a href=3D"m=
ailto:alistair23@gmail.com">alistair23@gmail.com</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">On Wed, Aug 12, 2020 at 9:1=
2 PM Green Wan &lt;<a href=3D"mailto:green.wan@sifive.com" target=3D"_blank=
">green.wan@sifive.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Hi Alistair,<br>
&gt;<br>
&gt; Thanks for the feedback and tips. Not sure whether I get it right. I g=
ave a try with -drive and -device options as below.<br>
&gt;<br>
&gt; $ qemu-system-riscv64 -M sifive_u -drive if=3Dnone,format=3Draw,file=
=3Dotp.img -device riscv.sifive.u.otp<br>
&gt; qemu-system-riscv64: -device riscv.sifive.u.otp: Parameter &#39;driver=
&#39; expects pluggable device type<br>
<br>
You don&#39;t need the -device, -drive should be enough (and then the OTP<b=
r>
device needs to be re-written to support it).<br>
<br>
Alistair<br>
<br>
&gt;<br>
&gt; Then I dump &quot;info qtree&quot;. The device, &quot;riscv.sifive.u.o=
tp&quot;, belongs to &#39;System&#39; bus. (dump list by &#39;info qdm&#39;=
) and all devices on &#39;System&#39; bus seem not available with &quot;-de=
vice&quot;. Any suggestions for specifying the device?<br>
&gt;<br>
&gt; Thanks,<br>
&gt; - Green<br>
&gt;<br>
&gt; On Tue, Aug 11, 2020 at 6:24 AM Alistair Francis &lt;<a href=3D"mailto=
:alistair23@gmail.com" target=3D"_blank">alistair23@gmail.com</a>&gt; wrote=
:<br>
&gt;&gt;<br>
&gt;&gt; ,()On Thu, Jul 30, 2020 at 7:49 PM Green Wan &lt;<a href=3D"mailto=
:green.wan@sifive.com" target=3D"_blank">green.wan@sifive.com</a>&gt; wrote=
:<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Add a file-backed implementation for OTP of sifive_u machine.=
 The<br>
&gt;&gt; &gt; machine property for file-backed is disabled in default. Do f=
ile<br>
&gt;&gt; &gt; open, mmap and close for every OTP read/write in case keep th=
e<br>
&gt;&gt; &gt; update-to-date snapshot of OTP.<br>
&gt;&gt;<br>
&gt;&gt; I don&#39;t think this is the correct way to write to the file.<br=
>
&gt;&gt;<br>
&gt;&gt; QEMU has backends that should do this for you. For example QEMU<br=
>
&gt;&gt; includes the -blockdev/-driver or -mtdblock command line arguments=
.<br>
&gt;&gt;<br>
&gt;&gt; This implementation should look more like an SD card in terms of<b=
r>
&gt;&gt; interface. You will probably want to call drive_get_next() (probab=
ly<br>
&gt;&gt; with IF_MTD, but that&#39;s up to you).<br>
&gt;&gt;<br>
&gt;&gt; The hw/arm/xlnx-zcu102.c file has a good example of attaching an S=
D<br>
&gt;&gt; card by setting the drive property.<br>
&gt;&gt;<br>
&gt;&gt; Alistair<br>
&gt;&gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Signed-off-by: Green Wan &lt;<a href=3D"mailto:green.wan@sifi=
ve.com" target=3D"_blank">green.wan@sifive.com</a>&gt;<br>
&gt;&gt; &gt; ---<br>
&gt;&gt; &gt;=C2=A0 hw/riscv/sifive_u.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0| 26 +++++++++++<br>
&gt;&gt; &gt;=C2=A0 hw/riscv/sifive_u_otp.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| 83 +++++++++++++++++++++++++++++++++<br>
&gt;&gt; &gt;=C2=A0 include/hw/riscv/sifive_u.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 =
2 +<br>
&gt;&gt; &gt;=C2=A0 include/hw/riscv/sifive_u_otp.h |=C2=A0 1 +<br>
&gt;&gt; &gt;=C2=A0 4 files changed, 112 insertions(+)<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c<br>
&gt;&gt; &gt; index e5682c38a9..c818496918 100644<br>
&gt;&gt; &gt; --- a/hw/riscv/sifive_u.c<br>
&gt;&gt; &gt; +++ b/hw/riscv/sifive_u.c<br>
&gt;&gt; &gt; @@ -87,6 +87,7 @@ static const struct MemmapEntry {<br>
&gt;&gt; &gt;=C2=A0 };<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 #define OTP_SERIAL=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1<=
br>
&gt;&gt; &gt; +#define OTP_FILE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &q=
uot;NULL&quot;<br>
&gt;&gt; &gt;=C2=A0 #define GEM_REVISION=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x10070=
109<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 static void create_fdt(SiFiveUState *s, const struct Me=
mmapEntry *memmap,<br>
&gt;&gt; &gt; @@ -387,6 +388,8 @@ static void sifive_u_machine_init(Machine=
State *machine)<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 object_initialize_child(OBJECT(machine), =
&quot;soc&quot;, &amp;s-&gt;soc, TYPE_RISCV_U_SOC);<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 object_property_set_uint(OBJECT(&amp;s-&g=
t;soc), &quot;serial&quot;, s-&gt;serial,<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;error_abort);<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 object_property_set_str(OBJECT(&amp;s-&gt;soc)=
, &quot;otp-file&quot;, s-&gt;otp_file,<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;error_abort);<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 qdev_realize(DEVICE(&amp;s-&gt;soc), NULL=
, &amp;error_abort);<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 /* register RAM */<br>
&gt;&gt; &gt; @@ -526,6 +529,21 @@ static void sifive_u_machine_set_uint32_=
prop(Object *obj, Visitor *v,<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 visit_type_uint32(v, name, (uint32_t *)op=
aque, errp);<br>
&gt;&gt; &gt;=C2=A0 }<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; +static void sifive_u_machine_get_str_prop(Object *obj, Visit=
or *v,<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0const char *name, void *opaque,<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0Error **errp)<br>
&gt;&gt; &gt; +{<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 visit_type_str(v, name, (char **)opaque, errp)=
;<br>
&gt;&gt; &gt; +}<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +static void sifive_u_machine_set_str_prop(Object *obj, Visit=
or *v,<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0const char *name, void *opaque,<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0Error **errp)<br>
&gt;&gt; &gt; +{<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 visit_type_str(v, name, (char **)opaque, errp)=
;<br>
&gt;&gt; &gt; +}<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt;=C2=A0 static void sifive_u_machine_instance_init(Object *obj)=
<br>
&gt;&gt; &gt;=C2=A0 {<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 SiFiveUState *s =3D RISCV_U_MACHINE(obj);=
<br>
&gt;&gt; &gt; @@ -551,6 +569,12 @@ static void sifive_u_machine_instance_in=
it(Object *obj)<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sifive_u_machine_get_uint32_prop,<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sifive_u_machine_set_uint32_prop, NULL, &amp;s=
-&gt;serial);<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 object_property_set_description(obj, &quo=
t;serial&quot;, &quot;Board serial number&quot;);<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 s-&gt;otp_file =3D (char *)OTP_FILE;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 object_property_add(obj, &quot;otp-file&quot;,=
 &quot;string&quot;,<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 sifive_u_machine_get_str_prop,<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 sifive_u_machine_set_str_prop, NULL, &amp;s-&gt;ot=
p_file);<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 object_property_set_description(obj, &quot;otp=
-file&quot;, &quot;file-backed otp file&quot;);<br>
&gt;&gt; &gt;=C2=A0 }<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 static void sifive_u_machine_class_init(ObjectClass *oc=
, void *data)<br>
&gt;&gt; &gt; @@ -709,6 +733,7 @@ static void sifive_u_soc_realize(DeviceSt=
ate *dev, Error **errp)<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 qdev_prop_set_uint32(DEVICE(&amp;s-&gt;ot=
p), &quot;serial&quot;, s-&gt;serial);<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 qdev_prop_set_string(DEVICE(&amp;s-&gt;otp), &=
quot;otp-file&quot;, s-&gt;otp_file);<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 if (!sysbus_realize(SYS_BUS_DEVICE(&amp;s=
-&gt;otp), errp)) {<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt; &gt; @@ -737,6 +762,7 @@ static void sifive_u_soc_realize(DeviceSt=
ate *dev, Error **errp)<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 static Property sifive_u_soc_props[] =3D {<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 DEFINE_PROP_UINT32(&quot;serial&quot;, Si=
FiveUSoCState, serial, OTP_SERIAL),<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 DEFINE_PROP_STRING(&quot;otp-file&quot;, SiFiv=
eUSoCState, otp_file),<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 DEFINE_PROP_END_OF_LIST()<br>
&gt;&gt; &gt;=C2=A0 };<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; diff --git a/hw/riscv/sifive_u_otp.c b/hw/riscv/sifive_u_otp.=
c<br>
&gt;&gt; &gt; index f6ecbaa2ca..e359f30fdb 100644<br>
&gt;&gt; &gt; --- a/hw/riscv/sifive_u_otp.c<br>
&gt;&gt; &gt; +++ b/hw/riscv/sifive_u_otp.c<br>
&gt;&gt; &gt; @@ -24,6 +24,62 @@<br>
&gt;&gt; &gt;=C2=A0 #include &quot;qemu/log.h&quot;<br>
&gt;&gt; &gt;=C2=A0 #include &quot;qemu/module.h&quot;<br>
&gt;&gt; &gt;=C2=A0 #include &quot;hw/riscv/sifive_u_otp.h&quot;<br>
&gt;&gt; &gt; +#include &lt;stdio.h&gt;<br>
&gt;&gt; &gt; +#include &lt;stdlib.h&gt;<br>
&gt;&gt; &gt; +#include &lt;sys/types.h&gt;<br>
&gt;&gt; &gt; +#include &lt;sys/stat.h&gt;<br>
&gt;&gt; &gt; +#include &lt;unistd.h&gt;<br>
&gt;&gt; &gt; +#include &lt;fcntl.h&gt;<br>
&gt;&gt; &gt; +#include &lt;sys/mman.h&gt;<br>
&gt;&gt; &gt; +#include &lt;string.h&gt;<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +#define TRACE_PREFIX=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &quot;FU540_OTP: &quot;<br>
&gt;&gt; &gt; +#define SIFIVE_FU540_OTP_SIZE=C2=A0 =C2=A0(SIFIVE_U_OTP_NUM_=
FUSES * 4)<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +static int32_t sifive_u_otp_backed_open(const char *filename=
, int32_t *fd,<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 uint32_t **map)<br>
&gt;&gt; &gt; +{<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 /* open and mmap OTP image file */<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 if (filename &amp;&amp; strcmp(filename, &quot=
;NULL&quot;) !=3D 0) {<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 *fd =3D open(filename, O_RDWR);<=
br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (*fd &lt; 0) {<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_=
TRACE,<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TRACE_PREFIX &quot;Warning: can&#39;t open =
otp file&lt;%s&gt;\n&quot;,<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 filename);<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *map =3D (unsigned=
 int *)mmap(0,<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0SIFIVE_FU540_OTP_SIZE,<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0PROT_READ | PROT_WRITE | PROT_EXEC,<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0MAP_FILE | MAP_SHARED,<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0*fd,<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A00);<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (*map =3D=3D MA=
P_FAILED) {<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu=
_log_mask(LOG_TRACE,<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TRACE_PREFIX &quot;Warning: c=
an&#39;t mmap otp file&lt;%s&gt;\n&quot;,<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 filename);<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 clos=
e(*fd);<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 retu=
rn -2;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 } else {<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* filename is &#39;NULL&#39; */=
<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -3;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 return 0;<br>
&gt;&gt; &gt; +}<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +static int32_t sifive_u_otp_backed_close(int fd, unsigned in=
t *map)<br>
&gt;&gt; &gt; +{<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 munmap(map, SIFIVE_FU540_OTP_SIZE);<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 close(fd);<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 return 0;<br>
&gt;&gt; &gt; +}<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 static uint64_t sifive_u_otp_read(void *opaque, hwaddr =
addr, unsigned int size)<br>
&gt;&gt; &gt;=C2=A0 {<br>
&gt;&gt; &gt; @@ -46,6 +102,20 @@ static uint64_t sifive_u_otp_read(void *o=
paque, hwaddr addr, unsigned int size)<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((s-&gt;pce &amp; SIFIVE=
_U_OTP_PCE_EN) &amp;&amp;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (s-&gt;pdstb =
&amp; SIFIVE_U_OTP_PDSTB_EN) &amp;&amp;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (s-&gt;ptrim =
&amp; SIFIVE_U_OTP_PTRIM_EN)) {<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int32_t fd;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t *map;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t val;<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* open and mmap O=
TP image file */<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (0 =3D=3D sifiv=
e_u_otp_backed_open(s-&gt;otp_file, &amp;fd, &amp;map)) {<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 val =
=3D (uint64_t)(map[s-&gt;pa]);<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* c=
lose and unmmap */<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sifi=
ve_u_otp_backed_close(fd, map);<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 retu=
rn val;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return s-&gt;=
fuse[s-&gt;pa &amp; SIFIVE_U_OTP_PA_MASK];<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0xff;<=
br>
&gt;&gt; &gt; @@ -78,6 +148,8 @@ static void sifive_u_otp_write(void *opaqu=
e, hwaddr addr,<br>
&gt;&gt; &gt;=C2=A0 {<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 SiFiveUOTPState *s =3D opaque;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 uint32_t val32 =3D (uint32_t)val64;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 int32_t fd;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 uint32_t *map;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 switch (addr) {<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 case SIFIVE_U_OTP_PA:<br>
&gt;&gt; &gt; @@ -123,6 +195,16 @@ static void sifive_u_otp_write(void *opa=
que, hwaddr addr,<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;ptrim =3D val32;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 case SIFIVE_U_OTP_PWE:<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* open and mmap OTP image file =
*/<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (0 =3D=3D sifive_u_otp_backed=
_open(s-&gt;otp_file, &amp;fd, &amp;map)) {<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* store value */<=
br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 map[s-&gt;pa] &amp=
;=3D ~(s-&gt;pdin &lt;&lt; s-&gt;paio);<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 map[s-&gt;pa] |=3D=
 (s-&gt;pdin &lt;&lt; s-&gt;paio);<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* close and unmma=
p */<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sifive_u_otp_backe=
d_close(fd, map);<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;pwe =3D val32;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 default:<br>
&gt;&gt; &gt; @@ -143,6 +225,7 @@ static const MemoryRegionOps sifive_u_otp=
_ops =3D {<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 static Property sifive_u_otp_properties[] =3D {<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 DEFINE_PROP_UINT32(&quot;serial&quot;, Si=
FiveUOTPState, serial, 0),<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 DEFINE_PROP_STRING(&quot;otp-file&quot;, SiFiv=
eUOTPState, otp_file),<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 DEFINE_PROP_END_OF_LIST(),<br>
&gt;&gt; &gt;=C2=A0 };<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/s=
ifive_u.h<br>
&gt;&gt; &gt; index aba4d0181f..966723da1d 100644<br>
&gt;&gt; &gt; --- a/include/hw/riscv/sifive_u.h<br>
&gt;&gt; &gt; +++ b/include/hw/riscv/sifive_u.h<br>
&gt;&gt; &gt; @@ -46,6 +46,7 @@ typedef struct SiFiveUSoCState {<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 CadenceGEMState gem;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 uint32_t serial;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 char *otp_file;<br>
&gt;&gt; &gt;=C2=A0 } SiFiveUSoCState;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 #define TYPE_RISCV_U_MACHINE MACHINE_TYPE_NAME(&quot;si=
five_u&quot;)<br>
&gt;&gt; &gt; @@ -65,6 +66,7 @@ typedef struct SiFiveUState {<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 bool start_in_flash;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 uint32_t msel;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 uint32_t serial;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 char *otp_file;<br>
&gt;&gt; &gt;=C2=A0 } SiFiveUState;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 enum {<br>
&gt;&gt; &gt; diff --git a/include/hw/riscv/sifive_u_otp.h b/include/hw/ris=
cv/sifive_u_otp.h<br>
&gt;&gt; &gt; index 639297564a..f3d71ce82d 100644<br>
&gt;&gt; &gt; --- a/include/hw/riscv/sifive_u_otp.h<br>
&gt;&gt; &gt; +++ b/include/hw/riscv/sifive_u_otp.h<br>
&gt;&gt; &gt; @@ -75,6 +75,7 @@ typedef struct SiFiveUOTPState {<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 uint32_t fuse[SIFIVE_U_OTP_NUM_FUSES];<br=
>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 /* config */<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 uint32_t serial;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 char *otp_file;<br>
&gt;&gt; &gt;=C2=A0 } SiFiveUOTPState;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 #endif /* HW_SIFIVE_U_OTP_H */<br>
&gt;&gt; &gt; --<br>
&gt;&gt; &gt; 2.17.1<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
</blockquote></div>

--0000000000000f940005ad2a00c2--

