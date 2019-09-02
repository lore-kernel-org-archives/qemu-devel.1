Return-Path: <SRS0=OFvx=W5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C80C3A59E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 20:51:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F170921897
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 20:51:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F170921897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=unipi.it
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4tIG-0004DV-3z
	for qemu-devel@archiver.kernel.org; Mon, 02 Sep 2019 16:51:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60525)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <giuseppe.lettieri@unipi.it>) id 1i4tHZ-0003oo-KK
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 16:50:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <giuseppe.lettieri@unipi.it>) id 1i4tHX-0007q6-IK
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 16:50:37 -0400
Received: from smtp2.unipi.it ([131.114.21.21]:48007 helo=smtp.unipi.it)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <giuseppe.lettieri@unipi.it>) id 1i4tHX-0007ob-7C
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 16:50:35 -0400
Received: from localhost (localhost [127.0.0.1])
 by smtp.unipi.it (Postfix) with ESMTP id E43ED40ADF;
 Mon,  2 Sep 2019 22:50:31 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at unipi.it
Received: from lettieri.iet.unipi.it (triderg7.iet.unipi.it [131.114.58.42])
 (Authenticated User)
 by smtp.unipi.it (Postfix) with ESMTPSA id 1134E40054;
 Mon,  2 Sep 2019 22:50:30 +0200 (CEST)
Received: from [192.168.1.10]
 (host134-200-dynamic.7-87-r.retail.telecomitalia.it [87.7.200.134])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lettieri.iet.unipi.it (Postfix) with ESMTPSA id 62B8540A3;
 Mon,  2 Sep 2019 22:50:15 +0200 (CEST)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20190806151435.10740-1-armbru@redhat.com>
 <20190806151435.10740-28-armbru@redhat.com>
 <8c2a6fad-6ac1-21b1-c17c-e1bd5ac41c9f@redhat.com>
 <87a7ckrat7.fsf@dusky.pond.sub.org>
 <ee3709c9-f351-081a-3aeb-53b7b6036b0a@redhat.com>
 <87imr8l0ti.fsf_-_@dusky.pond.sub.org>
 <695325d7-a0c3-73c1-97ab-f62fb345c622@unipi.it>
 <87blwzho1y.fsf@dusky.pond.sub.org>
 <2fb98b77-efab-6092-dd5a-fa50c3c4b3f9@redhat.com>
From: Giuseppe Lettieri <giuseppe.lettieri@unipi.it>
Message-ID: <58e7895e-4910-4d4c-79d8-dead7de69ab7@unipi.it>
Date: Mon, 2 Sep 2019 22:50:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <2fb98b77-efab-6092-dd5a-fa50c3c4b3f9@redhat.com>
Content-Type: multipart/mixed; boundary="------------EFA4B7325029CAA54677FCB6"
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
 "Daniel P. Berrange" <berrange@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org, Vincenzo Maffione <v.maffione@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>, Luigi Rizzo <rizzo@iet.unipi.it>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a multi-part message in MIME format.
--------------EFA4B7325029CAA54677FCB6
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi all,

I have been thinking of the submodule suggestion and I have also=20
prepared a patch for it (attached). However, I am not sure about what we=20
want to achieve with it. In particular, I am not sure that the option is=20
useful for end users. The problem is that netmap, unlike capstone and=20
slirp, is a library plus a kernel module. If netmap is not installed in=20
the system, the --enable-netmap=3Dgit option will successfully build qemu=
=20
with netmap support, but then -netdev netmap will fail at runtime. On=20
the other end, if netmap is installed in the system, using the =3Dgit=20
option may cause qemu to be built against a different, possibly=20
incompatible version.

If the option is only useful for developers to check that some qemu=20
change does not break anything, then probably it should be enabled in=20
some other, less visible way. What do you think?

Cheers,

Giuseppe

On 8/12/19 2:32 PM, Philippe Mathieu-Daud=C3=A9 wrote:

> On 8/8/19 1:52 PM, Markus Armbruster wrote:
>> Giuseppe Lettieri <giuseppe.lettieri@unipi.it> writes:
>>
>>> Dear Markus,
>>>
>>> the netmap project is alive and well, if a bit understuffed. We have
>>> moved to github:
>>>
>>> https://github.com/luigirizzo/netmap
>>>
>>> We have users from FreeBSD, where it is part of the official kernel,
>>> and Linux, both from Academia and industry.
>>>
>>> But you asked about the netmap backend in QEMU, in particular. When i=
t
>>> was merged, the decision was made to disable it by default because it
>>> was not supported upstream in Linux. As Jason Wang says, this support
>>> is even more unlikely now than it was then.
>>>
>>> The fact the the backend has to be explicitly enabled and built from
>>> the sources has obviously cut down the number of potential
>>> users. However, we still think it is useful and we have pending
>>> updates for it. If it's causing problems in the workflow, I am willin=
g
>>> to help as much as I can.
>> Could we make it a submodule, simililar to slirp and capstone?
> Good idea, this would extend the coverage. Netmap users/developers are
> probably best suited to do this.
>
>>      --enable-netmap=3Dsystem      use the system's netmap
>>      --enable-netmap=3Dgit         use the git submodule
>>      --enable-netmap             use system's, else git, else fail
>>      --disable-netmap            disable netmap
>>      default                     use system's, else git, else disable
>>
>> A fresh clone of https://github.com/luigirizzo/netmap clocks in at
>> 14MiB, which is between libslirp's 1.5MiB and capstone's 72MiB.
> In which directory should we clone it? As /netmap directly?
>
> Should we start using a 3rd-party/ subdirectory?
>
> Similarly, what about the virglrenderer component?
>
> Its repository is: https://anongit.freedesktop.org/git/virglrenderer.gi=
t

--------------EFA4B7325029CAA54677FCB6
Content-Type: text/x-patch;
 name="0001-netmap-support-git-submodule-build-otption.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-netmap-support-git-submodule-build-otption.patch"

From ddec3b9e4e1e6e8da44d0d7eec643db7b82b2b81 Mon Sep 17 00:00:00 2001
From: Giuseppe Lettieri <g.lettieri@iet.unipi.it>
Date: Mon, 2 Sep 2019 17:35:33 +0200
Subject: [PATCH] netmap: support git-submodule build otption

With this patch, netmap support can be enabled with
the following options to the configure script:

  --enable-netmap=system

	Use the host system netmap installation.
	Fail if not found.

  --enable-netmap=git

	clone the official netmap repository on
	github

  --enable-netmap

	try system and then git.
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
index e44e454c43..560f357967 100755
--- a/configure
+++ b/configure
@@ -1155,6 +1155,10 @@ for opt do
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
@@ -3351,8 +3355,9 @@ fi
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
@@ -3362,15 +3367,56 @@ if test "$netmap" != "no" ; then
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
@@ -6630,7 +6676,7 @@ if test "$vde" = "yes" ; then
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


--------------EFA4B7325029CAA54677FCB6--

