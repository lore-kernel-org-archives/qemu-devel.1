Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A9C3C2BBD1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 15:12:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E03462078D
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 15:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="XoXH3FAu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E03462078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIva3-0000Hq-Ua
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 11:12:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54308)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kIvPP-0001WS-PJ
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 11:01:15 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631]:37501)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kIvP8-0000si-Nu
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 11:01:15 -0400
Received: by mail-pl1-x631.google.com with SMTP id u9so1274697plk.4
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 08:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=y+k9Fl1Snln5TQyJuSkHxx0wDGWPg6vrEjCT/djZxTM=;
 b=XoXH3FAuMWj//g5qkMgBG2PSoRaon53SkRW0unKkt8YYn6nGX3DWuRa03E9AH0JbnJ
 rl1A/StZT4DPe91TgniVJDtFoctJNs4thUrJbPRj3RZVOGHZR7h9ppmsA16gOwJgHkm8
 aiNMYq4KhxJ+FGDzpIvDux6sx1TXfI8WRziMLKA+xRbXedaXj5i4ZCOV/MIKXA47tIHW
 SAMWXB4MXSaMoOGLvsZM6Df6eob5Ge7S6IhfhrCJ4hPB8r/E8PN6kIH2pmpkfN/yAEo5
 I1UoKpdk4QF/GkT6qLyhCvgtu1M+DQjY5GZSbyB3vURsfTJqx/U3cG+EaBuvUFr3LXAY
 2v3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=y+k9Fl1Snln5TQyJuSkHxx0wDGWPg6vrEjCT/djZxTM=;
 b=Gnqm5fa+vOzPFCRAvi6P4KE60jN500rEULmGHFIvbZmQZdSUEzuWhlII9bYYV03em3
 t7+o/9IxMSZqwoLO0w8sKqkxrdmQ+gYVoL73+E50sS+fKY7mOpRg0M48Ehf/QYD8q9JZ
 nlQpKFj09a9GLpuRLQBNR2Zgu4tn+DjpTmbDtFeyFGn73gf+Bec9mZHla28dYt5zipXa
 Ilg0uKmHmTK1vRXhiijsWozPVR3N+xcJHOgG9Zt1RoNMWbcs/4uouiJc2VJs5j0f+OEW
 Gkj3QW+kqwc9L+9vbNcwOLLNrCTvnRrG3n3o5EeXt1qdntUku/VLiLpJRcvS5OLX4CKf
 iv5A==
X-Gm-Message-State: AOAM5329GVsv5W+5Lw4VDOa3SV6NpGEeyMsWDSw3h6MKoKul2wDjttc4
 jWgia8/ESTliRXCf7TeL8bc6JFnhqwPkzLgt
X-Google-Smtp-Source: ABdhPJzn44jCpiXNunPi86DM13GJD37dAO+6va5Ms5tc526gIz6cVbgm2exm3rbfG0BGBfoo/jq6dw==
X-Received: by 2002:a17:902:e9d2:b029:d1:e5e7:be63 with SMTP id
 18-20020a170902e9d2b02900d1e5e7be63mr11258119plk.61.1600354854471; 
 Thu, 17 Sep 2020 08:00:54 -0700 (PDT)
Received: from localhost.localdomain ([115.96.151.231])
 by smtp.googlemail.com with ESMTPSA id e10sm17674374pgb.45.2020.09.17.08.00.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2020 08:00:53 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 00/12] i440fx/acpi: addition of feature and bug fixes.
Date: Thu, 17 Sep 2020 20:30:32 +0530
Message-Id: <20200917150044.23159-1-ani@anisinha.ca>
X-Mailer: git-send-email 2.17.1
Received-SPF: none client-ip=2607:f8b0:4864:20::631;
 envelope-from=ani@anisinha.ca; helo=mail-pl1-x631.google.com
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, jusual@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <ani@anisinha.ca>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In v8, I have updated the commit log for patch #9 mentioning the tables that
are being updated with patch #10.


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


