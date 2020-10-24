Return-Path: <SRS0=SOuJ=D7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 904C3C388F9
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 00:15:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12A032225E
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 00:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dym3INMz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12A032225E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kW7D5-0007iX-NS
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 20:15:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54724)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kW7C1-0006ah-Li; Fri, 23 Oct 2020 20:13:58 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:41040)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kW7By-0007Vs-Ok; Fri, 23 Oct 2020 20:13:57 -0400
Received: by mail-io1-xd42.google.com with SMTP id u62so4008365iod.8;
 Fri, 23 Oct 2020 17:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=g6d8kNhVYrSQks0nOXxK/SSqiv+CYxWCaBG1rmfqCzg=;
 b=Dym3INMzzAVRImV8MCW8GPkhG7IWRc8KKC+z7LQdcvP22cSXcqKeIyywbHZ3u/38Gg
 4Lc5tXJOlZ5x+D1Rcik45gkQeg/q44Sg630aPvh4f/IhAc4rgMjPKIT8c269KLwxWLOp
 uUl4oNv7vRvzpZUzHgtpMXzS+NUnRK77j6jWJKtk7jReksqDdKjNbH1JaMToTAVx9Mbn
 aPjbcaWohrqUodHliCbgXHiI0lFKcfFzTB+BWntYAmSD9FRRPaFOju9W0BhU5zF3O3pb
 DFuLL6E3LdQwYPqJtms8sZfyxsK2uVn5XnBSzxPArKiulZAN09Kpuo+XqLGcpMjm31B4
 Mu5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=g6d8kNhVYrSQks0nOXxK/SSqiv+CYxWCaBG1rmfqCzg=;
 b=M+ZXqeGuseNCk7Gw56wAFkfua1on14xmWwcDQzoR7dZEkiztT8AwnLpzJxY6mBsJub
 Xm3zRwqiPXIg9mykLT/6ZPwQ+az+2MggPGQj+v3ttFoZ0kl7WMSQUqDuSSdB9aUXo8S4
 +urHZk1B721nfm+SXvL76Jg8VynU0iI7EddB/him0pdFJw/shYJar+wsy7Ld8J50xRiB
 aRIacO0F0XfFP+LCdfJsmSzXSzS+ef9ufhUgvUQVtc0l2hAn+wL2kkErCstfkzdsxRNo
 1g1hSJMRdavFP9h4PQns0KWdNLb613FvnVbv0WI1PkRTklJb5FEO0pmbIOQaOD5J+fqK
 p7pQ==
X-Gm-Message-State: AOAM531vLfqooOQcKgGrvEQy456nRmUCx7Yg+CYvsGMF7ZDsDWUdmeBa
 72GlDERGz2N2K2qIYg9GOK/q/9O+/iYenfX3rvw=
X-Google-Smtp-Source: ABdhPJwwMRoOrSrCvDBz2gZQ6qH+Adl81wDen70h0g0+NbtTNFuqHNbYazTJia3gXnmSCgnDItfrPJ/TSJVze2+mcbY=
X-Received: by 2002:a5d:9a8d:: with SMTP id c13mr3621582iom.176.1603498433500; 
 Fri, 23 Oct 2020 17:13:53 -0700 (PDT)
MIME-Version: 1.0
References: <20201023091225.224-1-jiangyifei@huawei.com>
 <20201023091225.224-7-jiangyifei@huawei.com>
In-Reply-To: <20201023091225.224-7-jiangyifei@huawei.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 23 Oct 2020 17:02:06 -0700
Message-ID: <CAKmqyKNg5__hB+tMm3z0S9EH7FG9fMLpvFmwz5BoBKZ0Ag_Ruw@mail.gmail.com>
Subject: Re: [PATCH V3 6/6] target/riscv: Add sifive_plic vmstate
To: Yifei Jiang <jiangyifei@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d42;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd42.google.com
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
 Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 "Zhangxiaofeng \(F\)" <victor.zhangxiaofeng@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>, yinyipeng <yinyipeng1@huawei.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, "Wubin \(H\)" <wu.wubin@huawei.com>,
 "dengkai \(A\)" <dengkai1@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 23, 2020 at 2:13 AM Yifei Jiang <jiangyifei@huawei.com> wrote:
