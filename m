Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04AC4C33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 14:25:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C196121744
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 14:25:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="KSha5Lcj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C196121744
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iopnX-0002F7-Av
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 09:25:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35900)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <n54@gmx.com>) id 1iooNt-0003jU-1u
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 07:54:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <n54@gmx.com>) id 1iooNr-0000z3-Dt
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 07:54:56 -0500
Received: from mout.gmx.net ([212.227.15.15]:36531)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <n54@gmx.com>) id 1iooNr-0000xO-3p
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 07:54:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1578401684;
 bh=MNe65IX81php0msP6hBmroHHZoRYTXqyhunZqXPS9uk=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=KSha5Lcj98BJiycOGEot7524k7lEY9j/56sF8kouCxxiuquwZ0jIkoDJAyhTvH6bb
 gm2Y00VrnNhRoytocEVTZoQ9bYPLkWb/fe7GiE8oAAoDTbmel7trKD0Z4tFqw1S815
 aDEIf6m4YIkHIpWrLlI584WoGTvU5L5vvjqelrqo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([89.71.135.231]) by mail.gmx.com
 (mrgmx005 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MTiPv-1jGT5a44Uv-00TySy; Tue, 07 Jan 2020 13:54:44 +0100
From: Kamil Rytarowski <n54@gmx.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/4] Add the NetBSD Virtual Machine Monitor accelerator.
Date: Tue,  7 Jan 2020 13:53:59 +0100
Message-Id: <20200107125401.18126-3-n54@gmx.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200107125401.18126-1-n54@gmx.com>
References: <20200107125401.18126-1-n54@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Va58LnAqGNV5aMYRzW+KSTjJlXVucQcpbQU7cQEiD5oWpMCFvkq
 EwH/w7ih5DBhEDWLBikLLj8wTg6GdNfKwjURQCOeFI5BJJyMwjFyNiS8Lw2UXZ1GHeGFb5f
 ka2Noz5/V3G4hP6gksCZTxQg9Fd2L6wnUimUiBcY65YZbIBpjzAQX6f9O2xle1KOnN2dR7A
 dCTBzFet37HhWtecvagyQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:otGnVlpPJlY=:stqlQCrGUYHWbt+5GoOHfG
 ZmFH4ED7afmuGmD1Jrxkt3vXZ1UMJHn+JHfpXzsyiVvFeFA/wp2p8RKfQQUbeQg7WoC+/ERXm
 De4UjRektYT/pILq6hzt7A5yXJyHNDYrveFwBooi7daU7RO5rUZ9vfDY2JSIJk6c1hNlX1J7F
 Se12qPyTPN1ZmfWFhFllwahwY/UhHWWdnMRgtnUb2gKl1YYHxopkmd3tN9jsbGUe0CH0mTY0a
 EUmXAoPv7K5VpUm22vkH5sn5VStSXotgLVMlDDv04b61ZQAEUqFbP0mwJxG6dCLojd3u4Wa4W
 7c5mRzavrM3yDdGtM3v0hhVdSuWVNWoSX2dZ7znez/U1GYEjocdtm3rqotfn1M2Y9bF5cln2M
 FLnmYcXIVl4iyzkBUmgPyffAJHnREV9K6BVfgPeZGxXYKd04QanAyqxlJ2mWz6TL/T2Zj6MRR
 i0fAWUX5sTLhna1ZOSrcAhfSX5TRThDJjEEDY/2AsE5HhSf/w8mtWBteKUzTM6wut93mmb/Sf
 zpmjlzotRSjfXspefrpm3JS1JZXqCMWl3WoBq+6N+X0qkancjwiNm3HpB1pvjytbTn6WYxjeX
 EvH7FonMYR2NpO9p/3oTNRrlbkCd03+Tgewtxz6j7sBkQ+bnCr7UPD5d0cgvsMPXSCtaNnR5w
 7Fr/wUi6KrqUtLrxn0FpiV6rG1J4SJOaznB7+VUouSnE+sL2QlYpNMm6pM1pNTzmC6vDOHT00
 KwPyGArOP/hBYQs0Z8rZZ/b3ETEZIiOSeu27nNEDR9mETUrKgckCxxmRojjwfrV/Uu2HVq4T3
 nOSx6h5Vz3TFGBTUiBNGOXLQtpDZhx+a+KyLCcGQDqJLRdmisVAZAqAw4dEpDj5tZNC4ndSB+
 Wx80i9Ulz/eorw15k6/U968nc3O59ToFvd8ya0vXmctkZGPJWwck01loAzAW5fKiQzhOAzLz/
 nqCNRVPmmXF2E6CSTlipdDD8OItmuAxDqHnnh39ERxgKpUkGHWdc2xdgO9pL3pbMdb9ceNwpY
 kD9Cchwm+Sb8wgPSwg7z1LwccbnB9/+DozeDVyFbdHKJFG3rNxnXnxKt4EJsRSWgpeMK3WUD0
 Z4ffHtm+z7xvblr/bGAI3ELXoWxYaVsNSDBgTiubGwnXv25wPaKsz9Fvc6QJM24PezgOkYtpv
 gJV+usXqi1WhQJjVZz4ci9sGbB1lJI7CpuMuPRXM7JxNUWF/xk2EXlssF00PLNpb3h73WNDEn
 URY5xY9oKGJSLafTcXU5eupAlUNBwj4JxTV8SYw==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.15.15
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
Cc: pbonzini@redhat.com, Kamil Rytarowski <n54@gmx.com>,
 Maxime Villard <max@m00nbsd.net>, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Maxime Villard <max@m00nbsd.net>

