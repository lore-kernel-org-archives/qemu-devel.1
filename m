Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D4EC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:54:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64CE420679
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="phqAh/g2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64CE420679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlCyZ-0001VK-Ju
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 10:54:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58146)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCQl-0003ec-3u; Tue, 16 Jun 2020 10:19:15 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:46993)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCQh-0006yE-Qj; Tue, 16 Jun 2020 10:19:14 -0400
Received: by mail-oi1-x242.google.com with SMTP id 25so19336412oiy.13;
 Tue, 16 Jun 2020 07:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=IhA7tGc4qQITgrYTWHPDVz8A3fUsUmDnXkD5C60/dcc=;
 b=phqAh/g2YyNhyYCcznlu2ECdKdM0Hr6yuvdTPxKmWmQR4xxGMx9tvaVvhlLv3to1jK
 JdH5PfVSRY6yw/Swf9N/R5/8apODnV7eyUJcPkKxcniHwOzJxk01lTo4nCk+chll+YTh
 LqZTQ4dJvh0V7sT7FIi9dhkMg3PfWfmY+mBhrT7JmG8u10Pa2l6c9c9SSQn5uooMuOMz
 y+Cv66OKlXOPjPU3/hGZQithDbp4VHiT4OuKMJRFhT/xfYd2IfPl0OEKX2n18vjOmBMf
 kYhw3Gct3zujlhPMU4b1cnEIf4yALFghhuW96IgW204U2MlT1Y1fijA/NP3lMGcAGTUW
 82Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=IhA7tGc4qQITgrYTWHPDVz8A3fUsUmDnXkD5C60/dcc=;
 b=G+yv/dmRDqv18/4zrPLo3QDS4uP0ov2xpnCcMgB3Jy6omE8huL4vKC8rqpj7yZLgNC
 p9d/yy86ru/hFBLtvvjYw2zSkhdnZIp8Iy8fPr6LTK5HUU0P6RJofxR8Vvt8gBOYvbkE
 YhoopCIe0nFPHeHEA/2BMaUoQ77nfXaXSzqW31LeHuAkmD3E4NFVUFyxyaxREYuKdeJ4
 6zK/qYwNXHncwmfb/WS4K1h6WqX7EMxfziKIZ3sN2Vv/WAxM1oaVtQRjxI1dINq76JT8
 GZnNhGnnIPnTytOBDn8PvbqLvJAFmeDTXDXjW+YWPJ4lwMxbhpR/RLMsPtojmN5boWYh
 NKOw==
X-Gm-Message-State: AOAM532dQTtGdnH7dm7i75NbuAYPtPeTPqghNoRwFtUemPw9hBW1PrQW
 2naXzBxRYksKUqeR000G65297J2s
X-Google-Smtp-Source: ABdhPJz161B8mMuQHVo7VUZnppv5cLaSH+XIZyIK3/i25uAoSYq1AOoqbirZIFziElVD2sw8CjdBOA==
X-Received: by 2002:aca:eb42:: with SMTP id j63mr3315973oih.144.1592317147300; 
 Tue, 16 Jun 2020 07:19:07 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id m13sm4086378oou.25.2020.06.16.07.19.05
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 16 Jun 2020 07:19:06 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 60/78] qga-win: prevent crash when executing guest-file-read
 with large count
Date: Tue, 16 Jun 2020 09:15:29 -0500
Message-Id: <20200616141547.24664-61-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
References: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::242;
 envelope-from=flukshun@gmail.com; helo=mail-oi1-x242.google.com
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
Cc: Basil Salman <basil@daynix.com>, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Basil Salman <basil@daynix.com>

guest-file-read command is currently implemented to read from a
file handle count number of bytes. when executed with a very large count number
qemu-ga crashes.
after some digging turns out that qemu-ga crashes after trying to allocate
a buffer large enough to save the data read in it, the buffer was allocated using
g_malloc0 which is not fail safe, and results a crash in case of failure.
g_malloc0 was replaced with g_try_malloc0() which returns NULL on failure,
A check was added for that case in order to prevent qemu-ga from crashing
and to send a response to the qemu-ga client accordingly.

Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1594054

Signed-off-by: Basil Salman <basil@daynix.com>
Reported-by: Fakhri Zulkifli <mohdfakhrizulkifli@gmail.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
(cherry picked from commit 807e2b6fce022707418bc8f61c069d91c613b3d2)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qga/commands-win32.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 55ba5b263a..01e02e4440 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -342,7 +342,13 @@ GuestFileRead *qmp_guest_file_read(int64_t handle, bool has_count,
     }
 
     fh = gfh->fh;
-    buf = g_malloc0(count+1);
+    buf = g_try_malloc0(count + 1);
+    if (!buf) {
+        error_setg(errp,
+                   "failed to allocate sufficient memory "
+                   "to complete the requested service");
+        return NULL;
+    }
     is_ok = ReadFile(fh, buf, count, &read_count, NULL);
     if (!is_ok) {
         error_setg_win32(errp, GetLastError(), "failed to read file");
-- 
2.17.1


