Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CABEC83004
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 07:41:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29C972073E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 07:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="fTFgwSqe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29C972073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jThLb-0006Jv-5i
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 03:41:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46776)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <luc.michel@greensocs.com>) id 1jTh6O-0007vG-Js
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:26:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <luc.michel@greensocs.com>) id 1jTh6H-00072K-Km
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:25:52 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:57170)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc.michel@greensocs.com>)
 id 1jTh4Q-0005bj-O7; Wed, 29 Apr 2020 03:23:50 -0400
Received: from [172.17.10.6] (unknown [172.17.10.6])
 by beetle.greensocs.com (Postfix) with ESMTPSA id 9AE0C96EF2;
 Wed, 29 Apr 2020 07:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1588145029;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RgZxt7m47Azwf4GwDjyuYY/Lnebn+TdybSEDtuCUIfg=;
 b=fTFgwSqe+rKtbFJbLmR/pNdiQxlB8PRXQCbNH30DPrdIaqL7j21l4eMAa1qfcK8R6hsqVz
 qhRuQTBwYJtXCJnvcuNYJ+pxYJtPtNF8HfskZfwqKoW6Ll/x8XMnv0mq+EJG68WKPflj2/
 711ZDaFZueSCkCVeDnsTsNh0ea2CuPs=
Subject: Re: [PATCH v1 02/11] hw/arm: versal: Move misplaced comment
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
References: <20200427181649.26851-1-edgar.iglesias@gmail.com>
 <20200427181649.26851-3-edgar.iglesias@gmail.com>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <43668463-c08d-533c-d296-5e5c1c877483@greensocs.com>
Date: Wed, 29 Apr 2020 09:23:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200427181649.26851-3-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1588145029;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RgZxt7m47Azwf4GwDjyuYY/Lnebn+TdybSEDtuCUIfg=;
 b=YHbqWQlJBnDfX8Fs6ygxa1hNozDh5+/pMYI52KB0QZU8wuA9L5F/k6fjIpMWF4f1VfJL73
 luQtvbfiXR3t5kWl9Le6JcBMWfSa602HEVqq/OdE6j8BpBHQ8DUc/2gMx1R/GKzCVoHMpo
 ioxOw4bv/u84sGcRwkDmn7Sl3KejLjs=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1588145029; a=rsa-sha256; cv=none;
 b=tQvGiAIrn3B9B9rHfjskBY7s0ZELb+VSNPwyJeaqlpz9aiOyfZhBMxI7XuVeiNsEz9MRFp
 e4juZ8T3sZ9vsm2sp05SaDMoLo6pI5AoZgoGpUHgSfD6eZ/PCv3oZBdNhEKYxUHopQ2ccr
 riO0dcGPS04yJmT6L3V0B7wUfBIQUJI=
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
> Move misplaced comment.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Luc Michel <luc.michel@greensocs.com>

> ---
>  hw/arm/xlnx-versal.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
> index c73b2fe755..cc696e44c0 100644
> --- a/hw/arm/xlnx-versal.c
> +++ b/hw/arm/xlnx-versal.c
> @@ -36,7 +36,6 @@ static void versal_create_apu_cpus(Versal *s)
>  
>          obj = object_new(XLNX_VERSAL_ACPU_TYPE);
>          if (!obj) {
> -            /* Secondary CPUs start in PSCI powered-down state */
>              error_report("Unable to create apu.cpu[%d] of type %s",
>                           i, XLNX_VERSAL_ACPU_TYPE);
>              exit(EXIT_FAILURE);
> @@ -49,6 +48,7 @@ static void versal_create_apu_cpus(Versal *s)
>          object_property_set_int(obj, s->cfg.psci_conduit,
>                                  "psci-conduit", &error_abort);
>          if (i) {
> +            /* Secondary CPUs start in PSCI powered-down state */
>              object_property_set_bool(obj, true,
>                                       "start-powered-off", &error_abort);
>          }
> 

