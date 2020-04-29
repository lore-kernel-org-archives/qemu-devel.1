Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E715C83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 07:43:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 198CD2073E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 07:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="nIBucYNt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 198CD2073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jThNO-00017X-3i
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 03:43:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46780)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <luc.michel@greensocs.com>) id 1jTh6P-0007wo-8V
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:26:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <luc.michel@greensocs.com>) id 1jTh6I-00072X-Hk
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:25:53 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:57218)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc.michel@greensocs.com>)
 id 1jTh4g-0005qP-SO; Wed, 29 Apr 2020 03:24:07 -0400
Received: from [172.17.10.6] (unknown [172.17.10.6])
 by beetle.greensocs.com (Postfix) with ESMTPSA id 95B9B96EF0;
 Wed, 29 Apr 2020 07:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1588145045;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bOgs9kyXuKIPIY6xlyzW6jDHgzVYxzpJBIaGKE7baNA=;
 b=nIBucYNty+JF3NETX+/KuXoqNg3zLFoc2xrwypR6ECxVq4nHmrlYbR92l3+OK6dYp4q8es
 6HnRQU/+Giu0txnL5ZHKU9iszWU5VLHip8Jfn9JMKTUwEWgxd0+eU/3EGipsD8hg2VASZt
 HwYi5KP0Q6r25YsTNB3tvAAvZF9qdhI=
Subject: Re: [PATCH v1 03/11] hw/arm: versal-virt: Fix typo xlnx-ve ->
 xlnx-versal
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
References: <20200427181649.26851-1-edgar.iglesias@gmail.com>
 <20200427181649.26851-4-edgar.iglesias@gmail.com>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <f8845f34-9787-20e5-f18a-6495e90cb039@greensocs.com>
Date: Wed, 29 Apr 2020 09:24:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200427181649.26851-4-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1588145045;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bOgs9kyXuKIPIY6xlyzW6jDHgzVYxzpJBIaGKE7baNA=;
 b=nXyJU9n2niq0V5ikg12CnuL3BIkc0i5r9BsK6V5kMrU4+MfUcrCEGxhR7qnOEn5hBDGkPv
 XBY6s1Zi8XSi6IYsatTmRSYeOswI9n6Ppnppg5JdT+cp5iPKHyBhRs/XzyMCdBSHDSYb9c
 4GY9BXpVfHeFg/BsKw5HHsBCjyhDpsY=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1588145045; a=rsa-sha256; cv=none;
 b=Iarq3kFi6txJBwIwGphkGb0b57tebmGaVuhqjLmlVFa249viTcFeTyYjqFLVhCXzNYSTQh
 airN1/WEhTT6NfQTz+gIweDq+NtkWe8QsVBNsye7eCbHMBUlUWyUyU+ws5DfgVlaBiYUQh
 Dv/OuvplzGXxG6cL94cFgAw04ByPx9k=
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
> Fix typo xlnx-ve -> xlnx-versal.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Luc Michel <luc.michel@greensocs.com>

> ---
>  hw/arm/xlnx-versal-virt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
> index 878a275140..8a608074d1 100644
> --- a/hw/arm/xlnx-versal-virt.c
> +++ b/hw/arm/xlnx-versal-virt.c
> @@ -440,7 +440,7 @@ static void versal_virt_init(MachineState *machine)
>          psci_conduit = QEMU_PSCI_CONDUIT_SMC;
>      }
>  
> -    sysbus_init_child_obj(OBJECT(machine), "xlnx-ve", &s->soc,
> +    sysbus_init_child_obj(OBJECT(machine), "xlnx-versal", &s->soc,
>                            sizeof(s->soc), TYPE_XLNX_VERSAL);
>      object_property_set_link(OBJECT(&s->soc), OBJECT(machine->ram),
>                               "ddr", &error_abort);
> 

