Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A672C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 19:20:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 262BC215A4
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 19:20:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 262BC215A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ehu.eus
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBNwp-0006iE-9R
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 15:20:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49217)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <unai.martinezcorral@ehu.eus>) id 1jBNvU-0005BS-Pe
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 15:18:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <unai.martinezcorral@ehu.eus>) id 1jBNvT-00073v-8l
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 15:18:56 -0400
Received: from smtp.lg.ehu.es ([158.227.0.66]:55052 helo=smtp.ehu.eus)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <unai.martinezcorral@ehu.eus>)
 id 1jBNvS-000737-T8
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 15:18:55 -0400
Received: from imsva2.lgp.ehu.es (imsva2.lgp.ehu.es [10.0.3.246])
 by postfix.smtp2.imsva2 (Postfix) with ESMTPS id 55D086311;
 Mon,  9 Mar 2020 20:18:53 +0100 (CET)
Received: from imsva2.lgp.ehu.es (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0BF855A04F;
 Mon,  9 Mar 2020 20:18:53 +0100 (CET)
Received: from imsva2.lgp.ehu.es (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 00A895A045;
 Mon,  9 Mar 2020 20:18:53 +0100 (CET)
Received: from smtp.ehu.eus (unknown [10.0.100.76])
 by imsva2.lgp.ehu.es (Postfix) with ESMTPS;
 Mon,  9 Mar 2020 20:18:52 +0100 (CET)
Received: from 669c1c222ef4 (static.187.0.0.81.ibercom.com [81.0.0.187])
 by smtp2 (Postfix) with ESMTPSA id B1C426311;
 Mon,  9 Mar 2020 20:18:52 +0100 (CET)
Date: Mon, 9 Mar 2020 19:18:46 +0000
From: Unai Martinez-Corral <unai.martinezcorral@ehu.eus>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 01/10] qemu-binfmt-conf.sh: enforce style consistency
Message-ID: <20200309191846.GA65@669c1c222ef4>
References: <20200309191200.GA60@669c1c222ef4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200309191200.GA60@669c1c222ef4>
X-Greylist: ACL 191 matched, not delayed by milter-greylist-4.6.2 (smtp2
 [10.0.100.76]); Mon, 09 Mar 2020 20:18:52 +0100 (CET)
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSVA-9.1.0.1631-8.5.0.1020-25280.002
X-TM-AS-Result: No-1.035-7.0-31-10
X-imss-scan-details: No-1.035-7.0-31-10
X-TMASE-Version: IMSVA-9.1.0.1631-8.5.1020-25280.002
X-TMASE-Result: 10-1.034500-10.000000
X-TMASE-MatchedRID: lk/a9VXHoMTeG4FwcWqAS3/HTU/OBaTGnVQTrXdqB1rGkE1bT11zTEAc
 6DyoS2rIX5ZfmW1Ym4Xl7N0S/wu39cyB+MYaW/KQpyEWs4H2Rqc4eGohd7gjNn16C7GFcvkyGgr
 CtJAREvEaUt/08cthqw6v12u9K+m3SkJz50w3SpFmPsTq8ee41uwlOGZoQVV0DpCUEeEFm7Byw4
 qzm86Di79p0+NmFAkoX/2hCeJrRE9ccQ8eam5Eff7E6GNqs6ce3QfwsVk0UbsIoUKaF27lxXGwI
 NCE/mk/R8y8KLeYInjdxrPoeKsrpx5pnJtYVfsaQql8Qaf6Y2XimFXTfQZc0l/Ysw/eKl1qnvLf
 ZdcA39zwrovrXlT8pRKGdgr8x4f4BBSv+oarUQsKtuXWKSlXVpNHmClQkxEB+rL5VW+ofZc=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-12:0,22:0,33:0,34:0-0
X-Greylist: Sender IP whitelisted, Sender succeeded SMTP AUTH, not delayed by
 milter-greylist-4.6.2 (postfix.smtp2.imsva2 [10.0.100.76]);
 Mon, 09 Mar 2020 20:18:53 +0100 (CET)
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

Spaces are removed before '; then', for consistency with other scripts
in the project.

Signed-off-by: Unai Martinez-Corral <unai.martinezcorral@ehu.eus>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 scripts/qemu-binfmt-conf.sh | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh
index 9f1580a91c..c728443ba2 100755
--- a/scripts/qemu-binfmt-conf.sh
+++ b/scripts/qemu-binfmt-conf.sh
@@ -215,7 +215,7 @@ EOF
 }
 
 qemu_check_access() {
-    if [ ! -w "$1" ] ; then
+    if [ ! -w "$1" ]; then
         echo "ERROR: cannot write to $1" 1>&2
         exit 1
     fi
@@ -224,12 +224,12 @@ qemu_check_access() {
 qemu_check_bintfmt_misc() {
     # load the binfmt_misc module
     if [ ! -d /proc/sys/fs/binfmt_misc ]; then
-      if ! /sbin/modprobe binfmt_misc ; then
+      if ! /sbin/modprobe binfmt_misc; then
           exit 1
       fi
     fi
     if [ ! -f /proc/sys/fs/binfmt_misc/register ]; then
-      if ! mount binfmt_misc -t binfmt_misc /proc/sys/fs/binfmt_misc ; then
+      if ! mount binfmt_misc -t binfmt_misc /proc/sys/fs/binfmt_misc; then
           exit 1
       fi
     fi
@@ -242,16 +242,16 @@ installed_dpkg() {
 }
 
 qemu_check_debian() {
-    if [ ! -e /etc/debian_version ] ; then
+    if [ ! -e /etc/debian_version ]; then
         echo "WARNING: your system is not a Debian based distro" 1>&2
-    elif ! installed_dpkg binfmt-support ; then
+    elif ! installed_dpkg binfmt-support; then
         echo "WARNING: package binfmt-support is needed" 1>&2
     fi
     qemu_check_access "$EXPORTDIR"
 }
 
 qemu_check_systemd() {
-    if ! systemctl -q is-enabled systemd-binfmt.service ; then
+    if ! systemctl -q is-enabled systemd-binfmt.service; then
         echo "WARNING: systemd-binfmt.service is missing or disabled" 1>&2
     fi
     qemu_check_access "$EXPORTDIR"
@@ -259,10 +259,10 @@ qemu_check_systemd() {
 
 qemu_generate_register() {
     flags=""
-    if [ "$CREDENTIAL" = "yes" ] ; then
+    if [ "$CREDENTIAL" = "yes" ]; then
         flags="OC"
     fi
-    if [ "$PERSISTENT" = "yes" ] ; then
+    if [ "$PERSISTENT" = "yes" ]; then
         flags="${flags}F"
     fi
 
@@ -295,23 +295,23 @@ qemu_set_binfmts() {
 
     # register the interpreter for each cpu except for the native one
 
-    for cpu in ${qemu_target_list} ; do
+    for cpu in ${qemu_target_list}; do
         magic=$(eval echo \$${cpu}_magic)
         mask=$(eval echo \$${cpu}_mask)
         family=$(eval echo \$${cpu}_family)
 
-        if [ "$magic" = "" ] || [ "$mask" = "" ] || [ "$family" = "" ] ; then
+        if [ "$magic" = "" ] || [ "$mask" = "" ] || [ "$family" = "" ]; then
             echo "INTERNAL ERROR: unknown cpu $cpu" 1>&2
             continue
         fi
 
         qemu="$QEMU_PATH/qemu-$cpu"
-        if [ "$cpu" = "i486" ] ; then
+        if [ "$cpu" = "i486" ]; then
             qemu="$QEMU_PATH/qemu-i386"
         fi
 
         qemu="$qemu$QEMU_SUFFIX"
-        if [ "$host_family" != "$family" ] ; then
+        if [ "$host_family" != "$family" ]; then
             $BINFMT_SET
         fi
     done
@@ -331,7 +331,7 @@ QEMU_SUFFIX=""
 options=$(getopt -o ds:Q:S:e:hc:p: -l debian,systemd:,qemu-path:,qemu-suffix:,exportdir:,help,credential:,persistent: -- "$@")
 eval set -- "$options"
 
-while true ; do
+while true; do
     case "$1" in
     -d|--debian)
         CHECK=qemu_check_debian
@@ -344,14 +344,14 @@ while true ; do
         EXPORTDIR=${EXPORTDIR:-$SYSTEMDDIR}
         shift
         # check given cpu is in the supported CPU list
-        if [ "$1" != "ALL" ] ; then
-            for cpu in ${qemu_target_list} ; do
-                if [ "$cpu" = "$1" ] ; then
+        if [ "$1" != "ALL" ]; then
+            for cpu in ${qemu_target_list}; do
+                if [ "$cpu" = "$1" ]; then
                     break
                 fi
             done
 
-            if [ "$cpu" = "$1" ] ; then
+            if [ "$cpu" = "$1" ]; then
                 qemu_target_list="$1"
             else
                 echo "ERROR: unknown CPU \"$1\"" 1>&2
-- 
2.25.1



