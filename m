Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32533C433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 14:44:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9AAC2087D
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 14:44:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LQGbD1w3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9AAC2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDTzc-0006Aj-7b
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 10:44:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35776)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>) id 1kDTz6-0005k9-Af
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 10:43:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:42178)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>) id 1kDTz4-0003UG-DB
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 10:43:35 -0400
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [129.253.182.57])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2184620767;
 Wed,  2 Sep 2020 14:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599057811;
 bh=iAkfXyquv9Ls9pxxFP/M6P7FWl+o7omWqULZuWiBqqU=;
 h=Date:From:To:Cc:Subject:From;
 b=LQGbD1w3IRDY3IKP4kJvLlymj75XDITnHXxUjx9uJyI6jT0CGAUgEZgLARj0qGxWo
 PHeaU/+g2ce+dBegu73zIIoWxQr3D/hZN/ku2fpxUwCXDguJhGyDN0MhMv8K0Mjq+E
 6eFniAtn5YgqXogcNlkTzhXwvAVlMN0TUL/EX1+U=
Date: Wed, 2 Sep 2020 23:43:27 +0900
From: Keith Busch <kbusch@kernel.org>
To: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Subject: [PULLv2] nvme updates
Message-ID: <20200902144327.GA22699@redsun51.ssa.fujisawa.hgst.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.12.1 (2019-06-15)
Received-SPF: pass client-ip=198.145.29.99; envelope-from=kbusch@kernel.org;
 helo=mail.kernel.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 10:43:32
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Klaus Jensen <k.jensen@samsung.com>,
 Klaus Jensen <its@irrelevant.dk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

This is our second attempt at the nvme pull request from me and Klaus
after fixing the error you identified in the first attempt.

The following changes since commit 8d90bfc5c31ad60f6049dd39be636b06bc00b652:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20200901' into staging (2020-09-01 16:51:37 +0100)

are available in the Git repository at:

  git://git.infradead.org/qemu-nvme.git tags/pull-nvme-20200902

for you to fetch changes up to 82386d4a0f19ff1e6a04e29f104da1d12269539e:

  hw/block/nvme: remove explicit qsg/iov parameters (2020-09-02 08:48:50 +0200)

----------------------------------------------------------------
qemu-nvme

----------------------------------------------------------------
Keith Busch (1):
      MAINTAINERS: update nvme entry

Klaus Jensen (34):
      hw/block/nvme: bump spec data structures to v1.3
      hw/block/nvme: fix missing endian conversion
      hw/block/nvme: additional tracing
      hw/block/nvme: add support for the abort command
      hw/block/nvme: add temperature threshold feature
      hw/block/nvme: mark fw slot 1 as read-only
      hw/block/nvme: add support for the get log page command
      hw/block/nvme: add support for the asynchronous event request command
      hw/block/nvme: move NvmeFeatureVal into hw/block/nvme.h
      hw/block/nvme: flush write cache when disabled
      hw/block/nvme: add remaining mandatory controller parameters
      hw/block/nvme: support the get/set features select and save fields
      hw/block/nvme: make sure ncqr and nsqr is valid
      hw/block/nvme: support identify namespace descriptor list
      hw/block/nvme: reject invalid nsid values in active namespace id list
      hw/block/nvme: enforce valid queue creation sequence
      hw/block/nvme: provide the mandatory subnqn field
      hw/block/nvme: bump supported version to v1.3
      hw/block/nvme: memset preallocated requests structures
      hw/block/nvme: add mapping helpers
      hw/block/nvme: replace dma_acct with blk_acct equivalent
      hw/block/nvme: remove redundant has_sg member
      hw/block/nvme: destroy request iov before reuse
      hw/block/nvme: refactor dma read/write
      hw/block/nvme: add tracing to nvme_map_prp
      hw/block/nvme: add request mapping helper
      hw/block/nvme: verify validity of prp lists in the cmb
      hw/block/nvme: refactor request bounds checking
      hw/block/nvme: add check for mdts
      hw/block/nvme: be consistent about zeros vs zeroes
      hw/block/nvme: add ns/cmd references in NvmeRequest
      hw/block/nvme: consolidate qsg/iov clearing
      hw/block/nvme: use preallocated qsg/iov in nvme_dma_prp
      hw/block/nvme: remove explicit qsg/iov parameters

Philippe Mathieu-Daudé (4):
      hw/block/nvme: Update specification URL
      hw/block/nvme: Use QEMU_PACKED on hardware/packet structures
      hw/block/nvme: Fix pmrmsc register size
      hw/block/nvme: Align I/O BAR to 4 KiB

 MAINTAINERS           |    2 +
 block/nvme.c          |   22 +-
 hw/block/nvme.c       | 1136 +++++++++++++++++++++++++++++++++++++++++--------
 hw/block/nvme.h       |   26 +-
 hw/block/trace-events |   31 +-
 include/block/nvme.h  |  271 +++++++++---
 6 files changed, 1248 insertions(+), 240 deletions(-)


