Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C66EC433E1
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 07:22:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 188362065D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 07:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hd9Rmt4S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 188362065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jshwE-0006PY-9E
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 03:22:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43518)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jshoB-0006R7-9T
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 03:14:27 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:45561)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jsho8-0004q3-Uo
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 03:14:26 -0400
Received: by mail-wr1-x434.google.com with SMTP id s10so43937961wrw.12
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 00:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+v5zmTqMHanAlbP0rCuGswlB7G9ERwBp467Jydp4J1s=;
 b=Hd9Rmt4SPUXUgR0Qsa0W06b7poQu1JKVGeX9VguAR8b4SL1A39TybJOB3rgKo8kHiT
 FsyhWhqQ3/JaPvmAR401CrMQtAUoogplZy4NSP5KrfQPIfikEtlqu6wn8Gq23XHzNGgi
 We9XtmnpYYK4tlGTo08Pe6wLW9j5XUX3ebNWKn0fv1o3gs5yNToDOhsR3bDNIXX7SfaF
 2e9XNbn+SwbXzmniemg0s95HIfB8Is0Ek/RzTEdgppZPCgpTm/AzErYK6rSKai5gfgkT
 VRGPi/UYR83ESvpET/tpY3/B4iSeX+w/+5Bjke+zysM4pvt55ScDOILiTkdpdY1yc7bn
 sOOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+v5zmTqMHanAlbP0rCuGswlB7G9ERwBp467Jydp4J1s=;
 b=E6op6RUy/rBzSHqcVfwbR36/e2UmRxqaZBxLa7xhH8bpvd0coKm0HWqTxz6UURGkHX
 mEeu6S1A8LzPbf+jZ7pwX77YqOIKmnRO99ourxoeMsFv3jqSdRB9zA53ABa7gH/yZNmU
 t3XiR5anfeuuGjdScUn7xaOPNmH7iTgII8dRZCRySuuNOQIsaSPezIdk3caS6mlMkPgY
 QSL1R7dvU+qB3tIvcWzOr3l0SBHs3NjDq5os1woXuXI/3Br5D7qoc4nqzeta8P8AN9uz
 GnS/Xr4V7vDXhINDloMn2tOAo/m0rEBW8u5brvcXjr7oaljaH4ra6yOE9kfXqtfTJe2j
 pL9Q==
X-Gm-Message-State: AOAM533mJVeFHLIx01mifwe7t+7Csgy9+n3uH+CevW0SGly3bqiaUBQN
 C6GWJqWrl3bCBT8JCw5RC9lRtw==
X-Google-Smtp-Source: ABdhPJysvw1m3CkmR7Cj0h3x4mdyQQzavBWrpgkBvQayAcxfbK9c7ognjSpJbEOCsZi+PHS0Vq8/Yw==
X-Received: by 2002:adf:f842:: with SMTP id d2mr56855091wrq.55.1594106063017; 
 Tue, 07 Jul 2020 00:14:23 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id e17sm26417761wrr.88.2020.07.07.00.14.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2020 00:14:22 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9DD1F1FFB8;
 Tue,  7 Jul 2020 08:09:01 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 31/41] linux-user/elfload: use MAP_FIXED_NOREPLACE in
 pgb_reserved_va
Date: Tue,  7 Jul 2020 08:08:48 +0100
Message-Id: <20200707070858.6622-32-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200707070858.6622-1-alex.bennee@linaro.org>
References: <20200707070858.6622-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x434.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Given we assert the requested address matches what we asked we should
also make that clear in the mmap flags. Otherwise we see failures in
the GitLab environment for some currently unknown but allowable
reason. We use MAP_FIXED_NOREPLACE if we can so we don't just clobber
an existing mapping. Also include the strerror string for a bit more
info on failure.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Message-Id: <20200701135652.1366-34-alex.bennee@linaro.org>

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index b5cb21384a1c..7e7f642332dc 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2294,7 +2294,7 @@ static void pgb_dynamic(const char *image_name, long align)
 static void pgb_reserved_va(const char *image_name, abi_ulong guest_loaddr,
                             abi_ulong guest_hiaddr, long align)
 {
-    const int flags = MAP_ANONYMOUS | MAP_PRIVATE | MAP_NORESERVE;
+    int flags = MAP_ANONYMOUS | MAP_PRIVATE | MAP_NORESERVE;
     void *addr, *test;
 
     if (guest_hiaddr > reserved_va) {
@@ -2307,15 +2307,19 @@ static void pgb_reserved_va(const char *image_name, abi_ulong guest_loaddr,
     /* Widen the "image" to the entire reserved address space. */
     pgb_static(image_name, 0, reserved_va, align);
 
+#ifdef MAP_FIXED_NOREPLACE
+    flags |= MAP_FIXED_NOREPLACE;
+#endif
+
     /* Reserve the memory on the host. */
     assert(guest_base != 0);
     test = g2h(0);
     addr = mmap(test, reserved_va, PROT_NONE, flags, -1, 0);
     if (addr == MAP_FAILED) {
         error_report("Unable to reserve 0x%lx bytes of virtual address "
-                     "space for use as guest address space (check your "
+                     "space (%s) for use as guest address space (check your "
                      "virtual memory ulimit setting or reserve less "
-                     "using -R option)", reserved_va);
+                     "using -R option)", reserved_va, strerror(errno));
         exit(EXIT_FAILURE);
     }
     assert(addr == test);
-- 
2.20.1


