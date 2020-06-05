Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF5AC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 16:10:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB5BE2053B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 16:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G7wGumtz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB5BE2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhEvP-0003Ot-7B
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 12:10:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33488)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jhEu5-000236-Sw
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 12:09:09 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:52214)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jhEu5-0007ow-0H
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 12:09:09 -0400
Received: by mail-wm1-x343.google.com with SMTP id u13so8958681wml.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 09:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=HFowDgHn4CBYjLaoEFTClYZH1tSts7iWWVJ2bzP7d/4=;
 b=G7wGumtzTnSbypPQtW2KHJtsrZW16TxcX+jKYPog8A+Y49HiFsc8Eg3Nimp4mYrF8L
 hpE1Rd6Knsrc43CICm31c4Vimzr/nlaYIMGr9Spxo3p93j6VRoZvJ/fDWeKuzsKwxfoz
 U1bemqHLCIccpPVZDiEUxuoKmpnwm8wpjBPzjH3jlgj73XawHfp6TOQ41oTZKG5XkQIk
 hZmgdAFg0evvOPYR7+XvNU/FL2uT1l32aLGOLJWXwGhpXn1zve67XQhPc0DZ0ADUS7ku
 eu5gfJCLtoT8UVF/4HB4rBhoyygxvQd1++eVXnIonAypLQwlMeA+34eaVbtzwYeq1k+R
 FvUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HFowDgHn4CBYjLaoEFTClYZH1tSts7iWWVJ2bzP7d/4=;
 b=q7JHgYkJATglWJOjjQgvjR+CG3Dhn8hV7lCxYXRD5gzmV8wv8su8w1EKOGviEmGQ2V
 IjqCSRNd8lrb/hZTuduXLsKQd/PaFpIxjJf8uWsyi2q7+TcXEaTci2RkkobLaveUEOGO
 +0x+u0dEL15TuBy56NDnwsRItabnzYKPTxuFL2f3yqDBjqVdJcpiVDcGjOa55OjdirZZ
 LL/wYwvT8CNDVnFmnKAzb9zJSmGRayilc7dmpBoAx3pP4PcLLlOIClJslJhDPIfhB2xY
 TQKVuvCrNhrVwu7LKG4PETrQFnfhag3moI6pSO96L6+gk6M8fuLYHaI5hWlRX9Usk4Pw
 OuEw==
X-Gm-Message-State: AOAM530dh8Kd89mhyx7k7x8JqamZ7e7srpnO7M0xnZWK8HnMzbvIaJ0Q
 6aFro0yQJkkqKFlAU0bHV8R/ViuF
X-Google-Smtp-Source: ABdhPJzKRZDaqHOjQwunW/PtDPHO2s2YUm9hzSttfdlVgTULDZfzLcCHQp/x3yO4VwAY+jxkoIZhig==
X-Received: by 2002:a05:600c:2317:: with SMTP id
 23mr3449919wmo.139.1591373343588; 
 Fri, 05 Jun 2020 09:09:03 -0700 (PDT)
Received: from [192.168.1.43] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id t189sm11870010wma.4.2020.06.05.09.09.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Jun 2020 09:09:02 -0700 (PDT)
Subject: Re: [PATCH 05/10] hw/rx: RX MCU and target
To: Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org
References: <20200531162427.57410-1-ysato@users.sourceforge.jp>
 <20200531162427.57410-6-ysato@users.sourceforge.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <efa08ca1-648f-2d1a-c512-9938b4918f36@amsat.org>
