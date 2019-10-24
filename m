Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50662CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 16:34:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2567121906
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 16:34:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2567121906
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNg3n-0000Xn-Hl
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 12:34:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49280)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iNfCp-0005m3-Ld
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 11:39:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iNfCl-0000S0-VD
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 11:39:19 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:38911)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iNfCl-0000QG-Lc
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 11:39:15 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Mtfa5-1i9RER2wb1-00v9YY; Thu, 24 Oct 2019 17:38:52 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH v3] linux-user: manage binfmt-misc preserve-arg[0] flag
Date: Thu, 24 Oct 2019 17:38:47 +0200
Message-Id: <20191024153847.31815-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:x5gh9EuzJOc9DIK8kGSHKB7aeZV96XQ5z4Ni9URsl4w7F61Tu36
 cAr/X4Y6mYGrOFxRmAmpZds3gWPBVcYZUMT3BldbqI/lGPZ/ikyYJKw8vgi74pZ+wVXgzlQ
 eKEG151fhrkTrVD0iAuTapepIF+svEWro5MnFoWGodVOah2kl2viW9MVJ3sMIyzX6ISpIPC
 gxIFd9SEQHNYLiv2trfZw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ajhX67FJl74=:flU6qwJvKy2rYmCUSEvI/M
 nmineMqmWCha/6e1c/RxjfLt3uUCSJIEXPHrL08vVg7eQ8ast1dBe2tteweB/zgUe79qyuTVn
 UumSoQjr6Jg7e7GwihTarG8hK9LJBtXBFgXBqBM77AKQAQ0qRtGSkUm3JwcH87geGGuy9aTfF
 r34P8zZ1KWhhk/Sb5temIFcKHJLBll7QXh0xEaGqzAedPHSVd+0DD5aA4+KPFwp4XqMLSQamU
 uFwjzmJlF+vk95djbR8353Rio/r/JF4FVhUf6yw0tUvGazsXMpEqW/ExyEtqEgfOBE0jXtFkn
 t2Ek+gT1Hj4QR9EohD9y293Z2v5lc91TJSRKH0xIXqgnd6mlC0G1Ts9wlkK8RGEawe4m3CXYi
 68uohws3yvZPLJMxRsBnNHMMqTudBBpEPTFWRhQQYYIuMWuh9vNckkiVYUQChzL9DO2wpWWak
 d2KGSPcDhexEdUiduZO5F/D1vbDh8jAjg7XAgi+ItgMXhAR1dVYUJdu89O7w3kvxEhka5OE43
 RSymB7Pi141VcBBKCCiv+38wvZsaExW385phfAKcjzfGXqFC2PQ96GR87bAjG5Hy4cEfYwGpR
 25n/fCyX3MtPiUiGI291KR8O14JJfod24TR0hoqO1Qjii45heaMol4j0PqQwhNLsCPYwNs1BV
 1C8CLC90wIxODslkjhmFa0nBPL3et3M61P2HcctzgJh/jnwiWYmd/4U41O9NjVlHe4ISGkQBX
 vJCzj7E21RQybm9J2zuOYptllaAeIsuOx8OyjkqFSbY/JXT225K0yy2k6zp/puNL5ExoiJrr2
 zTrY0VOVFiyWlZ6Rg9PxPzTpZgo4uT6ldwrV/8cFOOWDxE1nHJv2ycZFUPw+28mIbA7BSSLIx
 YAgH8DEiwXXQkO//1E1w==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 217.72.192.75
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
Cc: Christophe de Dinechin <dinechin@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add --preserve-argv0 in qemu-binfmt-conf.sh to configure the preserve-argv0
flag.

Now, if QEMU is started with -0 or QEMU_ARGV0 and an empty parameter
argv[0] (the full pathname provided by binfmt-misc) is removed and
replaced by argv[1] (the original argv[0] provided by binfmt-misc when
'P'/preserve-arg[0] is set)

