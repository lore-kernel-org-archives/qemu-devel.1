Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86731C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:41:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C259205CB
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VBLIXfmA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C259205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZF2u-0005GX-B8
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 10:41:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39602)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZEkX-0003VJ-LC
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:22:15 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53402)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZEkV-0005oP-4N
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:22:13 -0400
Received: by mail-wm1-x343.google.com with SMTP id k12so30571570wmj.3
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 07:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=+e0KnBNeEY/okZVW+Hjye5rPrfTMQhkiDKc5yXXoSU4=;
 b=VBLIXfmAf4K376cKrO9sTpMeuA3X66xHaYy/IKsmoDT+ysGpvXiFCKrXjm1A9CTh+J
 8fRoX1y5LVqVPBj3o59tjyIvX8dj9KCg2J6xMnhO03Yyr55wJkTuOxTjgt55pNlXHWB7
 vmp6yjTvsjSBBvywrGiKowDpCDX8ZkfsckDJD3EjE1xUs5HGK5y+yHxDvPeyCjc8BbVL
 gEF/duWHGTp9/avbDu8K4/MeVPRHrCAsgTwBlr0iTpan0/XPNlCLg3JfeRKWA8SSmBvG
 7I9F7Ikg2GcRdklTNuk2EPk+AHWRkiRv2Xq/O/ZsE6VS1POzImjXxSFQOcchk7AsBfAC
 Rshg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+e0KnBNeEY/okZVW+Hjye5rPrfTMQhkiDKc5yXXoSU4=;
 b=g07n6LGkZ2D2uGm6wnQ+3FgMYYRKVrW710r+nvMbFlrNYy6BX+OF7jtCaWtcbc/zod
 6Gkrbn3T94B16MBTJM+AtBzmBL+BtrsvLc+q/Iq7Gbj79mViHfK6vpb/XB4e4XhDho7Z
 7DnDuLjwlhFbrqRY6vUhwbp9+nRxeX05L+nXOwTJTQYSfr6V7D9wk84g7LbWSz4yVZHi
 9Yrf0Rk3bICCmgkiqhKTS/xsIUPbo5Rt5TykRwJiQmLJXpHaeDr8GktAcEHQGOwwjoKe
 DJ+Y2Ku4SU8wEHHRLTBddrhrw70EnUKJUpaR6TbHS+zCuwVoOl7Z7cPet8CwQ55kD/Ml
 k2Aw==
X-Gm-Message-State: AGi0PuYY3S21ScCLuOFhBuxSyXxlZEriLNa+fxiQhdAJs1v4NFZZL2fG
 xmfTdwd2fM/uAXSYqs8YiMZcT17klcQOWw==
X-Google-Smtp-Source: APiQypK43fo9AFBtWLITSRznHkGcXEBOJHi/fw1kepES3DwHA7BRNJdmaMFjiNRSrjN6OQKYEmUm5Q==
X-Received: by 2002:a7b:c7d5:: with SMTP id z21mr31974450wmk.112.1589466128405; 
 Thu, 14 May 2020 07:22:08 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 88sm4077443wrq.77.2020.05.14.07.22.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2020 07:22:07 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/45] docs: APEI GHES generation and CPER record description
Date: Thu, 14 May 2020 15:21:14 +0100
Message-Id: <20200514142138.20875-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514142138.20875-1-peter.maydell@linaro.org>
References: <20200514142138.20875-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x343.google.com
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

From: Dongjiu Geng <gengdongjiu@huawei.com>

Add APEI/GHES detailed design document

Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
Signed-off-by: Xiang Zheng <zhengxiang9@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-id: 20200512030609.19593-4-gengdongjiu@huawei.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/specs/acpi_hest_ghes.rst | 110 ++++++++++++++++++++++++++++++++++
 docs/specs/index.rst          |   1 +
 2 files changed, 111 insertions(+)
 create mode 100644 docs/specs/acpi_hest_ghes.rst

