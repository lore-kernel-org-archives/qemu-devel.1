Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35112C4CEC9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 13:21:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 012E8206C2
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 13:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="FUSV5iOW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 012E8206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAZtC-0006uR-J5
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 09:20:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59970)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iAZpa-0004Ze-I0
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 09:17:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iAZpZ-0000Xp-HD
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 09:17:14 -0400
Received: from mail-eopbgr20123.outbound.protection.outlook.com
 ([40.107.2.123]:42138 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iAZpM-0000Qj-T9; Wed, 18 Sep 2019 09:17:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QO6qAA/rCjz1U8UFb1cUPwTYZnwLa3RldlV2I6jQdsGknssBXl2sONtwPPe6+cEn+2qhy8AcnXx8auXFBfNCBdul6yR2YaaET5myzyHmweLmlnNTsceQHpztBmUZt8lZ9mydrcU8vmja9Gzhhxsfg5LO4OJ9mSjW6rZg7qIo26ulBn9hXJdSLvTohG5QPNgI1Gr1G5/5Z+eyA91bFyWXmm6law4Dku5WXILFJKI4lCSzNdCuwY21LjtXTOeiF+GnPyTSr/qnHecczL6GNxXxEWRNgKCXE1LbLwL6qMGRXYRpXdPLemaou+q43jgxS9/pnGUVh31wfaWwePxGeh+kPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lYDjrYK0mPp/Y+f90eHpXx/6/GcJYrFFgyBYs2HYcEE=;
 b=VL6g0tBqVQ17TWFj12NmOelCKwR4SApgsHWPsoAk5dvIjRAyog0xqCEykx9zz+6AkSxXP4BgP8dclpq5HjOUaGcKjCZO3/JyndkKJhf4l0csrCGc/tX9CM2u9FegC9DQprY8BTN6BHExBDeuMR94qMhzjnG/D/4OJV8+3fDu2kkJssSl8lpKtKaG2XrLYyUNPTbsDZBD4qdCzuxw+OmdsZ7cPHC2wuRXjb6g+PHYxuxJSrNfTltHILrtp1yO3TlioBsFw1MkS2q2xEdG5Xcvi2uipsEKwhsWCu5+s1RYQQ0X7ImHrHrucUXCijSvyitXTVsg0WJ9M1Gex6A/vZf9kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lYDjrYK0mPp/Y+f90eHpXx/6/GcJYrFFgyBYs2HYcEE=;
 b=FUSV5iOW48trRCew0ESMp4xx/ftfn/D3QY1234xWKVYcIInNEmNJgcE8D/DULDeI9VPro/5WKed5DB9z3cVC6j4scj7/rAS3Ptbp87M5LMQl8g0hFqRBABKMzDDqNeMITi0a3v1QLHkYUq0rZIm7kYcXu6AeAmHST0VGmRNNdo8=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5356.eurprd08.prod.outlook.com (52.133.240.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Wed, 18 Sep 2019 13:16:57 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2263.023; Wed, 18 Sep 2019
 13:16:57 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH v5 1/5] iotests: remove 'linux' from default
 supported platforms
Thread-Index: AQHVbbJ83xWXTdpl9kaJA80cfyBhIqcxa0qA
Date: Wed, 18 Sep 2019 13:16:57 +0000
Message-ID: <795e48f2-fc6c-d985-2c35-6cdf3fec732a@virtuozzo.com>
References: <20190917234549.22910-1-jsnow@redhat.com>
 <20190917234549.22910-2-jsnow@redhat.com>
In-Reply-To: <20190917234549.22910-2-jsnow@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0501CA0014.eurprd05.prod.outlook.com
 (2603:10a6:3:1a::24) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190918161655417
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2ed318e3-274f-4476-ae43-08d73c3a7b63
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5356; 
x-ms-traffictypediagnostic: DB8PR08MB5356:
x-microsoft-antispam-prvs: <DB8PR08MB5356DEC20E6368C1BE5FC00EC18E0@DB8PR08MB5356.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01644DCF4A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39850400004)(136003)(396003)(346002)(366004)(376002)(189003)(199004)(229853002)(31696002)(305945005)(4326008)(7736002)(8676002)(71190400001)(66066001)(66476007)(64756008)(6436002)(66946007)(66556008)(86362001)(66446008)(31686004)(102836004)(446003)(486006)(8936002)(25786009)(81166006)(6506007)(81156014)(386003)(3846002)(6116002)(71200400001)(2906002)(26005)(11346002)(2616005)(186003)(478600001)(476003)(14454004)(2501003)(14444005)(76176011)(256004)(52116002)(316002)(36756003)(6246003)(54906003)(110136005)(6486002)(99286004)(5660300002)(6512007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5356;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: LujxQuhgN8i4wd2+C9eNHD/m4slYb6PTjVKnoY7HXPtE23suZY6MdCDLCgV8ZjuWpl742KKkocNCnSQJksSZg31AsDuAiky7oC88wbj0JMeqbXNp2F6aYHgbr3X47Bx5cK5l3Cxt6lhScs3Uiu6qdtMXFJSF9PrI29bstpSWThDCw7pM6PKQtqmgzuW8RVo8brrYY+KeOpz9c+CLOeuqghhd/wJaARa0KvydQIH/GmjEzeIuU5H1jE/l3EFYuxe10ISSSVMC6ZEvfrVGEOZo9zNzU6g1+SfgSlJCKBBnIrStCbDO3+lK1B1rfThNjRqxB6sGZUpk+I8MEPpnLsqqbxpMzESiXfDLq5wp3HvIU8PV956pj320Se81CFqffcWjSIAez0vo7lhABbLdAMgfBXTVNXrA+zwQddEV66BwhIw=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <797C3CE1FF29EA4E8C4F0CB478B6B45F@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ed318e3-274f-4476-ae43-08d73c3a7b63
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2019 13:16:57.3565 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +TQMVTFXafyW6lJXdZsKxip+m4NTypPECAAPNZFHaLKvxMSXy471Pth++0IsuiLnXcyJY8HB6p9qKbpmT+uxF6ub3jddeNt0TsSoD9s2Dkk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5356
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.2.123
Subject: Re: [Qemu-devel] [PATCH v5 1/5] iotests: remove 'linux' from
 default supported platforms
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
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTguMDkuMjAxOSAyOjQ1LCBKb2huIFNub3cgd3JvdGU6DQo+IHZlcmlmeV9wbGF0Zm9ybSB3aWxs
IGNoZWNrIGFuIGV4cGxpY2l0IHdoaXRlbGlzdCBhbmQgYmxhY2tsaXN0IGluc3RlYWQuDQo+IFRo
ZSBkZWZhdWx0IHdpbGwgbm93IGJlIGFzc3VtZWQgdG8gYmUgYWxsb3dlZCB0byBydW4gYW55d2hl
cmUuDQo+IA0KPiBGb3IgdGVzdHMgdGhhdCBkbyBub3Qgc3BlY2lmeSB0aGVpciBwbGF0Zm9ybXMg
ZXhwbGljaXRseSwgdGhpcyBoYXMgdGhlIGVmZmVjdCBvZg0KPiBlbmFibGluZyB0aGVzZSB0ZXN0
cyBvbiBub24tbGludXggcGxhdGZvcm1zLiBGb3IgdGVzdHMgdGhhdCBhbHdheXMgc3BlY2lmaWVk
DQo+IGxpbnV4IGV4cGxpY2l0bHksIHRoZXJlIGlzIG5vIGNoYW5nZS4NCj4gDQo+IEZvciBQeXRo
b24gdGVzdHMgb24gRnJlZUJTRCBhdCBsZWFzdDsgb25seSBzZXZlbiBweXRob24gdGVzdHMgZmFp
bDoNCj4gMDQ1IDE0NyAxNDkgMTY5IDE5NCAxOTkgMjExDQo+IA0KPiAwNDUgYW5kIDE0OSBhcHBl
YXIgdG8gYmUgbWlzY29uZmlndXJhdGlvbnMsDQo+IDE0NyBhbmQgMTk0IGFyZSB0aGUgQUZfVU5J
WCBwYXRoIHRvbyBsb25nIGVycm9yLA0KPiAxNjkgYW5kIDE5OSBhcmUgYml0bWFwIG1pZ3JhdGlv
biBidWdzLCBhbmQNCj4gMjExIGlzIGEgYnVnIHRoYXQgc2hvd3MgdXAgb24gTGludXggcGxhdGZv
cm1zLCB0b28uDQo+IA0KPiBUaGlzIGlzIGF0IGxlYXN0IGdvb2QgZXZpZGVuY2UgdGhhdCB0aGVz
ZSB0ZXN0cyBhcmUgbm90IExpbnV4LW9ubHkuIElmDQo+IHRoZXkgYXJlbid0IHN1aXRhYmxlIGZv
ciBvdGhlciBwbGF0Zm9ybXMsIHRoZXkgc2hvdWxkIGJlIGRpc2FibGVkIG9uIGENCj4gcGVyLXBs
YXRmb3JtIGJhc2lzIGFzIGFwcHJvcHJpYXRlLg0KPiANCj4gVGhlcmVmb3JlLCBsZXQncyBzd2l0
Y2ggdGhlc2Ugb24gYW5kIGRlYWwgd2l0aCB0aGUgZmFpbHVyZXMuDQo+IA0KPiBTaWduZWQtb2Zm
LWJ5OiBKb2huIFNub3c8anNub3dAcmVkaGF0LmNvbT4NCg0KUmV2aWV3ZWQtYnk6IFZsYWRpbWly
IFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCg0KLS0gDQpC
ZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

