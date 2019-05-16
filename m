Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A3A9C04AAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 16:03:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 353AE20833
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 16:03:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="P9umGCVJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 353AE20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60524 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRIr9-0004Mf-8D
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 12:03:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1hRIni-0001ub-FP
	for qemu-devel@nongnu.org; Thu, 16 May 2019 12:00:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1hRInh-0002H0-5H
	for qemu-devel@nongnu.org; Thu, 16 May 2019 12:00:10 -0400
Received: from mail-eopbgr40097.outbound.protection.outlook.com
	([40.107.4.97]:36621
	helo=EUR03-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
	id 1hRIng-0002CL-D2; Thu, 16 May 2019 12:00:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=cAkUW2M9LzUv+RmHZNx2zpLCOEgMLuK/k7JTosH7L9Y=;
	b=P9umGCVJlsHhLYnwdCkjJ3pO3swup6gathL0dmfnknRS62mSdOkFJqLYLPzGhyrRFkdYYJzriCz9Fldg9/TYPbW4wk6s9SXzaKvlDIw0sBGxphFqhuF+XbyZIso7hAHoh2jUSoAS90ZrKbqm3RBIIV6okrHekPszC7Xzdvlnays=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
	VI1PR08MB3726.eurprd08.prod.outlook.com (20.178.14.145) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1900.16; Thu, 16 May 2019 16:00:05 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
	([fe80::48f:a107:e2ac:a28f]) by VI1PR08MB4078.eurprd08.prod.outlook.com
	([fe80::48f:a107:e2ac:a28f%7]) with mapi id 15.20.1900.010;
	Thu, 16 May 2019 16:00:05 +0000
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
	"qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [PATCH v8 3/9] block: add empty account cookie type
Thread-Index: AQHVC/RUlONwaQA4l0SCHbjjqML0laZt4dmAgAAHFQA=
Date: Thu, 16 May 2019 16:00:04 +0000
Message-ID: <652ee334-b1aa-321b-85fb-8b67284cf979@virtuozzo.com>
References: <20190516143314.81302-1-anton.nefedov@virtuozzo.com>
	<20190516143314.81302-4-anton.nefedov@virtuozzo.com>
	<7618e582-195b-56c4-7525-d166d7d0e40b@virtuozzo.com>
In-Reply-To: <7618e582-195b-56c4-7525-d166d7d0e40b@virtuozzo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0202CA0045.eurprd02.prod.outlook.com
	(2603:10a6:3:e4::31) To VI1PR08MB4078.eurprd08.prod.outlook.com
	(2603:10a6:803:e5::28)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=anton.nefedov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aad9cc25-1a00-4ca6-ba69-08d6da178f94
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);
	SRVR:VI1PR08MB3726; 
x-ms-traffictypediagnostic: VI1PR08MB3726:
x-microsoft-antispam-prvs: <VI1PR08MB3726924EA3CE50F6C7921CBFF80A0@VI1PR08MB3726.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-forefront-prvs: 0039C6E5C5
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(136003)(346002)(376002)(396003)(366004)(39850400004)(189003)(199004)(5660300002)(71200400001)(71190400001)(66446008)(64756008)(53936002)(73956011)(6116002)(31686004)(3846002)(66476007)(66556008)(66946007)(4326008)(6486002)(229853002)(6436002)(6246003)(14444005)(256004)(6512007)(25786009)(486006)(99286004)(68736007)(76176011)(446003)(476003)(186003)(2616005)(110136005)(52116002)(15650500001)(386003)(53546011)(86362001)(2906002)(6506007)(44832011)(11346002)(478600001)(316002)(14454004)(31696002)(54906003)(36756003)(66066001)(26005)(7736002)(102836004)(8676002)(81156014)(81166006)(8936002)(2501003)(305945005);
	DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB3726;
	H:VI1PR08MB4078.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Zgf7RfrO4Am5SQiFsqYXhWXLKTV2zRmpiduwRm2rWtBFJFhENDGPElNx9YYKGWB5yRDDVgpeHNqVK1kd85iR6PkmC1HNNNvNgHrzxalvkUJ8n2x4Dz7QrKo2JtngbaJLvUxOp1wuS23c59kNO0eE+7FtJ4dAekmt7yDMrOGbuJf9us3sCdRe44z3lFixpU+vFhhMmhwfipKDCRtKU4zp4rIFvSulPs+Ht8znmqBlLi4o4UqYmWugtsmX93jP1siDydVSfUAFN7VbwfA9Q7af9kNaApxYqvceTuHMNn82P1RajmoG36HsvLnSkegatZPma+zZXmJQn6UxrO/3EuBzh3OTFQSkqWK9M2Z2h284YmJdxPWJBL64FIaI2/e4wovZ2zPvyGyReRPUHTFKaRya9ClojgRLVCmg/8rq2hzBfB8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CBEDDABEC69079449D8FF1A4C2FF7F66@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aad9cc25-1a00-4ca6-ba69-08d6da178f94
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2019 16:00:04.9054 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3726
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.4.97
Subject: Re: [Qemu-devel] [PATCH v8 3/9] block: add empty account cookie type
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
	"berto@igalia.com" <berto@igalia.com>, Denis Lunev <den@virtuozzo.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"mreitz@redhat.com" <mreitz@redhat.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gMTYvNS8yMDE5IDY6MzQgUE0sIFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgd3JvdGU6
