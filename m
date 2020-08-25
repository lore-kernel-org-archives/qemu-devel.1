Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ABB2C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 19:45:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E8C32075E
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 19:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PTQFiliZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E8C32075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAesS-0006Ed-Ew
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 15:45:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40574)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kAeXG-0002Jd-TN
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 15:23:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52774
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kAeXF-0006KJ-1d
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 15:23:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598383388;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cN56Qh/RA7pUGeK+UjYLed6tcMecdFPLXuhdnlyAfCo=;
 b=PTQFiliZKIgkW2zwa/vvZr7XMy/Y5VT2lSLitipP4s9utsnAMBWBw45zoCOEFytkX+Vx2h
 NH9N3UcLPF7K2YFFbDFMme2gefbUAsFsj/1wh3o77wiG5Y52xNYUOOIcs/7pSUL+b3S14k
 qOEX93zey4Ug6ZTuL5YjweFOWRtVIFo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-GHSnqBItPKC5TycjIvYXFw-1; Tue, 25 Aug 2020 15:23:06 -0400
X-MC-Unique: GHSnqBItPKC5TycjIvYXFw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A69F11074640
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 19:23:05 +0000 (UTC)
Received: from localhost (unknown [10.10.67.254])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4A0427E305;
 Tue, 25 Aug 2020 19:23:05 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 50/74] migration: Rename class type checking macros
Date: Tue, 25 Aug 2020 15:20:46 -0400
Message-Id: <20200825192110.3528606-51-ehabkost@redhat.com>
In-Reply-To: <20200825192110.3528606-1-ehabkost@redhat.com>
References: <20200825192110.3528606-1-ehabkost@redhat.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 10:39:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.958,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Rename the macros to make them consistent with the MIGRATION_OBJ
macro name.

This will make future conversion to OBJECT_DECLARE* easier.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Changes series v2 -> v3: new patch added to series v3

---
Cc: Juan Quintela <quintela@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org
---
 migration/migration.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/migration/migration.h b/migration/migration.h
index 2ed55c4aef..ae497bd45a 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -114,11 +114,11 @@ void fill_destination_postcopy_migration_info(MigrationInfo *info);
 
 #define TYPE_MIGRATION "migration"
 
-#define MIGRATION_CLASS(klass) \
+#define MIGRATION_OBJ_CLASS(klass) \
     OBJECT_CLASS_CHECK(MigrationClass, (klass), TYPE_MIGRATION)
 #define MIGRATION_OBJ(obj) \
     OBJECT_CHECK(MigrationState, (obj), TYPE_MIGRATION)
-#define MIGRATION_GET_CLASS(obj) \
+#define MIGRATION_OBJ_GET_CLASS(obj) \
     OBJECT_GET_CLASS(MigrationClass, (obj), TYPE_MIGRATION)
 
 typedef struct MigrationClass {
-- 
2.26.2


