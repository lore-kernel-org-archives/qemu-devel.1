Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB733C4360C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 09:23:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94D5420862
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 09:23:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="CembG8O+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94D5420862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43657 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGJnq-000067-OY
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 05:23:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49692)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iGJmZ-0007oJ-1n
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 05:21:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iGJmX-0002ef-Bt
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 05:21:50 -0400
Received: from mail-eopbgr20091.outbound.protection.outlook.com
 ([40.107.2.91]:65494 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iGJmW-0002aJ-GQ; Fri, 04 Oct 2019 05:21:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DzjZLvPdsQqK+J8pTi2WT2naHypKJxhio7oeHEmvV39mhhr1hUswybWG+TraRHHurw/pG5JaHbxGbrtKkisfJI9xgBsZYjiOLuvMcKMbfq+VRICntGYq7PHskGbqyT457pTnov3EkmmbzeNO4qj8elAjEQ+y8M/9EPv7BV8Btm+0DPRL7MxfXo5V+W49caDBW4kG/WN7YbHoTEhkIpStK09C5yE1pTxZWOaJbeg3KYVxISQ1kzXeMAIT/qZ8c2kXiRJfcaYe3vrANOykuHCfRYdqxBLHdJVxjjz2CMetckTxfBcFSPsgbk+JBTgO1P6vj0IlP/i1fRejyTXwPNnaYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=APeCJ1+Yd2KHJ7ngFufPNtsfi4TF13zJuEqQlhPeeIg=;
 b=e978+cpsO9KPCFOq2Nl9Yr5XhNdscEaAm6JC9BgyJCAJIM4SAyVgWivmm67Qe5wEYm3/Mw68RAiqJgbMYKUrITsZnRi4GmHtdLr7xhPgnmQKAQrhYOXi2+ueK/Y7X/6PwFaI+zZ45Bpt+IfcdQzoOmZFJjT9WhZVGi5Gx2UnHL4qeUt5RBY3e2VTd6Lboswc2vc1bdUrCM/rd3F5YfiPJodeM8OVxLlYS7s87w0AJradG7EmaymmhzJziP/X9XU19l3VyfPQKlKIIxTo8+WSIu0jRcyVedauhP5HAl61oodHfH1q0iVs8n1Um4LNSdB8Zsh7l+q5KOC+muB38CB0eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=APeCJ1+Yd2KHJ7ngFufPNtsfi4TF13zJuEqQlhPeeIg=;
 b=CembG8O+kEYpHqli8UoIVKF9O+hPnBkhErGdPykK+YHKsTVUnIuqejFmVreFe5sWeunfCWp/nloNNrJleQmdmFi+elmrP4rD5Wywo4kweNbrb6Ayy/N82uz+wD65Lau3n74F03QG/xJkelILZcQ4uDx/7zbVlewBW/PnIzkyOTs=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5418.eurprd08.prod.outlook.com (52.133.241.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Fri, 4 Oct 2019 09:21:45 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f%2]) with mapi id 15.20.2305.023; Fri, 4 Oct 2019
 09:21:44 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Peter Krempa <pkrempa@redhat.com>, John Snow <jsnow@redhat.com>
Subject: Re: bitmap migration bug with -drive while block mirror runs
Thread-Topic: bitmap migration bug with -drive while block mirror runs
Thread-Index: AQHVd+yDiWNDoVbdB0u/++2NVEJq8qdF0TUAgAAC+ICAAB3ngIAAAtYAgAE4ZQCAALVxAIAA1AEAgADfuQCAAJZegIAADZKA
Date: Fri, 4 Oct 2019 09:21:44 +0000
Message-ID: <c211158a-d3fd-3f30-02f8-3785c2f72b1f@virtuozzo.com>
References: <315cff78-dcdb-a3ce-2742-da3cc9f0ca97@redhat.com>
 <d897c755-40e7-6392-23e3-c06b1a371f28@virtuozzo.com>
 <4bc910ef-0bec-cfd6-89f6-a93d35367218@redhat.com>
 <9431d242-bfe1-b9db-17d0-6c1a280a05da@virtuozzo.com>
 <e112c85a-684f-5721-2da7-d23312c9e487@redhat.com>
 <20191002104600.GC6129@angien.pipo.sk>
 <73dcfdd5-ede2-250e-4680-7c1408c5a3c3@redhat.com>
 <7b0ea320-4c77-2b0f-7f12-615aa0a6d8cd@virtuozzo.com>
 <53da72e0-d265-8d0f-e47c-8338c43081e3@redhat.com>
 <20191004083307.GI6129@angien.pipo.sk>
