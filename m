Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A060C32771
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 08:38:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F002621734
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 08:38:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F002621734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioNu0-0004Ok-3l
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 03:38:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44640)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yang.zhong@intel.com>) id 1ioNtR-0003yr-3d
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 03:37:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yang.zhong@intel.com>) id 1ioNtP-0005aE-2z
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 03:37:44 -0500
Received: from mga05.intel.com ([192.55.52.43]:29160)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yang.zhong@intel.com>)
 id 1ioNtO-0005VO-Rf
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 03:37:43 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 06 Jan 2020 00:37:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,401,1571727600"; d="scan'208";a="215136679"
Received: from yangzhon-virtual.bj.intel.com (HELO localhost) ([10.238.145.50])
 by orsmga008.jf.intel.com with ESMTP; 06 Jan 2020 00:37:33 -0800
Date: Mon, 6 Jan 2020 16:30:51 +0800
From: Yang Zhong <yang.zhong@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] virtio: add the queue number check
Message-ID: <20200106083051.GA28699@yangzhon-Virtual>
References: <20191223082813.28930-1-yang.zhong@intel.com>
 <5cb6ace0-dd8e-aa22-e280-1e697c2c4156@redhat.com>
 <20191223091856.GA8433@yangzhon-Virtual>
 <e13a5fcc-b861-1847-58a8-e3d6445f84b0@redhat.com>
 <20191223092508-mutt-send-email-mst@kernel.org>
 <187f02d9-1677-d232-a44a-ed7b1e5f6ee5@redhat.com>
 <20200103150145.GA24552@yangzhon-Virtual>
 <CABgObfZWq_d-R_j456yxipPnbcLzCOJwd=9mCBMiwHDOckaXYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABgObfZWq_d-R_j456yxipPnbcLzCOJwd=9mCBMiwHDOckaXYg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.43
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
Cc: Yang Zhong <yang.zhong@intel.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jan 03, 2020 at 10:18:58PM +0100, Paolo Bonzini wrote:
> Il ven 3 gen 2020, 16:08 Yang Zhong <yang.zhong@intel.com> ha scritto:
> 
> >   I also tried virtio-blk device like below:
> >   https://patchwork.kernel.org/cover/10873193/
> >
> >   The virtio-blk can work with this changes, but vhost-user-blk device
> >   failed with this kernel patch.
> >
> >   in vhost_virtqueue_start() function, below operation to check if the
> >   desc addr set by guest kernel. This will ignore the extra vqs.
> >     a = virtio_queue_get_desc_addr(vdev, idx);
> >     if (a == 0) {
> >         /* Queue might not be ready for start */
> >         return 0;
> >     }
> >
> >   If guest kernel add min(cpu,num_vqs), do we need add same check in
> >   realize function of vhost-user-blk device?
> >
> 
> No. If virtio-blk works, the bug is in vhost-user-blk; if virtio-blk needs
> no check in cpu count, vhost-user-blk also doesn't.
> 
> You need to check first if the bug is in QEMU or the vhost-user-blk server.
>
  Thanks Paolo for your comments, and i will do it later. thanks!

  Yang

> Paolo

