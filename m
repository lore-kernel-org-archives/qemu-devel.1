Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FBE1C3A5A6
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 08:01:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73A6120820
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 08:01:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73A6120820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCJHH-00081H-IO
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 04:00:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41411)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1iCJG4-0007ND-P0
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 03:59:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1iCJG3-0008Q7-R2
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 03:59:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33401)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1iCJG3-0008PI-L9
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 03:59:43 -0400
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AAB9718C37B
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 07:59:42 +0000 (UTC)
Received: by mail-pl1-f199.google.com with SMTP id o12so2438754pll.2
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 00:59:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=STs5zoSMg2ih7wnHezf5iWfAFg85hVUiEa5wtjeZ3/c=;
 b=CTCE/fe7DUfScw2bPkSzWNL2JT4fqz18Xo/3WQQDVC3OFfOfh3A6UBBkNcJ/v/EzJ8
 xTSzS+zLnuUhVsesZwUO5SInFCAKVznK7pFLrL9ps2/Kj3Fc12i+XvnyVCkK7itmntF7
 Dnb9X2fQw5pzIyc9eTcZUn7olv7rtekUg1K6dLThIpWM6btNro0z8Ej24ySPUyrEvdm8
 J/qgrd+hc7NccwqtPlSR3B33/4Hjg7KPzD93HTfpuaxYPPaJexHz/6+mXLJeZz/bmo+o
 z6jZ6eEwS6FVx4MU62o9yOQ55GRsjlFvOOrB7yTKOmmXkRz1KroZi9KPGy9XyyZSWbQb
 EUbg==
X-Gm-Message-State: APjAAAV83aUjRK3ZUXRNyT+O9JiV47VJO4wtD2ILFsPkMyFWib2ZbLDP
 W/pbKvxffPKJblcjL/1qa/sYFjTwmno/L/zbW471iRlcu1WD/n/7axs/JGMDp69aTI+dwHsiONZ
 S/hDqZy3Wr2YvN5w=
X-Received: by 2002:a17:902:ba82:: with SMTP id
 k2mr29660405pls.293.1569225582232; 
 Mon, 23 Sep 2019 00:59:42 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxL0OpduzCPCZVfpT5gDQejK1D4xih8U7IgYQ8G8s81GaYF99LqsLHk0CHrvXDbvIc4M/RLuw==
X-Received: by 2002:a17:902:ba82:: with SMTP id
 k2mr29660394pls.293.1569225582090; 
 Mon, 23 Sep 2019 00:59:42 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id x68sm15170085pfd.183.2019.09.23.00.59.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Sep 2019 00:59:41 -0700 (PDT)
Date: Mon, 23 Sep 2019 15:59:30 +0800
From: Peter Xu <peterx@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v3 2/2] memory: allow
 memory_region_register_iommu_notifier() to fail
Message-ID: <20190923075930.GB12806@xz-x1>
References: <20190923065552.10602-1-eric.auger@redhat.com>
 <20190923065552.10602-3-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190923065552.10602-3-eric.auger@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: peter.maydell@linaro.org, mst@redhat.com, aik@ozlabs.ru,
 qemu-devel@nongnu.org, alex.williamson@redhat.com, qemu-arm@nongnu.org,
 pbonzini@redhat.com, david@gibson.dropbear.id.au, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Sep 23, 2019 at 08:55:52AM +0200, Eric Auger wrote:
> Currently, when a notifier is attempted to be registered and its
> flags are not supported (especially the MAP one) by the IOMMU MR,
> we generally abruptly exit in the IOMMU code. The failure could be
> handled more nicely in the caller and especially in the VFIO code.
> 
> So let's allow memory_region_register_iommu_notifier() to fail as
> well as notify_flag_changed() callback.
> 
> All sites implementing the callback are updated. This patch does
> not yet remove the exit(1) in the amd_iommu code.
> 
> in SMMUv3 we turn the warning message into an error message saying
> that the assigned device would not work properly.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

