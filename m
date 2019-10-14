Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D709DC4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 08:52:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90FC720673
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 08:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ACh+PPJI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90FC720673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJw5W-00069I-OY
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 04:52:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56656)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iJw4n-0005hk-FD
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 04:51:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iJw4m-0004FT-0L
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 04:51:37 -0400
Received: from mail-eopbgr80113.outbound.protection.outlook.com
 ([40.107.8.113]:39392 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iJw4l-0004DD-1j
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 04:51:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e3QEShOHjSLSWshcZp0/y9r8JMnH9GQ1DcwvsIAE+387E3emAtA2UQHf1uA0HOEVyy+MRqE25LVo47G0ssB1D+v3sctLIqDPwiYyqduYgbc0q6+v5nz9kjyqsR+8oMB5bnUA08BDwOe5ZOQ6OxGfBW8zolQ4L5QvHB+cAPnf6Q7eJzG0Z+LnRkY9x1cJmtA+wggCzhNMi8ZvSDkOWcixfRpLpWzgN/StjJD40vPsScPcprAi2J1u0NNrpkwT8Z459Y10Ju3SgfWYto+FTWl3EDSavfe+FH81lPRefxMlm26pOl0XxQkScQbxOdd4FZ6wj0jnd6vb/Z8TX3J0iafF2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0jg3au4OzJGOOvHUEroixRHN3zZdukOSnkzMqM7w2wE=;
 b=R3VEI52AzGAg9zHi77jNpB1QWxdG2i8mT/VGS/33rAQilsM5QAkREsyh7/y0ADTa9u3JuoNcPgAHFapDNp2ojROQYVrWydDK/hth5xZjS7RXrE+I1ckiZNZLcawf8nv5DD/gb8eKh3Uw0EOC9rKl1jXaYXEeBMam1cL4GecQP9CDhcU/lcqBbB3+5iE0K490jjzsIJTE0JplqLIVuUL6wnHX6aSh9Gy4RbCS19bw/RrPF7nz8g4+4aRb2YnUSzju+W8VhjycWjpSPPobgEIboiGnNo+DMeM275FhIq+lQmQ2AkhQQ2hTNeWVPa6v84NhSVbzjMNUljYanabPI6bXlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0jg3au4OzJGOOvHUEroixRHN3zZdukOSnkzMqM7w2wE=;
 b=ACh+PPJIrzb68J9jvO/CHfLz669UBTHDeYUBfmqtRvGC5H3K2qxebmfVeoo+tXXKvmJ4Ooj/KFfVE15vaH5dJKTdi/Gh/Dv1VHf4mxYW3T2cj7I7LasnS6yPmcYdjkFn25ttKxOkLjHDh5DQhWsyxibrOmSejTuIkeMMMJEddOA=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5307.eurprd08.prod.outlook.com (52.133.240.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.22; Mon, 14 Oct 2019 08:51:31 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f%2]) with mapi id 15.20.2347.021; Mon, 14 Oct 2019
 08:51:31 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: [RFC v5 027/126] misc: introduce ERRP_AUTO_PROPAGATE
Thread-Topic: [RFC v5 027/126] misc: introduce ERRP_AUTO_PROPAGATE
Thread-Index: AQHVgE3MwsunpbMo3kS8rjV4k3AYhqdVx1UAgAQRMoA=
Date: Mon, 14 Oct 2019 08:51:31 +0000
Message-ID: <9212d7cc-3f62-382d-55a0-42ed26eb7e29@virtuozzo.com>
References: <20191011160552.22907-1-vsementsov@virtuozzo.com>
 <20191011160552.22907-28-vsementsov@virtuozzo.com>
 <632cfeaf-52cd-829a-2f49-b7302f558a3a@redhat.com>
