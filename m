Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B77DC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 22:24:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20F9A2073E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 22:24:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dKv4Ju6V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20F9A2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5GDw-0006LW-9i
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 18:24:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51670)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1k5GDM-0005qS-PH; Mon, 10 Aug 2020 18:24:20 -0400
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141]:42674)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1k5GDK-0005lj-FN; Mon, 10 Aug 2020 18:24:20 -0400
Received: by mail-il1-x141.google.com with SMTP id i15so8229028ils.9;
 Mon, 10 Aug 2020 15:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fXwsnB9KmrrNRKEzswdxPfdR+RcPDY96bFi+8GYfWhc=;
 b=dKv4Ju6V4M2SQU59AoGGHFm2bVhEmsCSNv3EHnHhp2nV9VCGOiFXNng09s3L+u6tSm
 s5tMan+VROeCvs1yPtMbZY9xLX8A97tNLW9xQPR/mebpKXtcpfbxBLu9kh7WDsBf5SqI
 OX42uc7if32588ERdlTlr1GxnDiyhXZ/9jfThPbmwwjKQh4ty+EpS3rzrpiOPqHf526K
 GZSPJE0qZ1qmxlA71UDWjqLEYy86UDyql9PdRmo94Y8WCBjkOP+HPhBR6Whkw9l3XKDE
 CdXj/syk9xor722bAQV5V49kjHjEedR9We+2VG4gFGC3K4EXLl5xyGzocZjQda5QPbzb
 bW8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fXwsnB9KmrrNRKEzswdxPfdR+RcPDY96bFi+8GYfWhc=;
 b=Z53xfU8aVMKobr80DfNP9fOTskSEtBghPHA7+t4eBt/fYqDHSZMYcYfyZ1DL56PRZH
 zkehTAzPwERzREzfma+WfwLDJWP9NMta38jKs6z8A1GojmibBoGzfSBQn9XDGT3kZuiP
 eDtyPjpHWDC0REe6Usd3uO6uXwIz3yI35UtJl5G+tjJV/emCKz+bHPzChbeZ+9RLsK6a
 lTj+2llC7ZTvRwp67cr/1VGhmDhx/xBdfEvkn6hcfaetbTrEW4I63c1pL74AVAi+AS2i
 e1FYvgY3RcKZnu2jWw4/jb+z51cugbAY54Bx/j7WYkFUcXzPi4d42WwmhN+duTQ0L+F3
 zK5w==
X-Gm-Message-State: AOAM532qrzmTe4YWG+6DV5namZuPcGdkhnTcRtVpgRqW90o8WDQVBotK
 DfXelQ8WFfPCrhKrTiwwAASTjhjtOOx0+X8KhOc=
X-Google-Smtp-Source: ABdhPJyaZ8jzjIAVIepa6C5h4cR+FWzjO8PhiPhZBBacdOKgN91eympBnFVbP7rOrWwUUAJIcHYLFsrfjJM3jbIOxgk=
X-Received: by 2002:a05:6e02:f07:: with SMTP id
 x7mr20253745ilj.40.1597098256432; 
 Mon, 10 Aug 2020 15:24:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200731024708.32725-1-green.wan@sifive.com>
 <20200731024708.32725-2-green.wan@sifive.com>
In-Reply-To: <20200731024708.32725-2-green.wan@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 10 Aug 2020 15:13:53 -0700
Message-ID: <CAKmqyKP=P92SzwnLh-UmBcvt20_PTjMNZpTVKE6w-KyDd0PDMQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/2] hw/riscv: sifive_u: Add file-backed OTP.
To: Green Wan <green.wan@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::141;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x141.google.com
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

,()On Thu, Jul 30, 2020 at 7:49 PM Green Wan <green.wan@sifive.com> wrote:
>
> Add a file-backed implementation for OTP of sifive_u machine. The
> machine property for file-backed is disabled in default. Do file
> open, mmap and close for every OTP read/write in case keep the
> update-to-date snapshot of OTP.

I don't think this is the correct way to write to the file.

QEMU has backends that should do this for you. For example QEMU
includes the -blockdev/-driver or -mtdblock command line arguments.

