Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC97C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 21:02:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 866C12074D
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 21:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IlZZlVAh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 866C12074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqNOM-0002xv-Jp
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 17:02:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41336)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jqNNc-0002SO-KH; Tue, 30 Jun 2020 17:01:24 -0400
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:44791)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jqNNa-0005ao-Qc; Tue, 30 Jun 2020 17:01:24 -0400
Received: by mail-il1-x143.google.com with SMTP id w73so7236236ila.11;
 Tue, 30 Jun 2020 14:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tgsnQ1e2Zvv+rol8rF7yNyHF4wdsNXofnqR9uCghlvU=;
 b=IlZZlVAhiLuQUc2Z198Io3yfZlFlukAJJPa5DV89Hfhqmg6HpLMZ3iksfL3wgec9Q5
 3sEx+ZZrDgTD+lbv3tPUp6mRpmCP0Z4uUouDNDjxi3cg89fMTpu5fUc0DzDpaITHn4dF
 P8FH3EJFOXDipyj20QGdGxpUEuqlOxpukxLYqMt7e07iAOMFPSRSR2Ansu9oF1KKpXzX
 DBNqztHHWdvzJodqBKW7ezhskfr+8irA0VSxBI92DQVDagmA2++2qOjGHt/nSRz3P+WX
 KqD9rub9dsZGaQIcVqN71ngj7Yh1vqgyy1NaR0dzveyNP3Ce6Qtsfk3Qh05dP56/ZLrg
 sZHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tgsnQ1e2Zvv+rol8rF7yNyHF4wdsNXofnqR9uCghlvU=;
 b=WzAQf4KHJRJzbcFh6sx0ZZNYYlHJSWBzngOUg9PCd6HzIbx8CQ/kyetc1GHTBP7oVa
 YxwphgQ62XgZOiYwPtxBB3PDWxN6uq3m+dvoG/Fy+cdrQLGcCHiG5hlvHCMt2A9bzo/g
 JtAtillsRjWjSnhy/RZb8kxkkEMnjXP7gx88o1E1j4ne9KV2brU6PTNYN8VN3vI+P4eO
 eMwjaRSKIg6Af99lOfAvsk3nH8OVQONqbeKWWabo9jKcMJB4wnxx/Etij+QEOPNzWlkA
 2KD61L1MdosLf1UJhakz0VZsmp8+sMeWn2ijlymiUxuc+A4c/sIHxi9r3R2zUntausF8
 6Eow==
X-Gm-Message-State: AOAM5307bBIFWbQJJhYsEtIhI3gL985Uyd0u5wkFZteaCgM+NgEXTXeo
 GwVblOT1MyLTxZTRGU6pMeJEq0OwASPPneGofGE=
X-Google-Smtp-Source: ABdhPJwlYzNySNphniezjVaCXRrbzFZskyboY7kXnTHSxAG01VQC8RKfNhARPS7DsYFFk5q34jyJDqqctJ1XbqQmVPg=
X-Received: by 2002:a92:d186:: with SMTP id z6mr4867702ilz.227.1593550881192; 
 Tue, 30 Jun 2020 14:01:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200628142429.17111-1-peter.maydell@linaro.org>
 <20200628142429.17111-7-peter.maydell@linaro.org>
