Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE2CC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 18:18:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70F772065C
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 18:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uRuXKhan"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70F772065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYvxW-0000Pl-On
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 14:18:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36440)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jYvpZ-0003qA-QU
 for qemu-devel@nongnu.org; Wed, 13 May 2020 14:10:09 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a]:42175)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jYvpW-0000Me-E1
 for qemu-devel@nongnu.org; Wed, 13 May 2020 14:10:09 -0400
Received: by mail-pl1-x62a.google.com with SMTP id k19so136966pll.9
 for <qemu-devel@nongnu.org>; Wed, 13 May 2020 11:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JSmowOO+YiAA0eSN0s8xOlbrTguVMlQ6LjWvJ71pNA4=;
 b=uRuXKhanODepsH+nLE0Bb8fz3ZKAZFQjhC1YneZy2V5DmXo9Afaj/r790teAy/xf4P
 qEX9WC/A+s00ibSqa2gk2EDgt3CJzKts3E1vXGhdTnqjlO4rVwKTC1lZp0EZrs31nDC9
 YW6msOereGCOEgUxgkrQZssyah5L+Zd0XJRgmr/OHQ8S9JOtAmLVTtsrdvb2vyJNA8V9
 QQy36j+xLsHIkeGZsYTED/iAj8U5rSKIQ9AUIsHOtj8yVDAzmVmVjnrKdR//scCYcJ9g
 eO9W8jodpSbuXG38j2sK4P1sM+TzNt/EgncxOCtQuIHPaFFAfOhIaU1LP/UBKaWjSHZ3
 2ZlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JSmowOO+YiAA0eSN0s8xOlbrTguVMlQ6LjWvJ71pNA4=;
 b=JvvGSQ94vva7VwMMK5vxRRk9RRrcW/f0OOKNqK2RciedXs7i6Ngtr6rqWA/rE1h+ZI
 gG3u+0QVxAm+JFTZCnFMJC5IqtiEmbL1s9lTbYE9Pb2XL3rO2V3wWHSjwqJAvnhCZB7W
 YZdF9KcTdUURENOSpaxdIevymAUDkS/OOMKgMV3fBKbBC6EAGqn9SibY0Sixowa4mplL
 O4qIu7eWJ2nvjtZWTPCEA7HO8KR29fxjDdLAtm2S+Jx4p89OyGa7dimmWUvYzUllJjed
 Sn4E3B3/8tMP0w1nIRQEKCBYMAphsmE217cVhRs6uWPK4Me4ZK05vkSQr2WJ0DGV/kiR
 5EDQ==
X-Gm-Message-State: AOAM531HSTl/sOSv8eOeE/sAoFvUcH0S/Fj8FL1BhXQrdZRM1FfutTkZ
 ALHYRJsU685Xmjp6SLYkIplPDPnC50o=
X-Google-Smtp-Source: ABdhPJw7g4PxyzaTN7O9I3mh7nZi82hE9YDbRpG8X7a6cvSiMopn09USryoCl4EU+/oTnJOOJwIfoA==
X-Received: by 2002:a17:90a:be09:: with SMTP id
 a9mr2678962pjs.165.1589393403834; 
 Wed, 13 May 2020 11:10:03 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id i185sm197361pfg.14.2020.05.13.11.10.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2020 11:10:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RISU 6/9] Add magic and size to the trace header
Date: Wed, 13 May 2020 11:09:50 -0700
Message-Id: <20200513180953.20376-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200513180953.20376-1-richard.henderson@linaro.org>
References: <20200513180953.20376-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Sanity check that we're not getting out of sync with
the trace stream.  This will be especially bad with
the change in size of the sve save data.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 risu.h    |  6 +++++-
 reginfo.c | 42 ++++++++++++++++++++++++++++++++----------
 2 files changed, 37 insertions(+), 11 deletions(-)

