Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43133C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 15:09:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CADAF20829
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 15:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aPLyaifR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CADAF20829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHq6r-0002I5-Sp
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 11:09:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37776)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kHq4g-0000bY-Ri
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 11:07:22 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36608)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kHq4f-0000D2-6u
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 11:07:22 -0400
Received: by mail-wr1-x444.google.com with SMTP id z1so50161wrt.3
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 08:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WnEEcW5T8TnW3Xg2cKGofSTt8rnGAByMYZea8oHCeVE=;
 b=aPLyaifRy8D2CtTGxJi9AW7rp61b7XdaJjsvPzytt/dpy/g5xOwhUF/OENXaAZ+gwG
 RWHzUdt9qTgKHScT/47tyOGbcIPsVKgb9wpoN8tIHRlhZz5BGZJwhYn/gq8aQOLGmW/5
 I9DxkuvH4F0cAhveTf5cxbIW/sa4tWtcI4tQUd5R8AB3RCsYKvXeLlcCvMJIDuk7dZcQ
 cYgykGMuvL4nfwRHcUBBBGfML6qhcFA83kUD7HGhJ54sMbIuM/X0EBAugUP5oARE8pdz
 t47tmQoyA5WyEJVZlmEVlgoaMEBXILffsMu8SZiiD0uJvkzSLXXhHuoKeWJxqyDcEWIC
 Xp6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WnEEcW5T8TnW3Xg2cKGofSTt8rnGAByMYZea8oHCeVE=;
 b=my4cYBlaaR6j7Xc2XhyJiuHY1FHL94mqkyIDiWsH64NBjC8SwwKuAR9UWts6/HRYTr
 z2xztuh31sQ32tQiTfv6fZ2ACMRkGQ6HlTYzwIV2JlItOpIpXyC7MbOkQmMeovLFQ17s
 eaDZAUhRJ22SZ3XiPQCGf7BbAqH6l09WEQRVQvdngLaZCXBFOcykcjBBIIwgpG3yJL5s
 PfOlmYap+L9qqFbuVJTkdghdCGKK6pcSOGr2lGJafuPXvK2T1bgt24+wjfIyy72cI4Qs
 PyuKamtpiA8VN0XgTLfjVayJwgS2nI9pKEjl+ygqKMwG4Zc2DrhEixfML5DG3yQte7Ih
 ssgg==
X-Gm-Message-State: AOAM531rHOD7YmxorT+isWhtNk2TDz6XwKdm9ZH32Jqz07axzGt9hPAU
 rW9C/I+Xdh93WH7U/0ZUglfoZQ==
X-Google-Smtp-Source: ABdhPJwWlZ7XyMAF+woUaQZxZTAImBTPJHDauWw15PKL0XcGCVEMcFqLPT4y8xV+iEsvsn/btVzZgA==
X-Received: by 2002:a5d:6406:: with SMTP id z6mr15796123wru.133.1600096039763; 
 Mon, 14 Sep 2020 08:07:19 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g8sm19206547wmd.12.2020.09.14.08.07.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2020 08:07:17 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id F38CD1FF87;
 Mon, 14 Sep 2020 16:07:16 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 1/6] linux-user: test,
 don't assert addr != test in pgb_reserved_va
Date: Mon, 14 Sep 2020 16:07:11 +0100
Message-Id: <20200914150716.10501-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200914150716.10501-1-alex.bennee@linaro.org>
References: <20200914150716.10501-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Bug 1895080 <1895080@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On older kernels which don't implement MAP_FIXED_NOREPLACE the kernel
may still fail to give us the address we asked for despite having
already probed the map for a valid hole. Asserting isn't particularly
useful to the user so let us move the check up and expand the
error_report a little to give them a fighting chance of working around
the problem.

Ameliorates: ee94743034
Cc: Bug 1895080 <1895080@bugs.launchpad.net>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 linux-user/elfload.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 4961e6119e24..f6022fd70493 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2331,14 +2331,13 @@ static void pgb_reserved_va(const char *image_name, abi_ulong guest_loaddr,
     assert(guest_base != 0);
     test = g2h(0);
     addr = mmap(test, reserved_va, PROT_NONE, flags, -1, 0);
-    if (addr == MAP_FAILED) {
+    if (addr == MAP_FAILED || addr != test) {
         error_report("Unable to reserve 0x%lx bytes of virtual address "
-                     "space (%s) for use as guest address space (check your "
-                     "virtual memory ulimit setting or reserve less "
-                     "using -R option)", reserved_va, strerror(errno));
+                     "space at %p (%s) for use as guest address space (check your"
+                     "virtual memory ulimit setting, min_mmap_addr or reserve less "
+                     "using -R option)", reserved_va, test, strerror(errno));
         exit(EXIT_FAILURE);
     }
-    assert(addr == test);
 }
 
 void probe_guest_base(const char *image_name, abi_ulong guest_loaddr,
-- 
2.20.1


