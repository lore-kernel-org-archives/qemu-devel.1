Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A625BC433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 22:49:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 662DC20767
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 22:49:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PcYyFO87"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 662DC20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDbZO-0003XQ-HD
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 18:49:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34884)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDbU2-0001np-Nd
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 18:44:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55882
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDbU1-0008K9-2Y
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 18:44:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599086640;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ggDPih9j8RPySFAWbuDTM/kAcnO941hQQwT7LmzL8sw=;
 b=PcYyFO87tpOFLPNct01VcxYXx3IUMiccV3miv78JTX7ZcfK8591faSNblj8qrXpehQXlim
 iqpHJIFjLFVu8Zc3CbwIxEVMCiweT7BPk2wgcANkjvdntTJCyTHYQ664/E/xYpAGgeeAwp
 QX8blVFABgLwZn0WINOCc2h6asopN2U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-484-C7jYWxPBPrKSAe7945QOGw-1; Wed, 02 Sep 2020 18:43:58 -0400
X-MC-Unique: C7jYWxPBPrKSAe7945QOGw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7F52710059A7;
 Wed,  2 Sep 2020 22:43:57 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 19DB45C1C4;
 Wed,  2 Sep 2020 22:43:57 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 11/63] edu: Rename TYPE_PCI_EDU_DEVICE to TYPE_EDU
Date: Wed,  2 Sep 2020 18:42:19 -0400
Message-Id: <20200902224311.1321159-12-ehabkost@redhat.com>
In-Reply-To: <20200902224311.1321159-1-ehabkost@redhat.com>
References: <20200902224311.1321159-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 16:20:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Jiri Slaby <jslaby@suse.cz>, berrange@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This will make the type name constant consistent with the name of
the type checking macro.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Cc: Jiri Slaby <jslaby@suse.cz>
Cc: qemu-devel@nongnu.org
---
 hw/misc/edu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/misc/edu.c b/hw/misc/edu.c
index 0ff9d1ac78..b69728838d 100644
--- a/hw/misc/edu.c
+++ b/hw/misc/edu.c
@@ -33,10 +33,10 @@
 #include "qemu/module.h"
 #include "qapi/visitor.h"
 
-#define TYPE_PCI_EDU_DEVICE "edu"
+#define TYPE_EDU "edu"
 typedef struct EduState EduState;
 DECLARE_INSTANCE_CHECKER(EduState, EDU,
-                         TYPE_PCI_EDU_DEVICE)
+                         TYPE_EDU)
 
 #define FACT_IRQ        0x00000001
 #define DMA_IRQ         0x00000100
@@ -429,7 +429,7 @@ static void pci_edu_register_types(void)
         { },
     };
     static const TypeInfo edu_info = {
-        .name          = TYPE_PCI_EDU_DEVICE,
+        .name          = TYPE_EDU,
         .parent        = TYPE_PCI_DEVICE,
         .instance_size = sizeof(EduState),
         .instance_init = edu_instance_init,
-- 
2.26.2


