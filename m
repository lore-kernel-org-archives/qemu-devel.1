Return-Path: <SRS0=VlUQ=WG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD18FC32751
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 12:55:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 731472166E
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 12:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="IVuy9ya2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 731472166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwQuG-00011K-MY
	for qemu-devel@archiver.kernel.org; Sat, 10 Aug 2019 08:55:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57308)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hwQtb-0000QH-5F
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 08:54:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hwQtZ-0005ad-VR
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 08:54:55 -0400
Received: from mail-eopbgr80129.outbound.protection.outlook.com
 ([40.107.8.129]:27423 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hwQtZ-0005a1-Ad; Sat, 10 Aug 2019 08:54:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RsHg9kGzUI6hQGuVMBB0qu6OYJw0/uIzFUgIk6Sho3skXrEqOSDhYln7vEgRH+JIL+N8GQRmCpMntuwEF9gDAKSuPo9pZIwe1L4C5+VnOoHlAxu8pgH5JtakHJnMpFozJEEb9yjgCZ1QW0oYvAxWgs9G22hH4IbCD4JX0xGPbIjhJneOg+F1Y3IzgM8VC7GMxtPNSKzHKofB8ys4UlPW3A+pdvu0eVpOa7TpIknaKnukNBJLcUqegXH6/4Oj3xG7KbhXAl1uSEq8DMyNOgXiGMaP0fNkc2otbhwKAgZewjn0lpNKdYBoPh4gqWTPcIOFXvCYMRgyVxqJfJD5EmhKrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9W9vw+E6wpCaD+9M+KAUSZ4DZ/rd1z+TMRb/LyRlc18=;
 b=HwBUsUXPOQ89wpt5625he2EHx3SUZLaRb93ZBxXQw80kqNql/77ZBqww0uwFXjdzEMhMIykmI2Cc52IbeoKcLrpIYiqeXY3ooSjVUAYkbyG9xOE4I6tEQRMMIntE2ojbzRk1QuLdBF3YNRgPNtQdWZ5X6jvy4dsKnbi2Tfu0aycDVmeXjpP5C2zU7/ZMmbeuKsbGSnurKXf+w2lL/DEZ+SwwQCmAXJXnRPFU7Vn29GTWeEY0hXrHQIi89GBb1ajz7uuQy3xN6280zsftL/Iihsy3EN404MXvPMaiZNeQ1jYPHqQXfll6WcVL43QQFQQPa8yoY+4M2g2z6MOAiHdYxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9W9vw+E6wpCaD+9M+KAUSZ4DZ/rd1z+TMRb/LyRlc18=;
 b=IVuy9ya2ewvVmQbW8n3rOh7P5WNobnF7w1GlOj3zfjxhpat6vYc5PRLIUgws5uF/c4Cwa/U3pY1Pw+ri6IvPsMMI/y+qUo5WSBcGgmmk+weGW3HKSinXQiZnDpj0rBFoWfy1OBbJUndpaBQHjyBjuMAZzuuwXe+qfntsquC/W5M=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4571.eurprd08.prod.outlook.com (20.179.11.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.21; Sat, 10 Aug 2019 12:54:49 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2157.021; Sat, 10 Aug 2019
 12:54:49 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH v2 6/7] block/backup: teach
 backup_cow_with_bounce_buffer to copy more at once
Thread-Index: AQHVTsegHdnYpu5qx0+85E1DXrVPQ6by+WeAgAFSwoCAAAnYgIAAAgOA
Date: Sat, 10 Aug 2019 12:54:49 +0000
Message-ID: <7f498ccd-efb5-ea20-6bb7-854f2207bb50@virtuozzo.com>
References: <20190809153207.49288-1-vsementsov@virtuozzo.com>
 <20190809153207.49288-7-vsementsov@virtuozzo.com>
 <62bca2ef-d175-6926-e1e8-5edfc08d58ab@redhat.com>
 <04e9f57a-4137-eed8-5005-f4fb26b71c47@virtuozzo.com>
 <f5c3b9ff-5efd-d637-1be1-20f284088d8c@redhat.com>
In-Reply-To: <f5c3b9ff-5efd-d637-1be1-20f284088d8c@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR09CA0066.eurprd09.prod.outlook.com
 (2603:10a6:7:3c::34) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190810155447006
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4ca0c58b-5b49-4b59-93d1-08d71d91edfc
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:DB8PR08MB4571; 
x-ms-traffictypediagnostic: DB8PR08MB4571:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB4571D372F46365D6B9980DBBC1D10@DB8PR08MB4571.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-forefront-prvs: 012570D5A0
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(39850400004)(366004)(376002)(136003)(396003)(189003)(199004)(305945005)(2501003)(8676002)(7736002)(5660300002)(386003)(6506007)(53546011)(31696002)(102836004)(66446008)(64756008)(66556008)(66476007)(66946007)(26005)(81156014)(81166006)(186003)(14444005)(31686004)(256004)(11346002)(446003)(486006)(476003)(3846002)(6116002)(478600001)(2616005)(36756003)(71190400001)(71200400001)(316002)(4326008)(6486002)(6436002)(110136005)(54906003)(14454004)(6246003)(2906002)(25786009)(66066001)(53936002)(966005)(229853002)(8936002)(86362001)(52116002)(76176011)(6306002)(99286004)(6512007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4571;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: dszgq3zudQa+jp6v4j4/ZqV8zRIx3rGheUJjkzKm2orUpe9D3mjYJGzJZRszWTQR9q8KO8ghjYZWyyB0nm0IOwG4/RHPmvMrEPkhls2smGjNaktvbXaYsgxvJnbN50kh8P2OEqSV8cqPDPD92Oq5xzs4KBjhk/tHlNPZln5dbxh4bLZ2wPl9JcAwHWDyRxOzdVpQ3IyhUGpSfsMhdgOKOem3YnEqY6/S1tI1UHLX3eNE61hW5isCO/hhZ6OMRYAR0zPOpoMMPgsi4vQPtuGsT9Qj4oFiZZK48AxVxfz8MkONq+HLBTmF/Ausyv04jvKS56Gbbbfa4ZcW4+oWYX9mT8tfrAsLOVvaFvvuk3nKnJncmbSeP8vWqy+usRxARpGbKlFiZNFqVHq4GN4BOhLhtoqB3/0HytbGkJQBEjveuck=
Content-Type: text/plain; charset="utf-8"
Content-ID: <62FB0692DF468142BE1092D2D487D98B@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ca0c58b-5b49-4b59-93d1-08d71d91edfc
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2019 12:54:49.8252 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7R4ibIlQatwRP8dbkTDFWV0ITxy9ne0/Ii8oaEuSlhNVtpRiIK3BHDYSMIgUXbya67cwyrAAPajNkyLiaNA27AR5425b5DDsrLDjXB+egN4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4571
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.8.129
Subject: Re: [Qemu-devel] [PATCH v2 6/7] block/backup: teach
 backup_cow_with_bounce_buffer to copy more at once
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
Cc: "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
 Denis Lunev <den@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTAuMDguMjAxOSAxNTo0NywgRXJpYyBCbGFrZSB3cm90ZToNCj4gT24gOC8xMC8xOSA3OjEyIEFN
LCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdyb3RlOg0KPj4gMDkuMDguMjAxOSAxODo1
OSwgRXJpYyBCbGFrZSB3cm90ZToNCj4+PiBPbiA4LzkvMTkgMTA6MzIgQU0sIFZsYWRpbWlyIFNl
bWVudHNvdi1PZ2lldnNraXkgd3JvdGU6DQo+Pj4+IGJhY2t1cF9jb3dfd2l0aF9vZmZsb2FkIGNh
biB0cmFuc2ZlciBtb3JlIHRoYW4gb24gY2x1c3Rlci4gTGV0DQo+Pj4NCj4+PiBzL29uL29uZS8N
Cj4+Pg0KPj4+PiBiYWNrdXBfY293X3dpdGhfYm91bmNlX2J1ZmZlciBiZWhhdmUgc2ltaWxhcmx5
LiBJdCByZWR1Y2VzIG51bWJlcg0KPj4+PiBvZiBJTyBhbmQgdGhlcmUgYXJlIG5vIG5lZWRzIHRv
IGNvcHkgY2x1c3RlciBieSBjbHVzdGVyLg0KPj4+DQo+Pj4gSXQgcmVkdWNlcyB0aGUgbnVtYmVy
IG9mIElPIHJlcXVlc3RzLCBzaW5jZSB0aGVyZSBpcyBubyBuZWVkIHRvIGNvcHkNCj4+PiBjbHVz
dGVyIGJ5IGNsdXN0ZXIuDQo+IA0KPj4+PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgYm9vbCAqZXJyb3JfaXNfcmVhZCwNCj4+Pj4gLSAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZvaWQgKipi
b3VuY2VfYnVmZmVyKQ0KPj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgYm9vbCAqZXJyb3JfaXNfcmVhZCkNCj4+Pg0KPj4+IFdoeSBpcyB0
aGlzIHNpZ25hdHVyZSBjaGFuZ2luZz8NCj4+Pg0KPiANCj4+DQo+PiAyLiBBY3R1YWxseSBpdCBp
cyBhIHF1ZXN0aW9uIGFib3V0IG1lbW9yeSBhbGxvY2F0b3I6IGlzIGl0IGZhc3QgYW5kIG9wdGlt
aXplZA0KPj4gZW5vdWdoIHRvIG5vdCBjYXJlLCBvciBpcyBpdCBiYWQsIGFuZCB3ZSBzaG91bGQg
d29yay1hcm91bmQgaXQgbGlrZSBpbg0KPj4gbWlycm9yPyBBbmQgaW4gbXkgb3BpbmlvbiAocHJv
dmVkIGJ5IGEgYml0IG9mIGJlbmNobWFya2luZykgbWVtYWxpZ24NCj4+IGlzIGZhc3QgZW5vdWdo
IHRvIGRvbid0IGNhcmUuIEkgd2FzIGFuc3dlcmluZyBzaW1pbGFyIHF1ZXN0aW9uIGluIG1vcmUg
ZGV0YWlscw0KPj4gYW5kIHdpdGggc29tZSBudW1iZXJzIGhlcmU6DQo+PiBodHRwczovL2xpc3Rz
LmdudS5vcmcvYXJjaGl2ZS9odG1sL3FlbXUtZGV2ZWwvMjAxOC0xMS9tc2cwMDA4Ny5odG1sDQo+
Pg0KPj4gU28sIEknZCBwcmVmZXJlIHRvIG5vdCBjYXJlIGFuZCBrZWVwIGNvZGUgc2ltcGxlci4g
QnV0IGlmIHlvdSBkb24ndCBhZ3JlZSwNCj4+IEkgY2FuIGxlYXZlIHNoYXJlZCBidWZmZXIgaGVy
ZSwgYXQgbGVhc3QgdW50aWwgaW50cm9kdWN0aW9uIG9mIHBhcmFsbGVsIHJlcXVlc3RzLg0KPj4g
VGhlbiwgaXQgd2lsbCBiZSBzb21ldGhpbmcgbGlrZSBxZW11X3RyeV9ibG9ja2FsaWduKE1JTihi
eXRlcywgNjRNKSkuLg0KPiANCj4gSXQgbWF5IHN0aWxsIGJlIHdvcnRoIGNhcHBpbmcgYXQgNjRN
LiAgSSdtIG5vdCBvcHBvc2VkIHRvIGEgY2hhbmdlIHRvDQo+IHBlci1yZXF1ZXN0IGFsbG9jYXRp
b24gcmF0aGVyIHRoYW4gdHJ5aW5nIHRvIHJldXNlIGEgYnVmZmVyLCBpZiBpdCBpcw0KPiBnb2lu
ZyB0byBtYWtlIHBhcmFsbGVsaXphdGlvbiBlZmZvcnRzIGVhc2llcjsgYnV0IEkgYW0gd29ycmll
ZCBhYm91dCB0aGUNCj4gbWF4aW11bSBtZW1vcnkgdXNhZ2UuICBJJ20gbW9yZSB3b3JyaWVkIHRo
YXQgeW91IGFyZSB0cnlpbmcgdG8gY3JhbSB0d28NCj4gZGlzdGluY3QgY2hhbmdlcyBpbnRvIG9u
ZSBwYXRjaCwgYW5kIGRpZG4ndCBldmVuIG1lbnRpb24gdGhlIGNoYW5nZQ0KPiBhYm91dCBhIGNo
YW5nZSBmcm9tIGJ1ZmZlciByZXVzZSB0byBwZXItcmVxdWVzdCBhbGxvY2F0aW9ucywgaW4gdGhl
DQo+IGNvbW1pdCBtZXNzYWdlLiAgSWYgeW91IG1ha2UgdGhhdCBzb3J0IG9mIGNoYW5nZSwgaXQg
c2hvdWxkIGJlIGNhbGxlZA0KPiBvdXQgaW4gdGhlIGNvbW1pdCBtZXNzYWdlIGFzIGludGVudGlv
bmFsLCBvciBtYXliZSBldmVuIHNwbGl0IHRvIGENCj4gc2VwYXJhdGUgcGF0Y2guDQo+IA0KDQpP
SywgSSBmYWlsZWQgdG8gaGlkZSBpdCA6KSBXaWxsIHNwbGl0IG91dCBhbmQgYWRkIDY0TSBsaW1p
dC4NCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

