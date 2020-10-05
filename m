Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB99C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 19:34:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B200207BC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 19:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D1NdLxM6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B200207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPWFI-0000L2-VW
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 15:34:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53044)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kPWE2-0007sY-U8
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 15:32:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55273)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kPWDu-0004nu-H3
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 15:32:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601926357;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=qbFTcWtCGm5ghUxZS2gJDasFaQNsc7NeWlf/qL/ARD8=;
 b=D1NdLxM6NsQ9SsJQE9HHo2thnjibVpA8DKGbcdjgysqx5Sd4DfBS8DP/L/eHWFjUiSB2EC
 eWdUnBjJqqA1erJ1W9pET6cGHgRM6/3IC4v0QdNpwPEr/PNMf5D4gANrMJFDzr+MXdkHAT
 UP8U/+b43AOYQnQUc06vNxb2iyfOmhE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-uUfGmvs0NMarTIn1ke6xdQ-1; Mon, 05 Oct 2020 15:32:35 -0400
X-MC-Unique: uUfGmvs0NMarTIn1ke6xdQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EFAB42FD01;
 Mon,  5 Oct 2020 19:32:33 +0000 (UTC)
Received: from localhost (ovpn-119-102.rdu2.redhat.com [10.10.119.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B357B7E731;
 Mon,  5 Oct 2020 19:32:33 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] docs/devel/clocks: Include API reference using kernel-doc
Date: Mon,  5 Oct 2020 15:32:32 -0400
Message-Id: <20201005193232.660906-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use kernel-doc to include clock API reference in
docs/devel/clocks.html.  A few small change had to be made in
clock.h and qdev-clock.h to use the kernel-doc syntax.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 docs/devel/clocks.rst   |  7 +++++++
 include/hw/clock.h      |  4 ++--
 include/hw/qdev-clock.h | 28 ++++++++++++++++++----------
 3 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/docs/devel/clocks.rst b/docs/devel/clocks.rst
index e5da28e2111..9a390ad5df9 100644
--- a/docs/devel/clocks.rst
+++ b/docs/devel/clocks.rst
@@ -389,3 +389,10 @@ state.
 Care should be taken not to use ``clock_update[_ns|_hz]()`` or
 ``clock_propagate()`` during the whole migration procedure because it
 will trigger side effects to other devices in an unknown state.
+
+
+API Reference
+-------------
+
+.. kernel-doc:: include/hw/clock.h
+.. kernel-doc:: include/hw/qdev-clock.h
diff --git a/include/hw/clock.h b/include/hw/clock.h
index d357594df99..ffe8e99930a 100644
--- a/include/hw/clock.h
+++ b/include/hw/clock.h
@@ -43,7 +43,7 @@ typedef void ClockCallback(void *opaque);
 #define CLOCK_PERIOD_TO_HZ(per) (((per) != 0) ? CLOCK_PERIOD_1SEC / (per) : 0u)
 
 /**
- * Clock:
+ * struct Clock:
  * @parent_obj: parent class
  * @period: unsigned integer representing the period of the clock
  * @canonical_path: clock path string cache (used for trace purpose)
@@ -56,7 +56,7 @@ typedef void ClockCallback(void *opaque);
 
 
 struct Clock {
-    /*< private >*/
+    /* private: */
     Object parent_obj;
 
     /* all fields are private and should not be modified directly */
diff --git a/include/hw/qdev-clock.h b/include/hw/qdev-clock.h
index 64ca4d266f2..3a00f798cab 100644
--- a/include/hw/qdev-clock.h
+++ b/include/hw/qdev-clock.h
@@ -22,7 +22,7 @@
  * @name: the name of the clock (can't be NULL).
  * @callback: optional callback to be called on update or NULL.
  * @opaque: argument for the callback
- * @returns: a pointer to the newly added clock
+ * @return: a pointer to the newly added clock
  *
  * Add an input clock to device @dev as a clock named @name.
  * This adds a child<> property.
@@ -35,7 +35,7 @@ Clock *qdev_init_clock_in(DeviceState *dev, const char *name,
  * qdev_init_clock_out:
  * @dev: the device to add an output clock to
  * @name: the name of the clock (can't be NULL).
- * @returns: a pointer to the newly added clock
+ * @return: a pointer to the newly added clock
  *
  * Add an output clock to device @dev as a clock named @name.
  * This adds a child<> property.
@@ -46,7 +46,7 @@ Clock *qdev_init_clock_out(DeviceState *dev, const char *name);
  * qdev_get_clock_in:
  * @dev: the device which has the clock
  * @name: the name of the clock (can't be NULL).
- * @returns: a pointer to the clock
+ * @return: a pointer to the clock
  *
  * Get the input clock @name from @dev or NULL if does not exist.
  */
@@ -56,7 +56,7 @@ Clock *qdev_get_clock_in(DeviceState *dev, const char *name);
  * qdev_get_clock_out:
  * @dev: the device which has the clock
  * @name: the name of the clock (can't be NULL).
- * @returns: a pointer to the clock
+ * @return: a pointer to the clock
  *
  * Get the output clock @name from @dev or NULL if does not exist.
  */
@@ -81,7 +81,7 @@ void qdev_connect_clock_in(DeviceState *dev, const char *name, Clock *source);
  * @name: the name of the clock in @dev (can't be NULL)
  * @alias_dev: the device to add the clock
  * @alias_name: the name of the clock in @container
- * @returns: a pointer to the clock
+ * @return: a pointer to the clock
  *
  * Add a clock @alias_name in @alias_dev which is an alias of the clock @name
  * in @dev. The direction _in_ or _out_ will the same as the original.
@@ -100,9 +100,9 @@ Clock *qdev_alias_clock(DeviceState *dev, const char *name,
 void qdev_finalize_clocklist(DeviceState *dev);
 
 /**
- * ClockPortInitElem:
+ * struct ClockPortInitElem:
  * @name: name of the clock (can't be NULL)
- * @output: indicates whether the clock is input or output
+ * @is_output: indicates whether the clock is input or output
  * @callback: for inputs, optional callback to be called on clock's update
  * with device as opaque
  * @offset: optional offset to store the ClockIn or ClockOut pointer in device
@@ -127,11 +127,11 @@ struct ClockPortInitElem {
 }
 
 /**
- * QDEV_CLOCK_(IN|OUT):
+ * QDEV_CLOCK_IN:
  * @devstate: structure type. @dev argument of qdev_init_clocks below must be
  * a pointer to that same type.
- * @field: a field in @_devstate (must be Clock*)
- * @callback: (for input only) callback (or NULL) to be called with the device
+ * @field: a field in @devstate (must be Clock*)
+ * @callback: callback (or NULL) to be called with the device
  * state as argument
  *
  * The name of the clock will be derived from @field
@@ -139,6 +139,14 @@ struct ClockPortInitElem {
 #define QDEV_CLOCK_IN(devstate, field, callback) \
     QDEV_CLOCK(false, devstate, field, callback)
 
+/**
+ * QDEV_CLOCK_OUT:
+ * @devstate: structure type. @dev argument of qdev_init_clocks below must be
+ * a pointer to that same type.
+ * @field: a field in @devstate (must be Clock*)
+ *
+ * The name of the clock will be derived from @field
+ */
 #define QDEV_CLOCK_OUT(devstate, field) \
     QDEV_CLOCK(true, devstate, field, NULL)
 
-- 
2.26.2


