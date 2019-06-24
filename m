Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68AB9C43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 08:07:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6DF320679
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 08:07:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6DF320679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48654 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfK0n-0001eZ-BN
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 04:07:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34731)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peterx@redhat.com>) id 1hfK0H-0001Fd-L1
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 04:07:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1hfK0G-0008WE-Nl
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 04:07:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56560)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1hfK0G-0008V3-Gk
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 04:07:04 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 27F49307D84B;
 Mon, 24 Jun 2019 08:07:03 +0000 (UTC)
Received: from xz-x1 (ovpn-12-60.pek2.redhat.com [10.72.12.60])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A746560BF7;
 Mon, 24 Jun 2019 08:06:55 +0000 (UTC)
Date: Mon, 24 Jun 2019 16:06:49 +0800
From: Peter Xu <peterx@redhat.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Message-ID: <20190624080649.GG6279@xz-x1>
References: <20190624063733.22079-1-peterx@redhat.com>
 <20190624063733.22079-3-peterx@redhat.com>
 <20190624064122.GB27894@joy-OptiPlex-7040>
 <20190624065750.GE6279@xz-x1>
 <20190624070450.GC27894@joy-OptiPlex-7040>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190624070450.GC27894@joy-OptiPlex-7040>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Mon, 24 Jun 2019 08:07:03 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/2] intel_iommu: Fix unexpected unmaps
 during global unmap
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Auger Eric <eric.auger@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 24, 2019 at 03:04:50AM -0400, Yan Zhao wrote:

[...]

> I think it might be helpful if there anything wrong in code.
> for example, when previously, size = end - start, it will happen that
> size will eventually be less than page size.

Well, if with such an error we'd better fix it right away in this
patch... :)

Let me wait for some more comments, I'll touch that up too if I need a
repost.

Regards,

-- 
Peter Xu

