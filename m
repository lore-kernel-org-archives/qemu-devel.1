Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06016ECE587
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 08:56:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B24BE206A3
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 08:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="vOHB7dc3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B24BE206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJw9h-0001qM-Ul
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 04:56:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57085)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iJw8b-0000tt-Tt
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 04:55:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iJw8a-00083O-DW
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 04:55:33 -0400
Received: from mail-eopbgr00121.outbound.protection.outlook.com
 ([40.107.0.121]:15430 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iJw8a-00081u-48
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 04:55:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SW0f5KI7APoGuCVDFfVumJwz/lLeW7d0ObdSdRj8s/nL832kFsgkMjo8Jhe/3tmGWma9O+LCYngzwbjqC+yFPbfxkxeqkWLh8vk9b5CSxjsKbPTq7g39g6z0o8SKjvrrDOEepYnQDfm/WzET0J2NNw6SbyRk3acbX0WVe7xKsgWC7DsEZC+tVSdLD0A6fgmAPgxzSYerkkB/ppAyykQ80IWqTBHDLu9FApO+YheT7VJwEC/DSe0km3VYhbbvKyZyk7pb9tQPk/FBBxkAuaNhmeNYp3QN2b6GpImmwtLY1mhAny9XhyqSEec04Z+Qbo/nvtQokuLDhm29OUPhmZpk5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j1VFAyd9s4zjH5ITfddSX4aMExXdqjF6p2IusGTNqgE=;
 b=hwx3qGvp9WIfj0QVSCv90qtdUk/cXIq9vhRKHMMtCOiXiGobKZ1gl0NHRPNCahh43A95I2eLM0AMW6XOeptMa8tlbdly1tTYXNyQbh5IckOpmA1Dr+RssDktrFx/4HcYvikobSq3G4AnfQ5xyogriTspgfkUGe2zYyg3Cssxw7ndtLNnFe43EELM60mgLilM8ea2I4/UawFnHSrh0V9kWWPqHSCSZYYlIFY0CLLSfoef2LG1QPa/Dv3WVxI9fEzEa0EjqhPWmV3xsb1dDyK553w/FAhS2vFLX3eNsoG3hf8m/Pwlrb2ROBkGowBLDJ1aJzq5IhDF65mPlaDzkwmWBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j1VFAyd9s4zjH5ITfddSX4aMExXdqjF6p2IusGTNqgE=;
 b=vOHB7dc31tv5aQF9jZYh+ZmhvjmhitE2HVf+FPYooGa4QxZ4+dCmTC4M1fGtR08dJYWaX631+EyLHc+QSFoq6sd9W4biGgClm2/V4kjXz55FOj42vSkhM2B8fhfOmihoyOXmNUr1qE+1tGvyFP1xsclDNt/zUlFQKJcIAgj++Vc=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5307.eurprd08.prod.outlook.com (52.133.240.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.22; Mon, 14 Oct 2019 08:55:30 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f%2]) with mapi id 15.20.2347.021; Mon, 14 Oct 2019
 08:55:30 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [RFC v5 034/126] MIPS Machines: introduce ERRP_AUTO_PROPAGATE
Thread-Topic: [RFC v5 034/126] MIPS Machines: introduce ERRP_AUTO_PROPAGATE
Thread-Index: AQHVgE3O1CjEVE2dE0+9XQgLSDlsbKdWiiyAgANPd4A=
Date: Mon, 14 Oct 2019 08:55:30 +0000
Message-ID: <82c82b70-b773-23ce-8527-eee5de0ae0fe@virtuozzo.com>
References: <20191011160552.22907-1-vsementsov@virtuozzo.com>
 <20191011160552.22907-35-vsementsov@virtuozzo.com>
 <0b59dbdc-a0b2-37a9-694c-ab3c034f70d5@redhat.com>