diff --git a/docs/specs/acpi_hest_ghes.rst b/docs/specs/acpi_hest_ghes.rst
new file mode 100644
index 00000000000..68f1fbe0a4a
--- /dev/null
+++ b/docs/specs/acpi_hest_ghes.rst
@@ -0,0 +1,110 @@
+APEI tables generating and CPER record
+======================================
+
+..
+   Copyright (c) 2020 HUAWEI TECHNOLOGIES CO., LTD.
+
+   This work is licensed under the terms of the GNU GPL, version 2 or later.
+   See the COPYING file in the top-level directory.
+
+Design Details
+--------------
+
+::
+
+         etc/acpi/tables                           etc/hardware_errors
+      ====================                   ===============================
+  + +--------------------------+            +----------------------------+
+  | | HEST                     | +--------->|    error_block_address1    |------+
+  | +--------------------------+ |          +----------------------------+      |
+  | | GHES1                    | | +------->|    error_block_address2    |------+-+
+  | +--------------------------+ | |        +----------------------------+      | |
+  | | .................        | | |        |      ..............        |      | |
+  | | error_status_address-----+-+ |        -----------------------------+      | |
+  | | .................        |   |   +--->|    error_block_addressN    |------+-+---+
+  | | read_ack_register--------+-+ |   |    +----------------------------+      | |   |
+  | | read_ack_preserve        | +-+---+--->|     read_ack_register1     |      | |   |
+  | | read_ack_write           |   |   |    +----------------------------+      | |   |
+  + +--------------------------+   | +-+--->|     read_ack_register2     |      | |   |
+  | | GHES2                    |   | | |    +----------------------------+      | |   |
+  + +--------------------------+   | | |    |       .............        |      | |   |
+  | | .................        |   | | |    +----------------------------+      | |   |
+  | | error_status_address-----+---+ | | +->|     read_ack_registerN     |      | |   |
+  | | .................        |     | | |  +----------------------------+      | |   |
+  | | read_ack_register--------+-----+ | |  |Generic Error Status Block 1|<-----+ |   |
+  | | read_ack_preserve        |       | |  |-+------------------------+-+        |   |
+  | | read_ack_write           |       | |  | |          CPER          | |        |   |
+  + +--------------------------|       | |  | |          CPER          | |        |   |
+  | | ...............          |       | |  | |          ....          | |        |   |
+  + +--------------------------+       | |  | |          CPER          | |        |   |
+  | | GHESN                    |       | |  |-+------------------------+-|        |   |
+  + +--------------------------+       | |  |Generic Error Status Block 2|<-------+   |
+  | | .................        |       | |  |-+------------------------+-+            |
+  | | error_status_address-----+-------+ |  | |           CPER         | |            |
+  | | .................        |         |  | |           CPER         | |            |
+  | | read_ack_register--------+---------+  | |           ....         | |            |
+  | | read_ack_preserve        |            | |           CPER         | |            |
+  | | read_ack_write           |            +-+------------------------+-+            |
+  + +--------------------------+            |         ..........         |            |
+                                            |----------------------------+            |
+                                            |Generic Error Status Block N |<----------+
+                                            |-+-------------------------+-+
+                                            | |          CPER           | |
+                                            | |          CPER           | |
+                                            | |          ....           | |
+                                            | |          CPER           | |
+                                            +-+-------------------------+-+
+
+
+(1) QEMU generates the ACPI HEST table. This table goes in the current
+    "etc/acpi/tables" fw_cfg blob. Each error source has different
+    notification types.
+
+(2) A new fw_cfg blob called "etc/hardware_errors" is introduced. QEMU
+    also needs to populate this blob. The "etc/hardware_errors" fw_cfg blob
+    contains an address registers table and an Error Status Data Block table.
+
+(3) The address registers table contains N Error Block Address entries
+    and N Read Ack Register entries. The size for each entry is 8-byte.
+    The Error Status Data Block table contains N Error Status Data Block
+    entries. The size for each entry is 4096(0x1000) bytes. The total size
+    for the "etc/hardware_errors" fw_cfg blob is (N * 8 * 2 + N * 4096) bytes.
+    N is the number of the kinds of hardware error sources.
+
+(4) QEMU generates the ACPI linker/loader script for the firmware. The
+    firmware pre-allocates memory for "etc/acpi/tables", "etc/hardware_errors"
+    and copies blob contents there.
+
+(5) QEMU generates N ADD_POINTER commands, which patch addresses in the
+    "error_status_address" fields of the HEST table with a pointer to the
+    corresponding "address registers" in the "etc/hardware_errors" blob.
+
+(6) QEMU generates N ADD_POINTER commands, which patch addresses in the
+    "read_ack_register" fields of the HEST table with a pointer to the
+    corresponding "read_ack_register" within the "etc/hardware_errors" blob.
+
+(7) QEMU generates N ADD_POINTER commands for the firmware, which patch
+    addresses in the "error_block_address" fields with a pointer to the
+    respective "Error Status Data Block" in the "etc/hardware_errors" blob.
+
+(8) QEMU defines a third and write-only fw_cfg blob which is called
+    "etc/hardware_errors_addr". Through that blob, the firmware can send back
+    the guest-side allocation addresses to QEMU. The "etc/hardware_errors_addr"
+    blob contains a 8-byte entry. QEMU generates a single WRITE_POINTER command
+    for the firmware. The firmware will write back the start address of
+    "etc/hardware_errors" blob to the fw_cfg file "etc/hardware_errors_addr".
+
+(9) When QEMU gets a SIGBUS from the kernel, QEMU writes CPER into corresponding
+    "Error Status Data Block", guest memory, and then injects platform specific
+    interrupt (in case of arm/virt machine it's Synchronous External Abort) as a
+    notification which is necessary for notifying the guest.
+
+(10) This notification (in virtual hardware) will be handled by the guest
+     kernel, on receiving notification, guest APEI driver could read the CPER error
+     and take appropriate action.
+
+(11) kvm_arch_on_sigbus_vcpu() uses source_id as index in "etc/hardware_errors" to
+     find out "Error Status Data Block" entry corresponding to error source. So supported
+     source_id values should be assigned here and not be changed afterwards to make sure
+     that guest will write error into expected "Error Status Data Block" even if guest was
+     migrated to a newer QEMU.
diff --git a/docs/specs/index.rst b/docs/specs/index.rst
index de46a8b5e7d..426632a4755 100644
--- a/docs/specs/index.rst
+++ b/docs/specs/index.rst
@@ -14,3 +14,4 @@ Contents:
    ppc-spapr-xive
    acpi_hw_reduced_hotplug
    tpm
+   acpi_hest_ghes
-- 
2.20.1


