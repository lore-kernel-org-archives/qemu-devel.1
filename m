Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E223AC33CB7
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 07:40:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93D1B20708
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 07:40:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="SxJm5w+z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93D1B20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42291 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwhxF-0006hJ-Nt
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 02:40:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35597)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1iwhwE-0005N3-Dm
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 02:39:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1iwhwC-0007j7-JG
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 02:39:01 -0500
Received: from mail-ve1eur01on0716.outbound.protection.outlook.com
 ([2a01:111:f400:fe1f::716]:64750
 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1iwhwB-0007ez-Qk; Wed, 29 Jan 2020 02:39:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DEWBUhdGxmB4KfgOtoHnYAyLODrkSOki+NO9JeufFWk4wAZspcT4DE7rx+TL/AoSOW3AU0G+WvN9hmpN7CWhACo0yMx21b+dslg2b56E2wvBgkLzdCe/3OD2V2lHSje4OgEeMBxYw4YuywFEMz50+Vl/pCrd6VSJB9vA4gmTSSS+2oDeaRy0tO7niy9wkWx8JQY3JGD/H5id3lCsO9Uj0CHgKYLCmXoTzOxKJw36zx0s8HsO4IYpmn0pMSEgjFDIdm5olSO0YuYNRZ0Ahvzr+E0snONN0p142y1SlrNOcoWeb0OFIpsw+YMD31PeygHYl+xVtb1zlAd5JzVQIStsQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WPLSW305kRVvcZQA/s3sJZStnCDG2eJyBauKywHB1ic=;
 b=kAn4Y06GYDXkRblqc4XX0rCgQPpbcjXZxmPyO3aC+lUA7zqQgyUTRg5XieaEcBS1tM9zEhOwlv6QGHOZbPNZ2+2tmgIt51R1jP2jN2vJF0pQX9sXaq7zZSXm8S0S6Ackcs0JdeH0mnjv++lCAEmDhwaFbrfFnPn/rPvWxG2xUWNdgNFVHFwZ7gtgXUksId885QziGJ0GkaX6DrJ/8wNtOlV1ShEo3N8NsobTjivIilWJyCDwKr+iM0UDi0CYYhF5UjckXb3KHr33VxXVBtzhgHDmStK+T1OGtrnHZ53rxiJigEa7MKLnfpp9nrCO3u8C9bPXM8PUgXt16um4/B9v9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WPLSW305kRVvcZQA/s3sJZStnCDG2eJyBauKywHB1ic=;
 b=SxJm5w+zofjvcka3LVig+YpgIjNiRCWXZpL4BlZ/4LfcCXyZxnEc6wN5d/H5shK7yBW9gfmeQEfFqHOu0QJteKBO8ftnKsS6mKNLeg9OC0kLjaAgvQcbqVNX5yvuwzTYjQz3LJzn3PRfpWbOW2sJ7KonZCXBLpKo+YNoGPHdSu4=
Received: from AM6PR08MB5048.eurprd08.prod.outlook.com (10.255.123.95) by
 AM6PR08MB4600.eurprd08.prod.outlook.com (20.178.88.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.20; Wed, 29 Jan 2020 07:38:56 +0000
Received: from AM6PR08MB5048.eurprd08.prod.outlook.com
 ([fe80::8805:5633:ca46:c8c8]) by AM6PR08MB5048.eurprd08.prod.outlook.com
 ([fe80::8805:5633:ca46:c8c8%7]) with mapi id 15.20.2665.026; Wed, 29 Jan 2020
 07:38:56 +0000
Received: from [172.16.24.225] (185.231.240.5) by
 HE1PR05CA0291.eurprd05.prod.outlook.com (2603:10a6:7:93::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.20 via Frontend Transport; Wed, 29 Jan 2020 07:38:55 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: Re: [PATCH v2 1/7] block/block-copy: specialcase first copy_range
 request
Thread-Topic: [PATCH v2 1/7] block/block-copy: specialcase first copy_range
 request
Thread-Index: AQHVpU9f7FdXGKL+2EO6XnNDvt96OKgBo7CA
Date: Wed, 29 Jan 2020 07:38:56 +0000
Message-ID: <aee94498-e607-e8ed-31e9-f1bf1035854a@virtuozzo.com>
References: <20191127180840.11937-1-vsementsov@virtuozzo.com>
 <20191127180840.11937-2-vsementsov@virtuozzo.com>
In-Reply-To: <20191127180840.11937-2-vsementsov@virtuozzo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0291.eurprd05.prod.outlook.com
 (2603:10a6:7:93::22) To AM6PR08MB5048.eurprd08.prod.outlook.com
 (2603:10a6:20b:ee::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4550dfd1-b447-4cf6-9ce4-08d7a48e4bbb
x-ms-traffictypediagnostic: AM6PR08MB4600:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR08MB460026D60F85D18FF3AFCAD5F4050@AM6PR08MB4600.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:935;
x-forefront-prvs: 02973C87BC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39850400004)(136003)(376002)(346002)(366004)(396003)(189003)(199004)(52116002)(31686004)(81166006)(8676002)(81156014)(8936002)(2616005)(71200400001)(53546011)(478600001)(956004)(36756003)(44832011)(186003)(16526019)(26005)(6486002)(66446008)(66556008)(66946007)(2906002)(64756008)(66476007)(110136005)(5660300002)(86362001)(16576012)(54906003)(316002)(4326008)(31696002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4600;
 H:AM6PR08MB5048.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C7H2Gsggpz68Y4GKde63GF0LTpCWNdyZkbbQDQg6XIcrkY+YV7Ue9CiILO3B4H91tawXGgEVjeKTO/Fnmd2aoeWfNlg0vk/ZCpGVubJ5200i56W+cdZcQrN0/DS2teH9vf/4Rlhp0Kh89rf2KTx4fGfa8sihcmDdLe57GKvLKlpSZIUF8f+COilyiYKo+DEz029W2LtE+tOsN+/GJVlQ/kU4IuAp3Vc56cZws9kaju9YusHxx1gYTOScaacDGPmABPm+300RzFP0eBGWU2YEoD3bNYblNoBxsu4TraL4gzKWZWs1pe9Wi96bSy8vMtz3V/YcBZZUWLHkMIh3Xn9801j4KiJ3z7aE0Ru21HZfj7NGn5YXO/UYj3rGWKK5ZQ8JDSqpEVgUhfsIeM1i06fBXYUNoETv+/IZvVn5IKJs18rkgLFXIpqBwz/4rH+X0uPC
x-ms-exchange-antispam-messagedata: EkUc4naAETpEGFgcUzTp0uLke8BiOKPwXSeXVjPleJ6b7Iln6ILCdqgE6rOGsqU8vD+/qnW1jyXGMZwLAqhU5IX4hL4Yt/JesvfG9Wd5djQuC2IYBc3TmOK3toAr+mAQeE6QZYyseTAG5UwYfbw34A==
Content-Type: text/plain; charset="utf-8"
Content-ID: <C02C253DAC31B04ABD68DD4A2AEB8D16@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4550dfd1-b447-4cf6-9ce4-08d7a48e4bbb
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2020 07:38:56.2370 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yATkILBfoV+ZUT3PueFwdJr9dN12sFTIMIUWpoFsVlsT6yiw8SGFhztmNQ+C9KcZSOTGFSWueyOLwUgte2/kOwa2BNQ007hK4aPKhUE4lV0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4600
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe1f::716
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDI3LzExLzIwMTkgMjE6MDgsIFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgd3Jv
dGU6DQo+IEluIGJsb2NrX2NvcHlfZG9fY29weSB3ZSBmYWxsYmFjayB0byByZWFkK3dyaXRlIGlm
IGNvcHlfcmFuZ2UgZmFpbGVkLg0KPiBJbiB0aGlzIGNhc2UgY29weV9zaXplIGlzIGxhcmdlciB0
aGFuIGRlZmluZWQgZm9yIGJ1ZmZlcmVkIElPLCBhbmQNCj4gdGhlcmUgaXMgY29ycmVzcG9uZGlu
ZyBjb21taXQuIFN0aWxsLCBiYWNrdXAgY29waWVzIGRhdGEgY2x1c3RlciBieQ0KPiBjbHVzdGVy
LCBhbmQgbW9zdCBvZiByZXF1ZXN0cyBhcmUgbGltaXRlZCB0byBvbmUgY2x1c3RlciBhbnl3YXks
IHNvIHRoZQ0KPiBvbmx5IHNvdXJjZSBvZiB0aGlzIG9uZSBiYWQtbGltaXRlZCByZXF1ZXN0IGlz
IGNvcHktYmVmb3JlLXdyaXRlDQo+IG9wZXJhdGlvbi4NCj4gDQo+IEZ1cnRoZXIgcGF0Y2ggd2ls
bCBtb3ZlIGJhY2t1cCB0byB1c2UgYmxvY2tfY29weSBkaXJlY3RseSwgdGhhbiBmb3INCj4gY2Fz
ZXMgd2hlcmUgY29weV9yYW5nZSBpcyBub3Qgc3VwcG9ydGVkLCBmaXJzdCByZXF1ZXN0IHdpbGwg
YmUNCj4gb3ZlcnNpemVkIGluIGVhY2ggYmFja3VwLiBJdCdzIG5vdCBnb29kLCBsZXQncyBjaGFu
Z2UgaXQgbm93Lg0KPiANCj4gRml4IGlzIHNpbXBsZToganVzdCBsaW1pdCBmaXJzdCBjb3B5X3Jh
bmdlIHJlcXVlc3QgbGlrZSBidWZmZXItYmFzZWQNCj4gcmVxdWVzdC4gSWYgaXQgc3VjY2VlZCwg
c2V0IGxhcmdlciBjb3B5X3JhbmdlIGxpbWl0Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogVmxhZGlt
aXIgU2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPg0KPiAtLS0N
Cj4gICBibG9jay9ibG9jay1jb3B5LmMgfCA0MSArKysrKysrKysrKysrKysrKysrKysrKysrKysr
KystLS0tLS0tLS0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAzMCBpbnNlcnRpb25zKCspLCAxMSBk
ZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9ibG9jay9ibG9jay1jb3B5LmMgYi9ibG9j
ay9ibG9jay1jb3B5LmMNCj4gaW5kZXggNzk3OThhMTU2Ny4uODYwMmUyY2FlNyAxMDA2NDQNCj4g
LS0tIGEvYmxvY2svYmxvY2stY29weS5jDQo+ICsrKyBiL2Jsb2NrL2Jsb2NrLWNvcHkuYw0KPiBA
QCAtNzAsMTYgKzcwLDE5IEBAIHZvaWQgYmxvY2tfY29weV9zdGF0ZV9mcmVlKEJsb2NrQ29weVN0
YXRlICpzKQ0KPiAgICAgICBnX2ZyZWUocyk7DQo+ICAgfQ0KPiAgIA0KPiArc3RhdGljIHVpbnQz
Ml90IGJsb2NrX2NvcHlfbWF4X3RyYW5zZmVyKEJkcnZDaGlsZCAqc291cmNlLCBCZHJ2Q2hpbGQg
KnRhcmdldCkNCj4gK3sNCj4gKyAgICByZXR1cm4gTUlOX05PTl9aRVJPKElOVF9NQVgsDQo+ICsg
ICAgICAgICAgICAgICAgICAgICAgICBNSU5fTk9OX1pFUk8oc291cmNlLT5icy0+YmwubWF4X3Ry
YW5zZmVyLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRhcmdldC0+
YnMtPmJsLm1heF90cmFuc2ZlcikpOw0KPiArfQ0KPiArDQo+ICAgQmxvY2tDb3B5U3RhdGUgKmJs
b2NrX2NvcHlfc3RhdGVfbmV3KEJkcnZDaGlsZCAqc291cmNlLCBCZHJ2Q2hpbGQgKnRhcmdldCwN
Cj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW50NjRfdCBjbHVzdGVy
X3NpemUsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEJkcnZSZXF1
ZXN0RmxhZ3Mgd3JpdGVfZmxhZ3MsIEVycm9yICoqZXJycCkNCj4gICB7DQo+ICAgICAgIEJsb2Nr
Q29weVN0YXRlICpzOw0KPiAgICAgICBCZHJ2RGlydHlCaXRtYXAgKmNvcHlfYml0bWFwOw0KPiAt
ICAgIHVpbnQzMl90IG1heF90cmFuc2ZlciA9DQo+IC0gICAgICAgICAgICBNSU5fTk9OX1pFUk8o
SU5UX01BWCwNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICBNSU5fTk9OX1pFUk8oc291cmNl
LT5icy0+YmwubWF4X3RyYW5zZmVyLA0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB0YXJnZXQtPmJzLT5ibC5tYXhfdHJhbnNmZXIpKTsNCj4gICANCj4gICAgICAgY29w
eV9iaXRtYXAgPSBiZHJ2X2NyZWF0ZV9kaXJ0eV9iaXRtYXAoc291cmNlLT5icywgY2x1c3Rlcl9z
aXplLCBOVUxMLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBlcnJwKTsNCj4gQEAgLTk5LDcgKzEwMiw3IEBAIEJsb2NrQ29weVN0YXRlICpibG9ja19jb3B5
X3N0YXRlX25ldyhCZHJ2Q2hpbGQgKnNvdXJjZSwgQmRydkNoaWxkICp0YXJnZXQsDQo+ICAgICAg
ICAgICAubWVtID0gc2hyZXNfY3JlYXRlKEJMT0NLX0NPUFlfTUFYX01FTSksDQo+ICAgICAgIH07
DQo+ICAgDQo+IC0gICAgaWYgKG1heF90cmFuc2ZlciA8IGNsdXN0ZXJfc2l6ZSkgew0KPiArICAg
IGlmIChibG9ja19jb3B5X21heF90cmFuc2Zlcihzb3VyY2UsIHRhcmdldCkgPCBjbHVzdGVyX3Np
emUpIHsNCj4gICAgICAgICAgIC8qDQo+ICAgICAgICAgICAgKiBjb3B5X3JhbmdlIGRvZXMgbm90
IHJlc3BlY3QgbWF4X3RyYW5zZmVyLiBXZSBkb24ndCB3YW50IHRvIGJvdGhlcg0KPiAgICAgICAg
ICAgICogd2l0aCByZXF1ZXN0cyBzbWFsbGVyIHRoYW4gYmxvY2stY29weSBjbHVzdGVyIHNpemUs
IHNvIGZhbGxiYWNrIHRvDQo+IEBAIC0xMTQsMTIgKzExNywxMSBAQCBCbG9ja0NvcHlTdGF0ZSAq
YmxvY2tfY29weV9zdGF0ZV9uZXcoQmRydkNoaWxkICpzb3VyY2UsIEJkcnZDaGlsZCAqdGFyZ2V0
LA0KPiAgICAgICAgICAgcy0+Y29weV9zaXplID0gY2x1c3Rlcl9zaXplOw0KPiAgICAgICB9IGVs
c2Ugew0KPiAgICAgICAgICAgLyoNCj4gLSAgICAgICAgICogY29weV9yYW5nZSBkb2VzIG5vdCBy
ZXNwZWN0IG1heF90cmFuc2ZlciAoaXQncyBhIFRPRE8pLCBzbyB3ZSBmYWN0b3INCj4gLSAgICAg
ICAgICogdGhhdCBpbiBoZXJlLg0KPiArICAgICAgICAgKiBXZSBlbmFibGUgY29weS1yYW5nZSwg
YnV0IGtlZXAgc21hbGwgY29weV9zaXplLCB1bnRpbCBmaXJzdA0KPiArICAgICAgICAgKiBzdWNj
ZXNzZnVsIGNvcHlfcmFuZ2UgKGxvb2sgYXQgYmxvY2tfY29weV9kb19jb3B5KS4NCj4gICAgICAg
ICAgICAqLw0KPiAgICAgICAgICAgcy0+dXNlX2NvcHlfcmFuZ2UgPSB0cnVlOw0KPiAtICAgICAg
ICBzLT5jb3B5X3NpemUgPSBNSU4oTUFYKGNsdXN0ZXJfc2l6ZSwgQkxPQ0tfQ09QWV9NQVhfQ09Q
WV9SQU5HRSksDQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICBRRU1VX0FMSUdOX0RPV04o
bWF4X3RyYW5zZmVyLCBjbHVzdGVyX3NpemUpKTsNCj4gKyAgICAgICAgcy0+Y29weV9zaXplID0g
TUFYKHMtPmNsdXN0ZXJfc2l6ZSwgQkxPQ0tfQ09QWV9NQVhfQlVGRkVSKTsNCj4gICAgICAgfQ0K
PiAgIA0KPiAgICAgICBRTElTVF9JTklUKCZzLT5pbmZsaWdodF9yZXFzKTsNCj4gQEAgLTE2OCw3
ICsxNzAsMjEgQEAgc3RhdGljIGludCBjb3JvdXRpbmVfZm4gYmxvY2tfY29weV9kb19jb3B5KEJs
b2NrQ29weVN0YXRlICpzLA0KPiAgICAgICAgICAgICAgIHMtPnVzZV9jb3B5X3JhbmdlID0gZmFs
c2U7DQo+ICAgICAgICAgICAgICAgcy0+Y29weV9zaXplID0gTUFYKHMtPmNsdXN0ZXJfc2l6ZSwg
QkxPQ0tfQ09QWV9NQVhfQlVGRkVSKTsNCj4gICAgICAgICAgICAgICAvKiBGYWxsYmFjayB0byBy
ZWFkK3dyaXRlIHdpdGggYWxsb2NhdGVkIGJ1ZmZlciAqLw0KPiAtICAgICAgICB9IGVsc2Ugew0K
PiArICAgICAgICB9IGVsc2UgaWYgKHMtPnVzZV9jb3B5X3JhbmdlKSB7DQo+ICsgICAgICAgICAg
ICAvKg0KPiArICAgICAgICAgICAgICogU3VjY2Vzc2Z1bCBjb3B5LXJhbmdlLiBOb3cgaW5jcmVh
c2UgY29weV9zaXplLg0KPiArICAgICAgICAgICAgICogY29weV9yYW5nZSBkb2VzIG5vdCByZXNw
ZWN0IG1heF90cmFuc2ZlciAoaXQncyBhIFRPRE8pLCBzbyB3ZQ0KPiArICAgICAgICAgICAgICog
ZmFjdG9yIHRoYXQgaW4gaGVyZS4NCj4gKyAgICAgICAgICAgICAqDQo+ICsgICAgICAgICAgICAg
KiBOb3RlOiB3ZSBkb3VibGUtY2hlY2sgcy0+dXNlX2NvcHlfcmFuZ2UgZm9yIHRoZSBjYXNlIHdo
ZW4NCj4gKyAgICAgICAgICAgICAqIHBhcmFsbGVsIGJsb2NrLWNvcHkgcmVxdWVzdCB1bnNldCBp
dCBkdXJpbmcgcHJldmlvdXMNCnVuc2V0cw0KDQo+ICsgICAgICAgICAgICAgKiBiZHJ2X2NvX2Nv
cHlfcmFuZ2UgY2FsbC4NCj4gKyAgICAgICAgICAgICAqLw0KPiArICAgICAgICAgICAgcy0+Y29w
eV9zaXplID0NCj4gKyAgICAgICAgICAgICAgICAgICAgTUlOKE1BWChzLT5jbHVzdGVyX3NpemUs
IEJMT0NLX0NPUFlfTUFYX0NPUFlfUkFOR0UpLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAg
UUVNVV9BTElHTl9ET1dOKGJsb2NrX2NvcHlfbWF4X3RyYW5zZmVyKHMtPnNvdXJjZSwNCj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBzLT50YXJnZXQpLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHMtPmNsdXN0ZXJfc2l6ZSkpOw0KPiAgICAgICAgICAgICAgIGdvdG8gb3V0Ow0KPiAgICAg
ICAgICAgfQ0KPiAgICAgICB9DQo+IEBAIC0xNzYsNyArMTkyLDEwIEBAIHN0YXRpYyBpbnQgY29y
b3V0aW5lX2ZuIGJsb2NrX2NvcHlfZG9fY29weShCbG9ja0NvcHlTdGF0ZSAqcywNCj4gICAgICAg
LyoNCj4gICAgICAgICogSW4gY2FzZSBvZiBmYWlsZWQgY29weV9yYW5nZSByZXF1ZXN0IGFib3Zl
LCB3ZSBtYXkgcHJvY2VlZCB3aXRoIGJ1ZmZlcmVkDQo+ICAgICAgICAqIHJlcXVlc3QgbGFyZ2Vy
IHRoYW4gQkxPQ0tfQ09QWV9NQVhfQlVGRkVSLiBTdGlsbCwgZnVydGhlciByZXF1ZXN0cyB3aWxs
DQo+IC0gICAgICogYmUgcHJvcGVybHkgbGltaXRlZCwgc28gZG9uJ3QgY2FyZSB0b28gbXVjaC4N
Cj4gKyAgICAgKiBiZSBwcm9wZXJseSBsaW1pdGVkLCBzbyBkb24ndCBjYXJlIHRvbyBtdWNoLiBN
b3Jlb3ZlciB0aGUgbW9zdCBwb3NzaWJsZQ0KPiArICAgICAqIGNhc2UgKGNvcHlfcmFuZ2UgaXMg
dW5zdXBwb3J0ZWQgZm9yIHRoZSBjb25maWd1cmF0aW9uLCBzbyB0aGUgdmVyeSBmaXJzdA0KPiAr
ICAgICAqIGNvcHlfcmFuZ2UgcmVxdWVzdCBmYWlscykgaXMgaGFuZGxlZCBieSBzZXR0aW5nIGxh
cmdlIGNvcHlfc2l6ZSBvbmx5DQo+ICsgICAgICogYWZ0ZXIgZmlyc3Qgc3VjY2Vzc2Z1bCBjb3B5
X3JhbmdlLg0KPiAgICAgICAgKi8NCj4gICANCj4gICAgICAgYm91bmNlX2J1ZmZlciA9IHFlbXVf
YmxvY2thbGlnbihzLT5zb3VyY2UtPmJzLCBuYnl0ZXMpOw0KPiANCg0KSXQgd291bGQgYmUgZ29v
ZCB0byBtYWtlIHRoYXQgY2xlYXIgd2hlcmUgdGhlIGxhcmdlIHNpemUgb2YgdGhlIGZpcnN0IA0K
cmVxdWVzdCBjb21lcyBmcm9tIGFuZCB3aGVyZSBpdCBpcyBjaGVja2VkIHdpdGggZmFpbHVyZS4N
Cg0KUmV2aWV3ZWQtYnk6IEFuZHJleSBTaGlua2V2aWNoIDxhbmRyZXkuc2hpbmtldmljaEB2aXJ0
dW96em8uY29tPg0KLS0gDQpXaXRoIHRoZSBiZXN0IHJlZ2FyZHMsDQpBbmRyZXkgU2hpbmtldmlj
aA0K

