Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99489C282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 08:54:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 586A220883
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 08:54:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 586A220883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37662 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDmWc-00056G-II
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 04:54:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hDmV2-00043c-Dv
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 04:53:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hDmV0-0002td-UC
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 04:53:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51448)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>)
	id 1hDmUx-0002rr-NO; Tue, 09 Apr 2019 04:52:55 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0DC23F74CF;
	Tue,  9 Apr 2019 08:52:55 +0000 (UTC)
Received: from thuth.com (ovpn-116-133.ams2.redhat.com [10.36.116.133])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 09F051A917;
	Tue,  9 Apr 2019 08:52:52 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue,  9 Apr 2019 10:52:41 +0200
Message-Id: <20190409085245.31548-2-thuth@redhat.com>
In-Reply-To: <20190409085245.31548-1-thuth@redhat.com>
References: <20190409085245.31548-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Tue, 09 Apr 2019 08:52:55 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH for-4.1 1/5] tests/tco: Make test independent
 of global_qtest
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
Cc: lvivier@redhat.com, Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
	armbru@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	Hannes Reinecke <hare@suse.com>, Paolo Bonzini <pbonzini@redhat.com>,
	John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190409085241.TSYQ0CVfnEsJtUwAdmBkN1ZM3B14dxmqzYuf9kYIrOs@z>

Pass around the QTestState in the TestData, so we do not need the
global_qtest variable here anymore.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/tco-test.c | 63 ++++++++++++++++++++++++------------------------
 1 file changed, 32 insertions(+), 31 deletions(-)

diff --git a/tests/tco-test.c b/tests/tco-test.c
index f89a42cdcc..254f735370 100644
--- a/tests/tco-test.c
+++ b/tests/tco-test.c
@@ -45,13 +45,14 @@ typedef struct {
     QPCIDevice *dev;
     QPCIBar tco_io_bar;
     QPCIBus *bus;
+    QTestState *qts;
 } TestData;
=20
 static void test_end(TestData *d)
 {
     g_free(d->dev);
     qpci_free_pc(d->bus);
-    qtest_end();
+    qtest_quit(d->qts);
 }
=20
 static void test_init(TestData *d)
@@ -61,7 +62,6 @@ static void test_init(TestData *d)
     qs =3D qtest_initf("-machine q35 %s %s",
                      d->noreboot ? "" : "-global ICH9-LPC.noreboot=3Dfal=
se",
                      !d->args ? "" : d->args);
-    global_qtest =3D qs;
     qtest_irq_intercept_in(qs, "ioapic");
=20
     d->bus =3D qpci_new_pc(qs, NULL);
@@ -78,6 +78,7 @@ static void test_init(TestData *d)
     qpci_config_writel(d->dev, ICH9_LPC_RCBA, RCBA_BASE_ADDR | 0x1);
=20
     d->tco_io_bar =3D qpci_legacy_iomap(d->dev, PM_IO_BASE_ADDR + 0x60);
+    d->qts =3D qs;
 }
=20
 static void stop_tco(const TestData *d)
@@ -115,17 +116,17 @@ static void clear_tco_status(const TestData *d)
     qpci_io_writew(d->dev, d->tco_io_bar, TCO2_STS, 0x0004);
 }
=20
-static void reset_on_second_timeout(bool enable)
+static void reset_on_second_timeout(const TestData *td, bool enable)
 {
     uint32_t val;
=20
-    val =3D readl(RCBA_BASE_ADDR + ICH9_CC_GCS);
+    val =3D qtest_readl(td->qts, RCBA_BASE_ADDR + ICH9_CC_GCS);
     if (enable) {
         val &=3D ~ICH9_CC_GCS_NO_REBOOT;
     } else {
         val |=3D ICH9_CC_GCS_NO_REBOOT;
     }
-    writel(RCBA_BASE_ADDR + ICH9_CC_GCS, val);
+    qtest_writel(td->qts, RCBA_BASE_ADDR + ICH9_CC_GCS, val);
 }
=20
 static void test_tco_defaults(void)
