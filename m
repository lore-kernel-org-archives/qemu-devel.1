Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2EC8ECE58C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 08:34:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CB0220679
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 08:34:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="EvOdg/Tm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CB0220679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIqNL-0003t3-7F
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 04:34:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44227)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iIqMM-000387-Mw
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 04:33:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iIqML-0007bo-7M
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 04:33:14 -0400
Received: from mail-db5eur03on070c.outbound.protection.outlook.com
 ([2a01:111:f400:fe0a::70c]:35707
 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iIqMK-0007Zr-FW; Fri, 11 Oct 2019 04:33:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zg8bS/Rr2lqUKFqh989BQR4Jmp42byo8jhLD6GInvr4za+jDAGnbPVmYt2TIs1q9ZqSdkX/UpQBGUkrvkGMGkc/rgUi8UHfi2sOMNVUHEVlQy8kC3nFfCTfWsrTa8ChGlG6r3z0g3CQR756W+8jC/fH1qBCKozL0nG2LNjzsTDltXXew+lBy0wRBKGbqjrSG+biZW+RDY1irBB26aP3YzRBSlIoT7Z0XA03g+7nN736HHtxRUxxA5MLYQzg07TogoN+Og9ScdmXm6XIi++9uC6Rqq3HWzIO/J4ZNTxwEaw6bvM70Dk6g8urd3fbtxCgTrfxEe3nRX1zpNHYtgVN+4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=InWFVk6Rpn9jI/rspUnCREB73yoMNwB69Ft3K+WoRio=;
 b=LSiSdS8zuOsUWNk9KG+nJxybHG78y/gSTP3YPPhTBPCVbeyNQW7h6tDsIjEX48PIWCiWlPcNBo31sP/oLJZSzwy2Jp7mrUMqsdYKJMVB1AA0L8MqYLR0HY6TVml99Mj9qjFsc1VNiwiVpSLlzpxPGRvRRKYYoA9G9GyCuzeYidDe1OMMrVhJFCgcfAgR1XVTPhtHYR43M78tsYJotKg55PGq25X3T3R0ZDEmt43uPZTWSCGPWNfW8xWuZ9aEERblNIzqFEMVEeo9xCP6dLzwBGYF22yKD8dtWNphX8YZKxqeIjuNVg9MEjNh/P91OcwCpAupp3OPkBvXH9MSoUhHTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=InWFVk6Rpn9jI/rspUnCREB73yoMNwB69Ft3K+WoRio=;
 b=EvOdg/TmfnmzkpjcoCk4gmwRKYgNk9g9+n44AOKJNtbM2wqMUiMpJNY9GOsce5dxlEV7hYIgrz9s21qq/q0/pCwAZ6bSH1HngWmz6yYn9Uw+ptE164LTfVk/HIJFWVmAXLJSyVUG775YDlmbLH62uG0aJN9q5vRFnNweDnTMJr4=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB3932.eurprd08.prod.outlook.com (20.179.8.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.21; Fri, 11 Oct 2019 08:33:09 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f%2]) with mapi id 15.20.2347.021; Fri, 11 Oct 2019
 08:33:08 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH 3/4] block/mirror: support unaligned write in active mirror
Thread-Topic: [PATCH 3/4] block/mirror: support unaligned write in active
 mirror
Thread-Index: AQHVaXyqGWMlukZLJkOXoRVirVbRLqdKz3mAgAp6joA=
Date: Fri, 11 Oct 2019 08:33:08 +0000
Message-ID: <eb11dfe2-fe3b-54bf-a23f-b9d208690680@virtuozzo.com>
References: <20190912151338.21225-1-vsementsov@virtuozzo.com>
 <20190912151338.21225-4-vsementsov@virtuozzo.com>
 <6fd6a449-0443-ecfa-0eec-23e3b515b303@redhat.com>
