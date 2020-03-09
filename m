Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C77C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 18:38:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DCE320873
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 18:38:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DCE320873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ehu.eus
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBNI9-0003zl-AM
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 14:38:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41912)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <unai.martinezcorral@ehu.eus>) id 1jBNGu-0002iL-Ie
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 14:37:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <unai.martinezcorral@ehu.eus>) id 1jBNGt-0003RX-BR
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 14:37:00 -0400
Received: from smtp.lg.ehu.es ([158.227.0.66]:59873 helo=smtp.ehu.eus)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <unai.martinezcorral@ehu.eus>)
 id 1jBNGs-0003Qv-VD
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 14:36:59 -0400
Received: from imsva2.lgp.ehu.es (imsva2.lgp.ehu.es [10.0.3.246])
 by postfix.smtp2.imsva2 (Postfix) with ESMTPS id 8C98C61E1;
 Mon,  9 Mar 2020 19:36:57 +0100 (CET)
Received: from imsva2.lgp.ehu.es (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 599075A04F;
 Mon,  9 Mar 2020 19:36:57 +0100 (CET)
Received: from imsva2.lgp.ehu.es (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4E4765A045;
 Mon,  9 Mar 2020 19:36:57 +0100 (CET)
Received: from smtp.ehu.eus (unknown [10.0.100.76])
 by imsva2.lgp.ehu.es (Postfix) with ESMTPS;
 Mon,  9 Mar 2020 19:36:57 +0100 (CET)
Received: from 669c1c222ef4 (static.187.0.0.81.ibercom.com [81.0.0.187])
 by smtp2 (Postfix) with ESMTPSA id 0C3B061E1;
 Mon,  9 Mar 2020 19:36:57 +0100 (CET)
Date: Mon, 9 Mar 2020 18:36:51 +0000
From: Unai Martinez-Corral <unai.martinezcorral@ehu.eus>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 1/9] qemu-binfmt-conf.sh: enforce safe style consistency
Message-ID: <20200309183651.GA14@669c1c222ef4>
References: <20200309183521.GA9@669c1c222ef4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200309183521.GA9@669c1c222ef4>
X-Greylist: ACL 191 matched, not delayed by milter-greylist-4.6.2 (smtp2
 [10.0.100.76]); Mon, 09 Mar 2020 19:36:57 +0100 (CET)
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSVA-9.1.0.1631-8.5.0.1020-25280.001
X-TM-AS-Result: No-1.203-7.0-31-10
X-imss-scan-details: No-1.203-7.0-31-10
X-TMASE-Version: IMSVA-9.1.0.1631-8.5.1020-25280.001
X-TMASE-Result: 10-1.202800-10.000000
X-TMASE-MatchedRID: C2Ox2wkr63jeG4FwcWqAS1IWq0PbCp4xsaFafeSZpcbCtB5AXGRY27H9
 y3BGSBuXf+3yqvQrlggtpxclXgLOJWJZXQNDzktSSHCU59h5KrHOoAXTAVKONZ+4ziUPq4Lxgm7
 WCykPm9QLZPDLz2fappsT5uP6xQz0dTtVF1QIQ4RLIfps09VJ24IXoaQH2H4P9G/iyJjj8J/e/8
 mzpz6Tltg9dKgWHMAdkb3r+FsnMU2iexRwf5KEhMzSKGx9g8xhZlQDEANheHGbKItl61J/yX2PY
 bDNMTe9KrauXd3MZDVQ9tfhA5AeJqu3XGY3i0vm8h0Vtd5gEqOYKIZboSNYJW3znmbWciqGRO/I
 D/JEVE6RElks2VoueCPYYEP1kqJR5fiqzvLgTYnU0QfJ7oMD81i7FP9SiiauF1qISuK4qVqjyqn
 hL+I3r3T5gPkpDQEZQwymtxuJ6y0=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-12:0,22:0,33:0,34:0-0
X-Greylist: Sender IP whitelisted, Sender succeeded SMTP AUTH, not delayed by
 milter-greylist-4.6.2 (postfix.smtp2.imsva2 [10.0.100.76]);
 Mon, 09 Mar 2020 19:36:57 +0100 (CET)
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

Spaces are removed before '; then', for consistency.

All the tests are prefixed with 'x', in order to avoid risky comparisons
(i.e. a user deliberately trying to provoke a syntax error).

Signed-off-by: umarcor <unai.martinezcorral@ehu.eus>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 scripts/qemu-binfmt-conf.sh | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh
index 9f1580a91c..98401f4e7c 100755
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
+    if [ "x$CREDENTIAL" = "xyes" ]; then
         flags="OC"
     fi
-    if [ "$PERSISTENT" = "yes" ] ; then
+    if [ "x$PERSISTENT" = "xyes" ]; then
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
+        if [ "x$magic" = "x" ] || [ "x$mask" = "x" ] || [ "x$family" = "x" ]; then
             echo "INTERNAL ERROR: unknown cpu $cpu" 1>&2
             continue
         fi
 
         qemu="$QEMU_PATH/qemu-$cpu"
-        if [ "$cpu" = "i486" ] ; then
+        if [ "x$cpu" = "xi486" ]; then
             qemu="$QEMU_PATH/qemu-i386"
         fi
 
         qemu="$qemu$QEMU_SUFFIX"
-        if [ "$host_family" != "$family" ] ; then
+        if [ "x$host_family" != "x$family" ]; then
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



