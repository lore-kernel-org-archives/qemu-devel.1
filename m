Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C713AC10F13
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 15:44:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71E0A21473
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 15:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ZzGRfh1D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71E0A21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55130 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDWS3-0005jR-Nm
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 11:44:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hDWQr-00054N-Cp
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 11:43:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hDWQq-00060L-Bf
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 11:43:37 -0400
Received: from mail-eopbgr30130.outbound.protection.outlook.com
	([40.107.3.130]:12491
	helo=EUR03-AM5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
	id 1hDWQj-0005rL-M5; Mon, 08 Apr 2019 11:43:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=WSphofrbxSf5UyfUSIn1iYToxmnImZM7rKUdAN4qKZQ=;
	b=ZzGRfh1Dt5CUpseUQ3J2UHquuOXhJPK2jPq8+qdVG0xvRkMKLH7zZYi7LXXRqkPeICPPfHNf3WEaCab1Nq7ZjYcQV/8kAOhhdF6HEUSHJpxlFY9VUUhkQEsQx+WNj70m/eWO0jweWHm8FpaHdQ5lyHfYEUcylpsQ+Y213R5FQos=
Received: from AM6PR08MB4421.eurprd08.prod.outlook.com (20.179.18.23) by
	AM6PR08MB4660.eurprd08.prod.outlook.com (10.255.96.17) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1771.15; Mon, 8 Apr 2019 15:43:26 +0000
Received: from AM6PR08MB4421.eurprd08.prod.outlook.com
	([fe80::d15a:3eaa:44bc:2644]) by
	AM6PR08MB4421.eurprd08.prod.outlook.com
	([fe80::d15a:3eaa:44bc:2644%4]) with mapi id 15.20.1771.019;
	Mon, 8 Apr 2019 15:43:26 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Alberto Garcia <berto@igalia.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [PATCH v3 3/3] block/stream: introduce a bottom node
Thread-Index: AQHU69CHIwn9BmbH/EaqcUPHOcgaUaYyav4AgAAA+gA=
Date: Mon, 8 Apr 2019 15:43:26 +0000
Message-ID: <b3c0f4bb-c606-0628-ea42-4703a2130991@virtuozzo.com>
References: <1554483379-682051-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1554483379-682051-4-git-send-email-andrey.shinkevich@virtuozzo.com>
	<w511s2cy08l.fsf@maestria.local.igalia.com>
In-Reply-To: <w511s2cy08l.fsf@maestria.local.igalia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P191CA0017.EURP191.PROD.OUTLOOK.COM (2603:10a6:3:cf::27)
	To AM6PR08MB4421.eurprd08.prod.outlook.com
	(2603:10a6:20b:71::23)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d72fc0f5-8f7d-4bf6-3f84-08d6bc38f0d8
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);
	SRVR:AM6PR08MB4660; 
