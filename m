Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D07C32771
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 06:07:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9082B2073A
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 06:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="KuXP4vq7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9082B2073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itQDs-0003pV-0w
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 01:07:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35202)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1itQ1R-0006sn-QY
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 00:54:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1itQ1Q-0006KG-CI
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 00:54:49 -0500
Received: from mail-bn7nam10on2100.outbound.protection.outlook.com
 ([40.107.92.100]:26271 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1itQ1Q-0006Jg-6v
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 00:54:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IH3tfS2m0wesdQk0b03rEq5RyB/9kA6zuATslVpVhtNSvYvfZzoxsclj6ggHikzrLrQhWMmwTm/XLj0NEe0Glwx/sjF6wOR4CqeVDr1t3Cvd5EphC9ru8KRSCt9rZhe7pQ3Bntq56SNGPO4jUJKFX4mpggqRWjQ6Uh5zg1jODx2d/4NzbyGiVATU2ztwD3hEsZhtmUDVubiM65NN3fQ3WItN/EObHMO1kxO3HzhfR0+lWEEnmf12hJYTbBbDRI11PfQoPiInp7V7l4RJ3KvXDKn4r/zCHGsUuxwZHqBEyaeBjlkzWERWUQZ+tFNxJYJeSs7G4vRs2gj+m0YxTtmeDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1hQfW9/9q8KnXyTWzkxHml6DPaJtmQZHPkWi5XPf+6I=;
 b=B9TPcnwOjDbFXMTr2GNVXxVxrbBs9+plC4/xDyQbF02J01W3hIdWDKHIKuW2bLcevj0isV3BeB5LgUg6pLfzbJTc40cFF9ipTGigaWcBjYLsQVWgvoQUUTvkMibIc0SD1POjtnNeSLJuELVkBeXPYJjNEnbXZmzZmSE5vo+Abnz3fZvTRQkD5S8QbxEIAhcWeqmgQ/x0CHgxXcPFhkGlZ1z2DgIOgmGna+5WeuT9TVuSfQ2TJxZfi7VISiSvyqXDAmgqlvZhsph2xZir0hHJJk/iyxgU7z5d5m311Cijt3x7ZsFTgMRWKrTN8JHv+58xEfIkkVc7c2Rk1vLHGNsrMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1hQfW9/9q8KnXyTWzkxHml6DPaJtmQZHPkWi5XPf+6I=;
 b=KuXP4vq7cszhrcomA+wDQk8vwNGrpPOrNVut4o02QCojMwpG1w3aDI0Ay2N/NVwJaR/T1VBDeunO2NjyzJ985Ugk+J4RKg0mJX2AtA/b+4qcuwKch6cOUnQHGNOrCJpFrb5g37+nbsb1gWmNiy4BS7iSrSWlEchfsOqylPCO27w=
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (52.135.102.32) by
 SN6PR03MB4399.namprd03.prod.outlook.com (20.178.6.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.23; Mon, 20 Jan 2020 05:54:47 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8%7]) with mapi id 15.20.2644.024; Mon, 20 Jan 2020
 05:54:47 +0000
Received: from mozz.bu.edu (128.197.127.33) by
 MN2PR20CA0032.namprd20.prod.outlook.com (2603:10b6:208:e8::45) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20 via Frontend Transport; Mon, 20 Jan 2020 05:54:46 +0000
From: "Bulekov, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH v7 06/20] libqtest: make bufwrite rely on the TransportOps
Thread-Topic: [PATCH v7 06/20] libqtest: make bufwrite rely on the TransportOps
Thread-Index: AQHVz1YerQq3oPWou0yHdFK7g14dhA==
Date: Mon, 20 Jan 2020 05:54:47 +0000
Message-ID: <20200120055410.22322-8-alxndr@bu.edu>
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
x-ms-office365-filtering-correlation-id: ce5096e1-7eae-463d-8234-08d79d6d4153
x-ms-traffictypediagnostic: SN6PR03MB4399:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR03MB43991E190C374AE53ED83E62BA320@SN6PR03MB4399.namprd03.prod.outlook.com>
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
x-microsoft-antispam-message-info: cvsUY5xfYstO3WDvi6TkcZuBawrtPZSnZ3CFfWPZxCEBwqB7ulEz+m72ikrJyIrAnBJGAzY+34QO+wJzbOQRRaO7UHO/CGTXa2mtKbMLlTU+Pr0+LZ/XP4uT2SspmRnCz4em7GLALqW8N2n1G2wafoGkIIy7fohB1mOszzS7gpUqjVV4UiB9Q0cWYpGmFDLOQ2a0LEp98NdJ8uDGJiyBVf6e8jWGh4uFyHtVOqnwRSwr8Ng7jMN0WKSiCE7N+VqDhHGPxkUeKaebXGyV90esqqXE2ylM0HsioDl1rhvLQoyiB9SSHuNIARIdUMAH+iLZz0oTlGZsLXIBdLN3O7Qtuh9KndD85K3gfE283uPjSN9Bocrax5y+jjJwV6vJ80vJZvF2iX95PR6Vbl3iXog3uPY9JIg01Szg5FMa/RPyoyfo2Weevyxs7xRzKgs7XRWD
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: ce5096e1-7eae-463d-8234-08d79d6d4153
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2020 05:54:47.1611 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f/cBx5OhhT7kyOtn3iK3tzh5A1G8GYHtulXBKa8+w6EztP79F2VEyATTevSea1Vv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB4399
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.92.100
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


