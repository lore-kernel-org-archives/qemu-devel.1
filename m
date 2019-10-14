Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 041E4C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 09:08:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFAB9207FF
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 09:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="g8TswlMB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFAB9207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJwKr-00008w-T0
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 05:08:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58398)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iJwK7-00089L-ID
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 05:07:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iJwK6-0003BA-35
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 05:07:27 -0400
Received: from mail-eopbgr10131.outbound.protection.outlook.com
 ([40.107.1.131]:54020 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iJwK5-00039D-9x
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 05:07:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jFTuely1hTTOdIoWKRS5ouHE+NWDHSs0Fs31k7JjD9+iuUPI1gDnBPoN7bHjaF0UkXm4b8v+7SmD3w1jChU+gVqTNemru9EUcMIgTawQOHm0SCkHGRjpw7C+c07we20Gclzr4KA8A+3SYjyKMCpMOs1CekkRMx7ypoij6Gg4jaqlWI0tYHoS9Sg2SjLLTJ8KGauqIQ2fTHU4t1Qf3Fo9/wRtML7JFeShp8RjWYlpr8EHAmkEMWMqfDrmv0r3Z7Exl0W+0J4b429cdhjhtTBzWJIBQJZFXiihAPrRovLpSWzyTSk3s5cBk+OEXDeWxHUNy+5TVqMpM/WJp0jBNEkCmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bOivhlhLBeZs6yoOW2sM/PMkeAwWXadp4Dew1RR8WGg=;
 b=dV3ViQTz8guDN58EB8htL1CWs0k413HzUg1StafN+imYb+ezCpQH7cTjkBO4Rabe+lHM1zWmml0S9lBdr4Abv2uNorcRiv6YIHXFzLjD3Eo6lgpHiI2rj1o19xeGNYaeNM5Uoo5l96QKLetlbINbqZ0jJFDngyc85G8UIVWZZXvWe3oEomup/5RROJL1733k+3XKlq+K0tcrx9c7U0/NenpCxfbknwfGKQObPh/D5/IYGc/O6pXtJiM4Xcg5NTZCXmmvxoVURe0iU8Y3f/1tUeAXZibJMI5XWHGtHHX/77X0X10MY/yGzSYcq79BS1khL0uj2MwCb/chmBMga9GwqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bOivhlhLBeZs6yoOW2sM/PMkeAwWXadp4Dew1RR8WGg=;
 b=g8TswlMBtAI2iR6bUBfRnafvPR2OZTFhiE5bkxWiZ81YboJ50jF/NoyH//+ekw8uAMwwUfJA0pEmN9oPxe0eFk8Z1IIo4oP2KLHANN/Tmn+/b+5NOmazkbg6C7Kzft4XMN71hX3+Jy5LDx7Kekq8cvJQ02GsDa1sCeEyxihc6dE=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5275.eurprd08.prod.outlook.com (10.255.19.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.22; Mon, 14 Oct 2019 09:07:22 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f%2]) with mapi id 15.20.2347.021; Mon, 14 Oct 2019
 09:07:22 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [RFC v5 121/126] hw/sd/ssi-sd.c: introduce ERRP_AUTO_PROPAGATE
Thread-Topic: [RFC v5 121/126] hw/sd/ssi-sd.c: introduce ERRP_AUTO_PROPAGATE
Thread-Index: AQHVgFAeU/NDl8/6KE+3Ou+1v7KVfqdWjTeAgANPtwA=
Date: Mon, 14 Oct 2019 09:07:22 +0000
Message-ID: <8af36e08-26ce-4a49-00f8-a50affe0132f@virtuozzo.com>
References: <20191011160552.22907-1-vsementsov@virtuozzo.com>
 <20191011160552.22907-122-vsementsov@virtuozzo.com>
 <fe720ff6-0949-fced-8d33-2e8dcb5d568a@redhat.com>
In-Reply-To: <fe720ff6-0949-fced-8d33-2e8dcb5d568a@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0402CA0016.eurprd04.prod.outlook.com
 (2603:10a6:3:d0::26) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191014120718607
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6dd3ae1f-3da2-4e92-2dbc-08d75085ec23
x-ms-traffictypediagnostic: DB8PR08MB5275:
x-microsoft-antispam-prvs: <DB8PR08MB5275538B149F7B83134A2503C1900@DB8PR08MB5275.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 01901B3451
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(376002)(346002)(39840400004)(136003)(366004)(189003)(199004)(186003)(2906002)(316002)(6246003)(66066001)(5660300002)(110136005)(3846002)(54906003)(36756003)(8936002)(6512007)(6116002)(2616005)(476003)(14444005)(26005)(81156014)(81166006)(11346002)(66446008)(64756008)(66946007)(66476007)(66556008)(446003)(256004)(4326008)(52116002)(71200400001)(99286004)(71190400001)(305945005)(8676002)(7736002)(76176011)(102836004)(386003)(486006)(53546011)(6486002)(6506007)(6436002)(2501003)(478600001)(86362001)(31696002)(229853002)(31686004)(25786009)(14454004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5275;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GTHv1c0oYTVMbPDMjfIR0O/uOvfdMkH1bHkiG8yRnqPRCIpGPGfHbDfGpiAaFuUbLAH2Gr6ZjokdbPWjoOhwePFcd6okPoFJDebaX20dhwtZ1La+LsSEpuzBhy7OZNZ6BeodWNdtZOOjR+61nU91mtuQRwt7AygacWRU/CmJAJE+revMvLZDcELl0VW9il06hgLrcjFBZaHMG/W7ncCNM9hSp6WIjGJnoR3i7PEya7jZjfZ2BpjWadWL6Zf9dwCvt3aJIOM5og/erLtyIQkgiXcvKYgw7SwaAzFgaX/0zCa1nB+xRgOHW/AkxXscuISRFrJJph1oG0eYYKHZKIU2Y6+SISw02W7xMC4wuk7cjUv7jNnqQbQ4ngcUjJm8Ih7xqnpo7NYgr/mLvZ+MngCEPz2mEX1qiB61VKZ+MiBNGtU=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E531E926FF039A4E86C195989B1B5567@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dd3ae1f-3da2-4e92-2dbc-08d75085ec23
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2019 09:07:22.0937 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2P45UkeZ/a0xaSbTWtyKhnSonospQ/KIIkF/95VzgliCOqAcXZj48VggWHmdFr64onXL4a0k9QidYwjB5k6pHf6EuX1bIvLZKTWBL6I0PhI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5275
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.131
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

MTIuMTAuMjAxOSA5OjMzLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4gT24gMTAv
MTEvMTkgNjowNSBQTSwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IElm
IHdlIHdhbnQgdG8gYWRkIHNvbWUgaW5mbyB0byBlcnJwIChieSBlcnJvcl9wcmVwZW5kKCkgb3IN
Cj4+IGVycm9yX2FwcGVuZF9oaW50KCkpLCB3ZSBtdXN0IHVzZSB0aGUgRVJSUF9BVVRPX1BST1BB
R0FURSBtYWNyby4NCj4+IE90aGVyd2lzZSwgdGhpcyBpbmZvIHdpbGwgbm90IGJlIGFkZGVkIHdo
ZW4gZXJycCA9PSAmZmF0YWxfZXJyDQo+PiAodGhlIHByb2dyYW0gd2lsbCBleGl0IHByaW9yIHRv
IHRoZSBlcnJvcl9hcHBlbmRfaGludCgpIG9yDQo+PiBlcnJvcl9wcmVwZW5kKCkgY2FsbCkuwqAg
Rml4IHN1Y2ggY2FzZXMuDQo+Pg0KPj4gSWYgd2Ugd2FudCB0byBjaGVjayBlcnJvciBhZnRlciBl
cnJwLWZ1bmN0aW9uIGNhbGwsIHdlIG5lZWQgdG8NCj4+IGludHJvZHVjZSBsb2NhbF9lcnIgYW5k
IHRoYW4gcHJvcGFnYXRlIGl0IHRvIGVycnAuIEluc3RlYWQsIHVzZQ0KPj4gRVJSUF9BVVRPX1BS
T1BBR0FURSBtYWNybywgYmVuZWZpdHMgYXJlOg0KPj4gMS4gTm8gbmVlZCBvZiBleHBsaWNpdCBl
cnJvcl9wcm9wYWdhdGUgY2FsbA0KPj4gMi4gTm8gbmVlZCBvZiBleHBsaWNpdCBsb2NhbF9lcnIg
dmFyaWFibGU6IHVzZSBlcnJwIGRpcmVjdGx5DQo+PiAzLiBFUlJQX0FVVE9fUFJPUEFHQVRFIGxl
YXZlcyBlcnJwIGFzIGlzIGlmIGl0J3Mgbm90IE5VTEwgb3INCj4+IMKgwqDCoCAmZXJyb3JfZmF0
ZWwsIHRoaXMgbWVhbnMgdGhhdCB3ZSBkb24ndCBicmVhayBlcnJvcl9hYm9ydA0KPj4gwqDCoMKg
ICh3ZSdsbCBhYm9ydCBvbiBlcnJvcl9zZXQsIG5vdCBvbiBlcnJvcl9wcm9wYWdhdGUpDQo+Pg0K
Pj4gVGhpcyBjb21taXQgKHRvZ2V0aGVyIHdpdGggaXRzIG5laWdoYm9ycykgd2FzIGdlbmVyYXRl
ZCBieQ0KPj4NCj4+IGZvciBmIGluICQoZ2l0IGdyZXAgLWwgZXJycCBcKi5bY2hdKTsgZG8gXA0K
Pj4gwqDCoMKgwqAgc3BhdGNoIC0tc3AtZmlsZSBzY3JpcHRzL2NvY2NpbmVsbGUvYXV0by1wcm9w
YWdhdGVkLWVycnAuY29jY2kgXA0KPj4gwqDCoMKgwqAgLS1tYWNyby1maWxlIHNjcmlwdHMvY29j
Y2ktbWFjcm8tZmlsZS5oIC0taW4tcGxhY2UgLS1uby1zaG93LWRpZmYgJGY7IFwNCj4+IGRvbmU7
DQo+Pg0KPj4gdGhlbiBmaXggYSBiaXQgb2YgY29tcGlsYXRpb24gcHJvYmxlbXM6IGNvY2NpbmVs
bGUgZm9yIHNvbWUgcmVhc29uDQo+PiBsZWF2ZXMgc2V2ZXJhbA0KPj4gZigpIHsNCj4+IMKgwqDC
oMKgIC4uLg0KPj4gwqDCoMKgwqAgZ290byBvdXQ7DQo+PiDCoMKgwqDCoCAuLi4NCj4+IMKgwqDC
oMKgIG91dDoNCj4+IH0NCj4+IHBhdHRlcm5zLCB3aXRoICJvdXQ6IiBhdCBmdW5jdGlvbiBlbmQu
DQo+Pg0KPj4gdGhlbg0KPj4gLi9weXRob24vY29tbWl0LXBlci1zdWJzeXN0ZW0ucHkgTUFJTlRB
SU5FUlMgIiQoPCBhdXRvLW1zZykiDQo+Pg0KPj4gKGF1dG8tbXNnIHdhcyBhIGZpbGUgd2l0aCB0
aGlzIGNvbW1pdCBtZXNzYWdlKQ0KPj4NCj4+IFN0aWxsLCBmb3IgYmFja3BvcnRpbmcgaXQgbWF5
IGJlIG1vcmUgY29tZm9ydGFibGUgdG8gdXNlIG9ubHkgdGhlIGZpcnN0DQo+PiBjb21tYW5kIGFu
ZCB0aGVuIGRvIG9uZSBodWdlIGNvbW1pdC4NCj4+DQo+PiBSZXBvcnRlZC1ieTogS2V2aW4gV29s
ZiA8a3dvbGZAcmVkaGF0LmNvbT4NCj4+IFJlcG9ydGVkLWJ5OiBHcmVnIEt1cnogPGdyb3VnQGth
b2Qub3JnPg0KPj4gU2lnbmVkLW9mZi1ieTogVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSA8
dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPg0KPj4gLS0tDQo+PiDCoCBody9zZC9zc2ktc2QuYyB8
IDE0ICsrKysrKysrLS0tLS0tDQo+PiDCoCAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCsp
LCA2IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9ody9zZC9zc2ktc2QuYyBiL2h3
L3NkL3NzaS1zZC5jDQo+PiBpbmRleCA5MWRiMDY5MjEyLi5mNDIyMDRkNjQ5IDEwMDY0NA0KPj4g
LS0tIGEvaHcvc2Qvc3NpLXNkLmMNCj4+ICsrKyBiL2h3L3NkL3NzaS1zZC5jDQo+PiBAQCAtMjQx
LDEwICsyNDEsMTAgQEAgc3RhdGljIGNvbnN0IFZNU3RhdGVEZXNjcmlwdGlvbiB2bXN0YXRlX3Nz
aV9zZCA9IHsNCj4+IMKgIHN0YXRpYyB2b2lkIHNzaV9zZF9yZWFsaXplKFNTSVNsYXZlICpkLCBF
cnJvciAqKmVycnApDQo+PiDCoCB7DQo+PiArwqDCoMKgIEVSUlBfQVVUT19QUk9QQUdBVEUoKTsN
Cj4+IMKgwqDCoMKgwqAgc3NpX3NkX3N0YXRlICpzID0gRlJPTV9TU0lfU0xBVkUoc3NpX3NkX3N0
YXRlLCBkKTsNCj4+IMKgwqDCoMKgwqAgRGV2aWNlU3RhdGUgKmNhcmRkZXY7DQo+PiDCoMKgwqDC
oMKgIERyaXZlSW5mbyAqZGluZm87DQo+PiAtwqDCoMKgIEVycm9yICplcnIgPSBOVUxMOw0KPj4g
wqDCoMKgwqDCoCBxYnVzX2NyZWF0ZV9pbnBsYWNlKCZzLT5zZGJ1cywgc2l6ZW9mKHMtPnNkYnVz
KSwgVFlQRV9TRF9CVVMsDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBERVZJQ0UoZCksICJzZC1idXMiKTsNCj4+IEBAIC0yNTQsMTIgKzI1NCwx
NCBAQCBzdGF0aWMgdm9pZCBzc2lfc2RfcmVhbGl6ZShTU0lTbGF2ZSAqZCwgRXJyb3IgKiplcnJw
KQ0KPj4gwqDCoMKgwqDCoCBkaW5mbyA9IGRyaXZlX2dldF9uZXh0KElGX1NEKTsNCj4+IMKgwqDC
oMKgwqAgY2FyZGRldiA9IHFkZXZfY3JlYXRlKEJVUygmcy0+c2RidXMpLCBUWVBFX1NEX0NBUkQp
Ow0KPj4gwqDCoMKgwqDCoCBpZiAoZGluZm8pIHsNCj4+IC3CoMKgwqDCoMKgwqDCoCBxZGV2X3By
b3Bfc2V0X2RyaXZlKGNhcmRkZXYsICJkcml2ZSIsIGJsa19ieV9sZWdhY3lfZGluZm8oZGluZm8p
LCAmZXJyKTsNCj4+ICvCoMKgwqDCoMKgwqDCoCBxZGV2X3Byb3Bfc2V0X2RyaXZlKGNhcmRkZXYs
ICJkcml2ZSIsIGJsa19ieV9sZWdhY3lfZGluZm8oZGluZm8pLA0KPj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBlcnJwKTsNCj4gDQo+IFRo
aXMgZml0cyA3MiBjaGFycywgY2FuIHlvdSBrZWVwIGl0IGluIHRoZSBzYW1lIGxpbmU/DQoNCkhv
bmVzdGx5LCBJJ2QgcHJlZmVyIG5vdCBmaXhpbmcgY29kZSBzdHlsZSBpbiB0aGVzZSAxMDAgYXV0
by1nZW5lcmF0ZWQgY29tbWl0cy4uLg0KQnV0IGlmIG9ubHkgeW91IHJlcXVlc3QgdGhpcywgaXQn
cyBub3QgYSBwcm9ibGVtLg0KDQo+IA0KPj4gwqDCoMKgwqDCoCB9DQo+PiAtwqDCoMKgIG9iamVj
dF9wcm9wZXJ0eV9zZXRfYm9vbChPQkpFQ1QoY2FyZGRldiksIHRydWUsICJzcGkiLCAmZXJyKTsN
Cj4+IC3CoMKgwqAgb2JqZWN0X3Byb3BlcnR5X3NldF9ib29sKE9CSkVDVChjYXJkZGV2KSwgdHJ1
ZSwgInJlYWxpemVkIiwgJmVycik7DQo+PiAtwqDCoMKgIGlmIChlcnIpIHsNCj4+IC3CoMKgwqDC
oMKgwqDCoCBlcnJvcl9zZXRnKGVycnAsICJmYWlsZWQgdG8gaW5pdCBTRCBjYXJkOiAlcyIsIGVy
cm9yX2dldF9wcmV0dHkoZXJyKSk7DQo+PiArwqDCoMKgIG9iamVjdF9wcm9wZXJ0eV9zZXRfYm9v
bChPQkpFQ1QoY2FyZGRldiksIHRydWUsICJzcGkiLCBlcnJwKTsNCj4+ICvCoMKgwqAgb2JqZWN0
X3Byb3BlcnR5X3NldF9ib29sKE9CSkVDVChjYXJkZGV2KSwgdHJ1ZSwgInJlYWxpemVkIiwgZXJy
cCk7DQo+PiArwqDCoMKgIGlmICgqZXJycCkgew0KPj4gK8KgwqDCoMKgwqDCoMKgIGVycm9yX3Nl
dGcoZXJycCwgImZhaWxlZCB0byBpbml0IFNEIGNhcmQ6ICVzIiwNCj4+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZXJyb3JfZ2V0X3ByZXR0eSgqZXJycCkpOw0KPiANCj4g
RGl0dG8uLi4NCj4gDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuOw0KPj4gwqDCoMKgwqDC
oCB9DQo+PiDCoCB9DQo+Pg0KPiANCj4gSWYgcG9zc2libGUgcGxlYXNlIHNxdWFzaCB3aXRoICI0
Ny8xMjYgU0QgKFNlY3VyZSBDYXJkKSINCg0KSG1tIHRoaXMgaXMgaW4gc2VwYXJhdGUsIGFzIGl0
J3MgdW5tYWludGFpbmVkIGFjY29yZGluZ2x5IHRvIE1BSU5UQUlORVJTLiBJJ2xsIHJlYmFzZQ0K
dGhlIG5leHQgdmVyc2lvbiBvbiB5b3VyIE1BSU5UQUlORVJTLWZpeGVzIGFuZCBpdCBzaG91bGQg
d29yay4NCg0KPiANCj4gUmV2aWV3ZWQtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGls
bWRAcmVkaGF0LmNvbT4NCg0KVGhhbmtzIQ0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWly
DQo=

