Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7437EC10DAA
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:42:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34711206D4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:42:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NytrLzEv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34711206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDwzu-0000rf-9c
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 17:42:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58860)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwLX-0004H8-LS; Thu, 03 Sep 2020 17:00:39 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:34043)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwLV-0007j6-Q4; Thu, 03 Sep 2020 17:00:39 -0400
Received: by mail-ot1-x341.google.com with SMTP id h17so3208928otr.1;
 Thu, 03 Sep 2020 14:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=oq3rmsSk19eLVuEsf+6dlcXRckj5zxSI8+Z4QSek0vY=;
 b=NytrLzEvZr5suz5KCF8Sr8zpgeUvW9nKWqe1oDnIcXMiempLk16DQdgW5Ox3FRHUWa
 6ZFxjbaDqBKZ8aCg2pU3floklNA7GfoSjXYCDjSKmLj5PTD/AfrTs8Bc7KtjvFhUncB9
 yeLXsWmlJRx02utc0MUbZRWqwIm1dZ707kXw2mt6QhzVR3DmW2mEBOTF9oumgYdsDT1V
 9OU61FYTK+LB0ijyeC2X5CUisf6y2p+/MvWw3EG6yEve6TKkqdTSSf/lPP8xBgZTk2Kl
 2hHd1Jz4OL6h5PpbkZKK5V+P/wL4S7u3xuMVtnl6QEIcjx6X1J5NfQasQrIko3wY+L5F
 lGeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=oq3rmsSk19eLVuEsf+6dlcXRckj5zxSI8+Z4QSek0vY=;
 b=WnLj0Gm/eX2DBqNv1dJFgcBT7+u13la3xwEiooBGlqrP9Y/qlOW/SbBlk5uvKVUIVT
 FU4FvZ34zeqwcAwXEWCHSzOaVh8nt1O73GfEsgKRg7PYRbfkuXPwM4OkilheEhZZUOOw
 yYAQOKEgyrbA6MpORlW7V8Fi7MhJrXFjQDEOk+j9mrc5rJSmsSE4jebssgAP0f/fHrqe
 XcVITCqYnDBvpR5r7EtBe+E6bkOOwopNfb1gT5vxoeJSwmx8Ox4M6En8Mm8YZv3K9whj
 fLCtWn3h9By9TKgBDPOto6kkF87ri17kQlWuS8G3jxBcerMC0cvTDO+hZNKsm0O8d42g
 fK7Q==
X-Gm-Message-State: AOAM532zfnaMj+JULz3O4ORfxxtJiSj1gXFnfMrLKlc4Ml1kGuUfkMF1
 ahbKXBaghGxbBICEFzciVLrY4ltgRTY=
X-Google-Smtp-Source: ABdhPJxMbaKF221BCEUMmGDIG9PgxnO3mN2NQLXNWT8unBeRfmIT/cOMKHxDkxsIB65AAdwI0qXgmg==
X-Received: by 2002:a9d:6e19:: with SMTP id e25mr2935901otr.219.1599166836076; 
 Thu, 03 Sep 2020 14:00:36 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id c26sm767254otr.50.2020.09.03.14.00.34
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 03 Sep 2020 14:00:35 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 42/77] qga: fix assert regression on guest-shutdown
Date: Thu,  3 Sep 2020 15:59:00 -0500
Message-Id: <20200903205935.27832-43-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
References: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=flukshun@gmail.com; helo=mail-ot1-x341.google.com
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Since commit 781f2b3d1e ("qga: process_event() simplification"),
send_response() is called unconditionally, but will assert when "rsp" is
NULL. This may happen with QCO_NO_SUCCESS_RESP commands, such as
"guest-shutdown".

Fixes: 781f2b3d1e5ef389b44016a897fd55e7a780bf35
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>
Reported-by: Christian Ehrhardt <christian.ehrhardt@canonical.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Christian Ehrhardt <christian.ehrhardt@canonical.com>
Tested-by: Christian Ehrhardt <christian.ehrhardt@canonical.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
(cherry picked from commit 844bd70b5652f30bbace89499f513e3fbbb6457a)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qga/main.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/qga/main.c b/qga/main.c
index f0e454f28d..3febf3b0fd 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -531,7 +531,11 @@ static int send_response(GAState *s, const QDict *rsp)
     QString *payload_qstr, *response_qstr;
     GIOStatus status;
 
-    g_assert(rsp && s->channel);
+    g_assert(s->channel);
+
+    if (!rsp) {
+        return 0;
+    }
 
     payload_qstr = qobject_to_json(QOBJECT(rsp));
     if (!payload_qstr) {
-- 
2.17.1


