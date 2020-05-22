Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A506C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 16:22:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D7B12070A
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 16:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KkIZOsoP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D7B12070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcAQz-00071n-6Q
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 12:22:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40436)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jcAKV-0003AI-CQ
 for qemu-devel@nongnu.org; Fri, 22 May 2020 12:15:28 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:44546)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jcAKT-0006FO-63
 for qemu-devel@nongnu.org; Fri, 22 May 2020 12:15:27 -0400
Received: by mail-pg1-x541.google.com with SMTP id p30so5183675pgl.11
 for <qemu-devel@nongnu.org>; Fri, 22 May 2020 09:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=E2NUbUllh+KAafmECCEQXin5XBjgzmIjrK1tK+Jhx74=;
 b=KkIZOsoPSxtyYHa4qo7TTlEhyFRe1hQt3UNu58y4mklHRa2rWYiB0J2aYP1+yUiHsC
 HYWG+SlaK+uRBEYSzikdTAtW+3ZSjLJxFtIoX/OaOAfv9YSj5SwgIgWsfT6aUhbUW8as
 3sAnUnH8lTFSl9iwfwkzoELmBKAxB3Encr5RibxG0N1n9jMqe+J4lOawUj88oTwjK1HK
 7frTSAi1KOLYRC6rjAsmBC4RdxiHymYBd23EwjVqHm41VU2CNCFCWjfWQyMwzwssWHu5
 dqDsOxgYFoiLkPviX8TNuKch6IkA+l6gKG7hjlKyQj8tRKVLwW0RAR4m510PcShLSukh
 9Bfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=E2NUbUllh+KAafmECCEQXin5XBjgzmIjrK1tK+Jhx74=;
 b=DtvAJvbNDcnOAryLMXracxiqNq3W9GSyIUQeoKJRZ1vEi4bTtV9W+KFUqzQTCD7P6i
 aPSFOZ88xU3V4JVteg/LYyEcPPQmy1XqRS+2dTgGNQtcB4VAJoeCvI1ZCNH2TB1v/Z1e
 rlGFDHLWK4ANwM0yqB8QeuV1Vd19awmKoykDKOhmAQNrWYJjd0x0Rk12l8o20IxYf+VU
 8DI76CAp97Y2B13dc39qfla1PO2qzUAWOw3X1L5V4HNCR4ptJVnn/FBB0yLAnpnKcS1K
 bFGpRVn8by94oNwORd23xjo3HxR4uk/jDV2S3dlZjrX0UJmF1ABVZ8HvoIpZSTP1Eiz+
 CxfQ==
X-Gm-Message-State: AOAM530boVvJHCXBNqxZQDctaR9umQbUT20kfZ3FHtru1nx2kAcG01lZ
 MGIgPM11AURdTZpuSJrdT6T96yGgUNrSpQ==
X-Google-Smtp-Source: ABdhPJxSWGGajirmm6Ds/VeFTnZ+AJ33Vhht1mdP5l9A1jIZ7juEikAtmhzxfAm1ZzAeeVMO+4cxcg==
X-Received: by 2002:a63:f59:: with SMTP id 25mr14173119pgp.420.1590164123073; 
 Fri, 22 May 2020 09:15:23 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:f1d9:5fce:c451:d2e2])
 by smtp.gmail.com with ESMTPSA id y75sm7255428pfb.212.2020.05.22.09.15.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2020 09:15:22 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 12/19] configure: added tsan support for blacklist.
Date: Fri, 22 May 2020 12:07:48 -0400
Message-Id: <20200522160755.886-13-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200522160755.886-1-robert.foley@linaro.org>
References: <20200522160755.886-1-robert.foley@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=robert.foley@linaro.org; helo=mail-pg1-x541.google.com
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
Cc: peter.puhov@linaro.org, cota@braap.org, alex.bennee@linaro.org,
 robert.foley@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Initially put several files into blacklist that were
causing the most problems, namely bitops.c and bitmap.c.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 configure                 | 3 ++-
 tests/tsan/blacklist.tsan | 5 +++++
 2 files changed, 7 insertions(+), 1 deletion(-)
 create mode 100644 tests/tsan/blacklist.tsan

diff --git a/configure b/configure
index c95c54fb48..8a86a0638d 100755
--- a/configure
+++ b/configure
@@ -6306,7 +6306,8 @@ if test "$have_asan" = "yes"; then
 fi
 if test "$have_tsan" = "yes" ; then
   if test "$have_tsan_iface_fiber" = "yes" ; then
-    QEMU_CFLAGS="-fsanitize=thread $QEMU_CFLAGS"
+    QEMU_CFLAGS="-fsanitize=thread -fsanitize-blacklist="\
+	        "\$(SRC_PATH)/tests/tsan/blacklist.tsan $QEMU_CFLAGS"
     QEMU_LDFLAGS="-fsanitize=thread $QEMU_LDFLAGS"
   else
     echo "Cannot enable TSAN due to missing fiber annotation interface."
diff --git a/tests/tsan/blacklist.tsan b/tests/tsan/blacklist.tsan
new file mode 100644
index 0000000000..67dd809e96
--- /dev/null
+++ b/tests/tsan/blacklist.tsan
@@ -0,0 +1,5 @@
+# TSan is not happy about setting/getting of dirty bits,
+# for example, cpu_physical_memory_set_dirty_range,
+# and cpu_physical_memory_get_dirty.
+src:bitops.c
+src:bitmap.c
-- 
2.17.1


