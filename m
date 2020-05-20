Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1CDAC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 13:33:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71CBF20748
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 13:33:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BCAKZb82"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71CBF20748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=invisiblethingslab.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbOqZ-0003dn-Kz
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 09:33:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47928)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marmarek@invisiblethingslab.com>)
 id 1jbOei-0003bb-Pp
 for qemu-devel@nongnu.org; Wed, 20 May 2020 09:21:08 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:38717)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marmarek@invisiblethingslab.com>)
 id 1jbOeh-0000UL-Pk
 for qemu-devel@nongnu.org; Wed, 20 May 2020 09:21:08 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.nyi.internal (Postfix) with ESMTP id 7ADD15C0180;
 Wed, 20 May 2020 09:21:05 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute3.internal (MEProxy); Wed, 20 May 2020 09:21:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:message-id:mime-version:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=dCWDTR
 uEr9EdgWbZZp0CL/1fjqOYuuGrVpGcBdKj8O8=; b=BCAKZb825xVGz2sp4uF0XA
 33Ke4V4PuprIZloP2p7BaHCZfcZswH11UCo/1hbjmFcAbJijolXzdcKeTa7iN1VJ
 50vPYxUedM459o1Mvm37gdhJAs05h1OXhY+PWtfBZc6QMNi4QFybtZV72y7WY+m/
 +vFXAS6jKj7TalnLBpKfaKp00+woeTAU91Swtfw8K1RRoffW+l0NJjVMW2BqcqzY
 Qjnk1EtZqTO9nxnGA9/WxfTYNqqFVQoRyEuHcnDyXKyYp7jYAGT+1G3MRp4BSjAn
 k7t8+sPUeFYkcVFGBFxjs8gnkOsB8iPEFpo4onrsE1rHk1/W9tXE9JQmrzeo+LRQ
 ==
X-ME-Sender: <xms:wS7FXgtQwWG-EnLbCFzv8DHbxEs6wNcPAN4jtKyVS4ghHBZU3P8fHQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddtledgiedvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofggtghogfesthekre
 dtredtjeenucfhrhhomhepofgrrhgvkhcuofgrrhgtiiihkhhofihskhhiqdfikphrvggt
 khhiuceomhgrrhhmrghrvghksehinhhvihhsihgslhgvthhhihhnghhslhgrsgdrtghomh
 eqnecuggftrfgrthhtvghrnhepveektdfgtddutdetffehheejhfduhfelhefhfffgjefg
 feefvddugeeghfelgfdtnecuffhomhgrihhnpehgnhhurdhorhhgnecukfhppeeluddrie
 ehrdefgedrfeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
 rhhomhepmhgrrhhmrghrvghksehinhhvihhsihgslhgvthhhihhnghhslhgrsgdrtghomh
X-ME-Proxy: <xmx:wS7FXtcSU-ke-TZVNd4KFlxxKquDjpUfUv1a9Bfyd4r-BrSXSEvj4w>
 <xmx:wS7FXryH4MKiJpv4GiQh0cGTv5VTZIO9W3ZVZlmErTk7BAwQnsPWzA>
 <xmx:wS7FXjMfwCGt_O7OcguaMXKWm54FTTsgntCXlXy3rjrgwOE4WViElg>
 <xmx:wS7FXieqRqbEU_wNvoAO7KXXB75TwenfCrRU5rM5wli9mvjoPTPzEw>
Received: from localhost.localdomain (ip5b412221.dynamic.kabel-deutschland.de
 [91.65.34.33])
 by mail.messagingengine.com (Postfix) with ESMTPA id D6ED8306644A;
 Wed, 20 May 2020 09:21:04 -0400 (EDT)
From: =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] crypto: add "none" random provider
Date: Wed, 20 May 2020 15:20:23 +0200
Message-Id: <20200520132022.6913-1-marmarek@invisiblethingslab.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Invisible Things Lab
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=66.111.4.25;
 envelope-from=marmarek@invisiblethingslab.com;
 helo=out1-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 03:21:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In case of not using random-number needing feature, it makes sense to
