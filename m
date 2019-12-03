Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF427C432C3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 07:42:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAAC620637
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 07:42:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ZZ78J4Zm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAAC620637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=openvz.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ic2pj-0000l4-Rb
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 02:42:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56069)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <den@virtuozzo.com>) id 1ic2na-0000Bb-Pg
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 02:40:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <den@virtuozzo.com>) id 1ic2nY-0000NA-Mw
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 02:40:42 -0500
Received: from mail-eopbgr00138.outbound.protection.outlook.com
 ([40.107.0.138]:12935 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <den@virtuozzo.com>) id 1ic2nW-0000I7-JP
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 02:40:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=URIJ2F+eH5o0MgJ7VsMkbIWJ3t2YOSc/ba9fN74+ZT8hC/2DMyjLBJTv4jyom9hhEP9mCYCeM138WZpAjlP4jx617fikFWoSo0gZwWtxJOgijaFBWa7YQjhPl1++TTR7lLpiJp/jZuZcpqpLRHzRIiPoYLTQSktVSwaFx+Qfef1fTOaZi60BvwVOpcNWGCWPOBh/KqFA/HWn6AS+DURR9u21LHkG8UD8T/AhKB02gv12pISSmol3GFAYRf6ExpaeC2spI/4++Cqk1BTo4fQsEdeUsdchbjWjgyUlUioQN5p5+FA3tA4BrathgnZxsImDKWQduK0YeuexK3/j1c/viw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YC+OsMkCFSuxxA8Xvu/6iBpOd6cRXplu7FbwVA4WAVY=;
 b=XRItyasvuJHLU609j2r+fd0jEHwC/F1bZmAhaGGIdudcOD1R5Elo8IStJGJ0ouE4Ml6rU00v+R2izugJ7MlKVhJG+hZN44g1K243iYIiMK0lJLSKjMunHILpzkmDAmDea7WMi9kvqdi+g9+d7MFWnZXq7Uc+7weYf5l6kIF3+CC/6mE3EwzqCZA7knEH9deQoUL8BPAIdee+C6+73dmn1vVZVvhEuuMbtGPHKG8QxT26Krles586EKZ29b+gWWcSwjCEMssemU/RkmO69cREMJbwP/veiWCcfugUqjjD57lR/ajYRu3p37+kRUFq8aXJpSo21NYUr2JeUBLX9LlLYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none header.from=openvz.org;
 dkim=pass header.d=openvz.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YC+OsMkCFSuxxA8Xvu/6iBpOd6cRXplu7FbwVA4WAVY=;
 b=ZZ78J4ZmO+p6D2L3OQpKjihLngUbl/yuN8HPyOrQ83+BZCcKRk/W4zxgLfmw0RfvjBvVLEhMWMZXl3Mi5RGGGkB1Kv+PmcGP/diU4M8IkWD0APVUK+5WANoDgLthZutfNlSwcZtjS2TSB+GySfdzckPxFby3nNsP1y1T7deDadY=
Received: from DB7PR08MB3052.eurprd08.prod.outlook.com (52.135.131.139) by
 DB7PR08MB3721.eurprd08.prod.outlook.com (20.178.47.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.21; Tue, 3 Dec 2019 07:40:32 +0000
Received: from DB7PR08MB3052.eurprd08.prod.outlook.com
 ([fe80::c9cf:8792:ca32:c33c]) by DB7PR08MB3052.eurprd08.prod.outlook.com
 ([fe80::c9cf:8792:ca32:c33c%6]) with mapi id 15.20.2495.014; Tue, 3 Dec 2019
 07:40:32 +0000
From: "Denis V. Lunev" <den@openvz.org>
To: Markus Armbruster <armbru@redhat.com>, Yury Kotov
 <yury-kotov@yandex-team.ru>
Subject: Re: [PATCH] monitor: Fix slow reading
Thread-Topic: [PATCH] monitor: Fix slow reading
Thread-Index: AQHVpo4SPLQbGG2Ku0iKt2rn+QCK0qenIt2AgAA0NkyAALWvgA==
Date: Tue, 3 Dec 2019 07:40:32 +0000
Message-ID: <3ab0ec6b-cbd6-1f72-bc6a-4d587db6589e@openvz.org>
References: <20191122092347.28309-1-yury-kotov@yandex-team.ru>
 <87v9r3w0ro.fsf@dusky.pond.sub.org>
 <324361575308591@sas1-20474e4ea3be.qloud-c.yandex.net>
 <87wobea1vv.fsf@dusky.pond.sub.org>
In-Reply-To: <87wobea1vv.fsf@dusky.pond.sub.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PR0P264CA0163.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1b::31) To DB7PR08MB3052.eurprd08.prod.outlook.com
 (2603:10a6:5:28::11)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=den@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [31.148.204.195]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 97751dde-d9f7-4a35-f913-08d777c4137f
