Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 284C9C43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 20:07:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C580F204FD
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 20:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ThJyD5u4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C580F204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFjtU-0004qw-Nz
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 16:07:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43866)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kFjoZ-0001Mj-9A
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 16:02:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51485
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kFjoS-0004M5-Ik
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 16:02:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599595315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y+oHo64EvoiaTMi66DVtt06upr/08pRVnAZcNgeussI=;
 b=ThJyD5u4RKmHBU2i2cKsj5KgQTD7sdqKn2Of/HFtp5lyEeKl4By7PFmvaXr44vwxWVth53
 eJx9u+VixPfangNVFq52gmRXGg4LFfn0fgYG0iVEk3ip0C698xHM54nMufTTY5KheLzxbD
 zcEdYBkOa3TTj2b/wmbN9LJOCdN/Gxg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-a-0YiJ-xPb62A1xuIVcLCw-1; Tue, 08 Sep 2020 16:01:51 -0400
X-MC-Unique: a-0YiJ-xPb62A1xuIVcLCw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2CB3918B9ED3;
 Tue,  8 Sep 2020 20:01:50 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E8A195C1C4;
 Tue,  8 Sep 2020 20:01:49 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 18/34] vfio: Rename VFIO_AP_DEVICE_TYPE to TYPE_VFIO_AP_DEVICE
Date: Tue,  8 Sep 2020 16:01:07 -0400
Message-Id: <20200908200123.3402311-19-ehabkost@redhat.com>
In-Reply-To: <20200908200123.3402311-1-ehabkost@redhat.com>
References: <20200908200123.3402311-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 12:55:20
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This will make the type name constant consistent with the name of
the type checking macro.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20200902224311.1321159-9-ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/vfio/ap.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index 68ed059b39..582c091a24 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -30,7 +30,7 @@
 #include "exec/address-spaces.h"
 #include "qom/object.h"
 
-#define VFIO_AP_DEVICE_TYPE      "vfio-ap"
+#define TYPE_VFIO_AP_DEVICE      "vfio-ap"
 
 struct VFIOAPDevice {
     APDevice apdev;
@@ -39,7 +39,7 @@ struct VFIOAPDevice {
 typedef struct VFIOAPDevice VFIOAPDevice;
 
 DECLARE_INSTANCE_CHECKER(VFIOAPDevice, VFIO_AP_DEVICE,
-                         VFIO_AP_DEVICE_TYPE)
+                         TYPE_VFIO_AP_DEVICE)
 
 static void vfio_ap_compute_needs_reset(VFIODevice *vdev)
 {
@@ -72,7 +72,7 @@ static VFIOGroup *vfio_ap_get_group(VFIOAPDevice *vapdev, Error **errp)
 
     if (!group_path) {
         error_setg(errp, "%s: no iommu_group found for %s: %s",
-                   VFIO_AP_DEVICE_TYPE, vapdev->vdev.sysfsdev, gerror->message);
+                   TYPE_VFIO_AP_DEVICE, vapdev->vdev.sysfsdev, gerror->message);
         g_error_free(gerror);
         return NULL;
     }
@@ -176,7 +176,7 @@ static void vfio_ap_class_init(ObjectClass *klass, void *data)
 }
 
 static const TypeInfo vfio_ap_info = {
-    .name = VFIO_AP_DEVICE_TYPE,
+    .name = TYPE_VFIO_AP_DEVICE,
     .parent = TYPE_AP_DEVICE,
     .instance_size = sizeof(VFIOAPDevice),
     .class_init = vfio_ap_class_init,
-- 
2.26.2


