Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 753E0C433E4
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 14:21:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F7F720578
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 14:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VmUZD28Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F7F720578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyyaB-0007tf-BL
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 10:21:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44738)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jyyYe-0005tK-Dv; Fri, 24 Jul 2020 10:20:20 -0400
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42]:39449)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jyyYc-0002rE-Cc; Fri, 24 Jul 2020 10:20:20 -0400
Received: by mail-yb1-xb42.google.com with SMTP id q16so2573147ybk.6;
 Fri, 24 Jul 2020 07:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YqcN2NQc7gaCr2V/22gdwYFCkw+AamcVfvmyHrRMS+E=;
 b=VmUZD28ZdwOlo+BJ2ob2V/9tFBiyL5C25+mjrrUszgQuYATx5UZlu1Bf56ubAO0ah9
 jY/R3oFqAFlysYZeP6Jk+igazn6qTC/ZsJ1JNDVFj84dOx/yBWIC3lm3waum4gXNrFVV
 oCoNdMH+ltWI1bFd+VBKFV9SvPx7EcnJ9Hprv34YVeBBzvpvbBHqZJTyIdMjCs7x07IM
 qWpEA2nf1m8go3ntK1gZZKGyBdo1wnvasgmnt75JWXxpW/RgtdYHmrvCKur8znVpbfjh
 xoi475qA76Q0J/zcuOXsG2H4swN85+/RlelYHaT6bXNR7R3UWpPe2VBz0TxIsJWK6z7o
 YzPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YqcN2NQc7gaCr2V/22gdwYFCkw+AamcVfvmyHrRMS+E=;
 b=fWU6fhZLr7EoIJtp4VcVbxWzhI5C3uyXZrayLzfn61osqVoSHG4zxAVRSbdDUrvWFx
 6ni6JO6SEhDnkf8e9u9Vb61o6FUBn19Ly6EpWVnVOAMVS8ad/gd8vbGC4X1y9o21Hqkl
 nx0LKEtawYowGU7fd/kLTTp+Vv+pXX34pokQ6ryC5yh+bfH/I3tPdRWVbs6hVZCPNR9I
 7MffqxHd7ZkGcK7OYObBCLvbI9YI0+FzM94AVjpeMDTKI+Q1fPQmKgXI/e3mS2U61H6d
 3sL1wM6g1WMpwShzl267Kmry4C2z4vz7J3d6ADW/FLcBh3Gfrshy0doZ6Dspta7skO1u
 lsLg==
X-Gm-Message-State: AOAM530GTwin6EZJPkxeTKehDEzS32ugKNYVeIKwMM7RjOtnNZCvsTx+
 RFUKkoPmcvYZIUeIaOVVEHnQeE9aEEzYhwfzsi4=
X-Google-Smtp-Source: ABdhPJxVSbYdAXaxyGzsn/poqP0PsVS7Lkp/HacFDZucHYavuGxJeduqY46axtwy/QNAo6SDMSfDk8H0vxRGJwEdU4c=
X-Received: by 2002:a25:d006:: with SMTP id h6mr13980035ybg.122.1595600416834; 
 Fri, 24 Jul 2020 07:20:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200724095112.2615-1-green.wan@sifive.com>
 <20200724095112.2615-2-green.wan@sifive.com>
In-Reply-To: <20200724095112.2615-2-green.wan@sifive.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Fri, 24 Jul 2020 22:20:01 +0800
Message-ID: <CAEUhbmVgqNEe9k9p7Fto08_Rsu0W3d7UfzSK0HcprTk3cSzgaQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] hw/riscv: sifive_u: Add file-backed OTP.
 softmmu/vl: add otp-file to boot option
To: Green Wan <green.wan@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b42;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yb1-xb42.google.com
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
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Green,

