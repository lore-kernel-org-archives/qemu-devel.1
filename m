Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA724C43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 11:55:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 737BC214F1
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 11:55:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 737BC214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEAJF-0000Kb-7Q
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 07:55:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42744)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kEA6d-0000ih-Lg
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 07:42:11 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:45385
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kEA6a-0005GU-83
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 07:42:11 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-kf_zb3CwN5aBBbg2pk7Sgw-1; Fri, 04 Sep 2020 07:42:06 -0400
X-MC-Unique: kf_zb3CwN5aBBbg2pk7Sgw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DDA4D8E771E
 for <qemu-devel@nongnu.org>; Fri,  4 Sep 2020 11:41:39 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9B28060CC0;
 Fri,  4 Sep 2020 11:41:39 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 27/46] configure: remove dead code for in-tree builds
Date: Fri,  4 Sep 2020 07:41:03 -0400
Message-Id: <20200904114122.31307-28-pbonzini@redhat.com>
In-Reply-To: <20200904114122.31307-1-pbonzini@redhat.com>
References: <20200904114122.31307-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 01:57:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The $pwd_is_source_path variable is never "y", since
configure re-executes itself from a build directory.
Remove code that will never run.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/configure b/configure
index 3372a43a4f..8b79d6c946 100755
--- a/configure
+++ b/configure
@@ -665,14 +665,6 @@ QEMU_INCLUDES="$QEMU_INCLUDES -iquote ${source_path}/disas/libvixl"
 CFLAGS="-std=gnu99 -Wall"
 
 
-# running configure in the source tree?
-# we know that's the case if configure is there.
-if test -f "./configure"; then
-    pwd_is_source_path="y"
-else
-    pwd_is_source_path="n"
-fi
-
 check_define() {
 cat > $TMPC <<EOF
 #if !defined($1)
@@ -4261,9 +4253,7 @@ EOF
       if test -d "${source_path}/dtc/libfdt" || test -e "${source_path}/.git" ; then
           fdt=git
           mkdir -p dtc
-          if [ "$pwd_is_source_path" != "y" ] ; then
-              symlink "$source_path/dtc/Makefile" "dtc/Makefile"
-          fi
+          symlink "$source_path/dtc/Makefile" "dtc/Makefile"
           fdt_cflags="-I${source_path}/dtc/libfdt"
           fdt_ldflags="-Ldtc/libfdt"
           fdt_libs="$fdt_libs"
@@ -8076,7 +8066,7 @@ do
 done
 mkdir -p $DIRS
 for f in $LINKS ; do
-    if [ -e "$source_path/$f" ] && [ "$pwd_is_source_path" != "y" ]; then
+    if [ -e "$source_path/$f" ]; then
         symlink "$source_path/$f" "$f"
     fi
 done
-- 
2.26.2



