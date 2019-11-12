Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 632F2C17440
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 14:55:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AB1120656
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 14:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="trNSRwzD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AB1120656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUXZY-0008RL-1T
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 09:55:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59705)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iUXV6-0003QH-SN
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 09:50:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iUXV5-00034R-VM
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 09:50:36 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:50404)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iUXV5-00033y-PR
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 09:50:35 -0500
Received: by mail-wm1-x329.google.com with SMTP id l17so3522976wmh.0
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2019 06:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MgNvQL45Hwg6psU5bHdK3yy5lx6MA/Ql526zQmB9a9Y=;
 b=trNSRwzDOM+I+w+H1MxuC9KDatbbPZHcdX1vR1zCVnPcELDa5FlIyl86mtiuXyaDET
 GijOzm/Yn8ZtLPzvnZfhE4Eh/7j8bwwId1BH+EX6G48sBjXZAMqchAxIX+zLw+pDLhd5
 CQx3ZFMHdxctmz5vcfmw5siihbpO50oizgvSoWCn1nuDkT9tvRFVhdWz2jU/I0UsttRC
 QaR0FEz9qRzf621VE+5+G6LPyMv4sY641mb+iXb1lu2tAh7c/pMH/EZRTTctRXHXMaOl
 CLKdeBH4nk6GtCWFvWQQT3vZ8lErALR9IgVRt+4WV9sQJZZCyYycfHkdpq+/Ho4tI5At
 Isng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MgNvQL45Hwg6psU5bHdK3yy5lx6MA/Ql526zQmB9a9Y=;
 b=EZFlGrLWpG3r+Jkg4marebtaQVmjPkPFaX0en4/Xu6+s+D/fG59Qy6qW2ivZh4379T
 uX0bnRlumXY0LWfgVWmN8CROK5x99fxk174cpC2rM0Vg1KRCJthmLPNshYY1dSemnATG
 H5MUgyACIuZW/Hz2ZxF72mbx9cojVpY+BGq4WWc3uO82eJoye4CBm8Y1rww/8fK5KagQ
 Otru7X9QXBdq/0dxNKAZq0VLy1/t8wdAcXWjv6qiDBQwZue8UCID/A+63H7iBq8cSfrz
 6s2QTtE/rGHAxDd3h/DAZNxOQliACIHdXPvBKq6NAw3avIFbFZXpcCXNL/QzGt5hJBN5
 PuLg==
X-Gm-Message-State: APjAAAV1gShs/FQ3AEO4CYdj+IZftm/mI76wobBQFNq/0eID8yrjhTZx
 HJddvV7bqugiysZRsnf8FzOyGw==
X-Google-Smtp-Source: APXvYqzCqrwPgH0OiASzHgliWZjDEOgl7UXouc4uy/8oVFjS2Eg8MpOuHGgvkvV5PZztQJVwpGpjpA==
X-Received: by 2002:a7b:c7d3:: with SMTP id z19mr4509359wmk.98.1573570234658; 
 Tue, 12 Nov 2019 06:50:34 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 36sm26795482wrj.42.2019.11.12.06.50.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2019 06:50:30 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4DC681FF90;
 Tue, 12 Nov 2019 14:50:29 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 3/8] tests/vm: use console_consume for netbsd
Date: Tue, 12 Nov 2019 14:50:23 +0000
Message-Id: <20191112145028.26386-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191112145028.26386-1-alex.bennee@linaro.org>
References: <20191112145028.26386-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::329
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Kamil Rytarowski <kamil@netbsd.org>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Gerd Hoffmann <kraxel@redhat.com>

Use new helper to read all pending console output,
not just a single char.  Unblocks installer boot.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-Id: <20191031085306.28888-4-kraxel@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

diff --git a/tests/vm/netbsd b/tests/vm/netbsd
index 445c34dc495..0083f7ff6a7 100755
--- a/tests/vm/netbsd
+++ b/tests/vm/netbsd
@@ -93,7 +93,7 @@ class NetBSDVM(basevm.BaseVM):
         for char in list("5consdev com0\n"):
             time.sleep(0.2)
             self.console_send(char)
-            self.console_wait("")
+            self.console_consume()
         self.console_wait_send("> ", "boot\n")
 
         self.console_wait_send("Terminal type",            "xterm\n")
-- 
2.20.1


