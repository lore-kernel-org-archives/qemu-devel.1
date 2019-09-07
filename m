Return-Path: <SRS0=eB96=XC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6AB0C43331
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2019 19:09:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9957821848
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2019 19:09:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="d7WgKg2e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9957821848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6g5U-0000gm-KC
	for qemu-devel@archiver.kernel.org; Sat, 07 Sep 2019 15:09:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51236)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i6g4R-000870-3j
 for qemu-devel@nongnu.org; Sat, 07 Sep 2019 15:08:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i6g4P-00030Q-Ez
 for qemu-devel@nongnu.org; Sat, 07 Sep 2019 15:08:27 -0400
Received: from mail-eopbgr50124.outbound.protection.outlook.com
 ([40.107.5.124]:14213 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1i6g4I-0002hK-3O; Sat, 07 Sep 2019 15:08:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GAnMbPKRZH27bqctPHTue5geX9u3PUI0lBMO3nX23W7MYB3j3l3XgN2eopnycxNnO4iPQu0lR2/mq+vvzm5O0DOebuMmSfH8HnTj7MpmonaI0NmQ9+3UQP2aYrzkpG0vPOtJkPRvCr1llAEmfKWDTq6Civ+fDJjc4puK4VV3qIOzSSBou97yduZ1Iv67KGoU/Ip9MYPSBSO85T/AqDkVHDWChqU+TuN+pGxMkTE5mSQseHtLOAYuqYyrU78JWiQTg5nlWuvzjIl+VYfUWvX2DHtOyupleiqTJ+UxBmMo8UnoQ7ecrRU6Hthdq1S2ySLV9ton2qyg0YzhS2jDJOwmZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WlvazzxaBN0B4Npkk0W2v/E87woqUviYRzDK4zfLGpc=;
 b=Pva0iXvL4QA1pyeWQ8AR2DDVMeKtipErg8ERVKZsgG3Lj2c/a4iSu3IND2aVkSdGYkJvMyR0uljpe5CB59fQ65fPkJzwLlLkesCC3pvWXSGgqe1kOsf9vppnc5oCdxWsN0ny+zXD0Pv4tlDUe6K4w26Z0Lk+bOTWDoujEXJG10n72I9Qx/lDIgW6s82LY1A16lpPLQeH569wu3B6dyEh43R7evqBJRwy55JK0S2pXnLB0RwEUIECvI8v/MWzjOo5qNoW7bWpFZJdpzvONHMSrIe6qy4GsIcaRBe4wCauF3UFhSY9+wiiRobtZzGuepnFqBPcV8/rXjM9FhiTdS127Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WlvazzxaBN0B4Npkk0W2v/E87woqUviYRzDK4zfLGpc=;
 b=d7WgKg2eGyZNuKZJrE1arlpezzDUZ54QCQ0+WUNYsTwCkfhOTusnd8PWt6upSzl0CKzrxRE/tEVTmI7vJbSNN/xOPlCHAdS8F/ow/e4wUldFknXFHUhOYDaWDTdoOimhmTVSYzYDi+x1CRLlirbYpPN03JTr5R20k1B5RS07qkk=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5290.eurprd08.prod.outlook.com (20.179.9.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.18; Sat, 7 Sep 2019 19:08:13 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2241.018; Sat, 7 Sep 2019
 19:08:13 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Maxim Levitsky <mlevitsk@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v2 1/3] block/qcow2: refactoring of threaded encryption
 code
Thread-Index: AQHVZO1jU8Wsr4Od2EySuqG2u22JMqcglVOA
Date: Sat, 7 Sep 2019 19:08:13 +0000
Message-ID: <7634baef-f42f-4603-2ec9-3f4aa6cfe278@virtuozzo.com>
References: <20190906195750.17651-1-mlevitsk@redhat.com>
 <20190906195750.17651-2-mlevitsk@redhat.com>
In-Reply-To: <20190906195750.17651-2-mlevitsk@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P18901CA0007.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:3:8b::17) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190907220811502
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e4c76871-a574-433f-9e6a-08d733c6bb45
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5290; 
x-ms-traffictypediagnostic: DB8PR08MB5290:
x-microsoft-antispam-prvs: <DB8PR08MB5290B05E1B7BC62765ADDBD1C1B50@DB8PR08MB5290.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:332;
x-forefront-prvs: 0153A8321A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(39840400004)(366004)(396003)(376002)(346002)(199004)(189003)(71190400001)(71200400001)(6506007)(386003)(86362001)(8676002)(81156014)(81166006)(6436002)(305945005)(54906003)(8936002)(66066001)(76176011)(2501003)(6512007)(25786009)(52116002)(7736002)(31696002)(31686004)(256004)(99286004)(6246003)(2906002)(4326008)(6486002)(110136005)(6116002)(102836004)(3846002)(14454004)(53936002)(229853002)(26005)(5660300002)(36756003)(66446008)(64756008)(66556008)(66476007)(486006)(316002)(476003)(11346002)(66946007)(2616005)(446003)(478600001)(186003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5290;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8SQ9iZuNll+XQRWdvqHjvjlGA+/G9ORLFXMQlS9bn2WEwNkZaSd5tOLayTYPgTKFn/azcOSLOntyaZcvbtQmlNSmitrV4lYV5coR7f7/12nmwESUiGCOBPEIh5BXL0VsZcYoV76V+VyOyiuKbWGV07zPnh1HXIlp66pfR4a/dZ6Q1e/F8prBfypmBe9IdQFms1QlemHpM229ugSNV/pt91/EJc9OLHGHbPKd2GNsXjAQUKhQo2ysYsxEJYzEH1t70gBXNawdawqTp2+jh2SvyVuPMU5U3e6ztLrkrgIVYJclBGy5DbQo6tEFPYa3+BfDaVZXtrIP48oRe/MoKkmcgVf72unOJ3CQ0ItY3OHzWMNGWe3gFp0CQHZ6+SS8xxA5/SFO1J6vqCpw2EsVhq6KXDRmL/qNva7Xh+AYVBMubNc=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <22AB21B18812934F94BDA8A99E2FD8ED@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4c76871-a574-433f-9e6a-08d733c6bb45
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2019 19:08:13.5498 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kYZ6SNvUmW+uo37DVTHTbA5UyiFVu/wejolnJ3E954fgBQ1U34NExRdf77ucgdrFAa3F9S99XPuFmmC3zmUP2Dr2p+kpQ66QJepg/uw3eps=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5290
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.5.124
Subject: Re: [Qemu-devel] [PATCH v2 1/3] block/qcow2: refactoring of
 threaded encryption code
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
 =?utf-8?B?RGFuaWVsIFAgLiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 qemu-stable <qemu-stable@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDYuMDkuMjAxOSAyMjo1NywgTWF4aW0gTGV2aXRza3kgd3JvdGU6DQo+IFRoaXMgY29tbWl0IHRy
aWVzIHRvIGNsYXJpZnkgZmV3IGZ1bmN0aW9uIGFyZ3VtZW50cywNCj4gYW5kIGFkZCBjb21tZW50
cyBkZXNjcmliaW5nIHRoZSBlbmNyeXB0L2RlY3J5cHQgaW50ZXJmYWNlDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBNYXhpbSBMZXZpdHNreSA8bWxldml0c2tAcmVkaGF0LmNvbT4NCj4gLS0tDQo+ICAg
YmxvY2svcWNvdzItY2x1c3Rlci5jIHwgMTAgKysrLS0tLQ0KPiAgIGJsb2NrL3Fjb3cyLXRocmVh
ZHMuYyB8IDYxICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0NCj4g
ICAyIGZpbGVzIGNoYW5nZWQsIDUzIGluc2VydGlvbnMoKyksIDE4IGRlbGV0aW9ucygtKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2Jsb2NrL3Fjb3cyLWNsdXN0ZXIuYyBiL2Jsb2NrL3Fjb3cyLWNsdXN0
ZXIuYw0KPiBpbmRleCBmMDljYzk5MmFmLi4xOTg5YjQyM2RhIDEwMDY0NA0KPiAtLS0gYS9ibG9j
ay9xY293Mi1jbHVzdGVyLmMNCj4gKysrIGIvYmxvY2svcWNvdzItY2x1c3Rlci5jDQo+IEBAIC00
NjMsOCArNDYzLDggQEAgc3RhdGljIGludCBjb3JvdXRpbmVfZm4gZG9fcGVyZm9ybV9jb3dfcmVh
ZChCbG9ja0RyaXZlclN0YXRlICpicywNCj4gICB9DQo+ICAgDQo+ICAgc3RhdGljIGJvb2wgY29y
b3V0aW5lX2ZuIGRvX3BlcmZvcm1fY293X2VuY3J5cHQoQmxvY2tEcml2ZXJTdGF0ZSAqYnMsDQo+
IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50NjRf
dCBzcmNfY2x1c3Rlcl9vZmZzZXQsDQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICB1aW50NjRfdCBjbHVzdGVyX29mZnNldCwNCj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQ2NF90IGd1ZXN0X2NsdXN0
ZXJfb2Zmc2V0LA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgdWludDY0X3QgaG9zdF9jbHVzdGVyX29mZnNldCwNCj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1bnNpZ25lZCBvZmZzZXRfaW5fY2x1c3Rl
ciwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1
aW50OF90ICpidWZmZXIsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgdW5zaWduZWQgYnl0ZXMpDQo+IEBAIC00NzQsOCArNDc0LDggQEAgc3RhdGlj
IGJvb2wgY29yb3V0aW5lX2ZuIGRvX3BlcmZvcm1fY293X2VuY3J5cHQoQmxvY2tEcml2ZXJTdGF0
ZSAqYnMsDQo+ICAgICAgICAgICBhc3NlcnQoKG9mZnNldF9pbl9jbHVzdGVyICYgfkJEUlZfU0VD
VE9SX01BU0spID09IDApOw0KPiAgICAgICAgICAgYXNzZXJ0KChieXRlcyAmIH5CRFJWX1NFQ1RP
Ul9NQVNLKSA9PSAwKTsNCj4gICAgICAgICAgIGFzc2VydChzLT5jcnlwdG8pOw0KPiAtICAgICAg
ICBpZiAocWNvdzJfY29fZW5jcnlwdChicywgY2x1c3Rlcl9vZmZzZXQsDQo+IC0gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHNyY19jbHVzdGVyX29mZnNldCArIG9mZnNldF9pbl9jbHVzdGVy
LA0KPiArICAgICAgICBpZiAocWNvdzJfY29fZW5jcnlwdChicywgaG9zdF9jbHVzdGVyX29mZnNl
dCwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZ3Vlc3RfY2x1c3Rlcl9vZmZzZXQg
KyBvZmZzZXRfaW5fY2x1c3RlciwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJ1
ZmZlciwgYnl0ZXMpIDwgMCkgew0KPiAgICAgICAgICAgICAgIHJldHVybiBmYWxzZTsNCj4gICAg
ICAgICAgIH0NCj4gQEAgLTQ5Niw3ICs0OTYsNyBAQCBzdGF0aWMgaW50IGNvcm91dGluZV9mbiBk
b19wZXJmb3JtX2Nvd193cml0ZShCbG9ja0RyaXZlclN0YXRlICpicywNCj4gICAgICAgfQ0KPiAg
IA0KPiAgICAgICByZXQgPSBxY293Ml9wcmVfd3JpdGVfb3ZlcmxhcF9jaGVjayhicywgMCwNCj4g
LSAgICAgICAgICAgIGNsdXN0ZXJfb2Zmc2V0ICsgb2Zmc2V0X2luX2NsdXN0ZXIsIHFpb3YtPnNp
emUsIHRydWUpOw0KPiArICAgICAgICAgICAgICBjbHVzdGVyX29mZnNldCArIG9mZnNldF9pbl9j
bHVzdGVyLCBxaW92LT5zaXplLCB0cnVlKTsNCg0KDQpIbW0sIHVucmVsYXRlZCBodW5rLg0KDQo+
ICAgICAgIGlmIChyZXQgPCAwKSB7DQo+ICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiAgICAgICB9
DQo+IGRpZmYgLS1naXQgYS9ibG9jay9xY293Mi10aHJlYWRzLmMgYi9ibG9jay9xY293Mi10aHJl
YWRzLmMNCj4gaW5kZXggM2IxZTYzZmU0MS4uYzNjZGEwYzZhNSAxMDA2NDQNCj4gLS0tIGEvYmxv
Y2svcWNvdzItdGhyZWFkcy5jDQo+ICsrKyBiL2Jsb2NrL3Fjb3cyLXRocmVhZHMuYw0KPiBAQCAt
MjM0LDE1ICsyMzQsMTkgQEAgc3RhdGljIGludCBxY293Ml9lbmNkZWNfcG9vbF9mdW5jKHZvaWQg
Km9wYXF1ZSkNCj4gICB9DQo+ICAgDQo+ICAgc3RhdGljIGludCBjb3JvdXRpbmVfZm4NCj4gLXFj
b3cyX2NvX2VuY2RlYyhCbG9ja0RyaXZlclN0YXRlICpicywgdWludDY0X3QgZmlsZV9jbHVzdGVy
X29mZnNldCwNCj4gLSAgICAgICAgICAgICAgICAgIHVpbnQ2NF90IG9mZnNldCwgdm9pZCAqYnVm
LCBzaXplX3QgbGVuLCBRY293MkVuY0RlY0Z1bmMgZnVuYykNCj4gK3Fjb3cyX2NvX2VuY2RlYyhC
bG9ja0RyaXZlclN0YXRlICpicywgdWludDY0X3QgaG9zdF9jbHVzdGVyX29mZnNldCwNCj4gKyAg
ICAgICAgICAgICAgICB1aW50NjRfdCBndWVzdF9vZmZzZXQsIHZvaWQgKmJ1Ziwgc2l6ZV90IGxl
biwNCj4gKyAgICAgICAgICAgICAgICBRY293MkVuY0RlY0Z1bmMgZnVuYykNCj4gICB7DQo+ICAg
ICAgIEJEUlZRY293MlN0YXRlICpzID0gYnMtPm9wYXF1ZTsNCj4gKw0KPiArICAgIHVpbnQ2NF90
IG9mZnNldCA9IHMtPmNyeXB0X3BoeXNpY2FsX29mZnNldCA/DQo+ICsgICAgICAgIGhvc3RfY2x1
c3Rlcl9vZmZzZXQgKyBvZmZzZXRfaW50b19jbHVzdGVyKHMsIGd1ZXN0X29mZnNldCkgOg0KPiAr
ICAgICAgICBndWVzdF9vZmZzZXQ7DQo+ICsNCj4gICAgICAgUWNvdzJFbmNEZWNEYXRhIGFyZyA9
IHsNCj4gICAgICAgICAgIC5ibG9jayA9IHMtPmNyeXB0bywNCj4gLSAgICAgICAgLm9mZnNldCA9
IHMtPmNyeXB0X3BoeXNpY2FsX29mZnNldCA/DQo+IC0gICAgICAgICAgICAgICAgICAgICAgZmls
ZV9jbHVzdGVyX29mZnNldCArIG9mZnNldF9pbnRvX2NsdXN0ZXIocywgb2Zmc2V0KSA6DQo+IC0g
ICAgICAgICAgICAgICAgICAgICAgb2Zmc2V0LA0KPiArICAgICAgICAub2Zmc2V0ID0gb2Zmc2V0
LA0KPiAgICAgICAgICAgLmJ1ZiA9IGJ1ZiwNCj4gICAgICAgICAgIC5sZW4gPSBsZW4sDQo+ICAg
ICAgICAgICAuZnVuYyA9IGZ1bmMsDQo+IEBAIC0yNTEsMTggKzI1NSw0OSBAQCBxY293Ml9jb19l
bmNkZWMoQmxvY2tEcml2ZXJTdGF0ZSAqYnMsIHVpbnQ2NF90IGZpbGVfY2x1c3Rlcl9vZmZzZXQs
DQo+ICAgICAgIHJldHVybiBxY293Ml9jb19wcm9jZXNzKGJzLCBxY293Ml9lbmNkZWNfcG9vbF9m
dW5jLCAmYXJnKTsNCj4gICB9DQo+ICAgDQo+ICsNCj4gKy8qDQo+ICsgKiBxY293Ml9jb19lbmNy
eXB0KCkNCj4gKyAqDQo+ICsgKiBFbmNyeXB0cyBvbmUgb3IgbW9yZSBjb250aWd1b3VzIGFsaWdu
ZWQgc2VjdG9ycw0KPiArICoNCj4gKyAqIEBob3N0X2NsdXN0ZXJfb2Zmc2V0IC0gb24gZGlzayBv
ZmZzZXQgb2YgdGhlIGZpcnN0IGNsdXN0ZXIgaW4gd2hpY2gNCj4gKyAqIHRoZSBlbmNyeXB0ZWQg
ZGF0YSB3aWxsIGJlIHdyaXR0ZW4NCg0KDQpJdCdzIG5vdCBxdWl0ZSByaWdodCwgaXQncyBub3Qg
b24gZGlzaywgYnV0IG9uIC5maWxlIGNoaWxkIG9mIHFjb3cyIG5vZGUsIHdoaWNoDQptYXkgYmUg
YW55IG90aGVyIGZvcm1hdCBvciBwcm90b2NvbCBub2RlLi4gU28sIEkgY2FsbGVkIGl0IGZpbGVf
Y2x1c3Rlcl9vZmZzZXQuDQpCdXQgSSdtIE9LIHdpdGggbmV3IG5hbWluZyBhbnl3YXkuIEFuZCBp
dCBtYXkgYmUgYmV0dGVyIGZvciBlbmNyeXB0aW9uIHJlbGF0ZWQNCmxvZ2ljLi4NCg0KID4gKyAq
IFVzZWQgYXMgYW4gaW5pdGlhbGl6YXRpb24gdmVjdG9yIGZvciBlbmNyeXB0aW9uDQoNCkhtbSwg
aXMgaXQgZGVmYXVsdCBub3c/DQoNCj4gKyAqDQo+ICsgKiBAZ3Vlc3Rfb2Zmc2V0IC0gZ3Vlc3Qg
KHZpcnR1YWwpIG9mZnNldCBvZiB0aGUgZmlyc3Qgc2VjdG9yIG9mIHRoZQ0KPiArICogZGF0YSB0
byBiZSBlbmNyeXB0ZWQNCg0KSG1tLCBzdG9wLiBJdCdzIHdyb25nLiBEYXRhIHRvIGJlIGVuY3J5
cHRlZCBpcyBpbiBidWZmZXIsIHNvLCBpdCdzIG5vdCBmaXJzdCBzZWN0b3Igb2YNCnRoZSBkYXRh
IHRvIGJlIGVuY3J5cHRlZCwgYnV0IGZpcnN0IHNlY3RvciBpbiB3aGljaCBndWVzdCB3cml0ZXMg
ZGF0YSAodG8gYmUgZW5jcnlwdGVkDQppbiBtZWFudGltZSkuDQoNCj4gKyAqIFVzZWQgYXMgYW4g
aW5pdGlhbGl6YXRpb24gdmVjdG9yIGZvciBvbGRlciwgcWNvdzIgbmF0aXZlIGVuY3J5cHRpb24N
Cj4gKyAqDQo+ICsgKiBAYnVmIC0gYnVmZmVyIHdpdGggdGhlIGRhdGEgdG8gZW5jcnlwdA0KPiAr
ICogQGxlbiAtIGxlbmd0aCBvZiB0aGUgYnVmZmVyIChpbiBzZWN0b3Igc2l6ZSBtdWx0aXBsaWVz
KQ0KPiArICoNCj4gKyAqIE5vdGUgdGhhdCB0aGUgZ3JvdXAgb2YgdGhlIHNlY3RvcnMsIGRvbid0
IGhhdmUgdG8gYmUgYWxpZ25lZA0KPiArICogb24gY2x1c3RlciBib3VuZGFyeSBhbmQgY2FuIGFs
c28gY3Jvc3MgYSBjbHVzdGVyIGJvdW5kYXJ5Lg0KDQpBbmQgSSBkb3VidCBpbiBpdCBub3cuIEkn
bSBhZnJhaWQgdGhhdCBpZiB3ZSBjYWxsIHFjb3cyX2NvX2VuY3J5cHQgZm9yIGEgZ3JvdXANCm9m
IHRoZSBzZWN0b3JzIGNyb3NzaW5nIGEgY2x1c3RlciBib3VuZGFyeSwgd2Ugd2lsbCBmaW5pc2gg
dXAgd2l0aCBzaW1pbGFyIGJ1Zzogd2UnbGwNCnVzZSBmaXJzdCBjbHVzdGVyIG9mZnNldCBhcyBh
IHZlY3RvciBmb3IgYWxsIHRoZSBzZWN0b3JzLiBXZSBzdGlsbCBuZXZlciBkbyBpdC4uIFNvLA0K
SSB0aGluayBpdCB3b3J0aCBhc3NlcnRpb24gYW5kIGNvcnJlc3BvbmRpbmcgY29tbWVudC4NCg0K
T3IgaXMgaXQgY29ycmVjdD8NCg0KPiArICoNCj4gKyAqDQo+ICsgKi8NCj4gICBpbnQgY29yb3V0
aW5lX2ZuDQo+IC1xY293Ml9jb19lbmNyeXB0KEJsb2NrRHJpdmVyU3RhdGUgKmJzLCB1aW50NjRf
dCBmaWxlX2NsdXN0ZXJfb2Zmc2V0LA0KPiAtICAgICAgICAgICAgICAgICB1aW50NjRfdCBvZmZz
ZXQsIHZvaWQgKmJ1Ziwgc2l6ZV90IGxlbikNCj4gK3Fjb3cyX2NvX2VuY3J5cHQoQmxvY2tEcml2
ZXJTdGF0ZSAqYnMsIHVpbnQ2NF90IGhvc3RfY2x1c3Rlcl9vZmZzZXQsDQo+ICsgICAgICAgICAg
ICAgICAgIHVpbnQ2NF90IGd1ZXN0X29mZnNldCwgdm9pZCAqYnVmLCBzaXplX3QgbGVuKQ0KPiAg
IHsNCj4gLSAgICByZXR1cm4gcWNvdzJfY29fZW5jZGVjKGJzLCBmaWxlX2NsdXN0ZXJfb2Zmc2V0
LCBvZmZzZXQsIGJ1ZiwgbGVuLA0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICBxY3J5
cHRvX2Jsb2NrX2VuY3J5cHQpOw0KPiArICAgIHJldHVybiBxY293Ml9jb19lbmNkZWMoYnMsIGhv
c3RfY2x1c3Rlcl9vZmZzZXQsIGd1ZXN0X29mZnNldCwgYnVmLCBsZW4sDQo+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICBxY3J5cHRvX2Jsb2NrX2VuY3J5cHQpOw0KPiAgIH0NCj4gICANCj4g
Kw0KPiArLyoNCj4gKyAqIHFjb3cyX2NvX2RlY3J5cHQoKQ0KPiArICoNCj4gKyAqIERlY3J5cHRz
IG9uZSBvciBtb3JlIGNvbnRpZ3VvdXMgYWxpZ25lZCBzZWN0b3JzDQo+ICsgKiBTYW1lIGZ1bmN0
aW9uIGFzIHFjb3cyX2NvX2VuY3J5cHQNCg0KSG1tLCBub3QgZXhhY3RseSBzYW1lIDopDQoNCj4g
KyAqDQo+ICsgKi8NCj4gKw0KPiAgIGludCBjb3JvdXRpbmVfZm4NCj4gLXFjb3cyX2NvX2RlY3J5
cHQoQmxvY2tEcml2ZXJTdGF0ZSAqYnMsIHVpbnQ2NF90IGZpbGVfY2x1c3Rlcl9vZmZzZXQsDQo+
IC0gICAgICAgICAgICAgICAgIHVpbnQ2NF90IG9mZnNldCwgdm9pZCAqYnVmLCBzaXplX3QgbGVu
KQ0KPiArcWNvdzJfY29fZGVjcnlwdChCbG9ja0RyaXZlclN0YXRlICpicywgdWludDY0X3QgaG9z
dF9jbHVzdGVyX29mZnNldCwNCj4gKyAgICAgICAgICAgICAgICAgdWludDY0X3QgZ3Vlc3Rfb2Zm
c2V0LCB2b2lkICpidWYsIHNpemVfdCBsZW4pDQo+ICAgew0KPiAtICAgIHJldHVybiBxY293Ml9j
b19lbmNkZWMoYnMsIGZpbGVfY2x1c3Rlcl9vZmZzZXQsIG9mZnNldCwgYnVmLCBsZW4sDQo+IC0g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHFjcnlwdG9fYmxvY2tfZGVjcnlwdCk7DQo+ICsg
ICAgcmV0dXJuIHFjb3cyX2NvX2VuY2RlYyhicywgaG9zdF9jbHVzdGVyX29mZnNldCwgZ3Vlc3Rf
b2Zmc2V0LCBidWYsIGxlbiwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgIHFjcnlwdG9f
YmxvY2tfZGVjcnlwdCk7DQo+ICAgfQ0KPiANCg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRp
bWlyDQo=

