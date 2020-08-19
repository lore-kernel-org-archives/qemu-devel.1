Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37682C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 19:23:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 084832078D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 19:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="s8RSA4gX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 084832078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8TgB-0000Ts-9F
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 15:23:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45046)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>) id 1k8Tfb-0008Qk-3f
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 15:22:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:45180)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>) id 1k8TfZ-0000Cm-Az
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 15:22:46 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 805282078D;
 Wed, 19 Aug 2020 19:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1597864962;
 bh=aMgQd33Dgsl7g8th17oHJhl57j+Lvy6p2VK2rAhd+q4=;
 h=Date:From:To:Cc:Subject:From;
 b=s8RSA4gX5cveZukNtAFeu3b8dICd8dKAwvemG6zmyvb5PYIDgDpwMmjDMrKPX5sZB
 MHZzn0xS+aeCf1PyPecdouJCelQzj75iB+7tDh7NJCYE+uWSSOQ/gRtENidqUH7FRI
 dOtIXv6XVjpFxo+jlo7glqOEXQlc9xdatXmfkS+0=
Date: Wed, 19 Aug 2020 12:22:40 -0700
From: Keith Busch <kbusch@kernel.org>
To: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Klaus Jensen <k.jensen@samsung.com>
Subject: [PULL] nvme updates
Message-ID: <20200819192240.GA25305@dhcp-10-100-145-180.wdl.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.145.29.99; envelope-from=kbusch@kernel.org;
 helo=mail.kernel.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 15:22:43
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -80
X-Spam_score: -8.1
X-Spam_bar: --------
X-Spam_report: (-8.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Klaus Jensen <its@irrelevant.dk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We're trying our first nvme pull request from a dedicated development
tree containing various fixes, cleanups, spec compliance, and welcoming
Klaus Jensen to maintaining the emulated nvme device development.

The following changes since commit d0ed6a69d399ae193959225cdeaa9382746c91cc:

  Update version for v5.1.0 release (2020-08-11 17:07:03 +0100)

are available in the Git repository at:

  git://git.infradead.org/qemu-nvme.git nvme-next

for you to fetch changes up to 9257c77e4f0feaefb76f02fff3dc8d60b420ea4d:

  hw/block/nvme: remove explicit qsg/iov parameters (2020-08-17 08:40:54 +0200)

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


