Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D671C43219
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 22:40:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E3902075E
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 22:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fm+bUfb7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E3902075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42256 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLxtY-0002rc-Cn
	for qemu-devel@archiver.kernel.org; Wed, 01 May 2019 18:40:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLxs2-0001z7-DJ
	for qemu-devel@nongnu.org; Wed, 01 May 2019 18:38:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLxs0-0007xl-5q
	for qemu-devel@nongnu.org; Wed, 01 May 2019 18:38:33 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:38034)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLxrw-0007uz-KU
	for qemu-devel@nongnu.org; Wed, 01 May 2019 18:38:28 -0400
Received: by mail-pf1-x444.google.com with SMTP id 10so121951pfo.5
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 15:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=Y8fpOx1lHam9DoAyom3Eo+rGp2qFykY2yeJeOtgf3Ew=;
	b=fm+bUfb7Y1LLRDVpMTda564BIcXlm15uLrPKYh2AqyVXXSnwmucJ4DIbgAwiHmVDMb
	Rnot9c+84HkJ7YQIEblxUiYN2wKjb5WmSLzWf6hFa893ZTBTzBDQu+f3vfGYPUBWNwVQ
	wfEbs3k1Ekyo1ahkmnvy6lUi//qQl5FjhSaMnyVHTz9AMFZ9NVjXKpH34I5W8RtZHjPS
	ZgRCWNueyXZ++Q7E6YK7lnzs6aqsCJ8u/xje4MFsm5mumj6v0Iv9wQN+T7hucY5bmrXQ
	ctWEwJ/WMaD5iVaTae0a9IqsJ8gGbDx901rd7Qkxj2KSD2S8I4r4U1GREJBrMMNIYUFr
	yKHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=Y8fpOx1lHam9DoAyom3Eo+rGp2qFykY2yeJeOtgf3Ew=;
	b=sA3w4EP6NfopOzk/HyCMdzQYwa1BBlAb0YBWEq0uf1XJgycuk4nWLHS2+xCZO7yCA7
	GCrGbJ9C8Bmz/HFTCGPZCV83GbOrRgtrDvoPIUzqpKuHPkHVFz6YbNmUOJZhbnd5t28D
	Mi+Wy93d9H7qInv5Sla2MbZ8D6WjuNdu0jxDb9Th7tXRsqFKVGfdy/2EQl11tzQv5Vff
	kNWD8nmeifzEklqRPFvq619AQlrIK1fJT+9ZQhECcY5NjfOaKlWvhB8tMfAVG18B7A7x
	HSh24KAg6ah6aVoE6Bl6PxiGNFs6Sj1skOmDDsDCJ40XJJzQUOgYJqgR9GvkKzhhUY3T
	02hQ==
X-Gm-Message-State: APjAAAUBGkIOTfkjjH8788lkNkDibOh7Q6o8RUpVxGX/i8xzaSQiCIXM
	5HMN8Cgc8PQGaR04+z2l97p1LG6umLA=
X-Google-Smtp-Source: APXvYqwsZxLCOhsN+HXlU+lV7jEXSlt9MqMKhchjWRoOAF3L6Xv0hSF9vHqr64FX7JtjFBgC0FEIUQ==
X-Received: by 2002:a63:fa46:: with SMTP id g6mr506876pgk.382.1556750302695;
	Wed, 01 May 2019 15:38:22 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	s85sm70603354pfa.23.2019.05.01.15.38.21
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 01 May 2019 15:38:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  1 May 2019 15:38:18 -0700
Message-Id: <20190501223819.8584-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190501223819.8584-1-richard.henderson@linaro.org>
References: <20190501223819.8584-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: [Qemu-devel] [PATCH 1/2] configure: Distinguish ppc64 and ppc64le
 hosts
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-ppc@nongnu.org, mark.cave-ayland@ilande.co.uk, alex.bennee@linaro.org,
	david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190501223818.LmnYwQDUbq-QYYUjmPp1ucWbFKwMZy3sLXZb2j8-pAY@z>

We cannot use the ppc64le host compiler to build ppc64(be) guest code.
Clean up confusion between cross_cc_powerpc and cross_cc_ppc; make use
of the cflags variable as well.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 configure | 38 ++++++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/configure b/configure
index 60719ddcc5..234cb929ca 100755
--- a/configure
+++ b/configure
@@ -198,7 +198,7 @@ supported_kvm_target() {
         i386:i386 | i386:x86_64 | i386:x32 | \
         x86_64:i386 | x86_64:x86_64 | x86_64:x32 | \
         mips:mips | mipsel:mips | \
-        ppc:ppc | ppc64:ppc | ppc:ppc64 | ppc64:ppc64 | \
+        ppc:ppc | ppc64:ppc | ppc:ppc64 | ppc64:ppc64 | ppc64:ppc64le | \
         s390x:s390x)
             return 0
         ;;
