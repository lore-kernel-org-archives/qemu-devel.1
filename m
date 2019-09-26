Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B957DC4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 08:48:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92D25222BE
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 08:48:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92D25222BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60917 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDPSF-0004UO-Lx
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 04:48:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47768)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iDPRK-0003iQ-Ex
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 04:47:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iDPRG-000296-JC
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 04:47:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48908)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iDPRG-00028D-DH
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 04:47:50 -0400
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 81AD581F0D
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 08:47:48 +0000 (UTC)
Received: by mail-qk1-f197.google.com with SMTP id s14so1664155qkg.12
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 01:47:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=qN8DKH0Qj9aTOxgZFOd+HotsB/I8m2mbDLUExkTjj6A=;
 b=pesfM/Y7t+9981uZaS9AKpHz064C0CrRXTd7fU6mciZhJ21DzFUZXCJfDg+KZG0QCB
 o8KwHlWymGTVr6+SNtI0weEMGFiQYlDjOUFTsIB8NVShqnhgOBL5D68FREHZlYZpz8Xs
 efnQwx3O+UMnl5QgZyhW/Ke9TXRPi9LdLXyGLiJojS1nPsy3RiWx5vK0atjLWGT5FMP1
 MNGjB9vZKeLnXNZbvPtpJAS0Jt6SbwLOuSZEqPFxmcbxu0kMoLcAVT7WKw7uzlBzjwz4
 W1RRZ+iza7V2hhW2DCtyuPi/mXKWmG10hAqh3OgdbOHTbJuI/TcINy1b/kjKu+0EZx7s
 NjXw==
X-Gm-Message-State: APjAAAUkmy0GiotP7fRYiamKOioeb/tdm8Pqb2V9s2DqiLiuSeOKTSty
 XYdAdJVc0HeXTRVS9zBc+JnZQ6iruFOxHmNem+WlPUcKgnvswFO7DIpvwG9hOtQmtofBEl4sKk+
 KdvQ4IVVRdw/JZSw=
X-Received: by 2002:ac8:65c5:: with SMTP id t5mr2658024qto.217.1569487667886; 
 Thu, 26 Sep 2019 01:47:47 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy5KlEzlFo8B34rztYktxG2RCKivLSfZFiiJvq6mpwly4I9cgN3Ljyx6pResMNdDIDw2Pbj0w==
X-Received: by 2002:ac8:65c5:: with SMTP id t5mr2657964qto.217.1569487666752; 
 Thu, 26 Sep 2019 01:47:46 -0700 (PDT)
Received: from redhat.com (bzq-79-176-40-226.red.bezeqint.net. [79.176.40.226])
 by smtp.gmail.com with ESMTPSA id x15sm634641qkh.44.2019.09.26.01.47.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2019 01:47:45 -0700 (PDT)
Date: Thu, 26 Sep 2019 04:47:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qi1.zhang@intel.com
Subject: Re: [PATCH] intel_iommu: TM field should not be in reserved bits
Message-ID: <20190926044114-mutt-send-email-mst@kernel.org>
References: <20190926054922.21110-1-qi1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190926054922.21110-1-qi1.zhang@intel.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: pbonzini@redhat.com, ehabkost@redhat.com, qemu-devel@nongnu.org,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 26, 2019 at 01:49:22PM +0800, qi1.zhang@intel.com wrote:
> From: "Zhang, Qi" <qi1.zhang@intel.com>
> 
> When dt is supported, TM field should not be Reserved(0).
> 
> Refer to VT-d Spec 9.8
> 
> Signed-off-by: Zhang, Qi <qi1.zhang@intel.com>
> Signed-off-by: Qi, Yadong <yadong.qi@intel.com>
> ---
>  hw/i386/intel_iommu.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index f1de8fdb75..2696ceeb9d 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -3567,6 +3567,13 @@ static void vtd_init(IntelIOMMUState *s)
>  
>      if (x86_iommu->dt_supported) {
>          s->ecap |= VTD_ECAP_DT;
> +        vtd_paging_entry_rsvd_field[1] &= ~(1ULL << 62);
> +        vtd_paging_entry_rsvd_field[2] &= ~(1ULL << 62);
> +        vtd_paging_entry_rsvd_field[3] &= ~(1ULL << 62);
> +
> +        vtd_paging_entry_rsvd_field[5] &= ~(1ULL << 62);
> +        vtd_paging_entry_rsvd_field[6] &= ~(1ULL << 62);
> +        vtd_paging_entry_rsvd_field[7] &= ~(1ULL << 62);

Add a macro for this value, please.


And I think it's cleaner to pass dt_supported flag
to VTD_SPTE_PAGE_LX_RSVD_MASK and VTD_SPTE_LPAGE_LX_RSVD_MASK,
rather than set bits then clear them selectively.

>      }
>  
>      if (x86_iommu->pt_supported) {
> -- 
> 2.20.1

