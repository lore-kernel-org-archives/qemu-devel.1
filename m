Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A175C43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 11:54:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2541D214F1
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 11:54:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2541D214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEAIY-0006qg-8A
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 07:54:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42860)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kEA6q-000107-5a
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 07:42:25 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56174
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kEA6o-0005Hr-70
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 07:42:23 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-sh8GA1CAPpaR3954GY7YNA-1; Fri, 04 Sep 2020 07:42:19 -0400
X-MC-Unique: sh8GA1CAPpaR3954GY7YNA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 358F61017DD0
 for <qemu-devel@nongnu.org>; Fri,  4 Sep 2020 11:41:45 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E88C182140
 for <qemu-devel@nongnu.org>; Fri,  4 Sep 2020 11:41:44 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 37/46] meson: get glib compilation flags from GLIB_CFLAGS
Date: Fri,  4 Sep 2020 07:41:13 -0400
Message-Id: <20200904114122.31307-38-pbonzini@redhat.com>
In-Reply-To: <20200904114122.31307-1-pbonzini@redhat.com>
References: <20200904114122.31307-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 03:57:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The glib compilation flags were added to QEMU_CFLAGS.  While we still
want them to be added to all compilation commands (at least for now),
do that via GLIB_CFLAGS rather than via QEMU_CFLAGS.  This shows that
glib is a special case and makes it clearer that QEMU_CFLAGS is only
about compiler commands and not dependencies.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure   | 19 +++++++++----------
 meson.build |  7 +++++--
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/configure b/configure
index ca9a6eca93..e63b356234 100755
--- a/configure
+++ b/configure
@@ -3742,24 +3742,23 @@ if test "$plugins" = yes; then
     glib_modules="$glib_modules gmodule-2.0"
 fi
 
-# This workaround is required due to a bug in pkg-config file for glib as it
-# doesn't define GLIB_STATIC_COMPILATION for pkg-config --static
-
-if test "$static" = yes && test "$mingw32" = yes; then
-    QEMU_CFLAGS="-DGLIB_STATIC_COMPILATION $QEMU_CFLAGS"
-fi
-
 for i in $glib_modules; do
     if $pkg_config --atleast-version=$glib_req_ver $i; then
         glib_cflags=$($pkg_config --cflags $i)
         glib_libs=$($pkg_config --libs $i)
-        QEMU_CFLAGS="$glib_cflags $QEMU_CFLAGS"
         LIBS="$glib_libs $LIBS"
     else
         error_exit "glib-$glib_req_ver $i is required to compile QEMU"
     fi
 done
 
+# This workaround is required due to a bug in pkg-config file for glib as it
+# doesn't define GLIB_STATIC_COMPILATION for pkg-config --static
+
+if test "$static" = yes && test "$mingw32" = yes; then
+    glib_cflags="-DGLIB_STATIC_COMPILATION $glib_cflags"
+fi
+
 if $pkg_config --atleast-version=$glib_req_ver gio-2.0; then
     gio=yes
     gio_cflags=$($pkg_config --cflags gio-2.0)
@@ -3794,7 +3793,7 @@ int main(void) {
 }
 EOF
 
-if ! compile_prog "$CFLAGS" "$LIBS" ; then
+if ! compile_prog "$glib_cflags" "$glib_libs" ; then
     error_exit "sizeof(size_t) doesn't match GLIB_SIZEOF_SIZE_T."\
                "You probably need to set PKG_CONFIG_LIBDIR"\
 	       "to point to the right pkg-config files for your"\
@@ -3809,7 +3808,7 @@ EOF
 if ! compile_prog "$glib_cflags -Werror" "$glib_libs" ; then
     if cc_has_warning_flag "-Wno-unknown-attributes"; then
         glib_cflags="-Wno-unknown-attributes $glib_cflags"
-        QEMU_CFLAGS="-Wno-unknown-attributes $CFLAGS"
+        CFLAGS="-Wno-unknown-attributes $CFLAGS"
     fi
 fi
 
diff --git a/meson.build b/meson.build
index e62b304480..a10239cfa4 100644
--- a/meson.build
+++ b/meson.build
@@ -120,8 +120,11 @@ elif targetos == 'haiku'
             cc.find_library('network'),
             cc.find_library('bsd')]
 endif
-glib = declare_dependency(compile_args: config_host['GLIB_CFLAGS'].split(),
-                          link_args: config_host['GLIB_LIBS'].split())
+# The path to glib.h is added to all compilation commands.  This was
+# grandfathered in from the QEMU Makefiles.
+add_project_arguments(config_host['GLIB_CFLAGS'].split(),
+                      native: false, language: ['c', 'cpp', 'objc'])
+glib = declare_dependency(link_args: config_host['GLIB_LIBS'].split())
 gio = not_found
 if 'CONFIG_GIO' in config_host
   gio = declare_dependency(compile_args: config_host['GIO_CFLAGS'].split(),
-- 
2.26.2



