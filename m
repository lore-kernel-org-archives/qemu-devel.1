Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38148C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 12:58:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BF11205C9
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 12:58:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BF11205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzhEm-00036d-Ms
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 08:58:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42967)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1hzh1p-0005fn-Un
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 08:44:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1hzh1o-0003pC-Jc
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 08:44:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41488)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1hzh1o-0003oS-93
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 08:44:52 -0400
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8D3B8C057F31
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 12:44:51 +0000 (UTC)
Received: by mail-pg1-f200.google.com with SMTP id z35so2506075pgk.10
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 05:44:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=VX59h7cYMfm7tHfMNYleY8XgaDwvKlk0BYd+QJymBwk=;
 b=d8+ZFTqCv7UJmlNrFeIoF/7HoOB84MvDDxGWSvwd2gLhCq/QABA32IFUeEkOq0ZG4J
 H2E+QG1TWFPXAMb5ypmrTHfqCe0hH6e9lGpSymxSNyK5wv0Tw5RYy6VPEfYUsDYHEUgM
 JQOJyCmh4bWs/limulBVrt51FId26cGSIAsBD1Y4RH4RrojgXp0i9DC5vzbSPJcYwbll
 GjgoyfM2bkfJkj/3xftq9yzocc+H+1Na4zb79itKLisjo2HX0zB9AlZRM099+Kplv/QT
 5IpTTPW7Wwp91Xj86jW6lOPGHoxsiQfrx75CmrnM5FAqSg0H5H7F53pldyYAMULHhyCO
 MUDQ==
X-Gm-Message-State: APjAAAWL6fUp5Z61ZbQNQWC6uo1xp4P0rtBD1CXaGse7i/bcvkp0Uazz
 vIVyApPU5eeONNFop+Wfongek7XLxpb/BGkCGCkdWpM3BRCTRxJ1NB/bYM+H3UiQ7sZAAHZh48/
 +9XLM/jYzTDxJc0k=
X-Received: by 2002:a17:902:2ae9:: with SMTP id
 j96mr12769964plb.10.1566218691147; 
 Mon, 19 Aug 2019 05:44:51 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyrYbay3xVMt1ctWFr5kZshNjIYr4lxtnwgUyEA+AlZ8CLWvD/VQ2xjLQXAC0kG9T/xv36YGg==
X-Received: by 2002:a17:902:2ae9:: with SMTP id
 j96mr12769951plb.10.1566218690954; 
 Mon, 19 Aug 2019 05:44:50 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id v18sm16431169pgl.87.2019.08.19.05.44.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2019 05:44:50 -0700 (PDT)
Date: Mon, 19 Aug 2019 20:44:38 +0800
From: Peter Xu <peterx@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Message-ID: <20190819124438.GE13560@xz-x1>
References: <20190730172137.23114-1-eric.auger@redhat.com>
 <20190730172137.23114-14-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190730172137.23114-14-eric.auger@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH for-4.2 v10 13/15] virtio_iommu: Handle
 reserved regions in translation process
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
Cc: peter.maydell@linaro.org, kevin.tian@intel.com, mst@redhat.com,
 tn@semihalf.com, qemu-devel@nongnu.org, alex.williamson@redhat.com,
 qemu-arm@nongnu.org, jean-philippe@linaro.org, bharat.bhushan@nxp.com,
 eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 30, 2019 at 07:21:35PM +0200, Eric Auger wrote:
> When translating an address we need to check if it belongs to
> a reserved virtual address range. If it does, there are 2 cases:
> 
> - it belongs to a RESERVED region: the guest should neither use
>   this address in a MAP not instruct the end-point to DMA on
>   them. We report an error
> 
> - It belongs to an MSI region: we bypass the translation.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

