Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97062C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 10:16:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B3F42083B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 10:16:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="LQRS8nuq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B3F42083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIqxe-0007pG-1u
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 06:16:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60132)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kIqs1-0000Qx-9N
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 06:10:29 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631]:46143)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kIqrY-0003Nl-5x
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 06:10:28 -0400
Received: by mail-pl1-x631.google.com with SMTP id f1so853525plo.13
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 03:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=E1N463V/9iLlwdBi10nOjl0uK56HoNPohxGIxGEQCEM=;
 b=LQRS8nuqGIaWniGh30tsFnMeNLvRR6rke8zHq2cRSr0UF4kP2fRhA+DF9DCuqHKers
 CiF9fr/gL0OHr2wLriRPqpP/HZwKpJzjIjx1LefpyHZ3zfWcj77HSIpqYet5mWpVt16h
 aHEltoa8E7cC+z1ju7dHPiaVs4JPvLFOlY1l+Hq5ipcBzbravb48KhCB8ntCqKrPe5e3
 FeYjeX0mY5pS58hmgiwZ7DV1ckjkXF7jg3E5vWkADfMRi9+p62ad3afNH81SHs7HFjXN
 MtKH+PDDZvhk3eiAe1/h3VV4troMawPXDrKi6okOtDRmCC3QGn2HWxa4WrnMNQTjcnmP
 pZ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=E1N463V/9iLlwdBi10nOjl0uK56HoNPohxGIxGEQCEM=;
 b=Z+F+v7+9iBj9vZ//mfLbbozXDd7AVZSGo94gLk2KCZlN/zEm2f6lUbp6SYaTObz4XL
 ZTKPNJcHviolt2/8juV9TCp0RNPBeaggluwVwjtgz61PhUMMAOwICFt5veSBBnz6lHqZ
 7MVv6XtUCvRyFHeUqThYTt/yVwXN8vrd+HbOo/jxRmstoW3pi5olSu12zRmbWK8x0AQt
 jFshpJpXwdZkbkkkbokWDX4O07uFk7kWs6AIHvnUCF5kFrC7IW4OZXGkNIMpnZB+tY6/
 rl3UnPCxpObbsI0W+45RDuYRMCafW4wzUUjxC8yePqq3Yg3rCZO1W3RnPO5P2+NQ4OKL
 j6aA==
X-Gm-Message-State: AOAM532RyUhchEaXA2yK0i4h6DnH0qmY89QGUb2i6YIqROCRRv3RJrgH
 khRd8yzwEq4FhwH8PK5f5AY6nv/YobQx8GSN
X-Google-Smtp-Source: ABdhPJz0sdNiJUM8FQIL9HRhTmcJkM27nORILXoVuax8+kDBvr5Ap7VHOl+bQ3cqM34dPKcDbZbjqQ==
X-Received: by 2002:a17:90b:80f:: with SMTP id
 bk15mr7925076pjb.36.1600337397899; 
 Thu, 17 Sep 2020 03:09:57 -0700 (PDT)
Received: from localhost.localdomain ([115.96.122.113])
 by smtp.googlemail.com with ESMTPSA id d20sm5241559pjv.39.2020.09.17.03.09.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2020 03:09:56 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 00/12] i440fx/acpi: addition of feature and bug fixes.
Date: Thu, 17 Sep 2020 15:39:35 +0530
Message-Id: <20200917100947.21106-1-ani@anisinha.ca>
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
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

In v7, I have updated the commit log for patch #10 to include the diff between the
ACPI DSDT table blobs that were added. This was done to help review the patch and
for documentation.

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


