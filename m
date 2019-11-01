Return-Path: <SRS0=V8KP=YZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C1A9CA9ECF
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 10:10:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41D852086D
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 10:10:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="WNlETwjj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41D852086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQTtC-0006ph-Cj
	for qemu-devel@archiver.kernel.org; Fri, 01 Nov 2019 06:10:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41861)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iQTs7-0005uU-E7
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 06:09:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iQTs6-0004lJ-5r
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 06:09:35 -0400
Received: from mail-eopbgr60111.outbound.protection.outlook.com
 ([40.107.6.111]:45999 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iQTs1-0004MZ-W6; Fri, 01 Nov 2019 06:09:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R8XRTqU9MkxtkZpHlsIGj6hoBIT81vPII2Y4Gm9XgVV4EcJ1Yd2mnKqQ29NziYCOL2KjsulX3c3N+R64HQOmYJ75yv91QKw1pdVJ5L4QHtQcJy/HaqvFqhaP+BZia1GlL4y5KjOvIa/EfUh8C71EFlTlbrBWJJMS37WsXEkMIWRzYQrwRZ++5Lnu4mC1LX9WStLoOukwW7qdFZFw7kK0iTQltgBUcFnpPdYOaAQFwK3OrZJCOgIEAu/Hv3npkPZfEHK8tddbNfrIf0aQAFAP7g/j+Hj9L+YrYS+aVNzYq1gFwUr5PhWentJnyBSCZtrn1Jvk55oKB8ldiE2qi0eVgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=keYtYHblYt7FCMwmDQlDansx4DfD46tqoJzUwBEEQBs=;
 b=Z62c+ETuwc0CNidMiwKuC/yZiHyY91A1kH43pSb+wrtdbE/z5qQoiw2KcQs7NklN8y5WRhyOirdYycqRw0//SxQ4HHFJgTrQklSCG7ofRfsPm5+QB2ErJPxS+ayvD9spPAs4re1WMIrN+TY5yAXiiZ0veJ9lxuTJNnYnYGnaijfOuCT4t7rprYSngSMF+wJPJanoFAVlbpOav06t4G57eXZTFeVRlCEJcvk+n5JsNJHg3oU7mJLmzS8236vAX+I5xUtv5YjRPCufqJbtj8ECuWpR3RMJBkEY5wjc2RZQSeIDjMpgXf3hQmdJfOFIH6NwKOZIQWAyzv3ctI+t+xcxbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=keYtYHblYt7FCMwmDQlDansx4DfD46tqoJzUwBEEQBs=;
 b=WNlETwjjpnmJKDc08aYYkFBdeJZz4Q7M6OIDtam/mycoN1GeHiNZRvkM48kIxjQxjCixb/G/nodLn00+0G1LBJbDjOcKav9u9xA+qOtOOOS6uHp55pdWW1qTbLIy3xDFRM4alA8DwoYTtdZRNYa8c4uX3jNYUf64Pm6co+1FFX8=
Received: from AM0PR08MB4097.eurprd08.prod.outlook.com (20.178.202.217) by
 AM0PR08MB3122.eurprd08.prod.outlook.com (52.134.93.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.24; Fri, 1 Nov 2019 10:09:27 +0000
Received: from AM0PR08MB4097.eurprd08.prod.outlook.com
 ([fe80::6844:bb8c:7d2c:b119]) by AM0PR08MB4097.eurprd08.prod.outlook.com
 ([fe80::6844:bb8c:7d2c:b119%6]) with mapi id 15.20.2408.019; Fri, 1 Nov 2019
 10:09:27 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Tuguoyi <tu.guoyi@h3c.com>, "kwolf@redhat.com" <kwolf@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH v4] qcow2-bitmap: Fix uint64_t left-shift overflow
Thread-Topic: [PATCH v4] qcow2-bitmap: Fix uint64_t left-shift overflow
Thread-Index: AdWQhrb0bffMwMc6ShSREntjykPuIgAKDhOA///RRICAAAm8AA==
Date: Fri, 1 Nov 2019 10:09:27 +0000
Message-ID: <dcdf7075-45f4-8ba1-69fc-17cd673125ca@virtuozzo.com>
References: <4ba40cd1e7ee4a708b40899952e49f22@h3c.com>
 <8b7d3d50-4a29-a8b3-5b6c-cde4af1b1d7a@virtuozzo.com>
 <7650a7b706d24774b4ea3af23a2b371f@h3c.com>
In-Reply-To: <7650a7b706d24774b4ea3af23a2b371f@h3c.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0301CA0001.eurprd03.prod.outlook.com
 (2603:10a6:3:76::11) To AM0PR08MB4097.eurprd08.prod.outlook.com
 (2603:10a6:208:132::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191101130924700
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3fb15ac5-df5d-4223-4f24-08d75eb39400
x-ms-traffictypediagnostic: AM0PR08MB3122:
x-microsoft-antispam-prvs: <AM0PR08MB3122F5DC5FB7C0A3902B14A6C1620@AM0PR08MB3122.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:161;
x-forefront-prvs: 020877E0CB
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(136003)(366004)(39840400004)(396003)(346002)(199004)(189003)(66066001)(256004)(3846002)(478600001)(2501003)(25786009)(2906002)(99286004)(5660300002)(66446008)(6436002)(64756008)(66946007)(66556008)(66476007)(7416002)(6486002)(14454004)(6116002)(229853002)(2201001)(476003)(8936002)(2616005)(31686004)(6512007)(52116002)(36756003)(86362001)(71200400001)(71190400001)(486006)(6506007)(386003)(76176011)(53546011)(81166006)(4326008)(54906003)(8676002)(186003)(26005)(81156014)(316002)(31696002)(110136005)(102836004)(6246003)(305945005)(446003)(11346002)(7736002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3122;
 H:AM0PR08MB4097.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lU8nLtoG+goBzriS+rWCEgvq1vs+KqI9Mv3pli1WZRawcBW7q8GRwwbMIQ5AT4jHcdH1GQk+H8xWZlLJgvROw0QCFUsMHhzpV6uDS08MQjah9VmXhCUc8JX6CZdO4tPUgW+FqSLV5YslZPYhHV3EIxTRHtXNV47KY0tc/0UP9GPabxce/1m7Ultu196A2eviD9XD5b2WCViWwxJPn2XLNzWrO6ujHxX4HS/4OcJXEyszwkkOo4I4F0TNGaWuIsDWbRAI/mI+eEJmTubhAKWkcgSPbVeOEyVOIL0dP0Q4dP4CV/kkkPaRVhPz9r/oWgL9zxcfCFWio+vPQMQFrhZrw2OiL8e6KJq4NsaSg8Nl4kP2NdNgXZzUt6UAyRsxvN3l9FKACnrKKFTla0VaUGhBBq8KA7Nt0Tr2inpIBESMxMFhIZFXFbudNWh+64G3zfHp
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <1B28F0ECD7EB4249AD5DD841ADA61879@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fb15ac5-df5d-4223-4f24-08d75eb39400
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2019 10:09:27.2878 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 823uCxNaBSl8ZzGLgDMbPIeTT/Wzp2ob22D/eMfSpa4ql4H0Fi1LZqMmmlwNpZWnI6QWOEuG5aBbCz8R81UKuV+Q91Fi3zgzFWmv8WJSU3g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3122
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.6.111
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
Cc: Chengchiwen <chengchiwen@h3c.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>,
 Wangyongqing <w_yongqing@h3c.com>, Changlimin <changlimin@h3c.com>,
 Gaoliang <liang_gao@h3c.com>, Wangyong <wang.yongD@h3c.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDEuMTEuMjAxOSAxMjozNCwgVHVndW95aSB3cm90ZToNCj4gT24gMDEuMTEuMjAxOSAxNzoyNSBW
bGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdyb3RlOg0KPj4gMDEuMTEuMjAxOSAxMDozNywg
VHVndW95aSB3cm90ZToNCj4+PiBUaGVyZSBhcmUgdHdvIGlzc3VlcyBpbiBJbiBjaGVja19jb25z
dHJhaW50c19vbl9iaXRtYXAoKSwNCj4+PiAxKSBUaGUgc2FuaXR5IGNoZWNrIG9uIHRoZSBncmFu
dWxhcml0eSB3aWxsIGNhdXNlIHVpbnQ2NF90IGludGVnZXINCj4+PiBsZWZ0LXNoaWZ0IG92ZXJm
bG93IHdoZW4gY2x1c3Rlcl9zaXplIGlzIDJNIGFuZCB0aGUgZ3JhbnVsYXJpdHkgaXMNCj4+PiBC
SUdHRVIgdGhhbiAzMksuDQo+Pj4gMikgVGhlIHdheSB0byBjYWxjdWxhdGUgaW1hZ2Ugc2l6ZSB0
aGF0IHRoZSBtYXhpbXVtIGJpdG1hcCBzdXBwb3J0ZWQNCj4+PiBjYW4gbWFwIHRvIGlzIGEgYml0
IGluY29ycmVjdC4NCj4+PiBUaGlzIHBhdGNoIGZpeCBpdCBieSBhZGQgYSBoZWxwZXIgZnVuY3Rp
b24gdG8gY2FsY3VsYXRlIHRoZSBudW1iZXIgb2YNCj4+PiBieXRlcyBuZWVkZWQgYnkgYSBub3Jt
YWwgYml0bWFwIGluIGltYWdlIGFuZCBjb21wYXJlIGl0IHRvIHRoZSBtYXhpbXVtDQo+Pj4gYml0
bWFwIGJ5dGVzIHN1cHBvcnRlZCBieSBxZW11Lg0KPj4+DQo+Pj4gRml4ZXM6IDVmNzI4MjZlN2Zj
NjIxNjdjZjNhDQo+Pj4gU2lnbmVkLW9mZi1ieTogR3VveWkgVHUgPHR1Lmd1b3lpQGgzYy5jb20+
DQo+Pg0KPj4gWW91IGZvcmdldCBteQ0KPj4gUmV2aWV3ZWQtYnk6IFZsYWRpbWlyIFNlbWVudHNv
di1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCj4gDQo+IFNvcnJ5IGZvciB0
aGF0LCBpdCdzIG15IGZpcnN0IHRpbWUgdG8gc3VibWl0IHBhdGNoIHRvIHFlbXUsIGFuZCBzaG91
bGQgSSBzZW5kIGFub3RoZXIgcGF0Y2ggb3Igbm90ID8NCg0KR29vZCBzdGFydCENCg0KTm8sIHlv
dSBzaG91bGRuJ3QuIE1haW50YWluZXIgd2lsbCB0YWtlIHN1Y2ggbWFya3MgKGFuZCBtYXkgYmUg
b3RoZXIgcHJvcG9zZWQNCmltcHJvdmVtZW50cyBmb3IgY29tbWl0IG1lc3NhZ2UgbGlrZSB0aGlz
ICJGaXhlczogIiwgd2hlbiBhcHBseWluZywgc28gbm8gcmVhc29uIHRvIHJlc2VuZC4NCg0KQWxz
bywgd2hlbiBzZW5kaW5nIGEgbmV3IHZlcnNpb24gb2YgcGF0Y2gsIHN1bW1hcml6ZSB3aGF0IHdh
cyBjaGFuZ2VkIHNpbmNlIHByZXZpb3VzIHZlcnNpb24NCih5b3UgbWF5IGRvIGl0IHVuZGVyICIt
LS0iIHdoaWNoIGZvbGxvd3MgY29tbWl0IG1lc3NhZ2UsIG9yIGluIGNvdmVyIGxldHRlciBpZiBp
dCdzDQphIHBhdGNoIHNldCB3aXRoIHNldmVyYWwgcGF0Y2hlcy4NCg0KPiANCj4+IChJIGRvbid0
IHNlZSBjaGFuZ2VzIGV4Y2VwdCBhZGQgIkZpeGVzOiAiIHRvIGNvbW1pdCBtc2cgYW5kIHB1dA0K
Pj4gZ2V0X2JpdG1hcF9ieXRlc19uZWVkZWQgZGVmaW5pdGlvbiBoZWFkZXIgaW50byBvbmUgbGlu
ZS4pDQo+IA0KPiBZZXMsIE9ubHkgbWlub3IgY2hhbmdlcyBhcmUgbWFkZSwgaW5jbHVkaW5nIHJl
bW92aW5nICdpbmxpbmUnIGtleXdvcmQuDQo+IA0KPiBUaGFua3MgZm9yIHlvdXIgcGF0aWVuY2Ug
aW4gcmV2aWV3aW5nID4NCj4+PiAtLS0NCj4+PiAgICBibG9jay9xY293Mi1iaXRtYXAuYyB8IDE0
ICsrKysrKysrKysrLS0tDQo+Pj4gICAgMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyks
IDMgZGVsZXRpb25zKC0pDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvYmxvY2svcWNvdzItYml0bWFw
LmMgYi9ibG9jay9xY293Mi1iaXRtYXAuYyBpbmRleA0KPj4+IDk4Mjk0YTcuLmVmOWVmNjIgMTAw
NjQ0DQo+Pj4gLS0tIGEvYmxvY2svcWNvdzItYml0bWFwLmMNCj4+PiArKysgYi9ibG9jay9xY293
Mi1iaXRtYXAuYw0KPj4+IEBAIC0xNDIsNiArMTQyLDEzIEBAIHN0YXRpYyBpbnQgY2hlY2tfdGFi
bGVfZW50cnkodWludDY0X3QgZW50cnksIGludA0KPj4gY2x1c3Rlcl9zaXplKQ0KPj4+ICAgICAg
ICByZXR1cm4gMDsNCj4+PiAgICB9DQo+Pj4NCj4+PiArc3RhdGljIGludDY0X3QgZ2V0X2JpdG1h
cF9ieXRlc19uZWVkZWQoaW50NjRfdCBsZW4sIHVpbnQzMl90DQo+Pj4gK2dyYW51bGFyaXR5KSB7
DQo+Pj4gKyAgICBpbnQ2NF90IG51bV9iaXRzID0gRElWX1JPVU5EX1VQKGxlbiwgZ3JhbnVsYXJp
dHkpOw0KPj4+ICsNCj4+PiArICAgIHJldHVybiBESVZfUk9VTkRfVVAobnVtX2JpdHMsIDgpOyB9
DQo+Pj4gKw0KPj4+ICAgIHN0YXRpYyBpbnQgY2hlY2tfY29uc3RyYWludHNfb25fYml0bWFwKEJs
b2NrRHJpdmVyU3RhdGUgKmJzLA0KPj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGNvbnN0IGNoYXIgKm5hbWUsDQo+Pj4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgdWludDMyX3QgZ3JhbnVsYXJpdHksIEBADQo+Pj4gLTE1MCw2ICsx
NTcsNyBAQCBzdGF0aWMgaW50IGNoZWNrX2NvbnN0cmFpbnRzX29uX2JpdG1hcChCbG9ja0RyaXZl
clN0YXRlDQo+PiAqYnMsDQo+Pj4gICAgICAgIEJEUlZRY293MlN0YXRlICpzID0gYnMtPm9wYXF1
ZTsNCj4+PiAgICAgICAgaW50IGdyYW51bGFyaXR5X2JpdHMgPSBjdHozMihncmFudWxhcml0eSk7
DQo+Pj4gICAgICAgIGludDY0X3QgbGVuID0gYmRydl9nZXRsZW5ndGgoYnMpOw0KPj4+ICsgICAg
aW50NjRfdCBiaXRtYXBfYnl0ZXM7DQo+Pj4NCj4+PiAgICAgICAgYXNzZXJ0KGdyYW51bGFyaXR5
ID4gMCk7DQo+Pj4gICAgICAgIGFzc2VydCgoZ3JhbnVsYXJpdHkgJiAoZ3JhbnVsYXJpdHkgLSAx
KSkgPT0gMCk7IEBAIC0xNzEsOSArMTc5LDkNCj4+PiBAQCBzdGF0aWMgaW50IGNoZWNrX2NvbnN0
cmFpbnRzX29uX2JpdG1hcChCbG9ja0RyaXZlclN0YXRlICpicywNCj4+PiAgICAgICAgICAgIHJl
dHVybiAtRUlOVkFMOw0KPj4+ICAgICAgICB9DQo+Pj4NCj4+PiAtICAgIGlmICgobGVuID4gKHVp
bnQ2NF90KUJNRV9NQVhfUEhZU19TSVpFIDw8IGdyYW51bGFyaXR5X2JpdHMpIHx8DQo+Pj4gLSAg
ICAgICAgKGxlbiA+ICh1aW50NjRfdClCTUVfTUFYX1RBQkxFX1NJWkUgKiBzLT5jbHVzdGVyX3Np
emUgPDwNCj4+PiAtICAgICAgICAgICAgICAgZ3JhbnVsYXJpdHlfYml0cykpDQo+Pj4gKyAgICBi
aXRtYXBfYnl0ZXMgPSBnZXRfYml0bWFwX2J5dGVzX25lZWRlZChsZW4sIGdyYW51bGFyaXR5KTsN
Cj4+PiArICAgIGlmICgoYml0bWFwX2J5dGVzID4gKHVpbnQ2NF90KUJNRV9NQVhfUEhZU19TSVpF
KSB8fA0KPj4+ICsgICAgICAgIChiaXRtYXBfYnl0ZXMgPiAodWludDY0X3QpQk1FX01BWF9UQUJM
RV9TSVpFICoNCj4+PiArIHMtPmNsdXN0ZXJfc2l6ZSkpDQo+Pj4gICAgICAgIHsNCj4+PiAgICAg
ICAgICAgIGVycm9yX3NldGcoZXJycCwgIlRvbyBtdWNoIHNwYWNlIHdpbGwgYmUgb2NjdXBpZWQg
YnkgdGhlDQo+PiBiaXRtYXAuICINCj4+PiAgICAgICAgICAgICAgICAgICAgICAgIlVzZSBsYXJn
ZXIgZ3JhbnVsYXJpdHkiKTsNCj4+Pg0KPj4NCj4+DQo+PiAtLQ0KPj4gQmVzdCByZWdhcmRzLA0K
Pj4gVmxhZGltaXINCg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