diff --git a/risu.h b/risu.h
index e2b4508..3fc198f 100644
--- a/risu.h
+++ b/risu.h
@@ -62,10 +62,14 @@ extern void *memblock;
 struct reginfo;
 
 typedef struct {
-   uintptr_t pc;
+   uint32_t magic;
+   uint32_t size;
    uint32_t risu_op;
+   uintptr_t pc;
 } trace_header_t;
 
+#define RISU_MAGIC  (('R' << 24) | ('i' << 16) | ('S' << 8) | 'u')
+
 /* Functions operating on reginfo */
 
 /* Function prototypes for read/write helper functions.
diff --git a/reginfo.c b/reginfo.c
index 1b2a821..a4f7da6 100644
--- a/reginfo.c
+++ b/reginfo.c
@@ -26,20 +26,45 @@ int send_register_info(write_fn write_fn, void *uc)
     struct reginfo ri;
     trace_header_t header;
     int op;
+    void *extra;
 
     reginfo_init(&ri, uc);
     op = get_risuop(&ri);
 
     /* Write a header with PC/op to keep in sync */
+    header.magic = RISU_MAGIC;
     header.pc = get_pc(&ri);
     header.risu_op = op;
+
+    switch (op) {
+    case OP_TESTEND:
+    case OP_COMPARE:
+    default:
+        header.size = reginfo_size();
+        extra = &ri;
+        break;
+
+    case OP_SETMEMBLOCK:
+    case OP_GETMEMBLOCK:
+        header.size = 0;
+        extra = NULL;
+        break;
+
+    case OP_COMPAREMEM:
+        header.size = MEMBLOCKLEN;
+        extra = memblock;
+        break;
+    }
+
     if (write_fn(&header, sizeof(header)) != 0) {
         return -1;
     }
+    if (extra && write_fn(extra, header.size) != 0) {
+        return -1;
+    }
 
     switch (op) {
     case OP_TESTEND:
-        write_fn(&ri, reginfo_size());
         /* if we are tracing write_fn will return 0 unlike a remote
            end, hence we force return of 1 here */
         return 1;
@@ -51,14 +76,9 @@ int send_register_info(write_fn write_fn, void *uc)
                               get_reginfo_paramreg(&ri) + (uintptr_t)memblock);
         break;
     case OP_COMPAREMEM:
-        return write_fn(memblock, MEMBLOCKLEN);
-        break;
     case OP_COMPARE:
     default:
-        /* Do a simple register compare on (a) explicit request
-         * (b) end of test (c) a non-risuop UNDEF
-         */
-        return write_fn(&ri, reginfo_size());
+        break;
     }
     return 0;
 }
@@ -84,7 +104,7 @@ int recv_and_compare_register_info(read_fn read_fn,
         return -1;
     }
 
-    if (header.risu_op != op) {
+    if (header.magic != RISU_MAGIC || header.risu_op != op) {
         /* We are out of sync */
         resp = 2;
         resp_fn(resp);
@@ -101,7 +121,8 @@ int recv_and_compare_register_info(read_fn read_fn,
         /* Do a simple register compare on (a) explicit request
          * (b) end of test (c) a non-risuop UNDEF
          */
-        if (read_fn(&apprentice_ri, reginfo_size())) {
+        if (header.size != reginfo_size() ||
+            read_fn(&apprentice_ri, header.size)) {
             packet_mismatch = 1;
             resp = 2;
         } else if (!reginfo_is_eq(&master_ri, &apprentice_ri)) {
@@ -121,7 +142,8 @@ int recv_and_compare_register_info(read_fn read_fn,
         break;
     case OP_COMPAREMEM:
         mem_used = 1;
-        if (read_fn(apprentice_memblock, MEMBLOCKLEN)) {
+        if (header.size != MEMBLOCKLEN ||
+            read_fn(apprentice_memblock, MEMBLOCKLEN)) {
             packet_mismatch = 1;
             resp = 2;
         } else if (memcmp(memblock, apprentice_memblock, MEMBLOCKLEN) != 0) {
-- 
2.20.1


