Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA09C83007
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 07:49:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A66120787
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 07:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="wQBkJ2+S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A66120787
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jThSh-0006kQ-W5
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 03:48:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46766)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <luc.michel@greensocs.com>) id 1jTh6L-0007nS-AT
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:25:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <luc.michel@greensocs.com>) id 1jTh6A-0006zJ-81
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:25:49 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:57134)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc.michel@greensocs.com>)
 id 1jTh4E-0005aO-KV; Wed, 29 Apr 2020 03:23:39 -0400
Received: from [172.17.10.6] (unknown [172.17.10.6])
 by beetle.greensocs.com (Postfix) with ESMTPSA id 332E296EF0;
 Wed, 29 Apr 2020 07:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1588145014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fMd+4wIDhy4VuieueBBhVTrXprknNqYism8E1D6RAps=;
 b=wQBkJ2+SZAa3PqcPyAHgYoUmp3zySTJBmJ4rc9BmMG0usdP68Mz6poW9E2sN5x317khjVz
 +lOpwJrQC0lPq6qPjhXLrkeO9ScxaUt71f/moGatZXCgvM1IsG8KYoDcdHa4Bqte1X7LF7
 Urnkb28b9VgQI2/K69caCthSkHWQqps=
Subject: Re: [PATCH v1 01/11] hw/arm: versal: Remove inclusion of
 arm_gicv3_common.h
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
References: <20200427181649.26851-1-edgar.iglesias@gmail.com>
 <20200427181649.26851-2-edgar.iglesias@gmail.com>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <14ed00d6-6a40-bcfa-0c06-984016adff29@greensocs.com>
Date: Wed, 29 Apr 2020 09:23:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200427181649.26851-2-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1588145015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fMd+4wIDhy4VuieueBBhVTrXprknNqYism8E1D6RAps=;
 b=Fg0N6L9hikB2+glswoO9SSrnx/SepaSrg9WRgLrz+vQ+8ErXeKsQUkQPHKyiT80W2naR3D
 4w/Fb5DkGbaq6Ly9RRbsaMQXi72eR+36DMlOhtUzhY9RXQWuWqtG+FZBbzulTNaj5+2gml
 40bUMNTS27GBSje8rgC/dDxGybQhi7s=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1588145015; a=rsa-sha256; cv=none;
 b=SxtpqkkfFMSeuDtZIwowVIRFa4rYTjGEDXeoQ4Ds6Dn4lpu7AUtxRCgcptF0Kx9APVGsWn
 VUWV0icpcEZUiHVVcgWoVlRdt5GXn8ZwEWwKb0HxLiAvxrbNvKfSzqDWhUyo6eEUQuoHZs
 3gaep07zww+IXnQS40sZM7GGbHK9sP0=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=luc smtp.mailfrom=luc.michel@greensocs.com
Received-SPF: pass client-ip=5.135.226.135;
 envelope-from=luc.michel@greensocs.com; helo=beetle.greensocs.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 03:23:35
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Received-From: 5.135.226.135
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
Cc: figlesia@xilinx.com, peter.maydell@linaro.org, sstabellini@kernel.org,
 edgar.iglesias@xilinx.com, sai.pavan.boddu@xilinx.com,
 frasse.iglesias@gmail.com, alistair@alistair23.me,
 richard.henderson@linaro.org, frederic.konrad@adacore.com, qemu-arm@nongnu.org,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/27/20 8:16 PM, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> 
> Remove inclusion of arm_gicv3_common.h, this already gets
> included via xlnx-versal.h.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Luc Michel <luc.michel@greensocs.com>

> ---
>  hw/arm/xlnx-versal.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
> index 94460f2343..c73b2fe755 100644
> --- a/hw/arm/xlnx-versal.c
> +++ b/hw/arm/xlnx-versal.c
> @@ -20,7 +20,6 @@
>  #include "hw/arm/boot.h"
>  #include "kvm_arm.h"
>  #include "hw/misc/unimp.h"
> -#include "hw/intc/arm_gicv3_common.h"
>  #include "hw/arm/xlnx-versal.h"
>  #include "hw/char/pl011.h"
>  
> 

