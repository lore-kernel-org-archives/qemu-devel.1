Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A7F1C4CEC4
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 23:40:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7488218AE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 23:40:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="YENhJ99D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7488218AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAjYc-0004Ts-2P
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 19:40:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33341)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1iAjEe-0000Tv-Ov
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 19:19:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1iAjEd-0002cU-Cw
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 19:19:44 -0400
Received: from mail-eopbgr700101.outbound.protection.outlook.com
 ([40.107.70.101]:49633 helo=NAM04-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1iAjEd-0002bn-7N
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 19:19:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JCCNtlROGkUtPHU2ZrFRO2erDb1nC2h4CmBOp9lwrC4O7hFIq48fCdfXbEixzpHs+pCanXrDJg1cnaLfLiI3TB0xk8HaiBnNtsTA9We+qEglpSBlwvZ8lz2y2OZcRQiTy22wMqBvSK6SoIF0lEX9SjSEyZM79ueUB5h/BDWqF1l7lv5zCjiy8w/HU+1Qb8ua1cTbYUFx3JokOzjekPY0dG3QnXZy+1+FYkOSWrwnKsquYPLGS1C5lYTpR+aYUzrOWXzYCeRB6nXzJALLhk4pCYkYLRDwhEmQzsNVR2QnqM3Gaqfnk6/m/k75KzuchdIKKJQYSD9VSASAixNvN5fkfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lc2CkDJQcimdztENGOPGbCknWpSubB8TVQhQIzeytxU=;
 b=ImA9Q5E8iLhj7/f9+Hk8RDtT7S6MHSo81rKIh6OtHb+BrahL1jG4CgILG9miGQpu6RHw3dcgKsIhsFtal8xw8tZYkUWb+DRgqeLKbD6bobM9y0igTnu11qF2WJYOryr7M8WyceSuVEU78TlmxdQl23hk2jZWqlpf2vYksrn7njRukiovYXHENhyofpe+WppYko5WZwDeCr4gD+Tmto1xwmZhpjKxI0JiGzYMaPlYglYTjs7uZvmbwNFlQpMvd/4PHw5Hofe9YLWyTTzCLWVVkfnXvwUSGCzaAQGOFpjdV1IWgMgwydPi+qKQ3qNmumAIKm06VqGxvPHVt+//fU3RCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lc2CkDJQcimdztENGOPGbCknWpSubB8TVQhQIzeytxU=;
 b=YENhJ99DEclITEk6nYKQzXh64l0Rr+3W+P0hhN9NNQ0Da2bpMcfqlgpYVCnwNLvdSIZQYmFZFdk/wB5IfFVeD914GQFUN+ldyECquWystWeuNbUo6/fx7mtpyjdFtu+Y79I4E4IED9WDQqwAtdwoGXhWDAD5Z9dTliPLw48n6XM=
Received: from CY4PR03MB2872.namprd03.prod.outlook.com (10.175.118.17) by
 CY4PR03MB3016.namprd03.prod.outlook.com (10.175.117.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Wed, 18 Sep 2019 23:19:41 +0000
Received: from CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6d88:c5bd:41ad:b107]) by CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6d88:c5bd:41ad:b107%3]) with mapi id 15.20.2263.023; Wed, 18 Sep 2019
 23:19:41 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v3 14/22] libqtest: add in-process qtest.c tx/rx handlers
