Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C21C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 19:52:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 169A4208E4
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 19:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NJjOPZv1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 169A4208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGSc3-000081-23
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 15:52:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54298)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kGSa2-0004jf-BK
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 15:50:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49453)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kGSZz-0000cF-TH
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 15:50:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599767398;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/DVmnWXbjfp4IFN03k1SQobCGFF9J4I2dpJoYqkax8Q=;
 b=NJjOPZv19b44s/AWelyUM3CI5yaucVQa+uflWx5O2jjB/eZg7PiKz1N6ivHHAW/dNS/T+8
 Ed6bS+5iS9rhYaLjZuX0TrRIBPrwm6wWyuS/toJLh42C/DL7LbupcNlVkSXy/xPM/id+5l
 VjL7BeKhdiorLSFEck2BoIpOJmla79U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-3Fb4d7tGM_a1Wwq9NuLMLg-1; Thu, 10 Sep 2020 15:49:57 -0400
X-MC-Unique: 3Fb4d7tGM_a1Wwq9NuLMLg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1DA958CCC24;
 Thu, 10 Sep 2020 19:49:56 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4090819C4F;
 Thu, 10 Sep 2020 19:49:50 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/18] chardev: Rename PARALLEL_CHARDEV to CHARDEV_PARALLEL
Date: Thu, 10 Sep 2020 15:48:53 -0400
Message-Id: <20200910194903.4104696-9-ehabkost@redhat.com>
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
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 08:38:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
 chardev/char-parallel.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/chardev/char-parallel.c b/chardev/char-parallel.c
index 3d670bcb1d..7ab19339c7 100644
--- a/chardev/char-parallel.c
+++ b/chardev/char-parallel.c
@@ -48,7 +48,7 @@
 #include "chardev/char-parallel.h"
 
 typedef struct ParallelChardev ParallelChardev;
-DECLARE_INSTANCE_CHECKER(ParallelChardev, PARALLEL_CHARDEV,
+DECLARE_INSTANCE_CHECKER(ParallelChardev, CHARDEV_PARALLEL,
                          TYPE_CHARDEV_PARALLEL)
 
 #if defined(__linux__)
@@ -73,7 +73,7 @@ static int pp_hw_mode(ParallelChardev *s, uint16_t mode)
 
 static int pp_ioctl(Chardev *chr, int cmd, void *arg)
 {
-    ParallelChardev *drv = PARALLEL_CHARDEV(chr);
+    ParallelChardev *drv = CHARDEV_PARALLEL(chr);
     int fd = drv->fd;
     uint8_t b;
 
@@ -163,7 +163,7 @@ static void qemu_chr_open_pp_fd(Chardev *chr,
                                 bool *be_opened,
                                 Error **errp)
 {
-    ParallelChardev *drv = PARALLEL_CHARDEV(chr);
+    ParallelChardev *drv = CHARDEV_PARALLEL(chr);
 
     if (ioctl(fd, PPCLAIM) < 0) {
         error_setg_errno(errp, errno, "not a parallel port");
@@ -185,7 +185,7 @@ struct ParallelChardev {
 
 static int pp_ioctl(Chardev *chr, int cmd, void *arg)
 {
-    ParallelChardev *drv = PARALLEL_CHARDEV(chr);
+    ParallelChardev *drv = CHARDEV_PARALLEL(chr);
     uint8_t b;
 
     switch (cmd) {
@@ -230,7 +230,7 @@ static void qemu_chr_open_pp_fd(Chardev *chr,
                                 bool *be_opened,
                                 Error **errp)
 {
-    ParallelChardev *drv = PARALLEL_CHARDEV(chr);
+    ParallelChardev *drv = CHARDEV_PARALLEL(chr);
     drv->fd = fd;
     *be_opened = false;
 }
@@ -286,7 +286,7 @@ static void char_parallel_finalize(Object *obj)
 {
 #if defined(__linux__)
     Chardev *chr = CHARDEV(obj);
-    ParallelChardev *drv = PARALLEL_CHARDEV(chr);
+    ParallelChardev *drv = CHARDEV_PARALLEL(chr);
     int fd = drv->fd;
 
     pp_hw_mode(drv, IEEE1284_MODE_COMPAT);
-- 
2.26.2


