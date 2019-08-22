Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F94C3A59D
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 10:55:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8142B21726
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 10:55:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8142B21726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0kkw-0003Ne-O7
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 06:55:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44380)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1i0kiN-0007jM-Vg
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 06:53:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1i0kiM-00040m-9Y
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 06:53:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47722)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1i0kiM-000408-0n
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 06:53:10 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 55FA47FDF4
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2019 10:53:09 +0000 (UTC)
Received: from dhcp-16-132.lcy.redhat.com (unknown [10.42.16.132])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1A6B9600CD;
 Thu, 22 Aug 2019 10:53:03 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 22 Aug 2019 11:53:00 +0100
Message-Id: <20190822105302.26823-2-berrange@redhat.com>
In-Reply-To: <20190822105302.26823-1-berrange@redhat.com>
References: <20190822105302.26823-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Thu, 22 Aug 2019 10:53:09 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 1/3] glib: bump min required glib library
 version to 2.48
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Per supported platforms doc[1], the various min glib on relevant distros =
is:

  RHEL-8: 2.56.1
  RHEL-7: 2.50.3
  Debian (Buster): 2.58.3
  Debian (Stretch): 2.50.3
  OpenBSD (Ports): 2.58.3
  FreeBSD (Ports): 2.56.3
  OpenSUSE Leap 15: 2.54.3
  SLE12-SP2: 2.48.2
  Ubuntu (Xenial): 2.48.0
  macOS (Homebrew): 2.56.0

This suggests that a minimum glib of 2.48 is a reasonable target.

Compared to the previous version bump in

  commit e7b3af81597db1a6b55f2c15d030d703c6b2c6ac
  Author: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
  Date:   Fri May 4 15:34:46 2018 +0100

    glib: bump min required glib library version to 2.40

This will result in us dropping support for Debian Jessie and
Ubuntu 14.04.

As per the commit message 14.04 was already outside our list
of supported build platforms and an exception was only made
because one of the build hosts used during merge testing was
stuck on 14.04.

Debian Jessie is justified to drop because we only aim to
support at most 2 major versions of Debian at any time. This
means Buster and Stretch at this time.

The g_strv_contains compat code is dropped as this API is
present since 2.44

The g_assert_cmpmem compat code is dropped as this API is
present since 2.46

[1] https://qemu.weilnetz.de/doc/qemu-doc.html#Supported-build-platforms

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 configure             |  2 +-
 crypto/hmac-glib.c    |  5 -----
 include/glib-compat.h | 42 ++----------------------------------------
 3 files changed, 3 insertions(+), 46 deletions(-)

diff --git a/configure b/configure
index 0173db5d9f..3a020aefd8 100755
--- a/configure
+++ b/configure
@@ -3636,7 +3636,7 @@ fi
 ##########################################
 # glib support probe
=20
-glib_req_ver=3D2.40
+glib_req_ver=3D2.48
 glib_modules=3Dgthread-2.0
 if test "$modules" =3D yes; then
     glib_modules=3D"$glib_modules gmodule-export-2.0"
diff --git a/crypto/hmac-glib.c b/crypto/hmac-glib.c
index 7df627329d..509bbc74c2 100644
--- a/crypto/hmac-glib.c
+++ b/crypto/hmac-glib.c
@@ -21,12 +21,7 @@ static int qcrypto_hmac_alg_map[QCRYPTO_HASH_ALG__MAX]=
 =3D {
     [QCRYPTO_HASH_ALG_MD5] =3D G_CHECKSUM_MD5,
     [QCRYPTO_HASH_ALG_SHA1] =3D G_CHECKSUM_SHA1,
     [QCRYPTO_HASH_ALG_SHA256] =3D G_CHECKSUM_SHA256,
-/* Support for HMAC SHA-512 in GLib 2.42 */
-#if GLIB_CHECK_VERSION(2, 42, 0)
     [QCRYPTO_HASH_ALG_SHA512] =3D G_CHECKSUM_SHA512,
-#else
-    [QCRYPTO_HASH_ALG_SHA512] =3D -1,
-#endif
     [QCRYPTO_HASH_ALG_SHA224] =3D -1,
     [QCRYPTO_HASH_ALG_SHA384] =3D -1,
     [QCRYPTO_HASH_ALG_RIPEMD160] =3D -1,
diff --git a/include/glib-compat.h b/include/glib-compat.h
index 1291628e09..0b0ec76299 100644
--- a/include/glib-compat.h
+++ b/include/glib-compat.h
@@ -19,12 +19,12 @@
 /* Ask for warnings for anything that was marked deprecated in
  * the defined version, or before. It is a candidate for rewrite.
  */
-#define GLIB_VERSION_MIN_REQUIRED GLIB_VERSION_2_40
+#define GLIB_VERSION_MIN_REQUIRED GLIB_VERSION_2_48
=20
 /* Ask for warnings if code tries to use function that did not
  * exist in the defined version. These risk breaking builds
  */
-#define GLIB_VERSION_MAX_ALLOWED GLIB_VERSION_2_40
+#define GLIB_VERSION_MAX_ALLOWED GLIB_VERSION_2_48
=20
 #pragma GCC diagnostic push
 #pragma GCC diagnostic ignored "-Wdeprecated-declarations"
@@ -63,26 +63,6 @@
  * without generating warnings.
  */
=20
-static inline gboolean g_strv_contains_qemu(const gchar *const *strv,
-                                            const gchar *str)
-{
-#if GLIB_CHECK_VERSION(2, 44, 0)
-    return g_strv_contains(strv, str);
-#else
-    g_return_val_if_fail(strv !=3D NULL, FALSE);
-    g_return_val_if_fail(str !=3D NULL, FALSE);
-
-    for (; *strv !=3D NULL; strv++) {
-        if (g_str_equal(str, *strv)) {
-            return TRUE;
-        }
-    }
-
-    return FALSE;
-#endif
-}
-#define g_strv_contains(a, b) g_strv_contains_qemu(a, b)
-
 #if defined(_WIN32) && !GLIB_CHECK_VERSION(2, 50, 0)
 /*
  * g_poll has a problem on Windows when using
@@ -92,24 +72,6 @@ static inline gboolean g_strv_contains_qemu(const gcha=
r *const *strv,
 gint g_poll_fixed(GPollFD *fds, guint nfds, gint timeout);
 #endif
=20
-
-#ifndef g_assert_cmpmem
-#define g_assert_cmpmem(m1, l1, m2, l2)                                 =
       \
-    do {                                                                =
       \
-        gconstpointer __m1 =3D m1, __m2 =3D m2;                         =
           \
-        int __l1 =3D l1, __l2 =3D l2;                                   =
           \
-        if (__l1 !=3D __l2) {                                           =
         \
-            g_assertion_message_cmpnum(                                 =
       \
-                G_LOG_DOMAIN, __FILE__, __LINE__, G_STRFUNC,            =
       \
-                #l1 " (len(" #m1 ")) =3D=3D " #l2 " (len(" #m2 "))", __l=
1, "=3D=3D",   \
-                __l2, 'i');                                             =
       \
-        } else if (memcmp(__m1, __m2, __l1) !=3D 0) {                   =
         \
-            g_assertion_message(G_LOG_DOMAIN, __FILE__, __LINE__, G_STRF=
UNC,   \
-                                "assertion failed (" #m1 " =3D=3D " #m2 =
")");      \
-        }                                                               =
       \
-    } while (0)
-#endif
-
 #pragma GCC diagnostic pop
=20
 #endif
--=20
2.21.0


