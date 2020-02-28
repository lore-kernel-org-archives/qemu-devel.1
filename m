Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 305C4C3F2D2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 19:27:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 006712469F
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 19:27:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z4FDt9zf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 006712469F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7lIC-0007ft-4l
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 14:27:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40187)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j7lFH-0003XI-B5
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 14:24:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j7lFG-00061A-3y
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 14:24:23 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:37935)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j7lFF-00060B-Tk
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 14:24:22 -0500
Received: by mail-wm1-x341.google.com with SMTP id n64so3157607wme.3
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 11:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Ani8t6ZA25StH0QycQf8FnItMvLK0JPOczLU0WnT68k=;
 b=Z4FDt9zfTNU5jn+SS1tlQ7zjVqU8f2aFwlnyuTOEqZpMB9UPQ/MdgseI9oXZZC1P2C
 HL2de5LzxGqSVh1sartSH2VPkKYiTUMwGf9qbalWXZeKrWlxNLaUEPz1Hr0pPXlwIEld
 3D+rQbUxXJ+u1zQo8E05qMOg0ji7AhFBwFog29wUzRrZYA2h8TflTeXZVBR9RDLHo3OG
 gH8DJLzTpdFplkXaekbKQtBbXb+/+xx3B3qeHlQDxqcfDchDZcxNkLLjcwKqTJo9SBSo
 tibDrLv+zIlAPmt/FWcdv4lh95PxmBoUupbXjj8i1+el/HMJgWzoVcyyUhmve3LT6SBw
 altA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ani8t6ZA25StH0QycQf8FnItMvLK0JPOczLU0WnT68k=;
 b=bnv7aYkstF+L9hNGWcFa3H2/rg8Vh9DVWmXQDtDijcB8+dbwNdwibn/mEFOkRuVg8a
 UnD+YlBnmmc0X7D7994aclLWvOTb3sHZjE2OCbd7y4PioSaSg7piy/vBlpH9fCHdg7bz
 pAxix7hL6M/FvdwQV6r9owVtIFYELRR0Ec2g9U6J5v/YHoFQGOK6my5StWhX+w+Wvm2J
 ZmD8dcaK5qOc+k+8Zerz5jGeLHkCrZgmwBRDI61/0Ff4YWTlyNQFHGe5yZvE13j053Ab
 D6K+HyXzXB/a2X16itb5LEXuOLNRVozC95UnhwAX1GdfHBdb1ams/UbSmCOA1GQRbVgI
 bCZQ==
X-Gm-Message-State: APjAAAVzYXEUeepJQuviYNhPx+dF7M5vHrTzv8b97pr2u/kakHo4L5nC
 vSWxgmO7jF/ZmQi0DaI0mwBhdQ==
X-Google-Smtp-Source: APXvYqxX0K5VlP7khb0B3TY7mbFimJd1DfaHLzhe3Vxz8k8SoADIlpjL3QjKKZHAr40DSoEUquHlrA==
X-Received: by 2002:a1c:dcd5:: with SMTP id t204mr6157986wmg.34.1582917860602; 
 Fri, 28 Feb 2020 11:24:20 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z2sm5545260wrr.78.2020.02.28.11.24.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 11:24:18 -0800 (PST)
Received: from zen.home.arpa (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CF86C1FF91;
 Fri, 28 Feb 2020 19:24:15 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 4/4] accel/tcg: increase default code gen buffer size for
 64 bit
Date: Fri, 28 Feb 2020 19:24:15 +0000
Message-Id: <20200228192415.19867-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200228192415.19867-1-alex.bennee@linaro.org>
References: <20200228192415.19867-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

While 32mb is certainly usable a full system boot ends up flushing the
codegen buffer nearly 100 times. Increase the default on 64 bit hosts
to take advantage of all that spare memory. After this change I can
boot my tests system without any TB flushes.

As we usually run more CONFIG_USER binaries at a time in typical usage
we aren't quite as profligate for user-mode code generation usage. We
also bring the static code gen defies to the same place to keep all
the reasoning in the comments together.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Niek Linnenbank <nieklinnenbank@gmail.com>

---
v2
  - 2gb->1gb for system emulation
  - split user and system emulation buffer sizes
---
 accel/tcg/translate-all.c | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 4ce5d1b3931..78914154bfc 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -892,15 +892,6 @@ static void page_lock_pair(PageDesc **ret_p1, tb_page_addr_t phys1,
     }
 }
 
-#if defined(CONFIG_USER_ONLY) && TCG_TARGET_REG_BITS == 32
-/*
- * For user mode on smaller 32 bit systems we may run into trouble
- * allocating big chunks of data in the right place. On these systems
- * we utilise a static code generation buffer directly in the binary.
- */
-#define USE_STATIC_CODE_GEN_BUFFER
-#endif
-
 /* Minimum size of the code gen buffer.  This number is randomly chosen,
    but not so small that we can't have a fair number of TB's live.  */
 #define MIN_CODE_GEN_BUFFER_SIZE     (1 * MiB)
@@ -929,7 +920,33 @@ static void page_lock_pair(PageDesc **ret_p1, tb_page_addr_t phys1,
 # define MAX_CODE_GEN_BUFFER_SIZE  ((size_t)-1)
 #endif
 
+#if TCG_TARGET_REG_BITS == 32
 #define DEFAULT_CODE_GEN_BUFFER_SIZE_1 (32 * MiB)
+#ifdef CONFIG_USER_ONLY
+/*
+ * For user mode on smaller 32 bit systems we may run into trouble
+ * allocating big chunks of data in the right place. On these systems
+ * we utilise a static code generation buffer directly in the binary.
+ */
+#define USE_STATIC_CODE_GEN_BUFFER
+#endif
+#else /* TCG_TARGET_REG_BITS == 64 */
+#ifdef CONFIG_USER_ONLY
+/*
+ * As user-mode emulation typically means running multiple instances
+ * of the translator don't go too nuts with our default code gen
+ * buffer lest we make things too hard for the OS.
+ */
+#define DEFAULT_CODE_GEN_BUFFER_SIZE_1 (128 * MiB)
+#else
+/*
+ * We expect most system emulation to run one or two guests per host.
+ * Users running large scale system emulation may want to tweak their
+ * runtime setup via the tb-size control on the command line.
+ */
+#define DEFAULT_CODE_GEN_BUFFER_SIZE_1 (1 * GiB)
+#endif
+#endif
 
 #define DEFAULT_CODE_GEN_BUFFER_SIZE \
   (DEFAULT_CODE_GEN_BUFFER_SIZE_1 < MAX_CODE_GEN_BUFFER_SIZE \
-- 
2.20.1


