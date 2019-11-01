Return-Path: <SRS0=V8KP=YZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF46CA9ECF
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 18:11:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C672217F9
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 18:11:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C672217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQbOS-0005mk-BD
	for qemu-devel@archiver.kernel.org; Fri, 01 Nov 2019 14:11:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48602)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1iQbMy-0004d8-9c
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 14:09:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1iQbMx-0007vp-A1
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 14:09:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60689)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1iQbMx-0007ui-4V
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 14:09:55 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4872DC05A1D3
 for <qemu-devel@nongnu.org>; Fri,  1 Nov 2019 18:09:54 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id o8so4401050wmc.2
 for <qemu-devel@nongnu.org>; Fri, 01 Nov 2019 11:09:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=8jUfco7qh0pcrSjrShTOcaIDt+470HVcOI3AOAmvFn8=;
 b=g7ud8ykF1QQDNmnqGUKnc1YWgHE7yT3Q4Ja3La+lGNSVisEWXFXIHi8cSb+P3bSSOF
 4qrtrmjO4T28rEO3iIEA8XMgjXv2x4qUqURko1A2IIKqW8zGK2LGsFat490Obs7LAZyt
 jFpTal8cfT6p2n0XlOFWKC4awyin5hFbRPfZjtCh9BkS0rg46d+paetW6OqJMWyDyJEU
 jXIcJbEOqziDUOdOHx0Sth+CUXdoG42fghW6QAUvh67qgwsregEmJvZSa9PFYX4Rfjw7
 r3fE8OUmvNXNSpJ+k43NSi0CFJxrZ5zERKt4t6JfLqvBXQ20U1Em3dEXACNZDt3NWAla
 B3ug==
X-Gm-Message-State: APjAAAWbyku7uv9QCPulwxsblKjeiri8fu3wqt2OIm+5JtDCtF+oaRly
 244wYShhNIN7arPdpB0C0O+9uRNwXfzJ+dnPCPZaStuUIrMO4aIpcCszMuFY6VR3SdIyYjsdAyq
 Gg5tBMzlJuAdL8YA=
X-Received: by 2002:a5d:5444:: with SMTP id w4mr10145414wrv.164.1572631792983; 
 Fri, 01 Nov 2019 11:09:52 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy4NENz4o79PqRKSRVv5SOg7yKO+WfQ2dEggLZBDl7qe74/tZGua7zuZfCFnPpCCMW320O/gQ==
X-Received: by 2002:a5d:5444:: with SMTP id w4mr10145398wrv.164.1572631792803; 
 Fri, 01 Nov 2019 11:09:52 -0700 (PDT)
Received: from xz-x1.metropole.lan (94.222.26.109.rev.sfr.net. [109.26.222.94])
 by smtp.gmail.com with ESMTPSA id p15sm8829146wrs.94.2019.11.01.11.09.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Nov 2019 11:09:51 -0700 (PDT)
Date: Fri, 1 Nov 2019 19:09:49 +0100
From: Peter Xu <peterx@redhat.com>
To: Liu Yi L <yi.l.liu@intel.com>
Subject: Re: [RFC v2 07/22] hw/pci: introduce pci_device_iommu_context()
Message-ID: <20191101180949.GH8888@xz-x1.metropole.lan>
References: <1571920483-3382-1-git-send-email-yi.l.liu@intel.com>
 <1571920483-3382-8-git-send-email-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1571920483-3382-8-git-send-email-yi.l.liu@intel.com>
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

On Thu, Oct 24, 2019 at 08:34:28AM -0400, Liu Yi L wrote:
> This patch adds pci_device_iommu_context() to get an iommu_context
> for a given device. A new callback is added in PCIIOMMUOps. Users
> who wants to listen to events issued by vIOMMU could use this new
> interface to get an iommu_context and register their own notifiers,
> then wait for notifications from vIOMMU. e.g. VFIO is the first user
> of it to listen to the PASID_ALLOC/PASID_BIND/CACHE_INV events and
> propagate the events to host.
> 
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: Yi Sun <yi.y.sun@linux.intel.com>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

