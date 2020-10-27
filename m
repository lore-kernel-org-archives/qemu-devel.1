Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED870C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 10:04:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A36021D24
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 10:04:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KHIvbtMI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A36021D24
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXLqR-0003Vr-F6
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 06:04:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54326)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kXLlc-0006hZ-I8
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 05:59:48 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:34281)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kXLla-0000Pr-DM
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 05:59:48 -0400
Received: by mail-wm1-x332.google.com with SMTP id k21so701901wmi.1
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 02:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ji1OK2cw4qK0q2shMLk3KuQWB+2Gvmzz4g4Bk/4luuQ=;
 b=KHIvbtMI1hr1+sN4NyTAjjCpR02d1leMyhwPlTt+DIjN5UF379AzAJwTCl42jQ4BEw
 yihZ9k/lmSlgWZdfbOseHo18ytsN2NF5AqpIPpyUA9XkxlwBYBDvX/0dapaiZ3q/Ji4s
 wFlRj3U/K6zQ18L/dQQbGib/s+n5Wzf66xo20k+viw4p3bMYlHA/sdHKtL/89pdPU6R4
 khI9JJ3Gc5qD/dw6mPM6q+duTTnd95h2B11mXImc/DFKDBCbbjPyQiXcRIYDX8Z86oZK
 ZgfI+xognV3mdWERsWy9OFDHcgdrcRo29ya+7CSfEI1DxqPT/0RVSHSvQF4IkFJfFb7S
 nGJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ji1OK2cw4qK0q2shMLk3KuQWB+2Gvmzz4g4Bk/4luuQ=;
 b=do5VFyXyGfAuw85K7rkrK6e11ZhuewJlerIJHi4lANdx3GNcDbRVi8PlgI+d5Vuyij
 qFCjTrbC0R7OReJ+jqJbV7jE9a1sQrv5a2kM6kYlAikwOenpx/N7xK6eJSZA0MYBgPg/
 AsXoJEHjQXNxckKK34hf07voySmm624gsE8/8iFYEx7myzD/G+rmL79NukiaRG5klctT
 uyynVKjawGNIhoL9k10AUQRB4JjTZI1db2nPrEb6m/1gV4WjuPzR5v3eQmdebPkAUKGe
 gU/g4M3JMDVNN4HAsmVoFlfiUW916YyjCPjY5MEpt1f4XS15BLzlN1vM2+hpjTeSkWVN
 mHfg==
X-Gm-Message-State: AOAM5338rcdeWaH4aIp+ki5s3K7c9G6GlHMoZMFFk6vdqcZMKrbbpDKS
 0oLDuCQF8NykQGW7JTQIeAAcdORnQ/LXBg==
X-Google-Smtp-Source: ABdhPJxJftfX1EH2LsCMs9FxM5+3N0g6O9j7Jz6anibj+hIawlTKVln12G85bfNelD4pnURJQhPyIg==
X-Received: by 2002:a1c:7e82:: with SMTP id z124mr1792545wmc.8.1603792785128; 
 Tue, 27 Oct 2020 02:59:45 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id e20sm1268247wme.35.2020.10.27.02.59.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 02:59:43 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0C4AC1FF8F;
 Tue, 27 Oct 2020 09:59:39 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 3/8] tests/docker/dockerfiles/centos: Use SDL2 instead of SDL1
Date: Tue, 27 Oct 2020 09:59:33 +0000
Message-Id: <20201027095938.28673-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201027095938.28673-1-alex.bennee@linaro.org>
References: <20201027095938.28673-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

We do not support SDL1 in QEMU anymore. Use SDL2 instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20201021072308.9224-1-thuth@redhat.com>
Message-Id: <20201021163136.27324-4-alex.bennee@linaro.org>

diff --git a/tests/docker/dockerfiles/centos7.docker b/tests/docker/dockerfiles/centos7.docker
index 8b273725ee..6f11af1989 100644
--- a/tests/docker/dockerfiles/centos7.docker
+++ b/tests/docker/dockerfiles/centos7.docker
@@ -31,7 +31,7 @@ ENV PACKAGES \
     perl-Test-Harness \
     pixman-devel \
     python3 \
-    SDL-devel \
+    SDL2-devel \
     spice-glib-devel \
     spice-server-devel \
     tar \
diff --git a/tests/docker/dockerfiles/centos8.docker b/tests/docker/dockerfiles/centos8.docker
index a589142114..54bc6d54cd 100644
--- a/tests/docker/dockerfiles/centos8.docker
+++ b/tests/docker/dockerfiles/centos8.docker
@@ -2,7 +2,7 @@ FROM centos:8.1.1911
 
 RUN dnf -y update
 ENV PACKAGES \
-    SDL-devel \
+    SDL2-devel \
     bzip2 \
     bzip2-devel \
     dbus-daemon \
-- 
2.20.1


