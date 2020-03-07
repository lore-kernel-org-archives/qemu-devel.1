Return-Path: <SRS0=oVW3=4Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E631C10F00
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2020 17:29:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED25A20674
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2020 17:29:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED25A20674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ehu.eus
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAdG1-0004Xh-5N
	for qemu-devel@archiver.kernel.org; Sat, 07 Mar 2020 12:29:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52885)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <unai.martinezcorral@ehu.eus>) id 1jAdEn-0003MH-TZ
 for qemu-devel@nongnu.org; Sat, 07 Mar 2020 12:27:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <unai.martinezcorral@ehu.eus>) id 1jAdEm-0000GU-8E
 for qemu-devel@nongnu.org; Sat, 07 Mar 2020 12:27:45 -0500
Received: from smtp.lg.ehu.es ([158.227.0.66]:55658 helo=smtp.ehu.eus)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <unai.martinezcorral@ehu.eus>)
 id 1jAdEl-0008UY-T1
 for qemu-devel@nongnu.org; Sat, 07 Mar 2020 12:27:44 -0500
Received: from imsva1.lgp.ehu.es (imsva1.lgp.ehu.es [10.0.3.245])
 by postfix.smtp1.imsva1 (Postfix) with ESMTPS id BA07B3760E;
 Sat,  7 Mar 2020 18:27:41 +0100 (CET)
Received: from imsva1.lgp.ehu.es (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8213611004A;
 Sat,  7 Mar 2020 18:27:41 +0100 (CET)
Received: from imsva1.lgp.ehu.es (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 75EAB110045;
 Sat,  7 Mar 2020 18:27:41 +0100 (CET)
Received: from smtp.ehu.eus (unknown [10.0.100.73])
 by imsva1.lgp.ehu.es (Postfix) with ESMTPS;
 Sat,  7 Mar 2020 18:27:41 +0100 (CET)
Received: from afee69d503a7 (unknown [81.0.0.187])
 by smtp1 (Postfix) with ESMTPSA id 314103760E;
 Sat,  7 Mar 2020 18:27:41 +0100 (CET)
Date: Sat, 7 Mar 2020 17:27:40 +0000
From: umarcor <unai.martinezcorral@ehu.eus>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 2/9] qemu-binfmt-conf.sh: make opts -p and -c boolean
Message-ID: <20200307172740.GB9@afee69d503a7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Greylist: ACL 184 matched, not delayed by milter-greylist-4.6.2 (smtp1
 [10.0.100.73]); Sat, 07 Mar 2020 18:27:41 +0100 (CET)
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSVA-9.1.0.1631-8.5.0.1020-25276.001
X-TM-AS-Result: No--0.283-7.0-31-10
X-imss-scan-details: No--0.283-7.0-31-10
X-TMASE-Version: IMSVA-9.1.0.1631-8.5.1020-25276.001
X-TMASE-Result: 10--0.282600-10.000000
X-TMASE-MatchedRID: U43YD7H1Lvw8mRT0SYY6fn4neC0h7SADM0wEwxpnA/68YDH/UBNnm9IS
 YzBUt2RaPNUcTj3KnwYYtU40WMXvIYG80L1SbJgHPwKTD1v8YV5MkOX0UoduuUp12IXZajx5isV
 L6tesfykTxXC00El2lhakbZdr8IRbe4rShPdcdTacVWc2a+/ju3MewI65KqfWA1njkhEhkqD1Ze
 b7KEkrKJ++W6npokaOY8uDPjNciyEZhPwmib0kjeLzNWBegCW2U/185JqDvmbaqT6lqWS9QsRB0
 bsfrpPI34T9cYMsdwwOJox114k7L4utkPfYpmAOoHq+Hs/zrWEhua9uUgMKZ1axhI27yKUYa37u
 +lQw2jslgZqICCEoWYmUFS1V970DoMDl4vNmLhBQ8Ijyfb7R1NaR6eevSLMI3+Sfk+YbswR/XNh
 OvrwWA7UAzM040TIQ
X-TMASE-SNAP-Result: 1.821001.0001-0-1-12:0,22:0,33:0,34:0-0
X-Greylist: Sender IP whitelisted, Sender succeeded SMTP AUTH, not delayed by
 milter-greylist-4.6.2 (postfix.smtp1.imsva1 [10.0.100.73]);
 Sat, 07 Mar 2020 18:27:41 +0100 (CET)
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

This patch breaks backward compatibility.

Both '--persistent' and '--credential' default to 'no'. Hence, '-p no'
or '-c no' are redundant. Overall, accepting an argument might be
misleading because options are, indeed, boolean. This patch makes both
options boolean in getopt, so if any of them is provided the corresponding
variable is set to true.

Signed-off-by: Unai Martinez-Corral <unai.martinezcorral@ehu.eus>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 scripts/qemu-binfmt-conf.sh | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh
index 672ce716b6..75eb19c3bf 100755
--- a/scripts/qemu-binfmt-conf.sh
+++ b/scripts/qemu-binfmt-conf.sh
@@ -172,8 +172,8 @@ qemu_get_family() {
 usage() {
     cat <<EOF
 Usage: qemu-binfmt-conf.sh [--qemu-path PATH][--debian][--systemd CPU]
-                           [--help][--credential yes|no][--exportdir PATH]
-                           [--persistent yes|no][--qemu-suffix SUFFIX]
+                           [--help][--credential][--exportdir PATH]
+                           [--persistent][--qemu-suffix SUFFIX]
 
        Configure binfmt_misc to use qemu interpreter
 
@@ -188,9 +188,9 @@ Usage: qemu-binfmt-conf.sh [--qemu-path PATH][--debian][--systemd CPU]
                       file for all known cpus
        --exportdir:   define where to write configuration files
                       (default: $SYSTEMDDIR or $DEBIANDIR)
-       --credential:  if yes, credential and security tokens are
+       --credential:  if present, credential and security tokens are
                       calculated according to the binary to interpret
-       --persistent:  if yes, the interpreter is loaded when binfmt is
+       --persistent:  if present, the interpreter is loaded when binfmt is
                       configured and remains in memory. All future uses
                       are cloned from the open file.
 
@@ -328,7 +328,7 @@ CREDENTIAL=no
 PERSISTENT=no
 QEMU_SUFFIX=""
 
-options=$(getopt -o ds:Q:S:e:hc:p: -l debian,systemd:,qemu-path:,qemu-suffix:,exportdir:,help,credential:,persistent: -- "$@")
+options=$(getopt -o ds:Q:S:e:hcp -l debian,systemd:,qemu-path:,qemu-suffix:,exportdir:,help,credential,persistent -- "$@")
 eval set -- "$options"
 
 while true ; do
@@ -377,12 +377,10 @@ while true ; do
         exit 1
         ;;
     -c|--credential)
-        shift
-        CREDENTIAL="$1"
+        CREDENTIAL="yes"
         ;;
     -p|--persistent)
-        shift
-        PERSISTENT="$1"
+        PERSISTENT="yes"
         ;;
     *)
         break
-- 
2.25.1



