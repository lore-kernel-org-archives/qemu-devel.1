Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4837C76188
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 13:38:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEFDC2173B
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 13:38:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YtfmgL6E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEFDC2173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoT5i-0004m0-Mx
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 09:38:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37983)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mehta.aaru20@gmail.com>) id 1hoT44-0005WX-CB
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 09:36:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mehta.aaru20@gmail.com>) id 1hoT43-0007yf-AG
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 09:36:48 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:43668)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mehta.aaru20@gmail.com>)
 id 1hoT43-0007xZ-50; Fri, 19 Jul 2019 09:36:47 -0400
Received: by mail-pg1-x544.google.com with SMTP id f25so14478922pgv.10;
 Fri, 19 Jul 2019 06:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bjo2OWZfzDM9JJnmfjwrjNDcJFN5qjeOYd8x/VH9dn4=;
 b=YtfmgL6EVs4cIdUfApLpU9UVJmn/kViasswwuBr5/mCCBMVCxBgDesYII6g+CelUI1
 E105mcJc/wnPAnRscwLPzdyf4S0XLkoG5w2AKTZnoF24cXzPlOk+c2deFhnf0Vh5p/1l
 VqZU62PRrd/uKwPyrFZcICPXPU9mOYAm93ng1kUJo41wC0kaWPT1B1Gm/7rU9cNrzwWG
 5u93qIpiIwRo7ht+1iCz9eZJUHMNFvxVV1LqmAUh/v3y99OV96zEq/L2Fx9V0+F9mkSn
 6T0aoMijRwV6g67XEVcXVpvJv/iNMT+TnVV3gVzXKQ4bDNOBfffQXlK3hUhcqj13VNK6
 rZ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bjo2OWZfzDM9JJnmfjwrjNDcJFN5qjeOYd8x/VH9dn4=;
 b=SJWSZ/v9mWwzW1CQ9I9x5AQt/VU/NB5ywWYB4+SE03L76K5+W9cnJajoSGL3roxGxI
 UrW83whDKNsib3lKs4lApQgLLAPFSYDePdDd7vR3kUtiM6rbX+4V250OtsvHv9HkYzbm
 32Sh0ZlwCu/QAi8/B/T7Dws6wUJ9S9vsJfEMNa4tYBQJG6PI4qtjk4e3P231Mp7QOs2w
 fJMKKq5puYyTTr+LPwBy8PcEIsRhWXNpdT0OVz7jnOxVoC/6KIYlIYWXOkM7xXiGJbLm
 5htI7lTm4fYNjKC8Ls4zCKfWL+IYNsJqyHX1reePn+eTjhRMqNo/1p91bxIKCAAi7fUM
 LHFw==
X-Gm-Message-State: APjAAAVEHbNAUDpxNBrtK7GeJr4zud9DqWe8Zy8GMiukhSaUIaTpB6QV
 fT+gzPdOUB9n1gyOOHxkdhRgcJSe6XY=
X-Google-Smtp-Source: APXvYqyUfa9pMF6XOkSiy63obYqEWrnFYKRKn+5h7bjYRH6kBfbCRRXqY0teZvL/ZhIH9U+JLDc/8A==
X-Received: by 2002:a17:90a:a407:: with SMTP id
 y7mr58002370pjp.97.1563543404186; 
 Fri, 19 Jul 2019 06:36:44 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:433:31a4:f2fb:dab8:3a89:c056])
 by smtp.gmail.com with ESMTPSA id 11sm31895369pfw.33.2019.07.19.06.36.37
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 19 Jul 2019 06:36:43 -0700 (PDT)
From: Aarushi Mehta <mehta.aaru20@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri, 19 Jul 2019 19:05:23 +0530
Message-Id: <20190719133530.28688-8-mehta.aaru20@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190719133530.28688-1-mehta.aaru20@gmail.com>
References: <20190719133530.28688-1-mehta.aaru20@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: [Qemu-devel] [PATCH v6 07/14] blockdev: accept io_uring as option
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Sergio Lopez <slp@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 saket.sinha89@gmail.com, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefan@redhat.com>, Julia Suvorova <jusual@mail.ru>,
 Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
---
 blockdev.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index 4d141e9a1f..695b3a803b 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -383,13 +383,9 @@ static void extract_common_blockdev_options(QemuOpts *opts, int *bdrv_flags,
         }
 
         if ((aio = qemu_opt_get(opts, "aio")) != NULL) {
-            if (!strcmp(aio, "native")) {
-                *bdrv_flags |= BDRV_O_NATIVE_AIO;
-            } else if (!strcmp(aio, "threads")) {
-                /* this is the default */
-            } else {
-               error_setg(errp, "invalid aio option");
-               return;
+            if (bdrv_parse_aio(aio, bdrv_flags) < 0) {
+                error_setg(errp, "invalid aio option");
+                return;
             }
         }
     }
@@ -4574,7 +4570,7 @@ QemuOptsList qemu_common_drive_opts = {
         },{
             .name = "aio",
             .type = QEMU_OPT_STRING,
-            .help = "host AIO implementation (threads, native)",
+            .help = "host AIO implementation (threads, native, io_uring)",
         },{
             .name = BDRV_OPT_CACHE_WB,
             .type = QEMU_OPT_BOOL,
-- 
2.21.0


