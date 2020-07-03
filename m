Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 819C9C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 14:59:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CB1D20899
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 14:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MCh4Ug0J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CB1D20899
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrN9Z-00070Q-Fi
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 10:59:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42614)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrN71-0003ib-Kw
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 10:56:23 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:35036)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrN6z-0006jL-R4
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 10:56:23 -0400
Received: by mail-wm1-x343.google.com with SMTP id l2so32874530wmf.0
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 07:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xdwJ7T2gYvtwSqRJeSeL30u3SzAKMgTYxu/rW3+6M/8=;
 b=MCh4Ug0JmCPpVEY2DbybO3y27usxhdBrluHJPNBGMh5M/x1P3dHWT6tTEvz8aX7381
 EkxVZsP1qsMNT4qM+/v5hzefmlpiTy/o68XLNqpj1jDIR/QeBV8QjbPH/d4ZIUIGkiZI
 NTek2pEvPEv90oB8YW/62DJJmTJ5GpO0C3WY4QUqB5r4Crgt+n3cpQ+DtpoOvfRWFIL5
 bf2l7vRQezIG16v3cTnEocJCGSgZeh18hO7lXDGuAUJDGaiBEf2YOXsaiv+DcXr8Y8MV
 yfHGOiC7HyQuw9bNxbIo9Lw4FfyG8mdk4FteU/Feml8hGzbthZJfAg4KEslcI1zAhItn
 UTAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xdwJ7T2gYvtwSqRJeSeL30u3SzAKMgTYxu/rW3+6M/8=;
 b=X9JJpTHyJVGStWOq0CwIwfqB6VnY57LYvCtO2w+3SclFXQnTgVhcL2QeHVPv+2Te0C
 mkDfMX2P+/wzUVXoG9I9NqOZSmy31wDmVtyusO4kLnh25UlCHdK+3MFd+pYm48v00Qoq
 0NASZMukcCJkAlD6USSmkA3k9E8mrX3gqugQuhwk+P7yltge8bvbfJ4pJjj56o/VrTlT
 Gi9zPmtjRxtSjQAPT4T0F2ODAlP74EauZMo5knIsGqpakOnyFG+IfJ163S9kE82BSW4W
 5R3QVLEPJ0VO5jLskgLl/gepf5ryIJTKrxRD4wbCF+OhdL/OBEO6gBmvTmggD40oy1zt
 kh3A==
X-Gm-Message-State: AOAM530DyQr5t9Ex5ce+QZFFLGFiXYUqa44TfW3kYTwL7cNUKweZcfFz
 ec0UKeq2/oGI9rI60CVtoKSjymD0myTKug==
X-Google-Smtp-Source: ABdhPJyAqaT/mkiD7SpYhyktS+Mo+xjvEKf28v++P/kmqNHYw1PzNPLLX2C1J+AOz3ykrIPvbGLXUg==
X-Received: by 2002:a1c:2349:: with SMTP id j70mr36294944wmj.22.1593788180161; 
 Fri, 03 Jul 2020 07:56:20 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s10sm14078347wme.31.2020.07.03.07.56.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2020 07:56:19 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 3/9] build: Check that mlockall() exists
Date: Fri,  3 Jul 2020 15:56:08 +0100
Message-Id: <20200703145614.16684-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200703145614.16684-1-peter.maydell@linaro.org>
References: <20200703145614.16684-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x343.google.com
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
Cc: David Carlier <devnexen@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David CARLIER <devnexen@gmail.com>

Instead of assuming that all POSIX platforms provide mlockall(),
test for it in configure. If the host doesn't provide this platform
then os_mlock() will fail -ENOSYS, as it does already on Windows.

This is necessary for Haiku, which does not have mlockall().

Signed-off-by: David Carlier <devnexen@gmail.com>
[PMM: Expanded commit message]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 configure  | 15 +++++++++++++++
 os-posix.c |  4 ++++
 2 files changed, 19 insertions(+)

diff --git a/configure b/configure
index 5455ae10d05..ddc53d873ef 100755
--- a/configure
+++ b/configure
@@ -2392,6 +2392,18 @@ else
   pty_h=no
 fi
 
+cat > $TMPC <<EOF
+#include <sys/mman.h>
+int main(int argc, char *argv[]) {
+    return mlockall(MCL_FUTURE);
+}
+EOF
+if compile_prog "" "" ; then
+  have_mlockall=yes
+else
+  have_mlockall=no
+fi
+
 #########################################
 # vhost interdependencies and host support
 
@@ -7865,6 +7877,9 @@ fi
 if test "$pty_h" = "yes" ; then
   echo "CONFIG_PTY=y" >> $config_host_mak
 fi
+if test "$have_mlockall" = "yes" ; then
+  echo "CONFIG_MLOCKALL=y" >> $config_host_mak
+fi
 if test "$fuzzing" = "yes" ; then
   if test "$have_fuzzer" = "yes"; then
     FUZZ_LDFLAGS=" -fsanitize=address,fuzzer"
diff --git a/os-posix.c b/os-posix.c
index 3cd52e1e700..e02b566940c 100644
--- a/os-posix.c
+++ b/os-posix.c
@@ -337,6 +337,7 @@ bool is_daemonized(void)
 
 int os_mlock(void)
 {
+#if defined CONFIG_MLOCKALL
     int ret = 0;
 
     ret = mlockall(MCL_CURRENT | MCL_FUTURE);
@@ -345,4 +346,7 @@ int os_mlock(void)
     }
 
     return ret;
+#else
+    return -ENOSYS;
+#endif
 }
-- 
2.20.1


