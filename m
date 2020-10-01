Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DBECC4727C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 15:55:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA46C20872
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 15:54:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQD0Af2m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA46C20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO0v4-00025I-QD
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 11:54:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33478)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kO0tV-0008PT-5B
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 11:53:21 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:39701)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kO0tS-0005j3-WA
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 11:53:20 -0400
Received: by mail-wm1-x32b.google.com with SMTP id t17so3674761wmi.4
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 08:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=zSYOXeSlcSA7ke+ZuZ7jMFx/GITH0sskN+zpeSvAgv4=;
 b=JQD0Af2mLBZHxWB+HG2xSQaY1LnAyaizlfEdNMHCf1DLlEoXvOvga0obIDrkHE1Gak
 Q+Qx47BitZbEmcbrG7Inu378CNSZWmHW2LL5gfhtcwXXOeQ3BforoygRWbgAQgckWgMv
 nYmf6rikaEwwN8sK22qEGvZ5ijemtjhNQL+VWYEiXHDGHti6klOQNNtMjqe0bJ3+Pp7j
 xxxq0gZPthUb2TrU+zJWh0GuK72arloTjrTVtSJTWUF/kvcEnG7f+cMZc9PEkELzurOM
 V+W0Q/DhBuuS046Ju5s8Z/1ptvZiswIjFeO3pQ1zUTMqUCtB37Id7BbNvdDt5TY7lNrK
 nT8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=zSYOXeSlcSA7ke+ZuZ7jMFx/GITH0sskN+zpeSvAgv4=;
 b=QO9SZjfDNnDv/OagE7RgXpX3QVBXuDeZdneILYC8uw+0rxP2u+KpU3AsAguOk0JHhH
 RtQmqTH+71D0Tf3kalb0HViLxF309CqCGSJR3NVDB4m96mePwgyd7AlTJZu1mpsVk2fr
 8XNLjZRkotXkLu70Au9Kkxbm4CAlX0M5sekMqCMzEyGm9yY1+hXvviOWxCVo0oi4888a
 K+czSiX0n8/jlsMzyWYMDWO1VQe4vossIGzXyTxIyuCH9InfmC4DihyV6AXR1mzD0Rax
 rzhjhos4vidSaoPhBsqhxLG5ba1t5rCtXb4MWi6J0E26lhVfuGauBxxjQlvAydpGfLL+
 4DAA==
X-Gm-Message-State: AOAM530xwRrCO2ZUmAiJAbgYJ9mt0iirvVXeAkqFr7yB/DHvTDiCBUY5
 jW4iB5ImnYRma+ujDhvsyESM6p26QdQ=
X-Google-Smtp-Source: ABdhPJxk8dxxa4URUpjaaqPsq6or3g/bimJ0dn9RDm4oFoxSWE8mj0RbM+qE+19w2L94zfPfbVPwMg==
X-Received: by 2002:a1c:7d55:: with SMTP id y82mr692324wmc.100.1601567597048; 
 Thu, 01 Oct 2020 08:53:17 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6468:f312:86de:492a:fae3:16f2])
 by smtp.gmail.com with ESMTPSA id g14sm9739399wrv.25.2020.10.01.08.53.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2020 08:53:15 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] meson: move sparse detection to Meson and rewrite
 check_sparse.py
Date: Thu,  1 Oct 2020 17:53:13 +0200
Message-Id: <20201001155313.18364-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wm1-x32b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
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

Pass the path to the program to scripts/check_sparse.py, which
previously was not included in config-host.mak.  Change
scripts/check_sparse.py to work with cgcc, which seems to
work better with sparse 0.6.x.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure               | 24 +++---------------
 meson.build             | 10 +++++---
 meson_options.txt       |  2 ++
 scripts/check_sparse.py | 56 +++++++++++++++++++++++++++++++++--------
 4 files changed, 57 insertions(+), 35 deletions(-)

