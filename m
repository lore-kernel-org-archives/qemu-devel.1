Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32660C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 10:02:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0C4F2088E
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 10:02:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qnap.com header.i=@qnap.com header.b="QERepN8P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0C4F2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=qnap.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo2EN-0000Ou-8F
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 06:02:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42798)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dereksu@qnap.com>) id 1jo2DL-0008FY-7k
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 06:01:08 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:37144)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dereksu@qnap.com>) id 1jo2DI-0003E9-R5
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 06:01:06 -0400
Received: by mail-pl1-x641.google.com with SMTP id y18so874194plr.4
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 03:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qnap.com; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=E9GFs1hHVl70+owPehV4Z9aeYxNzgO8lmUTpikjezqk=;
 b=QERepN8PLz/yEQVtoyPIt4WrXFma2zVbEjcOTqaLUU+gfOLacfZCq92EDeDh2rWw40
 K307pamdmFpTgGjAOmbwFf1t1ziM7ENbv3fAo6ytxBD55JZ6H9q09RZHshZPuCumNqEg
 Bb1RXXxhPL45+d6hVxi3bfsK5K0UpyiQ/PWiw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=E9GFs1hHVl70+owPehV4Z9aeYxNzgO8lmUTpikjezqk=;
 b=SbAkS+5nyN+xt4yI8107OPyAn8DOEBbiKDcaOoByevlMPbRTgx4XqJKMRH5p5iLMwq
 VpQtVwpgH3ob+HL/Qxst9nMI54EFEvcK0XxCQqVKrzPzsoGPYKg3oG8hasWW8gnP9h7R
 kf//LyEWC//MSNz6VG/r+QbeAsX8IFPz1naGth6sUUyHmGLIsiutFczso1DA/WEWYDPy
 OK2kxHXRY8+cdwKyZW+mpWnoeh+Hd6CPXSr52qe000zgI4PSgNddqrpBDGaw8mdDYbN5
 qfrEJROAqstYPu+9Ol+d/ztNSxK5MxPvGs4VTbSneQ0EALpeowViIfHFRvpo8le7sFOp
 XXQA==
X-Gm-Message-State: AOAM531rLK7uBNIsrUEqPCsbW3BYby3xTu4aCQF2RttjbcI5nKIKu6zQ
 QSf8Z86VknKdtov7JTXwxL/eTDKcfTcFlQ==
X-Google-Smtp-Source: ABdhPJzIJUpq7Jhqe1lRSjEOSfdA0LF7zn2PM0UVERPxJC6xrXY790ipqw6W9i5/bQZV1A6iCB89Dw==
X-Received: by 2002:a17:90a:6b08:: with SMTP id
 v8mr28935551pjj.162.1592992861880; 
 Wed, 24 Jun 2020 03:01:01 -0700 (PDT)
Received: from localhost.localdomain (202-39-79-13.HINET-IP.hinet.net.
 [202.39.79.13])
 by smtp.gmail.com with ESMTPSA id z24sm20042137pfk.29.2020.06.24.03.00.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2020 03:01:01 -0700 (PDT)
From: Derek Su <dereksu@qnap.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1] chardev/char-socket: fix double free of err after socket
 is disconnected
Date: Wed, 24 Jun 2020 18:00:54 +0800
Message-Id: <20200624100054.7168-1-dereksu@qnap.com>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=dereksu@qnap.com; helo=mail-pl1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Derek Su <dereksu@qnap.com>, marcandre.lureau@redhat.com,
 jwsu1986@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The err is freed in check_report_connect_error() conditionally,
calling error_free() directly may lead to a double-free bug.

Signed-off-by: Derek Su <dereksu@qnap.com>
---
 chardev/char-socket.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index afebeec5c3..a009bed5ee 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -1086,7 +1086,11 @@ static void qemu_chr_socket_connected(QIOTask *task, void *opaque)
     if (qio_task_propagate_error(task, &err)) {
         tcp_chr_change_state(s, TCP_CHARDEV_STATE_DISCONNECTED);
         check_report_connect_error(chr, err);
-        error_free(err);
+
+        if (!s->connect_err_reported) {
+            error_free(err);
+        }
+
         goto cleanup;
     }
 
-- 
2.17.1


