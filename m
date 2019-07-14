Return-Path: <SRS0=Qpa9=VL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5793C73C66
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jul 2019 13:41:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D54920820
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jul 2019 13:41:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D54920820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmekN-0002gE-77
	for qemu-devel@archiver.kernel.org; Sun, 14 Jul 2019 09:40:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38684)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hmekC-00026q-Iq
 for qemu-devel@nongnu.org; Sun, 14 Jul 2019 09:40:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hmekB-0004Ox-7O
 for qemu-devel@nongnu.org; Sun, 14 Jul 2019 09:40:48 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:33571)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hmekA-0004O5-UY
 for qemu-devel@nongnu.org; Sun, 14 Jul 2019 09:40:47 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MCsDe-1hdp3O1MaO-008uK2; Sun, 14 Jul 2019 15:40:38 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Sun, 14 Jul 2019 15:40:28 +0200
Message-Id: <20190714134028.315-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190714134028.315-1-laurent@vivier.eu>
References: <20190714134028.315-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:g6hC2kndF+xEY3SJyfv+j6kUeTH+TixdiX1460rF3FSIt5uqgM7
 OCLI/LTq3CVucbOog6Vc5oanr7O7ewOZ7FTeCgmMxRVnm87YMq82HxGdj+AML/OFyQI12eV
 kk+ubP2zCrXKD5IMM+2QLkc9UkSjKPZSXvUM5NpF2E6L9Y70k5p+2Cd34T+6xPYDvMy1RZb
 RNlyMY1bBe9V8tG+o/Ucg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zaATLEmj+DI=:EY3Ir1mR3OlKnXRuIt4Lao
 t9vufI4fZ8V0Dmw6WZrFakfkEKeZJQ4LCcp8qoRxuz0XEwLbbn4kBJ3rwVscSgRR/3VVoBZV3
 DXgOJn84vAQ1b0Rxz9pp5Obd8fJ0qJrSLi1m/1Y0Fb4YGNVvmBRxdllZVk4NtRby9eBAAc0nW
 Msacg54LVzu60r+1m0ZWM5GjmYNr4Don+hr6ylBA1Bn+KT8G5NdyXlCo66sgMt0iNIMvXZoEK
 9KcptwODtRi0D02KACjxBKXiOOxNbZrSirvSIaGR+quwMOVA4gswTXEzv92WxUNrqIR98y/bE
 pgXnpBZXzVIAOqa/qOUSx1x3WioH5jYju5js9t5tzTmaWbAIAsIxMgHvnk1BUNmnD6UdZoiDg
 CimxJRKdwznLxpUJuqV7zdWL186syJ2RdlkjINUdhEYR8nPA+lodD5hHlyYzMdBwduWoWTixE
 Wmt8GhvUxAF48U2wAstLXyrLXjy7NKSOV5qRcDV8npxyuaykzPtdDBVhGlSReszuGpm8bQCzY
 Pv39KyMBxyHxDlXnfrz6WTY00+XNWv6srumOEX2GfTiDkhjBRfUr3GsN7ViYdWeATgeZJpoAA
 ld9/kzzLmfcXk6EPqaQeeipAiQtnWFZL4Z8lab6D7QdL1OfUVywXCPa8c1N0fTECFlFHBvmdk
 iyq/xEZ+9J2xdODYxESyI9VdfZ0vf4gjb86JNoQ5clCw9sG9JbxR4f0go1BzdBnmVwlQhASkH
 MSGUfBp6fMkeuEF8JH7dX2+DGQj+RPyaOk2Plg==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.24
Subject: [Qemu-devel] [PATCH 2/2] linux-user: manage binfmt-misc
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

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/main.c           | 18 ++++++++++++++-
 scripts/qemu-binfmt-conf.sh | 44 +++++++++++++++++++++++--------------
 2 files changed, 44 insertions(+), 18 deletions(-)

diff --git a/linux-user/main.c b/linux-user/main.c
index ef8e8cb10eba..eeaba4a7b914 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -647,6 +647,9 @@ int main(int argc, char **argv, char **envp)
 
     init_qemu_uname_release();
 
+    /*
+     * Manage binfmt-misc open-binary flag
+     */
     execfd = qemu_getauxval(AT_EXECFD);
     if (execfd == 0) {
         execfd = open(exec_path, O_RDONLY);
@@ -656,6 +659,19 @@ int main(int argc, char **argv, char **envp)
         }
     }
 
+    /*
+     * Manage binfmt-misc preserve-arg[0] flag
+     *    argv[optind]     full path to the binary
+     *    argv[optind + 1] original argv[0]
+     */
+    if (optind + 1 < argc && argv0 != NULL && argv0[0] == 0) {
+        /*
+         * argv0 with an empty string will set argv[optind + 1]
+         * as target_argv[0]
+         */
+        optind++;
+    }
+
     if (cpu_model == NULL) {
         cpu_model = cpu_get_model(get_elf_eflags(execfd));
     }
@@ -760,7 +776,7 @@ int main(int argc, char **argv, char **envp)
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


