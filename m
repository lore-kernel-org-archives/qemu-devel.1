Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 493A9ECE58D
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 17:35:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06E5C20820
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 17:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="rq3CcpLn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06E5C20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL9gg-0007tI-4H
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 13:35:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42376)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iL8ze-00077S-9d
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 12:51:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iL8zc-0006KA-RB
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 12:51:18 -0400
Received: from mail-eopbgr40108.outbound.protection.outlook.com
 ([40.107.4.108]:14222 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iL8zY-0006Ig-Gn; Thu, 17 Oct 2019 12:51:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BmopGbvfSqbpczQHORj9m2RJdnjHaXkNNCh9Jz7XZzOYDL+SOn6ZbD+8pVxLW0ZmGgiyWzreLmcOYil4Ip6OaUoQnSsdU/lh/HJI7TgDvXsp5ubRun+amUafT/DIn50bYdY2FYkBBG6gmP1Z+geK1IeUoJN3kKS/e5r4CbyH6UuN//l2M54Cg2Ci3vqm+2Ps38NmEOwYC7UUFwREdroSnA4PuKChFmLsw+I7QPCJx3gDVSNvQKO9Lqp4uAey14QY8RFNEosl7+Xwn/EDqsvNRlOL6rqVmJiyLWjbJFka6dCcBFVt5hFkO6D4w/KeovbGS+ri0h/rQgoBkNo5y1S4TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6rgsoqfcFy6We4cvbfXubPBjRdLVnKJ/1hZC/XXyyjE=;
 b=TL5CCugV/diM1c2W0ilH5gXnVdrTYDhBA1pBhCJ5ZAJPYsj5/zW3PdNnVZv6BVFYyKBcCGv1rEx9uwkpW0B0hB+rB29SzePLYtlIfHmeSObqXZHSvwxhM48C4MY51OJtcH1in/Oj1wTIr320QpVj9WzNH0goux8uC68MCR67j4YusCPUG9CKW4nJtAmHf0TXhqYKGt9RXz4/nNgAYatg377b+lx5cCyxrAXuArTYhqw1hOnBjRYBXUo7aW2J/pybheaYOgFslDen5NV/EIlj7iDhP9SuTCwyP6QqwX8EvNn68zaqv5HY4hXWMGJqaQMDkkh+0bWHuUga9dSsfESKbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6rgsoqfcFy6We4cvbfXubPBjRdLVnKJ/1hZC/XXyyjE=;
 b=rq3CcpLnlg4/vCDF4vNWoIdG457OknDJvW4eXJ3FgZP/Czjmz1klikKWNMiXy0gPF4aSCASF50LhyKTj71KCjvKmsO8wVkvUX0hSB8ZPWPsxfqzl9J+rYZUqgq3+PaGxk0OvA+i4ZXyJr8L19iZTQeS108jGTr5keRDOMGaPBbQ=
Received: from AM0PR08MB4435.eurprd08.prod.outlook.com (20.179.35.83) by
 AM0PR08MB3011.eurprd08.prod.outlook.com (52.134.125.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.21; Thu, 17 Oct 2019 16:51:10 +0000
Received: from AM0PR08MB4435.eurprd08.prod.outlook.com
 ([fe80::4461:dd32:b358:110c]) by AM0PR08MB4435.eurprd08.prod.outlook.com
 ([fe80::4461:dd32:b358:110c%7]) with mapi id 15.20.2347.023; Thu, 17 Oct 2019
 16:51:10 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH v4 2/4] qcow2: Allow writing compressed data of multiple
 clusters
Thread-Topic: [PATCH v4 2/4] qcow2: Allow writing compressed data of multiple
 clusters
Thread-Index: AQHVhD7X7bd10FNYMEW8AMuIkCQTY6dfDaaA
Date: Thu, 17 Oct 2019 16:51:10 +0000
Message-ID: <19ac5edf-31d0-2646-33f7-d0a63d38e697@virtuozzo.com>
References: <1571243333-882302-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1571243333-882302-3-git-send-email-andrey.shinkevich@virtuozzo.com>
In-Reply-To: <1571243333-882302-3-git-send-email-andrey.shinkevich@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0199.eurprd05.prod.outlook.com
 (2603:10a6:3:f9::23) To AM0PR08MB4435.eurprd08.prod.outlook.com
 (2603:10a6:208:144::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191017195107528
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2ee813df-4a66-4236-620b-08d753223630
x-ms-traffictypediagnostic: AM0PR08MB3011:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR08MB3011A2429D9453C322C37D4DC16D0@AM0PR08MB3011.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:454;
x-forefront-prvs: 01930B2BA8
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(396003)(136003)(366004)(376002)(39850400004)(199004)(189003)(6246003)(71190400001)(66946007)(71200400001)(36756003)(66446008)(54906003)(110136005)(316002)(2501003)(66476007)(66556008)(64756008)(107886003)(6506007)(76176011)(102836004)(26005)(14454004)(7736002)(52116002)(186003)(386003)(6512007)(305945005)(81166006)(66066001)(14444005)(4326008)(5660300002)(478600001)(2616005)(31686004)(3846002)(2906002)(229853002)(81156014)(8676002)(31696002)(256004)(25786009)(6116002)(476003)(11346002)(99286004)(2201001)(446003)(486006)(6486002)(6436002)(86362001)(8936002)(21314003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3011;
 H:AM0PR08MB4435.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7sKj54a3O9p2ZUx8D5eBSl1v6zbPFbreA6IvL8N1qwHwMjxiO9HV8YkRKBNu1/JKPrmwU/P7+YH6tjsgSscnp3yF1A2DSYPlo/y/FSzP5NMfScfUdp+Xcw7EfMHtljeKUMg+6BgaJE4x673duOuRHrWOkLCE3OxaDNkKks/3wL4IO473odbwtkwz/1RXoldQrkXtmfBTXANLptEZx8klO0/PLbr1MogNKDu6UfGNynC7S6hg8QncdbkGIq9YWBavlhcvI5K4BxTHruaOxfWkzXDzrnFt2qAoK2s31BuPabnvluvSGBS738hWFdgMdhFv5aeigFEchBea0AsW1S9/+o/ZecTsn9k6MAvRrrxaxsk295y/bZM39gkpYY9Uj14dkGB5KStdRTyW++Xot9jNiIwR+SlZP4Wy0+gnCh/ngZQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AD38787B654FE742B77B050DCDD4A3C7@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ee813df-4a66-4236-620b-08d753223630
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2019 16:51:10.0757 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TSdmFzTRj8FvP+r5c0SZevspCcSkLxcNTAsW7mTI+hiEf0bqfU6uvNQnRTOEWDhLPkpA4Lx19J+Dcqo6c+4qgQswhTgvaicKTDm7ZNrstXI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3011
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.4.108
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, "fam@euphon.net" <fam@euphon.net>,
 Denis Lunev <den@virtuozzo.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTYuMTAuMjAxOSAxOToyOCwgQW5kcmV5IFNoaW5rZXZpY2ggd3JvdGU6DQo+IFFFTVUgY3VycmVu
dGx5IHN1cHBvcnRzIHdyaXRpbmcgY29tcHJlc3NlZCBkYXRhIG9mIHRoZSBzaXplIGVxdWFsIHRv
DQo+IG9uZSBjbHVzdGVyLiBUaGlzIHBhdGNoIGFsbG93cyB3cml0aW5nIFFDT1cyIGNvbXByZXNz
ZWQgZGF0YSB0aGF0DQo+IGV4Y2VlZCBvbmUgY2x1c3Rlci4gTm93LCB3ZSBzcGxpdCBidWZmZXJl
ZCBkYXRhIGludG8gc2VwYXJhdGUgY2x1c3RlcnMNCj4gYW5kIHdyaXRlIHRoZW0gY29tcHJlc3Nl
ZCB1c2luZyB0aGUgZXhpc3RpbmcgZnVuY3Rpb25hbGl0eS4NCj4gDQo+IFN1Z2dlc3RlZC1ieTog
UGF2ZWwgQnV0c3lraW4gPHBidXRzeWtpbkB2aXJ0dW96em8uY29tPg0KPiBTaWduZWQtb2ZmLWJ5
OiBBbmRyZXkgU2hpbmtldmljaCA8YW5kcmV5LnNoaW5rZXZpY2hAdmlydHVvenpvLmNvbT4NCj4g
LS0tDQo+ICAgYmxvY2svcWNvdzIuYyB8IDEwMiArKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDc1IGlu
c2VydGlvbnMoKyksIDI3IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Jsb2NrL3Fj
b3cyLmMgYi9ibG9jay9xY293Mi5jDQo+IGluZGV4IDZiMjllMTYuLjlhODVkNzMgMTAwNjQ0DQo+
IC0tLSBhL2Jsb2NrL3Fjb3cyLmMNCj4gKysrIGIvYmxvY2svcWNvdzIuYw0KPiBAQCAtNDE1Niwx
MCArNDE1Niw4IEBAIGZhaWw6DQo+ICAgICAgIHJldHVybiByZXQ7DQo+ICAgfQ0KPiAgIA0KPiAt
LyogWFhYOiBwdXQgY29tcHJlc3NlZCBzZWN0b3JzIGZpcnN0LCB0aGVuIGFsbCB0aGUgY2x1c3Rl
ciBhbGlnbmVkDQo+IC0gICB0YWJsZXMgdG8gYXZvaWQgbG9zaW5nIGJ5dGVzIGluIGFsaWdubWVu
dCAqLw0KPiAgIHN0YXRpYyBjb3JvdXRpbmVfZm4gaW50DQo+IC1xY293Ml9jb19wd3JpdGV2X2Nv
bXByZXNzZWRfcGFydChCbG9ja0RyaXZlclN0YXRlICpicywNCj4gK3Fjb3cyX2NvX3B3cml0ZXZf
Y29tcHJlc3NlZF90YXNrKEJsb2NrRHJpdmVyU3RhdGUgKmJzLA0KPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHVpbnQ2NF90IG9mZnNldCwgdWludDY0X3QgYnl0ZXMsDQo+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgUUVNVUlPVmVjdG9yICpxaW92LCBzaXpl
X3QgcWlvdl9vZmZzZXQpDQo+ICAgew0KPiBAQCAtNDE2OSwzMiArNDE2NywxMSBAQCBxY293Ml9j
b19wd3JpdGV2X2NvbXByZXNzZWRfcGFydChCbG9ja0RyaXZlclN0YXRlICpicywNCj4gICAgICAg
dWludDhfdCAqYnVmLCAqb3V0X2J1ZjsNCj4gICAgICAgdWludDY0X3QgY2x1c3Rlcl9vZmZzZXQ7
DQo+ICAgDQo+IC0gICAgaWYgKGhhc19kYXRhX2ZpbGUoYnMpKSB7DQo+IC0gICAgICAgIHJldHVy
biAtRU5PVFNVUDsNCj4gLSAgICB9DQo+IC0NCj4gLSAgICBpZiAoYnl0ZXMgPT0gMCkgew0KPiAt
ICAgICAgICAvKiBhbGlnbiBlbmQgb2YgZmlsZSB0byBhIHNlY3RvciBib3VuZGFyeSB0byBlYXNl
IHJlYWRpbmcgd2l0aA0KPiAtICAgICAgICAgICBzZWN0b3IgYmFzZWQgSS9PcyAqLw0KPiAtICAg
ICAgICBpbnQ2NF90IGxlbiA9IGJkcnZfZ2V0bGVuZ3RoKGJzLT5maWxlLT5icyk7DQo+IC0gICAg
ICAgIGlmIChsZW4gPCAwKSB7DQo+IC0gICAgICAgICAgICByZXR1cm4gbGVuOw0KPiAtICAgICAg
ICB9DQo+IC0gICAgICAgIHJldHVybiBiZHJ2X2NvX3RydW5jYXRlKGJzLT5maWxlLCBsZW4sIFBS
RUFMTE9DX01PREVfT0ZGLCBOVUxMKTsNCj4gLSAgICB9DQo+IC0NCj4gLSAgICBpZiAob2Zmc2V0
X2ludG9fY2x1c3RlcihzLCBvZmZzZXQpKSB7DQo+IC0gICAgICAgIHJldHVybiAtRUlOVkFMOw0K
PiAtICAgIH0NCj4gKyAgICBhc3NlcnQoYnl0ZXMgPT0gcy0+Y2x1c3Rlcl9zaXplIHx8IChieXRl
cyA8IHMtPmNsdXN0ZXJfc2l6ZSAmJg0KPiArICAgICAgICAgICAob2Zmc2V0ICsgYnl0ZXMgPT0g
YnMtPnRvdGFsX3NlY3RvcnMgPDwgQkRSVl9TRUNUT1JfQklUUykpKTsNCj4gICANCj4gICAgICAg
YnVmID0gcWVtdV9ibG9ja2FsaWduKGJzLCBzLT5jbHVzdGVyX3NpemUpOw0KPiAtICAgIGlmIChi
eXRlcyAhPSBzLT5jbHVzdGVyX3NpemUpIHsNCj4gLSAgICAgICAgaWYgKGJ5dGVzID4gcy0+Y2x1
c3Rlcl9zaXplIHx8DQo+IC0gICAgICAgICAgICBvZmZzZXQgKyBieXRlcyAhPSBicy0+dG90YWxf
c2VjdG9ycyA8PCBCRFJWX1NFQ1RPUl9CSVRTKQ0KPiAtICAgICAgICB7DQo+IC0gICAgICAgICAg
ICBxZW11X3ZmcmVlKGJ1Zik7DQo+IC0gICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4gLSAg
ICAgICAgfQ0KPiArICAgIGlmIChieXRlcyA8IHMtPmNsdXN0ZXJfc2l6ZSkgew0KPiAgICAgICAg
ICAgLyogWmVyby1wYWQgbGFzdCB3cml0ZSBpZiBpbWFnZSBzaXplIGlzIG5vdCBjbHVzdGVyIGFs
aWduZWQgKi8NCj4gICAgICAgICAgIG1lbXNldChidWYgKyBieXRlcywgMCwgcy0+Y2x1c3Rlcl9z
aXplIC0gYnl0ZXMpOw0KPiAgICAgICB9DQo+IEBAIC00MjQzLDYgKzQyMjAsNzcgQEAgZmFpbDoN
Cj4gICAgICAgcmV0dXJuIHJldDsNCj4gICB9DQo+ICAgDQo+ICtzdGF0aWMgY29yb3V0aW5lX2Zu
IGludCBxY293Ml9jb19wd3JpdGV2X2NvbXByZXNzZWRfdGFza19lbnRyeShBaW9UYXNrICp0YXNr
KQ0KPiArew0KPiArICAgIFFjb3cyQWlvVGFzayAqdCA9IGNvbnRhaW5lcl9vZih0YXNrLCBRY293
MkFpb1Rhc2ssIHRhc2spOw0KPiArDQo+ICsgICAgYXNzZXJ0KCF0LT5jbHVzdGVyX3R5cGUgJiYg
IXQtPmwybWV0YSk7DQo+ICsNCj4gKyAgICByZXR1cm4gcWNvdzJfY29fcHdyaXRldl9jb21wcmVz
c2VkX3Rhc2sodC0+YnMsIHQtPm9mZnNldCwgdC0+Ynl0ZXMsIHQtPnFpb3YsDQo+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHQtPnFpb3Zfb2Zmc2V0KTsNCj4g
K30NCj4gKw0KPiArLyoNCj4gKyAqIFhYWDogcHV0IGNvbXByZXNzZWQgc2VjdG9ycyBmaXJzdCwg
dGhlbiBhbGwgdGhlIGNsdXN0ZXIgYWxpZ25lZA0KPiArICAgdGFibGVzIHRvIGF2b2lkIGxvc2lu
ZyBieXRlcyBpbiBhbGlnbm1lbnQNCg0KbWlzc2VkIGFzdGVyaXNrDQoNCj4gKyAqLw0KPiArc3Rh
dGljIGNvcm91dGluZV9mbiBpbnQNCj4gK3Fjb3cyX2NvX3B3cml0ZXZfY29tcHJlc3NlZF9wYXJ0
KEJsb2NrRHJpdmVyU3RhdGUgKmJzLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgdWludDY0X3Qgb2Zmc2V0LCB1aW50NjRfdCBieXRlcywNCj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIFFFTVVJT1ZlY3RvciAqcWlvdiwgc2l6ZV90IHFpb3Zfb2Zmc2V0KQ0K
PiArew0KPiArICAgIEJEUlZRY293MlN0YXRlICpzID0gYnMtPm9wYXF1ZTsNCj4gKyAgICBBaW9U
YXNrUG9vbCAqYWlvID0gTlVMTDsNCj4gKyAgICBpbnQgcmV0Ow0KPiArDQo+ICsgICAgaWYgKGhh
c19kYXRhX2ZpbGUoYnMpKSB7DQo+ICsgICAgICAgIHJldHVybiAtRU5PVFNVUDsNCj4gKyAgICB9
DQo+ICsNCj4gKyAgICBpZiAoYnl0ZXMgPT0gMCkgew0KPiArICAgICAgICAvKg0KPiArICAgICAg
ICAgKiBhbGlnbiBlbmQgb2YgZmlsZSB0byBhIHNlY3RvciBib3VuZGFyeSB0byBlYXNlIHJlYWRp
bmcgd2l0aA0KPiArICAgICAgICAgKiBzZWN0b3IgYmFzZWQgSS9Pcw0KPiArICAgICAgICAgKi8N
Cj4gKyAgICAgICAgaW50NjRfdCBsZW4gPSBiZHJ2X2dldGxlbmd0aChicy0+ZmlsZS0+YnMpOw0K
PiArICAgICAgICBpZiAobGVuIDwgMCkgew0KPiArICAgICAgICAgICAgcmV0dXJuIGxlbjsNCj4g
KyAgICAgICAgfQ0KPiArICAgICAgICByZXR1cm4gYmRydl9jb190cnVuY2F0ZShicy0+ZmlsZSwg
bGVuLCBQUkVBTExPQ19NT0RFX09GRiwgTlVMTCk7DQo+ICsgICAgfQ0KPiArDQo+ICsgICAgaWYg
KG9mZnNldF9pbnRvX2NsdXN0ZXIocywgb2Zmc2V0KSkgew0KPiArICAgICAgICByZXR1cm4gLUVJ
TlZBTDsNCj4gKyAgICB9DQo+ICsNCj4gKyAgICB3aGlsZSAoYnl0ZXMgJiYgYWlvX3Rhc2tfcG9v
bF9zdGF0dXMoYWlvKSA9PSAwKSB7DQo+ICsgICAgICAgIHVpbnQzMl90IGNodW5rX3NpemUgPSBN
SU4oYnl0ZXMsIHMtPmNsdXN0ZXJfc2l6ZSk7DQoNCkhtbS4gY2x1c3Rlcl9zaXplIGlzIGludC4g
Ynl0ZXMgaXMgdWludDY0X3QuIHFjb3cyX2FkZF90YXNrIGFyZ3VtZW50IHR5cGUNCmlzIHVpbnQ2
NF90LiBJIHRoaW5rIGJldHRlciB0byBjaG9vc2UgZnJvbSB0aGVzZSB0eXBlcy4uIEFiZCwgSSdk
IHByZWZlciB0bw0KdXNlIHVpbnQ2NF90IGZvciBjaHVua19zaXplLi4gQnV0LCB1aW50MzJfdCBz
aG91bGQgd29yayB0b28sIG9mIGNvdXJzZS4NCg0KPiArDQo+ICsgICAgICAgIGlmICghYWlvICYm
IGNodW5rX3NpemUgIT0gYnl0ZXMpIHsNCj4gKyAgICAgICAgICAgIGFpbyA9IGFpb190YXNrX3Bv
b2xfbmV3KFFDT1cyX01BWF9XT1JLRVJTKTsNCj4gKyAgICAgICAgfQ0KPiArDQo+ICsgICAgICAg
IHJldCA9IHFjb3cyX2FkZF90YXNrKGJzLCBhaW8sIHFjb3cyX2NvX3B3cml0ZXZfY29tcHJlc3Nl
ZF90YXNrX2VudHJ5LA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAwLCAwLCBvZmZz
ZXQsIGNodW5rX3NpemUsIHFpb3YsIHFpb3Zfb2Zmc2V0LCBOVUxMKTsNCj4gKyAgICAgICAgaWYg
KHJldCA8IDApIHsNCj4gKyAgICAgICAgICAgIGJyZWFrOw0KPiArICAgICAgICB9DQo+ICsgICAg
ICAgIHFpb3Zfb2Zmc2V0ICs9IGNodW5rX3NpemU7DQo+ICsgICAgICAgIG9mZnNldCArPSBjaHVu
a19zaXplOw0KPiArICAgICAgICBieXRlcyAtPSBjaHVua19zaXplOw0KPiArICAgIH0NCj4gKw0K
PiArICAgIGlmIChhaW8pIHsNCj4gKyAgICAgICAgYWlvX3Rhc2tfcG9vbF93YWl0X2FsbChhaW8p
Ow0KPiArICAgICAgICBpZiAocmV0ID09IDApIHsNCj4gKyAgICAgICAgICAgIHJldCA9IGFpb190
YXNrX3Bvb2xfc3RhdHVzKGFpbyk7DQo+ICsgICAgICAgIH0NCj4gKyAgICAgICAgZ19mcmVlKGFp
byk7DQo+ICsgICAgfQ0KPiArDQo+ICsgICAgcmV0dXJuIHJldDsNCj4gK30NCj4gKw0KPiAgIHN0
YXRpYyBpbnQgY29yb3V0aW5lX2ZuDQo+ICAgcWNvdzJfY29fcHJlYWR2X2NvbXByZXNzZWQoQmxv
Y2tEcml2ZXJTdGF0ZSAqYnMsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDY0
X3QgZmlsZV9jbHVzdGVyX29mZnNldCwNCj4gDQoNCg0KV2l0aCBhc3RlcmlzayBpbiBjb21tZW50
IGZpeGVkLCBhbmQgb3B0aW9uYWxseSBjaHVua19zaXplIHR5cGUgY2hhbmdlZCB0byB1aW50NjRf
dDoNCg0KUmV2aWV3ZWQtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRz
b3ZAdmlydHVvenpvLmNvbT4NCg0KQWxzbywgSSdkIHByZWZlciB0aGlzIHBhdGNoIHRvIGdvIGZp
cnN0LCBvdGhlcndpc2Ugd2UgYWRkZWQgaW4gcHJldmlvdXMgcGF0Y2ggYW4NCm9wdGlvbiB3aGlj
aCBkb2Vzbid0IHdvcmsgZm9yIHJlcXVlc3RzIGxhcmdlciB0aGFuIG9uZSBjbHVzdGVyLg0KDQpP
ciwgb3RoZXJ3aXNlLCB5b3UgY2FuIGluIHByZXZpb3VzIHBhdGNoIHNldCBtYXhfdHJhbnNmZXIg
dG8gb25lIGNsdXN0ZXIgaW4gY2FzZQ0Kb2YgYWxsX3dyaXRlc19jb21wcmVzc2VkLCBhbmQgaW4g
dGhpcyBwYXRjaCBkcm9wIHRoaXMgcmVzdHJpY3Rpb24uDQoNCihOb3RlLCB0aGF0IHRoaXMgcGF0
Y2ggaXMgbmVlZGVkOiBpZiB3ZSBqdXN0IHNldCBtYXhfdHJhbnNmZXIgdG8gb25lIGNsdXN0ZXIg
aW5zdGVhZA0KZm9yIGFsbF93cml0ZXNfY29tcHJlc3NlZCBjYXNlLCB3ZSdsbCBtaXNzIGJlbmVm
aXRzIG9mIGFpb190YXNrX3Bvb2wgYW5kIHdpbGwgbm90DQpjb21wcmVzcyBjbHVzdGVycyBpbiBw
YXJhbGxlbCB0aHJlYWRzIGZvciBvbmUgcmVxdWVzdCkuDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0K
VmxhZGltaXINCg==

