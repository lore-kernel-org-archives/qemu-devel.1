Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C95C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 15:07:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AF6C2073E
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 15:07:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nml/dKZy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AF6C2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnkWK-0004qI-DI
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 11:07:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59244)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jnkAT-0006Ol-Lq
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 10:44:57 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:55346)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jnkAR-0003TH-Cg
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 10:44:57 -0400
Received: by mail-wm1-x344.google.com with SMTP id g75so3206076wme.5
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 07:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QdipPuDFtPEbcTTK9bILm5/cYHhEDIazGm1KaZL1a6M=;
 b=nml/dKZy7+JWhIOU7Jr4T7lYiz8nvFVcJTfBhbqNruV8vZoAQEDD3b3asAdJG4YE8N
 1ajKdcizhm3D0J2egCwRJH5ZvwLVCwlMdUFbYhip7BHWoNoN0hfd+h2OXSr5xAMr640w
 iur+GdilZwv8quTN0/yLhci3JNEt7Ct24hnFV1R/P0ILKdHOfMRTc+MjcihAuUU+bSUm
 PvqtwuGFvFQMujrd67we0ds1dcOauqk8Ye8dmVqK320npGmLrMRiAdlyTIMNCnIoAwVg
 +79uYNdcojL8jyBqStPLF9bLtROpb7wfPS1L9BLsoM2cxztqoro17M91FRJYusAow9fP
 +ObQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QdipPuDFtPEbcTTK9bILm5/cYHhEDIazGm1KaZL1a6M=;
 b=C8zso7BjIOVOF1pZbqxqHt1ndUrYkgySpiDZHsWd43DUzD5zwtifJaSe+P6ylp9vjp
 2hqlcN88usLPDEtYYO+y9tVaaawb7TcJ5NqE2/L4WMupo3foyBcIbOZbma4ZAe5+jcIa
 FznlyNUFRFqXTWTcujQT6AqMN4G/LzYXnORP7V9tVLpFZDiB13eTP2BXY2BdDpkWuKzk
 A/z0QU0xqTVQyYv0TQ/Ybbe3ApDWwxr8NfBST7Dj4VgLzGEl+vNURJkJwzOI36QP6vJ8
 qpRyNIy++gLW0Q/1UkRyK6noNt1RpfK1Sri6XUdCzIFFBepDu4ajqwCoKUARtwHF+j4Z
 WsBA==
X-Gm-Message-State: AOAM533mlt415FDgyH24xzSbpQ3GfJAzys/hzHMagD7xhPxzAyNRrDqz
 HNj7YXV0ew+omnWgAajOHn93L5WuJ58=
X-Google-Smtp-Source: ABdhPJyNH1NZSlldd18glITD9vsvGrPmYgzjMu4b5+u2Ic6zPVPkq4Q6WiDKUkg+90/HpCMKS6JvQQ==
X-Received: by 2002:a1c:2402:: with SMTP id k2mr20546657wmk.138.1592923493168; 
 Tue, 23 Jun 2020 07:44:53 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l17sm4130205wmi.16.2020.06.23.07.44.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 07:44:51 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 95CE91FF7E;
 Tue, 23 Jun 2020 15:44:50 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] risu: don't do a full register compare for OP_SIGILL
Date: Tue, 23 Jun 2020 15:44:46 +0100
Message-Id: <20200623144446.4243-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200522023440.26261-1-richard.henderson@linaro.org>
References: <20200522023440.26261-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x344.google.com
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

OP_SIGILL means we have an unexpected invalid operation. If this is a
load or store the register state may be un-rectified pointing at the
memblock so would be invalid. In this case just compare the PC and
make sure the other end also faulted at the same place.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 risu.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/risu.c b/risu.c
index 8d907d9..6d6dcf9 100644
--- a/risu.c
+++ b/risu.c
@@ -124,7 +124,6 @@ static RisuResult send_register_info(void *uc)
     switch (op) {
     case OP_TESTEND:
     case OP_COMPARE:
-    case OP_SIGILL:
         header.size = reginfo_size(&ri[MASTER]);
         extra = &ri[MASTER];
         break;
@@ -132,6 +131,7 @@ static RisuResult send_register_info(void *uc)
         header.size = MEMBLOCKLEN;
         extra = memblock;
         break;
+    case OP_SIGILL:
     case OP_SETMEMBLOCK:
     case OP_GETMEMBLOCK:
         header.size = 0;
@@ -203,7 +203,6 @@ static RisuResult recv_register_info(struct reginfo *ri)
     switch (header.risu_op) {
     case OP_COMPARE:
     case OP_TESTEND:
-    case OP_SIGILL:
         /* If we can't store the data, report invalid size. */
         if (header.size > sizeof(*ri)) {
             return RES_BAD_SIZE;
@@ -223,6 +222,7 @@ static RisuResult recv_register_info(struct reginfo *ri)
         respond(RES_OK);
         return read_buffer(other_memblock, MEMBLOCKLEN);
 
+    case OP_SIGILL:
     case OP_SETMEMBLOCK:
     case OP_GETMEMBLOCK:
         return header.size == 0 ? RES_OK : RES_BAD_SIZE;
@@ -250,7 +250,6 @@ static RisuResult recv_and_compare_register_info(void *uc)
     switch (op) {
     case OP_COMPARE:
     case OP_TESTEND:
-    case OP_SIGILL:
         /*
          * If we have nothing to compare against, report an op mismatch.
          * Otherwise allow the compare to continue, and assume that
@@ -270,7 +269,14 @@ static RisuResult recv_and_compare_register_info(void *uc)
             res = RES_END;
         }
         break;
-
+    case OP_SIGILL:
+        /* We can only check the op and PC */
+        if (header.risu_op != OP_SIGILL) {
+            res = RES_MISMATCH_OP;
+        } else if (header.pc != get_pc(&ri[APPRENTICE])) {
+            res = RES_MISMATCH_REG;
+        }
+        break;
     case OP_SETMEMBLOCK:
         if (op != header.risu_op) {
             res = RES_MISMATCH_OP;
-- 
2.20.1


