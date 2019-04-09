Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC37C10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 08:56:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A8682084C
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 08:56:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A8682084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37712 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDmYg-000731-O9
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 04:56:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hDmVC-0004Be-KC
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 04:53:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hDmV9-0002wj-3o
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 04:53:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51548)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>)
	id 1hDmV4-0002vO-Nl; Tue, 09 Apr 2019 04:53:02 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 05198308222E;
	Tue,  9 Apr 2019 08:53:02 +0000 (UTC)
Received: from thuth.com (ovpn-116-133.ams2.redhat.com [10.36.116.133])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 03CEF1A917;
	Tue,  9 Apr 2019 08:52:59 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue,  9 Apr 2019 10:52:44 +0200
Message-Id: <20190409085245.31548-5-thuth@redhat.com>
In-Reply-To: <20190409085245.31548-1-thuth@redhat.com>
References: <20190409085245.31548-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Tue, 09 Apr 2019 08:53:02 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH for-4.1 4/5] tests/test-hmp: Use qtest_init()
 instead of qtest_start()
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
Message-ID: <20190409085244.1iUglhZj7fToFPpMGxihX6HG2QBVJSXSJkutt6X6XJ4@z>

qtest_start() + qtest_end() should be avoided, since they use the
global_qtest variable that we want to get rid of in the long run
Use qtest_init() and qtest_quit() instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/test-hmp.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/tests/test-hmp.c b/tests/test-hmp.c
index 54a01824dc..f0d843e34a 100644
--- a/tests/test-hmp.c
+++ b/tests/test-hmp.c
@@ -72,13 +72,13 @@ static const char *hmp_cmds[] =3D {
 };
=20
 /* Run through the list of pre-defined commands */
-static void test_commands(void)
+static void test_commands(QTestState *qts)
 {
     char *response;
     int i;
=20
     for (i =3D 0; hmp_cmds[i] !=3D NULL; i++) {
-        response =3D hmp("%s", hmp_cmds[i]);
+        response =3D qtest_hmp(qts, "%s", hmp_cmds[i]);
         if (verbose) {
             fprintf(stderr,
                     "\texecute HMP command: %s\n"
@@ -91,11 +91,11 @@ static void test_commands(void)
 }
=20
 /* Run through all info commands and call them blindly (without argument=
s) */
-static void test_info_commands(void)
+static void test_info_commands(QTestState *qts)
 {
     char *resp, *info, *info_buf, *endp;
=20
-    info_buf =3D info =3D hmp("help info");
+    info_buf =3D info =3D qtest_hmp(qts, "help info");
=20
     while (*info) {
         /* Extract the info command, ignore parameters and description *=
/
@@ -107,7 +107,7 @@ static void test_info_commands(void)
         if (verbose) {
             fprintf(stderr, "\t%s\n", info);
         }
-        resp =3D hmp("%s", info);
+        resp =3D qtest_hmp(qts, "%s", info);
         g_free(resp);
         /* And move forward to the next line */
         info =3D strchr(endp + 1, '\n');
@@ -124,14 +124,15 @@ static void test_machine(gconstpointer data)
 {
     const char *machine =3D data;
     char *args;
+    QTestState *qts;
=20
     args =3D g_strdup_printf("-S -M %s", machine);
-    qtest_start(args);
+    qts =3D qtest_init(args);
=20
-    test_info_commands();
-    test_commands();
+    test_info_commands(qts);
+    test_commands(qts);
=20
-    qtest_end();
+    qtest_quit(qts);
     g_free(args);
     g_free((void *)data);
 }
--=20
2.21.0


