Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6003C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 21:39:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7141920768
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 21:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kWmSsELC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7141920768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6KwA-0004uX-Oa
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 17:39:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54022)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1k6KsJ-0001OW-T9; Thu, 13 Aug 2020 17:35:03 -0400
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144]:40842)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1k6KsG-0005a8-KK; Thu, 13 Aug 2020 17:35:03 -0400
Received: by mail-il1-x144.google.com with SMTP id p18so2983921ilm.7;
 Thu, 13 Aug 2020 14:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=haBWXR/HLGXs3nRRpYu/283Ffq55CLzPSR0ukHqJw1M=;
 b=kWmSsELC1bnQkRQaBO3RX3sbcwmo+iZwC7solz9V7CORJYSqhcuPBAz9F11Iy+p9+f
 61bv7KgYS7phmoaVTmHQ2On7ML1H4q0iHPnv6+jNSbWiT+QTI1NIrkrc0CeixCT6wBtn
 AeNW0thu/5hRD8tbSBKpjXVrJ0Dv0g80e7au6sSEOfIvFJ2IQVWwjU2vGY9Gbqqh++dj
 RRnXEMl1BXc3cKr9Rr8gdvmWwQZXtdbPHRB0XjPR0VbpnvB6jtbXaMbHtYEzG0sQbZds
 H8fqeI1PAmVZN9jPDRnBSQjmc++Soz+7Vv3KVRapPgJLCCR7a1RRpc0JgoGv4ttVmck5
 6qwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=haBWXR/HLGXs3nRRpYu/283Ffq55CLzPSR0ukHqJw1M=;
 b=iSXMiGgpu9QkKhJ6QHwWBT+bYlSk0EpVtQ1QWpZeAe4UP4zTLQkVbIJfvQPdpc/WS/
 EZCziTIVzu2/sER3sGi88aRn4gvZwEirDh8+y0JvNwVgY2rTK4XO9/NwQe4paJawDmVF
 K7/c+Snidx3hAFGtM1Q17yudoVwKWHeiCwlvQDlmcr0kH4b+WznYGufe0aWJQFcb4Afq
 c0WV81R/nlLuiTBRNGyJ8WXlP/7bvYwdRjz6mHZQF33fOMK8v2k6IBf8d9aLdoWEq0WJ
 mvwCXo+/QOSew+IOAtb2pJ0Z5VbOoVOXP3/wzk6Z37fVdyw1d+uPS9OlMv2VyNcbtzQp
 MEvw==
X-Gm-Message-State: AOAM532IPkjTFIsylj41ywuewHqJNhI1erxvKoHMPnlyrGYSTJUW9AR8
 txy17TThobo/FGujuNwhBxZW3/9u0HLZ1MKAgLw=
X-Google-Smtp-Source: ABdhPJyPHBE1pB98dsZLPJPjk00rwUJLX8cCs4Kg3FZk+GFsAaN3cAd9ORkJcToqwxNMG8Vc/InueeRYilHYgKCEInE=
X-Received: by 2002:a05:6e02:ed4:: with SMTP id
 i20mr6483773ilk.267.1597354498735; 
 Thu, 13 Aug 2020 14:34:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200731024708.32725-1-green.wan@sifive.com>
 <20200731024708.32725-2-green.wan@sifive.com>
 <CAKmqyKP=P92SzwnLh-UmBcvt20_PTjMNZpTVKE6w-KyDd0PDMQ@mail.gmail.com>
 <CAJivOr4pqLnh_46KT7YsuENOVkmnn39_NOG8cyUYSsT3H5cVwA@mail.gmail.com>
In-Reply-To: <CAJivOr4pqLnh_46KT7YsuENOVkmnn39_NOG8cyUYSsT3H5cVwA@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 13 Aug 2020 14:24:30 -0700
Message-ID: <CAKmqyKOa6T0BE=AuJcQRfe-WSGMuiCgCis7JweKzarR30Ga0nA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/2] hw/riscv: sifive_u: Add file-backed OTP.
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Bin Meng <bmeng.cn@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 12, 2020 at 9:12 PM Green Wan <green.wan@sifive.com> wrote:
>
> Hi Alistair,
>
> Thanks for the feedback and tips. Not sure whether I get it right. I gave a try with -drive and -device options as below.
>
> $ qemu-system-riscv64 -M sifive_u -drive if=none,format=raw,file=otp.img -device riscv.sifive.u.otp
> qemu-system-riscv64: -device riscv.sifive.u.otp: Parameter 'driver' expects pluggable device type

