Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5458CC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 15:18:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CC50206EC
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 15:18:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="pf4J0M24"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CC50206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihxZd-0003QF-TK
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 10:18:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41137)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ihxYL-0002NT-KY
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 10:17:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ihxYJ-0008Sd-QG
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 10:17:25 -0500
Received: from mail-eopbgr30108.outbound.protection.outlook.com
 ([40.107.3.108]:31366 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1ihxYE-0008BZ-Il; Thu, 19 Dec 2019 10:17:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RhU1iAqNmwaeXu3Nscuomqo7AzYbIMzfY0G3o/SVdk8R4Fnya6ODJPpTheGxIVP7yRnYxxs9DLzs6HZwODAyw+C/E/Wsl3vUNB8hMNiLW6fplQG3zk6aYVnrRzjA8BgrZznvY9YQha1DEqtiDCNqRFyMWpOji850McVURBRCCNkkfcR+Xsp9f6+F1Ooj07eYPt1WvcAlGgT0p1XeLHSyf+i4B+Wz9XkzZcfc5+FoPpu6gLS/iZeGKTM+pCW+G+htcJZQywzHuqX+raV/gS+Mqldar7bxrrm1OQQIa3z3RW0vjzFPba0i6ahzpbEBfBdxYBafeBVdgTFVdluMEsmgYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/htC5IVqKjR4oSGHZMqP7E4FYq7S4TU9vOsRId59rdQ=;
 b=EE+at6bKYdZ/Tgk3ZOvd0hUqj0W3iof5wZVPLKNKtnkGCFsO366PZ/vrms844OZVz/xIVJRLM4KZzybxnXuciH3uZsjoNwjzUf2nZUNCcNkpZin+1LKLB/kDd+qEfqZilMFMwZ7At+3K+iaAe2VYHJO0I0SB66EQFVc402570C/tTMHB+7gbZYDj143YtZl/h0u464OrwcHN9b+zjFDY3FKJt0NMCs5uxP+o6SWBoAMtFri0qvKyBawzUymZ5CAfPClGqx/BC9TphaDUKZsaNUcCR3gjEH+QKJiLpeNamZgn1ZmnYSu8R3Q1HfI5zG4IptLY3Tjh21dxy/0T7UxtpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/htC5IVqKjR4oSGHZMqP7E4FYq7S4TU9vOsRId59rdQ=;
 b=pf4J0M24inSrQBy2ceQB+S8jWE63W9ZAoZkpS9YMwgLK4r1lZUloS5h3m7QSiEsfnPlrK4wzmVJnb4TxyNi89Xv8zUssT/pnBXBK/IqK55UJj/OADJiUWwugjHuAfZ1Y05JfC1M7U8w8COKU9UNXo6sJ2wrDXq19z8M7aZbweiw=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4582.eurprd08.prod.outlook.com (20.178.91.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.18; Thu, 19 Dec 2019 15:17:14 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2559.012; Thu, 19 Dec 2019
 15:17:14 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Nir Soffer <nsoffer@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH] block: nbd: Fix dirty bitmap context name
Thread-Topic: [PATCH] block: nbd: Fix dirty bitmap context name
Thread-Index: AQHVtmzMtpyWQS3Bp0OaQNZadGqOP6fBd04AgAAGUoCAAA9GgIAABQYA
Date: Thu, 19 Dec 2019 15:17:14 +0000
Message-ID: <ddf58827-72e8-f853-e6bc-05d19100c62d@virtuozzo.com>
References: <20191219125151.21482-1-nsoffer@redhat.com>
 <443c32b3-0e0c-ef9e-4d5b-9404b16eaa02@virtuozzo.com>
 <20191219140433.GK5230@linux.fritz.box>
 <CAMRbyyvqa1_3U=2Q7HmCrRcEq+yJjxUP7MM-GM5hUdrZw=yBOw@mail.gmail.com>
In-Reply-To: <CAMRbyyvqa1_3U=2Q7HmCrRcEq+yJjxUP7MM-GM5hUdrZw=yBOw@mail.gmail.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0502CA0018.eurprd05.prod.outlook.com
 (2603:10a6:3:e3::28) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191219181712365
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ee66d8fa-412c-4d6b-9ace-08d784968722
x-ms-traffictypediagnostic: AM6PR08MB4582:
x-microsoft-antispam-prvs: <AM6PR08MB4582B4A51668F30402E94053C1520@AM6PR08MB4582.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0256C18696
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(39840400004)(366004)(136003)(376002)(346002)(189003)(199004)(54906003)(110136005)(81156014)(316002)(478600001)(86362001)(8936002)(52116002)(186003)(66476007)(8676002)(6486002)(66556008)(64756008)(6506007)(53546011)(66446008)(66946007)(26005)(71200400001)(81166006)(4326008)(5660300002)(31696002)(2906002)(2616005)(6512007)(36756003)(31686004)(14143004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4582;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EcHi/8yeB+NYZz+hEmmIpeK9l8UYvgwMQb1rNgLQQXnazXCTx2E1DhSY+legL2TtMvIuBkbMkfElY0jAVoCmLNTHsTj40FHnGEJbhgAY3/ep+4iqbdjPl937Y6tENA5F1of7k9Fw044jo196AxJmxATXxxCXYJ5wy7LTNhL7k0kmmjHHO1MpTfAonvKUyQIHHIfXjXSvY9NTSPJ+d/dTYyYu87ziMyzGTwVhzNsJkQN7DY3IcHn7aFBq2SpJkFK0gYyk9jTDVHE93ARkc317IC1dPxQU+uzju14jSDBJIFKaDimdQqp6OLPfh2PNMJUBzEp2DwJitSRQled8UIjjV3D6VPhJsVOfxaAKu6eSpRVEyhWczOUiDR0bLXACps7w6yVdjwBFoM9F8g1FWpwXzF9cQQSM3PFCFYmFsOmsTvuP4x7lEOAAwaD74rGQi00iVuE+w03sjjZWtAkwyJOAgbrPGjdbsqLXGhtAY12Te8sUMB8stsOtxHokIdMCjYYh
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <7BE5076C4E7CDF45B4E5F96C2F9D576B@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee66d8fa-412c-4d6b-9ace-08d784968722
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2019 15:17:14.4776 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SBH5NhQCCHJQk7foF+kAzqDjHNCEWTZImjBR5kk4y95yOrJMw6a6UjjkGgKnHY7v2iiEeNPJKvV9K7mxnorHhrLuT6wX2K29BAoML6DqeHk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4582
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.3.108
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
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Nir Soffer <nirsof@gmail.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTkuMTIuMjAxOSAxNzo1OSwgTmlyIFNvZmZlciB3cm90ZToNCj4gT24gVGh1LCBEZWMgMTksIDIw
MTkgYXQgNDowNCBQTSBLZXZpbiBXb2xmIDxrd29sZkByZWRoYXQuY29tPiB3cm90ZToNCj4+DQo+
PiBBbSAxOS4xMi4yMDE5IHVtIDE0OjQxIGhhdCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5
IGdlc2NocmllYmVuOg0KPj4+IEFoaCwgSSBzZWUsIGl0J3MgZG9jdW1lbnRlZCBhcw0KPj4+DQo+
Pj4gKyMgQGJpdG1hcDogQWxzbyBleHBvcnQgdGhlIGRpcnR5IGJpdG1hcCByZWFjaGFibGUgZnJv
bSBAZGV2aWNlLCBzbyB0aGUNCj4+PiArIyAgICAgICAgICBOQkQgY2xpZW50IGNhbiB1c2UgTkJE
X09QVF9TRVRfTUVUQV9DT05URVhUIHdpdGgNCj4+PiArIyAgICAgICAgICAicWVtdTpkaXJ0eS1i
aXRtYXA6TkFNRSIgdG8gaW5zcGVjdCB0aGUgYml0bWFwLiAoc2luY2UgNC4wKQ0KPj4+DQo+Pj4g
YW5kIGl0IGlzIGxvZ2ljYWwgdG8gYXNzdW1lIHRoYXQgZXhwb3J0IG5hbWUgKHdoaWNoIGlzIEBu
YW1lIGFyZ3VtZW50KSBpcw0KPj4+IG1lbnRpb25lZC4gQnV0IHdlIG5ldmVyIG1lbnRpb25lZCBp
dC4gVGhpcyBpcyBqdXN0IGRvY3VtZW50ZWQgYWZ0ZXINCj4+PiByZW1vdmVkIGV4cGVyaW1lbmF0
bCBjb21tYW5kIHgtbmJkLXNlcnZlci1hZGQtYml0bWFwLA0KPj4+DQo+Pj4gbG9vayBhdA0KPj4+
DQo+Pj4gY29tbWl0IDdkYzU3MGIzODA2ZTViMGE0YzkyMTkwNjE1NTZlZDVhNGEwZGU4MGMNCj4+
PiBBdXRob3I6IEVyaWMgQmxha2UgPGVibGFrZUByZWRoYXQuY29tPg0KPj4+IERhdGU6ICAgRnJp
IEphbiAxMSAxMzo0NzoxOCAyMDE5IC0wNjAwDQo+Pj4NCj4+PiAgICAgICBuYmQ6IFJlbW92ZSB4
LW5iZC1zZXJ2ZXItYWRkLWJpdG1hcA0KPj4+DQo+Pj4gLi4uDQo+Pj4NCj4+PiAtIyBAYml0bWFw
LWV4cG9ydC1uYW1lOiBIb3cgdGhlIGJpdG1hcCB3aWxsIGJlIHNlZW4gYnkgbmJkIGNsaWVudHMN
Cj4+PiAtIyAgICAgICAgICAgICAgICAgICAgICAoZGVmYXVsdCBAYml0bWFwKQ0KPj4+IC0jDQo+
Pj4gLSMgTm90ZTogdGhlIGNsaWVudCBtdXN0IHVzZSBOQkRfT1BUX1NFVF9NRVRBX0NPTlRFWFQg
d2l0aCBhIHF1ZXJ5IG9mDQo+Pj4gLSMgInFlbXU6ZGlydHktYml0bWFwOk5BTUUiICh3aGVyZSBO
QU1FIG1hdGNoZXMgQGJpdG1hcC1leHBvcnQtbmFtZSkgdG8gYWNjZXNzDQo+Pj4gLSMgdGhlIGV4
cG9zZWQgYml0bWFwLg0KPj4+DQo+Pj4NCj4+PiBTbywgdGhpcyAiTkFNRSIgaXMgc2F2ZWQgYW5k
IG5vdyBsb29rcyBpbmNvcnJlY3QuIFdoYXQgc2hvdWxkIGJlIGZpeGVkLCBpcyBRYXBpDQo+Pj4g
ZG9jdW1lbnRhdGlvbi4NCj4+DQo+PiBIbSwgSSBkb24ndCBrbm93IHRoZXNlIGludGVyZmFjZXMg
dmVyeSB3ZWxsLCBidXQgZnJvbSB5b3UgZXhwbGFuYXRpb24gaXQNCj4+IGxvb2tzIHRvIG1lIGFz
IGlmIGhhdmluZyBhIGJpdG1hcCBuYW1lIG1hZGUgc2Vuc2Ugd2l0aA0KPj4geC1uYmQtc2VydmVy
LWFkZC1iaXRtYXAgYmVjYXVzZSBpdCBjb3VsZCBiZSBjYWxsZWQgbW9yZSB0aGFuIG9uY2UgZm9y
DQo+PiBleHBvcnRpbmcgbXVsdGlwbGUgYml0bWFwcy4NCj4+DQo+PiBCdXQgbm93LCB3ZSBoYXZl
IG9ubHkgbmJkLXNlcnZlci1hZGQsIHdoaWNoIHRha2VzIGEgc2luZ2xlIGJpdG1hcCBuYW1lLg0K
Pj4gQXMgd2UgZG9uJ3QgaGF2ZSB0byBkaXN0aW5ndWlzaCBtdWx0aXBsZSBiaXRtYXBzIGFueSBt
b3JlLCB3b3VsZG4ndCBpdA0KPj4gbWFrZSBtb3JlIHNlbnNlIHRvIHVzZSAicWVtdTpkaXJ0eS1i
aXRtYXAiIHdpdGhvdXQgYW55IG90aGVyDQo+PiBpbmZvcm1hdGlvbj8gQm90aCBleHBvcnQgbmFt
ZSBhbmQgYml0bWFwIG5hbWUgYXJlIGFscmVhZHkgaWRlbnRpZmllZCBieQ0KPj4gdGhlIGNvbm5l
Y3Rpb24uDQo+IA0KPiBXZSBjYW4gdXNlIGVtcHR5IHN0cmluZyAobGlrZSB0aGUgZGVmYXVsdCBl
eHBvcnQgbmFtZSksIHNvIHRoZSBiaXRtYXANCj4gd291bGQgYmUgZXhwb3NlZCBhczoNCj4gDQo+
ICAgICAgInFlbXU6ZGlydHktYml0bWFwOiINCj4gDQo+IFRoaXMgd291bGQgc29sdmUgdGhlIGlz
c3VlIGZvciB1c2VycywgYW5kIGtlZXAgdGhlIEFQSSBleHRlbnNpYmxlLg0KDQpBcyBJIGFscmVh
ZHkgc2FpZCwgd2UgY2FuIG5vdC4gSWYgd2UgcmVhbGx5IHdvbnQgc3VjaCB0aGluZywgdXNlIGFu
b3RoZXIgbmFtZSwNCmxpa3EgcWVtdTpkZWZhdWx0LWRpcnR5LWJpdG1hcC4uDQoNCk9yIGNhbGwg
Yml0bWFwIGV4cG9ydCAiZGVmYXVsdCIsIHRvIHByb2R1Y2UNCiAgInFlbXU6ZGlydHktYml0bWFw
czpkZWZhdWx0Ig0KDQpCdXQgZG9uJ3QgY2hhbmdlIGRlZmF1bHQgYmVoYXZpb3Igb2YgbmJkLXNl
cnZlci1hZGQNCg0KPiANCj4+IEJ1dCBpZiB3ZSBoYXZlIHRvIGhhdmUgc29tZXRoaW5nIHRoZXJl
LCB1c2luZyB0aGUgYml0bWFwIG5hbWUgKHdoaWNoIG1heQ0KPj4gb3IgbWF5IG5vdCBiZSB0aGUg
c2FtZSBhcyB1c2VkIGluIHRoZSBpbWFnZSBmaWxlKSBtYWtlcyBhIGxpdHRsZSBtb3JlDQo+PiBz
ZW5zZSBiZWNhdXNlIGl0IG1ha2VzIHRoZSBpbnRlcmZhY2UgZXh0ZW5zaWJsZSBmb3IgdGhlIGNh
c2UgdGhhdCB3ZQ0KPj4gZXZlciB3YW50IHRvIHJlLWludHJvZHVjZSBhbiBuYmQtc2VydmVyLWFk
ZC1iaXRtYXAuDQo+IA0KPiBCdXQgdXNpbmcgdGhlIGJpdG1hcCBuYW1lIG1lYW5zIHVzZXIgb2Yg
dGhlIE5CRCBzZXJ2ZXIgbmVlZCB0byBrbm93IHRoaXMgbmFtZS4NCg0KV2h5IG5vdD8gV2hhdCBp
cyB5b3VyIGNhc2UgZXhhY3RseT8gVXNlciBrbm93cywgd2hhdCBraW5kIG9mIGJpdG1hcCB5b3Ug
YXJlDQpleHBvcnRpbmcsIHNvIHVzZXIgaXMgaW4gc29tZSByZWxhdGlvbiB3aXRoIGV4cG9ydGlu
ZyBwcm9jZXNzIGFueXdheS4gV2h5DQpzaG91bGRuJ3QgaXQga25vdyB0aGUgbmFtZT8NCg0KVGhp
cyBuYW1lIG1heSBiZSBkZWZpbmVkIGluIHlvdSBleHBvcnRpbmcgcHJvdG9jb2wuLiBXaGF0IGFy
ZSB5b3UgZXhwb3J0aW5nPw0KDQpOb3RlIGFsc28sIHRoYXQgY2xpZW50IG1heSB1c2UgTkJEX09Q
VF9MSVNUX01FVEFfQ09OVEVYVCB3aXRoIHF1ZXJ5DQoicWVtdTpkaXJ0eS1iaXRtYXA6IiwgdG8g
Z2V0IGxpc3Qgb2YgYWxsIGV4cG9ydGVkIGJpdG1hcHMuDQoNCj4gDQo+IE9uZSBvcHRpb24gaXMg
dGhhdCBsaWJ2aXJ0IHdvdWxkIHB1Ymxpc2ggdGhlIG5hbWUgb2YgdGhlIGJpdG1hcCBpbiB0aGUN
Cj4geG1sIGRlc2NyaWJpbmcNCj4gdGhlIGJhY2t1cCwgYW5kIG9WaXJ0IHdpbGwgaGF2ZSB0byBw
cm9wYWdhdGUgdGhpcyBuYW1lIHRvIHRoZSBhY3R1YWwNCj4gcHJvZ3JhbSBhY2Nlc3NpbmcNCj4g
dGhlIE5CRCBzZXJ2ZXIsIHdoaWNoIG1heSBiZSBhIHVzZXIgcHJvZ3JhbSBpbiB0aGUgY2FzZSB3
aGVuIHdlIGV4cG9zZSB0aGUgTkJEDQo+IFVSTCB0byB1c2VycyAocGxhbm5lZCBmb3IgZnV0dXJl
IHZlcnNpb24pLg0KPiANCj4gQW5vdGhlciBvcHRpb24gaXMgdGhhdCB0aGUgdXNlciB3aWxsIGNv
bnRyb2wgdGhpcyBuYW1lLCBhbmQgbGlidmlydA0KPiB3aWxsIHVzZSB0aGUgbmFtZSBzcGVjaWZp
ZWQNCj4gYnkgdGhlIHVzZXIuIFRoaXMgbWVhbnMgb1ZpcnQgd2lsbCBoYXZlIHRvIHByb3ZpZGUg
QVBJIHRvIHNldCB0aGlzDQo+IG5hbWUgYW5kIHBhc3MgaXQgdG8gbGlidmlydC4NCj4gDQo+IEJv
dGggY2FzZXMgcmVxdWlyZSBsb3Qgb2YgZWZmb3J0IHdoaWNoIGRvZXMgbm90IGhlbHAgYW55b25l
IGluIHRoZQ0KPiB0YXNrIG9mIGdldHRpbmcgZGlydHkNCj4gZXh0ZW50cyBmcm9tIGFuIGltYWdl
IC0gd2hpY2ggaXMgb3VyIGN1cnJlbnQgZ29hbC4gV2UgbmVlZCB0byBoYXZlDQo+IGdvb2QgZGVm
YXVsdHMgdGhhdA0KPiBzYXZlIHVubmVlZGVkIGVmZm9ydCBpbiB0aGUgZW50aXJlIHN0YWNrLg0K
DQpTbywgeW91IGltcGxlbWVudGluZyBzb21lIHByb3RvY29sLCBhbmQgbmVlZCB0byBleHBvcnQg
b25seSBvbmUgYml0bWFwIGZvcg0KeW91ciBzcGVjaWZpZWQgc2NlbmFyaW8uIFdoeSBub3QganVz
dCBnaXZlIGEgY29uc3RhbnQgbmFtZT8gTGlrZSBvdmlydC1iaXRtYXAsDQpvciBzb21ldGhpbmcg
bGlrZSB0aGlzPw0KDQoob2YgY291cnNlLCB3ZSBuZWVkIG5ldyBvcHRpb25hbCBwYXJhbXRlciBl
eHBvcnQtYml0bWFwLW5hbWUgZm9yIG5iZC1zZXJ2ZXItYWRkLA0KYXMgSSBwcm9wb3Nlcywgb3Ig
cmVpbXBsZW1lbnQgbmJkLXNlcnZlci1hZGQtYml0bWFwKQ0KDQo+IA0KPj4gKEJ5IHRoZSB3YXks
IGV2ZW4gaWYgdGhlIHBhdGNoIHdlcmUgY29ycmVjdCwNCj4gDQo+IEkgZG9uJ3QgdGhpbmsgdGhp
cyBpcyBhYm91dCBjb3JyZWN0bmVzcywgYnV0IGhhdmluZyBiZXR0ZXIgZGVmYXVsdCBmb3IgdXNl
cnMuDQo+IA0KDQpDaGFuZ2luZyBkZWZhdWx0cyBhbHdheXMgYnJlYWtzIGV4aXN0aW5nIHVzZXJz
LiBGb3IgZXhhbXBsZSBWaXJ0dW96em8uIFdlIGxpdmUNCndpdGggdGhlc2UgZGVmYXVsdHMsIHlv
dSBjYW4ndCBqdXN0IGNoYW5nZSBpdCB3aXRob3V0IGFueSBuZXcgb3B0aW9uLi4gSSBob3BlLg0K
DQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