This implementation should look more like an SD card in terms of
interface. You will probably want to call drive_get_next() (probably
with IF_MTD, but that's up to you).

The hw/arm/xlnx-zcu102.c file has a good example of attaching an SD
card by setting the drive property.

Alistair

>
> Signed-off-by: Green Wan <green.wan@sifive.com>
> ---
>  hw/riscv/sifive_u.c             | 26 +++++++++++
>  hw/riscv/sifive_u_otp.c         | 83 +++++++++++++++++++++++++++++++++
>  include/hw/riscv/sifive_u.h     |  2 +
>  include/hw/riscv/sifive_u_otp.h |  1 +
>  4 files changed, 112 insertions(+)
>
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index e5682c38a9..c818496918 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -87,6 +87,7 @@ static const struct MemmapEntry {
>  };
>
>  #define OTP_SERIAL          1
> +#define OTP_FILE            "NULL"
>  #define GEM_REVISION        0x10070109
>
>  static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
> @@ -387,6 +388,8 @@ static void sifive_u_machine_init(MachineState *machine)
>      object_initialize_child(OBJECT(machine), "soc", &s->soc, TYPE_RISCV_U_SOC);
>      object_property_set_uint(OBJECT(&s->soc), "serial", s->serial,
>                               &error_abort);
> +    object_property_set_str(OBJECT(&s->soc), "otp-file", s->otp_file,
> +                             &error_abort);
>      qdev_realize(DEVICE(&s->soc), NULL, &error_abort);
>
>      /* register RAM */
> @@ -526,6 +529,21 @@ static void sifive_u_machine_set_uint32_prop(Object *obj, Visitor *v,
>      visit_type_uint32(v, name, (uint32_t *)opaque, errp);
>  }
>
> +static void sifive_u_machine_get_str_prop(Object *obj, Visitor *v,
> +                                             const char *name, void *opaque,
> +                                             Error **errp)
> +{
> +    visit_type_str(v, name, (char **)opaque, errp);
> +}
> +
> +static void sifive_u_machine_set_str_prop(Object *obj, Visitor *v,
> +                                             const char *name, void *opaque,
> +                                             Error **errp)
> +{
> +    visit_type_str(v, name, (char **)opaque, errp);
> +}
> +
> +
>  static void sifive_u_machine_instance_init(Object *obj)
>  {
>      SiFiveUState *s = RISCV_U_MACHINE(obj);
> @@ -551,6 +569,12 @@ static void sifive_u_machine_instance_init(Object *obj)
>                          sifive_u_machine_get_uint32_prop,
>                          sifive_u_machine_set_uint32_prop, NULL, &s->serial);
>      object_property_set_description(obj, "serial", "Board serial number");
> +
> +    s->otp_file = (char *)OTP_FILE;
> +    object_property_add(obj, "otp-file", "string",
> +                        sifive_u_machine_get_str_prop,
> +                        sifive_u_machine_set_str_prop, NULL, &s->otp_file);
> +    object_property_set_description(obj, "otp-file", "file-backed otp file");
>  }
>
>  static void sifive_u_machine_class_init(ObjectClass *oc, void *data)
> @@ -709,6 +733,7 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
>      }
>
>      qdev_prop_set_uint32(DEVICE(&s->otp), "serial", s->serial);
> +    qdev_prop_set_string(DEVICE(&s->otp), "otp-file", s->otp_file);
>      if (!sysbus_realize(SYS_BUS_DEVICE(&s->otp), errp)) {
>          return;
>      }
> @@ -737,6 +762,7 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
>
>  static Property sifive_u_soc_props[] = {
>      DEFINE_PROP_UINT32("serial", SiFiveUSoCState, serial, OTP_SERIAL),
> +    DEFINE_PROP_STRING("otp-file", SiFiveUSoCState, otp_file),
>      DEFINE_PROP_END_OF_LIST()
>  };
>
> diff --git a/hw/riscv/sifive_u_otp.c b/hw/riscv/sifive_u_otp.c
> index f6ecbaa2ca..e359f30fdb 100644
> --- a/hw/riscv/sifive_u_otp.c
> +++ b/hw/riscv/sifive_u_otp.c
> @@ -24,6 +24,62 @@
>  #include "qemu/log.h"
>  #include "qemu/module.h"
>  #include "hw/riscv/sifive_u_otp.h"
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <unistd.h>
> +#include <fcntl.h>
> +#include <sys/mman.h>
> +#include <string.h>
> +
> +#define TRACE_PREFIX            "FU540_OTP: "
> +#define SIFIVE_FU540_OTP_SIZE   (SIFIVE_U_OTP_NUM_FUSES * 4)
> +
> +static int32_t sifive_u_otp_backed_open(const char *filename, int32_t *fd,
> +                                        uint32_t **map)
> +{
> +    /* open and mmap OTP image file */
> +    if (filename && strcmp(filename, "NULL") != 0) {
> +        *fd = open(filename, O_RDWR);
> +
> +        if (*fd < 0) {
> +            qemu_log_mask(LOG_TRACE,
> +                          TRACE_PREFIX "Warning: can't open otp file<%s>\n",
> +                          filename);
> +            return -1;
> +        } else {
> +
> +            *map = (unsigned int *)mmap(0,
> +                                         SIFIVE_FU540_OTP_SIZE,
> +                                         PROT_READ | PROT_WRITE | PROT_EXEC,
> +                                         MAP_FILE | MAP_SHARED,
> +                                         *fd,
> +                                         0);
> +
> +            if (*map == MAP_FAILED) {
> +                qemu_log_mask(LOG_TRACE,
> +                              TRACE_PREFIX "Warning: can't mmap otp file<%s>\n",
> +                              filename);
> +                close(*fd);
> +                return -2;
> +            }
> +        }
> +    } else {
> +        /* filename is 'NULL' */
> +        return -3;
> +    }
> +
> +    return 0;
> +}
> +
> +static int32_t sifive_u_otp_backed_close(int fd, unsigned int *map)
> +{
> +    munmap(map, SIFIVE_FU540_OTP_SIZE);
> +    close(fd);
> +
> +    return 0;
> +}
>
>  static uint64_t sifive_u_otp_read(void *opaque, hwaddr addr, unsigned int size)
>  {
> @@ -46,6 +102,20 @@ static uint64_t sifive_u_otp_read(void *opaque, hwaddr addr, unsigned int size)
>          if ((s->pce & SIFIVE_U_OTP_PCE_EN) &&
>              (s->pdstb & SIFIVE_U_OTP_PDSTB_EN) &&
>              (s->ptrim & SIFIVE_U_OTP_PTRIM_EN)) {
> +
> +            int32_t fd;
> +            uint32_t *map;
> +            uint64_t val;
> +
> +            /* open and mmap OTP image file */
> +            if (0 == sifive_u_otp_backed_open(s->otp_file, &fd, &map)) {
> +                val = (uint64_t)(map[s->pa]);
> +
> +                /* close and unmmap */
> +                sifive_u_otp_backed_close(fd, map);
> +                return val;
> +            }
> +
>              return s->fuse[s->pa & SIFIVE_U_OTP_PA_MASK];
>          } else {
>              return 0xff;
> @@ -78,6 +148,8 @@ static void sifive_u_otp_write(void *opaque, hwaddr addr,
>  {
>      SiFiveUOTPState *s = opaque;
>      uint32_t val32 = (uint32_t)val64;
> +    int32_t fd;
> +    uint32_t *map;
>
>      switch (addr) {
>      case SIFIVE_U_OTP_PA:
> @@ -123,6 +195,16 @@ static void sifive_u_otp_write(void *opaque, hwaddr addr,
>          s->ptrim = val32;
>          break;
>      case SIFIVE_U_OTP_PWE:
> +        /* open and mmap OTP image file */
> +        if (0 == sifive_u_otp_backed_open(s->otp_file, &fd, &map)) {
> +            /* store value */
> +            map[s->pa] &= ~(s->pdin << s->paio);
> +            map[s->pa] |= (s->pdin << s->paio);
> +
> +            /* close and unmmap */
> +            sifive_u_otp_backed_close(fd, map);
> +        }
> +
>          s->pwe = val32;
>          break;
>      default:
> @@ -143,6 +225,7 @@ static const MemoryRegionOps sifive_u_otp_ops = {
>
>  static Property sifive_u_otp_properties[] = {
>      DEFINE_PROP_UINT32("serial", SiFiveUOTPState, serial, 0),
> +    DEFINE_PROP_STRING("otp-file", SiFiveUOTPState, otp_file),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>
> diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
> index aba4d0181f..966723da1d 100644
> --- a/include/hw/riscv/sifive_u.h
> +++ b/include/hw/riscv/sifive_u.h
> @@ -46,6 +46,7 @@ typedef struct SiFiveUSoCState {
>      CadenceGEMState gem;
>
>      uint32_t serial;
> +    char *otp_file;
>  } SiFiveUSoCState;
>
>  #define TYPE_RISCV_U_MACHINE MACHINE_TYPE_NAME("sifive_u")
> @@ -65,6 +66,7 @@ typedef struct SiFiveUState {
>      bool start_in_flash;
>      uint32_t msel;
>      uint32_t serial;
> +    char *otp_file;
>  } SiFiveUState;
>
>  enum {
> diff --git a/include/hw/riscv/sifive_u_otp.h b/include/hw/riscv/sifive_u_otp.h
> index 639297564a..f3d71ce82d 100644
> --- a/include/hw/riscv/sifive_u_otp.h
> +++ b/include/hw/riscv/sifive_u_otp.h
> @@ -75,6 +75,7 @@ typedef struct SiFiveUOTPState {
>      uint32_t fuse[SIFIVE_U_OTP_NUM_FUSES];
>      /* config */
>      uint32_t serial;
> +    char *otp_file;
>  } SiFiveUOTPState;
>
>  #endif /* HW_SIFIVE_U_OTP_H */
> --
> 2.17.1
>
>

