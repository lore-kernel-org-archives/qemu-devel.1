Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99782C35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 15:58:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 646C72084E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 15:58:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="us5dMVYV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 646C72084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz0b6-0002AW-LQ
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 10:58:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32957)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iz0aW-0001c3-K9
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 10:58:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iz0aU-0000As-Cw
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 10:58:08 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:35079)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iz0aU-00008w-7P
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 10:58:06 -0500
Received: by mail-wr1-x42d.google.com with SMTP id w12so12812003wrt.2
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2020 07:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=0cWTROFuLM3aqAuYptvDS+Z87vNSm5cfhxElZkltOo4=;
 b=us5dMVYV3KwtHS/92I9FJajnYz2GwM6+4vAsbCq19MOVOwneA+eVb38y93Z9ItTibT
 /CIsC8NwZwg+PPwSZ8/A96FTfXA1T0ITVbOKE7zzrx9BsiFjbSS8oIf/ktEJlp9MAGLp
 c18MVTOOcqcV8HW3uK8A+dcO6uCTHbVqiennn9Zq0+RP3WLEFcHO/eTTj08Z9QuQLTiP
 ki1iXkvV75Vdz3XjaPcP9TZkLCifByL8WrUUB9ULhFmyCz0uUiPbdVTC/mDijXhl6JHY
 VZBys1OoZ3rZbZy4CAoMmeJx9w7zlKdS1+b79G7TPRYoJSFf8U08Yh/9i+jGiCuFmRzJ
 nRNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=0cWTROFuLM3aqAuYptvDS+Z87vNSm5cfhxElZkltOo4=;
 b=EzoVKw+eLhSYUizKZhaweR9BLp23FqfGr3vZcOeomisOufDrgLbBO6jLBHRsdBnLsP
 Isxq2Um6u1SQf4LRwb90zu/s1Y+1R1VtCgcsTJYaMmRmlwK2wpN9giEYbboizaOtaso0
 Y0W4FcxQEZUV4IceYPMFeujg0XnOfjaB29DwoRyIbquJl2CAfNEusVfyws11uRXF3eiA
 ARDgwC6Y54qgja6ITdD6v/gQmqCegFfy5HjH60AJ8sXmYgmeu7Y1log4k1aO7C35gohc
 Ls31VdNlZGvkoap5pbXa0FXJAuWjz8j6607Sw7L7EdGFWwfJ4s41ye/vmQPDqM3mKInb
 XWBQ==
X-Gm-Message-State: APjAAAUbvOztHjcQRAyeyeg/IRzz0R42lMLaQOGml2KeklsW0olEYHD1
 kpGVBO6zOjM+HSJMZd3+CoTKgRAe
X-Google-Smtp-Source: APXvYqw/irHVvcgmo5hO7TRMM0ItHgsuUObccFGS0qF59vbUVG6iv/9O6niUPfjRcph2Z9KRSgFT1g==
X-Received: by 2002:adf:e5c6:: with SMTP id a6mr23487141wrn.185.1580831884842; 
 Tue, 04 Feb 2020 07:58:04 -0800 (PST)
Received: from donizetti.redhat.com ([151.20.243.54])
 by smtp.gmail.com with ESMTPSA id p5sm30157884wrt.79.2020.02.04.07.58.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2020 07:58:04 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] scripts/signrom: remove Python 2 support, add shebang
Date: Tue,  4 Feb 2020 16:58:02 +0100
Message-Id: <20200204155802.13621-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42d
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
Cc: philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/signrom.py | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/scripts/signrom.py b/scripts/signrom.py
index 313ee28a17..9be5dab1cf 100644
--- a/scripts/signrom.py
+++ b/scripts/signrom.py
@@ -1,3 +1,5 @@
+#!/usr/bin/env python3
+
 from __future__ import print_function
 #
 # Option ROM signing utility
@@ -44,14 +46,8 @@ fout.write(data)
 
 checksum = 0
 for b in data:
-    # catch Python 2 vs. 3 differences
-    if isinstance(b, int):
-        checksum += b
-    else:
-        checksum += ord(b)
-checksum = (256 - checksum) % 256
-
-# Python 3 no longer allows chr(checksum)
+    checksum = (checksum - b) & 255
+
 fout.write(struct.pack('B', checksum))
 
 fin.close()
-- 
2.21.0


