Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F5CC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 13:10:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B096C20665
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 13:10:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZ0nPyC3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B096C20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBe9g-0002ol-Qq
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 09:10:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48704)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kBe7m-0001Mu-Vp; Fri, 28 Aug 2020 09:08:58 -0400
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42]:32845)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kBe7l-0001D9-Aw; Fri, 28 Aug 2020 09:08:58 -0400
Received: by mail-yb1-xb42.google.com with SMTP id p191so515635ybg.0;
 Fri, 28 Aug 2020 06:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=RZO7WDhW/ftkCphDDT8tMwIE4qGVJGj+Q8SeLBQiZ0k=;
 b=TZ0nPyC36Y0eD6bAsrNbuPX4kcrDdEfRil4eeKrGjLKb6nF5ZXoVI1o7CQdFkqdEBO
 948YPGbKB9eaertN99xlsthKCD9igA9VwLDVYo5edU0R+uqrylk4cY8ltGDcpmhLcrT8
 ZDsOqgAvbfzoGzxoCsovs4+cYe3k/jC21+TJ37HO4VC04WJ1yeFV3QYoqlzYjNFtPEsx
 +yLLyDuXFJXK5mL0I6Znrnf6OERlzKmAx6kKzkVF/iFRN/+ibXSsnpB2WIHMy8ATieEo
 joSMV02QIMeLdS+iO7GQL7JiPI1wZHuXMqc74daqkf4suYOoA/TiZj1r5aZ0rl7lYDAK
 nEVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RZO7WDhW/ftkCphDDT8tMwIE4qGVJGj+Q8SeLBQiZ0k=;
 b=KeKnShAk9DM2eSmjz0XenFec6X4AKlCpDaFGLFS6qj5jygGMesBYCQiixzEXGhZlp2
 pgg17RLrQSzEquNOPWS0Cu3D9a8Qlw4WvVRmNxE95x1HVAFsGbVo5VntBqfVyxBMiR7+
 EJUpYKry36aQkV7DYUa6oM0CltcAwUt+iu5dNBmWHlA8Q7S3uBDVv3xPg05rfdy0kNxf
 SE4HXPsaY5TgmqRisEN9u6TlX0+Glt2hZ1w5M7H9hCHZ1dCac1PIPKEijodfF6RGX+rl
 nYpHwoZOq5+nYs2yeRamwY3eFZtx3JbrJGzX/8BdynJ+mnuGc6j/8i5GzTaeJbKohatM
 S2cA==
X-Gm-Message-State: AOAM530jC7NtcePK7oge7uTUttQB4nxctoRMVIWlZ3tM/7gedbBAckxd
 zIXYYWvLPe/zvsI+fOHaKSmscWaY2qKv5YHCZLI=
X-Google-Smtp-Source: ABdhPJwTVDPXYIVoyp3KY0e8UI660AKHbTU1fBEK63vcLMge837VjKx0ME/GU55+/J1eUHU5ATmuu0fePV21hqR9ZLk=
X-Received: by 2002:a25:9cc7:: with SMTP id z7mr2476120ybo.387.1598620135347; 
 Fri, 28 Aug 2020 06:08:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200827074638.21451-1-green.wan@sifive.com>
 <20200827074638.21451-3-green.wan@sifive.com>
In-Reply-To: <20200827074638.21451-3-green.wan@sifive.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Fri, 28 Aug 2020 21:08:44 +0800
Message-ID: <CAEUhbmX_g+8V=5qVeD9oFn+YWxjAveJxiWKYyy3_kLzRMtsOCA@mail.gmail.com>
Subject: Re: [RFC PATCH v4 2/2] hw/riscv: sifive_u: Add write-once protection
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
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Green,

On Thu, Aug 27, 2020 at 3:47 PM Green Wan <green.wan@sifive.com> wrote:
>
> Add array to store the 'written' status for all bit of OTP to block
> the write operation to the same bit. Ignore the control register
> offset from 0x0 to 0x38 of OTP memory mapping.
>
> Signed-off-by: Green Wan <green.wan@sifive.com>
> ---
>  hw/riscv/sifive_u_otp.c         | 21 +++++++++++++++++++++
>  include/hw/riscv/sifive_u_otp.h |  1 +
>  2 files changed, 22 insertions(+)
>
> diff --git a/hw/riscv/sifive_u_otp.c b/hw/riscv/sifive_u_otp.c
> index aab2220494..e9605b9ae9 100644
> --- a/hw/riscv/sifive_u_otp.c
> +++ b/hw/riscv/sifive_u_otp.c
> @@ -27,6 +27,12 @@
>  #include "sysemu/blockdev.h"
>  #include "sysemu/block-backend.h"
>
> +#define SET_WRITTEN_BIT(map, idx, bit)    \
> +    (map[idx] |= (0x1 << bit))
> +
> +#define GET_WRITTEN_BIT(map, idx, bit)    \
> +    ((map[idx] >> bit) & 0x1)
> +
>  static uint64_t sifive_u_otp_read(void *opaque, hwaddr addr, unsigned int size)
>  {
>      SiFiveUOTPState *s = opaque;
> @@ -135,6 +141,18 @@ static void sifive_u_otp_write(void *opaque, hwaddr addr,
>          s->ptrim = val32;
>          break;
>      case SIFIVE_U_OTP_PWE:
> +        /* Keep written state for data only and PWE is enabled. Ignore PAS=1 */
> +        if ((s->pa > SIFIVE_U_OTP_PWE) && (val32 & 0x1) && !s->pas) {

s->pa represents the OTP memory address, and it has nothing to do with
the OTP controller register SIFIVE_U_OTP_PWE.

Please replace 0x1 with a macro like SIFIVE_U_OTP_PWE_EN.

> +            if (GET_WRITTEN_BIT(s->fuse_wo, s->pa, s->paio)) {
> +                qemu_log_mask(LOG_GUEST_ERROR,
> +                              "Error: write idx<%u>, bit<%u>\n",
> +                              s->pa, s->paio);
> +                break;
> +            }
> +
> +            SET_WRITTEN_BIT(s->fuse_wo, s->pa, s->paio);

Note this only protects 1 bit, so you should probably change the write
operation to operate on a bit basis instead of 4 bytes
(SIFIVE_U_OTP_FUSE_WORD).

> +        }
> +
>          /* write to backend */
>          if (s->blk) {
>              blk_pwrite(s->blk, s->pa * SIFIVE_U_OTP_FUSE_WORD, &val32,
> @@ -215,6 +233,9 @@ static void sifive_u_otp_reset(DeviceState *dev)
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
> index 13d2552e43..49d40a6430 100644
> --- a/include/hw/riscv/sifive_u_otp.h
> +++ b/include/hw/riscv/sifive_u_otp.h
> @@ -74,6 +74,7 @@ typedef struct SiFiveUOTPState {
>      uint32_t ptrim;
>      uint32_t pwe;
>      uint32_t fuse[SIFIVE_U_OTP_NUM_FUSES];
> +    uint32_t fuse_wo[SIFIVE_U_OTP_NUM_FUSES];
>      /* config */
>      uint32_t serial;
>      BlockBackend *blk;
> --

Regards,
Bin

