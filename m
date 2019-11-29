Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BFEBC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 21:52:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3264A216F4
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 21:52:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="t/c+2ufJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3264A216F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaoBz-0003FI-Dz
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 16:52:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48180)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1ianui-00006t-RV
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 16:34:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1ianug-0002v5-P6
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 16:34:56 -0500
Received: from mail-eopbgr790122.outbound.protection.outlook.com
 ([40.107.79.122]:35989 helo=NAM03-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1ianuf-0002ny-Qk
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 16:34:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FJLmBqZMID/LW/XLXIfVZRwas1O8NXOhraNkaAhStKoQSO3HSaGXGE1zxH8iOel7llPz3ttpqRd39MKBZVXEF8FR4vjtVe4ZgyugsOlyfUuaHJa2PN7FJ6C4r4mABxc2DZoQiL9Tf6w2d0i86Eg0QbofMjIgESGAN0lXlPiganH55PmQJi9LTQt06Lv40E1jdZMog0f1UqcWY8qRh1I6XPAtFXjpTMhFJRxwgUwnj2kDQPJ+ipRlkSz8vlTlIlT2uI8y1qjZV4mJB4u+xaXk1iyidijgWQ+ThJE4sZrJpu/99siCqoir8LsK3AuJUy9rtYTR5rusOmhJJb+jo6XGHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WC0gHgdrTSzxrcZC8oXdiASACm9Hghpf8KYFgQyEyXk=;
 b=aR00ZLKQ2Ab7gwvFQBi4IU4rVgADN7tTYF+5eKCreTeg4L92tanmhCJhsYZUujLhbobTXHH/mRp3Au8X6dHhCDaJn989LNhiqOlCbU7bJfVGUUQpu4GIwNPW+aPl/hbUXPMdvvYdwhp5hnItvsLii/z47RFQX7C9JF0kgQ4qIP38GGG2dfMXU8YxOweBxCqWwqcjhyE46LnbGYdHQ/wzSK15UDbeCCI1+fWM9b5gspbBF53gl7eAap/Lsw3ycUKXswfW2BT/iMSq0atgAHIbdFmC4p3gEo4SfASFoj27Fdfe9fuCfWACVNUuloZTxeKK+l/zI2qAAYkpu+MZtvyF/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WC0gHgdrTSzxrcZC8oXdiASACm9Hghpf8KYFgQyEyXk=;
 b=t/c+2ufJBZyIIS6Hf7xx8cjR0JQPcfoMnc3a3+9kk8z4EmreDzcVWrb3cOBPRck7Y/XtvW3stOLbjlIIkb5H8n4eBECSBp4osg/t4PdTwOT3EE2joSF58DJclXkVgxQf7XqQz6SkG1NcCAzvCxjVd6Qzi7itS7UnmcWs99zkCTY=
Received: from DM6PR03MB4795.namprd03.prod.outlook.com (20.179.107.22) by
 DM6PR03MB5050.namprd03.prod.outlook.com (10.141.161.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18; Fri, 29 Nov 2019 21:34:47 +0000
Received: from DM6PR03MB4795.namprd03.prod.outlook.com
 ([fe80::2557:454e:205e:4d74]) by DM6PR03MB4795.namprd03.prod.outlook.com
 ([fe80::2557:454e:205e:4d74%2]) with mapi id 15.20.2495.014; Fri, 29 Nov 2019
 21:34:47 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH v6 12/21] libqtest: add in-process qtest.c tx/rx handlers
Thread-Topic: [PATCH v6 12/21] libqtest: add in-process qtest.c tx/rx handlers
Thread-Index: AQHVpvzSqDOkOrQumkKFNNlPX/Mgaw==
Date: Fri, 29 Nov 2019 21:34:47 +0000
Message-ID: <20191129213424.6290-13-alxndr@bu.edu>
References: <20191129213424.6290-1-alxndr@bu.edu>
In-Reply-To: <20191129213424.6290-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.23.0
x-originating-ip: [128.197.127.33]
x-clientproxiedby: BL0PR1501CA0025.namprd15.prod.outlook.com
 (2603:10b6:207:17::38) To DM6PR03MB4795.namprd03.prod.outlook.com
 (2603:10b6:5:18c::22)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 411d67fd-5d7b-4d0d-a4fc-08d77513f52c
x-ms-traffictypediagnostic: DM6PR03MB5050:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR03MB5050A80D5533EDAF1C2DF893BA460@DM6PR03MB5050.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:153;
x-forefront-prvs: 0236114672
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(366004)(346002)(39860400002)(136003)(396003)(199004)(189003)(54906003)(81156014)(81166006)(66066001)(6436002)(3846002)(8936002)(66946007)(6116002)(1076003)(66446008)(64756008)(66476007)(14444005)(256004)(66556008)(316002)(786003)(8676002)(6512007)(102836004)(6486002)(478600001)(71190400001)(71200400001)(2351001)(86362001)(6506007)(14454004)(2501003)(75432002)(386003)(5640700003)(2906002)(6916009)(7736002)(2616005)(25786009)(26005)(52116002)(88552002)(99286004)(5660300002)(76176011)(186003)(446003)(11346002)(305945005)(50226002)(36756003)(4326008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM6PR03MB5050;
 H:DM6PR03MB4795.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RRVyPPuAwl23W8aO2KMFqgh012aYWIkupFUr3nvmx55/3jERpROKQeQG7zeS3WlCs/tmA94efD5SB2SEqYpH+3RciVIOID8MrXyINE8wwSxr9m4S6LTSOJiQk2oHhWftqLwXsEzUyjS9WgpcybEOJ6+uhfaz5KGJNh8urzvTx9zRsxSYf3/tQl0K9cbukcfoP+uFl1NoisruIhXM10ZOXtfWMTuUc0qUj9TcM0SmvBNAPCfX2Nc/Mda9nU0bQKS+ehL8vTeOGFS8k0/HnLqHwhAM5wI05gwY+EVC8lkxsNFMQ5NU4hwb0ME/eaOh/u+DCoLpQJ30TtzeVqrC9+BE1yFBi2mBlAiiQR+MtYPIBr/fglamGRZyReQdDqgAzn1WzysGuVXiSqtWiphj319ajWVrOYmb20ysWuYh6Sjj911KyImmkyfhRRVuFKtPCQcs
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 411d67fd-5d7b-4d0d-a4fc-08d77513f52c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2019 21:34:47.5615 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2JRtk/PVZEfKzY5HxjPDs2m/L738MB6m/iGjFnxgT6J4kDmoy6I1tH34wiBOk/4Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5050
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.79.122
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
 "Oleinik, Alexander" <alxndr@bu.edu>, "bsd@redhat.com" <bsd@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 tests/libqtest.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++
 tests/libqtest.h |  3 ++-
 2 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/tests/libqtest.c b/tests/libqtest.c
index a7df92319a..e0bc5bbe0b 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -1369,3 +1369,57 @@ static void qtest_client_set_rx_handler(QTestState *=
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
diff --git a/tests/libqtest.h b/tests/libqtest.h
index 0e9b8908ef..f5cf93c386 100644
--- a/tests/libqtest.h
+++ b/tests/libqtest.h
@@ -729,7 +729,8 @@ bool qtest_probe_child(QTestState *s);
  */
 void qtest_set_expected_status(QTestState *s, int status);
=20
-QTestState *qtest_inproc_init(bool log, const char* arch,
+QTestState *qtest_inproc_init(QTestState **s, bool log, const char* arch,
                     void (*send)(void*, const char*));
+
 void qtest_client_inproc_recv(void *opaque, const char *str);
 #endif
--=20
2.23.0


