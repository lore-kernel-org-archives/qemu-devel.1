Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5910C352A4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 03:23:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2FC320873
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 03:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HIXbCS1Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2FC320873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2567-00042E-TL
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 22:23:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60179)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j255G-0002Hb-3e
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 22:22:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j255F-0000NF-2o
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 22:22:34 -0500
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:52547)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j255E-0000Lv-Ti
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 22:22:33 -0500
Received: by mail-pj1-x1044.google.com with SMTP id ep11so1746732pjb.2
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 19:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FNe39eIz0v47jOI5MYP3eadgdWO6rgbl92hzBmHUc0w=;
 b=HIXbCS1ZU372+NaJEEEzzWn7BlZr4pjvORj7nWp9LM5MR7V83wNETb0Pcgamv9jjPM
 MSCSrrwrVfKyjCrW9VbMTD6ZyvA9ltnyrPka96gWtNueWaFKyXL1LO6HzRZ1LxlsHwJH
 E4R9Dx/cdFt90v13RlD8xWLD+dUZk/Yku707pLxH9CFq3wSpyMKeXt7lvT0GR4/cvo37
 aaByeQR7+gU7LctR6vhj89U4o+I0JElRL2jhtmhu8FmUNxZ9Iw95SJtqNwK9Ddn+FvKN
 IJMW05OECoHeWggQkSZrEjXuknGc8k9+psGW8QKHPQC1BjEZY92dYPBd/k7xZdaBIjqI
 HJIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FNe39eIz0v47jOI5MYP3eadgdWO6rgbl92hzBmHUc0w=;
 b=jJYh5IKeLU7vK9Fye2wJUzjZiNxY0vZMD0vwMx1kCBKjSuNffL6EE/CnN1jtR3zavh
 Ce8R7mOOn4LxHdqNFQY1/s3iChuQKs6FX5Y3S7yiD58S4xhc2nYqx5FpLH+/WN4Wc3fp
 4mq1/57F6LgQVl/h1OqoouNrS2BPkUdfg8yzyW3KUmNTZI7OD+MUGLeEFYbTIN5aDn4/
 j19sb0UfB3f5Zsgldk0SeEz43wfBOfs/ZCDO18wemDoZWXV2RzoUgeMzKJZMrXzXAlyu
 C+siWHRRxrECPWpU1LRx8CX+qi+Y64co9lMSq2F7d8y7GXpcpSJGe0q4Xc0Yfg3PS1ew
 M9AA==
X-Gm-Message-State: APjAAAWxbI/LiWb6ao5lCPNUBt7xuYB6BwQR908IWW1Q0T6Brb9EsEOV
 YIyMocWafGyaID1TJ8bWGFVBvZ0JDu0=
X-Google-Smtp-Source: APXvYqyak25r4LPVhe+F5zIlK4XmRTb7Jzafj/0qKW1dXi84aA/MhMrPUXVVG5JSr+dtW3/Z4cdcOQ==
X-Received: by 2002:a17:902:ab95:: with SMTP id
 f21mr10487855plr.188.1581564150563; 
 Wed, 12 Feb 2020 19:22:30 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id l15sm536067pgi.31.2020.02.12.19.22.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Feb 2020 19:22:29 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 4/5] linux-user: Add x86_64 vsyscall page to /proc/self/maps
Date: Wed, 12 Feb 2020 19:22:22 -0800
Message-Id: <20200213032223.14643-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200213032223.14643-1-richard.henderson@linaro.org>
References: <20200213032223.14643-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1044
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
Cc: laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The page isn't (necessarily) present in the host /proc/self/maps,
and even if it might be it isn't present in page_flags, and even
if it was it might not have the same set of page permissions.

The easiest thing to do, particularly when it comes to the
"[vsyscall]" note at the end of line, is to special case it.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v3: Use TARGET_VSYSCALL_PAGE.
---
 linux-user/syscall.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index d60142f069..b684727b83 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7012,6 +7012,16 @@ static int open_self_maps(void *cpu_env, int fd)
         }
     }
 
+#ifdef TARGET_VSYSCALL_PAGE
+    /*
+     * We only support execution from the vsyscall page.
+     * This is as if CONFIG_LEGACY_VSYSCALL_XONLY=y from v5.3.
+     */
+    dprintf(fd, TARGET_FMT_lx "-" TARGET_FMT_lx 
+            " --xp 00000000 00:00 0 [vsyscall]\n",
+            TARGET_VSYSCALL_PAGE, TARGET_VSYSCALL_PAGE + TARGET_PAGE_SIZE);
+#endif
+
     free(line);
     fclose(fp);
 
-- 
2.20.1


