Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F35C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 08:44:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E362C2064C
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 08:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SrWb8gs4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E362C2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPM6w-0005Ra-TT
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 04:44:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37020)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPLmu-0008Bm-8d
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 04:24:04 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:37117)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPLmr-0007Ka-S0
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 04:24:03 -0400
Received: by mail-wm1-x333.google.com with SMTP id j136so7820215wmj.2
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 01:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WbvNVyyQpGtC2FSjWBIrKLh9s7jbXnVwEiQ8gZ/iym8=;
 b=SrWb8gs4zEToXhB+B/ASeqhT9xzaWAsI76zNuJ68wMyB5xc/qBSFxTJNDMOgy0hz6+
 H0GR0TlorFZ24LvHZvxCcM69SmhYkqW23BEfy5H0mDBUsAizGVtfEvINAQiaAHuen6Po
 Hb3/K4iHYlM2BNZTDq4sjroQI4z2umj9Ur74SXW8UTREA6mqKN4KWSI9CHQYtExspDZK
 5AN6eR1ZilYCSWJ3HIKPWxPqlH9hfo3mfCWQ7REPg8dqpajgeCSbsiJhT8nqri563E8K
 veT2U5zZSMJJ263NW+8Imbh1f+NSkhn+cPQovD14UIDWHstUNlkFwvfxR9jUv3EfB0gm
 TwYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=WbvNVyyQpGtC2FSjWBIrKLh9s7jbXnVwEiQ8gZ/iym8=;
 b=LTAmtJ2K7tGD4l3NQh8vvX2PsyAcSXDIWSmPLgJ5i1mDuy3C6jSbyRJaOkRoiFEj+m
 SQNxA7PVVsC1yDZqUCOZ0gWFbW4NIbPdhCurqfI9ru6T/s6ZZ2ZvPRGrjrhjSZwqt5WX
 lfVDOSzyTu5EAoKg/wPfowAnBboWKhLJ3+sjuDu83KPP1B9kk2iWN95GvJF4US5sQI7I
 CySdufEc4J4Krwo6nUCD7ZZwhdzp/sL5b4mRcYARd3rmMaS3aueMyEcGwEmivsbC3kkP
 vogBayAKPvOQI5xka9U7rVabxwYjqGqeYPjHHfO6u4am9JbBHKxNlJkLtvMIow2a+IDz
 3GnQ==
X-Gm-Message-State: AOAM530G2JaLnkKNJHz/j5gFzdF25zz4fxYxkWiD9plBzOd2O93nzFJt
 DViXNUxCYxVLzJttv6WxKy6zRmuf0mk=
X-Google-Smtp-Source: ABdhPJyKaM17wgOHpkP+COrmquak3CkldpR5kT075od6+5J+MqOR8c8qmman/xdiDLud4jD/f0HN0A==
X-Received: by 2002:a7b:c4c3:: with SMTP id g3mr16486446wmk.128.1601886239979; 
 Mon, 05 Oct 2020 01:23:59 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6468:f312:2e86:3d8b:8b70:920c])
 by smtp.gmail.com with ESMTPSA id z15sm11931434wrv.94.2020.10.05.01.23.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2020 01:23:59 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 14/19] meson: move sparse detection to Meson and rewrite
 check_sparse.py
Date: Mon,  5 Oct 2020 10:23:44 +0200
Message-Id: <20201005082349.354095-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201005082349.354095-1-pbonzini@redhat.com>
References: <20201005082349.354095-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wm1-x333.google.com
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
index b31bf24d60..baa245b5ad 100755
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
@@ -7382,7 +7366,7 @@ NINJA=${ninja:-$PWD/ninjatool} $meson setup \
         -Dstrip=$(if test "$strip_opt" = yes; then echo true; else echo false; fi) \
         -Db_pie=$(if test "$pie" = yes; then echo true; else echo false; fi) \
         -Db_coverage=$(if test "$gcov" = yes; then echo true; else echo false; fi) \
-	-Dmalloc=$malloc -Dmalloc_trim=$malloc_trim \
+	-Dmalloc=$malloc -Dmalloc_trim=$malloc_trim -Dsparse=$sparse \
 	-Dkvm=$kvm -Dhax=$hax -Dwhpx=$whpx -Dhvf=$hvf \
 	-Dxen=$xen -Dxen_pci_passthrough=$xen_pci_passthrough -Dtcg=$tcg \
 	-Dcocoa=$cocoa -Dmpath=$mpath -Dsdl=$sdl -Dsdl_image=$sdl_image \
diff --git a/meson.build b/meson.build
index 9a90d19113..1dd3f49011 100644
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
@@ -1557,7 +1559,7 @@ summary_info += {'host CPU':          cpu}
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



