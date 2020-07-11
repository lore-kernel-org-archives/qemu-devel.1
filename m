Return-Path: <SRS0=vx8y=AW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC3EBC433E2
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 11:14:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B77082078B
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 11:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h9lRt6Mu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B77082078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juDSb-0007QF-1Q
	for qemu-devel@archiver.kernel.org; Sat, 11 Jul 2020 07:14:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52760)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1juDMQ-0004ho-0s
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 07:08:02 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d]:45508)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1juDMN-0006OK-NU
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 07:08:01 -0400
Received: by mail-pg1-x52d.google.com with SMTP id l63so3675252pge.12
 for <qemu-devel@nongnu.org>; Sat, 11 Jul 2020 04:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ON8TlGBWP6j9tnyoD1Ob1PnTUOjdjsUaKfXxF5xWLoo=;
 b=h9lRt6MuTJA+a4wzYaTFmU/HYOt+fNBc2v6pXBQA0DaYayjl1yozzWkbHOdeBO2SRi
 gcQib5jghLvxNRViRRmN8jry7MHSA50ArQUhXgXecUHpfMEQvJVMcTVG7ChSZOdoJTfd
 zm3baQG4UCHfyAwZErhwKYa4yR8Yr9MQji5az5QXClPd6DdhqvPNAulwBGLtF39jXbPs
 4GcEI+HOWMFK4VcG7PbNiFh25lUUAsKIGj2dupmVMT11aYXcAg3e7Eq6sGi1cziBGhV3
 nlHoMMSB+2NeDFAhTLAoPerJwXXwy9ZPkjZEojXq15v/iZNt5OYUA4j9BVNDdpkniWIJ
 MoUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ON8TlGBWP6j9tnyoD1Ob1PnTUOjdjsUaKfXxF5xWLoo=;
 b=IS8jXDIAzpptLwFQ9gIgL7cRaWHtPYWu3jsibJYmFzuNJ6Z9AzQVKVk14wtG7QYU5n
 JNMz2RZACIL9aPxXQ5XMVhdeiDGxWPhR4AKL/TNp+gBjmQyhTgakNsF0ipGiJr4Db8Pe
 c2OI/DxP3BEL89YMlSMpncrdOgoZsivBibb0NMV4jIGSce+PJe0j1BaZZ0bbqIOajBqw
 xUX0cQI53vZAtI9kABP3Yl57lee0aNWTo6WOSL0YRiTBRA78OyqSkbvaz5zoGPg35GDn
 zAgS0S8OScJUfsuEmik+e9Nfu83/DT6htr/lqJRl542frh2Pil8fHZdXjOpNye8yesii
 Eu/g==
X-Gm-Message-State: AOAM533kmz8hnfkWeolpl3M2oRUYDTqhxnucdNgvl9wql+hP5wgSA8Wk
 MbEKmWhJkiS4CJou89C4iRN+7FdY
X-Google-Smtp-Source: ABdhPJyYgksUSkNTz8Eb2FXv1FJEdMqHfMBjGX9gK3moc9+FmK21ZCiw9EtWE2ia/MLFviYfl+d8Rg==
X-Received: by 2002:a62:158d:: with SMTP id 135mr49283934pfv.287.1594465678315; 
 Sat, 11 Jul 2020 04:07:58 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net
 ([2601:641:400:e00:19b7:f650:7bbe:a7fb])
 by smtp.gmail.com with ESMTPSA id m31sm8925826pjb.52.2020.07.11.04.07.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Jul 2020 04:07:57 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 12/22] tests/tcg/xtensa: fix test execution on ISS
Date: Sat, 11 Jul 2020 04:06:47 -0700
Message-Id: <20200711110655.20287-13-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200711110655.20287-1-jcmvbkbc@gmail.com>
References: <20200711110655.20287-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pg1-x52d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: Max Filippov <jcmvbkbc@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
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


