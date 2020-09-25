Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3834C4727E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 21:48:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6295A206FB
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 21:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ryjkH5oh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6295A206FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLva1-00023C-HM
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 17:48:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33636)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kLvXq-00006l-Kf; Fri, 25 Sep 2020 17:46:23 -0400
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141]:45943)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kLvXm-00056b-Ii; Fri, 25 Sep 2020 17:46:22 -0400
Received: by mail-il1-x141.google.com with SMTP id h2so3721676ilo.12;
 Fri, 25 Sep 2020 14:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KZP6HHc7D1KN/3c3zHXsoXBSpiAUHPQAxY5YqCpgxbg=;
 b=ryjkH5ohbZYBFYIBtGH2YhzIar+CNBpYvh+nfG6GqoaQOTlKaHnVsRRzyBTbPbWKTG
 SDEH2w274Nr82eBbtq6+pkw/NqCiTDio5I/XjbpuIbnKsQNty2qr7rQvB9NJCgCUO/KW
 2m5w7BV3s2BusS+E63WbM66oB02QiW9K3zylR5r9MpvNhupdW2cJV6BZI7isjbjx86du
 WEWFQPEI+Pvaoh85dCFHZXw+vWK7csQSzVSciToNGAnxZbTic6VBq/8pZm2d1SLee+da
 HMrTR56qnLqCPUjr0mfZPua+nGQEEqf+ZDtltToAjq8sP3F3sVNrwXdl9QzJZe94wOGz
 7Xmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KZP6HHc7D1KN/3c3zHXsoXBSpiAUHPQAxY5YqCpgxbg=;
 b=XiiSwtgmWgoc3j8mxpa1Z2K8PHEKfhxMdqSLBlg1PhjnU7Z6UZl0jo8WEV62c3uXDv
 9UUXTEzwvmUwXkDYXgkYGzi7Uqtub4iLA4ZZ/DkEB038Hk4Izk1BR2qYNuPA5u6xDE0G
 xiKY8tdPgQabFdIOW56VlmYk2w44onGaB0IRrpWX2Qor5EtPA1YQ2Id9uq+hN05i2M7q
 i89ItWfHDVjbhaF/526vMttuNAGbos8Ifti2Kut0YrdaiqwWtfZm3lqIY2RJ9pdAMHH5
 XlN+t9kp7gJhy96s8hFm3ra0OFGD3R1sBjB/iZs1mHScEIa3n7Yx45swKbiI+T5QehGJ
 CRLg==
X-Gm-Message-State: AOAM5308lWICm8zL81dMcu1rqF8AQwKnlld3HngVhGtKELEaexkPIgNM
 SuUM9EApBX+PvzdhMah+Hu/iIruUsEiYdAifj8w=
X-Google-Smtp-Source: ABdhPJy6Px89pdEr2c6xaXc24/e/e+WOoNXK+prEYtPCdAQoPzrzAxZeuSDzJFqIvc9XybnL98K1QQGxz4GjrbpSXIw=
X-Received: by 2002:a92:8b52:: with SMTP id i79mr1953065ild.177.1601070375035; 
 Fri, 25 Sep 2020 14:46:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200901154711.18457-1-green.wan@sifive.com>
 <20200901154711.18457-2-green.wan@sifive.com>
In-Reply-To: <20200901154711.18457-2-green.wan@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 25 Sep 2020 14:34:56 -0700
Message-ID: <CAKmqyKO0Y1s_8tOfD1qr6iBDN9J+yYrE5PR06ezTJfuEf0jo+g@mail.gmail.com>
Subject: Re: [RFC PATCH v5 1/2] hw/riscv: sifive_u: Add write operation and
 write-once protection
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

