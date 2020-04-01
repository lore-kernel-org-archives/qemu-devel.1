Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B4C9C43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 09:52:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2128420772
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 09:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bho9PpvI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2128420772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJa2q-0003oH-Ao
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 05:52:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38494)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jJZyp-0004TV-Dg
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 05:48:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jJZyo-0002Fw-9f
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 05:48:15 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:45978)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jJZyo-0002FX-3D
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 05:48:14 -0400
Received: by mail-wr1-x442.google.com with SMTP id t7so29717079wrw.12
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2020 02:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WLTsGPoiyiZpQWSAjDx1Jd/3OsKOnqyDSFWAME1qJxU=;
 b=Bho9PpvIJqh1yBVCpgktnF2q4gBLJiWRK1Bdesx3wnL+bemJhpFF1PtSZ+V0z2Whcl
 qnChS1AabKalg2BP7QCt6e9x5+0GxJXZhVSve+cbD1XWZkvsnFYExxwP4WasdAmzJj0J
 hYEhtdQc1gRLIleu5WkOCk/gRUSVRzSOvABl/rfkX5KLwSh2fgqh9RYG4gD2EEf+omeo
 P5UTatdU0nrIn57LzZRfvI8FXFZYveF8tlWC1zdqhDnhA4eO/hNs6IucRB1l6c7Wa9N+
 x/6atOLjsBst1LJAEw4RkvK+ntRfZykRlGvD/plb2bySagklsTfkDhdAApKYjyKlDUez
 UAPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WLTsGPoiyiZpQWSAjDx1Jd/3OsKOnqyDSFWAME1qJxU=;
 b=nWQaj1jUyEJDpLujiLffm+QJOGTp14laUIiEi8lJMyIC8+dCquMPIUz1qt7Lj8Slcr
 fT8qAhr2EU4AlPEJTcyO7JiPvfO8NUBmjeInfADxLjA2XWZfxkhNeZRpnF6RHXTwmmXO
 3cGMwTfE2hQw25U2EPVBr5nugSeF/Fd2+bkcFUO47bl/i389uAi8/UEBpDj4XVCWcmAf
 P2abDXvdsmXIlBBTy415yDoCE/nMlm4zOSOaqMdeMwLCDuIYFeU34jeBrBXoZHfG0rSC
 vyO+K3fr2XulfRlAC8hUQfJ696CO1zDdlquqPAWMBNmUjvuDXHDsa0YzdKnAePCB7qgU
 pkaA==
X-Gm-Message-State: ANhLgQ3VHu9JhzhEJ/IwP9CytePMVazEWI1d2sEmcdTEZ8kjxvKcUmu+
 t9sd14xn8bLtI4Jy4wHHUCRaCg==
X-Google-Smtp-Source: ADFU+vvmkcPnEaQoSqVRpRTP7Ezl4fwK7WCuek23SCd9jAE6+pWf+MZLzxDBU85j05YW39uphhtwoQ==
X-Received: by 2002:adf:bb06:: with SMTP id r6mr25539282wrg.324.1585734493143; 
 Wed, 01 Apr 2020 02:48:13 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id r15sm2350519wra.19.2020.04.01.02.48.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2020 02:48:09 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C998A1FF98;
 Wed,  1 Apr 2020 10:48:01 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 09/10] linux-user: clean-up padding on /proc/self/maps
Date: Wed,  1 Apr 2020 10:47:58 +0100
Message-Id: <20200401094759.5835-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200401094759.5835-1-alex.bennee@linaro.org>
References: <20200401094759.5835-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Don't use magic spaces, calculate the justification for the file
field like the kernel does with seq_pad.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 linux-user/syscall.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 0246df01573..b921432f4ff 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7235,6 +7235,7 @@ static int open_self_maps(void *cpu_env, int fd)
     TaskState *ts = cpu->opaque;
     GSList *map_info = read_self_maps();
     GSList *s;
+    int count;
 
     for (s = map_info; s; s = g_slist_next(s)) {
         MapInfo *e = (MapInfo *) s->data;
@@ -7253,20 +7254,24 @@ static int open_self_maps(void *cpu_env, int fd)
             }
 
             if (h2g(min) == ts->info->stack_limit) {
-                path = "      [stack]";
+                path = "[stack]";
             } else {
                 path = e->path;
             }
 
-            dprintf(fd, TARGET_ABI_FMT_ptr "-" TARGET_ABI_FMT_ptr
-                    " %c%c%c%c %08" PRIx64 " %s %d %s%s\n",
-                    h2g(min), h2g(max - 1) + 1,
-                    e->is_read ? 'r' : '-',
-                    e->is_write ? 'w' : '-',
-                    e->is_exec ? 'x' : '-',
-                    e->is_priv ? 'p' : '-',
-                    e->offset, e->dev, e->inode,
-                    path ? "         " : "", path ? path : "");
+            count = dprintf(fd, TARGET_ABI_FMT_ptr "-" TARGET_ABI_FMT_ptr
+                            " %c%c%c%c %08" PRIx64 " %s %d",
+                            h2g(min), h2g(max - 1) + 1,
+                            e->is_read ? 'r' : '-',
+                            e->is_write ? 'w' : '-',
+                            e->is_exec ? 'x' : '-',
+                            e->is_priv ? 'p' : '-',
+                            e->offset, e->dev, e->inode);
+            if (path) {
+                dprintf(fd, "%*s%s\n", 73 - count, "", path);
+            } else {
+                dprintf(fd, "\n");
+            }
         }
     }
 
@@ -7277,9 +7282,10 @@ static int open_self_maps(void *cpu_env, int fd)
      * We only support execution from the vsyscall page.
      * This is as if CONFIG_LEGACY_VSYSCALL_XONLY=y from v5.3.
      */
-    dprintf(fd, TARGET_FMT_lx "-" TARGET_FMT_lx
-            " --xp 00000000 00:00 0 [vsyscall]\n",
-            TARGET_VSYSCALL_PAGE, TARGET_VSYSCALL_PAGE + TARGET_PAGE_SIZE);
+    count = dprintf(fd, TARGET_FMT_lx "-" TARGET_FMT_lx
+                    " --xp 00000000 00:00 0",
+                    TARGET_VSYSCALL_PAGE, TARGET_VSYSCALL_PAGE + TARGET_PAGE_SIZE);
+    dprintf(fd, "%*s%s\n", 73 - count, "",  "[vsyscall]");
 #endif
 
     return 0;
-- 
2.20.1


