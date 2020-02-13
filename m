Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B101C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 14:52:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBF862082F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 14:52:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jL6r7CiK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBF862082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2Fqz-0000E6-0o
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 09:52:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60121)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2Fgk-0004BI-1M
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:41:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2Fgi-0001Tg-JS
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:41:57 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51713)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2Fgi-0001R6-Bm
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:41:56 -0500
Received: by mail-wm1-x343.google.com with SMTP id t23so6543098wmi.1
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 06:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=bLlb0z2duQkI+Q2aALcxB/tkS6BOKIX9RgY26xXMpws=;
 b=jL6r7CiKawvDxqjJJJMzLEQoA6d1ZfruWlifdKSFpIxxVmSFuThM0T3F5xq0sT8Nqc
 rufPIc5Pwo6/tEY85SRJ81m3brtWxUSbJpci43oD04fMSDl9b1LmMxuvZD7wt5HNBFaA
 2FhjCULbGBtaDFkUW3iN4gH9wfSnbx3WefoTLCTEX2fTIuVn/xSBSl52dxh0iB1A5e6U
 l3I2RMSoQKiOyC8W2sNpxrDCdZeQYbBVl1xcjTRHMGYP+fLVVlMS9OsX65NesamQW3pG
 60DohEAvOJtiyCozUiYrukp3jXYWndi1woERSlBQ8Y/UBxIUyPTKsYfHyUfiuNfdeOE3
 s/+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bLlb0z2duQkI+Q2aALcxB/tkS6BOKIX9RgY26xXMpws=;
 b=JpB+A5m2pQk3FVeNLiq4G+A3AH5/vxYdZJ7EKfg34UC8eXFZi9VCQ1IDil1O8NEkES
 KNoQvNwmkcr1FKbl+VF5aX2VQnG7UtHLNnGaKm8XfvjZrO9EzfxAQWpyC3hShKEA1WHP
 ryEnW57f/+q+d5wOlNt79dKs2dgg4stvPcW7wYtvmpkGHZGvjCy2YP1G79invSltOH7K
 jKtw8LPsSWUmhLBCWt/sbVNeiqRbOIw6gHRGgkXoSlXlfOiM7PhDVKVfu24CByD9GW/E
 ZtFCpiRQWPpioPm6mJRHEOT6e+zhPYjVqpnkxD9I0/sq6qmJqGoXv+rvqL8BlMLpbaFT
 DtFA==
X-Gm-Message-State: APjAAAX9aTAgvoxAd72mzpJE9mKBNiQzrLi+e3b6H1HB/piGOt6npGYt
 yYYo5WQHE5i0rnd6Du3B+LAIRYTM3lY=
X-Google-Smtp-Source: APXvYqwqzVxKYTMx6IpFuyBUsA2HRPxNKzdjMeXQaooaLuailUOU18K7KUYUcLzjeQuiz07wzfZcyg==
X-Received: by 2002:a1c:9854:: with SMTP id a81mr6006141wme.1.1581604915018;
 Thu, 13 Feb 2020 06:41:55 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e22sm3362454wme.45.2020.02.13.06.41.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 06:41:54 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/46] arm/acpi: fix PCI _PRT definition
Date: Thu, 13 Feb 2020 14:41:05 +0000
Message-Id: <20200213144145.818-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200213144145.818-1-peter.maydell@linaro.org>
References: <20200213144145.818-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Heyi Guo <guoheyi@huawei.com>

The address field in each _PRT mapping package should be constructed
with high word for device# and low word for function#, so it is wrong
to use bus_no as the high word. The existing code adds a bunch useless
entries with device #s above 31. Enumerate all possible slots
(i.e. PCI_SLOT_MAX) instead.

Signed-off-by: Heyi Guo <guoheyi@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-id: 20200204014325.16279-5-guoheyi@huawei.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt-acpi-build.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index be752c0ad8e..5d157a9dd5e 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -151,7 +151,7 @@ static void acpi_dsdt_add_pci(Aml *scope, const MemMapEntry *memmap,
 {
     int ecam_id = VIRT_ECAM_ID(highmem_ecam);
     Aml *method, *crs, *ifctx, *UUID, *ifctx1, *elsectx, *buf;
-    int i, bus_no;
+    int i, slot_no;
     hwaddr base_mmio = memmap[VIRT_PCIE_MMIO].base;
     hwaddr size_mmio = memmap[VIRT_PCIE_MMIO].size;
     hwaddr base_pio = memmap[VIRT_PCIE_PIO].base;
@@ -170,12 +170,12 @@ static void acpi_dsdt_add_pci(Aml *scope, const MemMapEntry *memmap,
     aml_append(dev, aml_name_decl("_CCA", aml_int(1)));
 
     /* Declare the PCI Routing Table. */
-    Aml *rt_pkg = aml_varpackage(nr_pcie_buses * PCI_NUM_PINS);
-    for (bus_no = 0; bus_no < nr_pcie_buses; bus_no++) {
+    Aml *rt_pkg = aml_varpackage(PCI_SLOT_MAX * PCI_NUM_PINS);
+    for (slot_no = 0; slot_no < PCI_SLOT_MAX; slot_no++) {
         for (i = 0; i < PCI_NUM_PINS; i++) {
-            int gsi = (i + bus_no) % PCI_NUM_PINS;
+            int gsi = (i + slot_no) % PCI_NUM_PINS;
             Aml *pkg = aml_package(4);
-            aml_append(pkg, aml_int((bus_no << 16) | 0xFFFF));
+            aml_append(pkg, aml_int((slot_no << 16) | 0xFFFF));
             aml_append(pkg, aml_int(i));
             aml_append(pkg, aml_name("GSI%d", gsi));
             aml_append(pkg, aml_int(0));
-- 
2.20.1