>
> Add sifive_plic vmstate for supporting sifive_plic migration.
> Current vmstate framework only supports one structure parameter
> as num field to describe variable length arrays, so introduce
> num_enables.
>
> Signed-off-by: Yifei Jiang <jiangyifei@huawei.com>
> Signed-off-by: Yipeng Yin <yinyipeng1@huawei.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/intc/sifive_plic.c | 26 +++++++++++++++++++++++++-
>  hw/intc/sifive_plic.h |  1 +
>  2 files changed, 26 insertions(+), 1 deletion(-)
>
> diff --git a/hw/intc/sifive_plic.c b/hw/intc/sifive_plic.c
> index f42fd695d8..97a1a27a9a 100644
> --- a/hw/intc/sifive_plic.c
> +++ b/hw/intc/sifive_plic.c
> @@ -30,6 +30,7 @@
>  #include "hw/intc/sifive_plic.h"
>  #include "target/riscv/cpu.h"
>  #include "sysemu/sysemu.h"
> +#include "migration/vmstate.h"
>
>  #define RISCV_DEBUG_PLIC 0
>
> @@ -448,11 +449,12 @@ static void sifive_plic_realize(DeviceState *dev, Error **errp)
>                            TYPE_SIFIVE_PLIC, plic->aperture_size);
>      parse_hart_config(plic);
>      plic->bitfield_words = (plic->num_sources + 31) >> 5;
> +    plic->num_enables = plic->bitfield_words * plic->num_addrs;
>      plic->source_priority = g_new0(uint32_t, plic->num_sources);
>      plic->target_priority = g_new(uint32_t, plic->num_addrs);
>      plic->pending = g_new0(uint32_t, plic->bitfield_words);
>      plic->claimed = g_new0(uint32_t, plic->bitfield_words);
> -    plic->enable = g_new0(uint32_t, plic->bitfield_words * plic->num_addrs);
> +    plic->enable = g_new0(uint32_t, plic->num_enables);
>      sysbus_init_mmio(SYS_BUS_DEVICE(dev), &plic->mmio);
>      qdev_init_gpio_in(dev, sifive_plic_irq_request, plic->num_sources);
>
> @@ -472,12 +474,34 @@ static void sifive_plic_realize(DeviceState *dev, Error **errp)
>      msi_nonbroken = true;
>  }
>
> +static const VMStateDescription vmstate_sifive_plic = {
> +    .name = "riscv_sifive_plic",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (VMStateField[]) {
> +            VMSTATE_VARRAY_UINT32(source_priority, SiFivePLICState,
> +                                  num_sources, 0,
> +                                  vmstate_info_uint32, uint32_t),
> +            VMSTATE_VARRAY_UINT32(target_priority, SiFivePLICState,
> +                                  num_addrs, 0,
> +                                  vmstate_info_uint32, uint32_t),
> +            VMSTATE_VARRAY_UINT32(pending, SiFivePLICState, bitfield_words, 0,
> +                                  vmstate_info_uint32, uint32_t),
> +            VMSTATE_VARRAY_UINT32(claimed, SiFivePLICState, bitfield_words, 0,
> +                                  vmstate_info_uint32, uint32_t),
> +            VMSTATE_VARRAY_UINT32(enable, SiFivePLICState, num_enables, 0,
> +                                  vmstate_info_uint32, uint32_t),
> +            VMSTATE_END_OF_LIST()
> +        }
> +};
> +
>  static void sifive_plic_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
>
>      device_class_set_props(dc, sifive_plic_properties);
>      dc->realize = sifive_plic_realize;
> +    dc->vmsd = &vmstate_sifive_plic;
>  }
>
>  static const TypeInfo sifive_plic_info = {
> diff --git a/hw/intc/sifive_plic.h b/hw/intc/sifive_plic.h
> index b75b1f145d..1e451a270c 100644
> --- a/hw/intc/sifive_plic.h
> +++ b/hw/intc/sifive_plic.h
> @@ -52,6 +52,7 @@ struct SiFivePLICState {
>      uint32_t num_addrs;
>      uint32_t num_harts;
>      uint32_t bitfield_words;
> +    uint32_t num_enables;
>      PLICAddr *addr_config;
>      uint32_t *source_priority;
>      uint32_t *target_priority;
> --
> 2.19.1
>
>

