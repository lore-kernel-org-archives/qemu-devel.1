Return-Path: <SRS0=oVW3=4Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D56E8C10F00
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2020 17:33:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A90B02073D
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2020 17:33:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A90B02073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ehu.eus
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAdK1-0007UZ-Rn
	for qemu-devel@archiver.kernel.org; Sat, 07 Mar 2020 12:33:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53649)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <unai.martinezcorral@ehu.eus>) id 1jAdJ8-000700-JP
 for qemu-devel@nongnu.org; Sat, 07 Mar 2020 12:32:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <unai.martinezcorral@ehu.eus>) id 1jAdJ6-0001C3-Rj
 for qemu-devel@nongnu.org; Sat, 07 Mar 2020 12:32:13 -0500
Received: from smtp.lg.ehu.es ([158.227.0.66]:32238 helo=smtp.ehu.eus)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <unai.martinezcorral@ehu.eus>)
 id 1jAdJ6-0000xx-GF
 for qemu-devel@nongnu.org; Sat, 07 Mar 2020 12:32:12 -0500
Received: from imsva1.lgp.ehu.es (imsva1.lgp.ehu.es [10.0.3.245])
 by postfix.smtp1.imsva1 (Postfix) with ESMTPS id 7C74821BB8;
 Sat,  7 Mar 2020 18:32:10 +0100 (CET)
