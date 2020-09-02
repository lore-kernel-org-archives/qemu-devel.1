Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94141C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 23:01:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CD3720767
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 23:01:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RTfVb4oP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CD3720767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDblN-0005AW-7x
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 19:01:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35442)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDbUz-00044M-DJ
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 18:45:01 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45320
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDbUx-0008UM-He
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 18:45:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599086698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zq9LSe6jW4K7WL54MmIxfbLjOQyXbELHR988rh4CKe0=;
 b=RTfVb4oPUMfVxCmC7u2t2RGWnryjugdME70V9plM5LBmkys2nq/O198rEqgWpGv/9/99Nj
 0FOIVsbppLe+GaEJW+6Ect8N08mX5cXov6qVpL+kM9D7Ab4aS9HhmZevFFckzt9dX1fyHk
 GUvikcxcg2b9+o4rAFady4ylZxRJ/AM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-5tyNOB5eM-WJzmkxFfx9gg-1; Wed, 02 Sep 2020 18:44:57 -0400
X-MC-Unique: 5tyNOB5eM-WJzmkxFfx9gg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 28082801AAE
 for <qemu-devel@nongnu.org>; Wed,  2 Sep 2020 22:44:56 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 94B2760C0F;
 Wed,  2 Sep 2020 22:44:52 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 37/63] ccid-card-emulated: Rename EMULATED_CCID_CARD to
 EMULATED_CCID
Date: Wed,  2 Sep 2020 18:42:45 -0400
Message-Id: <20200902224311.1321159-38-ehabkost@redhat.com>
In-Reply-To: <20200902224311.1321159-1-ehabkost@redhat.com>
References: <20200902224311.1321159-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 17:54:07
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
Cc: berrange@redhat.com, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Make the type checking macro name consistent with the TYPE_*
constant.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org
---
 hw/usb/ccid-card-emulated.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/usb/ccid-card-emulated.c b/hw/usb/ccid-card-emulated.c
index 5e4649d367..9803dac5b7 100644
--- a/hw/usb/ccid-card-emulated.c
+++ b/hw/usb/ccid-card-emulated.c
@@ -47,7 +47,7 @@ do {\
 
 #define TYPE_EMULATED_CCID "ccid-card-emulated"
 typedef struct EmulatedState EmulatedState;
-DECLARE_INSTANCE_CHECKER(EmulatedState, EMULATED_CCID_CARD,
+DECLARE_INSTANCE_CHECKER(EmulatedState, EMULATED_CCID,
                          TYPE_EMULATED_CCID)
 
 #define BACKEND_NSS_EMULATED_NAME "nss-emulated"
@@ -138,7 +138,7 @@ struct EmulatedState {
 static void emulated_apdu_from_guest(CCIDCardState *base,
     const uint8_t *apdu, uint32_t len)
 {
-    EmulatedState *card = EMULATED_CCID_CARD(base);
+    EmulatedState *card = EMULATED_CCID(base);
     EmulEvent *event = (EmulEvent *)g_malloc(sizeof(EmulEvent) + len);
 
     assert(event);
@@ -155,7 +155,7 @@ static void emulated_apdu_from_guest(CCIDCardState *base,
 
 static const uint8_t *emulated_get_atr(CCIDCardState *base, uint32_t *len)
 {
-    EmulatedState *card = EMULATED_CCID_CARD(base);
+    EmulatedState *card = EMULATED_CCID(base);
 
     *len = card->atr_length;
     return card->atr;
@@ -488,7 +488,7 @@ static uint32_t parse_enumeration(char *str,
 
 static void emulated_realize(CCIDCardState *base, Error **errp)
 {
-    EmulatedState *card = EMULATED_CCID_CARD(base);
+    EmulatedState *card = EMULATED_CCID(base);
     VCardEmulError ret;
     const EnumTable *ptable;
 
@@ -564,7 +564,7 @@ out1:
 
 static void emulated_unrealize(CCIDCardState *base)
 {
-    EmulatedState *card = EMULATED_CCID_CARD(base);
+    EmulatedState *card = EMULATED_CCID(base);
     VEvent *vevent = vevent_new(VEVENT_LAST, NULL, NULL);
 
     vevent_queue_vevent(vevent); /* stop vevent thread */
-- 
2.26.2


