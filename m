Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24ADFC00454
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 20:03:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0D822073B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 20:03:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0D822073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifUgm-0007ey-P1
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 15:03:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47496)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1ifUel-0005x8-MN
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 15:01:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1ifUej-0004Br-Os
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 15:01:51 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:40711)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1ifUeh-00044p-RP
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 15:01:49 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MwxNF-1hm89L2hHX-00yMRo; Thu, 12 Dec 2019 21:01:44 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/3] q800: fix ESCC base
Date: Thu, 12 Dec 2019 21:01:40 +0100
Message-Id: <20191212200142.15688-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191212200142.15688-1-laurent@vivier.eu>
References: <20191212200142.15688-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:KwNe+eUQl1Ww4Y0vvfXrqZjcejk0ju1XGmCAc2nJz1TxqZBDdej
 kExVBOPe/LBQVy//d681qJLph6cM6WcCz7Z6I39PlvxAu+unV8C77ERhhHvn8ArgR663z2G
 UjKwvJn991dER5x2ILqCZnJpZL+k6neK/Gsm5Nf7PY7ggUKZXJaQM2AA0HTU9zXcwt8g472
 vy6HbnDCszPYrRdpIY/zA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+lGyNolFVvI=:ZkdVY8BgyL1qxWI3zL6ay8
 53aG7ReD2yYXYfAS1qpjMUHATXaF64MmEBC79YvsJGVTJT+zG4QtHIRW6rpRZHHcYMxY3CLlQ
 QsCEmnaGXiNPCBfzE13FA+LrIwfZrBYq9r0yTlvHhvAtlfKDMXWF19a+Sgj27CIJCUthzZqIL
 iH2PzeVIDvkekpsS0Lqgjf9kV/iYe4tUgNPvjNKXXUoAw5tgV2935CNFQ3Mas7Y5PVxiswqzp
 AVQCtXY93Pj6V5/tO4javoJglqMTivzwyk5zRgTq4x/N6/tq2J/Te7pAAxtDvOeu9+AmAsnq7
 E0NM6O+xqVfrWiFk83IHfFbH60gAagcm05y/Wk0rKdOrB2n2HKB7xN0OceQ62N5gLayGkeRI3
 fb2mH8KM3bSza3vqby+wyKoT8K+Xbui6JLnuIT5c7uTBiJEfsU86782D1pml7m+4w66FNzjw1
 yeY2xf4Xr2s+2Wquo7DoWz2xk8kBzqbHiK5nLJnPKesAqFZzPq693bhnIBDoze2XZvyN5rDvB
 9zlHng8T1QaQRrLO4G5YfFiE2g52KMekz4Gmyow8M60gruMK2BNx7q4d4rZI8wvk9LLh05lkN
 GEWbas+hi++MbcutjrvCTW6L+WBaeR7ev0e9l6eccXf4lxbP3mq4d9RBSm6krr111kbWNGgPZ
 vMA4HE++gbqyiBBQfsxwn4/RjZfxVa9nLViy42nj+5g+JxZfjYhUhYFj+SgUvpct4kESmAxph
 yZDiehYa8Iwu9IRenmkZmyo90zEYbbfJvohOQElvCUBJ56QxFGCk8DtyfLtbESJolLvo60uXo
 N4HFL2rCWUueqg/Kpc+EyWZQ0VOa+yyMWGjsngwZH8D2e7GMmdTd41UUVVjfmTeq//51hSn5b
 zrhqWXuhxBrgTuQcImDg==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.17.13
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
Cc: Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

0xc020 is for Q900/Q950, Q800 uses 0xc000.
This value was provided to the kernel, this explains why it was working
even with wrong value

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/m68k/q800.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index 4ca8678007..ef0014f4c4 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -67,7 +67,7 @@
 #define VIA_BASE              (IO_BASE + 0x00000)
 #define SONIC_PROM_BASE       (IO_BASE + 0x08000)
 #define SONIC_BASE            (IO_BASE + 0x0a000)
-#define SCC_BASE              (IO_BASE + 0x0c020)
+#define SCC_BASE              (IO_BASE + 0x0c000)
 #define ESP_BASE              (IO_BASE + 0x10000)
 #define ESP_PDMA              (IO_BASE + 0x10100)
 #define ASC_BASE              (IO_BASE + 0x14000)
-- 
2.23.0


