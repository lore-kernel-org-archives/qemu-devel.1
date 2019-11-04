Return-Path: <SRS0=KlJF=Y4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 812E6CA9EB5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 17:10:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5030F2080F
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 17:10:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5030F2080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRfrs-0004pE-L7
	for qemu-devel@archiver.kernel.org; Mon, 04 Nov 2019 12:10:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58764)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1iRfqR-0003kX-Fc
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 12:08:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1iRfqP-0007md-7i
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 12:08:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60006)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1iRfqO-0007ls-VQ
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 12:08:45 -0500
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C4A3959455
 for <qemu-devel@nongnu.org>; Mon,  4 Nov 2019 17:08:42 +0000 (UTC)
Received: by mail-qt1-f198.google.com with SMTP id k9so19463084qtg.2
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2019 09:08:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=uKHKr+sED8/ifki1N84hANz+1qxhCsRrQg1xbOjDuGQ=;
 b=EgKvyh7LkW4+8WLstmIic8bIh8AgMtrMOzDlL1YED4BI4p/qToI5S4YGi9MaAuD6DG
 3jwegjCbyPV38cs4kfxvIBZ0hcImm8q9fyt1GiY2uoHAZmwzYYKbC0X7HHS1ypZB47jl
 U2drdvAAuZJ5iIamTS0C+CoPSUFH/UcLCWSiw8VljqoBSo0dGLD+IdEkzE/PS10n4JS2
 Fxlf/cZ+ZtxFl8qDTuqgmPcN0VwafxWvmuVoAW/BT7YU99FBn3KndtyOlhgMp/byXMEq
 hGJupLa2eI2kRDpYaXDd5qLPN8xwE9/+PH8rEInkIrOgZZEFEFBYg++RvEtEdleSGmzW
 vMYw==
X-Gm-Message-State: APjAAAVqSESTylUOKSvsEyvcyBPwerov3nNyb5J82OtBiS4K76lvUYEf
 CMUaqjMlPhEQCTLSlk+O5r1hhmn3HVBFG+GPg8dpMyCqfODOD/ng2Cr4XtBTZZ7gvhPhpKpCwMc
 IAAW5oDcTPkc6CtQ=
X-Received: by 2002:ac8:109:: with SMTP id e9mr13539981qtg.233.1572887322084; 
 Mon, 04 Nov 2019 09:08:42 -0800 (PST)
X-Google-Smtp-Source: APXvYqwnZiHtSCIDwnaSbOGiV++99WNwUV0+w//hsZpHrFlaZveBT2pjBpdR3kZqEA9vRmxqY9w+YA==
X-Received: by 2002:ac8:109:: with SMTP id e9mr13539942qtg.233.1572887321714; 
 Mon, 04 Nov 2019 09:08:41 -0800 (PST)
Received: from xz-x1.metropole.lan ([104.156.64.74])
 by smtp.gmail.com with ESMTPSA id b21sm2620443qtr.67.2019.11.04.09.08.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2019 09:08:40 -0800 (PST)
Date: Mon, 4 Nov 2019 12:08:38 -0500
From: Peter Xu <peterx@redhat.com>
To: Liu Yi L <yi.l.liu@intel.com>
Subject: Re: [RFC v2 13/22] intel_iommu: add PASID cache management
 infrastructure
Message-ID: <20191104170838.GC26023@xz-x1.metropole.lan>
References: <1571920483-3382-1-git-send-email-yi.l.liu@intel.com>
 <1571920483-3382-14-git-send-email-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1571920483-3382-14-git-send-email-yi.l.liu@intel.com>
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

On Thu, Oct 24, 2019 at 08:34:34AM -0400, Liu Yi L wrote:
> This patch adds a PASID cache management infrastructure based on
> new added structure VTDPASIDAddressSpace, which is used to track
> the PASID usage and future PASID tagged DMA address translation
> support in vIOMMU.
> 
>     struct VTDPASIDAddressSpace {
>         VTDBus *vtd_bus;
>         uint8_t devfn;
>         AddressSpace as;
>         uint32_t pasid;
>         IntelIOMMUState *iommu_state;
>         VTDContextCacheEntry context_cache_entry;
>         QLIST_ENTRY(VTDPASIDAddressSpace) next;
>         VTDPASIDCacheEntry pasid_cache_entry;
>     };
> 
> Ideally, a VTDPASIDAddressSpace instance is created when a PASID
> is bound with a DMA AddressSpace. Intel VT-d spec requires guest
> software to issue pasid cache invalidation when bind or unbind a
> pasid with an address space under caching-mode. However, as
> VTDPASIDAddressSpace instances also act as pasid cache in this
> implementation, its creation also happens during vIOMMU PASID
> tagged DMA translation. The creation in this path will not be
> added in this patch since no PASID-capable emulated devices for
> now.

So is this patch an incomplete version even for the pasid caching
layer for emulated device?

IMHO it would be considered as acceptable to merge something that is
even not ready from hardware pov but at least from software pov it is
complete (so when the hardware is ready we should logically run the
binary directly on them, bugs can happen but that's another story).
However if for this case:

  - it's not even complete as is (in translation functions it seems
    that we don't ever use this cache layer at all),

  - we don't have emulated device supported for pasid yet at all, so
    even further to have this code start to make any sense, and,

  - this is a 400 line patch as standalone :)  Which means that we
    need to start maintain these 400 LOC starting from the day when it
    gets merged, while it's far from even being tested.  Then I don't
    see how to maintain...

With above, I would suggest you put this patch into the future
patchset where you would like to have the first emulated device for
pasid and then you can even test this patch with those ones.  What do
you think?

Thanks,

-- 
Peter Xu

