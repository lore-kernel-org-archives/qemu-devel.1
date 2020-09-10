Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 420E4C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 19:55:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB73A2076D
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 19:55:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Du8jIMZj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB73A2076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGSfK-0006wC-1b
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 15:55:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54316)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kGSa4-0004oc-0G
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 15:50:04 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45005
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kGSa2-0000ca-7m
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 15:50:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599767401;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yDSkuYKlOtfIM7UvBv7kRTHyikTp8v/R6T39bDeWySg=;
 b=Du8jIMZjQDGX1yNgwj/OsqnYA36opPfIPl+CUCfurhioFwkiNGoBTvvKHgd6ke/m/2TQTY
 IYMEdFrvXPotzxRjj6u09iWSV0hK6b22ZoBNG5uxohTV4X4GqEdb04OtZ21/OsCbE5HxDM
 qrO6fm0mu38zcQil6pByTzOPwBfgugg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-sFCDlwQJP2qq1JRLs-_UhA-1; Thu, 10 Sep 2020 15:49:59 -0400
X-MC-Unique: sFCDlwQJP2qq1JRLs-_UhA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 741148CCC31;
 Thu, 10 Sep 2020 19:49:58 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3B3C719C66;
 Thu, 10 Sep 2020 19:49:58 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/18] chardev: Rename RINGBUF_CHARDEV to CHARDEV_RINGBUF
Date: Thu, 10 Sep 2020 15:48:55 -0400
Message-Id: <20200910194903.4104696-11-ehabkost@redhat.com>
In-Reply-To: <20200910194903.4104696-1-ehabkost@redhat.com>
References: <20200910194903.4104696-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 08:38:09
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
 chardev/char-ringbuf.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/chardev/char-ringbuf.c b/chardev/char-ringbuf.c
index d40d21d3cf..8d2916cd78 100644
--- a/chardev/char-ringbuf.c
+++ b/chardev/char-ringbuf.c
@@ -42,19 +42,19 @@ struct RingBufChardev {
 };
 typedef struct RingBufChardev RingBufChardev;
 
-DECLARE_INSTANCE_CHECKER(RingBufChardev, RINGBUF_CHARDEV,
+DECLARE_INSTANCE_CHECKER(RingBufChardev, CHARDEV_RINGBUF,
                          TYPE_CHARDEV_RINGBUF)
 
 static size_t ringbuf_count(const Chardev *chr)
 {
-    const RingBufChardev *d = RINGBUF_CHARDEV(chr);
+    const RingBufChardev *d = CHARDEV_RINGBUF(chr);
 
     return d->prod - d->cons;
 }
 
 static int ringbuf_chr_write(Chardev *chr, const uint8_t *buf, int len)
 {
-    RingBufChardev *d = RINGBUF_CHARDEV(chr);
+    RingBufChardev *d = CHARDEV_RINGBUF(chr);
     int i;
 
     if (!buf || (len < 0)) {
@@ -73,7 +73,7 @@ static int ringbuf_chr_write(Chardev *chr, const uint8_t *buf, int len)
 
 static int ringbuf_chr_read(Chardev *chr, uint8_t *buf, int len)
 {
-    RingBufChardev *d = RINGBUF_CHARDEV(chr);
+    RingBufChardev *d = CHARDEV_RINGBUF(chr);
     int i;
 
     qemu_mutex_lock(&chr->chr_write_lock);
@@ -87,7 +87,7 @@ static int ringbuf_chr_read(Chardev *chr, uint8_t *buf, int len)
 
 static void char_ringbuf_finalize(Object *obj)
 {
-    RingBufChardev *d = RINGBUF_CHARDEV(obj);
+    RingBufChardev *d = CHARDEV_RINGBUF(obj);
 
     g_free(d->cbuf);
 }
@@ -98,7 +98,7 @@ static void qemu_chr_open_ringbuf(Chardev *chr,
                                   Error **errp)
 {
     ChardevRingbuf *opts = backend->u.ringbuf.data;
-    RingBufChardev *d = RINGBUF_CHARDEV(chr);
+    RingBufChardev *d = CHARDEV_RINGBUF(chr);
 
     d->size = opts->has_size ? opts->size : 65536;
 
-- 
2.26.2