For instance:

  $ sudo QEMU_ARGV0= chroot m68k-chroot sh -c 'echo $0'
  sh

without this patch:

  $ sudo chroot m68k-chroot sh -c 'echo $0'
  /usr/bin/sh

QEMU can be forced to always use preserve-argv[0] at configuration
time with --force-preserve-argv0

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 configure                   |  8 +++++++
 linux-user/main.c           | 24 +++++++++++++++++++-
 scripts/qemu-binfmt-conf.sh | 44 +++++++++++++++++++++++--------------
 3 files changed, 58 insertions(+), 18 deletions(-)

diff --git a/configure b/configure
index 145fcabbb3c3..94c41f0a068a 100755
--- a/configure
+++ b/configure
@@ -497,6 +497,7 @@ sheepdog="yes"
 libxml2=""
 debug_mutex="no"
 libpmem=""
+force_preserve_argv0="no"
 default_devices="yes"
 
 supported_cpu="no"
@@ -1529,6 +1530,8 @@ for opt do
   ;;
   --disable-xkbcommon) xkbcommon=no
   ;;
+  --force-preserve-argv0) force_preserve_argv0=yes
+  ;;
   *)
       echo "ERROR: unknown option $opt"
       echo "Try '$0 --help' for more information"
@@ -1710,6 +1713,8 @@ Advanced options (experts only):
   --enable-profiler        profiler support
   --enable-debug-stack-usage
                            track the maximum stack usage of stacks created by qemu_alloc_stack
+  --force-preserve-argv0   for linux-user only, force the use of binfmt_misc 'P'
+                           flag (preserve-argv[0])
 
 Optional features, enabled with --enable-FEATURE and
 disabled with --disable-FEATURE, default is enabled if available:
@@ -7633,6 +7638,9 @@ if test "$target_user_only" = "yes" ; then
 fi
 if test "$target_linux_user" = "yes" ; then
   echo "CONFIG_LINUX_USER=y" >> $config_target_mak
+  if test "$force_preserve_argv0" = "yes" ; then
+    echo "CONFIG_FORCE_PRESERVE_ARGV0=y" >> $config_target_mak
+  fi
 fi
 list=""
 if test ! -z "$gdb_xml_files" ; then
diff --git a/linux-user/main.c b/linux-user/main.c
index 560d053f7249..1b4df24ef483 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -616,6 +616,7 @@ int main(int argc, char **argv, char **envp)
     int ret;
     int execfd;
     unsigned long max_reserved_va;
+    bool preserve_argv0;
 
     error_init(argv[0]);
     module_call_init(MODULE_INIT_TRACE);
@@ -664,6 +665,9 @@ int main(int argc, char **argv, char **envp)
 
     init_qemu_uname_release();
 
+    /*
+     * Manage binfmt-misc open-binary flag
+     */
     execfd = qemu_getauxval(AT_EXECFD);
     if (execfd == 0) {
         execfd = open(exec_path, O_RDONLY);
@@ -673,6 +677,24 @@ int main(int argc, char **argv, char **envp)
         }
     }
 
+     /*
+      * argv0 with an empty string will set argv[optind + 1]
+      * as target_argv[0]
+      */
+#ifdef CONFIG_FORCE_PRESERVE_ARGV0
+    preserve_argv0 = true;
+#else
+    preserve_argv0 = (argv0 != NULL && argv0[0] == 0);
+#endif
+    /*
+     * Manage binfmt-misc preserve-arg[0] flag
+     *    argv[optind]     full path to the binary
+     *    argv[optind + 1] original argv[0]
+     */
+    if (optind + 1 < argc && preserve_argv0) {
+        optind++;
+    }
+
     if (cpu_model == NULL) {
         cpu_model = cpu_get_model(get_elf_eflags(execfd));
     }
@@ -777,7 +799,7 @@ int main(int argc, char **argv, char **envp)
      * argv[0] pointer with the given one.
      */
     i = 0;
