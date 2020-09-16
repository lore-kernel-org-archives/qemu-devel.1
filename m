Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F77C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 06:29:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B190206A4
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 06:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="Ww8989pv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B190206A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIQwN-0002hW-HS
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 02:29:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59280)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kIQhW-0001RF-Gd
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 02:13:54 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:41641)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kIQhS-0005h1-IJ
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 02:13:52 -0400
Received: by mail-pg1-x542.google.com with SMTP id y1so3294425pgk.8
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2020 23:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=PcCk1GLI4Q58jUzt52DY4ZcRuX2d8nFJDm69ZitJ4Dc=;
 b=Ww8989pvyIpabXzG5BGwtFO/G04N5ZlKxidXaGWGePYK8ajfwzrYPJdVVc9HHOLJgm
 b/vob2Eu+WJmqe6IEnzhvkuUbMw7naO2HYmDnmkFZ/3IefwdsQ9hZvy8xgFJ7RduDo/U
 23EKs7/E4UEXJSJXisYr3nIzuyWKAfjOztcXukASChKmAYo/dNin/Ru3fO37pqNdN4Xa
 M31+fNO8Sp8C7CGGJ8erL8HRO7Cfzw+3b20g9F7FidwunrRyCrizfHKTfe/9Q8TTfgbb
 AiwgXPtAPJDazQBSx+ngZmnxc50J/W47FA2AvBSAjkYBrMr9S0tKIKg3jDo9dA2CNkzg
 opug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=PcCk1GLI4Q58jUzt52DY4ZcRuX2d8nFJDm69ZitJ4Dc=;
 b=Kh8IaZRjim2Pvb3lWyG641E3B5eCq/SF10O+Aq09Cg7Zx3ZlQ7+p0D08YBe0yBqN5X
 xP8yUn41m1Jhs6u8Bj9CEZxlAQCgMS0ujOIVsscC/dCwlnD4hCdYCZMwFFQiyCrZmxTC
 2VwLmjyhaGgYrpjcSqIkNixzxc4/Wb1SLmsyumgLxWrJeCeQMblQnYjrRl50PfmeDFDC
 UjK1WVvBsJWUBI4aANQOLe8aYoqQIAPLGg4ZlV6l4mw26wnqZYUJTScWlzC5WkvACyVb
 cMi9T8RWw7W+jU1+IrLJBC17BYOtSnIno4S3BE2IJTvfS6sDoUW9kIzZnDTkXmT8xLNp
 zXiw==
X-Gm-Message-State: AOAM531DUPWu65I+Lm1bnzwrU+T4qcURifCizCrir3M9X9DuNZnh9xCJ
 7VkseF/08Ap4CSWCvedani+n80qGcp6eBEuv
X-Google-Smtp-Source: ABdhPJxmD9HypI6+cu93r2iNLseJQKoH/9skDGa8JKOmTvy9IL+OR+4IQZ/RxTyeS/KFbTmpTTcddw==
X-Received: by 2002:a63:5b0c:: with SMTP id p12mr16890803pgb.102.1600236828482; 
 Tue, 15 Sep 2020 23:13:48 -0700 (PDT)
Received: from localhost.localdomain ([203.163.234.244])
 by smtp.googlemail.com with ESMTPSA id c20sm583164pfc.209.2020.09.15.23.13.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2020 23:13:47 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 00/11] i440fx/acpi: addition of feature and bug fixes.
Date: Wed, 16 Sep 2020 11:43:24 +0530
Message-Id: <20200916061335.14045-1-ani@anisinha.ca>
X-Mailer: git-send-email 2.17.1
Received-SPF: none client-ip=2607:f8b0:4864:20::542;
 envelope-from=ani@anisinha.ca; helo=mail-pg1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, jusual@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <ani@anisinha.ca>,
 Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In v4 I have made the following changes:

- a cosmetic change for patch #4. Commit log was updated as per Igor's suggestion.
- patches #10 and #11 were added to unit test patch #9.

The DSDT table after disabling hotplug on the root bus and the pci bridges is shown here:

https://pastebin.ubuntu.com/p/WvpYYjpPN8/

This was generated by disassembling the newly added DSDT golden master binary table blob
DSDT.hpbrroot.

I sincerely hope this is the final iteration of the set of patches.  The patches has been
unit tested on top of latest qemu upstream master branch.


Ani Sinha (11):
  tests/acpi: document addition of table DSDT.roothp for unit testing
    root pci hotplug on/off
  tests/acpi: add a new unit test to test hotplug off/on feature on the
    root pci bus
  tests/acpi: add a new ACPI table in order to test root pci hotplug
    on/off
  Fix a gap where acpi_pcihp_find_hotplug_bus() returns a
    non-hotpluggable bus
  i440fx/acpi: do not add hotplug related amls for cold plugged bridges
  tests/acpi: list added acpi table binary file for pci bridge hotplug
    test
  tests/acpi: unit test for 'acpi-pci-hotplug-with-bridge-support'
    bridge flag
  tests/acpi: add newly added acpi DSDT table blob for pci bridge
    hotplug flag
  piix4: don't reserve hw resources when hotplug is off globally
  tests/acpi: unit test exercizing hotplug off for pci root bus & bridge
    in i440fx
  tests/acpi: add DSDT.hpbrroot DSDT table blob to test global i440fx
    hotplug

 hw/acpi/pcihp.c                   |  15 ++++++++++
 hw/acpi/piix4.c                   |   6 ++--
 hw/i386/acpi-build.c              |  37 ++++++++++++++---------
 tests/data/acpi/pc/DSDT.hpbridge  | Bin 0 -> 4895 bytes
 tests/data/acpi/pc/DSDT.hpbrroot  | Bin 0 -> 2953 bytes
 tests/data/acpi/pc/DSDT.roothp    | Bin 0 -> 5130 bytes
 tests/data/acpi/q35/DSDT          | Bin 7678 -> 7670 bytes
 tests/data/acpi/q35/DSDT.acpihmat | Bin 9002 -> 8994 bytes
 tests/data/acpi/q35/DSDT.bridge   | Bin 7695 -> 7688 bytes
 tests/data/acpi/q35/DSDT.cphp     | Bin 8141 -> 8133 bytes
 tests/data/acpi/q35/DSDT.dimmpxm  | Bin 9331 -> 9323 bytes
 tests/data/acpi/q35/DSDT.ipmibt   | Bin 7753 -> 7745 bytes
 tests/data/acpi/q35/DSDT.memhp    | Bin 9037 -> 9029 bytes
 tests/data/acpi/q35/DSDT.mmio64   | Bin 8808 -> 8801 bytes
 tests/data/acpi/q35/DSDT.numamem  | Bin 7684 -> 7676 bytes
 tests/data/acpi/q35/DSDT.tis      | Bin 8283 -> 8276 bytes
 tests/qtest/bios-tables-test.c    |  47 ++++++++++++++++++++++++++++++
 17 files changed, 90 insertions(+), 15 deletions(-)
 create mode 100644 tests/data/acpi/pc/DSDT.hpbridge
 create mode 100644 tests/data/acpi/pc/DSDT.hpbrroot
 create mode 100644 tests/data/acpi/pc/DSDT.roothp

-- 
2.17.1


