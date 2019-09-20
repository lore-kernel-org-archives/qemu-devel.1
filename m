Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C62C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 06:37:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DF2D2080F
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 06:37:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DF2D2080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBCY0-0005O6-Q5
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 02:37:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49790)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1iBCUA-0000dO-Cp
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 02:33:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1iBCDg-0002Cf-RQ
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 02:16:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47644)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1iBCDg-0002Bx-K5
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 02:16:40 -0400
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 61C4E4E919
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 06:16:39 +0000 (UTC)
Received: by mail-pf1-f198.google.com with SMTP id f2so3956164pfk.13
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 23:16:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=63eRVRiPaHYQAoA4Qw85V6AzIpWXz87aoXIxFk5UGjM=;
 b=ZQlifqMJvlXqJp2DOLFRbqrfZgGE7yxqN3eYdodMoSd0/jBqvTvirFS1ybX64DpZdx
 tbKv+411vfYj9wMmWNEj09wzOJbH3q5+brTEcChpc7oITZHq6D0YNsmlPe0zUvvOXvoL
 ytXgaSzFbgfHXYYy5alwVTFnWRf12UWFEG+ltiW+dRq9SqqGxAPyf+bRP/rFMXQkrSv7
 LrS9VgcHkBLbpmxpX9Kb/Uq1XO7spf2pOF7o79fY5QWNaz4JlKHfASNXn5xpXJ9rR3id
 EL7g7g2za0nfrZkgAOVpNFcw02+3777akjwOs469vDl+e8eS6Y5FLQe6XxiVMG+q0PNE
 VVOg==
X-Gm-Message-State: APjAAAVx9PlGu/VaBc/WFkG/yRsAunLxaPqgCf80xtWeGQqIsanKCiCO
 q3tBGE6Bxl16cUsFHxNq/MCLRUVbUoWjoDo3S6nOL+0VgI6qPg1sfHm/ujnQIjzmvTl3pCqKHm+
 egeR2PnGLhnJ7tHk=
X-Received: by 2002:a17:90a:28c5:: with SMTP id
 f63mr2693192pjd.67.1568960198693; 
 Thu, 19 Sep 2019 23:16:38 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzxbcnICr/V90GshTFflbxvsv8yjc+JZulY2XZALIJnD02YkooYpv7/slAOOWoOBICJPAb6kQ==
X-Received: by 2002:a17:90a:28c5:: with SMTP id
 f63mr2693166pjd.67.1568960198416; 
 Thu, 19 Sep 2019 23:16:38 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id v8sm1517528pje.6.2019.09.19.23.16.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2019 23:16:37 -0700 (PDT)
Date: Fri, 20 Sep 2019 14:16:28 +0800
From: Peter Xu <peterx@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v2 0/5] Allow memory_region_register_iommu_notifier() to
 fail
Message-ID: <20190920061628.GD12858@xz-x1>
References: <20190919121845.29520-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190919121845.29520-1-eric.auger@redhat.com>
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
Cc: peter.maydell@linaro.org, mst@redhat.com, qemu-devel@nongnu.org,
 alex.williamson@redhat.com, qemu-arm@nongnu.org, pbonzini@redhat.com,
 eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 19, 2019 at 02:18:40PM +0200, Eric Auger wrote:
> This series allows the memory_region_register_iommu_notifier()
> to fail. As of now, when a MAP notifier is attempted to be
> registered along with SMMUv3, Intel iommu without caching mode
> or AMD IOMMU, we exit in the IOMMU MR notify_flag_changed()
> callback. In case of VFIO assigned device hotplug, this could be
> handled more nicely directly within the VFIO code, simply rejecting
> the hotplug without exiting. This is what the series achieves
> by handling the memory_region_register_iommu_notifier() returned
> value.

Could I ask what's the code path for ARM when the hot plug failed?  Is
that vfio_realize() then vfio_connect_container() will fail with this?

    if (container->error) {
        ret = container->error;
        error_setg_errno(errp, -ret,
                         "memory listener initialization failed for container");
        goto listener_release_exit;
    }

If so, I would again suggest you to use Error** in patch 1.  IMHO we
can let vfio_listener_region_add() to be the first one to use the
Error** so that instead of this:

    /*
     * On the initfn path, store the first error in the container so we
     * can gracefully fail.  Runtime, there's not much we can do other
     * than throw a hardware error.
     */
    if (!container->initialized) {
        if (!container->error) {
            container->error = ret;
        }
    } else {
        hw_error("vfio: DMA mapping failed, unable to continue");
    }

We can also cache the Error** into container and return to user if the
user is using QMP which should be better than the int number (or
again, maybe return both errors?).  IIUC error_report() will not work
for QMP.

Regards,

-- 
Peter Xu

