Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF13C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 13:12:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8BD8206F4
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 13:12:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8BD8206F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj0Wd-0001E3-RA
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 09:12:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45118)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jj0Un-0007gB-9w; Wed, 10 Jun 2020 09:10:21 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:57733)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jj0Um-0003Z9-5j; Wed, 10 Jun 2020 09:10:20 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MStKw-1jMPxe2iS6-00UKQO; Wed, 10 Jun 2020 15:10:16 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v2 05/16] hw/isa/apm: Convert debug printf()s to trace events
Date: Wed, 10 Jun 2020 15:10:00 +0200
Message-Id: <20200610131011.1941209-6-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200610131011.1941209-1-laurent@vivier.eu>
References: <20200610131011.1941209-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:BSGPFsbMSrJJdCEnLODi1H19zLMsYGbOkyF+y1Wm295AfJR35Be
 8kS5Sux21+dUpwv6a1tCd5NHcMC3p3feZa/Z+4MMy63sLS/GQ5upeM/gRn9DI2pndz2J3vk
 3A9iPIFjjG7dlTHAwlJEQ60DyczrD5XE+MKziiZ7drp0uDEN5RLf9OleO6R2NhlLzzpHs+D
 W6fgnlV4yELsSgaRG8Ghg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lIGKMcqLdaw=:FlYsc7R6ktKHedypKWSwJQ
 ApYGKp9QN++nfazBcZ3D3wwwAc9hw5piRUdrJbSirnMq1GF7fY3o8z9MBRUBn7mcY1yXHNdmb
 VMaTZ9uZF4O7mgGL7fmM9eVFfjxrwb2eUJmJNyYW0y/0PwBWE9XPKOhRDPCEqU1dGQ/8psg7n
 g+BId/kN02a7lIhfS6wBmsyIiiBeeXmUAfv8QQhZPi87g3kNK9eofIUou26JnN9SyAFAH1FVS
 uReg/DBP45yqnZidSNl1NyusAJhV6YYUHV888TJ00IH13XF5TGS2sRHlldo/PGNZo365rXMd6
 uDLJ3ooi2aoFc/F9glZqClCH8cCL/Te1snP6aBPTwj9EJVv/5sHFaAt0T36OM+Y+lCZj8i9li
 D0ij1YV9IUqTP7glE1YrkG5XyVib0o/LmlqeVqsJxRHl6L4gH69J90RVSssC/JLnKuXXblXJa
 a/i4pvY3EmMdI+JDLHb0o1dGZZHP3ocVYH0oK63tmshMWHSGlakgbBeMgFeHhy7i4AokVh+NT
 8Km/aVh14X2fEVz4IeeRveTEWRvZn88YWvcqP4grMYy8O72kFn+GGSCHmTNNvGwLhcWo5FCvp
 dvSjRbmMIaXBof2f5EPVMI/hzfPRMSmWOZNG6aE9kG0rzlkg7m/R91dYo4516XvAyt9wDdcKI
 ZMHiePHw5R3nKQ1cnCtQo385feDdtXqs6bF6AKaOpbyJOjQDTxFu9bPx/UN3hjqVP+nHZm8Fb
 OWZ4GBAfqidfq4a/JRYLys64SpxzU+PVtdl5bk23UPLovkfmgKfI/+KvbEUj4UMtqxYsU08cE
 r07JlIpXdefQkRomKK9KzyX1QRoyZ5th0c92EbtUjWhgVu3CkisUGA2597FsMhetQsgXmHW
Received-SPF: none client-ip=212.227.126.187; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 09:10:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Convert APM_DPRINTF() to trace events and remove ifdef'ry.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200524164806.12658-1-f4bug@amsat.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/isa/apm.c        | 15 +++++----------
 hw/isa/trace-events |  4 ++++
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/hw/isa/apm.c b/hw/isa/apm.c
index 6300b1ba7ace..bce266b9574c 100644
--- a/hw/isa/apm.c
+++ b/hw/isa/apm.c
@@ -24,14 +24,8 @@
 #include "hw/isa/apm.h"
 #include "hw/pci/pci.h"
 #include "migration/vmstate.h"
+#include "trace.h"
 
-//#define DEBUG
-
-#ifdef DEBUG
-# define APM_DPRINTF(format, ...)       printf(format, ## __VA_ARGS__)
-#else
-# define APM_DPRINTF(format, ...)       do { } while (0)
-#endif
 
 /* fixed I/O location */
 #define APM_STS_IOPORT  0xb3
@@ -41,8 +35,8 @@ static void apm_ioport_writeb(void *opaque, hwaddr addr, uint64_t val,
 {
     APMState *apm = opaque;
     addr &= 1;
-    APM_DPRINTF("apm_ioport_writeb addr=0x%" HWADDR_PRIx
-                " val=0x%02" PRIx64 "\n", addr, val);
+
+    trace_apm_io_write(addr, val);
     if (addr == 0) {
         apm->apmc = val;
 
@@ -65,7 +59,8 @@ static uint64_t apm_ioport_readb(void *opaque, hwaddr addr, unsigned size)
     } else {
         val = apm->apms;
     }
-    APM_DPRINTF("apm_ioport_readb addr=0x%" HWADDR_PRIx " val=0x%02x\n", addr, val);
+    trace_apm_io_read(addr, val);
+
     return val;
 }
 
diff --git a/hw/isa/trace-events b/hw/isa/trace-events
index 202f8938e7b8..3544c6213c39 100644
--- a/hw/isa/trace-events
+++ b/hw/isa/trace-events
@@ -9,3 +9,7 @@ superio_create_ide(int id, uint16_t base, unsigned int irq) "id=%d, base 0x%03x,
 # pc87312.c
 pc87312_io_read(uint32_t addr, uint32_t val) "read addr=0x%x val=0x%x"
 pc87312_io_write(uint32_t addr, uint32_t val) "write addr=0x%x val=0x%x"
+
+# apm.c
+apm_io_read(uint8_t addr, uint8_t val) "read addr=0x%x val=0x%02x"
+apm_io_write(uint8_t addr, uint8_t val) "write addr=0x%x val=0x%02x"
-- 
2.26.2


