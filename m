Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F51CC33CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 05:37:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECCCF2071E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 05:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="OV4iy/8r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECCCF2071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwg2D-0004Sn-6I
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 00:37:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44772)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1iwfza-0007pk-Ga
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 00:34:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1iwfzZ-0001vz-Ed
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 00:34:22 -0500
Received: from mail-mw2nam10on2110.outbound.protection.outlook.com
 ([40.107.94.110]:45280 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1iwfzZ-0001tn-8G
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 00:34:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mw+zh3hnm5CuYequdKL2JL8+y5Y40aWGP+BdqiAxz07g9LJMlmKd0Y+2XIKSPL3BswrpsHiG9w1Vdod4Nk3VmwOZE1km2oJR1Ng8Ul86oqbv7FJry78bWDa99P2BGVhy69bf4iMi5AyK0N7twDf/IRP6oL7L9g80YPRm74MS+iTuAkpgP/7TNUgCJhfOnH0ZZgwKXiUQDgRfPlwVhe5QjlmUESMmKy+Je3yoWhWxymYUGU/lT35zMWrYvrVx+0FPdAQkayxo710hUMXr0TtMJQiB2MMutXhnhlXae7JNiwt2mk+t6FIdjTHPuKPcFwJvSiJ2u+xpLjzAX0/w03hO+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9pyU+EWwWoz7a+tVKk2F3sx5oHPPmQUWy8kzp3v+g28=;
 b=EIa6vE583RIBRstJmFzd0yLPhzfvkGF2jWj3MHHY8iiba/t6Qcio6oJ3DpaCnyqZ2JqKra/hflZvIwV4+c30zllKhoAqBCpmucGeRfmyIQHZKORqfMOpQSgn94nouI4vV/DayJU6qb0d7IsY5dW8X5umhA17EZckGjqeF/dsWx8xPRZFPE80yrb8ITE1H3GQK6MBcxLptiBhF6Z+e8G7EKuKZbI/49H7HTpsupNiFoHMYySzLWIztdCUI/+db6B2CxujlhQzKmz8mYGEomEGYeHSGfIVVjuWBUF9M4RceUyJ9C8OveY3a1+6zjXE5svPXL89GWUIJ11bBQlQDxbXzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9pyU+EWwWoz7a+tVKk2F3sx5oHPPmQUWy8kzp3v+g28=;
 b=OV4iy/8rRXe9qZRkqe8z0t2hurflIhdPduyhNw5LFayu1/qZZB3YrVQv7gLIGdN/NiK/zvNGcXBlT4e03a98fTOCPUV79WDG1xHz2O/mB7WKDQMZrXCzOLCHMCzfU5X3BJI+FYI0lFThmToCy5ygUFyFc9i3vRoSbJDBOst6VGc=
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (52.135.102.32) by
 SN6PR03MB4206.namprd03.prod.outlook.com (52.135.110.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.20; Wed, 29 Jan 2020 05:34:20 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8%7]) with mapi id 15.20.2665.026; Wed, 29 Jan 2020
 05:34:20 +0000
