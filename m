Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F34B7C433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 12:25:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1BA32074F
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 12:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ivz7bepB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1BA32074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k02Bq-0000Co-Vj
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 08:25:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36962)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k02Ao-0006uP-UA
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 08:24:06 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:40034)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k02An-0006QD-8h
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 08:24:06 -0400
Received: by mail-wr1-x442.google.com with SMTP id l2so4115412wrc.7
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 05:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4DkH+HsKr59a1msZyNsGwSRnaJGoXL2y3SWKWzOhSpU=;
 b=Ivz7bepBEmniKPvFEH8tB/o+eAqzW/oFlp7mg/i9blICyxhA1aNpA+DxYBbf/JF94G
 g8RXFZ0+oGq148PVBbjW0n8MEaLcgda8xj8ovrO+uNF25Fl8EbNoGd+zjtKHiJREwKAW
 bKEpeJjwniXV3d3DHWFXtaU9+2yjPOvq8iUYVVq3EYetCBjqLtni4x1P3y99/6WIgSpl
 gGpi6RYAp5PcoP8U/naRBC7foGjpTybY2Wj82Rdpl0q1v2M08OS2MBXPIXrxCdru+4B6
 oRrPx+FT/GbgH6Ha12Wf1p2NIDxeFiz1I1yB9f6OOSnlcrku421dI9z0A2EJHWLTXkf7
 wNUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4DkH+HsKr59a1msZyNsGwSRnaJGoXL2y3SWKWzOhSpU=;
 b=qV+JhOOehBj+V356wl4S7i7K1RQVzHitq/EyvEQBY84/0H0Ydzh+OUY3YuokvMI48D
 EWOpQikQ3PVAt6HlhxWDhdfrt4m8ou2ph3cK8I+zZNh7P3HhrNAV99W0woQ6OgRPbmpA
 13NXtZjCsx+b/LxmC6mcORKH0U6do03iNyIRcNswdX5ldKpSBjHqQpuALeyPJM1kKuRD
 tBHxBP1I7K1K904oL2VJFVghuyjmJHpaTjfOLgqduW+kTx8iQ23HNlXtF0BH3w76De9P
 nKpC4v1QzDli2tpxpcvLkFyxDdZz4COuEKaB56PvkLvRWlUyMfw4j6lOiRvkMfECee07
 KubQ==
X-Gm-Message-State: AOAM532YJf46Q7byhBDp7zzo9sq3za+cyAB0DvBTpJo1j0YltkzFdUEC
 RMxqNfMyMFZQ7aQGx+y8Hub9mQ==
X-Google-Smtp-Source: ABdhPJykbFGse0w4a1U7AyiEGiSv5IcVBq0AKQLXLP1rPFj2U/2VXOatAlmpT6QBWO4qbG9LJ2kjmQ==
X-Received: by 2002:adf:83c5:: with SMTP id 63mr19833097wre.321.1595852643909; 
 Mon, 27 Jul 2020 05:24:03 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z11sm12067528wrw.93.2020.07.27.05.23.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2020 05:24:00 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BC7A21FF90;
 Mon, 27 Jul 2020 13:23:57 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 04/16] util: add qemu_get_host_physmem utility function
Date: Mon, 27 Jul 2020 13:23:45 +0100
Message-Id: <20200727122357.31263-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200727122357.31263-1-alex.bennee@linaro.org>
References: <20200727122357.31263-1-alex.bennee@linaro.org>
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
Cc: Stefan Weil <sw@weilnetz.de>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Christian Ehrhardt <christian.ehrhardt@canonical.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
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
Message-Id: <20200724064509.331-5-alex.bennee@linaro.org>

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