Received: from imsva1.lgp.ehu.es (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2C60E11004A;
 Sat,  7 Mar 2020 18:32:10 +0100 (CET)
Received: from imsva1.lgp.ehu.es (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 20349110045;
 Sat,  7 Mar 2020 18:32:10 +0100 (CET)
Received: from smtp.ehu.eus (unknown [10.0.100.73])
 by imsva1.lgp.ehu.es (Postfix) with ESMTPS;
 Sat,  7 Mar 2020 18:32:10 +0100 (CET)
Received: from afee69d503a7 (unknown [81.0.0.187])
 by smtp1 (Postfix) with ESMTPSA id CDF0421BB8;
 Sat,  7 Mar 2020 18:32:09 +0100 (CET)
Date: Sat, 7 Mar 2020 17:32:08 +0000
From: Unai Martinez-Corral <unai.martinezcorral@ehu.eus>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 4/9] qemu-binfmt-conf.sh: use the same presentation format
 as for qemu-*
Message-ID: <20200307173208.GD9@afee69d503a7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Greylist: ACL 184 matched, not delayed by milter-greylist-4.6.2 (smtp1
 [10.0.100.73]); Sat, 07 Mar 2020 18:32:10 +0100 (CET)
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSVA-9.1.0.1631-8.5.0.1020-25276.001
X-TM-AS-Result: No--1.297-7.0-31-10
X-imss-scan-details: No--1.297-7.0-31-10
X-TMASE-Version: IMSVA-9.1.0.1631-8.5.1020-25276.001
X-TMASE-Result: 10--1.297000-10.000000
X-TMASE-MatchedRID: T3hsd5K8wIA8mRT0SYY6fj8Ckw9b/GFeTJDl9FKHbrlKddiF2Wo8ecRx
 XgwTt4PF3EJA0FSQihWISVF+XOaYFHFnJN0+hJldcI7vRACwF0LKIqAq0jIHigaYevV4zG3ZB5Z
 kNX8n24FEpOrteNkNyzDw0BFh4qwrXPQvn/00CLFM0MpnLn+G9Gr+GymfohKdVI7KaIl9NheBev
 ioG5gI930tCKdnhB58dQgf7bli9LzT6JDACkKf2wP5zT0d393cymsk/wUE4hpG3z85bKXlcN1JW
 yEnC+KUVWGXHrwx1nHvDMd9ZEuNquvd8pBEKhMU+8VCAXGty6Fu/iwIil2Mi2bnSFR79tDE13hs
 igVleNSHG0SUTQyRe1i7FP9SiiauF1qISuK4qVqjyqnhL+I3r7GxzFzvrCh6QwymtxuJ6y0=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-12:0,22:0,33:0,34:0-0
X-Greylist: Sender IP whitelisted, Sender succeeded SMTP AUTH, not delayed by
 milter-greylist-4.6.2 (postfix.smtp1.imsva1 [10.0.100.73]);
 Sat, 07 Mar 2020 18:32:10 +0100 (CET)
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
---
 scripts/qemu-binfmt-conf.sh | 63 +++++++++++++++++++------------------
 1 file changed, 32 insertions(+), 31 deletions(-)

diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh
index 347cddf698..251a78a2ce 100755
--- a/scripts/qemu-binfmt-conf.sh
+++ b/scripts/qemu-binfmt-conf.sh
@@ -171,47 +171,48 @@ qemu_get_family() {
 
 usage() {
     cat <<EOF
-Usage: qemu-binfmt-conf.sh [--qemu-path PATH][--debian][--systemd CPU]
-                           [--help][--credential][--exportdir PATH]
-                           [--persistent][--qemu-suffix SUFFIX]
+Usage: qemu-binfmt-conf.sh [options]
 
-       Configure binfmt_misc to use qemu interpreter
+Configure binfmt_misc to use qemu interpreter
 
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
-       --credential:  if present, credential and security tokens are
-                      calculated according to the binary to interpret
-                      (QEMU_CREDENTIAL=yes)
-       --persistent:  if present, the interpreter is loaded when binfmt is
-                      configured and remains in memory. All future uses
-                      are cloned from the open file.
-                      (QEMU_PERSISTENT=yes)
+Options and associated environment variables:
 
-    To import templates with update-binfmts, use :
+Argument             Env-variable     Description
+-h|--help                             display this usage
+-Q|--qemu-path PATH  QEMU_PATH        set path to qemu interpreter
+-F|--qemu-suffix SUFFIX               add a suffix to the default interpreter name
+-p|--persistent      QEMU_PERSISTENT  (yes) load the interpreter and keep it in memory; all future
+                                      uses are cloned from the open file.
+-c|--credential      QEMU_CREDENTIAL  (yes) credential and security tokens are calculated according
+                                      to the binary to interpret
+-e|--exportdir PATH                   define where to write configuration files
+                                      (default: $SYSTEMDDIR or $DEBIANDIR)
+-s|--systemd CPU                      don't write into /proc, generate file for
+                                      systemd-binfmt.service for the given CPU; if CPU is "ALL",
+                                      generate a file for all known cpus.
+-d|--debian                           don't write into /proc, generate update-binfmts templates
 
-        sudo update-binfmts --importdir ${EXPORTDIR:-$DEBIANDIR} --import qemu-CPU
+Defaults:
+QEMU_PATH=$QEMU_PATH
+QEMU_PERSISTENT=$QEMU_PERSISTENT
+QEMU_CREDENTIAL=$QEMU_CREDENTIAL
 
-    To remove interpreter, use :
+To import templates with update-binfmts, use :
 
-        sudo update-binfmts --package qemu-CPU --remove qemu-CPU $QEMU_PATH
+    sudo update-binfmts --importdir ${EXPORTDIR:-$DEBIANDIR} --import qemu-CPU
 
-    With systemd, binfmt files are loaded by systemd-binfmt.service
+To remove interpreter, use :
 
-    The environment variable HOST_ARCH allows to override 'uname' to generate
-    configuration files for a different architecture than the current one.
+    sudo update-binfmts --package qemu-CPU --remove qemu-CPU $QEMU_PATH
 
-    where CPU is one of:
+With systemd, binfmt files are loaded by systemd-binfmt.service
 
-        $qemu_target_list
+The environment variable HOST_ARCH allows to override 'uname' to generate configuration files for a
+different architecture than the current one.
+
+where CPU is one of:
+
+    $qemu_target_list
 
 EOF
 }
-- 
2.25.1

Reply-To: 

