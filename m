Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30636C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:21:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1D7020823
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mPOd8aCV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1D7020823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbql6-0003Xs-2x
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 15:21:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38000)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jbqg2-00022j-6O
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:16:22 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:35787)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jbqg1-0000PG-7q
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:16:21 -0400
Received: by mail-wr1-x42b.google.com with SMTP id x14so2390693wrp.2
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 12:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=IaZtb9mzc1u3nnOp3gW0dG4QSP8UXW5anJbY4Gmv+gE=;
 b=mPOd8aCVeIw3BIrA8COwOpbC65xMtDwDGDltpBo+xW+4OzHn6PhYcHTa62esAVAmOC
 6xhiLhbk8WcE+Zbwkb+wqk6cJ5TfQ+GL6mJF3P1JELEoj8MCUPNUR7x4Op2wKuMSLCvQ
 20afZg4sSmBFeLkh7EOl2eOlk9PBAHtOBJyufkcChjtI/Ovks4PxIRFLKHwKNhwfc3Ey
 Gf41X2qi6FzKl68gAzU2/giJx1VPM97qCtkV/xywLqZdb1Jh5nz1n+GOyqlRT0LQsXVR
 brrOA3JT9B3FVSSA4umA3yZcE6hDDBWuZzWJPMWybRRQJX41yavg7fPbf0DlMO5hMZwO
 6AZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=IaZtb9mzc1u3nnOp3gW0dG4QSP8UXW5anJbY4Gmv+gE=;
 b=Is/vUCyNdPl7B/91N4Xda00v6/OJKb/hkDixd2cluo3bni9BmAptOj07UlM2/4jN9d
 oDzKlb3Ewa4OGg6unlpZfvOWBaWRNcOiHq94mlu8KUJ6lNvGXCFyCIkKycCBCbwM/ZBP
 2PmF7FF9IR/AvGwsP1f7PbP+3sddyViIk2gakcO6db9TaUpbZ7q+wkBrd4y0kno4Z52f
 kEq2xdaPAZo41+CyFQ0B2qTvdzcWymgLEFs+8w8NF+aphPVVmFIEXVXIgMy5kaZFSOSm
 luIuhJgqQhr6+WtKd/VS7wExskHGeVL+qum5MxfaVMk0IX6bTcCp7V6mpvw06eUUdl//
 v97g==
X-Gm-Message-State: AOAM5308i9T/jh6/SuowzTwQnuGZGQ7jOJL/WUrVgueJKctJg/8UhW/8
 /SaB3Ho4mKObF0TJq1QcnEzXwV8/SP2vSQ==
X-Google-Smtp-Source: ABdhPJyAP96vlXO72zIBHOY96Mn9o7Jq+xx7dCbRbmw8fiwouafysnweMzAC5BB1bxWrCp1JgJ52kA==
X-Received: by 2002:adf:e90b:: with SMTP id f11mr95957wrm.364.1590088579534;
 Thu, 21 May 2020 12:16:19 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z124sm7335100wmg.20.2020.05.21.12.16.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 12:16:18 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/29] docs/system: Document the various MPS2 models
Date: Thu, 21 May 2020 20:15:46 +0100
Message-Id: <20200521191610.10941-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200521191610.10941-1-peter.maydell@linaro.org>
References: <20200521191610.10941-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add basic documentation of the MPS2 board models.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20200507151819.28444-5-peter.maydell@linaro.org
---
 docs/system/arm/mps2.rst   | 29 +++++++++++++++++++++++++++++
 docs/system/target-arm.rst |  1 +
 MAINTAINERS                |  1 +
 3 files changed, 31 insertions(+)
 create mode 100644 docs/system/arm/mps2.rst

diff --git a/docs/system/arm/mps2.rst b/docs/system/arm/mps2.rst
new file mode 100644
index 00000000000..3a98cb59b0d
--- /dev/null
+++ b/docs/system/arm/mps2.rst
@@ -0,0 +1,29 @@
+Arm MPS2 boards (``mps2-an385``, ``mps2-an505``, ``mps2-an511``, ``mps2-an521``)
+================================================================================
+
+These board models all use Arm M-profile CPUs.
+
+The Arm MPS2 and MPS2+ dev boards are FPGA based (the 2+ has a bigger
+FPGA but is otherwise the same as the 2). Since the CPU itself
+and most of the devices are in the FPGA, the details of the board
+as seen by the guest depend significantly on the FPGA image.
+
+QEMU models the following FPGA images:
+
+``mps2-an385``
+  Cortex-M3 as documented in ARM Application Note AN385
+``mps2-an511``
+  Cortex-M3 'DesignStart' as documented in AN511
+``mps2-an505``
+  Cortex-M33 as documented in ARM Application Note AN505
+``mps2-an521``
+  Dual Cortex-M33 as documented in Application Note AN521
+
+Differences between QEMU and real hardware:
+
+- AN385 remapping of low 16K of memory to either ZBT SSRAM1 or to
+  block RAM is unimplemented (QEMU always maps this to ZBT SSRAM1, as
+  if zbt_boot_ctrl is always zero)
+- QEMU provides a LAN9118 ethernet rather than LAN9220; the only guest
+  visible difference is that the LAN9118 doesn't support checksum
+  offloading
diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst
index 1c759aa1a08..f2d9366e9b4 100644
--- a/docs/system/target-arm.rst
+++ b/docs/system/target-arm.rst
@@ -76,6 +76,7 @@ undocumented; you can get a complete list by running
    :maxdepth: 1
 
    arm/integratorcp
+   arm/mps2
    arm/realview
    arm/versatile
    arm/vexpress
diff --git a/MAINTAINERS b/MAINTAINERS
index 6a9280c1b03..520a7b74f28 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -701,6 +701,7 @@ F: hw/misc/armsse-cpuid.c
 F: include/hw/misc/armsse-cpuid.h
 F: hw/misc/armsse-mhu.c
 F: include/hw/misc/armsse-mhu.h
+F: docs/system/arm/mps2.rst
 
 Musca
 M: Peter Maydell <peter.maydell@linaro.org>
-- 
2.20.1


