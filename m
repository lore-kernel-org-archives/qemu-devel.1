Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BCFFC49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 17:00:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0413520678
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 17:00:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="O3AYDV1J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0413520678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9uMG-0001Af-5O
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 13:00:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45381)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i9u2x-000756-5Z
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 12:40:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i9u2q-00079L-Rv
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 12:40:14 -0400
Received: from mail-eopbgr00093.outbound.protection.outlook.com
 ([40.107.0.93]:15342 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1i9u2d-00072l-6E; Mon, 16 Sep 2019 12:39:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WLYpSXzsLy9duiTjr4oOKkKXApRiQL+szi00U8QuFQ0NvnUTE/2FMcD4QrWQB+H+pZikAZydb8SSriifjVk1M9xwR1P5DjO3bheZYhA9nC0+pMhds3dMm0rf+TsYIxKBzhFt+gG2jsrmGuZzafoCf3EtrEP2YNhaQ8sLpc7aYBNcgt17fje3F2dV+YhED877cKB7BNXsbgX5cSU0UKdl8Jsc+4WiO7cflcDAzvb994uxL9nAWl5EVT8FC2yB9XtA9LvT5q0ccP4TihejdGIhHP39+0w2ROf7fgacgXM8myEOLND7dqKcXf9Vb5EwANZQl6OpTSj/KcLDGIxFo9eXjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6tNxs0QJizivfmM+kiM4+tUVc+bllBY/JKsejQCdVMU=;
 b=UszhjYFxDyP5YYO8tPN7UywBhxf3qyFDEppc1Dk3EdJTgufhBj8p36rtZgw3Jj/4AxjX8IIeomNjfsJq4DEDAE+Vh3WxqxiaL/EF4wGjXIxzYQ6uUPQSfSkebZTpFbAEIK0dOXlDbZZxcu9KBsQOZTrjprzF4S0wyL+X1SUqdNLW8AhcFxACEearGDeF56+k+5La/mQ4vP7L9D4qqTDgolpteiPh0g3cF7Ql8iDaAY4FOeSVYYghkyMJQ26KMrZY17JJVQCKvYTdB67tZZnZvU2U2ykPhxbG7Kv/e1y+3WSZQo/cpvgY256pIDHzVhSfCYDJUFlZkD/pLmZiua6atw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6tNxs0QJizivfmM+kiM4+tUVc+bllBY/JKsejQCdVMU=;
 b=O3AYDV1JeUYMSSBftT/F7CbJVCx3KYyIw1qdYkv/XGrzLjGTJmd9CZRwOWT8IgPHGszrFAsAhbFH5KLdBJzip1BnCwklakm82DIyloDPiZ+iVFoP2alVnW+GKTUIg1VIAIckVtuplFnMyHslrNnR15sfxgX311jSC8uPt4qERc8=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4043.eurprd08.prod.outlook.com (20.179.10.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.20; Mon, 16 Sep 2019 16:39:53 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2263.023; Mon, 16 Sep 2019
 16:39:53 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH v4 1/4] iotests: add script_initialize
Thread-Index: AQHVaP+sHvXQg5mIX0qbfLdZwy5qOKcua+GAgAAas4CAAAIjAA==
Date: Mon, 16 Sep 2019 16:39:53 +0000
Message-ID: <91133853-23e0-90ad-bb51-29a6c18ffc92@virtuozzo.com>
References: <20190912001633.11372-1-jsnow@redhat.com>
 <20190912001633.11372-2-jsnow@redhat.com>
 <974b64b8-a191-c529-4e77-6a38b372c4b8@virtuozzo.com>
 <376bbe1c-09dd-2dfc-cebe-6144f3411ec5@redhat.com>
In-Reply-To: <376bbe1c-09dd-2dfc-cebe-6144f3411ec5@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0902CA0022.eurprd09.prod.outlook.com
 (2603:10a6:3:e5::32) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190916193950906
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0ee8e823-09ce-4c18-9a9c-08d73ac47fd7
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:DB8PR08MB4043; 
x-ms-traffictypediagnostic: DB8PR08MB4043:
x-microsoft-antispam-prvs: <DB8PR08MB404373DE29888D04E99116A9C18C0@DB8PR08MB4043.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0162ACCC24
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(366004)(39840400004)(346002)(376002)(136003)(52314003)(199004)(189003)(305945005)(256004)(14444005)(8676002)(4326008)(8936002)(6116002)(6246003)(2501003)(76176011)(81156014)(81166006)(6506007)(53546011)(386003)(316002)(11346002)(99286004)(6512007)(186003)(6486002)(446003)(54906003)(6436002)(2906002)(229853002)(3846002)(14454004)(26005)(52116002)(2616005)(476003)(53936002)(36756003)(66446008)(486006)(7736002)(64756008)(102836004)(66556008)(66946007)(31696002)(86362001)(31686004)(110136005)(5660300002)(71190400001)(71200400001)(66066001)(25786009)(66476007)(478600001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4043;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0kkNoQrdI1sUUZ7rV/E1Mkt1b7z3VFl9Lr4ipF3AXJnTdC+45kxTzOjUoJQfxDUSP6uWo+KGrxShTtsZz/naopqUJsybosKmgq5BzCnCFmcTo8MZqKD1R5pPXQthu+y+TVZKWjbc6ew7znpyyC4SZMp3lMN2dSTVbRDKzNj8iM1JOIzQhT74YSqCgJTeiO3BPLhTVA3LxFOEqz57gaNxi5x39dG9XimGe6g/LX9Sj7dCb5ZKHnYmFcT89GEnN+OtrCJf+om2oBAG9h/e/3Xjr4e0/zOWFL+t79z+TTWUwis8EuqcRm9Xe3Pr0iW8uFL6pIsgvvRNZCI9VmLP083kZIjnEMl8GglMFrOjjKwg5baZ7ylUyyzXNTF6jIabfkbYOYpyJM43HoShTkvxypseM2MIhWh6mcbzaSeFMtECtvU=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <5A1D72BA705F2D4E9C8F8B4EAAFE655A@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ee8e823-09ce-4c18-9a9c-08d73ac47fd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2019 16:39:53.0773 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: erazAXLIxGwYgYahBMnlQYJlfqfZlNaL+z1vPvTHOqZECCZNHCR+RgTBEnghtfmG85L/kzDAQ2m2EKiqEnQdOXykPUQHOnVSZ7DaM+UhCv8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4043
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.0.93
Subject: Re: [Qemu-devel] [PATCH v4 1/4] iotests: add script_initialize
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
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTYuMDkuMjAxOSAxOTozMiwgSm9obiBTbm93IHdyb3RlOg0KPiANCj4gDQo+IE9uIDkvMTYvMTkg
MTA6NTYgQU0sIFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgd3JvdGU6DQo+PiAxMi4wOS4y
MDE5IDM6MTYsIEpvaG4gU25vdyB3cm90ZToNCj4+PiBMaWtlIHNjcmlwdF9tYWluLCBidXQgZG9l
c24ndCByZXF1aXJlIGEgc2luZ2xlIHBvaW50IG9mIGVudHJ5Lg0KPj4+IFJlcGxhY2UgYWxsIGV4
aXN0aW5nIGluaXRpYWxpemF0aW9uIHNlY3Rpb25zIHdpdGggdGhpcyBkcm9wLWluIHJlcGxhY2Vt
ZW50Lg0KPj4+DQo+Pj4gVGhpcyBicmluZ3MgZGVidWcgc3VwcG9ydCB0byBhbGwgZXhpc3Rpbmcg
c2NyaXB0LXN0eWxlIGlvdGVzdHMuDQo+Pj4NCj4+PiBOb3RlOiBzdXBwb3J0ZWRfb3Nlcz1bJ2xp
bnV4J10gd2FzIG9taXR0ZWQsIGFzIGl0IGlzIGEgZGVmYXVsdCBhcmd1bWVudC4NCj4+DQo+PiBC
dXQgYWZ0ZXIgdGhpcyBwYXRjaCBhbGwgdGVzdCB3aGljaCBkaWRuJ3QgY2hlY2sgb3Mgc3RhcnQg
dG8gY2hlY2sgbGludXgNCj4+IChhcyBpdCdzIGRlZmF1bHQpLi4gU28gYWxsIHRlc3RzIHdoaWNo
IHdvcmtlZCBvbiBvdGhlciBwbGF0Zm9ybXMgd2lsbCBub3cNCj4+IGJlIHNraXBwZWQgb24gdGhl
c2Ugb3RoZXIgcGxhdGZvcm1zPw0KPj4NCj4gDQo+IGRlZiB2ZXJpZnlfcGxhdGZvcm0oc3VwcG9y
dGVkX29zZXM9WydsaW51eCddKToNCj4gICAgICBpZiBUcnVlIG5vdCBpbiBbc3lzLnBsYXRmb3Jt
LnN0YXJ0c3dpdGgoeCkgZm9yIHggaW4gc3VwcG9ydGVkX29zZXNdOg0KPiAgICAgICAgICBub3Ry
dW4oJ25vdCBzdWl0YWJsZSBmb3IgdGhpcyBPUzogJXMnICUgc3lzLnBsYXRmb3JtKQ0KPiANCj4g
DQo+IEl0IHdhcyBhbHJlYWR5IHRoZSBkZWZhdWx0LiBJIGRpZG4ndCAqbWFrZSogaXQgdGhlIGRl
ZmF1bHQuDQoNClllcy4gQnV0IGZvciBzb21lIHRlc3RzLCB2ZXJpZnlfcGxhdGZvcm0gd2Fzbid0
IGNhbGxlZCBiZWZvcmUgdGhpcyBwYXRjaCBhdCBhbGwuDQpBbmQgbm93IGl0IGlzIGNhbGxlZCBh
bmQgY2hlY2tzICJsaW51eCIuIEl0J3MgdGhlIGNoYW5nZS4gT3Igd2hhdCBJIG1pc3M/DQoNCj4g
VGhlcmUgaXMgbm8NCj4gY2hhbmdlIGhlcmUuIEZlZWwgZnJlZSB0byBwcm9wb3NlIGEgZml4LCBi
dXQgSSBkb24ndCB0aGluayBpdCdzIHdpdGhpbg0KPiB0aGUgc2NvcGUgb2YgdGhpcyBzZXJpZXMu
DQo+IA0KPj4gRmluYWxseSBkbyB3ZSBzdXBwb3J0IHNvbWV0aGluZyBleGNlcHQgbGludXggZm9y
IGlvdGVzdHM/DQo+PiBmb3IgYmFzaCB0ZXN0cyBfc3VwcG9ydGVkX29zIGFsc28gdXNlZCBvbmx5
IHdpdGggIkxpbnV4IiBpbiA4NyB0ZXN0cy4uDQo+Pg0KPiANCj4gRXZpZGVudGx5LCBub3QgcmVh
bGx5LiBTZWUgYmM1MjE2OTY2MDdjNTM0OGZjZDhhOWU1N2I0MDhkMGFjMGRiZTJmOA0KPiANCj4+
IE1heSBiZSB3ZSdkIGJldHRlciBkcm9wIGJvdGggX3N1cHBvcnRlZF9vcyBhbmQgc3VwcG9ydGVk
X29zZXMgYWxsdG9nZXRoZXIsDQo+PiBhbmQgZG9uJ3QgY2FyZT8NCj4+DQo+IA0KPiBCZXlvbmQg
dGhlIHNjb3BlIG9mIHRoaXMgc2VyaWVzLg0KPiANCj4+IEFueXdheSwgaWYgd2Ugc3VwcG9ydCBv
bmx5IGxpbnV4LCBhbnkgcmVhc29uIHRvIHNraXAgYWxtb3N0IGFsbCB0ZXN0cywNCj4+IGlmIHNv
bWVvbmUgdHJpZXMgdG8gcnVuIHRlc3Qgb24gb3RoZXIgcGxhdGZvcm0/IExldCBoaW0gcnVuIHdo
YXQgaGUgd2FudHMuDQo+IA0KPiBNYXliZSB0cnVlLCBtYXliZSBub3QuDQo+IA0KPj4NCj4+PiBT
aWduZWQtb2ZmLWJ5OiBKb2huIFNub3cgPGpzbm93QHJlZGhhdC5jb20+DQo+Pj4gLS0tDQo+Pg0K
Pj4gWy4uXQ0KPj4NCj4+PiArZGVmIGV4ZWN1dGVfdGVzdCh0ZXN0X2Z1bmN0aW9uPU5vbmUsICph
cmdzLCAqKmt3YXJncyk6DQo+Pj4gKyAgICAiIiJSdW4gZWl0aGVyIHVuaXR0ZXN0IG9yIHNjcmlw
dC1zdHlsZSB0ZXN0cy4iIiINCj4+PiArDQo+Pj4gKyAgICBkZWJ1ZyA9IGV4ZWN1dGVfc2V0dXBf
Y29tbW9uKCphcmdzLCAqKmt3YXJncykNCj4+PiAgICAgICAgaWYgbm90IHRlc3RfZnVuY3Rpb246
DQo+Pj4gLSAgICAgICAgZXhlY3V0ZV91bml0dGVzdChvdXRwdXQsIHZlcmJvc2l0eSwgZGVidWcp
DQo+Pj4gKyAgICAgICAgZXhlY3V0ZV91bml0dGVzdChkZWJ1ZykNCj4+PiAgICAgICAgZWxzZToN
Cj4+PiAgICAgICAgICAgIHRlc3RfZnVuY3Rpb24oKQ0KPj4+ICAgIA0KPj4+ICsjIFRoaXMgaXMg
Y2FsbGVkIGZyb20gc2NyaXB0LXN0eWxlIGlvdGVzdHMgd2l0aG91dCBhIHNpbmdsZSBwb2ludCBv
ZiBlbnRyeQ0KPj4+ICtkZWYgc2NyaXB0X2luaXRpYWxpemUoKmFyZ3MsICoqa3dhcmdzKToNCj4+
PiArICAgICIiIkluaXRpYWxpemUgc2NyaXB0LXN0eWxlIHRlc3RzIHdpdGhvdXQgcnVubmluZyBh
bnkgdGVzdHMuIiIiDQo+Pj4gKyAgICBleGVjdXRlX3NldHVwX2NvbW1vbigqYXJncywgKiprd2Fy
Z3MpDQo+Pj4gKw0KPj4+ICsjIFRoaXMgaXMgY2FsbGVkIGZyb20gc2NyaXB0LXN0eWxlIGlvdGVz
dHMgd2l0aCBhIHNpbmdsZSBwb2ludCBvZiBlbnRyeQ0KPj4+ICAgIGRlZiBzY3JpcHRfbWFpbih0
ZXN0X2Z1bmN0aW9uLCAqYXJncywgKiprd2FyZ3MpOg0KPj4+ICAgICAgICAiIiJSdW4gc2NyaXB0
LXN0eWxlIHRlc3RzIG91dHNpZGUgb2YgdGhlIHVuaXR0ZXN0IGZyYW1ld29yayIiIg0KPj4+ICAg
ICAgICBleGVjdXRlX3Rlc3QodGVzdF9mdW5jdGlvbiwgKmFyZ3MsICoqa3dhcmdzKQ0KPj4+ICAg
IA0KPj4+ICsjIFRoaXMgaXMgY2FsbGVkIGZyb20gdW5pdHRlc3Qgc3R5bGUgaW90ZXN0cw0KPj4+
ICAgIGRlZiBtYWluKCphcmdzLCAqKmt3YXJncyk6DQo+Pj4gICAgICAgICIiIlJ1biB0ZXN0cyB1
c2luZyB0aGUgdW5pdHRlc3QgZnJhbWV3b3JrIiIiDQo+Pg0KPj4NCj4+IEhtbSwgbm93IHR3byBk
aWZmZXJlbnQgc3R5bGVzIG9mIGNvZGUgZG9jdW1lbnRpbmcgdXNlZDogY29tbWVudCBhbmQgZG9j
LXN0cmluZywNCj4+IGJvdGggY29udGFpbmluZyBhbG1vc3QgZXF1YWwgbWVhbmluZy4uIEkgZG9u
J3QgbGlrZSBpdCwgc3RpbGwgZG9uJ3QgcmVhbGx5IG1pbmQuDQo+IA0KPiBJIHRoaW5rIEkgd2Fz
IHRyeWluZyB0byBkb2N1bWVudCB3aGF0IHRoZSBmdW5jdGlvbiAvZG9lcy8gc2VwYXJhdGVseQ0K
PiBmcm9tIGEgbm90ZSBhYm91dCBleHBsYWluaW5nIGhvdyBhbmQgd2hlcmUgaXQgaXMgdXNlZC4g
SXQncyBxdWl0ZSBuZWFybHkNCj4gcmVkdW5kYW50IGFuZCBpZiBpdCdzIGRpc3RyYWN0aW5nIEkg
Y2FuIHJlbW92ZSBpdC4NCj4gDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

