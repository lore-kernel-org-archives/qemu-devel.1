Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C95C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 06:24:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08477218DE
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 06:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="uXaJLcJH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08477218DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIRsU-0000DX-2p
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 02:24:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44451)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iIRrn-0008C6-D0
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 02:24:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iIRrm-0005w7-05
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 02:24:03 -0400
Received: from mail-eopbgr60118.outbound.protection.outlook.com
 ([40.107.6.118]:45161 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iIRrl-0005vv-EQ; Thu, 10 Oct 2019 02:24:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LUKQmIg1GiGbRJvhsy2wF7v7NZiDPpMEq90zogj8E5Pz6GTTP83pbWPjnW+GcR2n+89yJFdarz3Bxa3hcd5GtC+/8DItufADWh1bruIJl4oxMmOoD0HPyGUFiTYQLM0BB8E3rJV1Nk4NPPzqqFa7/7sKfyU5gGOMrdpt2vJL//QTGq4YsndKHxBWoXhqqU9+LoxlV7kcIWliVL44Iriffr7BnsVz4wlqKpNg1Ysw2rJcWX+BVHEnR3hzbzjLIIT8YhW6Ch62WiWbhDROCGooUsyEhw/N95w4KQAVc3YuKvYlRJb1E0PNqkawQsCUVT9RwQdCtw0DsguOBQzDJSXUkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0XxNvGeymtiIC10iXoQjJBqmm+1fgySwx6jwvkqJ6Wk=;
 b=Z1VOARD2YSuW75kX7DDdAOAetF5JTQs71OfzcqbKo+KuvHIZBk8pRVSIWGi8CQ+hdeNTSqPYbFSYaUa+nrRObIlCnkpH9Gi04VYsQZNGJkVXUXGvnWCP09JhyEFLiQ6QDteakuuLq72R+tY7ByKs5ZBKwo+i0zxpVUzm/yTzv0UcD2CuJNabeZKKSth20s0oRPl9uz5lQ/u7DTSRtRTkVSTjqvTR34+6W0OiA8aFwttQl+DAdvEAFrKoY+WvN5mUXefDthMMIJGIv5REPx4H6V+mZt+8EvCxG65WAW8VIMuFfoS0Y9r++M8GqEypGeKIU+dd0z7+A3MH777dha6/LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0XxNvGeymtiIC10iXoQjJBqmm+1fgySwx6jwvkqJ6Wk=;
 b=uXaJLcJH9jLXYw4WR7foGXjVHLBW1SKzIG783cI8fXml8AIctYFJv73z7d1zxmGx4bC+QNEULz52DgLTPRjV1rsOe2ifPRqkGxMjq2SH+0iNyFAzTs1K605XnqlhCPbPxd+TeWknZgZSvUWDrLd6t8vaLKqGoJ2LQrZhS/OoQAQ=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5163.eurprd08.prod.outlook.com (10.255.18.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.18; Thu, 10 Oct 2019 06:23:58 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f%2]) with mapi id 15.20.2347.016; Thu, 10 Oct 2019
 06:23:58 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, Eric Blake <eblake@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH 0/5] block/dirty-bitmap: check number and size constraints
 against queued bitmaps
Thread-Topic: [PATCH 0/5] block/dirty-bitmap: check number and size
 constraints against queued bitmaps
Thread-Index: AQHVHJeLcgEUr7FAT06ulD3hcf3NuadTbYgAgAAeGgCAAKHEgA==
Date: Thu, 10 Oct 2019 06:23:58 +0000
Message-ID: <2460ad6b-1bfd-0d9f-2913-04c8211fb8b1@virtuozzo.com>
References: <20190606184159.979-1-jsnow@redhat.com>
 <ba9b72f0-42b4-f295-78e4-454cc2992346@redhat.com>
 <cd799a95-c1bc-a157-eac8-176e470a245b@redhat.com>
