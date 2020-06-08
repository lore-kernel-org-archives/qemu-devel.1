Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1095C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 14:03:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBC5C206C3
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 14:03:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SV6f0XK5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBC5C206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiIMz-00087V-2O
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 10:03:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51330)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jiILw-0007bz-LN; Mon, 08 Jun 2020 10:02:16 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44460)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jiILv-0001qC-P3; Mon, 08 Jun 2020 10:02:16 -0400
Received: by mail-wr1-x443.google.com with SMTP id y17so17509546wrn.11;
 Mon, 08 Jun 2020 07:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=nq2xanGLh6ZPYCzponIHSk7Z+mN3fH6xJlvcIRxXB9U=;
 b=SV6f0XK55Y/JXu0hm28pUCkigZ6ZDSX9yxPA95gCM6iAzKR/LGn/GUcVNfsGG0c9tL
 Jw2iLgiouCTKSJQGOkTJHLYA2r9O1L5tz0MiILGcNhCDlpvIDwcR1b1zjogup89n1FoX
 HaimsmexFkcdVXhwmZM2n0OUz38vNfY3QkNcO6QKNMNiQTudq+yl96n1fS2j1qNPpvgA
 xj2sqEOqXraw/WdSMbUBdgr5411SN8Lt4fj/47ZLfrWWMpGOrRy6IBlY7vwKTd1aGOv+
 IqvbMmiiaKXfJVgMIl2s4jRwzRmd4BLZPvBEEHHHmaWe0prMfZ/fRwUPWvSlb2N6ZWkT
 6EgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nq2xanGLh6ZPYCzponIHSk7Z+mN3fH6xJlvcIRxXB9U=;
 b=UT7TFRgoMwMO7OKYldNuXraR+JE5LhPJv8YWaCXK0posbX/CD9XWK0w8HO9w8xSHqK
 QFve9WEqMzLRMUawMdzKSnBZUYIfkkHqhAyNht5hz6eztJPguqkaBITzyzgoUIYpQOP6
 uZGx61oNkhKJLNvt3XkecwbO8BB3bgUzvAswyhLyhpqu46XAXFoJs/GK/Q+rLmnGwzQw
 voAtCmbI7ll1G1djFzFlS1jl+zQXCc6Djw/Vq1+CRNATrIaA0XYLIpcIkLFyE/a1sv0Y
 8kAzttQvmuqcWqBbfoa6DTtmsaf6azAv+010t+mGK4vTlfDiE9Cp/fz6lLjreZA57aa1
 aDuw==
X-Gm-Message-State: AOAM5338Ii41q4C5dlsU4E2vT5/yzMXlvNjp9gOT+OJKUFQjArYs7n8b
 GbYhE6qPRmMbTpYYIivO0mE=
X-Google-Smtp-Source: ABdhPJwZaj72h1OxdD0wBZa2hfso0K7VS0EPnmpcVctDAh1y2UcE1mIVGeVbOGyAoOrZfbworEt1Wg==
X-Received: by 2002:a5d:5585:: with SMTP id i5mr23430380wrv.112.1591624933001; 
 Mon, 08 Jun 2020 07:02:13 -0700 (PDT)
Received: from [192.168.1.38] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id q13sm23018034wrn.84.2020.06.08.07.02.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jun 2020 07:02:11 -0700 (PDT)
Subject: Re: [PATCH v2 06/24] armv7m: Delete unused "ARM,bitband-memory"
 devices
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200528110444.20456-1-armbru@redhat.com>
 <20200528110444.20456-7-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <435ddac3-29f8-9f0a-6fa3-c369bcfd005c@amsat.org>
Date: Mon, 8 Jun 2020 16:02:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200528110444.20456-7-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
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
Cc: pbonzini@redhat.com, qemu-arm@nongnu.org, berrange@redhat.com,
 ehabkost@redhat.com, Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/28/20 1:04 PM, Markus Armbruster wrote:
> These devices are optional, and enabled by property "enable-bitband".
> armv7m_instance_init() creates them unconditionally, because the
> property has not been set then.  armv7m_realize() realizes them only
> when the property is true.  Works, although it leaves unrealized
> devices hanging around in the QOM composition tree.  Affects machines
> microbit, mps2-an505, mps2-an521, musca-a, and musca-b1.
> 
> Delete the unused devices by making armv7m_realize() unparent them.
> Visible in "info qom-tree"; here's the change for microbit:
> 
>      /machine (microbit-machine)
>        /microbit.twi (microbit.i2c)
>          /microbit.twi[0] (qemu:memory-region)
>        /nrf51 (nrf51-soc)
>          /armv6m (armv7m)
>            /armv7m-container[0] (qemu:memory-region)
>     -      /bitband[0] (ARM,bitband-memory)
>     -        /bitband[0] (qemu:memory-region)
>     -      /bitband[1] (ARM,bitband-memory)
>     -        /bitband[0] (qemu:memory-region)
>            /cpu (cortex-m0-arm-cpu)
> 
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: qemu-arm@nongnu.org
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/arm/armv7m.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
> index 7da57f56d3..f930619f53 100644
> --- a/hw/arm/armv7m.c
> +++ b/hw/arm/armv7m.c
> @@ -245,8 +245,8 @@ static void armv7m_realize(DeviceState *dev, Error **errp)
>      memory_region_add_subregion(&s->container, 0xe000e000,
>                                  sysbus_mmio_get_region(sbd, 0));
>  
> -    if (s->enable_bitband) {
> -        for (i = 0; i < ARRAY_SIZE(s->bitband); i++) {
> +    for (i = 0; i < ARRAY_SIZE(s->bitband); i++) {
> +        if (s->enable_bitband) {
>              Object *obj = OBJECT(&s->bitband[i]);
>              SysBusDevice *sbd = SYS_BUS_DEVICE(&s->bitband[i]);
>  
> @@ -265,6 +265,8 @@ static void armv7m_realize(DeviceState *dev, Error **errp)
>  
>              memory_region_add_subregion(&s->container, bitband_output_addr[i],
>                                          sysbus_mmio_get_region(sbd, 0));
> +        } else {
> +            object_unparent(OBJECT(&s->bitband[i]));
>          }
>      }
>  }
> 


