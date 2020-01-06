Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 673C2C33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 18:42:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31275208C4
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 18:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P3e1aHqs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31275208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioXKJ-0007II-NV
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 13:42:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45867)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielhb413@gmail.com>) id 1ioX4W-0002cY-57
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:25:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1ioX4V-0004Yg-0M
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:25:48 -0500
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843]:34795)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1ioX4U-0004YR-Sd; Mon, 06 Jan 2020 13:25:46 -0500
Received: by mail-qt1-x843.google.com with SMTP id 5so43197290qtz.1;
 Mon, 06 Jan 2020 10:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9bVPKH/u51qFSWaRLOxFrn4Yt2i0R3QrPeQ70R4x82s=;
 b=P3e1aHqsVL6FmSFsstxXwCg5dTAjOFJApqJ4WypAQSeI8eX6HWV3QbH9zIRvsyFWNG
 GR7O39PEKugv+H6YvLY03aZDJ9/eyekRvhNqrHYR5PkkA25EsxyeuUtupT6pEcs/Jai3
 Khoy44++nTdynHbbz2bI5SqZJFYxjg6DQ02jlCn2ZkTovsf2YGDVCGQsPRAYlMC1vQdI
 f8y/KmsDxMla0dXLZnHecVl3x8et3z8P5EmcwKKaOsaxe8cLvA00UB+A4cFax4/LmvQ8
 Je8I4VSaVGNf/zPZDEKWbwbgO2EU+p8MZN86+iNA1VZjSzulahSoZXz8yJndOP5BkAnC
 u7Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9bVPKH/u51qFSWaRLOxFrn4Yt2i0R3QrPeQ70R4x82s=;
 b=S2ArbKcCyOP2R5S7+13FccnxBk0IAbI9UdXqMNCDC/BQgp+tVX6Ibmv0wztXp+XTNM
 hPFm8plRs+GoG7ikkuhS4m9g3o4tgmB12xtT6IMWs6n+K8K7j14MC/D+BmtwcTPrvA+5
 oZ+l1QRN+9tDwLI7TkE3okXgaKgmJ+dQc3Nn8/N2mTX5L6BnJkl54rVpzfMuihB5Mfgp
 FkGWMgt7MwxgK22S4QWkqZgAovtLh0unRzblzFx3dOnjzTfWd8m9CgXZrt9dsJyaTMPb
 qEUicnHsiOpVxpT7GOFByp17dl60sDd0rHLUKutS4ZxhC7KkuEiEorY/7K9MnDbORCxK
 eubg==
X-Gm-Message-State: APjAAAV7QQpe8tk3lh1qDu9UDGmvjkSWXivjhLAqxIvqzjueOi6QMQLa
 4SfmOzJuo2J6R5K2rBHGN+eA50ca
X-Google-Smtp-Source: APXvYqzUt0pJJsam0yMuf4GLbZQlWznnPX9YhdgHEcot1QfP8rnOSPzphUhEpM7hBOP2w67OZSTm9g==
X-Received: by 2002:ac8:5215:: with SMTP id r21mr75440322qtn.77.1578335146381; 
 Mon, 06 Jan 2020 10:25:46 -0800 (PST)
Received: from rekt.ibmuc.com ([2804:431:c7c6:655b:9e1c:e865:3705:e1df])
 by smtp.gmail.com with ESMTPSA id b81sm21026522qkc.135.2020.01.06.10.25.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2020 10:25:45 -0800 (PST)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 30/59] util/module.c: remove unneeded label in
 module_load_file()
Date: Mon,  6 Jan 2020 15:23:56 -0300
Message-Id: <20200106182425.20312-31-danielhb413@gmail.com>
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

'out' can be replaced by the apropriate return values set
in 'ret' for each case.

CC: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 util/module.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/util/module.c b/util/module.c
index e9fe3e5422..9b5453f878 100644
--- a/util/module.c
+++ b/util/module.c
@@ -111,12 +111,10 @@ static int module_load_file(const char *fname)
 
     if (len <= suf_len || strcmp(&fname[len - suf_len], dsosuf)) {
         /* wrong suffix */
-        ret = -EINVAL;
-        goto out;
+        return -EINVAL;
     }
     if (access(fname, F_OK)) {
-        ret = -ENOENT;
-        goto out;
+        return -ENOENT;
     }
 
     assert(QTAILQ_EMPTY(&dso_init_list));
@@ -125,8 +123,7 @@ static int module_load_file(const char *fname)
     if (!g_module) {
         fprintf(stderr, "Failed to open module: %s\n",
                 g_module_error());
-        ret = -EINVAL;
-        goto out;
+        return -EINVAL;
     }
     if (!g_module_symbol(g_module, DSO_STAMP_FUN_STR, (gpointer *)&sym)) {
         fprintf(stderr, "Failed to initialize module: %s\n",
@@ -151,7 +148,7 @@ static int module_load_file(const char *fname)
         QTAILQ_REMOVE(&dso_init_list, e, node);
         g_free(e);
     }
-out:
+
     return ret;
 }
 #endif
-- 
2.24.1