Introduces the configure support for the new NetBSD Virtual Machine Monito=
r that
allows for hypervisor acceleration from usermode components on the NetBSD
platform.

Signed-off-by: Maxime Villard <max@m00nbsd.net>
Signed-off-by: Kamil Rytarowski <n54@gmx.com>
=2D--
 configure       | 36 ++++++++++++++++++++++++++++++++++++
 qemu-options.hx |  4 ++--
 2 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/configure b/configure
index 0ce2c0354a..eb456a271e 100755
=2D-- a/configure
+++ b/configure
@@ -241,6 +241,17 @@ supported_whpx_target() {
     return 1
 }

+supported_nvmm_target() {
+    test "$nvmm" =3D "yes" || return 1
+    glob "$1" "*-softmmu" || return 1
+    case "${1%-softmmu}" in
+        i386|x86_64)
+            return 0
+        ;;
+    esac
+    return 1
+}
+
 supported_target() {
     case "$1" in
         *-softmmu)
@@ -268,6 +279,7 @@ supported_target() {
     supported_hax_target "$1" && return 0
     supported_hvf_target "$1" && return 0
     supported_whpx_target "$1" && return 0
+    supported_nvmm_target "$1" && return 0
     print_error "TCG disabled, but hardware accelerator not available for=
 '$target'"
     return 1
 }
@@ -387,6 +399,7 @@ kvm=3D"no"
 hax=3D"no"
 hvf=3D"no"
 whpx=3D"no"
+nvmm=3D"no"
 rdma=3D""
 pvrdma=3D""
 gprof=3D"no"
@@ -1168,6 +1181,10 @@ for opt do
   ;;
   --enable-whpx) whpx=3D"yes"
   ;;
+  --disable-nvmm) nvmm=3D"no"
+  ;;
+  --enable-nvmm) nvmm=3D"yes"
+  ;;
   --disable-tcg-interpreter) tcg_interpreter=3D"no"
   ;;
   --enable-tcg-interpreter) tcg_interpreter=3D"yes"
@@ -1768,6 +1785,7 @@ disabled with --disable-FEATURE, default is enabled =
if available:
   hax             HAX acceleration support
   hvf             Hypervisor.framework acceleration support
   whpx            Windows Hypervisor Platform acceleration support
+  nvmm            NetBSD Virtual Machine Monitor acceleration support
   rdma            Enable RDMA-based migration
   pvrdma          Enable PVRDMA support
   vde             support for vde network
@@ -2757,6 +2775,20 @@ if test "$whpx" !=3D "no" ; then
     fi
 fi

+##########################################
+# NetBSD Virtual Machine Monitor (NVMM) accelerator check
+if test "$nvmm" !=3D "no" ; then
+    if check_include "nvmm.h" ; then
+        nvmm=3D"yes"
+	LIBS=3D"-lnvmm $LIBS"
+    else
+        if test "$nvmm" =3D "yes"; then
+            feature_not_found "NVMM" "NVMM is not available"
+        fi
+        nvmm=3D"no"
+    fi
+fi
+
 ##########################################
 # Sparse probe
 if test "$sparse" !=3D "no" ; then
@@ -6495,6 +6527,7 @@ echo "KVM support       $kvm"
 echo "HAX support       $hax"
 echo "HVF support       $hvf"
 echo "WHPX support      $whpx"
+echo "NVMM support      $nvmm"
 echo "TCG support       $tcg"
 if test "$tcg" =3D "yes" ; then
     echo "TCG debug enabled $debug_tcg"
@@ -7771,6 +7804,9 @@ fi
 if test "$target_aligned_only" =3D "yes" ; then
   echo "TARGET_ALIGNED_ONLY=3Dy" >> $config_target_mak
 fi
+if supported_nvmm_target $target; then
+    echo "CONFIG_NVMM=3Dy" >> $config_target_mak
+fi
 if test "$target_bigendian" =3D "yes" ; then
   echo "TARGET_WORDS_BIGENDIAN=3Dy" >> $config_target_mak
 fi
diff --git a/qemu-options.hx b/qemu-options.hx
index e9d6231438..f2dbac68ef 100644
=2D-- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -31,7 +31,7 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
     "-machine [type=3D]name[,prop[=3Dvalue][,...]]\n"
     "                selects emulated machine ('-machine help' for list)\=
n"
     "                property accel=3Daccel1[:accel2[:...]] selects accel=
erator\n"
-    "                supported accelerators are kvm, xen, hax, hvf, whpx =
or tcg (default: tcg)\n"
+    "                supported accelerators are kvm, xen, hax, hvf, nvmm,=
 whpx or tcg (default: tcg)\n"
     "                vmport=3Don|off|auto controls emulation of vmport (d=
efault: auto)\n"
     "                dump-guest-core=3Don|off include guest memory in a c=
ore dump (default=3Don)\n"
     "                mem-merge=3Don|off controls memory merge support (de=
fault: on)\n"
@@ -63,7 +63,7 @@ Supported machine properties are:
 @table @option
 @item accel=3D@var{accels1}[:@var{accels2}[:...]]
 This is used to enable an accelerator. Depending on the target architectu=
re,
-kvm, xen, hax, hvf, whpx or tcg can be available. By default, tcg is used=
. If there is
+kvm, xen, hax, hvf, nvmm, whpx or tcg can be available. By default, tcg i=
s used. If there is
 more than one accelerator specified, the next one is used if the previous=
 one
 fails to initialize.
 @item vmport=3Don|off|auto
=2D-
2.24.0


