Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A86C10F25
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 19:22:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79C9F208C3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 19:22:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79C9F208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ehu.eus
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBNyT-000282-MI
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 15:22:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49592)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <unai.martinezcorral@ehu.eus>) id 1jBNwv-0007QZ-Sk
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 15:20:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <unai.martinezcorral@ehu.eus>) id 1jBNwu-0008En-NR
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 15:20:25 -0400
Received: from smtp.lg.ehu.es ([158.227.0.66]:2743 helo=smtp.ehu.eus)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <unai.martinezcorral@ehu.eus>)
 id 1jBNwu-0008C8-BL
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 15:20:24 -0400
Received: from imsva2.lgp.ehu.es (imsva2.lgp.ehu.es [10.0.3.246])
 by postfix.smtp2.imsva2 (Postfix) with ESMTPS id 213616311;
 Mon,  9 Mar 2020 20:20:23 +0100 (CET)
Received: from imsva2.lgp.ehu.es (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EED655A04F;
 Mon,  9 Mar 2020 20:20:22 +0100 (CET)
Received: from imsva2.lgp.ehu.es (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E35975A045;
 Mon,  9 Mar 2020 20:20:22 +0100 (CET)
Received: from smtp.ehu.eus (unknown [10.0.100.76])
 by imsva2.lgp.ehu.es (Postfix) with ESMTPS;
 Mon,  9 Mar 2020 20:20:22 +0100 (CET)
Received: from 669c1c222ef4 (static.187.0.0.81.ibercom.com [81.0.0.187])
 by smtp2 (Postfix) with ESMTPSA id A1CD96311;
 Mon,  9 Mar 2020 20:20:22 +0100 (CET)
Date: Mon, 9 Mar 2020 19:20:21 +0000
From: Unai Martinez-Corral <unai.martinezcorral@ehu.eus>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 04/10] qemu-binfmt-conf.sh: add QEMU_CREDENTIAL and
 QEMU_PERSISTENT
Message-ID: <20200309192021.GD65@669c1c222ef4>
References: <20200309191200.GA60@669c1c222ef4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200309191200.GA60@669c1c222ef4>
X-Greylist: ACL 191 matched, not delayed by milter-greylist-4.6.2 (smtp2
 [10.0.100.76]); Mon, 09 Mar 2020 20:20:22 +0100 (CET)
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSVA-9.1.0.1631-8.5.0.1020-25280.002
X-TM-AS-Result: No-1.919-7.0-31-10
X-imss-scan-details: No-1.919-7.0-31-10
X-TMASE-Version: IMSVA-9.1.0.1631-8.5.1020-25280.002
X-TMASE-Result: 10-1.919100-10.000000
X-TMASE-MatchedRID: /rjjNR0fZCoNdWPTMyGlNn41AgV24XnfVFeUPAjsd8bhmYLRM9m2iEhq
 QpzXZe40YNA0HZI8EiGPQi9XuOWoOIG9V0kqQ2uQitvkWeP31kk/GTuOFUz5s2mycYYiBYyZ1AP
 JYMpZ2b45ekiuCWp2reHQaFidrFj3/N0WsxWI4QdDbiUnjRcCmJnaxzJFBx6vrP7fIroeSfN6Ho
 OzBHN0E+LzNWBegCW2OubYLCVnBVEqyYS0oyUVZvame15MIThR+8CwdiPq88eRQ5ABDkG7qjGgT
 lf1BRgl1GRbd+6gQEN33qXzE9EBM7W6kOI3g9aLFqondSz7+RyJKj2R/IENdRuJyuskHg4AzM2F
 BO7i4hJRYW5hfzhEW0CLmZDDvMfd0hli/KDwoy2eqD9WtJkSIw==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-12:0,22:0,33:0,34:0-0
X-Greylist: Sender IP whitelisted, Sender succeeded SMTP AUTH, not delayed by
 milter-greylist-4.6.2 (postfix.smtp2.imsva2 [10.0.100.76]);
 Mon, 09 Mar 2020 20:20:23 +0100 (CET)
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

Allow to set options '--persistent' and/or '--credential' through
environment variables. If not defined, defaults are used ('no').
Anyway, command-line arguments have priority over environment variables.

Signed-off-by: Unai Martinez-Corral <unai.martinezcorral@ehu.eus>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 scripts/qemu-binfmt-conf.sh | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh
index 285ce528d1..0c28db5ca4 100755
--- a/scripts/qemu-binfmt-conf.sh
+++ b/scripts/qemu-binfmt-conf.sh
@@ -190,9 +190,11 @@ Usage: qemu-binfmt-conf.sh [--qemu-path PATH][--debian][--systemd CPU]
                       (default: $SYSTEMDDIR or $DEBIANDIR)
        --credential:  if present, credential and security tokens are
                       calculated according to the binary to interpret
+                      (QEMU_CREDENTIAL=yes)
        --persistent:  if present, the interpreter is loaded when binfmt is
                       configured and remains in memory. All future uses
                       are cloned from the open file.
+                      (QEMU_PERSISTENT=yes)
 
     To import templates with update-binfmts, use :
 
@@ -259,10 +261,10 @@ qemu_check_systemd() {
 
 qemu_generate_register() {
     flags=""
-    if [ "x$CREDENTIAL" = "xyes" ]; then
+    if [ "x$QEMU_CREDENTIAL" = "xyes" ]; then
         flags="OC"
     fi
-    if [ "x$PERSISTENT" = "xyes" ]; then
+    if [ "x$QEMU_PERSISTENT" = "xyes" ]; then
         flags="${flags}F"
     fi
 
@@ -285,7 +287,7 @@ package qemu-$cpu
 interpreter $qemu
 magic $magic
 mask $mask
-credential $CREDENTIAL
+credential $QEMU_CREDENTIAL
 EOF
 }
 
@@ -324,8 +326,10 @@ SYSTEMDDIR="/etc/binfmt.d"
 DEBIANDIR="/usr/share/binfmts"
 
 QEMU_PATH=/usr/local/bin
-CREDENTIAL=no
-PERSISTENT=no
+
+QEMU_PERSISTENT="${QEMU_PERSISTENT:-no}"
+QEMU_CREDENTIAL="${QEMU_CREDENTIAL:-no}"
+
 QEMU_SUFFIX=""
 
 options=$(getopt -o ds:Q:S:e:hcp -l debian,systemd:,qemu-path:,qemu-suffix:,exportdir:,help,credential,persistent -- "$@")
@@ -377,10 +381,10 @@ while true; do
         exit 1
         ;;
     -c|--credential)
-        CREDENTIAL="yes"
+        QEMU_CREDENTIAL="yes"
         ;;
     -p|--persistent)
-        PERSISTENT="yes"
+        QEMU_PERSISTENT="yes"
         ;;
     *)
         break
-- 
2.25.1



