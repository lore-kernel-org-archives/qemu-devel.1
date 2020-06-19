Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 479F8C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 06:44:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11FBC207DD
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 06:44:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="PLJHq7Vu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11FBC207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmAlO-0004ln-9a
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 02:44:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56934)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4324eb4de=alistair.francis@wdc.com>)
 id 1jmAbz-0005hA-W4
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 02:34:52 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:61615)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4324eb4de=alistair.francis@wdc.com>)
 id 1jmAbv-00028E-JI
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 02:34:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1592548488; x=1624084488;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=LYV/HV2oePnGMNLANWSHYTsEansGO/O7noO72QkqJrU=;
 b=PLJHq7Vuv6NS1ZawfhrecgtWIX49fz0W+zr9DUSKvK2Y8ypS0WglRg5K
 sFlyU+l3jckClJzfLC8YfGZ4kTL7Q7TTARiwKgh1b6Jq/wnF7dMGX5iM/
 tT4dtlfGYpN9IwKGNjrDwK9fIHHxc5txrehjZyVGTlY1dpXZQFgXn1E2j
 cc+uxFQcohoqSL9bUfdbke8mh/pFP7AlaxRm0ZPJ+BJ2uKXKw2+xjzvmi
 Nr3K54yNiHWQVq9CkO9gPKWEPEqu5ah7qxNLvZUaY5oUGi5Ed6WFdmuJ3
 3oojY2FjKpgY0NieSfiChdTHMAQudOpYdAhDZllAVWWXXwqYvxKUoGzP8 g==;
IronPort-SDR: xxEsy2pSeeTOQrljmUGSJiZdCsh0m8qSahPKms0hJn1YCOVfyA1eA/c1QksGf0uQySuFH5a+UU
 DihYXLm0OmrrtzSYp7nCDAyFMdWia/OoNfF7A4jZoD2VvtNJQwGCtAJuWYt7npNcO/usI3x3dW
 212KWDQpYTWg4pF9o8WZ9+7vxwDzXBPRwAcsCrYgWUYJ2/dE2M5IyXnRetHexLgLpy1kijXV4W
 1ibOzeJfVj8lpm45Q4puv22ZQ+ZW+h6/i5pOJzB1fMvFb3lkmC8S5WvBfLqhgN0fv5enJu/lam
 SL0=
X-IronPort-AV: E=Sophos;i="5.75,253,1589212800"; d="scan'208";a="144724294"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 19 Jun 2020 14:34:29 +0800
IronPort-SDR: KEzOHV/pEAMIl7W6zYvjfgMmvBPHEFmpzzGu3CyUpL/blfqsqzcAuLPDdBifyVRkDpq3o5OnHP
 XaCWbC55HsbEoUUft4UeAZxyQ1zOIxSAA=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2020 23:23:39 -0700
IronPort-SDR: NmXVdURzOhc793feji8UHhM+LkGMc/kUhnPxH2RZRdLSE7Aqd+CVnAWlea6rYoBKNoWemfORui
 en/n74Y/8PJA==
WDCIronportException: Internal
Received: from unknown (HELO risc6-mainframe.hgst.com) ([10.86.58.142])
 by uls-op-cesaip02.wdc.com with ESMTP; 18 Jun 2020 23:34:28 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 11/32] riscv/opentitan: Fix the ROM size
Date: Thu, 18 Jun 2020 23:24:57 -0700
Message-Id: <20200619062518.1718523-12-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619062518.1718523-1-alistair.francis@wdc.com>
References: <20200619062518.1718523-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=4324eb4de=alistair.francis@wdc.com;
 helo=esa3.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 02:34:26
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: Damien Hedde <damien.hedde@greensocs.com>, alistair23@gmail.com,
 Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reported-by: Damien Hedde <damien.hedde@greensocs.com>
---
 hw/riscv/opentitan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/opentitan.c b/hw/riscv/opentitan.c
index f6776da8e9..011e4f7ee2 100644
--- a/hw/riscv/opentitan.c
+++ b/hw/riscv/opentitan.c
@@ -25,12 +25,13 @@
 #include "hw/misc/unimp.h"
 #include "hw/riscv/boot.h"
 #include "exec/address-spaces.h"
+#include "qemu/units.h"
 
 static const struct MemmapEntry {
     hwaddr base;
     hwaddr size;
 } ibex_memmap[] = {
-    [IBEX_ROM] =            {  0x00008000,   0xc000 },
+    [IBEX_ROM] =            {  0x00008000, 16 * KiB },
     [IBEX_RAM] =            {  0x10000000,  0x10000 },
     [IBEX_FLASH] =          {  0x20000000,  0x80000 },
     [IBEX_UART] =           {  0x40000000,  0x10000 },
-- 
2.27.0


