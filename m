Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1958C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 22:49:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62F3120767
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 22:49:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cSj2lGBM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62F3120767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDbZd-0004CS-Ew
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 18:49:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34938)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDbU8-00022I-0S
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 18:44:08 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24254
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDbU6-0008Kf-AC
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 18:44:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599086645;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X5fem+hpI97myR6L8jqxTgfrc8vXjZJY8/UZJdvvPyk=;
 b=cSj2lGBMXyYppvZkTx/Z3K5S/Gfx2d6kv/3O1masqrrB1iTWIkSgJnXw4CCMr2y9LW9cJf
 DC0bw9ijESSqlyAbh7Pz4L9TOiYEjA7+MJPnLdvTbRFOPEEludiAWq2SR/b2XUVEDJi5Ay
 MdXH323lPUqa5BMkU+v0yJf+r6mUP3k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-ygB5VtMqOmuqbT6PyZC_mw-1; Wed, 02 Sep 2020 18:44:03 -0400
X-MC-Unique: ygB5VtMqOmuqbT6PyZC_mw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D8E9B18A2257;
 Wed,  2 Sep 2020 22:44:02 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 851225C1C4;
 Wed,  2 Sep 2020 22:44:02 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 13/63] etrax: Rename TYPE_ETRAX_FS_TIMER to TYPE_ETRAX_TIMER
Date: Wed,  2 Sep 2020 18:42:21 -0400
Message-Id: <20200902224311.1321159-14-ehabkost@redhat.com>
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
Received-SPF: pass client-ip=205.139.110.61; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 17:27:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, berrange@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This will make the type name constant consistent with the name of
the type checking macro.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: qemu-devel@nongnu.org
---
 hw/timer/etraxfs_timer.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/timer/etraxfs_timer.c b/hw/timer/etraxfs_timer.c
index 48f2e3ade2..585e934ed5 100644
--- a/hw/timer/etraxfs_timer.c
+++ b/hw/timer/etraxfs_timer.c
@@ -48,10 +48,10 @@
 #define R_INTR        0x50
 #define R_MASKED_INTR 0x54
 
-#define TYPE_ETRAX_FS_TIMER "etraxfs,timer"
+#define TYPE_ETRAX_TIMER "etraxfs,timer"
 typedef struct ETRAXTimerState ETRAXTimerState;
 DECLARE_INSTANCE_CHECKER(ETRAXTimerState, ETRAX_TIMER,
-                         TYPE_ETRAX_FS_TIMER)
+                         TYPE_ETRAX_TIMER)
 
 struct ETRAXTimerState {
     SysBusDevice parent_obj;
@@ -354,7 +354,7 @@ static void etraxfs_timer_class_init(ObjectClass *klass, void *data)
 }
 
 static const TypeInfo etraxfs_timer_info = {
-    .name          = TYPE_ETRAX_FS_TIMER,
+    .name          = TYPE_ETRAX_TIMER,
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(ETRAXTimerState),
     .class_init    = etraxfs_timer_class_init,
-- 
2.26.2


