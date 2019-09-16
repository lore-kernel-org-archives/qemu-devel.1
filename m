Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 397E6C49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 16:06:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F7812184D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 16:06:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F7812184D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=unipi.it
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9tWJ-00084X-Gd
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 12:06:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54609)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <giuseppe.lettieri@unipi.it>) id 1i9sGG-000116-Is
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:45:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <giuseppe.lettieri@unipi.it>) id 1i9sGE-0000HQ-OB
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:45:52 -0400
Received: from smtp2.unipi.it ([131.114.21.21]:44674 helo=smtp.unipi.it)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <giuseppe.lettieri@unipi.it>) id 1i9sGE-0000GZ-B6
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:45:50 -0400
Received: from localhost (localhost [127.0.0.1])
 by smtp.unipi.it (Postfix) with ESMTP id 8664040CF7;
 Mon, 16 Sep 2019 16:45:45 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at unipi.it
Received: from [10.216.1.207] (prova.iet.unipi.it [131.114.58.86])
 (Authenticated User)
 by smtp.unipi.it (Postfix) with ESMTPSA id A5343400AA;
 Mon, 16 Sep 2019 16:45:43 +0200 (CEST)
To: Markus Armbruster <armbru@redhat.com>
References: <20190806151435.10740-1-armbru@redhat.com>
 <20190806151435.10740-28-armbru@redhat.com>
 <8c2a6fad-6ac1-21b1-c17c-e1bd5ac41c9f@redhat.com>
 <87a7ckrat7.fsf@dusky.pond.sub.org>
 <ee3709c9-f351-081a-3aeb-53b7b6036b0a@redhat.com>
 <87imr8l0ti.fsf_-_@dusky.pond.sub.org>
 <695325d7-a0c3-73c1-97ab-f62fb345c622@unipi.it>
 <87blwzho1y.fsf@dusky.pond.sub.org>
 <2fb98b77-efab-6092-dd5a-fa50c3c4b3f9@redhat.com>
 <58e7895e-4910-4d4c-79d8-dead7de69ab7@unipi.it>
 <87blvocpq2.fsf@dusky.pond.sub.org>
From: Giuseppe Lettieri <giuseppe.lettieri@unipi.it>
Message-ID: <df94280b-13f6-1df3-f594-5eb0a614777d@unipi.it>
Date: Mon, 16 Sep 2019 16:45:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <87blvocpq2.fsf@dusky.pond.sub.org>
Content-Type: multipart/mixed; boundary="------------C20B41AC7FD5CFB813BC7D78"
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 131.114.21.21
Subject: Re: [Qemu-devel] Is network backend netmap worth keeping?
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
 "Daniel P. Berrange" <berrange@redhat.com>, Luigi Rizzo <rizzo@iet.unipi.it>,
 Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 Vincenzo Maffione <v.maffione@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a multi-part message in MIME format.
--------------C20B41AC7FD5CFB813BC7D78
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 13/09/19 15:04, Markus Armbruster ha scritto:
> 
> What happens when I build with --enable-netmap=system on host A, then
> run the resulting binary on some host B that doesn't have netmap
> installed?
> 

Qemu will fail at startup, complaining that /dev/netmap does not exists.


> 
> Yes.  We default to netmap=system, though.  If you break things by
> passing arcane arguments to configure, you get to keep the pieces :)
> 
>> If the option is only useful for developers to check that some qemu
>> change does not break anything, then probably it should be enabled in
>> some other, less visible way. What do you think?
> 
> I think an --enable-netmap patterned after --enable-capstone and
> --enable-slirp has sufficiently low visibility as long as the default is
> sane.
> 
> We clearly want configure to pick netmap=system when the system provides
> netmap.
> 
> What shall configure pick when the system doesn't provide it?  If you
> think netmap=git is too dangerous for general audience, consider
> disabling netmap then.  Experts can still compile-test with
> --enable-netmap=git.  Our CI certainly should.
> 

OK, sounds reasonable. The attached patch will select system if netmap 
is available, and git only if explicitly requested.

Cheers,
Giuseppe

-- 
Dr. Ing. Giuseppe Lettieri
Dipartimento di Ingegneria della Informazione
Universita' di Pisa
Largo Lucio Lazzarino 1, 56122 Pisa - Italy
Ph. : (+39) 050-2217.649 (direct) .599 (switch)
Fax : (+39) 050-2217.600
e-mail: g.lettieri@iet.unipi.it

--------------C20B41AC7FD5CFB813BC7D78
Content-Type: text/x-patch;
 name="0001-netmap-support-git-submodule-build-otption.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-netmap-support-git-submodule-build-otption.patch"

