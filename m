Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8173C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 18:22:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE0472253D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 18:22:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lqd+1yYX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE0472253D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuh7o-0005jX-Hd
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 13:22:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48312)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iueRW-0000A1-AQ
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 10:30:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iueRU-0003d5-TJ
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 10:30:50 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:36489)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iueRU-0003cA-Mu
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 10:30:48 -0500
Received: by mail-wm1-x334.google.com with SMTP id p17so2982873wma.1
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 07:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=cLl48arpAObRN4ZJE2lzt8zWf4efO8tDW8tlBWZ2Av8=;
 b=lqd+1yYXZihb2iQ9Xabrclijbd426prqbmbgMIU8Be4PAkkEEouwRwoXjjGBT7PDXf
 1o1LUun/MgyU0rYzKu/xPBZF3UkvTya/f5dPYafq77SSHoCgMbbDg62bU73GjV7kyEr6
 j9ltT5hb79QFHn2Ew5fJ66HBGy0QKSw97srhuAXlpNiy2jnjAlzto4D+0+wxyN6Nj0sQ
 qcS5houfX23ipIgWHgp6wVTGosTbwmZ+FPSPSI+EcZPQFMB6rCIT4QIZH0/CQJHzVzrK
 2v4MKF3AMMSW7LGHQEtXxaBaeRPaxVWJMFj0yfv0R5nWUN5d5+RKa+ka0W1lsR/iVVfV
 TzNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cLl48arpAObRN4ZJE2lzt8zWf4efO8tDW8tlBWZ2Av8=;
 b=m6Gt5n+J64srNBk5qWuBfNU59jSOw26u8ib3LjIxHte3GeJESSpLQtq5EtWtH8N4Py
 VMg5bYJvphhMR2Po/CxFX7lejIN2c739Jyqfuzc4ktkHkYGWd7voP0CYfCmDhxyayzaL
 +cUgEH9lauvipkbdIrhytyVRaqFHKB6kdrvgNllx2Y9Q0mvOmtC9KeIfQ38G9WE/RwEA
 ni0MpOzhab4OSPwxQfZE75qdrSXv7PMAX7xV+26r05pIG0AgPy2tBFlQZyZGulUwJ+Mf
 DGh4BF80osK7rxEFMhslHiMg4f7acKQZx0rV+jFMmS4gvztPOR+ewlEwqLgDsByRvD7n
 lOXQ==
X-Gm-Message-State: APjAAAWnNml92IeVixvG/qgPawVqQnMUP51eACYsHYMnrqlK2r5On0QG
 VpUWaa7vUJ+aPLHxwE648cTFl7SEvyGz8Q==
X-Google-Smtp-Source: APXvYqwd5lfaXPraLqgbsUGr14ZlZmPapyU4NI+czk5c8Lw/CrQI0ClScVxC0bP0PsM/1QwdqPrrxQ==
X-Received: by 2002:a7b:c7d4:: with SMTP id z20mr4685005wmk.42.1579793447382; 
 Thu, 23 Jan 2020 07:30:47 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s139sm2903592wme.35.2020.01.23.07.30.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jan 2020 07:30:46 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/20] tests/tcg/aarch64: Add pauth-3
Date: Thu, 23 Jan 2020 15:30:25 +0000
Message-Id: <20200123153041.4248-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200123153041.4248-1-peter.maydell@linaro.org>
References: <20200123153041.4248-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::334
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

This is the test vector from the QARMA paper, run through PACGA.

Suggested-by: Vincent Dehors <vincent.dehors@smile.fr>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200116230809.19078-4-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/tcg/aarch64/Makefile.softmmu-target |  5 ++-
 tests/tcg/aarch64/system/pauth-3.c        | 40 +++++++++++++++++++++++
 2 files changed, 44 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/aarch64/system/pauth-3.c

diff --git a/tests/tcg/aarch64/Makefile.softmmu-target b/tests/tcg/aarch64/Makefile.softmmu-target
index 7b4eede3f07..f6b5121f5ce 100644
--- a/tests/tcg/aarch64/Makefile.softmmu-target
+++ b/tests/tcg/aarch64/Makefile.softmmu-target
@@ -61,4 +61,7 @@ run-memory-replay: memory-replay run-memory-record
 	   	  $(QEMU_OPTS) memory, \
 	  "$< on $(TARGET_NAME)")
 
-EXTRA_TESTS+=memory-record memory-replay
+run-pauth-3: pauth-3
+pauth-3: CFLAGS += -march=armv8.3-a
+
+EXTRA_TESTS+=memory-record memory-replay pauth-3
diff --git a/tests/tcg/aarch64/system/pauth-3.c b/tests/tcg/aarch64/system/pauth-3.c
new file mode 100644
index 00000000000..42eff4d5eae
--- /dev/null
+++ b/tests/tcg/aarch64/system/pauth-3.c
@@ -0,0 +1,40 @@
+#include <inttypes.h>
+#include <minilib.h>
+
+int main()
+{
+    /*
+     * Test vector from QARMA paper (https://eprint.iacr.org/2016/444.pdf)
+     * to verify one computation of the pauth_computepac() function,
+     * which uses sbox2.
+     *
+     * Use PACGA, because it returns the most bits from ComputePAC.
+     * We still only get the most significant 32-bits of the result.
+     */
+
+    static const uint64_t d[5] = {
+        0xfb623599da6e8127ull,
+        0x477d469dec0b8762ull,
+        0x84be85ce9804e94bull,
+        0xec2802d4e0a488e9ull,
+        0xc003b93999b33765ull & 0xffffffff00000000ull
+    };
+    uint64_t r;
+
+    asm("msr apgakeyhi_el1, %[w0]\n\t"
+        "msr apgakeylo_el1, %[k0]\n\t"
+        "pacga %[r], %[P], %[T]"
+        : [r] "=r"(r)
+        : [P] "r" (d[0]),
+          [T] "r" (d[1]),
+          [w0] "r" (d[2]),
+          [k0] "r" (d[3]));
+
+    if (r == d[4]) {
+        ml_printf("OK\n");
+        return 0;
+    } else {
+        ml_printf("FAIL: %lx != %lx\n", r, d[4]);
+        return 1;
+    }
+}
-- 
2.20.1


