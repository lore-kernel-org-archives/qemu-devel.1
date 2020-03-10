Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF446C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 17:54:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACA8F21927
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 17:54:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c7PivQKE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACA8F21927
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBj5N-0001eb-Qb
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 13:54:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37936)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jBj4f-0001DR-Et
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 13:53:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jBj4d-0001a7-Ra
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 13:53:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37278
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jBj4d-0001WS-Ng
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 13:53:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583862826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5i+9BmQW2HnWTZtXIfDBeNaFzeAC80VRIaZM2+zrlFQ=;
 b=c7PivQKEYiLHp6fxnSLfyzl6fSCfUBWBxBfTp9oSlEKp+0tWPqm17m2BbO1BzUVD7JiRj8
 +F0ZytydvkwBOn9BzdWqQBSwGVgV3Av/gEkxetXj/LL3UI44sxLVXjzrAwr6UKxe/sTBtM
 i/GihyBNlTIHV8xgZIJmKc4bsbR1eD8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-F5BQ6mBcNz2nqzL4uL_X_w-1; Tue, 10 Mar 2020 13:53:45 -0400
X-MC-Unique: F5BQ6mBcNz2nqzL4uL_X_w-1
Received: by mail-wm1-f71.google.com with SMTP id d129so679927wmd.2
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 10:53:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5i+9BmQW2HnWTZtXIfDBeNaFzeAC80VRIaZM2+zrlFQ=;
 b=TJYVO1B1xVcwsyau67QJZj3R6L0IUa79iguKqK5TKleRyDcXTZ68xL5ijtFKLERoGd
 YA91rvnfkTbLlqJOIY82UueeNlOJeT8KQ5NAhZZOigTWqngoGsnpJ2yAQFFacXvQEWt4
 GzwLBk5NDTiXNndZpHgF8msrWhnlQybP3rE+PSZiYa3kI3/4Ncs6Agqk+LSG6BxelbbD
 f2CunYtJlw8gSq3rxq6I/jtRICpr81n4cWGH6JEkxmfPwbYyoDWO016n4aSU0SckaPUK
 JcL3WKYlE7W5KkJPWyHVQuFCWArTGheoTqmBpSnPCV8RhO8DFu9t17pXZaNtF+VC8MGf
 Ks4g==
X-Gm-Message-State: ANhLgQ1uP/DtUuCsUkTNMZtL8qWJSgko93nI+wF6bLSGIoPVkcBAAMef
 Wy6Xc/wW4zXVgsyCppho+HnuR8kuUbvnouRlyW3xrVSVrHOH3L4jZAlWSbhTUbw1L1wRck12OaH
 8boMBNN+XlpaLvos=
X-Received: by 2002:adf:9364:: with SMTP id 91mr22428121wro.223.1583862823840; 
 Tue, 10 Mar 2020 10:53:43 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsCmyFe3lPXVb1D7qy7HLLRIy2lvOzEQxZzBieR4r6s4sTRrBczJ3Bn+/PgMpl7s9K2FOpRiQ==
X-Received: by 2002:adf:9364:: with SMTP id 91mr22428111wro.223.1583862823617; 
 Tue, 10 Mar 2020 10:53:43 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:f1b5:9f9:3125:2a5a?
 ([2001:b07:6468:f312:f1b5:9f9:3125:2a5a])
 by smtp.gmail.com with ESMTPSA id f6sm4794739wmh.29.2020.03.10.10.53.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Mar 2020 10:53:43 -0700 (PDT)
Subject: Re: [PATCH] hw/i386/intel_iommu: Fix out-of-bounds access on guest IRT
To: Jan Kiszka <jan.kiszka@siemens.com>, Peter Xu <peterx@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
References: <4b15b728-bdfe-3bbe-3a5c-ca3baeef3c5c@siemens.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <93446379-400a-8ed1-f0bb-648dfe97c3ba@redhat.com>
Date: Tue, 10 Mar 2020 18:53:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <4b15b728-bdfe-3bbe-3a5c-ca3baeef3c5c@siemens.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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

On 10/03/20 18:42, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> vtd_irte_get failed to check the index against the configured table
> size, causing an out-of-bounds access on guest memory and potentially
> misinterpreting the result.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
> 
> BTW, we still miss error reporting emulation, right? Therefore, I added 
> that simple error_report_once thing, like the other paths do.
> 
>  hw/i386/intel_iommu.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 204b6841ec..df7ad254ac 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -3094,6 +3094,12 @@ static int vtd_irte_get(IntelIOMMUState *iommu, uint16_t index,
>      uint16_t mask, source_id;
>      uint8_t bus, bus_max, bus_min;
>  
> +    if (index >= iommu->intr_size) {
> +        error_report_once("%s: index too large: ind=0x%x",
> +                          __func__, index);
> +        return -VTD_FR_IR_INDEX_OVER;
> +    }
> +
>      addr = iommu->intr_root + index * sizeof(*entry);
>      if (dma_memory_read(&address_space_memory, addr, entry,
>                          sizeof(*entry))) {
> 

Queued, thanks.

Paolo


