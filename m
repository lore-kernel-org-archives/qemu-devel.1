Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 952AEC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 19:37:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D1382087E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 19:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KWxhOtGV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D1382087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBNiA-0002qo-JF
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 15:37:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34512)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kBNU7-00084Y-4T
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 15:22:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36591)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kBNU5-0000WU-FK
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 15:22:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598556172;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bGXbAiYTASYGGEBCy9P2BZF868tBcfi+9F/wWZusn1o=;
 b=KWxhOtGVqrZ6xATsRLwqV+W8j/8MEFuJyKSOGdS0PsY2vGd1/01P0qJj2rO1HvyFVEwKyG
 FFm0AH8sv6B7LuVkhFjbq44ivcX49nvDTp5i1Vl1zMDbNxQefOuGpBXawuC2+kKmE/pnp3
 kxmdcF3x9gl2O1RLOvp7Uh+UE/GbsJk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-87-QtpmyrdnMYmtnGjKoNadbA-1; Thu, 27 Aug 2020 15:22:50 -0400
X-MC-Unique: QtpmyrdnMYmtnGjKoNadbA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4028A8018A4;
 Thu, 27 Aug 2020 19:22:49 +0000 (UTC)
Received: from localhost (unknown [10.10.67.254])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 055C419C71;
 Thu, 27 Aug 2020 19:22:48 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 39/53] mptsas: Move QOM macros to header
Date: Thu, 27 Aug 2020 15:21:08 -0400
Message-Id: <20200827192122.658035-40-ehabkost@redhat.com>
In-Reply-To: <20200827192122.658035-1-ehabkost@redhat.com>
References: <20200827192122.658035-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 02:10:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This will make future conversion to OBJECT_DECLARE* easier.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Tested-By: Roman Bolshakov <r.bolshakov@yadro.com>
Message-Id: <20200825192110.3528606-41-ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/scsi/mptsas.h | 6 +++++-
 hw/scsi/mptsas.c | 5 -----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/hw/scsi/mptsas.h b/hw/scsi/mptsas.h
index 0436a33911..9ac98fc20e 100644
--- a/hw/scsi/mptsas.h
+++ b/hw/scsi/mptsas.h
@@ -11,9 +11,13 @@
 
 #define MPTSAS_MAXIMUM_CHAIN_DEPTH 0x22
 
-typedef struct MPTSASState MPTSASState;
 typedef struct MPTSASRequest MPTSASRequest;
 
+#define TYPE_MPTSAS1068 "mptsas1068"
+typedef struct MPTSASState MPTSASState;
+#define MPT_SAS(obj) \
+    OBJECT_CHECK(MPTSASState, (obj), TYPE_MPTSAS1068)
+
 enum {
     DOORBELL_NONE,
     DOORBELL_WRITE,
diff --git a/hw/scsi/mptsas.c b/hw/scsi/mptsas.c
index 14cbed84d0..135e7d96e4 100644
--- a/hw/scsi/mptsas.c
+++ b/hw/scsi/mptsas.c
@@ -42,11 +42,6 @@
 #define NAA_LOCALLY_ASSIGNED_ID 0x3ULL
 #define IEEE_COMPANY_LOCALLY_ASSIGNED 0x525400
 
-#define TYPE_MPTSAS1068 "mptsas1068"
-
-#define MPT_SAS(obj) \
-    OBJECT_CHECK(MPTSASState, (obj), TYPE_MPTSAS1068)
-
 #define MPTSAS1068_PRODUCT_ID                  \
     (MPI_FW_HEADER_PID_FAMILY_1068_SAS |       \
      MPI_FW_HEADER_PID_PROD_INITIATOR_SCSI |   \
-- 
2.26.2


