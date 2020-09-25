Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72509C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 16:23:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEC7C2087D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 16:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K1NaTBJL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEC7C2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLqVR-0006BA-JZ
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 12:23:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45584)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kLqMa-00059V-CI
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 12:14:24 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:37234)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kLqMY-0005Z9-19
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 12:14:23 -0400
Received: by mail-wm1-x32c.google.com with SMTP id a9so3918290wmm.2
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 09:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=vPUbmQIwrNRMsd7qhtf8xrEMX3bvGdNpPLCMm19mP5w=;
 b=K1NaTBJLQNe9aFWkGOIidyvw2R/+GBYpBPrb5PLEAVkHS35XFkjAOI4a9I7ttEBhTQ
 C0RHUTbCpUiBPwzzO9+rZYbc8TTibot7U3803HO7BX90GmW+Bn6zHD/WmrhzzLlxQvy5
 F8q7xRkkXPCJB3oaRwETyN7y5AIT0INS8h0UtuArx+UwCpYBlMMVxcdRK2W1UCgT/jTG
 vIlviWNNiO5VYJytUb7qmr9OE6EB4ephrAts2InycJAX4IT4uabKsihCiv+DFUaTWhjc
 YunQAJeFxGIN5vZLLRbVpQoh3VNbSKg6sdyQQa+cxncqpfAARL00d8bGVQ9CV9zFVVIq
 RWTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=vPUbmQIwrNRMsd7qhtf8xrEMX3bvGdNpPLCMm19mP5w=;
 b=Omw0AqwbSXv8yfzTer6nqmJTUfXJUUz9Im/hqgQGNhcCb0cd2yPH8yLXCqY0GG3HrR
 IVhxa1w8nlLxmvU6jNP5Tb4j6xB7YDiwoftujnySTj8zj1/FdQc4FYsqkVWHaOFEpM+V
 MBl9FXULUxAnucbLobYuPY7MIc/vwVauwN7qf646ah3b2DE3vbTGcjC57URRGcLFI03Y
 UFiJ3YuZGprvC5lvBVrR1/lMk33/YKe/Krv3xES6tH7Vx//xmfvQZMktwLk1APWDR4ng
 KZ3CiEkAnJmzqYZyx6PBo8hFnV3HWokzGKfCI9mlLCNglu0mTbGh6+bKCiXcsqw9VdvZ
 dqZg==
X-Gm-Message-State: AOAM533kB+b70mHApxRJDNbwbyYut0riKM2EjaECaiO9BncOTvA4RS35
 tPcYSMjsRB8gRCQDw61BA7vTSQ==
X-Google-Smtp-Source: ABdhPJyLiq0oR0JxMa1UruM1an+Q2dQ29yTWbgbOLritEtyd+y26O2e5vHgL3K1rhqaXCrST1oWJ8w==
X-Received: by 2002:a7b:cbd4:: with SMTP id n20mr4147329wmi.105.1601050460212; 
 Fri, 25 Sep 2020 09:14:20 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u63sm3426554wmb.13.2020.09.25.09.14.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 09:14:18 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 40F231FF7E;
 Fri, 25 Sep 2020 17:14:18 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] configure: make building deprecated targets easier
Date: Fri, 25 Sep 2020 17:14:08 +0100
Message-Id: <20200925161408.4016-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

While we are ceasing to care about these targets it is useful for CI
purposes to be able to enable them all without having to remember the
list.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 configure      | 17 ++++++++++++++++-
 .gitlab-ci.yml |  4 +---
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/configure b/configure
index c5f1b3bec6a8..2436125cf541 100755
--- a/configure
+++ b/configure
@@ -1039,9 +1039,13 @@ for opt do
   ;;
   --cpu=*)
   ;;
-  --target-list=*) target_list="$optarg"
+  --target-list=*)
                    if test "$target_list_exclude"; then
                        error_exit "Can't mix --target-list with --target-list-exclude"
+                   elif test "$target_list"; then
+                       target_list="$target_list,$optarg"
+                   else
+                       target_list="$optarg"
                    fi
   ;;
   --target-list-exclude=*) target_list_exclude="$optarg"
@@ -1049,6 +1053,13 @@ for opt do
                        error_exit "Can't mix --target-list-exclude with --target-list"
                    fi
   ;;
+  --include-deprecated-targets)
+                   if test "$target_list"; then
+                       target_list="$deprecated_targets_list,$target_list"
+                   else
+                       target_list="$deprecated_targets_list"
+                   fi
+  ;;
   --enable-trace-backends=*) trace_backends="$optarg"
   ;;
   # XXX: backwards compatibility
@@ -1763,6 +1774,10 @@ Standard options:
 $(echo Available targets: $default_target_list | \
   fold -s -w 53 | sed -e 's/^/                           /')
   --target-list-exclude=LIST exclude a set of targets from the default target-list
+  --include-deprecated-targets add currently deprecated targets to the list
+$(echo Deprecated targets: $deprecated_targets_list | \
+  fold -s -w 53 | sed -e 's/^/                           /')
+
 
 Advanced options (experts only):
   --cross-prefix=PREFIX    use PREFIX for compile tools [$cross_prefix]
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index c265e7f8ab0a..bc907812c152 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -258,10 +258,8 @@ build-deprecated:
   <<: *native_build_job_definition
   variables:
     IMAGE: debian-all-test-cross
-    CONFIGURE_ARGS: --disable-docs --disable-tools
+    CONFIGURE_ARGS: --disable-docs --disable-tools --include-deprecated-targets
     MAKE_CHECK_ARGS: check-tcg
-    TARGETS: ppc64abi32-linux-user tilegx-linux-user lm32-softmmu
-      unicore32-softmmu
   allow_failure: true
 
 build-oss-fuzz:
-- 
2.20.1


