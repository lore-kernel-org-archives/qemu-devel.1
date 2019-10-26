Return-Path: <SRS0=l02z=YT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A3ACA9EB9
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 17:53:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73EA42084C
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 17:53:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="GxRils4p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73EA42084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOQG5-0001p3-M6
	for qemu-devel@archiver.kernel.org; Sat, 26 Oct 2019 13:53:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39258)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iOQFA-00006I-87
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 13:52:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iOQF7-0000zz-WF
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 13:52:51 -0400
Received: from mail-eopbgr40107.outbound.protection.outlook.com
 ([40.107.4.107]:37883 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iOQF7-0000za-19; Sat, 26 Oct 2019 13:52:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YpSYNM9KsWdT5CZvPC54wWbPfrbTJQ8f0oPsqs8x+ehi8kOli7Dz5PAyaFCHLji4KktcqhI8ABdGUisrgTLmvqbKVAeFyWJMXhT2tWU7eF347Aolutm4zHZ9E4IQo2xsVcEXhy+Ewc92hQmInAcT06aPJi2cJ5kbvJ9GqCK7tCCabFMIonhuZKtMUs9I6Y0GhwqKcv2wm9K2g24e6jOGEHuNwKrAzTUH4JNFOJhDAG3UGu2kGt/jKuKlV5QwxZCQfj22jmepUp9FakPPUmssntkytprtqlJDld7cqASoueaWpVRoM/caXeVZHJVC5h+aUlq/CJ5Zf/94KDOtHNamCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3wpwzb7kPKGTOFAnwASHAQVF9xI8AArX66fXdItbzhM=;
 b=gyAIISeZOMzrecROt/C1frLAAdDxIYu6YdG89/mwS+I03Z1e0O3yGo3yfciR8Fl9UDYbk81JkC9sGlTQuV6UjQjrYKSuuhgg4YOpabsNo1BTGXjKlrpKBrsJtMb1l+Dt5v7wtG8IlDeOdz7rnUSSls+c8hq7c7wgJRsjqHuiTG28CHNmcdoeTncTQdP37UTLxuj5mK05ZHtxZFQk0DPhAyCarbhea5aVZYzTNrij8HiwmAdcn5hkyL/93TRR0/2jXiuaVX0qagVO366akf7WFCiWSthqz80ivgJhGa8DENQJfKb+9VxEXLSkX21OIZ67AlhTPBEtt9YemRJfzDL+hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3wpwzb7kPKGTOFAnwASHAQVF9xI8AArX66fXdItbzhM=;
 b=GxRils4pgnBnYCmgvXL9QitNAwI3L1xLwKK8sC4a65jre3LdfdAu2Clz/DnF2enVPvi6HPkigcdFBEeXKvSZndUVzwWHcrmoWj798YkoQ14L3PfEbyqf/bMW0wmnZLKFkq4nbVwFs+pxNm4adWyTGV95w07xJerE/IlBmNABL8I=
Received: from AM0PR08MB4435.eurprd08.prod.outlook.com (20.179.35.83) by
 AM0PR08MB4275.eurprd08.prod.outlook.com (20.179.34.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.22; Sat, 26 Oct 2019 17:52:45 +0000
Received: from AM0PR08MB4435.eurprd08.prod.outlook.com
 ([fe80::dc12:c5b5:bd8e:f402]) by AM0PR08MB4435.eurprd08.prod.outlook.com
 ([fe80::dc12:c5b5:bd8e:f402%4]) with mapi id 15.20.2387.025; Sat, 26 Oct 2019
 17:52:45 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Nir Soffer <nsoffer@redhat.com>, Max Reitz <mreitz@redhat.com>
Subject: Re: [RFC 0/3] block/file-posix: Work around XFS bug
Thread-Topic: [RFC 0/3] block/file-posix: Work around XFS bug
Thread-Index: AQHVixrVzIJNY5LqnE6V3J8eZcL1nqdtMdKAgAAETgA=
Date: Sat, 26 Oct 2019 17:52:45 +0000
Message-ID: <314c504d-5560-3770-766f-ab7bfa9a37d0@virtuozzo.com>
References: <20191025095849.25283-1-mreitz@redhat.com>
 <CAMRbyyuMyyMp0HT2Kmdwj4svKLAmk4_Lryagx8XowRJ1T3xjcg@mail.gmail.com>
In-Reply-To: <CAMRbyyuMyyMp0HT2Kmdwj4svKLAmk4_Lryagx8XowRJ1T3xjcg@mail.gmail.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR08CA0044.eurprd08.prod.outlook.com
 (2603:10a6:7:2a::15) To AM0PR08MB4435.eurprd08.prod.outlook.com
 (2603:10a6:208:144::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191026205244067
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 410b2524-1e17-4a2b-82d8-08d75a3d4eb4
x-ms-traffictypediagnostic: AM0PR08MB4275:
x-ms-exchange-purlcount: 3
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR08MB4275000A3ADA7FB6DE5DE2DDC1640@AM0PR08MB4275.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0202D21D2F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(396003)(346002)(136003)(366004)(39840400004)(199004)(189003)(66446008)(66556008)(64756008)(66476007)(52116002)(36756003)(476003)(486006)(25786009)(86362001)(31686004)(26005)(6436002)(76176011)(81166006)(14454004)(81156014)(6486002)(229853002)(7736002)(66946007)(5660300002)(305945005)(6306002)(6512007)(8936002)(446003)(11346002)(2616005)(99286004)(8676002)(966005)(31696002)(186003)(71190400001)(102836004)(66066001)(14444005)(71200400001)(256004)(54906003)(110136005)(478600001)(316002)(3846002)(386003)(6116002)(4326008)(2906002)(6506007)(53546011)(6246003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB4275;
 H:AM0PR08MB4435.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6O3O6TLBtWmW1BzsMjb+o+GAECcIkMzxWewYMs72Ey0wycZjQtPt1mx3zr5Ab0iOHFii/FJ/T1EsMsVCP7Na+maAJDA+osrw/3+45zyFStPpQshK0JajOfbRGwU2wU1usAEGCklS+n5JUHzVM5pazk+zlVNudqinvQEMLVzdj6XafL4OXXWXF2W99/xL2CenYm/RJqh7hhsbKi9M9vjIUxjt7rgxSnJza5thifpPLcGaTl3XL/ZEh1QOw8yQRAaowl78h26jkhfnx1v3SxdKTlUpuiuLYuyxGAEPieFlvc3Wt0nKFnyIcQ4m/oSUMw0CRJdmz0+T02l/NhBBeaXLF9YR/a4BX4KLoh5gBxX/AKk+GDuvjAUDuhcXxBgl8avW8K0poKhSvtqm2zXqgIM7ceVFZ4idD8tTpbrSZpWmj9OUsafnt3qEGRZhyHpIxh/WbGsoY9bW3xQtooqrqpnXC1seK1+SGlzURES6VnTF0Tk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <87E4D756BF3328418C06B214E88433B1@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 410b2524-1e17-4a2b-82d8-08d75a3d4eb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2019 17:52:45.7911 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: goP1QadQfAJwiYhu0QKsOFgTJJzBVE/NrQIPWp0fUL1NqLwZwFEp/j+JIjhNXYEp3M+vWoWBKqlXkZSeYmcnJRI0p2vvsVnl+2stRYdp6/M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4275
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.4.107
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 Alberto Garcia <berto@igalia.com>, qemu-block <qemu-block@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjYuMTAuMjAxOSAyMDozNywgTmlyIFNvZmZlciB3cm90ZToNCj4gT24gRnJpLCBPY3QgMjUsIDIw
MTkgYXQgMToxMSBQTSBNYXggUmVpdHogPG1yZWl0ekByZWRoYXQuY29tPiB3cm90ZToNCj4+DQo+
PiBIaSwNCj4+DQo+PiBJdCBzZWVtcyB0byBtZSB0aGF0IHRoZXJlIGlzIGEgYnVnIGluIExpbnV4
4oCZcyBYRlMga2VybmVsIGRyaXZlciwgYXMNCj4+IEnigJl2ZSBleHBsYWluZWQgaGVyZToNCj4+
DQo+PiBodHRwczovL2xpc3RzLm5vbmdudS5vcmcvYXJjaGl2ZS9odG1sL3FlbXUtYmxvY2svMjAx
OS0xMC9tc2cwMTQyOS5odG1sDQo+Pg0KPj4gSW4gY29tYmluYXRpb24gd2l0aCBvdXIgY29tbWl0
IGM4YmIyM2NiZGJlMzJmLCB0aGlzIG1heSBsZWFkIHRvIGd1ZXN0DQo+PiBkYXRhIGNvcnJ1cHRp
b24gd2hlbiB1c2luZyBxY293MiBpbWFnZXMgb24gWEZTIHdpdGggYWlvPW5hdGl2ZS4NCj4+DQo+
PiBXZSBjYW7igJl0IHdhaXQgdW50aWwgdGhlIFhGUyBrZXJuZWwgZHJpdmVyIGlzIGZpeGVkLCB3
ZSBzaG91bGQgd29yaw0KPj4gYXJvdW5kIHRoZSBwcm9ibGVtIG91cnNlbHZlcy4NCj4+DQo+PiBU
aGlzIGlzIGFuIFJGQyBmb3IgdHdvIHJlYXNvbnM6DQo+PiAoMSkgSSBkb27igJl0IGtub3cgd2hl
dGhlciB0aGlzIGlzIHRoZSByaWdodCB3YXkgdG8gYWRkcmVzcyB0aGUgaXNzdWUsDQo+PiAoMikg
SWRlYWxseSwgd2Ugc2hvdWxkIGRldGVjdCB3aGV0aGVyIHRoZSBYRlMga2VybmVsIGRyaXZlciBp
cyBmaXhlZCBhbmQNCj4+ICAgICAgaWYgc28gc3RvcCBhcHBseWluZyB0aGUgd29ya2Fyb3VuZC4N
Cj4+ICAgICAgSSBkb27igJl0IGtub3cgaG93IHdlIHdvdWxkIGdvIGFib3V0IHRoaXMsIHNvIHRo
aXMgc2VyaWVzIGRvZXNu4oCZdCBkbw0KPj4gICAgICBpdC4gIChIZW5jZSBpdOKAmXMgYW4gUkZD
LikNCj4+ICgzKSBQZXJoYXBzIGl04oCZcyBhIGJpdCBvZiBhIGxheWVyaW5nIHZpb2xhdGlvbiB0
byBsZXQgdGhlIGZpbGUtcG9zaXgNCj4+ICAgICAgZHJpdmVyIGFjY2VzcyBhbmQgbW9kaWZ5IGEg
QmRydlRyYWNrZWRSZXF1ZXN0IG9iamVjdC4NCj4+DQo+PiBBcyBmb3IgaG93IHdlIGNhbiBhZGRy
ZXNzIHRoZSBpc3N1ZSwgSSBzZWUgdGhyZWUgd2F5czoNCj4+ICgxKSBUaGUgb25lIHByZXNlbnRl
ZCBpbiB0aGlzIHNlcmllczogT24gWEZTIHdpdGggYWlvPW5hdGl2ZSwgd2UgZXh0ZW5kDQo+PiAg
ICAgIHRyYWNrZWQgcmVxdWVzdHMgZm9yIHBvc3QtRU9GIGZhbGxvY2F0ZSgpIGNhbGxzIChpLmUu
LCB3cml0ZS16ZXJvDQo+PiAgICAgIG9wZXJhdGlvbnMpIHRvIHJlYWNoIHVudGlsIGluZmluaXR5
IChJTlQ2NF9NQVggaW4gcHJhY3RpY2UpLCBtYXJrDQo+PiAgICAgIHRoZW0gc2VyaWFsaXppbmcg
YW5kIHdhaXQgZm9yIG90aGVyIGNvbmZsaWN0aW5nIHJlcXVlc3RzLg0KPj4NCj4+ICAgICAgQWR2
YW50YWdlczoNCj4+ICAgICAgKyBMaW1pdHMgdGhlIGltcGFjdCB0byB2ZXJ5IHNwZWNpZmljIGNh
c2VzDQo+PiAgICAgICAgKEFuZCB0aGF0IG1lYW5zIGl0IHdvdWxkbuKAmXQgaHVydCB0b28gbXVj
aCB0byBrZWVwIHRoaXMgd29ya2Fyb3VuZA0KPj4gICAgICAgIGV2ZW4gd2hlbiB0aGUgWEZTIGRy
aXZlciBoYXMgYmVlbiBmaXhlZCkNCj4+ICAgICAgKyBXb3JrcyBhcm91bmQgdGhlIGJ1ZyB3aGVy
ZSBpdCBoYXBwZW5zLCBuYW1lbHkgaW4gZmlsZS1wb3NpeA0KPj4NCj4+ICAgICAgRGlzYWR2YW50
YWdlczoNCj4+ICAgICAgLSBBIGJpdCBjb21wbGV4DQo+PiAgICAgIC0gQSBiaXQgb2YgYSBsYXll
cmluZyB2aW9sYXRpb24gKHNob3VsZCBmaWxlLXBvc2l4IGhhdmUgYWNjZXNzIHRvDQo+PiAgICAg
ICAgdHJhY2tlZCByZXF1ZXN0cz8pDQo+Pg0KPj4gKDIpIEFsd2F5cyBza2lwIHFjb3cy4oCZcyBo
YW5kbGVfYWxsb2Nfc3BhY2UoKSBvbiBYRlMuICBUaGUgWEZTIGJ1ZyBvbmx5DQo+PiAgICAgIGJl
Y29tZXMgdmlzaWJsZSBkdWUgdG8gdGhhdCBmdW5jdGlvbjogSSBkb27igJl0IHRoaW5rIHFjb3cy
IHdyaXRlcw0KPj4gICAgICB6ZXJvZXMgaW4gYW55IG90aGVyIEkvTyBwYXRoLCBhbmQgcmF3IGlt
YWdlcyBhcmUgZml4ZWQgaW4gc2l6ZSBzbw0KPj4gICAgICBwb3N0LUVPRiB3cml0ZXMgd29u4oCZ
dCBoYXBwZW4uDQo+Pg0KPj4gICAgICBBZHZhbnRhZ2VzOg0KPj4gICAgICArIE1heWJlIHNpbXBs
ZXIsIGRlcGVuZGluZyBvbiBob3cgZGlmZmljdWx0IGl0IGlzIHRvIGhhbmRsZSB0aGUNCj4+ICAg
ICAgICBsYXllcmluZyB2aW9sYXRpb24NCj4+ICAgICAgKyBBbHNvIGZpeGVzIHRoZSBwZXJmb3Jt
YW5jZSBwcm9ibGVtIG9mIGhhbmRsZV9hbGxvY19zcGFjZSgpIGJlaW5nDQo+PiAgICAgICAgc2xv
dyBvbiBwcGM2NCtYRlMuDQo+Pg0KPj4gICAgICBEaXNhZHZhbnRhZ2VzOg0KPj4gICAgICAtIEh1
Z2UgbGF5ZXJpbmcgdmlvbGF0aW9uIGJlY2F1c2UgcWNvdzIgd291bGQgbmVlZCB0byBrbm93IHdo
ZXRoZXINCj4+ICAgICAgICB0aGUgaW1hZ2UgaXMgc3RvcmVkIG9uIFhGUyBvciBub3QuDQo+PiAg
ICAgIC0gV2XigJlkIGRlZmluaXRlbHkgd2FudCB0byBza2lwIHRoaXMgd29ya2Fyb3VuZCB3aGVu
IHRoZSBYRlMgZHJpdmVyDQo+PiAgICAgICAgaGFzIGJlZW4gZml4ZWQsIHNvIHdlIG5lZWQgc29t
ZSBtZXRob2QgdG8gZmluZCBvdXQgd2hldGhlciBpdCBoYXMNCj4+DQo+PiAoMykgRHJvcCBoYW5k
bGVfYWxsb2Nfc3BhY2UoKSwgaS5lLiByZXZlcnQgYzhiYjIzY2JkYmUzMmYuDQo+PiAgICAgIFRv
IG15IGtub3dsZWRnZSBJ4oCZbSB0aGUgb25seSBvbmUgd2hvIGhhcyBwcm92aWRlZCBhbnkgYmVu
Y2htYXJrcyBmb3INCj4+ICAgICAgdGhpcyBjb21taXQsIGFuZCBldmVuIHRoZW4gSSB3YXMgYSBi
aXQgc2tlcHRpY2FsIGJlY2F1c2UgaXQgcGVyZm9ybXMNCj4+ICAgICAgd2VsbCBpbiBzb21lIGNh
c2VzIGFuZCBiYWQgaW4gb3RoZXJzLiAgSSBjb25jbHVkZWQgdGhhdCBpdOKAmXMNCj4+ICAgICAg
cHJvYmFibHkgd29ydGggaXQgYmVjYXVzZSB0aGUg4oCcc29tZSBjYXNlc+KAnSBhcmUgbW9yZSBs
aWtlbHkgdG8gb2NjdXIuDQo+Pg0KPj4gICAgICBOb3cgd2UgaGF2ZSB0aGlzIHByb2JsZW0gb2Yg
Y29ycnVwdGlvbiBoZXJlIChncmFudGVkIGR1ZSB0byBhIGJ1ZyBpbg0KPj4gICAgICB0aGUgWEZT
IGRyaXZlciksIGFuZCBhbm90aGVyIHJlcG9ydCBvZiBtYXNzaXZlbHkgZGVncmFkZWQNCj4+ICAg
ICAgcGVyZm9ybWFuY2Ugb24gcHBjNjQNCj4+ICAgICAgKGh0dHBzOi8vYnVnemlsbGEucmVkaGF0
LmNvbS9zaG93X2J1Zy5jZ2k/aWQ9MTc0NTgyMyDigJMgc29ycnksIGENCj4+ICAgICAgcHJpdmF0
ZSBCWjsgSSBoYXRlIHRoYXQgOi0vICBUaGUgcmVwb3J0IGlzIGFib3V0IDQwICUgd29yc2UNCj4+
ICAgICAgcGVyZm9ybWFuY2UgZm9yIGFuIGluLWd1ZXN0IGZpbyB3cml0ZSBiZW5jaG1hcmsuKQ0K
Pj4NCj4+ICAgICAgU28gSSBoYXZlIHRvIGFzayB0aGUgcXVlc3Rpb24gYWJvdXQgd2hhdCB0aGUg
anVzdGlmaWNhdGlvbiBmb3INCj4+ICAgICAga2VlcGluZyBjOGJiMjNjYmRiZTMyZiBpcy4gIEhv
dyBtdWNoIGRvZXMgcGVyZm9ybWFuY2UgaW5jcmVhc2Ugd2l0aA0KPj4gICAgICBpdCBhY3R1YWxs
eT8gIChPbiBub24tKHBwYzY0K1hGUykgbWFjaGluZXMsIG9idmlvdXNseSkNCj4+DQo+PiAgICAg
IEFkdmFudGFnZXM6DQo+PiAgICAgICsgVHJpdmlhbA0KPj4gICAgICArIE5vIGxheWVyaW5nIHZp
b2xhdGlvbnMNCj4+ICAgICAgKyBXZSB3b3VsZG7igJl0IG5lZWQgdG8ga2VlcCB0cmFjayBvZiB3
aGV0aGVyIHRoZSBrZXJuZWwgYnVnIGhhcyBiZWVuDQo+PiAgICAgICAgZml4ZWQgb3Igbm90DQo+
PiAgICAgICsgRml4ZXMgdGhlIHBwYzY0K1hGUyBwZXJmb3JtYW5jZSBwcm9ibGVtDQo+Pg0KPj4g
ICAgICBEaXNhZHZhbnRhZ2VzOg0KPj4gICAgICAtIFJldmVydHMgY2x1c3RlciBhbGxvY2F0aW9u
IHBlcmZvcm1hbmNlIHRvIHByZS1jOGJiMjNjYmRiZTMyZg0KPj4gICAgICAgIGxldmVscywgd2hh
dGV2ZXIgdGhhdCBtZWFucw0KPiANCj4gQ29ycmVjdG5lc3MgaXMgbW9yZSBpbXBvcnRhbnQgdGhh
biBwZXJmb3JtYW5jZSwgc28gdGhpcyBpcyBteQ0KPiBwcmVmZXJlbmNlIGFzIGEgdXNlci4NCj4g
DQoNCkhtbSwgc3RpbGwsIGluY29ycmVjdCBpcyBYRlMsIG5vdCBRZW11LiBUaGlzIGJ1ZyBtYXkg
YmUgdHJpZ2dlcmVkIGJ5IGFub3RoZXINCnNvZnR3YXJlLCBvciBtYXkgYmUgYW5vdGhlciBzY2Vu
YXJpbyBpbiBRZW11IChub3Qgc3VyZSkuDQoNCj4gDQo+PiBTbyB0aGlzIGlzIHRoZSBtYWluIHJl
YXNvbiB0aGlzIGlzIGFuIFJGQzogV2hhdCBzaG91bGQgd2UgZG8/ICBJcyAoMSkNCj4+IHJlYWxs
eSB0aGUgYmVzdCBjaG9pY2U/DQo+Pg0KPj4NCj4+IEluIGFueSBjYXNlLCBJ4oCZdmUgcmFuIHRo
ZSB0ZXN0IGNhc2UgSSBzaG93ZWQgaW4NCj4+IGh0dHBzOi8vbGlzdHMubm9uZ251Lm9yZy9hcmNo
aXZlL2h0bWwvcWVtdS1ibG9jay8yMDE5LTEwL21zZzAxMjgyLmh0bWwNCj4+IG1vcmUgdGhhbiB0
ZW4gdGltZXMgd2l0aCB0aGlzIHNlcmllcyBhcHBsaWVkIGFuZCB0aGUgaW5zdGFsbGF0aW9uDQo+
PiBzdWNjZWVkZWQgZXZlcnkgdGltZS4gIChXaXRob3V0IHRoaXMgc2VyaWVzLCBpdCBmYWlscyBs
aWtlIGV2ZXJ5IG90aGVyDQo+PiB0aW1lLikNCj4+DQo+Pg0KPj4gTWF4IFJlaXR6ICgzKToNCj4+
ICAgIGJsb2NrOiBNYWtlIHdhaXQvbWFyayBzZXJpYWxpc2luZyByZXF1ZXN0cyBwdWJsaWMNCj4+
ICAgIGJsb2NrL2ZpbGUtcG9zaXg6IERldGVjdCBYRlMgd2l0aCBDT05GSUdfRkFMTE9DQVRFDQo+
PiAgICBibG9jay9maWxlLXBvc2l4OiBMZXQgcG9zdC1FT0YgZmFsbG9jYXRlIHNlcmlhbGl6ZQ0K
Pj4NCj4+ICAgaW5jbHVkZS9ibG9jay9ibG9ja19pbnQuaCB8ICAzICsrKw0KPj4gICBibG9jay9m
aWxlLXBvc2l4LmMgICAgICAgIHwgNDYgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKy0tDQo+PiAgIGJsb2NrL2lvLmMgICAgICAgICAgICAgICAgfCAyNCArKysrKysrKysrLS0t
LS0tLS0tLQ0KPj4gICAzIGZpbGVzIGNoYW5nZWQsIDU5IGluc2VydGlvbnMoKyksIDE0IGRlbGV0
aW9ucygtKQ0KPj4NCj4+IC0tDQo+PiAyLjIxLjANCj4+DQo+Pg0KDQoNCi0tIA0KQmVzdCByZWdh
cmRzLA0KVmxhZGltaXINCg==

