Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A59FC2D0C1
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 11:00:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECE7A24672
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 11:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M8EA8SP2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECE7A24672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihtXf-0004bS-FN
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 06:00:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41122)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ihtNX-00070b-I5
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 05:50:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ihtNW-0001F7-Bi
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 05:49:59 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:51621)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ihtNW-0001Ah-0b
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 05:49:58 -0500
Received: by mail-wm1-x32d.google.com with SMTP id d73so4946926wmd.1
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 02:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=H8z1MrJa+EblW1lPryKy7epJgduWdqrAx6IGD9b/tew=;
 b=M8EA8SP2f64jGJ37MO6QOsBQwhO9mff4UYO8O/sNtFKyGReTH+57VN2c1fflGL9C9Z
 KogucPBhkiu9rQycCsSNoxFyO/2d1k+dHcWqxXWLvXU+X+wPiM3qr1HpWVXwKUbqQNV0
 1p02DRS4c2+vvkCApkVpFbQndalxR75ww89Ttb57DFO/KKKnYBbFfHIhsQRNCJI2o7g8
 JV+ifsQaRWc6tyFK3y6uH2m3nlWwu5C63TNmriU10Vn0TtZGdljwJXgWnoIEcCR7lAJ8
 SUQTfXaPDHjcK8E9DDj8qH/+sDn/mA6ggEnf7M5PAqy3rHBvLgUatiZ+2q4t59m2qm5w
 PbRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=H8z1MrJa+EblW1lPryKy7epJgduWdqrAx6IGD9b/tew=;
 b=RQkwhlSJ3ZYueoBLaa5pOMvilp11MVTdnCdy09//I/l/w5igXIHqhvHNdoTz1ZJENu
 2ut63VPWUqbmttAb4SOHhuLmq8jO7aXm1i6xSNg4OQlXwlH2IG133Sz0TIbyg3nbC85r
 Z83Ludc3Oy+kQcG3h0cqAJV+7YsFQkzwwWuRDcF2mEVuF3qMtctUKrMvTvH+KEXFbU0s
 3AtxN/IgA9ctwVwJzw9o8HBsvuF6zFfvf9Ywh469WZFnT5fRjj3H3PLVZPuo3fis4DTO
 lRf7DE5bgjFmhi+rgdbgEy6UAdxF6r6IEvgIakkvjRotkzueDxO8JrDobxkzioDexCxO
 3JuQ==
X-Gm-Message-State: APjAAAV/PtSkmgp5JD4l2//4/lpWsxFOomzm+9JI7VRYho94YWTkdN4h
 BkZXuCqfJ01dlvhtFUG7I/yx2rNuBo0=
X-Google-Smtp-Source: APXvYqw97how5nI+H0z3MqYbW/cgyaTmQsz5lDSv2OO16dJpqjzAQNcGH2gRfIVTiYErkGXvzgLxXg==
X-Received: by 2002:a7b:cd0a:: with SMTP id f10mr9648646wmj.56.1576752597021; 
 Thu, 19 Dec 2019 02:49:57 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s15sm6340132wrp.4.2019.12.19.02.49.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2019 02:49:51 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 72DB31FFAB;
 Thu, 19 Dec 2019 10:49:36 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 21/25] linux-user: add target_mmap_complete tracepoint
Date: Thu, 19 Dec 2019 10:49:30 +0000
Message-Id: <20191219104934.866-22-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191219104934.866-1-alex.bennee@linaro.org>
References: <20191219104934.866-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32d
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For full details we also want to see where the mmaps end up.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20191205122518.10010-4-alex.bennee@linaro.org>

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index f4f10deaeac..0b1b43ac3c0 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -538,8 +538,8 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
  the_end1:
     page_set_flags(start, start + len, prot | PAGE_VALID);
  the_end:
+    trace_target_mmap_complete(start);
 #ifdef DEBUG_MMAP
-    printf("ret=0x" TARGET_ABI_FMT_lx "\n", start);
     page_dump(stdout);
     printf("\n");
 #endif
diff --git a/linux-user/trace-events b/linux-user/trace-events
index 8d8d4c3c68c..6d6aeef7b52 100644
--- a/linux-user/trace-events
+++ b/linux-user/trace-events
@@ -15,3 +15,4 @@ user_s390x_restore_sigregs(void *env, uint64_t sc_psw_addr, uint64_t env_psw_add
 # mmap.c
 target_mprotect(uint64_t start, uint64_t len, int flags) "start=0x%"PRIx64 " len=0x%"PRIx64 " prot=0x%x"
 target_mmap(uint64_t start, uint64_t len, int pflags, int mflags, int fd, uint64_t offset) "start=0x%"PRIx64 " len=0x%"PRIx64 " prot=0x%x flags=0x%x fd=%d offset=0x%"PRIx64
+target_mmap_complete(uint64_t retaddr) "retaddr=0x%"PRIx64
-- 
2.20.1


