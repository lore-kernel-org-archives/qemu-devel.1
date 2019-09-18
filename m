Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD11C4CEC9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 23:26:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4712220665
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 23:26:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="7LdTycAG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4712220665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAjKh-0006uu-Ou
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 19:25:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33314)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1iAjEd-0000Rj-43
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 19:19:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1iAjEb-0002bE-VE
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 19:19:42 -0400
Received: from mail-eopbgr700132.outbound.protection.outlook.com
 ([40.107.70.132]:29345 helo=NAM04-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1iAjEb-0002aR-Pb
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 19:19:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h4qeWoB1OpF/5GzBvzWq7gFVjZFv7H0q7h87gByYWUft7ZTGfTA6MznJl7FiyrRb+sAYeB1JumYVg/1AYt37hp1FoT9f7tPD5th9Z5xcCvWXC9Ih+tcAC8a7ZLpxmzNxdY5PogjQCZ6PYcaEhOAokAhKxQm7s+jWuSseKVd5uEDzc3aBTbsLHdHSEvSr2XlQPJOzZ/tkVaa8KKy/UwQ6TfpTiMPG3RzyVqKNnqECUSrMtt1WBaO40fGfWosX+ecX4ZYoQdmo6oY39zivTNNB9QMW4nsnHt79Is7zRz2Arvao0+Z4tutGyFWYHsjPImYMKx9qXRxX/PSjCPDAzknPSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MDCO4pOny31wEpw6FlNn2VBGyWJRAg3gdX7mjAe1vXw=;
 b=VcQoN4d+jMug9FbNm4yRn9f7lTO3THAsVBjvHuwhogWcs8Xfd64kT1/TmSukuZa3Wt25JQbn0OBqJbWnM1uwdSf8Gxnsfk6/6ptXNQ0ehXQk7RYfqaRWaZfIULnIc6cEWBluPwzR7C1FmorB6QSmQhEI/OIux5PKLrJfZg4Ibl8/YxKvupljL3J/9Gopdl0/w246PLtUdaDu8SZ/sPEUP1HY7+ubsqQOEJVGAbTABmR91Ph+EZzAfuJUBjOeoHym+yQ68MfHjCSnT00AoWFXgguzT/sjv0novzvdcbiRqQfKs7YFmwAofHaUAcPgo7blPXEhB3jJrj495dRqaNytow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MDCO4pOny31wEpw6FlNn2VBGyWJRAg3gdX7mjAe1vXw=;
 b=7LdTycAG410FKPr/JnpiYL81EMkz7FcyWaU1lYFdGEkVBo8Fpb/UlFsCuXn7SbyFRqYzFSez1EoAU3LPYcgfNOJ7GhxHenNoTe1fl5IUjVkzAeEYfSnICkNGD26kDEnfh8e9bzb+MioqI3/04/aveQzmjtFve03UpZvKnAB/Ztk=
Received: from CY4PR03MB2872.namprd03.prod.outlook.com (10.175.118.17) by
 CY4PR03MB3016.namprd03.prod.outlook.com (10.175.117.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Wed, 18 Sep 2019 23:19:40 +0000
Received: from CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6d88:c5bd:41ad:b107]) by CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6d88:c5bd:41ad:b107%3]) with mapi id 15.20.2263.023; Wed, 18 Sep 2019
 23:19:40 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v3 13/22] libqtest: make qtest_bufwrite send "atomic"
Thread-Index: AQHVbneLvcrhrDR470+fVESmeJqVGQ==
Date: Wed, 18 Sep 2019 23:19:40 +0000
Message-ID: <20190918231846.22538-14-alxndr@bu.edu>
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
x-ms-office365-filtering-correlation-id: d6d27b62-48e4-45cc-f006-08d73c8eae4d
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:CY4PR03MB3016; 
x-ms-traffictypediagnostic: CY4PR03MB3016:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR03MB3016F15DD3061E30C7525E10BA8E0@CY4PR03MB3016.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:449;
x-forefront-prvs: 01644DCF4A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(39860400002)(366004)(376002)(136003)(346002)(396003)(199004)(189003)(66066001)(86362001)(52116002)(478600001)(2616005)(7736002)(71190400001)(8676002)(36756003)(71200400001)(14454004)(54906003)(316002)(786003)(6486002)(81156014)(75432002)(256004)(6436002)(305945005)(6916009)(6512007)(5640700003)(386003)(486006)(26005)(11346002)(186003)(102836004)(99286004)(76176011)(66946007)(446003)(476003)(66476007)(66556008)(64756008)(66446008)(6506007)(5660300002)(4326008)(2501003)(2351001)(6116002)(81166006)(50226002)(25786009)(1076003)(4744005)(2906002)(88552002)(8936002)(3846002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR03MB3016;
 H:CY4PR03MB2872.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6Hkadz7XWYL0CKtHr7xpwVQ3lzVaiUmyKGJ91+ooa8MGVwdfVGbSJ5csqzWak6sH4SUGLYOs99lkefpLqRD4yB1KdZXBeTdT+suVmZCZ7NGfzrzdSxTc6x4xchuWBRimonEnpzr6O/bZl3scg9+0bPnF7BYSDfvYg+36LY3jUTkiCj8RPjoCcUhiLqCWkslcsth8b6wgefSr3XLiIb48DIcv4fRp6DY89Ji7QyKp1WEXC5vMzRZF1ngwj1LognQE17Zz6xMbKQ8+y4LRq4n064a05NsQgDdlkdA16h3hzKnfnpFpbT7ATOtBJFAShDlPpoKXd0eNzvY0sfpKxSKrYPRxyUmtMceTLSGmMuqc+OdJiA5xB5DxlALAKc1Qw8M3f27XEXb2Tll2ZAiOLvcWGa10CaL1P7pojR6Wvg6sLC4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: d6d27b62-48e4-45cc-f006-08d73c8eae4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2019 23:19:40.5339 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +e21NMDT4a9E8cDy7puQWIfI6X0T52WptCoB0imRdBmdNxIzzAI9w8lhjtLka/zR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB3016
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.70.132
Subject: [Qemu-devel] [PATCH v3 13/22] libqtest: make qtest_bufwrite send
 "atomic"
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

When using qtest "in-process" communication, qtest_sendf directly calls
a function in the server (qtest.c). Combining the contents of the
subsequent socket_sends into the qtest_sendf, makes it so the server can
immediately handle the command, without building a local buffer and
waiting for a newline.

Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
---
 tests/libqtest.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tests/libqtest.c b/tests/libqtest.c
index 19feea9e17..d770462869 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -1086,9 +1086,7 @@ void qtest_bufwrite(QTestState *s, uint64_t addr, con=
st void *data, size_t size)
     gchar *bdata;
=20
     bdata =3D g_base64_encode(data, size);
-    qtest_sendf(s, "b64write 0x%" PRIx64 " 0x%zx ", addr, size);
-    socket_send(s->fd, bdata, strlen(bdata));
-    socket_send(s->fd, "\n", 1);
+    qtest_sendf(s, "b64write 0x%" PRIx64 " 0x%zx %s\n", addr, size, bdata)=
;
     qtest_rsp(s, 0);
     g_free(bdata);
 }
--=20
2.23.0