From 4e93b5cc3ad68d92bc3562df3745e1d10dc08fc0 Mon Sep 17 00:00:00 2001
From: Giuseppe Lettieri <g.lettieri@iet.unipi.it>
Date: Mon, 2 Sep 2019 17:35:33 +0200
Subject: [PATCH] netmap: support git-submodule build otption

With this patch, netmap support can be enabled with
the following options to the configure script:

  --enable-netmap[=system]

	Use the host system netmap installation.
	Fail if not found.

  --enable-netmap=git

	clone the official netmap repository on
	github (mostly useful for CI)

system will also be automatically used if no option is
passed and netmap is available in the host system.

Signed-off-by: Giuseppe Lettieri <giuseppe.lettieri@unipi.it>
---
 .gitmodules |  3 +++
 configure   | 68 ++++++++++++++++++++++++++++++++++++++++++++---------
 netmap      |  1 +
 3 files changed, 61 insertions(+), 11 deletions(-)
 create mode 160000 netmap

diff --git a/.gitmodules b/.gitmodules
index c5c474169d..bf75dbc5e3 100644
--- a/.gitmodules
+++ b/.gitmodules
@@ -58,3 +58,6 @@
 [submodule "roms/opensbi"]
 	path = roms/opensbi
 	url = 	https://git.qemu.org/git/opensbi.git
+[submodule "netmap"]
+	path = netmap
+	url = https://github.com/luigirizzo/netmap.git
diff --git a/configure b/configure
index 30aad233d1..5cb924985c 100755
--- a/configure
+++ b/configure
@@ -1133,6 +1133,10 @@ for opt do
   ;;
   --enable-netmap) netmap="yes"
   ;;
+  --enable-netmap=git) netmap="git"
+  ;;
+  --enable-netmap=system) netmap="system"
+  ;;
   --disable-xen) xen="no"
   ;;
   --enable-xen) xen="yes"
@@ -3314,8 +3318,9 @@ fi
 # a minor/major version number. Minor new features will be marked with values up
 # to 15, and if something happens that requires a change to the backend we will
 # move above 15, submit the backend fixes and modify this two bounds.
-if test "$netmap" != "no" ; then
-  cat > $TMPC << EOF
+case "$netmap" in
+    "" | yes | system)
+      cat > $TMPC << EOF
 #include <inttypes.h>
 #include <net/if.h>
 #include <net/netmap.h>
@@ -3325,15 +3330,56 @@ if test "$netmap" != "no" ; then
 #endif
 int main(void) { return 0; }
 EOF
-  if compile_prog "" "" ; then
-    netmap=yes
-  else
-    if test "$netmap" = "yes" ; then
-      feature_not_found "netmap"
+      if compile_prog "" "" ; then
+        netmap_system=yes
+      else
+        netmap_system=no
+      fi
+      ;;
+esac
+
+case "$netmap" in
+  "" | yes)
+    if test "$netmap_system" = "yes"; then
+      netmap=system
+    elif test -e "${source_path}/.git" && test $git_update = 'yes' ; then
+      netmap=git
+    elif test -e "${source_path}/netmap/configure" ; then
+      netmap=internal
+    elif test -z "$netmap" ; then
+      netmap=no
+    else
+      feature_not_found "netmap" "Install netmap or git submodule"
     fi
-    netmap=no
-  fi
-fi
+    ;;
+
+  system)
+    if test "$netmap_system" = "no"; then
+      feature_not_found "netmap" "Install netmap"
+    fi
+    ;;
+esac
+
+case "$netmap" in
+  git | internal)
+    if test "$netmap" = git; then
+      git_submodules="${git_submodules} netmap"
+    fi
+    mkdir -p netmap
+    QEMU_CFLAGS="$QEMU_CFLAGS -I\$(SRC_PATH)/netmap/sys"
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
 
 ##########################################
 # libcap-ng library probe
@@ -6582,7 +6628,7 @@ if test "$vde" = "yes" ; then
   echo "CONFIG_VDE=y" >> $config_host_mak
   echo "VDE_LIBS=$vde_libs" >> $config_host_mak
 fi
-if test "$netmap" = "yes" ; then
+if test "$netmap" != "no" ; then
   echo "CONFIG_NETMAP=y" >> $config_host_mak
 fi
 if test "$l2tpv3" = "yes" ; then
diff --git a/netmap b/netmap
new file mode 160000
index 0000000000..137f537eae
--- /dev/null
+++ b/netmap
@@ -0,0 +1 @@
+Subproject commit 137f537eae513f02d5d6871d1f91c049e6345803
-- 
2.20.1


--------------C20B41AC7FD5CFB813BC7D78--

