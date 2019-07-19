Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B48D7C76188
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 08:06:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 839D620665
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 08:06:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 839D620665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoNus-0005av-Pz
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 04:06:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44539)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hoNui-0005C2-L1
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 04:06:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hoNuh-0004Vw-I7
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 04:06:48 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:57363)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hoNuh-0004UU-8v
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 04:06:47 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M2gt5-1hrxLC3wgJ-004CiN; Fri, 19 Jul 2019 10:06:18 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Fri, 19 Jul 2019 10:06:09 +0200
Message-Id: <20190719080610.1607-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190719080610.1607-1-laurent@vivier.eu>
References: <20190719080610.1607-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:3vZTmkp2CIU/uLb9dj5H0NYmh6QWxpKuuZCCkAw/sEStKXXk1RQ
 wojVnpv63+pcyzFgvI/reAUcF8xlKbpgfVBI74hCJYKG0RokUBeJ5HQg4Dl+ZPxg2xJRTC1
 zDItbQQiWgTTNLxwn9UBa0MX7wMhtPXn0llHaoR0BTFZOQBsj38fmuDj8IlaPobeqrRWQ8T
 Zdx9M59D9FY7I78UDV+3Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:90PKw+tmUqM=:oNjPxE2Kx1sPLSjFtj5TL4
 NaMnlUjQrEHn5JhD3FPDwrDbiXd9SNmmktBvy7clYJ9YLKde90Jh5jYtOv/CxqaZ3R231miG/
 D/B6NzU/MiOKg1hs6GDYXhM2lR7uyZtnnCFi70lRsS6v/IH/VCT5vR20YiiGytNqZfKQHg4xs
 sal/Fk0iJ7rz0IVD9KhdW5AsmqTIFvR+uRFnHnTO9UgOdZrDfbhbAO7jBXWWaCqDSXMAjOZjN
 E05H0FQl6VJknOL0Ytdx3Rr1u/welGKo+xamMDZf1FpbpL1kz6c+QmNZykTHhIyfGPBDneJlH
 XijY9tVJoYTI8JxMT1rubMa4kMYf+1WrYYiUui8cXfN7SXO1M71oiTMVVePWHFAZt0MDpeyR0
 Rxt7vRo/SG1W1w9uNP5CFVfbV2cnFM0IZO1zIougHyIbrYHVOPJaPNYD/PbzYx0/1qPW4M4/R
 S7fGtRxl7QZxdLF06Nf+bc9JLwI7+Lv0mtPpcUQm1Ntuc0/V0WgMWnkCVELnu8EkkNCQ5HoMt
 ioIH5LKZogAy8BC3nTDefaHpqQUqiJlZ7xoB5/NQgVXUx/Pjtqc/VEnaaMphSkXKGRd5ldytm
 QBn2oxKVlwQdMlVeqbA9izPrgHvQZDAV5s+M+8x/1DMkjaxso8IAnZjhn2/8AwFFfmQY0OFMs
 89ULtCBtatzrOUY07JycAaWKUeBKCGCAl3uGXULIqkAsuP8aaeDYZXO/JGFGKvKP1tkipDSU2
 UasXO6fQanJNbxWnpLJafJ56qArdFz0ltNx3Hjp8D3Mk/x2hqWZf9LAnDfM=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.187
Subject: [Qemu-devel] [PULL v2 2/3] linux-user: check valid address in
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


