Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84306C433FF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 03:13:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A8DA2075C
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 03:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="gfxD6MTv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A8DA2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huTRC-0004aO-K4
	for qemu-devel@archiver.kernel.org; Sun, 04 Aug 2019 23:13:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57800)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alxndr@bu.edu>) id 1huTQp-0004BY-BY
 for qemu-devel@nongnu.org; Sun, 04 Aug 2019 23:13:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1huTQo-0007pu-Bl
 for qemu-devel@nongnu.org; Sun, 04 Aug 2019 23:13:07 -0400
Received: from mail-eopbgr760120.outbound.protection.outlook.com
 ([40.107.76.120]:43669 helo=NAM02-CY1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1huTQo-0007mb-48
 for qemu-devel@nongnu.org; Sun, 04 Aug 2019 23:13:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j17vv6hzfxzePHyGHsFR7HKz6Ovcbv2q4+JoRoYFAXKguMCYPEt1IKUn//g/24eISfyK02/nbdfvODiBsfBqJXWvot+iYo4T5mJfIJsBrklTpzSNpV5eMFdTUiJIUqQ50CgRl5nzl/GTUZSv989dDofa2Nnqw+cnZHL3Mi39E+d327ulWkVo6+paOXQvRWcD9kQlVV5EeL+TjLrt7yOimBO7ApmAgKA9LKcf8mxDpKaxQzO0rZJTEllpDEVdGUW1O8m322vabC56OGmOK+j62PQc8I6XavOenK+24F2R5Pnp6rJADssHjdKDUj3HSRGO7Z2TvDwCbcTsUtTqpAdb3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MZ+uwPae1WRhp/i+GaZswWUDiVExYHybMfR6MwdbcwI=;
 b=oaQCP/lbXc4Kl1BZy/znZAcvVlhEWEQlROI1iu/Zw7L9tiY3u8yQbwfRIXYPHNwKmDIteSxutrFjlXBAQ67b44aRIzK2phPM8l3JwRxUInyTrS+WHwC0XXL/UDhyJzT4kntpVunTO6WNRhqLrb8EllXPiXc0ZTOlvGBsKyiG8Dpm4H8ADZbbbA6jVWy0KQJUXbmJeOGEwcZQKiSZx8A0qgj9K81cpzULawXRXZFwR5HLulDxmbz5CeFDWoMBvfoZ8BvmXlKsEhJ5Kg2RoIhkNtfP8MokanOr4e7l3D2uhWKF/CanRjN6KX/qauo4TzyippLQ17Z0BfipZPXfDB3zwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=bu.edu;dmarc=pass action=none header.from=bu.edu;dkim=pass
 header.d=bu.edu;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MZ+uwPae1WRhp/i+GaZswWUDiVExYHybMfR6MwdbcwI=;
 b=gfxD6MTvGZxOEQ/PfGd87GHTwlmHW3qy5hc+nofUdzVh+u848ZqJeKLxd6xzWGSa5yFu0XRgMKzLvB11oWQUe9mCnUkk+9APNeLjrHvcPYeFYGaVOsRcTYvoVCSar7nPp6l2LviKXbyEj3oBorklTCtW1kCEA4bZ9ZaNZqhfk/8=
Received: from CY4PR03MB2872.namprd03.prod.outlook.com (10.175.118.17) by
 CY4PR03MB2853.namprd03.prod.outlook.com (10.175.116.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.13; Mon, 5 Aug 2019 03:13:01 +0000
Received: from CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6cce:cc85:9e3:d33a]) by CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6cce:cc85:9e3:d33a%4]) with mapi id 15.20.2136.018; Mon, 5 Aug 2019
 03:13:01 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH] qtest: Rename qtest.c:qtest_init()
