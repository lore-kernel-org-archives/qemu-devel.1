Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29FC6C352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 09:23:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 000EF2086A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 09:23:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 000EF2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1Rlq-0002ia-5K
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 04:23:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59365)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chao.p.peng@linux.intel.com>) id 1j1RlH-0002Fc-SS
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 04:23:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chao.p.peng@linux.intel.com>) id 1j1RlG-0003cW-QV
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 04:23:19 -0500
Received: from mga14.intel.com ([192.55.52.115]:5534)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <chao.p.peng@linux.intel.com>)
 id 1j1RlG-0003aN-IL
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 04:23:18 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 11 Feb 2020 01:23:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,428,1574150400"; d="scan'208";a="380377287"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.192.106])
 by orsmga004.jf.intel.com with ESMTP; 11 Feb 2020 01:23:13 -0800
Date: Tue, 11 Feb 2020 16:05:41 +0000
From: Chao Peng <chao.p.peng@linux.intel.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 0/5] virtio mmio specification enhancement
Message-ID: <20200211160541.GA37446@chaop.bj.intel.com>
References: <cover.1581305609.git.zhabin@linux.alibaba.com>
 <20200210062938-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200210062938-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.115
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
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
Cc: virtio-dev@lists.oasis-open.org, Zha Bin <zhabin@linux.alibaba.com>,
 slp@redhat.com, jasowang@redhat.com, jing2.liu@linux.intel.com,
 linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, gerry@linux.alibaba.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Feb 10, 2020 at 06:44:50AM -0500, Michael S. Tsirkin wrote:
> On Mon, Feb 10, 2020 at 05:05:16PM +0800, Zha Bin wrote:
> > We have compared the number of files and the lines of code between
> > virtio-mmio and virio-pci.
> > 
> > 				Virtio-PCI	    Virtio-MMIO	
> > 	number of files(Linux)	    161			1
> > 	lines of code(Linux)	    78237		538
> 
> 
> 
> Something's very wrong here. virtio PCI is 161 files?
> Are you counting the whole PCI subsystem?

Right, that is just a rough statistics. Surely enough, some drivers will
never get enabled in a typcial config.

> Sure enough:
> 
> $ find drivers/pci -name '*c' |wc -l
> 150

and plus:
$ find arch/x86/pci/ -name '*c' |wc -l
22

> 
> That's not reasonable, this includes a bunch of drivers that
> never run on a typical hypervisor.
> 
> MMIO is also not as small as you are trying to show:
> 
> $ cloc drivers/virtio/virtio_mmio.c include/uapi/linux/virtio_mmio.h
>        2 text files.
>        2 unique files.                              
>        0 files ignored.
> 
> github.com/AlDanial/cloc v 1.82  T=0.01 s (230.7 files/s, 106126.5 lines/s)
> -------------------------------------------------------------------------------
> Language                     files          blank        comment           code
> -------------------------------------------------------------------------------
> C                                1            144            100            535
> C/C++ Header                     1             39             66             36
> -------------------------------------------------------------------------------
> SUM:                             2            183            166            571
> -------------------------------------------------------------------------------
> 
> 
> I don't doubt MMIO is smaller than PCI. Of course that's because it has
> no features to speak of - just this patch already doubles it's size. If
> we keep doing that because we want the features then they will reach
> the same size in about 4 iterations.

Since current virtio-mmio size is small enough, so adding any notable
feature would easily double it. I have no objection that it may one day
reach the same level of PCI, but in this patch some are actually
generic changes and for MSI specific code we provide the option to
confige away.

Thanks,
Chao

> 
> 
> -- 
> MST

