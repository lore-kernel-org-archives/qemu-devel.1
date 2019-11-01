Return-Path: <SRS0=V8KP=YZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E668CA9ECF
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 15:00:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0219620650
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 15:00:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0219620650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQYPC-0006jk-6h
	for qemu-devel@archiver.kernel.org; Fri, 01 Nov 2019 11:00:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44775)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1iQYO7-0005mf-Fx
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 10:58:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1iQYO5-00039L-Jc
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 10:58:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41532)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1iQYO5-000353-B9
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 10:58:53 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7910EC05B000
 for <qemu-devel@nongnu.org>; Fri,  1 Nov 2019 14:58:52 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id z9so5638425wrq.11
 for <qemu-devel@nongnu.org>; Fri, 01 Nov 2019 07:58:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=u2CxMAivUe7dZm3320bhIQ9Xyr/AwoYRD0bvKrh5Kn4=;
 b=b+L9ItoSE/qKxcBKCTT7VV1W6hMPqQS+zxp+7WDNL7x6V8BqzER2vurf6CPSBRAt/I
 2TZKscVHYoQYiHIQ84H46uFE0ugChhsCHatHkHMCV/aigRbpd38GWsBBqbSew1rjZszD
 3v3MXtp7Odg0jKihRaE7i1+SURgyNihi9f5vmyA4D5hrM/DwxtXWaGRdsbDz5SgDQV/v
 MzBxqfzGRqbTptkgRk0GEYYotT3WyVYI4WTM9YQD8I/+oKAi+VqIp2kiJi9LZ2ObpNEl
 yHYKV/kJl6elHH765NZ9bjqoDuo/Zke2h6/sR/UMVP2FiDLWPbuX6l7vQMGpPninKgiO
 g0AQ==
X-Gm-Message-State: APjAAAX/2QuvNNjJD7DuSo3QWliwhNVm7ZMZjZaDxVVOO1Wfz0EgJohf
 sokOQh0E4AMUV3xgGLXbyQ4zyVxhAdzHB8tmozgLKnQ98h+GZbYtibfykPnLAE36ENrsLNy+aZa
 LrZ0x17rhGgjq2wY=
X-Received: by 2002:a5d:5282:: with SMTP id c2mr11495851wrv.64.1572620331286; 
 Fri, 01 Nov 2019 07:58:51 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwYRVYd4RHoXHZFROnIZg1uxaQ3GsmE55MirQ4XHKYprZnLGzQP+1TI9f9BuF7E+JA84iaxlw==
X-Received: by 2002:a5d:5282:: with SMTP id c2mr11495825wrv.64.1572620331055; 
 Fri, 01 Nov 2019 07:58:51 -0700 (PDT)
Received: from xz-x1.metropole.lan ([91.217.168.176])
 by smtp.gmail.com with ESMTPSA id b3sm8131614wrv.40.2019.11.01.07.58.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Nov 2019 07:58:50 -0700 (PDT)
Date: Fri, 1 Nov 2019 15:58:48 +0100
From: Peter Xu <peterx@redhat.com>
To: Liu Yi L <yi.l.liu@intel.com>
Subject: Re: [RFC v2 05/22] vfio/common: add iommu_ctx_notifier in container
Message-ID: <20191101145848.GD8888@xz-x1.metropole.lan>
References: <1571920483-3382-1-git-send-email-yi.l.liu@intel.com>
 <1571920483-3382-6-git-send-email-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1571920483-3382-6-git-send-email-yi.l.liu@intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
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
Cc: tianyu.lan@intel.com, kevin.tian@intel.com, jacob.jun.pan@linux.intel.com,
 Yi Sun <yi.y.sun@linux.intel.com>, kvm@vger.kernel.org, mst@redhat.com,
 jun.j.tian@intel.com, qemu-devel@nongnu.org, eric.auger@redhat.com,
 alex.williamson@redhat.com, pbonzini@redhat.com, yi.y.sun@intel.com,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 24, 2019 at 08:34:26AM -0400, Liu Yi L wrote:

[...]

> +typedef struct VFIOIOMMUContext {
> +    VFIOContainer *container;
> +    IOMMUContext *iommu_ctx;
> +    IOMMUCTXNotifier n;
> +    QLIST_ENTRY(VFIOIOMMUContext) iommu_ctx_next;
> +} VFIOIOMMUContext;
> +

No strong opinion on this - but for me it would be more meaningful to
squash this patch into where this struct is firstly used.

-- 
Peter Xu

