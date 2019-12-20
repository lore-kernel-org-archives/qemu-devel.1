Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 221C6C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 10:07:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D088524680
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 10:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ZEfdMKIn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D088524680
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiFBo-0001gG-1D
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 05:07:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35438)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iiFB0-0000Fy-2z
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 05:06:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iiFAy-0005On-9F
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 05:06:29 -0500
Received: from mail-vi1eur04on072d.outbound.protection.outlook.com
 ([2a01:111:f400:fe0e::72d]:52974
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iiFAs-0004ko-Iq; Fri, 20 Dec 2019 05:06:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cXMSlo4AF/lFI+me1tYDPO0bDX+vFQ5Kp5JS9F7oq+NCwXSDlMW1PAWGPySNygovGgZu5M+Vv80OvX2U4w1anxszUBrrIWH3r6lj5hWXeG9JKgyjKJlYr3X59/J3Qd+WtiU6A3p9t5j1ocpZUWPTmt5xPT9EU60v3DlFykLI3OC2+lu8KwBjzK2Dfv1VPkXUho3qGbnwg3jR1L8JcpPsm9c3XFsg3kalnsTu4q0kLrRhT7HA7w4YXTyTQSHq36hjy0RQI0gQxoXazxc4YMaYtTxUTAzkR8Xyqv+ofzBihCsK+wkPvTYMXt3pN+Roj596Fj3lkjz7/9DBcPRvzX+dmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aH+ch2H2o0B68rmW3Ki9OD2aIGN3+0egSZy+7Dy/M8w=;
 b=WsnlbJmmCBiTRDwDEv/rrtXFJ4WWQkGaj4KFq9NimU/2Het5V53EV4JteeXKK4xzHzoz1k3UlKZSQxGxM/zUo4lXTlgASBl71yRkwbXlZbhCGhvfk0LQF2Pdlf2TNeYqvQ3DW5UmXv93cvmgFJSY5jJCzLKe7fDJxXG/IoQoGHdahvcSbsihHnyhY5yvWc7r4ZBJ/vWjTNYWhcL1/evW6ykeQRqS9ztDHHoEatbSoYwmgTj2/8MQ6c75pc7KaY4DSqkPm1u93y4Iaw3YJnEfo2jmKzqhDmdOAlusCUDuzr98QbqgxFqsey3wgtgzs37haG4qBZlPpMLKkOAHCFQXmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aH+ch2H2o0B68rmW3Ki9OD2aIGN3+0egSZy+7Dy/M8w=;
 b=ZEfdMKInKLf/5J0tEoQLdSW5QbopyjUycNGvESobS4Q3KXARkbTyutCoPS8EzscDGJbR74OGOdIcJapPd9ejc7sNZZdJp0+SlIzGUYPUYEnrFb2alLWvP+AQceHD0WWI3cnisWa7CNFysWBlTAj08MPaajC3mHo/I1n+wEihx0c=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Fri, 20 Dec 2019 10:06:17 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2559.016; Fri, 20 Dec 2019
 10:06:17 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Peter Krempa <pkrempa@redhat.com>
Subject: Re: [PATCH] block: nbd: Fix dirty bitmap context name
Thread-Topic: [PATCH] block: nbd: Fix dirty bitmap context name
Thread-Index: AQHVtmzMtpyWQS3Bp0OaQNZadGqOP6fBd04AgAAGUoCAAA9GgIAABQYAgAAKm4CAASlOgIAABMOAgAACxwA=
Date: Fri, 20 Dec 2019 10:06:17 +0000
Message-ID: <a372b586-17a4-9984-68d2-a1131fc219f2@virtuozzo.com>
References: <20191219125151.21482-1-nsoffer@redhat.com>
 <443c32b3-0e0c-ef9e-4d5b-9404b16eaa02@virtuozzo.com>
 <20191219140433.GK5230@linux.fritz.box>
 <CAMRbyyvqa1_3U=2Q7HmCrRcEq+yJjxUP7MM-GM5hUdrZw=yBOw@mail.gmail.com>
 <ddf58827-72e8-f853-e6bc-05d19100c62d@virtuozzo.com>
 <CAMRbyysHGjsWaCWXW2+iNSwU03DhavRF6sJ9-POUx3Mky6LK7Q@mail.gmail.com>
 <42c73579-fdaa-5590-39f9-ca9cacfeaa5e@virtuozzo.com>
 <20191220095617.GK4914@andariel.pipo.sk>
In-Reply-To: <20191220095617.GK4914@andariel.pipo.sk>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR06CA0143.eurprd06.prod.outlook.com
 (2603:10a6:7:16::30) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191220130614385
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b0cd44ea-2554-42b3-5766-08d7853440e2
x-ms-traffictypediagnostic: AM6PR08MB4423:
x-microsoft-antispam-prvs: <AM6PR08MB4423023531AD499F1138F27AC12D0@AM6PR08MB4423.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 025796F161
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(376002)(396003)(366004)(39850400004)(346002)(199004)(189003)(2906002)(8936002)(6486002)(966005)(54906003)(31696002)(81166006)(31686004)(316002)(66556008)(81156014)(64756008)(8676002)(66946007)(4326008)(6506007)(53546011)(6512007)(86362001)(66476007)(52116002)(36756003)(6916009)(186003)(26005)(66446008)(478600001)(2616005)(71200400001)(5660300002)(14143004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4423;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pGxS1BWzq14vNGnLQUgLzbyrMr0Buqi7H5fzmVLWhk5DRSqUUPJLe1s1jqJcP/3kABy9gUKS/Oyujq5SGSwhB2OPe3pn2FDRoQAcaI1QaZR0f3eWiuLC35gu7WxZECL5NRBbaOYJANjj3r0O9T4TYZ3kEFIEzuqnsMLWKM9wu+/3DfjRbCvX6uKjM9+OZXhix0rTQrQjoOYl4SmRnFrcZSvpNH4GOyNLF9nwGrzzJ1BfkhsR1U9YzpSYjYiCyqO89FeAqWQjMP2ADFnyCHywbMdlOA9IzAWQHcq1kJPQIOSKkQNZCVOs1MkaaDysRstwNs9yG5ymBHFrxwq0jCPaiaWpIKyVmwvkiUH4M8jBNm6aLaVK3x8fB/eLtdyeTmoWJtuNxj1EnJDAJUX9pUkCPR7NM3tKes3v1uGLcjAYb5OIWHkwcPTF7drclNO0SMv1KGBbWdEKxVC4MFeiSPWNK+BatoeZLqFYGjSRB7rG80ZgEEWZJcSGholXIUdl/+Ha+2mXCDyYrjQ9iGmBcCahfw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <EB8B9FBA1B86344EA10C5169839EEC2D@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0cd44ea-2554-42b3-5766-08d7853440e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2019 10:06:17.0852 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HC6OsCzJMymPx2TrvhUfK33x0WUJFp50CIrKXXyBWCC8yy1Y9vqP7V84o5eggFTzXfwrvxNtsSVsGuu6OqAL9vJTLiKyrZqdc/v2fnOhN9c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4423
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe0e::72d
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
Cc: Kevin Wolf <kwolf@redhat.com>, Nir Soffer <nirsof@gmail.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Nir Soffer <nsoffer@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjAuMTIuMjAxOSAxMjo1NiwgUGV0ZXIgS3JlbXBhIHdyb3RlOg0KPiBPbiBGcmksIERlYyAyMCwg
MjAxOSBhdCAwOTozOToxNyArMDAwMCwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90
ZToNCj4+IDE5LjEyLjIwMTkgMTg6NTUsIE5pciBTb2ZmZXIgd3JvdGU6DQo+Pj4gT24gVGh1LCBE
ZWMgMTksIDIwMTkgYXQgNToxNyBQTSBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5DQo+Pj4g
PHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4gd3JvdGU6DQo+Pj4+DQo+Pj4+IDE5LjEyLjIwMTkg
MTc6NTksIE5pciBTb2ZmZXIgd3JvdGU6DQo+Pj4+PiBPbiBUaHUsIERlYyAxOSwgMjAxOSBhdCA0
OjA0IFBNIEtldmluIFdvbGYgPGt3b2xmQHJlZGhhdC5jb20+IHdyb3RlOg0KPj4+Pj4+DQo+Pj4+
Pj4gQW0gMTkuMTIuMjAxOSB1bSAxNDo0MSBoYXQgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tp
eSBnZXNjaHJpZWJlbjoNCj4+Pj4+Pj4gQWhoLCBJIHNlZSwgaXQncyBkb2N1bWVudGVkIGFzDQo+
Pj4+Pj4+DQo+Pj4+Pj4+ICsjIEBiaXRtYXA6IEFsc28gZXhwb3J0IHRoZSBkaXJ0eSBiaXRtYXAg
cmVhY2hhYmxlIGZyb20gQGRldmljZSwgc28gdGhlDQo+Pj4+Pj4+ICsjICAgICAgICAgIE5CRCBj
bGllbnQgY2FuIHVzZSBOQkRfT1BUX1NFVF9NRVRBX0NPTlRFWFQgd2l0aA0KPj4+Pj4+PiArIyAg
ICAgICAgICAicWVtdTpkaXJ0eS1iaXRtYXA6TkFNRSIgdG8gaW5zcGVjdCB0aGUgYml0bWFwLiAo
c2luY2UgNC4wKQ0KPj4+Pj4+Pg0KPj4+Pj4+PiBhbmQgaXQgaXMgbG9naWNhbCB0byBhc3N1bWUg
dGhhdCBleHBvcnQgbmFtZSAod2hpY2ggaXMgQG5hbWUgYXJndW1lbnQpIGlzDQo+Pj4+Pj4+IG1l
bnRpb25lZC4gQnV0IHdlIG5ldmVyIG1lbnRpb25lZCBpdC4gVGhpcyBpcyBqdXN0IGRvY3VtZW50
ZWQgYWZ0ZXINCj4+Pj4+Pj4gcmVtb3ZlZCBleHBlcmltZW5hdGwgY29tbWFuZCB4LW5iZC1zZXJ2
ZXItYWRkLWJpdG1hcCwNCj4+Pj4+Pj4NCj4+Pj4+Pj4gbG9vayBhdA0KPj4+Pj4+Pg0KPj4+Pj4+
PiBjb21taXQgN2RjNTcwYjM4MDZlNWIwYTRjOTIxOTA2MTU1NmVkNWE0YTBkZTgwYw0KPj4+Pj4+
PiBBdXRob3I6IEVyaWMgQmxha2UgPGVibGFrZUByZWRoYXQuY29tPg0KPj4+Pj4+PiBEYXRlOiAg
IEZyaSBKYW4gMTEgMTM6NDc6MTggMjAxOSAtMDYwMA0KPj4+Pj4+Pg0KPj4+Pj4+PiAgICAgICAg
IG5iZDogUmVtb3ZlIHgtbmJkLXNlcnZlci1hZGQtYml0bWFwDQo+Pj4+Pj4+DQo+Pj4+Pj4+IC4u
Lg0KPj4+Pj4+Pg0KPj4+Pj4+PiAtIyBAYml0bWFwLWV4cG9ydC1uYW1lOiBIb3cgdGhlIGJpdG1h
cCB3aWxsIGJlIHNlZW4gYnkgbmJkIGNsaWVudHMNCj4+Pj4+Pj4gLSMgICAgICAgICAgICAgICAg
ICAgICAgKGRlZmF1bHQgQGJpdG1hcCkNCj4+Pj4+Pj4gLSMNCj4+Pj4+Pj4gLSMgTm90ZTogdGhl
IGNsaWVudCBtdXN0IHVzZSBOQkRfT1BUX1NFVF9NRVRBX0NPTlRFWFQgd2l0aCBhIHF1ZXJ5IG9m
DQo+Pj4+Pj4+IC0jICJxZW11OmRpcnR5LWJpdG1hcDpOQU1FIiAod2hlcmUgTkFNRSBtYXRjaGVz
IEBiaXRtYXAtZXhwb3J0LW5hbWUpIHRvIGFjY2Vzcw0KPj4+Pj4+PiAtIyB0aGUgZXhwb3NlZCBi
aXRtYXAuDQo+Pj4+Pj4+DQo+Pj4+Pj4+DQo+Pj4+Pj4+IFNvLCB0aGlzICJOQU1FIiBpcyBzYXZl
ZCBhbmQgbm93IGxvb2tzIGluY29ycmVjdC4gV2hhdCBzaG91bGQgYmUgZml4ZWQsIGlzIFFhcGkN
Cj4+Pj4+Pj4gZG9jdW1lbnRhdGlvbi4NCj4+Pj4+Pg0KPj4+Pj4+IEhtLCBJIGRvbid0IGtub3cg
dGhlc2UgaW50ZXJmYWNlcyB2ZXJ5IHdlbGwsIGJ1dCBmcm9tIHlvdSBleHBsYW5hdGlvbiBpdA0K
Pj4+Pj4+IGxvb2tzIHRvIG1lIGFzIGlmIGhhdmluZyBhIGJpdG1hcCBuYW1lIG1hZGUgc2Vuc2Ug
d2l0aA0KPj4+Pj4+IHgtbmJkLXNlcnZlci1hZGQtYml0bWFwIGJlY2F1c2UgaXQgY291bGQgYmUg
Y2FsbGVkIG1vcmUgdGhhbiBvbmNlIGZvcg0KPj4+Pj4+IGV4cG9ydGluZyBtdWx0aXBsZSBiaXRt
YXBzLg0KPj4+Pj4+DQo+Pj4+Pj4gQnV0IG5vdywgd2UgaGF2ZSBvbmx5IG5iZC1zZXJ2ZXItYWRk
LCB3aGljaCB0YWtlcyBhIHNpbmdsZSBiaXRtYXAgbmFtZS4NCj4+Pj4+PiBBcyB3ZSBkb24ndCBo
YXZlIHRvIGRpc3Rpbmd1aXNoIG11bHRpcGxlIGJpdG1hcHMgYW55IG1vcmUsIHdvdWxkbid0IGl0
DQo+Pj4+Pj4gbWFrZSBtb3JlIHNlbnNlIHRvIHVzZSAicWVtdTpkaXJ0eS1iaXRtYXAiIHdpdGhv
dXQgYW55IG90aGVyDQo+Pj4+Pj4gaW5mb3JtYXRpb24/IEJvdGggZXhwb3J0IG5hbWUgYW5kIGJp
dG1hcCBuYW1lIGFyZSBhbHJlYWR5IGlkZW50aWZpZWQgYnkNCj4+Pj4+PiB0aGUgY29ubmVjdGlv
bi4NCj4+Pj4+DQo+Pj4+PiBXZSBjYW4gdXNlIGVtcHR5IHN0cmluZyAobGlrZSB0aGUgZGVmYXVs
dCBleHBvcnQgbmFtZSksIHNvIHRoZSBiaXRtYXANCj4+Pj4+IHdvdWxkIGJlIGV4cG9zZWQgYXM6
DQo+Pj4+Pg0KPj4+Pj4gICAgICAgICJxZW11OmRpcnR5LWJpdG1hcDoiDQo+Pj4+Pg0KPj4+Pj4g
VGhpcyB3b3VsZCBzb2x2ZSB0aGUgaXNzdWUgZm9yIHVzZXJzLCBhbmQga2VlcCB0aGUgQVBJIGV4
dGVuc2libGUuDQo+Pj4+DQo+Pj4+IEFzIEkgYWxyZWFkeSBzYWlkLCB3ZSBjYW4gbm90LiBJZiB3
ZSByZWFsbHkgd29udCBzdWNoIHRoaW5nLCB1c2UgYW5vdGhlciBuYW1lLA0KPj4+PiBsaWtxIHFl
bXU6ZGVmYXVsdC1kaXJ0eS1iaXRtYXAuLg0KPj4+Pg0KPj4+PiBPciBjYWxsIGJpdG1hcCBleHBv
cnQgImRlZmF1bHQiLCB0byBwcm9kdWNlDQo+Pj4+ICAgICAicWVtdTpkaXJ0eS1iaXRtYXBzOmRl
ZmF1bHQiDQo+Pj4+DQo+Pj4+IEJ1dCBkb24ndCBjaGFuZ2UgZGVmYXVsdCBiZWhhdmlvciBvZiBu
YmQtc2VydmVyLWFkZA0KPj4+Pg0KPj4+Pj4NCj4+Pj4+PiBCdXQgaWYgd2UgaGF2ZSB0byBoYXZl
IHNvbWV0aGluZyB0aGVyZSwgdXNpbmcgdGhlIGJpdG1hcCBuYW1lICh3aGljaCBtYXkNCj4+Pj4+
PiBvciBtYXkgbm90IGJlIHRoZSBzYW1lIGFzIHVzZWQgaW4gdGhlIGltYWdlIGZpbGUpIG1ha2Vz
IGEgbGl0dGxlIG1vcmUNCj4+Pj4+PiBzZW5zZSBiZWNhdXNlIGl0IG1ha2VzIHRoZSBpbnRlcmZh
Y2UgZXh0ZW5zaWJsZSBmb3IgdGhlIGNhc2UgdGhhdCB3ZQ0KPj4+Pj4+IGV2ZXIgd2FudCB0byBy
ZS1pbnRyb2R1Y2UgYW4gbmJkLXNlcnZlci1hZGQtYml0bWFwLg0KPj4+Pj4NCj4+Pj4+IEJ1dCB1
c2luZyB0aGUgYml0bWFwIG5hbWUgbWVhbnMgdXNlciBvZiB0aGUgTkJEIHNlcnZlciBuZWVkIHRv
IGtub3cgdGhpcyBuYW1lLg0KPj4+Pg0KPj4+PiBXaHkgbm90PyBXaGF0IGlzIHlvdXIgY2FzZSBl
eGFjdGx5PyBVc2VyIGtub3dzLCB3aGF0IGtpbmQgb2YgYml0bWFwIHlvdSBhcmUNCj4+Pj4gZXhw
b3J0aW5nLCBzbyB1c2VyIGlzIGluIHNvbWUgcmVsYXRpb24gd2l0aCBleHBvcnRpbmcgcHJvY2Vz
cyBhbnl3YXkuIFdoeQ0KPj4+PiBzaG91bGRuJ3QgaXQga25vdyB0aGUgbmFtZT8NCj4+Pg0KPj4+
IEJlY2F1c2UgdGhlIHVzZXIgY29uZmlndXJpbmcgcWVtdSAobGlidmlydCkgaXMgbm90IHRoZSBz
YW1lIHVzZXINCj4+PiBhY2Nlc3NpbmcgcWVtdSBOQkQNCj4+PiBzZXJ2ZXIgKG92aXJ0LCBvciBz
b21lIGJhY2t1cCBhcHBsaWNhdGlvbikuDQo+Pj4NCj4+Pj4gVGhpcyBuYW1lIG1heSBiZSBkZWZp
bmVkIGluIHlvdSBleHBvcnRpbmcgcHJvdG9jb2wuLiBXaGF0IGFyZSB5b3UgZXhwb3J0aW5nPw0K
Pj4+DQo+Pj4gV2UgZXhwb3J0IEhUVFAgQVBJLCBhbGxvd2luZyBnZXR0aW5nIGRpcnR5IGV4dGVu
dHMgYW5kIHJlYWRpbmcgZGF0YToNCj4+PiBodHRwczovL3d3dy5vdmlydC5vcmcvZGV2ZWxvcC9y
ZWxlYXNlLW1hbmFnZW1lbnQvZmVhdHVyZXMvc3RvcmFnZS9pbmNyZW1lbnRhbC1iYWNrdXAuaHRt
bCNtYXAtcmVxdWVzdA0KPj4+ICh0aGlzIGRvY3VtZW50IGlzIG91dGRhdGVkLCBidXQgaXQgZ2l2
ZXMgdGhlIGdlbmVyYWwgaWRlYSkNCj4+Pg0KPj4+IE9yIHByb3ZpZGUgdGhlIE5CRCBVUkwgZGly
ZWN0bHkgdG8gdXNlciAoZnV0dXJlKS4NCj4+Pg0KPj4+PiBOb3RlIGFsc28sIHRoYXQgY2xpZW50
IG1heSB1c2UgTkJEX09QVF9MSVNUX01FVEFfQ09OVEVYVCB3aXRoIHF1ZXJ5DQo+Pj4+ICJxZW11
OmRpcnR5LWJpdG1hcDoiLCB0byBnZXQgbGlzdCBvZiBhbGwgZXhwb3J0ZWQgYml0bWFwcy4NCj4+
Pg0KPj4+IFRoaXMgaXMgYW5vdGhlciBvcHRpb24sIEkgZGlkIG5vdCB0cnkgdG8gdXNlIHRoaXMg
eWV0LiBXZSBjYW4gdXNlIHRoZSBzaW5nbGUNCj4+PiBleHBvcnRlZCBiaXRtYXAgYW5kIGZhaWwg
aWYgd2UgZ2V0IG1vcmUgdGhhbiBvbmUuIFRoaXMgaXMgcHJvYmFibHkgYmV0dGVyDQo+Pj4gdGhh
biBjaGFuZ2luZyB0aGUgZW50aXJlIHN0YWNrIHRvIHN1cHBvcnQgYml0bWFwIG5hbWUuDQo+Pj4N
Cj4+Pj4+IE9uZSBvcHRpb24gaXMgdGhhdCBsaWJ2aXJ0IHdvdWxkIHB1Ymxpc2ggdGhlIG5hbWUg
b2YgdGhlIGJpdG1hcCBpbiB0aGUNCj4+Pj4+IHhtbCBkZXNjcmliaW5nDQo+Pj4+PiB0aGUgYmFj
a3VwLCBhbmQgb1ZpcnQgd2lsbCBoYXZlIHRvIHByb3BhZ2F0ZSB0aGlzIG5hbWUgdG8gdGhlIGFj
dHVhbA0KPj4+Pj4gcHJvZ3JhbSBhY2Nlc3NpbmcNCj4+Pj4+IHRoZSBOQkQgc2VydmVyLCB3aGlj
aCBtYXkgYmUgYSB1c2VyIHByb2dyYW0gaW4gdGhlIGNhc2Ugd2hlbiB3ZSBleHBvc2UgdGhlIE5C
RA0KPj4+Pj4gVVJMIHRvIHVzZXJzIChwbGFubmVkIGZvciBmdXR1cmUgdmVyc2lvbikuDQo+Pj4+
Pg0KPj4+Pj4gQW5vdGhlciBvcHRpb24gaXMgdGhhdCB0aGUgdXNlciB3aWxsIGNvbnRyb2wgdGhp
cyBuYW1lLCBhbmQgbGlidmlydA0KPj4+Pj4gd2lsbCB1c2UgdGhlIG5hbWUgc3BlY2lmaWVkDQo+
Pj4+PiBieSB0aGUgdXNlci4gVGhpcyBtZWFucyBvVmlydCB3aWxsIGhhdmUgdG8gcHJvdmlkZSBB
UEkgdG8gc2V0IHRoaXMNCj4+Pj4+IG5hbWUgYW5kIHBhc3MgaXQgdG8gbGlidmlydC4NCj4+Pj4+
DQo+Pj4+PiBCb3RoIGNhc2VzIHJlcXVpcmUgbG90IG9mIGVmZm9ydCB3aGljaCBkb2VzIG5vdCBo
ZWxwIGFueW9uZSBpbiB0aGUNCj4+Pj4+IHRhc2sgb2YgZ2V0dGluZyBkaXJ0eQ0KPj4+Pj4gZXh0
ZW50cyBmcm9tIGFuIGltYWdlIC0gd2hpY2ggaXMgb3VyIGN1cnJlbnQgZ29hbC4gV2UgbmVlZCB0
byBoYXZlDQo+Pj4+PiBnb29kIGRlZmF1bHRzIHRoYXQNCj4+Pj4+IHNhdmUgdW5uZWVkZWQgZWZm
b3J0IGluIHRoZSBlbnRpcmUgc3RhY2suDQo+Pj4+DQo+Pj4+IFNvLCB5b3UgaW1wbGVtZW50aW5n
IHNvbWUgcHJvdG9jb2wsIGFuZCBuZWVkIHRvIGV4cG9ydCBvbmx5IG9uZSBiaXRtYXAgZm9yDQo+
Pj4+IHlvdXIgc3BlY2lmaWVkIHNjZW5hcmlvLiBXaHkgbm90IGp1c3QgZ2l2ZSBhIGNvbnN0YW50
IG5hbWU/IExpa2Ugb3ZpcnQtYml0bWFwLA0KPj4+PiBvciBzb21ldGhpbmcgbGlrZSB0aGlzPw0K
Pj4+DQo+Pj4gQnV0IHdlIGRvbid0IHVzZSBxZW11IGRpcmVjdGx5LiBXZSB1c2UgbGlidmlydCwg
YW5kIGxpYnZpcnQgZG9lcyBub3QgZXhwb3NlDQo+Pj4gdGhlIG5hbWUgb2YgdGhlIGJpdG1hcCwg
b3IgbGV0IHVzZSBjb250cm9sIHRoaXMgbmFtZS4NCj4+Pg0KPj4+IFRoaXMgaXMgYSBzaW1wbGlm
aWVkIGZsb3c6DQo+Pj4gMS4gbGlidmlydCBzdGFydHMgYSBiYWNrdXAsIGNyZWF0aW5nIHRoZSAi
YmFja3VwLWV4cG9ydG5hbWUiIGJpdG1hcA0KPj4NCj4+IEJ1dCBkbyB5b3UgbWFuYWdlIGV4cG9y
dG5hbWUsIG9yIG5vdD8NCj4gDQo+IFRoZXkgY2FuJ3QgbWFuYWdlIHRoZSBleHBvcnQgbmFtZSBl
aXRoZXIsIGJ1dCBhcHBhcmVudGx5IHRoZSBkZWZhdWx0DQo+IHRoYXQgbGlidmlydCB1c2VzIHN1
aXRzIHRoZW0uDQo+IA0KPiBJIGNhbiBhZGQgcG9zc2liaWxpdHkgdG8gbmFtZSB0aGUgYWN0dWFs
IGJhY2t1cCBvdXRwdXQgYml0bWFwDQo+IGFyYml0cmFyaWx5LiBPYnZpb3VzbHkgdGhlIHVzZXIg
dGhlbiBoYXMgdG8gcGFzcyBhIHNlbnNpYmxlIG5hbWUgb2YgYQ0KPiBub24gZXhpc3RhbnQgYml0
bWFwIHRvIHByb2NlZWQuDQo+IA0KPiBNYWtpbmcgYm90aCBjb25maWd1cmFibGUgYXQgdGhlIHNh
bWUgdGltZSBtYXkgYmUgd29ydGggZG9pbmcgYXMgaXQgd2lsbA0KPiBiZSBiYXNpY2FsbHkgdGhl
IHNhbWUgY29kZS4NCj4gDQoNCkludHVpdGl2ZWx5LCBJIHRoaW5rIGl0J3MgYmV0dGVyIGxlYXZl
IGJpdG1hcCBuYW1lIGFzIGlzOiBsaWJ2aXJ0IG1hbmFnZXMNCmJpdG1hcHMsIHNvIGxldCBpdCBt
YW5hZ2UgdGhlaXIgbmFtZXMgYXMgaXQgd2FudHMuIEFuZCBJIGRvbid0IHRoaW5rIHRoYXQNCk5p
ciB3YW50IHRvIGNhcmUgYWJvdXQgZXhpc3RpbmcgYml0bWFwcy4NCg0KQnV0IGJpdG1hcC1leHBv
cnQtbmFtZSBpcyB0aGUgb3RoZXIgdGhpbmcuIEl0J3MgYSBiaXRtYXAgbmFtZSwgYXMgaXQNCnJl
cHJlc2VudGVkIHRvIE5CRCBjbGllbnQuIEFuZCBpdCBtYXkgYmUgc29tZXRoaW5nIG90aGVyLiBC
eSBkZWZhdWx0DQpRZW11IHVzZXMgbmFtZSBvZiB0aGUgYml0bWFwIGFzIHRoaXMgbmFtZSwgYnV0
IHdlIGNhbiBhZGQgYW4gb3B0aW9uDQp0byBhbHRlciB0aGlzIGJlaGF2aW9yIChhY3R1YWxseSB3
ZSBoYWQgc3VjaCBvcHRpb24gaW4gZXhwZXJpbWVudGFsDQp4LW5iZC1zZXJ2ZXItYWRkLWJpdG1h
cCwgd2hpY2ggd2FzIGRyb3BwZWQpLg0KDQpUaGVuLCBmb3IgdGhpcyAibmJkIGJpdG1hcCBuYW1l
IiBvciAiZXhwb3J0IGJpdG1hcCBuYW1lIiwgTmlyIHdpbGwgYmUNCmFibGUgdG8gdXNlIHNvbWUg
Y29uc3RhbnQgbmFtZSwgd2hpY2ggd2lsbCBuZXZlciBjb25mbGljdCB3aXRoIG90aGVyDQpiaXRt
YXBzLCBhcyBpdCBpcyB0aGUgb3RoZXIgdGhpbmcgKHBhcnQgb2YgTkJEIG1ldGFkYXRhIGNvbnRl
eHQgbmFtZSkNCg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

