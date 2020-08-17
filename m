Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EEDAC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:52:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 295B1204FD
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L167BocW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 295B1204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7gUj-0005ya-9k
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 10:52:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40644)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gGm-0003ns-Nx
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:37:52 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:41870)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gGl-00064K-0Q
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:37:52 -0400
Received: by mail-wr1-x435.google.com with SMTP id r2so15266270wrs.8
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 07:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pjHPdTSEtllDij+zXCCOkgSX4mQ0mNOLN2bMHomzYEY=;
 b=L167BocW5B37/ru9Q8OW8GKUCYY6FBFTccRI8lyDI2+teCrIuLo37TqSNTi1OD0mzV
 ZwMWZkhM/89pa9yTPlzpUnP6UhpHK7XhNNSl4j9jxKQsYlTWuSW1fhQ54T/3t4ZrwbyA
 HKha10FNROB6m2mee/xwrc7+e71JuoG/6V7fjGoKI07z07phv4Ek2KEa5OCyWSTrcxd3
 wJuz8blNbOqAzQGBhoTlGg7Qjtzw8BxMB3wcR8DXxS07Nx35EUX0+JZUJMlF2ufLDP44
 FHYpxi3hrArlTLi65c+9N9S1Bm6SwJVX5NAwL4rJpDV2Qcx/3yu40S23WWiMl1um17W5
 bgzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=pjHPdTSEtllDij+zXCCOkgSX4mQ0mNOLN2bMHomzYEY=;
 b=GGZToI88abptZPe1gdFGmFxVVVu7affexYNNecHyXOKZiQeNMbnwge89sg9XT2zJW2
 25RKNEa8zSgN8u5Sc/2CicYgz3JjIsufSx6HDNBtrzTz1/8koUo7h63sBslWhNxM7vTZ
 JQZvF6W/Bx4mK2eUG1wvUlktDEWUXDYnURvUxFPSdbxNgXBcGK1d05o50mKfF9pw7Hyd
 F7u7EsjNG0GcAf/HUqxg+Z3Ck02asFXF8Me3noWWw7R/0Vie2YritLrUEsSxl2x31CDZ
 FrkIX06gIgI3SKEchQ/tOG9wUen8cVquoAIuQpNA/0PWGHH+ku2bkpFAghHwOT2IyGSA
 a6jA==
X-Gm-Message-State: AOAM5339xEjhmQcCIuCRTu4w4QY/UX4CgjMYa8xaX4F3FuhAvhlzjPUC
 N48kwWBcMICUj0BI6+/GIu2FjI60Tlg=
X-Google-Smtp-Source: ABdhPJzMXPtmypvOd2d543sVK0swn9DW1dxRBx2vTDWNPDbcdzStk7t7zGlgzncRP65UuyqSawww6A==
X-Received: by 2002:a5d:5272:: with SMTP id l18mr14149269wrc.89.1597675069360; 
 Mon, 17 Aug 2020 07:37:49 -0700 (PDT)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:a0d1:fc42:c610:f977])
 by smtp.gmail.com with ESMTPSA id
 i22sm34966603wrb.45.2020.08.17.07.37.48 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 07:37:49 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 022/150] meson: add sparse support
Date: Mon, 17 Aug 2020 16:35:15 +0200
Message-Id: <20200817143723.343284-23-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200817143723.343284-1-pbonzini@redhat.com>
References: <20200817143723.343284-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wr1-x435.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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

Do not use cgcc; instead, extract compilation commands from compile_commands.json
and invoke sparse directly.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile                |  1 +
 configure               |  8 ++------
 meson.build             |  7 +++++++
 scripts/check_sparse.py | 25 +++++++++++++++++++++++++
 4 files changed, 35 insertions(+), 6 deletions(-)
 create mode 100644 scripts/check_sparse.py

