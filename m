Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 152B6C7618B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 08:02:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7BD92070B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 08:02:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OtvxHNYs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7BD92070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs0cI-0005vp-4S
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 04:02:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41918)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <renyime@gmail.com>) id 1hs0b6-00045r-F0
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 04:01:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <renyime@gmail.com>) id 1hs0b5-0006Ax-Fq
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 04:01:32 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:36771)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <renyime@gmail.com>) id 1hs0b5-0006AL-AI
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 04:01:31 -0400
Received: by mail-pf1-x441.google.com with SMTP id r7so27602150pfl.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2019 01:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=RCALnrmVXGRwrTMkjZOW8FAYp4R1oPgBYpPgRrkRIeQ=;
 b=OtvxHNYshIwKyLp6bqEllZBPUv/f2gJUPIYxYGcG0whyCzu4b5JBBDicSzrzLITFqR
 dCjlGx3McaIvIM6VayhYMNI3wac62nyvMMYOW7TQaR7xfJgH+VStzZgUnJ2jBZL30IUC
 fOtWYdi3JFIH9zn7lV7nbEbJsRb84YYeO88d4pd2314zASR9W8pylG3YiP3ROMHHhdTQ
 UyvOCQ3At1MS3Me0U1ZZEe5paFLXEIYX+/Xr1s/npjhk9dZG60g5wVQd15hhYXrZXR9e
 xr27eSR1tBXfiV9vzjvOw5q+Vn95YDXHvfimzylKcVJC9luK1tmcG7lqjO80GhzDJ7R7
 BYaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=RCALnrmVXGRwrTMkjZOW8FAYp4R1oPgBYpPgRrkRIeQ=;
 b=L1xTicSOR12aDZZJ1LxkJepTwEnxAHGYFHhq6QT48kwaHZoMgbVN1hhyW0gsxGPzQs
 xerff7ssipTlnI0OtxqSG7DFPhFApDOFFZh7Az8hrFyUA9wTjdGNg9GaxlFE73GsntcG
 cOwjQ7cCUG2SdAywzOGRTau6tnGtKp6g0ikaL0pZOcWZc19UQ4iQ9I39WitgmnaboWpc
 5kFvOp+LZiqQIZuQ9ti4ODqVf5IEACW6T4eECY4eET7mCB/h1OOdNB9C14uDyO9WY/jx
 tC+lppaDdXVUwhrqT6feAJ9SAP0tQ0qg9bx/+Djxnwlg9MJIopqmKtT+PTkVVqTKDi+8
 pIDg==
X-Gm-Message-State: APjAAAUMALjr1h0b+l2FQsBX1MlrvS5tP2OStgjZkpuDslkPnafmbC00
 fDdbIMNWGkdbJQOmFto8WZW512DKKF8t3A==
X-Google-Smtp-Source: APXvYqySLEyYUiRHbqBhjnUkKPn7VegDKew6qVCNtglRnOHOg5Y6gxqPhr0qnj++bhbX7sFEqoCxoA==
X-Received: by 2002:a17:90a:cf8f:: with SMTP id
 i15mr58694851pju.110.1564387290275; 
 Mon, 29 Jul 2019 01:01:30 -0700 (PDT)
Received: from VM_85_204_centos.localdomain ([129.226.55.250])
 by smtp.gmail.com with ESMTPSA id l6sm61237035pga.72.2019.07.29.01.01.29
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Jul 2019 01:01:29 -0700 (PDT)
From: Ivan Ren <renyime@gmail.com>
X-Google-Original-From: Ivan Ren <ivanren@tencent.com>
To: quintela@redhat.com,
	dgilbert@redhat.com
Date: Mon, 29 Jul 2019 16:01:19 +0800
Message-Id: <1564387281-12321-2-git-send-email-ivanren@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1564387281-12321-1-git-send-email-ivanren@tencent.com>
References: <1564387281-12321-1-git-send-email-ivanren@tencent.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: [Qemu-devel] [PATCH v2 1/3] migration: add
 qemu_file_update_transfer interface
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add qemu_file_update_transfer for just update bytes_xfer for speed
limitation. This will be used for further migration feature such as
multifd migration.

Signed-off-by: Ivan Ren <ivanren@tencent.com>
---
 migration/qemu-file.c | 5 +++++
 migration/qemu-file.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index 0431585502..18f480529a 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -615,6 +615,11 @@ void qemu_file_reset_rate_limit(QEMUFile *f)
     f->bytes_xfer = 0;
 }
 
+void qemu_file_update_transfer(QEMUFile *f, int64_t len)
+{
+    f->bytes_xfer += len;
+}
+
 void qemu_put_be16(QEMUFile *f, unsigned int v)
 {
     qemu_put_byte(f, v >> 8);
diff --git a/migration/qemu-file.h b/migration/qemu-file.h
index 13baf896bd..5de9fa2e96 100644
--- a/migration/qemu-file.h
+++ b/migration/qemu-file.h
@@ -147,6 +147,7 @@ int qemu_peek_byte(QEMUFile *f, int offset);
 void qemu_file_skip(QEMUFile *f, int size);
 void qemu_update_position(QEMUFile *f, size_t size);
 void qemu_file_reset_rate_limit(QEMUFile *f);
+void qemu_file_update_transfer(QEMUFile *f, int64_t len);
 void qemu_file_set_rate_limit(QEMUFile *f, int64_t new_rate);
 int64_t qemu_file_get_rate_limit(QEMUFile *f);
 void qemu_file_set_error(QEMUFile *f, int ret);
-- 
2.17.2 (Apple Git-113)


