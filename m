Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB0FC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:13:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C62E2072D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VizsTQEl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C62E2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juzDP-0001Jj-Ld
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 10:13:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35154)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1juzAw-0005IT-Mz
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:11:22 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:39556)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1juzAt-0006dN-Ng
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:11:22 -0400
Received: by mail-wm1-x341.google.com with SMTP id w3so13308120wmi.4
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 07:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=sFunfT5Kh2K53TfOYy7GzkQp2kpbcgHJUtW52Jf/d80=;
 b=VizsTQEli1zuwZ573ecUiTZURo/ruIpNIlnN9aj6hDn3D9I765nk5tcZGZjgq/wBRW
 y4xe6pULMEKyjaSv0egAQ++cyXZNBxRqJ8+bFNvS/mhdvjQJ5l0N+Yi7awYW719sd18U
 aH9piBokp6Rb4XmNi6pk3EzwaTRpLdH82KHD5JLqub1CdCj/UdDrNwHc+IwapS7vRFBv
 rYlIiVGa8bmp88zOeZy9ZH6qmC7X1qOxtiFxFUSbmYUCv8xYkLufcLna/rGdhmM2Yczz
 lEVpQFTLtq0mWF/4ZHR5NVnbiARqeh6OzqWWymdkrNHqhveg17UOENiY0iewYx7wxlHJ
 WQlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sFunfT5Kh2K53TfOYy7GzkQp2kpbcgHJUtW52Jf/d80=;
 b=SIfygOBEHc7y6vObXSh94Y9aFDPPJqMV1Y3/PqFNjnJmW5HafeHPP7NhmHTb+PJ1AZ
 eqqvnvTEVitkuH5KddSyrPpqiC1un20yfYRee0V+iwm5JjN7MGtWe3Iz0xPO1AAUZjFk
 ieYHGEh874UpuGnnRiCvR01DXY+iwIvG/uNU658yhS7cI7/2e3YclxHbJncFM+mD/1lw
 CIg/KWyJDqpUoFzFjYVVoa2TIvegKorf5KKxZiPAy0lexhqWcx70xVxKaY0Ex8abkt21
 lwyk2/bCqpktSb9IONdrJTt74VMGGChJrrrmf4ku3g855r8+RxgOP2LyqKwTwyvoFX7q
 hufg==
X-Gm-Message-State: AOAM532k1gGXN73d97aHQJpXVFhCUVPJ7dJu0lTKgNRaPIhENT4o+TIY
 wCqyx2sDeQ44PK8eNnwsqRmvwfVS7jm15Q==
X-Google-Smtp-Source: ABdhPJysyS+TLH0bjm66fwmVHtr0fArUAnFZxH5LPehhDF8gNeWYVzIpY6f8tvR2tVgC2i2truEulQ==
X-Received: by 2002:a1c:2349:: with SMTP id j70mr182824wmj.22.1594649478138;
 Mon, 13 Jul 2020 07:11:18 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c136sm24031297wmd.10.2020.07.13.07.11.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2020 07:11:17 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/25] build: Check that mlockall() exists
Date: Mon, 13 Jul 2020 15:10:49 +0100
Message-Id: <20200713141104.5139-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200713141104.5139-1-peter.maydell@linaro.org>
References: <20200713141104.5139-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x341.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David CARLIER <devnexen@gmail.com>

Instead of assuming that all POSIX platforms provide mlockall(),
test for it in configure. If the host doesn't provide this platform
then os_mlock() will fail -ENOSYS, as it does already on Windows.

This is necessary for Haiku, which does not have mlockall().

Signed-off-by: David Carlier <devnexen@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20200703145614.16684-4-peter.maydell@linaro.org
[PMM: Expanded commit message; rename to HAVE_MLOCKALL]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 configure  | 15 +++++++++++++++
 os-posix.c |  4 ++++
 2 files changed, 19 insertions(+)

diff --git a/configure b/configure
index 978505611b1..429c938708e 100755
--- a/configure
+++ b/configure
@@ -2408,6 +2408,18 @@ else
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
 
@@ -7902,6 +7914,9 @@ fi
 if test "$pty_h" = "yes" ; then
   echo "HAVE_PTY_H=y" >> $config_host_mak
 fi
+if test "$have_mlockall" = "yes" ; then
+  echo "HAVE_MLOCKALL=y" >> $config_host_mak
+fi
 if test "$fuzzing" = "yes" ; then
   if test "$have_fuzzer" = "yes"; then
     FUZZ_LDFLAGS=" -fsanitize=address,fuzzer"
diff --git a/os-posix.c b/os-posix.c
index 3cd52e1e700..b674b20b1b1 100644
--- a/os-posix.c
+++ b/os-posix.c
@@ -337,6 +337,7 @@ bool is_daemonized(void)
 
 int os_mlock(void)
 {
+#ifdef HAVE_MLOCKALL
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


