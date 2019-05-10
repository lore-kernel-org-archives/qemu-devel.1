Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E03C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 17:44:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7598F217D6
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 17:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FNPH219O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7598F217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47657 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP9Ze-0003vO-Gb
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 13:44:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hP9MV-0007TX-0g
	for qemu-devel@nongnu.org; Fri, 10 May 2019 13:31:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hP9MU-00067t-3x
	for qemu-devel@nongnu.org; Fri, 10 May 2019 13:31:10 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:40333)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hP9MT-00067S-Uu
	for qemu-devel@nongnu.org; Fri, 10 May 2019 13:31:10 -0400
Received: by mail-pg1-x542.google.com with SMTP id d31so3331433pgl.7
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 10:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=LA1zmsYxmzBAEiSSaTbYsFeqnklh9uk6Ygv0EHqOLtQ=;
	b=FNPH219OQ0b5NQFTLYr6qpuNP/ia06SlQEpUiIzLc3TyDA5TWvjGWa1re+Ocdw+oN3
	XY8VJIv36iFk7zFNJZ2aiLd+zCPWke+1ASbAw7piHG8/uhA4VpC5gFji2+zKfzSS6Ur2
	1QaMnFgn6lc8YtDNa8zDc71DVvQG7tzFND10aJrnlOXWkjDcNnZeCkXAs1kdIgF4mUOq
	IC5LMWKfCAlXRZbFUQnCuieTTF/9x0MU7w58Gqcju1nc3khvPQhOB1xVSPWCgdknS8u9
	ar3wyyjkfKMWG7gUdePlY6YizDJG5ijb8GC+k0S85x12F3hZYcn+o+n4RQV/CvFU16gM
	BpAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=LA1zmsYxmzBAEiSSaTbYsFeqnklh9uk6Ygv0EHqOLtQ=;
	b=Dml8TncuL3rmlDZ/Y3reJjcdsQMZoQ9mNgIDKsgSrFAc/Z5+9UM9O/PT+62VSsvUTp
	uVyu08ATkPHMc0eMC3jin5kanGNyaXvsa9R4ckYwgf7k89CABv+J0q1R+t9KgQP05UKI
	hbKbba/cMVUXMBFPmICBK1XACnnEWnd3EbdEQj51tRPWOqvbEdE3NHx+qLa96GwCD0np
	Zd9lhprHy/lZg7AYkRzfj5mTZkzbOTDy8U1j0YGqvFbRiHw8Is75qg9FG8R+Q038JdBW
	S70c67VO60acs+fpmRv4fCqdky+fvKjs3+QbDDQ5ewOKAdUZpUAg73vmn7Jik7y9cVaV
	ttXg==
X-Gm-Message-State: APjAAAVXBTEaT2PZ8QaAnNOSZqm4bwKGoCMm6V2bqhLoU0oh+zszKUt1
	b3+ndbELhIQHcS9QTFZXM2fqpRfT7qM=
X-Google-Smtp-Source: APXvYqx8W+tKSiGtcG6l4ADNgOYL0AmtTU+1zTxUj99Z44cSjyrLrvsWk7HhbaKFz3juITzsPUZKkA==
X-Received: by 2002:a63:1d05:: with SMTP id d5mr15173262pgd.157.1557509468739; 
	Fri, 10 May 2019 10:31:08 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	v64sm7936792pfv.106.2019.05.10.10.31.07 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 10 May 2019 10:31:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 10 May 2019 10:30:38 -0700
Message-Id: <20190510173049.28171-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190510173049.28171-1-richard.henderson@linaro.org>
References: <20190510173049.28171-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: [Qemu-devel] [PATCH v6 14/25] linux-user: Use
 qemu_guest_getrandom_nofail for AT_RANDOM
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use a better interface for random numbers than rand * 16.

Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index ef42e02d82..1e06b908b7 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -7,6 +7,7 @@
 #include "qemu.h"
 #include "disas/disas.h"
 #include "qemu/path.h"
+#include "qemu/guest-random.h"
 
 #ifdef _ARCH_PPC64
 #undef ARCH_DLINFO
@@ -1883,12 +1884,9 @@ static abi_ulong create_elf_tables(abi_ulong p, int argc, int envc,
     }
 
     /*
-     * Generate 16 random bytes for userspace PRNG seeding (not
-     * cryptically secure but it's not the aim of QEMU).
+     * Generate 16 random bytes for userspace PRNG seeding.
      */
-    for (i = 0; i < 16; i++) {
-        k_rand_bytes[i] = rand();
-    }
+    qemu_guest_getrandom_nofail(k_rand_bytes, sizeof(k_rand_bytes));
     if (STACK_GROWS_DOWN) {
         sp -= 16;
         u_rand_bytes = sp;
-- 
2.17.1


