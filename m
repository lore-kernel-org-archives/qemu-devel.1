Return-Path: <SRS0=68uo=YX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16931CA9EC5
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 14:53:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D590320856
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 14:53:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="aoxAV7Vb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D590320856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPpLc-00018s-Hj
	for qemu-devel@archiver.kernel.org; Wed, 30 Oct 2019 10:53:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35361)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1iPpIR-00052t-8B
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 10:50:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1iPpIP-0007Ji-QH
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 10:50:03 -0400
Received: from mail-eopbgr690115.outbound.protection.outlook.com
 ([40.107.69.115]:23033 helo=NAM04-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1iPpIP-0007Ax-GQ
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 10:50:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JkHb5aC16jE5C+9jBmrXqRxVDkso0Tgk/Z0hQ/B6RLYaz4Fe5uJVH/GLfpjNWCHSiQfO5YW/qsEdXm30k5lY7Xlza8IBddOjW5wCGD5jQ6lLQ3O4mf2LwNTMgkBJ84g9P9+vKTPInLGniiLnx2gGehVGmHpgfQ+uj3UROreMy6+A551x20UuK/gdsVEdQVG5oyixJf+wWWkBNNcCYXHViH3mtmuEOKUbfPyVWf8eBLFuw6JneY3Fy70BVFt4GZwAReA9yRZXghfEgB9IWilYrqmVTqLSfwqQMXl1m/+0LjHxFgl8xJi3rlbZp7WOSoplgX2eUgsCXnmAO2MRBAxnaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l4k01TjyloxFs5+fi5Uc8/v+PfVMYbJjMeZc7qNSdqk=;
 b=FGf/jxVQ8eqEfL5mGvpD1tP965McCklApCf1VZya/mXVy7SO5Pk9oh63R+D3cOw2HI6H0slrql39Ca4q+gGQGLwBtf7OYqIlMaEz9bkVRlkJg+87dx5+SjS6VZaadltzXbQQEh9gx2wlo3jUV+inHwqddtHs/SAAqUIv46qmOOz1tTJKIFLJWuK2z4f8S1642SbzKtFbxlTJ9x53nFhkTlgDpWwplEZfjT2DCC51pO2T1ebwBazFBbFeHIlG4UUxorVYa6MQq3eKJ7H8wMNZMgZ8ivUGl2lUQ5KQJXJzhfdaH6aUzOvxY04KkMcwyHrpdMk9l4UnjqR7v89zsknsxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l4k01TjyloxFs5+fi5Uc8/v+PfVMYbJjMeZc7qNSdqk=;
 b=aoxAV7VbhJUag6oaPeJPQgY7NZi6be3ELL7TdeJeMCBPyY/4U78e89+Gzojz8Oumpqbd7oiEe2pRYW0fAy1KOlss0ReP9e3Ge+kWV/EKL/JX5hvjn7Do/x4MZojkvW/HtsHUUx8RVst+BtBIlWH0BZijrzNPoDEIVTsu4RoqfVU=
Received: from MN2PR03MB4800.namprd03.prod.outlook.com (20.179.82.78) by
 MN2PR03MB4959.namprd03.prod.outlook.com (52.132.168.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.22; Wed, 30 Oct 2019 14:49:58 +0000
Received: from MN2PR03MB4800.namprd03.prod.outlook.com
 ([fe80::344f:b88:26f0:9f66]) by MN2PR03MB4800.namprd03.prod.outlook.com
 ([fe80::344f:b88:26f0:9f66%7]) with mapi id 15.20.2387.028; Wed, 30 Oct 2019
 14:49:58 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH v4 12/20] libqtest: add in-process qtest.c tx/rx handlers
Thread-Topic: [PATCH v4 12/20] libqtest: add in-process qtest.c tx/rx handlers
Thread-Index: AQHVjzFMZCJi/x3SAU+2TC4zQBE0Lg==
Date: Wed, 30 Oct 2019 14:49:58 +0000
Message-ID: <20191030144926.11873-13-alxndr@bu.edu>
References: <20191030144926.11873-1-alxndr@bu.edu>
In-Reply-To: <20191030144926.11873-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.23.0
x-originating-ip: [128.197.127.33]
x-clientproxiedby: DM5PR08CA0048.namprd08.prod.outlook.com
 (2603:10b6:4:60::37) To MN2PR03MB4800.namprd03.prod.outlook.com
 (2603:10b6:208:101::14)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a09f1917-1b77-430f-fbd2-08d75d486f4e
x-ms-traffictypediagnostic: MN2PR03MB4959:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR03MB4959573A626433AAF462FE3DBA600@MN2PR03MB4959.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:115;
x-forefront-prvs: 02065A9E77
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(366004)(39860400002)(376002)(346002)(136003)(199004)(189003)(102836004)(386003)(6506007)(66946007)(66446008)(64756008)(66476007)(2616005)(186003)(2351001)(446003)(26005)(36756003)(66556008)(3846002)(6116002)(14444005)(2501003)(14454004)(11346002)(66066001)(256004)(4326008)(6916009)(305945005)(1076003)(6486002)(486006)(5660300002)(71190400001)(50226002)(71200400001)(476003)(86362001)(88552002)(7736002)(52116002)(76176011)(2906002)(478600001)(99286004)(786003)(316002)(8676002)(81166006)(5640700003)(81156014)(25786009)(6436002)(54906003)(75432002)(8936002)(6512007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MN2PR03MB4959;
 H:MN2PR03MB4800.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +KzMUN2eplcH97fOgj53ccGAiDl2tNDmT9E9TnyKpHEITBIEjzhQalI9yXoD8a3zbkGAFqslCOLSDx94T0aYXwyYqrnr/5w70+mDyjgRLbFKE5mrFnOHuT7JeoacIdQQraNPfLwIoivbcCFF1NxN7gfWvOQcxYt9SyUxJQKY/5KdDl0v+ZTJgxjAH4bcOVPuR8q5AUiYSFnz3Ns7mrnS6IlnJ4ZiJgF5NucatqUUx+zoOswWPru9SUZQwpGUCT6aQIb4ul2qaQ3coNTSa+MOUVbd1BmxEexnVNNBH/QikhAQPsfbtSsDiLO0ikt96EZh0RVbU2+cnvQ2mT5/5vCBcLKSlx6xABmAzpAOKK1Wofr9HIajG/gp92J1Bz5v1pCqZ2yEtK3G3f+OsW/KOc5d+oBFxwOuLsAZIpuioi9b0qQdZYSklKNDGDOQiAK41zb1
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: a09f1917-1b77-430f-fbd2-08d75d486f4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2019 14:49:58.5768 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BjZgNZz2hDAYig3e6H48ame8bciwuikilDLwF1ORJhQHVW12Jy8UR86AHI6AUuXO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB4959
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.69.115
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
Cc: Laurent Vivier <lvivier@redhat.com>, "Oleinik, Alexander" <alxndr@bu.edu>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alexander Oleinik <alxndr@bu.edu>

Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
---
There's a particularily ugly line here:
qtest_client_set_tx_handler(qts,
        (void (*)(QTestState *s, const char*, size_t)) send);

Since qtest.c has no knowledge of the QTestState, I'm not sure how to
avoid doing this, without adding back the *opaque that was present in
v3.

 qtest.c          |  2 +-
 tests/libqtest.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++++
 tests/libqtest.h |  5 +++++
 3 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/qtest.c b/qtest.c
index 9fbfa0f08f..f817a5d789 100644
--- a/qtest.c
+++ b/qtest.c
@@ -812,6 +812,6 @@ void qtest_server_inproc_recv(void *dummy, const char *=
buf, size_t size)
     g_string_append(gstr, buf);
     if (gstr->str[gstr->len - 1] =3D=3D '\n') {
         qtest_process_inbuf(NULL, gstr);
-        g_string_free(gstr, true);
+        g_string_truncate(gstr, 0);
     }
 }
diff --git a/tests/libqtest.c b/tests/libqtest.c
index ff3153daf2..6143af33da 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -71,6 +71,7 @@ static void qtest_client_set_tx_handler(QTestState *s,
 static void qtest_client_set_rx_handler(QTestState *s,
         GString * (*recv)(QTestState *));
=20
+static GString *recv_str;
=20
 static int init_socket(const char *socket_path)
 {
@@ -486,6 +487,7 @@ static GString *qtest_client_socket_recv_line(QTestStat=
e *s)
     return line;
 }
=20
+
 static gchar **qtest_rsp(QTestState *s, int expected_args)
 {
     GString *line;
@@ -1372,3 +1374,50 @@ static void qtest_client_set_rx_handler(QTestState *=
s,
 {
     s->ops.recv_line =3D recv;
 }
+
+static GString *qtest_client_inproc_recv_line(QTestState *s)
+{
+    GString *line;
+    size_t offset;
+    char *eol;
+
+    eol =3D strchr(recv_str->str, '\n');
+    offset =3D eol - recv_str->str;
+    line =3D g_string_new_len(recv_str->str, offset);
+    g_string_erase(recv_str, 0, offset + 1);
+    return line;
+}
+
+QTestState *qtest_inproc_init(bool log, const char* arch,
+                    void (*send)(void*, const char*, size_t))
+{
+    QTestState *qts;
+    qts =3D g_new(QTestState, 1);
+    qts->wstatus =3D 0;
+    for (int i =3D 0; i < MAX_IRQ; i++) {
+        qts->irq_level[i] =3D false;
+    }
+
+    qtest_client_set_rx_handler(qts, qtest_client_inproc_recv_line);
+    /* Re-cast the  send pointer, since qtest.c should need to know about
+     * QTestState
+     */
+    qtest_client_set_tx_handler(qts,
+            (void (*)(QTestState *s, const char*, size_t)) send);
+
+    qts->big_endian =3D qtest_query_target_endianness(qts);
+    gchar *bin_path =3D g_strconcat("/qemu-system-", arch, NULL);
+    setenv("QTEST_QEMU_BINARY", bin_path, 0);
+    g_free(bin_path);
+
+    return qts;
+}
+
+void qtest_client_inproc_recv(void *opaque, const char *str, size_t len)
+{
+    if (!recv_str) {
+        recv_str =3D g_string_new(NULL);
+    }
+    g_string_append_len(recv_str, str, len);
+    return;
+}
diff --git a/tests/libqtest.h b/tests/libqtest.h
index 31267fc915..7251de4ba9 100644
--- a/tests/libqtest.h
+++ b/tests/libqtest.h
@@ -728,4 +728,9 @@ bool qtest_probe_child(QTestState *s);
  * Set expected exit status of the child.
  */
 void qtest_set_expected_status(QTestState *s, int status);
+
+
+QTestState *qtest_inproc_init(bool log, const char* arch,
+                    void (*send)(void*, const char*, size_t));
+void qtest_client_inproc_recv(void *opaque, const char *str, size_t len);
 #endif
--=20
2.23.0


