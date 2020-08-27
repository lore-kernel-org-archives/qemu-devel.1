Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 376EAC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 19:34:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 038BC20714
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 19:34:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YKaT4yO3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 038BC20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBNew-0004cn-76
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 15:34:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34354)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kBNTo-0007cD-SD
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 15:22:36 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21863
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kBNTm-0000TJ-0b
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 15:22:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598556153;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QDFvAThdxBiZ+OodaaiyC2nMo9zw7CtZ3DTqqwycb/U=;
 b=YKaT4yO38P6Mu4bIm2cIhdV4bNmIJoH+nLAPZKvduYiaAJyB7X871YmIQJ3OvJ/myZdU5r
 Ug4vOIsaP6ZqTgLxJeDJ7o+oA+XCxFIuvde2+MZJTdzgMbgGGg+h4+rDpwrHtr0VfnnELU
 EMBugyNv8XXNR/aLKztUD1xlRieo+yk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-504-vOMGLmBSPY2TrPi3GHDqXg-1; Thu, 27 Aug 2020 15:22:31 -0400
X-MC-Unique: vOMGLmBSPY2TrPi3GHDqXg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E5C491074668;
 Thu, 27 Aug 2020 19:22:29 +0000 (UTC)
Received: from localhost (unknown [10.10.67.254])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ABBC678396;
 Thu, 27 Aug 2020 19:22:29 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 30/53] i8257: Move QOM macro to header
Date: Thu, 27 Aug 2020 15:20:59 -0400
Message-Id: <20200827192122.658035-31-ehabkost@redhat.com>
In-Reply-To: <20200827192122.658035-1-ehabkost@redhat.com>
References: <20200827192122.658035-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 07:16:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move the I8257 macro to i8257.h, close to the TYPE_I8257 define.

This will make future conversion to OBJECT_DECLARE* easier.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Tested-By: Roman Bolshakov <r.bolshakov@yadro.com>
Message-Id: <20200825192110.3528606-32-ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/dma/i8257.h | 2 ++
 hw/dma/i8257.c         | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/hw/dma/i8257.h b/include/hw/dma/i8257.h
index 03e2c166be..ee06371699 100644
--- a/include/hw/dma/i8257.h
+++ b/include/hw/dma/i8257.h
@@ -5,6 +5,8 @@
 #include "exec/ioport.h"
 
 #define TYPE_I8257 "i8257"
+#define I8257(obj) \
+    OBJECT_CHECK(I8257State, (obj), TYPE_I8257)
 
 typedef struct I8257Regs {
     int now[2];
diff --git a/hw/dma/i8257.c b/hw/dma/i8257.c
index db808029b0..de5f696919 100644
--- a/hw/dma/i8257.c
+++ b/hw/dma/i8257.c
@@ -33,8 +33,6 @@
 #include "qemu/log.h"
 #include "trace.h"
 
-#define I8257(obj) \
-    OBJECT_CHECK(I8257State, (obj), TYPE_I8257)
 
 /* #define DEBUG_DMA */
 
-- 
2.26.2