Received: from mozz.bu.edu (128.197.127.33) by
 MN2PR05CA0029.namprd05.prod.outlook.com (2603:10b6:208:c0::42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.19 via Frontend Transport; Wed, 29 Jan 2020 05:34:16 +0000
From: "Bulekov, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH v8 07/21] qtest: add in-process incoming command handler
Thread-Topic: [PATCH v8 07/21] qtest: add in-process incoming command handler
Thread-Index: AQHV1mW/jLQxr4PAlUSaT2U/4rKEEA==
Date: Wed, 29 Jan 2020 05:34:17 +0000
Message-ID: <20200129053357.27454-8-alxndr@bu.edu>
References: <20200129053357.27454-1-alxndr@bu.edu>
In-Reply-To: <20200129053357.27454-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.23.0
x-originating-ip: [128.197.127.33]
x-clientproxiedby: MN2PR05CA0029.namprd05.prod.outlook.com
 (2603:10b6:208:c0::42) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cb54efd7-e4d7-45a8-ce7b-08d7a47ce1fe
x-ms-traffictypediagnostic: SN6PR03MB4206:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR03MB42067014AC33319403A53557BA050@SN6PR03MB4206.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-forefront-prvs: 02973C87BC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(376002)(136003)(366004)(346002)(396003)(39860400002)(189003)(199004)(478600001)(75432002)(36756003)(316002)(6916009)(2906002)(786003)(4326008)(54906003)(26005)(186003)(956004)(2616005)(6486002)(7696005)(52116002)(16526019)(1076003)(5660300002)(71200400001)(86362001)(66446008)(66556008)(66946007)(66476007)(8936002)(81156014)(81166006)(64756008)(8676002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SN6PR03MB4206;
 H:SN6PR03MB3871.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7eJ46z4wLzOsE/kllf7fTsAp4liJ9QThL0GD95e5Kw5LhNA15zYg2zNy/IDHYx/sm9sg/AeYPYsPUcp1PYVS4vokCyP8ctMNFzmbrkQCPDjIHkNybmYk7P8QyP2sCpFitoAMfzni+Q+wdPzGktot1JJgjPg6TFgsgbmFxQD0a5jZLqgVpf5YluUo1hJEQI4KobHsAWk9teXbAX2q5ZS1LGPxlRy+VXxSyn0Ty/5Co78S9/9cIxwDw8i6GotzbISRRAPZPI5Y+yZPeVDm0fuTTuzsQ9XmGHyqDtdh7hp3NGINijionOX0vzZDiGUW4dRcPy0JEjOB2+YEO0NmFlqGWXANpSjb+DBMYM8dLaVxktxv0g6iGhGs19CnjEQtW+69yiAuwXIK9D2QS5qQMA5KqMMzPIC7FS03aJLw/FkL+0yvDBCs+VM/t9w+QOW+bGIY
x-ms-exchange-antispam-messagedata: MHIn2iC2/fUP4vHzP/krIg96wDVsodFPVvuEfMhsuhwg+rVTTruBnv2MrWgZN2JM02pBqw6q4UJN9e+ymfkGkvN7VA5PzPW9XnRUn/VYIt6M3RyMeW5+H+EbgMlTajK0Gl4oup8kbaBFncfwFYokig==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: cb54efd7-e4d7-45a8-ce7b-08d7a47ce1fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2020 05:34:17.2935 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2THVo8HFEp4OMuVOUEkb1E205Dv6Z5qjM0p/w4R7xQM7Y01DyWn3/zuQOuScK0JR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB4206
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.94.110
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

The handler allows a qtest client to send commands to the server by
directly calling a function, rather than using a file/CharBackend

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/sysemu/qtest.h |  1 +
 qtest.c                | 13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/sysemu/qtest.h b/include/sysemu/qtest.h
index e2f1047fd7..eedd3664f0 100644
--- a/include/sysemu/qtest.h
+++ b/include/sysemu/qtest.h
@@ -28,5 +28,6 @@ void qtest_server_init(const char *qtest_chrdev, const ch=
ar *qtest_log, Error **
=20
 void qtest_server_set_send_handler(void (*send)(void *, const char *),
                                  void *opaque);
+void qtest_server_inproc_recv(void *opaque, const char *buf);
=20
 #endif
diff --git a/qtest.c b/qtest.c
index 938c3746d6..ad6eb6a526 100644
--- a/qtest.c
+++ b/qtest.c
@@ -803,3 +803,16 @@ bool qtest_driver(void)
 {
     return qtest_chr.chr !=3D NULL;
 }
+
+void qtest_server_inproc_recv(void *dummy, const char *buf)
+{
+    static GString *gstr;
+    if (!gstr) {
+        gstr =3D g_string_new(NULL);
+    }
+    g_string_append(gstr, buf);
+    if (gstr->str[gstr->len - 1] =3D=3D '\n') {
+        qtest_process_inbuf(NULL, gstr);
+        g_string_truncate(gstr, 0);
+    }
+}
--=20
2.23.0