x-ms-traffictypediagnostic: AM6PR08MB4660:
x-microsoft-antispam-prvs: <AM6PR08MB46605B9F37DE15119D8C52ECF42C0@AM6PR08MB4660.eurprd08.prod.outlook.com>
x-forefront-prvs: 0001227049
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(136003)(346002)(396003)(366004)(39840400004)(376002)(199004)(189003)(6436002)(68736007)(66066001)(6246003)(52116002)(14454004)(107886003)(476003)(6116002)(486006)(3846002)(229853002)(99286004)(2616005)(5660300002)(36756003)(186003)(71200400001)(6486002)(11346002)(71190400001)(26005)(106356001)(105586002)(76176011)(446003)(44832011)(53936002)(102836004)(86362001)(386003)(7736002)(54906003)(305945005)(25786009)(2906002)(53546011)(110136005)(256004)(31686004)(8936002)(8676002)(97736004)(2501003)(478600001)(316002)(81156014)(6506007)(31696002)(2201001)(81166006)(4326008)(14444005)(6512007);
	DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4660;
	H:AM6PR08MB4421.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VijlyaUWkoHl4ftElGY3HIOvfXHKJFY1HoEEVZ3Sterrpk7GaFX9aJ382dA87EmArVUJuTCRCOYGTNybtXDnhQ5ANv67Of2RZLwZYoK/e2CrBbsWIjQL9TLI1xmbUg0zz7t+l/6C6AQGcxFZuxGrzOmdIh3c+LOf3WR7BQe+rX+p8grCmUA+pJy1AUe6zso85D9h6IR2HrFExuGI//PefQShqOLCcN5cyA2338p4zRHCvx06vDcNmRX1Gc/8O7fP3T2N2V5wmpMBhhuiXfRUAMgfZ9ftFDaTIgUFKsqFemO9BPblsVDx3ZEhs2MFa9HfpIMkmukKMcF/I2hQo0naK7msNqepUdlUHQwN4bnXddREJQFjtPd8UbC57TOLUlg5DlopKUmRfOPPAO2OqD64U1tbks7dbJD+NQmM06K1xv8=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <75DCF3C212AAB845890A99784C37DFE8@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d72fc0f5-8f7d-4bf6-3f84-08d6bc38f0d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2019 15:43:26.6689 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4660
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.3.130
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
Message-ID: <20190408154326.t8kyIdBFS7-yvdxp0hnqEugTPNUZoaBojr07ZY86xKg@z>

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
c2UgaGVyZSA/Pw0KPiANCj4+ICsgICAgLyoNCj4+ICsgICAgICogQmxvY2sgYWxsIGludGVybWVk
aWF0ZSBub2RlcyBiZXR3ZWVuIGJzIGFuZCBib3R0b20gKGluY2x1c2l2ZSksIGJlY2F1c2UNCj4+
ICsgICAgICogdGhleSB3aWxsIGRpc2FwcGVhciBmcm9tIHRoZSBjaGFpbiBhZnRlciB0aGlzIG9w
ZXJhdGlvbi4gVGhlIHN0cmVhbWluZw0KPj4gKyAgICAgKiBqb2IgcmVhZHMgZXZlcnkgYmxvY2sg
b25seSBvbmNlLCBhc3N1bWluZyB0aGF0IGl0IGRvZXNuJ3QgY2hhbmdlLCBzbw0KPj4gKyAgICAg
KiBmb3JiaWQgd3JpdGVzIGFuZCByZXNpemVzLg0KPj4gKyAgICAgKi8NCj4+ICsgICAgZm9yIChp
dGVyID0gYnM7IGl0ZXIgIT0gYm90dG9tOyBpdGVyID0gYmFja2luZ19icyhpdGVyKSkgew0KPj4g
KyAgICAgICAgYmxvY2tfam9iX2FkZF9iZHJ2KCZzLT5jb21tb24sICJpbnRlcm1lZGlhdGUgbm9k
ZSIsIGJhY2tpbmdfYnMoaXRlciksDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgMCwg
YmFzaWNfZmxhZ3MsICZlcnJvcl9hYm9ydCk7DQo+PiAgICAgICB9DQo+IA0KPiBUaGlzIHN0b3Bz
IHdoZW4gaXRlciA9PSBib3R0b20sIHNvIGJvdHRvbSBpcyBub3QgYWN0dWFsbHkgYmxvY2tlZC4N
Cj4gDQo+PiBkaWZmIC0tZ2l0IGEvYmxvY2svdHJhY2UtZXZlbnRzIGIvYmxvY2svdHJhY2UtZXZl
bnRzDQo+PiBpbmRleCA3MzM1YTQyLi41MzY2ZDQ1IDEwMDY0NA0KPj4gLS0tIGEvYmxvY2svdHJh
Y2UtZXZlbnRzDQo+PiArKysgYi9ibG9jay90cmFjZS1ldmVudHMNCj4+IEBAIC0yMCw3ICsyMCw3
IEBAIGJkcnZfY29fY29weV9yYW5nZV90byh2b2lkICpzcmMsIHVpbnQ2NF90IHNyY19vZmZzZXQs
IHZvaWQgKmRzdCwgdWludDY0X3QgZHN0X29mDQo+PiAgIA0KPj4gICAjIHN0cmVhbS5jDQo+PiAg
IHN0cmVhbV9vbmVfaXRlcmF0aW9uKHZvaWQgKnMsIGludDY0X3Qgb2Zmc2V0LCB1aW50NjRfdCBi
eXRlcywgaW50IGlzX2FsbG9jYXRlZCkgInMgJXAgb2Zmc2V0ICUiIFBSSWQ2NCAiIGJ5dGVzICUi
IFBSSXU2NCAiIGlzX2FsbG9jYXRlZCAlZCINCj4+IC1zdHJlYW1fc3RhcnQodm9pZCAqYnMsIHZv
aWQgKmJhc2UsIHZvaWQgKnMpICJicyAlcCBiYXNlICVwIHMgJXAiDQo+PiArc3RyZWFtX3N0YXJ0
KHZvaWQgKmJzLCB2b2lkICpib3R0b20sIHZvaWQgKnMpICJicyAlcCBib3R0b20gJXAgcyAlcCIN
Cj4gDQo+IElzIHRoaXMgY2hhbmdlIHN0aWxsIGNvcnJlY3Q/IFdlIGRvbid0IHBhc3MgYm90dG9t
IGFueW1vcmUuDQo+IA0KPiBCZXJ0bw0KPiANCg0KWWVzLCBJIHdpbGwgcm9sbCBJdCBiYWNrLg0K
LS0gDQpXaXRoIHRoZSBiZXN0IHJlZ2FyZHMsDQpBbmRyZXkgU2hpbmtldmljaA0K

