Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,WEIRD_QUOTING autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9831C47095
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 20:54:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3105E2078E
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 20:54:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gHebiPwQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3105E2078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPXVB-0003Iu-3B
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 16:54:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40602)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kPXTM-0001Vv-Ak
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 16:52:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29296)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kPXTK-0005pV-Hx
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 16:52:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601931157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wVQsFC/6CHovH8ATZVlcErcvtcUa1Ob5fQfvHRinQcI=;
 b=gHebiPwQ8owwQiDh0byB2Z15z7EX0jPx+WdgoZj4fBJnaA1KQ2fapQmu+lg2LdIUWFcu1P
 EF1XT9W6uIHXaQPTWil/CxhIWf0eAHmfrFVbhMcdPvLeh3wW/DBVLFXzwIvlw3doKeXMn8
 zPcMlS2A9lCtzcPo8g96ARiMYhviooA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-faz0S_b8Pwi1uWGzbbzbag-1; Mon, 05 Oct 2020 16:52:36 -0400
X-MC-Unique: faz0S_b8Pwi1uWGzbbzbag-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 65FEA925C46
 for <qemu-devel@nongnu.org>; Mon,  5 Oct 2020 20:52:35 +0000 (UTC)
Received: from localhost (ovpn-119-102.rdu2.redhat.com [10.10.119.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2925618E3C;
 Mon,  5 Oct 2020 20:52:35 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/3] docs/devel/qtest: Include protocol spec in document
Date: Mon,  5 Oct 2020 16:52:27 -0400
Message-Id: <20201005205228.697463-3-ehabkost@redhat.com>
In-Reply-To: <20201005205228.697463-1-ehabkost@redhat.com>
References: <20201005205228.697463-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 02:11:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Include the QTest Protocol doc string in docs/devel/qtest.rst,
after converting it to use Sphinx syntax.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 docs/devel/qtest.rst | 12 ++++++--
 softmmu/qtest.c      | 73 +++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 75 insertions(+), 10 deletions(-)

diff --git a/docs/devel/qtest.rst b/docs/devel/qtest.rst
index 86dec84a0ba..3bf9ebee7f0 100644
--- a/docs/devel/qtest.rst
+++ b/docs/devel/qtest.rst
@@ -4,8 +4,8 @@ QTest Device Emulation Testing Framework
 
 QTest is a device emulation testing framework.  It can be very useful to test
 device models; it could also control certain aspects of QEMU (such as virtual
-clock stepping), with a special purpose "qtest" protocol.  Refer to the
-documentation in ``qtest.c`` for more details of the protocol.
+clock stepping), with a special purpose "qtest" protocol.  Refer to
+:ref:`qtest-protocol` for more details of the protocol.
 
 QTest cases can be executed with
 
@@ -56,3 +56,11 @@ from the output of
 
 which you can run manually.
 
