Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC1C6C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 13:05:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 814BA206D8
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 13:05:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 814BA206D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihZ1a-0007Yu-AE
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 08:05:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52190)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1ihYx2-0001sB-6h
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 08:01:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1ihYx0-0007iN-V9
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 08:01:16 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:36705)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1ihYx0-0007bd-IX; Wed, 18 Dec 2019 08:01:14 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M2Nm2-1ifvK72kxS-003v1g; Wed, 18 Dec 2019 14:01:09 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 3/7] util/cutils: Turn FIXME comment into QEMU_BUILD_BUG_ON()
Date: Wed, 18 Dec 2019 14:01:01 +0100
Message-Id: <20191218130105.125981-4-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191218130105.125981-1-laurent@vivier.eu>
References: <20191218130105.125981-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Z6qpvgpRgK83bqqxGDdS0W/GT+hXJdPgM7idN7ExVcjSrrL//C2
 tn5OhPvbociww0aXhH4Pf5bXN5KhtRWHc/XxB/+PpVaV+HR7mf6IYuF8HbhOKdohsvmC04J
 MQFOGwfr0u+Pc9MUGjdOfI6cFJwg54pv79YxwY+AE/p08+W8Y08Jfj5vwHg0YcJJDA4AvFl
 Mgewp8i1DTbm9c4Hsz4Zg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zcLUXBW2HKA=:kpjk1LjmQDFmlvqAOhgqpb
 1qdYQf7rnTmTxhMbbFEPw4Q5y3b2J4xuqpp/W3zz0voxrik2vy+llwQX+R67hhsbOG+sSqoQd
 dSb4AdFvTWEomCrj/ybc8RUgv4dbDiqlPWmdNb7hMFyjj+ycDdWn9wLrsHodi1YbmfCFhzcyg
 zl2iC2IPje4h8bl4WY7ieWhDUCosnoY4HPJ1HLtjLKtQVNSaDCY2Nieed9xdA546/oqPRFIph
 WlBCAjBqEh6l9on3ngnmsHF6bSeQ/TXX1/wiIUEwg+qD2qZ612/5jQ8fyzJJmgubnBZ46NTdF
 g4jLxR1nDe/QtW3/3bHTm1753DvDCglPzrcIKyBu4UGz5QCNtJ9gAyuQnq/28JH6D1EDULj5S
 L0XZYtwUTxBtdOufmbaTNclf0A6rckUXVBo9teAGbyNCwQ7HYWfCsqr3boDmwY2urFuVu8C5t
 xsJTZ5ub/8hfvP5p5sFudcwD338UmfqYGVcKz0qpiXYanZ+IA9dscBQ40VzqmzygDc1O4YQSK
 PHR+YFoOq1q9WaIneZl0yAVhp4bJ0YfvkddrsLhBOnHZSku/7BD2VByRmypuztyZYV2+utG35
 aYaKSxmXL1Hkrx6CSzIlnK8f5Wyc0IX/GvWUFylgDNXTTNKaQi0JPC6MnQGKsDiaZmwObdDef
 CRCERRAyJI7MCSlu0ycLJzDz2AcS5/Fgk67zew6NGpLvzpMDKPo164SGEXoCVLnAXZBjHlY+H
 +oGfikhEjVEtpajeghT+Tg31S+p1/M1jeuj4tw4d0tnzk/5yJwqpvspVABj1va10+umYbK+lS
 YladQckGLYMvlOHCZDfyabZq88a5S6NK41dsel5+5KC/1Z44xFiB0KBSZDlUPPY+U2agSNXQo
 lM75J6ZXT/rInm9SYsjSBuuDW26smvYKTg3EphjeE=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.134
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
Cc: qemu-trivial@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Markus Armbruster <armbru@redhat.com>

qemu_strtoi64() assumes int64_t is long long.  This is marked FIXME.
Replace by a QEMU_BUILD_BUG_ON() to avoid surprises.

Same for qemu_strtou64().

Fix a typo in qemu_strtoul()'s contract while there.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20191125133846.27790-2-armbru@redhat.com>
[lv: removed trailing whitespace]
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 util/cutils.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/util/cutils.c b/util/cutils.c
index 238016523039..36ce712271f1 100644
--- a/util/cutils.c
+++ b/util/cutils.c
@@ -542,7 +542,7 @@ int qemu_strtoul(const char *nptr, const char **endptr, int base,
  * Convert string @nptr to an int64_t.
  *
  * Works like qemu_strtol(), except it stores INT64_MAX on overflow,
- * and INT_MIN on underflow.
+ * and INT64_MIN on underflow.
  */
 int qemu_strtoi64(const char *nptr, const char **endptr, int base,
                  int64_t *result)
@@ -557,8 +557,9 @@ int qemu_strtoi64(const char *nptr, const char **endptr, int base,
         return -EINVAL;
     }
 
+    /* This assumes int64_t is long long TODO relax */
+    QEMU_BUILD_BUG_ON(sizeof(int64_t) != sizeof(long long));
     errno = 0;
-    /* FIXME This assumes int64_t is long long */
     *result = strtoll(nptr, &ep, base);
     return check_strtox_error(nptr, ep, endptr, errno);
 }
@@ -581,8 +582,9 @@ int qemu_strtou64(const char *nptr, const char **endptr, int base,
         return -EINVAL;
     }
 
+    /* This assumes uint64_t is unsigned long long TODO relax */
+    QEMU_BUILD_BUG_ON(sizeof(uint64_t) != sizeof(unsigned long long));
     errno = 0;
-    /* FIXME This assumes uint64_t is unsigned long long */
     *result = strtoull(nptr, &ep, base);
     /* Windows returns 1 for negative out-of-range values.  */
     if (errno == ERANGE) {
-- 
2.24.1


