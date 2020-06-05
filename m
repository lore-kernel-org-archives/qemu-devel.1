Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D67C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 15:36:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2CC22074B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 15:36:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SrqYmy4B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2CC22074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhEOA-0002no-1d
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 11:36:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56442)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jhEMT-000150-BW; Fri, 05 Jun 2020 11:34:26 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42604)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jhEMR-0000SG-Sn; Fri, 05 Jun 2020 11:34:25 -0400
Received: by mail-wr1-x441.google.com with SMTP id p5so10190325wrw.9;
 Fri, 05 Jun 2020 08:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=z8Uk4MiOT8Fk8076R7Colg8QeWSfB+NReO4bTL3BsUc=;
 b=SrqYmy4BX7LEio06FrsHk4RoGHJOghoBPeOT2sx6q3KgxY9xfvA2je16KL7hZSbOc9
 Sn7eq3W45BnB5AVK0LlFghLA736Gw9PxuLlmcwnH8iTh3iZKM4kDBF8ExEBtiZqyFa2R
 Df5DboBLfzEwd9Ur0TzJtU/PvdV52cmZHAUHcW7PXGNWOA7LhaftXeRWSa1+LV1tYl2q
 d3I0bLweIw80R3k7B3GSz0T1pandhkN1CrsUaAhAkgR239+pVrt94i0DLQhyLG81iVrV
 Rfp7pWnYim46XlyrYDQ9/cfRj/7qpBFnU3FhzeXETv3UQxK5XnjvlMtd/+IFqb8koFKA
 EGUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=z8Uk4MiOT8Fk8076R7Colg8QeWSfB+NReO4bTL3BsUc=;
 b=ONadOj+EF3AkBqqZTiLXOT6AQx4K1NyFktVnhTAbFdICxtDXGukpv4s/NlhiZNx2r9
 M3PC4FOZORob5VCGgX9Fd388mAfNw4X6EExmmJluauR40UVVMNti1sAtBIrR4g7LYZWl
 YZ8RoTgLkoBfd3DE6+jp1ceZx27Kc+jie5SDcpAtrSICiS1JXpH4Y6RFd70SkY7ftkdB
 Z7OPjpuSGU4qGv8kAIbvATbNra9OpOHbXjgiYUpKT+iqflLJyl5gAu5o6fd+zTVnolc9
 JD2tmpbp69eit0GD88CWOsp7UeEkZEQC7lDMJkfUwe4R5CXGjHiiGPyfEKmCZmtShMal
 AhDQ==
X-Gm-Message-State: AOAM533FSePXsjkXFlQ6Da5eh6LQBaFxNtiTg6y71JX687pyF1MnRfBW
 dA7581E4NAVCQnV6Q0YH5i4=
X-Google-Smtp-Source: ABdhPJzB/OrziwsjqJ/F4O7uDF3PCTJh8Dl0uwOx2BNQ8B2qI9ucu+8UoPkhZFebwBIl4T/MgtGwiA==
X-Received: by 2002:a5d:46d0:: with SMTP id g16mr11023589wrs.229.1591371261392; 
 Fri, 05 Jun 2020 08:34:21 -0700 (PDT)
Received: from [192.168.1.43] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id r5sm13020923wrq.0.2020.06.05.08.34.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Jun 2020 08:34:20 -0700 (PDT)
Subject: Re: [PATCH 15/16] sd/pxa2xx_mmci: Don't crash on pxa2xx_mmci_init()
 error
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200605145625.2920920-1-armbru@redhat.com>
 <20200605145625.2920920-16-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <bebb2db4-3da4-28f0-1d2d-2cea34d8d7dd@amsat.org>
Date: Fri, 5 Jun 2020 17:34:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200605145625.2920920-16-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
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
Cc: kwolf@redhat.com, Peter Maydell <peter.maydell@linaro.org>,
 berrange@redhat.com, ehabkost@redhat.com, qemu-block@nongnu.org,
 mreitz@redhat.com, qemu-arm@nongnu.org, pbonzini@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/5/20 4:56 PM, Markus Armbruster wrote:
> On error, pxa2xx_mmci_init() reports to stderr and returns NULL.
> Callers don't check for errors.  Machines akita, borzoi, mainstone,
> spitz, terrier, tosa, and z2 crash shortly after, like this:
> 
>     $ qemu-system-aarch64 -M akita -drive if=sd,readonly=on
>     qemu-system-aarch64: failed to init SD card: Cannot use read-only drive as SD card
>     Segmentation fault (core dumped)
> 
> Machines connex and verdex reach the check for orphaned drives first:
> 
>     $ aarch64-softmmu/qemu-system-aarch64 -M connex -drive if=sd,readonly=on -accel qtest
>     qemu-system-aarch64: failed to init SD card: Cannot use read-only drive as SD card
>     qemu-system-aarch64: -drive if=sd,readonly=on: machine type does not support if=sd,bus=0,unit=0
> 
> Make pxa2xx_mmci_init() fail cleanly right away.
> 
> Cc: Andrzej Zaborowski <balrogg@gmail.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: qemu-arm@nongnu.org
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/sd/pxa2xx_mmci.c | 15 +++------------
>  1 file changed, 3 insertions(+), 12 deletions(-)
> 
> diff --git a/hw/sd/pxa2xx_mmci.c b/hw/sd/pxa2xx_mmci.c
> index 3407617afc..68bed24480 100644
> --- a/hw/sd/pxa2xx_mmci.c
> +++ b/hw/sd/pxa2xx_mmci.c
> @@ -18,7 +18,6 @@
>  #include "hw/arm/pxa.h"
>  #include "hw/sd/sd.h"
>  #include "hw/qdev-properties.h"
> -#include "qemu/error-report.h"
>  #include "qemu/log.h"
>  #include "qemu/module.h"
>  #include "trace.h"
> @@ -483,7 +482,6 @@ PXA2xxMMCIState *pxa2xx_mmci_init(MemoryRegion *sysmem,
>      DeviceState *dev, *carddev;
>      SysBusDevice *sbd;
>      PXA2xxMMCIState *s;
> -    Error *err = NULL;
>  
>      dev = qdev_new(TYPE_PXA2XX_MMCI);
>      s = PXA2XX_MMCI(dev);
> @@ -496,16 +494,9 @@ PXA2xxMMCIState *pxa2xx_mmci_init(MemoryRegion *sysmem,
>  
>      /* Create and plug in the sd card */
>      carddev = qdev_new(TYPE_SD_CARD);
> -    qdev_prop_set_drive_err(carddev, "drive", blk, &err);
> -    if (err) {
> -        error_reportf_err(err, "failed to init SD card: ");
> -        return NULL;
> -    }
> -    qdev_realize_and_unref(carddev, qdev_get_child_bus(dev, "sd-bus"), &err);
> -    if (err) {
> -        error_reportf_err(err, "failed to init SD card: ");
> -        return NULL;
> -    }
> +    qdev_prop_set_drive_err(carddev, "drive", blk, &error_fatal);
> +    qdev_realize_and_unref(carddev, qdev_get_child_bus(dev, "sd-bus"),
> +                           &error_fatal);
>  
>      return s;
>  }
> 

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>



