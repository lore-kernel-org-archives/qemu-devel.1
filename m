Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA93C49ED7
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 21:56:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A762208C0
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 21:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PbxI/KY5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A762208C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB4Pw-0002PV-IG
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 17:56:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56197)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tcminyard@gmail.com>) id 1iB49M-0001OI-FD
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 17:39:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tcminyard@gmail.com>) id 1iB49K-00067L-KF
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 17:39:40 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:42040)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1iB49K-00066d-Eu
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 17:39:38 -0400
Received: by mail-oi1-x242.google.com with SMTP id i185so9645oif.9
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 14:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id;
 bh=2enA2drY9wCo/Kbo6LykccKQHzAX5G3+0exxgdSFwus=;
 b=PbxI/KY5U17FVMmi07N4QszOJdO8215ZeQd+QmrxM0mDJLoLNoWhEzliX9m9fhVgC7
 3d2r20sLJxXTkdzL8QHlSNNv47KCG9UTW69unxsrxQZIz7449VsDQSP6LMvmPdoymZ20
 q5XfOLVYq6zYUOOmycK60z6Z1nWjqarTubDh0lPySbUAS43nwFWl9CkLQwnojo69LC5y
 BYDxoukHCizBnvcCyfTT6iCSTfK2k17zHIXYgnKGZLM9iC+82wfDY/BYSQq40IEug7KI
 HtFx0ssy4pSSv+iR4Yz2iTPn95M4j5s7CWKsGPSUUN6UtDLY6oKC2Uj9BMyeEB/xlD56
 TfEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
 bh=2enA2drY9wCo/Kbo6LykccKQHzAX5G3+0exxgdSFwus=;
 b=mK8m9GU7RWwQRPL/EqU2ByA7uFHx2YKph2bp65gMZWu4awnj9oOU9eyX/31L8FHPJv
 j/tNa9WD/B2/ApdJDzxD6OdqScWiee+Kd6jEZ8CQBRHsUqOsvKW3PEhgAeCsHCcq9Zsf
 C6h5H4qHKaiFRUyD3eHzABejKKu2pKBpKNnlQxVGtnyXk0KqduiNXkHJ2XshuG2Jyl0w
 /T0i26O6MdTfdp2A55DE/ZW3tS4pm8OV4nFB11kMfwUPSY42Tzwq8ZrjXYyjh/jNAYzC
 p09TPnBaAPbAcv9gCKDBnk0bGeb0Kqrkd5JjnW7mPNYoURnSsLZcf+IJKzYt9QGREklh
 x5tQ==
X-Gm-Message-State: APjAAAV8qZr1D5vPQiE+/aoOb2Gt2ndq/PpoUvwgw9Se3DdDZZNk2Pl6
 QBzs3D/ThuZXq5CkPX3zAQ==
X-Google-Smtp-Source: APXvYqyl5sDjBouSZSrHVbTD88q/TQ0lqvv7rVArKdHqPYdiqL2G1myPRhxuz5M47QPZTD8bKm6xHw==
X-Received: by 2002:aca:fccb:: with SMTP id a194mr71066oii.52.1568929176557;
 Thu, 19 Sep 2019 14:39:36 -0700 (PDT)
Received: from serve.minyard.net ([47.184.136.59])
 by smtp.gmail.com with ESMTPSA id 67sm41696otj.21.2019.09.19.14.39.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2019 14:39:35 -0700 (PDT)
Received: from t560.minyard.net (unknown [192.168.27.180])
 by serve.minyard.net (Postfix) with ESMTPA id 1C3F01800CE;
 Thu, 19 Sep 2019 21:39:35 +0000 (UTC)
From: minyard@acm.org
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 00/15] ipmi: Bug fixes, add new interfaces
Date: Thu, 19 Sep 2019 16:39:09 -0500
Message-Id: <20190919213924.31852-1-minyard@acm.org>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: Fam Zheng <famz@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I haven't gotten a lot of commentary on this, but I assume that means
that everything is ok.  It's been posted a few times and the last time
I received no issues, just a couple of reviews.  I would like more
review.  But I'm not quite sure what to do about that, I've been
hanging on to these changes far too long.

The following changes since commit a77d20bafcd4cb7684168a9b4c6dc2a321aaeb50:

  Merge remote-tracking branch 'remotes/kraxel/tags/ui-20190919-pull-request' into staging (2019-09-19 17:16:07 +0100)

are available in the Git repository at:

  https://github.com/cminyard/qemu.git tags/ipmi-for-release-2019-09-19

for you to fetch changes up to d9b74295c6528fd68cebdea116b283e46543b2a2:

  pc: Add an SMB0 ACPI device to q35 (2019-09-19 14:41:58 -0500)

