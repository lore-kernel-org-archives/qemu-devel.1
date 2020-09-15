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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E01C43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 17:34:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59D0A208E4
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 17:34:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nLrw10xa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59D0A208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIEqE-00011S-Aw
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 13:34:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44460)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kIEXL-0000V1-LM; Tue, 15 Sep 2020 13:14:35 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:38982)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kIEXG-0002ox-25; Tue, 15 Sep 2020 13:14:35 -0400
Received: by mail-pj1-x1043.google.com with SMTP id v14so118041pjd.4;
 Tue, 15 Sep 2020 10:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ISfeCpjoQz41XYkDVzSwja5AQEtv40E6VBUlsI12dS8=;
 b=nLrw10xaWy9aDQN10gIc5soSu5ktnEn4bsfPQ4qCecFA3RpXGhS0TOJOwzMtmf3+HS
 UOgB7ukxVCSqyXtSLjbK0lSVWcRodequVDq5rVG+nRHMQv+D02sAsMYA1aZNTYgXk2TG
 KLTs67FpWQo595nktD8xmjqGOM4l4u1YzAqEthWmqopoxF41U5aSTdujIitEoF8sIhbG
 XH8JgD+z5+i90FDwA2uidoVJbdIsoN8CH3KrOY07wksLMt3nTduLrGUztjuJ7q/q4Joi
 jFf6GKwqgCHABuT8B9L2pHiyAfmvYM6ZvtUkkd45Sydfo0ZpvbbSkowHMeYYHtgiAeGx
 Nt+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ISfeCpjoQz41XYkDVzSwja5AQEtv40E6VBUlsI12dS8=;
 b=Zb1Cn1ddv+10OF8xh8exFL08OUj9p3qor9TuHdBcS3sya0fRKmjGHXK8TrdgKw0XAF
 P8ko3JVwzbNvUcQ234ZLYRgm5liRoJlDOJFUZmSdWhLAUklqwrvenGbKrnSR16OSQmj6
 2FdbXwE2qjl77XTKoZFJgRVSibhFfNmhA2sSghNLbUjEWI1M/I/FzS6j5qLaWSAFH/gg
 2Naum2TSEUMP+JEjTe9XRywPS6W4LuyULeLHQzCHecQM/GlDMQj9sQFbW2c70w/gmfhk
 T6kVIdRVEQ/0meH6RgXrJ4Uh5tdUJp2Z3WlqChGOzlHerjbFrQPWJ+eBNhXEMO6trmZz
 9vAw==
X-Gm-Message-State: AOAM531r66yTXpWbLjjQFbxTqGnGpKMcd/hTJgZTy735mfDV6JuibXcX
 67ZgXns99mH/XH6xgXw41s+6iHeRkepP/6GIJ0A=
X-Google-Smtp-Source: ABdhPJxh9aFKnxyu9itFoD/F+X7J59o+rlYXjZ4OpcSekFovPAnrR9x5REgZRor0TrmHpKWDBp0usA==
X-Received: by 2002:a17:902:fe84:b029:d1:e598:3ff6 with SMTP id
 x4-20020a170902fe84b02900d1e5983ff6mr2768151plm.48.1600190067267; 
 Tue, 15 Sep 2020 10:14:27 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id j14sm124046pjz.21.2020.09.15.10.14.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2020 10:14:26 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 21/26] tests: Fixes test-qdev-global-props.c
Date: Wed, 16 Sep 2020 01:12:29 +0800
Message-Id: <20200915171234.236-22-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200915171234.236-1-luoyonggang@gmail.com>
References: <20200915171234.236-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=luoyonggang@gmail.com; helo=mail-pj1-x1043.google.com
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
 Xie Changlong <xiechanglong.d@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Peter Lieven <pl@kamp.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On win32 the line ending are \r\n, so we skip the \n in function test_dynamic_globalprop

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/test-qdev-global-props.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tests/test-qdev-global-props.c b/tests/test-qdev-global-props.c
index 8a3c14d92c..c8862cac5f 100644
--- a/tests/test-qdev-global-props.c
+++ b/tests/test-qdev-global-props.c
@@ -251,10 +251,13 @@ static void test_dynamic_globalprop(void)
     g_test_trap_assert_passed();
     g_test_trap_assert_stderr_unmatched("*prop1*");
     g_test_trap_assert_stderr_unmatched("*prop2*");
-    g_test_trap_assert_stderr("*warning: global dynamic-prop-type-bad.prop3 has invalid class name\n*");
+    g_test_trap_assert_stderr(
+        "*warning: global dynamic-prop-type-bad.prop3 has invalid class name*");
     g_test_trap_assert_stderr_unmatched("*prop4*");
-    g_test_trap_assert_stderr("*warning: global nohotplug-type.prop5=105 not used\n*");
-    g_test_trap_assert_stderr("*warning: global nondevice-type.prop6 has invalid class name\n*");
+    g_test_trap_assert_stderr(
+        "*warning: global nohotplug-type.prop5=105 not used*");
+    g_test_trap_assert_stderr(
+        "*warning: global nondevice-type.prop6 has invalid class name*");
     g_test_trap_assert_stdout("");
 }
 
-- 
2.28.0.windows.1