Thread-Index: AQHVSzuwXAo7kU22bEmHiss0yqO+mw==
Date: Mon, 5 Aug 2019 03:13:01 +0000
Message-ID: <20190805031240.6024-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.20.1
x-originating-ip: [128.197.127.33]
x-clientproxiedby: MN2PR19CA0068.namprd19.prod.outlook.com
 (2603:10b6:208:19b::45) To CY4PR03MB2872.namprd03.prod.outlook.com
 (2603:10b6:903:134::17)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b3095de5-4aa5-4930-6b82-08d71952d2f0
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:CY4PR03MB2853; 
x-ms-traffictypediagnostic: CY4PR03MB2853:
x-microsoft-antispam-prvs: <CY4PR03MB2853DC4A0F161F1D4525338ABADA0@CY4PR03MB2853.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 01208B1E18
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(979002)(4636009)(39860400002)(376002)(346002)(366004)(396003)(136003)(199004)(189003)(36756003)(6486002)(75432002)(68736007)(6512007)(14454004)(478600001)(53936002)(66446008)(64756008)(66556008)(66476007)(6916009)(486006)(256004)(476003)(2616005)(71190400001)(71200400001)(5640700003)(6436002)(66946007)(66066001)(2906002)(5660300002)(102836004)(88552002)(99286004)(25786009)(786003)(316002)(8936002)(7736002)(54906003)(81166006)(81156014)(1076003)(2501003)(386003)(6506007)(305945005)(186003)(8676002)(4326008)(26005)(50226002)(2351001)(52116002)(3846002)(86362001)(6116002)(42522002)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR03MB2853;
 H:CY4PR03MB2872.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: uYRgjDn/xISTpjc1l2bVjjiaTjGg5P61RTxI3lNKx/1Lnrcpsq1Jlb2qYBexziKe4gVtW5uKCEQKdHlEnVqmzC19mnl+pFMBotWkAMifyA/Ba9msqkonFZlxw0sJIe93MNGZlJY7NEhyclLb/Sz5BI3UcI32eA9FJNGu2x8Y5Am0eXpwEKk8mv1ZnpFMfdeFGImlMe8vRUuB2aKcH+oOZlI43+dLN4PZPmIkYscUOqWHPUPI4zE0zzy50VqwZ7cFam2ZlgS08Up9npsTiiZgRAUS7P7BUdhjAQq+Y3yw/XHYdoEX/MqDpV+yqH9fp7mhKlHjMwbOz5rNRT5UCmh0PC4wXTNJW6fu2ymjLjmINxkQdiKFoIiEqj1oph61V78viQU7w3lcFXxWH9UlU9ZMDhyCo60pUvT3JT7dPKCT9Dc=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: b3095de5-4aa5-4930-6b82-08d71952d2f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2019 03:13:01.6007 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: alxndr@bu.edu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2853
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.76.120
Subject: [Qemu-devel] [PATCH] qtest: Rename qtest.c:qtest_init()
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
Cc: Laurent Vivier <lvivier@redhat.com>, "thuth@redhat.com" <thuth@redhat.com>,
 "Oleinik, Alexander" <alxndr@bu.edu>, "bsd@redhat.com" <bsd@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Both the qtest client, libqtest.c, and server, qtest.c, used the same
name for initialization functions which can cause confusion.

Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
---
Thank you, Thomas Huth for the suggestion.

 include/sysemu/qtest.h | 2 +-
 qtest.c                | 3 +--
 vl.c                   | 2 +-
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/sysemu/qtest.h b/include/sysemu/qtest.h
index cd114b8d80..5ed09c80b1 100644
--- a/include/sysemu/qtest.h
+++ b/include/sysemu/qtest.h
@@ -24,6 +24,6 @@ static inline bool qtest_enabled(void)
=20
 bool qtest_driver(void);
=20
-void qtest_init(const char *qtest_chrdev, const char *qtest_log, Error **e=
rrp);
+void qtest_server_init(const char *qtest_chrdev, const char *qtest_log, Er=
ror **errp);
=20
 #endif
diff --git a/qtest.c b/qtest.c
index 15e27e911f..c9681dbdf3 100644
--- a/qtest.c
+++ b/qtest.c
@@ -748,8 +748,7 @@ static void qtest_event(void *opaque, int event)
         break;
     }
 }
-
-void qtest_init(const char *qtest_chrdev, const char *qtest_log, Error **e=
rrp)
+void qtest_server_init(const char *qtest_chrdev, const char *qtest_log, Er=
ror **errp)
 {
     Chardev *chr;
=20
diff --git a/vl.c b/vl.c
index b426b32134..130a389712 100644
--- a/vl.c
+++ b/vl.c
@@ -4197,7 +4197,7 @@ int main(int argc, char **argv, char **envp)
     migration_object_init();
=20
     if (qtest_chrdev) {
-        qtest_init(qtest_chrdev, qtest_log, &error_fatal);
+        qtest_server_init(qtest_chrdev, qtest_log, &error_fatal);
     }
=20
     machine_opts =3D qemu_get_machine_opts();
--=20
2.20.1


