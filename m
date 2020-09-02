Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F379C433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 22:47:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E67920767
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 22:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e3FXfDwJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E67920767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDbXX-00008b-AH
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 18:47:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34758)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDbTp-0001Ic-A1
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 18:43:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60030
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDbTn-0008I2-K7
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 18:43:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599086626;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aTYWuyvh9AHBbcAYeWfzKAnFXRJ3BS3A1s16bJuf0+c=;
 b=e3FXfDwJFcvokLtQGoJLY2eKM9XHwcokKfKSby6/Gz/kE4mQwsBkEdW7Mr/5r98LZSqYgF
 5Vk3UXNQfGAf60K3jNOsSTk6XU1Im7fUwYxStPogN61EOLXwT/KgSdc8/n3sdequTK0tXb
 8Hi82nLjVJGw1xujU+Qj+++RFiR02co=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-H5bqcHtLOTKbZgkatGBtZg-1; Wed, 02 Sep 2020 18:43:45 -0400
X-MC-Unique: H5bqcHtLOTKbZgkatGBtZg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3FBA58030C7;
 Wed,  2 Sep 2020 22:43:44 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0FCFD5C1C4;
 Wed,  2 Sep 2020 22:43:43 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 07/63] rdma: Rename PVRDMA_HW_NAME to TYPE_PVRDMA_DEV
Date: Wed,  2 Sep 2020 18:42:15 -0400
Message-Id: <20200902224311.1321159-8-ehabkost@redhat.com>
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
Cc: berrange@redhat.com, Yuval Shaia <yuval.shaia.ml@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This will make the type name constant consistent with the name of
the type checking macro.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Cc: Yuval Shaia <yuval.shaia.ml@gmail.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: qemu-devel@nongnu.org
---
 hw/rdma/vmw/pvrdma.h      | 4 ++--
 hw/rdma/vmw/pvrdma_main.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/rdma/vmw/pvrdma.h b/hw/rdma/vmw/pvrdma.h
index 1d36a76f1e..e7e610b223 100644
--- a/hw/rdma/vmw/pvrdma.h
+++ b/hw/rdma/vmw/pvrdma.h
@@ -50,7 +50,7 @@
 #define INTR_VEC_CMD_COMPLETION_Q    2
 
 /* HW attributes */
-#define PVRDMA_HW_NAME       "pvrdma"
+#define TYPE_PVRDMA_DEV       "pvrdma"
 #define PVRDMA_HW_VERSION    17
 #define PVRDMA_FW_VERSION    14
 
@@ -102,7 +102,7 @@ struct PVRDMADev {
 };
 typedef struct PVRDMADev PVRDMADev;
 DECLARE_INSTANCE_CHECKER(PVRDMADev, PVRDMA_DEV,
-                         PVRDMA_HW_NAME)
+                         TYPE_PVRDMA_DEV)
 
 static inline int get_reg_val(PVRDMADev *dev, hwaddr addr, uint32_t *val)
 {
diff --git a/hw/rdma/vmw/pvrdma_main.c b/hw/rdma/vmw/pvrdma_main.c
index 77b1235a3f..a08f720bfd 100644
--- a/hw/rdma/vmw/pvrdma_main.c
+++ b/hw/rdma/vmw/pvrdma_main.c
@@ -697,7 +697,7 @@ static void pvrdma_class_init(ObjectClass *klass, void *data)
 }
 
 static const TypeInfo pvrdma_info = {
-    .name = PVRDMA_HW_NAME,
+    .name = TYPE_PVRDMA_DEV,
     .parent = TYPE_PCI_DEVICE,
     .instance_size = sizeof(PVRDMADev),
     .class_init = pvrdma_class_init,
-- 
2.26.2


