Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9301C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 09:54:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DEBA2396E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 09:54:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TAYPO/V8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DEBA2396E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLNxO-0002Ut-FZ
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 05:54:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39110)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLNTs-0001I2-IP
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 05:24:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22001)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLNTp-00066g-R3
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 05:24:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600939437;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tHKjbusthXD3rtEvGDNcQcsWVkEAA+X2aPa+9QCB1N8=;
 b=TAYPO/V8FuNmu0EEF+YNltTJ/T3WnHiBJv6V08/L5TVheNxjqfC0BM+kIq+GoMM70vSlik
 rULHmX8cJVVx3VfIDy7/rVXp61QDEN2DwllpFNPjnWCMo7F8PbAbfNd5owO561nPCazzWf
 fC1b2mzSoptI7w/RS+IATkVqEWYOvYc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-7g1wqgNJP_iGjwF8S7qDEQ-1; Thu, 24 Sep 2020 05:23:54 -0400
X-MC-Unique: 7g1wqgNJP_iGjwF8S7qDEQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8162C81F00B
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2020 09:23:53 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 50AA75C22B
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2020 09:23:53 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 51/92] configure: use a platform-neutral prefix
Date: Thu, 24 Sep 2020 05:22:33 -0400
Message-Id: <20200924092314.1722645-52-pbonzini@redhat.com>
In-Reply-To: <20200924092314.1722645-1-pbonzini@redhat.com>
References: <20200924092314.1722645-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 01:10:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Now that the installation is relocatable, there is no need to compile a
Windows-format prefix into Win32 binaries.  Instead, the prefix will
only be used to compute installation-relative paths, and it can be
any string.

Drop the "Program Files" path completely: it is only usable on English
versions of Windows; therefore, using the NSIS installer to get the
"correct" path to the Program Files folder is recommended, and NSIS
works just as well with any prefix.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 30 +++++++++++-------------------
 1 file changed, 11 insertions(+), 19 deletions(-)

diff --git a/configure b/configure
index 161d0604bb..fee5faa054 100755
--- a/configure
+++ b/configure
@@ -969,7 +969,7 @@ if test "$mingw32" = "yes" ; then
   # MinGW needs -mthreads for TLS and macro _MT.
   CFLAGS="-mthreads $CFLAGS"
   write_c_skeleton;
-  prefix="c:/Program Files/QEMU"
+  prefix="/qemu"
   qemu_suffix=""
   libs_qga="-lws2_32 -lwinmm -lpowrprof -lwtsapi32 -lwininet -liphlpapi -lnetapi32 $libs_qga"
 fi
@@ -7802,17 +7802,9 @@ echo "strip = $(meson_quote $strip)" >> $cross
 echo "windres = $(meson_quote $windres)" >> $cross
 if test -n "$cross_prefix"; then
     cross_arg="--cross-file config-meson.cross"
-    # Hack: Meson expects an absolute path for the *build* machine
-    # for the prefix, so add a slash in front of a Windows path that
-    # includes a drive letter.
-    #
-    # See https://github.com/mesonbuild/meson/issues/7577.
     echo "[host_machine]" >> $cross
     if test "$mingw32" = "yes" ; then
         echo "system = 'windows'" >> $cross
-        case $prefix in
-            ?:*) pre_prefix=/ ;;
-        esac
     fi
     if test "$linux" = "yes" ; then
         echo "system = 'linux'" >> $cross
@@ -7841,16 +7833,16 @@ mv $cross config-meson.cross
 
 rm -rf meson-private meson-info meson-logs
 NINJA=${ninja:-$PWD/ninjatool} $meson setup \
-        --prefix "${pre_prefix}$prefix" \
-        --libdir "${pre_prefix}$libdir" \
-        --libexecdir "${pre_prefix}$libexecdir" \
-        --bindir "${pre_prefix}$bindir" \
-        --includedir "${pre_prefix}$includedir" \
-        --datadir "${pre_prefix}$datadir" \
-        --mandir "${pre_prefix}$mandir" \
-        --sysconfdir "${pre_prefix}$sysconfdir" \
-        --localstatedir "${pre_prefix}$local_statedir" \
-        -Ddocdir="${pre_prefix}$docdir" \
+        --prefix "$prefix" \
+        --libdir "$libdir" \
+        --libexecdir "$libexecdir" \
+        --bindir "$bindir" \
+        --includedir "$includedir" \
+        --datadir "$datadir" \
+        --mandir "$mandir" \
+        --sysconfdir "$sysconfdir" \
+        --localstatedir "$local_statedir" \
+        -Ddocdir="$docdir" \
         -Dqemu_suffix="$qemu_suffix" \
         -Doptimization=$(if test "$debug" = yes; then echo 0; else echo 2; fi) \
         -Ddebug=$(if test "$debug_info" = yes; then echo true; else echo false; fi) \
-- 
2.26.2