In-Reply-To: <6fd6a449-0443-ecfa-0eec-23e3b515b303@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0237.eurprd05.prod.outlook.com
 (2603:10a6:3:fb::13) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191011113305410
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 54920725-4808-41ef-a1a1-08d74e25a522
x-ms-traffictypediagnostic: DB8PR08MB3932:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB3932AB6BD0FAB6780E2F4AADC1970@DB8PR08MB3932.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:489;
x-forefront-prvs: 0187F3EA14
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(396003)(39830400003)(136003)(366004)(346002)(189003)(199004)(256004)(14444005)(5660300002)(8676002)(81156014)(81166006)(8936002)(66066001)(52116002)(11346002)(2906002)(102836004)(486006)(446003)(476003)(26005)(36756003)(71190400001)(71200400001)(2501003)(478600001)(53546011)(2616005)(6506007)(386003)(14454004)(76176011)(186003)(4326008)(99286004)(66946007)(66556008)(6512007)(54906003)(3846002)(31696002)(6116002)(66476007)(66446008)(64756008)(31686004)(110136005)(229853002)(6486002)(305945005)(7736002)(6436002)(86362001)(6246003)(25786009)(107886003)(316002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB3932;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mUTLyHmJ6TRRHJfkFYXPdp7qDHCmunj4MRt3lska04GhlPxPY6ZOhQ50tYheRapJXdSCY+0ITGIO0T3YRA2ule++Tem8nzp3K3PNXJziq6+ABzErEut/y9+eO1Z16LN0o9VVbuMSx2uCTNCPSQPEETe5YHOtcTe4N/O/slpIQDoNR/hgvPhfVe3AG7Y2OGZ6zFvaXa0ja6agURbOjKWgYDbQUQEhQeWMDWgwBqtiF64S/rTUnrO8DhFEXROLpsfhgFZPj3KJFgDVX5as1D2JegLClj9o7/YL7AgkHV2BX76fdC2w7QdCyZFG1ZGldjHlq2I/CDVEn2dGJW+G4Do0QaI8rO1dWz/o5dIBSjpUxAYIFPXaOjreNCL6yg78IYCV1sjKBUxopLHsml12WojCUcqFA6CxECFQmmTIHvjPoDE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A9BD73D4DC80E84DA4E3920042CC3C58@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54920725-4808-41ef-a1a1-08d74e25a522
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2019 08:33:08.9152 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e1DZYj109GgsCxY8oqeKrgMIlGvgC7Qq/fIMXR20QZlIthu2b6sDeY5Dy2eJU1eiz3fJM0e/IFCeynCXt8dAjai9ES9VDZLMVX5hzgT1kOg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB3932
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe0a::70c
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
 "jsnow@redhat.com" <jsnow@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDQuMTAuMjAxOSAxOTozMSwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAxMi4wOS4xOSAxNzoxMywg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IFByaW9yIDlhZGMxY2I0OWFm
OGQgZG9fc3luY190YXJnZXRfd3JpdGUgaGFkIGEgYnVnOiBpdCByZXNldCBhbGlnbmVkLXVwDQo+
PiByZWdpb24gaW4gdGhlIGRpcnR5IGJpdG1hcCwgd2hpY2ggbWVhbnMgdGhhdCB3ZSBtYXkgbm90
IGNvcHkgc29tZSBieXRlcw0KPj4gYW5kIGFzc3VtZSB0aGVtIGNvcGllZCwgd2hpY2ggYWN0dWFs
bHkgbGVhZHMgdG8gcHJvZHVjaW5nIGNvcnJ1cHRlZA0KPj4gdGFyZ2V0Lg0KPj4NCj4+IFNvIDlh
ZGMxY2I0OWFmOGQgZm9yY2VkIGRpcnR5IGJpdG1hcCBncmFudWxhcml0eSB0byBiZQ0KPj4gcmVx
dWVzdF9hbGlnbm1lbnQgZm9yIG1pcnJvci10b3AgZmlsdGVyLCBzbyB3ZSBhcmUgbm90IHdvcmtp
bmcgd2l0aA0KPj4gdW5hbGlnbmVkIHJlcXVlc3RzLiBIb3dldmVyIGZvcmNpbmcgbGFyZ2UgYWxp
Z25tZW50IG9idmlvdXNseSBkZWNyZWFzZXMNCj4+IHBlcmZvcm1hbmNlIG9mIHVuYWxpZ25lZCBy
ZXF1ZXN0cy4NCj4+DQo+PiBUaGlzIGNvbW1pdCBwcm92aWRlcyBhbm90aGVyIHNvbHV0aW9uIGZv
ciB0aGUgcHJvYmxlbTogaWYgdW5hbGlnbmVkDQo+PiBwYWRkaW5nIGlzIGFscmVhZHkgZGlydHks
IHdlIGNhbiBzYWZlbHkgaWdub3JlIGl0LCBhcw0KPj4gMS4gSXQncyBkaXJ0eSwgaXQgd2lsbCBi
ZSBjb3BpZWQgYnkgbWlycm9yX2l0ZXJhdGlvbiBhbnl3YXkNCj4+IDIuIEl0J3MgZGlydHksIHNv
IHNraXBwaW5nIGl0IG5vdyB3ZSBkb24ndCBpbmNyZWFzZSBkaXJ0aW5lc3Mgb2YgdGhlDQo+PiAg
ICAgYml0bWFwIGFuZCB0aGVyZWZvcmUgZG9uJ3QgZGFtYWdlICJzeW5jaHJvbmljaXR5IiBvZiB0
aGUNCj4+ICAgICB3cml0ZS1ibG9ja2luZyBtaXJyb3IuDQo+Pg0KPj4gSWYgdW5hbGlnbmVkIHBh
ZGRpbmcgaXMgbm90IGRpcnR5LCB3ZSBqdXN0IHdyaXRlIGl0LCBubyByZWFzb24gdG8gdG91Y2gN
Cj4+IGRpcnR5IGJpdG1hcCBpZiB3ZSBzdWNjZWVkIChvbiBmYWlsdXJlIHdlJ2xsIHNldCB0aGUg
d2hvbGUgcmVnaW9uDQo+PiBvZmNvdXJzZSwgYnV0IHdlIGxvc3MgInN5bmNocm9uaWNpdHkiIG9u
IGZhaWx1cmUgYW55d2F5KS4NCj4+DQo+PiBOb3RlOiB3ZSBuZWVkIHRvIGRpc2FibGUgZGlydHlf
Yml0bWFwLCBvdGhlcndpc2Ugd2Ugd2lsbCBub3QgYmUgYWJsZSB0bw0KPj4gc2VlIGluIGRvX3N5
bmNfdGFyZ2V0X3dyaXRlIGJpdG1hcCBzdGF0ZSBiZWZvcmUgY3VycmVudCBvcGVyYXRpb24uIFdl
DQo+PiBtYXkgb2YgY291cnNlIGNoZWNrIGRpcnR5IGJpdG1hcCBiZWZvcmUgdGhlIG9wZXJhdGlv
biBpbg0KPj4gYmRydl9taXJyb3JfdG9wX2RvX3dyaXRlIGFuZCByZW1lbWJlciBpdCwgYnV0IHdl
IGRvbid0IG5lZWQgYWN0aXZlDQo+PiBkaXJ0eSBiaXRtYXAgZm9yIHdyaXRlLWJsb2NraW5nIG1p
cnJvciBhbnl3YXkuDQo+Pg0KPj4gTmV3IGNvZGUtcGF0aCBpcyB1bnVzZWQgdW50aWwgdGhlIGZv
bGxvd2luZyBjb21taXQgcmV2ZXJ0cw0KPj4gOWFkYzFjYjQ5YWY4ZC4NCj4+DQo+PiBTdWdnZXN0
ZWQtYnk6IERlbmlzIFYuIEx1bmV2IDxkZW5Ab3BlbnZ6Lm9yZz4NCj4+IFNpZ25lZC1vZmYtYnk6
IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4N
Cj4+IC0tLQ0KPj4gICBibG9jay9taXJyb3IuYyB8IDM5ICsrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrLQ0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMzggaW5zZXJ0aW9ucygrKSwg
MSBkZWxldGlvbigtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9ibG9jay9taXJyb3IuYyBiL2Jsb2Nr
L21pcnJvci5jDQo+PiBpbmRleCBkMTc2YmY1OTIwLi5kMTkyZjZhOTZiIDEwMDY0NA0KPj4gLS0t
IGEvYmxvY2svbWlycm9yLmMNCj4+ICsrKyBiL2Jsb2NrL21pcnJvci5jDQo+PiBAQCAtMTIwNCw2
ICsxMjA0LDM5IEBAIGRvX3N5bmNfdGFyZ2V0X3dyaXRlKE1pcnJvckJsb2NrSm9iICpqb2IsIE1p
cnJvck1ldGhvZCBtZXRob2QsDQo+PiAgICAgICAgICAgICAgICAgICAgICAgIFFFTVVJT1ZlY3Rv
ciAqcWlvdiwgaW50IGZsYWdzKQ0KPj4gICB7DQo+PiAgICAgICBpbnQgcmV0Ow0KPj4gKyAgICBz
aXplX3QgcWlvdl9vZmZzZXQgPSAwOw0KPj4gKw0KPj4gKyAgICBpZiAoIVFFTVVfSVNfQUxJR05F
RChvZmZzZXQsIGpvYi0+Z3JhbnVsYXJpdHkpICYmDQo+PiArICAgICAgICBiZHJ2X2RpcnR5X2Jp
dG1hcF9nZXQoam9iLT5kaXJ0eV9iaXRtYXAsIG9mZnNldCkpIHsNCj4+ICsgICAgICAgICAgICAv
Kg0KPj4gKyAgICAgICAgICAgICAqIERpcnR5IHVuYWxpZ25lZCBwYWRkaW5nDQo+PiArICAgICAg
ICAgICAgICogMS4gSXQncyBhbHJlYWR5IGRpcnR5LCBubyBkYW1hZ2UgdG8gImFjdGl2ZWx5X3N5
bmNlZCIgaWYgd2UganVzdA0KPj4gKyAgICAgICAgICAgICAqICAgIHNraXAgdW5hbGlnbmVkIHBh
cnQuDQo+PiArICAgICAgICAgICAgICogMi4gSWYgd2UgY29weSBpdCwgd2UgY2FuJ3QgcmVzZXQg
Y29ycmVzcG9uZGluZyBiaXQgaW4NCj4+ICsgICAgICAgICAgICAgKiAgICBkaXJ0eV9iaXRtYXAg
YXMgdGhlcmUgbWF5IGJlIHNvbWUgImRpcnR5IiBieXRlcyBzdGlsbCBub3QNCj4+ICsgICAgICAg
ICAgICAgKiAgICBjb3BpZWQuDQo+PiArICAgICAgICAgICAgICogU28sIGp1c3QgaWdub3JlIGl0
Lg0KPj4gKyAgICAgICAgICAgICAqLw0KPj4gKyAgICAgICAgICAgIHFpb3Zfb2Zmc2V0ID0gUUVN
VV9BTElHTl9VUChvZmZzZXQsIGpvYi0+Z3JhbnVsYXJpdHkpIC0gb2Zmc2V0Ow0KPj4gKyAgICAg
ICAgICAgIGlmIChieXRlcyA8PSBxaW92X29mZnNldCkgew0KPj4gKyAgICAgICAgICAgICAgICAv
KiBub3RoaW5nIHRvIGRvIGFmdGVyIHNocmluayAqLw0KPj4gKyAgICAgICAgICAgICAgICByZXR1
cm47DQo+PiArICAgICAgICAgICAgfQ0KPj4gKyAgICAgICAgICAgIG9mZnNldCArPSBxaW92X29m
ZnNldDsNCj4+ICsgICAgICAgICAgICBieXRlcyAtPSBxaW92X29mZnNldDsNCj4+ICsgICAgfQ0K
Pj4gKw0KPj4gKyAgICBpZiAoIVFFTVVfSVNfQUxJR05FRChvZmZzZXQgKyBieXRlcywgam9iLT5n
cmFudWxhcml0eSkgJiYNCj4+ICsgICAgICAgIGJkcnZfZGlydHlfYml0bWFwX2dldChqb2ItPmRp
cnR5X2JpdG1hcCwgb2Zmc2V0ICsgYnl0ZXMgLSAxKSkNCj4+ICsgICAgew0KPj4gKyAgICAgICAg
dWludDY0X3QgdGFpbCA9IChvZmZzZXQgKyBieXRlcykgJSBqb2ItPmdyYW51bGFyaXR5Ow0KPj4g
Kw0KPj4gKyAgICAgICAgaWYgKGJ5dGVzIDw9IHRhaWwpIHsNCj4+ICsgICAgICAgICAgICAvKiBu
b3RoaW5nIHRvIGRvIGFmdGVyIHNocmluayAqLw0KPj4gKyAgICAgICAgICAgIHJldHVybjsNCj4+
ICsgICAgICAgIH0NCj4+ICsgICAgICAgIGJ5dGVzIC09IHRhaWw7DQo+PiArICAgIH0NCj4+ICAg
DQo+PiAgICAgICBiZHJ2X3Jlc2V0X2RpcnR5X2JpdG1hcChqb2ItPmRpcnR5X2JpdG1hcCwgb2Zm
c2V0LCBieXRlcyk7DQo+PiAgIA0KPiANCj4gVGhlIGJkcnZfc2V0X2RpcnR5X2JpdG1hcCgpIGlu
IHRoZSBlcnJvciBjYXNlIGJlbG93IG5lZWRzIHRvIHVzZSB0aGUNCj4gb3JpZ2luYWwgb2Zmc2V0
L2J5dGVzLCBJIHN1cHBvc2UuDQoNCk5vLCBiZWNhdXNlIHdlIHNocmluayB0YWlsIG9ubHkgaWYg
aXQgaXMgYWxyZWFkeSBkaXJ0eS4gQW5kIHdlJ3ZlIGxvY2tlZCB0aGUNCnJlZ2lvbiBmb3IgaW4t
ZmxpZ2h0IG9wZXJhdGlvbiwgc28gbm9ib2R5IGNhbiBjbGVhciB0aGUgYml0bWFwIGluIGEgbWVh
bnRpbWUuDQoNCkJ1dCBzdGlsbCwgaGVyZSBpcyBzb21ldGhpbmcgdG8gZG86DQoNCmZvciBub3Qt
c2hyaW5rZWQgdGFpbHMsIGlmIGFueSwgd2Ugc2hvdWxkOg0KMS4gYWxpZ24gZG93biBmb3IgcmVz
ZXQNCjIuIGFsaWduIHVwIGZvciBzZXQgb24gZmFpbHVyZQ0KDQoNCj4gDQo+IEFwYXJ0IGZyb20g
dGhhdCwgbG9va3MgZ29vZCB0byBtZS4NCj4gDQo+IE1heA0KPiANCg0KDQotLSANCkJlc3QgcmVn
YXJkcywNClZsYWRpbWlyDQo=

