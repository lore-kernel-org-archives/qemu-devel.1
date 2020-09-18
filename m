Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E8DC43465
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 08:43:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FED42176B
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 08:43:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="ObvCt7Gv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FED42176B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJByy-00030T-CD
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 04:43:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36828)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kJBxN-0001Fo-DA
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 04:41:25 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431]:43496)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kJBxK-0007n3-Py
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 04:41:25 -0400
Received: by mail-pf1-x431.google.com with SMTP id f18so2990757pfa.10
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 01:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=GdgweBFiZYARuCVoz1uNH+aYHDiFtvCUWBa8dNRXSzk=;
 b=ObvCt7GvTbWP8WiCl0okf1dYdh7WBq5xFXfDLw1cJ6imVBfRdTzQBTDraFb4VpFEd8
 UiLJl+RCXBND2LqcGfE2+ZVvVeLfEr2P8mNLNCE8ywq9Mt6X1yyS54aGmZgqhmffms2g
 AI23xwMGMsYLOP++cvqN6ZN12mrU7pWVWw1llHnse7wImXWHxM0lNkWr5aA2LL4O1Mdp
 xsMgyzVqVzM8Pn3NyvCPq0e0E7OfCYc8RL+GB5o5nfV4ST4YgFBi9TCt6X7dibvfy18T
 g5JYw8s4usU6Z8EC/xUh39R+MtC7O1hDQsYyvGyapE3ptFuxCiz4UuhzHeW59XGik7Ag
 E+WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=GdgweBFiZYARuCVoz1uNH+aYHDiFtvCUWBa8dNRXSzk=;
 b=MncFPObQIIL3Lgx8ueUERHLv6CUv8KJjJnugtRreTzusgPPIvKkmDnoECNozU3Jtvg
 KAKSJ6rtRPHcg71BY0uApZXeTEX/qLg7JmZsnAjvw3pNLvAOFTLd7d8RfXeH9iMwi4uo
 BU6NFSEEzbbTbkR9+okeo0HtakmuGuK2UJzeaOHXYVo6muKoo5BX5hcGZEjtrb2ql5yH
 bPUKbcVSmtzCufDrfq/lRSnKV+R+1GxlsuuX2daIo6W2W0zKpaBX6PJJ7orRzFxAY6bV
 g+B74t9oE3n82V+8JW5y7QUC4gyu/Y33qaz/SDZGH7UuCctyzadV68vHKokmSpWd9RUv
 VdKA==
X-Gm-Message-State: AOAM533LZSjk+k0K3DpeVP8fZvvL2etmA4G+ITEdKLByQPCdrA9Z89i1
 W8OsXB2RdCsuDtJhQlrW76+dmA==
X-Google-Smtp-Source: ABdhPJyQqMxBTUq86BT9AskTLlGpTvspHIoO7eWy4p0+vNpvCzazscyp9Ece1t+97hhQDrqF6TULSg==
X-Received: by 2002:a63:7018:: with SMTP id l24mr25085668pgc.55.1600418481078; 
 Fri, 18 Sep 2020 01:41:21 -0700 (PDT)
Received: from localhost.localdomain ([115.96.124.157])
 by smtp.googlemail.com with ESMTPSA id gi20sm2120603pjb.28.2020.09.18.01.41.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 01:41:19 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
To: mst@redhat.com,
	qemu-devel@nongnu.org
Subject: [PATCH v10 00/13]  i440fx/acpi: addition of feature and bug fixes.
Date: Fri, 18 Sep 2020 14:10:58 +0530
Message-Id: <20200918084111.15339-1-ani@anisinha.ca>
X-Mailer: git-send-email 2.17.1
Received-SPF: none client-ip=2607:f8b0:4864:20::431;
 envelope-from=ani@anisinha.ca; helo=mail-pf1-x431.google.com
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, jusual@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <ani@anisinha.ca>,
 Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Final patch series with all the patches reviewed or ack'd and marked as such.
Thanks Julia and Igor for the reviews. Hope this series gets pulled in soon.

--Ani

Ani Sinha (13):
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
  Add ACPI DSDT tables for q35 that are being updated by the next patch
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


