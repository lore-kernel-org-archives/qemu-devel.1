Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC7D1C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 19:53:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 259A2208E4
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 19:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R3/wJOSE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 259A2208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGSdL-00037m-6o
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 15:53:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54196)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kGSZj-0003sp-SN
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 15:49:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54013
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kGSZi-0000b7-86
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 15:49:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599767381;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=USh04D7GmPodeLCrUnBGKkPOXZRTk4QbeK/nTmu9mxc=;
 b=R3/wJOSEEehyBU2GLBesp672HLpRhTuTq2FeWYM/p1XtdkW8DWzsvS+qrTyOhrKGLNtNAc
 aqf990ZUPR+upNzZA8ekAlQS7K1Wj6yYf3c3tQGRGggPXLJXoI6BxfHyFTvoHPZKC7PjRe
 Jijg6PjEHYBvLP62pjltxu6eoE586UM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-49-_nTRV3HTMDyq6zgsLBAGAA-1; Thu, 10 Sep 2020 15:49:39 -0400
X-MC-Unique: _nTRV3HTMDyq6zgsLBAGAA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E55CA100746F;
 Thu, 10 Sep 2020 19:49:38 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DB4CD7E8F9;
 Thu, 10 Sep 2020 19:49:32 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 05/18] chardev: Rename BAUM_CHARDEV to CHARDEV_BRAILLE
Date: Thu, 10 Sep 2020 15:48:50 -0400
Message-Id: <20200910194903.4104696-6-ehabkost@redhat.com>
In-Reply-To: <20200910194903.4104696-1-ehabkost@redhat.com>
References: <20200910194903.4104696-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 08:35:50
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Rename instance and class type checkers to match the
TYPE_CHARDEV_BRAILLE constant name and the QOM type name string
("chardev-braille").

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 chardev/baum.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/chardev/baum.c b/chardev/baum.c
index 5deca778bc..48459bd73c 100644
--- a/chardev/baum.c
+++ b/chardev/baum.c
@@ -105,7 +105,7 @@ struct BaumChardev {
 typedef struct BaumChardev BaumChardev;
 
 #define TYPE_CHARDEV_BRAILLE "chardev-braille"
-DECLARE_INSTANCE_CHECKER(BaumChardev, BAUM_CHARDEV,
+DECLARE_INSTANCE_CHECKER(BaumChardev, CHARDEV_BRAILLE,
                          TYPE_CHARDEV_BRAILLE)
 
 /* Let's assume NABCC by default */
@@ -269,7 +269,7 @@ static int baum_deferred_init(BaumChardev *baum)
 /* The serial port can receive more of our data */
 static void baum_chr_accept_input(struct Chardev *chr)
 {
-    BaumChardev *baum = BAUM_CHARDEV(chr);
+    BaumChardev *baum = CHARDEV_BRAILLE(chr);
     int room, first;
 
     if (!baum->out_buf_used)
@@ -336,7 +336,7 @@ static void baum_write_packet(BaumChardev *baum, const uint8_t *buf, int len)
 /* Called when the other end seems to have a wrong idea of our display size */
 static void baum_cellCount_timer_cb(void *opaque)
 {
-    BaumChardev *baum = BAUM_CHARDEV(opaque);
+    BaumChardev *baum = CHARDEV_BRAILLE(opaque);
     uint8_t cell_count[] = { BAUM_RSP_CellCount, baum->x * baum->y };
     DPRINTF("Timeout waiting for DisplayData, sending cell count\n");
     baum_write_packet(baum, cell_count, sizeof(cell_count));
@@ -486,7 +486,7 @@ static int baum_eat_packet(BaumChardev *baum, const uint8_t *buf, int len)
 /* The other end is writing some data.  Store it and try to interpret */
 static int baum_chr_write(Chardev *chr, const uint8_t *buf, int len)
 {
-    BaumChardev *baum = BAUM_CHARDEV(chr);
+    BaumChardev *baum = CHARDEV_BRAILLE(chr);
     int tocopy, cur, eaten, orig_len = len;
 
     if (!len)
@@ -543,7 +543,7 @@ static void baum_send_key2(BaumChardev *baum, uint8_t type, uint8_t value,
 /* We got some data on the BrlAPI socket */
 static void baum_chr_read(void *opaque)
 {
-    BaumChardev *baum = BAUM_CHARDEV(opaque);
+    BaumChardev *baum = CHARDEV_BRAILLE(opaque);
     brlapi_keyCode_t code;
     int ret;
     if (!baum->brlapi)
@@ -629,7 +629,7 @@ static void baum_chr_read(void *opaque)
 
 static void char_braille_finalize(Object *obj)
 {
-    BaumChardev *baum = BAUM_CHARDEV(obj);
+    BaumChardev *baum = CHARDEV_BRAILLE(obj);
 
     timer_free(baum->cellCount_timer);
     if (baum->brlapi) {
@@ -643,7 +643,7 @@ static void baum_chr_open(Chardev *chr,
                           bool *be_opened,
                           Error **errp)
 {
-    BaumChardev *baum = BAUM_CHARDEV(chr);
+    BaumChardev *baum = CHARDEV_BRAILLE(chr);
     brlapi_handle_t *handle;
 
     handle = g_malloc0(brlapi_getHandleSize());
-- 
2.26.2


