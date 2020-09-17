Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABDF7C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 07:53:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 332DE21D7F
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 07:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="jFuYUBPS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 332DE21D7F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIoje-0007O8-97
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 03:53:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50556)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kIodx-0007XW-8M
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 03:47:49 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d]:34729)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kIodu-0004mu-FF
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 03:47:48 -0400
Received: by mail-pl1-x62d.google.com with SMTP id r19so702165pls.1
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 00:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=ELadQwQtfsMgs1+bBS6WTTyvBwQ6VNDHjDYHEAYmMKo=;
 b=jFuYUBPSQa63FB2itGngAhWPIyCtf4rLXV0kPvj/sKLJ+d+uTsPaZHPHa0vPoX2lPN
 0FjyZzhhEykR9Q3qeIX2yBQd0EF7PKea1ZowjjoPByBpiVoqSmgcjmGt1FSei1BOhKfu
 V12f4rFSG/P5l/i8Y39QFGIYCXwAb7MwRTHZdSw6dQCklBNDnwcFfo2GiuB2j0vmkZAO
 Hl+QRHPUCOAQ81p/H4ZGRCCMigNDXCh6O07Vm67Ah5caMsQ35FRnJIP+W3aXBN/Mh8km
 zG/cxE9fASpt9cKRu1fLUC+rfmP0QtQuuvTopNVqUQZs8TeN0WA+y9ChqVYgtYNcUyZ8
 HULg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=ELadQwQtfsMgs1+bBS6WTTyvBwQ6VNDHjDYHEAYmMKo=;
 b=ukGE37KvtJbeBWPrPie5KUdejQ6z6gGAgHp3W1mVFO3qrTm6YnYFLNAi3xRHfgkWKz
 6suBgPTYfzoZSPK9KRaSu2YgFO4RSC3YTuT0NqdXWzwJscCODXqCPPqWVVY8CjNXTDe6
 TJ5SSr1oUBgs/4wUIoBqLiLhwywYE89037LL/pbAAdbkdDSsfFBH3S64zYktJO78/Ke4
 mEBYfNj8LMwiIOb6516RAy1vNjR2JyYdAOZTOs1VBg/SCzOp6qZd6QAzfhjXAevyVzZa
 UGa7ef8U4aJlpENgtqTfXp+wb522tXQMBEPJj4P+BZrL5lrwlAumf6gK4TZ4HL27/+Xx
 zZZw==
X-Gm-Message-State: AOAM533FJnamaIygy319N72cxRd8ZScx1QQLnfaXj7tDNTI/xOafeZhR
 GBN/7OQRbCU1dl4BNAW6RqDzstCZrNuUmSuA
X-Google-Smtp-Source: ABdhPJz+eJ24p1uCclwzmjB4Adj26Fdn3izmKcz91NhmGMde30rzc3cLS7UnQ20aPDU6pD7yBrC4yg==
X-Received: by 2002:a17:90b:3444:: with SMTP id
 lj4mr7075539pjb.78.1600328864284; 
 Thu, 17 Sep 2020 00:47:44 -0700 (PDT)
Received: from localhost.localdomain ([115.96.122.113])
 by smtp.googlemail.com with ESMTPSA id y3sm20572516pfb.18.2020.09.17.00.47.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2020 00:47:42 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 00/12] i440fx/acpi: addition of feature and bug fixes.
Date: Thu, 17 Sep 2020 13:17:20 +0530
Message-Id: <20200917074733.13612-1-ani@anisinha.ca>
X-Mailer: git-send-email 2.17.1
Received-SPF: none client-ip=2607:f8b0:4864:20::62d;
 envelope-from=ani@anisinha.ca; helo=mail-pl1-x62d.google.com
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

In v6:
- added Acked-by and Reviewed-by for additional patches
- checked 80 col/line limit for commit logs.
- s/amls/acpi code in commit log
- split acpi binary gold master table blobs for q35 into a separate patch
  (hence 12 patch series as opposed to 11).
 

Ani Sinha (12):
  tests/acpi: mark addition of table DSDT.roothp for unit testing root
    pci hotplug
  tests/acpi: add new unit test to test hotplug off/on feature on the
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
  tests/acpi: update golden master DSDT binary table blobs for q35
  tests/acpi: unit test exercising global pci hotplug off for i440fx
  tests/acpi: add DSDT.hpbrroot DSDT table blob to test global i440fx
    hotplug

 hw/acpi/pcihp.c                   |  15 +++++++++
 hw/acpi/piix4.c                   |   6 ++--
 hw/i386/acpi-build.c              |  37 ++++++++++++++--------
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
 tests/qtest/bios-tables-test.c    |  49 ++++++++++++++++++++++++++++++
 17 files changed, 92 insertions(+), 15 deletions(-)
 create mode 100644 tests/data/acpi/pc/DSDT.hpbridge
 create mode 100644 tests/data/acpi/pc/DSDT.hpbrroot
 create mode 100644 tests/data/acpi/pc/DSDT.roothp

-- 
2.17.1


