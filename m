Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5775AC3A59D
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 12:14:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BE2420851
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 12:14:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BE2420851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzgY4-0007Yk-5U
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 08:14:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36067)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hzgTa-0001rH-Rt
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 08:09:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hzgTZ-0002YX-Cg
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 08:09:30 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:56479 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1hzgTZ-0001et-6B
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 08:09:29 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 19A631A2083;
 Mon, 19 Aug 2019 14:08:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id BB23F1A2061;
 Mon, 19 Aug 2019 14:08:23 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Mon, 19 Aug 2019 14:07:42 +0200
Message-Id: <1566216496-17375-4-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1566216496-17375-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1566216496-17375-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH v8 03/37] target/mips: Amend CP0 MemoryMapID
 register implementation
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
Cc: arikalo@wavecomp.com, philmd@redhat.com, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yongbok Kim <yongbok.kim@mips.com>

Add migration support and fix preprocessor constant name for
MemoryMapID register.

Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/cpu.h     | 2 +-
 target/mips/machine.c | 7 +++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 6406ba8..eda8350 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -290,7 +290,7 @@ typedef struct mips_def_t mips_def_t;
 #define CP0_REG04__CONTEXT         0
 #define CP0_REG04__USERLOCAL       2
 #define CP0_REG04__DBGCONTEXTID    4
-#define CP0_REG00__MMID            5
+#define CP0_REG04__MEMORYMAPID     5
 /* CP0 Register 05 */
 #define CP0_REG05__PAGEMASK        0
 #define CP0_REG05__PAGEGRAIN       1
diff --git a/target/mips/machine.c b/target/mips/machine.c
index c3e52f8..e23b767 100644
--- a/target/mips/machine.c
+++ b/target/mips/machine.c
@@ -137,6 +137,7 @@ static int get_tlb(QEMUFile *f, void *pv, size_t size,
     qemu_get_betls(f, &v->VPN);
     qemu_get_be32s(f, &v->PageMask);
     qemu_get_be16s(f, &v->ASID);
+    qemu_get_be32s(f, &v->MMID);
     qemu_get_be16s(f, &flags);
     v->G = (flags >> 10) & 1;
     v->C0 = (flags >> 7) & 3;
@@ -162,6 +163,7 @@ static int put_tlb(QEMUFile *f, void *pv, size_t size,
     r4k_tlb_t *v = pv;
 
     uint16_t asid = v->ASID;
+    uint32_t mmid = v->MMID;
     uint16_t flags = ((v->EHINV << 15) |
                       (v->RI1 << 14) |
                       (v->RI0 << 13) |
@@ -178,6 +180,7 @@ static int put_tlb(QEMUFile *f, void *pv, size_t size,
     qemu_put_betls(f, &v->VPN);
     qemu_put_be32s(f, &v->PageMask);
     qemu_put_be16s(f, &asid);
+    qemu_put_be32s(f, &mmid);
     qemu_put_be16s(f, &flags);
     qemu_put_be64s(f, &v->PFN[0]);
     qemu_put_be64s(f, &v->PFN[1]);
@@ -199,8 +202,8 @@ const VMStateInfo vmstate_info_tlb = {
 
 const VMStateDescription vmstate_tlb = {
     .name = "cpu/tlb",
-    .version_id = 2,
-    .minimum_version_id = 2,
+    .version_id = 3,
+    .minimum_version_id = 3,
     .fields = (VMStateField[]) {
         VMSTATE_UINT32(nb_tlb, CPUMIPSTLBContext),
         VMSTATE_UINT32(tlb_in_use, CPUMIPSTLBContext),
-- 
2.7.4


