Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B74C43461
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:40:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE006206CA
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:40:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pqg7KMIG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE006206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDwyN-000689-1K
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 17:40:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58838)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwLW-0004Dl-Cq; Thu, 03 Sep 2020 17:00:38 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:43221)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwLU-0007ib-Ky; Thu, 03 Sep 2020 17:00:37 -0400
Received: by mail-ot1-x344.google.com with SMTP id v16so3994049otp.10;
 Thu, 03 Sep 2020 14:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=8v8cuelUN4GNnzF59rwkxhYKTzREPiqFMDPQs9yKMw0=;
 b=pqg7KMIGJN9NCyskp9TxALEebbe2hnxOeBp3wDMrF0amNBxJCYXxUtMbYtJH2bH+Jk
 /cFzgUNPC2ebnNUSg3RCbwKH1RhcpeAIWCTfhz0OFNqRKaNLX9/gI2K/uysvDqNtD4Xk
 zvt0UNYOjngrUoTgXz254s4ClzdQTp8mifyJXbqypMR1gLv6JOcTWU/GUyw8SuYKUqFb
 DkvKWPtVyZyRUbqRlg/CWfJbjQypLvDYgRdo99oiU8PFpQBASzowhyyLBCKAila3RS0o
 GB0AtkJ273Pfzxn8YTUfCjUwFVzrsKNWB5MMN6FM/27bxVlY5dKEwEdabSTgB2hmD20J
 4K9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=8v8cuelUN4GNnzF59rwkxhYKTzREPiqFMDPQs9yKMw0=;
 b=QUJ7kH+R2cBPfKf7bof3XFyynMK4gM6G90JxpC/nZCJOpfNicSnd5OL3SPVWgxd8lg
 Y7qExqi4j3VPgmzQLBZeelurhrEECAmZnfWfmpOM8rIJTiwnF2ZTvXywuv5oEiHsZ7lY
 FTZg4/+Z8NCw0mHaYvYr1vWhN/N6tTGrcnKviwBkCW12KcFue6tcAo+M8XWYLGWcMuoB
 d3KXpSjDn3aoSuCZqc+yc+OeTmdYwlNUG1JXCobbu5DlD959ELpJg220HKcCa0X9W97c
 Qw3+SGptOiegUgp9st22d1sqxRcSDlPneymc5m67qN+45/N1qoFaCT3a6rrwAHnxCgOs
 IPTQ==
X-Gm-Message-State: AOAM530n4M2xk7AfLu8Y3KMQftCBN75FB06rRO1Ng5RNJdTVGOdelJAj
 EAJDuN3LvTs1vOIZET9Dk94aW79d3oQ=
X-Google-Smtp-Source: ABdhPJyPCW6QRlx6jtQmUeoHq2d4RKVAnO8JJyumEjJidIygoWugUOcTaffMWyByF+VeoyjuaECHhw==
X-Received: by 2002:a9d:2667:: with SMTP id a94mr2869390otb.45.1599166834423; 
 Thu, 03 Sep 2020 14:00:34 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id i6sm718571oib.17.2020.09.03.14.00.33
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 03 Sep 2020 14:00:33 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 41/77] chardev/tcp: Fix error message double free error
Date: Thu,  3 Sep 2020 15:58:59 -0500
Message-Id: <20200903205935.27832-42-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
References: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=flukshun@gmail.com; helo=mail-ot1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: lichun <lichun@ruijie.com.cn>, qemu-stable@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: lichun <lichun@ruijie.com.cn>

Errors are already freed by error_report_err, so we only need to call
error_free when that function is not called.

Cc: qemu-stable@nongnu.org
Signed-off-by: lichun <lichun@ruijie.com.cn>
Message-Id: <20200621213017.17978-1-lichun@ruijie.com.cn>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
[Commit message improved, cc: qemu-stable]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
(cherry picked from commit ed4e0d2ef140aef255d67eec30767e5fcd949f58)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 chardev/char-socket.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index e5ee685f8c..58917870cd 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -142,6 +142,8 @@ static void check_report_connect_error(Chardev *chr,
                           "Unable to connect character device %s: ",
                           chr->label);
         s->connect_err_reported = true;
+    } else {
+        error_free(err);
     }
     qemu_chr_socket_restart_timer(chr);
 }
@@ -1083,7 +1085,6 @@ static void qemu_chr_socket_connected(QIOTask *task, void *opaque)
     if (qio_task_propagate_error(task, &err)) {
         tcp_chr_change_state(s, TCP_CHARDEV_STATE_DISCONNECTED);
         check_report_connect_error(chr, err);
-        error_free(err);
         goto cleanup;
     }
 
-- 
2.17.1


