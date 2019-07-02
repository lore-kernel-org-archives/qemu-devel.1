Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DEEFC06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 15:28:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8B04206A3
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 15:28:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8B04206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiKhl-0002lI-HW
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 11:28:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58275)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hiKMi-0005cs-6c
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:06:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hiKMd-000856-6H
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:06:40 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:55155)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hiKMc-00084Q-TA
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:06:35 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Mrggc-1iN79w05hs-00nhZ9; Tue, 02 Jul 2019 17:06:00 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Tue,  2 Jul 2019 17:05:43 +0200
Message-Id: <20190702150545.1872-5-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190702150545.1872-1-laurent@vivier.eu>
References: <20190702150545.1872-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:x14aztnEoJ8Aj53zH1yYn1m+xeqRcxvNs7cr2rZYVnQceKJxgqg
 ARpnvZD6xKVZdeZ/tuK6+SO2EL+9ikTX2qnLzsCF0jVj5KCLTV3zKKMyYzBnoyLET4ph/D3
 x81+Yvp1EI2oZzQ+wr5hbVb3UL+S1lg2Njmouy8GhW7OpUnzmE+JlZRGk/TFHIJuUTNxX7m
 vQA8ymEO3BjYkKi4ngqtg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VCvjpiZoLPM=:zbsC3mj2VU/PcXz/9JCYoZ
 kneTJTYddxpNNvjew+mycz6866l1ae2C767nym1Th6hSrLjViHS8MXdUvkE/NiIoFA2+fLLMu
 HFazIb+GG7O7DfUZeanWY4C0rsfmbz4PFLcg4mcmLqrm1szGnKlCt4BKhehsmn44gdSzlZ1x7
 5yxh+jMkWU/euCMRrTYFsQhGRjBK8tmmXLu12EijvDCcdim3875sgOgfwRzsTKo3kN9Bbow4H
 VoN+y7IMZRGlR8jzIO/WLWGC2rArcCivFOxew2RXJwmCBCsQ2kESGQ+Yx2RoRSL5yQ2AWsC8Q
 6sng0yt3DZcUASPc1NKsuY5MqcT1kYPE8DqPP1jn/Y0fJF/7265Y+BW9vdasLYxwWDuQwWI2W
 7vAJi6CY+sqCVv0Lnp3NHAHYVCYjVtJnKb0q21yej02cxiobuMD24XImprbGGqYr6ksEYMphi
 bebVk8gGHEjGZCdFxIzWZvRi/Y+fn3WfqPFAJl2Bz49CnpN+aqGKD7eFGubyvVan1cNyHEWGB
 w7gYpv7vOBkCWLdqMvyavxa1bH7rH+zSlT9I05TAabVtcCsynmcdwaGgqTtXprkPAkxEUGCY7
 JE3lmnqXXd42NvHqVolnBMRRmQF/ja4ravTkWNCygQm8b1zvy4T8RB8aV1pYljNeIYxK/cWCs
 EWaQBz1wnjmnkYCG9QE5binVzFjZRsyaJ2IHjP3QWacP21w0lU4GnmESB3t7M9uJQB4V34czQ
 FdJIJDFyyIW/eNwZeLvTGLAmViTyEAn145hooQ==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.13
Subject: [Qemu-devel] [PULL 4/6] linux-user: Introduce
 TARGET_HAVE_ARCH_STRUCT_FLOCK
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Bring target_flock definitions to be more in sync with the way
flock is defined in kernel.

Basically, the rules from the kernel are:

1. Majority of architectures have a common flock definition.

2. Architectures with 32-bit MIPS ABIs have a sligtly different
flock definition; those architectures are the only arcitectures
that have HAVE_ARCH_STRUCT_FLOCK defined, and that preprocessor
constant is used in the common header as a flag for including or
not including common flock definition.

3. Sparc architectures also have a sligtly different flock
definition, but the difference is only the padding at the end of
the structure. The presence of that padding is determined by
preprocessor constants __ARCH_FLOCK6_PAD and __ARCH_FLOCK64_PAD.

QEMU linux-user already implements rules 1. and 3. in a very
similar way as they are implemented in kernel. However, rule 2.
is implemented in a dissimilar way (for example, the constant
TARGET_HAVE_ARCH_STRUCT_FLOCK is missing), and this patch brings
QEMU implementation much closer to the kernel implementation.
TARGET_HAVE_ARCH_STRUCT_FLOCK64 constant is also introduced to
mimic HAVE_ARCH_STRUCT_FLOCK64 from kernel, but it is not defined
anywhere, however, this is the case with HAVE_ARCH_STRUCT_FLOCK64
in kernel as well.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <1561718618-20218-5-git-send-email-aleksandar.markovic@rt-rk.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/generic/fcntl.h     |  8 +++++---
 linux-user/mips/target_fcntl.h | 17 +++++++++++++----
 2 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/linux-user/generic/fcntl.h b/linux-user/generic/fcntl.h
index 1b48ddeb99fe..9f727d4df2c8 100644
--- a/linux-user/generic/fcntl.h
+++ b/linux-user/generic/fcntl.h
@@ -120,6 +120,7 @@ struct target_f_owner_ex {
 #define TARGET_F_SHLCK         8
 #endif
 
+#ifndef TARGET_HAVE_ARCH_STRUCT_FLOCK
 #ifndef TARGET_ARCH_FLOCK_PAD
 #define TARGET_ARCH_FLOCK_PAD
 #endif
@@ -129,13 +130,12 @@ struct target_flock {
     short l_whence;
     abi_long l_start;
     abi_long l_len;
-#if defined(TARGET_MIPS) && (TARGET_ABI_BITS == 32)
-    abi_long l_sysid;
-#endif
     int l_pid;
     TARGET_ARCH_FLOCK_PAD
 };
+#endif
 
+#ifndef TARGET_HAVE_ARCH_STRUCT_FLOCK64
 #ifndef TARGET_ARCH_FLOCK64_PAD
 #define TARGET_ARCH_FLOCK64_PAD
 #endif
@@ -149,3 +149,5 @@ struct target_flock64 {
     TARGET_ARCH_FLOCK64_PAD
 };
 #endif
+
+#endif
diff --git a/linux-user/mips/target_fcntl.h b/linux-user/mips/target_fcntl.h
index 795bba754b5a..6fc7b8a12bfc 100644
--- a/linux-user/mips/target_fcntl.h
+++ b/linux-user/mips/target_fcntl.h
@@ -28,11 +28,20 @@
 #define TARGET_F_GETOWN        23       /*  for sockets. */
 
 #if (TARGET_ABI_BITS == 32)
-#define TARGET_ARCH_FLOCK_PAD abi_long pad[4];
-#else
-#define TARGET_ARCH_FLOCK_PAD
+
+struct target_flock {
+    short l_type;
+    short l_whence;
+    abi_long l_start;
+    abi_long l_len;
+    abi_long l_sysid;
+    int l_pid;
+    abi_long pad[4];
+};
+
+#define TARGET_HAVE_ARCH_STRUCT_FLOCK
+
 #endif
-#define TARGET_ARCH_FLOCK64_PAD
 
 #define TARGET_F_GETLK64       33      /*  using 'struct flock64' */
 #define TARGET_F_SETLK64       34
-- 
2.21.0


