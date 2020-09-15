Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 692F9C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 14:44:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF456206A4
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 14:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="SKo4n1kv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF456206A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kICCJ-0006cr-Q7
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 10:44:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33018)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kICB7-00052Z-9u
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 10:43:29 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:54680)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kICB5-0003uB-Go
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 10:43:29 -0400
Received: by mail-pj1-x1043.google.com with SMTP id mm21so1877264pjb.4
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2020 07:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=7dvTww0QmO49WrBWkPajCea2kYj8YbsEv0Uhb1rZ9Ko=;
 b=SKo4n1kvLzGkiFRsKx+nmecspl+JwDjnNj+Fd9yCRObiKTZxyOWIeb4eqI4oKFCegz
 8qSzpz31gG0P30y7YrRP4DLu0o86I3E6JF5lvu0kra36TgcE5wuoHq9S/frkJrdPfq1z
 E/WTUJU4q8ze79yURXTCb0giFzGOeYvxdFkvW5d4Bkf8NUxLPKpZlzpoKyZNAYMMRYzJ
 bsGNasdTqp+ejHbXUefFSB8HWi5mRETy9EuUQj73i6WiMfJmqtUnr7IOmD8QAuJeJPM6
 yCZXLY/FKqNOqdtAU4LjAMSBFbyrRmQvvdsvHflqn+YtVEOoOaikQKLJH5sbY0k+Pq6m
 lzWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=7dvTww0QmO49WrBWkPajCea2kYj8YbsEv0Uhb1rZ9Ko=;
 b=FcR9ex7AFyS1UH28ITUwPUT3VELHiJl9baVENHhfFuSwIoKYIGrayn6+eVQHucbOBK
 i3ZsI42pLnqThayTFB1vCauapJNUCbkWop7fmpTHf+YTmxeDRfADq5+RnD5X3RgwfrYW
 IiX7UNWoWGAO30A5Xj8hVA6EJP1oMU1wVFo7dQpFnGT/kNpcbHszvwk1HUDUYJLwvH+p
 z30cRxI9DO9WGcJURQgYV/eBBvW4ETvdlFbFu19jN64gbjhuih4+Vy3orLHFVQErRyeo
 HecnaTHhH4DoY3DEJ9lAzGJOA1+KNKmKrzwR5ceszZ80ExOwBStciAU7qC8GUi7zjRbz
 Ks5g==
X-Gm-Message-State: AOAM5306/s4HmsAkTlq3y2/8YKHAkQen5NL6GZSDMKE8fs4oY3aQSVHX
 opqliLlyTQUfIx0byS0B/qkkQ8izcVjsoSgm
X-Google-Smtp-Source: ABdhPJzhtLEjmMNVkk2RAoH+I4aUVT1pw5yp5IDPUzE/Yuh0hG869QTeUgSE1gmk+XrDiUi79nF8sQ==
X-Received: by 2002:a17:90b:3444:: with SMTP id
 lj4mr4246889pjb.78.1600181005558; 
 Tue, 15 Sep 2020 07:43:25 -0700 (PDT)
Received: from localhost.localdomain ([115.96.128.178])
 by smtp.googlemail.com with ESMTPSA id r2sm11520693pga.94.2020.09.15.07.43.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2020 07:43:24 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/9] i440fx/acpi: addition of feature and bug fixes.
Date: Tue, 15 Sep 2020 20:13:04 +0530
Message-Id: <20200915144314.4997-1-ani@anisinha.ca>
X-Mailer: git-send-email 2.17.1
Received-SPF: none client-ip=2607:f8b0:4864:20::1043;
 envelope-from=ani@anisinha.ca; helo=mail-pj1-x1043.google.com
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
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <ani@anisinha.ca>,
 Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Updated patch #7 and patch #9.
Update to patch #7 is cosmetic, only commit message update.
Update to patch #9 fixes a bug and also updates the ACPI DSDT gold master
blobs for q35 so that unit tests pass.

Ani Sinha (9):
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

 hw/acpi/pcihp.c                   |  15 +++++++++++++
 hw/acpi/piix4.c                   |   6 +++--
 hw/i386/acpi-build.c              |  35 ++++++++++++++++++++----------
 tests/data/acpi/pc/DSDT.hpbridge  | Bin 0 -> 4895 bytes
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
 tests/qtest/bios-tables-test.c    |  30 +++++++++++++++++++++++++
 16 files changed, 72 insertions(+), 14 deletions(-)
 create mode 100644 tests/data/acpi/pc/DSDT.hpbridge
 create mode 100644 tests/data/acpi/pc/DSDT.roothp

-- 
2.17.1