diff --git a/Makefile b/Makefile
index 578aa99942..8288e2fbd2 100644
--- a/Makefile
+++ b/Makefile
@@ -1254,6 +1254,7 @@ endif
 	$(call print-help,install,Install QEMU, documentation and tools)
 	$(call print-help,ctags/TAGS,Generate tags file for editors)
 	$(call print-help,cscope,Generate cscope index)
+	$(call print-help,sparse,Run sparse on the QEMU source)
 	@echo  ''
 	@$(if $(TARGET_DIRS), \
 		echo 'Architecture specific targets:'; \
diff --git a/configure b/configure
index 9f20bf1d36..d4172b06a7 100755
--- a/configure
+++ b/configure
@@ -3009,7 +3009,7 @@ fi
 ##########################################
 # Sparse probe
 if test "$sparse" != "no" ; then
-  if has cgcc; then
+  if has sparse; then
     sparse=yes
   else
     if test "$sparse" = "yes" ; then
@@ -7810,11 +7810,7 @@ echo "QEMU_CFLAGS=$QEMU_CFLAGS" >> $config_host_mak
 echo "QEMU_CXXFLAGS=$QEMU_CXXFLAGS" >> $config_host_mak
 echo "QEMU_INCLUDES=$QEMU_INCLUDES" >> $config_host_mak
 if test "$sparse" = "yes" ; then
-  echo "CC           := REAL_CC=\"\$(CC)\" cgcc"       >> $config_host_mak
-  echo "CPP          := REAL_CC=\"\$(CPP)\" cgcc"      >> $config_host_mak
-  echo "CXX          := REAL_CC=\"\$(CXX)\" cgcc"      >> $config_host_mak
-  echo "HOST_CC      := REAL_CC=\"\$(HOST_CC)\" cgcc"  >> $config_host_mak
-  echo "QEMU_CFLAGS  += -Wbitwise -Wno-transparent-union -Wno-old-initializer -Wno-non-pointer-null" >> $config_host_mak
+  echo "SPARSE_CFLAGS = -Wbitwise -Wno-transparent-union -Wno-old-initializer -Wno-non-pointer-null" >> $config_host_mak
 fi
 echo "QEMU_LDFLAGS=$QEMU_LDFLAGS" >> $config_host_mak
 echo "LDFLAGS_NOPIE=$LDFLAGS_NOPIE" >> $config_host_mak
diff --git a/meson.build b/meson.build
index e6f9dfb070..e15e072a8c 100644
--- a/meson.build
+++ b/meson.build
@@ -17,6 +17,13 @@ add_project_arguments(config_host['QEMU_INCLUDES'].split(),
 
 python = import('python').find_installation()
 
+if 'SPARSE_CFLAGS' in config_host
+  run_target('sparse',
+             command: [find_program('scripts/check_sparse.py'),
+                       config_host['SPARSE_CFLAGS'].split(),
+                       'compile_commands.json'])
+endif
+
 if host_machine.system() == 'darwin'
   add_languages('objc', required: false, native: false)
 endif
diff --git a/scripts/check_sparse.py b/scripts/check_sparse.py
new file mode 100644
index 0000000000..0de7aa55d9
--- /dev/null
+++ b/scripts/check_sparse.py
@@ -0,0 +1,25 @@
+#! /usr/bin/env python3
+
+# Invoke sparse based on the contents of compile_commands.json
+
+import json
+import subprocess
+import sys
+import shlex
+
+def extract_cflags(shcmd):
+    cflags = shlex.split(shcmd)
+    return [x for x in cflags
+            if x.startswith('-D') or x.startswith('-I') or x.startswith('-W')
+               or x.startswith('-std=')]
+
+cflags = sys.argv[1:-1]
+with open(sys.argv[-1], 'r') as fd:
+    compile_commands = json.load(fd)
+
+for cmd in compile_commands:
+    cmd = ['sparse'] + cflags + extract_cflags(cmd['command']) + [cmd['file']]
+    print(' '.join((shlex.quote(x) for x in cmd)))
+    r = subprocess.run(cmd)
+    if r.returncode != 0:
+        sys.exit(r.returncode)
-- 
2.26.2



