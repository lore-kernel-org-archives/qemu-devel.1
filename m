Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC26C32771
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 06:05:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5F902073D
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 06:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="JuPpLvlX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5F902073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itQCB-0001Lv-II
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 01:05:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35310)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1itQ1c-00079r-0I
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 00:55:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1itQ1a-0006QG-Ln
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 00:54:59 -0500
Received: from mail-bn7nam10on2116.outbound.protection.outlook.com
 ([40.107.92.116]:31998 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1itQ1a-0006Q3-Ho
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 00:54:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YukunFqCfmH5jSh9MR1/UIfQLAuWqQm9LXW98eUwy4kNeqdYPelEDaK/YG2++lf4LYZoiTNNxFYRnQbxdyWVEM9EHR8bzqffT7t3HIKrtvW4t2UC24tj5KcPpjsu4JEno2MTVh647+dpjxT6Y5qvKABSCe5u5ReFDv5o2EAFgWIDni4tlbUdW9KFNrE88I1OR0lymDK0+C/1Re/m/kX5HaaOtc+aO5alLcIC5UKtwjlPTlF89Fk9Bm/YR8zIOoDuKVYxnMq52ysLXpJFVFHzgmhG6lXR0l1BEEXgrLl8MYBeVn7b3HX4U6sxz1Y/U58qbbckxvm9QjQNk9o4fKgPmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1hQfW9/9q8KnXyTWzkxHml6DPaJtmQZHPkWi5XPf+6I=;
 b=WgJNaykvdgGhWPdIQmkVfnxejmJjpGWeKXkXvroVOGBm1AVr8ylZSO5B8luJ6c4mUS9yprIomlDPowIs9OfHFF2rs1rRsfkMVQBx17WR7JbrpKWc2iKnSDUQqfnqtexxdzSlqoXTmUt6moHk2wBH8CLlO4mRvX8Qd60zu7JDlp8UhmrhTdYNuU8RH26WsT12dwBOJrug3k0Uf8cm2LWDzEg+BzHjkMhu1Ym/E55Zv8QRBC2AppLe6sKUM77zBp6An46L5XCe6hX0H0pnZJTJw6OtsUCOUA81IqAJxi1a4P8te3P7T2qPvSB9aGoDWLDsEVtPQzNNDnEZK0HSvPhTsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1hQfW9/9q8KnXyTWzkxHml6DPaJtmQZHPkWi5XPf+6I=;
 b=JuPpLvlXSuXLiEVIaG6fyFo03mNdG8M54MCrZjicnkibos9m7zDgZ1P8TsmtEf4nCtkQrr8R0JopbwpvjmnYvYcMTXenezc2MU+SY7S5ndb+JjJhPm9FA28WniB7uk21VaO/1yzLBsJX3gwcqScH+An5hTpwnaimB7FxWq2i+vE=
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (52.135.102.32) by
 SN6PR03MB4399.namprd03.prod.outlook.com (20.178.6.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.23; Mon, 20 Jan 2020 05:54:57 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8%7]) with mapi id 15.20.2644.024; Mon, 20 Jan 2020
 05:54:57 +0000
Received: from mozz.bu.edu (128.197.127.33) by
 MN2PR20CA0032.namprd20.prod.outlook.com (2603:10b6:208:e8::45) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20 via Frontend Transport; Mon, 20 Jan 2020 05:54:56 +0000
From: "Bulekov, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH v7 10/20] libqtest: make bufwrite rely on the TransportOps
Thread-Topic: [PATCH v7 10/20] libqtest: make bufwrite rely on the TransportOps
Thread-Index: AQHVz1Ykz539ApCc2kOWg771utMEUQ==
Date: Mon, 20 Jan 2020 05:54:57 +0000
Message-ID: <20200120055410.22322-16-alxndr@bu.edu>
References: <20200120055410.22322-1-alxndr@bu.edu>
In-Reply-To: <20200120055410.22322-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.23.0
x-originating-ip: [128.197.127.33]
x-clientproxiedby: MN2PR20CA0032.namprd20.prod.outlook.com
 (2603:10b6:208:e8::45) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 70d61398-015b-42b9-05ec-08d79d6d4711
