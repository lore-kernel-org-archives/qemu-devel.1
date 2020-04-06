Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80649C2BA17
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 18:17:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52C312064A
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 18:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLWfUpjU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52C312064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLWJm-00054U-Gj
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 14:17:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37010)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVrx-0003Px-To
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:49:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVrw-0003iX-Ms
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:49:09 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:34532)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVrw-0003i4-H6
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:49:08 -0400
Received: by mail-wm1-x32c.google.com with SMTP id c195so141598wme.1
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2020 10:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nkfwxbmtcGQqcNqONxBS4N4Qsj6iJU2M8QyuqgwGWzE=;
 b=dLWfUpjUZOenWr/sbg3dz0Pij4xjwUOFwsb+Q5moUMkgxhoL8wm2DnxVMbKsW1eBoY
 R97VxY0O72WkW2Hjncly8MHZ96yD4D4EMSnATiH5eZyfInP8Nrpojd4k19MxFeleiF3C
 CPidTx/sTmyG+s2EFHyQ4SSdlWg7NmNKQdc7RTTZZeh6kkfDBZe235pdtYCv9rEZGzXQ
 TTKlX17Pgfca8gxmypsTMCDCJ6FydbtxLZB1coFBOxqeAWhpiv9Pkl107FKMzu+kT+ir
 EjgZJMo64ToieWqr8ilTJxOuNi54H/fYpbCkx2N+7kjZ3qGZKTSfJmnFVdfjHVREIcU6
 pqkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=nkfwxbmtcGQqcNqONxBS4N4Qsj6iJU2M8QyuqgwGWzE=;
 b=ZlgI9pnZpJ0vaXQiZ8wzTLgBuze+HWMuuAzvQm+uARcKfLwBdh5mFdcXhOpM2HkvxM
 hwzAIwGP6n6mgz0OXM+t7RZhS2rpxltSR/ErWuRDIcLldzFB9FRkOOKOrSlRPNeYvF80
 NM+/nL0UORSzXZh2gvpzskz97CK8SKXzIfcNI/OCq2BwTYfSVaQVvbRRVw+TpMwFxgys
 yYW38EH+NtO4OV1wi49EgIefU1Dgo1nmLh8Pi/SP0PRavvZjqNbpI+01OaGicvjng5es
 iwLWtI6c1T68LLAFsKWPidI0ObglHPoMMUWsAy37wVtW1419ABCQ1pdqQ1VctufdMspt
 b5OQ==
X-Gm-Message-State: AGi0PuZr3rDhD+4iKyyl+m84ow8N4SBLiabPckTOqDzd7ihnIRjuAn9T
 o2/4LMsUO81fSlr5/wdLZ4p8XnYXR5I=
X-Google-Smtp-Source: APiQypIJAsO6bfUkykEv0EHFpeDq8wqPkH8KhP/yrE+AitNxWlBtffO1Qf+akL/6t8GwN4Kh3BkV4Q==
X-Received: by 2002:a7b:c4d0:: with SMTP id g16mr156168wmk.101.1586195344361; 
 Mon, 06 Apr 2020 10:49:04 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id a67sm364880wmc.30.2020.04.06.10.49.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2020 10:49:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Subject: [PATCH-for-5.1 v2 51/54] migration/colo: Add missing
 error-propagation code
Date: Mon,  6 Apr 2020 19:47:40 +0200
Message-Id: <20200406174743.16956-52-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200406174743.16956-1-f4bug@amsat.org>
References: <20200406174743.16956-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32c
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Hailiang Zhang <zhang.zhanghailiang@huawei.com>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Running the coccinelle script produced:

  $ spatch \
    --macro-file scripts/cocci-macro-file.h --include-headers \
    --sp-file scripts/coccinelle/find-missing-error_propagate.cocci \
    --keep-comments --smpl-spacing --dir .
  HANDLING: ./migration/colo.c
  [[manual check required: error_propagate() might be missing in migrate_set_block_enabled() ./migration/colo.c:439:4]]

Add the missing error_propagate() after review.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 migration/colo.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/migration/colo.c b/migration/colo.c
index a54ac84f41..57b2adb0cc 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -437,6 +437,9 @@ static int colo_do_checkpoint_transaction(MigrationState *s,
 
     /* Disable block migration */
     migrate_set_block_enabled(false, &local_err);
+    if (local_err) {
+        goto out;
+    }
     qemu_mutex_lock_iothread();
 
 #ifdef CONFIG_REPLICATION
-- 
2.21.1