Thread-Index: AQHVbneM5DHTVNsf2EWK27C25kPhHA==
Date: Wed, 18 Sep 2019 23:19:41 +0000
Message-ID: <20190918231846.22538-15-alxndr@bu.edu>
References: <20190918231846.22538-1-alxndr@bu.edu>
In-Reply-To: <20190918231846.22538-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.23.0
x-originating-ip: [128.197.127.33]
x-clientproxiedby: BL0PR02CA0124.namprd02.prod.outlook.com
 (2603:10b6:208:35::29) To CY4PR03MB2872.namprd03.prod.outlook.com
 (2603:10b6:903:134::17)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: daacef9f-c631-40af-40b6-08d73c8eaeec
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:CY4PR03MB3016; 
x-ms-traffictypediagnostic: CY4PR03MB3016:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR03MB3016D3EC19695025149EBB89BA8E0@CY4PR03MB3016.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:130;
x-forefront-prvs: 01644DCF4A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(39860400002)(366004)(376002)(136003)(346002)(396003)(199004)(189003)(66066001)(86362001)(52116002)(478600001)(2616005)(7736002)(71190400001)(8676002)(36756003)(71200400001)(14454004)(54906003)(316002)(786003)(6486002)(81156014)(75432002)(256004)(6436002)(305945005)(6916009)(6512007)(5640700003)(386003)(486006)(26005)(11346002)(186003)(102836004)(99286004)(76176011)(66946007)(446003)(476003)(66476007)(66556008)(64756008)(66446008)(6506007)(5660300002)(4326008)(2501003)(2351001)(6116002)(81166006)(50226002)(25786009)(1076003)(2906002)(88552002)(8936002)(3846002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR03MB3016;
 H:CY4PR03MB2872.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: E0EPodqjCzPuxjT7tzn6n/VV7DDniVYADVshCxBnOUPOKr8Q1SdvF7z+DKC2rQikeN8vvlj35oHpL18Ho+FOTrshohEpO7Mh1BpUDSQPXmFo3tEgtfRa/t69u1FgYPHlgkZM8GsLvYgDR8rQ88ass7p2idtF4kjQX5O4UW8WOAuEXTxv+6bHUqDVD46t2OJDTA+EpnszThPvQ1zRGQ95J8zDnwiSYbD+8fZgq1ZjnqpWoT0nHJS3N/398/woMsv9IjcSod5qgVegAoku/4OIDmL/Bnetj9wq8yNOHoPaJH9hUtkguwLxnL2tbDS/7yBqDCaWdMoP3suVx3/+0KYeAtjn+4dItNk9ZoIiWQ80g5ABhsbzotgogYQiNGrHMKqn0lw0SM4B6GiUXDqswRv2vWuwyVwRMkXnLg1EMiTKvI8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: daacef9f-c631-40af-40b6-08d73c8eaeec
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2019 23:19:41.5635 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G7Kp5974IpaOhcQHYennV0UWEi8nENBL27p1jrSsNXk33olXoFo4IBxT9qrK+61F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB3016
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.70.101
Subject: [Qemu-devel] [PATCH v3 14/22] libqtest: add in-process qtest.c
 tx/rx handlers
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

Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
---
 tests/libqtest.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/libqtest.h |  5 +++++
 2 files changed, 51 insertions(+)

diff --git a/tests/libqtest.c b/tests/libqtest.c
index d770462869..fc10322d52 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -60,6 +60,7 @@ struct QTestState
 static GHookList abrt_hooks;
 static struct sigaction sigact_old;
 static GString *recv_str;
+static const char *qtest_arch;
=20
 static int qtest_query_target_endianness(QTestState *s);
=20
@@ -490,6 +491,7 @@ static GString *qtest_client_socket_recv_line(void* opa=
que)
     return line;
 }
=20
+
 static gchar **qtest_rsp(QTestState *s, int expected_args)
 {
     GString *line;
@@ -830,6 +832,9 @@ char *qtest_hmp(QTestState *s, const char *fmt, ...)
=20
 const char *qtest_get_arch(void)
 {
+    if (qtest_arch) {
+        return qtest_arch;
+    }
     const char *qemu =3D qtest_qemu_binary();
     const char *end =3D strrchr(qemu, '/');
=20
@@ -1367,3 +1372,44 @@ static void qtest_client_set_rx_handler(QTestState *=
s,
     s->ops.recv_line =3D recv;
     s->ops.recv_line_opaque =3D opaque;
 }
+
+static GString *qtest_client_inproc_recv_line(void* opaque)
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
+    qtest_client_set_rx_handler(qts, qtest_client_inproc_recv_line, qts);
+    qtest_client_set_tx_handler(qts, send, NULL);
+
+    qts->big_endian =3D qtest_query_target_endianness(qts);
+    qtest_arch =3D arch;
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
index 40fa235a52..453bd8998f 100644
--- a/tests/libqtest.h
+++ b/tests/libqtest.h
@@ -716,4 +716,9 @@ bool qtest_probe_child(QTestState *s);
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


