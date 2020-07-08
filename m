Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E23C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:58:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC199206DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o9t/CT+U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC199206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtJ1Q-0000ba-VN
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 18:58:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48842)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1jtIS6-0002o2-GC
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 18:22:06 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d]:35427)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1jtIS4-000184-DS
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 18:22:06 -0400
Received: by mail-pj1-x102d.google.com with SMTP id f16so185620pjt.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2020 15:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ON8TlGBWP6j9tnyoD1Ob1PnTUOjdjsUaKfXxF5xWLoo=;
 b=o9t/CT+U+9cljCb4IH9vNy+y5v11WvIzHpuCd2bHxKRWEmhhAE24mtCRxhNP3mzBHJ
 wpVkp06PaDtP/G11gEGuiSOPqlOsXYdgf9aDLcbE370EN8cYVngrvPA5KIoVzAk6rbM6
 57N5ebJTab/1U4gClojF7ylYszmlOElVdpEe8HhYzWxD1JWFgEBIimAWGPOaeNKHSfX1
 PVy3pywqfMyhgDgEKDGfQFUB1SVggtWCfZFol8F0L4m1DGr4LfFv6Leg3LZm0ax0xLCW
 rqUlw2ByYyd+YXs9+UggFenVUj08VS5yLvzqr+QvdW0bf5rFp/T/4iFGDD4eO0kMV0/j
 v7vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ON8TlGBWP6j9tnyoD1Ob1PnTUOjdjsUaKfXxF5xWLoo=;
 b=MxIGMipXL/qdpTPShcBA8Qfc1KQkPBXhDUoON9Bwf+uJLUfw5Dux/AjfsH2J4gsaBh
 qFxjbZ8V5TrR+sMi669+7e7HnqOAQ+5CN3+wNtTnofhHr5jT0NLUiFqLpegm3M+wuXrg
 HrwwyO24dWPXrQMizJgb7Bpuo1l6eFYAw7hQvwzMvsq0kWwyhhqaK6G8gl7N5CA75k2K
 cWWXeV68d0LP2WebBLKpJIU2daEB5KEGrV10pzSYSgemTY0DXU8Gw6SUiGkMffLm09Qv
 7YCASOb2feiIk404RuGFejadzzwuF26AegbXkBvwDilf3N4CNzXzTux+/VJnYmdupxWa
 lSxg==
X-Gm-Message-State: AOAM5326rOBZxQailQp6GxTDQpgf19GRmH1OWGQZYWVr2d5N2R9uRh8D
 7kEIMabSITLDd8yF64+KABabGvxg
X-Google-Smtp-Source: ABdhPJzZgEH/G3SSY3JMf7Y457JXxrY3Mfkz2vkWBnUQG5Ki9sVsbqzE5HaXLWROO72yPydd8IdhlQ==
X-Received: by 2002:a17:902:b18b:: with SMTP id
 s11mr36312702plr.152.1594246923055; 
 Wed, 08 Jul 2020 15:22:03 -0700 (PDT)
Received: from octofox.cadence.com ([2601:641:400:e00:19b7:f650:7bbe:a7fb])
 by smtp.gmail.com with ESMTPSA id t73sm693517pfc.78.2020.07.08.15.22.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2020 15:22:02 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 11/21] tests/tcg/xtensa: fix test execution on ISS
Date: Wed,  8 Jul 2020 15:20:51 -0700
Message-Id: <20200708222101.24568-12-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200708222101.24568-1-jcmvbkbc@gmail.com>
References: <20200708222101.24568-1-jcmvbkbc@gmail.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


