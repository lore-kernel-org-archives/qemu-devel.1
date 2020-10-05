Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF06C46466
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 15:28:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DF5520874
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 15:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GsuFAH5F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DF5520874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPSPZ-0003fs-Uv
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 11:28:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50426)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPSOk-00037j-SJ
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 11:27:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31175)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPSOi-0005Jk-Av
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 11:27:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601911650;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ThhMUjjLg+/D2yAGmDv83K8pC0Dc18gDxERoM4qHJ1g=;
 b=GsuFAH5FrufAMnaW/qtY062BlDKPLHuE1CwCtT88V/c866gbOsx/h4yFnRSgSkR0Z+xrjg
 YTGex+a0sgE6HiMp2ML1vnr3QY+Sfgvb1l5fkTMhRoGL3dK68zbPSLxaelK99uXvPj98eJ
 8ASC8STNBsD+GCOA2VjgPrvj4ZdUm6E=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-mBhHYuRNMzmVOiYCUS95lQ-1; Mon, 05 Oct 2020 11:27:29 -0400
X-MC-Unique: mBhHYuRNMzmVOiYCUS95lQ-1
Received: by mail-wm1-f69.google.com with SMTP id d76so1360854wmd.8
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 08:27:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ThhMUjjLg+/D2yAGmDv83K8pC0Dc18gDxERoM4qHJ1g=;
 b=UsHRbyLe4hXVL1+M/751JsbMNVs6bavSSMUhvOElHqTcxb0byzZDVdzmhsAUVo66hR
 eXBjUyYS262+ZgFbUA558qSaRaBHFCdLL/CEYItzjDZwpcFnRL4NrgQA5crXMswdGUjR
 fpYgJyAO7mfPisV4qbB7lvi4cIQMLXkUf+NqlKV3ItIZy+m2itlATjYO0Ng5KRPNOytY
 uLtFkCylTpxy7vIno5isL9329aACOVeasZvI90B9akWl3CGMKMdTgksr8l9dlHly9E4e
 +tGFc8vaeDeKi6iyR2lDLNbhFf8FiQnHxTOHaaDzDT4OVLXE7O0iYlgNYSaCmq9NxfUm
 IH1A==
X-Gm-Message-State: AOAM533mpcqc2jPhqrg90Bj6XqmuKwy9OCL+lcZfbnCA6jXcxxEPGWQ2
 qF+ukVJMimxr0fNoCb57UlZLNQwj4RvJgOkgaNUI3QTAi/8cnLGua5kqpkp/ld+WYDGWd4w6sW+
 2q7yaAEicNaHZKmQ=
X-Received: by 2002:a5d:630a:: with SMTP id i10mr17956446wru.137.1601911647827; 
 Mon, 05 Oct 2020 08:27:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzoEDbNmaVqtq4LuuFziMdkP4O4nZd4TYjoG7erWESeywLb1BGqqQcWLru2VufEjnloXdmeNA==
X-Received: by 2002:a5d:630a:: with SMTP id i10mr17956419wru.137.1601911647578; 
 Mon, 05 Oct 2020 08:27:27 -0700 (PDT)
Received: from x1w.redhat.com (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id c4sm84612wme.27.2020.10.05.08.27.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2020 08:27:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] softmmu/memory: Log invalid memory accesses
Date: Mon,  5 Oct 2020 17:27:25 +0200
Message-Id: <20201005152725.2143444-1-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 02:11:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Log invalid memory accesses with as GUEST_ERROR.

This is particularly useful since commit 5d971f9e67 which reverted
("memory: accept mismatching sizes in memory_region_access_valid").

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 softmmu/memory.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/softmmu/memory.c b/softmmu/memory.c
index fa280a19f7..403ff3abc9 100644
--- a/softmmu/memory.c
+++ b/softmmu/memory.c
@@ -14,6 +14,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/log.h"
 #include "qapi/error.h"
 #include "cpu.h"
 #include "exec/memory.h"
@@ -1353,10 +1354,18 @@ bool memory_region_access_valid(MemoryRegion *mr,
 {
     if (mr->ops->valid.accepts
         && !mr->ops->valid.accepts(mr->opaque, addr, size, is_write, attrs)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "Invalid access at addr "
+                                       "0x%" HWADDR_PRIX ", size %u, "
+                                       "region '%s', reason: rejected\n",
+                      addr, size, memory_region_name(mr));
         return false;
     }
 
     if (!mr->ops->valid.unaligned && (addr & (size - 1))) {
+        qemu_log_mask(LOG_GUEST_ERROR, "Invalid access at addr "
+                                       "0x%" HWADDR_PRIX ", size %u, "
+                                       "region '%s', reason: unaligned\n",
+                      addr, size, memory_region_name(mr));
         return false;
     }
 
@@ -1367,6 +1376,13 @@ bool memory_region_access_valid(MemoryRegion *mr,
 
     if (size > mr->ops->valid.max_access_size
         || size < mr->ops->valid.min_access_size) {
+        qemu_log_mask(LOG_GUEST_ERROR, "Invalid access at addr "
+                                       "0x%" HWADDR_PRIX ", size %u, "
+                                       "region '%s', reason: invalid size "
+                                       "(min:%u max:%u)\n",
+                      addr, size, memory_region_name(mr),
+                      mr->ops->valid.min_access_size,
+                      mr->ops->valid.max_access_size);
         return false;
     }
     return true;
-- 
2.26.2