diff --git a/configure b/configure
index 73e3b14749..02a091dafb 100755
--- a/configure
+++ b/configure
@@ -303,7 +303,7 @@ sdl_image="auto"
 virtfs=""
 mpath="auto"
 vnc="enabled"
-sparse="no"
+sparse="auto"
 vde=""
 vnc_sasl="auto"
 vnc_jpeg="auto"
@@ -1040,9 +1040,9 @@ for opt do
   ;;
   --disable-tsan) tsan="no"
   ;;
-  --enable-sparse) sparse="yes"
+  --enable-sparse) sparse="enabled"
   ;;
-  --disable-sparse) sparse="no"
+  --disable-sparse) sparse="disabled"
   ;;
   --disable-strip) strip_opt="no"
   ;;
@@ -2875,19 +2875,6 @@ if test "$gettext" != "false" ; then
   fi
 fi
 
-##########################################
-# Sparse probe
-if test "$sparse" != "no" ; then
-  if has sparse; then
-    sparse=yes
-  else
-    if test "$sparse" = "yes" ; then
-      feature_not_found "sparse" "Install sparse binary"
-    fi
-    sparse=no
-  fi
-fi
-
 ##########################################
 # X11 probe
 if $pkg_config --exists "x11"; then
@@ -7127,9 +7114,6 @@ echo "QEMU_CXXFLAGS=$QEMU_CXXFLAGS" >> $config_host_mak
 echo "QEMU_INCLUDES=$QEMU_INCLUDES" >> $config_host_mak
 echo "GLIB_CFLAGS=$glib_cflags" >> $config_host_mak
 echo "GLIB_LIBS=$glib_libs" >> $config_host_mak
-if test "$sparse" = "yes" ; then
-  echo "SPARSE_CFLAGS = -Wbitwise -Wno-transparent-union -Wno-old-initializer -Wno-non-pointer-null" >> $config_host_mak
-fi
 echo "QEMU_LDFLAGS=$QEMU_LDFLAGS" >> $config_host_mak
 echo "LDFLAGS_NOPIE=$LDFLAGS_NOPIE" >> $config_host_mak
 echo "LD_I386_EMULATION=$ld_i386_emulation" >> $config_host_mak
@@ -7383,7 +7367,7 @@ NINJA=${ninja:-$PWD/ninjatool} $meson setup \
         -Dstrip=$(if test "$strip_opt" = yes; then echo true; else echo false; fi) \
         -Db_pie=$(if test "$pie" = yes; then echo true; else echo false; fi) \
         -Db_coverage=$(if test "$gcov" = yes; then echo true; else echo false; fi) \
-	-Dmalloc=$malloc -Dmalloc_trim=$malloc_trim \
+	-Dmalloc=$malloc -Dmalloc_trim=$malloc_trim -Dsparse=$sparse \
 	-Dkvm=$kvm -Dhax=$hax -Dwhpx=$whpx -Dhvf=$hvf \
 	-Dxen=$xen -Dxen_pci_passthrough=$xen_pci_passthrough -Dtcg=$tcg \
 	-Dcocoa=$cocoa -Dmpath=$mpath -Dsdl=$sdl -Dsdl_image=$sdl_image \
diff --git a/meson.build b/meson.build
index baaeab459d..40af93fa53 100644
--- a/meson.build
+++ b/meson.build
@@ -102,11 +102,13 @@ if host_machine.system() == 'darwin'
   add_languages('objc', required: false, native: false)
 endif
 
-if 'SPARSE_CFLAGS' in config_host
+sparse = find_program('cgcc', required: get_option('sparse'))
+if sparse.found()
   run_target('sparse',
              command: [find_program('scripts/check_sparse.py'),
-                       config_host['SPARSE_CFLAGS'].split(),
-                       'compile_commands.json'])
+                       'compile_commands.json', sparse.full_path(), '-Wbitwise',
+                       '-Wno-transparent-union', '-Wno-old-initializer',
+                       '-Wno-non-pointer-null'])
 endif
 
 ###########################################
