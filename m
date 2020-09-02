Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA580C433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 23:00:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77CB820709
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 23:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bk8J26Ht"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77CB820709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDbkG-0002sz-Fa
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 19:00:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35578)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDbVF-0004jE-Vb
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 18:45:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29003
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDbVD-00007i-VV
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 18:45:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599086715;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZTf3hJPr9kfGRaKSf0NUpzie9ms1TMjZZBoTx5/8NF4=;
 b=Bk8J26HtdDp/3zpUQCbiAhrVxtvBXAarv71bWk3VgW9wOz2plomP561z258gSCBuWMS/KC
 8e0QyobxsUP0Cmq/NuBcFC5rACSkiu0y1S2/1ecrQAa9YsNEblGwFCeSI5+VDRpS2UdrfI
 Y6SxMWwwd4kC4mwEJxvoTRbIBZenAdg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-zaXCfgVzPpy6DZAwmV9jJg-1; Wed, 02 Sep 2020 18:45:13 -0400
X-MC-Unique: zaXCfgVzPpy6DZAwmV9jJg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9BA048030C7;
 Wed,  2 Sep 2020 22:45:12 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6441E19C59;
 Wed,  2 Sep 2020 22:45:12 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 44/63] renesas: Rename RCMT to RENESAS_CMT
Date: Wed,  2 Sep 2020 18:42:52 -0400
Message-Id: <20200902224311.1321159-45-ehabkost@redhat.com>
In-Reply-To: <20200902224311.1321159-1-ehabkost@redhat.com>
References: <20200902224311.1321159-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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
Cc: Magnus Damm <magnus.damm@gmail.com>, berrange@redhat.com,
 Yoshinori Sato <ysato@users.sourceforge.jp>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This will make the type name constant consistent with the name of
the type checking macro.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: qemu-devel@nongnu.org
---
 include/hw/timer/renesas_cmt.h | 2 +-
 hw/timer/renesas_cmt.c         | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/hw/timer/renesas_cmt.h b/include/hw/timer/renesas_cmt.h
index 1c0b65c1d5..89e83df374 100644
--- a/include/hw/timer/renesas_cmt.h
+++ b/include/hw/timer/renesas_cmt.h
@@ -15,7 +15,7 @@
 
 #define TYPE_RENESAS_CMT "renesas-cmt"
 typedef struct RCMTState RCMTState;
-DECLARE_INSTANCE_CHECKER(RCMTState, RCMT,
+DECLARE_INSTANCE_CHECKER(RCMTState, RENESAS_CMT,
                          TYPE_RENESAS_CMT)
 
 enum {
diff --git a/hw/timer/renesas_cmt.c b/hw/timer/renesas_cmt.c
index 2e0fd21a36..5700980057 100644
--- a/hw/timer/renesas_cmt.c
+++ b/hw/timer/renesas_cmt.c
@@ -214,7 +214,7 @@ static void timer_event1(void *opaque)
 
 static void rcmt_reset(DeviceState *dev)
 {
-    RCMTState *cmt = RCMT(dev);
+    RCMTState *cmt = RENESAS_CMT(dev);
     cmt->cmstr = 0;
     cmt->cmcr[0] = cmt->cmcr[1] = 0;
     cmt->cmcnt[0] = cmt->cmcnt[1] = 0;
@@ -224,7 +224,7 @@ static void rcmt_reset(DeviceState *dev)
 static void rcmt_init(Object *obj)
 {
     SysBusDevice *d = SYS_BUS_DEVICE(obj);
-    RCMTState *cmt = RCMT(obj);
+    RCMTState *cmt = RENESAS_CMT(obj);
     int i;
 
     memory_region_init_io(&cmt->memory, OBJECT(cmt), &cmt_ops,
-- 
2.26.2


