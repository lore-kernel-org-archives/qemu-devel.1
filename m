Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,WEIRD_QUOTING autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D2C3C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 20:38:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13D48208D5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 20:38:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rbekj5CI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13D48208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS4ac-0000o1-7X
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 16:38:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38070)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kS4WD-0002kk-2i
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 16:34:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45934)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kS4WB-0002fe-4r
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 16:34:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602534842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aQvkge0tNZd5H2eAWDkXPTFRir9tCSRBEj2P2UjR8r8=;
 b=Rbekj5CI7OnFao/eoHoFyqnREdYNV4cKn9TKMQ8gylzRrrw3Afyr/HbVEE4Xtq7+tDNVhB
 NSpNq+FHOgppGD21oDXAOTva/vl/Nx/8UPAYTCH3CWeY2YmYVUrR6oFOsVZCSGbfDcC4KI
 miH5bNSx6n9GXrKcDjRv8Rpl3AQcBco=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-E1IJC_hKNES5PTDXLen9fA-1; Mon, 12 Oct 2020 16:34:01 -0400
X-MC-Unique: E1IJC_hKNES5PTDXLen9fA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DDF6488C784
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 20:33:51 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 893725D9CD;
 Mon, 12 Oct 2020 20:33:51 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 15/38] docs/devel/qtest: Include protocol spec in document
Date: Mon, 12 Oct 2020 16:33:20 -0400
Message-Id: <20201012203343.1105018-16-pbonzini@redhat.com>
In-Reply-To: <20201012203343.1105018-1-pbonzini@redhat.com>
References: <20201012203343.1105018-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/11 23:52:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eduardo Habkost <ehabkost@redhat.com>

Include the QTest Protocol doc string in docs/devel/qtest.rst,
after converting it to use Sphinx syntax.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Acked-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20201005205228.697463-3-ehabkost@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/qtest.rst | 12 ++++++--
 softmmu/qtest.c      | 71 +++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 73 insertions(+), 10 deletions(-)

diff --git a/docs/devel/qtest.rst b/docs/devel/qtest.rst
index 86dec84a0b..3bf9ebee7f 100644
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
index 0d43cf8883..2c6e8dc858 100644
--- a/softmmu/qtest.c
+++ b/softmmu/qtest.c
@@ -49,92 +49,139 @@ static void *qtest_server_send_opaque;
 #define FMT_timeval "%ld.%06ld"
 
 /**
- * QTest Protocol
+ * DOC: QTest Protocol
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
+ * .. code-block:: none
+ *
  *  > clock_step
  *  < OK VALUE
  *
- *     Advance the clock to the next deadline.  Useful when waiting for
- *     asynchronous events.
+ * Advance the clock to the next deadline.  Useful when waiting for
+ * asynchronous events.
+ *
+ * .. code-block:: none
  *
  *  > clock_step NS
  *  < OK VALUE
  *
- *     Advance the clock by NS nanoseconds.
+ * Advance the clock by NS nanoseconds.
+ *
+ * .. code-block:: none
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
+ * .. code-block:: none
  *
  *  > outb ADDR VALUE
  *  < OK
  *
+ * .. code-block:: none
+ *
  *  > outw ADDR VALUE
  *  < OK
  *
+ * .. code-block:: none
+ *
  *  > outl ADDR VALUE
  *  < OK
  *
+ * .. code-block:: none
+ *
  *  > inb ADDR
  *  < OK VALUE
  *
+ * .. code-block:: none
+ *
  *  > inw ADDR
  *  < OK VALUE
  *
+ * .. code-block:: none
+ *
  *  > inl ADDR
  *  < OK VALUE
  *
+ * .. code-block:: none
+ *
  *  > writeb ADDR VALUE
  *  < OK
  *
+ * .. code-block:: none
+ *
  *  > writew ADDR VALUE
  *  < OK
  *
+ * .. code-block:: none
+ *
  *  > writel ADDR VALUE
  *  < OK
  *
+ * .. code-block:: none
+ *
  *  > writeq ADDR VALUE
  *  < OK
  *
+ * .. code-block:: none
+ *
  *  > readb ADDR
  *  < OK VALUE
  *
+ * .. code-block:: none
+ *
  *  > readw ADDR
  *  < OK VALUE
  *
+ * .. code-block:: none
+ *
  *  > readl ADDR
  *  < OK VALUE
  *
+ * .. code-block:: none
+ *
  *  > readq ADDR
  *  < OK VALUE
  *
+ * .. code-block:: none
+ *
  *  > read ADDR SIZE
  *  < OK DATA
  *
+ * .. code-block:: none
+ *
  *  > write ADDR SIZE DATA
  *  < OK
  *
+ * .. code-block:: none
+ *
  *  > b64read ADDR SIZE
  *  < OK B64_DATA
  *
+ * .. code-block:: none
+ *
  *  > b64write ADDR SIZE B64_DATA
  *  < OK
  *
+ * .. code-block:: none
+ *
  *  > memset ADDR SIZE VALUE
  *  < OK
  *
@@ -149,16 +196,21 @@ static void *qtest_server_send_opaque;
  * If the sizes do not match, the data will be truncated.
  *
  * IRQ management:
+ * """""""""""""""
+ *
+ * .. code-block:: none
  *
  *  > irq_intercept_in QOM-PATH
  *  < OK
  *
+ * .. code-block:: none
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
@@ -168,12 +220,15 @@ static void *qtest_server_send_opaque;
  * NUM=0 even though it is remapped to GSI 2).
  *
  * Setting interrupt level:
+ * """"""""""""""""""""""""
+ *
+ * .. code-block:: none
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



