Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56606C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 00:15:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F1ED207DA
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 00:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hiEY9wK7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F1ED207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8YEo-0001S7-AW
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 20:15:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48926)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k8YCJ-0004kB-0g
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 20:12:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20102)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k8YCH-0002Gb-3I
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 20:12:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597882368;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k/TnqvUgCno7HKezta0XAkL5zem1rmll2vSOVW/9iIk=;
 b=hiEY9wK7D+835g/ihERqbwCdqvJEDvgLpWvFZsJToBmyCowdwdWHO4XBggMPWVyyaKb+kQ
 ah03q9KF6T2A9Rpi6/EwQekP/02N0Pa9H8uIIuUkV13ytLM0//pEiRZ1uMEBfv+GNXT8iw
 e7riA2WyiNmd+WehMhQXG7isG59Olzs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-7aDX9aDbO1qgjilema1DzQ-1; Wed, 19 Aug 2020 20:12:46 -0400
X-MC-Unique: 7aDX9aDbO1qgjilema1DzQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 59BA6186A568;
 Thu, 20 Aug 2020 00:12:45 +0000 (UTC)
Received: from localhost (ovpn-117-244.rdu2.redhat.com [10.10.117.244])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D61C616D4B;
 Thu, 20 Aug 2020 00:12:44 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 04/58] pl110: Rename pl110_version enum values
Date: Wed, 19 Aug 2020 20:11:42 -0400
Message-Id: <20200820001236.1284548-5-ehabkost@redhat.com>
In-Reply-To: <20200820001236.1284548-1-ehabkost@redhat.com>
References: <20200820001236.1284548-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 20:12:48
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The PL110 enum value name will conflict with the PL110 type cast
checker, when we replace the existing macro with an inline
function.  Add a VERSION_ prefix to all pl110_version enum
values, to avoid conflicts.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Changes v1 -> v2:
* Fixed typo on commit message
* Rename all enum values to VERSION_* (Philippe Mathieu-Daudé)

---
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org
---
 hw/display/pl110.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/hw/display/pl110.c b/hw/display/pl110.c
index c2991a28d2..61fefbffb3 100644
--- a/hw/display/pl110.c
+++ b/hw/display/pl110.c
@@ -42,9 +42,9 @@ enum pl110_bppmode
 /* The Versatile/PB uses a slightly modified PL110 controller.  */
 enum pl110_version
 {
-    PL110,
-    PL110_VERSATILE,
-    PL111
+    VERSION_PL110,
+    VERSION_PL110_VERSATILE,
+    VERSION_PL111
 };
 
 #define TYPE_PL110 "pl110"
@@ -189,7 +189,7 @@ static void pl110_update_display(void *opaque)
     else
         bpp_offset = 24;
 
-    if ((s->version != PL111) && (s->bpp == BPP_16)) {
+    if ((s->version != VERSION_PL111) && (s->bpp == BPP_16)) {
         /* The PL110's native 16 bit mode is 5551; however
          * most boards with a PL110 implement an external
          * mux which allows bits to be reshuffled to give
@@ -372,12 +372,12 @@ static uint64_t pl110_read(void *opaque, hwaddr offset,
     case 5: /* LCDLPBASE */
         return s->lpbase;
     case 6: /* LCDIMSC */
-        if (s->version != PL110) {
+        if (s->version != VERSION_PL110) {
             return s->cr;
         }
         return s->int_mask;
     case 7: /* LCDControl */
-        if (s->version != PL110) {
+        if (s->version != VERSION_PL110) {
             return s->int_mask;
         }
         return s->cr;
@@ -437,7 +437,7 @@ static void pl110_write(void *opaque, hwaddr offset,
         s->lpbase = val;
         break;
     case 6: /* LCDIMSC */
-        if (s->version != PL110) {
+        if (s->version != VERSION_PL110) {
             goto control;
         }
     imsc:
@@ -445,7 +445,7 @@ static void pl110_write(void *opaque, hwaddr offset,
         pl110_update(s);
         break;
     case 7: /* LCDControl */
-        if (s->version != PL110) {
+        if (s->version != VERSION_PL110) {
             goto imsc;
         }
     control:
@@ -513,21 +513,21 @@ static void pl110_init(Object *obj)
 {
     PL110State *s = PL110(obj);
 
-    s->version = PL110;
+    s->version = VERSION_PL110;
 }
 
 static void pl110_versatile_init(Object *obj)
 {
     PL110State *s = PL110(obj);
 
-    s->version = PL110_VERSATILE;
+    s->version = VERSION_PL110_VERSATILE;
 }
 
 static void pl111_init(Object *obj)
 {
     PL110State *s = PL110(obj);
 
-    s->version = PL111;
+    s->version = VERSION_PL111;
 }
 
 static void pl110_class_init(ObjectClass *klass, void *data)
-- 
2.26.2


