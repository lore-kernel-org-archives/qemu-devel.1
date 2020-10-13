Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76FCBC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 06:57:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3E112078A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 06:57:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3E112078A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSEFf-0002Gw-UQ
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 02:57:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32938)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kSEBd-00057e-Pl; Tue, 13 Oct 2020 02:53:29 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:53277)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kSEBb-0000G9-SK; Tue, 13 Oct 2020 02:53:29 -0400
Received: from localhost.localdomain ([82.252.141.186]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M72wZ-1kY0Q00pcV-008cDc; Tue, 13 Oct 2020 08:53:23 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 08/15] softmmu/memory: Log invalid memory accesses
Date: Tue, 13 Oct 2020 08:53:06 +0200
Message-Id: <20201013065313.7349-9-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201013065313.7349-1-laurent@vivier.eu>
References: <20201013065313.7349-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:XTwvNwJbyUEKn1WplhLpWLhTNTvO0/iGkuPv4NR58+IJpx9ykHt
 etcye7ynwKy25pehGzjHdzecwd1VlBemBHzUkaP8qeDu+5Urq+0p7jUrjqHu/z+dsvM5JER
 YcHLJtFaMlEWNGmyAn4RhROSHFN9xa028tab39x0ZUJjwruoo0bhzq/3CdMxG/PcYNXPGe6
 tFo0Msv/ShRE0C26w+zBg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LxGsmFHT+fs=:9l2UJy4xeFxmzMeSr6CSX6
 2Re0uiEkl/6eMl7uM4bc22UA11HwrvDtnQY7/O1FtuFyvtRWAepW6++nyHV0UvTySVwkVbZpY
 8qxNTCgly0yJNEliTUK0ahq9AYpZnVMF+/c5KBBgkKFgt22JpqS9eFie5wB3xn0s6iY0aKfvu
 O9vU3/DL5lpF+jvZam0ZNc13C7yM8GLXfe9FnDs8JuFSUDkdnKDEl3UjcI7S1L2EgZS2JmMTY
 q3CTRDrgcQXNgaR9IlrtnHWZOFRNfhFkTvFWvZKo5w5besVYJA3K5KNBtxGnRuoVwdo2VwPTL
 cgE+IBlBu6n/tUahg3U8kjWlwRoLp2pAlDoRugBLUFpYgFibAeLMgxhopBvY8tUbFq+meXlz7
 l/H2zJy9XeRiIOLVWEKhLkiOKNN2sIpZ+BolIp/wq7KSInKiXYDjfa6xoQXCxShfXNDrWXloY
 leGLP/0dS6eNgXXDBgA88MWH9sAxsgrMle4CvtYvvdOwciYLQ2qqpPNrNA3rcLKztlKersyfP
 hcm9tjSxW2fBgg0qJvZE3LHkK+rxdoCh5eJAdg0VCS104mpnXJzOLTyRIX6jD1T4qCz8Mhvmw
 TII4Jg8QQGdaeQXC1XEJTCD7fuyZG/iLavJJHh+XRqrXNG5wmNzW9y7MlfiEUvt+d/KYSgASE
 HWHhkD2k6OMimT4kALcdOKdfT+F/Ng23OElXklxKWNHPrWK1QbiCvNmj6C3ppxr4cAr7mglSO
 vNSgy9fb3AXLRiCJsSZRm0ea5ggxrw63x8xhj5mJso8ImmxX72akGB2epyMKCab4OdnG3WyWl
 L+dD2xX6RxhV2ueiIugTh5WDkZzbpq/YfKLF9vIbC34C+tb890Yeyw1Sc/09ylaXtyBMPzL
Received-SPF: none client-ip=212.227.126.135; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 02:53:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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


