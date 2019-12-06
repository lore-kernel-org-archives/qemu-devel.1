Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28190C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 14:23:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D52C720659
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 14:23:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="qlZuAPzu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D52C720659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idEWH-0000kv-Fy
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 09:23:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49154)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1idELt-0007OR-IN
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:13:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1idELq-0006iK-Pt
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:13:01 -0500
Received: from mail-eopbgr50137.outbound.protection.outlook.com
 ([40.107.5.137]:16526 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1idELm-0006Yr-Rj; Fri, 06 Dec 2019 09:12:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Or5Qqv8+l4B0qbKNjpsg1Q4O142e+b61Rb5qU6fQ/OWbxTou4RVoJjJWmzD8C4tlvjk6sBxOJaVpCA/6E+Pa08WPoqjshGlgJLMuzmVUGvBWJJtxnzz5nMMGitWAcal/Ru2k3aw5KSgzTcqke2L4qIFDGp+KVBNQCto8+9yV2WZd59+LUPiCbct/Pp83y+FhIAIttRzdNhxVpc+nsAM618o9HAzM3qV0yYNx1Gi0LRgGioW2FWQXLXnmDkPLoAPKvrym4sIE4DwtHAKw2UHqSIBKR3ODt0bpsBd4GQW3oi5kqzaIN4QVgD5QWcj5Ce5L28rER6CvSwV6QhiR9bRXZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=drgn9f3uaxgVtVUcV0//YY9VAISERZo/3rfxEUqBgGo=;
 b=gHiyv3Of7b3JOaBj4D8QjCq9VzKVHUxQICNMVmN5AEj7Exk+kbqS/RA17ez1nZbO1wvxhEItZM+5RJzszJYDLXIvUdPkb8hW1CI9N+Zjt/pLAe73YbnKqTUcZCNC5Fyvkf8H1V6lEkOK2nc4twr14aKzlfmi1teBx1eGIJ3c2BLt6EKjx551z4Pl2PcvYS8eV0QR8lQ5BGROcCzzIqaV8KhAp+uhKLusLHRJz+bVASFTqN46yCtTcQTu48O3qJrPNc6//Zc0NgGfI0t+dqyQABN07Z44htyeuVBo/NTJPYttniIyN0koONOAy41rQ0YF0gYpdWynmFVEzc9VM4Gkhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=drgn9f3uaxgVtVUcV0//YY9VAISERZo/3rfxEUqBgGo=;
 b=qlZuAPzu21CHgQL3Hwf4rt/4O6P8A7RFFHEb99Og8wduW+3/wOzM34lXiynYQmLvzvgHFED5OsHRwFquivsxhR9aR9VDzq3wnGeCSWsyeb1XJAtp8JauHgxHGlUF2K6XUrJJsPu1c4iivZj7CcWA2Ffh7WQnnEiXMkWOCAlmgdE=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3622.eurprd08.prod.outlook.com (20.177.115.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.21; Fri, 6 Dec 2019 10:26:53 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2516.014; Fri, 6 Dec 2019
 10:26:53 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v7 21/21] nbd: assert that Error** is not NULL in
 nbd_iter_channel_error
Thread-Topic: [PATCH v7 21/21] nbd: assert that Error** is not NULL in
 nbd_iter_channel_error
Thread-Index: AQHVq3+LSA8OoYLZZUia0++YbcEGYaerx+kAgAAG74CAAP+xCYAAGdCA
Date: Fri, 6 Dec 2019 10:26:53 +0000
Message-ID: <3f464bd4-abce-ae85-3bce-2da6311328ef@virtuozzo.com>
References: <20191205152019.8454-1-vsementsov@virtuozzo.com>
 <20191205152019.8454-22-vsementsov@virtuozzo.com>
 <c4ff448d-e756-9d95-b07e-4ae5f2d5b9b0@redhat.com>
 <93046486-1580-14a1-520d-08abdf74da0e@virtuozzo.com>
 <87sglxltqb.fsf@dusky.pond.sub.org>
In-Reply-To: <87sglxltqb.fsf@dusky.pond.sub.org>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR1001CA0020.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:3:f7::30) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191206132651642
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5436f7a7-82a4-459a-3ec9-08d77a36d03f
x-ms-traffictypediagnostic: AM6PR08MB3622:
x-microsoft-antispam-prvs: <AM6PR08MB3622FCF9B41C5B954AC06595C15F0@AM6PR08MB3622.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:983;
x-forefront-prvs: 0243E5FD68
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(346002)(376002)(136003)(189003)(199004)(4326008)(14454004)(305945005)(54906003)(99286004)(229853002)(186003)(2906002)(53546011)(76176011)(31686004)(102836004)(81166006)(81156014)(6506007)(26005)(6512007)(6916009)(66556008)(52116002)(66476007)(14444005)(6486002)(508600001)(64756008)(8936002)(66446008)(8676002)(66946007)(36756003)(5660300002)(31696002)(11346002)(25786009)(71190400001)(2616005)(86362001)(71200400001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3622;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: clm17+LhnD7sMZOtJOL3foDdQ3aC5V8k1WSrl/+mxJAZFgMPqmUB6Z2d6LBuBTZv1qPRTlOnpOUmvmeyRjdc3xYfUF3AaXme8cNQLjbJwRLOTKXzKKn5GtGInUdXU6JfkXc6GWpkSN3VLsDc+va7+uSSgh6JAHzfwhfPks7WwWtNeJjrzNjwXpfF/q8hEg8jcGOi6rc4zt/ViFYCReYfm2gvlHIExBnkVIj0XpNlxEZ/AlkaE6GjxN8HRKNm4Y3qv3Z+qMzLPF41/4ROqhZhkp2ZAIBdWkXX2fGGyAdBKrUI0iKAS7H8vasuYZeznrTLbLe3yMqR0ZcwpKTYpFC/wPiH6M8hDihhFAgj78Ym9AdVz65TIryatvKMr0qf8Qqh2aqtypUUpKPo0yJcfm3ZRCAfPI8vrHImafABrnOU3NfzOCvLe+l3JPSC7nFq375y
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <862F0D55E63EEB45BFF2C750FE44E75A@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5436f7a7-82a4-459a-3ec9-08d77a36d03f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2019 10:26:53.8342 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 88rVHEA2sAF5HKd5cL/fV5E0fzXT7rrE7UBLUnCMcZ0mV71v+9cunMc/rZc0FkQTwhR2RKaDCAgMeOsIWEZ1xkkFaIA+tROhlJILMHzlGc4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3622
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.5.137
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDYuMTIuMjAxOSAxMTo1NCwgTWFya3VzIEFybWJydXN0ZXIgd3JvdGU6DQo+IFZsYWRpbWlyIFNl
bWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4gd3JpdGVzOg0KPiAN
Cj4+IDA1LjEyLjIwMTkgMjA6MTQsIEVyaWMgQmxha2Ugd3JvdGU6DQo+Pj4gT24gMTIvNS8xOSA5
OjIwIEFNLCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdyb3RlOg0KPj4+PiBUaGUgbG9j
YWxfZXJyIHBhcmFtZXRlciBpcyBub3QgaGVyZSB0byByZXR1cm4gaW5mb3JtYXRpb24gYWJvdXQN
Cj4+Pj4gbmJkX2l0ZXJfY2hhbm5lbF9lcnJvciBmYWlsdXJlLiBJbnN0ZWFkIGl0J3MgYXNzdW1l
ZCB0byBiZSBmaWxsZWQgd2hlbg0KPj4+PiBwYXNzZWQgdG8gdGhlIGZ1bmN0aW9uLiBUaGlzIGlz
IGFscmVhZHkgc3RyZXNzZWQgYnkgaXRzIG5hbWUNCj4+Pj4gKGxvY2FsX2VyciwgaW5zdGVhZCBv
ZiBjbGFzc2ljIGVycnApLiBTdHJlc3MgaXQgYWRkaXRpb25hbGx5IGJ5DQo+Pj4+IGFzc2VydGlv
bi4NCj4+Pj4NCj4+Pj4gU2lnbmVkLW9mZi1ieTogVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tp
eSA8dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPg0KPj4+PiAtLS0NCj4+Pj4gIMKgIGJsb2NrL25i
ZC5jIHwgMSArDQo+Pj4+ICDCoCAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4+Pj4N
Cj4+Pj4gZGlmZiAtLWdpdCBhL2Jsb2NrL25iZC5jIGIvYmxvY2svbmJkLmMNCj4+Pj4gaW5kZXgg
NWYxOGY3OGE5NC4uZDA4NTU1NGYyMSAxMDA2NDQNCj4+Pj4gLS0tIGEvYmxvY2svbmJkLmMNCj4+
Pj4gKysrIGIvYmxvY2svbmJkLmMNCj4+Pj4gQEAgLTg2Niw2ICs4NjYsNyBAQCB0eXBlZGVmIHN0
cnVjdCBOQkRSZXBseUNodW5rSXRlciB7DQo+Pj4+ICDCoCBzdGF0aWMgdm9pZCBuYmRfaXRlcl9j
aGFubmVsX2Vycm9yKE5CRFJlcGx5Q2h1bmtJdGVyICppdGVyLA0KPj4+PiAgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGludCByZXQsIEVycm9yICoqbG9jYWxfZXJyKQ0KPj4+PiAgwqAgew0KPj4+PiArwqDCoMKg
IGFzc2VydChsb2NhbF9lcnIgJiYgKmxvY2FsX2Vycik7DQo+Pj4NCj4+PiBXaHkgYXJlIHdlIGZv
cmJpZGRpbmcgZ3JhbmRwYXJlbnQgY2FsbGVycyBmcm9tIHBhc3NpbmcgTlVMTCB3aGVuIHRoZXkg
d2FudCB0byBpZ25vcmUgYW4gZXJyb3I/wqAgV2UgYXJlIGNhbGxlZCBieSBzZXZlcmFsIHBhcmVu
dCBmdW5jdGlvbnMgdGhhdCBnZXQgYW4gZXJycCBmcm9tIHRoZSBncmFuZHBhcmVudCwgYW5kIHVz
ZSB0aGlzIGZ1bmN0aW9uIHRvIGRvIHNvbWUgY29tbW9uIGdydW50IHdvcmsuwqAgTGV0J3MgbG9v
ayBhdCB0aGUgcG9zc2liaWxpdGllczoNCj4+Pg0KPj4+IDEuIGdyYW5kcGFyZW50IHBhc3NlcyBh
ZGRyZXNzIG9mIGEgbG9jYWwgZXJyb3I6IHdlIHdhbnQgdG8gYXBwZW5kIHRvIHRoZSBlcnJvciBt
ZXNzYWdlLCBwYXJlbnQgd2lsbCB0aGVuIGRlYWwgd2l0aCB0aGUgZXJyb3IgaG93IGl0IHdhbnRz
IChyZXBvcnQgaXQsIGlnbm9yZSBpdCwgcHJvcGFnYXRlIGl0LCB3aGF0ZXZlcikNCj4+Pg0KPj4+
IDIuIGdyYW5kcGFyZW50IHBhc3NlcyAmZXJyb3JfZmF0YWw6IHdlIHdhbnQgdG8gYXBwZW5kIGEg
aGludCwgYnV0IGJlZm9yZSBFUlJQX0FVVE9fUFJPUEFHQVRFLCB0aGUgcGFyZW50IGhhcyBhbHJl
YWR5IGV4aXRlZC7CoCBBZnRlciBFUlJQX0FVVE9fUFJPUEFHQVRFLCB0aGlzIGxvb2tzIGxpa2Ug
Y2FzZSAxLg0KPj4+DQo+Pj4gMy4gZ3JhbmRwYXJlbnQgcGFzc2VzICZlcnJvcl9hYm9ydDogd2Ug
c2hvdWxkIG5ldmVyIGJlIHJlYWNoZWQgKGZhaWx1cmUgZWFybGllciBpbiB0aGUgcGFyZW50IHNo
b3VsZCBoYXZlIGFscmVhZHkgYWJvcnRlZCkgLSB0cnVlIHdoZXRoZXIgb3Igbm90IEVSUlBfQVVU
T19QUk9QQUdBVEUgaXMgYXBwbGllZA0KPj4+DQo+Pj4gNC4gZ3JhbmRwYXJlbnQgcGFzc2VzIE5V
TEwgdG8gaWdub3JlIHRoZSBlcnJvci4gRG9lcyBub3QgY3VycmVudGx5IGhhcHBlbiBpbiBhbnkg
b2YgdGhlIGdyYW5kcGFyZW50IGNhbGxlcnMsIGJlY2F1c2UgaWYgaXQgZGlkLCB5b3VyIGFzc2Vy
dGlvbiBpbiB0aGlzIHBhdGNoIHdvdWxkIG5vdyBmaXJlLsKgIEFmdGVyIEVSUlBfQVVUT19QUk9Q
QUdBVEUsIHRoaXMgd291bGQgbG9vayBsaWtlIGNhc2UgMS4NCj4+Pg0KPj4+IFdvdWxkIGl0IGJl
IGJldHRlciB0byBhc3NlcnQoIWxvY2FsX2VyciB8fCAqbG9jYWxfZXJyKT/CoCBUaGUgYXNzZXJ0
aW9uIGFzIHdyaXR0ZW4gaXMgdG9vIHN0cmljdCB3aXRob3V0IEVSUlBfQVVUT19QUk9QQUdBVEUs
IGJ1dCB5b3UgZ2V0IGF3YXkgd2l0aCBpdCBiZWNhdXNlIG5vbmUgb2YgdGhlIGdyYW5kcGFyZW50
cyBwYXNzIE5VTEw7IGJ1dCBpcyBhcHByb3ByaWF0ZSBhcyB3cml0dGVuIGZvciBhZnRlciBhZnRl
ciB0aGUgbWFjcm8gY29udmVyc2lvbiBzbyB0aGVuIHdlIHdvbmRlciBpZiBjaHVybiBvbiB0aGUg
bWFjcm8gaXMgd29ydGggaXQuDQo+Pg0KPj4gV2UgZG9uJ3QgaGF2ZSBhbnkgZ3JhbmRwYXJlbnRz
LCB0aGlzIGZ1bmN0aW9uIGlzIGFsd2F5cyBjYWxsZWQgb24gbG9jYWxfZXJyLiBBbmQgaXQncyBh
cmd1bWVudCBuYW1lZCBsb2NhbF9lcnIgdG8gc3RyZXNzIGl0Lg0KPj4gVGhlIGZ1bmN0aW9uIGlz
IGFuIEFQSSB0byByZXBvcnQgZXJyb3IsIGFuZCBpdCB3YW50cyBmaWxsZWQgbG9jYWxfZXJyIG9i
amVjdC4NCj4+DQo+PiBJdCB3aWxsIGNyYXNoIGFueXdheSBpZiBsb2NhbF9lcnIgaXMgTlVMTCwg
YXMgaXQgZGVyZWZlcmVuY2VzIGl0Lg0KPiANCj4gWWVzLg0KPiANCj4gV2UgYWxyZWFkeSBhc3Nl
cnQgcmV0IDwgMCBleHBsaWNpdGx5LCBhbmQgd2UgcmVseSBvbiAhbG9jYWxfZXJyDQo+IGltcGxp
Y2l0bHkuICBNYWtpbmcgdGhhdCBleHBsaWNpdCBpcyBvYnZpb3VzbHkgc2FmZS4NCj4gDQo+IFRo
ZSBjb2RlIGRvZXNuJ3QgYWN0dWFsbHkgcmVseSBvbiAhKmxvY2FsX2Vyci4gIEJ1dCB3aGVuIHJl
dCA8IDAsIGFuZA0KPiAhbG9jYWxfZXJyLCBzdXJlbHkgbG9jYWxfZXJyIHNob3VsZCBwb2ludCB0
byBhbiBFcnJvciBvYmplY3QuICBBc3NlcnRpbmcNCj4gdGhhdCBtYWtlcyBzZW5zZSB0byBtZS4N
Cj4gDQo+PiBJIGp1c3Qgd2FudCB0byBwbGFjZSBhbiBhc3NlcnRpb24gYXQgc3RhcnQgb2YgZnVu
Y3Rpb25zIGxpa2UgdGhpcywNCj4+IHdoaWNoIHdpbGwgYmUgZWFzaWx5IHJlY29nbml6YWJsZSBi
eSBjb2NjaW5lbGxlLg0KPiANCj4gVGhhdCdzIG5vdCBhIGNvbnZpbmNpbmcgYXJndW1lbnQuIA0K
DQpUaGF0J3Mgd2h5IGl0IGlzIGFic2VudCBpbiBjb21taXQgbWVzc2FnZSkNCg0KPiBEb2Vzbid0
IG1hdHRlciBhcyBsb25nIGFzIHdlIGhhdmUNCj4gY29udmluY2luZyBvbmVzIDopDQo+IA0KPj4N
Cj4+IC0tLQ0KPj4NCj4+IFdlIGNhbiBpbXByb3ZlIHRoZSBBUEksIHRvIHN1cHBvcnQgbG9jYWxf
ZXJyPT1OVUxMLCBmb3IgdGhlIGNhc2Ugd2hlbiBvcmlnaW5hbCByZXF1ZXN0IHdhcyBjYWxsZWQg
d2l0aA0KPj4gZXJycD09TlVMTCwgYnV0IGZvciB0aGlzIHdlJ2xsIG5lZWQgbW9yZSBjaGFuZ2Vz
LCBsaWtlLCBwYXNzIGVycnAgdG8gTkJEX0ZPUkVBQ0hfUkVQTFlfQ0hVTksgYW5kIHNhdmUNCj4+
IGl0IGludG8gaXRlciBvYmplY3QuLi4NCj4+DQo+PiBCdXQgaG93IHRvIGRldGVjdCBpdCBpbiBj
b2RlPyBTb21ldGhpbmcgbGlrZQ0KPj4NCj4+DQo+PiAtLS0gYS9ibG9jay9uYmQuYw0KPj4gKysr
IGIvYmxvY2svbmJkLmMNCj4+IEBAIC0xMDU5LDggKzEwNTksMTAgQEAgc3RhdGljIGludCBuYmRf
Y29fcmVjZWl2ZV9ibG9ja3N0YXR1c19yZXBseShCRFJWTkJEU3RhdGUgKnMsDQo+PiAgICAgICAg
ICAgIGNhc2UgTkJEX1JFUExZX1RZUEVfQkxPQ0tfU1RBVFVTOg0KPj4gICAgICAgICAgICAgICAg
aWYgKHJlY2VpdmVkKSB7DQo+PiAgICAgICAgICAgICAgICAgICAgbmJkX2NoYW5uZWxfZXJyb3Io
cywgLUVJTlZBTCk7DQo+PiAtICAgICAgICAgICAgICAgIGVycm9yX3NldGcoJmxvY2FsX2Vyciwg
IlNldmVyYWwgQkxPQ0tfU1RBVFVTIGNodW5rcyBpbiByZXBseSIpOw0KPj4gLSAgICAgICAgICAg
ICAgICBuYmRfaXRlcl9jaGFubmVsX2Vycm9yKCZpdGVyLCAtRUlOVkFMLCAmbG9jYWxfZXJyKTsN
Cj4+ICsgICAgICAgICAgICAgICAgaWYgKGVycnApIHsNCj4+ICsgICAgICAgICAgICAgICAgICAg
IGVycm9yX3NldGcoJmxvY2FsX2VyciwgIlNldmVyYWwgQkxPQ0tfU1RBVFVTIGNodW5rcyBpbiBy
ZXBseSIpOw0KPj4gKyAgICAgICAgICAgICAgICB9DQo+PiArICAgICAgICAgICAgICAgIG5iZF9p
dGVyX2NoYW5uZWxfZXJyb3IoJml0ZXIsIC1FSU5WQUwsIGVycnAgPyAmbG9jYWxfZXJyIDogTlVM
TCk7DQo+PiAgICAgICAgICAgICAgICB9DQo+PiAgICAgICAgICAgICAgICByZWNlaXZlZCA9IHRy
dWU7DQo+Pg0KPj4NCj4+IGlzIHVnbHkuLg0KPj4NCj4+DQo+PiBTbywgdG8gc3VwcG9ydCBvcmln
aW5hbCBlcnJwPU5VTEwgdGhlIHdob2xlIHRoaW5nIHNob3VsZCBiZSByZWZhY3RvcmVkLi4gTm90
IHdvcnRoIGl0LCBJIHRoaW5rLg0KPiANCj4gVGhlIG9ubHkgY2hhbmdlIEknZCBjb25zaWRlciBp
biBhZGRpdGlvbiB0byB0aGUgYXNzZXJ0aW9uIGlzIHRoaXMNCj4gc2ltcGxpZmljYXRpb246DQo+
IA0KPiBkaWZmIC0tZ2l0IGEvYmxvY2svbmJkLmMgYi9ibG9jay9uYmQuYw0KPiBpbmRleCA1ZjE4
Zjc4YTk0Li43YmJhYzFlNWI4IDEwMDY0NA0KPiAtLS0gYS9ibG9jay9uYmQuYw0KPiArKysgYi9i
bG9jay9uYmQuYw0KPiBAQCAtODcwLDExICs4NzAsOSBAQCBzdGF0aWMgdm9pZCBuYmRfaXRlcl9j
aGFubmVsX2Vycm9yKE5CRFJlcGx5Q2h1bmtJdGVyICppdGVyLA0KPiAgIA0KPiAgICAgICBpZiAo
IWl0ZXItPnJldCkgew0KPiAgICAgICAgICAgaXRlci0+cmV0ID0gcmV0Ow0KPiAtICAgICAgICBl
cnJvcl9wcm9wYWdhdGUoJml0ZXItPmVyciwgKmxvY2FsX2Vycik7DQo+IC0gICAgfSBlbHNlIHsN
Cj4gLSAgICAgICAgZXJyb3JfZnJlZSgqbG9jYWxfZXJyKTsNCj4gICAgICAgfQ0KPiAgIA0KPiAr
ICAgIGVycm9yX3Byb3BhZ2F0ZSgmaXRlci0+ZXJyLCAqbG9jYWxfZXJyKTsNCg0KYmVjYXVzZSBp
dCB3aWxsIGp1c3QgZnJlZSB0aGUgc2Vjb25kIGFyZ3VtZW50IGlmIHRoZSBmaXJzdCBvbmUgYWxy
ZWFkeSBzZXQuLg0KT0ssIHdpbGwgYWRkIHRoaXMuDQoNCj4gICAgICAgKmxvY2FsX2VyciA9IE5V
TEw7DQo+ICAgfQ0KPiAgIA0KPiANCg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

