Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA44DC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 22:33:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93450204EC
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 22:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jf0JD/BH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93450204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6Lmg-0006om-Mv
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 18:33:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36394)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k6LgZ-0005WV-LW
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 18:27:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33178
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k6LgY-0002uS-4i
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 18:26:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597357617;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6e/y6GnUNzmSq9ZLIZo77u5F9W4vloSle6sKKrVfSwo=;
 b=Jf0JD/BH7+iiW6Qcr8x0R/323fkGHxy7hsp+Wi2EvqvwW6GnSVvUkuNuxLoyYP6Qrr64QB
 UUn3FQfDvn3lHY0bw7XiZsJF5J1DJexhqNwZ3ImEVMY1Y9cABDhxpFg0IFNw4FVjwu8DmQ
 1LsiBYu9v9RVlvUROcNSIIrMWRRXSCc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-HRSIz7ouPgmtuj2covqXHg-1; Thu, 13 Aug 2020 18:26:55 -0400
X-MC-Unique: HRSIz7ouPgmtuj2covqXHg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D0783801AC4
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2020 22:26:54 +0000 (UTC)
Received: from localhost (ovpn-117-153.rdu2.redhat.com [10.10.117.153])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 67C785D759;
 Thu, 13 Aug 2020 22:26:54 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 24/41] platform-bus: Delete macros for non-existing typedef
Date: Thu, 13 Aug 2020 18:26:08 -0400
Message-Id: <20200813222625.243136-25-ehabkost@redhat.com>
In-Reply-To: <20200813222625.243136-1-ehabkost@redhat.com>
References: <20200813222625.243136-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 17:30:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
 "Daniel P. Berrange" <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PlatformBusDeviceClass doesn't exist.  This will break when we
automatically convert the code to use OBJECT_DEFINE_TYPE().
Delete the macros that reference the non-existing typedef.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/platform-bus.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/hw/platform-bus.h b/include/hw/platform-bus.h
index 19e20c57ce..33745a418e 100644
--- a/include/hw/platform-bus.h
+++ b/include/hw/platform-bus.h
@@ -29,10 +29,6 @@ typedef struct PlatformBusDevice PlatformBusDevice;
 #define TYPE_PLATFORM_BUS_DEVICE "platform-bus-device"
 #define PLATFORM_BUS_DEVICE(obj) \
      OBJECT_CHECK(PlatformBusDevice, (obj), TYPE_PLATFORM_BUS_DEVICE)
-#define PLATFORM_BUS_DEVICE_CLASS(klass) \
-     OBJECT_CLASS_CHECK(PlatformBusDeviceClass, (klass), TYPE_PLATFORM_BUS_DEVICE)
-#define PLATFORM_BUS_DEVICE_GET_CLASS(obj) \
-     OBJECT_GET_CLASS(PlatformBusDeviceClass, (obj), TYPE_PLATFORM_BUS_DEVICE)
 
 struct PlatformBusDevice {
     /*< private >*/
-- 
2.26.2


