Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00FA2C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 14:13:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE84D2076C
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 14:13:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aoH503cM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE84D2076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiIWi-00062z-W5
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 10:13:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52604)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jiIVn-0005bi-57
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 10:12:27 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:50941)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jiIVm-0003TS-Bo
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 10:12:26 -0400
Received: by mail-wm1-x342.google.com with SMTP id l17so4297141wmj.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 07:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=2goqOlN2UlS7NYGQ+Vt6xkMnpTKo+8/vFHo/nNEFH1k=;
 b=aoH503cM4FBABnSuFn7z/hDx42poOwMvi6nMND/cArbrzSLOoxHAnPh1B+gDrTpDYl
 kTg9D6LJHEoSdbmxagbQ7n3FGSANoQ/Xq/4vizkk2Fuoni4crzlW3Gy1O/loBcYpUVui
 Ncvja3I9R7JJtK0EJLhi6tGgKPheo8NDvEoBiZNdiWsu/vlAr/SERrDA1wOszb1D39GM
 5otPF6tk5t3B7WSWM3OjtILBOCRF5/0bmtj8ebhP4QCB/1+ULjDohaxytpre7ROIy4Kb
 t4+CU0JVnSo1xqxhwbMXMcw4LyexafhdyfnYNCPCCcr82IP6rrHYHb45KYxn6k2BO7da
 v6WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2goqOlN2UlS7NYGQ+Vt6xkMnpTKo+8/vFHo/nNEFH1k=;
 b=KJ66wd6USDdOEK1VondTl85LMNW+ZpmahxwC/KNx3eOB8frJOuR9f8RiKC+4WfpqlM
 dz5bgt8zeDbz+vvAiaaRB77GbRNi9UVgfxGLGqC3gcEvY4jHxB1X5IoRLRPl9FJ0qyOS
 vV+ji+hii3U96HLpxTFX6U2nWMck2kmD/xebscQ+059V352x1la2cZYZbZlbDzawHVQh
 Efb0itJMODe2End/lwggFbNdgSHN0kupsvZ3Dp21MaAbL6TD7Qbc+UnXzHgwHo/R0Txs
 9nE0u47cQMfDgtFHb6Hz43hR6CIXp/5p906dAMPOdLU4uueEt1GGpAMP2YZ9bg+N1TOU
 0RNA==
X-Gm-Message-State: AOAM531NLZuhLUBRPWBPTDLBVmqjV+akjNTuV3Op6SFFTBiWzhi42ufO
 wY5SnkJP5xpaUZQaa1JqGc8=
X-Google-Smtp-Source: ABdhPJwjg1bRT2dOCxrUoRVJSuQGcPrzNJNSt7bxcG1UspXLhrPdGMMsdY1vzz4qLAz6ZBz50Lc3Jw==
X-Received: by 2002:a1c:4487:: with SMTP id r129mr16376917wma.14.1591625543266; 
 Mon, 08 Jun 2020 07:12:23 -0700 (PDT)
Received: from [192.168.1.38] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id q128sm22717645wma.38.2020.06.08.07.12.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jun 2020 07:12:22 -0700 (PDT)
Subject: Re: [PATCH v2 09/24] macio: Fix to realize "mos6522-cuda" and
 "mos6522-pmu" devices
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200528110444.20456-1-armbru@redhat.com>
 <20200528110444.20456-10-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e7fc9403-cd49-5816-c13f-2d93129f4c27@amsat.org>
