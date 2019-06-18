Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78626C31E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 22:35:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 427AB20873
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 22:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="aVZgzdht"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 427AB20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33916 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdMhm-0006sa-9B
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 18:35:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52937)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jimw@sifive.com>) id 1hdMgV-0006Gh-Bf
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 18:34:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jimw@sifive.com>) id 1hdMgU-0000gJ-84
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 18:34:35 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:41109)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jimw@sifive.com>) id 1hdMgU-0000et-13
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 18:34:34 -0400
Received: by mail-pf1-x443.google.com with SMTP id m30so8455842pff.8
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2019 15:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=fcuIMm/pRv25rWLYXcWeKf5ZV92kO/2tcc3fCwRJkz4=;
 b=aVZgzdhtgAynbv2JxYCzpF8hUBZaKA/CgTiV7iPDx2j1PDQyfDK+A1g1dKhdFr1ER7
 yCk/PD/tulIDPPiX9ly2fAPNyzyFi/nWpnGTMX5ppqh8cqE+j7ynEglhsjCr51lkrZ/c
 HIsX8wz5o4sKrkq7JXes0s3+Vn9afVhiMOcXce1x6qqzGFGcWbgnhl31HCYLV0ltUxTy
 FJZ1+F4PYIYpndB+azNw3D6duHWiRWvoUCg9TwBritWmEpCWWEDxvRzFp9wBx84JqXZa
 hZKVzhMsC5Yi8zDOUOF5/xpQtu73tA1X/fsksI6bAJjNsKOsFAPb2yCWS82/nVsj1ylh
 yexA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=fcuIMm/pRv25rWLYXcWeKf5ZV92kO/2tcc3fCwRJkz4=;
 b=pqyBDB8GMjLqQgyKEJNBEay2huwCbFUuKNc1WYD+T32Yz8wrtnRopDRsUAe6K95SEC
 Is+fW3hQ3ZAwTuC2EyO/nI+jkyGqkrb5mbkKEAHFhdE+rwBOyFUyBWCZ3/JDPbDZGPMb
 fDrewBrs0s9A21wtGZx/YQy/Fvq9wOc3VEZXVZqWw0dxke+3LBhJSUBbbyVys5pSy/Sm
 tKJ3iRp+jL0iji6XQuzwUmtW3xu9QbbNOoJ4UlrPdaseVaMH+/SuVfG7roCugPuJuLcy
 oHJ3M4ly89jGQG5Mlzm4AaLJiYFiYfIIATTUavnvqELOgKbLw42aSdYCaB3W5habgCEa
 YM6A==
X-Gm-Message-State: APjAAAXUVl0yPHAgNov70hROsfjtbi42LCzmcB8WCm042/dIVStvwqAf
 f68/MCrKMLY0tJx2r5iN6B8zNDnlAA20mw==
X-Google-Smtp-Source: APXvYqxdlv7UU53fjh7nlbQvinyDoGklRnGodewgP12ObGVS+hRklSUB8neiCFabqSgF1TTjQZW9/g==
X-Received: by 2002:a17:90a:a116:: with SMTP id
 s22mr7589570pjp.47.1560897272493; 
 Tue, 18 Jun 2019 15:34:32 -0700 (PDT)
Received: from rohan.sifive.com ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id f5sm15389155pfn.161.2019.06.18.15.34.31
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 18 Jun 2019 15:34:32 -0700 (PDT)
From: Jim Wilson <jimw@sifive.com>
To: qemu-devel@nongnu.org
Date: Tue, 18 Jun 2019 15:32:52 -0700
Message-Id: <20190618223252.10907-1-jimw@sifive.com>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH] RISC-V: Update syscall list for 32-bit support.
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
 Jim Wilson <jimw@sifive.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

32-bit RISC-V uses _llseek instead of lseek as syscall number 62.
Update syscall list from open-embedded build, primarily because
32-bit RISC-V requires statx support.

Tested with cross gcc testsuite runs for rv32 and rv64, with the
pending statx patch also applied.

Signed-off-by: Jim Wilson <jimw@sifive.com>
---
 linux-user/riscv/syscall_nr.h | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/linux-user/riscv/syscall_nr.h b/linux-user/riscv/syscall_nr.h
index dab6509..5c87282 100644
--- a/linux-user/riscv/syscall_nr.h
+++ b/linux-user/riscv/syscall_nr.h
@@ -72,7 +72,11 @@
 #define TARGET_NR_pipe2 59
 #define TARGET_NR_quotactl 60
 #define TARGET_NR_getdents64 61
+#ifdef TARGET_RISCV32
+#define TARGET_NR__llseek 62
+#else
 #define TARGET_NR_lseek 62
+#endif
 #define TARGET_NR_read 63
 #define TARGET_NR_write 64
 #define TARGET_NR_readv 65
@@ -286,7 +290,16 @@
 #define TARGET_NR_membarrier 283
 #define TARGET_NR_mlock2 284
 #define TARGET_NR_copy_file_range 285
+#define TARGET_NR_preadv2 286
+#define TARGET_NR_pwritev2 287
+#define TARGET_NR_pkey_mprotect 288
+#define TARGET_NR_pkey_alloc 289
+#define TARGET_NR_pkey_free 290
+#define TARGET_NR_statx 291
+#define TARGET_NR_io_pgetevents 292
+#define TARGET_NR_rseq 293
+#define TARGET_NR_kexec_file_load 294
 
-#define TARGET_NR_syscalls (TARGET_NR_copy_file_range + 1)
+#define TARGET_NR_syscalls (TARGET_NR_kexec_file_load + 1)
 
 #endif
-- 
2.7.4


