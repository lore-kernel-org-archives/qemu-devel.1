Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC74C4CEC4
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 03:24:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65A0E20873
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 03:24:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65A0E20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9hcs-0004JE-8B
	for qemu-devel@archiver.kernel.org; Sun, 15 Sep 2019 23:24:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56542)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1i9hc5-0003lF-VX
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 23:23:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1i9hc3-0007D7-Uk
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 23:23:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42574)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1i9hc3-0007CS-Q7
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 23:23:39 -0400
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5991389AC6
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 03:23:38 +0000 (UTC)
Received: by mail-pg1-f200.google.com with SMTP id h3so21328554pgc.19
 for <qemu-devel@nongnu.org>; Sun, 15 Sep 2019 20:23:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=2XDUy8E1GJifRRBWG0PiBc3aS6Rj85Jdad7JsonkhwQ=;
 b=nEzl32bwJq9smqGvZai2CYXztgZ1uLv3OgC1UBVwYRJCOPPlrRtNNUjgu3F1UdbQMC
 8ZebCsy0kSu0tYMxoE1m/LrA+zfvT/cKzX1rHZLNc62b+HJAjdrxNBt6hrgsKToS2may
 rJYJunfav5jpNsi+xER9e7eBWOkScQKrXCz2QTj8UfyzsBtr3T293FuxIILaBHAcKJKV
 pha+SIBf5WXAxfIbk3G/hCvFgNSEStxYTNX8EQ3PtWNhDMY0Ve7ZnRVzy2gMDDOJUyLL
 7iBrHtknXAPCJlYsjKjLz9quUCGN8jGjo38G+MwIKGFPMrtY0xwv4E2CJmPawnjQ1UKt
 texA==
X-Gm-Message-State: APjAAAXlHDQSLqn4L1W6sRFZoKsQCJ5YGX4G3t1MUKcaEa/39TcoPgEm
 3c1qyJKSr62yxdZoICXnrZ5FBD/96EU/u1WnvObyYMOrY1WFqB3gNYCw79YfoqQcl0UpPvyh8pB
 y4OFosmhHmfPK4Gs=
X-Received: by 2002:a65:47c1:: with SMTP id f1mr52945672pgs.169.1568604217827; 
 Sun, 15 Sep 2019 20:23:37 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxVdk/IvYfzBvrRmEOvuIsyrgI+Mkxy/Ozny+QQq6jiLqDRIuZbkAus816w4pTjcTatQ+7IMQ==
X-Received: by 2002:a65:47c1:: with SMTP id f1mr52945648pgs.169.1568604217469; 
 Sun, 15 Sep 2019 20:23:37 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id r186sm32283212pfr.40.2019.09.15.20.23.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Sep 2019 20:23:36 -0700 (PDT)
Date: Mon, 16 Sep 2019 11:23:27 +0800
From: Peter Xu <peterx@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Message-ID: <20190916032326.GC14232@xz-x1>
References: <20190913083615.14719-1-eric.auger@redhat.com>
 <20190913083615.14719-2-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190913083615.14719-2-eric.auger@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v1 1/6] memory: allow
 memory_region_register_iommu_notifier() to fail
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

On Fri, Sep 13, 2019 at 10:36:10AM +0200, Eric Auger wrote:
> Currently, when a notifier is attempted to be registered and its
> flags are not supported (especially the MAP one) by the IOMMU MR,
> we generally abruptly exit in the IOMMU code. The failure could be
> handled more nicely in the caller and especially in the VFIO code.
> 
> So let's allow memory_region_register_iommu_notifier() to fail as
> well as notify_flag_changed() callback.
> 
> All sites implementing the callback are updated. This patch does
> not yet remove the exit(1) in the intel_iommu and amd_iommu code.

The idea looks sane to me, though how about using "Error **" instead
of returning int (or, both)?  Just like the majority of rest of QEMU.

Regards,

-- 
Peter Xu

