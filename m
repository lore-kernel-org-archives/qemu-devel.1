Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C75ECC47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 10:03:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DF61214E0
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 10:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="lBmr3Xyk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DF61214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIrlR-0004pe-Mt
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 06:03:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59227)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iIrkd-0004JE-30
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 06:02:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iIrkb-0006jz-R5
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 06:02:23 -0400
Received: from mail-eopbgr10138.outbound.protection.outlook.com
 ([40.107.1.138]:46208 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iIrkY-0006hk-1x; Fri, 11 Oct 2019 06:02:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GVpSVvM4nDVuTvuDrBNraqvBuftk4cqmGqA1Uutoj02mteymXHF80lo0j4srPhK6OlADTSS2SDOxbVcEexQZ/bogjY6MTS3pQFqUwdTzepva4eIfAcA5nDShMBAdZg0vXHcUF0kcnkSphRj2HCahRfJ5idG/ZGz49vCD+8lWUn4OOyNTWs/JFMwr9jVUGemDZSzCpxJpICM/DVEgJ0VLFGaYrwLWEvJMuN5FK8rWm6nyXKQChiSnn/DhlkvNjM9Bcrx13317hR9zqMWMcBEgA5lx6ZW1wifkUh5VEjf9FgbYROg0CTjtgkRN67N/CicAlmW8oriTEnkueD5AsbxduA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ysRyeKprIcO55K9SGEzra8E/QGY6aYoIO/+W5DRRiug=;
 b=IvlVlmooBJ3p98B9o49rhexuhMbhrqvGOdonWg2eE3F1LVJjU0zzsfGy7ksmEqcAxf7bIScQzZXW9vSHR8NPsZKOZdbsp6oEhb9dQDPBx5GHZru9i+UEpXs4F22+EajDGoJoHwDuCv8UWwqry/jg5AzW9y4vzXXH0MKvyhTD4xKfRmr872Os2ddqMuY5A206oMWrMrH8BFTCs+/zhsRrtI2S3TPayAEvScxoL5XlFBKtpxS+nqRZyOXogjAq+ruUIs9vrdCPlnBJ5NLaXBujO4yuMjlW8JBzhHedBPhQL/gN9+oIbnwH5ieSXRdmsam+VY0DHK9fRKbkAcD+MxT2+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ysRyeKprIcO55K9SGEzra8E/QGY6aYoIO/+W5DRRiug=;
 b=lBmr3XykKBlTEibJ/uE/QCcnlo+dBIBnvxqNBm9BY2o8BzKRdHqT7yCgfRDYJk1g0zmFQUl8MWXTJgfVjjlvriTDbJoreDolMStKlx6INAiWQNe68e6dDseK7knerf8580wD2VgZoJiofPtEW8abDPZlnXMXCf2Acze7YlqkC6U=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5099.eurprd08.prod.outlook.com (10.255.18.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.17; Fri, 11 Oct 2019 10:02:14 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f%2]) with mapi id 15.20.2347.021; Fri, 11 Oct 2019
 10:02:14 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, Eric Blake <eblake@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH] qcow2-bitmaps: fix qcow2_can_store_new_dirty_bitmap
Thread-Topic: [PATCH] qcow2-bitmaps: fix qcow2_can_store_new_dirty_bitmap
Thread-Index: AQHVHWGt3O1zHwGo8UiWi6cR5sNsBKaQidAAgMQ9U4CAADQyAIAA/82A
Date: Fri, 11 Oct 2019 10:02:14 +0000
Message-ID: <ce2c7d48-80f1-5b21-b5da-abb98add9cbc@virtuozzo.com>
References: <20190607184802.100945-1-vsementsov@virtuozzo.com>
 <f218e52c-8b0b-07cc-519f-23e9612b2320@virtuozzo.com>
 <6fde60fa-a4fb-eaf8-3830-5d358afb121f@redhat.com>
 <97542d69-0304-2b0a-e33b-de4369b35b4d@redhat.com>
