Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73320C3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 05:23:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 488DF216F4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 05:23:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 488DF216F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzwcJ-0002Zy-DJ
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 01:23:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58818)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1hzwbg-0002A2-WB
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 01:22:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1hzwbf-0007HW-Jz
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 01:22:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56866)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1hzwbf-0007HO-CI
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 01:22:55 -0400
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 44FBD3CA13
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2019 05:22:54 +0000 (UTC)
Received: by mail-pf1-f199.google.com with SMTP id 22so4002374pfn.22
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 22:22:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=lmDZdJpZ36GD1TZ3IZlgYRWs9MNglSdkq9RFiVWupgY=;
 b=LCjMte6QoQ43ewh+xpGy2etweH7hDlLIpLkX2rm6FDfMH3XqdoiCO7Hf1jtmzCSFFz
 MedFBlkhfbHqM+SQW4UtCN8DWnL/W7YDotiIYln0YrvTIKgQYxJMxcToR/7vzaZdbrin
 VYu7r101SqmSFHltqYMTUQbDCSh13LcI6S++TTPLIIQgHdedHOSCQzDH/olTb24Yl7Em
 aq9XP/WDLeOkTCEwA8IkcpLnER3VkSrJUBnLBosLuTff37hSsC5tC3twDR/VAce2kSpH
 Ei/i0ydgjKYgXp0sG/JOcqpCpi3fWS3qeSarOl9ir7m38T7Nv+S00cepaf4JONCwLeJe
 fIGA==
X-Gm-Message-State: APjAAAUu+GBBin1Aagq4hu5yZ6laZD7WQhiiwUbHiIPYa3KSRblkL1f8
 qVlZfdxlQrfUdJ5OMupCsT254cIum30WiU/L8g35Mcu+khaMs/cXYpLGenWWa4FurcBoLNMoidX
 UGfzWoN2S5g6aIqk=
X-Received: by 2002:a17:902:9889:: with SMTP id
 s9mr26795728plp.100.1566278573260; 
 Mon, 19 Aug 2019 22:22:53 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxK5J4m8yUjriMIG+1eJrHa8fayi8hmKhNFWFO5aRjv7HZi78R618R9Vno3nZRfMR2UIqdYZg==
X-Received: by 2002:a17:902:9889:: with SMTP id
 s9mr26795713plp.100.1566278573096; 
 Mon, 19 Aug 2019 22:22:53 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id e26sm20126624pfd.14.2019.08.19.22.22.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2019 22:22:52 -0700 (PDT)
Date: Tue, 20 Aug 2019 13:22:40 +0800
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190820052240.GG13560@xz-x1>
References: <20190812074531.28970-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190812074531.28970-1-peterx@redhat.com>
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
 Jason Wang <jasowang@redhat.com>, Alex Williamson <alex.williamson@redhat.com>,
 Bandan Das <bsd@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 12, 2019 at 09:45:27AM +0200, Peter Xu wrote:
> This is a RFC series.
> 
> The VT-d code has some defects, one of them is that we cannot detect
> the misuse of vIOMMU and vfio-pci early enough.
> 
> For example, logically this is not allowed:
> 
>   -device intel-iommu,caching-mode=off \
>   -device vfio-pci,host=05:00.0
> 
> Because the caching mode is required to make vfio-pci devices
> functional.
> 
> Previously we did this sanity check in vtd_iommu_notify_flag_changed()
> as when the memory regions change their attributes.  However that's
> too late in most cases!  Because the memory region layouts will only
> change after IOMMU is enabled, and that's in most cases during the
> guest OS boots.  So when the configuration is wrong, we will only bail
> out during the guest boots rather than simply telling the user before
> QEMU starts.
> 
> The same problem happens on device hotplug, say, when we have this:
> 
>   -device intel-iommu,caching-mode=off
> 
> Then we do something like:
> 
>   (HMP) device_add vfio-pci,host=05:00.0,bus=pcie.1
> 
> If at that time the vIOMMU is enabled in the guest then the QEMU
> process will simply quit directly due to this hotplug event.  This is
> a bit insane...
> 
> This series tries to solve above two problems by introducing two
> sanity checks upon these places separately:
> 
>   - machine done
>   - hotplug device
> 
> This is a bit awkward but I hope this could be better than before.
> There is of course other solutions like hard-code the check into
> vfio-pci but I feel it even more unpretty.  I didn't think out any
> better way to do this, if there is please kindly shout out.
> 
> Please have a look to see whether this would be acceptable, thanks.

Any more comment on this?

Thanks,

-- 
Peter Xu

