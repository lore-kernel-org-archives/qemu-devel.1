Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E62CBC3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 08:55:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB9C9215EA
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 08:55:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB9C9215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3GDQ-0008Jz-UO
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 04:55:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60407)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1i3GCm-0007qY-PO
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 04:54:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1i3GCl-0004sM-UJ
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 04:54:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59880)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1i3GCl-0004rq-OS
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 04:54:55 -0400
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B868A87633
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 08:54:54 +0000 (UTC)
Received: by mail-pg1-f200.google.com with SMTP id q1so1612594pgt.2
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 01:54:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=MV05PmXuqI6VTJEXNNiLb665+UFsPMcbnVHkKxcHxvw=;
 b=PEKYC68H8etI3aKUh9Qx1gT26AR6nUZA8umLan5PddUCfkfzBkPBppQK8BLKrZfJIe
 bbMMd5q6eEy44vDoMDI6eptdQWEEE6uYTGqjMa1tGl66WFkFkFLbh6hlzC2vzmgOo/VC
 Pjq3+OOjSpH/VQUuBZtwgXt78HS6vOUP8AgKgm2bGimy6KJGJgK0Py8t9XsPa3hhga3r
 qGSLu33FSedyAL2h0rrSbC4K4SdeML3JttDBD/Frgi3LCZwA5E1QRttlw3akpFdH5O99
 OnZBYvP+2nz28dV5o7wZ9hJY/X0aZofJxVSj+uh49/CTgWTDLZL7tOyUbF+HBXo0jvvv
 pPSw==
X-Gm-Message-State: APjAAAW7sj0I6IoHtwn7EgolHOrhdG4YjiRczuz4K1RHlD7wCv+6qbM7
 7NP/O2ehcj9gigLB0dvyZT/EStGRf6FyGoftD72V4XyCqGFTREAeb4+z9JNeFYzxu0ov7zrp5tJ
 L1lwHcKzZ2coKSgs=
X-Received: by 2002:a17:902:848c:: with SMTP id
 c12mr8671349plo.47.1567068894328; 
 Thu, 29 Aug 2019 01:54:54 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzmCR4breGRC20DfQyDvMzvPIUiR9Ay+vzD/WzFdFlxIJfpHL9WX9BxQuvKq3d2GyGe3moEnQ==
X-Received: by 2002:a17:902:848c:: with SMTP id
 c12mr8671340plo.47.1567068894133; 
 Thu, 29 Aug 2019 01:54:54 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id u18sm2208177pfl.29.2019.08.29.01.54.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2019 01:54:53 -0700 (PDT)
Date: Thu, 29 Aug 2019 16:54:42 +0800
From: Peter Xu <peterx@redhat.com>
To: Auger Eric <eric.auger@redhat.com>
Message-ID: <20190829085442.GI8729@xz-x1>
References: <20190812074531.28970-1-peterx@redhat.com>
 <319f1d6a-ef55-cc1b-98d6-f99b365bd88a@redhat.com>
 <e128decc-8b40-160e-fe8e-673682530750@redhat.com>
 <20190829011850.GC8729@xz-x1>
 <ba2df187-81cd-6dbb-992b-6ae9a7b35e37@redhat.com>
 <20190829082153.GH8729@xz-x1>
 <85b87150-9414-00e6-86a3-cf92f1ca6f7c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <85b87150-9414-00e6-86a3-cf92f1ca6f7c@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH RFC 0/4] intel_iommu: Do sanity check of
 vfio-pci earlier
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
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Bandan Das <bsd@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 29, 2019 at 10:46:42AM +0200, Auger Eric wrote:
> If I understand correctly PT mode is a bypass mode. With the ARM SMMUv3
> the IOMMU MR translate() function gets called but implements a direct
> mapping. I understand that on your side, you destroy the IOMMU MR, right?
> 
> At the moment since SMMUv3/VFIO integration is not ready I plan to
> forbid any usage of VFIO along with SMMUv3, whatever the enable state.
> 
> When HW nested paging gets ready, the stage1 bypass state will be
> propagated to the HW config structure.
> 
> Hope I answer your question.

Yes, nested page tables will be fine. :)

Thanks,

-- 
Peter Xu

