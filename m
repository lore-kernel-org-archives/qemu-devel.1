Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 288CAC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 04:11:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7CF320723
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 04:11:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q96IXeDP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7CF320723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jySZl-00078s-8Y
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 00:11:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55374)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jySZA-0006jr-AO
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 00:10:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37862
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jySZ7-000710-UO
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 00:10:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595477440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Pj3crPmS1rkMEFp34C8XVru9cLBV6X9tz555KAxssXg=;
 b=Q96IXeDP521j9O1XzJR/nvs2209kPs2lsqTbebe85M/W7UVhy0i75xVeG1mgVE524cXDpY
 wNlbawUIKo1MuCDX7v0VmJFjsdqCoN9kdv6txFA7VPfDqkXSkhow9P6aKPeBQt5ayUJrGU
 cXjj7Jmgai3KGtQaKz0qi+p8kktGxxg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-7PXY_YCBOki_VRyOc6eYKw-1; Thu, 23 Jul 2020 00:10:38 -0400
X-MC-Unique: 7PXY_YCBOki_VRyOc6eYKw-1
Received: by mail-wr1-f70.google.com with SMTP id c6so1010004wru.7
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 21:10:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Pj3crPmS1rkMEFp34C8XVru9cLBV6X9tz555KAxssXg=;
 b=uPnup/mC8Hq0bLPD9LMmkS0YaFehapRneGbZy0n0hC5zb6LvG4yInn8eOKWxTJYEdS
 HlNKGuq1XO5+8hJ9kYnNv23MaFT3xYC7g6iZlpgSU/uS39NQMCZAQkDcm8esMobbDk0/
 Z/9tVnc5IiB3FJOytiVEXEBJ0VYKRNjn5tMNf0Q1r2GdPdR5z9/iaaQHU4BNvsQZgLkd
 aKNbf2hSmmPl6Uo7cLROwadOL9bqwottRV9Xn3HAOmS396yg/tkUxTqAaUj5rcawZJsz
 Xe6VaWvZhoaNkCb7f7GCFbsfwgTQUNUBcgCL5IjkvHaU0fi4zzSMdHZEjrdpPwrk1ixo
 UHZg==
X-Gm-Message-State: AOAM532RfstGRbbKAYQL2RJ36hILCoYH/xy8+94VGxLDHO8wOjtS1PST
 QV95thVrsLzao0FxBF/IMNZ66AJjNti2GEhJdW04BQNLHzIy6myg+kit3Z4UCuU1Ltmdaj3P8pd
 NcWKvPPCVVRKw8JI=
X-Received: by 2002:a1c:9e4c:: with SMTP id h73mr2475021wme.177.1595477437525; 
 Wed, 22 Jul 2020 21:10:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxDNeSGFA4QcsVcqSpyrzLwxGMOzAJYp+X/Y//b/yg3IsOakVvGq9e7wj4pCP6LMJnXf8dKfQ==
X-Received: by 2002:a1c:9e4c:: with SMTP id h73mr2475006wme.177.1595477437248; 
 Wed, 22 Jul 2020 21:10:37 -0700 (PDT)
Received: from redhat.com (bzq-79-179-105-63.red.bezeqint.net. [79.179.105.63])
 by smtp.gmail.com with ESMTPSA id n3sm2256646wre.29.2020.07.22.21.10.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2020 21:10:36 -0700 (PDT)
Date: Thu, 23 Jul 2020 00:10:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2] virtio-balloon: always indicate S_DONE when migration
 fails
Message-ID: <20200723000949-mutt-send-email-mst@kernel.org>
References: <20200629080615.26022-1-david@redhat.com>
 <20200722080356-mutt-send-email-mst@kernel.org>
 <d52e7c61-a458-141c-5b7c-515173724fe8@redhat.com>
 <77a59dfa-9560-209b-f85e-4e0b3df51bab@redhat.com>
MIME-Version: 1.0
In-Reply-To: <77a59dfa-9560-209b-f85e-4e0b3df51bab@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 22:13:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: virtio-dev@lists.oasis-open.org,
 Alexander Duyck <alexander.h.duyck@linux.intel.com>,
 Wei Wang <wei.w.wang@intel.com>, qemu-devel@nongnu.org,
 Alexander Duyck <alexander.duyck@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 22, 2020 at 02:11:52PM +0200, David Hildenbrand wrote:
> On 22.07.20 14:05, David Hildenbrand wrote:
> > On 22.07.20 14:04, Michael S. Tsirkin wrote:
> >> On Mon, Jun 29, 2020 at 10:06:15AM +0200, David Hildenbrand wrote:
> >>> If something goes wrong during precopy, before stopping the VM, we will
> >>> never send a S_DONE indication to the VM, resulting in the hinted pages
> >>> not getting released to be used by the guest OS (e.g., Linux).
> >>>
> >>> Easy to reproduce:
> >>> 1. Start migration (e.g., HMP "migrate -d 'exec:gzip -c > STATEFILE.gz'")
> >>> 2. Cancel migration (e.g., HMP "migrate_cancel")
> >>> 3. Oberve in the guest (e.g., cat /proc/meminfo) that there is basically
> >>>    no free memory left.
> >>>
> >>> While at it, add similar locking to virtio_balloon_free_page_done() as
> >>> done in virtio_balloon_free_page_stop. Locking is still weird, but that
> >>> has to be sorted out separately.
> >>>
> >>> There is nothing to do in the PRECOPY_NOTIFY_COMPLETE case. Add some
> >>> comments regarding S_DONE handling.
> >>>
> >>> Fixes: c13c4153f76d ("virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT")
> >>> Reviewed-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> >>> Cc: Wei Wang <wei.w.wang@intel.com>
> >>> Cc: Alexander Duyck <alexander.duyck@gmail.com>
> >>> Signed-off-by: David Hildenbrand <david@redhat.com>
> >>
> >> IIUC this is superceded by Alexander's patches right?
> > 
> > Not that I know ... @Alex?
> > 
> 
> Okay, I'm confused, that patch is already upstream (via your tree)?
> 
> dd8eeb9671fc ("virtio-balloon: always indicate S_DONE when migration fails")
> 
> Did you stumble over this mail by mistake again?
> 
> -- 
> Thanks,
> 
> David / dhildenb

Oh. I guess that's what happened. I saw the code in the tree and thought
it came in from Alex's patch.
Sorry about the noise.

-- 
MST


