Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF76C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 19:24:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30823207DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 19:24:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EVBgv7gq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30823207DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAeYC-0004BD-FK
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 15:24:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39196)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kAeVb-0006PD-GQ
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 15:21:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37301)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kAeVZ-00062m-SR
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 15:21:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598383285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XTAFEKMSK8vkQHOcmSGBKYq+KE2Hne7CvM5XaApOCF4=;
 b=EVBgv7gqlV9Ovo39thMe7O1laobLuptbct1YM38RSkl50wsxtPNuubfpGXa8NScX6tm0kU
 85gCGlAzlki6fnRC2q75uWNop4HmRsTM+QTyjO/G/YdYveKtCJ/LFkM/a7AZxwu570NxSk
 CmSXsL3VwUXyPZZSwetTUh0oF4stVnA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-rSvvyfFANjiFCwHU1m3Rcw-1; Tue, 25 Aug 2020 15:21:23 -0400
X-MC-Unique: rSvvyfFANjiFCwHU1m3Rcw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 30535100559D;
 Tue, 25 Aug 2020 19:21:22 +0000 (UTC)
Received: from localhost (unknown [10.10.67.254])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D3D0460E1C;
 Tue, 25 Aug 2020 19:21:21 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 04/74] pl110: Rename pl110_version enum values
Date: Tue, 25 Aug 2020 15:20:00 -0400
Message-Id: <20200825192110.3528606-5-ehabkost@redhat.com>
In-Reply-To: <20200825192110.3528606-1-ehabkost@redhat.com>
References: <20200825192110.3528606-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 02:03:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.958,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 "Daniel P. Berrange" <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The PL110 enum value name will conflict with the PL110 type cast
checker, when we replace the existing macro with an inline
function.  Add a VERSION_ prefix to all pl110_version enum
values, to avoid conflicts.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Changes v2 -> v3: none

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


