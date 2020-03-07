Return-Path: <SRS0=oVW3=4Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96255C10F00
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2020 17:46:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 717682064A
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2020 17:46:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 717682064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ehu.eus
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAdWd-0008Kd-MX
	for qemu-devel@archiver.kernel.org; Sat, 07 Mar 2020 12:46:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55215)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <unai.martinezcorral@ehu.eus>) id 1jAdV4-0006dz-Bd
 for qemu-devel@nongnu.org; Sat, 07 Mar 2020 12:44:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <unai.martinezcorral@ehu.eus>) id 1jAdV2-0000YY-Nt
 for qemu-devel@nongnu.org; Sat, 07 Mar 2020 12:44:33 -0500
Received: from smtp.lg.ehu.es ([158.227.0.66]:5502 helo=smtp.ehu.eus)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <unai.martinezcorral@ehu.eus>)
 id 1jAdV2-0000XE-Bg
 for qemu-devel@nongnu.org; Sat, 07 Mar 2020 12:44:32 -0500
Received: from imsva1.lgp.ehu.es (imsva1.lgp.ehu.es [10.0.3.245])
 by postfix.smtp1.imsva1 (Postfix) with ESMTPS id DF9A13825B;
 Sat,  7 Mar 2020 18:44:30 +0100 (CET)
