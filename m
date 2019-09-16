Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B602AC4CEC4
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 03:34:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87315206C2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 03:34:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87315206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9hmB-0006C7-PF
	for qemu-devel@archiver.kernel.org; Sun, 15 Sep 2019 23:34:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57078)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1i9hlU-0005mk-0q
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 23:33:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1i9hlS-0002se-3m
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 23:33:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43824)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1i9hlQ-0002rq-FN
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 23:33:21 -0400
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 69B69C059758
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 03:33:19 +0000 (UTC)
Received: by mail-pg1-f197.google.com with SMTP id w5so21334596pgs.5
 for <qemu-devel@nongnu.org>; Sun, 15 Sep 2019 20:33:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=4MI/XiD/cEoNossYaCLoezLIzha76O6A/TVJCv/RTPg=;
 b=KVDt9U/47BOpeMUSubDWL18MYPBa3FUATELv6b9rpwkv3eCZP+HCqkMVcmzFlSTmVH
 qpp7M4TDnDVQDQQ3VCKzupKA493/p2k3XgZPiUx0nKqiHJgLxRbn7zEzNew/6IwPU6Gl
 ixpXgs+tdZilgukqOwC6ZBXJFiWJscGZo0Oq9t1oFS7y0UwXFxwosEPQ/u3ayaH6UhpN
 KZxCU5kqESDxUKOOWa5OJcRWC/nskZjAXwVZGS5Nt17eZCttQeXafBeyxdLdTHLGPp8m
 6uQ2i6YC2gWc5nR5lW6lGoe6sOxxdk2k15b9KH+c5MOlmLaq0cqT9fRj1n5x+9lEloXF
 Qb8g==
X-Gm-Message-State: APjAAAUOoC/ATm4jI4tJQQDP8WcrDhuPX+LZ/Hjjhn645EJhx0VfFy2I
 VjWEnW+9gKXtegXGsb+7f0dehfcbqdFIDFPDFhUHGMAsaEetoYLoP5Mxvj6L5xVYf1sov5rtBlR
 MiPmxyz5rPr9wLrg=
X-Received: by 2002:a63:5b23:: with SMTP id p35mr53183808pgb.366.1568604798823; 
 Sun, 15 Sep 2019 20:33:18 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxv/xsreg9PfwKYjp1l1+XzaFoudVLPbUAqQ55/zMHYFCTOhEeO1OY2DOEQdsQRh1qShpho1g==
X-Received: by 2002:a63:5b23:: with SMTP id p35mr53183791pgb.366.1568604798532; 
 Sun, 15 Sep 2019 20:33:18 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id z20sm6636599pfj.156.2019.09.15.20.33.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Sep 2019 20:33:17 -0700 (PDT)
Date: Mon, 16 Sep 2019 11:33:08 +0800
From: Peter Xu <peterx@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Message-ID: <20190916033308.GD14232@xz-x1>
References: <20190913083615.14719-1-eric.auger@redhat.com>
 <20190913083615.14719-6-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190913083615.14719-6-eric.auger@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v1 5/6] intel_iommu: Let
 vtd_iommu_notify_flag_changed() fail
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
Cc: peter.maydell@linaro.org, mst@redhat.com, qemu-devel@nongnu.org,
 alex.williamson@redhat.com, qemu-arm@nongnu.org, pbonzini@redhat.com,
 eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 13, 2019 at 10:36:14AM +0200, Eric Auger wrote:
> In case a MAP notifier is attempted to be registered without
> caching mode, let's simply return an error. This latter now is
> handled in the VFIO code.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  hw/i386/intel_iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 7a89ea9ba1..2f66d6882c 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -2931,7 +2931,7 @@ static int vtd_iommu_notify_flag_changed(IOMMUMemoryRegion *iommu,
>      if (!s->caching_mode && new & IOMMU_NOTIFIER_MAP) {
>          error_report("We need to set caching-mode=on for intel-iommu to enable "
>                       "device assignment with IOMMU protection.");
> -        exit(1);
> +        return -EINVAL;

This might be conflicting with the other series because that's going
to drop these lines:

https://lists.gnu.org/archive/html/qemu-devel/2019-08/msg01968.html

Though current change looks ok to me, and I don't even know which one
will reach master earlier after all so let's see. :)

The rest patches besides patch 1 all look sane to me. If we're going
to have "Error **" then the rest patches might need trivial touch-ups
of course.  And, IMHO squashing the whole series into patch 1 could be
better, but it's a personal preference only.

Thanks,

-- 
Peter Xu