On Tue, Sep 1, 2020 at 9:09 AM Green Wan <green.wan@sifive.com> wrote:
>
>  - Add write operation to update fuse data bit when PWE bit is on.
>  - Add array, fuse_wo, to store the 'written' status for all bits
>    of OTP to block the write operation.
>
> Signed-off-by: Green Wan <green.wan@sifive.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/sifive_u_otp.c         | 30 +++++++++++++++++++++++++++++-
>  include/hw/riscv/sifive_u_otp.h |  3 +++
>  2 files changed, 32 insertions(+), 1 deletion(-)
>
> diff --git a/hw/riscv/sifive_u_otp.c b/hw/riscv/sifive_u_otp.c
> index f6ecbaa2ca..b8369e9035 100644
> --- a/hw/riscv/sifive_u_otp.c
> +++ b/hw/riscv/sifive_u_otp.c
> @@ -25,6 +25,14 @@
>  #include "qemu/module.h"
>  #include "hw/riscv/sifive_u_otp.h"
>
> +#define WRITTEN_BIT_ON 0x1
> +
> +#define SET_FUSEARRAY_BIT(map, i, off, bit)    \
> +    map[i] = bit ? (map[i] | bit << off) : (map[i] & ~(bit << off))
> +
> +#define GET_FUSEARRAY_BIT(map, i, off)    \
> +    ((map[i] >> off) & 0x1)
> +
>  static uint64_t sifive_u_otp_read(void *opaque, hwaddr addr, unsigned int size)
>  {
>      SiFiveUOTPState *s = opaque;
> @@ -123,7 +131,24 @@ static void sifive_u_otp_write(void *opaque, hwaddr addr,
>          s->ptrim = val32;
>          break;
>      case SIFIVE_U_OTP_PWE:
> -        s->pwe = val32;
> +        s->pwe = val32 & SIFIVE_U_OTP_PWE_EN;
> +
> +        /* PWE is enabled. Ignore PAS=1 (no redundancy cell) */
> +        if (s->pwe && !s->pas) {
> +            if (GET_FUSEARRAY_BIT(s->fuse_wo, s->pa, s->paio)) {
> +                qemu_log_mask(LOG_GUEST_ERROR,
> +                              "Error: write idx<%u>, bit<%u>\n",
> +                              s->pa, s->paio);
> +                break;
> +            }
> +
> +            /* write bit data */
> +            SET_FUSEARRAY_BIT(s->fuse, s->pa, s->paio, s->pdin);
> +
> +            /* update written bit */
> +            SET_FUSEARRAY_BIT(s->fuse_wo, s->pa, s->paio, WRITTEN_BIT_ON);
> +        }
> +
>          break;
>      default:
>          qemu_log_mask(LOG_GUEST_ERROR, "%s: bad write: addr=0x%" HWADDR_PRIx
> @@ -165,6 +190,9 @@ static void sifive_u_otp_reset(DeviceState *dev)
>      /* Make a valid content of serial number */
>      s->fuse[SIFIVE_U_OTP_SERIAL_ADDR] = s->serial;
>      s->fuse[SIFIVE_U_OTP_SERIAL_ADDR + 1] = ~(s->serial);
> +
> +    /* Initialize write-once map */
> +    memset(s->fuse_wo, 0x00, sizeof(s->fuse_wo));
>  }
>
>  static void sifive_u_otp_class_init(ObjectClass *klass, void *data)
> diff --git a/include/hw/riscv/sifive_u_otp.h b/include/hw/riscv/sifive_u_otp.h
> index 639297564a..4a5a0acf48 100644
> --- a/include/hw/riscv/sifive_u_otp.h
> +++ b/include/hw/riscv/sifive_u_otp.h
> @@ -35,6 +35,8 @@
>  #define SIFIVE_U_OTP_PTRIM      0x34
>  #define SIFIVE_U_OTP_PWE        0x38
>
> +#define SIFIVE_U_OTP_PWE_EN     (1 << 0)
> +
>  #define SIFIVE_U_OTP_PCE_EN     (1 << 0)
>
>  #define SIFIVE_U_OTP_PDSTB_EN   (1 << 0)
> @@ -73,6 +75,7 @@ typedef struct SiFiveUOTPState {
>      uint32_t ptrim;
>      uint32_t pwe;
>      uint32_t fuse[SIFIVE_U_OTP_NUM_FUSES];
> +    uint32_t fuse_wo[SIFIVE_U_OTP_NUM_FUSES];
>      /* config */
>      uint32_t serial;
>  } SiFiveUOTPState;
> --
> 2.17.1
>
>

