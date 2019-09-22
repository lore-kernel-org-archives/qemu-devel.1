Return-Path: <SRS0=thrq=XR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BAF4C3A5A2
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Sep 2019 16:19:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31D2D206C2
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Sep 2019 16:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="NKSAUiAV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31D2D206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iC4Zi-0002Pb-8b
	for qemu-devel@archiver.kernel.org; Sun, 22 Sep 2019 12:19:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54197)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1iC4YO-0001lY-NA
 for qemu-devel@nongnu.org; Sun, 22 Sep 2019 12:17:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1iC4YM-00065w-NA
 for qemu-devel@nongnu.org; Sun, 22 Sep 2019 12:17:39 -0400
Received: from mail-eopbgr30129.outbound.protection.outlook.com
 ([40.107.3.129]:49988 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1iC4YM-000643-4x; Sun, 22 Sep 2019 12:17:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UEScBWr8BwItUFKmrUZ9PimMr0TsEROKz++tJq/q+TiF3EJwgVl9jkQjGooz+z84znNUPSsOKvhKe0HEjexGSf1wwba6jSRV/3UVnku2UnrIEjgmaA3ScavRmgQSRfEP5vwsnXbhgnbADq1XlIh1UJOX24aN7/H4e+dbZmBBtuAUsYttBtpy3u7DxE1yiTeFJ7+Cl9A+PW7ziJ/Nrjqn+VADub9J4FzZ/UxMikNeW6maz9P84j2i3y+1teQjDU6nLIyT8BUuSr+pOAq/KKtNH4DGjR5CQxbCJdcwOo05EkfpAjW92wAHOcXApcFhShzvoGYU9jFhO1YgkPP02XptZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B1GQzeAHC8lrCLMvRIZroqqprTRzg0Ee1qsRXl5Rfpw=;
 b=FZE7jdOe2um+DisLZu6tEH3H84BKB1nKAlyFJRdcVV0BOKCJqe/DRup7BVj9gjuswO6NLo17hRncOzRsXI5bVkjrSnU56waE05smIUVp3WDtjoSiY6gDyfJ1N1y2z/e3lq8rYVYYlbkxcpSkyWrBsWKVvtCqrYH8CjCnaQatwQ6rzpKiHooF4Ml7z1ZkknrPnxzDuHfvVyaGnt71YRrAHxYvOHfSLZX5TpGJXjUE/UM5ec+hqhsKFazVlavJZgdbNbLygVx0LGdtc4NgCNFijm0lJ5P9KrNmpWJTT/zXgJGF/3fSUrZbKa3RXIQLudTIXMQ+gU68oxvVczLQLtOnDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B1GQzeAHC8lrCLMvRIZroqqprTRzg0Ee1qsRXl5Rfpw=;
 b=NKSAUiAVlWn48Hd144mPbWrPkJOON30UGpNSu2N5/u/3C8tlCJm9C3xPj8E+7HSTicFKjM3xJ3hbbL4cQgF4Sene5cDG/TOxJ0TO3gPzntSExCWaigvc/Eh4269hM9fcjwh76MDhS0EH/5u8cRYrJtTJi/5cm3ry2r42c+e8cZQ=
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (20.178.22.27) by
 AM0PR08MB3970.eurprd08.prod.outlook.com (20.178.202.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.18; Sun, 22 Sep 2019 16:17:34 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::302b:b479:1322:9d31]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::302b:b479:1322:9d31%5]) with mapi id 15.20.2284.023; Sun, 22 Sep 2019
 16:17:34 +0000
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: [Qemu-block] [Ping] [PATCH v6 0/3] qcow2: add zstd cluster
 compression
Thread-Topic: [Qemu-block] [Ping] [PATCH v6 0/3] qcow2: add zstd cluster
 compression
Thread-Index: AQHVbj44c0thuovGjEe/EN8iLIPupqc03KMAgAMJXAA=
Date: Sun, 22 Sep 2019 16:17:33 +0000
Message-ID: <a7b741eb-088a-1704-5ab7-232c4d60d8bd@virtuozzo.com>
References: <20190905093109.12261-1-dplotnikov@virtuozzo.com>
 <8c42f523-23ad-1bce-5315-c1f4511723de@virtuozzo.com>
 <4cfcdf5d-efab-1d18-3bd6-240613ee84cc@virtuozzo.com>
 <bcd1d34e-5be2-0150-14a8-c3d2f13bef1f@redhat.com>
