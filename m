Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 562B8C35280
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 15:08:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21D292133F
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 15:08:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="UXjIMT66"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21D292133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFgEh-00013D-T5
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 11:08:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45904)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iFgDG-00081V-Se
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 11:06:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iFgDF-0002Me-IK
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 11:06:46 -0400
Received: from mail-eopbgr50130.outbound.protection.outlook.com
 ([40.107.5.130]:14926 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iFgDE-0002JT-HT; Wed, 02 Oct 2019 11:06:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ftBSjeVk3wrdbAvE3+6RQMobb7m3X8KgEKjKU/7yyeEWMW7kS6wf3mmAQMLLVb0bRNhgw8gul7OyV5fMHS6S4odZBEwhxgkqkg0ZeKr0MS1i0yooErw/ewDhNk6hEmajVpwgRNE2DsKmqRSB9se+HWH9ObV+or46ysZBYpoaYUz/DMPDg0h5eAoFbQQgP3tq6iXrXwuml4X6fWtgrEiRBljAUssFIyninAt2ALAVlQmkZYsm8fx1wxY0X/Fq5dEzcdbI+i3vQgBKfQV5guSmjo8FS9GwrKEvcKvHTtfdCVjoPTHMOlgiaoJU0GIugjB2tYFxdUChdjZkJXITdRVsNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GSllBUrrpcNZQOE3SWC7f7O7ScI3m60+NfNnM9sj/44=;
 b=RGKkVPHb/Tyft5R1oM1OmMTqI4QOD1GdNnkHAqM1EfyaBpRmQJc6+ahJfmwk6ziDBMXVFQcnd4jc7E+NwqDh1qbpGPbR9v6Cagc9e3eXGV/1ul9Vv4a2xAToxGKnpQ4wrcoHZnmYsMltO30t9PdHhS+pKtglS33aZyaS4OoNTVJiDzwF5H7rTxKVXzFn1tS5joLudsOby6GY+NgE5FgSlfbqblTdVzYb184mu9tRNR6gVtBY+31owpYbOXccBJIWXPfTbwGSNtJay8azmOCNzjaaIlUbRhSJk3wtG/uRff/7X4ca9WNa0nmVakx0YIj3t/PnqfIZaqeozbzyqmZmhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GSllBUrrpcNZQOE3SWC7f7O7ScI3m60+NfNnM9sj/44=;
 b=UXjIMT669hRiNopdIHiTd3F1NmnKbfm0IAmBEwAAovt6YhaWW2xJMYK9iHoBo28gKDq8uPovHoBq+zeg3d2np5sedb81D6Y1o6+y4+oW9Gj1cYyTBae5ekM1VBZrKzbbzo4xMxm2FoJAfOg3tzeJEKbCk4ZQ8DG0Uy8uWqfThtA=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB3977.eurprd08.prod.outlook.com (20.179.11.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.17; Wed, 2 Oct 2019 15:06:42 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f%2]) with mapi id 15.20.2305.023; Wed, 2 Oct 2019
 15:06:42 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH 3/4] block/mirror: support unaligned write in active mirror
Thread-Topic: [PATCH 3/4] block/mirror: support unaligned write in active
 mirror
Thread-Index: AQHVaXyqGWMlukZLJkOXoRVirVbRLqdHkGAAgAA0KAD//857AA==
Date: Wed, 2 Oct 2019 15:06:42 +0000
Message-ID: <62e03b60-b9cb-9e59-f876-df40bba96ca0@virtuozzo.com>
References: <20190912151338.21225-1-vsementsov@virtuozzo.com>
 <20190912151338.21225-4-vsementsov@virtuozzo.com>
 <7dec596f-0175-951e-ba3f-2eb8b2a3d8ed@redhat.com>
 <9a857f23-73b0-44c1-dde2-ac68d45dcf93@virtuozzo.com>