+
+.. _qtest-protocol:
+
+QTest Protocol
+--------------
+
+.. kernel-doc:: softmmu/qtest.c
+   :doc: QTest Protocol
diff --git a/softmmu/qtest.c b/softmmu/qtest.c
index 4e439caec7e..9382fd25439 100644
--- a/softmmu/qtest.c
+++ b/softmmu/qtest.c
@@ -49,92 +49,141 @@ static void *qtest_server_send_opaque;
 #define FMT_timeval "%ld.%06ld"
 
 /**
- * QTest Protocol
+ * DOC: QTest Protocol
+ *
+ * .. highlight:: none
  *
  * Line based protocol, request/response based.  Server can send async messages
  * so clients should always handle many async messages before the response
  * comes in.
  *
  * Valid requests
+ * ^^^^^^^^^^^^^^
  *
  * Clock management:
+ * """""""""""""""""
  *
  * The qtest client is completely in charge of the QEMU_CLOCK_VIRTUAL.  qtest commands
  * let you adjust the value of the clock (monotonically).  All the commands
  * return the current value of the clock in nanoseconds.
  *
+ * .. code-block::
+ *
  *  > clock_step
  *  < OK VALUE
  *
- *     Advance the clock to the next deadline.  Useful when waiting for
- *     asynchronous events.
+ * Advance the clock to the next deadline.  Useful when waiting for
+ * asynchronous events.
+ *
+ * .. code-block::
  *
  *  > clock_step NS
  *  < OK VALUE
  *
- *     Advance the clock by NS nanoseconds.
+ * Advance the clock by NS nanoseconds.
+ *
+ * .. code-block::
  *
  *  > clock_set NS
  *  < OK VALUE
  *
- *     Advance the clock to NS nanoseconds (do nothing if it's already past).
+ * Advance the clock to NS nanoseconds (do nothing if it's already past).
  *
  * PIO and memory access:
+ * """"""""""""""""""""""
+ *
+ * .. code-block::
  *
  *  > outb ADDR VALUE
  *  < OK
  *
+ * .. code-block::
+ *
  *  > outw ADDR VALUE
  *  < OK
  *
+ * .. code-block::
+ *
  *  > outl ADDR VALUE
  *  < OK
  *
+ * .. code-block::
+ *
  *  > inb ADDR
  *  < OK VALUE
  *
+ * .. code-block::
+ *
  *  > inw ADDR
  *  < OK VALUE
  *
+ * .. code-block::
+ *
  *  > inl ADDR
  *  < OK VALUE
  *
+ * .. code-block::
+ *
  *  > writeb ADDR VALUE
  *  < OK
  *
+ * .. code-block::
+ *
  *  > writew ADDR VALUE
  *  < OK
  *
+ * .. code-block::
+ *
  *  > writel ADDR VALUE
  *  < OK
  *
+ * .. code-block::
+ *
  *  > writeq ADDR VALUE
  *  < OK
  *
+ * .. code-block::
+ *
  *  > readb ADDR
  *  < OK VALUE
  *
+ * .. code-block::
+ *
  *  > readw ADDR
  *  < OK VALUE
  *
+ * .. code-block::
+ *
  *  > readl ADDR
  *  < OK VALUE
  *
+ * .. code-block::
+ *
  *  > readq ADDR
  *  < OK VALUE
  *
+ * .. code-block::
+ *
  *  > read ADDR SIZE
  *  < OK DATA
  *
+ * .. code-block::
+ *
  *  > write ADDR SIZE DATA
  *  < OK
  *
+ * .. code-block::
+ *
  *  > b64read ADDR SIZE
  *  < OK B64_DATA
  *
+ * .. code-block::
+ *
  *  > b64write ADDR SIZE B64_DATA
  *  < OK
  *
+ * .. code-block::
+ *
  *  > memset ADDR SIZE VALUE
  *  < OK
  *
@@ -149,16 +198,21 @@ static void *qtest_server_send_opaque;
  * If the sizes do not match, the data will be truncated.
  *
  * IRQ management:
+ * """""""""""""""
+ *
+ * .. code-block::
  *
  *  > irq_intercept_in QOM-PATH
  *  < OK
  *
+ * .. code-block::
+ *
  *  > irq_intercept_out QOM-PATH
  *  < OK
  *
  * Attach to the gpio-in (resp. gpio-out) pins exported by the device at
  * QOM-PATH.  When the pin is triggered, one of the following async messages
- * will be printed to the qtest stream:
+ * will be printed to the qtest stream::
  *
  *  IRQ raise NUM
  *  IRQ lower NUM
@@ -168,12 +222,15 @@ static void *qtest_server_send_opaque;
  * NUM=0 even though it is remapped to GSI 2).
  *
  * Setting interrupt level:
+ * """"""""""""""""""""""""
+ *
+ * .. code-block::
  *
  *  > set_irq_in QOM-PATH NAME NUM LEVEL
  *  < OK
  *
- *  where NAME is the name of the irq/gpio list, NUM is an IRQ number and
- *  LEVEL is an signed integer IRQ level.
+ * where NAME is the name of the irq/gpio list, NUM is an IRQ number and
+ * LEVEL is an signed integer IRQ level.
  *
  * Forcibly set the given interrupt pin to the given level.
  *
-- 
2.26.2


