Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54EFEC43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 12:53:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAD0F20756
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 12:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G7CuxFXC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAD0F20756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIASO-0006TC-Rb
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 08:53:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48508)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kI9rf-00023d-Ul; Tue, 15 Sep 2020 08:15:15 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:39931)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kI9re-0008M3-20; Tue, 15 Sep 2020 08:15:15 -0400
Received: by mail-pl1-x641.google.com with SMTP id x18so1242300pll.6;
 Tue, 15 Sep 2020 05:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ajxFadu+yHNyg0D+X68nZFkcXE3tK/jib0sFS+8nB4w=;
 b=G7CuxFXCpOVB4PxoOUxDiLu6ip1jXjbq/yoDF3ecQzhTwo6Ah5wh8QX+Bje5Gj8QR2
 nvizbCmtxPEcDvsW8LOkyNqQwnj95h2Ym7r8XTl83ZsuURr3HmR8pkRcp7ccIRuSJC+L
 4u//mAgXPe2jY18zr1SzEGd0aY5L1H+YFWjP21ZaarT3RAl9NUGNResw6+IsB6MLUV6T
 sxePT3Ie3jMgbth0Lis6yn1qkZb008yBBDLjR6xNRtHPU2gt6o1JpJnLH9su4HeB5dXz
 BHSm1jYpw/wnjvErXFDtzL2AGtIT21uqVpoq2CG1TIHBxpP2OOyKtz1y7pHU1OCVumy0
 0eNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ajxFadu+yHNyg0D+X68nZFkcXE3tK/jib0sFS+8nB4w=;
 b=hzCOCOx3UzcwlH/mMvV5ZhlXEExVKvciK+MmZ5dVpYo0+SThEqlY+LlWnhb0ZxD/2a
 XeDjb6YcJAlkb2dU1DDHxKiN8nFN2a2Zq4gV2dfDynRmFNLWV42+i1vbvuKylUkbIttf
 i/sbpjW6s4j6AEvAzN014xEE261qPdhHogrcgTNxtjZRm196s3f18Gc36v6L9x/o1Z0p
 7VJXS6CfEgokXNZZoy7ZJrDbT1K/t9+SqNKAqT1xBOOkNNJxRrfyt+zPvtB+z5nwC9+S
 zK/cT9uIbYwBhUq55PO8Pdis92fvadnc6P8o1KKC+v5W/wIZ35EFl258mfhbRma0ZC5Q
 mRqw==
X-Gm-Message-State: AOAM530iNVzpZ3tvqJyUHSIxgMk/G3JGWsZHUQR6FuJ+aljao55urhzb
 KiXP2X2CuPtRxdDMbKBBun3a8Xoab2p8FjfDZ9Q=
X-Google-Smtp-Source: ABdhPJw98Lc3tzKeo+lgHNoH/mfvhrIsBq5BYSDWYwDbZL1WPZlRW2AY+2irudECSKY5NYNPPsrvbQ==
X-Received: by 2002:a17:902:a512:b029:d0:92cc:a1f6 with SMTP id
 s18-20020a170902a512b02900d092cca1f6mr19579057plq.9.1600172111966; 
 Tue, 15 Sep 2020 05:15:11 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 k28sm13683061pfh.196.2020.09.15.05.15.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2020 05:15:11 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 21/26] tests: Fixes test-qdev-global-props.c
Date: Tue, 15 Sep 2020 20:13:13 +0800
Message-Id: <20200915121318.247-22-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200915121318.247-1-luoyonggang@gmail.com>
References: <20200915121318.247-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=luoyonggang@gmail.com; helo=mail-pl1-x641.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ed Maste <emaste@freebsd.org>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 qemu-block@nongnu.org, Stefan Weil <sw@weilnetz.de>,
 Xie Changlong <xiechanglong.d@gmail.com>, Peter Lieven <pl@kamp.de>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On win32 the line ending are \r\n, so we skip the \n in function test_dynamic_globalprop

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/test-qdev-global-props.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/test-qdev-global-props.c b/tests/test-qdev-global-props.c
index 8a3c14d92c..be6bcfc46b 100644
--- a/tests/test-qdev-global-props.c
+++ b/tests/test-qdev-global-props.c
@@ -251,10 +251,10 @@ static void test_dynamic_globalprop(void)
     g_test_trap_assert_passed();
     g_test_trap_assert_stderr_unmatched("*prop1*");
     g_test_trap_assert_stderr_unmatched("*prop2*");
-    g_test_trap_assert_stderr("*warning: global dynamic-prop-type-bad.prop3 has invalid class name\n*");
+    g_test_trap_assert_stderr("*warning: global dynamic-prop-type-bad.prop3 has invalid class name*");
     g_test_trap_assert_stderr_unmatched("*prop4*");
-    g_test_trap_assert_stderr("*warning: global nohotplug-type.prop5=105 not used\n*");
-    g_test_trap_assert_stderr("*warning: global nondevice-type.prop6 has invalid class name\n*");
+    g_test_trap_assert_stderr("*warning: global nohotplug-type.prop5=105 not used*");
+    g_test_trap_assert_stderr("*warning: global nondevice-type.prop6 has invalid class name*");
     g_test_trap_assert_stdout("");
 }
 
-- 
2.28.0.windows.1


