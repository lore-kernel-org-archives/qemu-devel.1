Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D120BC4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 09:29:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 765FA21D43
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 09:29:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sj6yQQSH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 765FA21D43
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL15J-000650-H1
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 05:29:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53162)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kL0od-0001Is-IK
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 05:11:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32110
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kL0oS-0002N2-KV
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 05:11:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600852299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bL7nD+JNaHuk7WyiSDhOoHjSV8am1jrl2EWBBD/pkBU=;
 b=Sj6yQQSHPp9x09IoeO7TIEqa6SIwFn/UygkEAJ7VGVn4emNs/pTIt6HNYM//bhKpvMegCH
 RA1eIzaNB6jo29ThNWXaWLxQOJsv/njPUo+POanhER2OS+I+H6t3aGNIj37XQoKbQNkOkI
 ECEtkxxr7rljpWmfw90LKUe6vkcPYBo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-L3mylkq7O3attLlMYHC5pA-1; Wed, 23 Sep 2020 05:11:37 -0400
X-MC-Unique: L3mylkq7O3attLlMYHC5pA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 28781107465A;
 Wed, 23 Sep 2020 09:11:36 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C22C45D9CC;
 Wed, 23 Sep 2020 09:11:35 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 07/12] configure: remove useless config-target.mak symbols
Date: Wed, 23 Sep 2020 05:11:26 -0400
Message-Id: <20200923091131.1591563-8-pbonzini@redhat.com>
In-Reply-To: <20200923091131.1591563-1-pbonzini@redhat.com>
References: <20200923091131.1591563-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 05:11:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: richard.henderson@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Omit symbols that are not needed by softmmu or bsd-user targets,
in preparation for moving the generated config-target.mak files
into the source tree.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/configure b/configure
index 2bd4336369..5e15b5e1ad 100755
--- a/configure
+++ b/configure
@@ -7494,7 +7494,7 @@ case "$target_name" in
   mips|mipsel)
     mttcg="yes"
     TARGET_ARCH=mips
-    echo "TARGET_ABI_MIPSO32=y" >> $config_target_mak
+    test "$target_user_only" = yes && echo "TARGET_ABI_MIPSO32=y" >> $config_target_mak
     TARGET_SYSTBL_ABI=o32
     TARGET_SYSTBL=syscall_o32.tbl
   ;;
@@ -7502,8 +7502,8 @@ case "$target_name" in
     mttcg="yes"
     TARGET_ARCH=mips64
     TARGET_BASE_ARCH=mips
-    echo "TARGET_ABI_MIPSN32=y" >> $config_target_mak
-    echo "TARGET_ABI32=y" >> $config_target_mak
+    test "$target_user_only" = yes && echo "TARGET_ABI_MIPSN32=y" >> $config_target_mak
+    test "$target_user_only" = yes && echo "TARGET_ABI32=y" >> $config_target_mak
     TARGET_SYSTBL_ABI=n32
     TARGET_SYSTBL=syscall_n32.tbl
   ;;
@@ -7511,7 +7511,7 @@ case "$target_name" in
     mttcg="no"
     TARGET_ARCH=mips64
     TARGET_BASE_ARCH=mips
-    echo "TARGET_ABI_MIPSN64=y" >> $config_target_mak
+    test "$target_user_only" = yes && echo "TARGET_ABI_MIPSN64=y" >> $config_target_mak
     TARGET_SYSTBL_ABI=n64
     TARGET_SYSTBL=syscall_n64.tbl
   ;;
@@ -7547,7 +7547,7 @@ case "$target_name" in
     TARGET_BASE_ARCH=ppc
     TARGET_ABI_DIR=ppc
     TARGET_SYSTBL_ABI=common,nospu,32
-    echo "TARGET_ABI32=y" >> $config_target_mak
+    test "$target_user_only" = yes && echo "TARGET_ABI32=y" >> $config_target_mak
     gdb_xml_files="power64-core.xml power-fpu.xml power-altivec.xml power-spe.xml power-vsx.xml"
   ;;
   riscv32)
@@ -7585,7 +7585,7 @@ case "$target_name" in
     TARGET_BASE_ARCH=sparc
     TARGET_ABI_DIR=sparc
     TARGET_SYSTBL_ABI=common,32
-    echo "TARGET_ABI32=y" >> $config_target_mak
+    test "$target_user_only" = yes && echo "TARGET_ABI32=y" >> $config_target_mak
   ;;
   s390x)
     TARGET_SYSTBL_ABI=common,64
@@ -7623,15 +7623,18 @@ upper() {
 target_arch_name="$(upper $TARGET_ARCH)"
 echo "TARGET_$target_arch_name=y" >> $config_target_mak
 echo "TARGET_BASE_ARCH=$TARGET_BASE_ARCH" >> $config_target_mak
-if [ "$TARGET_ABI_DIR" = "" ]; then
-  TARGET_ABI_DIR=$TARGET_ARCH
+if test "$target_user_only" = "yes" ; then
+  if [ "$TARGET_ABI_DIR" = "" ]; then
+    TARGET_ABI_DIR=$TARGET_ARCH
+  fi
+  echo "TARGET_ABI_DIR=$TARGET_ABI_DIR" >> $config_target_mak
 fi
-echo "TARGET_ABI_DIR=$TARGET_ABI_DIR" >> $config_target_mak
-if [ "$TARGET_SYSTBL_ABI" != "" ]; then
+if test "$target_linux_user" = "yes" ; then
+  if [ "$TARGET_SYSTBL_ABI" != "" ]; then
     echo "TARGET_SYSTBL_ABI=$TARGET_SYSTBL_ABI" >> $config_target_mak
     echo "TARGET_SYSTBL=$TARGET_SYSTBL" >> $config_target_mak
+  fi
 fi
-
 if test "$target_aligned_only" = "yes" ; then
   echo "TARGET_ALIGNED_ONLY=y" >> $config_target_mak
 fi
-- 
2.26.2



