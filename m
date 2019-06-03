Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A09FC28CC6
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 18:11:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 194EE22ADF
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 18:11:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 194EE22ADF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38987 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXrQC-0003NB-7o
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 14:11:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hXrNg-0001bL-HO
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 14:08:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hXrNf-0007MR-8u
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 14:08:24 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39754)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hXrNf-0007Jb-2i
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 14:08:23 -0400
Received: by mail-qk1-f193.google.com with SMTP id i125so1036190qkd.6
	for <qemu-devel@nongnu.org>; Mon, 03 Jun 2019 11:08:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
	:content-disposition;
	bh=q7PkH4KGoAw9H4xFvKSFsP3JArqDj2E+sHT0DrrM3vE=;
	b=eqZS4FVDECGT1NBch2PWo79TUXGdcZaF3x8vMHOPyDgUh4BLiFx33DcN9+JJtv8p9A
	KPanRMUplYiHzKYZ8VssMf9IolChZbyDrVAWod3gpVo9gBBEzNca/mLmlV02cfydRiKu
	4jcXIqEp6A975y9/x3ZV9rrHWgNQcT46JZ5H4ezcqhPVxSGPCzMmLhtd/c8tD8d4AQ0/
	cMkkUwY68LIvx6nBmreJd3B1+RNN9qEs1hYbpDlVqvODB3vZaQQ4i4I+XybgDC+OIWsE
	jrCXOBOtLueLsKYB5lM19JHCGYzt7WKmCa64DUtXtyt97LCLNHC47l94YArzugbmCD+u
	gSaQ==
X-Gm-Message-State: APjAAAX/MjtmwG4dy8EYEn9humvOJ5p1NS1MVU6XEM/CMRzzkffKVt4y
	uwgMdTGB0C0uTmya1BskyrCch3H0Y4g=
X-Google-Smtp-Source: APXvYqzibBLDqQ9tZo//fN/cpRfQqkErmX2xxHbB3GXu8CqwgnMIfyzAkr8ciKSofjnmfkHLpvMzig==
X-Received: by 2002:ae9:f818:: with SMTP id x24mr22816091qkh.329.1559585301892;
	Mon, 03 Jun 2019 11:08:21 -0700 (PDT)
Received: from redhat.com (pool-100-0-197-103.bstnma.fios.verizon.net.
	[100.0.197.103]) by smtp.gmail.com with ESMTPSA id
	u185sm9123801qkf.67.2019.06.03.11.08.20
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Mon, 03 Jun 2019 11:08:20 -0700 (PDT)
Date: Mon, 3 Jun 2019 14:08:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190603180807.16140-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.222.193
Subject: [Qemu-devel] [PULL v2 00/14] virtio, pci, pc: cleanups, features
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

for you to fetch changes up to df7cafdeb68b6572fa81d2be9a1910547c4dfafc:

  bios-tables-test: list all tables that differ (2019-06-03 08:05:43 -0400)

----------------------------------------------------------------
virtio, pci, pc: cleanups, features

stricter rules for acpi tables: we now fail
on any difference that isn't whitelisted.

vhost-scsi migration.

some cleanups all over the place

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

Liran Alon (1):
      vhost-scsi: Allow user to enable migration

Michael S. Tsirkin (2):
      bios-tables-test: add diff allowed list
      bios-tables-test: list all tables that differ

Nir Weiner (2):
      vhost-scsi: The vhost backend should be stopped when the VM is not running
      vhost-scsi: Add VMState descriptor

Wei Yang (2):
      hw/acpi: Consolidate build_mcfg to pci.c
      acpi: pci: use build_append_foo() API to construct MCFG

 default-configs/i386-softmmu.mak      |   1 +
 include/hw/acpi/acpi-defs.h           |  18 ------
 include/hw/acpi/pci.h                 |   1 +
 include/hw/pci/pci.h                  |   3 +-
 include/hw/pci/pci_bus.h              |   8 ++-
 include/hw/virtio/vhost-scsi-common.h |   1 +
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
 hw/scsi/vhost-scsi.c                  |  57 +++++++++++++++----
 hw/scsi/vhost-user-scsi.c             |   3 +
 hw/virtio/vhost.c                     |   3 +-
 tests/bios-tables-test.c              |  23 +++++++-
 hw/acpi/Kconfig                       |   4 ++
 hw/acpi/Makefile.objs                 |   1 +
 hw/arm/Kconfig                        |   1 +
 qemu-options.hx                       |   2 +-
 29 files changed, 226 insertions(+), 163 deletions(-)
 create mode 100644 tests/bios-tables-test-allowed-diff.h
 create mode 100644 hw/acpi/pci.c


