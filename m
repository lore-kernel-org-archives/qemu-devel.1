Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2419AC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:49:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5AFA20674
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:49:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5AFA20674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDts4-0007Vs-3n
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 13:49:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40160)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jDsPa-0007t2-Gn
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:16:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jDsPZ-0007ix-BY
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:16:18 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:43117)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jDsPZ-0007Xk-1G
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:16:17 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Ml3ym-1jaoAU0Poi-00lUG3; Mon, 16 Mar 2020 17:16:14 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 09/38] linux-user: Update TASK_UNMAPPED_BASE for aarch64
Date: Mon, 16 Mar 2020 17:15:21 +0100
Message-Id: <20200316161550.336150-10-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200316161550.336150-1-laurent@vivier.eu>
References: <20200316161550.336150-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:62h07PR3cHypYnxBYpK5aT+zdVUE4EF9wifkD4Mxjm7YHgdCYZs
 NQBNRKCAVkLfP56aey1qO6ZLhZ39OVgYFSxS1GsD+01vEvNEvw7UeOxU4fM361eku0JJedN
 XfruNhX9MURur9NVRnq+vCL54Z0ViJyZ0u54C2Mo3M3Z+LXA+tD4fYPSal2bjsLR7UiDJvP
 iajVkdLhgu6bVMmXdsPvQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1PvXK7PRVVY=:BgNMMkUc7HHRi1HMk0KGJR
 ChFRnDXm/W5f6gPBelgUrh7/4BFRc1s/R3DddRbozjcVVbm5uah5Lj65/si2VButH3Wa5pP2q
 sRwxUsKvjOWxUwgc3ROUTnlEgN2LdaTBv+KbZ9x4NWjEehADLbuoJPxP9ldSI99tuNaSlgu8R
 WIJkAS3uMWIIM//S3jw4xUkaw+/rHPc5Hy0KDeXhIoEVJCph+QqYmtYQSECQHNlreXbhoANN8
 kPRFp4cfbOWT9h1Ex/jtOeBM+JupI6i5idSp4w8PiVD2i4u/EqWZ2W+D48iNIz6+4S2wc8X16
 dau1iXwovhKYAbjT7M8PmabbBmGvPabBgAK6vlL246h2veEJ9QqO/wkkxfKq0drBj7jDhNE1d
 pbJmRxWQFMdgWdc/Rvq7IQub+x/CiatOq0fTbQWpERfAk9bSUfA3pUFsxLHvMaJ+M8RXKE3hv
 3T1fTnX7URd6hSpkrBYHiUFjDpBfSOjizeM5X2FNYjJ/Oi7E3/S6T3JW1ldugqcCoAIwsoQ3b
 /9gdodOQ4hWhHgKzAB8ZgoWJv3ac/4yXybhbyrwPtMea8L3cvhjdw/Y+bu/yHIMtrGWpfGN9B
 alZohfUeYgr6vHQ7avHWMM6rpa02AjKFyaGDT7aVN/NoP/eN/2qJhuEPSyLNx/2K1IsluSskj
 6pIh0YZUqfTNUwZ68uIY84cLUNtqwfE9a5bFzSK++9ONYJ9nZ8NxM7NvYbcwEDolcwQEKxFeh
 KkfsIxgXhc6Bb/XBXTPvyPh2Rbi/C6TJFht1yHAGQTNBAzEnJ+MdKpPHJs9y9+MvEnANxqelg
 Wg42VMPonfZzzbvR0Dj+yNYix6ulr8UaGeeLtUCmEM5K4jp5ckGVi4LOEkfnW+d9xtbK3vW
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.133
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


