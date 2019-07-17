Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C57BC7618F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 14:55:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4445C2173E
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 14:55:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4445C2173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnlLL-00050p-Iy
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 10:55:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48126)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hnlL6-00047v-De
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 10:55:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hnlL5-0000mZ-07
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 10:55:28 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:51777)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hnlL4-0000ke-Mb
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 10:55:26 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MYvTs-1i0ykD2oVs-00UugK; Wed, 17 Jul 2019 16:54:42 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Wed, 17 Jul 2019 16:54:18 +0200
Message-Id: <20190717145418.23883-4-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190717145418.23883-1-laurent@vivier.eu>
References: <20190717145418.23883-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:A1dtiap+W9ArKGUiGFoPWfgdbKR0TaRnA8I/ucKaEI367OjylTj
 zDo5OFQF42f54vixZUFZirebTu3GW4L5IS2ZDn82alLEYv6JXpR1TDsx5+6oGx1I9fi8hkI
 ovSw2mx2fLw+wgyfv/DikXOQcY3WYV3zCespUDO0H1RY5y+zDnMUyJ38QE/XABIYsfHnTYb
 8+40zEWSLYpR22NwACLew==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0UtVY4qcQPg=:5QAURPSnC8pb4fAsNQLHnU
 MsyoR6lEnjqylK+b8fOLi4LogLQFYG/EN65E+FPVxLYGT2gfbNVz+/b1Z4Ak60zXXn7rGM7Rs
 g3FMMHwNJcFEqjoDpV1M5nnHm/TNhFqv2hkSUF20GeG4MFeZjH7X5iGtleMIkywgUUta8pm9s
 vzc8AaJoEgTH4d9XHhuVtsHxnkquKzx8apfFMp4HkFiE6JJEGoG+w4z5fIaNSJNnapU5dUQph
 O/up9f5YSlIO3Ow+bsTQX/yDwDSWt017USx9NQLYf3ma03Gwre5twgciDySGeyLwDyq1YxBwz
 M7vWJKmBm5xTtdPQF1NUbZpRBSuvp6yoBX5BLhqMVbF3XkLslN6U1SljStIYreHUCVAlyZfV1
 EAI99AMNST36Cxz7+5NHdY04V/BBb6qlhnMYdRjy1tTTjsvLRwtbZ+TCHxqNpNBLnZzw7gAmD
 ZoDyQ6Kc6NgpaZdNUs5g6lxCAqrUhBIAf/8z5+5Uo+w7RJ4hDQfHlZ6v5i2erSk5dOB+okGjN
 5/xEtMbZLwn3PB2KrKA9mtbBcfUxLjZN9EGdAOVPzmanUCatEY5G8uBAb47wsff3NR1QobMZx
 hD3jVnbcbPqcLaTtZnk9iRHuqAYDPDXbGRQQ2QDs8LFLwupE7rfUA2AbYp85biicSUOo4Ug/r
 awSrM/iV7+uDgK5A7sbJnChjCEEiuwj/E+IJ16cHcDZppSeyLPtR8/Li0rMIVV8lWRdzdoIJc
 +I8OGZlGcTBruNRIyokfHMdzPu5mIq2GJ/aUEdx+hwqnUmmZlgWnS+qBeos=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.134
Subject: [Qemu-devel] [PULL 3/3] linux-user: check valid address in
 access_ok()
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?R=C3=A9mi=20Denis-Courmont?= <remi@remlab.net>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Rémi Denis-Courmont <remi@remlab.net>

Fix a crash with LTP testsuite and aarch64:

  tst_test.c:1015: INFO: Timeout per run is 0h 05m 00s
  qemu-aarch64: .../qemu/accel/tcg/translate-all.c:2522: page_check_range: Assertion `start < ((target_ulong)1 << L1_MAP_ADDR_SPACE_BITS)' failed.
  qemu:handle_cpu_signal received signal outside vCPU context @ pc=0x60001554

page_check_range() should never be called with address outside the guest
address space. This patch adds a guest_addr_valid() check in access_ok()
to only call page_check_range() with a valid address.

Fixes: f6768aa1b4c6 ("target/arm: fix AArch64 virtual address space size")
Signed-off-by: Rémi Denis-Courmont <remi@remlab.net>
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Message-Id: <20190704084115.24713-1-lvivier@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 include/exec/cpu_ldst.h | 4 ++++
 linux-user/qemu.h       | 4 +++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index 9de8c933031b..9151fdb042c4 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -62,7 +62,11 @@ typedef uint64_t abi_ptr;
 /* All direct uses of g2h and h2g need to go away for usermode softmmu.  */
 #define g2h(x) ((void *)((unsigned long)(abi_ptr)(x) + guest_base))
 
+#if HOST_LONG_BITS <= TARGET_VIRT_ADDR_SPACE_BITS
+#define guest_addr_valid(x) (1)
+#else
 #define guest_addr_valid(x) ((x) <= GUEST_ADDR_MAX)
+#endif
 #define h2g_valid(x) guest_addr_valid((unsigned long)(x) - guest_base)
 
 static inline int guest_range_valid(unsigned long start, unsigned long len)
diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index fab287b7ec50..4258e4162d26 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -456,7 +456,9 @@ extern unsigned long guest_stack_size;
 
 static inline int access_ok(int type, abi_ulong addr, abi_ulong size)
 {
-    return page_check_range((target_ulong)addr, size,
+    return guest_addr_valid(addr) &&
+           (size == 0 || guest_addr_valid(addr + size - 1)) &&
+           page_check_range((target_ulong)addr, size,
                             (type == VERIFY_READ) ? PAGE_READ : (PAGE_READ | PAGE_WRITE)) == 0;
 }
 
-- 
2.21.0