In-Reply-To: <9a857f23-73b0-44c1-dde2-ac68d45dcf93@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0280.eurprd05.prod.outlook.com
 (2603:10a6:3:fc::32) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191002180640162
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 20a94065-4ca7-46b3-3840-08d7474a222d
x-ms-traffictypediagnostic: DB8PR08MB3977:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB3977D2E21E0E03347AC9F611C19C0@DB8PR08MB3977.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:962;
x-forefront-prvs: 0178184651
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(376002)(366004)(39850400004)(396003)(136003)(189003)(199004)(186003)(31696002)(64756008)(66556008)(8936002)(256004)(8676002)(86362001)(5660300002)(11346002)(476003)(81166006)(66446008)(31686004)(66476007)(99286004)(386003)(76176011)(102836004)(6506007)(53546011)(26005)(2501003)(52116002)(2616005)(66946007)(14444005)(2906002)(446003)(110136005)(6436002)(54906003)(71190400001)(36756003)(6512007)(478600001)(25786009)(316002)(6486002)(81156014)(229853002)(6116002)(3846002)(14454004)(7736002)(66066001)(107886003)(4326008)(305945005)(71200400001)(486006)(6246003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB3977;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zkwvAQlZIxuMpK1jt9cNV41P3Gr3BZx03EocLEfLzFPLamY3lls7wW7ttSen7UVLnfW/0tDKAG3KsieFLMibAqkCDKcLvSk47a+ArNknhBvDreBAmjtUD8Zw+29b21Mby/nXYHGawD31HssmSthLBZL3fNAMJN6UlaCmoeNoBMNTB3nn6bvFpT4zOUNsnflX/k+V1pRNeYsL4yVVRMx0LiG9r8/+0+yF0DoxLZ2UC3VTsp8YPQTt7mlOd0j5/o2p3tV4NsQBm4RQGM0IcrKu3OVugErOnARRCuHOI363IHDXWMYnwskgbKMxyyo4FO+V6tuJ3cVuHJg0PE8CrDA7zU22bivlzbz7l3vbX0qvl288iywK6DWazAI3RbUpQnXSmw3kZSxmN3wYkSB/rf5Vl+mU2Xjo9mI4ALjfhcPcDMY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EF208AEF58E77745B79CE7DA7DE8B259@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20a94065-4ca7-46b3-3840-08d7474a222d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2019 15:06:42.3986 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aRDfUn3y3GHPJMZIihHOYAcoKMPwIJIHCdFuU9wwDHPiLPH3Ewx4EYQN3rSFe7oPGOF0XDZJSBKM+Za5sIq/gamHEbDk1/wxFz/wRfGj4hY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB3977
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.5.130
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

MDIuMTAuMjAxOSAxODowMywgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4g
MDIuMTAuMjAxOSAxNzo1NywgTWF4IFJlaXR6IHdyb3RlOg0KPj4gT24gMTIuMDkuMTkgMTc6MTMs
IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgd3JvdGU6DQo+Pj4gUHJpb3IgOWFkYzFjYjQ5
YWY4ZCBkb19zeW5jX3RhcmdldF93cml0ZSBoYWQgYSBidWc6IGl0IHJlc2V0IGFsaWduZWQtdXAN
Cj4+PiByZWdpb24gaW4gdGhlIGRpcnR5IGJpdG1hcCwgd2hpY2ggbWVhbnMgdGhhdCB3ZSBtYXkg
bm90IGNvcHkgc29tZSBieXRlcw0KPj4+IGFuZCBhc3N1bWUgdGhlbSBjb3BpZWQsIHdoaWNoIGFj
dHVhbGx5IGxlYWRzIHRvIHByb2R1Y2luZyBjb3JydXB0ZWQNCj4+PiB0YXJnZXQuDQo+Pj4NCj4+
PiBTbyA5YWRjMWNiNDlhZjhkIGZvcmNlZCBkaXJ0eSBiaXRtYXAgZ3JhbnVsYXJpdHkgdG8gYmUN
Cj4+PiByZXF1ZXN0X2FsaWdubWVudCBmb3IgbWlycm9yLXRvcCBmaWx0ZXIsIHNvIHdlIGFyZSBu
b3Qgd29ya2luZyB3aXRoDQo+Pj4gdW5hbGlnbmVkIHJlcXVlc3RzLiBIb3dldmVyIGZvcmNpbmcg
bGFyZ2UgYWxpZ25tZW50IG9idmlvdXNseSBkZWNyZWFzZXMNCj4+PiBwZXJmb3JtYW5jZSBvZiB1
bmFsaWduZWQgcmVxdWVzdHMuDQo+Pj4NCj4+PiBUaGlzIGNvbW1pdCBwcm92aWRlcyBhbm90aGVy
IHNvbHV0aW9uIGZvciB0aGUgcHJvYmxlbTogaWYgdW5hbGlnbmVkDQo+Pj4gcGFkZGluZyBpcyBh
bHJlYWR5IGRpcnR5LCB3ZSBjYW4gc2FmZWx5IGlnbm9yZSBpdCwgYXMNCj4+PiAxLiBJdCdzIGRp
cnR5LCBpdCB3aWxsIGJlIGNvcGllZCBieSBtaXJyb3JfaXRlcmF0aW9uIGFueXdheQ0KPj4+IDIu
IEl0J3MgZGlydHksIHNvIHNraXBwaW5nIGl0IG5vdyB3ZSBkb24ndCBpbmNyZWFzZSBkaXJ0aW5l
c3Mgb2YgdGhlDQo+Pj4gwqDCoMKgIGJpdG1hcCBhbmQgdGhlcmVmb3JlIGRvbid0IGRhbWFnZSAi
c3luY2hyb25pY2l0eSIgb2YgdGhlDQo+Pj4gwqDCoMKgIHdyaXRlLWJsb2NraW5nIG1pcnJvci4N
Cj4+DQo+PiBCdXQgdGhhdOKAmXMgbm90IHdoYXQgYWN0aXZlIG1pcnJvciBpcyBmb3IuwqAgVGhl
IHBvaW50IG9mIGFjdGl2ZSBtaXJyb3IgaXMNCj4+IHRoYXQgaXQgbXVzdCBjb252ZXJnZSBiZWNh
dXNlIGV2ZXJ5IGd1ZXN0IHdyaXRlIHdpbGwgY29udHJpYnV0ZSB0b3dhcmRzDQo+PiB0aGF0IGdv
YWwuDQo+Pg0KPj4gSWYgeW91IHNraXAgYWN0aXZlIG1pcnJvcmluZyBmb3IgdW5hbGlnbmVkIGd1
ZXN0IHdyaXRlcywgdGhleSB3aWxsIG5vdA0KPj4gY29udHJpYnV0ZSB0b3dhcmRzIGNvbnZlcmdp
bmcsIGJ1dCBpbiBmYWN0IGxlYWQgdG8gdGhlIG9wcG9zaXRlLg0KPj4NCj4gDQo+IFRoZSB3aWxs
IG5vdCBjb250cmlidXRlIG9ubHkgaWYgcmVnaW9uIGlzIGFscmVhZHkgZGlydHkuIEFjdHVhbGx5
LCBhZnRlcg0KPiBmaXJzdCBpdGVyYXRpb24gb2YgbWlycm9yaW5nIChjb3B5aW5nIHRoZSB3aG9s
ZSBkaXNrKSwgYWxsIGZvbGxvd2luZyB3cml0ZXMNCj4gd2lsbCBjb250cmlidXRlLCBzbyB0aGUg
d2hvbGUgcHJvY2VzcyBtdXN0IGNvbnZlcmdlLiBJdCBpcyBhIGJpdCBzaW1pbGFyIHdpdGgNCj4g
cnVubmluZyBvbmUgbWlycm9yIGxvb3AgaW4gbm9ybWFsIG1vZGUsIGFuZCB0aGVuIGVuYWJsZSB3
cml0ZS1ibG9ja2luZy4NCj4gDQoNCg0KSW4gb3RoZXIgd29yZHMsIHdlIGRvbid0IG5lZWQgImFs
bCBndWVzdCB3cml0ZXMgY29udHJpYnV0ZSIgdG8gY29udmVyZ2UsDQoiYWxsIGd1ZXN0IHdyaXRl
cyBkb24ndCBjcmVhdGUgbmV3IGRpcnR5IGJpdHMiIGlzIGVub3VnaCwgYXMgd2UgaGF2ZSBwYXJh
bGxlbA0KbWlycm9yIGl0ZXJhdGlvbiB3aGljaCBjb250aWd1b3VzbHkgaGFuZGxlcyBkaXJ0eSBi
aXRzLg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