You don't need the -device, -drive should be enough (and then the OTP
device needs to be re-written to support it).

Alistair

>
> Then I dump "info qtree". The device, "riscv.sifive.u.otp", belongs to 'System' bus. (dump list by 'info qdm') and all devices on 'System' bus seem not available with "-device". Any suggestions for specifying the device?
>
> Thanks,
> - Green
>
> On Tue, Aug 11, 2020 at 6:24 AM Alistair Francis <alistair23@gmail.com> wrote:
>>
>> ,()On Thu, Jul 30, 2020 at 7:49 PM Green Wan <green.wan@sifive.com> wrote:
>> >
>> > Add a file-backed implementation for OTP of sifive_u machine. The
>> > machine property for file-backed is disabled in default. Do file
>> > open, mmap and close for every OTP read/write in case keep the
>> > update-to-date snapshot of OTP.
>>
>> I don't think this is the correct way to write to the file.
>>
>> QEMU has backends that should do this for you. For example QEMU
>> includes the -blockdev/-driver or -mtdblock command line arguments.
>>
>> This implementation should look more like an SD card in terms of
>> interface. You will probably want to call drive_get_next() (probably
>> with IF_MTD, but that's up to you).
>>
>> The hw/arm/xlnx-zcu102.c file has a good example of attaching an SD
>> card by setting the drive property.
>>
>> Alistair
>>
>> >
>> > Signed-off-by: Green Wan <green.wan@sifive.com>
>> > ---
>> >  hw/riscv/sifive_u.c             | 26 +++++++++++
>> >  hw/riscv/sifive_u_otp.c         | 83 +++++++++++++++++++++++++++++++++
>> >  include/hw/riscv/sifive_u.h     |  2 +
>> >  include/hw/riscv/sifive_u_otp.h |  1 +
>> >  4 files changed, 112 insertions(+)
>> >
>> > diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
>> > index e5682c38a9..c818496918 100644
>> > --- a/hw/riscv/sifive_u.c
>> > +++ b/hw/riscv/sifive_u.c
>> > @@ -87,6 +87,7 @@ static const struct MemmapEntry {
>> >  };
>> >
>> >  #define OTP_SERIAL          1
>> > +#define OTP_FILE            "NULL"
>> >  #define GEM_REVISION        0x10070109
>> >
>> >  static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
>> > @@ -387,6 +388,8 @@ static void sifive_u_machine_init(MachineState *machine)
>> >      object_initialize_child(OBJECT(machine), "soc", &s->soc, TYPE_RISCV_U_SOC);
>> >      object_property_set_uint(OBJECT(&s->soc), "serial", s->serial,
>> >                               &error_abort);
>> > +    object_property_set_str(OBJECT(&s->soc), "otp-file", s->otp_file,
>> > +                             &error_abort);
>> >      qdev_realize(DEVICE(&s->soc), NULL, &error_abort);
>> >
>> >      /* register RAM */
>> > @@ -526,6 +529,21 @@ static void sifive_u_machine_set_uint32_prop(Object *obj, Visitor *v,
>> >      visit_type_uint32(v, name, (uint32_t *)opaque, errp);
>> >  }
>> >
>> > +static void sifive_u_machine_get_str_prop(Object *obj, Visitor *v,
>> > +                                             const char *name, void *opaque,
>> > +                                             Error **errp)
>> > +{
>> > +    visit_type_str(v, name, (char **)opaque, errp);
>> > +}
>> > +
>> > +static void sifive_u_machine_set_str_prop(Object *obj, Visitor *v,
>> > +                                             const char *name, void *opaque,
>> > +                                             Error **errp)
>> > +{
>> > +    visit_type_str(v, name, (char **)opaque, errp);
>> > +}
>> > +
>> > +
>> >  static void sifive_u_machine_instance_init(Object *obj)
>> >  {
>> >      SiFiveUState *s = RISCV_U_MACHINE(obj);
>> > @@ -551,6 +569,12 @@ static void sifive_u_machine_instance_init(Object *obj)
>> >                          sifive_u_machine_get_uint32_prop,
>> >                          sifive_u_machine_set_uint32_prop, NULL, &s->serial);
>> >      object_property_set_description(obj, "serial", "Board serial number");
>> > +
>> > +    s->otp_file = (char *)OTP_FILE;
>> > +    object_property_add(obj, "otp-file", "string",
>> > +                        sifive_u_machine_get_str_prop,
>> > +                        sifive_u_machine_set_str_prop, NULL, &s->otp_file);
>> > +    object_property_set_description(obj, "otp-file", "file-backed otp file");
>> >  }
>> >
>> >  static void sifive_u_machine_class_init(ObjectClass *oc, void *data)
>> > @@ -709,6 +733,7 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
>> >      }
>> >
>> >      qdev_prop_set_uint32(DEVICE(&s->otp), "serial", s->serial);
>> > +    qdev_prop_set_string(DEVICE(&s->otp), "otp-file", s->otp_file);
>> >      if (!sysbus_realize(SYS_BUS_DEVICE(&s->otp), errp)) {
>> >          return;
>> >      }
>> > @@ -737,6 +762,7 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
>> >
>> >  static Property sifive_u_soc_props[] = {
>> >      DEFINE_PROP_UINT32("serial", SiFiveUSoCState, serial, OTP_SERIAL),
>> > +    DEFINE_PROP_STRING("otp-file", SiFiveUSoCState, otp_file),
>> >      DEFINE_PROP_END_OF_LIST()
>> >  };
>> >
>> > diff --git a/hw/riscv/sifive_u_otp.c b/hw/riscv/sifive_u_otp.c
>> > index f6ecbaa2ca..e359f30fdb 100644
>> > --- a/hw/riscv/sifive_u_otp.c
>> > +++ b/hw/riscv/sifive_u_otp.c
>> > @@ -24,6 +24,62 @@
>> >  #include "qemu/log.h"
>> >  #include "qemu/module.h"
>> >  #include "hw/riscv/sifive_u_otp.h"
>> > +#include <stdio.h>
>> > +#include <stdlib.h>
>> > +#include <sys/types.h>
>> > +#include <sys/stat.h>
>> > +#include <unistd.h>
>> > +#include <fcntl.h>
>> > +#include <sys/mman.h>
>> > +#include <string.h>
>> > +
>> > +#define TRACE_PREFIX            "FU540_OTP: "
>> > +#define SIFIVE_FU540_OTP_SIZE   (SIFIVE_U_OTP_NUM_FUSES * 4)
>> > +
>> > +static int32_t sifive_u_otp_backed_open(const char *filename, int32_t *fd,
>> > +                                        uint32_t **map)
>> > +{
>> > +    /* open and mmap OTP image file */
>> > +    if (filename && strcmp(filename, "NULL") != 0) {
>> > +        *fd = open(filename, O_RDWR);
>> > +
>> > +        if (*fd < 0) {
>> > +            qemu_log_mask(LOG_TRACE,
>> > +                          TRACE_PREFIX "Warning: can't open otp file<%s>\n",
>> > +                          filename);
>> > +            return -1;
>> > +        } else {
>> > +
>> > +            *map = (unsigned int *)mmap(0,
>> > +                                         SIFIVE_FU540_OTP_SIZE,
>> > +                                         PROT_READ | PROT_WRITE | PROT_EXEC,
>> > +                                         MAP_FILE | MAP_SHARED,
>> > +                                         *fd,
>> > +                                         0);
>> > +
>> > +            if (*map == MAP_FAILED) {
>> > +                qemu_log_mask(LOG_TRACE,
>> > +                              TRACE_PREFIX "Warning: can't mmap otp file<%s>\n",
>> > +                              filename);
>> > +                close(*fd);
>> > +                return -2;
>> > +            }
>> > +        }
>> > +    } else {
>> > +        /* filename is 'NULL' */
>> > +        return -3;
>> > +    }
>> > +
>> > +    return 0;
>> > +}
>> > +
>> > +static int32_t sifive_u_otp_backed_close(int fd, unsigned int *map)
>> > +{
>> > +    munmap(map, SIFIVE_FU540_OTP_SIZE);
>> > +    close(fd);
>> > +
>> > +    return 0;
>> > +}
>> >
>> >  static uint64_t sifive_u_otp_read(void *opaque, hwaddr addr, unsigned int size)
>> >  {
>> > @@ -46,6 +102,20 @@ static uint64_t sifive_u_otp_read(void *opaque, hwaddr addr, unsigned int size)
>> >          if ((s->pce & SIFIVE_U_OTP_PCE_EN) &&
>> >              (s->pdstb & SIFIVE_U_OTP_PDSTB_EN) &&
>> >              (s->ptrim & SIFIVE_U_OTP_PTRIM_EN)) {
>> > +
>> > +            int32_t fd;
>> > +            uint32_t *map;
>> > +            uint64_t val;
>> > +
>> > +            /* open and mmap OTP image file */
>> > +            if (0 == sifive_u_otp_backed_open(s->otp_file, &fd, &map)) {
>> > +                val = (uint64_t)(map[s->pa]);
>> > +
>> > +                /* close and unmmap */
>> > +                sifive_u_otp_backed_close(fd, map);
>> > +                return val;
>> > +            }
>> > +
>> >              return s->fuse[s->pa & SIFIVE_U_OTP_PA_MASK];
>> >          } else {
>> >              return 0xff;
>> > @@ -78,6 +148,8 @@ static void sifive_u_otp_write(void *opaque, hwaddr addr,
>> >  {
>> >      SiFiveUOTPState *s = opaque;
>> >      uint32_t val32 = (uint32_t)val64;
>> > +    int32_t fd;
>> > +    uint32_t *map;
>> >
>> >      switch (addr) {
>> >      case SIFIVE_U_OTP_PA:
>> > @@ -123,6 +195,16 @@ static void sifive_u_otp_write(void *opaque, hwaddr addr,
>> >          s->ptrim = val32;
>> >          break;
>> >      case SIFIVE_U_OTP_PWE:
>> > +        /* open and mmap OTP image file */
>> > +        if (0 == sifive_u_otp_backed_open(s->otp_file, &fd, &map)) {
>> > +            /* store value */
>> > +            map[s->pa] &= ~(s->pdin << s->paio);
>> > +            map[s->pa] |= (s->pdin << s->paio);
>> > +
>> > +            /* close and unmmap */
>> > +            sifive_u_otp_backed_close(fd, map);
>> > +        }
>> > +
>> >          s->pwe = val32;
>> >          break;
>> >      default:
>> > @@ -143,6 +225,7 @@ static const MemoryRegionOps sifive_u_otp_ops = {
>> >
>> >  static Property sifive_u_otp_properties[] = {
>> >      DEFINE_PROP_UINT32("serial", SiFiveUOTPState, serial, 0),
>> > +    DEFINE_PROP_STRING("otp-file", SiFiveUOTPState, otp_file),
>> >      DEFINE_PROP_END_OF_LIST(),
>> >  };
>> >
>> > diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
>> > index aba4d0181f..966723da1d 100644
>> > --- a/include/hw/riscv/sifive_u.h
>> > +++ b/include/hw/riscv/sifive_u.h
>> > @@ -46,6 +46,7 @@ typedef struct SiFiveUSoCState {
>> >      CadenceGEMState gem;
>> >
>> >      uint32_t serial;
>> > +    char *otp_file;
>> >  } SiFiveUSoCState;
>> >
>> >  #define TYPE_RISCV_U_MACHINE MACHINE_TYPE_NAME("sifive_u")
>> > @@ -65,6 +66,7 @@ typedef struct SiFiveUState {
>> >      bool start_in_flash;
>> >      uint32_t msel;
>> >      uint32_t serial;
>> > +    char *otp_file;
>> >  } SiFiveUState;
>> >
>> >  enum {
>> > diff --git a/include/hw/riscv/sifive_u_otp.h b/include/hw/riscv/sifive_u_otp.h
>> > index 639297564a..f3d71ce82d 100644
>> > --- a/include/hw/riscv/sifive_u_otp.h
>> > +++ b/include/hw/riscv/sifive_u_otp.h
>> > @@ -75,6 +75,7 @@ typedef struct SiFiveUOTPState {
>> >      uint32_t fuse[SIFIVE_U_OTP_NUM_FUSES];
>> >      /* config */
>> >      uint32_t serial;
>> > +    char *otp_file;
>> >  } SiFiveUOTPState;
>> >
>> >  #endif /* HW_SIFIVE_U_OTP_H */
>> > --
>> > 2.17.1
>> >
>> >

