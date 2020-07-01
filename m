Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2448C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 14:09:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C543E2068F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 14:09:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tmWLG9Z8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C543E2068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqdQA-00061B-3y
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 10:09:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60852)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jqdKt-0004sS-7x
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 10:03:39 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53461)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jqdKr-0006pi-5g
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 10:03:38 -0400
Received: by mail-wm1-x343.google.com with SMTP id j18so22556029wmi.3
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 07:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JbHSSp+OWWoLJx/9MSaLrM42pM2ZJc5nMwUPC3QEVGo=;
 b=tmWLG9Z8Nyx4I30963cbylorfLynCpuEmbskKfJHBstLR7tyDiobK0hzmaonbkljfR
 TfLmfJyMQ7Ds6eO4E+ae0OO+8xJaHzijIcvU/eN5hQwiC9d/buZjSb7PPqzlXX6fJnMa
 u7kTntpc8abytSyn1bdvgd8HUPSQmkhaEB/RZSVJ9rWghdPbOjiWnX+s5zk+w1lvLKy6
 A8Sx0oua6oTp0bEgv0DO4dhAm19o5EgKkIrPpcZ434l12ZZVeVH+JKGSzoH5HjKIcKwZ
 dm4PRsdrht4MouRLBSoEEAc0fQzRHJzOoicr7QkSGiubvfWTcO3cWzTreH/i2DG1RgWa
 o+yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JbHSSp+OWWoLJx/9MSaLrM42pM2ZJc5nMwUPC3QEVGo=;
 b=TNBAHZS1LFjx0bGPeGlmbjijGyanQYCO9phu0UMMAxLej4/KpwQqBtLiLoNKn6ycRU
 SgO/RXFPuZ1oKP4m0uibtf3On6o+ymdbPesrinU22aPfUdVRoZjpRqe7HS+Z+0QVT2nC
 j+3SJJmjD9DEpdkS13Dx4akUvTxIv3dwAuzY8MGb8IBIpxgNYDW1MiC8RMMxUYJg5s6x
 9oOXh9Tvzn7kA4StRUKHFXYQM/Hiq64UtIKy4Xw7HxBKlQkh/O99VwKxn+9GmQ00sp1I
 Livp5UdAKkk7nnvEWIg+LaDzSyUWtac6T2rctBaPpHgQ7zdxXJhr9IajvPzUyr7MZnxu
 Ro5Q==
X-Gm-Message-State: AOAM531OuzCNhXB9mRVonXAJ49yxrQE1OrhKOsy4Cc4cCUV0HTYZf0Pe
 W6S/PZDRJ4c7OTc47tL3qr6P4A==
X-Google-Smtp-Source: ABdhPJzpq2YPcXx5UiCx7YW0y5EOgZMWah4n/t/t9sexghkbsSjgG1zWvWRXqdltGKvqJiSsG+dHHQ==
X-Received: by 2002:a1c:6308:: with SMTP id x8mr28002337wmb.92.1593612215706; 
 Wed, 01 Jul 2020 07:03:35 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t2sm7243554wma.43.2020.07.01.07.03.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2020 07:03:32 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3EE5B1FFBA;
 Wed,  1 Jul 2020 14:56:56 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 33/40] linux-user/elfload: use MAP_FIXED_NOREPLACE in
 pgb_reserved_va
Date: Wed,  1 Jul 2020 14:56:45 +0100
Message-Id: <20200701135652.1366-34-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200701135652.1366-1-alex.bennee@linaro.org>
References: <20200701135652.1366-1-alex.bennee@linaro.org>
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
Cc: fam@euphon.net, berrange@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, richard.henderson@linaro.org,
 f4bug@amsat.org, Laurent Vivier <laurent@vivier.eu>, cota@braap.org,
 aurelien@aurel32.net
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

---
v4
  - use MAP_FIXED_NOREPLACE instead
  - also dump strerror
---
 linux-user/elfload.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index b5cb21384a1..7e7f642332d 100644
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


