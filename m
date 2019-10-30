Return-Path: <SRS0=68uo=YX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A52DCA9EC6
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 14:52:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 604722054F
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 14:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="rJte0x4Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 604722054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPpKL-0007D3-93
	for qemu-devel@archiver.kernel.org; Wed, 30 Oct 2019 10:52:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35298)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1iPpIP-0004zq-Al
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 10:50:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1iPpIO-0007HN-66
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 10:50:01 -0400
Received: from mail-eopbgr800135.outbound.protection.outlook.com
 ([40.107.80.135]:59246 helo=NAM03-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1iPpIO-0006yI-0i
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 10:50:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YwrvYwz0RflHopOb81XsYsRHyfNGLnlWtL0SHIIzBHk3m8K5lxTpsHSJugQKdiRxGC+ucPPpP7jmEPYx9gpDz09J8vhh1CUeeKAwtYtO5ZApbApPrYkQ/2/q/lwmonAJMv2SiSrUIbrNgeb2lWv4sYF4miCtebJInp7MDk1kvpHYoDFgNbCRpCnhHUk9makfmQ7YQracUnfizKj+hiOz2vWSwKOsndz6I89AmaLdeJHzL1QbajbTAsaL8gVn3kyYNUUwDxzaQ5iLlBZOVRHRXw78QYgrqUnlSAC/EXQ4KqCMcXCJiEh96tLTCzJlyefZHk2+SjkWe84CCRSRJrRPdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4vkgg6G2jw3pa+m976iYaDVjzs3SekCfHBaK5tycshc=;
 b=Xxw3z8ZnarN79gt3NsN+8jOa4le1+E6vCKtxKVNKf1gIMi/vghl0IrVgf18fLceiJSHFv693F6pQrGJR+mzf0mA49CJAPPDR6tVKMbK7iL2QnX6M1oAYCIFr55Zo57VxnDSlvzoZoKGncou5+MAMktcNDDCvATEMngLtMQif6/O8kDmSIezojqA4UmT+v+1q0ZyEklbGgyo6kjyZiQF/oSrTuxWNxr7j3wuYf3fQYzH9kuFD6vYo3P4g0YJ/8n8qEMwHg6TsB+rkp22L3khOGvtZgCDKGTPX1GLHCx2Mmx7PjTR7r9+lshKNUZG96ilWHBecoDdT+eDtCtMNvgV0ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4vkgg6G2jw3pa+m976iYaDVjzs3SekCfHBaK5tycshc=;
 b=rJte0x4QiBZm+Dj0d3EuTuIddgrSCvWuKtun/0dPCbHjQtFJM7JJeSiiDyKvMQ5zocYdc70xx/IYCeW5ALkRxLxcdd32jpiRNtQUDfKBYnt3PGqK6d0Cr9On//nNp6c+87fGbN2br8UndqYXUMzClt2pbrMKW7RpKCcNpJIZHl8=
Received: from MN2PR03MB4800.namprd03.prod.outlook.com (20.179.82.78) by
 MN2PR03MB5054.namprd03.prod.outlook.com (52.132.170.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.17; Wed, 30 Oct 2019 14:49:54 +0000
Received: from MN2PR03MB4800.namprd03.prod.outlook.com
 ([fe80::344f:b88:26f0:9f66]) by MN2PR03MB4800.namprd03.prod.outlook.com
 ([fe80::344f:b88:26f0:9f66%7]) with mapi id 15.20.2387.028; Wed, 30 Oct 2019
 14:49:54 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH v4 07/20] qtest: add in-process incoming command handler
Thread-Topic: [PATCH v4 07/20] qtest: add in-process incoming command handler
Thread-Index: AQHVjzFKbb9pV5wyeUGaibJAvE3cXQ==
Date: Wed, 30 Oct 2019 14:49:53 +0000
Message-ID: <20191030144926.11873-8-alxndr@bu.edu>
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
x-ms-office365-filtering-correlation-id: 7f2ee95b-342c-47ee-c03b-08d75d486c9e
x-ms-traffictypediagnostic: MN2PR03MB5054:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR03MB5054442085E3F34F84CD6B37BA600@MN2PR03MB5054.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-forefront-prvs: 02065A9E77
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(366004)(396003)(346002)(136003)(39860400002)(189003)(199004)(2501003)(36756003)(476003)(86362001)(88552002)(386003)(256004)(316002)(5640700003)(1076003)(99286004)(6916009)(75432002)(486006)(786003)(11346002)(6506007)(4326008)(54906003)(186003)(2906002)(66946007)(26005)(6116002)(14454004)(446003)(2616005)(6512007)(305945005)(71200400001)(478600001)(71190400001)(81166006)(102836004)(66556008)(64756008)(50226002)(8676002)(81156014)(66446008)(6436002)(2351001)(25786009)(5660300002)(66066001)(52116002)(66476007)(6486002)(3846002)(8936002)(7736002)(76176011);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MN2PR03MB5054;
 H:MN2PR03MB4800.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PNtWIXtsiLeKQPby8RBM4cpkiYnbODYSYJLCZLAFmL/+4UfkFWgpO4JNYrm9SwdAasqVR1CmWXTft38y41GaOdiCVc35IsDG5CQLKEA3jO8VSscNYF0MvF3OZNudDZZgn3fd9TQrajtWM6ExbJN74IBdISdXwgrLpqeJV0hoR5WCiHykT2HNhC7C0oesYlSJJFg7aUkXZOVsRZ7N8eJDSkbrj/xladgJYTniJxwjiwcVt+TwBYn5YHkgDkTHZEfNkI9n7dzhLQz1Uk/IMd2wLkOWTyqQG85+q7L3T+XbaMFnxoAzL/YmL61zmAPiFs/hD5LGJTv6MaZak/FA19Sbfrn5d+LumSYyrnmB4pX7vjn2hUqWFNr2qz6cuzkmxA8P8FGpejaijdsY2Vs0q3fLXVfpyYRzV9kBB05rQwovl3adpXimbdo6MCJ7zpObawaL
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f2ee95b-342c-47ee-c03b-08d75d486c9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2019 14:49:54.0214 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2P0sUQmrqZTXQv3ijDym2KhCK7Y8PSa2k96CJgbl0mqtlyxcmO31wrdvA1EvrSOp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5054
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.80.135
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

The handler allows a qtest client to send commands to the server by
directly calling a function, rather than using a file/CharBackend

Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
---
 include/sysemu/qtest.h |  1 +
 qtest.c                | 13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/sysemu/qtest.h b/include/sysemu/qtest.h
index fda7000d2c..3f365522d5 100644
--- a/include/sysemu/qtest.h
+++ b/include/sysemu/qtest.h
@@ -28,5 +28,6 @@ void qtest_server_init(const char *qtest_chrdev, const ch=
ar *qtest_log, Error **
=20
 void qtest_server_set_tx_handler(void (*send)(void *, const char *, size_t=
),
                                  void *opaque);
+void qtest_server_inproc_recv(void *opaque, const char *buf, size_t size);
=20
 #endif
diff --git a/qtest.c b/qtest.c
index ae7e6d779d..9fbfa0f08f 100644
--- a/qtest.c
+++ b/qtest.c
@@ -802,3 +802,16 @@ bool qtest_driver(void)
 {
     return qtest_chr.chr !=3D NULL;
 }
+
+void qtest_server_inproc_recv(void *dummy, const char *buf, size_t size)
+{
+    static GString *gstr;
+    if (!gstr) {
+        gstr =3D g_string_new(NULL);
+    }
+    g_string_append(gstr, buf);
+    if (gstr->str[gstr->len - 1] =3D=3D '\n') {
+        qtest_process_inbuf(NULL, gstr);
+        g_string_free(gstr, true);
+    }
+}
--=20
2.23.0


