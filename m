Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBFCEC433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 18:55:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 213B420FC3
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 18:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nWnfj2+N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 213B420FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTUst-0003vi-1r
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 14:55:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55412)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kTUgf-0000cw-0G
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 14:42:45 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:36805)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kTUgM-00029T-4T
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 14:42:44 -0400
Received: by mail-pj1-x1041.google.com with SMTP id a1so1995697pjd.1
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2020 11:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=r7Om/lCAM0XeGEoR/BbgvQnU929VV6uqCsbicYkIs8s=;
 b=nWnfj2+NfwHyIX0khnpHi9q/tGs5ljebusoiCWy+naSMt1TlymRG1STYDRb8oYYr1w
 BMhKdsV2CufxXdeqs2lK2WMae0E6cV6p/ik9hhdmaaniQqxGQco4PiicvdaSz+4Jy5cD
 FpRr6Ty8xH5bfIv+ekHLKCgJBC8pPlEQFe6K4SRDGg1MrZSd7eX+Yj08Lu8VL1my1yAH
 U1C4wI9dOEqwN5REY4zLyIcS2Pzj+tXtpf/X7XCnrE1hxV7rWTruH9eMRp47jsfkod1B
 tPuVK9up/E06g5bNCDEkKx7sdPsjMR/FXY17P/Q0ZyzDxtfTzBBZqykJSWv+liymJifR
 a/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=r7Om/lCAM0XeGEoR/BbgvQnU929VV6uqCsbicYkIs8s=;
 b=R7wf4X7NZDnZSj2sdX6nfN9JZSip07j+2ET9Pfo+dOHfsJWxPNtmDoQkaAZmI8OMQf
 06LSkfvG2sXKH9oxZVESTxylWblplHUp/48Y99Zn6NSANmsbfKggVXgcfsiIC8ag5WeS
 R1I1dT0DNWgpSbBLJxvn4J+jK0Ez4ZsgBvxJEm2kBelrIki8tvzQap6nG8IX9i/lEbmf
 Jw3u/m1Anr0dBXa5kNwh/vRi5TNS2KpAd5qDnmbIWqq1rCa6fpVP17/jMLgLcjmn4bUu
 O3aNRfW1IN6nNYA0O1JBsUtwXpghX4KgrNlRYBpBMC1+9Fc301YnJUYb7ckxXWdknNu9
 +X3Q==
X-Gm-Message-State: AOAM532LV89hNepts8IXGZKvKSmvILEWT9TTXyWs2J90e5oKrRZFLS/o
 dDLrYSokIQEy+7AAWlZhMEpqpgllK061Sw==
X-Google-Smtp-Source: ABdhPJxzALA8rRT2Is4FUDpsg+Rnn0qMwOW69zmiptnYlPkxr06rDzUX7Hyt8oLEJz6QZVjztVdGsw==
X-Received: by 2002:a17:90a:c285:: with SMTP id
 f5mr5594904pjt.87.1602873743570; 
 Fri, 16 Oct 2020 11:42:23 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id c15sm3426011pgg.77.2020.10.16.11.42.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2020 11:42:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v11 09/12] linux-user/elfload: Use Error for load_elf_interp
Date: Fri, 16 Oct 2020 11:42:04 -0700
Message-Id: <20201016184207.786698-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201016184207.786698-1-richard.henderson@linaro.org>
References: <20201016184207.786698-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1041.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org,
 laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is slightly clearer than just using strerror, though
the different forms produced by error_setg_file_open and
error_setg_errno isn't entirely convenient.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 56fbda93d0..04c04bc260 100644
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
2.25.1


