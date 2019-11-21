Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD3D9C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 00:13:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A634B208A1
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 00:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yE5W+q13"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A634B208A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXa5j-0004pI-Tv
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 19:12:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56935)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <beata.michalska@linaro.org>) id 1iXa2S-00007G-Pu
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 19:09:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <beata.michalska@linaro.org>) id 1iXa2R-0005m9-QQ
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 19:09:36 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:46806)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <beata.michalska@linaro.org>)
 id 1iXa2R-0005ly-MI
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 19:09:35 -0500
Received: by mail-oi1-x242.google.com with SMTP id n14so1495179oie.13
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 16:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=HsdErY/VOvmYyLB8+2L3+K8sDccz0NDXgt0JMSNXxNM=;
 b=yE5W+q13zjR9HSIv2qTmit1G376oCNK63mE87vcAp5m3BCmNcERZ2pI/DleA241pJG
 KQQ2qIzR1Alk1Fx9KC7+oD3k/jWJCLdXdpbGU0T6NjYou9MjPyj+83LE9v5igjXdUwUL
 U+kknaJFZB98dHa/g9StcN1KFj2LRDm6AR3pQpgJhSbQNJbAC21ImS4ky+u3ScWZtAvL
 03sMIARyePANvzh1s81EWaKdUIUR/99qzFxP/ef1QMKgpCEHsLI/s9TREBtpGjR2QB5n
 Tt1PXsKfn2aACAqFmIPaIVFwt1lUwUS4WHWSbrdNRkiHUmHtS5D8OJMeKGpYuEAuLFPR
 yEQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HsdErY/VOvmYyLB8+2L3+K8sDccz0NDXgt0JMSNXxNM=;
 b=SlfqZSJa0jo4c3hJYkNmdgAnqJCpEjdWPkEDb90SVwNsa3uZme5es7g10nHlGz3x4n
 G7BlGPXYeusL+/UAP2F2hV+IkSIQv7BLAcMvyC9MH47MA9CobHgUpr5nyp8NyZolKowW
 ywnCx6nRmlTHJdfaMwGhuy5P/lBQJdtZ2CE1Nu7I+Hu4UPUWEauvAUuZL+FE5X30jgHJ
 I8dzL32H3s7MwVx6bZi4ZNh+1uR9M37ly0mLnRy5PsCCW27OgHYEv3St1Iril8QK6xIv
 XmhetlcvrNtA18pTprgqInRY3UyuBe0nZMHKQ11b/X4UGaElWzJ313vYQTjeUlQ/ghMj
 mQjw==
X-Gm-Message-State: APjAAAU1zK0LA18A9WGRnjOET+lc6Z9MiUG24hsvDsNJWmv7zMY1UkBv
 lXl/kU2GCOHlp0+QcnsVjrAFPqgC5CCtfg==
X-Google-Smtp-Source: APXvYqxcT5JqL5Y3heq9E/QnQ6K0pwMAYWD6DKsbRMakjfptkS7mNKtxkm7p6bdt3e7R4TH3PH3wVw==
X-Received: by 2002:aca:ddc2:: with SMTP id u185mr5222506oig.174.1574294974817; 
 Wed, 20 Nov 2019 16:09:34 -0800 (PST)
Received: from moi-limbo-9350.arm.com
 (host86-181-127-240.range86-181.btcentralplus.com. [86.181.127.240])
 by smtp.gmail.com with ESMTPSA id z17sm351439otk.40.2019.11.20.16.09.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Nov 2019 16:09:34 -0800 (PST)
From: Beata Michalska <beata.michalska@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 3/4] migration: ram: Switch to ram block writeback
Date: Thu, 21 Nov 2019 00:08:42 +0000
Message-Id: <20191121000843.24844-4-beata.michalska@linaro.org>
In-Reply-To: <20191121000843.24844-1-beata.michalska@linaro.org>
References: <20191121000843.24844-1-beata.michalska@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: peter.maydell@linaro.org, quintela@redhat.com, richard.henderson@linaro.org,
 dgilbert@redhat.com, shameerali.kolothum.thodi@huawei.com,
 eric.auger@redhat.com, qemu-arm@nongnu.org, pbonzini@redhat.com,
 alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Switch to ram block writeback for pmem migration.

Signed-off-by: Beata Michalska <beata.michalska@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/ram.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 5078f94..38070f1 100644
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
2.7.4


