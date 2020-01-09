Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E600C33CA2
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 02:19:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D0F6206F0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 02:19:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A5S75hZQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D0F6206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipNQA-0001Jq-NV
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 21:19:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34808)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ipNO2-0007Fg-Ku
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 21:17:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ipNNz-00086R-DD
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 21:17:26 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:39204)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ipNNw-00083y-9D
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 21:17:20 -0500
Received: by mail-pf1-x444.google.com with SMTP id q10so2572651pfs.6
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 18:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UEu09f1Nlqe8aDmLncxcurE+ZboCmDUATKx9s84WZ/k=;
 b=A5S75hZQnMsJ1nbOjo9RnK9XtB8yFbaUULsBPbLEB6/GcjVm1l+2HCgRNadFzGkQX1
 5z3Ipkc3WySJA6h5CZvIMPLVPvKo3QAynfKGtJcyZDsuhID9J80AWz74o+0+czmTcL2G
 i+bpptvkeMh8CnM5/fz7PuFgE66wbrdItvABM5WrcNjK9JPXnrpEiuP4AbU4A6AF5rVe
 Uq6lHbgssuhBgTi9PC9onSmtLj/JTJ5pY9le/s6H4VMo/gg00V8b684AZw117AtUPvFy
 HhjJq08vpO/9yWSRFwOScY9rfzP0gtl6b5c6xTmdVoqE8BlS9ywvpRJwSdFRrihVV9Rr
 fGaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UEu09f1Nlqe8aDmLncxcurE+ZboCmDUATKx9s84WZ/k=;
 b=dy5xenbeVRA/JxZmUPbgNJxF5KOon54udTrfyWldl2VHcYvsX/UXqYDu4tGrpbT0Qw
 YvGjW0OvjZgbaRQeLyXwaLyvhvpbXWvV+BEd0l2PgoyaYld3QYkvQO78oLeWeJJkQxE3
 cbv/Z5TcJEDR5zUx3xAzHPyHZqf/Twos1I1IEfhGFIVBEmNO0I0TMdeYu93DurO61M46
 BJa+8XPm5v3669iiQaljwaP+D1RiHccR/h5lc//MKO1VjlIluaToRyiKsl5Lqioawabf
 4m75PQ75BtXx8AXXFRyVTLFQC6+yxkPAAzllRiokEIyj0F74jVblDXMFEzZO5w2pQqSW
 vWUA==
X-Gm-Message-State: APjAAAW7Vzr0srWd8Zjv3uLeYKlNUKZie5eys04L0DLFCRVMUOHcM89g
 8mut5UKTql7qq8BRJ4ni6mIuYqaFQ+3qHw==
X-Google-Smtp-Source: APXvYqwfby/zSXjZLIIpJ63PWhjBorfJamXTyalnpdttGAVYZRG8FFVnc8/xAoMLCBnyD5HTBN8cOA==
X-Received: by 2002:a62:e30d:: with SMTP id g13mr8714360pfh.92.1578536238344; 
 Wed, 08 Jan 2020 18:17:18 -0800 (PST)
Received: from localhost.localdomain (alanje.lnk.telstra.net.
 [120.151.179.201])
 by smtp.gmail.com with ESMTPSA id n26sm5166715pgd.46.2020.01.08.18.17.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2020 18:17:17 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/4] vl: Remove unused variable in configure_accelerators
Date: Thu,  9 Jan 2020 13:17:07 +1100
Message-Id: <20200109021710.1219-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200109021710.1219-1-richard.henderson@linaro.org>
References: <20200109021710.1219-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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
Cc: pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The accel_initialised variable no longer has any setters.

Fixes: 6f6e1698a68c
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 vl.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/vl.c b/vl.c
index 86474a55c9..be79b03c1a 100644
--- a/vl.c
+++ b/vl.c
@@ -2749,7 +2749,6 @@ static void configure_accelerators(const char *progname)
 {
     const char *accel;
     char **accel_list, **tmp;
-    bool accel_initialised = false;
     bool init_failed = false;
 
     qemu_opts_foreach(qemu_find_opts("icount"),
@@ -2776,7 +2775,7 @@ static void configure_accelerators(const char *progname)
 
         accel_list = g_strsplit(accel, ":", 0);
 
-        for (tmp = accel_list; !accel_initialised && tmp && *tmp; tmp++) {
+        for (tmp = accel_list; tmp && *tmp; tmp++) {
             /*
              * Filter invalid accelerators here, to prevent obscenities
              * such as "-machine accel=tcg,,thread=single".
-- 
2.20.1


