Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4947C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 23:55:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E24720786
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 23:55:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mGBB5ADW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E24720786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsaxD-0006QP-Sp
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 19:55:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35404)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1jsaqC-00019A-Te
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 19:48:04 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d]:34877)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1jsaqA-0000w6-Pp
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 19:48:04 -0400
Received: by mail-pj1-x102d.google.com with SMTP id f16so7309692pjt.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2020 16:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ON8TlGBWP6j9tnyoD1Ob1PnTUOjdjsUaKfXxF5xWLoo=;
 b=mGBB5ADWjkw1K2wH++Ya1kMjmO9oW/mtQSBcKxb3Fb1lUBDOkiqN+4qdV2EEEfwSSg
 1or8AO/uz0Lrzght15bNNC/6Udn+9vBA4rFsbfkpWFoBYZAoqUKIIDvzDRzPFQJWDKWi
 VI64Py4Tvey+Ts9frcfe/3JFnV0OZqLnnAKXnYyJ9AEIyzb3B2LuK0aMPssOZCtAp4Wr
 uQA1GdFi6b27Lfg1XR1fLHvp3SZRyXazITkXvXEU7cyFJl0onyINYaKjneyVTUyb59RW
 TCNej0SBmdY0i2BZqJeWclLsvvcHrwLycQi8zS/H8S9OiYnwfyD6E+ucu9Iff6gidcmT
 3Rdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ON8TlGBWP6j9tnyoD1Ob1PnTUOjdjsUaKfXxF5xWLoo=;
 b=AxOWzZL/RBwKEJ9wsHS3hHOYu7jIkkTd42em2wMYQ5eyN7Y+YDLOi4vQ4NCm8mJe7W
 CRViIiTyJIPN3ZkTFM5PLEqz6dMy8m29VWjqKG5ujisnDPzuc0rvWm1Oe/jaoKi5Cu9R
 bX99wD9ditfgj/eAYUhMAOX19jnxFTHjHz+XxF+VmEh83cJhLz1EcX4aaoMt7TgDjEHM
 7oF3ZYBnir0tXC+a374Eme7LwSlsEf/MWT7TFuKFyq/AgDmKYsWjBkaGnv8+u4te2jg8
 oeL06Bbxhn03lfPbPLAlE4f3byBpyTpWEqehDnqHYEGNgKg2curMWU8SSCJIV9u/c62I
 cCnw==
X-Gm-Message-State: AOAM530DKf6RI6EWBvINx38V+hDUFSI52EnEVsoLFHfchKluNVFoEZMA
 zHd+W3n7DAElAAJMtdx2HiCmUt9Y
X-Google-Smtp-Source: ABdhPJyYoIBJaMcxfQ+mXAWmbtd1k2e+oH6ovoluwJqZRotaCH8DZR3TUkFUBDdjr4mzciNpq1Y/hQ==
X-Received: by 2002:a17:90a:240a:: with SMTP id
 h10mr1532565pje.225.1594079281418; 
 Mon, 06 Jul 2020 16:48:01 -0700 (PDT)
Received: from octofox.cadence.com ([2601:641:400:e00:19b7:f650:7bbe:a7fb])
 by smtp.gmail.com with ESMTPSA id e15sm19647649pgt.17.2020.07.06.16.48.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2020 16:48:00 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 11/21] tests/tcg/xtensa: fix test execution on ISS
Date: Mon,  6 Jul 2020 16:47:27 -0700
Message-Id: <20200706234737.32378-12-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200706234737.32378-1-jcmvbkbc@gmail.com>
References: <20200706234737.32378-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pj1-x102d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Max Filippov <jcmvbkbc@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Space for test results may be allocated in IRAM which is only
word-accessible. Use full 32-bit words to access test results.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 tests/tcg/xtensa/macros.inc | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tests/tcg/xtensa/macros.inc b/tests/tcg/xtensa/macros.inc
index aa8f95bce879..f88937c7bf82 100644
--- a/tests/tcg/xtensa/macros.inc
+++ b/tests/tcg/xtensa/macros.inc
@@ -3,7 +3,7 @@
 .macro test_suite name
 .data
 status: .word result
-result: .space 256
+result: .space 1024
 .text
 .global main
 .align 4
@@ -25,9 +25,9 @@ main:
     movi    a3, 0
     beqz    a2, 2f
 1:
-    l8ui    a1, a0, 0
+    l32i    a1, a0, 0
     or      a3, a3, a1
-    addi    a0, a0, 1
+    addi    a0, a0, 4
     addi    a2, a2, -1
     bnez    a2, 1b
 2:
@@ -65,7 +65,7 @@ test_\name:
     reset_ps
     movi    a2, status
     l32i    a3, a2, 0
-    addi    a3, a3, 1
+    addi    a3, a3, 4
     s32i    a3, a2, 0
 .endm
 
@@ -78,7 +78,7 @@ test_\name:
     movi    a2, status
     l32i    a2, a2, 0
     movi    a3, 1
-    s8i     a3, a2, 0
+    s32i    a3, a2, 0
 #ifdef DEBUG
     print   failed
 #endif
-- 
2.20.1


