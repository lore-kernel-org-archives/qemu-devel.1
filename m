Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39284C7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 15:34:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03B3E2184E
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 15:34:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="g2iTFexc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03B3E2184E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoUte-00024w-5y
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 11:34:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33053)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hoUtO-0001be-8V
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 11:33:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hoUtG-0000GZ-5I
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 11:33:50 -0400
Received: from mail-eopbgr140098.outbound.protection.outlook.com
 ([40.107.14.98]:13892 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1hoUst-0007gl-SU; Fri, 19 Jul 2019 11:33:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VtCOAzExG1Lu6LnGcXocwECHcB4U4IFNv0jpkoI3eEu0AeS22Xg2sKM/36w1VITHemeGu78j7t+jI7qCv+Ji8gPaNnhhlsp8tSG795J3spqf7nxpUZxKjTBIS15ReJQl4L2Xj8W7NwG/D+87QfPwW2S79WbBJ5OHwugHB7pBxAWhH08SHRax9hJkxnwpNz15EVG6LPrIvJNSzeCoacPJXtnvmyPOx71Ui1AbjQ57b7kp6TBTD41+//Q5I5qwC6Yl7uWb29+TcerLa4jCJfpmE5R2LKtwl7Lpfnl1qo7wFjL1lN8YWlDV+Oqa9kCFAC5QA6YQbVm1faR4bjh7QMK8Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/9YtRh4XFdEaEjHZrOoyj+i/zbC+vj40luhF9ZgD888=;
 b=BFAZ0PWxMLEBKaUB7SnQimd5NAt/bBXOWgWzyNCwQwTif5q08mAG41szbohWmY2oSerkimFmTkIApn/3JthjSQodaa4gtoo8B+7MYTDzFnNDmIWHDATGexaVLEDZvkMwYIJnaPhHKw3hVj7bof5wKAGvN3IaNTSW3wyOzbwP2FDofQ+aHpEJKp/eOyPjHNeQoN7uzpn9TVexzYn4sjU3EleJs4pY8ysZq3IEhPQgIkgzuhfb45Fjgw4UcXFbrjJXUKan1eElHHIEK4vMAf69uDIxJB51E5Tsw4/r2HlrwWxRA3/4lL65j0xlYJ9I+moiHbYnBTyFylZU7SUwbe6WOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=virtuozzo.com;dmarc=pass action=none
 header.from=virtuozzo.com;dkim=pass header.d=virtuozzo.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/9YtRh4XFdEaEjHZrOoyj+i/zbC+vj40luhF9ZgD888=;
 b=g2iTFexc/ZhKxSNWtVUfFb56aZwhxCeBJDZQ4DAER9zmGD54MFtuuLgL42Pf9gjTp/OfczhpwnA+VGFFNA1c5PjMvQrXkhauqiU7uYcMKrcIuuzCbu6U5CWSCJ0IJRyX8nsmb4DII2q48PEBjyYniK71PCNPgZGA+uqGZ0micII=
Received: from VI1PR08MB4399.eurprd08.prod.outlook.com (20.179.28.141) by
 VI1PR08MB3615.eurprd08.prod.outlook.com (20.177.61.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.14; Fri, 19 Jul 2019 15:17:01 +0000
Received: from VI1PR08MB4399.eurprd08.prod.outlook.com
 ([fe80::4c3d:79b3:a884:18c4]) by VI1PR08MB4399.eurprd08.prod.outlook.com
 ([fe80::4c3d:79b3:a884:18c4%3]) with mapi id 15.20.2073.012; Fri, 19 Jul 2019
 15:17:01 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Thread-Topic: [PATCH] nbd: Initialize reply on failure
Thread-Index: AQHVPkMcqbEGg55jt0ajtBYbBEe416bSDX6A
Date: Fri, 19 Jul 2019 15:17:01 +0000
Message-ID: <3bde6a55-0d6e-01e2-c15b-4eebfb274e5e@virtuozzo.com>
References: <20190719150313.29198-1-eblake@redhat.com>
In-Reply-To: <20190719150313.29198-1-eblake@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0402CA0003.eurprd04.prod.outlook.com
 (2603:10a6:3:d0::13) To VI1PR08MB4399.eurprd08.prod.outlook.com
 (2603:10a6:803:102::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c2e1bc17-ad64-4ec7-f5ca-08d70c5c261b
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:VI1PR08MB3615; 
x-ms-traffictypediagnostic: VI1PR08MB3615:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <VI1PR08MB361593D5C0A0FA5A10C3F298F4CB0@VI1PR08MB3615.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:431;
x-forefront-prvs: 01039C93E4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(979002)(39850400004)(396003)(366004)(136003)(346002)(376002)(189003)(199004)(6486002)(2906002)(54906003)(66556008)(2616005)(110136005)(66066001)(64756008)(36756003)(66446008)(66476007)(6506007)(316002)(53546011)(386003)(102836004)(6512007)(99286004)(305945005)(486006)(478600001)(68736007)(53936002)(7736002)(31696002)(6436002)(5660300002)(6116002)(66946007)(86362001)(44832011)(26005)(81156014)(71190400001)(71200400001)(8676002)(966005)(186003)(14454004)(31686004)(25786009)(8936002)(229853002)(3846002)(6306002)(446003)(6246003)(2501003)(11346002)(4326008)(256004)(14444005)(52116002)(476003)(76176011)(81166006)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB3615;
 H:VI1PR08MB4399.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: C69MHou85BX+HekVdKhacM5paWbrTeyG97e8q3QOQh85L2kqdKv2mHleCvFFmlaJF2v34boCWBIsRNSo91kw6+VxovuRZCHYpY6GRzcIMUeEqJdmJzWXKLWoC/HcJeF8vFLY5OywSZbgDAl2upbQottSMgnJjLgOVFLfnJQs6aET5aCGIg3vSiivQ1n6L8zjUM4JRYkVcIDTrndGBffwUiMUgc1Y10jcTjbiKlqpQKF3MM7dMU8XtX4LYGKg0FjXXUhwmYxUbXhL1OJVJ+sp/rUqtNE608S0jKTXpZs0D7qkf7B7DiGrAUv/nVBtXeRPAC2/mnUDMPXeTM7x7pf8z+0FO0GOmBntqYQ4MUf7J4MHsrbmY8YIwIFtw2oH6ZWV9iYUrlqwGg79zITmr449LDfXrwxMMBudjfNuvjRwbF4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0FC8B436667A77499F2E19CC555A141A@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2e1bc17-ad64-4ec7-f5ca-08d70c5c261b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2019 15:17:01.4104 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: andrey.shinkevich@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3615
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.14.98
Subject: Re: [Qemu-devel] [PATCH] nbd: Initialize reply on failure
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDE5LzA3LzIwMTkgMTg6MDMsIEVyaWMgQmxha2Ugd3JvdGU6DQo+IFdlJ3ZlIGhhZCB0
d28gc2VwYXJhdGUgcmVwb3J0cyBvZiBhIGNhbGxlciBydW5uaW5nIGludG8gdXNlIG9mDQo+IHVu
aW5pdGlhbGl6ZWQgZGF0YSBpZiBzLT5xdWl0IGlzIHNldCAob25lIGRldGVjdGVkIGJ5IGdjYyAt
TzMsIGFub3RoZXINCj4gYnkgdmFsZ3JpbmQpLCBkdWUgdG8gY2hlY2tpbmcgJ25iZF9yZXBseV9p
c19zaW1wbGUocmVwbHkpIHx8IHMtPnF1aXQnDQo+IGluIHRoZSB3cm9uZyBvcmRlci4gUmF0aGVy
IHRoYW4gY2hhc2luZyBkb3duIHdoaWNoIGNhbGxlcnMgbmVlZCB0bw0KPiBwcmUtaW5pdGlhbGl6
ZSByZXBseSwgaXQncyBlYXNpZXIgdG8gZ3VhcmFudGVlIHRoYXQgcmVwbHkgd2lsbCBhbHdheXMN
Cj4gYmUgc2V0IGJ5IG5iZF9jb19yZWNlaXZlX29uZV9jaHVuaygpIGV2ZW4gb24gZmFpbHVyZS4N
Cj4gDQo+IFJlcG9ydGVkLWJ5OiBUaG9tYXMgSHV0aCA8dGh1dGhAcmVkaGF0LmNvbT4NCj4gUmVw
b3J0ZWQtYnk6IEFuZHJleSBTaGlua2V2aWNoIDxhbmRyZXkuc2hpbmtldmljaEB2aXJ0dW96em8u
Y29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBFcmljIEJsYWtlIDxlYmxha2VAcmVkaGF0LmNvbT4NCj4g
LS0tDQo+IA0KPiBSZXBsYWNlczogaHR0cHM6Ly9saXN0cy5nbnUub3JnL2FyY2hpdmUvaHRtbC9x
ZW11LWRldmVsLzIwMTktMDcvbXNnMDQ0NzcuaHRtbA0KPiBSZXBsYWNlczogaHR0cHM6Ly9saXN0
cy5nbnUub3JnL2FyY2hpdmUvaHRtbC9xZW11LWRldmVsLzIwMTktMDcvbXNnMDM3MTIuaHRtbA0K
PiANCj4gICBibG9jay9uYmQuYyB8IDEgKw0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlv
bigrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Jsb2NrL25iZC5jIGIvYmxvY2svbmJkLmMNCj4gaW5k
ZXggOGQ1NjVjYzYyNGVjLi5mNzUxYThlNjMzZTUgMTAwNjQ0DQo+IC0tLSBhL2Jsb2NrL25iZC5j
DQo+ICsrKyBiL2Jsb2NrL25iZC5jDQo+IEBAIC02NDAsNiArNjQwLDcgQEAgc3RhdGljIGNvcm91
dGluZV9mbiBpbnQgbmJkX2NvX3JlY2VpdmVfb25lX2NodW5rKA0KPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJlcXVlc3RfcmV0LCBxaW92LCBwYXlsb2FkLCBl
cnJwKTsNCj4gDQo+ICAgICAgIGlmIChyZXQgPCAwKSB7DQo+ICsgICAgICAgIG1lbXNldChyZXBs
eSwgMCwgc2l6ZW9mICpyZXBseSk7DQo+ICAgICAgICAgICBzLT5xdWl0ID0gdHJ1ZTsNCj4gICAg
ICAgfSBlbHNlIHsNCj4gICAgICAgICAgIC8qIEZvciBhc3NlcnQgYXQgbG9vcCBzdGFydCBpbiBu
YmRfY29ubmVjdGlvbl9lbnRyeSAqLw0KPiANCg0KUmV2aWV3ZWQtYnk6IEFuZHJleSBTaGlua2V2
aWNoIDxhbmRyZXkuc2hpbmtldmljaEB2aXJ0dW96em8uY29tPg0KLS0gDQpXaXRoIHRoZSBiZXN0
IHJlZ2FyZHMsDQpBbmRyZXkgU2hpbmtldmljaA0K

