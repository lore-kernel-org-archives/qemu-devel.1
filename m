Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B696C33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 19:03:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 646BA2072C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 19:03:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vgvSkeeO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 646BA2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioXey-0000IG-VW
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 14:03:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45679)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielhb413@gmail.com>) id 1ioX4M-0002NS-QF
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:25:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1ioX4L-0004PA-PU
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:25:38 -0500
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:38121)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1ioX4L-0004On-LO; Mon, 06 Jan 2020 13:25:37 -0500
Received: by mail-qk1-x744.google.com with SMTP id k6so40296963qki.5;
 Mon, 06 Jan 2020 10:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=PKYZ0M4t+5Cvodu2K02JYtC//F3gaNkUYi3Ckm33kDw=;
 b=vgvSkeeOFCOWiENjxBXP+qbzb6eNuk+3D7Q6fYet0qFgaDfGM9sD3FyHyi0t9i1AG0
 qIXDU0dBHuKSA/RNyWMbNviS/3e89GH3uuyyOdGfeXccgCOinZL0AGDFQBSphX4HGbGn
 Xk+HHkS6Ygvyh0HqGzXRXQuF+FXxIGmj4K4MfehzTYK2QTd8irx2suv00wTl7FLpS39o
 vZzgvBWStF6P1AOrGBuUwpOxzfC0+ZiUkccB3n4ys+laWqT1ysKC1Qjgab5cHQmR0wLx
 yChLWGqTvsMlgZK9NZdjuLMbBr+DSBNM69R0tw27GUqI4rLZLiBWf+Kuq3PPfBPczZj4
 kLAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PKYZ0M4t+5Cvodu2K02JYtC//F3gaNkUYi3Ckm33kDw=;
 b=q9WFH9HUN+1Inu5WMOnhE9Kyqf6fDclwku5hGQ1wwYcmkXjDuAVUG0/OeVh12Mb3eo
 TLqVu0v9jnlGwMFj9ayFaqw/CBuF0/IWLrZ8+7So+iOgimHZOuC4aAep99U60sYH3CWT
 /Mkp3MDzwuSfY0HnwD6Wf4blVnB3fmcD+xrKsjApsORVk1GUnDD+MxB3Jh74CILtb1Nl
 T1saOzY2QlT1PikIwU8NmgjuGaqRlYixXSHNjdXByMU0qzc5cRt8BckGA6iSQQYlr3F3
 6+tMIduUNm5UyFGmcAjP3MLKirz7uqq/YSf4Db84H/Td//Gh/8bimHo3GdbRGohrOAWB
 y0qg==
X-Gm-Message-State: APjAAAVUKCi3esE/HH2ZCxzUpGb1RLhUMHiIcMJq6I/agL7K2VYXjJGa
 7GdGTB9D9wi7fC83WZCdajSoCuzN
X-Google-Smtp-Source: APXvYqyHPrK96/xFK20pSP76AtA0O9Douwyua786EZfCF4dVv9Ptbi5dJPEGq9kPIygFyrbrybdiSA==
X-Received: by 2002:a37:9f41:: with SMTP id i62mr81732449qke.272.1578335137004; 
 Mon, 06 Jan 2020 10:25:37 -0800 (PST)
Received: from rekt.ibmuc.com ([2804:431:c7c6:655b:9e1c:e865:3705:e1df])
 by smtp.gmail.com with ESMTPSA id b81sm21026522qkc.135.2020.01.06.10.25.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2020 10:25:36 -0800 (PST)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 25/59] block/vhdx.c: remove unneeded 'exit' labels
Date: Mon,  6 Jan 2020 15:23:51 -0300
Message-Id: <20200106182425.20312-26-danielhb413@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200106182425.20312-1-danielhb413@gmail.com>
References: <20200106182425.20312-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::744
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
Cc: qemu-trivial@nongnu.org, Jeff Cody <codyprime@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

'exit' label of vhdx_region_check() and vhdx_update_header()
can be replaced by 'return' statements.

CC: Jeff Cody <codyprime@gmail.com>
CC: qemu-block@nongnu.org
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 block/vhdx.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/block/vhdx.c b/block/vhdx.c
index f02d2611be..7a1ea312ed 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -229,7 +229,6 @@ void vhdx_guid_generate(MSGUID *guid)
 /* Check for region overlaps inside the VHDX image */
 static int vhdx_region_check(BDRVVHDXState *s, uint64_t start, uint64_t length)
 {
-    int ret = 0;
     uint64_t end;
     VHDXRegionEntry *r;
 
@@ -239,13 +238,11 @@ static int vhdx_region_check(BDRVVHDXState *s, uint64_t start, uint64_t length)
             error_report("VHDX region %" PRIu64 "-%" PRIu64 " overlaps with "
                          "region %" PRIu64 "-%." PRIu64, start, end, r->start,
                          r->end);
-            ret = -EINVAL;
-            goto exit;
+            return -EINVAL;
         }
     }
 
-exit:
-    return ret;
+    return 0;
 }
 
 /* Register a region for future checks */
@@ -390,11 +387,10 @@ static int vhdx_update_header(BlockDriverState *bs, BDRVVHDXState *s,
 
     ret = vhdx_write_header(bs->file, inactive_header, header_offset, true);
     if (ret < 0) {
-        goto exit;
+        return ret;
     }
     s->curr_header = hdr_idx;
 
-exit:
     return ret;
 }
 
-- 
2.24.1


