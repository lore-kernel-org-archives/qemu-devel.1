Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D56E2C49ED9
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 16:51:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD1252082C
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 16:51:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD1252082C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7jME-0003pB-II
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 12:51:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53355)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1i7j81-0004n1-TX
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 12:36:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1i7j80-0002FG-PM
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 12:36:29 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:58527)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1i7j80-0002Da-FC
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 12:36:28 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MS43X-1higAc3LD9-00TQZi; Tue, 10 Sep 2019 18:36:18 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Tue, 10 Sep 2019 18:35:57 +0200
Message-Id: <20190910163600.19971-13-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190910163600.19971-1-laurent@vivier.eu>
References: <20190910163600.19971-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:8P4zXj3D1FoRmVr4ARkgUOLDysmxAr2oo5mxX/cqvbMQ72UFX1E
 WTpPieRqowiT+XKtRZZwwhWN9BHVc9F4S+WiIOBeluOQ+Mr+DcoFQQu4a6yFb9xuR4+SEv9
 kJyXJ6tld/NoVu2ZSD1BM29r8ZxaEG3jairY1CkNQbgIEDixVRPP7ctGBrD3HxeNvdnIWNf
 jYyLi3/05ymrP/p9Lqx1g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PTOslLJNI5M=:UfFzEj1m6etqI0qeTQa/Q6
 DWf9Bpzbkt9WaPRu2BH9CZ7IMrJC1fOtMJ0+XqwwajGG5Msi3Pnxu6WdWn4tZbO3wfi45Xzn4
 DCEm8OP+14NoxuMJ4AxeK3yRq2sV9pJEgVuJ2/yVQvGxTaH8p5wBy63ZnI2OTIb23CqD7dOzn
 3qNyjMDt80JqH449cRsW//fFA7uwUZva6P/KAtdvGsLpLItbomBqSc8Q7n0XItLJqNhfxcpJA
 cUFCBsDp3aX/VX4GMCZW2m+w3VjuKVmUNRRvYXNP1mtA7MwcnlRByltSl34hTGhXIPEnOOsHS
 1QKcUVWp5QBWbIH3ZmtjTOJqq7exz81yPb0SrqJcnq3Vc2yGsz1p5jeStyAHOXkF0ZfvcNmTN
 +u9PLmioGTYmz3titc5L6sALjBO9utYUL8gCDdH2Yj84XRFN4XDrBLaeY94fXnizU4iIWeEf8
 SUKRrrKfYkBWmzfeLlgJyrV6ClNyX3HqszoRI5+n30sxCJmzCfJOLnDhhhO7LATbeU+VBoUJD
 xxFnykRixHvT5lT1ke70HjrW+cprsRo4U1HZhQVGQn129taLQl+HtCJtmhZ46aj0XZzc2as+L
 lKbrpBBrxLhklFv305PMXYW7hqC+QyfdezeIAFspCyX33YvDD8hbgrnW4o6Knjr5+39EU8uBb
 02OjILrPC+Q4YKxHumy92o6f6sATnZo8Ofj+sWxJkitrAMMJ/mxetZdjB6C/7+ItjCMpIybzz
 6iXIOWAKon4iefS94C82/PwhikLd1/7HRV6yVTfurlnlaLIRCz4EuSxjCeKgeHcvrihWVkZR1
 q5R/4vj1rCUKwxGN9+epUa7+WZxtWjQ/abQp62o9GP6rJXf7yw=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.130
Subject: [Qemu-devel] [PULL 12/15] linux-user: Add support for FIOGETOWN and
 FIOSETOWN ioctls
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
Cc: Max Filippov <jcmvbkbc@gmail.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>,
 Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

FIOGETOWN and FIOSETOWN ioctls have platform-specific definitions,
hence non-standard definition in QEMU too.

Other than that, they both have a single integer argument, and their
functionality is emulated in a straightforward way.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <1567601968-26946-4-git-send-email-aleksandar.markovic@rt-rk.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/ioctls.h       | 2 ++
 linux-user/syscall_defs.h | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index cd9b6f9a8d45..1830de96e12b 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -177,6 +177,8 @@
 #endif
 #endif /* CONFIG_USBFS */
 
+  IOCTL(FIOGETOWN, IOC_R, MK_PTR(TYPE_INT))
+  IOCTL(FIOSETOWN, IOC_W, MK_PTR(TYPE_INT))
   IOCTL(SIOCATMARK, IOC_R, MK_PTR(TYPE_INT))
   IOCTL(SIOCGIFNAME, IOC_RW, MK_PTR(MK_STRUCT(STRUCT_int_ifreq)))
   IOCTL(SIOCGIFFLAGS, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_short_ifreq)))
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 19a1d39cbc82..498223b77787 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -758,10 +758,14 @@ struct target_pollfd {
 
 #if defined(TARGET_ALPHA) || defined(TARGET_MIPS) || defined(TARGET_SH4) ||    \
        defined(TARGET_XTENSA)
+#define TARGET_FIOGETOWN       TARGET_IOR('f', 123, int)
+#define TARGET_FIOSETOWN       TARGET_IOW('f', 124, int)
 #define TARGET_SIOCATMARK      TARGET_IOR('s', 7, int)
 #define TARGET_SIOCSPGRP       TARGET_IOW('s', 8, pid_t)
 #define TARGET_SIOCGPGRP       TARGET_IOR('s', 9, pid_t)
 #else
+#define TARGET_FIOGETOWN       0x8903
+#define TARGET_FIOSETOWN       0x8901
 #define TARGET_SIOCATMARK      0x8905
 #define TARGET_SIOCSPGRP       0x8902
 #define TARGET_SIOCGPGRP       0x8904
-- 
2.21.0


