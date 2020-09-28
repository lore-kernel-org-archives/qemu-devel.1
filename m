Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6BE8C2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 07:53:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFD7D21775
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 07:53:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lmichel.fr header.i=@lmichel.fr header.b="R7WAaSBu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFD7D21775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=lmichel.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMnya-0007l7-UK
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 03:53:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56876)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>) id 1kMnxC-0006eJ-9T
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 03:52:10 -0400
Received: from pharaoh.lmichel.fr ([149.202.28.74]:36682)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>) id 1kMnxA-0000na-L2
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 03:52:10 -0400
Received: from localhost (sekoia-pc.home.lmichel.fr [192.168.61.100])
 by pharaoh.lmichel.fr (Postfix) with ESMTPSA id 68DBDC60F1A;
 Mon, 28 Sep 2020 07:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lmichel.fr; s=pharaoh; 
 t=1601279523;
 h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gcJlgcggBr8TDeD0xKw+LH+VcLMaM31XJoAdh5HF5Jw=;
 b=R7WAaSBuQdCE2QiGzl9dQ5enku1FtU8JpqVMa7JtFJlaBkZqqMiUzZg4hSXnvZPaL4t3zH
 SFxpZKg436tqTiSm8TkeVJt0wzAFDFr49/6XHaZ+7AfjfCB46/D3oCaDAtGpydPNZQxwlX
 toLjgUzQHNZQqvT1TeeFNGnS3cdxBryFwJYY1KRhth63qewSMO+D/d8OkAOeb1abBc23CA
 yBc0PZHr7McGCs3VLNZahssNMQ4kNphLMWFykdmry6g4eKhNoG4Efobd+F073ta8CZNnUn
 m3bxU4S9nYXcE7Bs+pRT22E3hRf9ac22DI2pG3Fida/zO0IeUcLY7fXLUcqNFg==
Date: Mon, 28 Sep 2020 09:53:00 +0200
From: Luc Michel <luc@lmichel.fr>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH 3/3] hw/qdev-clock: Display error hint when clock is
 missing from device
Message-ID: <20200928075300.q5ngcywiz5fyu6du@sekoia-pc.home.lmichel.fr>
References: <20200927090820.61859-1-f4bug@amsat.org>
 <20200927090820.61859-4-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200927090820.61859-4-f4bug@amsat.org>
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=lmichel.fr;
 s=pharaoh; t=1601279523;
 h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gcJlgcggBr8TDeD0xKw+LH+VcLMaM31XJoAdh5HF5Jw=;
 b=NEwPj1IB/et7CROaMl6yrKkx49rfP0sTizhYit65Joq11PY84sBheetuLdzWX/9rzHP3qL
 Tq2nIAmB5WFTOGSCqsHbTVURmHrntYIzpv8PowwWR3t3vY6cFRzdldVUZy96H3dQy/5K02
 9+OAQAPuhx/o2tE4L9Y2yQX3JzpXjE+BjmaeopIfmb3X0y+DP6f5S3HOib/EAtE/VBe2RP
 rGik9hxtfsBYo/5b6azuqmijfLchjBK54XSqyTa/iuerqkZKj19kVMdAX7bcmiql2dhjej
 iSgGS1/bbut67JT+y+pvAA+pQc6DQhhad9DqQKDmeyszxHyvp+KXYg/59Sg2bQ==
ARC-Seal: i=1; s=pharaoh; d=lmichel.fr; t=1601279523; a=rsa-sha256; cv=none;
 b=gmJYDd+6EW+ggEeBEED0vuGNVoxdHbATqGtUJX11yt4/ITTNmjrDCv9ydDM4c5eFkCpJnUct1kDTXL78hegxgBYVWQip6CS8qSdViQupdSe/+jN8n8/u2y62u+78zjodtZn+CyXU/s5ZvuuyOsfmDfqjJ/Fy49YxtgS70d5/dYqgSxgPCrrFy/YY+Nw7mw9ehJ1OClwul1rGABVMqnYXnDNCxU2czQ3l6+ef59x5w4C/1lhCVbIIFlv43T9xfGCoafMESt1+CUh72vz4HMkeiUcYcWj/7+547kN882EqG3oUgVkqkhrb2SyEqlSQMv598gUsrx6XV+xfFZ1GTtdFHg==
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=sekoia smtp.mailfrom=luc@lmichel.fr
Received-SPF: pass client-ip=149.202.28.74; envelope-from=luc@lmichel.fr;
 helo=pharaoh.lmichel.fr
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 03:49:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Havard Skinnemoen <hskinnemoen@google.com>, Tyrone Ting <kfting@nuvoton.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11:08 Sun 27 Sep     , Philippe Mathieu-Daudé wrote:
> Instead of directly aborting, display a hint to help the developer
> figure out the problem (likely trying to connect a clock to a device
> pre-dating the Clock API, thus not expecting clocks).
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Reviewed-by: Luc Michel <luc@lmichel.fr>

> ---
>  hw/core/qdev-clock.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/hw/core/qdev-clock.c b/hw/core/qdev-clock.c
> index 47ecb5b4fae..33bd4a9d520 100644
> --- a/hw/core/qdev-clock.c
> +++ b/hw/core/qdev-clock.c
> @@ -12,6 +12,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
>  #include "hw/qdev-clock.h"
>  #include "hw/qdev-core.h"
>  #include "qapi/error.h"
> @@ -153,6 +154,11 @@ Clock *qdev_get_clock_in(DeviceState *dev, const char *name)
>      assert(name);
>  
>      ncl = qdev_get_clocklist(dev, name);
> +    if (!ncl) {
> +        error_report("can not find clock-in '%s' for device type '%s'",
> +                     name, object_get_typename(OBJECT(dev)));
> +        abort();
> +    }
>      assert(!ncl->output);
>  
>      return ncl->clock;
> @@ -165,6 +171,11 @@ Clock *qdev_get_clock_out(DeviceState *dev, const char *name)
>      assert(name);
>  
>      ncl = qdev_get_clocklist(dev, name);
> +    if (!ncl) {
> +        error_report("can not find clock-out '%s' for device type '%s'",
> +                     name, object_get_typename(OBJECT(dev)));
> +        abort();
> +    }
>      assert(ncl->output);
>  
>      return ncl->clock;
> -- 
> 2.26.2
> 