x-ms-traffictypediagnostic: SN6PR03MB4399:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR03MB4399A2FE22B79F6BAF1E7846BA320@SN6PR03MB4399.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1468;
x-forefront-prvs: 0288CD37D9
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(189003)(199004)(5660300002)(956004)(2616005)(8936002)(86362001)(6916009)(6486002)(7696005)(1076003)(52116002)(316002)(71200400001)(16526019)(186003)(786003)(478600001)(2906002)(26005)(81166006)(66946007)(66476007)(64756008)(36756003)(8676002)(75432002)(81156014)(66446008)(4326008)(66556008)(54906003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SN6PR03MB4399;
 H:SN6PR03MB3871.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VBpEhFjBPyUf5SCoKSlbn1DdgKMPoke80LXxhh6v/rii9poX+zb5CWl4KxN0eAlWwLU1NrhqgfGuEbKVniNCevSRrG9f+FgucNR29djNOmEDzZndAMDXBa00R83gtjH7Gm+hNTeqhTbzsZeyBXA54Y15qqGJC+DgKLQM4OonK8wLjCa9r0es/n0ZVaueXParkL7Kx9ZxvEm8NDky9Itj3iTvCK+MrdHHKrBVFeBCXnZbPeta9drEK61wb+Hlsiqo4fz8ZWAORuPjNa0lmvaB/TYK7uk0esTylALrqDkTPS9oPZ5C4HMgMONzN5XzTUUBu2TqOUXRHI2wneOAgiDs8wra0kf08dGiQES5DrxWoYwaDe+6jBmZous6V3/iA1yq4dfLHrD2VMTS3FFdQdYlv7Tl8qVh8Eb76eDLaePsKwZy200odGIEmrG/1oAwEKj7
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 70d61398-015b-42b9-05ec-08d79d6d4711
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2020 05:54:57.1455 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TrVuI0YtNYV85HMNko2Zd8EfNoQoRkrivBv2VqV7IMy5q79v86gPvUAZ1LLsp/aT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB4399
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.92.116
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "Bulekov, Alexander" <alxndr@bu.edu>, "bsd@redhat.com" <bsd@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When using qtest "in-process" communication, qtest_sendf directly calls
a function in the server (qtest.c). Previously, bufwrite used
socket_send, which bypasses the TransportOps enabling the call into
qtest.c. This change replaces the socket_send calls with ops->send,
maintaining the benefits of the direct socket_send call, while adding
support for in-process qtest calls.

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/qtest/libqtest.c | 71 ++++++++++++++++++++++++++++++++++++++++--
 tests/qtest/libqtest.h |  4 +++
 2 files changed, 73 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index e5056a1d0f..49075b55a1 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -37,10 +37,18 @@
=20
=20
 typedef void (*QTestSendFn)(QTestState *s, const char *buf);
+typedef void (*ExternalSendFn)(void *s, const char *buf);
 typedef GString* (*QTestRecvFn)(QTestState *);
=20
 typedef struct QTestClientTransportOps {
     QTestSendFn     send;      /* for sending qtest commands */
+
+    /*
+     * use external_send to send qtest command strings through functions w=
hich
+     * do not accept a QTestState as the first parameter.
+     */
+    ExternalSendFn  external_send;
+
     QTestRecvFn     recv_line; /* for receiving qtest command responses */
 } QTestTransportOps;
=20
@@ -1078,8 +1086,8 @@ void qtest_bufwrite(QTestState *s, uint64_t addr, con=
st void *data, size_t size)
=20
     bdata =3D g_base64_encode(data, size);
     qtest_sendf(s, "b64write 0x%" PRIx64 " 0x%zx ", addr, size);
-    socket_send(s->fd, bdata, strlen(bdata));
-    socket_send(s->fd, "\n", 1);
+    s->ops.send(s, bdata);
+    s->ops.send(s, "\n");
     qtest_rsp(s, 0);
     g_free(bdata);
 }
@@ -1367,3 +1375,62 @@ static void qtest_client_set_rx_handler(QTestState *=
s, QTestRecvFn recv)
 {
     s->ops.recv_line =3D recv;
 }
+/* A type-safe wrapper for s->send() */
+static void send_wrapper(QTestState *s, const char *buf)
+{
+    s->ops.external_send(s, buf);
+}
+
+static GString *qtest_client_inproc_recv_line(QTestState *s)
+{
+    GString *line;
+    size_t offset;
+    char *eol;
+
+    eol =3D strchr(s->rx->str, '\n');
+    offset =3D eol - s->rx->str;
+    line =3D g_string_new_len(s->rx->str, offset);
+    g_string_erase(s->rx, 0, offset + 1);
+    return line;
+}
+
+QTestState *qtest_inproc_init(QTestState **s, bool log, const char* arch,
+                    void (*send)(void*, const char*))
+{
+    QTestState *qts;
+    qts =3D g_new0(QTestState, 1);
+    *s =3D qts; /* Expose qts early on, since the query endianness relies =
on it */
+    qts->wstatus =3D 0;
+    for (int i =3D 0; i < MAX_IRQ; i++) {
+        qts->irq_level[i] =3D false;
+    }
+
+    qtest_client_set_rx_handler(qts, qtest_client_inproc_recv_line);
+
+    /* send() may not have a matching protoype, so use a type-safe wrapper=
 */
+    qts->ops.external_send =3D send;
+    qtest_client_set_tx_handler(qts, send_wrapper);
+
+    qts->big_endian =3D qtest_query_target_endianness(qts);
+
+    /*
+     * Set a dummy path for QTEST_QEMU_BINARY. Doesn't need to exist, but =
this
+     * way, qtest_get_arch works for inproc qtest.
+     */
+    gchar *bin_path =3D g_strconcat("/qemu-system-", arch, NULL);
+    setenv("QTEST_QEMU_BINARY", bin_path, 0);
+    g_free(bin_path);
+
+    return qts;
+}
+
+void qtest_client_inproc_recv(void *opaque, const char *str)
+{
+    QTestState *qts =3D *(QTestState **)opaque;
+
+    if (!qts->rx) {
+        qts->rx =3D g_string_new(NULL);
+    }
+    g_string_append(qts->rx, str);
+    return;
+}
diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
index c9e21e05b3..f5cf93c386 100644
--- a/tests/qtest/libqtest.h
+++ b/tests/qtest/libqtest.h
@@ -729,4 +729,8 @@ bool qtest_probe_child(QTestState *s);
  */
 void qtest_set_expected_status(QTestState *s, int status);
=20
+QTestState *qtest_inproc_init(QTestState **s, bool log, const char* arch,
+                    void (*send)(void*, const char*));
+
+void qtest_client_inproc_recv(void *opaque, const char *str);
 #endif
--=20
2.23.0


