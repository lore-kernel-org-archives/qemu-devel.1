Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 947ECC4740C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 14:13:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D3D7218DE
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 14:13:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="MHQTOXVl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D3D7218DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7KQB-00012x-BU
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 10:13:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38456)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i7KPO-0000Y5-QX
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 10:12:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i7KPM-00083Z-Jh
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 10:12:45 -0400
Received: from mail-am5eur03on0701.outbound.protection.outlook.com
 ([2a01:111:f400:fe08::701]:46050
 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1i7KPL-00082u-TC; Mon, 09 Sep 2019 10:12:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P21rRImkeSxBuTlGLsKIJJEasF6bhG9w2Niy2sYeCtIjVB83AOSsaZF5+NP3C5Wa6y5dkgheGkPWhLg+1m/0cxkTc2xEx2zxW8KFR74VzuBH7HdoCKA787Az4blGl9o5Rx8ar7b+byfFC63HFfLw3mAo/AeAjU63rTuQwW+58clJMCA1a5HBfQxD9eMJxiG6To9FsNaQjfFKgYiVFNs7dNTQrndCWY7xRWDKTkKXQa3cGnV0doiR3HlE9XYOLDyRGpk4cF80curnor9qvhyX+h7v2LE2ODgmqwDwx9x4Af6vG9P7sUQQiqeXnL2qh2XyzhtuTdzGJhSiHOoeIu53Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ryLQ7RXzcSW3m7IqcQ7PCicCV1wvQRmLeUEgMmcvrRA=;
 b=ktqUNWTzY8RqjZXacYcc3+fXJreB9Chq/ajKGWz5o2aNdWS5F9JIdvo1Z6C/vFruhm+q9JsDLn+98egYh8f+8Zld0xALQJ4p2m/p77w7yn+nrWIPE6aYa3VP0mjsjOyceGSHvPUgwzh+p8L4/noAvJlRya1SC+FQS/LEjsdcWzk4FfkDbBztEnL4qRJJaLt+PrMCtWwYDFnj2my7G6fganhycG426pxBiG/eyDOzYPzmdMEcdRn126/OusLRCtewp8F7doZBEwVAuN6QNE8+l5mxgCjeD20nlTnevRoTZY7DulBf7ukIDrhY33iMukj6+7DRBIYiD+5BiqmG8ZldXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ryLQ7RXzcSW3m7IqcQ7PCicCV1wvQRmLeUEgMmcvrRA=;
 b=MHQTOXVl9nxT9w7tpd8cEMFmUv3EhBh9MYNM2nb/P+dFHySPQFStaG2dw93QalKgFLN+Yb9Ufz/ki7adbZS45ZjhXC635P/D4EI7xSiKYGJ4rONY4cgJDFNtz/jfMLS54nvmTqgHYjL3IkYhwXdkgyrU+6slBR8D+xktkO5rPWM=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB3980.eurprd08.prod.outlook.com (20.179.12.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.18; Mon, 9 Sep 2019 14:12:40 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2241.018; Mon, 9 Sep 2019
 14:12:40 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v10 04/14] block/backup: introduce BlockCopyState
Thread-Index: AQHVX03FFzbmaM/Nm0mHXVJ2sTGOiKcjXkKAgAAUZoA=
Date: Mon, 9 Sep 2019 14:12:40 +0000
Message-ID: <01bc8974-b9a5-8312-fe24-e2fbe87ab13d@virtuozzo.com>
References: <20190830161228.54238-1-vsementsov@virtuozzo.com>
 <20190830161228.54238-5-vsementsov@virtuozzo.com>
 <ae856032-2d6f-adb8-939b-410708dea596@redhat.com>
In-Reply-To: <ae856032-2d6f-adb8-939b-410708dea596@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0402CA0055.eurprd04.prod.outlook.com
 (2603:10a6:7:7c::44) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190909171237455
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 88043bcd-6e57-498e-00aa-08d7352fc62a
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:DB8PR08MB3980; 
x-ms-traffictypediagnostic: DB8PR08MB3980:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB39802FD628FB5AD3B14A1D5DC1B70@DB8PR08MB3980.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:221;
x-forefront-prvs: 01559F388D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39840400004)(366004)(396003)(136003)(346002)(376002)(189003)(199004)(14454004)(486006)(6116002)(229853002)(6436002)(6246003)(31686004)(6486002)(5660300002)(14444005)(256004)(53936002)(6512007)(107886003)(2501003)(2906002)(110136005)(54906003)(99286004)(71200400001)(71190400001)(76176011)(52116002)(316002)(11346002)(476003)(66946007)(102836004)(4326008)(26005)(386003)(478600001)(186003)(25786009)(2616005)(36756003)(86362001)(66556008)(64756008)(66446008)(66476007)(8676002)(81166006)(81156014)(31696002)(66066001)(305945005)(7416002)(3846002)(53546011)(7736002)(6506007)(8936002)(446003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB3980;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: U5Hhg6RlFmOBOKyuic69+bAQ/wIpfy/notco5eWfWp0FxbQF5ltUPiY2/ILl+nuy5Cm3eR+YumoXfC8Jstrr30zeK9pyIepkfsVU+ar7atrTLOET15OET0CIqqed77F23CXa96dtwVjYAi1A680zL16xAue7pHrbCQ8j2Lg5hbRoqq/UNnGWVVNV/wEr9a+5IZ+l8JBGrFUY9SION0+BBcLwsYZVtHooEfBWMKtsJRk0TBcfKehUBJhld1cRb8PmNJFq6ZaO9PrNwD5ByvRr3dkvZOafP7g8hePu1T2wPeWlfvnhPa+v1GPPeMZtf1cIeel8S60IgZE8kKCQnugpvsYdZ/kI0myHI4VS15RNcCTl21jX5Yp8xZjAoeZbZ01aNO0u5Zqmo8tEpwBLPimYxx/47zvcVYQnJhR1sYr+EOE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3A156BECBF4B0C428C8B950640FBA519@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88043bcd-6e57-498e-00aa-08d7352fc62a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2019 14:12:40.3263 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tbQs927kDzGlo97WN0vpq3zlkimY+Zr2avUYNoum9CVdaJL+0QmiAx9/PZEckbfGaH+XdavmlUCnSxRdOBfcEhQN89h7O899a5isEsJCPX4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB3980
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe08::701
Subject: Re: [Qemu-devel] [PATCH v10 04/14] block/backup: introduce
 BlockCopyState
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
Cc: "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
 Denis Lunev <den@virtuozzo.com>,
 "wencongyang2@huawei.com" <wencongyang2@huawei.com>,
 "xiechanglong.d@gmail.com" <xiechanglong.d@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDkuMDkuMjAxOSAxNTo1OSwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAzMC4wOC4xOSAxODoxMiwg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IFNwbGl0IGNvcHlpbmcgY29k
ZSBwYXJ0IGZyb20gYmFja3VwIHRvICJibG9jay1jb3B5IiwgaW5jbHVkaW5nIHNlcGFyYXRlDQo+
PiBzdGF0ZSBzdHJ1Y3R1cmUgYW5kIGZ1bmN0aW9uIHJlbmFtaW5nLiBUaGlzIGlzIG5lZWRlZCB0
byBzaGFyZSBpdCB3aXRoDQo+PiBiYWNrdXAtdG9wIGZpbHRlciBkcml2ZXIgaW4gZnVydGhlciBj
b21taXRzLg0KPj4NCj4+IE5vdGVzOg0KPj4NCj4+IDEuIEFzIEJsb2NrQ29weVN0YXRlIGtlZXBz
IG93biBCbG9ja0JhY2tlbmQgb2JqZWN0cywgcmVtYWluaW5nDQo+PiBqb2ItPmNvbW1vbi5ibGsg
dXNlcnMgb25seSB1c2UgaXQgdG8gZ2V0IGJzIGJ5IGJsa19icygpIGNhbGwsIHNvIGNsZWFyDQo+
PiBqb2ItPmNvbW1lbi5ibGsgcGVybWlzc2lvbnMgc2V0IGluIGJsb2NrX2pvYl9jcmVhdGUgYW5k
IGFkZA0KPj4gam9iLT5zb3VyY2VfYnMgdG8gYmUgdXNlZCBpbnN0ZWFkIG9mIGJsa19icyhqb2It
PmNvbW1vbi5ibGspLCB0byBrZWVwDQo+PiBpdCBtb3JlIGNsZWFyIHdoaWNoIGJzIHdlIHVzZSB3
aGVuIGludHJvZHVjZSBiYWNrdXAtdG9wIGZpbHRlciBpbg0KPj4gZnVydGhlciBjb21taXQuDQo+
Pg0KPj4gMi4gUmVuYW1lIHMvaW5pdGlhbGl6aW5nX2JpdG1hcC9za2lwX3VuYWxsb2NhdGVkLyB0
byBzb3VuZCBhIGJpdCBiZXR0ZXINCj4+IGFzIGludGVyZmFjZSB0byBCbG9ja0NvcHlTdGF0ZQ0K
Pj4NCj4+IDMuIFNwbGl0IGlzIG5vdCB2ZXJ5IGNsZWFuOiB0aGVyZSBsZWZ0IHNvbWUgZHVwbGlj
YXRlZCBmaWVsZHMsIGJhY2t1cA0KPj4gY29kZSB1c2VzIHNvbWUgQmxvY2tDb3B5U3RhdGUgZmll
bGRzIGRpcmVjdGx5LCBsZXQncyBwb3N0cG9uZSBpdCBmb3INCj4+IGZ1cnRoZXIgaW1wcm92ZW1l
bnRzIGFuZCBrZWVwIHRoaXMgY29tbWVudCBzaW1wbGVyIGZvciByZXZpZXcuDQo+Pg0KPj4gU2ln
bmVkLW9mZi1ieTogVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0
dW96em8uY29tPg0KPj4gLS0tDQo+PiAgIGJsb2NrL2JhY2t1cC5jICAgICB8IDM1NyArKysrKysr
KysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0NCj4+ICAgYmxvY2svdHJhY2Ut
ZXZlbnRzIHwgIDEyICstDQo+PiAgIDIgZmlsZXMgY2hhbmdlZCwgMjMxIGluc2VydGlvbnMoKyks
IDEzOCBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvYmxvY2svYmFja3VwLmMgYi9i
bG9jay9iYWNrdXAuYw0KPj4gaW5kZXggYWJiNTA5OWZhMy4uMDAyZGVlNGQ3ZiAxMDA2NDQNCj4+
IC0tLSBhL2Jsb2NrL2JhY2t1cC5jDQo+PiArKysgYi9ibG9jay9iYWNrdXAuYw0KPj4gQEAgLTM1
LDEyICszNSw0MyBAQCB0eXBlZGVmIHN0cnVjdCBDb3dSZXF1ZXN0IHsNCj4+ICAgICAgIENvUXVl
dWUgd2FpdF9xdWV1ZTsgLyogY29yb3V0aW5lcyBibG9ja2VkIG9uIHRoaXMgcmVxdWVzdCAqLw0K
Pj4gICB9IENvd1JlcXVlc3Q7DQo+PiAgIA0KPj4gK3R5cGVkZWYgdm9pZCAoKlByb2dyZXNzQnl0
ZXNDYWxsYmFja0Z1bmMpKGludDY0X3QgYnl0ZXMsIHZvaWQgKm9wYXF1ZSk7DQo+PiArdHlwZWRl
ZiB2b2lkICgqUHJvZ3Jlc3NSZXNldENhbGxiYWNrRnVuYykodm9pZCAqb3BhcXVlKTsNCj4+ICt0
eXBlZGVmIHN0cnVjdCBCbG9ja0NvcHlTdGF0ZSB7DQo+PiArICAgIEJsb2NrQmFja2VuZCAqc291
cmNlOw0KPj4gKyAgICBCbG9ja0JhY2tlbmQgKnRhcmdldDsNCj4+ICsgICAgQmRydkRpcnR5Qml0
bWFwICpjb3B5X2JpdG1hcDsNCj4+ICsgICAgaW50NjRfdCBjbHVzdGVyX3NpemU7DQo+PiArICAg
IGJvb2wgdXNlX2NvcHlfcmFuZ2U7DQo+PiArICAgIGludDY0X3QgY29weV9yYW5nZV9zaXplOw0K
Pj4gKyAgICB1aW50NjRfdCBsZW47DQo+PiArDQo+PiArICAgIEJkcnZSZXF1ZXN0RmxhZ3Mgd3Jp
dGVfZmxhZ3M7DQo+PiArDQo+PiArICAgIC8qDQo+PiArICAgICAqIHNraXBfdW5hbGxvY2F0ZWQ6
IGlmIHRydWUsIG9uIGNvcHkgb3BlcmF0aW9uIGZpcnN0bHkgcmVzZXQgYXJlYXMNCj4+ICsgICAg
ICogdW5hbGxvY2F0ZWQgaW4gdG9wIGxheWVyIG9mIHNvdXJjZSAoYW5kIHRoZW4gb2YgY291cnNl
IGRvbid0IGNvcHkNCj4+ICsgICAgICogY29ycmVzcG9uZGluZyBjbHVzdGVycykuIElmIHNvbWUg
Ynl0ZXMgcmVzZXQsIGNhbGwNCj4+ICsgICAgICogcHJvZ3Jlc3NfcmVzZXRfY2FsbGJhY2suDQo+
PiArICAgICAqLw0KPiANCj4gSXQgaXNu4oCZdCBxdWl0ZSBjbGVhciB0aGF0IHRoaXMgcmVmZXJz
IHRvIHRoZSBjb3B5X2JpdG1hcC4gIE1heWJlDQo+IHNvbWV0aGluZyBsaWtlDQo+IA0KPiDigJxJ
ZiB0cnVlLCB0aGUgY29weSBvcGVyYXRpb24gcHJlcGFyZXMgYSBzeW5jPXRvcCBqb2I6IEl0IHNj
YW5zIHRoZQ0KDQpobW0sIG5vdyBpdCdzIG5vdCByZWZhY3RvcmVkIHRvIHNjYW4gaXQgYmVmb3Jl
IGNvcHlpbmcgbG9vcCwgc28gaXQncyBub3QgcHJlY2lzZQ0Kd29yZGluZy4uDQoNCj4gc291cmNl
J3MgdG9wIGxheWVyIHRvIGZpbmQgYWxsIHVuYWxsb2NhdGVkIGFyZWFzIGFuZCByZXNldHMgdGhl
bSBpbiB0aGUNCg0KTm90IGFsbCwgYnV0IG1vc3RseSBpbnNpZGUgYmxvY2stY29weSByZXF1ZXN0
ZWQgYXJlYSAoYnV0IG1heSBiZSBtb3JlKQ0KDQo+IGNvcHlfYml0bWFwIChzbyB0aGV5IHdpbGwg
bm90IGJlIGNvcGllZCkuICBXaGVuZXZlciBhbnkgc3VjaCBhcmVhIGlzDQo+IGNsZWFyZWQsIHBy
b2dyZXNzX3Jlc2V0X2NhbGxiYWNrIHdpbGwgYmUgaW52b2tlZC4NCj4gT25jZSB0aGUgd2hvbGUg
dG9wIGxheWVyIGhhcyBiZWVuIHNjYW5uZWQsIHNraXBfdW5hbGxvY2F0ZWQgaXMgY2xlYXJlZA0K
PiBhbmQgdGhlIGFjdHVhbCBjb3B5aW5nIGJlZ2lucy7igJ0NCg0KTGFzdCBzZW50ZW5jZSBzb3Vu
ZHMgbGlrZSBpdCdzIGEgYmxvY2stY29weSB3aG8gd2lsbCBjbGVhciBza2lwX3VuYWxsb2NhdGVk
LA0KYnV0IGl0J3Mgbm90IHNvLiBJdCdzIG5vdCB2ZXJ5IGdvb2QgZGVzaWduIGFuZCBtYXkgYmUg
cmVmYWN0b3JlZCBpbiBmdXR1cmUsDQpidXQgZm9yIG5vdywgSSdkIGJldHRlciBkcm9wIGxhc3Qg
c2VudGVuY2UuDQoNCj4gDQo+IGluc3RlYWQ/DQoNCk9yLCB3aGF0IGFib3V0IHRoZSBmb2xsb3dp
bmcgbWl4Og0KDQpVc2VkIGZvciBqb2Igc3luYz10b3AgbW9kZS4gSWYgdHJ1ZSwgYmxvY2tfY29w
eSgpIHdpbGwgcmVzZXQgaW4gY29weV9iaXRtYXAgYXJlYXMNCnVuYWxsb2NhdGVkIGluIHRvcCBp
bWFnZSAoc28gdGhleSB3aWxsIG5vdCBiZSBjb3BpZWQpLiBXaGVuZXZlciBhbnkgc3VjaCBhcmVh
IGlzIGNsZWFyZWQsDQpwcm9ncmVzc19yZXNldF9jYWxsYmFjayB3aWxsIGJlIGludm9rZWQuIFVz
ZXIgaXMgYXNzdW1lZCB0byBjYWxsIGluIGJhY2tncm91bmQNCmJsb2NrX2NvcHlfcmVzZXRfdW5h
bGxvY2F0ZWQoKSBzZXZlcmFsIHRpbWVzIHRvIGNvdmVyIHRoZSB3aG9sZSBjb3BpZWQgZGlzayBh
bmQNCnRoZW4gY2xlYXIgc2tpcF91bmFsbG9jYXRlZCwgdG8gcHJldmVudCBleHRyYSBlZmZvcnQu
DQoNCj4gDQo+PiArICAgIGJvb2wgc2tpcF91bmFsbG9jYXRlZDsNCj4+ICsNCj4+ICsgICAgLyog
cHJvZ3Jlc3NfYnl0ZXNfY2FsbGJhY2sgY2FsbGVkIHdoZW4gc29tZSBjb3B5aW5nIHByb2dyZXNz
IGlzIGRvbmUuICovDQo+IA0KPiBNYXliZSBhZGQgYSBjb2xvbiBhZnRlciB0aGUgYXR0cmlidXRl
IG5hbWU/ICAoT3IgZHJvcCB0aGUgbmFtZSBhbHRvZ2V0aGVyKQ0KDQpPSw0KDQo+IA0KPj4gKyAg
ICBQcm9ncmVzc0J5dGVzQ2FsbGJhY2tGdW5jIHByb2dyZXNzX2J5dGVzX2NhbGxiYWNrOw0KPj4g
Kw0KPj4gKyAgICAvKg0KPj4gKyAgICAgKiBwcm9ncmVzc19yZXNldF9jYWxsYmFjayBjYWxsZWQg
d2hlbiBzb21lIGJ5dGVzIHJlc2V0IGZyb20gY29weV9iaXRtYXANCj4+ICsgICAgICogKHNlZSBA
c2tpcF91bmFsbG9jYXRlZCBhYm92ZSkNCj4gDQo+IE1heWJlIHlvdSBzaG91bGQga2VlcCB0aGUg
bm90ZSB5b3UgYmVmb3JlIG9uIHdoYXQgdG8gZG8gdGhlbiwgaS5lLiB0aGF0DQo+IHRoZSBjYWxs
ZWUgc2hvdWxkIHByb2JhYmx5IHJlY2FsY3VsYXRlIGhvdyBtYW55IGJ5dGVzIHJlbWFpbiBiYXNl
ZCBvbg0KPiB0aGUgY29weV9iaXRtYXDigJlzIGRpcnR5IGJpdCBjb3VudC4NCg0KT0sNCg0KPiAN
Cj4+ICsgICAgICovDQo+PiArICAgIFByb2dyZXNzUmVzZXRDYWxsYmFja0Z1bmMgcHJvZ3Jlc3Nf
cmVzZXRfY2FsbGJhY2s7DQo+PiArICAgIHZvaWQgKnByb2dyZXNzX29wYXF1ZTsNCj4+ICt9IEJs
b2NrQ29weVN0YXRlOw0KPiANCj4gWy4uLl0NCj4gDQo+PiBAQCAtNDE1LDE2ICs1MzUsMTYgQEAg
c3RhdGljIHZvaWQgYmFja3VwX2Fib3J0KEpvYiAqam9iKQ0KPj4gICBzdGF0aWMgdm9pZCBiYWNr
dXBfY2xlYW4oSm9iICpqb2IpDQo+PiAgIHsNCj4+ICAgICAgIEJhY2t1cEJsb2NrSm9iICpzID0g
Y29udGFpbmVyX29mKGpvYiwgQmFja3VwQmxvY2tKb2IsIGNvbW1vbi5qb2IpOw0KPj4gLSAgICBC
bG9ja0RyaXZlclN0YXRlICpicyA9IGJsa19icyhzLT5jb21tb24uYmxrKTsNCj4+ICsgICAgQmxv
Y2tDb3B5U3RhdGUgKmJjcyA9IHMtPmJjczsNCj4+ICAgDQo+PiAtICAgIGlmIChzLT5jb3B5X2Jp
dG1hcCkgew0KPj4gLSAgICAgICAgYmRydl9yZWxlYXNlX2RpcnR5X2JpdG1hcChicywgcy0+Y29w
eV9iaXRtYXApOw0KPj4gLSAgICAgICAgcy0+Y29weV9iaXRtYXAgPSBOVUxMOw0KPj4gLSAgICB9
DQo+PiArICAgIC8qDQo+PiArICAgICAqIFplcm8gcG9pbnRlciBmaXJzdCwgdG8gbm90IGludGVy
bGVhdmUgd2l0aCBiYWNrdXBfZHJhaW4gZHVyaW5nIHNvbWUNCj4+ICsgICAgICogeWllbGQuIFRP
RE86IGp1c3QgYmxvY2tfY29weV9zdGF0ZV9mcmVlKHMtPmJjcykgYWZ0ZXIgYmFja3VwX2RyYWlu
DQo+PiArICAgICAqIGRyb3BwZWQuDQo+PiArICAgICAqLw0KPiANCj4gSSBzdXBwb3NlIHRoYXTi
gJhzIG5vdy4gOi0pDQoNCkhtbSwgaXQncyBpbiBLZXZpbidzIGJyYW5jaC4gU2hvdWxkIEkgcmVi
YXNlIG9uIGl0Pw0KDQo+IA0KPj4gKyAgICBzLT5iY3MgPSBOVUxMOw0KPj4gICANCj4+IC0gICAg
YXNzZXJ0KHMtPnRhcmdldCk7DQo+PiAtICAgIGJsa191bnJlZihzLT50YXJnZXQpOw0KPj4gLSAg
ICBzLT50YXJnZXQgPSBOVUxMOw0KPj4gKyAgICBibG9ja19jb3B5X3N0YXRlX2ZyZWUoYmNzKTsN
Cj4+ICAgfQ0KPiANCj4gWy4uLl0NCj4gDQo+PiBAQCAtNDQ5LDggKzU2OSw4IEBAIHN0YXRpYyB2
b2lkIGJhY2t1cF9kcmFpbihCbG9ja0pvYiAqam9iKQ0KPj4gICAgICAgLyogTmVlZCB0byBrZWVw
IGEgcmVmZXJlbmNlIGluIGNhc2UgYmxrX2RyYWluIHRyaWdnZXJzIGV4ZWN1dGlvbg0KPj4gICAg
ICAgICogb2YgYmFja3VwX2NvbXBsZXRlLi4uDQo+PiAgICAgICAgKi8NCj4+IC0gICAgaWYgKHMt
PnRhcmdldCkgew0KPj4gLSAgICAgICAgQmxvY2tCYWNrZW5kICp0YXJnZXQgPSBzLT50YXJnZXQ7
DQo+PiArICAgIGlmIChzLT5iY3MpIHsNCj4+ICsgICAgICAgIEJsb2NrQmFja2VuZCAqdGFyZ2V0
ID0gcy0+YmNzLT50YXJnZXQ7DQo+PiAgICAgICAgICAgYmxrX3JlZih0YXJnZXQpOw0KPj4gICAg
ICAgICAgIGJsa19kcmFpbih0YXJnZXQpOw0KPj4gICAgICAgICAgIGJsa191bnJlZih0YXJnZXQp
Ow0KPiANCj4gKEFuZCB0aGlzIGh1bmsgY2FuIGdvIGF3YXkgbm93LikNCj4gDQo+IFsuLi5dDQo+
IA0KPj4gZGlmZiAtLWdpdCBhL2Jsb2NrL3RyYWNlLWV2ZW50cyBiL2Jsb2NrL3RyYWNlLWV2ZW50
cw0KPj4gaW5kZXggMDQyMDlmMDU4ZC4uNDUzNzkyZWQ4NyAxMDA2NDQNCj4+IC0tLSBhL2Jsb2Nr
L3RyYWNlLWV2ZW50cw0KPj4gKysrIGIvYmxvY2svdHJhY2UtZXZlbnRzDQo+PiBAQCAtNDAsMTIg
KzQwLDEyIEBAIG1pcnJvcl95aWVsZF9pbl9mbGlnaHQodm9pZCAqcywgaW50NjRfdCBvZmZzZXQs
IGludCBpbl9mbGlnaHQpICJzICVwIG9mZnNldCAlIiBQDQo+PiAgICMgYmFja3VwLmMNCj4+ICAg
YmFja3VwX2RvX2Nvd19lbnRlcih2b2lkICpqb2IsIGludDY0X3Qgc3RhcnQsIGludDY0X3Qgb2Zm
c2V0LCB1aW50NjRfdCBieXRlcykgImpvYiAlcCBzdGFydCAlIiBQUklkNjQgIiBvZmZzZXQgJSIg
UFJJZDY0ICIgYnl0ZXMgJSIgUFJJdTY0DQo+PiAgIGJhY2t1cF9kb19jb3dfcmV0dXJuKHZvaWQg
KmpvYiwgaW50NjRfdCBvZmZzZXQsIHVpbnQ2NF90IGJ5dGVzLCBpbnQgcmV0KSAiam9iICVwIG9m
ZnNldCAlIiBQUklkNjQgIiBieXRlcyAlIiBQUkl1NjQgIiByZXQgJWQiDQo+PiAtYmFja3VwX2Rv
X2Nvd19za2lwKHZvaWQgKmpvYiwgaW50NjRfdCBzdGFydCkgImpvYiAlcCBzdGFydCAlIlBSSWQ2
NA0KPj4gLWJhY2t1cF9kb19jb3dfc2tpcF9yYW5nZSh2b2lkICpqb2IsIGludDY0X3Qgc3RhcnQs
IHVpbnQ2NF90IGJ5dGVzKSAiam9iICVwIHN0YXJ0ICUiUFJJZDY0IiBieXRlcyAlIlBSSWQ2NA0K
Pj4gLWJhY2t1cF9kb19jb3dfcHJvY2Vzcyh2b2lkICpqb2IsIGludDY0X3Qgc3RhcnQpICJqb2Ig
JXAgc3RhcnQgJSJQUklkNjQNCj4+IC1iYWNrdXBfZG9fY293X3JlYWRfZmFpbCh2b2lkICpqb2Is
IGludDY0X3Qgc3RhcnQsIGludCByZXQpICJqb2IgJXAgc3RhcnQgJSJQUklkNjQiIHJldCAlZCIN
Cj4+IC1iYWNrdXBfZG9fY293X3dyaXRlX2ZhaWwodm9pZCAqam9iLCBpbnQ2NF90IHN0YXJ0LCBp
bnQgcmV0KSAiam9iICVwIHN0YXJ0ICUiUFJJZDY0IiByZXQgJWQiDQo+PiAtYmFja3VwX2RvX2Nv
d19jb3B5X3JhbmdlX2ZhaWwodm9pZCAqam9iLCBpbnQ2NF90IHN0YXJ0LCBpbnQgcmV0KSAiam9i
ICVwIHN0YXJ0ICUiUFJJZDY0IiByZXQgJWQiDQo+PiArYmxvY2tfY29weV9za2lwKHZvaWQgKmJj
cywgaW50NjRfdCBzdGFydCkgImpvYiAlcCBzdGFydCAlIlBSSWQ2NA0KPj4gK2Jsb2NrX2NvcHlf
c2tpcF9yYW5nZSh2b2lkICpiY3MsIGludDY0X3Qgc3RhcnQsIHVpbnQ2NF90IGJ5dGVzKSAiam9i
ICVwIHN0YXJ0ICUiUFJJZDY0IiBieXRlcyAlIlBSSWQ2NA0KPj4gK2Jsb2NrX2NvcHlfcHJvY2Vz
cyh2b2lkICpiY3MsIGludDY0X3Qgc3RhcnQpICJqb2IgJXAgc3RhcnQgJSJQUklkNjQNCj4+ICti
bG9ja19jb3B5X3dpdGhfYm91bmNlX2J1ZmZlcl9yZWFkX2ZhaWwodm9pZCAqYmNzLCBpbnQ2NF90
IHN0YXJ0LCBpbnQgcmV0KSAiam9iICVwIHN0YXJ0ICUiUFJJZDY0IiByZXQgJWQiDQo+PiArYmxv
Y2tfY29weV93aXRoX2JvdW5jZV9idWZmZXJfd3JpdGVfZmFpbCh2b2lkICpiY3MsIGludDY0X3Qg
c3RhcnQsIGludCByZXQpICJqb2IgJXAgc3RhcnQgJSJQUklkNjQiIHJldCAlZCINCj4+ICtibG9j
a19jb3B5X3dpdGhfb2ZmbG9hZF9mYWlsKHZvaWQgKmJjcywgaW50NjRfdCBzdGFydCwgaW50IHJl
dCkgImpvYiAlcCBzdGFydCAlIlBSSWQ2NCIgcmV0ICVkIg0KPiANCj4gVGhlIG1lc3NhZ2VzIHBy
b2JhYmx5IHNob3VsZCBzdG9wIGNhbGxpbmcgaXQgYSDigJxqb2LigJ0sIHRvby4NCj4gDQoNCk9v
cHMgc29ycnksIEknZCBiZXR0ZXIgZG8gcy9qb2IvYmNzL2cgaW5zdGVhZCBvZiBmaXhpbmcgZmly
c3Qgam9iIGFyZ3VtZW50IGJ5IGhhbmQuDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1p
cg0K