Date: Mon, 8 Jun 2020 16:12:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200528110444.20456-10-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
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
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/28/20 1:04 PM, Markus Armbruster wrote:
> cuda_init() creates a "mos6522-cuda" device, but it's never realized.
> Affects machines mac99 with via=cuda (default) and g3beige.
> 
> pmu_init() creates a "mos6522-pmu" device, but it's never realized.
> Affects machine mac99 with via=pmu and via=pmu-adb,
> 
> In theory, a device becomes real only on realize.  In practice, the
> transition from unreal to real is a fuzzy one.  The work to make a
> device real can be spread between realize methods (fine),
> instance_init methods (wrong), and board code wiring up the device
> (fine as long as it effectively happens on realize).  Depending on
> what exactly is done where, a device can work even when we neglect
> to realize it.
> 
> These onetwo appear to work.  Nevertheless, it's a clear misuse of the
> interface.  Even when it works today (more or less by chance), it can
> break tomorrow.
> 
> Fix by realizing them in cuda_realize() and pmu_realize(),
> respectively.
> 
> Fixes: 6dca62a0000f95e0b7020aa00d0ca9b2c421f341
> Cc: Laurent Vivier <laurent@vivier.eu>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/misc/macio/cuda.c | 10 +++++-----
>  hw/misc/macio/pmu.c  | 10 +++++-----
>  2 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
> index e0cc0aac5d..763a785f1a 100644
> --- a/hw/misc/macio/cuda.c
> +++ b/hw/misc/macio/cuda.c
> @@ -33,6 +33,7 @@
>  #include "hw/misc/macio/cuda.h"
>  #include "qemu/timer.h"
>  #include "sysemu/runstate.h"
> +#include "qapi/error.h"
>  #include "qemu/cutils.h"
>  #include "qemu/log.h"
>  #include "qemu/module.h"
> @@ -523,15 +524,14 @@ static void cuda_realize(DeviceState *dev, Error **errp)
>  {
>      CUDAState *s = CUDA(dev);
>      SysBusDevice *sbd;
> -    MOS6522State *ms;
> -    DeviceState *d;
>      struct tm tm;
>  
> +    object_property_set_bool(OBJECT(&s->mos6522_cuda), true, "realized",
> +                             &error_abort);

Either use local_err and return on error, or simpler realize it in
cuda_init()...

> +
>      /* Pass IRQ from 6522 */
> -    d = DEVICE(&s->mos6522_cuda);
> -    ms = MOS6522(d);
>      sbd = SYS_BUS_DEVICE(s);
> -    sysbus_pass_irq(sbd, SYS_BUS_DEVICE(ms));
> +    sysbus_pass_irq(sbd, SYS_BUS_DEVICE(&s->mos6522_cuda));
>  
>      qemu_get_timedate(&tm, 0);
>      s->tick_offset = (uint32_t)mktimegm(&tm) + RTC_OFFSET;
> diff --git a/hw/misc/macio/pmu.c b/hw/misc/macio/pmu.c
> index 9a9cd427e1..4264779396 100644
> --- a/hw/misc/macio/pmu.c
> +++ b/hw/misc/macio/pmu.c
> @@ -40,6 +40,7 @@
>  #include "hw/misc/macio/pmu.h"
>  #include "qemu/timer.h"
>  #include "sysemu/runstate.h"
> +#include "qapi/error.h"
>  #include "qemu/cutils.h"
>  #include "qemu/log.h"
>  #include "qemu/module.h"
> @@ -740,15 +741,14 @@ static void pmu_realize(DeviceState *dev, Error **errp)
>  {
>      PMUState *s = VIA_PMU(dev);
>      SysBusDevice *sbd;
> -    MOS6522State *ms;
> -    DeviceState *d;
>      struct tm tm;
>  
> +    object_property_set_bool(OBJECT(&s->mos6522_pmu), true, "realized",
> +                             &error_abort);

Ditto.

> +
>      /* Pass IRQ from 6522 */
> -    d = DEVICE(&s->mos6522_pmu);
> -    ms = MOS6522(d);
>      sbd = SYS_BUS_DEVICE(s);
> -    sysbus_pass_irq(sbd, SYS_BUS_DEVICE(ms));
> +    sysbus_pass_irq(sbd, SYS_BUS_DEVICE(&s->mos6522_pmu));
>  
>      qemu_get_timedate(&tm, 0);
>      s->tick_offset = (uint32_t)mktimegm(&tm) + RTC_OFFSET;
> 


