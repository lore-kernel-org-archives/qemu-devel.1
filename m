Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E2C7C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 06:39:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38A57206F5
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 06:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ad1Tzu64"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38A57206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvxXn-0005xL-FG
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 02:38:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57394)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jvxXE-0005X9-Qu
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 02:38:24 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:42744
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jvxXB-0007FS-Qn
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 02:38:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594881499;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mgsbCofvuyqXz4CiSAjrSGg+j5I3SP1iCQXPN1fyRB0=;
 b=Ad1Tzu64duExagm01DiFHyHqR9Q4OZahI9GBiWq8DM/5ak1J2iNQxE/bQJjlbGrZnVjvPD
 cF9gjjATcYeiYRHppAM/HlUf6AbXCiMAN/N3RY8IdZ78VlnUHhTaiXka3m+5LL6pJi0iEu
 08o8MXuoaDBZDysOvnGBhjfJCen6GjI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-O82WHeWSNEG8AHEDQRrkkg-1; Thu, 16 Jul 2020 02:38:13 -0400
X-MC-Unique: O82WHeWSNEG8AHEDQRrkkg-1
Received: by mail-wr1-f70.google.com with SMTP id 89so4688733wrr.15
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2020 23:38:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=mgsbCofvuyqXz4CiSAjrSGg+j5I3SP1iCQXPN1fyRB0=;
 b=pSV9wra8RXlSeWQyKlEpxDJ2IG5W6SRiJQg2eCnUxTiLyVWoVcyLMeQdpm+ptb7L3O
 7MrjF2gbwwy7faLXQ6Ecy+gCjXahrvKaOq4DQ8XXB0oP4BTr9kFa9E3qMiLvCTKLr7i3
 3RdluhPF39Vpg50YwiJa8+mLuh2HJS2ONE8s9TdQEO0CUiEaoHnrNzc2MrZ1Im5xvtJS
 +6z50kTnjlfrf6/fS/WcFr1AVgxgitskyeOMZSLgyG8rEILlQsE/nmvuQcp9cylVAl2/
 ua79PRnS1MSYTv0KVWlZRzm5xQ8X01X4UusT1KvqUu+1i/0v89Xd9Bv/1ObQ6/dBIthP
 NUaQ==
X-Gm-Message-State: AOAM530ffqR3fjHs/tASrY9FPtBxvSow9jdJkEsmRN2RKjkLS161E3N9
 NJelVZnQJTbhKiHlb7vwZOPyZJVHFz7FJ4bLIHjGfaTFiTnfNbewrMOK46J5WUJLNVdE0+p7IK8
 WLkd4X1hlGV94RLQ=
X-Received: by 2002:a1c:bb89:: with SMTP id l131mr2738042wmf.125.1594881492235; 
 Wed, 15 Jul 2020 23:38:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzzaPeWg1JnBNar2FAbNPZoF5EQR8AmndjmfZn9b+/T6UDyq076UKRxNe2r8PFt/+RlfkD65g==
X-Received: by 2002:a1c:bb89:: with SMTP id l131mr2738003wmf.125.1594881491787; 
 Wed, 15 Jul 2020 23:38:11 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 p14sm8342659wrj.14.2020.07.15.23.38.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2020 23:38:11 -0700 (PDT)
Date: Thu, 16 Jul 2020 02:38:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Hui Zhu <teawater@gmail.com>
Subject: Re: [RFC for Linux v4 0/2] virtio_balloon: Add
 VIRTIO_BALLOON_F_CONT_PAGES to report continuous pages
Message-ID: <20200716021929-mutt-send-email-mst@kernel.org>
References: <1594867315-8626-1-git-send-email-teawater@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1594867315-8626-1-git-send-email-teawater@gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 01:59:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Andrea Arcangeli <aarcange@redhat.com>, virtio-dev@lists.oasis-open.org,
 david@redhat.com, qemu-devel@nongnu.org, jasowang@redhat.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-mm@kvack.org, akpm@linux-foundation.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 16, 2020 at 10:41:50AM +0800, Hui Zhu wrote:
