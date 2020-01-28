Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 738C7C33C9E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 10:55:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FA012467B
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 10:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="N/mO5DYL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FA012467B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwOWq-0002Tp-75
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 05:55:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52389)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <n54@gmx.com>) id 1iwOTp-0000cP-AV
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 05:52:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <n54@gmx.com>) id 1iwOTn-0004is-Ua
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 05:52:25 -0500
Received: from mout.gmx.net ([212.227.15.18]:51839)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <n54@gmx.com>) id 1iwOTn-0004i9-Hr
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 05:52:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1580208735;
 bh=WsY8swjSmAssMYRjClxdfY23Vl55y4mQ4Au8Z2MDGSk=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=N/mO5DYLCX3JMF+Y86xwtHJgZpugWtzAejOJfioU+CI06v8d0GwNxvhrlDQZuXM83
 jw1mLMUKNKqiLGYwwfq2EDZMX/337198P/OGc2UocSetWw5q+Fn88kgYnvqVKShoPK
 pJBxY/jM6rG6Dg7t0fx5+aYnBLi7WbT2+VNf63rU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([89.71.135.231]) by mail.gmx.com
 (mrgmx005 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MUosN-1j5ZXj3rVZ-00Qkb3; Tue, 28 Jan 2020 11:52:15 +0100
From: Kamil Rytarowski <n54@gmx.com>
To: slp@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org,
 max@m00nbsd.net
Subject: [PATCH v2 2/4] Add the NetBSD Virtual Machine Monitor accelerator.
Date: Tue, 28 Jan 2020 11:51:33 +0100
Message-Id: <20200128105133.2245-1-n54@gmx.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200128085438.hhz3f55bow75zl35@dritchie>
References: <20200128085438.hhz3f55bow75zl35@dritchie>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Pw18AC6T4KJLsRdTk22pD7W9h16uzXrbVMEBqbGsvQb44zrTidt
 IWj3YuxzJ2skm96+LB9zOVCnw7lhpo7u/iRLBYP3XwVqgjr7aJnooY1k7HID71rpnhmjKGo
 EWBAuT+q2ZpXtweLMdSbj2LIAS9cmtLpkTFnDQk9XPvjvvm51X4bhCXS8i/Roirk7ZSVbyD
 Ab8Yh1N75C5/flsmKIRRw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NW42WudnbNc=:UmV/dD1X5DWR/OHZqSkPt4
 4jBI07AF1/Dxr5LV18iTLK+gET+w98SRpq0tF2Xw5UgBoqnoPZCfIE/3JaIfk/UiwlTUHzDlV
 ra2NNJ/3kgjOyqyufGxjzpnNZJIVfqmgVkT1/zU6b0HQECi6CG7cTYQodoF+WR1Qxv7bJW81t
 cP/jPqdnQ5XcLtkOPGVRFOCU1pJUJZPAQN63kXJPsFl6iovR5H+DgKsKYQ++h+n2Qp8hrOOhu
 wEKQAK1B1/2E4P4gi4ojzzzW4hrZpN8+MRuPmga+2hkqgathpxBdhkWxndDXa38RxHhC1/mTx
 NNMu8GKYSxS/vIOwlwawCXkHI0B7KRaRIcKNvTSjxeUYrNXbkzLfBi6CKbA7WdfZe6qjimCa9
 uq8ymoyA/2nTMP1fN9bdozC28lsXyu2M4S1ogRn3gEyJzzM2OYNqxoWbA4q1bqJ9D5bPC72tw
 zK6yG/anSj3M+qf6acWmPgIV7+Vm3C5x/HpNOvRitv8QxDXGiN0wJEbDE1UWO4Q5RFRrlw7nV
 TKoJ5oY0IVY2+JS2qM19FPOsSspJ7mUjtl3xDEv5oEcl4FB4n4tVwZrVsEaD+Z245mv2Uuuxz
 aI1BDSqeMC7L9T0SzBUYUOA1CUUYTbd6gY8nboyaSfcQbEDpcXzmpjdcmcURVIEJyzITnzF9j
 tLx5DmKV2eyLAFHaQ+ZgfTE/eeY/P8etgRkN9XImG7OIiZLBNwKviRfmzDbFvooy0EIiQEgX6
 VwVcZ+VZUCBVb2t/DhFd0e6ZjVOv4z4xdS6xF3sfjhHWHSbqhYN6IEHax7E62ZfyMD70wiLP8
 6nf39itk/DP2qwHoJ0FYxhxEsc5sfTMPrxohFYMxVockh/RSkFc2DTZuEjJQPNm75ubG3oE5p
 h6NK/6YQ8SwTq8pjboqWnmcQCDJtjHryqZljMKcq5cnUIgBX5HAoouCdvwIklxftmDfRnNIBd
 dKqK5Y9/hagvtBmnyM8SZuAuXWxswnnoquME/nJT7OrL7L7Dk0bFgSEHnXqUE5V7Vv76DCuZD
 J3ql68gv1T21wERUKnvbI2EySIIEaE5EhVstUtoiMLHRQpvyuUd+l5J245gW3etNWOehJHGYG
 7Ooe76ROXM0RecUO3j1TbTuYjBDNGhx3d5ap67wa1if1O9/Xui10hmytFaQcT5Oo1awNXu/6G
 LDUGWhtZ6RiJlvpVHLPFESTjZc+v9k6WfEbPfTfSGto5E+6DDkxy6bORSYyw+2Pyq2EFA=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.15.18
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
Cc: Kamil Rytarowski <n54@gmx.com>, qemu-devel@nongnu.org
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
 qemu-options.hx | 16 ++++++++--------
 2 files changed, 44 insertions(+), 8 deletions(-)

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
index e9d6231438..4ddf7c91a0 100644
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
@@ -63,9 +63,9 @@ Supported machine properties are:
 @table @option
 @item accel=3D@var{accels1}[:@var{accels2}[:...]]
 This is used to enable an accelerator. Depending on the target architectu=
re,
-kvm, xen, hax, hvf, whpx or tcg can be available. By default, tcg is used=
. If there is
-more than one accelerator specified, the next one is used if the previous=
 one
-fails to initialize.
+kvm, xen, hax, hvf, nvmm, whpx or tcg can be available. By default, tcg i=
s used.
+If there is more than one accelerator specified, the next one is used if =
the
+previous one fails to initialize.
 @item vmport=3Don|off|auto
 Enables emulation of VMWare IO port, for vmmouse etc. auto says to select=
 the
 value based on accel. For accel=3Dxen the default is off otherwise the de=
fault
@@ -110,7 +110,7 @@ ETEXI

 DEF("accel", HAS_ARG, QEMU_OPTION_accel,
     "-accel [accel=3D]accelerator[,prop[=3Dvalue][,...]]\n"
-    "                select accelerator (kvm, xen, hax, hvf, whpx or tcg;=
 use 'help' for a list)\n"
+    "                select accelerator (kvm, xen, hax, hvf, nvmm, whpx o=
r tcg; use 'help' for a list)\n"
     "                igd-passthru=3Don|off (enable Xen integrated Intel g=
raphics passthrough, default=3Doff)\n"
     "                kernel-irqchip=3Don|off|split controls accelerated i=
rqchip support (default=3Don)\n"
     "                kvm-shadow-mem=3Dsize of KVM shadow MMU in bytes\n"
@@ -120,9 +120,9 @@ STEXI
 @item -accel @var{name}[,prop=3D@var{value}[,...]]
 @findex -accel
 This is used to enable an accelerator. Depending on the target architectu=
re,
-kvm, xen, hax, hvf, whpx or tcg can be available. By default, tcg is used=
. If there is
-more than one accelerator specified, the next one is used if the previous=
 one
-fails to initialize.
+kvm, xen, hax, hvf, nvmm, whpx or tcg can be available. By default, tcg i=
s used.
+If there is more than one accelerator specified, the next one is used if =
the
+previous one fails to initialize.
 @table @option
 @item igd-passthru=3Don|off
 When Xen is in use, this option controls whether Intel integrated graphic=
s
=2D-
2.24.1


