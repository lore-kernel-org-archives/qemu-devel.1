Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF348C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 10:54:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C9E2206BE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 10:54:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T48STVcB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C9E2206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwO0b-0000MQ-Pb
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 06:54:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44014)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jwNy6-0004cU-7h
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 06:51:54 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53429)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jwNy4-0003ry-5o
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 06:51:53 -0400
Received: by mail-wm1-x343.google.com with SMTP id j18so14175404wmi.3
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2020 03:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=n7oJYPppjNHv+Hb+2CTlnOn4o/FtAViKxPV8Et6uZ+E=;
 b=T48STVcBAfjMmpoC0BBaizTYrf6BozevIBtRpuzIDspw/dQOPxQrXoLevWLI0QW4Ft
 adXOFRfNanG4cjwSMqESkI4IxusefDyJm0T1p8mY4KOYm0dXElmaMUpPrl7QqsdZ+I3D
 bvikUtKmBae+4IvJsmcEozhbf+S1+NNwrhO4r4jiHaYBpukbpAM7Fsus8thbhZOrq3hC
 SrA78EM3GBgYxM4WTs5iv5SsQIr3CCgWvAtKIRod86ky4BNp+MyMvSQZi4LHT67vaqNC
 6wjmarLLTQPXgyXGHEEs5sZjYmeziPnkWyTHPCm+yJQPAEPFQcNIoTg1raR+CyrYSKBI
 A8rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=n7oJYPppjNHv+Hb+2CTlnOn4o/FtAViKxPV8Et6uZ+E=;
 b=bhr5RgPu/Ia/uca9YeIviev3JX3RRsBQNFcrAcv38Kwabsb4V1M0KbB51z+eWdJq4d
 gmk3wE/XKrz2wRPt3j/7AsPrOQN51Hc34OaecsGK+b09k5ji5BTAabO9s7QtNH5LraOG
 1/yz8xLwayeB0tL1ATKjxwNt14E3ZjVSmGZXryNbxv5l+VHLOflfINL6mshiIruTCyn9
 vuE7PpASTUqVuuM4ZHykfq5RvZVIs5GqpjqS+jsBmT3OPs6TxvQ5a4VCgkitVBBnIxNm
 0LEcCQuUAyluym+iFt3dj1QSOO+d3dAAa5PUC80GGPL0BjUuwoc8Kr6PL0BL8Yzjt4Uw
 gxZA==
X-Gm-Message-State: AOAM5314O8TyaTgAcPLHDZl7tJ5haTxZVSwCHR1paWYRpDbHSl7TQX3d
 xfZZ1NO5T5MTPfmtzLDVOO4k4g==
X-Google-Smtp-Source: ABdhPJxBD+XYa+aWamzNymFw2wA9vK/E6L++kYOwkecxL8AmW5JpUFzFXHZPd5xDww1yC38ckeQM3g==
X-Received: by 2002:a1c:2e57:: with SMTP id u84mr9224980wmu.52.1594983105639; 
 Fri, 17 Jul 2020 03:51:45 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id j75sm15298926wrj.22.2020.07.17.03.51.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2020 03:51:43 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id F06701FF90;
 Fri, 17 Jul 2020 11:51:39 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 4/5] util: add qemu_get_host_physmem utility function
Date: Fri, 17 Jul 2020 11:51:38 +0100
Message-Id: <20200717105139.25293-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200717105139.25293-1-alex.bennee@linaro.org>
References: <20200717105139.25293-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x343.google.com
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
Cc: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Christian Ehrhardt <christian.ehrhardt@canonical.com>
---
 include/qemu/osdep.h | 10 ++++++++++
 util/oslib-posix.c   | 11 +++++++++++
 util/oslib-win32.c   |  6 ++++++
 3 files changed, 27 insertions(+)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 4841b5c6b5f..7ff209983e2 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -665,4 +665,14 @@ static inline void qemu_reset_optind(void)
  */
 char *qemu_get_host_name(Error **errp);
 
+/**
+ * qemu_get_host_physmem:
+ *
+ * Operating system agnostiv way of querying host memory.
+ *
+ * Returns amount of physical memory on the system. This is purely
+ * advisery and may return 0 if we can't work it out.
+ */
+size_t qemu_get_host_physmem(void);
+
 #endif
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 36bf8593f8c..d9da782b896 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -839,3 +839,14 @@ char *qemu_get_host_name(Error **errp)
 
     return g_steal_pointer(&hostname);
 }
+
+size_t qemu_get_host_physmem(void)
+{
+#ifdef _SC_PHYS_PAGES
+    long pages = sysconf(_SC_PHYS_PAGES);
+    if (pages > 0) {
+        return pages * qemu_real_host_page_size;
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


