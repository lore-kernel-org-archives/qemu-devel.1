Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7862DC10F14
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 18:19:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA99C2084C
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 18:19:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="KjBRxdb7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA99C2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56974 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDYrP-0002ep-Kx
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 14:19:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hDYq7-00023y-M5
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 14:17:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hDYq5-0001Bn-NX
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 14:17:51 -0400
Received: from mail-ve1eur01on0721.outbound.protection.outlook.com
	([2a01:111:f400:fe1f::721]:52611
	helo=EUR01-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
	id 1hDYpy-00016Y-QK; Mon, 08 Apr 2019 14:17:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=5GmyEhCyjg+C1Fc7IuUHATxvEjwEnC7XG5wsNTH2R1E=;
	b=KjBRxdb7gGQKFum+N75wQnF+A6IYSpE7QfyqFUSPrlQk5nuvy0vNOIcuQpHyyaImfYno3sO2NMslVQFbljzwuiOZNq6TrPdUMq0tVG++hVl0rKuArmtqYScVse3Qrzkuspc4r1qp2kstEibNn0x+iXm6TvvjM2KpOkYhLqXgOuc=
Received: from AM6PR08MB4421.eurprd08.prod.outlook.com (20.179.18.23) by
	AM6PR08MB4389.eurprd08.prod.outlook.com (20.179.6.208) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1771.13; Mon, 8 Apr 2019 18:17:37 +0000
Received: from AM6PR08MB4421.eurprd08.prod.outlook.com
	([fe80::d15a:3eaa:44bc:2644]) by
	AM6PR08MB4421.eurprd08.prod.outlook.com
	([fe80::d15a:3eaa:44bc:2644%4]) with mapi id 15.20.1771.019;
	Mon, 8 Apr 2019 18:17:37 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Alberto Garcia <berto@igalia.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [PATCH v3 3/3] block/stream: introduce a bottom node
Thread-Index: AQHU69CHIwn9BmbH/EaqcUPHOcgaUaYyav4AgAAsDoA=
Date: Mon, 8 Apr 2019 18:17:37 +0000
Message-ID: <15f8499f-812d-1bf9-ad22-21971687826a@virtuozzo.com>
References: <1554483379-682051-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1554483379-682051-4-git-send-email-andrey.shinkevich@virtuozzo.com>
	<w511s2cy08l.fsf@maestria.local.igalia.com>
In-Reply-To: <w511s2cy08l.fsf@maestria.local.igalia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P190CA0017.EURP190.PROD.OUTLOOK.COM (2603:10a6:3:bc::27)
	To AM6PR08MB4421.eurprd08.prod.outlook.com
	(2603:10a6:20b:71::23)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7f6b3ab4-e0ee-4071-b826-08d6bc4e7aba
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
	SRVR:AM6PR08MB4389; 
x-ms-traffictypediagnostic: AM6PR08MB4389:
x-microsoft-antispam-prvs: <AM6PR08MB43891F75FAD5F7138BDA4CDDF42C0@AM6PR08MB4389.eurprd08.prod.outlook.com>
x-forefront-prvs: 0001227049
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(366004)(39850400004)(376002)(396003)(346002)(136003)(189003)(199004)(81156014)(53936002)(66066001)(26005)(81166006)(186003)(71190400001)(478600001)(76176011)(8936002)(5660300002)(386003)(6506007)(256004)(14444005)(102836004)(53546011)(6246003)(2906002)(2616005)(31686004)(11346002)(110136005)(6116002)(486006)(476003)(52116002)(446003)(3846002)(54906003)(68736007)(305945005)(107886003)(316002)(25786009)(14454004)(44832011)(8676002)(6512007)(36756003)(71200400001)(7736002)(99286004)(4326008)(6486002)(2201001)(2501003)(6436002)(31696002)(97736004)(86362001)(229853002)(105586002)(106356001);
	DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4389;
	H:AM6PR08MB4421.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kK8Yuhj3oO3zr4+fT0g5ZSGI+uFwEy58P433rGS7nXcA+AncEpGvc6PYPuThyY+JlJ4gWRCmQ26ONGzYxx0ROtA7mPScUpL+jD27C1mWJxgBJGVOjrRGSjLoWPUVXG7YoMbsj2Gxmjufudvq+bp5DhnN6hxGp7nH9dKSKGQYVf7LNRYsszgD6ufWPNTgi1438IzIxhaLJ0kvG+d1Sw9Qd0WQcXpj56xRu5R78bOn1HRpNz78Tn9Ptu1oaybKi17Vtazhe4T5vm263FEmtsSbfPJ4yYzwqiYR2HwEUntfBBLEvmCn3uFItUDHjYUFnrnTvlHmfNxExpvEaCbueYbbbUWDa6/4ybdohnOLAPGJIIVVp+0RlAuq2agIfXqJbZtIJzzo9+f0G40G8IDINkxSbsmkLbbMvE/0p/PwhErpi5E=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <7DA0E3F6940E7243B924E47B18E502FE@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f6b3ab4-e0ee-4071-b826-08d6bc4e7aba
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2019 18:17:37.4303 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4389
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe1f::721
Subject: Re: [Qemu-devel] [PATCH v3 3/3] block/stream: introduce a bottom
 node
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
	Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
	Denis Lunev <den@virtuozzo.com>, "mreitz@redhat.com" <mreitz@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>,
	"jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408181737.ZpjV9EPry1XTNS46P9QGFkkvc7NPa1h0RxaBJXCC-9Q@z>

DQoNCk9uIDA4LzA0LzIwMTkgMTg6MzksIEFsYmVydG8gR2FyY2lhIHdyb3RlOg0KPiBPbiBGcmkg
MDUgQXByIDIwMTkgMDY6NTY6MTkgUE0gQ0VTVCwgQW5kcmV5IFNoaW5rZXZpY2ggd3JvdGU6DQo+
PiBAQCAtMjMyLDggKzIzMiwxMyBAQCB2b2lkIHN0cmVhbV9zdGFydChjb25zdCBjaGFyICpqb2Jf
aWQsIEJsb2NrRHJpdmVyU3RhdGUgKmJzLA0KPj4gICAgICAgU3RyZWFtQmxvY2tKb2IgKnM7DQo+
PiAgICAgICBCbG9ja0RyaXZlclN0YXRlICppdGVyOw0KPj4gICAgICAgYm9vbCBic19yZWFkX29u
bHk7DQo+PiArICAgIEJsb2NrRHJpdmVyU3RhdGUgKmJvdHRvbSA9IE5VTEw7DQo+PiArICAgIGlu
dCBiYXNpY19mbGFncyA9IEJMS19QRVJNX0NPTlNJU1RFTlRfUkVBRCB8IEJMS19QRVJNX1dSSVRF
X1VOQ0hBTkdFRDsNCj4+ICsNCj4+ICsgICAgLyogRmluZCB0aGUgYm90dG9tIG5vZGUgdGhhdCBo
YXMgdGhlIGJhc2UgYXMgaXRzIGJhY2tpbmcgaW1hZ2UgKi8NCj4+ICsgICAgYm90dG9tID0gYmRy
dl9maW5kX292ZXJsYXkoYnMsIGJhc2UpOw0KPiANCj4gV2hhdCBoYXBwZW5zIGlmIGJzID09IGJh
c2UgaGVyZSA/Pw0KPiANCg0KQWN0dWFsbHksIHRoYXQgY29uZGl0aW9uIGlzIGNoZWNrZWQgaW4g
dGhlIHFtcF9ibG9ja19zdHJlYW0oKS4NCkkgdXNlZCB0byBoYXZlIHRoZSAnYXNzZXJ0KGJvdHRv
bSknIGFmdGVyIHRoZSBjYWxsIHRvIHRoZQ0KYmRydl9maW5kX292ZXJsYXkoYnMsIGJhc2UpIGlu
IHRoZSBxbXBfYmxvY2tfc3RyZWFtKCkgb2YgdGhlIHYyLg0KDQo+PiArICAgIC8qDQo+PiArICAg
ICAqIEJsb2NrIGFsbCBpbnRlcm1lZGlhdGUgbm9kZXMgYmV0d2VlbiBicyBhbmQgYm90dG9tIChp
bmNsdXNpdmUpLCBiZWNhdXNlDQo+PiArICAgICAqIHRoZXkgd2lsbCBkaXNhcHBlYXIgZnJvbSB0
aGUgY2hhaW4gYWZ0ZXIgdGhpcyBvcGVyYXRpb24uIFRoZSBzdHJlYW1pbmcNCj4+ICsgICAgICog
am9iIHJlYWRzIGV2ZXJ5IGJsb2NrIG9ubHkgb25jZSwgYXNzdW1pbmcgdGhhdCBpdCBkb2Vzbid0
IGNoYW5nZSwgc28NCj4+ICsgICAgICogZm9yYmlkIHdyaXRlcyBhbmQgcmVzaXplcy4NCj4+ICsg
ICAgICovDQo+PiArICAgIGZvciAoaXRlciA9IGJzOyBpdGVyICE9IGJvdHRvbTsgaXRlciA9IGJh
Y2tpbmdfYnMoaXRlcikpIHsNCj4+ICsgICAgICAgIGJsb2NrX2pvYl9hZGRfYmRydigmcy0+Y29t
bW9uLCAiaW50ZXJtZWRpYXRlIG5vZGUiLCBiYWNraW5nX2JzKGl0ZXIpLA0KPj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgIDAsIGJhc2ljX2ZsYWdzLCAmZXJyb3JfYWJvcnQpOw0KPj4gICAg
ICAgfQ0KPiANCj4gVGhpcyBzdG9wcyB3aGVuIGl0ZXIgPT0gYm90dG9tLCBzbyBib3R0b20gaXMg
bm90IGFjdHVhbGx5IGJsb2NrZWQuDQoNClRoZSBib3R0b20gaXMgYWN0dWFsbHkgYmxvY2tlZCBi
ZWNhdXNlDQpiYWNraW5nX2JzKGl0ZXIpID09IGJvdHRvbSBpcyBwYXNzZWQgdG8gdGhlIGJsb2Nr
X2pvYl9hZGRfYmRydigpDQp3aXRoIHRoZSBsYXN0IGl0ZXJhdGlvbiBvZiB0aGUgbG9vcC4NCg0K
PiANCj4+IGRpZmYgLS1naXQgYS9ibG9jay90cmFjZS1ldmVudHMgYi9ibG9jay90cmFjZS1ldmVu
dHMNCj4+IGluZGV4IDczMzVhNDIuLjUzNjZkNDUgMTAwNjQ0DQo+PiAtLS0gYS9ibG9jay90cmFj
ZS1ldmVudHMNCj4+ICsrKyBiL2Jsb2NrL3RyYWNlLWV2ZW50cw0KPj4gQEAgLTIwLDcgKzIwLDcg
QEAgYmRydl9jb19jb3B5X3JhbmdlX3RvKHZvaWQgKnNyYywgdWludDY0X3Qgc3JjX29mZnNldCwg
dm9pZCAqZHN0LCB1aW50NjRfdCBkc3Rfb2YNCj4+ICAgDQo+PiAgICMgc3RyZWFtLmMNCj4+ICAg
c3RyZWFtX29uZV9pdGVyYXRpb24odm9pZCAqcywgaW50NjRfdCBvZmZzZXQsIHVpbnQ2NF90IGJ5
dGVzLCBpbnQgaXNfYWxsb2NhdGVkKSAicyAlcCBvZmZzZXQgJSIgUFJJZDY0ICIgYnl0ZXMgJSIg
UFJJdTY0ICIgaXNfYWxsb2NhdGVkICVkIg0KPj4gLXN0cmVhbV9zdGFydCh2b2lkICpicywgdm9p
ZCAqYmFzZSwgdm9pZCAqcykgImJzICVwIGJhc2UgJXAgcyAlcCINCj4+ICtzdHJlYW1fc3RhcnQo
dm9pZCAqYnMsIHZvaWQgKmJvdHRvbSwgdm9pZCAqcykgImJzICVwIGJvdHRvbSAlcCBzICVwIg0K
PiANCj4gSXMgdGhpcyBjaGFuZ2Ugc3RpbGwgY29ycmVjdD8gV2UgZG9uJ3QgcGFzcyBib3R0b20g
YW55bW9yZS4NCj4gDQo+IEJlcnRvDQo+IA0KDQotLSANCldpdGggdGhlIGJlc3QgcmVnYXJkcywN
CkFuZHJleSBTaGlua2V2aWNoDQo=

