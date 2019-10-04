Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87AFEC4360C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 14:52:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D81A2084D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 14:52:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D81A2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iet.unipi.it
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGOwm-0008Pd-CL
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 10:52:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40494)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <giuseppe@lettieri.iet.unipi.it>) id 1iGNF5-00033N-Ph
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 09:03:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <giuseppe@lettieri.iet.unipi.it>) id 1iGNF4-0002ak-7U
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 09:03:31 -0400
Received: from smtp2.unipi.it ([131.114.21.21]:44168 helo=smtp.unipi.it)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <giuseppe@lettieri.iet.unipi.it>) id 1iGNF3-0002UG-Tu
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 09:03:30 -0400
Received: from localhost (localhost [127.0.0.1])
 by smtp.unipi.it (Postfix) with ESMTP id 2F16440EAB;
 Fri,  4 Oct 2019 15:03:22 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at unipi.it
Received: from lettieri.iet.unipi.it (triderg7.iet.unipi.it [131.114.58.42])
 (Authenticated User)
 by smtp.unipi.it (Postfix) with ESMTPSA id 855A340EAA;
 Fri,  4 Oct 2019 15:03:20 +0200 (CEST)
Received: by lettieri.iet.unipi.it (Postfix, from userid 1000)
 id 4AFE040AC; Fri,  4 Oct 2019 15:03:05 +0200 (CEST)
From: Giuseppe Lettieri <g.lettieri@iet.unipi.it>
To: Markus Armbruster <armbru@redhat.com>
Subject: [PATCH] netmap: support git-submodule build otption
Date: Fri,  4 Oct 2019 15:02:42 +0200
Message-Id: <20191004130242.27267-1-g.lettieri@iet.unipi.it>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <874l13qmvb.fsf@dusky.pond.sub.org>
References: <874l13qmvb.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 131.114.21.21
X-Mailman-Approved-At: Fri, 04 Oct 2019 10:50:00 -0400
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 Vincenzo Maffione <v.maffione@gmail.com>,
 Giuseppe Lettieri <giuseppe.lettieri@unipi.it>,
 Stefan Hajnoczi <stefanha@redhat.com>, Luigi Rizzo <rizzo@iet.unipi.it>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Giuseppe Lettieri <giuseppe.lettieri@unipi.it>

With this patch, netmap support can be enabled with
the following options to the configure script:

  --enable-netmap[=3Dsystem]

	Use the host system netmap installation.
	Fail if not found.

  --enable-netmap=3Dgit

	clone the official netmap repository on
	github (mostly useful for CI)

Signed-off-by: Giuseppe Lettieri <giuseppe.lettieri@unipi.it>
---
 .gitmodules |  3 +++
 configure   | 64 +++++++++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 58 insertions(+), 9 deletions(-)

diff --git a/.gitmodules b/.gitmodules
index c5c474169d..bf75dbc5e3 100644
--- a/.gitmodules
+++ b/.gitmodules
@@ -58,3 +58,6 @@
 [submodule "roms/opensbi"]
 	path =3D roms/opensbi
 	url =3D 	https://git.qemu.org/git/opensbi.git
+[submodule "netmap"]
+	path =3D netmap
+	url =3D https://github.com/luigirizzo/netmap.git
diff --git a/configure b/configure
index 8f8446f52b..cb2c6c70d6 100755
--- a/configure
+++ b/configure
@@ -1132,6 +1132,10 @@ for opt do
   ;;
   --enable-netmap) netmap=3D"yes"
   ;;
+  --enable-netmap=3Dgit) netmap=3D"git"
+  ;;
+  --enable-netmap=3Dsystem) netmap=3D"system"
+  ;;
   --disable-xen) xen=3D"no"
   ;;
   --enable-xen) xen=3D"yes"
@@ -3318,8 +3322,9 @@ fi
 # a minor/major version number. Minor new features will be marked with v=
alues up
 # to 15, and if something happens that requires a change to the backend =
we will
 # move above 15, submit the backend fixes and modify this two bounds.
-if test "$netmap" !=3D "no" ; then
-  cat > $TMPC << EOF
+case "$netmap" in
+    "" | yes | system)
+      cat > $TMPC << EOF
 #include <inttypes.h>
 #include <net/if.h>
 #include <net/netmap.h>
@@ -3330,14 +3335,55 @@ if test "$netmap" !=3D "no" ; then
 int main(void) { return 0; }
 EOF
   if compile_prog "" "" ; then
-    netmap=3Dyes
+    netmap_system=3Dyes
   else
-    if test "$netmap" =3D "yes" ; then
-      feature_not_found "netmap"
-    fi
-    netmap=3Dno
+    netmap_system=3Dno
   fi
-fi
+  ;;
+esac
+
+case "$netmap" in
+  "" | yes)
+    if test "$netmap_system" =3D "yes"; then
+      netmap=3Dsystem
+    elif test -e "${source_path}/.git" && test $git_update =3D 'yes' ; t=
hen
+      netmap=3Dgit
+    elif test -e "${source_path}/netmap/configure" ; then
+      netmap=3Dinternal
+    elif test -z "$netmap" ; then
+      netmap=3Dno
+    else
+      feature_not_found "netmap" "Install netmap or git submodule"
+    fi
+    ;;
+
+  system)
+    if test "$netmap_system" =3D "no"; then
+      feature_not_found "netmap" "Install netmap"
+    fi
+    ;;
+esac
+
+case "$netmap" in
+  git | internal)
+    if test "$netmap" =3D git; then
+      git_submodules=3D"${git_submodules} netmap"
+    fi
+    mkdir -p netmap
+    QEMU_CFLAGS=3D"$QEMU_CFLAGS -I\$(SRC_PATH)/netmap/sys"
+    ;;
+
+  system)
+    ;;
+
+  no)
+    ;;
+  *)
+    error_exit "Unknown state for netmap: $netmap"
+    ;;
+esac
+
+##########################################
=20
 ##########################################
 # libcap-ng library probe
@@ -6585,7 +6631,7 @@ if test "$vde" =3D "yes" ; then
   echo "CONFIG_VDE=3Dy" >> $config_host_mak
   echo "VDE_LIBS=3D$vde_libs" >> $config_host_mak
 fi
-if test "$netmap" =3D "yes" ; then
+if test "$netmap" !=3D "no" ; then
   echo "CONFIG_NETMAP=3Dy" >> $config_host_mak
 fi
 if test "$l2tpv3" =3D "yes" ; then
--=20
2.21.0


