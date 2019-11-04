Return-Path: <SRS0=KlJF=Y4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0317CA9EB5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 17:23:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA86B214E0
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 17:23:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA86B214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRg4v-0000v9-TJ
	for qemu-devel@archiver.kernel.org; Mon, 04 Nov 2019 12:23:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60724)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1iRg41-0000EM-Sx
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 12:22:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1iRg3z-0003R3-67
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 12:22:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44130)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1iRg3y-0003Qi-U6
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 12:22:47 -0500
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 847F185360
 for <qemu-devel@nongnu.org>; Mon,  4 Nov 2019 17:22:45 +0000 (UTC)
Received: by mail-qk1-f199.google.com with SMTP id g62so18266955qkb.20
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2019 09:22:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=hGun/xxBDTM75WA+PPVD/XZnt9nEDVLB5zx43UE5Aso=;
 b=llvEJXqPjLI8ezphk2drl29E9WArRlXR0nVnx1d6DeY+pCPH9akKIy7PWJMbmwaLRz
 wHkZIoqxISbZXS8klIp7xwEtRy7p1CAwvBZMjYC6YJq3Q1D20R7waclaxaGksQOivA68
 3D5woFYXVgmy4FLoxYDvW4RjY+8Pgs1e+iUVPbXzjTJXY237LGNgiSgc9vyCCud93Hsv
 h6J86Jrg4im4Si817FFU+TQ/lAewJkfxiWveDgIpRAbnjONhsos0c7a4SJrZGZ1Uj9H/
 PJ8eDHhfI6lfZC1OH6oVhP2C2rnXKRe1ARSIawy+c4hK7d75LfV8584/0LxjNAnF8Bnt
 uGSg==
X-Gm-Message-State: APjAAAVMya+jN7cEDFpX3XFt+kI+eY/aUXk6gOqLG7j600rvpi/9uPzS
 XsxXWpYalxtaSM2WY489kYkE1azvtURQylf64NShCxtMKPf4VoHSdCCQ959ZyDPpt3gmzYyCBaa
 oCHnJ72uIl037l3k=
X-Received: by 2002:aed:24e4:: with SMTP id u33mr13311103qtc.259.1572888164829; 
 Mon, 04 Nov 2019 09:22:44 -0800 (PST)
X-Google-Smtp-Source: APXvYqwXDSii1Sp1JoXaaC96NK08xiocEah+dkAX0IB2PhxwphYwtk8Zpi5wlbG9RUjxaUVdk1G54w==
X-Received: by 2002:aed:24e4:: with SMTP id u33mr13311086qtc.259.1572888164607; 
 Mon, 04 Nov 2019 09:22:44 -0800 (PST)
Received: from xz-x1.metropole.lan ([104.156.64.74])
 by smtp.gmail.com with ESMTPSA id h21sm1097470qkl.13.2019.11.04.09.22.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2019 09:22:43 -0800 (PST)
Date: Mon, 4 Nov 2019 12:22:42 -0500
From: Peter Xu <peterx@redhat.com>
To: Liu Yi L <yi.l.liu@intel.com>
Subject: Re: [RFC v2 00/22] intel_iommu: expose Shared Virtual Addressing to VM
Message-ID: <20191104172242.GD26023@xz-x1.metropole.lan>
References: <1571920483-3382-1-git-send-email-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1571920483-3382-1-git-send-email-yi.l.liu@intel.com>
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
 kvm@vger.kernel.org, mst@redhat.com, jun.j.tian@intel.com,
 qemu-devel@nongnu.org, eric.auger@redhat.com, alex.williamson@redhat.com,
 pbonzini@redhat.com, yi.y.sun@intel.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 24, 2019 at 08:34:21AM -0400, Liu Yi L wrote:
> Shared virtual address (SVA), a.k.a, Shared virtual memory (SVM) on Intel
> platforms allow address space sharing between device DMA and applications.
> SVA can reduce programming complexity and enhance security.
> This series is intended to expose SVA capability to VMs. i.e. shared guest
> application address space with passthru devices. The whole SVA virtualization
> requires QEMU/VFIO/IOMMU changes. This series includes the QEMU changes, for
> VFIO and IOMMU changes, they are in separate series (listed in the "Related
> series").
> 
> The high-level architecture for SVA virtualization is as below:
> 
>     .-------------.  .---------------------------.
>     |   vIOMMU    |  | Guest process CR3, FL only|
>     |             |  '---------------------------'
>     .----------------/
>     | PASID Entry |--- PASID cache flush -
>     '-------------'                       |
>     |             |                       V
>     |             |                CR3 in GPA
>     '-------------'
> Guest
> ------| Shadow |--------------------------|--------
>       v        v                          v
> Host
>     .-------------.  .----------------------.
>     |   pIOMMU    |  | Bind FL for GVA-GPA  |
>     |             |  '----------------------'
>     .----------------/  |
>     | PASID Entry |     V (Nested xlate)
>     '----------------\.------------------------------.
>     |             |   |SL for GPA-HPA, default domain|
>     |             |   '------------------------------'
>     '-------------'
> Where:
>  - FL = First level/stage one page tables
>  - SL = Second level/stage two page tables

Yi,

Would you mind to always mention what tests you have been done with
the patchset in the cover letter?  It'll be fine to say that you're
running this against FPGAs so no one could really retest it, but still
it would be good to know that as well.  It'll even be better to
mention that which part of the series is totally untested if you are
aware of.

Thanks,

-- 
Peter Xu

