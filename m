Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6820C606D5
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 03:53:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2C48216C4
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 03:53:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2C48216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkhBu-0004a6-Uz
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 23:53:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38303)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <zhexu@redhat.com>) id 1hkfOo-0005Ou-N7
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 21:58:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhexu@redhat.com>) id 1hkfOn-0003KC-LF
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 21:58:30 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43763)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <zhexu@redhat.com>) id 1hkfOn-0003AW-F6
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 21:58:29 -0400
Received: by mail-pg1-f194.google.com with SMTP id f25so8586049pgv.10
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2019 18:58:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:date:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=zyDIO7yh1oeZpbiIlgCyaK7CcmNyJU5JiEZyTWaMNxE=;
 b=uVIvxQgUD2GRXtBRBZR0uKmf7kAp+YoHVg0D/5GzKHGTkA6o33VthXIo2C/AiVnZjR
 r2Frp4H4WQdgn7M4OYmWAbeZdOsqbu9GVMevrVdf2mmyR4f6IblxS5/8qVDj2cro4OVt
 4sIB4zv+Q34mmsCN5jdjVwSy8ARh+/c3GpvhsbKOy4j1BMcrnv7hGlhW1OL6KkjCWVqQ
 AsAb1OtKOihVTalQBHIDsDFfb8qSradCTZ6tqei9hYY3WzQljOlhbRRmmiddY4tNrmVr
 +m6sytIV6t0TpYz+0qqwUptQaruWBtld49BZcTNT5IsGm3FeQJ3xiAzM0XzNh2zjGE8X
 SOEQ==
X-Gm-Message-State: APjAAAWPaBKN3wK8Z6AciTDAGGV8/ikFhehKunqvwTCkw+VROgn/FAQ9
 u9P16MxEsnp/CLEmgE+oxqHIKQ==
X-Google-Smtp-Source: APXvYqxmQP3po9nC79ae7wUEpZA4moIQW5XJjcBpq0lp52WdTJOCFmyLLLg8W6qA/qwHlulZNIUK8w==
X-Received: by 2002:a63:7a4f:: with SMTP id j15mr28036729pgn.427.1562637491766; 
 Mon, 08 Jul 2019 18:58:11 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id i3sm22605155pfo.138.2019.07.08.18.58.07
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 08 Jul 2019 18:58:10 -0700 (PDT)
From: Peter Xu <zhexu@redhat.com>
X-Google-Original-From: Peter Xu <peterx@redhat.com>
Date: Tue, 9 Jul 2019 09:58:00 +0800
To: Liu Yi L <yi.l.liu@intel.com>
Message-ID: <20190709015800.GA566@xz-x1>
References: <1562324511-2910-1-git-send-email-yi.l.liu@intel.com>
 <1562324511-2910-3-git-send-email-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1562324511-2910-3-git-send-email-yi.l.liu@intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.215.194
X-Mailman-Approved-At: Mon, 08 Jul 2019 23:51:52 -0400
Subject: Re: [Qemu-devel] [RFC v1 02/18] linux-headers: import vfio.h from
 kernel
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
Cc: tianyu.lan@intel.com, kevin.tian@intel.com,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, Yi Sun <yi.y.sun@linux.intel.com>,
 kvm@vger.kernel.org, mst@redhat.com, jun.j.tian@intel.com,
 qemu-devel@nongnu.org, eric.auger@redhat.com, alex.williamson@redhat.com,
 pbonzini@redhat.com, yi.y.sun@intel.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 05, 2019 at 07:01:35PM +0800, Liu Yi L wrote:
> This patch imports the vIOMMU related definitions from kernel
> uapi/vfio.h. e.g. pasid allocation, guest pasid bind, guest pasid
> table bind and guest iommu cache invalidation.
> 
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: Yi Sun <yi.y.sun@linux.intel.com>
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>

Just a note that in the last version you can use
scripts/update-linux-headers.sh to update the headers.  For this RFC
it's perfectly fine.

-- 
Peter Xu