----------------------------------------------------------------
ipmi: Some bug fixes and new interfaces

Some bug fixes for the watchdog and hopeful the BT tests.

Change the IPMI UUID handling to give the user the ability to set it or
not have it.

Add a PCI interface.

Add an SMBus interfaces.

-corey

----------------------------------------------------------------
Corey Minyard (15):
      ipmi: Fix watchdog NMI handling
      ipmi: Fix the get watchdog command
      ipmi: Generate an interrupt on watchdog pretimeout expiry
      tests:ipmi: Fix IPMI BT tests
      qdev: Add a no default uuid property
      ipmi: Add a UUID device property
      ipmi: Split out KCS-specific code from ISA KCS code
      ipmi: Split out BT-specific code from ISA BT code
      ipmi: Allow a size value to be passed for I/O space
      smbios:ipmi: Ignore IPMI devices with no fwinfo function
      ipmi: Add PCI IPMI interfaces
      ipmi: Add an SMBus IPMI interface
      acpi: Add i2c serial bus CRS handling
      ipmi: Fix SSIF ACPI handling to use the right CRS
      pc: Add an SMB0 ACPI device to q35

 default-configs/i386-softmmu.mak |   3 +
 hw/acpi/aml-build.c              |  40 ++++
 hw/acpi/ipmi-stub.c              |   2 +-
 hw/acpi/ipmi.c                   |  13 +-
 hw/i386/Kconfig                  |   3 +
 hw/i386/acpi-build.c             |  17 +-
 hw/i386/pc_piix.c                |  12 +-
 hw/i386/pc_q35.c                 |   9 +-
 hw/ipmi/Kconfig                  |  15 ++
 hw/ipmi/Makefile.objs            |   5 +-
 hw/ipmi/ipmi.c                   |   6 +-
 hw/ipmi/ipmi_bmc_sim.c           |  30 ++-
 hw/ipmi/ipmi_bt.c                | 437 ++++++++++++++++++++++++++++++++++++++
 hw/ipmi/ipmi_kcs.c               | 423 +++++++++++++++++++++++++++++++++++++
 hw/ipmi/isa_ipmi_bt.c            | 443 ++-------------------------------------
 hw/ipmi/isa_ipmi_kcs.c           | 419 ++----------------------------------
 hw/ipmi/pci_ipmi_bt.c            | 146 +++++++++++++
 hw/ipmi/pci_ipmi_kcs.c           | 146 +++++++++++++
 hw/ipmi/smbus_ipmi.c             | 384 +++++++++++++++++++++++++++++++++
 hw/smbios/smbios_type_38.c       |   3 +
 include/hw/acpi/aml-build.h      |  18 ++
 include/hw/acpi/ipmi.h           |   2 +-
 include/hw/i386/pc.h             |   2 +
 include/hw/ipmi/ipmi.h           |   7 +-
 include/hw/ipmi/ipmi_bt.h        |  73 +++++++
 include/hw/ipmi/ipmi_kcs.h       |  76 +++++++
 include/hw/pci/pci.h             |   1 +
 include/hw/qdev-properties.h     |   7 +
 qemu-options.hx                  |  10 +-
 tests/Makefile.include           |   3 +-
 tests/data/acpi/q35/DSDT         | Bin 7841 -> 7879 bytes
 tests/data/acpi/q35/DSDT.bridge  | Bin 7858 -> 7896 bytes
 tests/data/acpi/q35/DSDT.cphp    | Bin 8304 -> 8342 bytes
 tests/data/acpi/q35/DSDT.dimmpxm | Bin 9494 -> 9532 bytes
 tests/data/acpi/q35/DSDT.ipmibt  | Bin 7916 -> 7954 bytes
 tests/data/acpi/q35/DSDT.memhp   | Bin 9200 -> 9238 bytes
 tests/data/acpi/q35/DSDT.mmio64  | Bin 8971 -> 9009 bytes
 tests/data/acpi/q35/DSDT.numamem | Bin 7847 -> 7885 bytes
 tests/ipmi-bt-test.c             |   6 +-
 39 files changed, 1902 insertions(+), 859 deletions(-)
 create mode 100644 hw/ipmi/ipmi_bt.c
 create mode 100644 hw/ipmi/ipmi_kcs.c
 create mode 100644 hw/ipmi/pci_ipmi_bt.c
 create mode 100644 hw/ipmi/pci_ipmi_kcs.c
 create mode 100644 hw/ipmi/smbus_ipmi.c
 create mode 100644 include/hw/ipmi/ipmi_bt.h
 create mode 100644 include/hw/ipmi/ipmi_kcs.h




