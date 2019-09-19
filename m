Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF682C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 14:09:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D8182067B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 14:09:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D8182067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAx7d-0002g2-4g
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 10:09:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51610)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iAwx2-0007Cl-Fq
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 09:58:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iAwta-0003jN-Oc
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 09:54:55 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:60019)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1iAwta-0003iX-Fg; Thu, 19 Sep 2019 09:54:54 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MMFZQ-1iTAnk2MjO-00JMT9; Thu, 19 Sep 2019 15:54:50 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Thu, 19 Sep 2019 15:54:41 +0200
Message-Id: <20190919135443.15164-7-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190919135443.15164-1-laurent@vivier.eu>
References: <20190919135443.15164-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:gCTZpmtHKLAlM6ggkWLzXvYON9BoHi026y+wk0KHm8QZRP7kYEy
 ZL8liT5ljF3wjc08u826E2/CyWXT1JZLgfNwZzrJQKP9aGM4jRAq580962S/C2Ncor+OfYO
 OUWS4a8NwOLJKCbrMecHtNpzFcpk6Uh1/5iTj4E9C7NPJCpnVpjpo7cXaCMVUTtbL5TKplF
 5xtxhHtw8LCsU0s1Qx7qA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WgSDtJllvg4=:yrBBCCeexAKYmZaWEC/h1I
 cHf8DMSa2EAl6f0UA/lgLbtNfxi5TrpVKVY2N/KqAGsBQLbUCLeM+gckvzQUMs8Vo6cTRmjwm
 K0E1t216JasT+t0zcqs9ED5VW2aNUvDZsSKb35RQAjn7snZqYxM0lzjL40dr8XiUZZnfff3eK
 cNPgvX3NcPCGYGrVsXfc0hOcAfvSG2OJrN3w7iseUDo3Ncem1yJqFD6E+Kiw5EAueI8RHy+hO
 svdOkKn5EhiI4HeWc5VxIWEA6kFFBQl0F3onB/YJ51+LOoFpoEoXCvOg3+fGVAx5TzSL3HA7d
 TzZ3X/vlOlSvw89Rl8yXw/ZsMUBDUMacuuBR4FhwuB4j6RnAMUf6XhO0YugU6EyWioHD/tkJf
 wDL6l8jn75XFiIwcrvYwXh2hxtjG/D/TMTD5usrvXoN5F2WYRKmGiXFNhwMCj10WYeGWQt7uj
 MdU3IxQxQTYRp4dFM9fwCKNFsG18Np/qEyYy01sOeyknOaFs4whF8g9txnZ+6PjWpOaX7X37f
 Gqcgefpc/Yc4EpWX8LO4aaMpfUgf958VYN3s7PLenReFZ9wKW/yI0hKJ5XFTug7Y+tAt9/lrC
 0C7vapVyrlIrK0KMrzZ3k+i12UWnzje18jQ7XtXk+QH/JiNgW8b9qArVroSsOOm+vCx6sHcds
 +gpUp0CA260wsX6ZYFbNDANF8OkQHfoIYCksr1ogyyUqs8Ji+DBFl2OObMnv9ohaS54lr6172
 ZIYiyz3YIfIS1HU8HsbTgqIBIYE/guhGPqndJI3/a0IowoPsfFR1gmDKYEzJdksriguj+ByaU
 7JIC5HpbEnsE2xXQkcIPw9NIherNNgTZeuxMIbIF7zgzPNDSh9yH4agkgsmkaTEeT3TAZTWTD
 fkBa1YNXGP2C9y0eZPJQ==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.10
Subject: [Qemu-devel] [PULL 6/8] Fix cacheline detection on FreeBSD/powerpc.
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
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>, Justin Hibbits <chmeeedalf@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Justin Hibbits <chmeeedalf@gmail.com>

machdep.cacheline_size is an integer, not a long.  Since PowerPC is
big-endian this causes sysctlbyname() to fill in the upper bits of the
argument, rather than the correct 'lower bits' of the word.  Specify the
correct type to fix this.

Fixes: b255b2c8a548 ("util: add cacheinfo")
Signed-off-by: Justin Hibbits <chmeeedalf@gmail.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Tested-by: Justin Hibbits <chmeeedalf@gmail.com>
Message-Id: <20190821082546.5252-2-laurent@vivier.eu>
---
 util/cacheinfo.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/util/cacheinfo.c b/util/cacheinfo.c
index eebe1ce9c5d2..ea6f3e99bf4a 100644
--- a/util/cacheinfo.c
+++ b/util/cacheinfo.c
@@ -65,25 +65,28 @@ static void sys_cache_info(int *isize, int *dsize)
     g_free(buf);
 }
 
-#elif defined(__APPLE__) \
-      || defined(__FreeBSD__) || defined(__FreeBSD_kernel__)
+#elif defined(__APPLE__)
 # include <sys/sysctl.h>
-# if defined(__APPLE__)
-#  define SYSCTL_CACHELINE_NAME "hw.cachelinesize"
-# else
-#  define SYSCTL_CACHELINE_NAME "machdep.cacheline_size"
-# endif
-
 static void sys_cache_info(int *isize, int *dsize)
 {
     /* There's only a single sysctl for both I/D cache line sizes.  */
     long size;
     size_t len = sizeof(size);
-    if (!sysctlbyname(SYSCTL_CACHELINE_NAME, &size, &len, NULL, 0)) {
+    if (!sysctlbyname("hw.cachelinesize", &size, &len, NULL, 0)) {
+        *isize = *dsize = size;
+    }
+}
+#elif defined(__FreeBSD__) || defined(__FreeBSD_kernel__)
+# include <sys/sysctl.h>
+static void sys_cache_info(int *isize, int *dsize)
+{
+    /* There's only a single sysctl for both I/D cache line sizes.  */
+    int size;
+    size_t len = sizeof(size);
+    if (!sysctlbyname("machdep.cacheline_size", &size, &len, NULL, 0)) {
         *isize = *dsize = size;
     }
 }
-
 #else
 /* POSIX */
 
-- 
2.21.0


