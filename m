Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B7FC282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 14:57:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFEC120863
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 14:57:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFEC120863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38254 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTp9Y-0005Vv-7Z
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 10:57:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:32793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hTox1-0004Lt-TZ
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:44:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hTox0-0006Nl-K0
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:44:11 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:38043)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hTox0-0006Mw-AU
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:44:10 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA
	(Nemesis)
	id 1MNtCi-1hIsj83vdQ-00OGcG; Thu, 23 May 2019 16:43:43 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Thu, 23 May 2019 16:43:29 +0200
Message-Id: <20190523144336.13960-4-laurent@vivier.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190523144336.13960-1-laurent@vivier.eu>
References: <20190523144336.13960-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:0MGJHVzNT2jKtASdGvmoFoDKkK64vgdE9rdE23Cw6YtvBUF6D5u
	W17UMI5/3ao0th2bQ3urJcuoanIc3kPtIdOs2eKC79zbO/bCUTvz9M8kz3nBNxYcfV6+6Sc
	gbjJlpesV9Il0DnH1Lb7H53dDw+sXJXjJhihMkgGr/KTpfo3Zw8kBQ8nePPnYJzZB9iJ1KG
	tk0lb072mijQOEBmtCqOA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XzmyCqWuS/E=:Fy0LPrCu8bS4W8Q058SXBR
	rc1GJdhN2D4UdH0SNRb1Yf+GiW5tqMYu03m0YYk4LL4MEH2/yzTwIwN4CyxZhwSVzg8fb2yCs
	FpMQky4VKBPpxDu9Y/W2P5cGV7NHjlx1rXuVN4Kg8YVbWyE+tDV9u34spHUQ/q48jl64lWMjr
	BgCVTtGphpm1lrTozPz7puWtbuGjsmkH1e1vJ9NZFx1CItaEeLfx7ueN1WaVyS2LRD8WAILyj
	gnpMOaW0uhYacW6uHr8UOTNya4k0aUxYg8lFHlMmJx1e+FcsLtfrBh6f/gfi4JzubVOc3KZMG
	uWBa97UL8OKbV0ujubefMEZ27PuNIRyZvGEQInIKKWqHoh0HJvqvQx05SO56yuAJQoFpbzP09
	FrFjQMZal3zBqqjOTXfNfele83QOneHayuLWBOeHCU/JuOM6H4E8/uPg67CdrjhrPHYdroisG
	NVG9IrX3OMtiiDAOJf/aPhl1Ql6XW6mTHt/KGiy1xupYQM1n9YVEcrlCYnXYTbZrUAiumVWct
	zxVibCDwT8XKvOqhmw488aECZ5lSrR3OGDu6f/um9vQL5lSek5f03geY2cJN6aslaJ23L6Kzz
	U2VmuGRnsG/eRiUoRe4u0/+XMlsuefdAcYuhzSNxbVkrchUtVVu4cNOguGMdcYODvquwlXZKl
	Mf7KILbHUiOG/6aNObvTHwfVqoMnBKQW1Vg1Haq5tDOUb1dpRgmK+1dtj53TY6Tw1GR1+dNHr
	DYBpNGWjDWNWokjnS8vFh6MzS9J4NiRBO1qL/w==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.187
Subject: [Qemu-devel] [PULL 03/10] linux-user: Fix support for SIOCATMARK
 and SIOCGPGRP ioctls for xtensa
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>, Riku Voipio <riku.voipio@iki.fi>,
	Laurent Vivier <laurent@vivier.eu>, Max Filippov <jcmvbkbc@gmail.com>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Fix support for the SIOCATMARK and SIOCGPGRP ioctls for xtensa by
correcting corresponding macro definition.

Values for TARGET_SIOCATMARK and TARGET_SIOCGPGRP are determined by
Linux kernel. Following relevant lines (obtained by grep) are from
the kernel source tree:

arch/ia64/include/uapi/asm/sockios.h:#define SIOCATMARK    0x8905
arch/mips/include/uapi/asm/sockios.h:#define SIOCATMARK    _IOR('s', 7, int)
arch/parisc/include/uapi/asm/sockios.h:#define SIOCATMARK  0x8905
arch/sh/include/uapi/asm/sockios.h:#define SIOCATMARK      _IOR('s', 7, int)
arch/xtensa/include/uapi/asm/sockios.h:#define SIOCATMARK  _IOR('s', 7, int)
arch/alpha/include/uapi/asm/sockios.h:#define SIOCATMARK   _IOR('s', 7, int)
arch/sparc/include/uapi/asm/sockios.h:#define SIOCATMARK   0x8905
include/uapi/asm-generic/sockios.h:#define SIOCATMARK	   0x8905

arch/ia64/include/uapi/asm/sockios.h:#define SIOCGPGRP     0x8904
arch/mips/include/uapi/asm/sockios.h:#define SIOCGPGRP     _IOR('s', 9, pid_t)
arch/parisc/include/uapi/asm/sockios.h:#define SIOCGPGRP   0x8904
arch/sh/include/uapi/asm/sockios.h:#define SIOCGPGRP       _IOR('s', 9, pid_t)
arch/xtensa/include/uapi/asm/sockios.h:#define SIOCGPGRP   _IOR('s', 9, pid_t)
arch/alpha/include/uapi/asm/sockios.h:#define SIOCGPGRP    _IOR('s', 9, pid_t)
arch/sparc/include/uapi/asm/sockios.h:#define SIOCGPGRP    0x8904
include/uapi/asm-generic/sockios.h:#define SIOCGPGRP       0x8904

It is visible from above that xtensa should have the same definitions
as alpha, mips and sh4 already do. This patch brings QEMU to the accurate
state wrt these two ioctls.

Acked-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <1558282527-22183-2-git-send-email-aleksandar.markovic@rt-rk.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall_defs.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 1f5b2d18dbea..5b530e04b8fd 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -737,7 +737,8 @@ struct target_pollfd {
 #define TARGET_KDSETLED        0x4B32	/* set led state [lights, not flags] */
 #define TARGET_KDSIGACCEPT     0x4B4E
 
-#if defined(TARGET_ALPHA) || defined(TARGET_MIPS) || defined(TARGET_SH4)
+#if defined(TARGET_ALPHA) || defined(TARGET_MIPS) || defined(TARGET_SH4) ||    \
+       defined(TARGET_XTENSA)
 #define TARGET_SIOCATMARK      TARGET_IOR('s', 7, int)
 #define TARGET_SIOCGPGRP       TARGET_IOR('s', 9, pid_t)
 #else
-- 
2.20.1