In-Reply-To: <20200628142429.17111-7-peter.maydell@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 30 Jun 2020 13:51:37 -0700
Message-ID: <CAKmqyKNiX8=VwvCFEwKHxyDM3YtuyOEwAmSd6tkZ=M1o+XCvCw@mail.gmail.com>
Subject: Re: [PATCH 06/17] hw/misc/max111x: provide QOM properties for setting
 initial values
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::143;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x143.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <alistair@alistair23.me>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Jun 28, 2020 at 7:29 AM Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Add some QOM properties to the max111x ADC device to allow the
> initial values to be configured. Currently this is done by
> board code calling max111x_set_input() after it creates the
> device, which doesn't work on system reset.
>
> This requires us to implement a reset method for this device,
> so while we're doing that make sure we reset the other parts
> of the device state.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/misc/max111x.c | 57 ++++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 47 insertions(+), 10 deletions(-)
>
> diff --git a/hw/misc/max111x.c b/hw/misc/max111x.c
> index 2b87bdee5b7..d0e5534e4f5 100644
> --- a/hw/misc/max111x.c
> +++ b/hw/misc/max111x.c
> @@ -15,11 +15,15 @@
>  #include "hw/ssi/ssi.h"
>  #include "migration/vmstate.h"
>  #include "qemu/module.h"
> +#include "hw/qdev-properties.h"
>
>  typedef struct {
>      SSISlave parent_obj;
>
>      qemu_irq interrupt;
> +    /* Values of inputs at system reset (settable by QOM property) */
> +    uint8_t reset_input[8];
> +
>      uint8_t tb1, rb2, rb3;
>      int cycle;
>
> @@ -135,16 +139,6 @@ static int max111x_init(SSISlave *d, int inputs)
>      qdev_init_gpio_out(dev, &s->interrupt, 1);
>
>      s->inputs = inputs;
> -    /* TODO: add a user interface for setting these */
> -    s->input[0] = 0xf0;
> -    s->input[1] = 0xe0;
> -    s->input[2] = 0xd0;
> -    s->input[3] = 0xc0;
> -    s->input[4] = 0xb0;
> -    s->input[5] = 0xa0;
> -    s->input[6] = 0x90;
> -    s->input[7] = 0x80;
> -    s->com = 0;
>
>      vmstate_register(VMSTATE_IF(dev), VMSTATE_INSTANCE_ID_ANY,
>                       &vmstate_max111x, s);
> @@ -168,11 +162,50 @@ void max111x_set_input(DeviceState *dev, int line, uint8_t value)
>      s->input[line] = value;
>  }
>
> +static void max111x_reset(DeviceState *dev)
> +{
> +    MAX111xState *s = MAX_111X(dev);
> +    int i;
> +
> +    for (i = 0; i < s->inputs; i++) {
> +        s->input[i] = s->reset_input[i];
> +    }
> +    s->com = 0;
> +    s->tb1 = 0;
> +    s->rb2 = 0;
> +    s->rb3 = 0;
> +    s->cycle = 0;
> +}
> +
> +static Property max1110_properties[] = {
> +    /* Reset values for ADC inputs */
> +    DEFINE_PROP_UINT8("input0", MAX111xState, reset_input[0], 0xf0),
> +    DEFINE_PROP_UINT8("input1", MAX111xState, reset_input[1], 0xe0),
> +    DEFINE_PROP_UINT8("input2", MAX111xState, reset_input[2], 0xd0),
> +    DEFINE_PROP_UINT8("input3", MAX111xState, reset_input[3], 0xc0),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static Property max1111_properties[] = {
> +    /* Reset values for ADC inputs */
> +    DEFINE_PROP_UINT8("input0", MAX111xState, reset_input[0], 0xf0),
> +    DEFINE_PROP_UINT8("input1", MAX111xState, reset_input[1], 0xe0),
> +    DEFINE_PROP_UINT8("input2", MAX111xState, reset_input[2], 0xd0),
> +    DEFINE_PROP_UINT8("input3", MAX111xState, reset_input[3], 0xc0),
> +    DEFINE_PROP_UINT8("input4", MAX111xState, reset_input[4], 0xb0),
> +    DEFINE_PROP_UINT8("input5", MAX111xState, reset_input[5], 0xa0),
> +    DEFINE_PROP_UINT8("input6", MAX111xState, reset_input[6], 0x90),
> +    DEFINE_PROP_UINT8("input7", MAX111xState, reset_input[7], 0x80),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
>  static void max111x_class_init(ObjectClass *klass, void *data)
>  {
>      SSISlaveClass *k = SSI_SLAVE_CLASS(klass);
> +    DeviceClass *dc = DEVICE_CLASS(klass);
>
>      k->transfer = max111x_transfer;
> +    dc->reset = max111x_reset;
>  }
>
>  static const TypeInfo max111x_info = {
> @@ -186,8 +219,10 @@ static const TypeInfo max111x_info = {
>  static void max1110_class_init(ObjectClass *klass, void *data)
>  {
>      SSISlaveClass *k = SSI_SLAVE_CLASS(klass);
> +    DeviceClass *dc = DEVICE_CLASS(klass);
>
>      k->realize = max1110_realize;
> +    device_class_set_props(dc, max1110_properties);
>  }
>
>  static const TypeInfo max1110_info = {
> @@ -199,8 +234,10 @@ static const TypeInfo max1110_info = {
>  static void max1111_class_init(ObjectClass *klass, void *data)
>  {
>      SSISlaveClass *k = SSI_SLAVE_CLASS(klass);
> +    DeviceClass *dc = DEVICE_CLASS(klass);
>
>      k->realize = max1111_realize;
> +    device_class_set_props(dc, max1111_properties);
>  }
>
>  static const TypeInfo max1111_info = {
> --
> 2.20.1
>
>

