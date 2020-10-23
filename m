Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51768C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:05:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6D042168B
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:05:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MkRiwiBr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6D042168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVzZ3-0003TK-Nr
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 12:05:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60432)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=558518344=alistair.francis@wdc.com>)
 id 1kVyz1-0004Lk-83
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:28:01 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:26170)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=558518344=alistair.francis@wdc.com>)
 id 1kVyyx-0001YB-1B
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:27:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1603466874; x=1635002874;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=yE5+hyUffpnvJ1ZCmkpKdCuq12nvG7F0ktIepyst7zw=;
 b=MkRiwiBry+qmiXVn3q7lVHI+KzTAbD91JRD/bflpzF7HUlxRa5apuGYb
 K0sUPRYuvwgKw9KIEpsqym8b8jPfzr7SsH0xWWmiwF+TW/z5xyaOoQ4ws
 qVVaLbyXtTkcxvpGOvT7iORLbs5LLBdaEIT7FEHMKTIPyxszhMa2KP097
 JlIyrkdZfiF4fhZzQ+fX5SJEKMeRt+zVyQEIHRGr5TdxDlskkfh6BZ0SG
 IyV/sHwy/uk4M7s2sUJ8hmHxGYi0NP9Hp37k5eVjRJLCfugrqj/qOVl5K
 7YbncWtlcojkKK/xG8FLbVlS795Bt0b3Qo+gzXUHwDpzt11N0RekiePYo w==;
IronPort-SDR: rhQYuJ3uLEPf7dazjkXt9OdGtNnxudgyhZ8pSk3qopVPUielJ7/dySWrNTRkHnI17b33kgjCmt
 TsnS+wnBizAmHAB9/j0yVz/NF+8KyiI4GroMpC15tbHyO7yzHgqPn1fTcerqxEw8mLF+n7O8+H
 EbWf4MJyql29Y/fEQeI29OLQeUdJxlY3Ze+SW7LnWflVLaVzwLCEThc/6+BJvfkWfr/sCYlQ0i
 BVt55HGG4MFf35ouafs5+CfowhfBI7mR1CjuG5YznWB42E1BlFROhVPT3AlSpDcU+2DwS4ZYxC
 uAo=
X-IronPort-AV: E=Sophos;i="5.77,408,1596470400"; d="scan'208";a="150652324"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 23 Oct 2020 23:27:44 +0800
IronPort-SDR: Ju1xbu79q094sol0WuPh0grpDTw7UjCyjrXRW38Y+PvHtIBhwVFBpVlOWkGvI3TWB0Soh8AZH2
 pzusxyX7T/0O3PIgjs+lKGauZdUs3vvZankFJD5d1+uGo+4dzQ2ozIKWxgcfRpUUIaoDNZDGCZ
 BAyHryDb+TAxJcu6XJkPJm+qI62H4+AgIfURVEzsGWp2q366V6ZeUJHw5NAAFz0hThuZem9u6z
 t6L7PeBsCJcrGsdz278LO9frL/af3OoLnT19aZRHBmMrL77G8oBZ9O6U1PDD/LkBoeLCoMlE+B
 mtQ5GOiecCtU0xD9X9ciS5Dw
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2020 08:12:59 -0700
IronPort-SDR: eifaaHkjO/mk24lCjubU+bvgeVxZIsP/YIEzsTSfoOxeyKhYVTS0G7drn5ilN8nc9aBA4kItk1
 iNjKSXDQraZwIbn8yMhDXcL1fK2xAx7GmHGi72GE6WeoanDhbpmDwAwP7otk519XY0AEzeUi2V
 X9OzKUCFC3Fv8fsMblkUXwBK3kGqII0Yj3wKSgVUe8xjVe+gB1FIIWe4n5pDrTmCV2q7yMcDI6
 wG2diwnB7KOMx/RhIXlTg3nzstJsf4AlrFU75crDeEfs4rLSdOH4XvLBXdvM7AX0Qgte+z8qg/
 7WY=
WDCIronportException: Internal
Received: from cnf006900.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.60.46])
 by uls-op-cesaip02.wdc.com with ESMTP; 23 Oct 2020 08:27:44 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 08/12] hw/riscv: Add a riscv_is_32_bit() function
Date: Fri, 23 Oct 2020 08:16:15 -0700
Message-Id: <20201023151619.3175155-9-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201023151619.3175155-1-alistair.francis@wdc.com>
References: <20201023151619.3175155-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=558518344=alistair.francis@wdc.com;
 helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 11:27:42
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
Cc: Bin Meng <bin.meng@windriver.com>, alistair23@gmail.com,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
Reviewed-by: Bin Meng <bin.meng@windriver.com>
Tested-by: Bin Meng <bin.meng@windriver.com>
Message-id: 4c6a85dfb6dd470aa79356ebc1b02f479c2758e0.1602634524.git.alistair.francis@wdc.com
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


