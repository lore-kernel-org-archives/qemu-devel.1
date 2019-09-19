Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B43C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 21:49:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 231DF217D6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 21:49:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f6eO/JHk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 231DF217D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB4Iv-0002bk-50
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 17:49:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56263)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tcminyard@gmail.com>) id 1iB49Z-0001W5-UF
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 17:40:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tcminyard@gmail.com>) id 1iB49L-00067e-9A
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 17:39:51 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:41334)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1iB49L-00067P-4A
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 17:39:39 -0400
Received: by mail-ot1-x341.google.com with SMTP id g13so4435599otp.8
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 14:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=5IGB425rPWZv6PIAxxgYjNsziWO2Aym53s828C6B59k=;
 b=f6eO/JHkxF8rpFPmPfyZBdK5XnzYZ08xkGF6yBaNn+tGSlFPUDHgJhLxBgxgWDyKeG
 T8VjjlVVd+lerZ7Qcpf1ZMdQ5r6Sndlle8hYEx53foA2NxWV+egPmaYggxHQ/PoDZ+Mp
 uNg7meWFpF34+w73my3BhJLL5PXaS8xJRNUd5LmJ67NccZtrxQbvTesFBV4j6ISbacGI
 h2cZv7mi6q3oR7xCsD/bE3O1ArNtC+zfJiIdppSeZiA9ECv6cZIXhMSAW3RnYzr4dQVh
 EeVo0nBQv9O4qkdDeC9+v+Suwswr4qbMiIUNgpt7nw3aCg8S85X8J9BRi9Q9rJs21cqZ
 0QCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=5IGB425rPWZv6PIAxxgYjNsziWO2Aym53s828C6B59k=;
 b=byeK+xSI55BH/75NR3QuGb+tcZmm/Lbe54abJ0JZgPftP7zd1c1s2NCFnRk4yl3v2x
 mNneLxwjcoAs0R3SHLSUSRX2+WWVxn7l4vpWvju0P9woySiXcpszLqCAoj/j3ONJCsgv
 ociRi6VLK3YbIidL/Rp4scZ7R3ovnEZtUdwsGncE5WqBKu/vI8ORQrg64lglv51f3ICg
 61LPFTJBsCr2zQUJL2XR7zGyF4EVC3cSfnvOAyMyfOKpxfwwIzPyGOi7a+j5aWVnwnP8
 BTsnyD6uOmg/Mq32dtm5T4mki/xMOPE7J2zJWLgbAP5uKhuaab9VEerACUIjNrhmUoAw
 VIvA==
X-Gm-Message-State: APjAAAUATTlgIXbdM3pPKnTQxNwk6csUl9KwLJUn36GxdmKmLOVb2BO3
 pDsDWUqwRFblo5xhNWgfkA==
X-Google-Smtp-Source: APXvYqxxbatzF0qNdrR6VcJgnE+Q1xRiwpH4RgsqIdkBs7PWk5tp6e5fKc/KI6+RuLNGmZr/g1a0TQ==
X-Received: by 2002:a9d:128c:: with SMTP id g12mr9010106otg.239.1568929178116; 
 Thu, 19 Sep 2019 14:39:38 -0700 (PDT)
Received: from serve.minyard.net ([47.184.136.59])
 by smtp.gmail.com with ESMTPSA id t12sm34378otl.35.2019.09.19.14.39.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2019 14:39:36 -0700 (PDT)
Received: from t560.minyard.net (unknown [192.168.27.180])
 by serve.minyard.net (Postfix) with ESMTPA id BF44B18059B;
 Thu, 19 Sep 2019 21:39:35 +0000 (UTC)
From: minyard@acm.org
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 02/15] ipmi: Fix the get watchdog command
Date: Thu, 19 Sep 2019 16:39:11 -0500
Message-Id: <20190919213924.31852-3-minyard@acm.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190919213924.31852-1-minyard@acm.org>
References: <20190919213924.31852-1-minyard@acm.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: Corey Minyard <cminyard@mvista.com>, Fam Zheng <famz@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Corey Minyard <cminyard@mvista.com>

It wasn't returning the set timeout like it should have been.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 hw/ipmi/ipmi_bmc_sim.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
index 8f63bb7181..afb99e33d7 100644
--- a/hw/ipmi/ipmi_bmc_sim.c
+++ b/hw/ipmi/ipmi_bmc_sim.c
@@ -1228,6 +1228,8 @@ static void get_watchdog_timer(IPMIBmcSim *ibs,
     rsp_buffer_push(rsp, ibs->watchdog_action);
     rsp_buffer_push(rsp, ibs->watchdog_pretimeout);
     rsp_buffer_push(rsp, ibs->watchdog_expired);
+    rsp_buffer_push(rsp, ibs->watchdog_timeout & 0xff);
+    rsp_buffer_push(rsp, (ibs->watchdog_timeout >> 8) & 0xff);
     if (ibs->watchdog_running) {
         long timeout;
         timeout = ((ibs->watchdog_expiry - ipmi_getmonotime() + 50000000)
-- 
2.17.1


