Return-Path: <SRS0=E5X6=CV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6133C433E2
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 22:57:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7663120731
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 22:57:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q14fd5jN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7663120731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHESI-0008AL-E9
	for qemu-devel@archiver.kernel.org; Sat, 12 Sep 2020 18:57:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47632)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kHEHx-0004cB-6u; Sat, 12 Sep 2020 18:46:33 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:42974)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kHEHu-0004X4-CE; Sat, 12 Sep 2020 18:46:32 -0400
Received: by mail-pl1-x642.google.com with SMTP id y6so2657021plt.9;
 Sat, 12 Sep 2020 15:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ajxFadu+yHNyg0D+X68nZFkcXE3tK/jib0sFS+8nB4w=;
 b=q14fd5jNpTmbP1HexEFKnr9FQdMak13lglhkDvGEx9Y28nxXZTBjabbSYNetL+WhFy
 m6z0yatCmuZj1ENBIVXdig2KwcnkIi/ksv8iV49hVGOnEOcd4VE/y/OgPuICP6FD5W11
 SSp8H99wpjbhKLfb7RPfYtJJX8P64Q1u8M3kY3VHNQ/TRj3VYGkqUwdQeCco9oNVXeLF
 iPsGy9laUl6/EvSbimvyvokbnLEFWnwlNnLiEqUr2aJ5N2aH0bTTyPYN5TD7yVbC67E0
 LFBMyRzixyi5hWwQ/+rzEdAeTWFIpkRJR7/ZsQ/ahvLYRUi7L66bpmTpSHzclxhkvVCr
 zssA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ajxFadu+yHNyg0D+X68nZFkcXE3tK/jib0sFS+8nB4w=;
 b=CqEHUqdueNDb+qL0xaBlYBnBLfaHxYoHakwnKSlVwOYA7pIN2hxYRYynA0GZvlDkHl
 DJ2hz6fh4AnI8QKcV8E7Y68AR0LNjUWLUUsnjPd9CVh3q1Yv8TD/NEn2kJ9PY+DIPgb/
 ucS4R1dbwkpMXkGwzSB1g5Bkxyhfh52ABL59tCD15x6dWUE9IzQ6PTeMdYOJQzfrkFzC
 SdFlca9CjypclHR7DnmNQA2cpygCJLNzhzq8eJzw59maao9GIqxW1lLShgeqajR/3M6Q
 obxYe8s3dXdxIpiBH6lPAn/q+z2PCfaHEXCi5oRuNHqY2ERC/jR4H5tfHfQ0dn++Af3e
 toXA==
X-Gm-Message-State: AOAM531qGh/xpQFL+9gKVoOPRgEfbAoO6u2grEY+9oRldEL8KnXXwP1A
 v2bUnbY9Le1xnCqG6vPFQL9jw5zKHzuwimi/bDc=
X-Google-Smtp-Source: ABdhPJzhoPjhFQvxWRbVrVyd5W1BWweLvsAzUq9gEgTDyjdt5Tqz0jB5RXl2DuIzbd5lVFQSgeB1XA==
X-Received: by 2002:a17:90b:796:: with SMTP id
 l22mr7888685pjz.199.1599950785128; 
 Sat, 12 Sep 2020 15:46:25 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id t10sm4639266pgp.15.2020.09.12.15.46.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2020 15:46:24 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 22/27] tests: Fixes test-qdev-global-props.c
Date: Sun, 13 Sep 2020 06:44:26 +0800
Message-Id: <20200912224431.1428-23-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200912224431.1428-1-luoyonggang@gmail.com>
References: <20200912224431.1428-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=luoyonggang@gmail.com; helo=mail-pl1-x642.google.com
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