skip RNG init too. This is especially helpful when QEMU is sandboxed in
Stubdomain under Xen, where there is very little entropy so initial
getrandom() call delays the startup several seconds. In that setup, no
random bytes are needed at all.

Signed-off-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
---
 configure            | 11 +++++++++++
 crypto/Makefile.objs |  3 ++-
 crypto/random-none.c | 38 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 51 insertions(+), 1 deletion(-)
 create mode 100644 crypto/random-none.c

diff --git a/configure b/configure
index 26084fc53a..79a3affe70 100755
--- a/configure
+++ b/configure
@@ -509,6 +509,7 @@ libpmem=""
 default_devices="yes"
 plugins="no"
 fuzzing="no"
+rng_none="no"
 
 supported_cpu="no"
 supported_os="no"
@@ -1601,6 +1602,10 @@ for opt do
   ;;
   --gdb=*) gdb_bin="$optarg"
   ;;
+  --enable-rng-none) rng_none=yes
+  ;;
+  --disable-rng-none) rng_none=no
+  ;;
   *)
       echo "ERROR: unknown option $opt"
       echo "Try '$0 --help' for more information"
@@ -1894,6 +1899,7 @@ disabled with --disable-FEATURE, default is enabled if available:
   debug-mutex     mutex debugging support
   libpmem         libpmem support
   xkbcommon       xkbcommon support
+  rng-none        dummy RNG, avoid using /dev/(u)random and getrandom()
 
 NOTE: The object files are built at the place where configure is launched
 EOF
@@ -6733,6 +6739,7 @@ echo "default devices   $default_devices"
 echo "plugin support    $plugins"
 echo "fuzzing support   $fuzzing"
 echo "gdb               $gdb_bin"
+echo "rng-none          $rng_none"
 
 if test "$supported_cpu" = "no"; then
     echo
@@ -7705,6 +7712,10 @@ if test "$edk2_blobs" = "yes" ; then
   echo "DECOMPRESS_EDK2_BLOBS=y" >> $config_host_mak
 fi
 
+if test "$rng_none" = "yes"; then
+  echo "CONFIG_RNG_NONE=y" >> $config_host_mak
+fi
+
 # use included Linux headers
 if test "$linux" = "yes" ; then
   mkdir -p linux-headers
diff --git a/crypto/Makefile.objs b/crypto/Makefile.objs
index c2a371b0b4..cdee92b4e5 100644
--- a/crypto/Makefile.objs
+++ b/crypto/Makefile.objs
@@ -35,5 +35,6 @@ crypto-obj-y += block-luks.o
 
 util-obj-$(CONFIG_GCRYPT) += random-gcrypt.o
 util-obj-$(if $(CONFIG_GCRYPT),n,$(CONFIG_GNUTLS)) += random-gnutls.o
-util-obj-$(if $(CONFIG_GCRYPT),n,$(if $(CONFIG_GNUTLS),n,y)) += random-platform.o
+util-obj-$(if $(CONFIG_GCRYPT),n,$(if $(CONFIG_GNUTLS),n,$(CONFIG_RNG_NONE))) += random-none.o
+util-obj-$(if $(CONFIG_GCRYPT),n,$(if $(CONFIG_GNUTLS),n,$(if $(CONFIG_RNG_NONE),n,y))) += random-platform.o
 util-obj-y += aes.o init.o
diff --git a/crypto/random-none.c b/crypto/random-none.c
new file mode 100644
index 0000000000..102f8a4dce
--- /dev/null
+++ b/crypto/random-none.c
@@ -0,0 +1,38 @@
+/*
+ * QEMU Crypto "none" random number provider
+ *
+ * Copyright (c) 2020 Marek Marczykowski-Górecki
+ *                      <marmarek@invisiblethingslab.com>
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ *
+ */
+
+#include "qemu/osdep.h"
+
+#include "crypto/random.h"
+#include "qapi/error.h"
+
+int qcrypto_random_init(Error **errp)
+{
+    return 0;
+}
+
+int qcrypto_random_bytes(void *buf,
+                         size_t buflen,
+                         Error **errp)
+{
+    error_setg(errp, "Random bytes not available with \"none\" rng");
+    return -1;
+}
-- 
2.21.1