DQo+IDE2LjA1LjIwMTkgMTc6MzMsIEFudG9uIE5lZmVkb3Ygd3JvdGU6DQo+PiBUaGlzIGFkZHMg
c29tZSBwcm90ZWN0aW9uIGZyb20gYWNjb3VudGluZyB1bmluaXRpYWxpemVkIGNvb2tpZS4NCj4+
IFRoYXQgaXMsIGJsb2NrX2FjY3RfZmFpbGVkL2RvbmUgd2l0aG91dCBwcmV2aW91cyBibG9ja19h
Y2N0X3N0YXJ0Ow0KPj4gaW4gdGhhdCBjYXNlLCBjb29raWUgcHJvYmFibHkgaG9sZHMgdmFsdWVz
IGZyb20gcHJldmlvdXMgb3BlcmF0aW9uLg0KPj4NCj4+IChOb3RlOiBpdCBtaWdodCBhbHNvIGJl
IHVuaW5pdGlhbGl6ZWQgaG9sZGluZyBnYXJiYWdlIHZhbHVlIGFuZCB0aGVyZSBpcw0KPj4gICAg
c3RpbGwgIjwgQkxPQ0tfTUFYX0lPVFlQRSIgYXNzZXJ0aW9uIGZvciB0aGF0Lg0KPj4gICAgU28g
YmxvY2tfYWNjdF9mYWlsZWQvZG9uZSB3aXRob3V0IHByZXZpb3VzIGJsb2NrX2FjY3Rfc3RhcnQg
c2hvdWxkIGJlIHVzZWQNCj4+ICAgIHdpdGggY2F1dGlvbi4pDQo+Pg0KPj4gQ3VycmVudGx5IHRo
aXMgaXMgcGFydGljdWxhcmx5IHVzZWZ1bCBpbiBpZGUgY29kZSB3aGVyZSBpdCdzIGhhcmQgdG8N
Cj4+IGtlZXAgdHJhY2sgd2hldGhlciB0aGUgcmVxdWVzdCBzdGFydGVkIGFjY291bnRpbmcgb3Ig
bm90LiBGb3IgZXhhbXBsZSwNCj4+IHRyaW0gcmVxdWVzdHMgZG8gdGhlIGFjY291bnRpbmcgc2Vw
YXJhdGVseS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBBbnRvbiBOZWZlZG92IDxhbnRvbi5uZWZl
ZG92QHZpcnR1b3p6by5jb20+DQo+PiAtLS0NCj4+ICAgIGluY2x1ZGUvYmxvY2svYWNjb3VudGlu
Zy5oIHwgMSArDQo+PiAgICBibG9jay9hY2NvdW50aW5nLmMgICAgICAgICB8IDYgKysrKysrDQo+
PiAgICAyIGZpbGVzIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYgLS1naXQg
YS9pbmNsdWRlL2Jsb2NrL2FjY291bnRpbmcuaCBiL2luY2x1ZGUvYmxvY2svYWNjb3VudGluZy5o
DQo+PiBpbmRleCBiYThiMDRkNTcyLi44NzhiNGMzNTgxIDEwMDY0NA0KPj4gLS0tIGEvaW5jbHVk
ZS9ibG9jay9hY2NvdW50aW5nLmgNCj4+ICsrKyBiL2luY2x1ZGUvYmxvY2svYWNjb3VudGluZy5o
DQo+PiBAQCAtMzMsNiArMzMsNyBAQCB0eXBlZGVmIHN0cnVjdCBCbG9ja0FjY3RUaW1lZFN0YXRz
IEJsb2NrQWNjdFRpbWVkU3RhdHM7DQo+PiAgICB0eXBlZGVmIHN0cnVjdCBCbG9ja0FjY3RTdGF0
cyBCbG9ja0FjY3RTdGF0czsNCj4+ICAgIA0KPj4gICAgZW51bSBCbG9ja0FjY3RUeXBlIHsNCj4+
ICsgICAgQkxPQ0tfQUNDVF9OT05FID0gMCwNCj4+ICAgICAgICBCTE9DS19BQ0NUX1JFQUQsDQo+
PiAgICAgICAgQkxPQ0tfQUNDVF9XUklURSwNCj4+ICAgICAgICBCTE9DS19BQ0NUX0ZMVVNILA0K
Pj4gZGlmZiAtLWdpdCBhL2Jsb2NrL2FjY291bnRpbmcuYyBiL2Jsb2NrL2FjY291bnRpbmcuYw0K
Pj4gaW5kZXggNzBhM2Q5YTQyNi4uOGQ0MWM4YTgzYSAxMDA2NDQNCj4+IC0tLSBhL2Jsb2NrL2Fj
Y291bnRpbmcuYw0KPj4gKysrIGIvYmxvY2svYWNjb3VudGluZy5jDQo+PiBAQCAtMTk1LDYgKzE5
NSwxMCBAQCBzdGF0aWMgdm9pZCBibG9ja19hY2NvdW50X29uZV9pbyhCbG9ja0FjY3RTdGF0cyAq
c3RhdHMsIEJsb2NrQWNjdENvb2tpZSAqY29va2llLA0KPj4gICAgDQo+PiAgICAgICAgYXNzZXJ0
KGNvb2tpZS0+dHlwZSA8IEJMT0NLX01BWF9JT1RZUEUpOw0KPj4gICAgDQo+PiArICAgIGlmIChj
b29raWUtPnR5cGUgPT0gQkxPQ0tfQUNDVF9OT05FKSB7DQo+IA0KPiB3b3J0aCBlcnJvcl9yZXBv
cnQoKSA/DQo+IA0KDQpJIGRvbid0IHRoaW5rIHdlIHNob3VsZCBuZWNlc3NhcmlseSBjb25zaWRl
ciBpdCBhbiBlcnJvcjsNCmFzIG1lbnRpb25lZCBpbiB0aGUgY29tbWl0IG1lc3NhZ2UgdGhpcyBt
aWdodCBiZSB1c2VmdWwgaW4gc29tZSBwbGFjZXMNCmxpa2UgSURFIHRyaW0gaGFuZGxpbmcuDQo=