On Fri, Jul 24, 2020 at 5:51 PM Green Wan <green.wan@sifive.com> wrote:
>
> Add a file-backed implementation for OTP of sifive_u machine. Use
> '-boot otp-file=xxx' to enable it. Do file open, mmap and close
> for every OTP read/write in case keep the update-to-date snapshot
> of OTP.
>
> Signed-off-by: Green Wan <green.wan@sifive.com>
> ---
>  hw/riscv/sifive_u_otp.c         | 88 ++++++++++++++++++++++++++++++++-
>  include/hw/riscv/sifive_u_otp.h |  2 +
>  qemu-options.hx                 |  3 +-
>  softmmu/vl.c                    |  6 ++-
>  4 files changed, 96 insertions(+), 3 deletions(-)
>
> diff --git a/hw/riscv/sifive_u_otp.c b/hw/riscv/sifive_u_otp.c
> index f6ecbaa2ca..26e1965821 100644
> --- a/hw/riscv/sifive_u_otp.c
> +++ b/hw/riscv/sifive_u_otp.c
> @@ -24,6 +24,72 @@
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
> +static int otp_backed_fd;
> +static unsigned int *otp_mmap;
> +
> +static void sifive_u_otp_backed_load(const char *filename);
> +static uint64_t sifive_u_otp_backed_read(uint32_t fuseidx);
> +static void sifive_u_otp_backed_write(uint32_t fuseidx,
> +                                      uint32_t paio,
> +                                      uint32_t pdin);
> +static void sifive_u_otp_backed_unload(void);
> +
> +void sifive_u_otp_backed_load(const char *filename)
> +{
> +    if (otp_backed_fd < 0) {
> +
> +        otp_backed_fd = open(filename, O_RDWR);
> +
> +        if (otp_backed_fd < 0)
> +            qemu_log_mask(LOG_TRACE,
> +                          TRACE_PREFIX "Warning: can't open otp file\n");
> +        else {
> +
> +            otp_mmap = (unsigned int *)mmap(0,
> +                                            SIFIVE_FU540_OTP_SIZE,
> +                                            PROT_READ | PROT_WRITE | PROT_EXEC,
> +                                            MAP_FILE | MAP_SHARED,
> +                                            otp_backed_fd,
> +                                            0);
> +
> +            if (otp_mmap == MAP_FAILED)
> +                qemu_log_mask(LOG_TRACE,
> +                              TRACE_PREFIX "Warning: can't mmap otp file\n");
> +        }
> +    }
> +
> +}
> +
> +uint64_t sifive_u_otp_backed_read(uint32_t fuseidx)
> +{
> +    return (uint64_t)(otp_mmap[fuseidx]);
> +}
> +
> +void sifive_u_otp_backed_write(uint32_t fuseidx, uint32_t paio, uint32_t pdin)
> +{
> +    otp_mmap[fuseidx] &= ~(pdin << paio);
> +    otp_mmap[fuseidx] |= (pdin << paio);
> +}
> +
> +
> +void sifive_u_otp_backed_unload(void)
> +{
> +    munmap(otp_mmap, SIFIVE_FU540_OTP_SIZE);
> +    close(otp_backed_fd);
> +    otp_backed_fd = -1;
> +}
>
>  static uint64_t sifive_u_otp_read(void *opaque, hwaddr addr, unsigned int size)
>  {
> @@ -46,7 +112,17 @@ static uint64_t sifive_u_otp_read(void *opaque, hwaddr addr, unsigned int size)
>          if ((s->pce & SIFIVE_U_OTP_PCE_EN) &&
>              (s->pdstb & SIFIVE_U_OTP_PDSTB_EN) &&
>              (s->ptrim & SIFIVE_U_OTP_PTRIM_EN)) {
> -            return s->fuse[s->pa & SIFIVE_U_OTP_PA_MASK];
> +
> +            if (otp_file) {
> +                uint64_t val;
> +
> +                sifive_u_otp_backed_load(otp_file);
> +                val = sifive_u_otp_backed_read(s->pa);
> +                sifive_u_otp_backed_unload();
> +
> +                return val;
> +            } else
> +                return s->fuse[s->pa & SIFIVE_U_OTP_PA_MASK];
>          } else {
>              return 0xff;
>          }
> @@ -123,6 +199,12 @@ static void sifive_u_otp_write(void *opaque, hwaddr addr,
>          s->ptrim = val32;
>          break;
>      case SIFIVE_U_OTP_PWE:
> +        if (otp_file) {
> +            sifive_u_otp_backed_load(otp_file);
> +            sifive_u_otp_backed_write(s->pa, s->paio, s->pdin);
> +            sifive_u_otp_backed_unload();
> +        }
> +
>          s->pwe = val32;
>          break;
>      default:
> @@ -165,6 +247,10 @@ static void sifive_u_otp_reset(DeviceState *dev)
>      /* Make a valid content of serial number */
>      s->fuse[SIFIVE_U_OTP_SERIAL_ADDR] = s->serial;
>      s->fuse[SIFIVE_U_OTP_SERIAL_ADDR + 1] = ~(s->serial);
> +
> +    /* Initialize file mmap and descriptor. */
> +    otp_mmap = NULL;
> +    otp_backed_fd = -1;
>  }
>
>  static void sifive_u_otp_class_init(ObjectClass *klass, void *data)
> diff --git a/include/hw/riscv/sifive_u_otp.h b/include/hw/riscv/sifive_u_otp.h
> index 639297564a..1342bd7342 100644
> --- a/include/hw/riscv/sifive_u_otp.h
> +++ b/include/hw/riscv/sifive_u_otp.h
> @@ -52,6 +52,8 @@
>  #define SIFIVE_U_OTP(obj) \
>      OBJECT_CHECK(SiFiveUOTPState, (obj), TYPE_SIFIVE_U_OTP)
>
> +extern const char *otp_file;
> +
>  typedef struct SiFiveUOTPState {
>      /*< private >*/
>      SysBusDevice parent_obj;
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 708583b4ce..eb9a54f4ed 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -415,10 +415,11 @@ ERST
>
>  DEF("boot", HAS_ARG, QEMU_OPTION_boot,
>      "-boot [order=drives][,once=drives][,menu=on|off]\n"
> -    "      [,splash=sp_name][,splash-time=sp_time][,reboot-timeout=rb_time][,strict=on|off]\n"
> +    "      [,splash=sp_name][,splash-time=sp_time][,reboot-timeout=rb_time][,strict=on|off][,otp-file=otp_file]\n"
>      "                'drives': floppy (a), hard disk (c), CD-ROM (d), network (n)\n"
>      "                'sp_name': the file's name that would be passed to bios as logo picture, if menu=on\n"
>      "                'sp_time': the period that splash picture last if menu=on, unit is ms\n"
> +    "                'otp_file': the file name backed OTP\n"
>      "                'rb_timeout': the timeout before guest reboot when boot failed, unit is ms\n",

Instead of touching generic codes, could we add such property at the
board level?

>      QEMU_ARCH_ALL)
>  SRST

Regards,
Bin

