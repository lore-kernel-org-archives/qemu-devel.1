Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 428B2C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 19:57:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E23E320882
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 19:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y206YV4U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E23E320882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGShA-0001zF-1K
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 15:57:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54352)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kGSaE-0005KI-Ul
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 15:50:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41545
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kGSaD-0000eL-1r
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 15:50:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599767412;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8byXPCH0aJllOHyLbYvO2RbX1+WLveIWvxPuKW8UHrw=;
 b=Y206YV4UzjeCI9ZSc9C+VwAElsn0O6mIm+zG5lS8ylw7McvcMuo6QN72nqa7tWcjLYdmPB
 SaBvuQq07Mfh15RxirK+jLpA9bJ3wgYtLmTjtqziMItCMkn0s6kzECdxquFionjdaq7ekw
 Obf7bdy9r0dLyFuOGD5tzSO77ZT9QrM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-MeJSmG9vOiqNDko3pcpSSA-1; Thu, 10 Sep 2020 15:50:10 -0400
X-MC-Unique: MeJSmG9vOiqNDko3pcpSSA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BDA351074640;
 Thu, 10 Sep 2020 19:50:09 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3F22F7EB74;
 Thu, 10 Sep 2020 19:50:00 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 12/18] chardev: Rename SPICE_CHARDEV to CHARDEV_SPICE
Date: Thu, 10 Sep 2020 15:48:57 -0400
Message-Id: <20200910194903.4104696-13-ehabkost@redhat.com>
In-Reply-To: <20200910194903.4104696-1-ehabkost@redhat.com>
References: <20200910194903.4104696-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 09:07:42
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
TYPE_CHARDEV_* constant names and the QOM type name strings
("chardev-*").

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/chardev/spice.h |  2 +-
 chardev/spice.c         | 16 ++++++++--------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/chardev/spice.h b/include/chardev/spice.h
index 99f26aedde..a48146d2c1 100644
--- a/include/chardev/spice.h
+++ b/include/chardev/spice.h
@@ -21,7 +21,7 @@ typedef struct SpiceChardev SpiceChardev;
 #define TYPE_CHARDEV_SPICEVMC "chardev-spicevmc"
 #define TYPE_CHARDEV_SPICEPORT "chardev-spiceport"
 
-DECLARE_INSTANCE_CHECKER(SpiceChardev, SPICE_CHARDEV,
+DECLARE_INSTANCE_CHECKER(SpiceChardev, CHARDEV_SPICE,
                          TYPE_CHARDEV_SPICE)
 
 void qemu_chr_open_spice_port(Chardev *chr, ChardevBackend *backend,
diff --git a/chardev/spice.c b/chardev/spice.c
index bf7ea1e294..90a6a55626 100644
--- a/chardev/spice.c
+++ b/chardev/spice.c
@@ -173,7 +173,7 @@ static GSourceFuncs SpiceCharSourceFuncs = {
 
 static GSource *spice_chr_add_watch(Chardev *chr, GIOCondition cond)
 {
-    SpiceChardev *scd = SPICE_CHARDEV(chr);
+    SpiceChardev *scd = CHARDEV_SPICE(chr);
     SpiceCharSource *src;
 
     assert(cond & G_IO_OUT);
@@ -187,7 +187,7 @@ static GSource *spice_chr_add_watch(Chardev *chr, GIOCondition cond)
 
 static int spice_chr_write(Chardev *chr, const uint8_t *buf, int len)
 {
-    SpiceChardev *s = SPICE_CHARDEV(chr);
+    SpiceChardev *s = CHARDEV_SPICE(chr);
     int read_bytes;
 
     assert(s->datalen == 0);
@@ -212,7 +212,7 @@ static int spice_chr_write(Chardev *chr, const uint8_t *buf, int len)
 
 static void char_spice_finalize(Object *obj)
 {
-    SpiceChardev *s = SPICE_CHARDEV(obj);
+    SpiceChardev *s = CHARDEV_SPICE(obj);
 
     vmc_unregister_interface(s);
 
@@ -224,7 +224,7 @@ static void char_spice_finalize(Object *obj)
 
 static void spice_vmc_set_fe_open(struct Chardev *chr, int fe_open)
 {
-    SpiceChardev *s = SPICE_CHARDEV(chr);
+    SpiceChardev *s = CHARDEV_SPICE(chr);
     if (fe_open) {
         vmc_register_interface(s);
     } else {
@@ -234,7 +234,7 @@ static void spice_vmc_set_fe_open(struct Chardev *chr, int fe_open)
 
 static void spice_port_set_fe_open(struct Chardev *chr, int fe_open)
 {
-    SpiceChardev *s = SPICE_CHARDEV(chr);
+    SpiceChardev *s = CHARDEV_SPICE(chr);
 
     if (fe_open) {
         spice_server_port_event(&s->sin, SPICE_PORT_EVENT_OPENED);
@@ -245,14 +245,14 @@ static void spice_port_set_fe_open(struct Chardev *chr, int fe_open)
 
 static void spice_chr_accept_input(struct Chardev *chr)
 {
-    SpiceChardev *s = SPICE_CHARDEV(chr);
+    SpiceChardev *s = CHARDEV_SPICE(chr);
 
     spice_server_char_device_wakeup(&s->sin);
 }
 
 static void chr_open(Chardev *chr, const char *subtype)
 {
-    SpiceChardev *s = SPICE_CHARDEV(chr);
+    SpiceChardev *s = CHARDEV_SPICE(chr);
 
     s->active = false;
     s->sin.subtype = g_strdup(subtype);
@@ -313,7 +313,7 @@ void qemu_chr_open_spice_port(Chardev *chr,
     chr_open(chr, "port");
 
     *be_opened = false;
-    s = SPICE_CHARDEV(chr);
+    s = CHARDEV_SPICE(chr);
     s->sin.portname = g_strdup(name);
 
     if (using_spice) {
-- 
2.26.2


