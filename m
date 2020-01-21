Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0491C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 14:01:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EEF522314
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 14:01:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="TwsaGqPz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EEF522314
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itu5n-0002n0-60
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 09:01:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55627)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1itt1x-00019M-9B
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 07:53:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1itt1v-0007Zh-G0
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 07:53:17 -0500
Received: from mail-am6eur05on2116.outbound.protection.outlook.com
 ([40.107.22.116]:62657 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1itt1o-0007WX-R1; Tue, 21 Jan 2020 07:53:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AZ7x8XThhHyKvGhCw6MkhvESmruDEsK6RmdKUvTTB8AbuqdsUKYe1o7JnwElZl5t3WyHEDywSH4wwxhl0U1E8mJ865dkKjPhTQAjz+e7weeGzoDFRb5DijMDJxFYy4uEqPD3Z72YuJ+2SbRxBCiDLj+wCqgXPFuh/s0O1JW3W2EEcDyVgmLzNekwUDE53o0zrtRN4D02bRtQ/fJpSkwppB7esfqXytIjiHtXTwWmqfo7qGpUjDEwRyzvMMaGpw0qY9NLAOFpe7GWq7oRETI+S/H/W8IUn+6EphRLmfeosU5Q/6kzKbZEn6AIMNHJwdV1I/j1q+/g5tJpM+qfsqIppg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4A/+QdWl5mpmaAZiNO41enXxTLEtFoaL0Vxqn2R5FpE=;
 b=euN/eOO5hN+ePGaGO3At/G1IwNAkn1Id71fTB9I3IraykKP2wy71yvMLk94Gj8v6hJqmoE+yM47w6D75L9fbqqjkKwefyPqXUAtCsD99d7ejh2C7LTqpz/XBBK6/Uc6UQegwGdH/1NpPEns7znxEsnSMsGoadTm6zeZftI0NGbbNJk19TxGxY5xwTlT2RYPATSGkJYGQLSRdHp/Ks8+mUMlzZQeUlMDRv/oQ7EWmo2wlaIpJKciTdkTtlbCquVwxvPTHKEO0IUSJ5/s4+j6wNPHOnnXvdUFBHhOipBTVSpLGbnZQBq04cBHJ58k8A0N0Q1FCnMdq+cSHw5ltrR7D2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4A/+QdWl5mpmaAZiNO41enXxTLEtFoaL0Vxqn2R5FpE=;
 b=TwsaGqPz0YF5G347e/nr+tWYMVE6/Bd1OgWXRioikt8QU5DY5eTW0rQhgjxuBuEBCK3JmhuNcXFGI94hLrbwz4MJFOKnVPnQUpzL/k+lkhuukEjmKhq5tZjs8zr844kj7+kMGhkSvBbA5H6Gg13DqzrvYTxRfRk7a6Wx86ouz3w=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4485.eurprd08.prod.outlook.com (20.179.7.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.22; Tue, 21 Jan 2020 12:53:07 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2644.027; Tue, 21 Jan 2020
 12:53:07 +0000
Received: from [172.16.24.200] (185.231.240.5) by
 AM5PR0402CA0021.eurprd04.prod.outlook.com (2603:10a6:203:90::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.18 via Frontend
 Transport; Tue, 21 Jan 2020 12:53:06 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH 2/2] iotests: add test for backup-top failure on
 permission activation
Thread-Topic: [PATCH 2/2] iotests: add test for backup-top failure on
 permission activation
Thread-Index: AQHVzIVUyOIzH3fEwkGWDPORhit+OafzzmgAgAAESICAAQrFgIAANI8A///S/oCAABBigIAAIRyAgAAD5IA=
Date: Tue, 21 Jan 2020 12:53:06 +0000
Message-ID: <61b2915c-01fd-65ab-a5c0-5f2e089baf60@virtuozzo.com>
References: <20200116155452.30972-1-vsementsov@virtuozzo.com>
 <20200116155452.30972-3-vsementsov@virtuozzo.com>
 <eedd42b6-bf4e-f6de-13a4-412d389fdb09@redhat.com>
 <ea9219cd-8cc1-8cc0-d568-a51013ba74a4@virtuozzo.com>
 <f52b6ff5-e993-d567-cbbe-1d6d158908da@redhat.com>
 <0e865df2-7d21-b18f-b73c-2948577b9dcb@virtuozzo.com>
 <1313e55e-0eb1-890a-4e8e-2517f1e80d38@redhat.com>
 <04a32d71-31da-a3e3-5c5f-cc6465fc9402@virtuozzo.com>
 <6923bc19-d203-63af-b206-8fe18e4a01c6@redhat.com>
In-Reply-To: <6923bc19-d203-63af-b206-8fe18e4a01c6@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR0402CA0021.eurprd04.prod.outlook.com
 (2603:10a6:203:90::31) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20200121155303642
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 291b2a88-cdb7-480d-5487-08d79e70dc74
x-ms-traffictypediagnostic: AM6PR08MB4485:
x-microsoft-antispam-prvs: <AM6PR08MB4485114C65E72FD17C7EA192C10D0@AM6PR08MB4485.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0289B6431E
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(136003)(366004)(376002)(39850400004)(346002)(199004)(189003)(53546011)(54906003)(31686004)(52116002)(4326008)(16576012)(64756008)(26005)(66556008)(81166006)(6486002)(110136005)(186003)(66446008)(16526019)(8676002)(66476007)(66946007)(2906002)(5660300002)(81156014)(31696002)(316002)(36756003)(2616005)(508600001)(86362001)(8936002)(956004)(71200400001)(2004002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4485;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NqUMXVd+COm1T2FN6VSobPgpN7r78+otR9/oYhMkzsDo/CGR672CyijQRtT5Cz+GOBpucDZFZ/vhaLSADVjROHZLk5Alchr8gIKmVuSCzjeN39IJdg23TJBFIkEUkmu5QIz/y6ZYgvVFVakuVCx3dQBv/rqNNo6LqiGUgj4r6jvlCyBKtII2jsNR0d9k0Uupb/QJHav9CioG4BSfBsuO1wJM2+O1pL8jNRBBwDsLTgpr5M+C+jt3Ey1M+9RcsIRWx2VBgTIG70t57+dKDNr2ERkipS30YH7oMsk8k3r4RwZOD5n6vVFZJfIYIScVEgx7p3vtGj6XB6//D5XyQZIzhL0uY/uNNzgFai1b4myqQKg3TT+wmqUvy1RAP9xQMW1miRSytIodBcyW83SOoG3fmB9+S00tmw4uuD5tLMf+w8y9oObt9xAGauRXJQd0aHSDA69XuqyalQnRGa97ozenPhPzebSua8UsB1E1qw35yzXII3yzhygrpAC0LqHVtxrUDRDVPELxpBvvbUEVAh8RSJHCvq/S8FbzcaLHlrvGluFAYQO4QAbhjt127OvNFsl6
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <FB001D1CCF786C4DA1F7D966A27A3ABC@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 291b2a88-cdb7-480d-5487-08d79e70dc74
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2020 12:53:06.9261 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vqcXpR1T3N7D7omBAOwX8RsWxUPKClPNmUSNWdBYYdEu0Jdloc52/f3NbJm2v4nwILoi7qqamGVGqoQWV+WDvjC5dgMur70VWoO2lQvdjGs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4485
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.22.116
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjEuMDEuMjAyMCAxNTozOSwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAyMS4wMS4yMCAxMTo0MCwg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IDIxLjAxLjIwMjAgMTI6NDEs
IE1heCBSZWl0eiB3cm90ZToNCj4+PiBPbiAyMS4wMS4yMCAxMDoyMywgVmxhZGltaXIgU2VtZW50
c292LU9naWV2c2tpeSB3cm90ZToNCj4+Pj4gMjEuMDEuMjAyMCAxMjoxNCwgTWF4IFJlaXR6IHdy
b3RlOg0KPj4+Pj4gT24gMjAuMDEuMjAgMTg6MjAsIFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNr
aXkgd3JvdGU6DQo+Pj4+Pj4gMjAuMDEuMjAyMCAyMDowNCwgTWF4IFJlaXR6IHdyb3RlOg0KPj4+
Pj4+PiBPbiAxNi4wMS4yMCAxNjo1NCwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90
ZToNCj4+Pj4+Pj4+IFRoaXMgdGVzdCBjaGVja3MgdGhhdCBidWcgaXMgcmVhbGx5IGZpeGVkIGJ5
IHByZXZpb3VzIGNvbW1pdC4NCj4+Pj4+Pj4+DQo+Pj4+Pj4+PiBDYzogcWVtdS1zdGFibGVAbm9u
Z251Lm9yZyAjIHY0LjIuMA0KPj4+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogVmxhZGltaXIgU2VtZW50
c292LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPg0KPj4+Pj4+Pj4gLS0tDQo+
Pj4+Pj4+PiAgICAgIHRlc3RzL3FlbXUtaW90ZXN0cy8yODMgICAgIHwgNzUgKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysNCj4+Pj4+Pj4+ICAgICAgdGVzdHMvcWVtdS1pb3Rl
c3RzLzI4My5vdXQgfCAgOCArKysrDQo+Pj4+Pj4+PiAgICAgIHRlc3RzL3FlbXUtaW90ZXN0cy9n
cm91cCAgIHwgIDEgKw0KPj4+Pj4+Pj4gICAgICAzIGZpbGVzIGNoYW5nZWQsIDg0IGluc2VydGlv
bnMoKykNCj4+Pj4+Pj4+ICAgICAgY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RzL3FlbXUtaW90ZXN0
cy8yODMNCj4+Pj4+Pj4+ICAgICAgY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RzL3FlbXUtaW90ZXN0
cy8yODMub3V0DQo+Pj4+Pj4+DQo+Pj4+Pj4+IFRoZSB0ZXN0IGxvb2tzIGdvb2QgdG8gbWUsIEkg
anVzdCBoYXZlIGEgY29tbWVudCBuaXQgYW5kIGEgbm90ZSBvbiB0aGUNCj4+Pj4+Pj4gZmFjdCB0
aGF0IHRoaXMgc2hvdWxkIHByb2JhYmx5IGJlIHF1ZXVlZCBvbmx5IGFmdGVyIFRob21hc+KAmXMg
4oCcRW5hYmxlDQo+Pj4+Pj4+IG1vcmUgaW90ZXN0cyBkdXJpbmcgIm1ha2UgY2hlY2stYmxvY2si
4oCdIHNlcmllcy4NCj4+Pj4+Pj4NCj4+Pj4+Pj4+IGRpZmYgLS1naXQgYS90ZXN0cy9xZW11LWlv
dGVzdHMvMjgzIGIvdGVzdHMvcWVtdS1pb3Rlc3RzLzI4Mw0KPj4+Pj4+Pj4gbmV3IGZpbGUgbW9k
ZSAxMDA2NDQNCj4+Pj4+Pj4+IGluZGV4IDAwMDAwMDAwMDAuLmYwZjIxNmQxMDkNCj4+Pj4+Pj4+
IC0tLSAvZGV2L251bGwNCj4+Pj4+Pj4+ICsrKyBiL3Rlc3RzL3FlbXUtaW90ZXN0cy8yODMNCj4+
Pj4+Pj4+IEBAIC0wLDAgKzEsNzUgQEANCj4+Pj4+Pj4+ICsjIS91c3IvYmluL2VudiBweXRob24N
Cj4+Pj4+Pj4+ICsjDQo+Pj4+Pj4+PiArIyBUZXN0IGZvciBiYWNrdXAtdG9wIGZpbHRlciBwZXJt
aXNzaW9uIGFjdGl2YXRpb24gZmFpbHVyZQ0KPj4+Pj4+Pj4gKyMNCj4+Pj4+Pj4+ICsjIENvcHly
aWdodCAoYykgMjAxOSBWaXJ0dW96em8gSW50ZXJuYXRpb25hbCBHbWJILg0KPj4+Pj4+Pj4gKyMN
Cj4+Pj4+Pj4+ICsjIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3YXJlOyB5b3UgY2FuIHJlZGlz
dHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5DQo+Pj4+Pj4+PiArIyBpdCB1bmRlciB0aGUgdGVybXMg
b2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGFzIHB1Ymxpc2hlZCBieQ0KPj4+Pj4+
Pj4gKyMgdGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbjsgZWl0aGVyIHZlcnNpb24gMiBvZiB0
aGUgTGljZW5zZSwgb3INCj4+Pj4+Pj4+ICsjIChhdCB5b3VyIG9wdGlvbikgYW55IGxhdGVyIHZl
cnNpb24uDQo+Pj4+Pj4+PiArIw0KPj4+Pj4+Pj4gKyMgVGhpcyBwcm9ncmFtIGlzIGRpc3RyaWJ1
dGVkIGluIHRoZSBob3BlIHRoYXQgaXQgd2lsbCBiZSB1c2VmdWwsDQo+Pj4+Pj4+PiArIyBidXQg
V0lUSE9VVCBBTlkgV0FSUkFOVFk7IHdpdGhvdXQgZXZlbiB0aGUgaW1wbGllZCB3YXJyYW50eSBv
Zg0KPj4+Pj4+Pj4gKyMgTUVSQ0hBTlRBQklMSVRZIG9yIEZJVE5FU1MgRk9SIEEgUEFSVElDVUxB
UiBQVVJQT1NFLiAgU2VlIHRoZQ0KPj4+Pj4+Pj4gKyMgR05VIEdlbmVyYWwgUHVibGljIExpY2Vu
c2UgZm9yIG1vcmUgZGV0YWlscy4NCj4+Pj4+Pj4+ICsjDQo+Pj4+Pj4+PiArIyBZb3Ugc2hvdWxk
IGhhdmUgcmVjZWl2ZWQgYSBjb3B5IG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZQ0K
Pj4+Pj4+Pj4gKyMgYWxvbmcgd2l0aCB0aGlzIHByb2dyYW0uICBJZiBub3QsIHNlZSA8aHR0cDov
L3d3dy5nbnUub3JnL2xpY2Vuc2VzLz4uDQo+Pj4+Pj4+PiArIw0KPj4+Pj4+Pj4gKw0KPj4+Pj4+
Pj4gK2ltcG9ydCBpb3Rlc3RzDQo+Pj4+Pj4+PiArDQo+Pj4+Pj4+PiArIyBUaGUgdGVzdCBpcyB1
bnJlbGF0ZWQgdG8gZm9ybWF0cywgcmVzdHJpY3QgaXQgdG8gcWNvdzIgdG8gYXZvaWQgZXh0cmEg
cnVucw0KPj4+Pj4+Pj4gK2lvdGVzdHMudmVyaWZ5X2ltYWdlX2Zvcm1hdChzdXBwb3J0ZWRfZm10
cz1bJ3Fjb3cyJ10pDQo+Pj4+Pj4+PiArDQo+Pj4+Pj4+PiArc2l6ZSA9IDEwMjQgKiAxMDI0DQo+
Pj4+Pj4+PiArDQo+Pj4+Pj4+PiArIiIiDQo+Pj4+Pj4+PiArT24gYWN0aXZhdGlvbiwgYmFja3Vw
LXRvcCBpcyBnb2luZyB0byB1bnNoYXJlIHdyaXRlIHBlcm1pc3Npb24gb24gaXRzDQo+Pj4+Pj4+
PiArc291cmNlIGNoaWxkLiBJdCB3aWxsIGJlIGltcG9zc2libGUgZm9yIHRoZSBmb2xsb3dpbmcg
Y29uZmlndXJhdGlvbjoNCj4+Pj4+Pj4NCj4+Pj4+Pj4g4oCcVGhlIGZvbGxvd2luZyBjb25maWd1
cmF0aW9uIHdpbGwgYmVjb21lIGltcG9zc2libGXigJ0/DQo+Pj4+Pj4NCj4+Pj4+PiBIbW0sIG5v
LCB0aGUgY29uZmlndXJhdGlvbiBpcyBwb3NzaWJsZS4gQnV0ICJpdCIsIGkuZS4gInVuc2hhcmUg
d3JpdGUgcGVybWlzc2lvbiIsDQo+Pj4+Pj4gaXMgaW1wb3NzaWJsZSB3aXRoIHN1Y2ggY29uZmln
dXJhdGlvbi4uDQo+Pj4+Pg0KPj4+Pj4gQnV0IGJhY2t1cF90b3AgYWx3YXlzIHVuc2hhcmVzIHRo
ZSB3cml0ZSBwZXJtaXNzaW9uIG9uIHRoZSBzb3VyY2UuDQo+Pj4+DQo+Pj4+IFllcywgYW5kIEkg
anVzdCB0cnkgdG8gc2F5LCB0aGF0IHRoaXMgYWN0aW9uIHdpbGwgZmFpbC4gQW5kIHRoZSB0ZXN0
IGNoZWNrcyB0aGF0IGl0DQo+Pj4+IGZhaWxzIChhbmQgaXQgY3Jhc2hlcyB3aXRoIGN1cnJlbnQg
bWFzdGVyIGluc3RlYWQgb2YgZmFpbCkuDQo+Pj4NCj4+PiBPSy4gIFNvIHdoYXQgSSB3YXMgdHJ5
aW5nIHRvIHNheSBpcyB0aGF0IHRoZSBjb21tZW50IGN1cnJlbnRseSBvbmx5DQo+Pj4gc3RhdGVz
IHRoYXQgdGhpcyB3aWxsIGZhaWwuICBJ4oCZZCBwcmVmZXIgaXQgdG8gYWxzbyByZWFzc3VyZSBt
ZSB0aGF0IGl04oCZcw0KPj4+IGNvcnJlY3QgdGhhdCB0aGlzIGZhaWxzIChiZWNhdXNlIGFsbCB3
cml0ZXMgb24gdGhlIGJhY2t1cCBzb3VyY2UgbXVzdCBnbw0KPj4+IHRocm91Z2ggYmFja3VwX3Rv
cCksIGFuZCB0aGF0IHRoaXMgaXMgZXhhY3RseSB3aGF0IHdlIHdhbnQgdG8gdGVzdCBoZXJlLg0K
Pj4+DQo+Pj4gT24gZmlyc3QgcmVhZGluZywgSSB3YXMgd29uZGVyaW5nIHdoeSBleGFjdGx5IHRo
aXMgY29tbWVudCB3b3VsZCB0ZWxsIG1lDQo+Pj4gYWxsIHRoZXNlIHRoaW5ncywgYmVjYXVzZSBJ
IGRpZG7igJl0IGtub3cgd2hhdCB0aGUgdGVzdCB3YW50cyB0byB0ZXN0IGluDQo+Pj4gdGhlIGZp
cnN0IHBsYWNlLg0KPj4+DQo+Pj4gTWF4DQo+Pg0KPj4gSG1tLCBzb21ldGhpbmcgbGlrZToNCj4+
DQo+PiBCYWNrdXAgd2FudHMgdG8gY29weSBhIHBvaW50LWluLXRpbWUgc3RhdGUgb2YgdGhlIHNv
dXJjZSBub2RlLiBTbywgaXQgY2F0Y2hlcyBhbGwgd3JpdGVzDQo+PiB0byB0aGUgc291cmNlIG5v
ZGUgYnkgYXBwZW5kaW5nIGJhY2t1cC10b3AgZmlsdGVyIGFib3ZlIGl0LiBTbyB3ZSBoYW5kbGUg
YWxsIGNoYW5nZXMgd2hpY2gNCj4+IGNvbWVzIGZyb20gc291cmNlIG5vZGUgcGFyZW50cy4gVG8g
cHJldmVudCBhcHBlYXJpbmcgb2YgbmV3IHdyaXRpbmcgcGFyZW50cyBkdXJpbmcgdGhlDQo+PiBw
cm9ncmVzcywgYmFja3VwLXRvcCB1bnNoYXJlcyB3cml0ZSBwZXJtaXNzaW9uIG9uIGl0cyBzb3Vy
Y2UgY2hpbGQuIFRoaXMgaGFzIGFkZGl0aW9uYWwNCj4+IGltcGxpY2F0aW9uOiBhcyB0aGlzICJ1
bnNoYXJpbmciIGlzIHByb3BhZ2F0ZWQgYnkgZGVmYXVsdCBieSBiYWNraW5nL2ZpbGUgY2hpbGRy
ZW4sDQo+PiBiYWNrdXAtdG9wIGNvbmZsaWN0cyB3aXRoIGFueSBzaWRlIHBhcmVudHMgb2Ygc291
cmNlIHN1Yi10cmVlIHdpdGggd3JpdGUgcGVybWlzc2lvbi4NCj4+IEFuZCB0aGlzIGlzIGluIGdv
b2QgcmVsYXRpb24gd2l0aCB0aGUgZ2VuZXJhbCBpZGVhOiB3aXRoIHN1Y2ggcGFyZW50cyB3ZSBj
YW4ndCBndWFyYW50ZWUNCj4+IHBvaW50LWluLXRpbWUgYmFja3VwLg0KPiANCj4gV29ya3MgZm9y
IG1lICh0aGFua3MgOi0pKSwgYnV0IGEgc2hvcnRlciDigJxXaGVuIHBlcmZvcm1pbmcgYSBiYWNr
dXAsIGFsbA0KPiB3cml0ZXMgb24gdGhlIHNvdXJjZSBzdWJ0cmVlIG11c3QgZ28gdGhyb3VnaCB0
aGUgYmFja3VwLXRvcCBmaWx0ZXIgc28gaXQNCj4gY2FuIGNvcHkgYWxsIGRhdGEgdG8gdGhlIHRh
cmdldCBiZWZvcmUgaXQgaXMgY2hhbmdlZC4gIFRoZXJlZm9yZSwNCj4gYmFja3VwLXRvcCBjYW5u
b3QgYWxsb3cgb3RoZXIgbm9kZXMgdG8gY2hhbmdlIGRhdGEgb24gaXRzIHNvdXJjZSBjaGlsZC7i
gJ0NCj4gd291bGQgd29yayBmb3IgbWUganVzdCBhcyB3ZWxsLg0KDQpIbW0sIEkgZG9uJ3QgbGlr
ZSB0aGlzICJUaGVyZWZvcmUiLiBGb3IgbWUgdGhlIGxhc3Qgc3RhdGVtZW50DQoiY2Fubm90IGFs
bG93IiBkb2Vzbid0IGxvb2tzIGxpa2UgYSBjb25zZXF1ZW5jZSBvZiB0aGUgZmlyc3QNCiJhbGwg
d3JpdGVzIG11c3QgZ28gdGhyb3VnaCIsIGl0IG1vcmUgbGlrZSByZXBocmFzaW5nIChzdGlsbA0K
bm90IGNvbXBsZXRlbHkgZXF1YWwpLi4uIFNvLCBJJ2xsIGtlZXAgbXkgd29yZGluZykNCg0KPiAN
Cj4+IFNvLCB0cnlpbmcgdG8gYmFja3VwIHRoZSBjb25maWd1cmF0aW9uIHdpdGggd3JpdGluZyBz
aWRlIHBhcmVudHMgb2YNCj4+IHNvdXJjZSBzdWItdHJlZSBub2RlcyBzaG91bGQgZmFpbC4gTGV0
J3MgdGVzdCBpdC4NCj4gTWF4DQo+IA0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXIN
Cg==

