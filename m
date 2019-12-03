Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E76F0C432C3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 13:48:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF3B12073B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 13:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="PgsrbfNG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF3B12073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ic8X5-0007Pl-Q4
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 08:48:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36171)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ic8JG-0001Bt-Jp
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 08:33:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ic8JE-00057d-Ew
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 08:33:45 -0500
Received: from mail-eopbgr130102.outbound.protection.outlook.com
 ([40.107.13.102]:44671 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1ic8JD-0004ul-NC; Tue, 03 Dec 2019 08:33:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=COQmqG4OmIeQ4m2HpNXKTKbxXCUT2O2IqZTYvlbR0UZcxNHY1jD8ejuY85mmSKOtmo3d2X6r4lCkTs4pgXcIfJ/UUj2mB9R+w1Ax1Z8jbls8Tf/7bh4g5IdWDneHEXpeV0KiHdiIpnC9DYPFm3kvsOAEnQnoK6c/o6qExL7CFYA0zc0JfNy/qrN+IaA4iHnIELsahNwrhq9ghtZbwybhpMEvr6hN8MuW1Iu8VNx7uq1fzro4pEsub3wG1lapPDrljUb3qVJOyEkFBjLmsG/kEalZnmtQkBhNZCBELwe7pHXBrvniPGLg5iLPmNvqDBiG/0iFrm5obvjEi1FcNP9iLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=io5voQRbR4yMdz6OqP2sp8h0wSy5oDsPJZERAjiBOjg=;
 b=i2d28h2Vneyqwtv4Y5tOQBYLmkH5+Bxmw6uE5yQyWC5llcbsnjy1OaeS/aLC3NHJs6MVsGbYDWm3EJHZsG/rDzhCQe4Y1NBTCenzLyCgZdk9Fh8r1L27tRwH5oYFoPNxk2SNRRII7u1Ra2kjGG177l0v8ljzJ9o15+puwaLBEjbr81BsjCKh8Hes9FtcDL4I0etKc2gyKmMSf+lbomSC6+tCMruND/fMq5jn2vH5b70kTPvLH2+SqHqJVooFFCevLk/XRKKz7L7k7qdRuvs4uCUI/GChoy9L7AZVyDgJHVetsZP05U1Ud2+F+vIGYjQoXY6Nlfsf0cWj5vuUGK7OEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=io5voQRbR4yMdz6OqP2sp8h0wSy5oDsPJZERAjiBOjg=;
 b=PgsrbfNG71oiyVYFuEizbpbjcoKuZOiuQgoet93mlt9mh++uwS77RhHpcbq3xwc2cxt1d8gVDQjcanMY7yrssKJZDclzy4cN315roOzQ3bV5FQ0tGktsNy7apa6iqbuPam87AqZvhHoPMErDJwr918yRdlpeBeY7vxdIP1/XJJY=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3527.eurprd08.prod.outlook.com (20.177.112.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.21; Tue, 3 Dec 2019 13:33:39 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2516.003; Tue, 3 Dec 2019
 13:33:39 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH for-5.0 v2 19/23] iotests: Resolve TODOs in 041
Thread-Topic: [PATCH for-5.0 v2 19/23] iotests: Resolve TODOs in 041
Thread-Index: AQHVmKmNmeJL6G4US0WS+6Oh5cK+GqeovUSA///N8YA=
Date: Tue, 3 Dec 2019 13:33:39 +0000
Message-ID: <3be97c8b-fbee-a183-0cd8-dc2e5824efbc@virtuozzo.com>
References: <20191111160216.197086-1-mreitz@redhat.com>
 <20191111160216.197086-20-mreitz@redhat.com>
 <2416e1d8-c1c3-4c88-6e7b-52670eb23c0e@virtuozzo.com>
In-Reply-To: <2416e1d8-c1c3-4c88-6e7b-52670eb23c0e@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR09CA0071.eurprd09.prod.outlook.com
 (2603:10a6:7:3d::15) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191203163337652
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3e8a40aa-ed96-42e3-2097-08d777f5681a
x-ms-traffictypediagnostic: AM6PR08MB3527:
x-microsoft-antispam-prvs: <AM6PR08MB352740FEB94D971DDF7B2420C1420@AM6PR08MB3527.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:185;
x-forefront-prvs: 02408926C4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(346002)(396003)(376002)(366004)(39840400004)(199004)(189003)(31696002)(256004)(26005)(6486002)(54906003)(36756003)(110136005)(229853002)(478600001)(99286004)(386003)(558084003)(81156014)(25786009)(14454004)(2501003)(6506007)(81166006)(8676002)(2616005)(446003)(2906002)(11346002)(71200400001)(8936002)(5660300002)(102836004)(316002)(71190400001)(66446008)(64756008)(3846002)(66476007)(6116002)(66556008)(305945005)(52116002)(186003)(6512007)(6246003)(76176011)(66946007)(6436002)(4326008)(86362001)(7736002)(31686004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3527;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AbhPIzX4Z1IgAJlsU/R1FFo0OuOmDF1hjEAPrBuSSbcmO+0tb4j7rQZdvLs07nGuJq9hz8UKlanZq1zWPENSaXvm/kLsaZk+ykrEJZpvPASna9KG/bkOJj/d9aJfz5wo8Zc+QoQUIn5mQzYtBUW/AeK1ZOC3EWaiTW0+MEVwA2jfUknSqgFWlzEzN0b1XC4UFFHtBbVabM0GtteNrV3JPzGhoKDMESZgwiFcEcUwWELB+IoX9DCKwGnCgEyVHn5u4lD4TT19s5/sw7o/OEdwpX6NMsVXWx2XhtVxWZvteI/l2F9MecaAOlLT3x3nj5aQKJ9SwQYMOmwFJE10VCQ1OWNJ9oSakgkfSOuT4t9NASLMofAuR8NXbbv/uDr9+gY7xWE8Xu92nsKx6u+szJnAuo/TdxXQEVGG9xhEBlstUDqGflaRxTe0kE7c8PUbWfq2
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <C16F3FDDCBBF654892E552A406FC02C3@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e8a40aa-ed96-42e3-2097-08d777f5681a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2019 13:33:39.4509 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w96Q1+hm0COmPu7Oo0VKyPLtgA7IVdasP+5+sneUS6AuEQOxagbZBuYBx/JQR4Feb3Oh1JxmImazGiXWBRJyVX9eAKcg9hpyo2xdE6xlKRg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3527
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.13.102
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

03.12.2019 16:32, Vladimir Sementsov-Ogievskiy wrote:
> 11.11.2019 19:02, Max Reitz wrote:
>> Signed-off-by: Max Reitz<mreitz@redhat.com>
>=20
>=20
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>=20


Oops, stop. Why do you remove line "self.vm.shutdown()" ?

--=20
Best regards,
Vladimir

