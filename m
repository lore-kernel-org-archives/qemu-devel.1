Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B4AC2BC11
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 20:16:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7D6520936
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 20:16:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X7S5iI7o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7D6520936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFk23-0003yx-QQ
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 16:15:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44046)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kFjok-0001lw-1b
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 16:02:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26166)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kFjoh-0004PM-M3
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 16:02:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599595330;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TPqznILZvUu9q1JPhNI3wAUpCRCItkymnaT8Sy8vjHU=;
 b=X7S5iI7ofQ0VAWWN8q9qZCjqaEHjDiHN9Xff43kDblS/yhNvDZatGM9kIW9FFgyEVF+5c9
 nyrs0QXhyBoU/bVHR9LCjq6fQ5G1ziEgtv2uAPkNx05BYYsPdJzJKnb2u5kKr7dPLe6kDL
 jGRHKSzQThxV+TqELN2RLWvA2hIbRn8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-jMGKpKvDMSu_a1nttu8tug-1; Tue, 08 Sep 2020 16:02:07 -0400
X-MC-Unique: jMGKpKvDMSu_a1nttu8tug-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C93CB1DDFA;
 Tue,  8 Sep 2020 20:02:02 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8F35160C15;
 Tue,  8 Sep 2020 20:02:02 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 27/34] pc87312: Rename TYPE_PC87312_SUPERIO to TYPE_PC87312
Date: Tue,  8 Sep 2020 16:01:16 -0400
Message-Id: <20200908200123.3402311-28-ehabkost@redhat.com>
In-Reply-To: <20200908200123.3402311-1-ehabkost@redhat.com>
References: <20200908200123.3402311-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 12:54:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This will make the type name constant consistent with the name of
the type checking macro.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Hervé Poussineau <hpoussin@reactos.org>
Message-Id: <20200902224311.1321159-21-ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/isa/pc87312.h | 4 ++--
 hw/isa/pc87312.c         | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/hw/isa/pc87312.h b/include/hw/isa/pc87312.h
index a65168a157..da8dc5ddf5 100644
--- a/include/hw/isa/pc87312.h
+++ b/include/hw/isa/pc87312.h
@@ -29,10 +29,10 @@
 #include "qom/object.h"
 
 
-#define TYPE_PC87312_SUPERIO "pc87312"
+#define TYPE_PC87312 "pc87312"
 typedef struct PC87312State PC87312State;
 DECLARE_INSTANCE_CHECKER(PC87312State, PC87312,
-                         TYPE_PC87312_SUPERIO)
+                         TYPE_PC87312)
 
 struct PC87312State {
     /*< private >*/
diff --git a/hw/isa/pc87312.c b/hw/isa/pc87312.c
index 0cacbbc91b..8d7b8d3db2 100644
--- a/hw/isa/pc87312.c
+++ b/hw/isa/pc87312.c
@@ -371,7 +371,7 @@ static void pc87312_class_init(ObjectClass *klass, void *data)
 }
 
 static const TypeInfo pc87312_type_info = {
-    .name          = TYPE_PC87312_SUPERIO,
+    .name          = TYPE_PC87312,
     .parent        = TYPE_ISA_SUPERIO,
     .instance_size = sizeof(PC87312State),
     .instance_init = pc87312_initfn,
-- 
2.26.2