Received: from imsva1.lgp.ehu.es (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A60E511004A;
 Sat,  7 Mar 2020 18:44:30 +0100 (CET)
Received: from imsva1.lgp.ehu.es (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9A9D8110045;
 Sat,  7 Mar 2020 18:44:30 +0100 (CET)
Received: from smtp.ehu.eus (unknown [10.0.100.73])
 by imsva1.lgp.ehu.es (Postfix) with ESMTPS;
 Sat,  7 Mar 2020 18:44:30 +0100 (CET)
Received: from afee69d503a7 (unknown [81.0.0.187])
 by smtp1 (Postfix) with ESMTPSA id 54FEF3825B;
 Sat,  7 Mar 2020 18:44:30 +0100 (CET)
Date: Sat, 7 Mar 2020 17:44:29 +0000
From: Unai Martinez-Corral <unai.martinezcorral@ehu.eus>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 9/9] qemu-binfmt-conf.sh: add --test
Message-ID: <20200307174429.GJ9@afee69d503a7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Greylist: ACL 184 matched, not delayed by milter-greylist-4.6.2 (smtp1
 [10.0.100.73]); Sat, 07 Mar 2020 18:44:30 +0100 (CET)
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSVA-9.1.0.1631-8.5.0.1020-25276.001
X-TM-AS-Result: No--2.997-7.0-31-10
X-imss-scan-details: No--2.997-7.0-31-10
X-TMASE-Version: IMSVA-9.1.0.1631-8.5.1020-25276.001
X-TMASE-Result: 10--2.997200-10.000000
X-TMASE-MatchedRID: 4y9/ylYYqyY8mRT0SYY6fguB7zdAMUjAnVQTrXdqB1rGkE1bT11zTEAc
 6DyoS2rIKnoLoDc7CX1BeUNELByi+f217Ks8q26/amOGWbsSIFenU+NxqV3DDUYza41dGqxSCn+
 QUnj5ZKiuQih3+HqEP/uCK8CpbZE5P0RMDgPThrXagiRcLo6XQOHCwRwMNQUW4ZmC0TPZtojHK3
 DBP8Kop+0+/68r4mWd+5zC6D5RoqsO9fZKTjt+z5XIRfiL5JZTAp+UH372RZUjNNPmQPqs4J4CI
 KY/Hg3AyJ1gFgOMhOkZsIdvLTjL2AAYNQKSVsYiwrbXMGDYqV8HTT+SR4FPABjtt0x+lU92LFiG
 Ovf3yPPkPGGaxXXHxV54s+vj71IOm6C1NINufeRSR6Juxne78syT8f6LnvnzUJR1Jh/1hk5coWw
 5/2ERXzQw5IQ87EEy6fuXT+JI9EvhYXsqMOmRhhqQohjffj3k
X-TMASE-SNAP-Result: 1.821001.0001-0-1-12:0,22:0,33:0,34:0-0
X-Greylist: Sender IP whitelisted, Sender succeeded SMTP AUTH, not delayed by
 milter-greylist-4.6.2 (postfix.smtp1.imsva1 [10.0.100.73]);
 Sat, 07 Mar 2020 18:44:30 +0100 (CET)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 158.227.0.66
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
Cc: riku.voipio@iki.fi, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Unai Martinez-Corral <unai.martinezcorral@ehu.eus>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 scripts/qemu-binfmt-conf.sh | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh
index 9685456747..4635871e6d 100755
--- a/scripts/qemu-binfmt-conf.sh
+++ b/scripts/qemu-binfmt-conf.sh
@@ -201,8 +201,7 @@ Options and associated environment variables:
 
 Argument             Env-variable     Description
 TARGETS              QEMU_TARGETS     A single arch name or a list of them (see all names below);
-                                      if empty, configure/clear all known targets;
-                                      if 'NONE', no interpreter is configured.
+                                      if empty, configure/clear all known targets.
 -h|--help                             display this usage
 -Q|--path PATH       QEMU_PATH        set path to qemu interpreter(s)
 -F|--suffix SUFFIX   QEMU_SUFFIX      add a suffix to the default interpreter name
@@ -212,6 +211,8 @@ TARGETS              QEMU_TARGETS     A single arch name or a list of them (see
                                       to the binary to interpret
 -r|--clear           QEMU_CLEAR       (yes) remove registered interpreters for target TARGETS;
                                       then exit.
+-t|--test            QEMU_TEST        (yes) test the setup with the provided arguments, but do not
+                                      configure any of the interpreters.
 -e|--exportdir PATH                   define where to write configuration files
                                       (default: $SYSTEMDDIR or $DEBIANDIR)
 -s|--systemd                          don't write into /proc, generate file(s) for
@@ -225,6 +226,7 @@ QEMU_SUFFIX=$QEMU_SUFFIX
 QEMU_PERSISTENT=$QEMU_PERSISTENT
 QEMU_CREDENTIAL=$QEMU_CREDENTIAL
 QEMU_CLEAR=$QEMU_CLEAR
+QEMU_TEST=$QEMU_TEST
 
 To import templates with update-binfmts, use :
 
@@ -323,9 +325,6 @@ qemu_set_binfmts() {
 
     # reduce the list of target interpreters to those given in the CLI
     targets=${@:-$QEMU_TARGET}
-    if [ "x$targets" = "xNONE" ] ; then
-      return
-    fi
     qemu_check_target_list $targets
 
     # register the interpreter for each target except for the native one
@@ -377,12 +376,16 @@ QEMU_SUFFIX="${QEMU_SUFFIX:-}"
 QEMU_PERSISTENT="${QEMU_PERSISTENT:-no}"
 QEMU_CREDENTIAL="${QEMU_CREDENTIAL:-no}"
 QEMU_CLEAR="${QEMU_CLEAR:-no}"
+QEMU_TEST="${QEMU_TEST:-no}"
 
-options=$(getopt -o rdsQ:S:e:hcp -l clear,debian,systemd,path:,suffix:,exportdir:,help,credential,persistent -- "$@")
+options=$(getopt -o trdsQ:S:e:hcp -l test,clear,debian,systemd,path:,suffix:,exportdir:,help,credential,persistent -- "$@")
 eval set -- "$options"
 
 while true ; do
     case "$1" in
+    -t|--test)
+        QEMU_TEST="yes"
+        ;;
     -r|--clear)
         QEMU_CLEAR="yes"
         ;;
@@ -431,6 +434,11 @@ shift
 
 $CHECK
 
+if [ "x$QEMU_TEST" = "xyes" ] ; then
+    BINFMT_SET=:
+    BINFMT_CLEAR=:
+fi
+
 if [ "x$QEMU_CLEAR" = "xyes" ] ; then
     qemu_check_target_list "$@"
     for t in $checked_target_list ; do
-- 
2.25.1



