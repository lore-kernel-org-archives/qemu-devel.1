Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB56FC00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 15:28:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51E902231B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 15:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FaxbEFCL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51E902231B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZblR-0005hf-Bp
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 10:28:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53772)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1kZbkZ-0005DJ-CE; Mon, 02 Nov 2020 10:28:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:47030)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1kZbkT-00004w-Jj; Mon, 02 Nov 2020 10:28:02 -0500
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [129.253.182.57])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id BCE0122453;
 Mon,  2 Nov 2020 15:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1604330874;
 bh=yP/CL1memJ6RSiFZ1u2Xa9ZEXv1P8YFrfTiHa0rmfTg=;
 h=Date:From:To:Cc:Subject:From;
 b=FaxbEFCLInitudTocxzKaOaf0LU7DV9Ip1/iEhPhHqFM9Dc9oMWr2W4qDCiOBV7/I
 Amfz04iOj/AdImokN+9IfE8kZSkhQtg9OpbLxypNJ0ouX/PRPQXLy3kbYomiyH0bcU
 BTnvJf7tmC7OaykGSLXhhHeSBXc9Zy3RJYVWC/1Y=
Date: Tue, 3 Nov 2020 00:27:47 +0900
From: Keith Busch <kbusch@kernel.org>
To: peter.maydell@linaro.org, qemu-devel@nongnu.org
Subject: [PULL] nvme emulation patches for 5.2
Message-ID: <20201102152747.GA28552@redsun51.ssa.fujisawa.hgst.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Received-SPF: pass client-ip=198.145.29.99; envelope-from=kbusch@kernel.org;
 helo=mail.kernel.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 10:27:54
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
Cc: its@irrelevant.dk, k.jensen@samsung.com, kbusch@kernel.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

We are sorting out Klaus' signature authentication this week, but in the
interest of timing, I've signed our pull request for this round.

The following changes since commit 1dc887329a10903940501b43e8c0cc67af7c06d5:

  Merge remote-tracking branch 'remotes/philmd-gitlab/tags/sd-next-20201026' into staging (2020-10-26 17:19:26 +0000)

are available in the Git repository at:

  git://git.infradead.org/qemu-nvme.git tags/pull-nvme-20201102

for you to fetch changes up to 843c8f91a7ad63f8f3e4e564d3f41f3d030ab8a9:

  hw/block/nvme: fix queue identifer validation (2020-10-27 11:29:25 +0100)

nvme emulation patches for 5.2

  - lots of cleanups
  - add support for scatter/gather lists
  - add support for multiple namespaces (adds new nvme-ns device)
  - change default pci vendor/device id
  - add support for per-namespace smart log

----------------------------------------------------------------
nvme pull 2 Nov 2020

----------------------------------------------------------------
Dmitry Fomichev (1):
      hw/block/nvme: report actual LBA data shift in LBAF

Gollu Appalanaidu (4):
      hw/block/nvme: add support for sgl bit bucket descriptor
      hw/block/nvme: fix prp mapping status codes
      hw/block/nvme: fix create IO SQ/CQ status codes
      hw/block/nvme: fix queue identifer validation

Keith Busch (5):
      hw/block/nvme: remove pointless rw indirection
      hw/block/nvme: fix log page offset check
      hw/block/nvme: support per-namespace smart log
      hw/block/nvme: validate command set selected
      hw/block/nvme: support for admin-only command set

Klaus Jensen (20):
      hw/block/nvme: fix typo in trace event
      pci: pass along the return value of dma_memory_rw
      hw/block/nvme: handle dma errors
      hw/block/nvme: commonize nvme_rw error handling
      hw/block/nvme: alignment style fixes
      hw/block/nvme: add a lba to bytes helper
      hw/block/nvme: fix endian conversion
      hw/block/nvme: add symbolic command name to trace events
      hw/block/nvme: refactor aio submission
      hw/block/nvme: default request status to success
      hw/block/nvme: harden cmb access
      hw/block/nvme: add support for scatter gather lists
      hw/block/nvme: refactor identify active namespace id list
      hw/block/nvme: support multiple namespaces
      pci: allocate pci id for nvme
      hw/block/nvme: change controller pci id
      hw/block/nvme: update nsid when registered
      hw/block/nvme: reject io commands if only admin command set selected
      hw/block/nvme: add nsid to get/setfeat trace events
      hw/block/nvme: add trace event for requests with non-zero status code

 MAINTAINERS            |   1 +
 docs/specs/nvme.txt    |  23 ++
 docs/specs/pci-ids.txt |   1 +
 hw/block/meson.build   |   2 +-
 hw/block/nvme-ns.c     | 168 +++++++++
 hw/block/nvme-ns.h     |  74 ++++
 hw/block/nvme.c        | 915 +++++++++++++++++++++++++++++++++++--------------
 hw/block/nvme.h        |  83 ++++-
 hw/block/trace-events  |  32 +-
 hw/core/machine.c      |   1 +
 include/block/nvme.h   |  18 +-
 include/hw/pci/pci.h   |   4 +-
 12 files changed, 1022 insertions(+), 300 deletions(-)
 create mode 100644 docs/specs/nvme.txt
 create mode 100644 hw/block/nvme-ns.c
 create mode 100644 hw/block/nvme-ns.h


