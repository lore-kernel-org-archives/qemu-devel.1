Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34394C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 08:05:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70EDA22243
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 08:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBYiCyQ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70EDA22243
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSyGN-0000Y5-FC
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 04:05:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44128)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kSyCl-0005vV-1R; Thu, 15 Oct 2020 04:01:48 -0400
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:38961)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kSyCh-0003cd-QK; Thu, 15 Oct 2020 04:01:42 -0400
Received: by mail-yb1-xb41.google.com with SMTP id 67so1521465ybt.6;
 Thu, 15 Oct 2020 01:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dSleulQX0RwtcXZiIWA1dhV78s+u5MuOjfDT7DxLzLY=;
 b=QBYiCyQ/DZIL8f3qzbRMTgbTRpEiy0DUPaZFjJGtzoQ/JbwtvX6fr58++l+p19Cwza
 iwtb6ybkB2P5O+AcvTI8tAo/OkjyV0/wS3/9rg/T/RRHwqmE5JZcj6y1skkUOdykbEJL
 f2WnPbn6gAjuUTrPEAYviPmrWb//Atx04khBkIES9+XOghge2KHEwGHE4/4eEzwSnp7R
 xsj9+xk8Phx15e8R8o6nMt02pVECt6R1YPtEN3XCv/bgDF9IsAbIIl9odgReHz95W9Sk
 ph7B/Vrsi/vCBC+1PHGudUriSgPVXpfezwu87lnIadxGyo4ubd9wkSVVpHA7jp1qyy0F
 Nc4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dSleulQX0RwtcXZiIWA1dhV78s+u5MuOjfDT7DxLzLY=;
 b=Ml9ql+kW2/DhxWvtKkJ4L8Up1LPwbmAI/xpxdkDCH3z34QyajztXxBsxpjhjkoCuGr
 v/dhW9VrghJkxyPrFx/zwvb8BAR3F8TJaIBddkjS5HTB8RqQ6gnDBKy8moXrjESt+plE
 w7ZlG3srJtF2VepLHyE+shcRvPtGYalciwmgzwu881ikCI+3mZ8Yh/rOt5495lk+BILU
 cbb3yfeuMCG710mBgcJ3g/c0gwMoUzT5/aIjpOr6+RRXV1iNTYaXD0vtuuNR9H01/hnk
 r50EXEGTtU3o14m0B2UVs2spUSfV1urRErkYPa4sWjlnU3CMTPhg/DzRj+MMZRbQv42d
 UBFA==
X-Gm-Message-State: AOAM530cHR7NU448l0kjpKggPpCMSMpbfwfqDPF76KHKlrRsNPVvth3V
 iaGk7ToEf1R321+WBYDJWII7bQydRJvJ81rX+jc=
X-Google-Smtp-Source: ABdhPJxlZzuSnQnkPzAdqtv554wyjHOIqbI4sxtDTT5pCNCf7jqPc3f4X4GEgrhgg451mhVZmSAByNF1VAdr2vg9wis=
X-Received: by 2002:a25:328a:: with SMTP id y132mr3698245yby.306.1602748898487; 
 Thu, 15 Oct 2020 01:01:38 -0700 (PDT)
MIME-Version: 1.0
References: <20201015041424.23090-1-green.wan@sifive.com>
 <20201015041424.23090-3-green.wan@sifive.com>
In-Reply-To: <20201015041424.23090-3-green.wan@sifive.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Thu, 15 Oct 2020 16:01:27 +0800
Message-ID: <CAEUhbmXZ5wXWyPqMwfwMoRUzmuKzj7-7QAXGd10MYhKanQhwbg@mail.gmail.com>
Subject: Re: [RFC PATCH v7 2/2] hw/misc/sifive_u_otp: Add backend drive support
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

On Thu, Oct 15, 2020 at 12:15 PM Green Wan <green.wan@sifive.com> wrote:
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
> ---
>  hw/misc/sifive_u_otp.c         | 67 +++++++++++++++++++++++++++++++++-
>  include/hw/misc/sifive_u_otp.h |  2 +
>  2 files changed, 68 insertions(+), 1 deletion(-)
>
> diff --git a/hw/misc/sifive_u_otp.c b/hw/misc/sifive_u_otp.c
> index 565eec082f..60066375ab 100644
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
> @@ -137,7 +150,7 @@ static void sifive_u_otp_write(void *opaque, hwaddr addr,
>          if (s->pwe && !s->pas) {
>              if (GET_FUSEARRAY_BIT(s->fuse_wo, s->pa, s->paio)) {
>                  qemu_log_mask(LOG_GUEST_ERROR,
> -                              "Error: write idx<%u>, bit<%u>\n",
> +                              "write once error: idx<%u>, bit<%u>\n",

This should be in the patch 1.

>                                s->pa, s->paio);
>                  break;
>              }
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

Otherwise,
Reviewed-by: Bin Meng <bin.meng@windriver.com>
Tested-by: Bin Meng <bin.meng@windriver.com>

You can drop the "RFC" tag in the next version.

