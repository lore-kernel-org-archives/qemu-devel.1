Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E710C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 19:18:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DB8C205F4
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 19:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qRL2bTMD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DB8C205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBOQd-0000fD-UW
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 15:18:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59049)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tcminyard@gmail.com>) id 1iBOOD-0007X2-Ed
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 15:16:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tcminyard@gmail.com>) id 1iBOOC-0003iP-0z
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 15:16:21 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a]:42229)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1iBOOB-0003iB-Ro
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 15:16:19 -0400
Received: by mail-ot1-x32a.google.com with SMTP id c10so7089855otd.9
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 12:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:reply-to:mime-version
 :content-disposition:user-agent;
 bh=o7+kgu+xY+953dXIXVI5jqUkNpm5tC+MfzzEFDTxHkc=;
 b=qRL2bTMDj7ZMVjB+VIJlaZc6R5NCceJFqs+w3nPi8brFxP0fJWprtR01LvFsImfYun
 hbP7w5ui8PCdnw9FXuImbChlXTNpP4DBsdBQpUg86qF9cWotCgBlhKNB0GVEs93zNLTU
 4gT8qN720M2UggICTtnl1zeLvTJ388D2opb7JqyUQuItJVFD0SPG6JKwcUEe15RgbLal
 t+0ftMQvPdY7yJfjr+iw4vz7/8Mm8bIzxBYjt3GdV5Vzj3shT2q4Vy9pt5Gi6LrAXBwW
 R+ZRsOR2QodKVDQ5g+wKG5BPrT2t+2ppBBXPkFJyBeXEQjRxt9FHNoM1kuyI5ErD1onG
 q62A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :reply-to:mime-version:content-disposition:user-agent;
 bh=o7+kgu+xY+953dXIXVI5jqUkNpm5tC+MfzzEFDTxHkc=;
 b=HV5I2AoCHYx0CSINzIH61l889i88RAeRMuolKJeVVR3rPAsMo5HPbTouwP0yLyfLQ2
 1Y58JHEjyV9isC5/jwYoxir1mGcA6WRJhASKRgbgEwutqkv8WGawxT+EtXZiDWhbHaNL
 oKYeDo+0cITb+i1sgggxAedXfedUKZxLzwZR3SaqzkIy0UNmrrLoHQxNg1GhDLela48F
 ZZqGeAhPx3iVENRIUfdnZW/aN/isNxFurQcT+LaTDHsdV51Lo20ETdbIywKWTYqv/LZM
 nebpZZZFCIAOiPuJej42ReQ32/4gogZ702GeVtPGfv1e3pD5LUyrHwtwtURPVmS80Hab
 9V6A==
X-Gm-Message-State: APjAAAUd8FLL/xrcgfsNP4C7r1dRtGphi8QJkyyngZidLfkKUuQq9D6r
 RWtioZJ6O5l2Q+Nmt1jaPw==
X-Google-Smtp-Source: APXvYqyNnmh9qyo9FrGSyJivjlmT9mWxk5ZEKAeK8+0UOkVpDN1UDOutwtgJc1cJimT7Fi2Pam9yuw==
X-Received: by 2002:a9d:4e0b:: with SMTP id p11mr3034865otf.280.1569006978798; 
 Fri, 20 Sep 2019 12:16:18 -0700 (PDT)
Received: from serve.minyard.net ([47.184.136.59])
 by smtp.gmail.com with ESMTPSA id 67sm950054otq.34.2019.09.20.12.16.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2019 12:16:18 -0700 (PDT)
Received: from t560 (unknown [192.168.27.180])
 by serve.minyard.net (Postfix) with ESMTPSA id 8D98F1800CE;
 Fri, 20 Sep 2019 19:16:17 +0000 (UTC)
Date: Fri, 20 Sep 2019 14:16:16 -0500
From: Corey Minyard <minyard@acm.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL] Request pull for IPMI changes
Message-ID: <20190920191616.GF31565@t560>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32a
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
Reply-To: minyard@acm.org
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit a77d20bafcd4cb7684168a9b4c6dc2a321aaeb50:

  Merge remote-tracking branch 'remotes/kraxel/tags/ui-20190919-pull-request' into staging (2019-09-19 17:16:07 +0100)

are available in the Git repository at:

  https://github.com/cminyard/qemu.git tags/ipmi-for-release-2019-09-20

for you to fetch changes up to ebe15582cafeb944a1c6e99aa526e81a1551c567:

  pc: Add an SMB0 ACPI device to q35 (2019-09-20 14:09:24 -0500)

----------------------------------------------------------------
ipmi: Some bug fixes and new interfaces

Some bug fixes for the watchdog and hopefully the BT tests.

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


