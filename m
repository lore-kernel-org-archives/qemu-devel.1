Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DDF8C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:31:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08E43206D3
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:31:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jyhMQ+kX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08E43206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igoay-0002W6-Ur
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 06:31:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51222)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1igoFz-00087T-3P
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1igoFy-0000Dz-02
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:42 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:47051)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1igoFx-0000Ax-OA
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:41 -0500
Received: by mail-wr1-x433.google.com with SMTP id z7so6675108wrl.13
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 03:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=kiznhuvKz4jfIKm/7fpiveKPXoY6Nj6u7zhRBMk1ww0=;
 b=jyhMQ+kXhJwCl7jlcf4vSMmzMKHXjoZe9RoDRxsO6VMmvBwcEQuG8QMzoLNsnJBsDB
 9QSoNvUeba/BCASgJBkRhfA0HacXKLKDsGMe3T3UcFpReDktkSpYedl4U7s9oaN5z/Oc
 10NBytX9CMfE2Pso225fcCfFN4VPg4ZHYaT4pqK/CWM2NGbwEuw94gpkkS6ynFVIoeI5
 OVM25fRGqbQlfTJkK4qQT2GJkDqV+h3FhstVfVaUtbGedZZ2Jo/Lo9qYU93F448eIFNo
 zeQIPdR9WpSFSOfuew/Mz0goCba1JmYkWEEpAY1xroyPF/YkBID+wpiw4vHRbr0rd062
 B7qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kiznhuvKz4jfIKm/7fpiveKPXoY6Nj6u7zhRBMk1ww0=;
 b=rp3YLZaTPu7K3Ml8qR0lsbRcV71A6RtIEFdtPBL9J49fSU3xr4ZfTX4Balw+bM3nua
 c3VBJt45i7/pxVA6igDQy5DCDH3H2meEZrmk3b4VshGzD4ebxCW5AN5dzVhjE5NyFZqO
 5opy3JuaZqHvIWyjtsSlBciCpNdnmUUBx6a6JQmEx6vjrENLt6sInf1Gn020xP78gcnD
 X/D/qsHHhqrnE8zSRH1jo+fRZNU2HWLE/+mGJy3ChCjx5x8V6RO1QWLELxHTJP/siDaV
 6JqixJa8EgoivUWC+84CBAs3TbqR1z06Y9rofSirLo7AJ5dGzO5Buh4xIAY/ERwbIDLG
 ruIA==
X-Gm-Message-State: APjAAAWUOvMp8qRZr422CDSBzMC110L3TBQU9mSuSzkYaQkBO8SsEiy4
 Qy8V2hvZxiXmVPsDKrwWAEWaD7I8Q5PyXw==
X-Google-Smtp-Source: APXvYqx1OHF25jKF1+Er4gqNvbANpleyeCSzmpPixaCfwak/NqMYp1HCVUYmeMhV3c5Shv3agWvomQ==
X-Received: by 2002:adf:de84:: with SMTP id w4mr28221776wrl.97.1576494577133; 
 Mon, 16 Dec 2019 03:09:37 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id x10sm20976131wrp.58.2019.12.16.03.09.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2019 03:09:36 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 28/34] migration: ram: Switch to ram block writeback
Date: Mon, 16 Dec 2019 11:08:58 +0000
Message-Id: <20191216110904.30815-29-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216110904.30815-1-peter.maydell@linaro.org>
References: <20191216110904.30815-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::433
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Beata Michalska <beata.michalska@linaro.org>

Switch to ram block writeback for pmem migration.

Signed-off-by: Beata Michalska <beata.michalska@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-id: 20191121000843.24844-4-beata.michalska@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 migration/ram.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 5078f94490d..38070f1bb23 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -33,7 +33,6 @@
 #include "qemu/bitops.h"
 #include "qemu/bitmap.h"
 #include "qemu/main-loop.h"
-#include "qemu/pmem.h"
 #include "xbzrle.h"
 #include "ram.h"
 #include "migration.h"
@@ -3981,9 +3980,7 @@ static int ram_load_cleanup(void *opaque)
     RAMBlock *rb;
 
     RAMBLOCK_FOREACH_NOT_IGNORED(rb) {
-        if (ramblock_is_pmem(rb)) {
-            pmem_persist(rb->host, rb->used_length);
-        }
+        qemu_ram_block_writeback(rb);
     }
 
     xbzrle_load_cleanup();
-- 
2.20.1


