Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5526AC43141
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 15:05:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2225220674
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 15:05:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="rIxmJfDK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2225220674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVdAD-0000Sk-Bj
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 10:05:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39498)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iVd8q-0007OF-BP
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 10:04:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iVd8p-0006PM-72
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 10:04:08 -0500
Received: from mail-eopbgr70122.outbound.protection.outlook.com
 ([40.107.7.122]:2757 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iVd8m-0006Ng-1A; Fri, 15 Nov 2019 10:04:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q4a3j450fW/vcHNklzZcZSkpwpugc1tzC8bqGNj2ZhuHa5jcfoPU9p+ercjTpy8iCqhu/zDmY+vL/JjzQ0m/hBfWlA5b4prYyfXNLdbQbhFSVQLNf4WVLMa+e/nGJKsk9XBu6jlb5Btwl4QpMiu9smaWBJjCsHas/tTt9ERE6pWnwYqvmTG+x6pQPtbxnBJJZnerWo0I1KllPGq01ErWDYylKzknwU3Ww/zSZg9tM/ZNk7A/5acpPlyJc2QGW9OxxyW6IlR9ffckWIHwgsNGU3ICEUu9OXgn2F43pGnA7Gd9Kz1HIYNZTTJsE5qUhwFSgKZtvQEgZEaXcIxfVpmiYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LODlAqlaUsxOFVNBKXugCFb8yjTJpPZDasSxs7k+CY8=;
 b=N53T8ejvT8QwuKHQaQSqTDRDl9lxSJYzb05iAR62KsGVyOSbfkgSd6AIRY2urFIA07cHXTDTHKcFz1RZrH0xC4JbeLVpymbUqoGNPyygAUP8opUII24SxBIhg/9H15614IHkJmT/7mlUtEO3EIIhEUwYX6/pB5MJ1N8k1gF7H7l4+bRiwAHlzIifm2S4PgfTq682AM79CFkZjciAv0OZZgVTB6awLtjgJuAsB8IIY7O1kjsDVoZKj7/4kggCEqa3j0aYV+s+Wx8BYRGrSbAYaPG2eUpmW68gViwdWs9xFDhXvXo1xw8Lfo2b6vDVS6a5j4WM/rgaeekg5hfRmv1Zsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LODlAqlaUsxOFVNBKXugCFb8yjTJpPZDasSxs7k+CY8=;
 b=rIxmJfDKOryr8pwQ4qxh00vxc9lhCRRs1tSZJtGCDHCJlAhFKtr9qzR1gy3ppeIPMt6LvjjA7FSitdE6linP+ANIZG/VPAkZuUDm1QAVXBthZCEzSkLWBi2Z5zBJ8BofxmORlC2tA5q/Xqkt//YgS2a0JoUuoCzHTHHiMlzyTHk=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3174.eurprd08.prod.outlook.com (52.135.163.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Fri, 15 Nov 2019 15:04:01 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f%3]) with mapi id 15.20.2451.029; Fri, 15 Nov 2019
 15:04:01 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v3 2/4] bitmap: Enforce maximum bitmap name length
Thread-Topic: [PATCH v3 2/4] bitmap: Enforce maximum bitmap name length
Thread-Index: AQHVmpXQlrP7gvUJk0eiM4XXWoXbLqeMVqWA
Date: Fri, 15 Nov 2019 15:04:01 +0000
Message-ID: <0a25974f-f9cd-07a1-4cb7-2bbd4dfe4375@virtuozzo.com>
References: <20191114024635.11363-1-eblake@redhat.com>
 <20191114024635.11363-3-eblake@redhat.com>
In-Reply-To: <20191114024635.11363-3-eblake@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P191CA0022.EURP191.PROD.OUTLOOK.COM (2603:10a6:3:cf::32)
 To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191115180359613
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 06398316-7110-4424-09e7-08d769dd0c4a
x-ms-traffictypediagnostic: AM6PR08MB3174:
x-microsoft-antispam-prvs: <AM6PR08MB317442E74C1A144958B35A6FC1700@AM6PR08MB3174.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 02229A4115
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(979002)(366004)(346002)(376002)(39840400004)(136003)(396003)(199004)(189003)(66946007)(110136005)(4326008)(26005)(66556008)(66476007)(36756003)(66446008)(64756008)(7736002)(6486002)(186003)(476003)(305945005)(5660300002)(11346002)(3846002)(6116002)(14454004)(71190400001)(71200400001)(31686004)(8676002)(81166006)(81156014)(76176011)(2616005)(386003)(52116002)(6506007)(31696002)(486006)(14444005)(8936002)(6512007)(256004)(4744005)(102836004)(229853002)(478600001)(2501003)(6246003)(446003)(66066001)(99286004)(6436002)(25786009)(316002)(54906003)(86362001)(2906002)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3174;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /Alzc8LQgjh66fgLIerEfuylyBKrwAle79mS5VhivY9JNjhrbkzk+mZTLaVavdooQRLrCeXLA0dOxS3ArVmPSwwp4Nv9J353ja/ZQqoo+z6RdZmfreW6FViGNtODmKvnQhyefR+i/asWKRIrMqVxY9NsDv5SIVUNXqNjy5L22YH5A6ksGwXZ59DpPOxP7aYj2u0sQ4toenosFHwOrg0tgN1XE25/3Ddh21G1ep22qW1WcYc8262jKMaM8iB4gHnoIpDgDU0XKF7v6UlVxc5RPZXc3L4G+3o+OiFjwgnAXMYfyiGeTU0QwYEfKof4qheWxX4H9PI9AyebLoYAFNaYvNU8llhYxrSwCDS5T+tPXFNNHuIBEMKdlAIIb5yDVV/LIFtDOIScQxwRAru1LuoAT8snZlCMXZwsX59EwtYkBql+l3GOS/kKx8q7IICO/kho
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <6739B6651DC0594A8CDE793800DDE4C4@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06398316-7110-4424-09e7-08d769dd0c4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2019 15:04:01.3510 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iWZheDqaiQHmi4FGoWWRWRB6zuoO22dpyW/OnDOow8ZQBr8jc9dEw1QLUz6S4ESmPSHS1SHIfj8m6lhogiK+CfsKmSJXP8ks3xP0yyJxgm8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3174
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.122
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 "mlevitsk@redhat.com" <mlevitsk@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

14.11.2019 5:46, Eric Blake wrote:
> We document that for qcow2 persistent bitmaps, the name cannot exceed
> 1023 bytes.  It is inconsistent if transient bitmaps do not have to
> abide by the same limit, and it is unlikely that any existing client
> even cares about using bitmap names this long.  It's time to codify
> that ALL bitmaps managed by qemu (whether persistent in qcow2 or not)
> have a documented maximum length.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>



--=20
Best regards,
Vladimir

