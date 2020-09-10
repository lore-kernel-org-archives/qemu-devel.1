Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD47C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 18:42:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B52F214F1
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 18:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="g/0kVAuo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B52F214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGRWM-0007iQ-Ek
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 14:42:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57986)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=515d47f05=alistair.francis@wdc.com>)
 id 1kGRCZ-0005Tf-3l
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 14:21:43 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:28256)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=515d47f05=alistair.francis@wdc.com>)
 id 1kGRCK-0002lX-Mg
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 14:21:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1599762088; x=1631298088;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=J90d8Q9PoN5u12oz1BG8t/RQ6CPBiX91YUZTE40VG6g=;
 b=g/0kVAuop5O8B6kbRe2p+mAVwIk8hdTMM5vlPMzKfT5H9RtBry4DEot5
 Ixjel4j23fmM4bAFPbHsGaLI8sV9KEkmKzrfxDZjZxBVg+phNMtzW92OP
 5PTiRfrZe175gUfUf7NiZpoNKWimbyTeNbgHkBWRMDj3Y5wcumdDdEgmc
 pwWd8VbIOcT/JSVW6sMWvUPB26pjfQzbnPPSoheh+TqhxIYvET7cXqK2T
 0ASZDQDPJWN9LmcocwdjRQyR92d+qtQ/0zr3vXohdwippzXqS1XXuvyKa
 o/cXrmVkfNfhR6T/Wz2KSmcW+U1Gac+jtKgBurqrIpawDmeWuKoiJ9yUx A==;
IronPort-SDR: bgTGyrzE+Hkur7Zv+VseYDrkeQet/cwrwvWQjh5Bt9Cka9E74mbyDnlwHIwcROYVkTdM0Dtkej
 T9VZ9V+BSiVDrqT+RZxdVmfp7l4AkLquxDIFTKR6Pv6Pnx2F1y40PycP7OiwRS90Pbd3Z39Mz2
 LhBzJ5gBbCB7wqXPQ8M2L0SKffRKu6snNwSNge9gn91Gv9XBGK0lbTmA9fpEoRzQTmXj9sV8Di
 Xg554eUU0FGeQHKYNx2kQ7FQAp2NRLdz03H1Y44Xx4VWm8KGV7JIVzTvtHDXLTBuWNKBJlxuej
 Fp4=
X-IronPort-AV: E=Sophos;i="5.76,413,1592841600"; d="scan'208";a="146979253"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2020 02:20:22 +0800
IronPort-SDR: RBdfgId9b6OfY0lVV8Gh9C3wBsVKuD1Cp0ktzwd1fH67O4zddj3QJ96zukOSgJsLJl+XyqgGOJ
 emQZ6X9l99Tg==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2020 11:07:39 -0700
IronPort-SDR: 3GWydOA5LkUGxQhtfuerNX78QV/hSX0nOOd4ziMVSk5PmHP5nvmxRkxl5IRYBgoR1DYjYS5Gzj
 /dQTF0Sdo46Q==
WDCIronportException: Internal
Received: from fwvkpc2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.152])
 by uls-op-cesaip01.wdc.com with ESMTP; 10 Sep 2020 11:20:22 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 28/30] hw/riscv: Always build riscv_hart.c
Date: Thu, 10 Sep 2020 11:09:36 -0700
Message-Id: <20200910180938.584205-29-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200910180938.584205-1-alistair.francis@wdc.com>
References: <20200910180938.584205-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=515d47f05=alistair.francis@wdc.com;
 helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 14:20:04
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: alistair23@gmail.com, Bin Meng <bin.meng@windriver.com>,
 Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bin.meng@windriver.com>

Every RISC-V machine needs riscv_hart hence there is no need to
have a dedicated Kconfig option for it. Drop the Kconfig option
and always build riscv_hart.c.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <1599129623-68957-11-git-send-email-bmeng.cn@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/Kconfig     | 9 ---------
 hw/riscv/meson.build | 2 +-
 2 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index 8e0710001b..7d017bc7c3 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -1,6 +1,3 @@
-config HART
-    bool
-
 config IBEX
     bool
 
@@ -10,7 +7,6 @@ config SIFIVE
 
 config SIFIVE_E
     bool
-    select HART
     select SIFIVE
     select SIFIVE_CLINT
     select SIFIVE_GPIO
@@ -22,7 +18,6 @@ config SIFIVE_E
 config SIFIVE_U
     bool
     select CADENCE
-    select HART
     select SIFIVE
     select SIFIVE_CLINT
     select SIFIVE_GPIO
@@ -35,7 +30,6 @@ config SIFIVE_U
 
 config SPIKE
     bool
-    select HART
     select HTIF
     select SIFIVE
     select SIFIVE_CLINT
@@ -44,7 +38,6 @@ config SPIKE
 config OPENTITAN
     bool
     select IBEX
-    select HART
     select UNIMP
 
 config RISCV_VIRT
@@ -52,7 +45,6 @@ config RISCV_VIRT
     imply PCI_DEVICES
     imply TEST_DEVICES
     select PCI
-    select HART
     select SERIAL
     select GOLDFISH_RTC
     select VIRTIO_MMIO
@@ -65,7 +57,6 @@ config RISCV_VIRT
 
 config MICROCHIP_PFSOC
     bool
-    select HART
     select SIFIVE
     select SIFIVE_CLINT
     select UNIMP
diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
index f762623288..275c0f7eb7 100644
--- a/hw/riscv/meson.build
+++ b/hw/riscv/meson.build
@@ -1,7 +1,7 @@
 riscv_ss = ss.source_set()
 riscv_ss.add(files('boot.c'), fdt)
 riscv_ss.add(files('numa.c'))
-riscv_ss.add(when: 'CONFIG_HART', if_true: files('riscv_hart.c'))
+riscv_ss.add(files('riscv_hart.c'))
 riscv_ss.add(when: 'CONFIG_OPENTITAN', if_true: files('opentitan.c'))
 riscv_ss.add(when: 'CONFIG_RISCV_VIRT', if_true: files('virt.c'))
 riscv_ss.add(when: 'CONFIG_SIFIVE_E', if_true: files('sifive_e.c'))
-- 
2.28.0


