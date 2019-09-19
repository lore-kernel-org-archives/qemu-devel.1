Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ABC5C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 14:09:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2D082067B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 14:09:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2D082067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAx7w-0003DB-Ek
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 10:09:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51610)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iAwx3-0007Cl-IG
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 09:58:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iAwtY-0003hV-5e
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 09:54:53 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:36933)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1iAwtX-0003gq-T1; Thu, 19 Sep 2019 09:54:52 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N0nSN-1hyWoc3a1V-00wq5c; Thu, 19 Sep 2019 15:54:48 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Thu, 19 Sep 2019 15:54:37 +0200
Message-Id: <20190919135443.15164-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190919135443.15164-1-laurent@vivier.eu>
References: <20190919135443.15164-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:xPGho2GRX7EUlkypACv+yhmVOn2fdClQAwJzIDjJjLjjATUqouJ
 vLla1oVdC0qkTVDvRJKgpSM4TAuSy6/vtIhfQ7WZUppZ8ADYpwkNHRopgbUMxXst7uzAOJL
 7Ue4TtvmfBhpON9eJqq4nH4n3NeKnS7aab6qJbUty+MffpIa0mkbTDsCbZIseYTOvHZaiH/
 peTBvkTJb0rR3vgjk3wow==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6UpysBwUi7s=:qFJvhP7ChDJuzkdplyJBXt
 btnBqZHlyscHGi8D9l4QdbD/3LDRBz0npl9n4NzA4FtfkchkGAc9FQsp3hNJtyHBC/73Omu0K
 67tlSh4S+SJu+ch3AjIUhUZFGNIZNcG9ctdkZurCxbl+cNPfrXCcX2pv0caWvfs/T2AimaJyz
 +4Scy5YSMVgl2GHB/PsHN2F3uQ0nlZVWTP4uvVogJSrMPviOR+BdBrBb8aUPaue410E5mfCEy
 O7Ywys9mxvJqMARgFqJ4R0V/ptrh14vIqVIUS7A2vp3UT2hwRMNDk5MqjUG1PfeXyClnKMXtj
 XPcuM7d2OthofGjhHCqTjrMt8tfgxTzMrOzw3rFtMwdwx1l0lluJeSCcWVImuH0g9OXiJ4Gfo
 AN7Qr+MEM7B+ip7ZdiT5IctNLOpY3gQTTCc7gc8zjSZOfX6Vj5KnU85SXGnxBUuKFjET4GmjS
 8PU6Cw+e4dXVI0bTGT6nr5FwU/YNNvQDvf8x2HqT5i0PT0lb2v+B7GkAzLM0bwVrjMJXgFMGp
 KEjqB0EMKpnrTxY5VVHLXpsZyNw0sOhhJIM/XVQM0ufm7/nBikQP39QX8BaUE80Dt4K2g/AKd
 /EUtA52rYtPSFuspvi6mFXdq6BBzqmEzOQTwfK4mXmcT1nM7UHAjYcRFc6ScRLc3VyI+azWfQ
 wNYZUQ8DtcEC1wSsASTSxm9uE3nG1hrVp9timL2I+Mt2oprln3/zY2JGwdXbIdPEf46GL0UlG
 /JLUTlclH4q+FT6Dv07jemn4EepyMIRsC4jRfJTRhCVQ7jvL4apBGielLyV3hOcQo8fkJdC8v
 6W1bDNwT+GZR5PpTwCgqec+QU+gkBuVrMEGLMG6g45b0aPruOm+3fcSxuveiFw4a1D4b/yy3R
 QeLfCGE3ovsnYYz0CTgdMbs3PfCAAVXxIonYpmKy8=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.24
Subject: [Qemu-devel] [PULL 2/8] cutils: Move size_to_str() from
 "qemu-common.h" to "qemu/cutils.h"
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
Cc: qemu-trivial@nongnu.org, John Snow <jsnow@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

"qemu/cutils.h" contains various qemu_strtosz_*() functions
useful to convert strings to size. It seems natural to have
the opposite usage (from size to string) there too.

The function definition is already in util/cutils.c.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Message-Id: <20190903120555.7551-1-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 block/qapi.c                 | 2 +-
 include/qemu-common.h        | 1 -
 include/qemu/cutils.h        | 2 ++
 qapi/string-output-visitor.c | 2 +-
 4 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/block/qapi.c b/block/qapi.c
index 15f103026473..7ee2ee065d24 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -23,7 +23,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu-common.h"
+#include "qemu/cutils.h"
 #include "block/qapi.h"
 #include "block/block_int.h"
 #include "block/throttle-groups.h"
diff --git a/include/qemu-common.h b/include/qemu-common.h
index 0235cd3b912e..8d84db90b083 100644
--- a/include/qemu-common.h
+++ b/include/qemu-common.h
@@ -123,7 +123,6 @@ void qemu_hexdump(const char *buf, FILE *fp, const char *prefix, size_t size);
 int parse_debug_env(const char *name, int max, int initial);
 
 const char *qemu_ether_ntoa(const MACAddr *mac);
-char *size_to_str(uint64_t val);
 void page_size_init(void);
 
 /* returns non-zero if dump is in progress, otherwise zero is
diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
index 12301340a474..b54c847e0fef 100644
--- a/include/qemu/cutils.h
+++ b/include/qemu/cutils.h
@@ -155,6 +155,8 @@ int qemu_strtosz(const char *nptr, const char **end, uint64_t *result);
 int qemu_strtosz_MiB(const char *nptr, const char **end, uint64_t *result);
 int qemu_strtosz_metric(const char *nptr, const char **end, uint64_t *result);
 
+char *size_to_str(uint64_t val);
+
 /* used to print char* safely */
 #define STR_OR_NULL(str) ((str) ? (str) : "null")
 
diff --git a/qapi/string-output-visitor.c b/qapi/string-output-visitor.c
index 7ab64468d9a5..0d93605d77a7 100644
--- a/qapi/string-output-visitor.c
+++ b/qapi/string-output-visitor.c
@@ -11,7 +11,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu-common.h"
+#include "qemu/cutils.h"
 #include "qapi/string-output-visitor.h"
 #include "qapi/visitor-impl.h"
 #include "qemu/host-utils.h"
-- 
2.21.0


