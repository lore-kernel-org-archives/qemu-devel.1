Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE612C4363C
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 15:56:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39D21206C9
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 15:56:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lNU4qKe3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39D21206C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kONPe-0006lh-P0
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 11:56:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48066)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=537b2d3de=alistair.francis@wdc.com>)
 id 1kONCJ-0004Hc-Nc; Fri, 02 Oct 2020 11:42:17 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:29844)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=537b2d3de=alistair.francis@wdc.com>)
 id 1kONCG-00047I-RN; Fri, 02 Oct 2020 11:42:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601653332; x=1633189332;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=JcOoStNrLXLWG/1r+iBFhBgXWdomjHQ9Rs1v5g9tW2A=;
 b=lNU4qKe3h/H5FkRFmWIXR2nFuYtH3hpT73ZniVGBIs7irCWZ1iffWIXX
 UgS+JLBTLE2I3YGV3Bd7/0IWJhUxJ5+BnHW9Yp/a8H/okpJoidtK1Z8+i
 4l6fWv1vnUiqxFUTawFJfL2TSi1Hmw4v7jfh8sgCoHpM34K5RxfJX+ZBV
 QZIDNX8JT+/uwRFhjOPiRffe0reQwqxHCXZFJJpIEEbOHIDwXNn1pXjWJ
 hMC5gEIu68CqVWOJgR3gDY0xXvz3Vbz8lha2Y1aVAuwkEIFiL/42HcMGN
 T53EvES18p+Zry2i1nH49QasNlI6Bd3A+iyN5KWNXEsYlSgVThIHt6x++ g==;
IronPort-SDR: C7QQdtTtFf3Zpi8CzOIEEH92DESlfMbwffwqNpNcTs9zPgag/vNbntx5ytmQgXRma2aO7TkETi
 +SUOpQmBHkSvEhpH+B1MIN78j8EXSRVwID+45ugncEJrkvWs3Oqq/zTX77DeZDKP5y9uNwYiJp
 DWnKYL9bY3TS4BWp3cNMZPP1RtYzKs2KT+y94J8gtyrK5MsAbi0I3yxcD4K4UdgbN8TA+eAE+U
 d3VN821ZnHmvTxj0Rnnw6us7ZInLNIpg86HsS4SSY18HeYVhKHNd3mGbJ9InyirkkD2mDcAV3U
 4Uc=
X-IronPort-AV: E=Sophos;i="5.77,328,1596470400"; d="scan'208";a="258699509"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 02 Oct 2020 23:42:10 +0800
IronPort-SDR: OS2Ntoe6oNuUFUm+TG9fs673RxSaBkiV1SE1PXYMc/iinch8UBdk5dATs77dWdDPTlgX9+Jbf4
 tDk0hZNhMzkA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Oct 2020 08:29:01 -0700
IronPort-SDR: K2l4AZetrL/lIS9yzexH1Xatkze96DT7yfyYTnC/mSwVAv6VJtPBEWDhFaT7nvZY9bF4SRME56
 qdCQhAqLO3tA==
WDCIronportException: Internal
Received: from dbzljc2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.174])
 by uls-op-cesaip02.wdc.com with ESMTP; 02 Oct 2020 08:42:10 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 3/4] hw/riscv: Add a riscv_is_32_bit() function
Date: Fri,  2 Oct 2020 08:31:10 -0700
Message-Id: <76a3cad9eb172108a0e415fe5afd481df42090d0.1601652616.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1601652616.git.alistair.francis@wdc.com>
References: <cover.1601652616.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=537b2d3de=alistair.francis@wdc.com;
 helo=esa1.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/02 11:42:11
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
Cc: alistair.francis@wdc.com, palmer@dabbelt.com, alistair23@gmail.com
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


