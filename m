Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01223C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 21:43:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C011E20DD4
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 21:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hQQMLtVu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C011E20DD4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbA13-0000qz-DE
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 17:43:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39040)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=401675184=alistair.francis@wdc.com>)
 id 1jb9xu-0004GI-1o; Tue, 19 May 2020 17:39:58 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:10353)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=401675184=alistair.francis@wdc.com>)
 id 1jb9xs-0008Nj-KQ; Tue, 19 May 2020 17:39:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1589924407; x=1621460407;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=F6PaS0ppWoREt+I7H+MwgSoKprK6XgKjP6if/dnLS2k=;
 b=hQQMLtVu+0nDTCLHOKHDcHsSzDk2Oyot20ufQVjxsk6JwgAN1TQucsvi
 3aqIb2N6lg3DulWYtpAuVPdQe65UcK9DGCtjHB7wERBwN4Heyd5l8YWLp
 1yb4ldcXHB6jP0jhOLzJTKJKe/ZRAajlL7kK7AvQ2/LFU1Y7j26/RqeA5
 FlR4Ra58Q4UBlYDfXT14d6gNy+HuXZtdFbLSJpJVqrvIVULMpaeZXY+nj
 8zjUtU/LD6zVjC3LRu2938mKAj08AD+UvpmZbLD6IzV6tVQiLttXugcSC
 aeN+0b5Y58n1yrZyQHv/fmBACAuUrv+48T1XT0LiNx45Y/wpAQWG+qsmL g==;
IronPort-SDR: 8AggHsskYGd6zHDXQotHyHiBVnvnv/tOY8yKvBwau6wtgTMT4lEhL+DR3p0YdPTLxVJrSVtKB+
 bvHwjAgLOEOBmVSkj9eN5IjYxu6LbfOvzk+arN4z1ho1DjTCsVH29RgzF30EACFZ02AswHSbu9
 eal9myWrUyEjrYT3jISPV9FLg6pvWXVsuMndgK/FrQzf/vC3MISQf7OyA+Oi+R/aXL/8Iz4JPH
 N6kXqADJxX9eliePBNxJsMWFhoFyaOmDQpFxKTQ1o593DT99DKw4PC/5xtDXrYyQRtVhJHaJyL
 MQg=
X-IronPort-AV: E=Sophos;i="5.73,411,1583164800"; d="scan'208";a="240814184"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 20 May 2020 05:40:03 +0800
IronPort-SDR: j81j6XbJyz2NBzpG9lSlA4fKKSIPZIoavec7y4wwVLz8QmzZ2IALs2SPIZaKlfZfqI7VhogMYH
 jUmvF6Lmn4aZW0dzVERuVpQpObuZDEYjo=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2020 14:29:24 -0700
IronPort-SDR: jpNlGFh1JgDiWSOXKeLV4tTL2cUX3AWuWSDeTAcOv/wXp7zGLCGZ7HqnBkqqXfy4FwOd3QRhyy
 vfu6agw94Qcg==
WDCIronportException: Internal
Received: from usa005149.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.57.14])
 by uls-op-cesaip01.wdc.com with ESMTP; 19 May 2020 14:39:53 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v3 1/9] riscv/boot: Add a missing header include
Date: Tue, 19 May 2020 14:31:26 -0700
Message-Id: <05ea15f2ec07e1c85273d4897d47c05225b116f6.1589923785.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1589923785.git.alistair.francis@wdc.com>
References: <cover.1589923785.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=401675184=alistair.francis@wdc.com;
 helo=esa2.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 17:39:51
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_PASS=-0.001,
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
Cc: alistair.francis@wdc.com, philmd@redhat.com, bmeng.cn@gmail.com,
 palmer@dabbelt.com, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently every c file that includes boot.h also includes loader.h
before it. Which is why the build works fine. We should be able to
include just boot.h though so this is a small fixup to allow that.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Bin Meng <bin.meng@windriver.com>
---
 include/hw/riscv/boot.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
index 474a940ad5..9daa98da08 100644
--- a/include/hw/riscv/boot.h
+++ b/include/hw/riscv/boot.h
@@ -21,6 +21,7 @@
 #define RISCV_BOOT_H
 
 #include "exec/cpu-defs.h"
+#include "hw/loader.h"
 
 void riscv_find_and_load_firmware(MachineState *machine,
                                   const char *default_machine_firmware,
-- 
2.26.2


