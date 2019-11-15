Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 481A7C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 20:23:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C32A20732
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 20:23:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="cxZf7QzX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C32A20732
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVi7t-00025i-22
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 15:23:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42745)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <luc.michel@greensocs.com>) id 1iVi55-000191-GJ
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 15:20:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <luc.michel@greensocs.com>) id 1iVi54-0001BU-Fh
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 15:20:35 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:38670)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <luc.michel@greensocs.com>)
 id 1iVi50-0000kN-Qs; Fri, 15 Nov 2019 15:20:31 -0500
Received: from [192.168.61.102] (lfbn-1-8165-82.w90-112.abo.wanadoo.fr
 [90.112.74.82])
 by beetle.greensocs.com (Postfix) with ESMTPSA id 5E4CD96EF0;
 Fri, 15 Nov 2019 20:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1573849226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hLDKuy7IB0iN0h9w41ICCOz6MrZwi9/YKDHpvVMqVKY=;
 b=cxZf7QzXivRd5SiWqpeEI0BMY1z1bIeJHtNMIAUyC1myFlsaoBsEt/xrjiQb8kj0kJQY8J
 OasTaiqCdceGEY1GQueqySCrahkWrT2PF9/UTe6GtlgmmzRz2o/po6j54jwReInKDT+bk0
 4HQoVuIBBHnm0IGTgB1lEX9jFJRqAdE=
Subject: Re: [PATCH v1 1/1] hw/arm: versal: Add the CRP as unimplemented
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
References: <20191115154734.26449-1-edgar.iglesias@gmail.com>
 <20191115154734.26449-2-edgar.iglesias@gmail.com>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <73da98ac-3635-c727-4fa7-d7d5e37a69f9@greensocs.com>
Date: Fri, 15 Nov 2019 21:20:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191115154734.26449-2-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-PH
Content-Transfer-Encoding: 7bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1573849226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hLDKuy7IB0iN0h9w41ICCOz6MrZwi9/YKDHpvVMqVKY=;
 b=OVHIqISRzhnNh85YJ20aT8ursqZEJmE7fNlZMWorgrzC7UkhynJvLbt/XdmUqicXJvbqJ/
 j2Jsxul98r3oD9dCbMyPVTujItayMX2pCaVtY/0mappFTczmzBn6xXl/BduXPXGuD92qU8
 VffU2blV1TDtawvrdLIqhbOTmBBBNOM=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1573849226; a=rsa-sha256; cv=none;
 b=X+ivAAQGOWf8T7y05RRHFzpxwp4dSvU2d3ExX66uM9ssb/cidOrBYTxhXORyVm2uSlTLYq
 HV3jUG5q/T5dwKS2AEEocxUPz0vfBwG5TsCT+JcWMC2Tz8h9uP/CEbenMkTmPvD3otcMZp
 OD5+MZtu/VUWMMmLZ1YkTCv6JsHP9rc=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=luc smtp.mailfrom=luc.michel@greensocs.com
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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

On 11/15/19 4:47 PM, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> 
> Add the CRP as unimplemented thus avoiding bus errors when
> guests access these registers.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Luc Michel <luc.michel@greensocs.com>


> ---
>  hw/arm/xlnx-versal.c         | 2 ++
>  include/hw/arm/xlnx-versal.h | 3 +++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
> index 98163eb1aa..8b3d8d85b8 100644
> --- a/hw/arm/xlnx-versal.c
> +++ b/hw/arm/xlnx-versal.c
> @@ -257,6 +257,8 @@ static void versal_unimp(Versal *s)
>                          MM_CRL, MM_CRL_SIZE);
>      versal_unimp_area(s, "crf", &s->mr_ps,
>                          MM_FPD_CRF, MM_FPD_CRF_SIZE);
> +    versal_unimp_area(s, "crp", &s->mr_ps,
> +                        MM_PMC_CRP, MM_PMC_CRP_SIZE);
>      versal_unimp_area(s, "iou-scntr", &s->mr_ps,
>                          MM_IOU_SCNTR, MM_IOU_SCNTR_SIZE);
>      versal_unimp_area(s, "iou-scntr-seucre", &s->mr_ps,
> diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
> index 14405c1465..d844c4ffe4 100644
> --- a/include/hw/arm/xlnx-versal.h
> +++ b/include/hw/arm/xlnx-versal.h
> @@ -119,4 +119,7 @@ typedef struct Versal {
>  #define MM_IOU_SCNTRS_SIZE          0x10000
>  #define MM_FPD_CRF                  0xfd1a0000U
>  #define MM_FPD_CRF_SIZE             0x140000
> +
> +#define MM_PMC_CRP                  0xf1260000U
> +#define MM_PMC_CRP_SIZE             0x10000
>  #endif
> 