@@ -1556,7 +1558,7 @@ summary_info += {'host CPU':          cpu}
 summary_info += {'host endianness':   build_machine.endian()}
 summary_info += {'target list':       ' '.join(target_dirs)}
 summary_info += {'gprof enabled':     config_host.has_key('CONFIG_GPROF')}
-summary_info += {'sparse enabled':    meson.get_compiler('c').cmd_array().contains('cgcc')}
+summary_info += {'sparse enabled':    sparse.found()}
 summary_info += {'strip binaries':    get_option('strip')}
 summary_info += {'profiler':          config_host.has_key('CONFIG_PROFILER')}
 summary_info += {'static build':      config_host.has_key('CONFIG_STATIC')}
diff --git a/meson_options.txt b/meson_options.txt
index 05adc7a179..bc5c674642 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -5,6 +5,8 @@ option('docdir', type : 'string', value : 'doc',
 
 option('gettext', type : 'boolean', value : true,
        description: 'Localization of the GTK+ user interface')
+option('sparse', type : 'feature', value : 'auto',
+       description: 'sparse checker')
 
 option('malloc_trim', type : 'feature', value : 'auto',
        description: 'enable libc malloc_trim() for memory optimization')
diff --git a/scripts/check_sparse.py b/scripts/check_sparse.py
index 0de7aa55d9..2956124442 100644
--- a/scripts/check_sparse.py
+++ b/scripts/check_sparse.py
@@ -1,25 +1,59 @@
 #! /usr/bin/env python3
 
-# Invoke sparse based on the contents of compile_commands.json
+# Invoke sparse based on the contents of compile_commands.json,
+# also working around several deficiencies in cgcc's command line
+# parsing
 
 import json
 import subprocess
+import os
 import sys
 import shlex
 
-def extract_cflags(shcmd):
-    cflags = shlex.split(shcmd)
-    return [x for x in cflags
-            if x.startswith('-D') or x.startswith('-I') or x.startswith('-W')
-               or x.startswith('-std=')]
+def cmdline_for_sparse(sparse, cmdline):
+    # Do not include the C compiler executable
+    skip = True
+    arg = False
+    out = sparse + ['-no-compile']
+    for x in cmdline:
+        if arg:
+            out.append(x)
+            arg = False
+            continue
+        if skip:
+            skip = False
+            continue
+        # prevent sparse from treating output files as inputs
+        if x == '-MF' or x == '-MQ' or x == '-o':
+            skip = True
+            continue
+        # cgcc ignores -no-compile if it sees -M or -MM?
+        if x.startswith('-M'):
+            continue
+        # sparse does not understand these!
+        if x == '-iquote' or x == '-isystem':
+            x = '-I'
+        if x == '-I':
+            arg = True
+        out.append(x)
+    return out
 
-cflags = sys.argv[1:-1]
-with open(sys.argv[-1], 'r') as fd:
+root_path = os.getenv('MESON_BUILD_ROOT')
+def build_path(s):
+    return s if not root_path else os.path.join(root_path, s)
+
+ccjson_path = build_path(sys.argv[1])
+with open(ccjson_path, 'r') as fd:
     compile_commands = json.load(fd)
 
+sparse = sys.argv[2:]
+sparse_env = os.environ.copy()
 for cmd in compile_commands:
-    cmd = ['sparse'] + cflags + extract_cflags(cmd['command']) + [cmd['file']]
-    print(' '.join((shlex.quote(x) for x in cmd)))
-    r = subprocess.run(cmd)
+    cmdline = shlex.split(cmd['command'])
+    cmd = cmdline_for_sparse(sparse, cmdline)
+    print('REAL_CC=%s' % shlex.quote(cmdline[0]),
+          ' '.join((shlex.quote(x) for x in cmd)))
+    sparse_env['REAL_CC'] = cmdline[0]
+    r = subprocess.run(cmd, env=sparse_env, cwd=root_path)
     if r.returncode != 0:
         sys.exit(r.returncode)
-- 
2.26.2


