Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0842CC04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 19:28:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5D622168B
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 19:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qXAl+exE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5D622168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53068 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQd6f-000475-VG
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 15:28:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQcvL-0002Yo-1y
	for qemu-devel@nongnu.org; Tue, 14 May 2019 15:17:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQcvJ-0006vB-UF
	for qemu-devel@nongnu.org; Tue, 14 May 2019 15:17:15 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:40108)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hQcvJ-0006ua-Ol
	for qemu-devel@nongnu.org; Tue, 14 May 2019 15:17:13 -0400
Received: by mail-pf1-x443.google.com with SMTP id u17so444pfn.7
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 12:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=LA1zmsYxmzBAEiSSaTbYsFeqnklh9uk6Ygv0EHqOLtQ=;
	b=qXAl+exEkgjEqmClYfwO7vrFkayBfeQkBVu+IovbupV24zdHx8PFEg1hT2Eq5cGx2M
	sUcF4i1VsdHpd2MzpdaspluHu7CUuetHJXEiMafVf+Vr0qMcBT6aogQNhLqgpHSnKZab
	VG0F3d08mvQD+GhvQDyZ6rlMt9KQLCYrc+eDTGecT5badY3bA7ys0ksH+dxn/BOdTt0f
	nbb9yWAfSTIzcWJCwZC5o6MTkt4dbYCj2C/iFZqXp9JJugPvq9bgeeYoJxTKokDscs9O
	Q7YoSEn7UXpbVpaTpT9DY0WcUXrdUTAddAtNQkVRaVtcoVT3UWngoWeNb4FR+JCR//i3
	QpcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=LA1zmsYxmzBAEiSSaTbYsFeqnklh9uk6Ygv0EHqOLtQ=;
	b=fw3UgFgw7W41UIa+c31Ms73RmZJN9j36pKcao10SgI2az9jxJhSA72XD847aM3ba6R
	ZT7a2MlrEzpuk9s7MTfBXZmLTPGMCwao2Rg8aOY/AO0XNzMmofhc4J96CglIY2H/G/wg
	qkNsp746aK7iYdqcE2cGUB6yGLyyqhjPg7pwOAdkY7r8yVovytv5y0QrrxaROKEd+q8K
	kuTSA2uVrPiiifSomVt6wUORGDWRHUpN3PAY4FlyCfKokeD2OqEoOFzp7g4LmbwSMntJ
	mcKWIsLsnQkeXSvBaNFhfWD8o/bR9qETGv4vfcOSEQ2xeQ9QHomQzF0aHdts4aopajSS
	KenQ==
X-Gm-Message-State: APjAAAUCx4hqNBfKYO+Ge+zJeBo5JABHJVhyKQ+uAc1rghQwS1BQPdo+
	VyCleKXCn5CwP6F2f8BBotEiyhKH3uo=
X-Google-Smtp-Source: APXvYqzurqDusysKDy2Ao0TcQgYL6U2dBD9hdM6n4KHp7mqiJRzt9/egpB4vAnSeqFtmDHe+vv/j/g==
X-Received: by 2002:a62:3605:: with SMTP id d5mr21638851pfa.28.1557861432600; 
	Tue, 14 May 2019 12:17:12 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	o6sm18682982pfa.88.2019.05.14.12.17.11
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 14 May 2019 12:17:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 14 May 2019 12:16:42 -0700
Message-Id: <20190514191653.31488-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190514191653.31488-1-richard.henderson@linaro.org>
References: <20190514191653.31488-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH v7 13/24] linux-user: Use
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


