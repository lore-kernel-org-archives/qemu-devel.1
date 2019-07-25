Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A36C76186
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 03:27:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6288A22AED
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 03:27:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="tw9/XZ3s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6288A22AED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55533 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqUPK-0008Uh-7X
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 23:27:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40268)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alxndr@bu.edu>) id 1hqUMJ-0004PZ-8E
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 23:24:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1hqUMI-0001rj-BL
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 23:23:59 -0400
Received: from mail-co1nam04on072e.outbound.protection.outlook.com
 ([2a01:111:f400:fe4d::72e]:55968
 helo=NAM04-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1hqUMI-0001rP-5Q
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 23:23:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pa/Oiau3KUiCrCcR3dGKA0rBX47mYjxsKCxFBKE2aOU+KhX+e9GXw3IyDb/JQvlzmV0KDqamA6OlKtWsJOZ0A310o9oSShMwcS6p6qEfvqzNwBsfs4nuCSoSAw+b+APXmOfxLG5y3TXkImtX2kZcFbsFh8wf9KiaFaPtxKNGOgBEy757BKoI6iNs7W0QRy8RymxE/yzd3mL0h5vSHE2z70ybW3KArsuvu/YieWOPpkLLIjo4Lp+L6SM36TZrj/7KNCIpn6t48ZApD5ltGAQctv4noXQ53p2iuEgicOEZP2eJm3aqsbLYwmTONIgnS+dKP+do6B4a/ztvLM32lQEs0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pIYOjl3LbiEWLk7hFilndmx4r7yoQ+ASXVA6yOJ1QJ0=;
 b=ZYO4/P4aUOE1hm/SZNWRVq9WTAHmkkyavHRTpSiFvlDwDi7m8GgXsnUFreRYwD1eBnBkbCU8jjoMf5k99OyGLp6JiX/oXtNWuahqHDrjV00goVU9QN7l/qqJCYIJHOAn9/Iyrc90T8oS99zslDogTi6kwda55nYXI+JyBKBoP4Rf3GkBIiOlAT+xO2zQTal01pkTDmrWxh5X+QCglds8M0LY6KgE8DJvpwfEySN4HzD3aF4K6SXz8lwj5IMBDJYUXpkzzVyjJ9VWfMN8ABe1IHy/b9KBH4Jdfg+WL5bGjWzGqOZEeEP8812y/uamNm7yiXSq8U/p2be5Qok8Q6epSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=bu.edu;dmarc=pass action=none header.from=bu.edu;dkim=pass
 header.d=bu.edu;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pIYOjl3LbiEWLk7hFilndmx4r7yoQ+ASXVA6yOJ1QJ0=;
 b=tw9/XZ3sqIrJyM5jlww57l0OIVvvJowLnBFhdE+F5K6DQj0bVFtkbJkxNiQLYoQmMZqukHjmR/UyftgjHhmKdYbtkTptsajYRTJmWvvVPjlqz6RPOQ7FcqeGyA6KzGGIYNTGDRPfhuboLgC1BK9EkAL/z3szkQEahjHk5owEqa0=
Received: from CY4PR03MB2872.namprd03.prod.outlook.com (10.175.118.17) by
 CY4PR03MB2726.namprd03.prod.outlook.com (10.173.40.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.16; Thu, 25 Jul 2019 03:23:56 +0000
Received: from CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::25e1:d1e3:2ad8:e6b5]) by CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::25e1:d1e3:2ad8:e6b5%5]) with mapi id 15.20.2094.013; Thu, 25 Jul 2019
 03:23:56 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [RFC 14/19] fuzz: hard-code a main-loop timeout
Thread-Index: AQHVQphk0S7/fKH5wUWyBBMtllhjZQ==
Date: Thu, 25 Jul 2019 03:23:56 +0000
Message-ID: <20190725032321.12721-15-alxndr@bu.edu>
References: <20190725032321.12721-1-alxndr@bu.edu>
In-Reply-To: <20190725032321.12721-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.20.1
x-originating-ip: [128.197.127.33]
x-clientproxiedby: BL0PR02CA0039.namprd02.prod.outlook.com
 (2603:10b6:207:3d::16) To CY4PR03MB2872.namprd03.prod.outlook.com
 (2603:10b6:903:134::17)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 932a99d7-0cb5-4e7e-ff63-08d710af86c2
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:CY4PR03MB2726; 
x-ms-traffictypediagnostic: CY4PR03MB2726:
x-microsoft-antispam-prvs: <CY4PR03MB27264BA7EFEDCCA493854082BAC10@CY4PR03MB2726.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:296;
x-forefront-prvs: 0109D382B0
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(366004)(136003)(396003)(39860400002)(376002)(346002)(199004)(189003)(50226002)(3846002)(53936002)(6512007)(14454004)(66066001)(5660300002)(6116002)(25786009)(4744005)(68736007)(316002)(99286004)(54906003)(1076003)(2351001)(2501003)(2616005)(75432002)(7736002)(76176011)(52116002)(305945005)(6436002)(71200400001)(6506007)(26005)(6916009)(478600001)(8936002)(5640700003)(786003)(86362001)(4326008)(256004)(88552002)(71190400001)(386003)(2906002)(476003)(66946007)(446003)(11346002)(8676002)(81156014)(81166006)(66476007)(66446008)(36756003)(6486002)(66556008)(64756008)(486006)(186003)(102836004)(42522002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR03MB2726;
 H:CY4PR03MB2872.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gCJOYT9o3fb1UlD2VyjpjEiYrGZyeH2dEPQgjVnFQtzRrY5wAoi8xJupmt/Aijmp5Qlro6mm6vFgSuMf3QcWExbN4nLu1Xif/Hre4GvPuee0fMEpon1pecN6XHvde0ZiD0Y/GFqZ+iAmQvw25uJo2v7bL3ESE8uZzgpAwCx5RfGqa6ibg1R7hn62wQJ5R4W+u1XTCkSbHrbF1Pfj3LxnNpZIAUUc+xOQ9iHRJJXOM65lQcWb+Xnw12/JbsfZY2Kx85QIOOpS0DVmjTGB2TsOsem9r7QMEy7QLbOWci5vKpTxZGh2DonwOXTUjAFvBhrq3iVa6E9kx8yYTxJROrdoa6wcAhGNtR7o1PGIfqsPt3OFWipM4pQfi+wZ1YEu5DYGOgumFad3h1xi4bgGaD2wRyYGexrq1UD+K1oXiGgQZMc=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 932a99d7-0cb5-4e7e-ff63-08d710af86c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2019 03:23:56.4631 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: alxndr@bu.edu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2726
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe4d::72e
Subject: [Qemu-devel] [RFC 14/19] fuzz: hard-code a main-loop timeout
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>,
 "superirishdonkey@gmail.com" <superirishdonkey@gmail.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>, "Oleinik, 
 Alexander" <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
---
 util/main-loop.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/util/main-loop.c b/util/main-loop.c
index e3eaa55866..708e6be5eb 100644
--- a/util/main-loop.c
+++ b/util/main-loop.c
@@ -513,6 +513,9 @@ void main_loop_wait(int nonblocking)
     timeout_ns =3D qemu_soonest_timeout(timeout_ns,
                                       timerlistgroup_deadline_ns(
                                           &main_loop_tlg));
+#ifdef CONFIG_FUZZ
+    timeout_ns =3D 50000;
+#endif
=20
     ret =3D os_host_main_loop_wait(timeout_ns);
     mlpoll.state =3D ret < 0 ? MAIN_LOOP_POLL_ERR : MAIN_LOOP_POLL_OK;
--=20
2.20.1


