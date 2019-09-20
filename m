Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 837ACC49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 05:25:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43D0B2054F
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 05:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C0svrwCt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43D0B2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBBQb-0006HC-C1
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 01:25:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39180)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1iBBGb-0005dd-QV
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 01:15:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1iBBGa-0004cx-Ag
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 01:15:37 -0400
Received: from mail-yb1-xb43.google.com ([2607:f8b0:4864:20::b43]:37735)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1iBBGa-0004c5-68; Fri, 20 Sep 2019 01:15:36 -0400
Received: by mail-yb1-xb43.google.com with SMTP id v5so2206918ybq.4;
 Thu, 19 Sep 2019 22:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=G/HMndOzKwhNSUK9mNQqwkoiSjNEsy0vmP3kv53/az0=;
 b=C0svrwCtpX+TSL55e0TJle2Owfsd+54eVaY3HSkWAjVnDVafbngMPYHXvegg+VOqNy
 hfaI8U71Lx319hBlgfzOe41oiEMHVxFF6Rj8oaTO4mtbqvpywkNmTo0MxxJbA/kFxGPw
 oorCdsDl1OYQoLUpzSk3DNrIdgbVMfV6kVrAo6HGmjy7Y1SAgJfkKzShE6fuRa6KGGJN
 k3cAS9Ozp3/ugUv6Pfp2K3YwTMTPHE6tGbblc56T+3L83BbBE0rNh4U/sHjZSG9Ex1rR
 +knloM8zrZYwwqeg0jo0NXbmgmIxQlesfw4b7ObabJAU+KVKJdoc910gVWN/8MCkqv3S
 +O6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=G/HMndOzKwhNSUK9mNQqwkoiSjNEsy0vmP3kv53/az0=;
 b=E7xnJeneeTufD9ul3iIeDzohxFqmIiLl2kzfj0yhrYULoIeDIaFrgnDhkI2CClN6X2
 wSyuD6+2lN704MzsG7VgF8DfQrmLnhDbwi4dz6AEUjsub+poVPF4gsHF7ns+pWxOk+lD
 fWnv94cumi6qmK5Mx2BC7U92qdmSm+tDcJQdRdND9Cnsh2Rz99yNtJj+MXmqhW33PazS
 xx5A4srNdIX3JrSpZggvvJ6qshySxsCxemrLOHF/itNq3NQbeIQuqu11CLPYDtYrnLyW
 JYOi9ug9lN3sShPdeisjppnrvUEY9hMo6U84KHsXkL0kSFbrFFPCTiqVysG1elrh8Xxj
 axqA==
X-Gm-Message-State: APjAAAXo82wWLEOOzGR2BWh6QktYBXjoqhScrIczeEzJNLBMqx1mJPQH
 sdKJj0CAM/OER3mW7p16lnvTZecsEfhVRasUy6qjYQ==
X-Google-Smtp-Source: APXvYqxq7qyHXzb2bj12sXgnCs0nrRZV/VrDYMN4q4Z4k9BPbCDFMtUKakUbMirD+P6eYdTEJrq6dcMGKTkTG0WqO0o=
X-Received: by 2002:a25:a87:: with SMTP id 129mr9749017ybk.203.1568956535601; 
 Thu, 19 Sep 2019 22:15:35 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1568931866.git.alistair.francis@wdc.com>
 <d3357e0b87cce025418f6383ce971246ded547bd.1568931866.git.alistair.francis@wdc.com>
In-Reply-To: <d3357e0b87cce025418f6383ce971246ded547bd.1568931866.git.alistair.francis@wdc.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Fri, 20 Sep 2019 13:15:22 +0800
Message-ID: <CAEUhbmV7Ao6L25HM+8AJLP8unn=HhvdRc1Kt+tUQgRB4S4zsBQ@mail.gmail.com>
Subject: Re: [PATCH v1 4/6] riscv/sifive_u: Add the start-in-flash property
To: Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b43
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
Cc: Alistair Francis <alistair23@gmail.com>, Palmer Dabbelt <palmer@sifive.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 20, 2019 at 6:32 AM Alistair Francis
<alistair.francis@wdc.com> wrote:
>
> Add a property that when set to true QEMU will jump from the ROM code to
> the start of flash memory instead of DRAM which is the default
> behaviour.
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  hw/riscv/sifive_u.c         | 27 +++++++++++++++++++++++++++
>  include/hw/riscv/sifive_u.h |  2 ++
>  2 files changed, 29 insertions(+)
>
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index c3949fb316..b7cd3631cd 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -373,6 +373,10 @@ static void riscv_sifive_u_init(MachineState *machine)
>                                         /* dtb: */
>      };
>
> +    if (s->start_in_flash) {
> +        reset_vec[6] = memmap[SIFIVE_U_FLASH0].base; /* start: .dword FLASH0_BASE */
> +    }
> +
>      /* copy in the reset vector in little_endian byte order */
>      for (i = 0; i < sizeof(reset_vec) >> 2; i++) {
>          reset_vec[i] = cpu_to_le32(reset_vec[i]);
> @@ -544,8 +548,31 @@ static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
>          memmap[SIFIVE_U_GEM_MGMT].base, memmap[SIFIVE_U_GEM_MGMT].size);
>  }
>
> +static bool virt_get_start_in_flash(Object *obj, Error **errp)
> +{
> +    SiFiveUState *s = RISCV_U_MACHINE(obj);
> +
> +    return s->start_in_flash;
> +}
> +
> +static void virt_set_start_in_flash(Object *obj, bool value, Error **errp)
> +{
> +    SiFiveUState *s = RISCV_U_MACHINE(obj);
> +
> +    s->start_in_flash = value;
> +}
> +
>  static void riscv_sifive_u_machine_instance_init(Object *obj)
>  {
> +    SiFiveUState *s = RISCV_U_MACHINE(obj);
> +
> +    s->start_in_flash = false;
> +    object_property_add_bool(obj, "start-in-flash", virt_get_start_in_flash,
> +                             virt_set_start_in_flash, NULL);
> +    object_property_set_description(obj, "start-in-flash",
> +                                    "Set on to tell QEMU's ROM to jump to " \
> +                                    "flash. Otherwise QEMU will jump to DRAM",
> +                                    NULL);
>
>  }
>
> diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
> index a921079fbe..2656b43c58 100644
> --- a/include/hw/riscv/sifive_u.h
> +++ b/include/hw/riscv/sifive_u.h
> @@ -57,6 +57,8 @@ typedef struct SiFiveUState {
>
>      void *fdt;
>      int fdt_size;
> +
> +    bool start_in_flash;
>  } SiFiveUState;
>
>  enum {

This patch chose a different way from the one used in patch "[v1,6/6]
riscv/virt: Jump to pflash if specified":

- this patch uses reset_vec[6] while patch [6/6] defines a variable start_addr
- this patch adds a "start-in-flash" property to the machine, while
patch [6/6] tests against drive IF_PFLASH

We should be consistent and I would prefer to use the patch [6/6] way.
On Unleashed an SPI flash is mounted so we cannot add a PFlash to
sifive_u machine like what was done on virt machine, so we should test
IF_MTD instead. Thoughts?

Regards,
Bin

