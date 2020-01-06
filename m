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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 971D7C33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 18:54:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F9202070E
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 18:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fRNkR8Pq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F9202070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioXW2-0005O1-SU
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 13:54:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46163)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielhb413@gmail.com>) id 1ioX4p-0003BE-Fc
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:26:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1ioX4o-0004tw-Hy
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:26:07 -0500
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:37690)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1ioX4o-0004tX-EI; Mon, 06 Jan 2020 13:26:06 -0500
Received: by mail-qt1-x844.google.com with SMTP id w47so43209353qtk.4;
 Mon, 06 Jan 2020 10:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9CWmGBj5aHcDceZZnak42d3HhmzkoQ6hZFURnh41AJQ=;
 b=fRNkR8Pq92PLD4Rj2lj2DlkW57FOCci79QyrBY/E4ItMBC7xeq+R4kunKB7FeSjPBu
 zE7qF4hW36T00wvtYM1tPvWSSPc3sGscMOX2LcqviMfYfAb956a3JsAgBzi+Z03E7w+d
 o2Jmt6n7jy0juIFX8uBKPJsDlAmbis15KOmxjz457UtyLCyjMojluXkmvYoNTesQtRas
 I7Wvx2kAjPaAr8vps60mOcT+IOz3SpGyaxZMaN7Zqfu4ELJ6S5cCMZOdTJ1tAU9KUowr
 hUuGn9M6ibX620kKFO66ixGhvZpTc5ESQMjCQ75CZdfxcqZZIMJx74PaVpZRu1UFkFCQ
 EcQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9CWmGBj5aHcDceZZnak42d3HhmzkoQ6hZFURnh41AJQ=;
 b=EzlkzNHDcQmVHgLKfsP1dPDKfz0gGvIB88Uj+Y16rR5Z55QNKbrOcIlPoWVWwy3y7+
 H5vTd9aooqOZ2mDkceDfJS8GglNNE/53DZqQvLye+ZodkUO9PiZzCXTx8esGVB4D6Wvq
 gLwbgDReBPFQmdYWFnGBfS6zvw9McVCxD3Jt3DjdbpprbdhUdwsqTVCPpxlJg3cvEpC9
 CJV4kTYZBkWorbmfeL6Sf0+7eqjkVeD5pm78zWa35T+MefdBpqOo82tbceTM+qfnrOBk
 gSjj7k4a69opRufaZVM64HviakgdEDb6FIT2ifq6Xka19lQyKtdR/cGzPFIV0dqK0oDQ
 csIw==
X-Gm-Message-State: APjAAAW3xAIX5RfBDC2GIl1ivBnEB7K++t/5J6I/aSbaEqAib6RK8t78
 P6J3mCtMAqx8uORp2S0QOSieOXT4
X-Google-Smtp-Source: APXvYqzTlr5xjO3oGTrwz33FSc5NOPPkNEHipnTdpGDDmkxvyLdJGLhxx5lH/htTz8fDtvcjIVnPbg==
X-Received: by 2002:ac8:5457:: with SMTP id d23mr72710032qtq.93.1578335165941; 
 Mon, 06 Jan 2020 10:26:05 -0800 (PST)
Received: from rekt.ibmuc.com ([2804:431:c7c6:655b:9e1c:e865:3705:e1df])
 by smtp.gmail.com with ESMTPSA id b81sm21026522qkc.135.2020.01.06.10.26.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2020 10:26:05 -0800 (PST)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 41/59] intc/s390_flic_kvm.c: remove unneeded label in
 kvm_flic_load()
Date: Mon,  6 Jan 2020 15:24:07 -0300
Message-Id: <20200106182425.20312-42-danielhb413@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200106182425.20312-1-danielhb413@gmail.com>
References: <20200106182425.20312-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::844
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
Cc: qemu-trivial@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

'out' label can be replaced by 'return' with the apropriate
value that is set by 'r' right before the jump.

Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/intc/s390_flic_kvm.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/hw/intc/s390_flic_kvm.c b/hw/intc/s390_flic_kvm.c
index dddd33ea61..2e1e70c61d 100644
--- a/hw/intc/s390_flic_kvm.c
+++ b/hw/intc/s390_flic_kvm.c
@@ -439,17 +439,14 @@ static int kvm_flic_load(QEMUFile *f, void *opaque, size_t size,
     count = qemu_get_be64(f);
     len = count * sizeof(struct kvm_s390_irq);
     if (count == FLIC_FAILED) {
-        r = -EINVAL;
-        goto out;
+        return -EINVAL;
     }
     if (count == 0) {
-        r = 0;
-        goto out;
+        return 0;
     }
     buf = g_try_malloc0(len);
     if (!buf) {
-        r = -ENOMEM;
-        goto out;
+        return -ENOMEM;
     }
 
     if (qemu_get_buffer(f, (uint8_t *) buf, len) != len) {
@@ -460,7 +457,6 @@ static int kvm_flic_load(QEMUFile *f, void *opaque, size_t size,
 
 out_free:
     g_free(buf);
-out:
     return r;
 }
 
-- 
2.24.1


