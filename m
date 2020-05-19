Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C12C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 12:03:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23ACA2072C
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 12:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O52Cw1qI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23ACA2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb0xd-0001sO-7q
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 08:03:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48354)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jb0wQ-0000zr-Iy; Tue, 19 May 2020 08:01:50 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:39413)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jb0wP-0005Ti-Lc; Tue, 19 May 2020 08:01:50 -0400
Received: by mail-wm1-x341.google.com with SMTP id w64so3215733wmg.4;
 Tue, 19 May 2020 05:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=tihzVMw/QIrw+2PDY5/1GihVk/6gQrdDDiTpLx+s7VM=;
 b=O52Cw1qI12wuWTuszaOQBJW8nb1iSjHcwnw0zUgVj2J3jw7cFuQaezdvPe50BJkvQC
 BiWO5tgrQ6kL6cLzF64U+Zox1fU7nOG1AmEuYYYTzUfMBV1LqYVUYML9tO63uQysUNe2
 UYlpMD7OiPQjPLBIrwo7KTTSh1ZuRFCc1uG+RpUsoPOhXMA6lfh4M48vHi5haBQYXyuo
 OMOV0fwqu39RY4SgSW6hFU2DJfVLoeLoaLabuS1gTrU9InrJpX3uj0bn/Lw6SB5CuxYq
 vTYLy2uyrAGaO0iNFJyo6eVq+aZwPGeHzqbRyanC42JeqNFGWJc7PwLlBNhY5V0Cr4UT
 9K4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tihzVMw/QIrw+2PDY5/1GihVk/6gQrdDDiTpLx+s7VM=;
 b=Sg45pdth2O+94R+Mif8u4Oygo5u+hihnddgReOs7NxgRQCotcoWSavlta5xZUzySd4
 6r+jEwYge5okADGXLV27VBhO/e5hzmyy2SvSLehjYhmRDfylLCaLpaCkoDHNMrI6190y
 eZ3OthPHvGEOs6LNiCcrY7k56tnN3mCdBG6Irfp9nTvQPkWz3rxo/bpn5tu8qvGXQaIE
 XTIx1LSLCukCPeMVqeq9lKC77xRetsvEpc1n/fpS8SuvaSWg2g95aZrJ3F02b20KZVvI
 iXcdKWFnOQPkyb6bSJ+aGnTGOrn8MIEgOQM9Vq2rvF6Cz5N3U+AAGQhu//AGqARsw3Nk
 nqIg==
X-Gm-Message-State: AOAM530DqMMKi8tkqg2XG87J+v/uCfu0ZaHYcdVfh/fINN0Q9M1erNo8
 WLBiR85TWjk41W/gCh0w0VFB/s+xAfs=
X-Google-Smtp-Source: ABdhPJyMmv1uXHYIPFQVcNkvGqr/lvsAZqJJS7mbougFaEkldQxtyIX2/62KcqTlJsAEdFk6LGycGQ==
X-Received: by 2002:a1c:dc02:: with SMTP id t2mr3664647wmg.8.1589889705304;
 Tue, 19 May 2020 05:01:45 -0700 (PDT)
Received: from [192.168.1.39] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id h74sm21709768wrh.76.2020.05.19.05.01.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2020 05:01:42 -0700 (PDT)
Subject: Re: [PATCH] ARM: PL061: Introduce N_GPIOS
To: Geert Uytterhoeven <geert+renesas@glider.be>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200519085143.1376-1-geert+renesas@glider.be>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <83f920b8-7555-bfc4-6cb6-096f5e5c6d80@amsat.org>
Date: Tue, 19 May 2020 14:01:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200519085143.1376-1-geert+renesas@glider.be>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/19/20 10:51 AM, Geert Uytterhoeven wrote:
> Add a definition for the number of GPIO lines controlled by a PL061
> instance, and use it instead of the hardcoded magic value 8.
> 
> Suggested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks for following up.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   hw/gpio/pl061.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/gpio/pl061.c b/hw/gpio/pl061.c
> index 2a828260bdb0b946..6d3c36bc16cf9e0d 100644
> --- a/hw/gpio/pl061.c
> +++ b/hw/gpio/pl061.c
> @@ -36,6 +36,8 @@ static const uint8_t pl061_id_luminary[12] =
>   #define TYPE_PL061 "pl061"
>   #define PL061(obj) OBJECT_CHECK(PL061State, (obj), TYPE_PL061)
>   
> +#define N_GPIOS 8
> +
>   typedef struct PL061State {
>       SysBusDevice parent_obj;
>   
> @@ -62,7 +64,7 @@ typedef struct PL061State {
>       uint32_t cr;
>       uint32_t amsel;
>       qemu_irq irq;
> -    qemu_irq out[8];
> +    qemu_irq out[N_GPIOS];
>       const unsigned char *id;
>       uint32_t rsvd_start; /* reserved area: [rsvd_start, 0xfcc] */
>   } PL061State;
> @@ -112,7 +114,7 @@ static void pl061_update(PL061State *s)
>       changed = s->old_out_data ^ out;
>       if (changed) {
>           s->old_out_data = out;
> -        for (i = 0; i < 8; i++) {
> +        for (i = 0; i < N_GPIOS; i++) {
>               mask = 1 << i;
>               if (changed & mask) {
>                   DPRINTF("Set output %d = %d\n", i, (out & mask) != 0);
> @@ -125,7 +127,7 @@ static void pl061_update(PL061State *s)
>       changed = (s->old_in_data ^ s->data) & ~s->dir;
>       if (changed) {
>           s->old_in_data = s->data;
> -        for (i = 0; i < 8; i++) {
> +        for (i = 0; i < N_GPIOS; i++) {
>               mask = 1 << i;
>               if (changed & mask) {
>                   DPRINTF("Changed input %d = %d\n", i, (s->data & mask) != 0);
> @@ -364,8 +366,8 @@ static void pl061_init(Object *obj)
>       memory_region_init_io(&s->iomem, obj, &pl061_ops, s, "pl061", 0x1000);
>       sysbus_init_mmio(sbd, &s->iomem);
>       sysbus_init_irq(sbd, &s->irq);
> -    qdev_init_gpio_in(dev, pl061_set_irq, 8);
> -    qdev_init_gpio_out(dev, s->out, 8);
> +    qdev_init_gpio_in(dev, pl061_set_irq, N_GPIOS);
> +    qdev_init_gpio_out(dev, s->out, N_GPIOS);
>   }
>   
>   static void pl061_class_init(ObjectClass *klass, void *data)
> 

