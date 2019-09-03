Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C52AC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 17:01:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38200217D7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 17:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ZbG0ytvd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38200217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5CBd-0002Kv-PD
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 13:01:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41484)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1i5Bmv-0004vM-Cu
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:36:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1i5Bmu-0000vA-7H
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:36:13 -0400
Received: from mail-eopbgr10116.outbound.protection.outlook.com
 ([40.107.1.116]:17408 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1i5Bmq-0000sJ-Be; Tue, 03 Sep 2019 12:36:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CHEMa7zwOW/sHGDqG3yZ/uYWQC1GaTeGXDEcaP+MU+nLBl1/V2QrepYaCYKvuesFHVcFJ8E0qjR517oQ+xZ63RhDPtwjR3bCv5PEnh5lbgkkDePaHnWLw7In5KnuLNI8La/ZvXdhpSZZXEXJUBO5rMUyvwP9VeN9EVoDn+n8u/MuwCeGtjGDXnlxf35frsjiE4sqkl037NotobbxED4xeoqXizjnVkFwE9W+9Io8epzb8QmagxJrm01T2XTgzxyyBDqoINJ3hac3O7F0C2L4DXXa6TAohQydJ3WnhhB5uCT6N1xOv7FEXCbEsViqOka11uVNyufyvMXO1nk9Z4r/iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9AgpmsQZoluUHNTnP3qVb/O+Hdaf9lOpp196wyWWLKw=;
 b=hyzVhBZN3VNXBnO36SA+m7uTmSSbyUxnMnBi86qqDuvGSfckshmmmnOucYBGh/YhU5OWhZYVbiJN0GMg/B0NRzotI1aVmvlIAImcEin3gR3lAd4CVGZGeDF3N8Bil59nnqP2pXzTsyJ5IIU6iSV6uJJX70j0cHPmONZzmUBjKM/RlVzKrnYtvh5LseRpdN7khvZ4zmA4EkYxpHF02Eswcb8uSnyC6lwLGr0hZx3flgdBcrHOSwSu+zN6bBiS/7IG4mDDeokGo4vyzLhnv3WsrAn3y8OWH0eU8Js4GTYK1b0XkJaZwJDWhMc5hTsGqFUvXbekDAqwZV6mpMcO/Z/0ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9AgpmsQZoluUHNTnP3qVb/O+Hdaf9lOpp196wyWWLKw=;
 b=ZbG0ytvdOLdD17s4Zhx3VfwWq5+owVxpvB/zPrzctzXTxJIM+3ch3g5fk7/diuQ8JZ6iRpDg0N2TqflFAI38/YUDQ4opXS9cnnEkaFuvZMr8bexPFayY2i6hyVWOnSCkbWXsHAq5PrJRqHJqFIjo44iSLiuTuOscZCjifGVW/F0=
Received: from AM0PR08MB3027.eurprd08.prod.outlook.com (52.134.95.154) by
 AM0PR08MB3316.eurprd08.prod.outlook.com (52.134.94.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.20; Tue, 3 Sep 2019 16:36:06 +0000
Received: from AM0PR08MB3027.eurprd08.prod.outlook.com
 ([fe80::19a3:6903:45eb:bf51]) by AM0PR08MB3027.eurprd08.prod.outlook.com
 ([fe80::19a3:6903:45eb:bf51%6]) with mapi id 15.20.2220.022; Tue, 3 Sep 2019
 16:36:06 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>
Thread-Topic: [PATCH v7 0/6] Allow Valgrind checking all QEMU processes
Thread-Index: AQHVYLvcme1P621GcUCyi7aLGgh+kacZu+yAgAB7B4D//89ngIAAI4iA
Date: Tue, 3 Sep 2019 16:36:05 +0000
Message-ID: <13e0b8f3-e825-8233-7a5f-e97b5e4ab0ee@virtuozzo.com>
References: <1567338786-586124-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <20190903100229.GD4582@localhost.localdomain>
 <0d46c5d2-8dac-c2fe-941e-4cd993a96d88@virtuozzo.com>
 <20190903142853.GN4582@localhost.localdomain>
In-Reply-To: <20190903142853.GN4582@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR09CA0066.eurprd09.prod.outlook.com
 (2603:10a6:7:3c::34) To AM0PR08MB3027.eurprd08.prod.outlook.com
 (2603:10a6:208:61::26)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 79e424d6-9097-4e4e-964b-08d7308cd121
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:AM0PR08MB3316; 
x-ms-traffictypediagnostic: AM0PR08MB3316:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR08MB3316B0BC12B13BCF90141C25F4B90@AM0PR08MB3316.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01494FA7F7
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(346002)(136003)(376002)(39840400004)(366004)(189003)(199004)(25786009)(6916009)(99286004)(6436002)(53936002)(107886003)(6512007)(6116002)(3846002)(316002)(229853002)(52116002)(54906003)(6486002)(6246003)(2906002)(4326008)(14454004)(186003)(102836004)(5660300002)(44832011)(31696002)(476003)(305945005)(2616005)(76176011)(6506007)(53546011)(26005)(386003)(14444005)(446003)(256004)(36756003)(478600001)(31686004)(11346002)(66476007)(66946007)(66066001)(7736002)(66446008)(8936002)(81156014)(81166006)(86362001)(66556008)(64756008)(71190400001)(71200400001)(486006)(8676002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3316;
 H:AM0PR08MB3027.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XXHY5+FnK453YVG1HokMNRNUUTABjcD2wMcvnJ2onWTWCqmHZUfbPIjY1GEoL+H47BQ2PUjyPqPqLqph6LQSt/WeiJz03+cHTd26v+n7X8oPBlxf8IyjXmcW4sBzAjM9ZQ71q44PjMUdAXsH86nDywapORL4qO7cd8mbOCb0Abdcu8dCtEeW8gi1DTCu2ndMQCkEGiqd9toEOgPURRAmQ5ryn40qwRaPAAiznS0YAycYVXB/B5dtiDfcUlom0R4VU/JJndXBYRzeQDvujyff6ykYsQSJmv0CnBsjGcUQRNVETBjohCJ0kdZYM0/O4fyVjxNPC+FmjDCzAWZiVzCmK44gfnP0dZWALKB5aiwbhxBCRixY3tbHeDtHMj9WnvWjuN2SjtM9yr68ikclgYiMC6rJI7JapYuT+0m1sd2fpKs=
Content-Type: text/plain; charset="utf-8"
Content-ID: <000BE18963FF7B49A5DE7C3EE96AB756@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79e424d6-9097-4e4e-964b-08d7308cd121
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2019 16:36:05.9807 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U+7m6w5zR9H1e8kV5xZGviskBrhirWV8flX9NohemVikMWd0Oi6d3l/zY3GLob8IsoohagVHqeY+C4qrVZU3V1yLzeHepON0mGQ7QtBUS50=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3316
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.116
Subject: Re: [Qemu-devel] [PATCH v7 0/6] Allow Valgrind checking all QEMU
 processes
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDAzLzA5LzIwMTkgMTc6MjgsIEtldmluIFdvbGYgd3JvdGU6DQo+IEFtIDAzLjA5LjIw
MTkgdW0gMTY6MjIgaGF0IEFuZHJleSBTaGlua2V2aWNoIGdlc2NocmllYmVuOg0KPj4NCj4+DQo+
PiBPbiAwMy8wOS8yMDE5IDEzOjAyLCBLZXZpbiBXb2xmIHdyb3RlOg0KPj4+IEFtIDAxLjA5LjIw
MTkgdW0gMTM6NTMgaGF0IEFuZHJleSBTaGlua2V2aWNoIGdlc2NocmllYmVuOg0KPj4+PiBJbiB0
aGUgY3VycmVudCBpbXBsZW1lbnRhdGlvbiBvZiB0aGUgUUVNVSBiYXNoIGlvdGVzdHMsIG9ubHkg
cWVtdS1pbw0KPj4+PiBwcm9jZXNzZXMgbWF5IGJlIHJ1biB1bmRlciB0aGUgVmFsZ3JpbmQgd2l0
aCB0aGUgc3dpdGNoICctdmFsZ3JpbmQnLg0KPj4+PiBMZXQncyBhbGxvdyB0aGUgY29tbW9uLnJj
IGJhc2ggc2NyaXB0IHJ1bm5pbmcgYWxsIG90aGVyIFFFTVUgcHJvY2Vzc2VzLA0KPj4+PiBzdWNo
IGFzIHFlbXUta3ZtLCBxZW11LWltZywgcWVtdS1uZGIgYW5kIHFlbXUtdnhocywgdW5kZXIgdGhl
IFZhbGdyaW5kLg0KPj4+DQo+Pj4gVGhhbmtzLCBhcHBsaWVkIHRvIHRoZSBibG9jayBicmFuY2gu
DQo+Pj4NCj4+PiBLZXZpbg0KPj4+DQo+Pg0KPj4gS2V2aW4hDQo+PiBQbGVhc2UgcG9zdHBvbmUg
dGhlIHB1bGwgcmVxdWVzdCENCj4+IFRoZSBsYXN0IG9wdGltaXphdGlvbiBpbiB0aGUgcGF0Y2gg
MS82IGJyb2tlIHRoZSBsb2dpYyBpbiB0aGUgcGF0Y2ggMi8zLg0KPj4gU28sIHRoZSB0ZXN0IDAz
OSBoYW5ncyB1bmRlciB0aGUgVmFsZ3JpbmQsIGFzIGl0IHdhcy4NCj4+IFRoZSBwYXRjaCAyLzYg
bXVzdCBiZSBvcHRpbWl6ZWQgdG9vLg0KPj4gSSBhbSBhYm91dCB0byBtYWtlIGEgbGl0dGxlIGNo
YW5nZSBpbiB0aGUgcGF0Y2ggMi82IGFuZCB3aWxsIHNlbmQgdjgNCj4+IHRvZGF5Li4uDQo+IA0K
PiBPaywgSSdsbCB1bnN0YWdlIHY3Lg0KPiANCj4gS2V2aW4NCj4gDQoNClRoZSB2OCBpcyByZWFk
eSB0byBiZSBzZW50LiBUaGUgdGVzdCAwMzkgcGFzc2VzIG5vdyBiZWluZyBydW4gdW5kZXIgdGhl
IA0KVmFsZ3JpbmQuIFRoZSBpb3Rlc3RzIHBhc3Mgd2l0aCB0aGUgdjggc2VyaWVzIGFwcGxpZWQg
YmVpbmcgcnVuIHdpdGhvdXQgDQp0aGUgVmFsZ3JpbmQ6DQouL2NoZWNrIC1xY293Mg0KYW5kDQou
L2NoZWNrIC1uYmQNCk5vdywgSSBhbSB3YWl0aW5nIGZvciBhbGwgdGhlIGlvdGVzdHMgdG8gcGFz
cyB3aXRoIHRoZSBzd2l0Y2ggDQonLXZhbGdyaW5kJy4gSXQgdGFrZXMgbXVjaCBtb3JlIHRpbWUg
YWN0dWFsbHkuDQpGZXcgbW9yZSBob3VycyBhcmUgbmVlZGVkIHRvIGNvbXBsZXRlIHJ1bm5pbmcg
dGhlIGlvdGVzdHMgdW5kZXIgdGhlIA0KVmFsZ3JpbmQuIEkgY291bGQgc2VuZCB0aGUgdjggbm93
IG9yIGJldHRlciB3YWl0IHVudGlsIHRvbW9ycm93IGZvciANCmFzc3VyYW5jZS4NCg0KQW5kcmV5
DQotLSANCldpdGggdGhlIGJlc3QgcmVnYXJkcywNCkFuZHJleSBTaGlua2V2aWNoDQo=

