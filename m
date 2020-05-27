Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6419C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 10:06:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B008F208E4
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 10:06:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L8cIFL3j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B008F208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdsxc-0004gb-U4
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 06:06:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50240)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jdswa-0003PH-Px
 for qemu-devel@nongnu.org; Wed, 27 May 2020 06:05:52 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:40712)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jdswZ-0005C0-Pe
 for qemu-devel@nongnu.org; Wed, 27 May 2020 06:05:52 -0400
Received: by mail-wr1-x443.google.com with SMTP id j16so10962323wrb.7
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 03:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Q9g2hw1e4m0meDSSDGhsHzYZBM3E+e3OyOVzFlX36Xg=;
 b=L8cIFL3jvF31gFLNhZfKcVyUva/SJZkPMo8p6jMPrz9TKGGYK7oi99G/yVQs0l5rxB
 s2hyzXGbYuN9G3dGjjZ3siAMbUhWWeYgy0sa/IdrzBtzbtYu7DVCx8anPINCqdw6OqBX
 fQX0N2c90JujLRS0y7xAjIMNn1n7QzS2FmvcaZMbhjrHVWjCiU2bL2n7HJnMpyXvfJVu
 6DQEJPA5oIU47rDGAwKPrywGhIL/wENg0u5SxES7ngwlayE3/OhW7e3M5uFI9htloRLg
 HtZv/DGwcnDddISMtMWQPJuM2FgTMWtxT1HgWSPlNty9edvvsW1yTw8xGxOOHgnqzKOi
 HEtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Q9g2hw1e4m0meDSSDGhsHzYZBM3E+e3OyOVzFlX36Xg=;
 b=J8M9ARb4IZbfnBAFjglodGoXAaT+0zuLB4nZkvpvGHlvG4C7mdFl1Qc9JSw594aLZN
 WIM3ikA4JvPufu5tOK3XDSb7oyM91FAa9BAR1rNTL1Lc2/0ioNgGJDS4K8pGfHiJXSRq
 3TYQ6z/DrdlXfcYaa7uLoTMeF/ABR7lWu3A5/xYN3Y+KYJp5MqKItY53v4BfyQmDGBJ8
 Mi9m8HMB+0h/5dDCaCSMkrHv0ejT4v8Zdzclnsem+fDMDHbe+h7E9XwDP/LSLFoIo2wZ
 zAaQbEDWoqBqraF8tKLH4P/IyTiELkECkBVRLWlPDVsQwDk24BC4nN0rsD3mUXsw1vZr
 iDmQ==
X-Gm-Message-State: AOAM530xbcQxPNZmNrlTA+UUhTKWeyaKhlQZLM++BP8sXnBeWCv5L/Qy
 1rof5x/cCbYwdQ7T6j8KjtjZZA==
X-Google-Smtp-Source: ABdhPJxFnYjDDBleWEc7OsrvheRhrr6oQPMLDU6sZQvh97QfYTG5+3VbQ5cECXIUB9twsyOk76ZlQg==
X-Received: by 2002:adf:aa97:: with SMTP id h23mr21461385wrc.251.1590573950239; 
 Wed, 27 May 2020 03:05:50 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id m129sm1971380wmf.2.2020.05.27.03.05.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2020 03:05:47 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DADDD1FF87;
 Wed, 27 May 2020 11:05:46 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 1/3] linux-user: provide fallback pgd_find_hole for bare
 chroots
Date: Wed, 27 May 2020 11:05:44 +0100
Message-Id: <20200527100546.29297-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200527100546.29297-1-alex.bennee@linaro.org>
References: <20200527100546.29297-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x443.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>,
 qemu-arm@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When running QEMU out of a chroot environment we may not have access
to /proc/self/maps. As there is no other "official" way to introspect
our memory map we need to fall back to the original technique of
repeatedly trying to mmap an address range until we find one that
works.

Fortunately it's not quite as ugly as the original code given we
already re-factored the complications of dealing with the
ARM_COMMPAGE. We do make an attempt to skip over brk() which is about
the only concrete piece of information we have about the address map
at this moment.

Fixes: ee9474303
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 linux-user/elfload.c | 48 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 01a9323a637..d6027867a1a 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2099,6 +2099,50 @@ static void pgb_have_guest_base(const char *image_name, abi_ulong guest_loaddr,
     }
 }
 
+/**
+ * pgd_find_hole_fallback: potential mmap address
+ * @guest_size: size of available space
+ * @brk: location of break
+ * @align: memory alignment
+ *
+ * This is a fallback method for finding a hole in the host address
+ * space if we don't have the benefit of being able to access
+ * /proc/self/map. It can potentially take a very long time as we can
+ * only dumbly iterate up the host address space seeing if the
+ * allocation would work.
+ */
+static uintptr_t pgd_find_hole_fallback(uintptr_t guest_size, uintptr_t brk, long align)
+{
+    uintptr_t base;
+
+    /* Start at the bottom and work our way up */
+    base = mmap_min_addr;
+
+    while (true) {
+        uintptr_t align_start, end;
+        align_start = ROUND_UP(base, align);
+        end = align_start + guest_size;
+
+        /* if brk is anywhere in the range give ourselves some room to grow. */
+        if (align_start <= brk && brk < end) {
+            base += 16 * MiB;
+            continue;
+        } else if (align_start + guest_size < align_start) {
+            /* we have run out of space */
+            return -1;
+        } else {
+            int flags = MAP_ANONYMOUS | MAP_PRIVATE | MAP_NORESERVE | MAP_FIXED;
+            void * mmap_start = mmap((void *) align_start, guest_size,
+                                     PROT_NONE, flags, -1, 0);
+            if (mmap_start != MAP_FAILED) {
+                munmap((void *) align_start, guest_size);
+                return (uintptr_t) mmap_start;
+            }
+            base += qemu_host_page_size;
+        }
+    }
+}
+
 /* Return value for guest_base, or -1 if no hole found. */
 static uintptr_t pgb_find_hole(uintptr_t guest_loaddr, uintptr_t guest_size,
                                long align)
@@ -2114,6 +2158,10 @@ static uintptr_t pgb_find_hole(uintptr_t guest_loaddr, uintptr_t guest_size,
     /* Read brk after we've read the maps, which will malloc. */
     brk = (uintptr_t)sbrk(0);
 
+    if (!maps) {
+        return pgd_find_hole_fallback(guest_size, brk, align);
+    }
+
     /* The first hole is before the first map entry. */
     this_start = mmap_min_addr;
 
-- 
2.20.1