In-Reply-To: <0b59dbdc-a0b2-37a9-694c-ab3c034f70d5@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0402CA0032.eurprd04.prod.outlook.com
 (2603:10a6:7:7c::21) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191014115527640
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8f004ced-b3c7-4ed0-f783-08d7508443e6
x-ms-traffictypediagnostic: DB8PR08MB5307:
x-microsoft-antispam-prvs: <DB8PR08MB5307E534854A1586C0B64C5DC1900@DB8PR08MB5307.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01901B3451
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(376002)(39840400004)(366004)(396003)(136003)(199004)(189003)(31696002)(7736002)(186003)(229853002)(2501003)(316002)(14454004)(2906002)(305945005)(110136005)(54906003)(26005)(6436002)(102836004)(478600001)(81156014)(81166006)(6486002)(6512007)(52116002)(8676002)(6246003)(76176011)(8936002)(99286004)(71190400001)(31686004)(66946007)(66476007)(64756008)(66446008)(66556008)(476003)(25786009)(11346002)(2616005)(446003)(486006)(71200400001)(86362001)(66066001)(5660300002)(6506007)(3846002)(6116002)(53546011)(386003)(4326008)(256004)(36756003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5307;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8hINPrishQeDGn/K9NyVAP61eGZx0KRFzwFqUbjbGd95+ko+quyH+srfPHMMu9CCaGNdB+cD4UxlZOOzoNW0D3FmkOTIhWqozzizPyQHde9wyNj5WPt8Zy+vBLEaN2gx1yw0l1+oPabv8s2uuKGYMzajQ4B5zTsyxUg/VTQWvgPk3pGBud4TTkdM+d2EnGkVMmUnDbxMvC8cC0FbHILF8wePHHRb5LWX8b3k/cpgPgnEjIreUlwAnSX3XZFBw698I1Qo4oBxAscSwH9HhNmC4L1j0sEorHSwjkqVW5aXRCfVycZ44vootzKbQJsdgkxiRgtQTjoGkKgwvPWfD5Gjaef33RYxCNMn+EC1X9DssZh2Cs5R3vqYzxhxytLh0UGDK4Dt6pxYfDVh78iIFnXrzFgzv3dBGzqX+silcxc0RKk=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E2FCA6619D5C1548876301118BB4D00E@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f004ced-b3c7-4ed0-f783-08d7508443e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2019 08:55:30.3231 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nm4Pb3aedPTZQeme9bgjhRxUKQ1t5ehVj9EzsI2H0Ter1tSwIMAporjin+ijRqrfL3ktcd+H5ej2I/a5fJ9qD+2bLKyhwEmmfTycZzU8oI0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5307
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.0.121
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
Cc: Kevin Wolf <kwolf@redhat.com>, Paul Burton <pburton@wavecomp.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, Greg Kurz <groug@kaod.org>,
 "armbru@redhat.com" <armbru@redhat.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTIuMTAuMjAxOSA5OjIyLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4gSGkgVmxh
ZGltaXIsDQo+IA0KPiBPbiAxMC8xMS8xOSA2OjA0IFBNLCBWbGFkaW1pciBTZW1lbnRzb3YtT2dp
ZXZza2l5IHdyb3RlOg0KPj4gSWYgd2Ugd2FudCB0byBhZGQgc29tZSBpbmZvIHRvIGVycnAgKGJ5
IGVycm9yX3ByZXBlbmQoKSBvcg0KPj4gZXJyb3JfYXBwZW5kX2hpbnQoKSksIHdlIG11c3QgdXNl
IHRoZSBFUlJQX0FVVE9fUFJPUEFHQVRFIG1hY3JvLg0KPj4gT3RoZXJ3aXNlLCB0aGlzIGluZm8g
d2lsbCBub3QgYmUgYWRkZWQgd2hlbiBlcnJwID09ICZmYXRhbF9lcnINCj4+ICh0aGUgcHJvZ3Jh
bSB3aWxsIGV4aXQgcHJpb3IgdG8gdGhlIGVycm9yX2FwcGVuZF9oaW50KCkgb3INCj4+IGVycm9y
X3ByZXBlbmQoKSBjYWxsKS7CoCBGaXggc3VjaCBjYXNlcy4NCj4+DQo+PiBJZiB3ZSB3YW50IHRv
IGNoZWNrIGVycm9yIGFmdGVyIGVycnAtZnVuY3Rpb24gY2FsbCwgd2UgbmVlZCB0bw0KPj4gaW50
cm9kdWNlIGxvY2FsX2VyciBhbmQgdGhhbiBwcm9wYWdhdGUgaXQgdG8gZXJycC4gSW5zdGVhZCwg
dXNlDQo+PiBFUlJQX0FVVE9fUFJPUEFHQVRFIG1hY3JvLCBiZW5lZml0cyBhcmU6DQo+PiAxLiBO
byBuZWVkIG9mIGV4cGxpY2l0IGVycm9yX3Byb3BhZ2F0ZSBjYWxsDQo+PiAyLiBObyBuZWVkIG9m
IGV4cGxpY2l0IGxvY2FsX2VyciB2YXJpYWJsZTogdXNlIGVycnAgZGlyZWN0bHkNCj4+IDMuIEVS
UlBfQVVUT19QUk9QQUdBVEUgbGVhdmVzIGVycnAgYXMgaXMgaWYgaXQncyBub3QgTlVMTCBvcg0K
Pj4gwqDCoMKgICZlcnJvcl9mYXRlbCwgdGhpcyBtZWFucyB0aGF0IHdlIGRvbid0IGJyZWFrIGVy
cm9yX2Fib3J0DQo+PiDCoMKgwqAgKHdlJ2xsIGFib3J0IG9uIGVycm9yX3NldCwgbm90IG9uIGVy
cm9yX3Byb3BhZ2F0ZSkNCj4+DQo+PiBUaGlzIGNvbW1pdCAodG9nZXRoZXIgd2l0aCBpdHMgbmVp
Z2hib3JzKSB3YXMgZ2VuZXJhdGVkIGJ5DQo+Pg0KPj4gZm9yIGYgaW4gJChnaXQgZ3JlcCAtbCBl
cnJwIFwqLltjaF0pOyBkbyBcDQo+PiDCoMKgwqDCoCBzcGF0Y2ggLS1zcC1maWxlIHNjcmlwdHMv
Y29jY2luZWxsZS9hdXRvLXByb3BhZ2F0ZWQtZXJycC5jb2NjaSBcDQo+PiDCoMKgwqDCoCAtLW1h
Y3JvLWZpbGUgc2NyaXB0cy9jb2NjaS1tYWNyby1maWxlLmggLS1pbi1wbGFjZSAtLW5vLXNob3ct
ZGlmZiAkZjsgXA0KPj4gZG9uZTsNCj4+DQo+PiB0aGVuIGZpeCBhIGJpdCBvZiBjb21waWxhdGlv
biBwcm9ibGVtczogY29jY2luZWxsZSBmb3Igc29tZSByZWFzb24NCj4+IGxlYXZlcyBzZXZlcmFs
DQo+PiBmKCkgew0KPj4gwqDCoMKgwqAgLi4uDQo+PiDCoMKgwqDCoCBnb3RvIG91dDsNCj4+IMKg
wqDCoMKgIC4uLg0KPj4gwqDCoMKgwqAgb3V0Og0KPj4gfQ0KPj4gcGF0dGVybnMsIHdpdGggIm91
dDoiIGF0IGZ1bmN0aW9uIGVuZC4NCj4+DQo+PiB0aGVuDQo+PiAuL3B5dGhvbi9jb21taXQtcGVy
LXN1YnN5c3RlbS5weSBNQUlOVEFJTkVSUyAiJCg8IGF1dG8tbXNnKSINCj4+DQo+PiAoYXV0by1t
c2cgd2FzIGEgZmlsZSB3aXRoIHRoaXMgY29tbWl0IG1lc3NhZ2UpDQo+Pg0KPj4gU3RpbGwsIGZv
ciBiYWNrcG9ydGluZyBpdCBtYXkgYmUgbW9yZSBjb21mb3J0YWJsZSB0byB1c2Ugb25seSB0aGUg
Zmlyc3QNCj4+IGNvbW1hbmQgYW5kIHRoZW4gZG8gb25lIGh1Z2UgY29tbWl0Lg0KPj4NCj4+IFJl
cG9ydGVkLWJ5OiBLZXZpbiBXb2xmIDxrd29sZkByZWRoYXQuY29tPg0KPj4gUmVwb3J0ZWQtYnk6
IEdyZWcgS3VyeiA8Z3JvdWdAa2FvZC5vcmc+DQo+PiBTaWduZWQtb2ZmLWJ5OiBWbGFkaW1pciBT
ZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+DQo+PiAtLS0NCj4+
IMKgIGh3L2NvcmUvbG9hZGVyLWZpdC5jIHwgMiArKw0KPj4gwqAgMSBmaWxlIGNoYW5nZWQsIDIg
aW5zZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9ody9jb3JlL2xvYWRlci1maXQuYyBi
L2h3L2NvcmUvbG9hZGVyLWZpdC5jDQo+PiBpbmRleCAzZWU5ZmIyZjJlLi44NGYzNWExZmUyIDEw
MDY0NA0KPj4gLS0tIGEvaHcvY29yZS9sb2FkZXItZml0LmMNCj4+ICsrKyBiL2h3L2NvcmUvbG9h
ZGVyLWZpdC5jDQo+PiBAQCAtMTIwLDYgKzEyMCw3IEBAIHN0YXRpYyBpbnQgZml0X2xvYWRfa2Vy
bmVsKGNvbnN0IHN0cnVjdCBmaXRfbG9hZGVyICpsZHIsIGNvbnN0IHZvaWQgKml0YiwNCj4+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlu
dCBjZmcsIHZvaWQgKm9wYXF1ZSwgaHdhZGRyICpwZW5kLA0KPj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgRXJyb3IgKiplcnJwKQ0KPj4g
wqAgew0KPj4gK8KgwqDCoCBFUlJQX0FVVE9fUFJPUEFHQVRFKCk7DQo+IA0KPiBUaGlzIGNlcnRh
aW5seSBsb29rcyBvZGQgYW5kIHRvb2sgbWUgc29tZSB0aW1lIHRvIGZpZ3VyZSBpdCBvdXQuDQo+
IA0KPiBQZXIgaW5jbHVkZS9xYXBpL2Vycm9yLmg6DQo+IA0KPiAvKg0KPiAgwqAqIEVSUlBfQVVU
T19QUk9QQUdBVEUNCj4gIMKgKg0KPiAgwqAqIFRoaXMgbWFjcm8gaXMgY3JlYXRlZCB0byBiZSB0
aGUgZmlyc3QgbGluZSBvZiBhIGZ1bmN0aW9uIHdpdGggRXJyb3IgKmVycnANCj4gIMKgKiBPVVQg
cGFyYW1ldGVyLiBJdCdzIG5lZWRlZCBvbmx5IGluIGNhc2VzIHdoZXJlIHdlIHdhbnQgdG8gdXNl
IHJyb3JfcHJlcGVuZCwNCj4gIMKgKiBlcnJvcl9hcHBlbmRfaGludCBvciBkZXJlZmVyZW5jZSAq
ZXJycC4gSXQncyBzdGlsbCBzYWZlIChidXQgdXNlbGVzcykgaW4NCj4gIMKgKiBvdGhlciBjYXNl
cy4NCj4gDQo+IFRoaXMgZnVuY3Rpb24gaW5kZWVkIHVzZXMgZXJyb3JfcHJlcGVuZCgpOg0KPiAN
Cj4gIMKgwqDCoCBsb2FkX2RhdGEgPSBkYXRhID0gZml0X2xvYWRfaW1hZ2VfYWxsb2MoaXRiLCBu
YW1lLCAmaW1nX29mZiwgJnN6LCBlcnJwKTsNCj4gIMKgwqDCoCBpZiAoIWRhdGEpIHsNCj4gIMKg
wqDCoMKgwqDCoMKgIGVycm9yX3ByZXBlbmQoZXJycCwgInVuYWJsZSB0byBsb2FkIGtlcm5lbCBp
bWFnZSBmcm9tIEZJVDogIik7DQo+ICDCoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVJTlZBTDsNCj4g
IMKgwqDCoCB9DQo+IA0KPiAgwqDCoMKgIGVyciA9IGZpdF9pbWFnZV9hZGRyKGl0YiwgaW1nX29m
ZiwgImxvYWQiLCAmbG9hZF9hZGRyLCBlcnJwKTsNCj4gIMKgwqDCoCBpZiAoZXJyKSB7DQo+ICDC
oMKgwqDCoMKgwqDCoCBlcnJvcl9wcmVwZW5kKGVycnAsICJ1bmFibGUgdG8gcmVhZCBrZXJuZWwg
bG9hZCBhZGRyZXNzIGZyb20gRklUOiAiKTsNCj4gIMKgwqDCoMKgwqDCoMKgIHJldCA9IGVycjsN
Cj4gIMKgwqDCoMKgwqDCoMKgIGdvdG8gb3V0Ow0KPiAgwqDCoMKgIH0NCj4gDQo+ICDCoMKgwqAg
ZXJyID0gZml0X2ltYWdlX2FkZHIoaXRiLCBpbWdfb2ZmLCAiZW50cnkiLCAmZW50cnlfYWRkciwg
ZXJycCk7DQo+ICDCoMKgwqAgaWYgKGVycikgew0KPiAgwqDCoMKgwqDCoMKgwqAgZXJyb3JfcHJl
cGVuZChlcnJwLCAidW5hYmxlIHRvIHJlYWQga2VybmVsIGVudHJ5IGFkZHJlc3MgZnJvbSBGSVQ6
ICIpOw0KPiAgwqDCoMKgwqDCoMKgwqAgcmV0ID0gZXJyOw0KPiAgwqDCoMKgwqDCoMKgwqAgZ290
byBvdXQ7DQo+ICDCoMKgwqAgfQ0KPiANCj4gR2VuZXJhdGluZyB0aGUgcGF0Y2ggd2l0aCBtb3Jl
IGxpbmVzIGNvbnRleHQgd291bGQgaGF2ZSBoZWxwIGEgYml0Lg0KPiANCj4gQ2FuIHlvdSBhZGQg
YSBsaW5lIGFib3V0IGVycm9yX3ByZXBlbmQoKSBpbiB0aGUgY29tbWl0IGRlc2NyaXB0aW9uPw0K
DQpIbW0sIGl0cyBhbHJlYWR5IGluIGl0OiAiSWYgd2Ugd2FudCB0byBhZGQgc29tZSBpbmZvIHRv
IGVycnAgKGJ5IGVycm9yX3ByZXBlbmQoKSAuLi4iLg0KQnV0IGJldHRlciBzdWdnZXN0aW9ucyBm
b3IgY29tbWl0IG1lc3NhZ2Ugd29yZGluZyBhcmUgd2VsY29tZSwgb2YgY291cnNlLg0KDQo+IA0K
Pj4gwqDCoMKgwqDCoCBjb25zdCBjaGFyICpuYW1lOw0KPj4gwqDCoMKgwqDCoCBjb25zdCB2b2lk
ICpkYXRhOw0KPj4gwqDCoMKgwqDCoCBjb25zdCB2b2lkICpsb2FkX2RhdGE7DQo+PiBAQCAtMTc4
LDYgKzE3OSw3IEBAIHN0YXRpYyBpbnQgZml0X2xvYWRfZmR0KGNvbnN0IHN0cnVjdCBmaXRfbG9h
ZGVyICpsZHIsIGNvbnN0IHZvaWQgKml0YiwNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGludCBjZmcsIHZvaWQgKm9wYXF1ZSwgY29uc3Qgdm9p
ZCAqbWF0Y2hfZGF0YSwNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGh3YWRkciBrZXJuZWxfZW5kLCBFcnJvciAqKmVycnApDQo+PiDCoCB7DQo+
PiArwqDCoMKgIEVSUlBfQVVUT19QUk9QQUdBVEUoKTsNCj4+IMKgwqDCoMKgwqAgY29uc3QgY2hh
ciAqbmFtZTsNCj4+IMKgwqDCoMKgwqAgY29uc3Qgdm9pZCAqZGF0YTsNCj4+IMKgwqDCoMKgwqAg
Y29uc3Qgdm9pZCAqbG9hZF9kYXRhOw0KPj4NCj4gDQo+IERpdHRvOg0KPiANCj4gIMKgwqDCoCBs
b2FkX2RhdGEgPSBkYXRhID0gZml0X2xvYWRfaW1hZ2VfYWxsb2MoaXRiLCBuYW1lLCAmaW1nX29m
ZiwgJnN6LCBlcnJwKTsNCj4gIMKgwqDCoCBpZiAoIWRhdGEpIHsNCj4gIMKgwqDCoMKgwqDCoMKg
IGVycm9yX3ByZXBlbmQoZXJycCwgInVuYWJsZSB0byBsb2FkIEZEVCBpbWFnZSBmcm9tIEZJVDog
Iik7DQo+ICDCoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVJTlZBTDsNCj4gIMKgwqDCoCB9DQo+IA0K
PiAgwqDCoMKgIGVyciA9IGZpdF9pbWFnZV9hZGRyKGl0YiwgaW1nX29mZiwgImxvYWQiLCAmbG9h
ZF9hZGRyLCBlcnJwKTsNCj4gIMKgwqDCoCBpZiAoZXJyID09IC1FTk9FTlQpIHsNCj4gIMKgwqDC
oMKgwqDCoMKgIGxvYWRfYWRkciA9IFJPVU5EX1VQKGtlcm5lbF9lbmQsIDY0ICogS2lCKSArICgx
MCAqIE1pQik7DQo+ICDCoMKgwqDCoMKgwqDCoCBlcnJvcl9mcmVlKCplcnJwKTsNCj4gIMKgwqDC
oCB9IGVsc2UgaWYgKGVycikgew0KPiAgwqDCoMKgwqDCoMKgwqAgZXJyb3JfcHJlcGVuZChlcnJw
LCAidW5hYmxlIHRvIHJlYWQgRkRUIGxvYWQgYWRkcmVzcyBmcm9tIEZJVDogIik7DQo+ICDCoMKg
wqDCoMKgwqDCoCByZXQgPSBlcnI7DQo+ICDCoMKgwqDCoMKgwqDCoCBnb3RvIG91dDsNCj4gIMKg
wqDCoCB9DQo+IA0KPiBSZXZpZXdlZC1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxt
ZEByZWRoYXQuY29tPg0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

