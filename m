Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E219CC33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 18:56:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5E342072A
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 18:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HogvO3OA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5E342072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioXYW-0000qj-As
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 13:56:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45561)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielhb413@gmail.com>) id 1ioX4H-0002EF-9w
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:25:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1ioX4F-0004IB-Fx
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:25:33 -0500
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843]:44904)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1ioX4E-0004Gm-8c; Mon, 06 Jan 2020 13:25:31 -0500
Received: by mail-qt1-x843.google.com with SMTP id t3so43182952qtr.11;
 Mon, 06 Jan 2020 10:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=a9jsk8u+/5hibvcbWneMzoArJdAq2nWhpUyUdOQCk1M=;
 b=HogvO3OAHqmXNQNWDvBqNkfr5eN91mMiemuxU5UdLdAjJb5muyyyIsEznFNTt9Ea+q
 DTZkVChOcIWsLAWQqKk/UWwC+Lk3NoJb15mgilFglc7lEbTlgS8aa/25SQhXW2fBpnnT
 jMOG101eQ8ICQw0/M1pnNwaHSGkq8EumOBxFM9lhm90unF4X4lxwZuYYP5L+F9MDLY7o
 Htg0NnhD6bYmxcCdUzAZdEcCNr7X76bnCQIWCl0q6am2rvW6HOzTZdnfR0KnMPbQUwb9
 3ABKOU4DKFxLlB6BhhiQeQC3PvcMXP9o8YD6wqJB9owvrGbt74IXsR7pHe4kgstuo2iG
 cxig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=a9jsk8u+/5hibvcbWneMzoArJdAq2nWhpUyUdOQCk1M=;
 b=XmWerVyY7t+rI5/XIsfLQxumeDa8loovgFfejZYHW0fss/O9eYwy+uPujIKLtFANm3
 VNXz9DoXTm8rG/x+M+flW+uxAhBo1cNFuCS6eIAzEJPSMIknbkVrKHhSnzvVPTz2KLg+
 b4g+c4QbHwe4VnZcw5aSjTjMWasTgRwnBFMq0/CGLbnwTerXR+2z92ZQlAgxCY5zQvu9
 FqY9706vmTMd5zpgIAHPPpCVaIuY1LBfjgG3SSzS5htXohp3YokEeHDIqk06+qOHjvVc
 yg1iukMiQfJ+j5O3/BtbIRvL3N8bdc+xwgSh6ShitL2FulLwZHc277wFKlaYih/1/nzW
 MrcA==
X-Gm-Message-State: APjAAAWEzrCFjVBPAp9SWETdbhFkIzyY0LC8sPBRwQ1BfWpNuwgIkdIU
 XWZko4veW7lli2OAAuYcBX8Kx7M+
X-Google-Smtp-Source: APXvYqzKjaRzSrLUDb5OgrpFLF8q43Lcha4CSMKbMWZawaidR3nbPVnUEDfKMRgcd9g1WNdLHGLAhw==
X-Received: by 2002:aed:2be4:: with SMTP id e91mr77977865qtd.148.1578335129743; 
 Mon, 06 Jan 2020 10:25:29 -0800 (PST)
Received: from rekt.ibmuc.com ([2804:431:c7c6:655b:9e1c:e865:3705:e1df])
 by smtp.gmail.com with ESMTPSA id b81sm21026522qkc.135.2020.01.06.10.25.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2020 10:25:29 -0800 (PST)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 21/59] block/backup.c remove unneeded 'out' label in
 backup_run()
Date: Mon,  6 Jan 2020 15:23:47 -0300
Message-Id: <20200106182425.20312-22-danielhb413@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200106182425.20312-1-danielhb413@gmail.com>
References: <20200106182425.20312-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::843
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
Cc: qemu-trivial@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

'out' can be replaced by 'return ret' and 'return -ECANCELED'.

CC: John Snow <jsnow@redhat.com>
CC: qemu-block@nongnu.org
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 block/backup.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index cf62b1a38c..e73294872c 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -254,13 +254,12 @@ static int coroutine_fn backup_run(Job *job, Error **errp)
 
         for (offset = 0; offset < s->len; ) {
             if (yield_and_check(s)) {
-                ret = -ECANCELED;
-                goto out;
+                return -ECANCELED;
             }
 
             ret = block_copy_reset_unallocated(s->bcs, offset, &count);
             if (ret < 0) {
-                goto out;
+                return ret;
             }
 
             offset += count;
@@ -284,7 +283,6 @@ static int coroutine_fn backup_run(Job *job, Error **errp)
         ret = backup_loop(s);
     }
 
- out:
     return ret;
 }
 
-- 
2.24.1