@@ -171,11 +172,11 @@ static void test_tco_timeout(void)
=20
     stop_tco(&d);
     clear_tco_status(&d);
-    reset_on_second_timeout(false);
+    reset_on_second_timeout(&d, false);
     set_tco_timeout(&d, ticks);
     load_tco(&d);
     start_tco(&d);
-    clock_step(ticks * TCO_TICK_NSEC);
+    qtest_clock_step(d.qts, ticks * TCO_TICK_NSEC);
=20
     /* test first timeout */
     val =3D qpci_io_readw(d.dev, d.tco_io_bar, TCO1_STS);
@@ -190,7 +191,7 @@ static void test_tco_timeout(void)
     g_assert(ret =3D=3D 0);
=20
     /* test second timeout */
-    clock_step(ticks * TCO_TICK_NSEC);
+    qtest_clock_step(d.qts, ticks * TCO_TICK_NSEC);
     val =3D qpci_io_readw(d.dev, d.tco_io_bar, TCO1_STS);
     ret =3D val & TCO_TIMEOUT ? 1 : 0;
     g_assert(ret =3D=3D 1);
@@ -215,18 +216,18 @@ static void test_tco_max_timeout(void)
=20
     stop_tco(&d);
     clear_tco_status(&d);
-    reset_on_second_timeout(false);
+    reset_on_second_timeout(&d, false);
     set_tco_timeout(&d, ticks);
     load_tco(&d);
     start_tco(&d);
-    clock_step(((ticks & TCO_TMR_MASK) - 1) * TCO_TICK_NSEC);
+    qtest_clock_step(d.qts, ((ticks & TCO_TMR_MASK) - 1) * TCO_TICK_NSEC=
);
=20
     val =3D qpci_io_readw(d.dev, d.tco_io_bar, TCO_RLD);
     g_assert_cmpint(val & TCO_RLD_MASK, =3D=3D, 1);
     val =3D qpci_io_readw(d.dev, d.tco_io_bar, TCO1_STS);
     ret =3D val & TCO_TIMEOUT ? 1 : 0;
     g_assert(ret =3D=3D 0);
-    clock_step(TCO_TICK_NSEC);
+    qtest_clock_step(d.qts, TCO_TICK_NSEC);
     val =3D qpci_io_readw(d.dev, d.tco_io_bar, TCO1_STS);
     ret =3D val & TCO_TIMEOUT ? 1 : 0;
     g_assert(ret =3D=3D 1);
@@ -235,9 +236,9 @@ static void test_tco_max_timeout(void)
     test_end(&d);
 }
