Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7794C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 16:03:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F9AF2082F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 16:03:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F9AF2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiLFN-00011e-Jg
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 12:03:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59660)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hiKS3-0002aB-2n
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:12:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hiKRz-0004Ez-7q
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:12:10 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:35063)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hiKRv-0004AO-EW
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:12:05 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N3sRi-1ihxOo27SC-00zqfT; Tue, 02 Jul 2019 17:05:58 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Tue,  2 Jul 2019 17:05:42 +0200
Message-Id: <20190702150545.1872-4-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190702150545.1872-1-laurent@vivier.eu>
References: <20190702150545.1872-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Qh3lIEilbINRqqWJ8tE+vEEDPyShIUvBAe/hhcAzW3e4k3kKbCj
 87phJebBmGvTWyozClUTP2zqQaHDnpVKn2eyWO8wF+u7KumW50MfnF7k8jjKOFzyX4frgJQ
 0EFeh2IHk+fWfjiTk4sBpI4smwgEU3PFvPEZqEgnBXkAbZjlp9PNZsmu+5ilVYrpM3Gh7dd
 RgzMjDcNxSC/PFl3n5UVw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zRoAzvmd5YQ=:S62X/HLjgnVFoPwdjUNBdI
 mV+0VGWRdbDkvdCNCtGa9CrSpPM31l8rP7napusIZaM23O0oW1Hlsmgbo775kMKRfTQHd/cu6
 ea9YYXe2PntWcYJhHduJi3PFqh0HzPirEBH1Urh5MwwE8/4xP6LlXOUS8khlBn2kvn5rfs2c9
 jCYLblGRzZi4t3KBYTrSQchJhD1ImeKQk7xox4ujWhs8NS24lJhCcZxXfu5mCRFD49SNPXH91
 FJUL7FO+cf0SmgTOg9RuNjAH1Uok9L4WZzlNJchaq7tHykGpAg7DC7lD2d3r0xMG4tmJcUyS4
 IEM/GLeaMcmsR5IpAnKZFzV2Supen0sYCzxbdZQZghLzW9BOM/7MTKIuVUu2ayYhoP2bbIqI2
 C8qjBJVhDAlqEHyKp+M11y44JrQ60M6Tycv78waoHn9KcWQKp5+RRXPkYGLBAG7dKTniUggXG
 E6kLP2uUKYBTSo04MflRnMI72fq4CsjqdkSCs6sOW01YR5gAkcruojMOYKSc9nNTxRoq9wxNN
 WvV/YCmG9MailWkC+0NYlys9nIh+T46hNvXeu86/Xr3JqgMg/r3TDgSdw37ZaJK8J7hRSwMyB
 pAGoXW/N7zbRQBp7FA8BANkqLmxGNtCmTn3FtFCfOy8K26trxUD6dh8/l77b2SlXDonFLQtj/
 iSttciOxzUrXeMwK86SXi+Lvkad2NdzgH2I7VnbZA8ouimPnLo71nHAO6Rc9fE1iuo/VFbyFJ
 0eLn0xbxdYnTg7wLTT1NOVZSBPPnqEFWOXa+Jw==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.24
Subject: [Qemu-devel] [PULL 3/6] linux-user: Fix target_flock structure for
 MIPS O64 ABI
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
Cc: Dragan Mladjenovic <dmladjenovic@wavecomp.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Among MIPS ABIs, only MIPS O32 and N32 have special (different
than other architectures) definition of structure flock in kernel.

Bring target_flock definition in QEMU for MIPS O64 ABI to the
correct state, which is currently different than the most common
definition, and it should actually be the same.

Reported-by: Dragan Mladjenovic <dmladjenovic@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <1561718618-20218-4-git-send-email-aleksandar.markovic@rt-rk.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/generic/fcntl.h     | 2 +-
 linux-user/mips/target_fcntl.h | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/linux-user/generic/fcntl.h b/linux-user/generic/fcntl.h
index a775a491e9e0..1b48ddeb99fe 100644
--- a/linux-user/generic/fcntl.h
+++ b/linux-user/generic/fcntl.h
@@ -129,7 +129,7 @@ struct target_flock {
     short l_whence;
     abi_long l_start;
     abi_long l_len;
-#if defined(TARGET_MIPS)
+#if defined(TARGET_MIPS) && (TARGET_ABI_BITS == 32)
     abi_long l_sysid;
 #endif
     int l_pid;
diff --git a/linux-user/mips/target_fcntl.h b/linux-user/mips/target_fcntl.h
index 000527cc955e..795bba754b5a 100644
--- a/linux-user/mips/target_fcntl.h
+++ b/linux-user/mips/target_fcntl.h
@@ -27,7 +27,11 @@
 #define TARGET_F_SETOWN        24       /*  for sockets. */
 #define TARGET_F_GETOWN        23       /*  for sockets. */
 
+#if (TARGET_ABI_BITS == 32)
 #define TARGET_ARCH_FLOCK_PAD abi_long pad[4];
+#else
+#define TARGET_ARCH_FLOCK_PAD
+#endif
 #define TARGET_ARCH_FLOCK64_PAD
 
 #define TARGET_F_GETLK64       33      /*  using 'struct flock64' */
-- 
2.21.0


