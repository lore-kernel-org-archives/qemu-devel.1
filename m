Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FBADC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 16:43:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6847B21848
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 16:43:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6847B21848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1Cek-0008T7-4O
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 12:43:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46837)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1i1CbG-0006aX-LT
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 12:39:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1i1CbF-0002uU-Ce
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 12:39:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41522)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1i1CbF-0002u7-4x
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 12:39:41 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7889A18DE76B;
 Fri, 23 Aug 2019 16:39:40 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-112-60.ams2.redhat.com
 [10.36.112.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2D418BA75;
 Fri, 23 Aug 2019 16:39:38 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 23 Aug 2019 17:39:30 +0100
Message-Id: <20190823163931.7442-4-berrange@redhat.com>
In-Reply-To: <20190823163931.7442-1-berrange@redhat.com>
References: <20190823163931.7442-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Fri, 23 Aug 2019 16:39:40 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 3/4] docs: document use of automatic cleanup
 functions in glib
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Document the use of g_autofree and g_autoptr in glib for automatic
freeing of memory, or other resource cleanup (eg mutex unlocking).

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 CODING_STYLE.md | 101 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/CODING_STYLE.md b/CODING_STYLE.md
index 9f4fc9dc77..f37b6c2d01 100644
--- a/CODING_STYLE.md
+++ b/CODING_STYLE.md
@@ -479,3 +479,104 @@ terminate QEMU.
=20
 Note that &error_fatal is just another way to exit(1), and &error_abort
 is just another way to abort().
+
+
+## Automatic memory deallocation
+
+QEMU has a mandatory dependency either the GCC or CLang compiler. As
+such it has the freedom to make use of a C language extension for
+automatically running a cleanup function when a stack variable goes
+out of scope. This can be used to simplify function cleanup paths,
+often allowing many goto jumps to be eliminated, through automatic
+free'ing of memory.
+
+The GLib2 library provides a number of functions/macros for enabling
+automatic cleanup:
+
+ https://developer.gnome.org/glib/stable/glib-Miscellaneous-Macros.html
+
+Most notably:
+
+ - g_autofree - will invoke g_free() on the variable going out of scope
+
+ - g_autoptr - for structs / objects, will invoke the cleanup func creat=
ed
+               by a previous use of G_DEFINE_AUTOPTR_CLEANUP_FUNC. This =
is
+               supported for most GLib data types and GObjects
+
+For example, instead of
+
+    int somefunc(void) {
+        int ret =3D -1;
+        char *foo =3D g_strdup_printf("foo%", "wibble");
+        GList *bar =3D .....
+
+        if (eek) {
+           goto cleanup;
+        }
+
+        ret =3D 0;
+
+      cleanup:
+        g_free(foo);
+        g_list_free(bar);
+        return ret;
+    }
+
+Using g_autofree/g_autoptr enables the code to be written as:
+
+    int somefunc(void) {
+        g_autofree char *foo =3D g_strdup_printf("foo%", "wibble");
+        g_autoptr (GList) bar =3D .....
+
+        if (eek) {
+           return -1;
+        }
+
+        return 0;
+    }
+
+While this generally results in simpler, less leak-prone code, there
+are still some caveats to beware of
+
+ * Variables declared with g_auto* MUST always be initialized,
+   otherwise the cleanup function will use uninitialized stack memory
+
+ * If a variable declared with g_auto* holds a value which must
+   live beyond the life of the function, that value must be saved
+   and the original variable NULL'd out. This can be simpler using
+   g_steal_pointer
+
+
+    char *somefunc(void) {
+        g_autofree char *foo =3D g_strdup_printf("foo%", "wibble");
+        g_autoptr (GList) bar =3D .....
+
+        if (eek) {
+           return NULL;
+        }
+
+        return g_steal_pointer(&foo);
+    }
+
+The cleanup functions are not restricted to simply free'ing memory. The
+GMutexLocker class is a variant of GMutex that has automatic locking and
+unlocking at start and end of the enclosing scope
+
+In the following example, the `lock` in `MyObj` will be held for the
+precise duration of the `somefunc` function
+
+    typedef struct {
+        GMutex lock;
+    } MyObj;
+
+    char *somefunc(MyObj *obj) {
+        g_autofree GMutexLocker *locker =3D g_mutex_locker_new(&obj->loc=
k)
+        g_autofree char *foo =3D g_strdup_printf("foo%", "wibble");
+        g_autoptr (GList) bar =3D .....
+
+        if (eek) {
+           return NULL;
+        }
+
+        return g_steal_pointer(&foo);
+    }
--=20
2.21.0