=20
-static QDict *get_watchdog_action(void)
+static QDict *get_watchdog_action(const TestData *td)
 {
-    QDict *ev =3D qmp_eventwait_ref("WATCHDOG");
+    QDict *ev =3D qtest_qmp_eventwait_ref(td->qts, "WATCHDOG");
     QDict *data;
=20
     data =3D qdict_get_qdict(ev, "data");
@@ -258,12 +259,12 @@ static void test_tco_second_timeout_pause(void)
=20
     stop_tco(&td);
     clear_tco_status(&td);
-    reset_on_second_timeout(true);
+    reset_on_second_timeout(&td, true);
     set_tco_timeout(&td, TCO_SECS_TO_TICKS(16));
     load_tco(&td);
     start_tco(&td);
-    clock_step(ticks * TCO_TICK_NSEC * 2);
-    ad =3D get_watchdog_action();
+    qtest_clock_step(td.qts, ticks * TCO_TICK_NSEC * 2);
+    ad =3D get_watchdog_action(&td);
     g_assert(!strcmp(qdict_get_str(ad, "action"), "pause"));
     qobject_unref(ad);
=20
@@ -283,12 +284,12 @@ static void test_tco_second_timeout_reset(void)
=20
     stop_tco(&td);
     clear_tco_status(&td);
-    reset_on_second_timeout(true);
+    reset_on_second_timeout(&td, true);
     set_tco_timeout(&td, TCO_SECS_TO_TICKS(16));
     load_tco(&td);
     start_tco(&td);
-    clock_step(ticks * TCO_TICK_NSEC * 2);
-    ad =3D get_watchdog_action();
+    qtest_clock_step(td.qts, ticks * TCO_TICK_NSEC * 2);
+    ad =3D get_watchdog_action(&td);
     g_assert(!strcmp(qdict_get_str(ad, "action"), "reset"));
     qobject_unref(ad);
=20
@@ -308,12 +309,12 @@ static void test_tco_second_timeout_shutdown(void)
=20
     stop_tco(&td);
     clear_tco_status(&td);
-    reset_on_second_timeout(true);
+    reset_on_second_timeout(&td, true);
     set_tco_timeout(&td, ticks);
     load_tco(&td);
     start_tco(&td);
-    clock_step(ticks * TCO_TICK_NSEC * 2);
-    ad =3D get_watchdog_action();
+    qtest_clock_step(td.qts, ticks * TCO_TICK_NSEC * 2);
+    ad =3D get_watchdog_action(&td);
     g_assert(!strcmp(qdict_get_str(ad, "action"), "shutdown"));
     qobject_unref(ad);
=20
@@ -333,12 +334,12 @@ static void test_tco_second_timeout_none(void)
=20
     stop_tco(&td);
     clear_tco_status(&td);
-    reset_on_second_timeout(true);
+    reset_on_second_timeout(&td, true);
     set_tco_timeout(&td, ticks);
     load_tco(&td);
     start_tco(&td);
-    clock_step(ticks * TCO_TICK_NSEC * 2);
-    ad =3D get_watchdog_action();
+    qtest_clock_step(td.qts, ticks * TCO_TICK_NSEC * 2);
+    ad =3D get_watchdog_action(&td);
     g_assert(!strcmp(qdict_get_str(ad, "action"), "none"));
     qobject_unref(ad);
=20
@@ -358,7 +359,7 @@ static void test_tco_ticks_counter(void)
=20
     stop_tco(&d);
     clear_tco_status(&d);
-    reset_on_second_timeout(false);
+    reset_on_second_timeout(&d, false);
     set_tco_timeout(&d, ticks);
     load_tco(&d);
     start_tco(&d);
@@ -366,7 +367,7 @@ static void test_tco_ticks_counter(void)
     do {
         rld =3D qpci_io_readw(d.dev, d.tco_io_bar, TCO_RLD) & TCO_RLD_MA=
SK;
         g_assert_cmpint(rld, =3D=3D, ticks);
-        clock_step(TCO_TICK_NSEC);
+        qtest_clock_step(d.qts, TCO_TICK_NSEC);
         ticks--;
     } while (!(qpci_io_readw(d.dev, d.tco_io_bar, TCO1_STS) & TCO_TIMEOU=
T));
=20
@@ -405,11 +406,11 @@ static void test_tco1_status_bits(void)
=20
     stop_tco(&d);
     clear_tco_status(&d);
-    reset_on_second_timeout(false);
+    reset_on_second_timeout(&d, false);
     set_tco_timeout(&d, ticks);
     load_tco(&d);
     start_tco(&d);
-    clock_step(ticks * TCO_TICK_NSEC);
+    qtest_clock_step(d.qts, ticks * TCO_TICK_NSEC);
=20
     qpci_io_writeb(d.dev, d.tco_io_bar, TCO_DAT_IN, 0);
     qpci_io_writeb(d.dev, d.tco_io_bar, TCO_DAT_OUT, 0);
@@ -434,11 +435,11 @@ static void test_tco2_status_bits(void)
=20
     stop_tco(&d);
     clear_tco_status(&d);
-    reset_on_second_timeout(true);
+    reset_on_second_timeout(&d, true);
     set_tco_timeout(&d, ticks);
     load_tco(&d);
     start_tco(&d);
-    clock_step(ticks * TCO_TICK_NSEC * 2);
+    qtest_clock_step(d.qts, ticks * TCO_TICK_NSEC * 2);
=20
     val =3D qpci_io_readw(d.dev, d.tco_io_bar, TCO2_STS);
     ret =3D val & (TCO_SECOND_TO_STS | TCO_BOOT_STS) ? 1 : 0;
--=20
2.21.0


