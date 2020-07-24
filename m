Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A219C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 06:48:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6129A2070B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 06:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uD93kTMU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6129A2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyrVi-0000ht-Jn
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 02:48:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37878)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jyrSJ-00043T-Gk
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 02:45:19 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43615)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jyrSH-0000HR-MT
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 02:45:19 -0400
Received: by mail-wr1-x442.google.com with SMTP id a15so7238333wrh.10
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 23:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=PghOm1+HJC0LKDphDTQ911GBY6Sy1XxnGIQ56Ai0urg=;
 b=uD93kTMUMIzqNhJQE3P6DjZGn2+oLx8iWdaH5ZCgvyaO+Kr0v4sAFab3bqoiVFbd3c
 7J8WLwAD2MrqeFh65JiwmKlS3Df6wQpG1zLynXt6TgQJmq+C7xfXnsbwEXZV2p6ueSRF
 c9X9OHiTFuLs6Jt048m2etTLXAy3RYIadFh6wnrihW3mIqrwIY5ThhhaBFn4s48RzQXJ
 TGmGo5E7+iVpkHpwVfRR70rfRY+GU3k8HSmIDh12nWh2CKadxkW5RBbfVmnnj+yvgVwu
 fA5m+a/1SQ9OxRGbr22VUPHMquSzsWtKxPbpHSEFz7z5YPYSBMQJpcsYjqg+pQjacrDZ
 RQlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PghOm1+HJC0LKDphDTQ911GBY6Sy1XxnGIQ56Ai0urg=;
 b=aR87FKphyuVMLVCgM2aSsknHShQTS9gVvn73rk6GCbi5FoABunQh2agaMFuWlSaY6D
 Bh360rnHtYmlMZkEPDEK5QX3cuC0hSzmGuoJQWL4J3XcT1NSNhd6AjSWHoEZPzw4QPrv
 rAQd4O0zX9bgrbwDzY7Md+ja0n4w4ccdg97R0H6oYTKCOI+ume0Qf124FxN205ZHRK09
 xtCnENsuqn4E3x6GnigFiNNaPDZ/gkDdW5dZ+4uqaLiAHTQPWe9kvJypUqIfJ5YBwB5D
 W9IQvzR5GlYm7PZsUxLzAx8c5cOM7Kex2OrMFE1g429fapzsYiXH87IaBINGisTKRopk
 aTtg==
X-Gm-Message-State: AOAM533idTKNqL9RRELAYuZgRLRV470GEsSvQxAcfezV51J+Gii7/7LL
 mIYxBVC/J61n4gh1E1n9d+gAFIAxJAE=
X-Google-Smtp-Source: ABdhPJzrowJMUZVXN00p3lDFkWhn+jsYosSnOTKJoxB+iEBnj3lzd3iAwu44fyJvbJFlcWCuW8INIQ==
X-Received: by 2002:adf:aace:: with SMTP id i14mr7033687wrc.236.1595573116344; 
 Thu, 23 Jul 2020 23:45:16 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 65sm209378wre.6.2020.07.23.23.45.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2020 23:45:13 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8F0AE1FF90;
 Fri, 24 Jul 2020 07:45:09 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v3 04/16] util: add qemu_get_host_physmem utility function
Date: Fri, 24 Jul 2020 07:44:57 +0100
Message-Id: <20200724064509.331-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200724064509.331-1-alex.bennee@linaro.org>
References: <20200724064509.331-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x442.google.com
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
 Stefan Weil <sw@weilnetz.de>, Paolo Bonzini <pbonzini@redhat.com>,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This will be used in a future patch. For POSIX systems _SC_PHYS_PAGES
isn't standardised but at least appears in the man pages for
Open/FreeBSD. The result is advisory so any users of it shouldn't just
fail if we can't work it out.

The win32 stub currently returns 0 until someone with a Windows system
can develop and test a patch.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Cc: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Christian Ehrhardt <christian.ehrhardt@canonical.com>
Message-Id: <20200722062902.24509-5-alex.bennee@linaro.org>
---
 include/qemu/osdep.h | 12 ++++++++++++
 util/oslib-posix.c   | 15 +++++++++++++++
 util/oslib-win32.c   |  6 ++++++
 3 files changed, 33 insertions(+)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 45c217aa280..0b1298b3c91 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -668,4 +668,16 @@ static inline void qemu_reset_optind(void)
  */
 char *qemu_get_host_name(Error **errp);
 
+/**
+ * qemu_get_host_physmem:
+ *
+ * Operating system agnostic way of querying host memory.
+ *
+ * Returns amount of physical memory on the system. This is purely
+ * advisery and may return 0 if we can't work it out. At the other
+ * end we saturate to SIZE_MAX if you are lucky enough to have that
+ * much memory.
+ */
+size_t qemu_get_host_physmem(void);
+
 #endif
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index d9236746248..ad8001a4ad8 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -841,3 +841,18 @@ char *qemu_get_host_name(Error **errp)
 
     return g_steal_pointer(&hostname);
 }
+
+size_t qemu_get_host_physmem(void)
+{
+#ifdef _SC_PHYS_PAGES
+    long pages = sysconf(_SC_PHYS_PAGES);
+    if (pages > 0) {
+        if (pages > SIZE_MAX / qemu_real_host_page_size) {
+            return SIZE_MAX;
+        } else {
+            return pages * qemu_real_host_page_size;
+        }
+    }
+#endif
+    return 0;
+}
diff --git a/util/oslib-win32.c b/util/oslib-win32.c
index 7eedbe5859a..31030463cc9 100644
--- a/util/oslib-win32.c
+++ b/util/oslib-win32.c
@@ -828,3 +828,9 @@ char *qemu_get_host_name(Error **errp)
 
     return g_utf16_to_utf8(tmp, size, NULL, NULL, NULL);
 }
+
+size_t qemu_get_host_physmem(void)
+{
+    /* currently unimplemented */
+    return 0;
+}
-- 
2.20.1