Date: Fri, 5 Jun 2020 18:09:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200531162427.57410-6-ysato@users.sourceforge.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/31/20 6:24 PM, Yoshinori Sato wrote:
> rx62n - RX62N MCU.
> rx-virt - RX QEMU virtual target.
>  This has the same specifications as the gdb simulator.
> 
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>  include/hw/rx/rx.h    |   7 ++
>  include/hw/rx/rx62n.h |  91 ++++++++++++++++
>  hw/rx/rx-virt.c       | 143 +++++++++++++++++++++++++
>  hw/rx/rx62n.c         | 240 ++++++++++++++++++++++++++++++++++++++++++
>  hw/rx/Kconfig         |  13 +++
>  hw/rx/Makefile.objs   |   2 +
>  6 files changed, 496 insertions(+)
>  create mode 100644 include/hw/rx/rx.h
>  create mode 100644 include/hw/rx/rx62n.h
>  create mode 100644 hw/rx/rx-virt.c
>  create mode 100644 hw/rx/rx62n.c
>  create mode 100644 hw/rx/Kconfig
>  create mode 100644 hw/rx/Makefile.objs
> 
[...]
> +static void register_tmr(RX62NState *s, int unit)
> +{
> +    SysBusDevice *tmr;
> +    int i, irqbase;
> +
> +    object_initialize_child(OBJECT(s), "tmr[*]", &s->tmr[unit],
> +                            sizeof(RTMRState), TYPE_RENESAS_8TMR,
> +                            &error_abort, NULL);
> +
> +    tmr = SYS_BUS_DEVICE(&s->tmr[unit]);
> +    qdev_prop_set_uint64(DEVICE(tmr), "input-freq", RX62N_PCLK);
> +
> +    qdev_init_nofail(DEVICE(tmr));
> +    sysbus_mmio_map(tmr, 0, RX62N_TMRBASE + unit * 0x10);
> +    irqbase = RX62N_TMR_IRQBASE + TMR_NR_IRQ * unit;
> +    for (i = 0; i < TMR_NR_IRQ; i++) {
> +        sysbus_connect_irq(tmr, i, s->irq[irqbase + i]);
> +    }
> +}
> +
> +static void register_cmt(RX62NState *s, int unit)
> +{
> +    SysBusDevice *cmt;
> +    int i, irqbase;
> +
> +    object_initialize_child(OBJECT(s), "cmt[*]", &s->cmt[unit],
> +                            sizeof(RTIMERState), TYPE_RENESAS_TIMER,
> +                            &error_abort, NULL);
> +
> +    cmt = SYS_BUS_DEVICE(&s->cmt[unit]);
> +    qdev_prop_set_uint64(DEVICE(cmt), "input-freq", RX62N_PCLK);
> +    qdev_prop_set_int32(DEVICE(cmt), "feature", RTIMER_FEAT_CMT);

OK, single logical change, no problem.

> +    qdev_init_nofail(DEVICE(cmt));
> +    sysbus_mmio_map(cmt, 0, RX62N_CMTBASE + unit * 0x10);
> +    irqbase = RX62N_CMT_IRQBASE + TIMER_CH_CMT * unit;
> +    for (i = 0; i < TIMER_CH_CMT; i++) {
> +        sysbus_connect_irq(cmt, i, s->irq[irqbase + i]);
> +    }
> +}
> +
> +static void register_sci(RX62NState *s, int unit)
> +{
> +    SysBusDevice *sci;
> +    int i, irqbase;
> +
> +    object_initialize_child(OBJECT(s), "sci[*]", &s->sci[unit],
> +                            sizeof(RSCIState), TYPE_RENESAS_SCI,
> +                            &error_abort, NULL);
> +    sci = SYS_BUS_DEVICE(&s->sci[unit]);
> +
> +    qdev_prop_set_chr(DEVICE(sci), "chardev", serial_hd(unit));
> +    qdev_prop_set_uint64(DEVICE(sci), "input-freq", RX62N_PCLK);
> +    qdev_prop_set_int32(DEVICE(sci), "feature", SCI_FEAT_SCIA);
> +    qdev_prop_set_int32(DEVICE(sci), "register-size", 8);
> +    qdev_init_nofail(DEVICE(sci));
> +    sysbus_mmio_map(sci, 0, RX62N_SCIBASE + unit * 0x08);
> +    irqbase = RX62N_SCI_IRQBASE + SCI_NR_IRQ * unit;
> +    for (i = 0; i < SCI_NR_IRQ; i++) {
> +        sysbus_connect_irq(sci, i, s->irq[irqbase + i]);
> +    }
> +}[...]


