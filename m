Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5068BC4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 16:18:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A95C42224A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 16:18:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ddOfYoVo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A95C42224A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUuLY-0007gW-Fs
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 12:18:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37966)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUu1P-0005f4-5y
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 11:57:59 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:38642)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUu1N-0003yd-08
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 11:57:58 -0400
Received: by mail-wr1-x443.google.com with SMTP id n18so2800834wrs.5
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 08:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=XT6Iram+4m2dzPuKNhFGf6Ll1daGrbT5FFIybyhVjnU=;
 b=ddOfYoVovijzVtt/7T8yhNCSKRIw76G+qZX6iaFVStKIH+9a3Clrt5DyzVD7auzW9t
 rJbrjel8vwN8cBaZbuizZubIOoovRdx8DWbMvkOkoXBl0wWnPIdAB+oDLiMxB17JPgz3
 l/1+E2JNTbMGDczisPgGtj0SReaTLfSd2fPxtvC9Lt5kVtqAM1YTlofviEOy/r1ppSB5
 2JOeRjuHeKhInVvPVsZ0rZDU8J4gDsWbhk3Nxbck8XZxn7RtIH3cdDB2VSyqQU6Pi2dx
 PyrMf4z2BDikVEA5LiPFAxe+/zMiifX52zmzPDts7PfWgp7yrj3vpv29DpNybp0ZWgHw
 /GEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XT6Iram+4m2dzPuKNhFGf6Ll1daGrbT5FFIybyhVjnU=;
 b=ACV3DtcyYaJvUM2hMhuiLn105SNyCPbKjjYYgS+qN4r5I1yzYPMBvJNZ8e9j8efWcN
 xTWg0T56GOXU6WuK3lpTGicZY9/cJ5HvwH+nTiv16Baf3/F349RkqYobAFZDRPFC8fju
 w8FKtgfRH0exENjcqF4zMFwmCtauF50TWLFExk6Litliohls0nK6j1/6Vl+DEM7G/3Qj
 qIYpJwH6lFu/+RyGBFJ6tcJNxqBIQuS31wxeFDcKxL8RMDsnRYeM9sGGkR2p4cDEPKVh
 Fsem6xUe7loIA+GdVn6BtlV3DwcG695NACSWfuCOIo/BUncSerXlk/xiHOBI9zan7Xmr
 NbeA==
X-Gm-Message-State: AOAM530XBsMQ/yR1QkLQnzGCg/JbuL9stQjOPD0JngXLR/Hmhru2gghy
 AGEGeaKuq9fK0CA7wFLgpuCO9oXefQo25g==
X-Google-Smtp-Source: ABdhPJyxGpL9a7/O76L4j2qJ8fUQiO4aa9gpT9QdqSbUVXwyMwcf4pJIzry2yy+ZAVozL8OLq8ZMdw==
X-Received: by 2002:adf:f3d2:: with SMTP id g18mr4188542wrp.367.1603209474265; 
 Tue, 20 Oct 2020 08:57:54 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id v6sm3780205wrp.69.2020.10.20.08.57.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2020 08:57:53 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 38/41] linux-user/elfload: Use Error for load_elf_interp
Date: Tue, 20 Oct 2020 16:56:53 +0100
Message-Id: <20201020155656.8045-39-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201020155656.8045-1-peter.maydell@linaro.org>
References: <20201020155656.8045-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x443.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

This is slightly clearer than just using strerror, though
the different forms produced by error_setg_file_open and
error_setg_errno isn't entirely convenient.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20201016184207.786698-10-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 linux-user/elfload.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 56fbda93d02..04c04bc2602 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2675,26 +2675,27 @@ static void load_elf_interp(const char *filename, struct image_info *info,
                             char bprm_buf[BPRM_BUF_SIZE])
 {
     int fd, retval;
+    Error *err = NULL;
 
     fd = open(path(filename), O_RDONLY);
     if (fd < 0) {
-        goto exit_perror;
+        error_setg_file_open(&err, errno, filename);
+        error_report_err(err);
+        exit(-1);
     }
 
     retval = read(fd, bprm_buf, BPRM_BUF_SIZE);
     if (retval < 0) {
-        goto exit_perror;
+        error_setg_errno(&err, errno, "Error reading file header");
+        error_reportf_err(err, "%s: ", filename);
+        exit(-1);
     }
+
     if (retval < BPRM_BUF_SIZE) {
         memset(bprm_buf + retval, 0, BPRM_BUF_SIZE - retval);
     }
 
     load_elf_image(filename, fd, info, NULL, bprm_buf);
-    return;
-
- exit_perror:
-    fprintf(stderr, "%s: %s\n", filename, strerror(errno));
-    exit(-1);
 }
 
 static int symfind(const void *s0, const void *s1)
-- 
2.20.1