@@ -502,8 +502,11 @@ cross_cc_arm="arm-linux-gnueabihf-gcc"
 cross_cc_cflags_armeb="-mbig-endian"
 cross_cc_i386="i386-pc-linux-gnu-gcc"
 cross_cc_cflags_i386=""
-cross_cc_powerpc="powerpc-linux-gnu-gcc"
-cross_cc_powerpc="powerpc-linux-gnu-gcc"
+cross_cc_ppc="powerpc-linux-gnu-gcc"
+cross_cc_cflags_ppc="-m32"
+cross_cc_ppc64="powerpc-linux-gnu-gcc"
+cross_cc_cflags_ppc64="-m64"
+cross_cc_ppc64le="powerpc64le-linux-gnu-gcc"
 
 enabled_cross_compilers=""
 
@@ -700,7 +703,11 @@ elif check_define __sparc__ ; then
   fi
 elif check_define _ARCH_PPC ; then
   if check_define _ARCH_PPC64 ; then
-    cpu="ppc64"
+    if check_define _LITTLE_ENDIAN ; then
+      cpu="ppc64le"
+    else
+      cpu="ppc64"
+    fi
   else
     cpu="ppc"
   fi
@@ -731,10 +738,14 @@ ARCH=
 # Note that this case should only have supported host CPUs, not guests.
 case "$cpu" in
   ppc|ppc64|s390|s390x|sparc64|x32|riscv32|riscv64)
-    cpu="$cpu"
     supported_cpu="yes"
     eval "cross_cc_${cpu}=\$host_cc"
   ;;
+  ppc64le)
+    ARCH="ppc64"
+    supported_cpu="yes"
+    cross_cc_ppc64le=$host_cc
+  ;;
   i386|i486|i586|i686|i86pc|BePC)
     cpu="i386"
     supported_cpu="yes"
@@ -1525,8 +1536,8 @@ case "$cpu" in
     ppc)
            CPU_CFLAGS="-m32"
            LDFLAGS="-m32 $LDFLAGS"
-           cross_cc_powerpc=$cc
-           cross_cc_cflags_powerpc=$CPU_CFLAGS
+           cross_cc_ppc=$cc
+           cross_cc_cflags_ppc="$CPU_CFLAGS"
            ;;
     ppc64)
            CPU_CFLAGS="-m64"
@@ -2379,7 +2390,7 @@ if test "$seccomp" != "no" ; then
     arm|aarch64)
         libseccomp_minver="2.2.3"
         ;;
-    ppc|ppc64|s390x)
+    ppc|ppc64|ppc64le|s390x)
         libseccomp_minver="2.3.0"
         ;;
     *)
@@ -6160,7 +6171,7 @@ if { test "$cpu" = "i386" || test "$cpu" = "x86_64"; } && \
         fi
     done
 fi
-if test "$cpu" = "ppc64" && test "$targetos" != "Darwin" ; then
+if test "$ARCH" = "ppc64" && test "$targetos" != "Darwin" ; then
   roms="$roms spapr-rtas"
 fi
 
@@ -7345,7 +7356,7 @@ if test "$linux" = "yes" ; then
   i386|x86_64|x32)
     linux_arch=x86
     ;;
-  ppc|ppc64)
+  ppc|ppc64|ppc64le)
     linux_arch=powerpc
     ;;
   s390x)
@@ -7506,7 +7517,8 @@ case "$target_name" in
   ;;
   ppc)
     gdb_xml_files="power-core.xml power-fpu.xml power-altivec.xml power-spe.xml"
-    target_compiler=$cross_cc_powerpc
+    target_compiler=$cross_cc_ppc
+    target_compiler_cflags="$cross_cc_cflags_ppc"
   ;;
   ppc64)
     TARGET_BASE_ARCH=ppc
@@ -7514,6 +7526,7 @@ case "$target_name" in
     mttcg=yes
     gdb_xml_files="power64-core.xml power-fpu.xml power-altivec.xml power-spe.xml power-vsx.xml"
     target_compiler=$cross_cc_ppc64
+    target_compiler_cflags="$cross_cc_cflags_ppc64"
   ;;
   ppc64le)
     TARGET_ARCH=ppc64
@@ -7529,7 +7542,8 @@ case "$target_name" in
     TARGET_ABI_DIR=ppc
     echo "TARGET_ABI32=y" >> $config_target_mak
     gdb_xml_files="power64-core.xml power-fpu.xml power-altivec.xml power-spe.xml power-vsx.xml"
-    target_compiler=$cross_cc_ppc64abi32
+    target_compiler=$cross_cc_ppc
+    target_compiler_cflags="$cross_cc_cflags_ppc"
   ;;
   riscv32)
     TARGET_BASE_ARCH=riscv
-- 
2.17.1


