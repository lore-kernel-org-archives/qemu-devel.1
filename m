Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C39C4C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 19:54:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D9CE208E4
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 19:54:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hcbrNUzP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D9CE208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGSe2-0004Mn-Ef
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 15:54:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54406)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kGSaU-0005vz-Gj
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 15:50:30 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28250
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kGSaS-0000jK-Jd
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 15:50:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599767427;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yEfAtE+0wDZ7+bvuWCzZ1RN/j1HSUrKTvd6UcuRBbJk=;
 b=hcbrNUzPou6/z95i08gJleMLg8a7ptbWdl3PguuEsxS7I40rXSFTNJVjoApp8qMAwLpA47
 b5scP4oggtdjdrY8EJmYJZAfuDtCtKGviTW80QGXSJRZvhuAE+wnpO3KBF1xs0wuh05EzH
 nRW89nk966YhOAWDeo1mlSpMiv9HTFc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-82-z4YkpfkTNnSLyKb5Wp0LLg-1; Thu, 10 Sep 2020 15:50:26 -0400
X-MC-Unique: z4YkpfkTNnSLyKb5Wp0LLg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 81E1F801AF2;
 Thu, 10 Sep 2020 19:50:24 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 44C9675125;
 Thu, 10 Sep 2020 19:50:18 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 14/18] chardev: Rename UDP_CHARDEV to CHARDEV_UDP
Date: Thu, 10 Sep 2020 15:48:59 -0400
Message-Id: <20200910194903.4104696-15-ehabkost@redhat.com>
In-Reply-To: <20200910194903.4104696-1-ehabkost@redhat.com>
References: <20200910194903.4104696-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 09:07:44
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
 chardev/char-udp.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/chardev/char-udp.c b/chardev/char-udp.c
index 16b5dbce58..9fa5b19a22 100644
--- a/chardev/char-udp.c
+++ b/chardev/char-udp.c
@@ -45,13 +45,13 @@ struct UdpChardev {
 };
 typedef struct UdpChardev UdpChardev;
 
-DECLARE_INSTANCE_CHECKER(UdpChardev, UDP_CHARDEV,
+DECLARE_INSTANCE_CHECKER(UdpChardev, CHARDEV_UDP,
                          TYPE_CHARDEV_UDP)
 
 /* Called with chr_write_lock held.  */
 static int udp_chr_write(Chardev *chr, const uint8_t *buf, int len)
 {
-    UdpChardev *s = UDP_CHARDEV(chr);
+    UdpChardev *s = CHARDEV_UDP(chr);
 
     return qio_channel_write(
         s->ioc, (const char *)buf, len, NULL);
@@ -72,7 +72,7 @@ static void udp_chr_flush_buffer(UdpChardev *s)
 static int udp_chr_read_poll(void *opaque)
 {
     Chardev *chr = CHARDEV(opaque);
-    UdpChardev *s = UDP_CHARDEV(opaque);
+    UdpChardev *s = CHARDEV_UDP(opaque);
 
     s->max_size = qemu_chr_be_can_write(chr);
 
@@ -87,7 +87,7 @@ static int udp_chr_read_poll(void *opaque)
 static gboolean udp_chr_read(QIOChannel *chan, GIOCondition cond, void *opaque)
 {
     Chardev *chr = CHARDEV(opaque);
-    UdpChardev *s = UDP_CHARDEV(opaque);
+    UdpChardev *s = CHARDEV_UDP(opaque);
     ssize_t ret;
 
     if (s->max_size == 0) {
@@ -108,7 +108,7 @@ static gboolean udp_chr_read(QIOChannel *chan, GIOCondition cond, void *opaque)
 
 static void udp_chr_update_read_handler(Chardev *chr)
 {
-    UdpChardev *s = UDP_CHARDEV(chr);
+    UdpChardev *s = CHARDEV_UDP(chr);
 
     remove_fd_in_watch(chr);
     if (s->ioc) {
@@ -122,7 +122,7 @@ static void udp_chr_update_read_handler(Chardev *chr)
 static void char_udp_finalize(Object *obj)
 {
     Chardev *chr = CHARDEV(obj);
-    UdpChardev *s = UDP_CHARDEV(obj);
+    UdpChardev *s = CHARDEV_UDP(obj);
 
     remove_fd_in_watch(chr);
     if (s->ioc) {
@@ -200,7 +200,7 @@ static void qmp_chardev_open_udp(Chardev *chr,
     SocketAddress *remote_addr = socket_address_flatten(udp->remote);
     QIOChannelSocket *sioc = qio_channel_socket_new();
     char *name;
-    UdpChardev *s = UDP_CHARDEV(chr);
+    UdpChardev *s = CHARDEV_UDP(chr);
     int ret;
 
     ret = qio_channel_socket_dgram_sync(sioc, local_addr, remote_addr, errp);
-- 
2.26.2


