Return-Path: <SRS0=PtAT=XD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28121C4332F
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2019 10:53:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3164206BB
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2019 10:53:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3164206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6uor-0004i8-1Q
	for qemu-devel@archiver.kernel.org; Sun, 08 Sep 2019 06:53:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54496)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1i6ukI-0003bE-Hc
 for qemu-devel@nongnu.org; Sun, 08 Sep 2019 06:48:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1i6ukH-0004dK-0m
 for qemu-devel@nongnu.org; Sun, 08 Sep 2019 06:48:38 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:41225)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1i6ukG-0004Zh-N1
 for qemu-devel@nongnu.org; Sun, 08 Sep 2019 06:48:36 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1M3lLh-1i7k5W2zTP-000pnG; Sun, 08 Sep 2019 12:48:21 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Sun,  8 Sep 2019 12:48:16 +0200
Message-Id: <20190908104816.20713-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190908104816.20713-1-laurent@vivier.eu>
References: <20190908104816.20713-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:EVsI7FIFmSXnS5IQGd5kgIfG67twZhCfL/POck0LtKLnxFF9A7x
 sN6m2sQx4Gjsvi3CYSmRq1aK0aPMTpfUZImek6GbVEc+fzU3emAa8cHgllNc4ozII1waFza
 Wzng/AW99zxxP5DU0VbJqWXwwJFalxxdY6UdIVRipi/NBAfW/UkgstQ1sCxdqdWKq8izFjO
 geHxYDq/UbSysPqIGP6gg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7cevyK/fQMU=:4WAtX6SDhDHCzHh4qtRc8F
 130mo2zfGXwrBQwGtjShVAd4iHj7WfZ5IxXBdg0K/hEKct/SnIU+yDGkwqWhi6v88pZkffCWK
 ms1CbB9WG5sBKAwSuNXKcQzLuxtBNByk8fXM0JNQ5zJe4rvBDu3wiAvYmDY+48nyjskO0oYx6
 Rh1iJBuaZZzFQ3yc5r5wWneVX2UDIMmS5hjU+oGrnSSbWkz5Vv6V1QwLqSvy7PtqSTpbP40ub
 sSzWZwf2HFhD6+z5MgIw8ySjN+T1vhEhbDHKWbqQU4XBH4StT9srB2v1tPh8p5lvUZK7+wlHz
 chBbgl7iPO2a0r1hAMvUis9L2p4OwvLXUdp2amUhIoS6O1Hrlm4sVpBsJ/0zpXSmrEa2BunDR
 nMENJc8QOkq7YIfdeKYSFbeoiM3H0OpB7X3Dd8adWLMooiDrJdF2iMEwaMf/7KzSrbwf7LeLW
 FERSt/uumSbMqgEff6/19ljXuMjcIq5lNBzlGr2MBd1te6F4XljPMNgl4mkb7Oo1BjnHjHAbU
 NWGVOuYCYkey7xQJUp0LIN7NlY9toZHSjaOtagc9gifBNgdeMnsL5p2AqZyzN1NGsaZWi1skk
 +YNSeFg981fmwUaKC78B/F5xrPOmf+bUFHnP5a57Kvd1E9kaxr/kQpu4S3kZkVBNNLKsS1KV8
 vJM2M2p3zh9IGGMHEsegzzGyYJAixmwAunJJ1KwdpHHERMGS9kqJgS/7rEqY1ba/kjweuI75b
 Qqx/OPWDsCvw1LLpXoJQEDIfvTrRotZlj1ScnNKqyYrfKjweHvSTF1eY4t65fdXOTzIejir+V
 9x09RUhbSEKEfL2OvlWgyi+bcf+JHrGjY4Y8xsH17JhB7uX42Q=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.10
Subject: [Qemu-devel] [PATCH v2 2/2] linux-user: manage binfmt-misc
 preserve-arg[0] flag
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add --preserve-arg0 in qemu-binfmt-conf.sh to configure the preserve-arg0
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