In-Reply-To: <632cfeaf-52cd-829a-2f49-b7302f558a3a@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR07CA0023.eurprd07.prod.outlook.com
 (2603:10a6:7:67::33) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191014115129363
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b1b2923c-7787-474b-a07f-08d75083b593
x-ms-traffictypediagnostic: DB8PR08MB5307:
x-microsoft-antispam-prvs: <DB8PR08MB53073FBC1585F926B9116556C1900@DB8PR08MB5307.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:243;
x-forefront-prvs: 01901B3451
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(979002)(136003)(396003)(366004)(39840400004)(376002)(346002)(189003)(199004)(11346002)(25786009)(486006)(446003)(476003)(2616005)(71200400001)(66066001)(86362001)(99286004)(66446008)(64756008)(66476007)(66946007)(66556008)(31686004)(71190400001)(256004)(36756003)(14444005)(6116002)(3846002)(53546011)(6506007)(386003)(5660300002)(4326008)(305945005)(14454004)(2906002)(6436002)(26005)(478600001)(102836004)(54906003)(110136005)(31696002)(186003)(7736002)(316002)(2501003)(229853002)(6246003)(8676002)(8936002)(76176011)(6512007)(6486002)(81166006)(81156014)(52116002)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5307;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z3ajVsOjFMN6NN9K6X2U/9XAIUog3IPc4NCrSirUJemO85XP1ZADzh3xwPcy3hJqUStJsjyoNNOwXbsNl4BcBPZMtUQGwjgiFS656mhgrYHYCgk2M1N/dy/Pxw2tJLAAw0Efo/dypDqJmYzbR09nex2SKHrVakFIzj4WSiZAjZTG7xr3zuQo2gYV55znaErb8nrnzgvy1hiZcv/Q+diMd8iRVa+C53GvRdNzwLx/slcqO+tsqqlM+cqgg0C60uQyu2yKObXY5Asik442i5hmC7yv0GjY7GJHEEZToGjM3hEfWyBM/aKPzluM3o2wMx4rInhk2cwomMHf5Q7/pJYwox/2ykaO2x/LdJEa240U9Fcrc9o8hreoFvivylSZZQE+aCt5VJP1xvQ+NRWnWE5h/o9p3ZemAqRj0pjj3YlUang=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E88290DC678532469632B9E84FA0D1D3@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1b2923c-7787-474b-a07f-08d75083b593
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2019 08:51:31.5274 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9sozd8V3TnfqYfl5nYiHNU/WnaWrtkVeP4uaXw4waW52rpLxz80lScZvlOA+u891G34oTBWy1EddyFNqqjWDj4SbuutTusIFpxOXkyxOozs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5307
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.8.113
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
Cc: Kevin Wolf <kwolf@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>,
 Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTEuMTAuMjAxOSAyMTo0NCwgRXJpYyBCbGFrZSB3cm90ZToNCj4gT24gMTAvMTEvMTkgMTE6MDQg
