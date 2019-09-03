Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D61FC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 12:06:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E2DE206B8
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 12:06:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E2DE206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i57aL-00085X-23
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 08:06:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58475)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i57Zc-0007TU-FN
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 08:06:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i57Zb-0005zP-0c
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 08:06:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35098)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1i57ZY-0005xH-0v; Tue, 03 Sep 2019 08:06:08 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3BFB430860BA;
 Tue,  3 Sep 2019 12:06:07 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-102.brq.redhat.com [10.40.204.102])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1A0105C1B5;
 Tue,  3 Sep 2019 12:05:58 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 14:05:55 +0200
Message-Id: <20190903120555.7551-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Tue, 03 Sep 2019 12:06:07 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] cutils: Move size_to_str() from
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 qemu-trivial@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Peter Xu <peterx@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

"qemu/cutils.h" contains various qemu_strtosz_*() functions
useful to convert strings to size. It seems natural to have
the opposite usage (from size to string) there too.

The function definition is already in util/cutils.c.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
There are only 5 users, is it worthwhile renaming it qemu_sztostrt()?
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 block/qapi.c                 | 2 +-
 include/qemu-common.h        | 1 -
 include/qemu/cutils.h        | 2 ++
 qapi/string-output-visitor.c | 2 +-
 4 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/block/qapi.c b/block/qapi.c
index 15f1030264..7ee2ee065d 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -23,7 +23,7 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qemu-common.h"
+#include "qemu/cutils.h"
 #include "block/qapi.h"
 #include "block/block_int.h"
 #include "block/throttle-groups.h"
diff --git a/include/qemu-common.h b/include/qemu-common.h
index 0235cd3b91..8d84db90b0 100644
--- a/include/qemu-common.h
+++ b/include/qemu-common.h
@@ -123,7 +123,6 @@ void qemu_hexdump(const char *buf, FILE *fp, const ch=
ar *prefix, size_t size);
 int parse_debug_env(const char *name, int max, int initial);
=20
 const char *qemu_ether_ntoa(const MACAddr *mac);
-char *size_to_str(uint64_t val);
 void page_size_init(void);
=20
 /* returns non-zero if dump is in progress, otherwise zero is
diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
index 12301340a4..b54c847e0f 100644
--- a/include/qemu/cutils.h
+++ b/include/qemu/cutils.h
@@ -155,6 +155,8 @@ int qemu_strtosz(const char *nptr, const char **end, =
uint64_t *result);
 int qemu_strtosz_MiB(const char *nptr, const char **end, uint64_t *resul=
t);
 int qemu_strtosz_metric(const char *nptr, const char **end, uint64_t *re=
sult);
=20
+char *size_to_str(uint64_t val);
+
 /* used to print char* safely */
 #define STR_OR_NULL(str) ((str) ? (str) : "null")
=20
diff --git a/qapi/string-output-visitor.c b/qapi/string-output-visitor.c
index 7ab64468d9..0d93605d77 100644
--- a/qapi/string-output-visitor.c
+++ b/qapi/string-output-visitor.c
@@ -11,7 +11,7 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qemu-common.h"
+#include "qemu/cutils.h"
 #include "qapi/string-output-visitor.h"
 #include "qapi/visitor-impl.h"
 #include "qemu/host-utils.h"
--=20
2.20.1


