Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C9DC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:55:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 699FB20644
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:55:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E1VQGJ83"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 699FB20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlD0A-0005IQ-K6
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 10:55:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58178)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCQm-0003i1-H8; Tue, 16 Jun 2020 10:19:16 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:44578)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCQk-0006yz-PB; Tue, 16 Jun 2020 10:19:16 -0400
Received: by mail-ot1-x343.google.com with SMTP id e5so16019583ote.11;
 Tue, 16 Jun 2020 07:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=luDTWDuXHrw0jVjHUOWwtj8xIi3ns98/jyoG5nV+cZo=;
 b=E1VQGJ83vVvyJBRTBkk5zIDSoUzhRTWSCrFmgxTEjDuVOhShz7BYhDtaaRvR6AFTdr
 aw9zcdX29aetglsKxQB9wu5WD5Ro/+8DnafQGs6PitkIQEhy/t8U5F5HJDo1eItqbOgD
 SfF6sA+K9vU5e1z8vvUE9/xo9vSKf2nyClOD9nruDtxmtJpzGxS+V3Hjysmqf1rkzKT1
 rFPqxhsB0DEUEC9q88cS89PvzLyTeCiSkfMbV15EWArIXvF4joIWYe7ZTBWxGcCyJzYB
 dlANiOUgzArrpUzz5EhvRcvSIuHIszMRnSMJ8GJqQVHZyi0xjc8F79JPctgWPCPVMUyT
 7U+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=luDTWDuXHrw0jVjHUOWwtj8xIi3ns98/jyoG5nV+cZo=;
 b=Gi3YuwWDBCPJ0kdd1uHG+XTSZ0QXqeFKL7Puf7Nj9aFjrjoIwiZ0W3/OrWuJFI9F20
 awnu1uwoYeKc3mqUIk1Rz9vVx6SxqxpnBtrSJ5IJtG555sdG6qqU0OHUhQ4u+KeY57vX
 2QFbEOTUxccLQ+3WQ1B2rqXjzEqwLym+UHCwHD2gU2YMmj8KsnxtJsy8s7u0O/gYuYFj
 CsHL8VkKzGO1xRIHg/FclsMyftUfGyCkdtm7dWl9dU98qyeRAKvQSBOrUJ/lBbI7W/z8
 IWMdVaxaJKCwAPMHxetIyi5Zhuexxnimz/X/PeKv7MM2l76lC1cPG1hHKUgBzahcRUw2
 +vQA==
X-Gm-Message-State: AOAM533v/iH0ekKzTSFmDKdkhbKqeTerdX4CfzPg2yI4A705Va5SIbgN
 TF3QJ9yLOf+UJAweBwRF3xUWY2eP
X-Google-Smtp-Source: ABdhPJwbOyq1+L9ExYcFnBJhBoSELKR5ybwRb06V3bl6Opt/lhZPmyxCJWx1ewsHpo/FJr62l7VF+Q==
X-Received: by 2002:a05:6830:13d3:: with SMTP id
 e19mr2629793otq.290.1592317152347; 
 Tue, 16 Jun 2020 07:19:12 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id t11sm4072451otr.65.2020.06.16.07.19.09
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 16 Jun 2020 07:19:10 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 61/78] qga: Fix undefined C behavior
Date: Tue, 16 Jun 2020 09:15:30 -0500
Message-Id: <20200616141547.24664-62-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
References: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=flukshun@gmail.com; helo=mail-ot1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eric Blake <eblake@redhat.com>

The QAPI struct GuestFileWhence has a comment about how we are
exploiting equivalent values between two different integer types
shared in a union. But C says behavior is undefined on assignments to
overlapping storage when the two types are not the same width, and
indeed, 'int64_t value' and 'enum QGASeek name' are very likely to be
different in width.  Utilize a temporary variable to fix things.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Fixes: 0b4b49387
Fixes: Coverity CID 1421990
Signed-off-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
(cherry picked from commit a23f38a72921fa915536a981a4f8a9134512f120)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qga/commands.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/qga/commands.c b/qga/commands.c
index 0c7d1385c2..8ec7fa3c04 100644
--- a/qga/commands.c
+++ b/qga/commands.c
@@ -482,10 +482,15 @@ done:
  * the guest's SEEK_ constants.  */
 int ga_parse_whence(GuestFileWhence *whence, Error **errp)
 {
-    /* Exploit the fact that we picked values to match QGA_SEEK_*. */
+    /*
+     * Exploit the fact that we picked values to match QGA_SEEK_*;
+     * however, we have to use a temporary variable since the union
+     * members may have different size.
+     */
     if (whence->type == QTYPE_QSTRING) {
+        int value = whence->u.name;
         whence->type = QTYPE_QNUM;
-        whence->u.value = whence->u.name;
+        whence->u.value = value;
     }
     switch (whence->u.value) {
     case QGA_SEEK_SET:
-- 
2.17.1


