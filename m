Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD79C43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 09:14:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5F4620665
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 09:14:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="WBODdkGP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5F4620665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48960 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfL3A-00044T-L5
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 05:14:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51799)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hfL11-0002qt-5u
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 05:11:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hfL0y-0005Pf-Vg
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 05:11:54 -0400
Received: from mail-eopbgr20091.outbound.protection.outlook.com
 ([40.107.2.91]:32389 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1hfL0u-0004zK-2R; Mon, 24 Jun 2019 05:11:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DCk0mIjxa0F5JtlKrvleoEljX3SL3ZPDBvxluSvcROY=;
 b=WBODdkGPzKYhK/Yl8yP/I+yMk0yR95P12JCRhuQM/3WilXDZ+DKamDUE8EjemBHRU8mnUzgfsxz6YtphPVYXuHBzNPBAZRpuKm4PTqOpq+/WH42dfJMc6VqNmRbxv998WZlFVLmC4bMsRdqko0T1A+rAC/y2nRrnZwgx9z51oZ0=
Received: from VI1PR08MB3677.eurprd08.prod.outlook.com (20.177.61.92) by
 VI1PR08MB4096.eurprd08.prod.outlook.com (20.178.127.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.13; Mon, 24 Jun 2019 09:11:44 +0000
Received: from VI1PR08MB3677.eurprd08.prod.outlook.com
 ([fe80::4c71:9c23:235b:fbed]) by VI1PR08MB3677.eurprd08.prod.outlook.com
 ([fe80::4c71:9c23:235b:fbed%3]) with mapi id 15.20.2008.014; Mon, 24 Jun 2019
 09:11:43 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH] block/null: Expose read-zeroes option in QAPI schema
Thread-Index: AQHVJQPYbJ13XTr800OcU0XqUwiqHaaqj6SA
Date: Mon, 24 Jun 2019 09:11:43 +0000
Message-ID: <d98be8d7-1d08-6491-b456-d10b4db8e530@virtuozzo.com>
References: <20190617115721.27525-1-kwolf@redhat.com>
In-Reply-To: <20190617115721.27525-1-kwolf@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0901CA0062.eurprd09.prod.outlook.com
 (2603:10a6:3:45::30) To VI1PR08MB3677.eurprd08.prod.outlook.com
 (2603:10a6:803:85::28)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 92ce3b3d-7bc3-40ad-4af2-08d6f883f9c9
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:VI1PR08MB4096; 
x-ms-traffictypediagnostic: VI1PR08MB4096:
x-microsoft-antispam-prvs: <VI1PR08MB40965EA8CE2033B7334958BEF4E00@VI1PR08MB4096.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 007814487B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(366004)(396003)(39840400004)(136003)(376002)(199004)(189003)(53936002)(66476007)(66946007)(14454004)(73956011)(66066001)(53546011)(110136005)(386003)(6506007)(71200400001)(71190400001)(256004)(186003)(6116002)(44832011)(3846002)(25786009)(486006)(54906003)(476003)(2501003)(31696002)(52116002)(478600001)(102836004)(8936002)(11346002)(316002)(26005)(8676002)(64756008)(66556008)(99286004)(229853002)(66446008)(36756003)(6486002)(2906002)(68736007)(76176011)(14444005)(2616005)(6246003)(446003)(305945005)(7736002)(31686004)(6512007)(5660300002)(4326008)(81156014)(81166006)(6436002)(86362001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB4096;
 H:VI1PR08MB3677.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lT+BgqMWPEjZi0XqQyCpIi4A3exV8xpVlR91JtM1Fm0ebaANRCHk7iCBgRwmqb/TLeZxp8SCkWJ0GE1kqvjK5EgfZg/ttRRd7j5D5ji585vOrf/tv1+y476k7dH+12EJDzphuT+b2Lt3TV4X2WWgesNolNirynO3l2snV3qOQh2lbJtxfeAs1oyF6HUN3OxwF77CilSWZuBO+WVM4BsmQ11CZ02I/IZsKZKm4OHwtQT0XA+7fqBmL73qPxFhzRsady5q1S+Q89VN3aFFrXBTrdzyaUfWpGIx9Vq5jrAUV66AQ18TsITTlhU7aNeNAciGFbWWZCK5HE94KiEQhh8bBRwQG3P/YdI8D+SU3mc11JyoShf7llBMgwp3gQzJknJn46gwZXB5IE6kA/p4II1tV9EDQWBctovv+LazKVn5vYU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <408E5C6B14FF434E98EE7F38E3C927F1@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92ce3b3d-7bc3-40ad-4af2-08d6f883f9c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2019 09:11:43.7515 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: andrey.shinkevich@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4096
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.2.91
Subject: Re: [Qemu-devel] [PATCH] block/null: Expose read-zeroes option in
 QAPI schema
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDE3LzA2LzIwMTkgMTQ6NTcsIEtldmluIFdvbGYgd3JvdGU6DQo+IENvbW1pdCBjZDIx
OWViMWU1NSBhZGRlZCB0aGUgcmVhZC16ZXJvZXMgb3B0aW9uIGZvciB0aGUgbnVsbC1jbyBhbmQN
Cj4gbnVsbC1haW8gYmxvY2sgZHJpdmVyLCBidXQgZm9yZ290IHRvIGFkZCB0aGVtIHRvIHRoZSBR
QVBJIHNjaGVtYS4NCj4gVGhlcmVmb3JlLCB0aGlzIG9wdGlvbiB3YXNuJ3QgYXZhaWxhYmxlIGlu
IC1ibG9ja2RldiBhbmQgYmxvY2tkZXYtYWRkDQo+IHVudGlsIG5vdy4NCj4gDQo+IEFkZCB0aGUg
bWlzc2luZyBvcHRpb24gaW4gdGhlIHNjaGVtYSB0byBtYWtlIGl0IGF2YWlsYWJsZSB0aGVyZSwg
dG9vLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogS2V2aW4gV29sZiA8a3dvbGZAcmVkaGF0LmNvbT4N
Cj4gLS0tDQo+ICAgcWFwaS9ibG9jay1jb3JlLmpzb24gfCA0ICsrKy0NCj4gICAxIGZpbGUgY2hh
bmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
cWFwaS9ibG9jay1jb3JlLmpzb24gYi9xYXBpL2Jsb2NrLWNvcmUuanNvbg0KPiBpbmRleCA2MTEy
NDQzMWQ4Li4wZDQzZDRmMzdjIDEwMDY0NA0KPiAtLS0gYS9xYXBpL2Jsb2NrLWNvcmUuanNvbg0K
PiArKysgYi9xYXBpL2Jsb2NrLWNvcmUuanNvbg0KPiBAQCAtMjg5MCwxMSArMjg5MCwxMyBAQA0K
PiAgICMgQGxhdGVuY3ktbnM6IGVtdWxhdGVkIGxhdGVuY3kgKGluIG5hbm9zZWNvbmRzKSBpbiBw
cm9jZXNzaW5nDQo+ICAgIyAgICAgICAgICAgICAgcmVxdWVzdHMuIERlZmF1bHQgdG8gemVybyB3
aGljaCBjb21wbGV0ZXMgcmVxdWVzdHMgaW1tZWRpYXRlbHkuDQo+ICAgIyAgICAgICAgICAgICAg
KFNpbmNlIDIuNCkNCj4gKyMgQHJlYWQtemVyb2VzOiBpZiB0cnVlLCByZWFkcyBmcm9tIHRoZSBk
ZXZpY2UgcHJvZHVjZSB6ZXJvZXM7IGlmIGZhbHNlLCB0aGUNCj4gKyMgICAgICAgICAgICAgICBi
dWZmZXIgaXMgbGVmdCB1bmNoYW5nZWQuIChkZWZhdWx0OiBmYWxzZTsgc2luY2U6IDQuMSkNCj4g
ICAjDQo+ICAgIyBTaW5jZTogMi45DQo+ICAgIyMNCj4gICB7ICdzdHJ1Y3QnOiAnQmxvY2tkZXZP
cHRpb25zTnVsbCcsDQo+IC0gICdkYXRhJzogeyAnKnNpemUnOiAnaW50JywgJypsYXRlbmN5LW5z
JzogJ3VpbnQ2NCcgfSB9DQo+ICsgICdkYXRhJzogeyAnKnNpemUnOiAnaW50JywgJypsYXRlbmN5
LW5zJzogJ3VpbnQ2NCcsICcqcmVhZC16ZXJvZXMnOiAnYm9vbCcgfSB9DQo+ICAgDQo+ICAgIyMN
Cj4gICAjIEBCbG9ja2Rldk9wdGlvbnNOVk1lOg0KPiANCg0KUmV2aWV3ZWQtYnk6IEFuZHJleSBT
aGlua2V2aWNoIDxhbmRyZXkuc2hpbmtldmljaEB2aXJ0dW96em8uY29tPg0K

