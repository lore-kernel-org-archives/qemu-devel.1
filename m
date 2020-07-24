Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6384FC433E3
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 06:50:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CE1620714
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 06:50:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j7L1mrR/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CE1620714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyrWy-0003f5-CI
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 02:50:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37914)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jyrSK-00045v-TN
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 02:45:20 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:37130)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jyrSI-0000Iq-Q6
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 02:45:20 -0400
Received: by mail-wr1-x441.google.com with SMTP id y3so7250838wrl.4
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 23:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6wHpeGuhHza62S57f3L4nQWiCyQTiRLWqfdUIbTB/QU=;
 b=j7L1mrR/nN3yZacC6ub2KAk/Ft5tc+uOdKb66/fdkni4xB6IYfv4VZYh08Ew0yGYxl
 VIju40U9ZWfbT+Dg06X+HGvQiKwUYQAIVA43uMgzhZlMN5KUnVdqciGmlHKuFhq7xmlh
 UR5zpzHqydHTDIkPHVBTqh7kCUkynlmJYFz6q2X5IDYGVg82M+d6epLOVX21M9mXCUlk
 KUkJnqJGJmop9PJob9tysXavxwuF5T70FdDRN7RHIyWq3dIXtYOP26eE2serl+EINi2k
 4jcwzUI8lBGu5EUh7NMDjw25Jz74oegMRjq+iJ1vb/GGt5ANnYX7YhIWMBUMXYcj0LlZ
 DJ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6wHpeGuhHza62S57f3L4nQWiCyQTiRLWqfdUIbTB/QU=;
 b=gGfr65+a/oaFpngPUmrZtNwoFKy6uu5q3sfJ6gL06hI6uvZmUBjY42pgQioJESxIXs
 0bGL1khij9zRcyCbLsRPB9h85A6v2Tuzc2XFKW2m8ovnV8Iq+EyrScPkWyUm5h6nKsvc
 W56tVm5idlC26weyb8fJI5qowwKYAJikrEiT48i8tcdP9Ph+wR2UUTB4WR6IJaaCsHCY
 lG9MbCJH1G3DKJRVbZO55XeQBf56gwf+5WG7JB8xpqnTNg00VGKEWaPe7358lsWQcOB+
 7tzddNmFJgcnAv2v1hR2bM01dj5GE2MdwDHKL2v0EzrUri5+eC6AkTEBLo3Lol34D3Hy
 Op4Q==
X-Gm-Message-State: AOAM531Bf0Ruwml9R+6IQZz4CIkbUitbIBOXeUaNTxx//xL3NdCzMzuR
 6rO2Ze9/maaeFkp2S5qzUoUduw==
X-Google-Smtp-Source: ABdhPJz9e5o2JSFQyrd5jW/iHweQZnUuOUUM/HBDw+X3tILAWcNLb/XYFWEhhYffA5QgpAOYiaximA==
X-Received: by 2002:adf:8bd3:: with SMTP id w19mr7025037wra.167.1595573117385; 
 Thu, 23 Jul 2020 23:45:17 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z16sm165588wrr.35.2020.07.23.23.45.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2020 23:45:14 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BA02C1FF92;
 Fri, 24 Jul 2020 07:45:09 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 06/16] accel/tcg: better handle memory constrained systems
Date: Fri, 24 Jul 2020 07:44:59 +0100
Message-Id: <20200724064509.331-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200724064509.331-1-alex.bennee@linaro.org>
References: <20200724064509.331-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x441.google.com
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
Cc: fam@euphon.net, berrange@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 Christian Ehrhardt <christian.ehrhardt@canonical.com>, cota@braap.org,
 Paolo Bonzini <pbonzini@redhat.com>, aurelien@aurel32.net,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It turns out there are some 64 bit systems that have relatively low
amounts of physical memory available to them (typically CI system).
Even with swapping available a 1GB translation buffer that fills up
can put the machine under increased memory pressure. Detect these low
memory situations and reduce tb_size appropriately.

Fixes: 600e17b2615 ("accel/tcg: increase default code gen buffer size for 64 bit")
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Christian Ehrhardt <christian.ehrhardt@canonical.com>

---
v3
  - use slightly tweak the logic to taper off more nicely
---
 accel/tcg/translate-all.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 2afa46bd2b1..2d83013633b 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -976,7 +976,12 @@ static inline size_t size_code_gen_buffer(size_t tb_size)
 {
     /* Size the buffer.  */
     if (tb_size == 0) {
-        tb_size = DEFAULT_CODE_GEN_BUFFER_SIZE;
+        size_t phys_mem = qemu_get_host_physmem();
+        if (phys_mem == 0) {
+            tb_size = DEFAULT_CODE_GEN_BUFFER_SIZE;
+        } else {
+            tb_size = MIN(DEFAULT_CODE_GEN_BUFFER_SIZE, phys_mem / 8);
+        }
     }
     if (tb_size < MIN_CODE_GEN_BUFFER_SIZE) {
         tb_size = MIN_CODE_GEN_BUFFER_SIZE;
-- 
2.20.1