> The first, second and third version are in [1], [2] and [3].
> Code of current version for Linux and qemu is available in [4] and [5].
> Update of this version:
> 1. Report continuous pages will increase the speed.  So added deflate
>    continuous pages.
> 2. According to the comments from David in [6], added 2 new vqs inflate_cont_vq
>    and deflate_cont_vq to report continuous pages with format 32 bits pfn and 32
>    bits size.
> Following is the introduction of the function.
> These patches add VIRTIO_BALLOON_F_CONT_PAGES to virtio_balloon. With this
> flag, balloon tries to use continuous pages to inflate and deflate.
> Opening this flag can bring two benefits:
> 1. Report continuous pages will increase memory report size of each time
>    call tell_host.  Then it will increase the speed of balloon inflate and
>    deflate.
> 2. Host THPs will be splitted when qemu release the page of balloon inflate.
>    Inflate balloon with continuous pages will let QEMU release the pages
>    of same THPs.  That will help decrease the splitted THPs number in
>    the host.
>    Following is an example in a VM with 1G memory 1CPU.  This test setups an
>    environment that has a lot of fragmentation pages.  Then inflate balloon will
>    split the THPs.
> // This is the THP number before VM execution in the host.
> // None use THP.
> cat /proc/meminfo | grep AnonHugePages:
> AnonHugePages:         0 kB
> // After VM start, use usemem
> // (https://git.kernel.org/pub/scm/linux/kernel/git/wfg/vm-scalability.git)
> // punch-holes function generates 400m fragmentation pages in the guest
> // kernel.
> usemem --punch-holes -s -1 800m &
> // This is the THP number after this command in the host.
> // Some THP is used by VM because usemem will access 800M memory
> // in the guest.
> cat /proc/meminfo | grep AnonHugePages:
> AnonHugePages:    911360 kB
> // Connect to the QEMU monitor, setup balloon, and set it size to 600M.
> (qemu) device_add virtio-balloon-pci,id=balloon1
> (qemu) info balloon
> balloon: actual=1024
> (qemu) balloon 600
> (qemu) info balloon
> balloon: actual=600
> // This is the THP number after inflate the balloon in the host.
> cat /proc/meminfo | grep AnonHugePages:
> AnonHugePages:     88064 kB
> // Set the size back to 1024M in the QEMU monitor.
> (qemu) balloon 1024
> (qemu) info balloon
> balloon: actual=1024
> // Use usemem to increase the memory usage of QEMU.
> killall usemem
> usemem 800m
> // This is the THP number after this operation.
> cat /proc/meminfo | grep AnonHugePages:
> AnonHugePages:     65536 kB
> 
> Following example change to use continuous pages balloon.  The number of
> splitted THPs is decreased.
> // This is the THP number before VM execution in the host.
> // None use THP.
> cat /proc/meminfo | grep AnonHugePages:
> AnonHugePages:         0 kB
> // After VM start, use usemem punch-holes function generates 400M
> // fragmentation pages in the guest kernel.
> usemem --punch-holes -s -1 800m &
> // This is the THP number after this command in the host.
> // Some THP is used by VM because usemem will access 800M memory
> // in the guest.
> cat /proc/meminfo | grep AnonHugePages:
> AnonHugePages:    911360 kB
> // Connect to the QEMU monitor, setup balloon, and set it size to 600M.
> (qemu) device_add virtio-balloon-pci,id=balloon1,cont-pages=on
> (qemu) info balloon
> balloon: actual=1024
> (qemu) balloon 600
> (qemu) info balloon
> balloon: actual=600
> // This is the THP number after inflate the balloon in the host.
> cat /proc/meminfo | grep AnonHugePages:
> AnonHugePages:    616448 kB
> // Set the size back to 1024M in the QEMU monitor.
> (qemu) balloon 1024
> (qemu) info balloon
> balloon: actual=1024
> // Use usemem to increase the memory usage of QEMU.
> killall usemem
> usemem 800m
> // This is the THP number after this operation.
> cat /proc/meminfo | grep AnonHugePages:
> AnonHugePages:    907264 kB

I'm a bit confused about which of the above run within guest,
and which run within host. Could you explain pls?



> [1] https://lkml.org/lkml/2020/3/12/144
> [2] https://lore.kernel.org/linux-mm/1584893097-12317-1-git-send-email-teawater@gmail.com/
> [3] https://lkml.org/lkml/2020/5/12/324
> [4] https://github.com/teawater/linux/tree/balloon_conts
> [5] https://github.com/teawater/qemu/tree/balloon_conts
> [6] https://lkml.org/lkml/2020/5/13/1211
> 
> Hui Zhu (2):
>   virtio_balloon: Add VIRTIO_BALLOON_F_CONT_PAGES and inflate_cont_vq
>   virtio_balloon: Add deflate_cont_vq to deflate continuous pages
> 
>  drivers/virtio/virtio_balloon.c     |  180 +++++++++++++++++++++++++++++++-----
>  include/linux/balloon_compaction.h  |   12 ++
>  include/uapi/linux/virtio_balloon.h |    1
>  mm/balloon_compaction.c             |  117 +++++++++++++++++++++--
>  4 files changed, 280 insertions(+), 30 deletions(-)


