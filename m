Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF5B0C55179
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 17:53:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46C0F2225F
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 17:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qYr1z1BW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46C0F2225F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVIIt-0005IP-6Q
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 13:53:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51868)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kVI3w-0006dv-MH
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 13:38:12 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:51912)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kVI3u-0006TE-4k
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 13:38:12 -0400
Received: by mail-pj1-x1041.google.com with SMTP id a17so1522241pju.1
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 10:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=r7Om/lCAM0XeGEoR/BbgvQnU929VV6uqCsbicYkIs8s=;
 b=qYr1z1BWmJW5qCiXztlPzE77U7HI/tv+Fn9oyCjz80MNczmRmWceWQ3a/P2G7BCRjI
 69GuBi43EJWPrCbM17af429pS6BpZxy33t/0XYxuVM+kU2J76RVyAEv7UDEeUZueGAGQ
 QHuX9AOxfymzDRy93dJl9WS0xarxBV1Qcy2hPSKXNDn1FHCxMz4dPdTuahJvptxyYnDf
 2cIOL/hFYzRqwl9rdIGbYh+I04E+AexxBY+k0JKQXB1xGF+MhWA1Of0+7NecPuuvUY3f
 5A6V1utr6vZbnCxS+dPBMHBt59eZz8H5yUSwlK7lz3uRMKBjWw0FOTUjBUCrUntt7tsZ
 sM6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=r7Om/lCAM0XeGEoR/BbgvQnU929VV6uqCsbicYkIs8s=;
 b=qCYOY2dguwIZiLjSBhEWuuqRZojk4h/YHdqa92fV9isLCn5+V2sz+qEhcwTNDPQJBE
 xnB3XAKn8ucgxrksEVQmS9Er4VwXQ1vAjrn12i9oExR7n5Nbjzt1FsgQ7hHjFIZyRFhL
 9rF3owZvpzmBVlkhk91/6T3IGSsoA12ag1ZdfG1jZIFRfixWWUAtg/nrXzxAYkSsGpAb
 dUkkhWS3CNuLZzCy6z8fCVtLAi55BJyh+MjkM5btpwXm+JZedwBS4nx5v+kTsphBmwRU
 wDljNTAaXga+e/QJnrEgpV5Y0eV9EsUbGmsFyAwnYkVCOsIwMUOVoJjpIrsLt8L3ZVgV
 zUAw==
X-Gm-Message-State: AOAM53287tWN+C8j5YBQ82q6ZeyyQSRRDQDuZM3raIp0mjl7ttJQDF8I
 NAVw+ouY4qvlz1OpGwyT3sqoonD4VstrRw==
X-Google-Smtp-Source: ABdhPJwwD4km7ClYoUoGlQfkhMMDuu2Efab+WUrYUMUH9mZG02hDL5cJo0odxneYnDEhjkEBNbRNOw==
X-Received: by 2002:a17:90b:90c:: with SMTP id
 bo12mr4237908pjb.7.1603301885194; 
 Wed, 21 Oct 2020 10:38:05 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id h5sm2928829pfh.9.2020.10.21.10.38.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2020 10:38:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v12 09/12] linux-user/elfload: Use Error for load_elf_interp
Date: Wed, 21 Oct 2020 10:37:46 -0700
Message-Id: <20201021173749.111103-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201021173749.111103-1-richard.henderson@linaro.org>
References: <20201021173749.111103-1-richard.henderson@linaro.org>
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
Cc: peter.maydell@linaro.org
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


