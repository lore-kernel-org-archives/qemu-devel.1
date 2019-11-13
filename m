Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30110C432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 23:04:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F018D206E3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 23:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="pXLz84KX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F018D206E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iV1gf-0003Yd-U3
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 18:04:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34043)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1iV1TR-00084s-Fg
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 17:50:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1iV1TP-0007hG-QJ
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 17:50:53 -0500
Received: from mail-dm3nam03on072d.outbound.protection.outlook.com
 ([2a01:111:f400:fe49::72d]:36592
 helo=NAM03-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1iV1TP-0007S1-HT
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 17:50:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bvOugvaFszBzaBv36clIAOYO4jTLpZKeeeNKR0Tf4W5cZuO6gp/eDgOQEoI6kYHNJsG4ANwOHCmef0SnMdY2gFOfK8tLcS54hIpYCDbkBv+I2cEVs3CiS5amuTG+fsLbB/R+FE8YlbSGziSNbQoNg6qPmof9faUblb6sidy7S4lGLLtrfDx6MHSuaU/vuweR4C7Ip8UcobDBjh387Wao31s4YIiv+Foqaf2ehYgwh2qxiKNeH1/EOg9Rea0KbF2Y6RkMc3Y1Kkcktj90NfPud4bMmI0P6zL9E+E0ihqq7+w1f0J/Rmp5lVnNyL1PFxapvv9SzzWvXS9y5BzZjxougg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e8dQOM8bA78C2yu/nzBMIoidszvSz9Ngpr1huYzUlBw=;
 b=Af5C5HDK0vpDHNWKY/hKnxnvDEQLRHTFvzglLsUijE04kBUxetcEw8jq52OiHlo8rJJCM+2sZfUXoD57W/yhxD3Vnl+BY8X73MnnFBbrqMOcTAG/L/3b/YDLxW7td3sF3QW1oYmJimfUFTNNAIppximCgBUy0PCZ6SpOe0dNPsNbZ5YgpT3OqmfXWeZOZgdPltNM7oyviaQ5iKm/XfP/n7xP1VmwbWK0iUUZOSjzEQ2m2OepbQpkasdEbsP8sZdDSAFCInSSMJOKiAITxJmapNPukNJHDzAOiqUtk0mUH86e/x+Highr4pVXxGBalsbce52Y2ohj9wkr1nEINIs1xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e8dQOM8bA78C2yu/nzBMIoidszvSz9Ngpr1huYzUlBw=;
 b=pXLz84KXtnrx8uiZqyKKzUeEpdve5OLXyRLYqI63tvsrvWSocuDB11fb6Uq1CJggEjH7g0rz1rnKrLL/o4BJ2iHJJxFuEcftSXmgI4ze6EISAsubF5sxz44cUK4Wm3FPf8EWi1MHtdgtV8iyuevMNaOoQKrZcRDOY1TWfn/OsGU=
Received: from MN2PR03MB4800.namprd03.prod.outlook.com (20.179.82.78) by
 MN2PR03MB5024.namprd03.prod.outlook.com (52.132.169.72) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Wed, 13 Nov 2019 22:50:49 +0000
Received: from MN2PR03MB4800.namprd03.prod.outlook.com
 ([fe80::344f:b88:26f0:9f66]) by MN2PR03MB4800.namprd03.prod.outlook.com
 ([fe80::344f:b88:26f0:9f66%7]) with mapi id 15.20.2451.023; Wed, 13 Nov 2019
 22:50:49 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH v5 12/20] libqtest: add in-process qtest.c tx/rx handlers
Thread-Topic: [PATCH v5 12/20] libqtest: add in-process qtest.c tx/rx handlers
Thread-Index: AQHVmnTLE1DwLBXUZkGd4DkJ8KXFBA==
Date: Wed, 13 Nov 2019 22:50:49 +0000
Message-ID: <20191113225030.17023-13-alxndr@bu.edu>
References: <20191113225030.17023-1-alxndr@bu.edu>
In-Reply-To: <20191113225030.17023-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.23.0
x-originating-ip: [128.197.127.33]
x-clientproxiedby: MN2PR15CA0028.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::41) To MN2PR03MB4800.namprd03.prod.outlook.com
 (2603:10b6:208:101::14)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6fa47e02-607c-4241-e633-08d7688bed69
x-ms-traffictypediagnostic: MN2PR03MB5024:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR03MB502420A25D18A76B087F4FCBBA760@MN2PR03MB5024.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:153;
x-forefront-prvs: 0220D4B98D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(366004)(136003)(376002)(346002)(39860400002)(199004)(189003)(2501003)(88552002)(75432002)(54906003)(446003)(7736002)(99286004)(11346002)(6436002)(6486002)(5640700003)(476003)(305945005)(256004)(786003)(2906002)(2351001)(14444005)(316002)(14454004)(6116002)(86362001)(2616005)(6512007)(6916009)(486006)(3846002)(71200400001)(71190400001)(4326008)(1076003)(36756003)(386003)(8676002)(478600001)(66066001)(76176011)(81166006)(186003)(66946007)(5660300002)(6506007)(81156014)(64756008)(52116002)(26005)(102836004)(50226002)(25786009)(8936002)(66476007)(66556008)(66446008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MN2PR03MB5024;
 H:MN2PR03MB4800.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vVVeATAI+k/tGl6qkYqbeg31AzhIgEbop4icP/13OEbdr96HoM/vVq4Ho2bXRTT62rTRxdYNkzsvt+8nWIkkfur/tGpbaB+Kb8wzs7HdZAW5iWZ4XaE5Xap+RUXlbtdKI1eF5kQNSpWd4bo7pAOzaHIfvEtmkRo3A8Zr0MWdplS6EBm8ZF4hp1u3yfRIbvAG2HZw9ux2aF5DLwShy3/3m1+D6jEYgt82jBPAa0EVf0Ixd+H3Bhjk4RBYo64UBnnqgwyHiSJrDSIhaO/Y9ggP5axNp2CsRb0izlt6oNYRrJASOeFQaMM4aefhulaTdHForuzLfGW/+JQQKl+Q9u2hG9tocCaXsvtJraFs4q5XxIxNhwTlNjjLtakpPkeo3CG6MaMYPLgrOSLpOvPL3DFR2KDoNarR18nPsyrjC4bdcgF00rF4VG5pBIfX8nzch7Yu
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fa47e02-607c-4241-e633-08d7688bed69
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 22:50:49.1556 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yi/n1clm/HxTkgs0o+Xec6S9RdjuOkh+n/rK/CwOKIYNwOjLVCpTU6XTFJAmv+x0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5024
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe49::72d
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
index 6d3bcb6766..da0e5c7ef8 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -1368,3 +1368,57 @@ static void qtest_client_set_rx_handler(QTestState *=
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


