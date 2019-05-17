Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A588C04AAF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 02:47:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 064F820815
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 02:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j1y8PrQG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 064F820815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40204 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRSuQ-0003a4-8X
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 22:47:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hRSmi-0005ZD-9Q
	for qemu-devel@nongnu.org; Thu, 16 May 2019 22:39:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hRSmh-00029Z-EV
	for qemu-devel@nongnu.org; Thu, 16 May 2019 22:39:48 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:44890)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hRSmh-00028m-7N
	for qemu-devel@nongnu.org; Thu, 16 May 2019 22:39:47 -0400
Received: by mail-pg1-x542.google.com with SMTP id z16so2503362pgv.11
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 19:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=LA1zmsYxmzBAEiSSaTbYsFeqnklh9uk6Ygv0EHqOLtQ=;
	b=j1y8PrQG9icgmziWvlfkG0Hzbs7kfCM8gvSVz7sdaacnDrJye7Z9Ewf5f9mCZgthd+
	x5ywYzed9i4+nd3eYjZCwXw9csSJCbDrNf+pWfYMn9X0QiZ1DjdJLARvWwPBPFfBaa+O
	xgllAvachONSuAorQ8TD0gSh5CUKlgEirrop23dECNJzfItQhm5DApCu9Oi6aE5Fi/2n
	vErB4/PEY9SI/Me1c7hPHkAlea/9xMg6ilGshOgUxABAysF3RsQYiEPfz+oB9JgMaZtN
	mPW2L8nEL2ABo/UDEhqFdPSBbRvl/LM50eP8DfyRhDk4EOGFWeKlwOrxbNdRB1DWqRm0
	ZR/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=LA1zmsYxmzBAEiSSaTbYsFeqnklh9uk6Ygv0EHqOLtQ=;
	b=KAabcyTz7/bWTbjg8cwbhqlAaRaBfzCxxeYBkvszX9553U2xd7htkjrhTVCi/xHNPO
	lpvyyBUG8xthX3Nn6J2zY6gR8BP2w+/RNyJglZFnag+9V2QPXkCkq/twv5Pj9iYsCk1D
	uyRFEwAioJf+eyZdZe2krc9Six4xvUxhb6z/YOwUKA6WyJuT1NC8CTFgaYgLDDj2oo4A
	+4wIM/9sUVKoF+DFjd7Xe2+lCmN1V7H5HggDE+aFqc8DwIhkc9NbL4QP3KesCUWmNjtI
	qkxAy50fkdgFe6sVb09/Zdv/T85i4Y7ocSJvklwCY/ilP6TIdFKPe5kTVW2wJN5blfzV
	Ruiw==
X-Gm-Message-State: APjAAAXQP7ngqrTDuGJ6Dn7QRmMU2LHeKXOwK+HW6NaeYBRIV90sbCvp
	APKuoJ8M58xVxCHiLehYEfzcBnWC5Hw=
X-Google-Smtp-Source: APXvYqwL2KGvkvWPz+y9wUXtOT3P783hmTES/qQleOQ5Cse1WO6/ao7TrbLTuxvxnCsPA6bBZY8zpw==
X-Received: by 2002:a63:7b1e:: with SMTP id w30mr48535344pgc.406.1558060784225;
	Thu, 16 May 2019 19:39:44 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231])
	by smtp.gmail.com with ESMTPSA id w6sm6984152pge.30.2019.05.16.19.39.43
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 16 May 2019 19:39:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 16 May 2019 19:39:13 -0700
Message-Id: <20190517023924.1686-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190517023924.1686-1-richard.henderson@linaro.org>
References: <20190517023924.1686-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: [Qemu-devel] [PATCH v8 14/25] linux-user: Use
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
Cc: lvivier@redhat.com, berrange@redhat.com, armbru@redhat.com
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


