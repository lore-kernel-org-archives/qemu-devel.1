Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E172C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 19:46:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5821D207DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 19:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tn9AkNP/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5821D207DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBNrD-0003H4-L6
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 15:46:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34306)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kBNTm-0007VB-6x
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 15:22:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42220)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kBNTg-0000SY-WE
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 15:22:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598556146;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yAU4tVS7aPRW5XItUAha+EHzHkQnvvorrA8YoWf36I4=;
 b=Tn9AkNP/YfmzvZ9IgOjcLYIuh/elRifXGjB/sYalSMHj7tES8CfMjQUzvWH2GUTf1Cvw3u
 FEMh09g2D0c3Uehjke4hJ8I8nCXNmSLM7aZEhjru5YknQd8M7Ws7JWXwy0daBx6U5DTQUE
 pheRDqscN1rWE4htoTvluWVrOwfmyZY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-tan1dLt7Nzm7CXzABSZRqQ-1; Thu, 27 Aug 2020 15:22:23 -0400
X-MC-Unique: tan1dLt7Nzm7CXzABSZRqQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 97CF5107464C;
 Thu, 27 Aug 2020 19:22:22 +0000 (UTC)
Received: from localhost (unknown [10.10.67.254])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1DC887849B;
 Thu, 27 Aug 2020 19:22:21 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 27/53] s390x: Move typedef SCLPEventFacility to event-facility.h
Date: Thu, 27 Aug 2020 15:20:56 -0400
Message-Id: <20200827192122.658035-28-ehabkost@redhat.com>
In-Reply-To: <20200827192122.658035-1-ehabkost@redhat.com>
References: <20200827192122.658035-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Roman Bolshakov <r.bolshakov@yadro.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This will make future conversion to OBJECT_DECLARE* easier.

In sclp.h, use "struct SCLPEventFacility" to avoid introducing
unnecessary header dependencies.

Acked-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Tested-By: Roman Bolshakov <r.bolshakov@yadro.com>
Message-Id: <20200825192110.3528606-29-ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/s390x/event-facility.h | 1 +
 include/hw/s390x/sclp.h           | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/hw/s390x/event-facility.h b/include/hw/s390x/event-facility.h
index 700a610f33..e61c4651d7 100644
--- a/include/hw/s390x/event-facility.h
+++ b/include/hw/s390x/event-facility.h
@@ -195,6 +195,7 @@ typedef struct SCLPEventClass {
 } SCLPEventClass;
 
 #define TYPE_SCLP_EVENT_FACILITY "s390-sclp-event-facility"
+typedef struct SCLPEventFacility SCLPEventFacility;
 #define EVENT_FACILITY(obj) \
      OBJECT_CHECK(SCLPEventFacility, (obj), TYPE_SCLP_EVENT_FACILITY)
 #define EVENT_FACILITY_CLASS(klass) \
diff --git a/include/hw/s390x/sclp.h b/include/hw/s390x/sclp.h
index 822eff4396..a87ed2a0ab 100644
--- a/include/hw/s390x/sclp.h
+++ b/include/hw/s390x/sclp.h
@@ -185,12 +185,12 @@ typedef struct SCCB {
 #define SCLP_CLASS(oc) OBJECT_CLASS_CHECK(SCLPDeviceClass, (oc), TYPE_SCLP)
 #define SCLP_GET_CLASS(obj) OBJECT_GET_CLASS(SCLPDeviceClass, (obj), TYPE_SCLP)
 
-typedef struct SCLPEventFacility SCLPEventFacility;
+struct SCLPEventFacility;
 
 typedef struct SCLPDevice {
     /* private */
     DeviceState parent_obj;
-    SCLPEventFacility *event_facility;
+    struct SCLPEventFacility *event_facility;
     int increment_size;
 
     /* public */
-- 
2.26.2