In-Reply-To: <cd799a95-c1bc-a157-eac8-176e470a245b@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0202CA0033.eurprd02.prod.outlook.com
 (2603:10a6:3:e4::19) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191010092355419
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 55172afe-8eee-41e0-ece1-08d74d4a6efc
x-ms-traffictypediagnostic: DB8PR08MB5163:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <DB8PR08MB5163D87DB5D1FF559EE9A480C1940@DB8PR08MB5163.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 018632C080
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(396003)(136003)(376002)(39850400004)(346002)(189003)(199004)(6246003)(3846002)(6436002)(476003)(2616005)(305945005)(6512007)(6116002)(486006)(25786009)(966005)(186003)(14454004)(102836004)(53546011)(52116002)(2906002)(7736002)(26005)(6306002)(6486002)(229853002)(99286004)(14444005)(256004)(76176011)(386003)(54906003)(110136005)(316002)(2201001)(86362001)(6506007)(561944003)(66066001)(66556008)(5660300002)(66946007)(66476007)(31686004)(31696002)(478600001)(71200400001)(71190400001)(36756003)(4326008)(66446008)(446003)(2501003)(81156014)(81166006)(64756008)(8936002)(8676002)(11346002)(14143004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5163;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iRzXQ6Vw7K1YDDkOZINSfc/+gOODBX7HkOHCHRyNNgJYpEOD9ZaL9kHwLiGFCj6skaEimW2XvV1J8/a5KvWci6q0qOB1aQFM72xUVHdQGKhPUZqKZWHsjgsJNGjqUAQ/0IgMO4BGkbq/QfnMbFMNNMJ9EQ7puhfH5wER5gokhyNiYVGW//4fHU6fiTKshgfuEd2jV3wsrXpSYFia+xMTshsk97kNU/pdtC8MKciltlKLOCuTrjK+WmBQoWs6XloBdMx24RJln3Nb7RPxLzh/Q3VspSJv4A5hF12SeCgo1so4ZKofNJj8/s9r25M6inbKJ5DhYrJ38pBMdslNm8hJbWZcuOLMNoBcjUtEcKRitbnqT3R6nxmqOEtlmpF3Xm9kQVLiOEAPzSC1cxY4xsCsD4bh/FEiM+BpBOjRdPvsbbYJPDz6zQOHvZMkLhjdyb9fiub9Xefc3Yt0ThsLJgtCAg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <100C3C89A4C385418D3E7E2875F5A07C@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55172afe-8eee-41e0-ece1-08d74d4a6efc
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2019 06:23:58.2743 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /5HdEmARUMhMCxDt3xEfMwZDtbL/ZXk2rQnyaitsqxMibgD1Ho3OBjvjVKWhcOaRfvcbB/HwO5bKfj75qV43qoJDj0FL0Dn0PHh5QAFI6i8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5163
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.6.118
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 aihua liang <aliang@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDkuMTAuMjAxOSAyMzo0NCwgSm9obiBTbm93IHdyb3RlOg0KPiANCj4gDQo+IE9uIDEwLzkvMTkg
Mjo1NyBQTSwgRXJpYyBCbGFrZSB3cm90ZToNCj4+IE9uIDYvNi8xOSAxOjQxIFBNLCBKb2huIFNu
b3cgd3JvdGU6DQo+Pj4gV2hlbiBhZGRpbmcgbmV3IHBlcnNpc3RlbnQgZGlydHkgYml0bWFwcywg
d2Ugb25seSBjaGVjayBjb25zdHJhaW50cw0KPj4+IGFnYWluc3QgY3VycmVudGx5IHN0b3JlZCBi
aXRtYXBzLCBhbmQgaWdub3JlIHRoZSBwZW5kaW5nIG51bWJlciBhbmQgc2l6ZQ0KPj4+IG9mIGFu
eSBiaXRtYXBzIHlldCB0byBiZSBzdG9yZWQuDQo+Pj4NCj4+PiBSZXdvcmsgdGhlICJjYW5fc3Rv
cmUiIGFuZCAicmVtb3ZlIiBpbnRlcmZhY2UgdG8gZXhwbGljaXQgImFkZCIgYW5kDQo+Pj4gInJl
bW92ZSIsDQo+Pj4gYW5kIGJlZ2luIGtlZXBpbmcgdHJhY2sgb2YgdGhlIHF1ZXVlZCBidXJkZW4g
d2hlbiBhZGRpbmcgbmV3IGJpdG1hcHMuDQo+Pj4NCj4+PiBSZXBvcnRlZC1ieTogYWlodWEgbGlh
bmcgPGFsaWFuZ0ByZWRoYXQuY29tPg0KPj4+IEZpeGVzOiBodHRwczovL2J1Z3ppbGxhLnJlZGhh
dC5jb20vc2hvd19idWcuY2dpP2lkPTE3MTI2MzYNCj4+Pg0KPj4+IEpvaG4gU25vdyAoNSk6DQo+
Pj4gIMKgwqAgYmxvY2svcWNvdzItYml0bWFwOiBhbGxvdyBiaXRtYXBfbGlzdF9sb2FkIHRvIHJl
dHVybiBhbiBlcnJvciBjb2RlDQo+Pj4gIMKgwqAgYmxvY2svZGlydHktYml0bWFwOiBSZWZhY3Rv
ciBiZHJ2X2Nhbl9zdG9yZV9uZXdfYml0bWFwDQo+Pj4gIMKgwqAgYmxvY2svZGlydHktYml0bWFw
OiByZXdvcmsgYmRydl9yZW1vdmVfcGVyc2lzdGVudF9kaXJ0eV9iaXRtYXANCj4+PiAgwqDCoCBi
bG9jay9xY293Mi1iaXRtYXA6IENvdW50IHF1ZXVlZCBiaXRtYXBzIHRvd2FyZHMgbmJfYml0bWFw
cw0KPj4+ICDCoMKgIGJsb2NrL3Fjb3cyLWJpdG1hcDogQ291bnQgcXVldWVkIGJpdG1hcHMgdG93
YXJkcyBkaXJlY3Rvcnlfc2l6ZQ0KPj4NCj4+IElzIHRoaXMgc2VyaWVzIHdvcnRoIHJldml2aW5n
IGFzIGEgdjIsIGFzIGl0IHNvbHZlcyBhIGNvcm5lci1jYXNlIGJ1Zz8NCj4+DQo+Pg0KPiANCj4g
WWVzLCBidXQgSUlSQyB0aGVyZSB3ZXJlIHNvbWUgZGlzYWdyZWVtZW50cyBhYm91dCB0aGUgbWV0
aG9kb2xvZ3kgZm9yDQo+IHRoZSBmaXgsIGJ1dCBjYW4ndCByZWNhbGwgZXhhY3RseSB3aGF0IHJp
Z2h0IG5vdy4NCj4gDQo+IFRoZSB3YXkgSSByZW1lbWJlciBpdCBpcyB0aGF0IEkgd2FudGVkIHRv
IG1ha2Ugb3VyIHFjb3cyIGZ1bmN0aW9ucyBtb3JlDQo+IGxpa2UgImRvX3N0b3JlX2JpdG1hcCIg
YW5kICJkb19yZW1vdmVfYml0bWFwIiBmb3IgZGlyZWN0IGFkZGl0aW9uIGFuZA0KPiByZW1vdmFs
IGFzIEkgZmluZCB0aGF0IGNvbmNlcHR1YWwgbW9kZWwgJ3NpbXBsZXInLg0KPiANCj4gKEkgdGhp
bmsgaXQgaGFkIHNvbWV0aGluZyB0byBkbyB3aXRoIGFkZGl0aW9uYWwgY29tcGxleGl0aWVzIGlu
IHRoZQ0KPiBkaWZmZXJlbnQgY29udGV4dHMgdGhhdCBsaXN0X2xvYWQgaXMgdXNlZCBpbiBmb3Ig
d2hlbiBhbmQgaWYgaXQgcGVyZm9ybXMNCj4gY2VydGFpbiBjb25zaXN0ZW5jeSBjaGVja3MuLi4/
KQ0KPiANCj4gSSB0aGluayBWbGFkaW1pciB3YW50ZWQgdG8gdXNlIGEgcGVuZGluZy1mbHVzaCBz
dHlsZSBjYWNoZSB0byBjaGVjaw0KPiByZXF1aXJlbWVudHMgYWdhaW5zdCBpbnN0ZWFkIG9mIGFj
dHVhbCB3cml0ZXMuDQo+IA0KDQpBY3R1YWxseSwgaGVyZSBpcyBteSBjb3VudGVyLXByb3Bvc2Fs
Og0KDQpbUEFUQ0hdIHFjb3cyLWJpdG1hcHM6IGZpeCBxY293Ml9jYW5fc3RvcmVfbmV3X2RpcnR5
X2JpdG1hcA0KICAgICA8MjAxOTA2MDcxODQ4MDIuMTAwOTQ1LTEtdnNlbWVudHNvdkB2aXJ0dW96
em8uY29tPg0KICAgICBodHRwczovL2xpc3RzLmdudS5vcmcvYXJjaGl2ZS9odG1sL3FlbXUtZGV2
ZWwvMjAxOS0wNi9tc2cwMTY5Ni5odG1sDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1p
cg0K