In-Reply-To: <bcd1d34e-5be2-0150-14a8-c3d2f13bef1f@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dplotnikov@virtuozzo.com; 
x-originating-ip: [94.233.244.90]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e9111503-349f-4e94-0b8c-08d73f786056
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:AM0PR08MB3970; 
x-ms-traffictypediagnostic: AM0PR08MB3970:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR08MB3970695C736623AC1AC991E6CF8A0@AM0PR08MB3970.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 016885DD9B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39830400003)(376002)(136003)(396003)(346002)(366004)(199004)(189003)(31686004)(71190400001)(71200400001)(966005)(4326008)(66066001)(14454004)(186003)(229853002)(6306002)(8676002)(2906002)(81166006)(486006)(6486002)(6436002)(26005)(81156014)(256004)(2616005)(6116002)(3846002)(6246003)(476003)(8936002)(11346002)(66556008)(64756008)(446003)(36756003)(76176011)(2501003)(54906003)(110136005)(4744005)(6512007)(99286004)(305945005)(66446008)(66946007)(66476007)(316002)(31696002)(76116006)(7736002)(102836004)(25786009)(6506007)(53546011)(5660300002)(478600001)(86362001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3970;
 H:AM0PR08MB3745.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zyjGMucWtbNZVCtC5HJ69ClirANd4sgyzkCMQSOsO5XIi15GHI1XnPNRvZR3TCXXIdxxLhKJ7WpKY0ZZr3hsD5jRcRWxsQofUn0QnoV1BjFoACRdVZZDm4VQoD3vYZaSSkbRORa1Zm6ri440+Xtc9ZCtbYGILW3FpMNJ1jIPC/Lhw7BMghMCb/7nAZVhvwgcZ6lo1HaKrhlo8hUUIUXG8gpLDrLQhoGnt/S8OTRqnA2GA13gyb7Ph1QFuqRpaMHSnHZBg057ACyUygYZVp/5K7OWBxsnQD3y+71xo0WNxEhxNIn4Qn0/qNpzpl4KgUG/me9xcmVn0eGBFBzrEo85yuwhvdg8NTDb7R9vjDaaC1EtIXFyrK6H3pqmTQZqyIzjuSKvTIZyj9n7WxxcQpEPUQu0vr3zxahbYtP0VL4MUls=
Content-Type: text/plain; charset="utf-8"
Content-ID: <491A6561569DE9448FA7506AD3F9E554@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9111503-349f-4e94-0b8c-08d73f786056
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2019 16:17:33.8073 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: udJ13zS7xMh+vxkJ6EYjUAtpQXXcpdTsvkfYe88I5F4mMyMAWWtov15bpKyH/wuKyMCGDpFcaSW/FtM/jVp/SdeTyTTVh5PSu4Cc8VB6WgQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3970
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.3.129
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gMjAuMDkuMjAxOSAyMDo1NSwgSm9obiBTbm93IHdyb3RlOg0KPg0KPiBPbiA5LzE4LzE5IDEy
OjI5IFBNLCBEZW5pcyBQbG90bmlrb3Ygd3JvdGU6DQo+PiBPbiAxMi4wOS4yMDE5IDExOjQ2LCBE
ZW5pcyBQbG90bmlrb3Ygd3JvdGU6DQo+Pj4gcGluZyENCj4+Pg0KPiBodHRwczovL2xpc3RzLmdu
dS5vcmcvYXJjaGl2ZS9odG1sL3FlbXUtZGV2ZWwvMjAxOS0wOS9tc2cwMDk0My5odG1sDQo+DQo+
IEkgd2FzIHVuZGVyIHRoZSBpbXByZXNzaW9uIHlvdSB3ZXJlIGFkZHJlc3NpbmcgZmVlZGJhY2sg
ZnJvbSBWbGFkaW1pci4NCj4NCj4gLS1qcw0KDQpJIGRvbid0IHJlYWxseSBrbm93IHdoYXQgdG8g
ZG8gd2l0aCB3aGF0IFZsYWRpbWlyIHBvaW50ZWQgb3V0IHNvIEkgd291bGQgDQpsaWtlIHRvIGdl
dCBhIGZlZWRiYWNrIGZyb20gS2V2aW4gYW5kIEVyaWMgYWJvdXQgdGhpcy4NCg0KRGVuaXMNCg0K