-    if (argv0 != NULL) {
+    if (argv0 != NULL && argv0[0] != 0) {
         target_argv[i++] = strdup(argv0);
     }
     for (; i < target_argc; i++) {
diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh
index b5a16742a149..275d3cf57e83 100755
--- a/scripts/qemu-binfmt-conf.sh
+++ b/scripts/qemu-binfmt-conf.sh
@@ -170,25 +170,27 @@ usage() {
 Usage: qemu-binfmt-conf.sh [--qemu-path PATH][--debian][--systemd CPU]
                            [--help][--credential yes|no][--exportdir PATH]
                            [--persistent yes|no][--qemu-suffix SUFFIX]
+                           [--preserve-argv0 yes|no]
 
        Configure binfmt_misc to use qemu interpreter
 
-       --help:        display this usage
-       --qemu-path:   set path to qemu interpreter ($QEMU_PATH)
-       --qemu-suffix: add a suffix to the default interpreter name
-       --debian:      don't write into /proc,
-                      instead generate update-binfmts templates
-       --systemd:     don't write into /proc,
-                      instead generate file for systemd-binfmt.service
-                      for the given CPU. If CPU is "ALL", generate a
-                      file for all known cpus
-       --exportdir:   define where to write configuration files
-                      (default: $SYSTEMDDIR or $DEBIANDIR)
-       --credential:  if yes, credential and security tokens are
-                      calculated according to the binary to interpret
-       --persistent:  if yes, the interpreter is loaded when binfmt is
-                      configured and remains in memory. All future uses
-                      are cloned from the open file.
+       --help:          display this usage
+       --qemu-path:     set path to qemu interpreter ($QEMU_PATH)
+       --qemu-suffix:   add a suffix to the default interpreter name
+       --debian:        don't write into /proc,
+                        instead generate update-binfmts templates
+       --systemd:       don't write into /proc,
+                        instead generate file for systemd-binfmt.service
+                        for the given CPU. If CPU is "ALL", generate a
+                        file for all known cpus
+       --exportdir:     define where to write configuration files
+                        (default: $SYSTEMDDIR or $DEBIANDIR)
+       --credential:    if yes, credential and security tokens are
+                        calculated according to the binary to interpret
+       --persistent:    if yes, the interpreter is loaded when binfmt is
+                        configured and remains in memory. All future uses
+                        are cloned from the open file.
+       --preserve-argv0 preserve argv[0]
 
     To import templates with update-binfmts, use :
 
@@ -261,6 +263,9 @@ qemu_generate_register() {
     if [ "$PERSISTENT" = "yes" ] ; then
         flags="${flags}F"
     fi
+    if [ "$PRESERVE_ARG0" = "yes" ] ; then
+        flags="${flags}P"
+    fi
 
     echo ":qemu-$cpu:M::$magic:$mask:$qemu:$flags"
 }
@@ -322,9 +327,10 @@ DEBIANDIR="/usr/share/binfmts"
 QEMU_PATH=/usr/local/bin
 CREDENTIAL=no
 PERSISTENT=no
+PRESERVE_ARG0=no
 QEMU_SUFFIX=""
 
-options=$(getopt -o ds:Q:S:e:hc:p: -l debian,systemd:,qemu-path:,qemu-suffix:,exportdir:,help,credential:,persistent: -- "$@")
+options=$(getopt -o ds:Q:S:e:hc:p:0: -l debian,systemd:,qemu-path:,qemu-suffix:,exportdir:,help,credential:,persistent:,preserve-argv0: -- "$@")
 eval set -- "$options"
 
 while true ; do
@@ -380,6 +386,10 @@ while true ; do
         shift
         PERSISTENT="$1"
         ;;
+    -0|--preserve-argv0)
+        shift
+        PRESERVE_ARG0="$1"
+        ;;
     *)
         break
         ;;
-- 
2.21.0


