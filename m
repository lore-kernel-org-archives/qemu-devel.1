Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A881C04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 10:55:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57C3421773
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 10:55:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57C3421773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51332 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT2Qu-00019I-GI
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 06:55:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hT2P5-0008PX-8M
	for qemu-devel@nongnu.org; Tue, 21 May 2019 06:53:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hT2P3-0004TL-TA
	for qemu-devel@nongnu.org; Tue, 21 May 2019 06:53:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50694)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hT2P3-0004Sj-Lq
	for qemu-devel@nongnu.org; Tue, 21 May 2019 06:53:53 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 075443082B45;
	Tue, 21 May 2019 10:53:53 +0000 (UTC)
Received: from thuth.com (ovpn-116-22.ams2.redhat.com [10.36.116.22])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CB05F7841C;
	Tue, 21 May 2019 10:53:51 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Date: Tue, 21 May 2019 12:53:32 +0200
Message-Id: <20190521105344.11637-2-thuth@redhat.com>
In-Reply-To: <20190521105344.11637-1-thuth@redhat.com>
References: <20190521105344.11637-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Tue, 21 May 2019 10:53:53 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 01/13] tests/libqtest: Remove unused
 global_qtest-related wrapper functions
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, lvivier@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A bunch of the wrapper functions that use global_qtest are not used
anymore. Remove them to avoid that they are used in new code again.

Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20190510052239.21947-1-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/libqtest.c |  11 +----
 tests/libqtest.h | 108 -----------------------------------------------
 2 files changed, 1 insertion(+), 118 deletions(-)

diff --git a/tests/libqtest.c b/tests/libqtest.c
index c49b85482d..8ac0c02af4 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -1038,15 +1038,6 @@ QDict *qmp(const char *fmt, ...)
     return response;
 }
=20
-void qmp_send(const char *fmt, ...)
-{
-    va_list ap;
-
-    va_start(ap, fmt);
-    qtest_qmp_vsend(global_qtest, fmt, ap);
-    va_end(ap);
-}
-
 char *hmp(const char *fmt, ...)
 {
     va_list ap;
@@ -1232,7 +1223,7 @@ void qtest_qmp_device_del(const char *id)
                                     &got_event);
     qobject_unref(rsp);
     if (!got_event) {
-        rsp =3D qmp_receive();
+        rsp =3D qtest_qmp_receive(global_qtest);
         g_assert_cmpstr(qdict_get_try_str(rsp, "event"),
                         =3D=3D, "DEVICE_DELETED");
         qobject_unref(rsp);
diff --git a/tests/libqtest.h b/tests/libqtest.h
index a16acd58a6..3f7675fcf0 100644
--- a/tests/libqtest.h
+++ b/tests/libqtest.h
@@ -618,26 +618,6 @@ static inline void qtest_end(void)
  */
 QDict *qmp(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
=20
-/**
- * qmp_send:
- * @fmt...: QMP message to send to qemu, formatted like
- * qobject_from_jsonf_nofail().  See parse_escape() for what's
- * supported after '%'.
- *
- * Sends a QMP message to QEMU and leaves the response in the stream.
- */
-void qmp_send(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
-
-/**
- * qmp_receive:
- *
- * Reads a QMP message from QEMU and returns the response.
- */
-static inline QDict *qmp_receive(void)
-{
-    return qtest_qmp_receive(global_qtest);
-}
-
 /**
  * qmp_eventwait:
  * @s: #event event to wait for.
@@ -649,18 +629,6 @@ static inline void qmp_eventwait(const char *event)
     return qtest_qmp_eventwait(global_qtest, event);
 }
=20
-/**
- * qmp_eventwait_ref:
- * @s: #event event to wait for.
- *
- * Continuously polls for QMP responses until it receives the desired ev=
ent.
- * Returns a copy of the event for further investigation.
- */
-static inline QDict *qmp_eventwait_ref(const char *event)
-{
-    return qtest_qmp_eventwait_ref(global_qtest, event);
-}
-
 /**
  * hmp:
  * @fmt...: HMP command to send to QEMU, formats arguments like sprintf(=
).
@@ -682,30 +650,6 @@ static inline bool get_irq(int num)
     return qtest_get_irq(global_qtest, num);
 }
=20
-/**
- * irq_intercept_in:
- * @string: QOM path of a device.
- *
- * Associate qtest irqs with the GPIO-in pins of the device
- * whose path is specified by @string.
- */
-static inline void irq_intercept_in(const char *string)
-{
-    qtest_irq_intercept_in(global_qtest, string);
-}
-
-/**
- * qtest_irq_intercept_out:
- * @string: QOM path of a device.
- *
- * Associate qtest irqs with the GPIO-out pins of the device
- * whose path is specified by @string.
- */
-static inline void irq_intercept_out(const char *string)
-{
-    qtest_irq_intercept_out(global_qtest, string);
-}
-
 /**
  * outb:
  * @addr: I/O port to write to.
@@ -894,19 +838,6 @@ static inline void memread(uint64_t addr, void *data=
, size_t size)
     qtest_memread(global_qtest, addr, data, size);
 }
=20
-/**
- * bufread:
- * @addr: Guest address to read from.
- * @data: Pointer to where memory contents will be stored.
- * @size: Number of bytes to read.
- *
- * Read guest memory into a buffer, receive using a base64 encoding.
- */
-static inline void bufread(uint64_t addr, void *data, size_t size)
-{
-    qtest_bufread(global_qtest, addr, data, size);
-}
-
 /**
  * memwrite:
  * @addr: Guest address to write to.
@@ -920,32 +851,6 @@ static inline void memwrite(uint64_t addr, const voi=
d *data, size_t size)
     qtest_memwrite(global_qtest, addr, data, size);
 }
=20
-/**
- * bufwrite:
- * @addr: Guest address to write to.
- * @data: Pointer to the bytes that will be written to guest memory.
- * @size: Number of bytes to write.
- *
- * Write a buffer to guest memory, transmit using a base64 encoding.
- */
-static inline void bufwrite(uint64_t addr, const void *data, size_t size=
)
-{
-    qtest_bufwrite(global_qtest, addr, data, size);
-}
-
-/**
- * qmemset:
- * @addr: Guest address to write to.
- * @patt: Byte pattern to fill the guest memory region with.
- * @size: Number of bytes to write.
- *
- * Write a pattern to guest memory.
- */
-static inline void qmemset(uint64_t addr, uint8_t patt, size_t size)
-{
-    qtest_memset(global_qtest, addr, patt, size);
-}
-
 /**
  * clock_step_next:
  *
@@ -971,19 +876,6 @@ static inline int64_t clock_step(int64_t step)
     return qtest_clock_step(global_qtest, step);
 }
=20
-/**
- * clock_set:
- * @val: Nanoseconds value to advance the clock to.
- *
- * Advance the QEMU_CLOCK_VIRTUAL to @val nanoseconds since the VM was l=
aunched.
- *
- * Returns: The current value of the QEMU_CLOCK_VIRTUAL in nanoseconds.
- */
-static inline int64_t clock_set(int64_t val)
-{
-    return qtest_clock_set(global_qtest, val);
-}
-
 QDict *qmp_fd_receive(int fd);
 void qmp_fd_vsend(int fd, const char *fmt, va_list ap) GCC_FMT_ATTR(2, 0=
);
 void qmp_fd_send(int fd, const char *fmt, ...) GCC_FMT_ATTR(2, 3);
--=20
2.21.0