In-Reply-To: <97542d69-0304-2b0a-e33b-de4369b35b4d@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P190CA0049.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:52::38)
 To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191011130211939
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 53086314-f3ba-4c11-b95e-08d74e321752
x-ms-traffictypediagnostic: DB8PR08MB5099:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DB8PR08MB5099C18392770E727181BF47C1970@DB8PR08MB5099.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0187F3EA14
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(376002)(136003)(396003)(366004)(39840400004)(52314003)(189003)(199004)(102836004)(7736002)(476003)(5660300002)(2501003)(2906002)(186003)(26005)(486006)(305945005)(11346002)(446003)(54906003)(110136005)(316002)(2616005)(6512007)(6306002)(3846002)(6116002)(229853002)(6436002)(6486002)(2201001)(31696002)(86362001)(66066001)(53546011)(76176011)(99286004)(31686004)(52116002)(25786009)(4326008)(6246003)(6506007)(386003)(14454004)(478600001)(71200400001)(36756003)(14444005)(256004)(71190400001)(966005)(8936002)(81166006)(66446008)(81156014)(66476007)(64756008)(8676002)(66946007)(66556008)(14143004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5099;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0RZMM4moDMamHkIw/OjnvfnnVBn2yjAEhJjezBDPm4FgRBekdEQlsXPQg/uNLrIiZI0DW+odsOcm0sk0oaTa1b8Vtx5Y93mLWgvR5j27/9DaJg/PJ2hdjPQHf9qIXIvbw4sIoOMMLLvGapNxk8s8L3OIFIyZGDPWAZxeMvqFIBx4abh0kIzHl4mOS0ZIz/15tiSSV7w6sIgs0BmYEZ6Ajy+bEiCGGtz79HV/vC0SUiZ7rQsOFulGhJelF+4rzFuEST2u6vvBukbxgkFWpne/44EdvMqtkQuwt5UmrqaayD5e2z4c5YY4z5fDs8NVGB9eayq7fjQNvhqK8kwqoLwHRUYjcLQ11OXFJoUk6N6k5gMwLImgqnOhx9KxweZX6ZvP7nMImS96pWyYIwDBmpROwiGStvPXnwFY2EhfpGsZIDw5CyhSDzFz5KDGi5/ONBPHNzyzVFUB2G6ZTUGFiwGV6w==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E9667F473270484FA780EED240EF61B3@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53086314-f3ba-4c11-b95e-08d74e321752
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2019 10:02:14.5265 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vYDdeun2wu8quzCqtIWlzouQKdJ4kTMpbvLQieeQrYhNkjAmzzw8QqF3dAP8lN/pCoqBPcSXiroNRqJmyCQg2febEusuw2/U32bzMT4MlUw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5099
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.138
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTAuMTAuMjAxOSAyMTo0NiwgSm9obiBTbm93IHdyb3RlOg0KPiANCj4gDQo+IE9uIDEwLzEwLzE5
IDExOjM5IEFNLCBFcmljIEJsYWtlIHdyb3RlOg0KPj4gT24gNi83LzE5IDE6NTMgUE0sIFZsYWRp
bWlyIFNlbWVudHNvdi1PZ2lldnNraXkgd3JvdGU6DQo+Pj4gMDcuMDYuMjAxOSAyMTo0OCwgVmxh
ZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+Pj4gcWNvdzJfY2FuX3N0b3JlX25l
d19kaXJ0eV9iaXRtYXAgd29ya3Mgd3JvbmcsIGFzIGl0IGNvbnNpZGVycyBvbmx5DQo+Pj4+IGJp
dG1hcHMgYWxyZWFkeSBzdG9yZWQgaW4gdGhlIHFjb3cyIGltYWdlIGFuZCBpZ25vcmVzIHBlcnNp
c3RlbnQNCj4+Pj4gQmRydkRpcnR5Qml0bWFwIG9iamVjdHMuDQo+Pj4+DQo+Pj4+IFNvLCBsZXQn
cyBpbnN0ZWFkIGNvdW50IHBlcnNpc3RlbnQgQmRydkRpcnR5Qml0bWFwcy4gV2UgbG9hZCBhbGwg
cWNvdzINCj4+Pj4gYml0bWFwcyBvbiBvcGVuLCBzbyB0aGVyZSBzaG91bGQgbm90IGJlIGFueSBi
aXRtYXAgaW4gdGhlIGltYWdlIGZvcg0KPj4+PiB3aGljaCB3ZSBkb24ndCBoYXZlIEJkcnZEaXJ0
eUJpdG1hcHMgdmVyc2lvbi4gSWYgaXQgaXMgLSBpdCdzIGEga2luZCBvZg0KPj4+PiBjb3JydXB0
aW9uLCBhbmQgbm8gcmVhc29uIHRvIGNoZWNrIGZvciBjb3JydXB0aW9ucyBoZXJlIChvcGVuKCkg
YW5kDQo+Pj4+IGNsb3NlKCkgYXJlIGJldHRlciBwbGFjZXMgZm9yIGl0KS4NCj4+Pj4NCj4+Pj4g
U2lnbmVkLW9mZi1ieTogVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2
aXJ0dW96em8uY29tPg0KPj4+PiAtLS0NCj4+Pj4NCj4+Pj4gSGkhDQo+Pj4+DQo+Pj4+IFBhdGNo
IGlzIGJldHRlciB0aGFuIGRpc2N1c3NpbmcgSSB0aGluZywgc28gaGVyZSBpcyBteQ0KPj4+PiBj
b3VudGVyLXN1Z2dlc3Rpb24gZm9yDQo+Pj4+ICJbUEFUQ0ggMC81XSBibG9jay9kaXJ0eS1iaXRt
YXA6IGNoZWNrIG51bWJlciBhbmQgc2l6ZSBjb25zdHJhaW50cw0KPj4+PiBhZ2FpbnN0IHF1ZXVl
ZCBiaXRtYXBzIg0KPj4+PiBieSBKb2huLg0KPj4+Pg0KPj4+PiBJdCdzIG9mIGNvdXJzZSBuZWVk
cyBzb21lIGFkZGl0aW9uYWwgcmVmYWN0b3JpbmcsIGFzIGZpcnN0IGFzc2VydA0KPj4+PiBzaG93
cyBiYWQgZGVzaWduLA0KPj4+PiBJIGp1c3Qgd3JvdGUgaXQgaW4gc3VjaCBtYW5uZXIgdG8gbWFr
ZSBtaW5pbXVtIGNoYW5nZXMgdG8gZml4IHRoZSBidWcuDQo+Pj4+DQo+Pg0KPj4+PiArwqDCoMKg
IGFzc2VydCghYmRydl9maW5kX2RpcnR5X2JpdG1hcChicywgbmFtZSkpOw0KPj4+DQo+Pj4gZXhh
Y3RseSBiYWQsIHRoaXMgc2hvdWxkIGJlIGNoZWNrZWQgaW4gcW1wX2Jsb2NrX2RpcnR5X2JpdG1h
cF9hZGQoKSwNCj4+PiBiZWZvcmUgY2hlY2tzIGFyb3VuZA0KPj4+IHBlcnNpc3RlbmNlLiBhbmQg
YWlvX2NvbnRleHRfYWNxdWlyZSBtYXkgYmUgZHJvcHBlZC4uDQo+Pj4NCj4+PiBCdXQgYW55d2F5
LCBpZGVhIGlzIGNsZWFyIEkgdGhpbmssIGNvbnNpZGVyIGl0IGFzIFJGQyBwYXRjaA0KPj4NCj4+
IEFyZSB5b3UgcGxhbm5pbmcgdG8gcG9zdCBhIHYyLCBhcyB0aGlzIGFmZmVjdHMgYXQgbGVhc3QN
Cj4+IGh0dHBzOi8vYnVnemlsbGEucmVkaGF0LmNvbS9zaG93X2J1Zy5jZ2k/aWQ9MTcxMjYzNg0K
Pj4NCj4gDQo+IEkgc3VwcG9zZSB3ZSBvdWdodCB0byBkbyBpdCB0aGlzIHdheSBmb3Igbm93IGFz
IGl0J3MgbGVzcyBTTE9DIHRoYW4gbXkNCj4gaWRlYSwgYnV0IEkgaGF2ZSB0byBhZG1pdCBJIHdv
dWxkIHN0aWxsIHByZWZlciB0byBnZXQgcmlkIG9mICJjYW5fc3RvcmUiDQo+IGFsdG9nZXRoZXIg
YW5kIHByb3ZpZGUgY29uY3JldGUgYml0bWFwX3N0b3JlKCkgYW5kIGJpdG1hcF9yZW1vdmUoKQ0K
PiBjYWxsYmFja3MgZm9yIHB1cnBvc2Ugb2Ygc3ltbWV0cnkgYW5kIG1vZGVsIHNpbXBsaWNpdHku
DQo+IA0KPiBJIGd1ZXNzIEknbGwgd29ycnkgYWJvdXQgdGhhdCBkaXNjdXNzaW9uIHNvbWUgb3Ro
ZXIgdGltZS4NCj4gDQo+IC0tanMNCj4gDQoNClNob3VsZCBJIGJhc2UgaXQgb24gbWFzdGVyIG9y
IG9uIHlvdSBiaXRtYXBzIGJyYW5jaD8gRG8gd2Ugd2FudCBpdCBmb3Igc3RhYmxlPw0KDQotLSAN
CkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