Notes:
    v2: add --force-preserve-argv0 configure option

 configure                   |  8 +++++++
 linux-user/main.c           | 24 +++++++++++++++++++-
 scripts/qemu-binfmt-conf.sh | 44 +++++++++++++++++++++++--------------
 3 files changed, 58 insertions(+), 18 deletions(-)

diff --git a/configure b/configure
index 95134c0180b2..3568e192776c 100755
--- a/configure
+++ b/configure
@@ -498,6 +498,7 @@ libxml2=""
 docker="no"
 debug_mutex="no"
 libpmem=""
+force_preserve_argv0="no"
 default_devices="yes"
 
 # cross compilers defaults, can be overridden with --cross-cc-ARCH
@@ -1543,6 +1544,8 @@ for opt do
   ;;
   --disable-libpmem) libpmem=no
   ;;
+  --force-preserve-argv0) force_preserve_argv0=yes
+  ;;
   *)
       echo "ERROR: unknown option $opt"
       echo "Try '$0 --help' for more information"
@@ -1740,6 +1743,8 @@ Advanced options (experts only):
   --enable-profiler        profiler support
   --enable-debug-stack-usage
                            track the maximum stack usage of stacks created by qemu_alloc_stack
+  --force-preserve-argv0   for linux-user only, force the use of binfmt_misc 'P'
+                           flag (preserve-argv[0])
 
 Optional features, enabled with --enable-FEATURE and
 disabled with --disable-FEATURE, default is enabled if available:
@@ -7736,6 +7741,9 @@ if test "$target_user_only" = "yes" ; then
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
index 28f0065b6ddf..02354d58e866 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -605,6 +605,7 @@ int main(int argc, char **argv, char **envp)
     int i;
     int ret;
     int execfd;
+    bool preserve_argv0;
 
     error_init(argv[0]);
     module_call_init(MODULE_INIT_TRACE);
@@ -653,6 +654,9 @@ int main(int argc, char **argv, char **envp)
 
     init_qemu_uname_release();
 
+    /*
+     * Manage binfmt-misc open-binary flag
+     */
     execfd = qemu_getauxval(AT_EXECFD);
     if (execfd == 0) {
         execfd = open(exec_path, O_RDONLY);
@@ -662,6 +666,24 @@ int main(int argc, char **argv, char **envp)
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
@@ -766,7 +788,7 @@ int main(int argc, char **argv, char **envp)
      * argv[0] pointer with the given one.
      */
     i = 0;
-    if (argv0 != NULL) {
+    if (argv0 != NULL && argv0[0] != 0) {
         target_argv[i++] = strdup(argv0);
     }
     for (; i < target_argc; i++) {
diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh
index b5a16742a149..7c9a4609c232 100755
--- a/scripts/qemu-binfmt-conf.sh
+++ b/scripts/qemu-binfmt-conf.sh
@@ -170,25 +170,27 @@ usage() {
 Usage: qemu-binfmt-conf.sh [--qemu-path PATH][--debian][--systemd CPU]
                            [--help][--credential yes|no][--exportdir PATH]
                            [--persistent yes|no][--qemu-suffix SUFFIX]
+                           [--preserve-arg0 yes|no]
 
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
+       --preserve-arg0  preserve arg[0]
 
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
+options=$(getopt -o ds:Q:S:e:hc:p:0: -l debian,systemd:,qemu-path:,qemu-suffix:,exportdir:,help,credential:,persistent:,preserve-arg0: -- "$@")
 eval set -- "$options"
 
 while true ; do
@@ -380,6 +386,10 @@ while true ; do
         shift
         PERSISTENT="$1"
         ;;
+    -0|--preserve-arg0)
+        shift
+        PRESERVE_ARG0="$1"
+        ;;
     *)
         break
         ;;
-- 
2.21.0


