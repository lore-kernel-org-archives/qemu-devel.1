Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A62C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 09:55:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04ACD207FB
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 09:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nDCxifch"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04ACD207FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvHf0-0007xC-6J
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 05:55:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58390)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jvHcO-0003NT-DE
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 05:52:56 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:55250)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jvHcM-0003wq-EY
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 05:52:56 -0400
Received: by mail-wm1-x335.google.com with SMTP id o8so4139097wmh.4
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 02:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BBfEE2/nVgeVfVJMVyVYNC/Z05o6uaGLDngf+bqz22g=;
 b=nDCxifchzh+MNerjmbmpwLmCRdVTHZjsUT/DO0kuD9Kf7UYae+7weRTeYzFIPtT5Zj
 lrMngcRaRtZdFXsqzV9vRTP6MUZDv0GYAMqcPJMqD0rYQWipLdsynFuzYC/yOf4Pznyl
 fUcuplsuRC6IH3trOAqa6ovBTTvcYNZiKfegXt3FV8sqX2Wklt09ooBO3hKGY7dIC/qD
 SxPq3pUvKB3YCkXkj/ohxYfoD+KY1OAsEJX1EZl23tsnjqi3aZNncoqkC1tpl+y+9yxJ
 kxVXegauHU1bHDJXUFvqWaSXdzvsO0nzItcnVaBoxMFMyCsKUIG9vlnWdC6XJun+zybR
 t0vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BBfEE2/nVgeVfVJMVyVYNC/Z05o6uaGLDngf+bqz22g=;
 b=tG4MhjDS7haohY4UNVLDj/+tlLqml/Qh2GppZLg9s07Vffqx/ims+D90Q7tVHMW3Sr
 hMViAvWpLjbEX+PbgGslEybUQDyHuIVdRQ4QIXmghfp5hLRkvXLeN9HyoSDqFF+qYLwK
 n5jxyNLMVolep+9d+o/+M6dDPgytoggSKvSnCShS18YJ1q6L1o9lvZYhAE4WOaP0PCi9
 jC0uAf5++n6tH94XN2Z6IVKYlv5hqZNk8xMSC6F5RTvqx+OXA+QCBCDT0APdjhd6i2UB
 FNvoRMfLrKyRqIrmQoNAX+YiuUooYr1SOgxry9G94yj9Vk1Pomwxw99NWWa4wTPbd7j0
 eBfw==
X-Gm-Message-State: AOAM5339Cnv895QRPFzlQxxBo2Q/KHgbwWZX9I1wzq6S3+nG8/Aj0fZR
 AWZqFQ3HnQ+3eZoUZEmgWPCS0g==
X-Google-Smtp-Source: ABdhPJzOW43bIeUggaUP3He/tJBk48xMJ/EmOr6PVUdJrGjhbYlbyHxsboIO78KTdmHEfcd0No2Low==
X-Received: by 2002:a1c:96ce:: with SMTP id y197mr3394116wmd.86.1594720373167; 
 Tue, 14 Jul 2020 02:52:53 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f9sm28163988wru.47.2020.07.14.02.52.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2020 02:52:48 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 90D5F1FF8F;
 Tue, 14 Jul 2020 10:52:47 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 3/9] tests/docker: Remove the libssh workaround from the ubuntu
 20.04 image
Date: Tue, 14 Jul 2020 10:52:41 +0100
Message-Id: <20200714095247.19573-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200714095247.19573-1-alex.bennee@linaro.org>
References: <20200714095247.19573-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

The libssh problem only exists in Ubuntu 18.04 - we can enable it
in 20.04 again.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20200713185237.9419-1-thuth@redhat.com>
Message-Id: <20200713200415.26214-3-alex.bennee@linaro.org>

diff --git a/tests/docker/dockerfiles/ubuntu2004.docker b/tests/docker/dockerfiles/ubuntu2004.docker
index f7aac840bf..8d10934a2a 100644
--- a/tests/docker/dockerfiles/ubuntu2004.docker
+++ b/tests/docker/dockerfiles/ubuntu2004.docker
@@ -65,9 +65,6 @@ RUN apt-get update && \
 RUN dpkg -l $PACKAGES | sort > /packages.txt
 ENV FEATURES clang tsan pyyaml sdl2
 
-# https://bugs.launchpad.net/qemu/+bug/1838763
-ENV QEMU_CONFIGURE_OPTS --disable-libssh
-
 # Apply patch https://reviews.llvm.org/D75820
 # This is required for TSan in clang-10 to compile with QEMU.
 RUN sed -i 's/^const/static const/g' /usr/lib/llvm-10/lib/clang/10.0.0/include/sanitizer/tsan_interface.h
-- 
2.20.1