In-Reply-To: <20191004083307.GI6129@angien.pipo.sk>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0153.eurprd05.prod.outlook.com
 (2603:10a6:7:28::40) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191004122141427
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5200dc1a-665a-4e45-8f7e-08d748ac460e
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:DB8PR08MB5418; 
x-ms-traffictypediagnostic: DB8PR08MB5418:
x-microsoft-antispam-prvs: <DB8PR08MB54183EE67AF4249002332C97C19E0@DB8PR08MB5418.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 018093A9B5
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39850400004)(396003)(346002)(136003)(376002)(366004)(189003)(199004)(478600001)(64756008)(53546011)(14444005)(7736002)(316002)(25786009)(66946007)(71200400001)(66476007)(36756003)(102836004)(31686004)(6506007)(386003)(446003)(6512007)(6116002)(71190400001)(110136005)(8676002)(54906003)(26005)(81166006)(186003)(6486002)(14454004)(8936002)(305945005)(66446008)(86362001)(486006)(99286004)(2616005)(52116002)(3846002)(5660300002)(81156014)(256004)(561944003)(66556008)(476003)(6246003)(66066001)(6436002)(2906002)(4326008)(229853002)(31696002)(11346002)(76176011);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5418;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bgNYRQfkInn/zYO64luWbWfwUAkSNM8ge1HrePiv60G9fqz4jsy9lUglJ/jkEK4mGANkMtySt0CJqV33rsFmalzL0vTmnLUL6kkbyEaNuAppns6cLJpiIQyPYCvZT6pYOnIaLxp6QAQULsFxrAqcPYuwQsUiJERseW254RRD+U+ebzCaXf038oY7132Cf5UqJXxaYmTiE1YJlfha6h2mtvsk0yXX+oh3SHx6dnGgHVzSrApq00Reqm40nBY9NVJApV9LopO0eChr05DFf7COzmZth4QXrdzRciEPimON13QTOWu/STpZZSrYH1Ee8UR6YG+16g0euRBTUm83wUNTO2tLXhMJarJw1zmpbm24AFFt1Modtc2W39l+21XcP+SU+lMbZmDQ8UENlOxusM+SISjYlYVeszpVqPmQtOX8um0=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <4EC1ED11E408A94D869DE956C38329B6@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5200dc1a-665a-4e45-8f7e-08d748ac460e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2019 09:21:44.5910 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UFZyYNgzYDQrSG7d3nKVJDGLzgYeuyfuRU0wpfBsWpF6ZqCpkjyFQ56C5tHsWOT+ylkiREMw+sS4XsGNgY4xTr6tej/qjVXlnd32qoTqj68=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5418
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.2.91
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
Cc: qemu-devel <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDQuMTAuMjAxOSAxMTozMywgUGV0ZXIgS3JlbXBhIHdyb3RlOg0KPiBPbiBUaHUsIE9jdCAwMywg
MjAxOSBhdCAxOTozNDo1NiAtMDQwMCwgSm9obiBTbm93IHdyb3RlOg0KPj4gT24gMTAvMy8xOSA2
OjE0IEFNLCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdyb3RlOg0KPj4+IDAzLjEwLjIw
MTkgMDozNSwgSm9obiBTbm93IHdyb3RlOg0KPj4+PiBPbiAxMC8yLzE5IDY6NDYgQU0sIFBldGVy
IEtyZW1wYSB3cm90ZToNCj4+PiA9PT09DQo+IA0KPiBbLi4uXQ0KPiANCj4gKEknbSBzb3JyeSBp
ZiBJIGlnbm9yZWQgc29tZXRoaW5nIHdoaWNoIG1pZ2h0IHJlcXVpcmUgaW5wdXQgaW4gdGhlDQo+
IHRyaW1tZWQgcGFydCBidXQgSSBkb24ndCBoYXZlIGVub3VnaCBtZW50YWwgY2FwYWNpdHkgdG8g
Zm9sbG93IHRoaXMNCj4gdGhyZWFkIGZ1bGx5KQ0KPiANCj4+Pg0KPj4+IElmIGl0J3MgYSBwcm9i
bGVtIGZvciBsaWJ2aXJ0IHRvIGtlZXAgc2FtZSBub2RlLW5hbWVzLCB3aHkgc2hvdWxkIHdlIGlu
c2lzdD8NCj4+Pg0KPj4+DQo+Pg0KPj4gSXMgaXQgcmVhbGx5IGEgcHJvYmxlbT8gSWYgbGlidmly
dCByZXF1ZXN0cyBtaWdyYXRpb24gb2YgYml0bWFwcywgdGhvc2UNCj4+IGJpdG1hcHMgbmVlZCB0
byBnbyBzb21ld2hlcmUuIEV2ZW4gaWYgaXQgY29uc3RydWN0cyBhIGRpZmZlcmVudCBncmFwaA0K
Pj4gZm9yIHZhbGlkIHJlYXNvbnMsIGl0IHNob3VsZCBzdGlsbCB1bmRlcnN0YW5kIHdoaWNoIHFj
b3cyIG5vZGVzDQo+PiBjb3JyZWxhdGUgdG8gd2hpY2ggb3RoZXIgcWNvdzIgbm9kZXMgYW5kIG5h
bWUgdGhlbSBhY2NvcmRpbmdseS4NCj4gDQo+IFdlbGwsIG5vIGl0IGlzIG5vdCBhIHByb2JsZW0u
IFNpbmNlIGJpdG1hcCBtaWdyYXRpb24gaGFzIGEgbWlncmF0aW9uDQo+IGNhcGFiaWxpdHkgYW5k
IGxpYnZpcnQgYnkgZGVmYXVsdCBkaXNhYmxlcyBhbGwgdW5rbm93biBtaWdyYXRpb24NCj4gY2Fw
YWJpbGl0aWVzIHdlIGNhbiBkZWFsIHdpdGggaXQuDQo+IA0KPiBXZSBoYXZlIG1lYXN1cmVzIHRv
IHRyYW5zZmVyIHN0YXRlIHRvIHRoZSBkZXN0aW5hdGlvbiB3ZSBjYW4NCj4gYmFzaWNhbGx5IGRv
IHRoZSBlcXVpdmFsZW50IG9mIHRoZSBleHBsaWNpdCBtYXBwaW5nIGJ1dCB3aXRoIGV4dHJhDQo+
IHN0ZXBzLg0KPiANCj4gV2Uga25vdyB3aGVyZSB3ZSB3YW50IHRvIHBsYWNlIHRoZSBiaXRtYXAg
YW5kIHRodXMgd2UgY2FuIGNvbmZpZ3VyZQ0KPiB0aG9zZSBub2RlcyBhcHByb3ByaWF0ZWx5IGFu
ZCBnZW5lcmF0ZSBuZXcgbmFtZXMgZm9yIGV2ZXJ5dGhpbmcgZWxzZSBzbw0KPiB0aGF0IG5vdGhp
bmcgZ2V0cyBhY2NpZGVudGFsbHkgY29waWVkIHRvIHdyb25nIHBsYWNlLg0KPiANCj4gTXkgY29u
Y2VybiBpcyB0aG91Z2ggYWJvdXQgdGhlIGZ1dHVyZS4gU2luY2UgdGhpcyBpcyB0aGUgZmlyc3Qg
aW5zdGFuY2UNCj4gb2Ygc3VjaCBhICBtaWdyYXRpb24gZmVhdHVyZSB3aGljaCByZXF1aXJlcyBu
b2RlIG5hbWVzIGl0J3Mgb2theSBiZWNhdXNlDQo+IHdlIGNhbiBjaGVhdCBieSBuYW1pbmcgdGhl
IGRlc3RpbmF0aW9uICJhcHByb3ByaWF0ZWx5Ii4gVGhlIHByb2JsZW0NCj4gd2lsbCBzdGFydCB0
aG91Z2ggaWYgdGhlcmUgd2lsbCBiZSBzb21ldGhpbmcgZWxzZSBib3VuZCB0byB0aGUgYmFja2Vu
ZA0KPiBvZiBhIGRpc2sgYWRkcmVzc2VkIGJ5IG5vZGUgbmFtZXMgd2hpY2ggd2lsbCBoYXZlIGRp
ZmZlcmVudCBzZW1hbnRpY3MuDQo+IA0KPiBJbiB0aGF0IGNhc2Ugd2Ugd29uJ3QgYmUgYWJsZSB0
byBjaGVhdCBhZ2Fpbi4NCj4gDQo+IExldCdzIGFzc3VtZSB0aGUgZm9sbG93aW5nIGV4YW1wbGU6
DQo+IA0KPiBxZW11IGFkZHMgYSBuZXcgZmVhdHVyZSBvZiBtaWdyYXRpbmcgdGhlIHFjb3cyIEwy
IGNhY2hlLiBUaGlzIHdpbGwNCj4gb2J2aW91c2x5IGhhdmUgZGlmZmVyZW50IGltcGxpY2F0aW9u
cyBvbiB3aGVuIGl0IGNhbiBiZSB1c2VkIHRoYW4NCj4gYml0bWFwcy4NCj4gDQo+IElmIHdlJ2Qg
bGlrZSB0byB1c2UgZWl0aGVyIG9mIHRoZSBmZWF0dXJlcyBidXQgbm90IGJvdGggdG9nZXRoZXIg
b24gYQ0KPiBub2RlIHRoZXJlIHdvdWxkbid0IGJlIGEgcG9zc2liaWxpdHkgdG8gYWNoaWV2ZSB0
aGF0Lg0KPiANCj4gVGhlIHRoaW5nIGFib3V0IGJpdG1hcHMgaXMgdGhhdCB0aGV5IGFyZSBub3Qg
cmVhbGx5IGJvdW5kIHRvIHRoZSBpbWFnZQ0KPiBpdHNlbGYgYnV0IHJhdGhlciB0aGUgZGF0YSBp
biB0aGUgaW1hZ2UuIEFzIGxvbmcgYXMgdGhlIHVzZXIgcHJvdmlkZXMgYQ0KPiBpbWFnZSB3aXRo
IGV4YWN0bHkgdGhlIHNhbWUgY29udGVudHMgdGhlIFZNIGNhbiB1c2UgaXQgYW5kIHRoZSBiaXRt
YXANCj4gd2lsbCBiZSBjb3JyZWN0IGZvciBpdC4NCj4gDQo+IFdlIHVzZSB0aGlzIGluIG5vbi1z
aGFyZWQgc3RvcmFnZSBtaWdyYXRpb24gd2hlcmUgd2UgYnkgZGVmYXVsdCBmbGF0dGVuDQo+IHRo
ZSBiYWNraW5nIGNoYWluIGludG8gYSBuZXcgaW1hZ2UuIEluIHN1Y2ggY2FzZSBhIGJpdG1hcCBp
cyBzdGlsbCB2YWxpZA0KPiBidXQgdGhlIGNhY2hlIGluIHRoZSBoeXBvdGhldGljYWwgZXhhbXBs
ZSBpcyBub3QgdmFsaWQgdG8gYmUgY29waWVkIG92ZXINCj4gZm9yIHRoZSBzYW1lIG5vZGUgbmFt
ZS4NCj4gDQo+IEF0IHRoZSB2ZXJ5IGxlYXN0IHRoZSBudWFuY2VzIG9mIHRoZSBjYXBhYmlsaXR5
IHNob3VsZCBiZSBkb2N1bWVudGVkIHNvDQo+IHRoYXQgd2UgZG9uJ3QgaGF2ZSB0byBzZWNvbmQg
Z3Vlc3Mgd2hhdCBpcyBnb2luZyB0byBoYXBwZW4uDQo+IA0KPj4gSSBkb24ndCBzZWUgd2h5IHRo
aXMgaXMgYWN0dWFsbHkgYSB0ZXJyaWJsZSBjb25zdHJhaW50LiBFdmVuIGluIG91cg0KPj4gbWFw
cGluZyBwcm9wb3NhbCB3ZSdyZSBzdGlsbCB1c2luZyBub2RlLW5hbWVzLg0KPj4NCj4+DQo+PiBT
byBoZXJlJ3MgYSBzdW1tYXJ5IG9mIHdoZXJlIEkgc3RhbmQgcmlnaHQgbm93Og0KPj4NCj4+IC0g
SSB3YW50IGFuIEFQSSBpbiBRRU1VIHRoYXQgZG9lc24ndCByZXF1aXJlIGxpYnZpcnQuDQo+Pg0K
Pj4gLSBJIHdhbnQgdG8gYWNjb21tb2RhdGUgbGlidmlydCwgYnV0IGRvbid0IHVuZGVyc3RhbmQg
dGhlIHJlcXVpcmVtZW50DQo+PiB0aGF0IG5vZGUtbmFtZXMgbXVzdCBiZSBlcGhlbWVyYWwuDQo+
IA0KPiBBcyBJJ3ZlIG91dGxpbmVkIGFib3ZlLCB0aGUgbm9kZSBuYW1lcyBtdXN0IG5vdCBiZSBl
cGhlbWVyYWwgYnV0IG9uIHRoZQ0KPiBzYW1lIG5vdGUgaXQncyB0aGVuIG5lY2Vzc2FyeSB0byBj
bGFyaWZ5IHdoZW4gdGhleSBtdXN0IGJlIHN0YWJsZQ0KPiBhY2Nyb3NzIG1pZ3JhdGlvbiBhbmQg
d2hlbiB0aGV5IG11c3QgYmUgZGlmZmVyZW50Lg0KPiANCj4gSW4gdGhlIGFib3ZlIGV4YW1wbGUg
SSdtIG91dGxpbmluZyBhbiBpbWFnZSB3aGljaCBoYXMgdGhlIHNhbWUgZGF0YSBidXQNCj4gaXQn
cyBhIGRpZmZlcmVudCBpbWFnZSAoaXQgd2FzIGNvbnZlcnRlZCBmb3IgZXhhbXBsZSkuIEluIHRo
YXQgY2FzZSB0aGUNCj4gYml0bWFwIG1pZ3JhdGlvbiB3b3VsZCBpbXBseSB0aGUgc2FtZSBub2Rl
IG5hbWUsIGJ1dCBhdCB0aGUgc2FtZSB0aW1lDQo+IHRoZSBpbWFnZSBpcyBjb21wbGV0ZWx5IGRp
ZmZlcmVudCBhbmQgYW55IG90aGVyIGZlYXR1cmUgbWF5IGJlDQo+IGluY29tcGF0aWJsZSB3aXRo
IGl0Lg0KPiANCj4gVGhlIHNhbWUgaXMgcG9zc2libGUgZS5nLiB3aGVuIHlvdSBoYXZlIG11bHRp
cGxlIHByb3RvY29scyB0byBhY2Nlc3MgdGhlDQo+IHNhbWUgZGF0YSBhcmUgdGhleSB0aGUgc2Ft
ZSB0aGluZyBhbmQgdGh1cyB3YXJyYW50IHRoZSBzYW1lIG5vZGUgbmFtZT8NCj4gb3IgYXJlIHRo
ZXkgZGlmZmVyZW50Lg0KPiANCj4gVHJlYXRpbmcgbm9kZSBuYW1lcyBhcyBlcGhlbWVyYWwgaGFz
IHRoZSBhZHZhbnRhZ2Ugb2Ygbm90IHRyeWluZyB0bw0KPiBhc3N1bWUgdGhlIGVxdWl2YWxlbmNl
IG9mIHRoZSBpbWFnZXMgb24gdGhlIG1pZ3JhdGlvbiBjaGFubmVsIGFuZCBub3QNCj4gaGF2aW5n
IHRvIHRyeSB0byBmaWd1cmUgb3V0IHdoZXRoZXIgdGhleSBhcmUgImV1cWl2YWxlbnQgZW5vdWdo
IiBmb3IgdGhlDQo+IGdpdmVuIGZlYXR1cmUuDQo+IA0KPj4NCj4+IC0gSSB3b3VsZCBsaWtlIHRv
IGRlZmluZSBhIHNldCBvZiBkZWZhdWx0IGJlaGF2aW9ycyAod2hlbiBiaXRtYXANCj4+IG1pZ3Jh
dGlvbiBpcyBlbmFibGVkKSB0aGF0IG1pZ3JhdGVzIG9ubHkgYml0bWFwcyBpdCBpcyBjb25maWRl
bnQgaXQgY2FuDQo+PiBkbyBzbyBjb3JyZWN0bHkgYW5kIGVycm9yIG91dCB3aGVuIGl0IGNhbm5v
dC4NCj4gDQo+IFRoaXMgcmVxdWlyZXMgYWxzbyBkZWZpbmluZyBhIHNldCBvZiBleHRlcm5hbCBj
b25zdHJhaW50cyB3aGVuIGl0IHdpbGwNCj4gd29yay4gTm90ZSB0aGF0IHRoZXkgY2FuIGRpZmZl
ciB3aXRoIG90aGVyIGZlYXR1cmVzLg0KPiANCj4+DQo+PiAtIEknZCBsaWtlIHRvIGFtZW5kIHRo
ZSBiaXRtYXAgZGV2aWNlIG5hbWUgcmVzb2x1dGlvbiB0byBhY2NvbW1vZGF0ZSB0aGUNCj4+IGRy
aXZlLW1pcnJvciBjYXNlLg0KPj4NCj4+IC0gQWNrbm93bGVkZ2luZyB0aGF0IHRoZXJlIG1pZ2h0
IGJlIGNhc2VzIHdoZXJlIHRoZSBkZWZhdWx0cyBqdXN0IHNpbXBseQ0KPj4gYXJlbid0IHBvd2Vy
ZnVsIGVub3VnaCwgYWxsb3cgYSBtYW51YWwgY29uZmlndXJhdGlvbiB0aGF0IGFsbG93cyB1cyB0
bw0KPj4gc2VsZWN0IG9yIGRlc2VsZWN0IGJpdG1hcHMgYW5kIGV4cGxpY2l0bHkgc2V0IHRoZWly
IGRlc3RpbmF0aW9uIG5vZGUtbmFtZS4NCj4gDQo+IFRoaXMgdGFuZ2VudGlhbGx5IGJyaW5ncyBt
ZSB0byBhbm90aGVyIHF1ZXN0aW9uLiBJbiBjYXNlIHdoZW4gdGhlDQo+IGRlc3RpbmF0aW9uIGlt
YWdlIGFscmVhZHkgY29udGFpbnMgYSBiaXRtYXAgd2l0aCB0aGUgc2FtZSBuYW1lLCB3aWxsIHRo
ZQ0KPiBtaWdyYXRpb24gb2YgYml0bWFwcyBvdmVyd3JpdGUgaXQgb3IgbWVyZ2Ugd2l0aCBpdD8N
Cg0KSXQgd2lsbCBmYWlsIGlmIGJpdG1hcCBhbHJlYWR5IGV4aXN0cy4NCg0KPiANCj4gVGhpcyBp
cyBhZ2FpbiBvbmUgdGhpbmcgdGhhdCBzaG91bGQgYmUgZG9jdW1lbnRlZC4NCj4gDQo+IEluIHRo
ZSBvdXRsaW5lZCBjYXNlIG9mIG5vbi1zaGFyZWQgc3RvcmFnZSBtaWdyYXRpb24gbGlidmlydCB3
b3VsZA0KPiBvYnZpb3VzbHkgcHJlZmVyIG1lcmdlIG9yIGhhdmluZyBpdCBjb25maWd1cmFibGUs
IGJ1dCBhcyBzYWlkLCB3ZSBoYXZlDQo+IG1lYW5zIHRvIHdvcmsgdGhpcyBhcm91bmQgYnkgcmVu
YW1pbmcgdGhlIGJpdG1hcCB0ZW1wb3JhcmlseSAgZHVyaW5nDQo+IG1pZ3JhdGlvbiBhbmQgdGhl
biBtZXJnaW5nIGl0IGV4cGxpY2l0bHkuDQo+IA0KDQpXaHkgbWVyZ2U/IHNvdXJjZSBhbmQgZGVz
dGluYXRpb24gZGlza3MgYXJlIG5vdCBtZXJnZWQsIGJ5IGRlc3RpbmF0aW9uIGlzIHJlcGxhY2Vk
DQpieSBzb3VyY2UuLi4NCg0KQW5kIHdoZXJlIGZyb20gd2lsbCB5b3UgaGF2ZSBiaXRtYXBzIGlu
IGRlc3RpbmF0aW9uPw0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

