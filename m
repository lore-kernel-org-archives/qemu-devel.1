Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B60C43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 08:20:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EC6F2083B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 08:20:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="lXMDh4wL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EC6F2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kISgB-0000KN-El
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 04:20:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57800)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kISez-0007qT-LW
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 04:19:25 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:40384)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kISew-0004n2-PY
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 04:19:25 -0400
Received: by mail-pl1-x643.google.com with SMTP id bd2so2787751plb.7
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 01:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=4RRJinZ626s75+RY38BBBhUZNE/+tmzL3BTzflthGj8=;
 b=lXMDh4wLGqpl+aB64LPNWHQMfjQliGnI1O5202p2eDnoccnQrTSNsRN52GBKldgGjn
 LSxZQEBSEVxhhZKR8+0DA1lbINkRGo1kl0yptB7mMquH/89HaY41VN/jV6qmyNRk07/L
 xEhoTyTdqeeigAgRk/MA7Iy9JpYs+a8eEAZpv4GnrGmdAs/QwtmIsX9ngbRZNb5mMVLc
 axRH12DOXgm6BlPkhkup3UIoaGMSraV8nm7Zx+Fyqejx/M4ylDOWc1pxxqgLbIYIv/UU
 KsyZbLSRtz0iSow5HcsvbsL0nzRupRQdPuE9Sea7UZpzi2dfY289jP+QlRgiWqiHnsHT
 RXng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=4RRJinZ626s75+RY38BBBhUZNE/+tmzL3BTzflthGj8=;
 b=WCIqYdDaGQWjl9wRA/nevMFYP0oXG5usrtn5hVPVDCqeTA48H+pLrYcQ8L7CDS38cc
 YWp9l7S8gsoTM6pD7xkCmVucr2Y6xeYxgKQapfbDNyTFoSLjF+yjtyRDgaJfI6dvmx1m
 hEwTGEjHm4Qj9JtuDNO5shugX5AKyXq0BQwR/7GQlzkFhZd7Grc6TmoUEVpFmrBT+bHm
 O8NDJ7Cdvux8aCSJ4LpU00JMNW47sm6akGg8Ythk9Z5PfLFr4ToofHUK1FpKUeApSWaK
 eWvgjhoE+U6KAePKCzbyqvNr2kEQzgfKP66G8e474f7pmOm173hZUSV4GPgdZnTIHa3n
 rXLg==
X-Gm-Message-State: AOAM532yRh/1Wfvo577srFr4PO70Ha7/BnmQI2wmYL6EpOJTwR9gqB9d
 OqeS0x9olIGf9Z+GxpffP+e2zucYjQWbKSNn
X-Google-Smtp-Source: ABdhPJyckVNUwmXsZySBl2027n4vCfuYie5LJG8yjslmSSA0FeYwDWsOmR4HQVU1F6cKSA3mYYG6Ag==
X-Received: by 2002:a17:90a:1f43:: with SMTP id
 y3mr2903282pjy.28.1600244360566; 
 Wed, 16 Sep 2020 01:19:20 -0700 (PDT)
Received: from localhost.localdomain ([203.163.234.244])
 by smtp.googlemail.com with ESMTPSA id nl10sm1658254pjb.11.2020.09.16.01.19.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2020 01:19:19 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 00/11] i440fx/acpi: addition of feature and bug fixes.
Date: Wed, 16 Sep 2020 13:48:59 +0530
Message-Id: <20200916081910.977-1-ani@anisinha.ca>
X-Mailer: git-send-email 2.17.1
Received-SPF: none client-ip=2607:f8b0:4864:20::643;
 envelope-from=ani@anisinha.ca; helo=mail-pl1-x643.google.com
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

In v5, I have tried to address all the latest review comments in commit logs
and in patches. Also added "Reviewed-by" and "Acked-by" tags when a particular
patch was already reviewed.

Unit tests pass when the patch series is applied on top of the latest qemu master
branch.

Disassembly of DSDT table is here:  https://pastebin.ubuntu.com/p/WvpYYjpPN8/
when pci hotplug is turned off globally.


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
  tests/acpi: unit test exercising hotplug off for pci root bus & bridge
    in i440fx
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


