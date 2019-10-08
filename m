Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E06BC10F14
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 20:15:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13332206C0
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 20:15:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13332206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHvsw-0005RD-HW
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 16:15:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59255)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1iHvqP-0003aT-3S
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 16:12:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1iHvqJ-0002Ni-Pf
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 16:12:26 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42999)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1iHvqI-0002Gr-G7
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 16:12:22 -0400
Received: by mail-pf1-f196.google.com with SMTP id q12so18029pff.9
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 13:12:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=aIuobeVD6KXRsEP141R/z6/YzVpEt09yHG4/Wz5AGcQ=;
 b=OeMq6FbdpCW9jugQgjyeOODWqQJ0rFK2n+VXL1Hha1KlI9CuEg+NZIzYWeDOocexfP
 VAIeOiH2f0KPzryAIjFV757u3qlWBOGrEF27rjTa0BBCo0ZNgs6si/YAaoFJhkHI3gYA
 LZme/gsFSFiZZdGwfbqZQshr3yOuqXo/CMBiA1jfnRoeOuwhdqJHY/uq7aKzry9WMRFY
 YjtvW3mDI5/f1zj8XSqJkmTDlMTcXR0dy/gOUKa4t6ZJRIQPl7/FzXC5VRsE9av59jSB
 kgso7bHK3+IXb9F7whU7nph54v6yHgI5R9/e+u1LmNKJH7k4GHAPmH115eLk3BIfLDKr
 LVsw==
X-Gm-Message-State: APjAAAWgyT9nV+EmP6feOc2ils+5olnx1Uk9kwlZiF9XhNZi1H4dQLKI
 lzv5Mtmn01qdjTjz0kjlN7HZ5+Mt7ho=
X-Google-Smtp-Source: APXvYqxmns/HF6A0xe+jK0Hl4FsdZNvR8psSxWDNcW5zf4ott+2z9QFpzCiZsqSVjvcJSrq9UCUGXA==
X-Received: by 2002:a17:90a:9ab:: with SMTP id 40mr8035714pjo.38.1570565531746; 
 Tue, 08 Oct 2019 13:12:11 -0700 (PDT)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id f15sm17197737pfd.141.2019.10.08.13.12.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2019 13:12:11 -0700 (PDT)
Date: Tue, 08 Oct 2019 13:12:11 -0700 (PDT)
X-Google-Original-Date: Tue, 08 Oct 2019 13:05:01 PDT (-0700)
Subject: Re: [PATCH v2 4/7] riscv/sifive_u: Add the start-in-flash property
In-Reply-To: <a24af06cea57073f4a75381755ab05e825679445.1569545046.git.alistair.francis@wdc.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: Alistair Francis <Alistair.Francis@wdc.com>
Message-ID: <mhng-695a9235-b999-4aad-a3c1-0a2cdd0a5cdb@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.196
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 26 Sep 2019 17:44:28 PDT (-0700), Alistair Francis wrote:
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
> index f5741e9a38..33b55d0d5b 100644
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
> @@ -432,8 +436,31 @@ static void riscv_sifive_u_soc_init(Object *obj)
>                            TYPE_CADENCE_GEM);
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
>  }
>
>  static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
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

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>