QU0sIFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgd3JvdGU6DQo+PiBJZiB3ZSB3YW50IHRv
IGFkZCBzb21lIGluZm8gdG8gZXJycCAoYnkgZXJyb3JfcHJlcGVuZCgpIG9yDQo+PiBlcnJvcl9h
cHBlbmRfaGludCgpKSwgd2UgbXVzdCB1c2UgdGhlIEVSUlBfQVVUT19QUk9QQUdBVEUgbWFjcm8u
DQo+PiBPdGhlcndpc2UsIHRoaXMgaW5mbyB3aWxsIG5vdCBiZSBhZGRlZCB3aGVuIGVycnAgPT0g
JmZhdGFsX2Vycg0KPj4gKHRoZSBwcm9ncmFtIHdpbGwgZXhpdCBwcmlvciB0byB0aGUgZXJyb3Jf
YXBwZW5kX2hpbnQoKSBvcg0KPj4gZXJyb3JfcHJlcGVuZCgpIGNhbGwpLsKgIEZpeCBzdWNoIGNh
c2VzLg0KPj4NCj4+IElmIHdlIHdhbnQgdG8gY2hlY2sgZXJyb3IgYWZ0ZXIgZXJycC1mdW5jdGlv
biBjYWxsLCB3ZSBuZWVkIHRvDQo+PiBpbnRyb2R1Y2UgbG9jYWxfZXJyIGFuZCB0aGFuIHByb3Bh
Z2F0ZSBpdCB0byBlcnJwLiBJbnN0ZWFkLCB1c2UNCj4+IEVSUlBfQVVUT19QUk9QQUdBVEUgbWFj
cm8sIGJlbmVmaXRzIGFyZToNCj4+IDEuIE5vIG5lZWQgb2YgZXhwbGljaXQgZXJyb3JfcHJvcGFn
YXRlIGNhbGwNCj4+IDIuIE5vIG5lZWQgb2YgZXhwbGljaXQgbG9jYWxfZXJyIHZhcmlhYmxlOiB1
c2UgZXJycCBkaXJlY3RseQ0KPj4gMy4gRVJSUF9BVVRPX1BST1BBR0FURSBsZWF2ZXMgZXJycCBh
cyBpcyBpZiBpdCdzIG5vdCBOVUxMIG9yDQo+PiDCoMKgwqAgJmVycm9yX2ZhdGVsLCB0aGlzIG1l
YW5zIHRoYXQgd2UgZG9uJ3QgYnJlYWsgZXJyb3JfYWJvcnQNCj4+IMKgwqDCoCAod2UnbGwgYWJv
cnQgb24gZXJyb3Jfc2V0LCBub3Qgb24gZXJyb3JfcHJvcGFnYXRlKQ0KPj4NCj4+IFRoaXMgY29t
bWl0ICh0b2dldGhlciB3aXRoIGl0cyBuZWlnaGJvcnMpIHdhcyBnZW5lcmF0ZWQgYnkNCj4+DQo+
PiBmb3IgZiBpbiAkKGdpdCBncmVwIC1sIGVycnAgXCouW2NoXSk7IGRvIFwNCj4+IMKgwqDCoMKg
IHNwYXRjaCAtLXNwLWZpbGUgc2NyaXB0cy9jb2NjaW5lbGxlL2F1dG8tcHJvcGFnYXRlZC1lcnJw
LmNvY2NpIFwNCj4+IMKgwqDCoMKgIC0tbWFjcm8tZmlsZSBzY3JpcHRzL2NvY2NpLW1hY3JvLWZp
bGUuaCAtLWluLXBsYWNlIC0tbm8tc2hvdy1kaWZmICRmOyBcDQo+PiBkb25lOw0KPj4NCj4+IHRo
ZW4gZml4IGEgYml0IG9mIGNvbXBpbGF0aW9uIHByb2JsZW1zOiBjb2NjaW5lbGxlIGZvciBzb21l
IHJlYXNvbg0KPj4gbGVhdmVzIHNldmVyYWwNCj4+IGYoKSB7DQo+PiDCoMKgwqDCoCAuLi4NCj4+
IMKgwqDCoMKgIGdvdG8gb3V0Ow0KPj4gwqDCoMKgwqAgLi4uDQo+PiDCoMKgwqDCoCBvdXQ6DQo+
PiB9DQo+PiBwYXR0ZXJucywgd2l0aCAib3V0OiIgYXQgZnVuY3Rpb24gZW5kLg0KPiANCj4gV2Fz
IHRoYXQgc3RpbGwgaGFwcGVuaW5nIGV2ZW4gYWZ0ZXIgeW91ciB0d2Vha3MgdG8gdGhlIC5jb2Nj
aSBzY3JpcHQ/DQoNClllcywgc2VlbSBjb2NjaW5lbGxhIHN1Y2Nlc2Z1bGx5IHJlbW92ZXMNCg0K
b3V0Og0KZXJyb3JfcHJhcGFnYXRlDQoNCnBhdHRlcm4gaW4gZ2VuZXJhbCwgYnV0IGZhaWxzIHRv
IHdvcmsgaWYgdGhlcmUgaXMgYWRkaXRpb25hbCAicmV0dXJuOyIgOg0KDQpyZXR1cm47DQpvdXQ6
DQplcnJvcl9wcm9hcGFnYXRlDQoNCj4gQnV0IG1hbnVhbCB0b3VjaC11cCBhZnRlciBjb2NjaSBp
cyBub3QgdW5oZWFyZCBvZiwgc28gaXQgaXMgbm90IGEgc2hvd3N0b3BwZXIgdG8gdGhlIHNlcmll
cy7CoCBTdGlsbCwgaXQgbWlnaHQgYmUgbmljZXIgaWYgdGhpcyBkaXNjbGFpbWVyIG9ubHkgYXBw
ZWFycyBvbiB0aGUgcGF0Y2hlcyB3aXRoaW4gdGhlIHNlcmllcyB3aGVyZSBpdCBhY3R1YWxseSBt
YXR0ZXJzLCByYXRoZXIgdGhhbiBvbiBldmVyeSBtZXNzYWdlIGluIHRoZSBzZXJpZXMgZXZlbiB3
aGVuIG5vIHR3ZWFrcyB3ZXJlIG5lZWRlZCAoYXMgdGhpcyBwYXRjaCBpcyBhbiBleGFtcGxlIHdo
ZXJlIHRoZSB0b3VjaHVwIHdhcyBub3QgbmVlZGVkKS4NCg0KSG1tLi4gTm90IHN1cmUuIEkgdGhp
bmsgaXQncyBnb29kIHRvIGhhdmUgaW4gZWFjaCBjb21taXQgYW4gaW5zdHJ1Y3Rpb24gaG93IHRv
IGdlbmVyYXRlIHRoZSB3aG9sZSBzZXF1ZW5jZS4gU3RpbGwsIHdoYXQgeW91IHdhbnQgaXMgbm90
IGRpZmZpY3VsdDoganVzdCBpbnN0ZWFkIG9mIGZpeGluZyBhbGwgY29tcGlsYXRpb24gZXJyb3Jz
IGF0IG9uY2UsIGNvbW1pdCB0aGUgY2hhbmdlcyBhbmQgdGhhbiBwbGF5IHdpdGggZ2l0IHJlYmFz
ZSAteCAnbWFrZSAtajknLg0KDQo+IA0KPj4NCj4+IHRoZW4NCj4+IC4vcHl0aG9uL2NvbW1pdC1w
ZXItc3Vic3lzdGVtLnB5IE1BSU5UQUlORVJTICIkKDwgYXV0by1tc2cpIg0KPj4NCj4gDQo+IElm
IHdlIGRvbid0IGNoZWNrIHRoZSBweXRob24gc2NyaXB0IGludG8gZ2l0LCB0aGVuIGNoYW5naW5n
IHRoaXMgdG8gYSBVUkwgdG8gb25lIG9mIHRoZSB0aHJlYWRzIHdoZXJlIHlvdSBwb3N0ZWQgdGhl
IHNjcmlwdCBpbiBhbiBlYXJsaWVyIHZlcnNpb24gb2YgdGhlIHBhdGNoIGlzIGFsc28gYWNjZXB0
YWJsZS4NCj4gDQo+PiAoYXV0by1tc2cgd2FzIGEgZmlsZSB3aXRoIHRoaXMgY29tbWl0IG1lc3Nh
Z2UpDQo+Pg0KPj4gU3RpbGwsIGZvciBiYWNrcG9ydGluZyBpdCBtYXkgYmUgbW9yZSBjb21mb3J0
YWJsZSB0byB1c2Ugb25seSB0aGUgZmlyc3QNCj4+IGNvbW1hbmQgYW5kIHRoZW4gZG8gb25lIGh1
Z2UgY29tbWl0Lg0KPj4NCj4+IFJlcG9ydGVkLWJ5OiBLZXZpbiBXb2xmIDxrd29sZkByZWRoYXQu
Y29tPg0KPj4gUmVwb3J0ZWQtYnk6IEdyZWcgS3VyeiA8Z3JvdWdAa2FvZC5vcmc+DQo+PiBTaWdu
ZWQtb2ZmLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1
b3p6by5jb20+DQo+PiAtLS0NCj4+IMKgIGh3L21pc2MvaXZzaG1lbS5jIHwgMzcgKysrKysrKysr
KysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPj4gwqAgaHcvbWlzYy90bXAxMDUuY8KgIHzC
oCA3ICsrKy0tLS0NCj4+IMKgIGh3L21pc2MvdG1wNDIxLmPCoCB8wqAgNyArKystLS0tDQo+PiDC
oCAzIGZpbGVzIGNoYW5nZWQsIDIyIGluc2VydGlvbnMoKyksIDI5IGRlbGV0aW9ucygtKQ0KPj4N
Cj4gDQo+PiBAQCAtODY0LDYgKzg1OCw3IEBAIHN0YXRpYyB2b2lkIGl2c2htZW1fd3JpdGVfY29u
ZmlnKFBDSURldmljZSAqcGRldiwgdWludDMyX3QgYWRkcmVzcywNCj4+IMKgIHN0YXRpYyB2b2lk
IGl2c2htZW1fY29tbW9uX3JlYWxpemUoUENJRGV2aWNlICpkZXYsIEVycm9yICoqZXJycCkNCj4+
IMKgIHsNCj4+ICvCoMKgwqAgRVJSUF9BVVRPX1BST1BBR0FURSgpOw0KPj4gwqDCoMKgwqDCoCBJ
VlNobWVtU3RhdGUgKnMgPSBJVlNITUVNX0NPTU1PTihkZXYpOw0KPj4gwqDCoMKgwqDCoCBFcnJv
ciAqZXJyID0gTlVMTDsNCj4gDQo+IFVtbSwgc28gd2h5IGRpZCBDb2NjaW5lbGxlIG5vdCByZW1v
dmUgdGhpcyBsaW5lLCBvciByZXRvdWNoIGxvd2VyIGRvd24gYXQ6DQo+IA0KPiAgwqDCoMKgIGlm
ICghaXZzaG1lbV9pc19tYXN0ZXIocykpIHsNCj4gIMKgwqDCoMKgwqDCoMKgIGVycm9yX3NldGco
JnMtPm1pZ3JhdGlvbl9ibG9ja2VyLA0KPiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgICJNaWdyYXRpb24gaXMgZGlzYWJsZWQgd2hlbiB1c2luZyBmZWF0dXJlICdwZWVyIG1v
ZGUnIGluIGRldmkNCj4gY2UgJ2l2c2htZW0nIik7DQo+ICDCoMKgwqDCoMKgwqDCoCBtaWdyYXRl
X2FkZF9ibG9ja2VyKHMtPm1pZ3JhdGlvbl9ibG9ja2VyLCAmbG9jYWxfZXJyKTsNCj4gIMKgwqDC
oMKgwqDCoMKgIGlmIChsb2NhbF9lcnIpIHsNCj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZXJy
b3JfcHJvcGFnYXRlKGVycnAsIGxvY2FsX2Vycik7DQo+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGVycm9yX2ZyZWUocy0+bWlncmF0aW9uX2Jsb2NrZXIpOw0KPiAgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCByZXR1cm47DQo+ICDCoMKgwqDCoMKgwqDCoCB9DQo+ICDCoMKgwqAgfQ0KPiANCj4gDQo+
IEJ1dCB0aGUgY29udmVyc2lvbnMgdGhhdCBDb2NjaW5lbGxlIG1hZGUgbG9vayBjb3JyZWN0Lg0K
PiANCg0KSG1tbS4gc3RyYW5nZS4gU28gaXQgZG9lcyBub3RoaW5nLCBleGNlcHQgYWRkIGEgbWFj
cm8gaW52b2NhdGlvbj8NCg0KSW50ZXJzdGluZzogaWYgSSBjb21tZW50IGRlZmluaXRpb24gZm9y
IGxvY2FsX2VyciwgaXQgY29ycmVjdGx5IHVwZGF0ZXMgY29kZSBhcm91bmQgZXJyLA0KaWYgSSBj
b21tZW50IGRlZmluaXRpb24gZm9yIGVyciwgaXQgY29ycmVjdGx5IHVwZGF0ZXMgY29kZSBhcm91
bmQgbG9jYWxfZXJyLg0KDQpTbywgcnVsZTAgd29ya3MsIGJ1dCBydWxlMSBkb24ndCBrbm93IHdo
YXQgdG8gZG8gd2l0aCB0d28gRXJyb3IgKiB2YXJpYWJsZXMuDQoNClNlZW1zLCBzaW1wbGVzdCB0
aGluZyBpcyB0byBwcmUtcmVmYWN0b3IgaXQsIHRvIGRyb3AgbG9jYWxfZXJyIHZhcmlhYmxlLg0K
DQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

