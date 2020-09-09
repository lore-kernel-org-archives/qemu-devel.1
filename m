Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 854A7C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 09:58:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3F5A21973
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 09:58:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sg4bKp3C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3F5A21973
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFwrp-0000T0-Rt
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 05:58:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57656)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFwhy-0008AM-Aj; Wed, 09 Sep 2020 05:48:06 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:36311)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFwhw-0007or-4G; Wed, 09 Sep 2020 05:48:05 -0400
Received: by mail-pg1-x541.google.com with SMTP id m8so1696368pgi.3;
 Wed, 09 Sep 2020 02:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XHC/DSYKKw+7p0nzLLzEY49FP0TKj5MM1g4o4UmgUFI=;
 b=Sg4bKp3CFxGJlzZIXfxAAM39pI/MzEaTDyM8QBgaT0iug3BwwlCc7001KBVGuW9tPp
 D3S5giFj/PeMa3H4pQT2yOAKkwn6+MyzC1qnK2hO8sZUYvYyH0dDQetLLz4ehsGi0zID
 AWRjXfSIgjhw/v9kZ+ZcgJrXNgltykXbQAV1g67cd5xEclqMx1Yu2iubYBwDzDx21kDB
 EdEsaqaYOroLV5oAgAdyS3Il7QbEs4mviAwfityDpM2X/CElvwtiH84oOZ+L4Rekpu3n
 mGUmjjVg/SZw9Ym6RA7ekqktKdW+4y2LT6qEb7EQIyYn9JMclI68ZNp9wBxvpRHeyo2n
 Xkzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XHC/DSYKKw+7p0nzLLzEY49FP0TKj5MM1g4o4UmgUFI=;
 b=TXqL10FD5JmyesMkzCNVsJqV5w/vyTJiiioDlZgR2rYYtjXs8yBP8iMDoQgU1LQER1
 DYgikoG/X1PWh3cH7Yrtz8/2FfrgVHH3Y537ZdF4922pTJLn2cJ7Eu7r3l0gyvnm+iTW
 4faMkR+H1/jl4ZYNcgq2/PtBhAEhjj8kA9DfLOeGjP2OlCIY6GCCOdOy2a/g3P62SBHq
 P5UfIfodGnVMVV06Kf3whDRP9V5Rg5cTB8/3F0A9PxfcRJquypAXL4s7XOhminxSrc9g
 SPPXF7n93ykf7SkwCtmkYYV9yt2+6nuG/JDN+d/ONB6SwILvVbEgdy11BOQp7TwadpKb
 yCGA==
X-Gm-Message-State: AOAM533ylxzfytClNsW/3zLKkC9Ml7/3EcA6ekl5U+6xodFLZZ5BcSGy
 yamPZZgfU5Qe/BMTQXM8mLQsljf+Zlwccywg
X-Google-Smtp-Source: ABdhPJw0+7KTm5sB03H1oOUzN/kXT+MqytcUIB/JkbJjCE/hj4VOqPZXN+1GCRzfir6KLyLSWs+aqA==
X-Received: by 2002:a17:902:b908:b029:d0:cbe1:e7ab with SMTP id
 bf8-20020a170902b908b02900d0cbe1e7abmr197516plb.28.1599644881994; 
 Wed, 09 Sep 2020 02:48:01 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id 64sm1708312pgi.90.2020.09.09.02.47.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2020 02:48:01 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 21/21] tests: Fixes test-qdev-global-props.c
Date: Wed,  9 Sep 2020 17:46:17 +0800
Message-Id: <20200909094617.1582-22-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200909094617.1582-1-luoyonggang@gmail.com>
References: <20200909094617.1582-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=luoyonggang@gmail.com; helo=mail-pg1-x541.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-block@nongnu.org,
 Stefan Weil <sw@weilnetz.de>, Xie Changlong <xiechanglong.d@gmail.com>,
 Peter Lieven <pl@kamp.de>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On win32 the line ending are \r\n, so we skip the \n in function test_dynamic_globalprop

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 tests/test-qdev-global-props.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/test-qdev-global-props.c b/tests/test-qdev-global-props.c
index 1e6b0f33ff..d8762a9756 100644
--- a/tests/test-qdev-global-props.c
+++ b/tests/test-qdev-global-props.c
@@ -250,10 +250,10 @@ static void test_dynamic_globalprop(void)
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


