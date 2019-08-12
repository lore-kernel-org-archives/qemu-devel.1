Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F239C433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 09:02:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 521E82070C
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 09:02:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 521E82070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hx6DR-0008UA-EE
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 05:02:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37521)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hx6D0-0007rz-Jb
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 05:01:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hx6Cz-00051O-Da
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 05:01:42 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34667)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hx6Cz-0004vv-6u
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 05:01:41 -0400
Received: by mail-wr1-f65.google.com with SMTP id 31so103918369wrm.1
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2019 02:01:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TaXRPuHHEEX+13u7pWR/SCClrWUXFr+XPxLkaWDlzFc=;
 b=iXW1bVJVTP7h601ku78D20B6QpW+tT0gyVpEDQVWAZ6V3WSGI7EUBzgWlTsVxuBuQ0
 3WIVnk2dzqHljmBjmexQcPeQnjx5P1X90bCdNV5GwJuVmzQhuW5YfHA0IwqSAfElO+N2
 UrDgx2yKgffiR2v4rLFVkIb6UxesapaK6pvTKz8rGqoOeLBiznXhB75WBPoP7/EGuhQT
 DNTWZKJ5SMS5Oz4ejkfuyB4n2FnWr399VU3BxzuRZYDVP2tW8/v8l9exeByqYqkPq/RX
 xwRMjRLMo7V5cyBts/Q3Sgc6WnK+I6T0bSn4eGWu8wLHFlIT7Uvn6t9H77JNICl6tqKc
 ykJQ==
X-Gm-Message-State: APjAAAXD+2fQjO3YVrwsDrs2ZyjPOFHEirTOSq1y0bUPYncLcavZMLDq
 2LVbYIfDo/1l3BUNTl83uSGGww==
X-Google-Smtp-Source: APXvYqzambSz+GGlDTKf0YEJhdRoe0M+juN2sQkF1LOkEj9ZW30Opitb2Uy/OJLs/XUqmWN1A1ZH6g==
X-Received: by 2002:a5d:50d1:: with SMTP id f17mr37057615wrt.124.1565600491579; 
 Mon, 12 Aug 2019 02:01:31 -0700 (PDT)
Received: from [192.168.1.37] (225.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.225])
 by smtp.gmail.com with ESMTPSA id g26sm1234379wmh.32.2019.08.12.02.01.26
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 12 Aug 2019 02:01:30 -0700 (PDT)
To: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org
References: <20190812054202.125492-1-aik@ozlabs.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <2c36b78c-cec9-4122-86a3-d9f4ef762583@redhat.com>
Date: Mon, 12 Aug 2019 11:01:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190812054202.125492-1-aik@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH qemu] spapr_iommu: Fix xlate trace to print
 translated address
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
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Alexey,

On 8/12/19 7:42 AM, Alexey Kardashevskiy wrote:
> Currently we basically print IO address twice, fix this.
> 
> Fixes: 7e472264e9e2 ("PPC: spapr: iommu: rework traces")
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  hw/ppc/spapr_iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
> index bd3d0256a65d..6fe57d799a10 100644
> --- a/hw/ppc/spapr_iommu.c
> +++ b/hw/ppc/spapr_iommu.c
> @@ -137,7 +137,7 @@ static IOMMUTLBEntry spapr_tce_translate_iommu(IOMMUMemoryRegion *iommu,
>          ret.addr_mask = ~page_mask;
>          ret.perm = spapr_tce_iommu_access_flags(tce);
>      }
> -    trace_spapr_iommu_xlate(tcet->liobn, addr, ret.iova, ret.perm,
> +    trace_spapr_iommu_xlate(tcet->liobn, addr, ret.translated_addr, ret.perm,
>                              ret.addr_mask);

But the trace format is:

spapr_iommu_xlate(uint64_t liobn, uint64_t ioba, uint64_t tce, unsigned
perm, unsigned pgsize) "liobn=%"PRIx64" 0x%"PRIx64" -> 0x%"PRIx64"
perm=%u mask=%x"

So this could be more appropriate:

  trace_spapr_iommu_xlate(tcet->liobn, ret.iova, ret.translated_addr,
                          ret.perm, ret.addr_mask);

Anyhow your patch is an improvment, so regardless addr/ret.iova:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>  
>      return ret;
> 

