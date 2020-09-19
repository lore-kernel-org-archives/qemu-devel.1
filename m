Return-Path: <SRS0=MBD3=C4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E57CFC43464
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 16:18:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 719D2208DB
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 16:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UkkHrweJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 719D2208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJfZG-0002x2-Eo
	for qemu-devel@archiver.kernel.org; Sat, 19 Sep 2020 12:18:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51386)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kJfHB-0005Qn-5d
 for qemu-devel@nongnu.org; Sat, 19 Sep 2020 11:59:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60001)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kJfH3-0007O6-PR
 for qemu-devel@nongnu.org; Sat, 19 Sep 2020 11:59:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600531181;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EPROH+rhHGc+CfF7H9/smITvRehkFbJS47wGwzU6KXY=;
 b=UkkHrweJPsPLHG2ivj6MWgI6QnA3zzMW3q+++lnZTvTatldNraUSATdavqvu0EidpO7gEG
 W2CRjwbpfz1YyNZCd1pYlaAjLpYzpfAy105ykLS5U26lIN/G6Lo6kTMhZkWBttwggLBReU
 DcO3coi7DCTMpHh2zJYREMnnngE1xcc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-2ThxMioMN_a0qWOHE6wnVQ-1; Sat, 19 Sep 2020 11:59:38 -0400
X-MC-Unique: 2ThxMioMN_a0qWOHE6wnVQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D67A088EF00;
 Sat, 19 Sep 2020 15:59:37 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8768360C84;
 Sat, 19 Sep 2020 15:59:37 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 23/57] hw/char/serial: Remove old DEBUG_SERIAL commented code
Date: Sat, 19 Sep 2020 11:58:42 -0400
Message-Id: <20200919155916.1046398-24-pbonzini@redhat.com>
In-Reply-To: <20200919155916.1046398-1-pbonzini@redhat.com>
References: <20200919155916.1046398-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/19 11:03:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

All useful DPRINTF() calls have been converted to trace
events.  Remove a pointless one in the IOEventHandler,
and drop the DEBUG_SERIAL ifdef'ry.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20200907015535.827885-4-f4bug@amsat.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/char/serial.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/hw/char/serial.c b/hw/char/serial.c
index e8029f840a..26f7fa8a21 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -36,8 +36,6 @@
 #include "trace.h"
 #include "hw/qdev-properties.h"
 
-//#define DEBUG_SERIAL
-
 #define UART_LCR_DLAB	0x80	/* Divisor latch access bit */
 
 #define UART_IER_MSI	0x08	/* Enable Modem status interrupt */
@@ -102,14 +100,6 @@
 
 #define MAX_XMIT_RETRY      4
 
-#ifdef DEBUG_SERIAL
-#define DPRINTF(fmt, ...) \
-do { fprintf(stderr, "serial: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) \
-do {} while (0)
-#endif
-
 static void serial_receive1(void *opaque, const uint8_t *buf, int size);
 static void serial_xmit(SerialState *s);
 
@@ -636,7 +626,6 @@ static void serial_receive1(void *opaque, const uint8_t *buf, int size)
 static void serial_event(void *opaque, QEMUChrEvent event)
 {
     SerialState *s = opaque;
-    DPRINTF("event %x\n", event);
     if (event == CHR_EVENT_BREAK)
         serial_receive_break(s);
 }
-- 
2.26.2