x-ms-traffictypediagnostic: DB7PR08MB3721:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR08MB37210650E55513ACDF0CBD7DB6420@DB7PR08MB3721.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02408926C4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(136003)(396003)(366004)(39840400004)(376002)(189003)(199004)(2616005)(229853002)(66066001)(11346002)(14444005)(6116002)(66946007)(102836004)(3846002)(4326008)(66556008)(31696002)(31686004)(25786009)(64756008)(6246003)(76176011)(6436002)(6512007)(66476007)(42882007)(186003)(53546011)(14454004)(66446008)(386003)(6506007)(26005)(6306002)(5660300002)(110136005)(54906003)(316002)(2906002)(8676002)(6486002)(256004)(7736002)(52116002)(446003)(99286004)(81156014)(966005)(71200400001)(71190400001)(81166006)(478600001)(36756003)(305945005)(8936002)(21314003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB7PR08MB3721;
 H:DB7PR08MB3052.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tPza0xSnS93xP8Rnv9M9y1kC/5a0azvftS04u+bbsNOaSYNIwKPg/xM3fcg5/e1exoCKkQf5mmja2ojL8PV9cVnGTHpkZkayz94hOGEJeWT8R/D7o6wz6eryxZI1evK1oKyV5V/1sdbiOns4B+qTzHvOPPC7Z9BHio5TrCiQYO10XXLrhZjF5dNnhuyVLjuXGb/bHB3v1S2SJ6HRl8Ut7i5wbJWokXM5kL+Fv8EMCoh2NavtlIRiAW+XATNHiWnEGyzrBEkS3JiK5K2hQlhlnueJk5GRnImGzWU2703b12WhAZQWGW1/QUGukE380SYZvGrHrxoIgT6ICCTG1rY7wOaxbeFNRFDwkskj0nh5M2TQkXZ1y1tTXZOt69DemUNy2RGweYm+StMaUj+SDifB8p1wztczLBy9suN3VZNvfx0AZD0zh3NmJj9TXw5qgmluUp/7tr4CQn42heGj2iDgRsOzRoam5tstuPCvrM6BnSo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6AE5127B61C2FD4699581466A71E684A@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: openvz.org
X-MS-Exchange-CrossTenant-Network-Message-Id: 97751dde-d9f7-4a35-f913-08d777c4137f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2019 07:40:32.2802 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rz+QbURz655lXkSbTYwREYuRmZZmhnpVjyattBR6gtyC6861aCZufsNZwqBfzTnLtEX8NttCFSIo5u53Yp2jVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3721
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.0.138
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
Cc: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gMTIvMi8xOSAxMTo0OSBQTSwgTWFya3VzIEFybWJydXN0ZXIgd3JvdGU6DQo+IFl1cnkgS290
b3YgPHl1cnkta290b3ZAeWFuZGV4LXRlYW0ucnU+IHdyaXRlczoNCj4NCj4+IEhpIQ0KPj4NCj4+
IDI5LjExLjIwMTksIDExOjIyLCAiTWFya3VzIEFybWJydXN0ZXIiIDxhcm1icnVAcmVkaGF0LmNv
bT46DQo+Pj4gWXVyeSBLb3RvdiA8eXVyeS1rb3RvdkB5YW5kZXgtdGVhbS5ydT4gd3JpdGVzOg0K
Pj4+DQo+Pj4+IMKgVGhlIG1vbml0b3JfY2FuX3JlYWQgKGFzIGEgY2FsbGJhY2sgb2YgcWVtdV9j
aHJfZmVfc2V0X2hhbmRsZXJzKQ0KPj4+PiDCoHNob3VsZCByZXR1cm4gc2l6ZSBvZiBidWZmZXIg
d2hpY2ggbW9uaXRvcl9xbXBfcmVhZCBvciBtb25pdG9yX3JlYWQNCj4+Pj4gwqBjYW4gcHJvY2Vz
cy4NCj4+Pj4gwqBDdXJyZW50bHksIG1vbml0b3JfY2FuX3JlYWQgcmV0dXJucyAxIGFzIGEgcmVz
dWx0IG9mIGxvZ2ljYWwgbm90Lg0KPj4+PiDCoFRodXMsIGZvciBlYWNoIFFNUCBjb21tYW5kLCBs
ZW4oUU1EKSBpdGVyYXRpb25zIG9mIHRoZSBtYWluIGxvb3ANCj4+Pj4gwqBhcmUgcmVxdWlyZWQg
dG8gaGFuZGxlIGEgY29tbWFuZC4NCj4+Pj4gwqBJbiBmYWN0LCB0aGVzZSBib3RoIGZ1bmN0aW9u
cyBjYW4gcHJvY2VzcyBhbnkgYnVmZmVyIHNpemUuDQo+Pj4+IMKgU28sIHJldHVybiAxMDI0IGFz
IGEgcmVhc29uYWJsZSBzaXplIHdoaWNoIGlzIGVub3VnaCB0byBwcm9jZXNzDQo+Pj4+IMKgdGhl
IG1vc3QgUU1QIGNvbW1hbmRzLCBidXQgbm90IHRvbyBiaWcgdG8gYmxvY2sgdGhlIG1haW4gbG9v
cCBmb3INCj4+Pj4gwqBhIGxvbmcgdGltZS4NCj4+Pj4NCj4+Pj4gwqBTaWduZWQtb2ZmLWJ5OiBZ
dXJ5IEtvdG92IDx5dXJ5LWtvdG92QHlhbmRleC10ZWFtLnJ1Pg0KPj4+PiDCoC0tLQ0KPj4+PiDC
oMKgbW9uaXRvci9tb25pdG9yLmMgfCA5ICsrKysrKysrLQ0KPj4+PiDCoMKgMSBmaWxlIGNoYW5n
ZWQsIDggaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPj4+Pg0KPj4+PiDCoGRpZmYgLS1n
aXQgYS9tb25pdG9yL21vbml0b3IuYyBiL21vbml0b3IvbW9uaXRvci5jDQo+Pj4+IMKgaW5kZXgg
MTI4OThiNjQ0OC4uY2FjM2YzOTcyNyAxMDA2NDQNCj4+Pj4gwqAtLS0gYS9tb25pdG9yL21vbml0
b3IuYw0KPj4+PiDCoCsrKyBiL21vbml0b3IvbW9uaXRvci5jDQo+Pj4+IMKgQEAgLTUwLDYgKzUw
LDEzIEBAIHR5cGVkZWYgc3RydWN0IHsNCj4+Pj4gwqDCoMKgwqDCoMKgaW50NjRfdCByYXRlOyAv
KiBNaW5pbXVtIHRpbWUgKGluIG5zKSBiZXR3ZWVuIHR3byBldmVudHMgKi8NCj4+Pj4gwqDCoH0g
TW9uaXRvclFBUElFdmVudENvbmY7DQo+Pj4+DQo+Pj4+IMKgKy8qDQo+Pj4+IMKgKyAqIFRoZSBt
YXhpbXVtIGJ1ZmZlciBzaXplIHdoaWNoIHRoZSBtb25pdG9yIGNhbiBwcm9jZXNzIGluIG9uZSBp
dGVyYXRpb24NCj4+Pj4gwqArICogb2YgdGhlIG1haW4gbG9vcC4gV2UgZG9uJ3Qgd2FudCB0byBi
bG9jayB0aGUgbG9vcCBmb3IgYSBsb25nIHRpbWUNCj4+Pj4gwqArICogYmVjYXVzZSBvZiBKU09O
IHBhcnNlciwgc28gdXNlIGEgcmVhc29uYWJsZSB2YWx1ZS4NCj4+Pj4gwqArICovDQo+Pj4+IMKg
KyNkZWZpbmUgTU9OSVRPUl9SRUFEX0xFTl9NQVggMTAyNA0KPj4+PiDCoCsNCj4+Pj4gwqDCoC8q
IFNoYXJlZCBtb25pdG9yIEkvTyB0aHJlYWQgKi8NCj4+Pj4gwqDCoElPVGhyZWFkICptb25faW90
aHJlYWQ7DQo+Pj4+DQo+Pj4+IMKgQEAgLTQ5OCw3ICs1MDUsNyBAQCBpbnQgbW9uaXRvcl9jYW5f
cmVhZCh2b2lkICpvcGFxdWUpDQo+Pj4+IMKgwqB7DQo+Pj4+IMKgwqDCoMKgwqDCoE1vbml0b3Ig
Km1vbiA9IG9wYXF1ZTsNCj4+Pj4NCj4+Pj4gwqAtIHJldHVybiAhYXRvbWljX21iX3JlYWQoJm1v
bi0+c3VzcGVuZF9jbnQpOw0KPj4+PiDCoCsgcmV0dXJuIGF0b21pY19tYl9yZWFkKCZtb24tPnN1
c3BlbmRfY250KSA/IDAgOiBNT05JVE9SX1JFQURfTEVOX01BWDsNCj4+Pj4gwqDCoH0NCj4+Pj4N
Cj4+Pj4gwqDCoHZvaWQgbW9uaXRvcl9saXN0X2FwcGVuZChNb25pdG9yICptb24pDQo+Pj4gUHJp
b3IgYXR0ZW1wdDoNCj4+PiBbUEFUQ0ggMS8xXSBtb25pdG9yOiBpbmNyZWFzZSBhbW91bnQgb2Yg
ZGF0YSBmb3IgbW9uaXRvciB0byByZWFkDQo+Pj4gTWVzc2FnZS1JZDogPDE0OTM3MzI4NTctMTA3
MjEtMS1naXQtc2VuZC1lbWFpbC1kZW5Ab3BlbnZ6Lm9yZz4NCj4+PiBodHRwczovL2xpc3RzLm5v
bmdudS5vcmcvYXJjaGl2ZS9odG1sL3FlbXUtZGV2ZWwvMjAxNy0wNS9tc2cwMDIwNi5odG1sDQo+
Pj4NCj4+PiBSZXZpZXcgY29uY2x1ZGVkIHRoYXQgaXQgYnJlYWtzIEhNUCBjb21tYW5kIG1pZ3Jh
dGUgd2l0aG91dCAtZC4gUU1QIGlzDQo+Pj4gcHJvYmFibHkgb2theS4gU2FkbHksIG5vIHYyLg0K
Pj4+DQo+Pj4gTmV4dCBvbmU6DQo+Pj4gU3ViamVjdDogW1BBVENIXSBtb25pdG9yOiBpbmNyZWFz
ZSBhbW91bnQgb2YgZGF0YSBmb3IgbW9uaXRvciB0byByZWFkDQo+Pj4gTWVzc2FnZS1JZDogPDIw
MTkwNjEwMTA1OTA2LjI4NTI0LTEtZHBsb3RuaWtvdkB2aXJ0dW96em8uY29tPg0KPj4+IGh0dHBz
Oi8vbGlzdHMubm9uZ251Lm9yZy9hcmNoaXZlL2h0bWwvcWVtdS1kZXZlbC8yMDE5LTA2L21zZzAx
OTEyLmh0bWwNCj4+Pg0KPj4+IFNhbWUgcGF0Y2gsIHdpdGggYSBzZWNvbmQsIHN1c3BpY2lvdXMt
bG9va2luZyBodW5rIHRocm93biBpbi4gSSBkaWRuJ3QNCj4+PiBtYWtlIHRoZSBjb25uZWN0aW9u
IHRvIHRoZSBwcmlvciBhdHRlbXB0IGJhY2sgdGhlbi4gSSB3cm90ZSAiSSB0aGluayBJDQo+Pj4g
bmVlZCB0byAocmUtKWV4YW1pbmUgaG93IFFNUCByZWFkcyBpbnB1dCwgd2l0aCBzcGVjaWFsIGNv
bnNpZGVyYXRpb24gdG8NCj4+PiBpdHMgT09CIGZlYXR1cmUuIg0KPj4+DQo+Pj4gVGhpcyBwYXRj
aCBpcyBhIGNsZWFuZXIgdmFyaWF0aW9uIG9uIHRoZSBzYW1lIHRoZW1lLiBJdHMgcmFtaWZpY2F0
aW9ucw0KPj4+IGFyZSBhcyB1bm9idmlvdXMgYXMgZXZlci4NCj4+Pg0KPj4+IEkgZmlndXJlIHRo
ZSBITVAgc2l0dWF0aW9uIGlzIHVuY2hhbmdlZDogbm90IHNhZmUsIGFsdGhvdWdoIHdlIGNvdWxk
DQo+Pj4gcHJvYmFibHkgbWFrZSBpdCBzYWZlIGlmIHdlIHdhbnRlZCB0byAoRGFuaWVsIHNrZXRj
aGVkIGhvdykuIE15IHNpbXBsZXINCj4+PiBzdWdnZXN0aW9uIHN0YW5kczogc2VwYXJhdGUgZl9j
YW5fcmVhZCgpIGNhbGxiYWNrcyBmb3IgSE1QIGFuZCBRTVANCj4+PiBbUEFUQ0ggMV0sIHRoZW4g
Y2hhbmdlIG9ubHkgdGhlIG9uZSBmb3IgUU1QIFtQQVRDSCAyXS4NCj4+Pg0KPj4+IFRoZSBRTVAg
c2l0dWF0aW9uIGlzIGFsc28gdW5jaGFuZ2VkOiB3ZSBzdGlsbCBuZWVkIHRvIHRoaW5rIHRocm91
Z2ggaG93DQo+Pj4gdGhpcyBhZmZlY3RzIHJlYWRpbmcgb2YgUU1QIGlucHV0LCBpbiBwYXJ0aWN1
bGFyIE9PQi4NCj4+IEkndmUgcmVhZCB0aGUgZGlzY3Vzc2lvbiBhcm91bmQgcGF0Y2hlczoNCj4+
ICJtb25pdG9yOiBpbmNyZWFzZSBhbW91bnQgb2YgZGF0YSBmb3IgbW9uaXRvciB0byByZWFkIg0K
Pj4gYW5kIHJlYWxpemVkIHRoZSBwcm9ibGVtLg0KPj4NCj4+IEl0IHNlZW1zIHRoYXQgbXkgcGF0
Y2ggYWN0dWFsbHkgaGFzIHNvbWUgYnVncyB3aXRoIEhNUCBhbmQgT09CDQo+PiBiZWNhdXNlIG9m
IHN1c3BlbmQvcmVzdW1lLg0KPiBGb3IgSE1QIHdlJ3JlIHN1cmUsIGZvciBPT0Igd2UgZG9uJ3Qg
a25vdy4NCj4NCj4+IElJVUMgdGhlcmUgYXJlIHNvbWUgYXBwcm9hY2hlcyB0byBmaXggdGhlbToN
Cj4+DQo+PiAxKSBJbnB1dCBidWZmZXINCj4+ICAgMS4gQWRkIGlucHV0IGJ1ZmZlciBmb3IgTW9u
aXRvciBzdHJ1Y3QNCj4+ICAgMi4gSGFuZGxlIGNvbW1hbmRzIGZyb20gbW9uaXRvcl94eHhfcmVh
ZCBjYWxsYmFja3Mgb25lIGJ5IG9uZQ0KPj4gICAzLiBTY2hlZHVsZSBCSCB0byBoYW5kbGUgcmVt
YWluaW5nIGJ5dGVzIGluIHRoZSBidWZmZXINCj4+DQo+PiAyKSBJbnB1dCBidWZmZXIgZm9yIHN1
c3BlbmQvcmVzdW1lDQo+PiAgIDEuIEFkZCBpbnB1dCBidWZmZXIgZm9yIE1vbml0b3Igc3RydWN0
DQo+PiAgIDIuIEhhbmRsZSBtdWx0aXBsZSBjb21tYW5kcyB1bnRpbCBtb25pdG9yIGlzIG5vdCBz
dXNwZW5kZWQNCj4+ICAgMy4gSWYgbW9uaXRvciBzdXNwZW5kZWQsIHB1dCByZW1haW5pbmcgZGF0
YSB0byB0aGUgYnVmZmVyDQo+PiAgIDQuIEhhbmRsZSByZW1haW5pbmcgZGF0YSBpbiB0aGUgYnVm
ZmVyIHdoZW4gd2UgZ2V0IHJlc3VtZQ0KPj4NCj4+IFdlIHVzZSBRRU1VIDIuMTIgd2hpY2ggZG9l
c24ndCBoYXZlIHRoZSBmdWxsIHN1cHBvcnQgb2YgT09CIGFuZCBmb3Igd2hpY2ggaXQncw0KPj4g
ZW5vdWdoIHRvIGZpeCBITVAgY2FzZSBieSBzZXBhcmF0aW5nIGNhbl9yZWFkIGNhbGxiYWNrcy4g
QnV0IHRob3NlIHdobyB1c2UNCj4+IGEgbmV3ZXIgdmVyc2lvbiBvZiBRRU1VIGNhbiB1c2UgT09C
IGZlYXR1cmUgdG8gaW1wcm92ZSBITVAvUU1QIHBlcmZvcm1hbmNlLg0KPiBPT0IgaXNuJ3QgZm9y
IG1vbml0b3IgcGVyZm9ybWFuY2UsIGl0J3MgZm9yIG1vbml0b3IgYXZhaWxhYmlsaXR5Lg0KPg0K
PiBRTVAgZXhlY3V0ZXMgb25lIGNvbW1hbmQgYWZ0ZXIgdGhlIG90aGVyLiAgV2hpbGUgYSBjb21t
YW5kIGV4ZWN1dGVzLCB0aGUNCj4gbW9uaXRvciBpcyBlZmZlY3RpdmVseSB1bmF2YWlsYWJsZS4g
IFRoaXMgY2FuIGJlIGEgcHJvYmxlbS4gIE9PQg0KPiBleGVjdXRpb24gbGV0cyB5b3UgZXhlY3V0
ZSBhIGZldyBzcGVjaWFsIGNvbW1hbmRzIHJpZ2h0IGF3YXksIHdpdGhvdXQNCj4gd2FpdGluZyBm
b3IgcHJpb3IgY29tbWFuZHMgdG8gY29tcGxldGUuDQo+DQo+PiBTbywgSSdtIG5vdCBzdXJlIHRo
ZXJlJ3MgYSBiaWcgc2Vuc2UgaW4gaW50cm9kdWNpbmcgc29tZSBidWZmZXJzLg0KPiBSZWFkaW5n
IGJ5dGUtd2lzZSBpcyBwcmV0dHkgcGF0aGV0aWMsIGJ1dCBpdCB3b3Jrcy4gIEknbSBub3Qgc3Vy
ZSBob3cNCj4gbXVjaCBwZXJmb3JtYW5jZSBidWZmZXJzIGNhbiBnYWluIHVzLCBhbmQgd2hldGhl
ciBpdCdzIHdvcnRoIHRoZQ0KPiBuZWNlc3NhcnkgcmV2aWV3IGVmZm9ydC4gIEhvdyBRTVAgcmVh
ZHMgaW5wdXQgaXMgbm90IHRyaXZpYWwsIHRoYW5rcyB0bw0KPiBPT0IuDQo+DQo+IEhhdmUgeW91
IG1lYXN1cmVkIHRoZSBpbXByb3ZlbWVudD8NCj4NCldlIGhhdmUgaGFkIGluIHRoZSBwYXN0Lg0K
DQpUaGUgZWZmZWN0IGlzIHByZXR0eSB2aXNpYmxlIHVuZGVyIDIgY2FzZXM6DQoxLiAxMDArIGlk
bGUgVk1zIG9uIGhvc3QuIENQVSBsb2FkIGRyb3BzIGJ5IHNldmVyYWwgJQ0KwqDCoMKgIChBRkFJ
UiBsaWJ2aXJ0ZCBzZW5kcyBhcm91bmQgNCByZXF1ZXN0cyBpbiAzMCBzZWNvbmRzKQ0KMi4gV2Ug
aGF2ZSBoYWQgcHJvYmxlbXMgZnJvbSB0aW1lIHRvIHRpbWUgd2l0aCBzbG93DQrCoMKgwqAgbHNl
ZWsoU0VFS19IT0xFKSBvbiBzb21lIHBhdHRlcm5zLiBJbiB0aGF0IGNhc2Ugb3JpZ2luYWwNCsKg
wqDCoCBtb25pdG9yIGlzIG5vbi1yZXNwb25zaXZlIGF0IGFsbC4NCg0KRGVuDQo=

