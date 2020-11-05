Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5EF9C4741F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 18:09:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E37CC20709
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 18:09:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KLv57ufL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E37CC20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kajhH-0003ri-Op
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 13:09:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34748)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kajR1-0004T6-I0
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 12:52:31 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53979)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kajQw-0004sj-TZ
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 12:52:31 -0500
Received: by mail-wm1-x343.google.com with SMTP id p22so2448740wmg.3
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 09:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=a5c1eKM/XybxvDJjKQOLiUdZhARb8RUFQ8wgNdzFCEM=;
 b=KLv57ufL0wf41x1AE66/8pYcnkE7tgcU+QuDpHdpDkhydu+GGJAX2j15O/1ECZH2Qi
 JAyK11xJz9DhnkxYFBQyDUkru63s38pRI96HRIcgfpqwcLO+tl5DUqgOy//9JvtV1Oix
 fkbgGxipAw9atvC+vDM/wQhSEvp1mQq+EYzf6cRnmJTfIgNEtPYViJf2Wq375pky6MUO
 mrbsflMe22hQEDPXP45PXc8OPaFkK4yzYjrlNa+8EZMaswvsEuVqtHKKYQ0oF2gZOi0/
 13RqjwMfzfFecl3NH6YoeXrIyQtRtZgxE042F2I+y5KDovYu0A5ZuyhWLAPQwd5v6zPG
 0W8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=a5c1eKM/XybxvDJjKQOLiUdZhARb8RUFQ8wgNdzFCEM=;
 b=HsPH6qNRXclrkm4F/H7ey36QiRX4UbqXmqg2oE9IpTPw1GEPufLc6uICfJ9JIF0CDw
 2XzC77OkYzC/D2SpVtsuOUMKwwxZ6+Ab9nu5OcdvHQ/ZjcospgMTF+zTqJC6Und2QmJO
 0D8Lwv5G/vVQwYmKyEkWbLLx74cFBSvoB5Oxg4VbSEKhQfsGfjttcQ5T1WN4FAXmujcb
 N3QBfYBUhlPMuqQ9PlLRLGojD59XUVeEx32vOVt2BfD37/1nOrk7lu41RsPR/gq4Q0ed
 ioVVZ0U/E2gsqAN4lKKrcjrsSOlwJctKe5CGF4xHu3kUcd2UdWhSD54deBMYYR4mrBkP
 quew==
X-Gm-Message-State: AOAM533QPjVVRDNXasSqSuWkNcxQP07AZps/moryAM1sOMPfsRswBsxL
 UG/faq4a+cahT51XleHU0jsJPw==
X-Google-Smtp-Source: ABdhPJyy9wj6MQCfwXAvJnhODAWKTVxucKRmoqBQ0EU4M1Cjc+IVsyynK0l0sXAKFpAfK4kNIJarew==
X-Received: by 2002:a1c:7213:: with SMTP id n19mr3866935wmc.36.1604598744726; 
 Thu, 05 Nov 2020 09:52:24 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y187sm3712156wmg.33.2020.11.05.09.51.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2020 09:52:08 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 664FB1FF93;
 Thu,  5 Nov 2020 17:51:54 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 07/15] accel/meson: you only need accelerator stubs for
 softmmu builds
Date: Thu,  5 Nov 2020 17:51:45 +0000
Message-Id: <20201105175153.30489-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201105175153.30489-1-alex.bennee@linaro.org>
References: <20201105175153.30489-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x343.google.com
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
Cc: julien@xen.org, masami.hiramatsu@linaro.org, andre.przywara@arm.com,
 stefano.stabellini@linaro.org, takahiro.akashi@linaro.org,
 stefano.stabellini@xilinx.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 stratos-dev@op-lists.linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This avoids us pulling in Xen headers we don't need. The TCG
accelerator will always exist for the *-user builds.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 accel/meson.build       |  4 +++-
 accel/stubs/meson.build | 12 ++++++++----
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/accel/meson.build b/accel/meson.build
index b26cca227a..c4936698cd 100644
--- a/accel/meson.build
+++ b/accel/meson.build
@@ -4,7 +4,9 @@ subdir('qtest')
 subdir('kvm')
 subdir('tcg')
 subdir('xen')
-subdir('stubs')
+if have_system
+  subdir('stubs')
+endif
 
 dummy_ss = ss.source_set()
 dummy_ss.add(files(
diff --git a/accel/stubs/meson.build b/accel/stubs/meson.build
index 12dd1539af..d65cb6a5e1 100644
--- a/accel/stubs/meson.build
+++ b/accel/stubs/meson.build
@@ -1,4 +1,8 @@
-specific_ss.add(when: 'CONFIG_HAX', if_false: files('hax-stub.c'))
-specific_ss.add(when: 'CONFIG_XEN', if_false: files('xen-stub.c'))
-specific_ss.add(when: 'CONFIG_KVM', if_false: files('kvm-stub.c'))
-specific_ss.add(when: 'CONFIG_TCG', if_false: files('tcg-stub.c'))
+softmmu_stub_ss = ss.source_set()
+
+softmmu_stub_ss.add(when: 'CONFIG_HAX', if_false: files('hax-stub.c'))
+softmmu_stub_ss.add(when: 'CONFIG_XEN', if_false: files('xen-stub.c'))
+softmmu_stub_ss.add(when: 'CONFIG_KVM', if_false: files('kvm-stub.c'))
+softmmu_stub_ss.add(when: 'CONFIG_TCG', if_false: files('tcg-stub.c'))
+
+specific_ss.add_all(when: 'CONFIG_SOFTMMU', if_true: softmmu_stub_ss)
-- 
2.20.1


