Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD85C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 15:55:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F8E620663
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 15:55:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F8E620663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEEYc-0002Tb-2k
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 11:55:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36908)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jEEVI-0004jg-QX
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:51:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jEEVH-0007A4-JS
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:51:40 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:58169)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jEEVC-00074I-Tg
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:51:35 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N8onQ-1jK1n00q0c-015moE; Tue, 17 Mar 2020 16:51:32 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v2 09/37] linux-user: Update TASK_UNMAPPED_BASE for aarch64
Date: Tue, 17 Mar 2020 16:50:48 +0100
Message-Id: <20200317155116.1227513-10-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200317155116.1227513-1-laurent@vivier.eu>
References: <20200317155116.1227513-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:VpaJU59AIPv4rBbxgxCk9XEvAnAIat9XyRL9WouSEjiUJMHWOA4
 3bN9wKn7H/qd5Zm+R3dJYMZ2Vk+/2HeYcLd/tqfza2tSpZePCerGW1s7Kkw6D6Oxivyofdm
 VzLT4M8zkg4G2UF9WPeqzsFQfXRFWYAUJp8RyfxHijQX4v5YS60ZW0xnhsmNjoVvTU8Ejqd
 6AWsdqkvwxdMmaKanONbw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bo2fGl5hh3E=:HGQxFXzkwAiYZqUnDAeRRO
 X2OTuYV8pSdLvK4E3SDk0aEkuRxUH/7h9krxiy42JnQtOJIb0l/Pke8plVk6zmWJcqIemHsGG
 9D2sfUSv9diOCsWcLf3Dxe8p2pF3oHqtlnvr5SvdNuwdrC7771f5rgkSvXwxnxZG7BuH0FYLG
 rmPmGu1q2M+p+EvncdAYWA8RCLSkPJfpiVQFKBfnslK+Tt+APGXZxrd4qTl+vjRCTMUe9ADvS
 BuNxrO2BQseCyEgp5jzENloaAEv+GPw3Ii4OVXn3gPfY5DNdzwyasdI9IzKDuxo0t5rB9Iwwc
 DXbrvZCeJ1sXA4FsTFHdJ7S+K1GDInyuX/IEPQFGprpa6yaHatry9qex9WYVUARzwaI+Ij3rI
 H7M9MIgaRlwKYxocXpD2tXHwPbg1b7uw8Lj8aLDamwUfSxyp2kFfJjUAWWxn8EfKJ1YIfOzWW
 1KQYLU/y0YSpUfOJEUrIP/cbJe9lpv9TfJVztBVlxll8OVet0h5ZVuUooz6WGjOFtR4h7faTU
 YS/godcOgnU0PiAbuBckyIusqqaMbCMqQcVsMKpgdQbwqpB8hYUyRSi7vU8loV5P75Xucftnw
 vV+78FvwpBPPSg4uYyGTwKudSb0dPWuRyCZnwxXZ4HJU7oHSBC75qgKdINZtbwGYvjshTVUXs
 zfht8a5WtoCw9DYznY6sEtBzTbSQc1Gzs9GRCRT/BkYT97tQo/YSoERY8hhzLGDo7uWvh+Gyi
 qBb9NeLkhI6Y5X5KuUzTyVDoDH9vlevSFVYn/9GqdVkz283E6eqIzRrcWe0o0EITkQON6qit1
 R3Rrmec0M54jHC62iCoehzI5+7XvNLP6/lPKqiSlp4XokI8icz0pnMPZKsA8U5gNgLaOJJF
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.13
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Lirong Yuan <yuanzi@google.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Lirong Yuan <yuanzi@google.com>

This change updates TASK_UNMAPPED_BASE (the base address for guest programs) for aarch64. It is needed to allow qemu to work with Thread Sanitizer (TSan), which has specific boundary definitions for memory mappings on different platforms:
https://github.com/llvm/llvm-project/blob/master/compiler-rt/lib/tsan/rtl/tsan_platform.h

Signed-off-by: Lirong Yuan <yuanzi@google.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20200313002813.3857-1-yuanzi@google.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/mmap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 8685f02e7e90..e37803379747 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -184,7 +184,11 @@ static int mmap_frag(abi_ulong real_start,
 }
 
 #if HOST_LONG_BITS == 64 && TARGET_ABI_BITS == 64
+#ifdef TARGET_AARCH64
+# define TASK_UNMAPPED_BASE  0x5500000000
+#else
 # define TASK_UNMAPPED_BASE  (1ul << 38)
+#endif
 #else
 # define TASK_UNMAPPED_BASE  0x40000000
 #endif
-- 
2.24.1


