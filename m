Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D44DC4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 07:18:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22DBD206B7
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 07:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="vyKyN+dg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22DBD206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDkWa-0004n0-Uv
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 03:18:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34845)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iDkVR-0003yI-R9
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 03:17:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iDkVP-0007Uk-1h
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 03:17:33 -0400
Received: from mail-eopbgr00097.outbound.protection.outlook.com
 ([40.107.0.97]:62722 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iDkVN-0007T3-TX; Fri, 27 Sep 2019 03:17:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RqxBswOsRiL3XHACI7zlo7AloEAo/+ALuNmawG/wz4sum4IyDy+EWttlW2F9v+r4IGpc1Rhvr71yhn2Hz+O1twSBcwprYj6AJnw9U5Nv/FQyw8ABnDNzJcR/baTKCs+WNadiMozXQY121zqt5QD19QU/GqZMFjHMSB5hzmOXUZPf3Demck/1zVsksBgbzxSyp/Xl7Lo358iI2QvQgHHDmmRQd0I6VAMhU071czCkWTxsuRzvHy+XQQarbO0UznIP/hzNzhjoRncVStWy66XIp5bsCEhjtR9bg5P6N3Avpv2Wom1tWiF6HpP+8GqEYQT1Y889aHsHkSVjRWNbx3pZvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cHDFEHBE2183ztgVE/Xf1PbMoBRRIDmPDwoQZ7upMSo=;
 b=Wdp1a7QDXSqlS/g6vHkVCkad6b0D+au7lWWHKt4zrxzQFP7TqgVJQmGlaZFNyHS8NC3SM1QJDSVVuMsYsIXbxOlprKVC3SyhZvKpDQMmy3yGbe5vpaRJDGDkbHKMJF4bjepVgFb0BhVzvVAclQO0cc+Z4xEKnHafJFluDRAp2WFrBEXzBNnND/ZBqz/PNTZaDoHUJeIljK3Nba2qi/cOs9now5nMThABqO1o4UjQZmJiiXh81U87dwzdA1h5AnH4U5Ezs5qjS5jFnz1aEpgq+Qnl6mNxv+dglsHN+cVyGQZShg4kAhnw/MNwMYPYtJmsXT47q1pTdjO99zUWiG4Y7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cHDFEHBE2183ztgVE/Xf1PbMoBRRIDmPDwoQZ7upMSo=;
 b=vyKyN+dghyx4XUG34md4Igab3gI7TmK3qCxtpU3euD+JXvbK8HxRNV6ycwSlfy+yG3bXr8hPpVvD9SXKsjqaViAmY71SD1pnGbFqR9+vHzAHnksjL9LRsL4v+I+8FxPH5DPWTr3IVY6EBFfW0tx7pgEHNMzHBq7KrNQX3a/WSJo=
Received: from AM0PR08MB5491.eurprd08.prod.outlook.com (52.132.215.9) by
 AM0PR08MB5284.eurprd08.prod.outlook.com (20.178.118.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.18; Fri, 27 Sep 2019 07:17:27 +0000
Received: from AM0PR08MB5491.eurprd08.prod.outlook.com
 ([fe80::d552:8bd7:4773:3d75]) by AM0PR08MB5491.eurprd08.prod.outlook.com
 ([fe80::d552:8bd7:4773:3d75%2]) with mapi id 15.20.2305.017; Fri, 27 Sep 2019
 07:17:27 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, Eric Blake <eblake@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: Re: [Qemu-devel] [PATCH 4/4] block/dirty-bitmap: refactor
 bdrv_dirty_bitmap_next
Thread-Topic: [Qemu-devel] [PATCH 4/4] block/dirty-bitmap: refactor
 bdrv_dirty_bitmap_next
Thread-Index: AQHVbJm7h0RgutRwZ0i5hlfBj8KUJ6c+XoIAgAAJjYCAACXBgIAAoDQA
Date: Fri, 27 Sep 2019 07:17:27 +0000
Message-ID: <22d1d286-7702-9b44-8a84-8dd9fc452342@virtuozzo.com>
References: <20190916141911.5255-1-vsementsov@virtuozzo.com>
 <20190916141911.5255-5-vsementsov@virtuozzo.com>
 <b099f898-1d0f-d9b3-f8fb-c354f5a3fc50@redhat.com>
 <0386d7d0-1bda-054b-89d6-6b179d37b46d@redhat.com>
 <9903ca0b-07f5-6c18-1a32-58e65ee27f9c@redhat.com>
In-Reply-To: <9903ca0b-07f5-6c18-1a32-58e65ee27f9c@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0145.eurprd05.prod.outlook.com
 (2603:10a6:7:28::32) To AM0PR08MB5491.eurprd08.prod.outlook.com
 (2603:10a6:208:189::9)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190927101724844
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b80c1ef7-9b04-4042-3cb1-08d7431ac041
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:AM0PR08MB5284; 
x-ms-traffictypediagnostic: AM0PR08MB5284:
x-ms-exchange-purlcount: 2
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR08MB5284894560621E8F1379F6CEC1810@AM0PR08MB5284.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0173C6D4D5
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(346002)(396003)(376002)(39850400004)(366004)(199004)(189003)(6512007)(2906002)(25786009)(6116002)(4326008)(5660300002)(3846002)(66476007)(71190400001)(64756008)(66556008)(86362001)(7736002)(229853002)(6486002)(31696002)(66446008)(66946007)(81166006)(6436002)(8676002)(81156014)(305945005)(36756003)(6246003)(966005)(478600001)(2616005)(99286004)(186003)(11346002)(446003)(6506007)(53546011)(76176011)(386003)(26005)(102836004)(66066001)(256004)(8936002)(31686004)(14454004)(486006)(2501003)(71200400001)(316002)(6306002)(110136005)(54906003)(476003)(52116002)(7416002)(14143004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB5284;
 H:AM0PR08MB5491.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: q/2+XCPOMQgsqGQu0cQcyDxjszuv52SkiTqTW8BHOD7oO0aBOXDbpmbrxQECWgigTBML6fWP91D5JptlS2yBwVJvEUctHfMSglqbfK6uLAOYVRki3TOdIDwKXtpbI8SS6XVsUF11w0Cb3CyKeTUCyyf60Efw7Xex1zSnm10jkHH9uILveTuMU+BFfTEuSMX7rRSoSfr9YP6vdEcbDSXtYtJRyp5xYyegGp9ma8oy7qml/DF1pai2jue13F1nsm38ojabuARH1Ou6QpXvRZ0Q/cxXbizBMp5D70ZEzuwwJ8L+P9jQszOt2ZaOvKRG0GENiv62ZWAcie3Xj0Gbdoi6Lw7QFfzjmfKKmkrRIVX+yy7omratK6tv3xyTZXwT9GX/PcQi5w/iIcPcocwDwjQWTWN9JcNlGJCjAMYwFSVwAjzTFJtmFcxhjYe/qEdrL1WD31emOIWGkqgFPuJa+/igxQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <2200A36AF56B874D88C58DA3DB0205BB@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b80c1ef7-9b04-4042-3cb1-08d7431ac041
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2019 07:17:27.1747 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KRTbOWtr1Dpadpb6j1x+jvmIfk7dh4CJFEeSsxjZFztUvxtXLFtzKWrBsiCBUSLngPn/KuRmpbKK/tEh3ozyldQT2b7fF8ZDufMHG5qiPKU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5284
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.0.97
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
 Denis Lunev <den@virtuozzo.com>, "quintela@redhat.com" <quintela@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjcuMDkuMjAxOSAwOjQ0LCBKb2huIFNub3cgd3JvdGU6DQo+IA0KPiANCj4gT24gOS8yNi8xOSAz
OjI4IFBNLCBFcmljIEJsYWtlIHdyb3RlOg0KPj4gT24gOS8yNi8xOSAxOjU0IFBNLCBKb2huIFNu
b3cgd3JvdGU6DQo+Pj4NCj4+Pg0KPj4+IE9uIDkvMTYvMTkgMTA6MTkgQU0sIFZsYWRpbWlyIFNl
bWVudHNvdi1PZ2lldnNraXkgd3JvdGU6DQo+Pj4+IGJkcnZfZGlydHlfYml0bWFwX25leHQgaXMg
YWx3YXlzIHVzZWQgaW4gc2FtZSBwYXR0ZXJuLiBTbywgc3BsaXQgaXQNCj4+Pj4gaW50byBfbmV4
dCBhbmQgX2ZpcnN0LCBpbnN0ZWFkIG9mIGNvbWJpbmluZyB0d28gZnVuY3Rpb25zIGludG8gb25l
IGFuZA0KPj4+PiBhZGQgRk9SX0VBQ0hfRElSVFlfQklUTUFQIG1hY3JvLg0KPj4+Pg0KPj4+PiBT
aWduZWQtb2ZmLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZp
cnR1b3p6by5jb20+DQo+Pj4+IC0tLQ0KPj4+PiAgwqAgaW5jbHVkZS9ibG9jay9kaXJ0eS1iaXRt
YXAuaMKgwqAgfMKgIDkgKysrKysrKy0tDQo+Pj4+ICDCoCBibG9jay5jwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgNCArLS0tDQo+Pj4+ICDCoCBibG9j
ay9kaXJ0eS1iaXRtYXAuY8KgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMTEgKysrKysrKy0tLS0NCj4+
Pj4gIMKgIGJsb2NrL3Fjb3cyLWJpdG1hcC5jwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDggKyst
LS0tLS0NCj4+Pj4gIMKgIG1pZ3JhdGlvbi9ibG9jay1kaXJ0eS1iaXRtYXAuYyB8wqAgNCArLS0t
DQo+Pj4+ICDCoCA1IGZpbGVzIGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKyksIDE4IGRlbGV0aW9u
cygtKQ0KPj4+DQo+Pj4gSSdtIG5vdCBhcyBzdXJlIHRoYXQgdGhpcyBpcyBhbiBpbXByb3ZlbWVu
dC4NCj4+Pg0KPj4NCj4+Pj4gIMKgIGJvb2wgYmRydl9oYXNfY2hhbmdlZF9wZXJzaXN0ZW50X2Jp
dG1hcHMoQmxvY2tEcml2ZXJTdGF0ZSAqYnMpOw0KPj4+PiAtQmRydkRpcnR5Qml0bWFwICpiZHJ2
X2RpcnR5X2JpdG1hcF9uZXh0KEJsb2NrRHJpdmVyU3RhdGUgKmJzLA0KPj4+PiAtwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIEJkcnZEaXJ0eUJpdG1hcCAqYml0bWFwKTsNCj4+Pj4gKw0KPj4+PiArQmRy
dkRpcnR5Qml0bWFwICpiZHJ2X2RpcnR5X2JpdG1hcF9maXJzdChCbG9ja0RyaXZlclN0YXRlICpi
cyk7DQo+Pj4+ICtCZHJ2RGlydHlCaXRtYXAgKmJkcnZfZGlydHlfYml0bWFwX25leHQoQmRydkRp
cnR5Qml0bWFwICpiaXRtYXApOw0KPj4+PiArI2RlZmluZSBGT1JfRUFDSF9ESVJUWV9CSVRNQVAo
YnMsIGJpdG1hcCkgXA0KPj4+PiArZm9yIChiaXRtYXAgPSBiZHJ2X2RpcnR5X2JpdG1hcF9maXJz
dChicyk7IGJpdG1hcDsgXA0KPj4+PiArwqDCoMKgwqAgYml0bWFwID0gYmRydl9kaXJ0eV9iaXRt
YXBfbmV4dChiaXRtYXApKQ0KPj4+PiArDQo+Pg0KPj4gSWYgeW91IHdhbnQgdGhlIG1hY3JvLCB5
b3UgY2FuIGRvIHRoYXQgd2l0aG91dCBzcGxpdHRpbmcgdGhlIGZ1bmN0aW9uIGluDQo+PiB0d286
DQo+Pg0KPj4gI2RlZmluZSBGT1JfRUFDSF9ESVJUWV9CSVRNQVAoYnMsIGJpdG1hcCkgXA0KPj4g
Zm9yIChiaXRtYXAgPSBiZHJ2X2RpcnR5X2JpdG1hcF9uZXh0KGJzLCBOVUxMKTsgYml0bWFwOyBc
DQo+PiAgwqDCoMKgwqAgYml0bWFwID0gYmRydl9kaXJ0eV9iaXRtYXBfbmV4dChicywgYml0bWFw
KSkNCj4+DQo+Pg0KPj4+DQo+Pj4gV2VsbCwgSSBndWVzcyBleHBsaWNpdCBmaXJzdCBhbmQgbmV4
dCBmdW5jdGlvbnMgaXMgaGFyZGVyIHRvIG1lc3MgdXAsDQo+Pj4gYW55d2F5Lg0KPj4+DQo+Pj4g
UmV2aWV3ZWQtYnk6IEpvaG4gU25vdyA8anNub3dAcmVkaGF0LmNvbT4NCj4+Pg0KPj4+IChBbnkg
b3RoZXIgdGhvdWdodHM/KQ0KPj4NCj4+IEkgZG9uJ3QgbWluZCB0aGUgbWFjcm8gYXMgbXVjaCAo
c2luY2Ugd2UgYWxyZWFkeSB1c2UgaXRlcmF0aW9uIG1hY3Jvcw0KPj4gZm9yIFFUQUlMUV9GT1JF
QUNIIGFuZCBzdWNoIHRocm91Z2hvdXQgdGhlIGNvZGViYXNlLCBhbmQgc2luY2UgaXQNCj4+IHNv
bWV3aGF0IGlzb2xhdGVzIHlvdSBmcm9tIHRoZSBjYWxsaW5nIGNvbnZlbnRpb25zIG9mIHBhc3Np
bmcgTlVMTCB0bw0KPj4gcHJpbWUgdGhlIGl0ZXJhdGlvbiksIGJ1dCBpbnRyb2R1Y2luZyB0aGUg
bWFjcm8gZG9lcyBub3QgaW1wbHkgdGhhdCB3ZQ0KPj4gbmVlZCB0d28gZnVuY3Rpb25zLsKgIFNv
IEkgdGhpbmsgdGhpcyBpcywgdG8gc29tZSBleHRlbnQsIGEgcXVlc3Rpb24gb2YNCj4+IHRoZSBt
YWludGFpbmVyJ3Mgc2Vuc2Ugb2YgYWVzdGhldGljcywgYW5kIG5vdCBhbiBhY3R1YWwgcHJvYmxl
bSBpbiB0aGUNCj4+IGNvZGUuDQo+Pg0KPiBObyBoYXJtIGluIHRha2luZyBpdCBhbmQgaXQncyBl
YXNpZXIgdGhhbiBub3QgdGFraW5nIGl0Lg0KDQpJIGRvbid0IGluc2lzdCwgY29uc2lkZXIgbGFz
dCBwYXRjaCBhcyBvcHRpb25hbC4NCg0KPiANCj4gVGhhbmtzLCBhcHBsaWVkIHRvIG15IGJpdG1h
cHMgdHJlZToNCj4gDQo+IGh0dHBzOi8vZ2l0aHViLmNvbS9qbnNub3cvcWVtdS9jb21taXRzL2Jp
dG1hcHMNCj4gaHR0cHM6Ly9naXRodWIuY29tL2puc25vdy9xZW11LmdpdA0KPiANCg0KVGhhbmsg
eW91IQ0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

