Return-Path: <SRS0=kd+i=55=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 603C8C2BA2B
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 20:54:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2240120656
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 20:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bFe6JOqK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2240120656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jO65f-00072H-8J
	for qemu-devel@archiver.kernel.org; Mon, 13 Apr 2020 16:53:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36019)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jO64o-0006Fd-Gf
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 16:53:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jO64n-0008DE-Eq
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 16:53:06 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:38414)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jO64n-0008AQ-8P
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 16:53:05 -0400
Received: by mail-wr1-x430.google.com with SMTP id k11so11085234wrp.5
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2020 13:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cq4SYX1xB02rm5tx4ZW/dd/4RXE5CGOFLNOTw+3yasw=;
 b=bFe6JOqKSVyoha6O+PdlV8H3q508ylQYoPs5i9hC9kzIZL99pWR697BPh9zYKoq+kw
 0+x3MYI5pTuUtKEvAgy3Koq8s1zYPCTm/UtER1KJYc84QSDEaH0S8RqUQdyzcRAii0Fu
 34REgE+NbADXzcGYX95GFRsFUB2CjSHepAE26z+s318ZXmIXTsCVoUYlJ/USNC7c5ina
 TXWnjs7yEXDrO6wtg+O+Kpe++1LJiBVn6JOCFWpcRbQ74Y++zDN0kiMgqD7VPW/XJMV4
 S91/iKtC4KDk/jcrsitZxsQ4s21YY8+2b1ihPCcY0Ip/5cBv+GDCt8O1O+93t8CMpMaZ
 6x7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=cq4SYX1xB02rm5tx4ZW/dd/4RXE5CGOFLNOTw+3yasw=;
 b=re9AscEaX7YdBBRbW1UUmNttAh/c6zIEl7I/0LYy3cZvMYtvZW92Irto6HhnCnNwRf
 NYSUI72oxfZ3n4z5u2LwQmXjhayUEK8PLHAk/64qi5frx3ucRSXdjlOzIYS4eyhHcD17
 GYBZH0328IgHyLuSGZlEjQmNhEEd8CtqFv9NJTPWNmTgdcjzEoBFYbVLGrp9CtUdYwaI
 ZvFh8CWCH8bLPLVeD56kmhKVJYcbKzSv5neCfhAKQv4lTCmUiK0uQ7OEKTQccdxm1jAR
 cDNupCnBWFPHY/ai1z8kWGYP4BZDWTEDz2gE5o48psakf1D/sqDHrfIanuL0IqfrGZQH
 S7cA==
X-Gm-Message-State: AGi0Pua3wJM82pKynkdnQTI+dYwMkIzdIizR9yIohVcPCxTcuKZ1yImF
 koLH0UU3PN+MUbGs1ygMZl1olP0k6to=
X-Google-Smtp-Source: APiQypJIgFXcN9hdXY+vBkUr+2ZqRss4uVGDavqmNSip/5QWTnxlxWB871X5b7YSXmFeAvlxJT8E+A==
X-Received: by 2002:a5d:6412:: with SMTP id z18mr7448919wru.322.1586811180117; 
 Mon, 13 Apr 2020 13:53:00 -0700 (PDT)
Received: from localhost.localdomain (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id b11sm16380603wrq.26.2020.04.13.13.52.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2020 13:52:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.1 v3 4/7] migration/colo: Add missing error-propagation
 code
Date: Mon, 13 Apr 2020 22:52:49 +0200
Message-Id: <20200413205250.687-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: 20200412224517.12869-1-f4bug@amsat.org
References: 
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::430
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
Cc: Juan Quintela <quintela@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Hailiang Zhang <zhang.zhanghailiang@huawei.com>
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

Reviewed-by: Juan Quintela <quintela@redhat.com>
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


