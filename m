Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9837C17449
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 12:05:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34F312245B
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 12:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WxoFSJlE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34F312245B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUrP8-0001tO-6G
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 07:05:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33101)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iUrJb-00055Z-PL
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 07:00:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iUrJa-0004GC-G3
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 07:00:03 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:34040)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iUrJa-0004FL-99
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 07:00:02 -0500
Received: by mail-wr1-x441.google.com with SMTP id e6so2070071wrw.1
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2019 04:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dAtTKvTGGLbgatjy9hszVeJW8BTJjLusZ3gELbhkEj4=;
 b=WxoFSJlEj2PN5haYt/fN+QdjGnMogU4uXP9+eLqNngRW8W6VKaJiD34MZPW9lWFbNy
 0hAd1JcemYlOV7G+BPHEt+aNr7WosFzhGp7kSpisaYUpdc80NVkUkxSAXGKX/BgTWurW
 ZDxlVvABf9GGjBnSNWlTKzoICPhca3e/1u1pa6/7ucvl4eUTrGy0ydy2E1PzlTo+Ng+W
 o+iRmSb/geS/VshGO5Yxo6oMtqoRyPo2Jvtglfbnie3ecdjf1xXdacCPKLYn15FYfdMj
 /MEU3cz9d3hvxTxJbJXZ9Ksd3hJhEvkgxx8RihVXe/hoLnezmPQArW+x6Qn6MvAFMFGo
 TyXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dAtTKvTGGLbgatjy9hszVeJW8BTJjLusZ3gELbhkEj4=;
 b=TrQlQKbNGvYQhtCfmOoZFun+pNb0ZBry581K08Xcj8aDJL+LKxvb37sBz6t+MLva85
 qNhVFaWjw/zb3HaJh5zpFtfy0uOCekkmWwmi6NIdY88eSLvPBSO5lvOYq9X2x2jbEOnH
 hbk/47v7cSIWZu36NR/6xlPgvhA9bZvdfXterGqTT3xoe1LAqD6KBSFxYY1M8svBAbOX
 NC8SGZrCZ9PV+HexcXc3QUbz8LgEQUVesR7i9x5zPfqBmAwYwU3LUkNJDl5hOQz4W9G9
 ffZkSApZzLKTwG+a3rtlOozbL0BJ+OfCYsVq7YVNnMWkwN6AFK17oj/Cdc7JxWTX+BHY
 8bLA==
X-Gm-Message-State: APjAAAVWeqp9hukRa5YryvavuGXML+5Wft3tT0GDxyGtzsjEWZtgdlqR
 yc/72MX5SyweRqCiPyKkadb1mrJpX24=
X-Google-Smtp-Source: APXvYqxs9LH3o+w8MIelf4F6m1mYuGQZ0xo5bEOmeQ4kBkS7cjJ6Iuk+vDApcjg7kOVETzhqqaqwIA==
X-Received: by 2002:a5d:6746:: with SMTP id l6mr2433214wrw.349.1573646400980; 
 Wed, 13 Nov 2019 04:00:00 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z4sm2181219wmf.36.2019.11.13.03.59.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2019 03:59:56 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 860281FF91;
 Wed, 13 Nov 2019 11:59:52 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 4/5] docs/devel: convert multi-thread-tcg to a .rst document
Date: Wed, 13 Nov 2019 11:59:51 +0000
Message-Id: <20191113115952.775-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113115952.775-1-alex.bennee@linaro.org>
References: <20191113115952.775-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/devel/index.rst                          |  1 +
 ...ti-thread-tcg.txt => multi-thread-tcg.rst} | 28 ++++++++++++-------
 2 files changed, 19 insertions(+), 10 deletions(-)
 rename docs/devel/{multi-thread-tcg.txt => multi-thread-tcg.rst} (96%)

diff --git a/docs/devel/index.rst b/docs/devel/index.rst
index c86a3cdff2f..3e6624ec604 100644
--- a/docs/devel/index.rst
+++ b/docs/devel/index.rst
@@ -22,4 +22,5 @@ Contents:
    decodetree
    secure-coding-practices
    tcg
+   multi-thread-tcg
    tcg-plugins
diff --git a/docs/devel/multi-thread-tcg.txt b/docs/devel/multi-thread-tcg.rst
similarity index 96%
rename from docs/devel/multi-thread-tcg.txt
rename to docs/devel/multi-thread-tcg.rst
index 782bebc28b4..4e914bacc0c 100644
--- a/docs/devel/multi-thread-tcg.txt
+++ b/docs/devel/multi-thread-tcg.rst
@@ -1,7 +1,10 @@
-Copyright (c) 2015-2016 Linaro Ltd.
+.. Copyright (c) 2015-2016 Linaro Ltd.
+.. This work is licensed under the terms of the GNU GPL, version 2 or
+.. later. See the COPYING file in the top-level directory.
 
-This work is licensed under the terms of the GNU GPL, version 2 or
-later. See the COPYING file in the top-level directory.
+==================
+Multi-threaded TCG
+==================
 
 Introduction
 ============
@@ -40,7 +43,7 @@ Main Run Loop
 Even when there is no code being generated there are a number of
 structures associated with the hot-path through the main run-loop.
 These are associated with looking up the next translation block to
-execute. These include:
+execute. These include::
 
     tb_jmp_cache (per-vCPU, cache of recent jumps)
     tb_ctx.htable (global hash table, phys address->tb lookup)
@@ -61,7 +64,9 @@ have their block-to-block jumps patched.
 Global TCG State
 ----------------
 
-### User-mode emulation
+User-mode emulation
+~~~~~~~~~~~~~~~~~~~
+
 We need to protect the entire code generation cycle including any post
 generation patching of the translated code. This also implies a shared
 translation buffer which contains code running on all cores. Any
@@ -78,7 +83,9 @@ patching.
 
 Code generation is serialised with mmap_lock().
 
-### !User-mode emulation
+System emulation
+~~~~~~~~~~~~~~~~
+
 Each vCPU has its own TCG context and associated TCG region, thereby
 requiring no locking.
 
@@ -125,10 +132,11 @@ linked list of all Translation Blocks in that page (see page_next).
 Both the jump patching and the page cache involve linked lists that
 the invalidated TranslationBlock needs to be removed from.
 
-DESIGN REQUIREMENT: Safely handle invalidation of TBs
-                      - safely patch/revert direct jumps
-                      - remove central PageDesc lookup entries
-                      - ensure lookup caches/hashes are safely updated
+DESIGN REQUIREMENTS:
+  - Safely handle invalidation of TBs
+     - safely patch/revert direct jumps
+     - remove central PageDesc lookup entries
+     - ensure lookup caches/hashes are safely updated
 
 (Current solution)
 
-- 
2.20.1


