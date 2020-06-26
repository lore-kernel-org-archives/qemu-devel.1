Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9880BC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 18:28:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56FA320836
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 18:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="boXIJc9W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56FA320836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jot5o-0005Jy-8y
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 14:28:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58290)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jot08-0003WR-7P
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 14:23:00 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:34183)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jot06-00052D-Jh
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 14:22:59 -0400
Received: by mail-wr1-x442.google.com with SMTP id f7so7384678wrw.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 11:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/rK0Sms5MapCn5tnpSN1o9DxY3jR2MXQyjMdJcVhwfU=;
 b=boXIJc9W7CwmZkyFXNg1XQfbfSOzTIxKVQMBHFjkWZe6z3Ue4vs80QjuJ8GcC8N/Y3
 rVh4P1+wyZCDapbiRoVMkb6ltxXLtG810trz6wmTK09siTrG3s9LAUnX8LlD8PFGp4Eo
 VsoWFgvpduQyGRp7cMtXyq0pnBINXcLova+DTjyI8OucjrtY40UeJxfJXxfndUFeqZI7
 c6xbST5lapx37onPgD+ZlJVLuPqQOU05ZRfpqrJ8r+vU1O9SfWIwrxeUJ6ecU5HIejXG
 11SxHJWQIzoSPoBpdR6I7svpTEeDzuCQ1aMIxiHGVOK9PP2LfTThxx+IyBg9jwYtevv8
 +rTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/rK0Sms5MapCn5tnpSN1o9DxY3jR2MXQyjMdJcVhwfU=;
 b=rQFjZzKQ/R46dUEIWamj8UyBu6vxD87rn80POH5fQwnc7zrGtr9COj4pDdTykK2ovn
 6ffEopcT79L502MGwMbvY/K4vbzvGAqlILK6iJnhJljVreyQhNqBrnO6qGY6tjueNXUR
 sXOTtPf3n3119foPZhAaWPMAXTIDdT8iaWup0yr+3HbBl8Kvg9d5E1O8XlraxXooc4NE
 7UIkKx7YU//ibOUG26dS2sLyUwBLyzEoDPcTzihcqCw05Nld8hKjTJRijsZzIZRlO0Sm
 fzO2XDTQxDMMtezW6bBiFWUbX8gE97COu/SQPue95e68McCXIzA0dRP5r5FwKzM2sPKp
 88FQ==
X-Gm-Message-State: AOAM531Wd2R8f3+D5D1dqPrruqcre1szJTSbXlpRaQQirVPLqRLjzrKn
 UbpU5HECUWOiDZk8vYEvJSJSoA==
X-Google-Smtp-Source: ABdhPJyNzOa1s4PYUPAkq+oZ3KTyqWbVik413SsrnBTX3dCqc3Lp4+4iR3p36MSWnTmBhYb5RFzn1w==
X-Received: by 2002:adf:de01:: with SMTP id b1mr4897537wrm.305.1593195777236; 
 Fri, 26 Jun 2020 11:22:57 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 14sm17823377wmk.19.2020.06.26.11.22.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 11:22:53 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 56F551FFAE;
 Fri, 26 Jun 2020 19:14:03 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v3 26/30] gitlab: enable check-tcg for linux-user tests
Date: Fri, 26 Jun 2020 19:13:53 +0100
Message-Id: <20200626181357.26211-27-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200626181357.26211-1-alex.bennee@linaro.org>
References: <20200626181357.26211-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: fam@euphon.net, Thomas Huth <thuth@redhat.com>, berrange@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, cota@braap.org,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Switch to building in the new debian-all-test-cross image which has
most of the cross compilers inline.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .gitlab-ci.yml | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 5ae8130bd1a..17c3349dd9e 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -140,10 +140,9 @@ build-tcg-disabled:
 build-user:
   <<: *native_build_job_definition
   variables:
-    IMAGE: ubuntu2004
-    CONFIGURE_ARGS: --disable-system --disable-guest-agent
-      --disable-capstone --disable-slirp --disable-fdt
-    MAKE_CHECK_ARGS:  run-tcg-tests-i386-linux-user run-tcg-tests-x86_64-linux-user
+    IMAGE: debian-all-test-cross
+    CONFIGURE_ARGS: --disable-tools --disable-system
+    MAKE_CHECK_ARGS: check-tcg
 
 build-clang:
   <<: *native_build_job_definition
-- 
2.20.1


