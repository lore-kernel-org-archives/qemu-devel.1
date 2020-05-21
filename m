Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F155CC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:17:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C601020738
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y8qf+qXK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C601020738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbqh8-0004Dg-Rf
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 15:17:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37976)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jbqfx-0001xR-Nj
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:16:17 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:37312)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jbqfw-0000OO-Jd
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:16:17 -0400
Received: by mail-wm1-x333.google.com with SMTP id z72so7561376wmc.2
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 12:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=0VFoy/cM3V05uBsBC12Q50YlNd/454IKTpCX5/EFXfo=;
 b=y8qf+qXKfYIFPHgS9wt+744Ctb5HNDpDI5HJ78JuVawZ8HSrTv8jN6YHP4nls6nBIX
 dbBltGPiBdgCB+9dhZ5iCHVhIX2ajqjOqu/Z18iFs78DhlcWzdReQ9ZpmT7G3dXpdymw
 M6BxRX2QlYpMAMG9dfxv0mcMzJgF6ol1yIIs8btdBJgmfmvV5Js74a6l0dAqq3uJfqzP
 rkifUyTmDBy4JXp4ZSH6DZSQzv0LIA7wTsyLEyh48QOtOiyNdeQJGaRqj/XW7pOWXGlj
 zuFVKWHFs37MKZGFtMoFE4g1kVK+bEMrX05/o7HssVb6AbgbMIIcarP69NviY63KPaw1
 CESQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0VFoy/cM3V05uBsBC12Q50YlNd/454IKTpCX5/EFXfo=;
 b=RIJVzLldc6wZS0mHe/wkwqXyaCP6vIjx1NulTJi481lM+FSbBJ8q1Gi987amkVtDo6
 dTplgpr0TI/knxwLBhCI2UB2+3egDIs1wv+jWaoIETf4uZg6RJXqrg5+t+GEwT9J2A4r
 4oQlvHw3A39H70C62Vr1tGLDsIcnAV/+WMfa3uz3kxxa5jkB3S2cvX7lf88ukC6lExRL
 EE6KVczRh0Lo8za5uOs0nlxt8FuwWXOdU803vNGurvbgnAiq7QSs4UD0mY0jXcIJ24EY
 Pxa62FYLbkjTGQBLuovYOuF9hK5Brx4XUGonGe5ur3vyDTLrN277X5NN7ccK7+4CAqRS
 a98w==
X-Gm-Message-State: AOAM533eE3Jukv6RhrWBBeTZqJOiYWiGDmBB51fFcyt0M8sg1HaMVazc
 UWgdI+MACxRYm1KwUVK9psaD7hY0SZasGQ==
X-Google-Smtp-Source: ABdhPJx/Gira8YoYYZITfiU5Sy7oDhiEn5W0wS09m5SNBEXXaMOLppcw/g+tSUzvsKjrb1b+sdqN6g==
X-Received: by 2002:a1c:c386:: with SMTP id t128mr9970909wmf.11.1590088574746; 
 Thu, 21 May 2020 12:16:14 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z124sm7335100wmg.20.2020.05.21.12.16.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 12:16:13 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/29] tests/acceptance: Add a test for the canon-a1100 machine
Date: Thu, 21 May 2020 20:15:42 +0100
Message-Id: <20200521191610.10941-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200521191610.10941-1-peter.maydell@linaro.org>
References: <20200521191610.10941-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

The canon-a1100 machine can be used with the Barebox firmware. The
QEMU Advent Calendar 2018 features a pre-compiled image which we
can use for testing.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
Tested-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20200514190422.23645-1-f4bug@amsat.org
Message-Id: <20200129090420.13954-1-thuth@redhat.com>
[PMD: Rebased MAINTAINERS]
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS                                |  1 +
 tests/acceptance/machine_arm_canona1100.py | 35 ++++++++++++++++++++++
 2 files changed, 36 insertions(+)
 create mode 100644 tests/acceptance/machine_arm_canona1100.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 87a412c229b..1e006c98fab 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -608,6 +608,7 @@ S: Odd Fixes
 F: include/hw/arm/digic.h
 F: hw/*/digic*
 F: include/hw/*/digic*
+F: tests/acceptance/machine_arm_canona1100.py
 
 Goldfish RTC
 M: Anup Patel <anup.patel@wdc.com>
diff --git a/tests/acceptance/machine_arm_canona1100.py b/tests/acceptance/machine_arm_canona1100.py
new file mode 100644
index 00000000000..0e5c43dbcf8
--- /dev/null
+++ b/tests/acceptance/machine_arm_canona1100.py
@@ -0,0 +1,35 @@
+# Functional test that boots the canon-a1100 machine with firmware
+#
+# Copyright (c) 2020 Red Hat, Inc.
+#
+# Author:
+#  Thomas Huth <thuth@redhat.com>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later.  See the COPYING file in the top-level directory.
+
+from avocado_qemu import Test
+from avocado_qemu import wait_for_console_pattern
+from avocado.utils import archive
+
+class CanonA1100Machine(Test):
+    """Boots the barebox firmware and checks that the console is operational"""
+
+    timeout = 90
+
+    def test_arm_canona1100(self):
+        """
+        :avocado: tags=arch:arm
+        :avocado: tags=machine:canon-a1100
+        :avocado: tags=device:pflash_cfi02
+        """
+        tar_url = ('https://www.qemu-advent-calendar.org'
+                   '/2018/download/day18.tar.xz')
+        tar_hash = '068b5fc4242b29381acee94713509f8a876e9db6'
+        file_path = self.fetch_asset(tar_url, asset_hash=tar_hash)
+        archive.extract(file_path, self.workdir)
+        self.vm.set_console()
+        self.vm.add_args('-bios',
+                         self.workdir + '/day18/barebox.canon-a1100.bin')
+        self.vm.launch()
+        wait_for_console_pattern(self, 'running /env/bin/init')
-- 
2.20.1


