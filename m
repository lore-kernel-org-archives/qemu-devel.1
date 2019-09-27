Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD45DC4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 08:39:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4D3E2075D
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 08:39:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="W1QNOlLs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4D3E2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDlmr-0004M6-Ef
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 04:39:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48163)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iDlks-0002ti-Tb
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 04:37:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iDlkr-0001bS-Em
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 04:37:34 -0400
Received: from mail-ve1eur03on0722.outbound.protection.outlook.com
 ([2a01:111:f400:fe09::722]:40418
 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iDlkq-0001Y0-Ri; Fri, 27 Sep 2019 04:37:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LRB2UgesN7+xHz0kXsVtzcqYHGE1p81CJarpG6P7K8CRnb3m51IIbGfKkcU/T3Jn0uTOuxgX+DJuyqSdHtSzUsZaoOys9/x3l9cDwya5ZCng2WuHMEsykoxLoW6wVTLFFlvq6oNB7wp3uf4paAemRVi320OjCfPppbF/lata3/1Dpkr6VH1aTRyL3KWI5N89RV9UHCdxDIj4nkI3RKHxe+MloeRtW+92VqmyV+lrIDsGBmeG1fdnq6YcDkLxzpOXJeU64BWL5ZVNvYaBYPkbXzf3cJ6HGB11njtQ+h5k6q7NtoRjYNQxjY+Fte2izX1YuABIs0b+4ceJWE4mMr2jzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWr2v7ADoFKLSYYwpXLqUqxdsSFC3yOwNj51z7GLcps=;
 b=RvrUmFYjRHK5giVUncqV6Ln81Pu+F7sI6EFqq/QGWTzJMSesxhjsjTcZA3OHKlEiHRuzkDep2nBZu4WPhbtV9wSy/bIMcSGn2nW5NLNFTnpel2sq9kYfqGC6NlDEOvI4lmeTGw03u12KRdYBi7SGBCHfcll7fFeBJojNBvSyMJrywUD2rRrluOXx4/hTKyQX1qM9m0pf4nd06pb6TK+GqvhM+Ljb7nTbvukRf4S+F6cx/D3K6+1Bzsi6P2iZfdpqfgffbr1d8LAhH+OPUSI7qEz5g/aseqtus5WlGfomAQm2+lhGtUi82Ns7j989vPywv5jTImmf5EvVDD8ZUeR3jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWr2v7ADoFKLSYYwpXLqUqxdsSFC3yOwNj51z7GLcps=;
 b=W1QNOlLsKcGof+lJJuwA9HZVRpSkCLkBHmwA5QYEm1A9binC5wEIPR0tMF3DKkg9VZZhONgUNWJXOkTEn/ApBN6yv8hdaNjeyMuoj8Sw9ZDPUE6LkYStV26HENFe+V6f20YrEYAfp5Y/F7qgREJX5+El8MwOjkdsVq778MjkDxE=
Received: from AM0PR08MB5491.eurprd08.prod.outlook.com (52.132.215.9) by
 AM0PR08MB4162.eurprd08.prod.outlook.com (20.178.118.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.18; Fri, 27 Sep 2019 08:37:30 +0000
Received: from AM0PR08MB5491.eurprd08.prod.outlook.com
 ([fe80::d552:8bd7:4773:3d75]) by AM0PR08MB5491.eurprd08.prod.outlook.com
 ([fe80::d552:8bd7:4773:3d75%2]) with mapi id 15.20.2305.017; Fri, 27 Sep 2019
 08:37:30 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH v3 0/3] proper locking on bitmap add/remove paths
Thread-Topic: [PATCH v3 0/3] proper locking on bitmap add/remove paths
Thread-Index: AQHVb40D+lVIaOhoW0m1fqZ3n3WCmqc+WnKAgADkCgA=
Date: Fri, 27 Sep 2019 08:37:30 +0000
Message-ID: <f1999d12-2c2b-452c-7013-98245d399383@virtuozzo.com>
References: <20190920082543.23444-1-vsementsov@virtuozzo.com>
 <d3ad51d9-9e11-6f08-caf1-9c189315d4ac@redhat.com>
In-Reply-To: <d3ad51d9-9e11-6f08-caf1-9c189315d4ac@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR09CA0064.eurprd09.prod.outlook.com
 (2603:10a6:7:3c::32) To AM0PR08MB5491.eurprd08.prod.outlook.com
 (2603:10a6:208:189::9)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190927113728149
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1e07838a-0595-4a1c-3421-08d74325ef10
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:AM0PR08MB4162; 
x-ms-traffictypediagnostic: AM0PR08MB4162:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR08MB4162E62089DBE10A3858EAEEC1810@AM0PR08MB4162.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0173C6D4D5
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(366004)(376002)(396003)(39850400004)(346002)(53754006)(189003)(199004)(86362001)(316002)(81156014)(186003)(7736002)(305945005)(76176011)(81166006)(446003)(4326008)(99286004)(66556008)(64756008)(107886003)(6436002)(66476007)(66946007)(66446008)(102836004)(26005)(6512007)(11346002)(6246003)(53546011)(386003)(6506007)(2616005)(14454004)(6486002)(5660300002)(54906003)(31686004)(14444005)(71200400001)(31696002)(2906002)(71190400001)(25786009)(36756003)(476003)(229853002)(3846002)(110136005)(486006)(8676002)(256004)(52116002)(6116002)(478600001)(2501003)(8936002)(66066001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB4162;
 H:AM0PR08MB5491.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BONTgOIsxBr6TK46tJCMcWBcvakCmrgflStHCJEICzyl3+am/EYBt8qWG6T30GWazzN8OUZc5Rh4/wfE4nlzB0U4G0/waOjJNy3qAGvaii/xuY0ZiGebKi7Hm8enswY7pdz+8XXsGIuTfhiok/A6Dpb9+wI7ZyG1Gz61+of9xh7aKahHe4XvMpvMloBygxLgw4p4RMDzwhdLZXJwBrJlegzXR6fvPCoe/+H6oEdKPOUVU/7TsVEOCVEs+5MapBqzgYREZs4PVYIeci9WmrB4LQk0DAHy9IOE1xEdj/jfPZ+niJT9rEUQ5RfD0KofAjLXbeIgRPZKRwhmXYChyKhs6FVYhG5U8RCkZtv960OFrbZIu+MMR87pSsRSHnXj1SeAy3+cxT8F2agZwOF3F6qNGN33DYuSIsBtIHR3DwhQciQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <99D3936EBEC2D74CB768DFBBA406EBC5@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e07838a-0595-4a1c-3421-08d74325ef10
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2019 08:37:30.1253 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N4xoupSsZEKy6g655ekswcoDl0mUgXmoySS5yP1iv1ii6vyqebG9/1XMOychkv+e1Njn3B8wGVcpa54hb01OC3Sz4Z6XUHmMwdsS1+dLvvE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4162
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe09::722
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
 Denis Lunev <den@virtuozzo.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjYuMDkuMjAxOSAyMjowMSwgSm9obiBTbm93IHdyb3RlOg0KPiANCj4gDQo+IE9uIDkvMjAvMTkg
NDoyNSBBTSwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IEhpIGFsbCEN
Cj4+DQo+PiBXZSBuZWVkIHRvIGxvY2sgcWNvdzIgbXV0ZXggb24gYWNjZXNzaW5nIGluLWltYWdl
IG1ldGFkYXRhLCBlc3BlY2lhbGx5DQo+PiBvbiB1cGRhdGluZyB0aGlzIG1ldGFkYXRhLiBMZXQn
cyBpbXBsZW1lbnQgaXQuDQo+Pg0KPj4gdjM6DQo+PiAwMTogYWRkIEpvaG4ncyByLWINCj4+IDAy
OiAtIGZpeCBiZHJ2X3JlbW92ZV9wZXJzaXN0ZW50X2RpcnR5X2JpdG1hcCByZXR1cm4gdmFsdWUN
Cj4+ICAgICAgLSBkcm9wIGV4dHJhIHplcm9pbmcgb2YgcmV0IGluIHFjb3cyX3JlbW92ZV9wZXJz
aXN0ZW50X2RpcnR5X2JpdG1hcA0KPj4gMDM6IGFkZCBKb2huJ3Mgci1iDQo+Pg0KPj4gVmxhZGlt
aXIgU2VtZW50c292LU9naWV2c2tpeSAoMyk6DQo+PiAgICBibG9jazogbW92ZSBiZHJ2X2Nhbl9z
dG9yZV9uZXdfZGlydHlfYml0bWFwIHRvIGJsb2NrL2RpcnR5LWJpdG1hcC5jDQo+PiAgICBibG9j
ay9kaXJ0eS1iaXRtYXA6IHJldHVybiBpbnQgZnJvbQ0KPj4gICAgICBiZHJ2X3JlbW92ZV9wZXJz
aXN0ZW50X2RpcnR5X2JpdG1hcA0KPj4gICAgYmxvY2svcWNvdzI6IHByb3BlciBsb2NraW5nIG9u
IGJpdG1hcCBhZGQvcmVtb3ZlIHBhdGhzDQo+Pg0KPj4gICBibG9jay9xY293Mi5oICAgICAgICAg
ICAgICAgIHwgIDE0ICsrLS0tDQo+PiAgIGluY2x1ZGUvYmxvY2svYmxvY2tfaW50LmggICAgfCAg
MTQgKystLS0NCj4+ICAgaW5jbHVkZS9ibG9jay9kaXJ0eS1iaXRtYXAuaCB8ICAgNSArLQ0KPj4g
ICBibG9jay5jICAgICAgICAgICAgICAgICAgICAgIHwgIDIyIC0tLS0tLS0NCj4+ICAgYmxvY2sv
ZGlydHktYml0bWFwLmMgICAgICAgICB8IDExOSArKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKystLQ0KPj4gICBibG9jay9xY293Mi1iaXRtYXAuYyAgICAgICAgIHwgIDM2ICsrKysrKyst
LS0tDQo+PiAgIGJsb2NrL3Fjb3cyLmMgICAgICAgICAgICAgICAgfCAgIDUgKy0NCj4+ICAgYmxv
Y2tkZXYuYyAgICAgICAgICAgICAgICAgICB8ICAyOCArKystLS0tLS0NCj4+ICAgOCBmaWxlcyBj
aGFuZ2VkLCAxNjMgaW5zZXJ0aW9ucygrKSwgODAgZGVsZXRpb25zKC0pDQo+Pg0KPiANCj4gSSds
bCB0YWtlIHRoaXM7IEkgaW1hZ2luZSB0aGUgcmV0dXJuIHNpZ25hdHVyZXMgYXJlIGdvaW5nIHRv
IGNoYW5nZQ0KPiBhZ2FpbiB3aXRoIHlvdXIgZXJyb3IgcHJvcGFnYXRpb24gc2VyaWVzLCB0aG91
Z2ggLi4uPw0KPiANCg0KVGhhbmtzIGEgbG90IQ0KDQpIbW0sIEkgZG9uJ3QgdGhpbmsgc28sIGFz
IEkgdXNlZCB0byB0aGluayB0aGF0IHJldHVybmluZyBpbnQgZm9yIGVycnAtZnVuY3Rpb25zDQpp
cyBiZXR0ZXIgYW55d2F5Li4NCg0KcmV0ID0gZiguLi4sIGVycnApOw0KaWYgKHJldCA8IDApIHsN
Cg0KfQ0KDQp2cw0KDQpmKC4uLiwgZXJycCk7DQppZiAoKmVycnApIHsNCg0KfQ0KDQpIbW1tLi4u
IFRoZSBsYXR0ZXIganVzdCBsb29rcyB1bmZhbWlsaWFyIGluIGNvbXBhcmlzb24gd2l0aCAiaWYg
KHJldCA8IDApIi4uIEJ1dA0KaWYgd2UgYW55d2F5IGdvaW5nIHRvIGNvbnZlcnQgYSBsb3Qgb2Yg
ImlmICgqbG9jYWxfZXJyKSIgdG8gImlmICgqZXJycCkiLCBpdCB3aWxsDQpiZWNvbWUgZmFtaWxp
YXIuLiBBbmQgdGhlIGxhdHRlciBtYXkgc2F2ZSA2IGNoYXJhY3RlcnMgaW4gYSBsaW5lIHdpdGgg
ZnVuY3Rpb24gY2FsbCwNCndoaWNoIG1heSBzYXZlIHRoZSB3aG9sZSBsaW5lIGluIHNvbWUgcGxh
Y2VzLg0KDQpTbyBJIGRvbid0IGtub3cuDQoNCnJldHVybmluZyB0d28gZXJyb3JzIGlzIG5vdCB2
ZXJ5IGdvb2QsIHdlIGRvbid0IGhhdmUgY29udmVudGlvbiBmb3IgaXQgYWN0dWFsbHkuDQoNCmlm
IEkgaGF2ZSBpbnQgcmV0ID0gZiguLi4sIGVycnApLCB3aGF0IHNob3VsZCBJIHJlcG9ydD8NCg0K
ZXJyb3JfcmVwb3J0X2Vycl9lcnJubyhyZXQsIGVycnApLCBvciBqdXN0IGVycm9yX3JlcG9ydF9l
cnIoZXJycCksIGFzc3VtaW5nIGVycnANCmNvbnRhaW5zIHRoZSB3aG9sZSBpbmZvcm1hdGlvbj8N
Cg0KU3RpbGwsIHNvbWV0aW1lcyB3ZSBuZWVkIHRvIGRpc3Rpbmd1aXNoIG9uZSBlcnJvciBjb2Rl
IGZyb20gYW5vdGhlciwgYW5kIHdlIGNhbid0DQpjaGVjayBlcnJwIGZvciBzdWNoIHRoaW5nLi4N
Cg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

