Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCDCBC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 12:59:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8349724125
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 12:59:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ESCdHFDj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8349724125
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuc4j-0001JG-N0
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 07:59:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40148)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iub8i-0001uK-7U
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:59:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iub8g-0004u5-1s
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:59:12 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:46231
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iub8f-0004td-NB
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:59:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579780749;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ToN5OA+OYIWiz1ocOLRwTVQ2bvWzssRm5w/2+kmT8qs=;
 b=ESCdHFDjXebWtcBf+YKZZYzlm4WJNl9OMQY1/h6MvufFvUoGikGqg8JKdY2icaWzDxkydJ
 EhOGKu69UxV28fJvRKEZrPuz0hGhWDYOODKGQtIGOhKlhA1Ux0QDxnoSooNEwuWzFqLjed
 xSSeljEWLE2ZSMS1rLPz0Cl7b3KF6Kg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-dod0DeWjPuiR0vFQsGR0ZA-1; Thu, 23 Jan 2020 06:59:01 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E1CDC801E6C
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 11:59:00 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.0])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3254D1CB;
 Thu, 23 Jan 2020 11:59:00 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com
Subject: [PULL 012/111] virtiofsd: Fix common header and define for QEMU builds
Date: Thu, 23 Jan 2020 11:57:02 +0000
Message-Id: <20200123115841.138849-13-dgilbert@redhat.com>
In-Reply-To: <20200123115841.138849-1-dgilbert@redhat.com>
References: <20200123115841.138849-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: dod0DeWjPuiR0vFQsGR0ZA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

All of the fuse files include config.h and define GNU_SOURCE
where we don't have either under our build - remove them.
Fixup path to the kernel's fuse.h in the QEMUs world.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tools/virtiofsd/buffer.c         | 4 +---
 tools/virtiofsd/fuse_i.h         | 3 +++
 tools/virtiofsd/fuse_log.c       | 1 +
 tools/virtiofsd/fuse_lowlevel.c  | 6 ++----
 tools/virtiofsd/fuse_opt.c       | 2 +-
 tools/virtiofsd/fuse_signals.c   | 2 +-
 tools/virtiofsd/helper.c         | 1 +
 tools/virtiofsd/passthrough_ll.c | 8 ++------
 8 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/tools/virtiofsd/buffer.c b/tools/virtiofsd/buffer.c
index 4d507f3302..772efa922d 100644
--- a/tools/virtiofsd/buffer.c
+++ b/tools/virtiofsd/buffer.c
@@ -9,9 +9,7 @@
  * See the file COPYING.LIB
  */
=20
-#define _GNU_SOURCE
-
-#include "config.h"
+#include "qemu/osdep.h"
 #include "fuse_i.h"
 #include "fuse_lowlevel.h"
 #include <assert.h>
diff --git a/tools/virtiofsd/fuse_i.h b/tools/virtiofsd/fuse_i.h
index e63cb58388..bae06992e0 100644
--- a/tools/virtiofsd/fuse_i.h
+++ b/tools/virtiofsd/fuse_i.h
@@ -6,6 +6,9 @@
  * See the file COPYING.LIB
  */
=20
+#define FUSE_USE_VERSION 31
+
+
 #include "fuse.h"
 #include "fuse_lowlevel.h"
=20
diff --git a/tools/virtiofsd/fuse_log.c b/tools/virtiofsd/fuse_log.c
index 11345f9ec8..c301ff6da1 100644
--- a/tools/virtiofsd/fuse_log.c
+++ b/tools/virtiofsd/fuse_log.c
@@ -8,6 +8,7 @@
  * See the file COPYING.LIB
  */
=20
+#include "qemu/osdep.h"
 #include "fuse_log.h"
=20
 #include <stdarg.h>
diff --git a/tools/virtiofsd/fuse_lowlevel.c b/tools/virtiofsd/fuse_lowleve=
l.c
index 3da80de233..07fb8a6095 100644
--- a/tools/virtiofsd/fuse_lowlevel.c
+++ b/tools/virtiofsd/fuse_lowlevel.c
@@ -9,11 +9,9 @@
  * See the file COPYING.LIB
  */
=20
-#define _GNU_SOURCE
-
-#include "config.h"
+#include "qemu/osdep.h"
 #include "fuse_i.h"
-#include "fuse_kernel.h"
+#include "standard-headers/linux/fuse.h"
 #include "fuse_misc.h"
 #include "fuse_opt.h"
=20
diff --git a/tools/virtiofsd/fuse_opt.c b/tools/virtiofsd/fuse_opt.c
index edd36f4a3b..28922361a2 100644
--- a/tools/virtiofsd/fuse_opt.c
+++ b/tools/virtiofsd/fuse_opt.c
@@ -9,8 +9,8 @@
  * See the file COPYING.LIB
  */
=20
+#include "qemu/osdep.h"
 #include "fuse_opt.h"
-#include "config.h"
 #include "fuse_i.h"
 #include "fuse_misc.h"
=20
diff --git a/tools/virtiofsd/fuse_signals.c b/tools/virtiofsd/fuse_signals.=
c
index 19d6791cb9..dc7c8ac025 100644
--- a/tools/virtiofsd/fuse_signals.c
+++ b/tools/virtiofsd/fuse_signals.c
@@ -8,7 +8,7 @@
  * See the file COPYING.LIB
  */
=20
-#include "config.h"
+#include "qemu/osdep.h"
 #include "fuse_i.h"
 #include "fuse_lowlevel.h"
=20
diff --git a/tools/virtiofsd/helper.c b/tools/virtiofsd/helper.c
index d9227d7367..9333691525 100644
--- a/tools/virtiofsd/helper.c
+++ b/tools/virtiofsd/helper.c
@@ -10,6 +10,7 @@
  * See the file COPYING.LIB.
  */
=20
+#include "qemu/osdep.h"
 #include "fuse_i.h"
 #include "fuse_lowlevel.h"
 #include "fuse_misc.h"
diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough=
_ll.c
index 126a56ccbd..322a889cdf 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -35,15 +35,11 @@
  * \include passthrough_ll.c
  */
=20
-#define _GNU_SOURCE
-#define FUSE_USE_VERSION 31
-
-#include "config.h"
-
+#include "qemu/osdep.h"
+#include "fuse_lowlevel.h"
 #include <assert.h>
 #include <dirent.h>
 #include <errno.h>
-#include <fuse_lowlevel.h>
 #include <inttypes.h>
 #include <limits.h>
 #include <pthread.h>
--=20
2.24.1


