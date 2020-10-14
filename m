Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4EBBC433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 00:33:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45D8E21D40
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 00:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JeUAQs91"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45D8E21D40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSUjg-0004Un-DJ
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 20:33:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51158)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=549b5cc2b=alistair.francis@wdc.com>)
 id 1kSUew-0000Mo-0f; Tue, 13 Oct 2020 20:28:50 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:47540)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=549b5cc2b=alistair.francis@wdc.com>)
 id 1kSUes-0003yq-So; Tue, 13 Oct 2020 20:28:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1602635326; x=1634171326;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=JcOoStNrLXLWG/1r+iBFhBgXWdomjHQ9Rs1v5g9tW2A=;
 b=JeUAQs91BNITqTpqOIqdpY1SxGuVSjrZMcNKCxJe27NZ9D4vLHugTk0m
 MdvEKoKfVA8PM450j6kTvl30r7hJVDjhLdxAe6TJK9pDB0rSnG8AwMOGv
 heGcHAkJ3n56BV+eTmx+ZjfCjjmalldt3ItDq6rNS4Nkvg56Ix+0KxKOp
 AZkm8SSoD0kLlh/j6lvXJYgEqnwkX8D0bRI/Kqe8Oq3S4ryY+hPqPlRHH
 ioS87ZJr566sT5uC1IftghHPkG6jQJ11fRgWvaOhoXzYzGEm1wDXOlUxS
 QwA95XOx2In7XOcvT+QJF+OalHOepxMIs8PdX8ah4725nV9DgB1qDTgQ3 w==;
IronPort-SDR: HeEYARn+GiN7NyAYeLubGzUiRL47u+1DLLRmiEqx3463R0Ew7AJz0GV2K3y0j7BWIGggPD/Bs3
 4ADsoQvKHvz72X3g3FTZ5PsNkLVCDkGLtRQ7FWuLp94SrCf/ebiEkyragj+5dJ22dLgTxr5/gP
 97y6Thn7ZbseCxw/Wtdg+jSnXAKZlYN5HHmMOAomq7O+tpYh+N3cC4i8uKbEgeJYLQu2kV2Rhw
 Q3O3O5D9KAcV96p7iC5r/4W+LoEV7FSccE3FQqcYEHFZ2yxC49NRaq46Q/OXrl3j7DGEBk4OG9
 /aQ=
X-IronPort-AV: E=Sophos;i="5.77,372,1596470400"; d="scan'208";a="259612089"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 14 Oct 2020 08:28:41 +0800
IronPort-SDR: aER6xZoZWe9yd7OZF25iQzdQYHwtoq6dS60K3OTJSC07t0+ES2VXy/AfdnBSJ/JVqatsy3UoDb
 3DhAx0U6qexIg6OU/d2bJuPUCsoRwHLnwywnWorql3dejQoPEhZVPdAadK6RN6JP91HaNdHnOV
 V3PbdoxSjGLOI0kbrZemD8X6gGkFUY+qpkH76hQhGqKFeeo8+ypfAaWyU8jBjx588lpW+nEi/8
 zM6aDqdkftR9w1aMt4UPZRDnjz4t9cDpbML0J/QtuY2WqGdJn+kvK5uhsNj3lqAjfNeN509dHe
 nRvCoy6U1anuAtskofU9lqs+
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2020 17:15:15 -0700
IronPort-SDR: +af+uS0ual1H5EGMZ/qdaRbX+o3zxl9cLv78CRSLJ9oxFMddxxu91ZPV7wWj8HJObGwGZU6gux
 Q6egL/VUUfFu+NbCJpBOJOBqNNI19e9dgKU/2tMqHGNhcszCTAEvyfsvFp0LcoUhlljwzblF74
 g3uDk+Y+70l8uekF/L/RBiOAp77s5EIHDILMMcnApm+BuIfUWsLg4IW1cLJlssd9TI9GEcy7Yo
 K13o+i9a262tRgWLwsgq3ocVWBXUaBiULzrnflQrzktMQiK0Le/D/GZWuc1MRuJzgsPW5O26Yt
 wXM=
WDCIronportException: Internal
Received: from cnf006900.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.60.55])
 by uls-op-cesaip01.wdc.com with ESMTP; 13 Oct 2020 17:28:42 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 3/4] hw/riscv: Add a riscv_is_32_bit() function
Date: Tue, 13 Oct 2020 17:17:30 -0700
Message-Id: <4c6a85dfb6dd470aa79356ebc1b02f479c2758e0.1602634524.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1602634524.git.alistair.francis@wdc.com>
References: <cover.1602634524.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=549b5cc2b=alistair.francis@wdc.com;
 helo=esa1.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 20:28:34
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
Cc: alistair.francis@wdc.com, bmeng.cn@gmail.com, palmer@dabbelt.com,
 alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/riscv/boot.h | 2 ++
 hw/riscv/boot.c         | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
index 0acbd8aa6e..2975ed1a31 100644
--- a/include/hw/riscv/boot.h
+++ b/include/hw/riscv/boot.h
@@ -23,6 +23,8 @@
 #include "exec/cpu-defs.h"
 #include "hw/loader.h"
 
+bool riscv_is_32_bit(MachineState *machine);
+
 target_ulong riscv_find_and_load_firmware(MachineState *machine,
                                           const char *default_machine_firmware,
                                           hwaddr firmware_load_addr,
diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index fa699308a0..5dea644f47 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -40,6 +40,15 @@
 #define fw_dynamic_info_data(__val)     cpu_to_le64(__val)
 #endif
 
+bool riscv_is_32_bit(MachineState *machine)
+{
+    if (!strncmp(machine->cpu_type, "rv32", 4)) {
+        return true;
+    } else {
+        return false;
+    }
+}
+
 target_ulong riscv_find_and_load_firmware(MachineState *machine,
                                           const char *default_machine_firmware,
                                           hwaddr firmware_load_addr,
-- 
2.28.0


