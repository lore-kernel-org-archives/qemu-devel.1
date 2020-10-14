Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA70C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 13:45:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D298E22201
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 13:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pK07Lqne"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D298E22201
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSh63-0000HH-EN
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 09:45:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52212)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chetan4windows@gmail.com>)
 id 1kSh4f-00085v-Br; Wed, 14 Oct 2020 09:44:14 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:53089)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chetan4windows@gmail.com>)
 id 1kSh4Y-0007as-84; Wed, 14 Oct 2020 09:44:13 -0400
Received: by mail-pj1-x1042.google.com with SMTP id gm14so1600986pjb.2;
 Wed, 14 Oct 2020 06:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=vu7wHZwFv19Z5r2Bsk8h61e6ME+AQtqrDgFh4GsV01g=;
 b=pK07LqnetZkFfSOZa3UJ0nqhrkm5N7DmLJshTPszhjasVCKceDVGtF0EJm8hbe2BUn
 7P/yAhBN/C+V3alVvI9Re689wn2RKj941PLx0vK1wgFeZi9vzcLmdtDHczjjHLpyE0/U
 qQKYGE4Nn7uKW6xSnH2Bh2a6XbtOa4Nkh8IoDiJgj2/ILWjlopuq+omAVyr1g7m38gtn
 efrlHpOycjs6r1n72Y9NX0HaUJV6I7iJIO3+4xMsqxD9g7fizoeofPGNzcy3W3vZ1zg3
 NGXpevI5jYOfp1+mafBlGzjL08ytttQ4u00Y+ovakOW3ZadUAeyKWZuX26dUZnAAVkfy
 uRXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=vu7wHZwFv19Z5r2Bsk8h61e6ME+AQtqrDgFh4GsV01g=;
 b=WHhV2vMSXPmrvUdT5Voe17oK7csJbTugYKbFcgwQkYe/MfB9iS2Rh3YzMltpPU/be9
 MP2DiRC5BXgBY9sz5Xq8KglYFULStC71mXs+MCJ89/T2Pbrq3Ve3IOUs9kl6sPxNC8ON
 i+s3vXrLj4Rk8B9YIEAM53GC5Dr1wIPSlYRET7jh9P7og9EDZHevMxX0v6qI0BVBkK0k
 6h+fFaec+EeH7wwN/7FNu6cqhKshH/oZe4in41dt4omc1U90Cn5/sdqEg16AtUkg/oDK
 0FikT9/AjAFNPncuxoZ47XScR7dEscEudKX7+dzQosCJv1FuitASOXnvNxXuhpgVBW6Y
 g8Zg==
X-Gm-Message-State: AOAM531e3JRG9k39eIibgAm8HAXRob+ZxNKkPJ1rVAuoS1t6LMBgDyHF
 J4SStNKWa9Ktn2un9DkQXsB/JFX8GcV5QYE+
X-Google-Smtp-Source: ABdhPJwTMKy5eFQUTznR3UtzUM092BA0mPzSoJvOFoMEEwuOA4xPtUmtnuwLrdk7Xls7H8Dcxp6OeA==
X-Received: by 2002:a17:902:6ac1:b029:d3:b3bd:b66e with SMTP id
 i1-20020a1709026ac1b02900d3b3bdb66emr4355700plt.21.1602683043667; 
 Wed, 14 Oct 2020 06:44:03 -0700 (PDT)
Received: from pulp100.localdomain ([103.199.158.131])
 by smtp.gmail.com with ESMTPSA id q66sm3502331pfc.109.2020.10.14.06.44.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2020 06:44:02 -0700 (PDT)
From: Chetan Pant <chetan4windows@gmail.com>
To: qemu-trivial@nongnu.org
Subject: [PATCH 3/30] crypt: Fix Lesser GPL version number
Date: Wed, 14 Oct 2020 13:42:48 +0000
Message-Id: <20201014134248.14146-1-chetan4windows@gmail.com>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=chetan4windows@gmail.com; helo=mail-pj1-x1042.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: berrange@redhat.com, qemu-devel@nongnu.org,
 Chetan Pant <chetan4windows@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is no "version 2" of the "Lesser" General Public License.
It is either "GPL version 2.0" or "Lesser GPL version 2.1".
This patch replaces all occurrences of "Lesser GPL version 2" with
"Lesser GPL version 2.1" in comment section.

Signed-off-by: Chetan Pant <chetan4windows@gmail.com>
---
 tests/test-crypto-afsplit.c | 2 +-
 tests/test-crypto-block.c   | 2 +-
 tests/test-crypto-cipher.c  | 2 +-
 tests/test-crypto-hash.c    | 2 +-
 tests/test-crypto-ivgen.c   | 2 +-
 tests/test-crypto-secret.c  | 2 +-
 tests/test-crypto-xts.c     | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tests/test-crypto-afsplit.c b/tests/test-crypto-afsplit.c
index f9f2fcd..00a7c18 100644
--- a/tests/test-crypto-afsplit.c
+++ b/tests/test-crypto-afsplit.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/tests/test-crypto-block.c b/tests/test-crypto-block.c
index 7c1ab07..3b1f0d5 100644
--- a/tests/test-crypto-block.c
+++ b/tests/test-crypto-block.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/tests/test-crypto-cipher.c b/tests/test-crypto-cipher.c
index bebba1a..280319a 100644
--- a/tests/test-crypto-cipher.c
+++ b/tests/test-crypto-cipher.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/tests/test-crypto-hash.c b/tests/test-crypto-hash.c
index 214a9f7..ce7d0ab 100644
--- a/tests/test-crypto-hash.c
+++ b/tests/test-crypto-hash.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/tests/test-crypto-ivgen.c b/tests/test-crypto-ivgen.c
index a5ff5d3..f581e6a 100644
--- a/tests/test-crypto-ivgen.c
+++ b/tests/test-crypto-ivgen.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/tests/test-crypto-secret.c b/tests/test-crypto-secret.c
index 9d06176..34a4aec 100644
--- a/tests/test-crypto-secret.c
+++ b/tests/test-crypto-secret.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/tests/test-crypto-xts.c b/tests/test-crypto-xts.c
index 6fb61cf..7acbc95 100644
--- a/tests/test-crypto-xts.c
+++ b/tests/test-crypto-xts.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
-- 
2.17.1


