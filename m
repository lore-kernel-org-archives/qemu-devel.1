Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF13C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 06:34:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3CE820658
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 06:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F9+l6cOY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3CE820658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jy8Ki-0006tW-W9
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 02:34:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41326)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jy8Fg-0007AU-DH
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 02:29:16 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:37898)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jy8Fe-0006vC-Tc
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 02:29:16 -0400
Received: by mail-wm1-x342.google.com with SMTP id f18so837617wml.3
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2020 23:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UjtgMi3yK33ZjhmVkRGlgMB3WMVIed90Ngc7ulb8I7c=;
 b=F9+l6cOYOB3MiOiDh5JXDMQ70OsszixR6C/OvcWj6quO1dKI6derFoOEOhHyEKfPFz
 Eit2iB91yDBreCmGOz8kSlIVl09cvJ5ho7vwrhW3lGlZ27BkLORTFCpqFmGiksK/qqsk
 FfxuREQa8EUAktPQ4+u5RlfQn3fQbEpbx0dLwp1pDnj0Dt/7P+HpoX7HKSkshl//6k1w
 6J5Xo+CKkeSSwb9lb870UfGReYkdJ21h6FsJDhbOjJEvVs+5ucHD9Mxeps8JdmgiKA42
 465ZwxAg7L2TmHw/240rdbK7QuG3W50rht8s5UDbaRlJZuSlM2rumzVILJKDTKJstxdP
 f54Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UjtgMi3yK33ZjhmVkRGlgMB3WMVIed90Ngc7ulb8I7c=;
 b=Mk0F+vJD+zY8LekJxvw05wdyEOu9X1T7flxUtDblMq5KELJ3iV/NGinfbSVDgs8LTC
 B0wW+Stl7SJks8DXMKvsv35n9+F8bYqPpV53397hHCt7cTHfzCV6wUVeyl0PA7sk3xt6
 wOTzJpHmATkLXmTo4Bw8t93c4/attVtHx0jbpC3af8sQbbh1vctknUqH9APqF3Xmstqt
 ouyZ7+wnE87s8khNzGilSz0RA+QZ4RPi9nr92BSJuF40kWCiadImi6vrQZW7QuRfsqCf
 lUCLmdMkhyFct00I4j5MG36hlPRmUmSu2924i1tdGyLyL03eXY39qHbdFDl5FhqRiaxy
 eElQ==
X-Gm-Message-State: AOAM530tPP/51DuL5N6lvYXf2hHbYNK9W2XO8jtAHfomQpEAeAJWeK62
 3ox89w7E8VyO++TmfoIbmlnXlw==
X-Google-Smtp-Source: ABdhPJzj/cxSWlnClphOoG2kHsrh4fM/Y6VUr/jSzMd/1izruW9cbILADXaK4DmHqh3sT9TPpNSFvw==
X-Received: by 2002:a1c:dd86:: with SMTP id u128mr7085401wmg.123.1595399353628; 
 Tue, 21 Jul 2020 23:29:13 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id j8sm24537574wrd.85.2020.07.21.23.29.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2020 23:29:09 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7172A1FF91;
 Wed, 22 Jul 2020 07:29:03 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 05/12] util/oslib-win32: add qemu_get_host_physmem
 implementation
Date: Wed, 22 Jul 2020 07:28:55 +0100
Message-Id: <20200722062902.24509-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200722062902.24509-1-alex.bennee@linaro.org>
References: <20200722062902.24509-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x342.google.com
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
 richard.henderson@linaro.org, f4bug@amsat.org, cota@braap.org,
 Stefan Weil <sw@weilnetz.de>, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It seems GetPhysicallyInstalledSystemMemory isn't available in the
MinGW headers so we have to declare it ourselves. Compile tested only.

Cc: Stefan Weil <sw@weilnetz.de>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 util/oslib-win32.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/util/oslib-win32.c b/util/oslib-win32.c
index 31030463cc9..f0f94833197 100644
--- a/util/oslib-win32.c
+++ b/util/oslib-win32.c
@@ -43,6 +43,8 @@
 /* this must come after including "trace.h" */
 #include <shlobj.h>
 
+WINBASEAPI BOOL WINAPI GetPhysicallyInstalledSystemMemory (PULONGLONG);
+
 void *qemu_oom_check(void *ptr)
 {
     if (ptr == NULL) {
@@ -831,6 +833,15 @@ char *qemu_get_host_name(Error **errp)
 
 size_t qemu_get_host_physmem(void)
 {
-    /* currently unimplemented */
-    return 0;
+    ULONGLONG mem;
+
+    if (GetPhysicallyInstalledSystemMemory(&mem)) {
+        if (mem > SIZE_MAX) {
+            return SIZE_MAX;
+        } else {
+            return mem;
+        }
+    } else {
+        return 0;
+    }
 }
-- 
2.20.1


