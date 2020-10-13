Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EEDAC43467
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 12:01:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A43720870
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 12:01:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A43720870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSIzk-0003vt-MJ
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 08:01:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44172)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kSIpi-00077k-Pj; Tue, 13 Oct 2020 07:51:10 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:53039)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kSIpg-0004y5-MY; Tue, 13 Oct 2020 07:51:10 -0400
Received: from localhost.localdomain ([82.252.141.186]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MLQgv-1kkFUK2LOl-00IYUu; Tue, 13 Oct 2020 13:51:03 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 07/14] softmmu/memory: Log invalid memory accesses
Date: Tue, 13 Oct 2020 13:50:45 +0200
Message-Id: <20201013115052.133355-8-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201013115052.133355-1-laurent@vivier.eu>
References: <20201013115052.133355-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:MKWt9Cjs1s5YhAebDSyrKmmhvomsOesLPiiTLR6Rz83/CrEjixy
 GijrUoKj3bk0RlaOI4ZBXPZxgV3Lgo/QBiKJMjnMsdt6O1GHmZUMtWbnw+sQr7KzfFlXfYY
 unwVGQduZcHrVNnaMRTPFyKd/Ab7CteQrVsGU40Ig7/2ajRvk8F73RlgURIrifG5DL6Xhl7
 zTIH7elMfedL5U/b7vwcQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:n+8Yw940KKk=:NJPe6/w0qeHBXQXU/87HzT
 9na+TmsdCUAwY3dpuyLy8PdPWIPNu+RamAGLM18qHPJFSgjXiN89+Fg4xpjGP2wzCWpE07gBw
 xQ0PC2Fyw6J9UYAWWvnRgVV1WUgyoxPN9rzAn8aNLTviAbAWFE2QJnjEQK5jpXk3w9kyxA1rh
 hxm6E+nvGwTAoloNrviASqi8OwGRsdru3rlCHNEwwnUqD70TwoDwFg9yFpKG2fxvDoXgwyoY7
 8rBOr1uRowy23gf6oIv+noU05285QinxB54iRUimS/obv1GwqPT4Cs5TFyfPeR4JBKUHe3ymf
 khMHsjIAosphogDF6SsnIdBTPpDYSxesWRQsa/tqrVZSQ+mYWakWOnGqAqC195iqxRKyE3JUs
 BGjTihVAt5kvL7Pmjgk8irfqmJsffPhSAcaNRbbf9tsznWe8+FbJWcFs30srDjNm1lSDqCm44
 F+Tvhcm2d4cZvK632MTQlO/eXJbEOnPUGy2Krh8ShDOXvUs9hFAuHwQHjHI9e5ALwGMsviDcu
 B5yH72E57hMg06bdKM4SH0Hen1SeMBWv+p/8ePM6afWPm1Yp9DXHw8p7Z81UbjdjZnHvZTSKm
 hozG/T2YltsGjO4ih1zDX/v/HeB4gUwICaVoDfST+D8Q8a7u6yyDjIg4B93vqyAAVNsU0xnm3
 3LJkINlnIVn/5i5oIYk+QqZaFQ6km2aW5AyC5r3wsDN7zYoc+wfwqX13YXi/6gFSxnUVSGSti
 1x66I1D7/BZRNIlSP/M9kfrDVafciMmz9nr+Hfd0awOD7lA7dyDLH9Gmk7qx+ulNlUCQ3zfTV
 c7V/iwqedjXp+3FLjANWA/ViKdrFxVQ0a3oruhsmX/Qb+vmUzO7VkTL5dDbzMmVTOojBfrA
Received-SPF: none client-ip=212.227.17.13; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 07:40:12
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Log invalid memory accesses with as GUEST_ERROR.

This is particularly useful since commit 5d971f9e67 which reverted
("memory: accept mismatching sizes in memory_region_access_valid").

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20201005152725.2143444-1-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 softmmu/memory.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/softmmu/memory.c b/softmmu/memory.c
index fa280a19f7f7..403ff3abc99b 100644
--- a/softmmu/memory.c
+++ b/softmmu/memory.c
@@ -14,6 +14,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/log.h"
 #include "qapi/error.h"
 #include "cpu.h"
 #include "exec/memory.h"
@@ -1353,10 +1354,18 @@ bool memory_region_access_valid(MemoryRegion *mr,
 {
     if (mr->ops->valid.accepts
         && !mr->ops->valid.accepts(mr->opaque, addr, size, is_write, attrs)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "Invalid access at addr "
+                                       "0x%" HWADDR_PRIX ", size %u, "
+                                       "region '%s', reason: rejected\n",
+                      addr, size, memory_region_name(mr));
         return false;
     }
 
     if (!mr->ops->valid.unaligned && (addr & (size - 1))) {
+        qemu_log_mask(LOG_GUEST_ERROR, "Invalid access at addr "
+                                       "0x%" HWADDR_PRIX ", size %u, "
+                                       "region '%s', reason: unaligned\n",
+                      addr, size, memory_region_name(mr));
         return false;
     }
 
@@ -1367,6 +1376,13 @@ bool memory_region_access_valid(MemoryRegion *mr,
 
     if (size > mr->ops->valid.max_access_size
         || size < mr->ops->valid.min_access_size) {
+        qemu_log_mask(LOG_GUEST_ERROR, "Invalid access at addr "
+                                       "0x%" HWADDR_PRIX ", size %u, "
+                                       "region '%s', reason: invalid size "
+                                       "(min:%u max:%u)\n",
+                      addr, size, memory_region_name(mr),
+                      mr->ops->valid.min_access_size,
+                      mr->ops->valid.max_access_size);
         return false;
     }
     return true;
-- 
2.26.2


