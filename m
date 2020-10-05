Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD4DC4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 08:28:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABE0720776
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 08:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qSA6qcHr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABE0720776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPLqo-00041y-QX
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 04:28:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36932)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPLmp-000819-T7
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 04:23:59 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:34329)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPLmo-0007Jd-8a
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 04:23:59 -0400
Received: by mail-wr1-x442.google.com with SMTP id t10so8486132wrv.1
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 01:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=upuWVn4FZNG7A93txMuYuYXI1qDSELZQM6EHJ6g56Ms=;
 b=qSA6qcHr3SQttjxyWExB+JUqELPLJeWZQcIvl14XR+I91vjNjh9NhMuDstpYvwfDeF
 gn+ctvWnTWTae1/UGeTuE46PE0CE6Z83bo/XBs53NllIbjRSerGcrBzgxhgL/9QojkC1
 GpQDIQqFdfaR+hsji//1eIL3GKeXNM/9ase2IX+hTIG0iqe7ErxPOZtGAfXt8qeA+2NL
 LvZX83Y7NcsDzF8/Edlg0un+yiM2Z5ItWRnxdiydEHCAtnAiC84T79I4DedWYrQL9162
 qpRQEtnT6Q5cP+eS2asICYQ/kFRL1aEdY0TQ9iau7nVtK38biVct+93PmjEUZaz5YnCJ
 NAug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=upuWVn4FZNG7A93txMuYuYXI1qDSELZQM6EHJ6g56Ms=;
 b=Leltr6IklwSyoFe9nAFo2MFMzM3LA9178x+mBEN93Kn0gdrgwXxJwThxyu2LeWvZ+l
 MUASdlfhpfBoZV8WRTIekenAJb7+3DWPzN+wBHfifEQie5oT87ckMG/W1oql4437Mt5f
 T8n+/adDkuLfd5eabAvd5biiZenwE4ufppKj0YJ0lScK8YVwzBtnq2a3H8rEnYo2kMP+
 TjHWypy4977f/NNKBAprZ/1YQIdAjKHEgyOlFuT1aDHlQNuSXHOErg943GQWRjRdSQwO
 jjEC8IPnZsTkxTbLPAlUUFPl99rDbL8L9PTcjmgKxSj1aCQPqOkTW9RVq0JqiRbR8C21
 7XEg==
X-Gm-Message-State: AOAM533zig6cyunQDmCbl4J9CXb3G6u1K59sQcNY0DKd5Dor5SwAU+NH
 xWFMuzo+gjLlkNmMcYibd3th+2PpTuU=
X-Google-Smtp-Source: ABdhPJwZFZu0fsYosvgIeY4TY9QEZAwx/SVjxfkW7Ar68fL58QLsOc5rjsc1PxkseyfhRlEROdOgRw==
X-Received: by 2002:adf:f846:: with SMTP id d6mr17433077wrq.56.1601886235154; 
 Mon, 05 Oct 2020 01:23:55 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6468:f312:2e86:3d8b:8b70:920c])
 by smtp.gmail.com with ESMTPSA id z15sm11931434wrv.94.2020.10.05.01.23.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2020 01:23:54 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 08/19] configure: remove useless config-target.mak symbols
Date: Mon,  5 Oct 2020 10:23:38 +0200
Message-Id: <20201005082349.354095-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201005082349.354095-1-pbonzini@redhat.com>
References: <20201005082349.354095-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.248,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Omit symbols that are not needed by softmmu or bsd-user targets,
in preparation for moving the generated config-target.mak files
into the source tree.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/configure b/configure
index 7058ac10e9..a8e314dd53 100755
--- a/configure
+++ b/configure
@@ -7471,7 +7471,7 @@ case "$target_name" in
   mips|mipsel)
     mttcg="yes"
     TARGET_ARCH=mips
-    echo "TARGET_ABI_MIPSO32=y" >> $config_target_mak
+    test "$target_user_only" = yes && echo "TARGET_ABI_MIPSO32=y" >> $config_target_mak
     TARGET_SYSTBL_ABI=o32
     TARGET_SYSTBL=syscall_o32.tbl
   ;;
@@ -7479,8 +7479,8 @@ case "$target_name" in
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
@@ -7488,7 +7488,7 @@ case "$target_name" in
     mttcg="no"
     TARGET_ARCH=mips64
     TARGET_BASE_ARCH=mips
-    echo "TARGET_ABI_MIPSN64=y" >> $config_target_mak
+    test "$target_user_only" = yes && echo "TARGET_ABI_MIPSN64=y" >> $config_target_mak
     TARGET_SYSTBL_ABI=n64
     TARGET_SYSTBL=syscall_n64.tbl
   ;;
@@ -7524,7 +7524,7 @@ case "$target_name" in
     TARGET_BASE_ARCH=ppc
     TARGET_ABI_DIR=ppc
     TARGET_SYSTBL_ABI=common,nospu,32
-    echo "TARGET_ABI32=y" >> $config_target_mak
+    test "$target_user_only" = yes && echo "TARGET_ABI32=y" >> $config_target_mak
     gdb_xml_files="power64-core.xml power-fpu.xml power-altivec.xml power-spe.xml power-vsx.xml"
   ;;
   riscv32)
@@ -7562,7 +7562,7 @@ case "$target_name" in
     TARGET_BASE_ARCH=sparc
     TARGET_ABI_DIR=sparc
     TARGET_SYSTBL_ABI=common,32
-    echo "TARGET_ABI32=y" >> $config_target_mak
+    test "$target_user_only" = yes && echo "TARGET_ABI32=y" >> $config_target_mak
   ;;
   s390x)
     TARGET_SYSTBL_ABI=common,64
@@ -7600,15 +7600,18 @@ upper() {
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



