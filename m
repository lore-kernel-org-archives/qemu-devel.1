Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA96C28CC2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 16:39:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43CEE23DE8
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 16:39:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43CEE23DE8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57761 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hW1bR-000195-DZ
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 12:39:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hW1Zl-0008MO-MB
	for qemu-devel@nongnu.org; Wed, 29 May 2019 12:37:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hW1Zk-0002cC-OG
	for qemu-devel@nongnu.org; Wed, 29 May 2019 12:37:17 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38966)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hW1Zk-0002Xm-Jd
	for qemu-devel@nongnu.org; Wed, 29 May 2019 12:37:16 -0400
Received: by mail-qk1-f194.google.com with SMTP id i125so1887297qkd.6
	for <qemu-devel@nongnu.org>; Wed, 29 May 2019 09:37:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
	:content-disposition;
	bh=73IHS6EG1JE03d9TT7MRxxNozRnT25VTHelKRcSvdqU=;
	b=iYbS44fSZwxEMkdbOmI44fCNs3sRw+5gQ0zX+f0bFBT50WjtKyAX7rPx/WqytbWGLm
	tLjHNpv05zFCSmZfZOEZncRudtuVjUF7osKpiQUzxiUvjRkF8LsrzisNoS9tviVw4h2H
	DmokGyDK6LQPBsY1ozC/TNV2Iw43dMtuTlMyHOJeNPrykXKSEa3cGQHoZ6SCk3aUSnE7
	pMEDHK6zQUUk91jjZwbYsTwLvZREKGtadKSzyveUT45xQ98+NXiQoaz6H8GeBdrmmn6x
	v7oxb2k5+2LwRityHY8iMbu+X8+uFJIYlT7r7AnMOkIbnmNwEPIB7oMN1/YBosYEEfEw
	4cDw==
X-Gm-Message-State: APjAAAU01tJN6yzMV6T9Pa0BRHX1xq/95RV9RjU6mIU+YHMg4/GnSCFI
	hCRp2alaXtuCtR6gku72PVYKE6yyPY0=
X-Google-Smtp-Source: APXvYqxc71LYIMvgPYkXG8AUgKMZO1SvFkqfpe7U/tdP0broUhTM6AIhO3SVi/qNBVjF0S+5K4y8tw==
X-Received: by 2002:a37:dcc1:: with SMTP id
	v184mr88344885qki.338.1559147829628; 
	Wed, 29 May 2019 09:37:09 -0700 (PDT)
Received: from redhat.com (pool-100-0-197-103.bstnma.fios.verizon.net.
	[100.0.197.103]) by smtp.gmail.com with ESMTPSA id
	100sm3309348qtb.53.2019.05.29.09.37.07
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Wed, 29 May 2019 09:37:08 -0700 (PDT)
Date: Wed, 29 May 2019 12:37:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190529163604.18560-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.222.194
Subject: [Qemu-devel] [PULL 00/10] virtio, pci, pc: cleanups
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 8c1ecb590497b0349c550607db923972b37f6963:

  Merge remote-tracking branch 'remotes/stsquad/tags/pull-testing-next-280519-2' into staging (2019-05-28 17:38:32 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to 8828a019eec52858140c7368494fb1523971cd5f:

  vhost: fix memory leak in vhost_user_scsi_realize (2019-05-29 12:34:45 -0400)

----------------------------------------------------------------
virtio, pci, pc: cleanups

not a lot going on, just some cleanups all over the place

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
David Gibson (3):
      pcie: Simplify pci_adjust_config_limit()
      pci: Make is_bridge a bool
      pci: Fold pci_get_bus_devfn() into its sole caller

Igor Mammedov (1):
      docs: smbios: remove family=x from type2 entry description

Jie Wang (3):
      vhost: remove the dead code
      vhost: fix incorrect print type
      vhost: fix memory leak in vhost_user_scsi_realize

Michael S. Tsirkin (1):
      bios-tables-test: add diff allowed list

Wei Yang (2):
      hw/acpi: Consolidate build_mcfg to pci.c
      acpi: pci: use build_append_foo() API to construct MCFG

 default-configs/i386-softmmu.mak      |   1 +
 include/hw/acpi/acpi-defs.h           |  18 ------
 include/hw/acpi/pci.h                 |   1 +
 include/hw/pci/pci.h                  |   3 +-
 include/hw/pci/pci_bus.h              |   8 ++-
 tests/bios-tables-test-allowed-diff.h |   1 +
 hw/acpi/pci.c                         |  61 ++++++++++++++++++++
 hw/arm/virt-acpi-build.c              |  17 ------
 hw/i386/acpi-build.c                  |  18 +-----
 hw/pci-bridge/dec.c                   |   4 +-
 hw/pci-bridge/i82801b11.c             |   2 +-
 hw/pci-bridge/pci_bridge_dev.c        |   2 +-
 hw/pci-bridge/pcie_pci_bridge.c       |   2 +-
 hw/pci-bridge/pcie_root_port.c        |   2 +-
 hw/pci-bridge/simba.c                 |   2 +-
 hw/pci-bridge/xio3130_downstream.c    |   2 +-
 hw/pci-bridge/xio3130_upstream.c      |   2 +-
 hw/pci/pci.c                          | 101 +++++++++++++++++-----------------
 hw/pci/pci_host.c                     |  13 +----
 hw/ppc/spapr_pci.c                    |  34 ++++--------
 hw/scsi/vhost-user-scsi.c             |   3 +
 hw/virtio/vhost.c                     |   3 +-
 tests/bios-tables-test.c              |  20 ++++++-
 hw/acpi/Kconfig                       |   4 ++
 hw/acpi/Makefile.objs                 |   1 +
 hw/arm/Kconfig                        |   1 +
 qemu-options.hx                       |   2 +-
 27 files changed, 176 insertions(+), 152 deletions(-)
 create mode 100644 tests/bios-tables-test-allowed-diff.h
 create mode 100644 hw/acpi/pci.c


