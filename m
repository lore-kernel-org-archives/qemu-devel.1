Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0087AC43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 17:00:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C02D52054F
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 17:00:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="FbudMoyq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C02D52054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53194 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfSKB-00021z-W9
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 13:00:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38763)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hfSG5-0007Ly-4k
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 12:55:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hfSG3-0001za-NW
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 12:55:57 -0400
Received: from mail-eopbgr80091.outbound.protection.outlook.com
 ([40.107.8.91]:44455 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1hfSG0-0001tS-GL; Mon, 24 Jun 2019 12:55:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JDiugAW1gFOMwUp2knStIUfB+uzfsVcIpCJJ1rUkf+k=;
 b=FbudMoyq3smrEheN96ReKUpND+TOkZ+ej4yjWB0TCUa3+IaJO4PKp03I9rtz7pc/LUKsBtxO1gkFPrRj3utaUJphLQZCGRRcjFClPuAHnO4o/KH9BKQM+SfsSHwCxVUzEOq7lQ+xisWtmBkltG7euSiU3fBeku7/XS0sbeHsLBY=
Received: from VI1PR08MB3677.eurprd08.prod.outlook.com (20.177.61.92) by
 VI1PR08MB3167.eurprd08.prod.outlook.com (52.133.15.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.15; Mon, 24 Jun 2019 16:55:50 +0000
Received: from VI1PR08MB3677.eurprd08.prod.outlook.com
 ([fe80::4c71:9c23:235b:fbed]) by VI1PR08MB3677.eurprd08.prod.outlook.com
 ([fe80::4c71:9c23:235b:fbed%3]) with mapi id 15.20.2008.014; Mon, 24 Jun 2019
 16:55:50 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v2 7/7] iotests: new file to suppress Valgrind errors
Thread-Index: AQHVIH/WtZ37DP0CJEiTLkjzsZK8gqaZXjmAgBG8HwA=
Date: Mon, 24 Jun 2019 16:55:50 +0000
Message-ID: <5b57cb61-7eef-b89e-7ea7-053e65c9f227@virtuozzo.com>
References: <1560276131-683243-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1560276131-683243-8-git-send-email-andrey.shinkevich@virtuozzo.com>
 <dc4ae7d2-64bf-ab12-4712-5752f848b5dd@virtuozzo.com>
In-Reply-To: <dc4ae7d2-64bf-ab12-4712-5752f848b5dd@virtuozzo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P190CA0043.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:52::32)
 To VI1PR08MB3677.eurprd08.prod.outlook.com
 (2603:10a6:803:85::28)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 239055ce-ce4f-489e-a694-08d6f8c4cfcd
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:VI1PR08MB3167; 
x-ms-traffictypediagnostic: VI1PR08MB3167:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR08MB31679B891AAACE364C2437B4F4E00@VI1PR08MB3167.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 007814487B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(39850400004)(376002)(346002)(136003)(366004)(199004)(189003)(6436002)(11346002)(66946007)(53936002)(186003)(8936002)(53546011)(316002)(102836004)(7736002)(256004)(107886003)(305945005)(68736007)(6506007)(110136005)(31686004)(6246003)(6116002)(3846002)(478600001)(76176011)(99286004)(52116002)(66066001)(2906002)(476003)(25786009)(14454004)(64756008)(229853002)(66446008)(4326008)(386003)(73956011)(86362001)(486006)(66556008)(2616005)(66476007)(446003)(44832011)(54906003)(14444005)(6486002)(26005)(71200400001)(81166006)(36756003)(2201001)(6306002)(31696002)(5660300002)(81156014)(6512007)(8676002)(2501003)(71190400001)(2004002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB3167;
 H:VI1PR08MB3677.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: im1Wi3jvc6392IHu2wAJzwRDaEnalQyQ1LuUPN0KOH9YAm71Zlj5zaEOz1Izl0KxoVwJ1xYV89d/+1CTvkwi5t0WpKKhoK7tRL3uMp4ryIOrQTBY03h/LZTD9YVIa+qVONUfLeha1T7LGgKcpV+FU0ZBFS3g6cyYC7w6o2MKuqCpRHLmndjmiHoWNuyUV5vci3s9B/TuARbviHJBuMDWFHZ2NpMV03Rvf2bVh/qQ7ShnnXZgojunbIrTXZ/99o6TOpDzrljPyhv0subNjoNf/KXtOQFum3P3wUIJkmQcM4NnfP7jlNOkl6je7EJcDj+tEu6eR+vJcJ1nVDd/ipiJTfJGgP3AQJ+2eTBLQh2WIVmAlf9RIlOpJW1Scuas24t2SwihXBjaPfuQ0Oomndj7C5LqFnQSJj0e0z5cJ9kNx6I=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1A7FC620D604A14688ECBB26818F7D1E@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 239055ce-ce4f-489e-a694-08d6f8c4cfcd
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2019 16:55:50.6331 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: andrey.shinkevich@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3167
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.8.91
Subject: Re: [Qemu-devel] [PATCH v2 7/7] iotests: new file to suppress
 Valgrind errors
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Roman Kagan <rkagan@virtuozzo.com>,
 "berrange@redhat.com" <berrange@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDEzLzA2LzIwMTkgMTM6MDYsIFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgd3Jv
dGU6DQo+IDExLjA2LjIwMTkgMjE6MDIsIEFuZHJleSBTaGlua2V2aWNoIHdyb3RlOg0KPj4gVGhl
IFZhbGdyaW5kIHRvb2wgcmVwb3J0cyBhYm91dCBhbiB1bmluaXRpYWxpc2VkIG1lbW9yeSB1c2Fn
ZSB3aGVuIHRoZQ0KPj4gaW5pdGlhbGl6YXRpb24gaXMgYWN0dWFsbHkgbm90IG5lZWRlZC4gRm9y
IGV4YW1wbGUsIHRoZSBidWZmZXIgJ2J1ZicNCj4+IGluc3RhbnRpYXRlZCBvbiBhIHN0YWNrIG9m
IHRoZSBmdW5jdGlvbiBndWVzc19kaXNrX2xjaHMoKS4NCj4gDQo+IGZvciBjb252aW5pZW5jZSwg
eW91IG1heSBhZGQ6ICJvZiB0aGUgZnVuY3Rpb24gZ3Vlc3NfZGlza19sY2hzKCksIHdoaWNoDQo+
IGlzIHRoZW4gYWN0dWFsbHkgaW5pdGlhbGl6ZWQgYnkgYmxrX3ByZWFkX3VudGhyb3R0bGVkKCki
DQo+IA0KPj4gTGV0J3MgdXNlIHRoZSBWYWxncmluZCB0ZWNobm9sb2d5IHRvIHN1cHByZXNzIHRo
ZSB1bndhbnRlZCByZXBvcnRzIGJ5DQo+PiBhZGRpbmcgdGhlIFZhbGdyaW5kIHNwZWNpZmljIGZv
cm1hdCBmaWxlIHZhbGdyaW5kLnN1cHAgdG8gdGhlIFFFTVUNCj4+IHByb2plY3QuIFRoZSBmaWxl
IGNvbnRlbnQgaXMgZXh0ZW5kYWJsZSBmb3IgZnV0dXJlIG5lZWRzLg0KPj4NCj4+IFNpZ25lZC1v
ZmYtYnk6IEFuZHJleSBTaGlua2V2aWNoIDxhbmRyZXkuc2hpbmtldmljaEB2aXJ0dW96em8uY29t
Pg0KPj4gLS0tDQo+PiAgICB0ZXN0cy9xZW11LWlvdGVzdHMvY29tbW9uLnJjICAgICB8ICA1ICsr
KystDQo+PiAgICB0ZXN0cy9xZW11LWlvdGVzdHMvdmFsZ3JpbmQuc3VwcCB8IDMxICsrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysNCj4+ICAgIDIgZmlsZXMgY2hhbmdlZCwgMzUgaW5zZXJ0
aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPj4gICAgY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RzL3Fl
bXUtaW90ZXN0cy92YWxncmluZC5zdXBwDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL3Rlc3RzL3FlbXUt
aW90ZXN0cy9jb21tb24ucmMgYi90ZXN0cy9xZW11LWlvdGVzdHMvY29tbW9uLnJjDQo+PiBpbmRl
eCAzY2FhY2E0Li45Yjc0ODkwIDEwMDY0NA0KPj4gLS0tIGEvdGVzdHMvcWVtdS1pb3Rlc3RzL2Nv
bW1vbi5yYw0KPj4gKysrIGIvdGVzdHMvcWVtdS1pb3Rlc3RzL2NvbW1vbi5yYw0KPj4gQEAgLTE3
LDYgKzE3LDggQEANCj4+ICAgICMgYWxvbmcgd2l0aCB0aGlzIHByb2dyYW0uICBJZiBub3QsIHNl
ZSA8aHR0cDovL3d3dy5nbnUub3JnL2xpY2Vuc2VzLz4uDQo+PiAgICAjDQo+PiAgICANCj4+ICty
ZWFkb25seSBWQUxHUklORF9TVVBQUkVTU19FUlJPUlM9Li92YWxncmluZC5zdXBwDQo+IA0KPiBX
aHkgcmVhZG9ubHk/DQo+IA0KPiBJIHRoaW5rIGl0IHNob3VsZCBiZSBkZWZpbmVkIG5lYXIgYW5k
IGluIHNhbWUgbWFubmVyIGFzIFZBTEdSSU5EX0xPR0ZJTEUsDQo+IHdpdGggdXNlIG9mIFRFU1Rf
RElSDQo+IA0KDQpUaGUgbmV3IGZpbGUgJ3ZhbGdyaW5kLnN1cHAnIGlzIGludGVuZGVkIHRvIGJl
IGEgcGFydCBvZiB0aGUgUUVNVSANCnByb2plY3QuIFNvLCBpdCB3aWxsIGJlIGxvY2F0ZWQgaW4g
dGhlIHRlc3QgZGlyZWN0b3J5IHRlc3RzL3FlbXUtaW90ZXN0cy4NClRoZSB2YXJpYWJsZSBURVNU
X0RJUiBtYXkgY2hhbmdlIHRoZSB3b3JraW5nIGRpcmVjdG9yeS4gSW4gdGhhdCBjYXNlLCANCm1v
dmluZyB0aGUgcHJvamVjdCBmaWxlIHdpbGwgYmUgYSBoYXNzbGUuDQoNCkFuZHJleQ0KDQo+PiAr
DQo+PiAgICBTRUQ9DQo+PiAgICBmb3Igc2VkIGluIHNlZCBnc2VkOyBkbw0KPj4gICAgICAgICgk
c2VkIC0tdmVyc2lvbiB8IGdyZXAgJ0dOVSBzZWQnKSA+IC9kZXYvbnVsbCAyPiYxDQo+PiBAQCAt
NjUsNyArNjcsOCBAQCBfcWVtdV9wcm9jX3dyYXBwZXIoKQ0KPj4gICAgICAgIGxvY2FsIFZBTEdS
SU5EX0xPR0ZJTEU9IiQxIg0KPj4gICAgICAgIHNoaWZ0DQo+PiAgICAgICAgaWYgWyAiJHtWQUxH
UklORF9RRU1VfSIgPT0gInkiIF07IHRoZW4NCj4+IC0gICAgICAgIGV4ZWMgdmFsZ3JpbmQgLS1s
b2ctZmlsZT0iJHtWQUxHUklORF9MT0dGSUxFfSIgLS1lcnJvci1leGl0Y29kZT05OSAiJEAiDQo+
PiArICAgICAgICBleGVjIHZhbGdyaW5kIC0tbG9nLWZpbGU9IiR7VkFMR1JJTkRfTE9HRklMRX0i
IC0tZXJyb3ItZXhpdGNvZGU9OTkgXA0KPj4gKyAgICAgICAgICAgIC0tc3VwcHJlc3Npb25zPSIk
e1ZBTEdSSU5EX1NVUFBSRVNTX0VSUk9SU30iICIkQCINCj4+ICAgICAgICBlbHNlDQo+PiAgICAg
ICAgICAgIGV4ZWMgIiRAIg0KPj4gICAgICAgIGZpDQo+PiBkaWZmIC0tZ2l0IGEvdGVzdHMvcWVt
dS1pb3Rlc3RzL3ZhbGdyaW5kLnN1cHAgYi90ZXN0cy9xZW11LWlvdGVzdHMvdmFsZ3JpbmQuc3Vw
cA0KPj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4+IGluZGV4IDAwMDAwMDAuLjc4MjE1YjYNCj4+
IC0tLSAvZGV2L251bGwNCj4+ICsrKyBiL3Rlc3RzL3FlbXUtaW90ZXN0cy92YWxncmluZC5zdXBw
DQo+PiBAQCAtMCwwICsxLDMxIEBADQo+PiArIw0KPj4gKyMgVmFsZ3JpbmQgZXJyb3JzIHN1cHBy
ZXNzaW9uIGZpbGUgZm9yIFFFTVUgaW90ZXN0cw0KPj4gKyMNCj4+ICsjIENvcHlyaWdodCAoYykg
MjAxOSBWaXJ0dW96em8gSW50ZXJuYXRpb25hbCBHbWJIDQo+PiArIw0KPj4gKyMgVGhpcyBwcm9n
cmFtIGlzIGZyZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBtb2Rp
ZnkNCj4+ICsjIGl0IHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExp
Y2Vuc2UgYXMgcHVibGlzaGVkIGJ5DQo+PiArIyB0aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9u
OyBlaXRoZXIgdmVyc2lvbiAyIG9mIHRoZSBMaWNlbnNlLCBvcg0KPj4gKyMgKGF0IHlvdXIgb3B0
aW9uKSBhbnkgbGF0ZXIgdmVyc2lvbi4NCj4+ICsjDQo+PiArIyBUaGlzIHByb2dyYW0gaXMgZGlz
dHJpYnV0ZWQgaW4gdGhlIGhvcGUgdGhhdCBpdCB3aWxsIGJlIHVzZWZ1bCwNCj4+ICsjIGJ1dCBX
SVRIT1VUIEFOWSBXQVJSQU5UWTsgd2l0aG91dCBldmVuIHRoZSBpbXBsaWVkIHdhcnJhbnR5IG9m
DQo+PiArIyBNRVJDSEFOVEFCSUxJVFkgb3IgRklUTkVTUyBGT1IgQSBQQVJUSUNVTEFSIFBVUlBP
U0UuICBTZWUgdGhlDQo+PiArIyBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBmb3IgbW9yZSBk
ZXRhaWxzLg0KPj4gKyMNCj4+ICsjIFlvdSBzaG91bGQgaGF2ZSByZWNlaXZlZCBhIGNvcHkgb2Yg
dGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlDQo+PiArIyBhbG9uZyB3aXRoIHRoaXMgcHJv
Z3JhbS4gIElmIG5vdCwgc2VlIDxodHRwOi8vd3d3LmdudS5vcmcvbGljZW5zZXMvPi4NCj4+ICsj
DQo+PiArew0KPj4gKyAgIGh3L2Jsb2NrL2hkLWdlb21ldHJ5LmMNCj4+ICsgICBNZW1jaGVjazpD
b25kDQo+PiArICAgZnVuOmd1ZXNzX2Rpc2tfbGNocw0KPj4gKyAgIGZ1bjpoZF9nZW9tZXRyeV9n
dWVzcw0KPj4gKyAgIGZ1bjpibGtjb25mX2dlb21ldHJ5DQo+PiArICAgLi4uDQo+PiArICAgZnVu
OmRldmljZV9zZXRfcmVhbGl6ZWQNCj4+ICsgICBmdW46cHJvcGVydHlfc2V0X2Jvb2wNCj4+ICsg
ICBmdW46b2JqZWN0X3Byb3BlcnR5X3NldA0KPj4gKyAgIGZ1bjpvYmplY3RfcHJvcGVydHlfc2V0
X3FvYmplY3QNCj4+ICsgICBmdW46b2JqZWN0X3Byb3BlcnR5X3NldF9ib29sDQo+PiArfQ0KPj4N
Cj4gDQo+IA0KDQotLSANCldpdGggdGhlIGJlc3QgcmVnYXJkcywNCkFuZHJleSBTaGlua2V2aWNo
DQo=

