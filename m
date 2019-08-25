Return-Path: <SRS0=aJdJ=WV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7813AC3A5A1
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 10:31:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4181D20870
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 10:31:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="QN9g2ZWf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4181D20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1pny-0001nI-7k
	for qemu-devel@archiver.kernel.org; Sun, 25 Aug 2019 06:31:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50812)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1i1pmt-0001ES-IV
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 06:30:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1i1pmr-0007Gv-VQ
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 06:30:19 -0400
Received: from mail-eopbgr80102.outbound.protection.outlook.com
 ([40.107.8.102]:51438 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1i1pmi-000743-Lx; Sun, 25 Aug 2019 06:30:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UdJM/XZNMin7/wm40riMhHCbjzoo7XrkD3g/FozyYdM6brhTiVZzE0Onw5Sp7VHGr2uZ4QgDG6ItXWcr2t4V6OjQ4VcL9L5xu8bmSd4B+K+vkxAxqWKBDSPHL2d58UjriF0AOa359KJWlQXSxiyun1iLx9m6gnCkN+7qO4ks/P5a5/kAPBlBQm+RjsXBogCIU+rGJeLihwmCQ8+xqMa0BhidrcT8KZ4tcmP6WGBWAjm9jvR4+zFopUeypyp2FbxQaLj4Idpj8qby0zuFqdnxiAJhrTqHoA8rCrGrqYTeO5dfVoKQK/x4ZQTi8U1FRQC8nwH8Qlh6XBZmLr0wh4nRrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=417WOwzXG0e3owuqpt11EIs7X96l//oRZbsH3eYAZto=;
 b=ad66Yxvn1zbcdrjzQDzC9SiB3uVbFfijxxDW+rvcr++nT5lgCWFfo+loLNlKs+vChqiWnUNuQtgyWdRQ/mctPCAPWE1OdLgz7DimMjTJ6vljhTG1USCEM+CJBk2RR4TwwRb+IuqBsyjWH3v+Nys9+I6Pp5DeZai2Z+dwlq1v2WVfHwILZK5pnAnWIBKyCYZRDGbH9650Gl3TSQIiafgouv3qu8Iv0VLFHyGIoEy4i5FTg39WOuVlI/GtD+WhRAiVVSUKdmxmuisAkP6rpah/n0JTiKtYrrHpvrYeKACLhoDnaczVyKrBDUEXWLtnX7Uo117ZEFsskhvtnIhPsw0Hrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=417WOwzXG0e3owuqpt11EIs7X96l//oRZbsH3eYAZto=;
 b=QN9g2ZWfGpOhwdc9/4KECyxPZNzzIWKbKkTZRmGOWdEFdK7VUUY8suLX4oIxBHKopv61n720RHE3R8QwvDN22l+xm6WynCaFkPsCI+hYzIaQTSYHH5l98XNYhQ7aevm8xL0098tSjg4UekSASrKNEDfuV+CGWxwFTi3J4eq5Huw=
Received: from VI1PR08MB4399.eurprd08.prod.outlook.com (20.179.28.141) by
 VI1PR08MB3760.eurprd08.prod.outlook.com (20.178.14.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.19; Sun, 25 Aug 2019 10:30:05 +0000
Received: from VI1PR08MB4399.eurprd08.prod.outlook.com
 ([fe80::5542:8398:f1bd:f8c7]) by VI1PR08MB4399.eurprd08.prod.outlook.com
 ([fe80::5542:8398:f1bd:f8c7%6]) with mapi id 15.20.2199.021; Sun, 25 Aug 2019
 10:30:05 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Cleber Rosa <crosa@redhat.com>
Thread-Topic: [Qemu-devel] [PATCH v5 0/6] Allow Valgrind checking all QEMU
 processes
Thread-Index: AQHVPk9Lhke4f+HMAkaliwaZTYueBKb+X0WAgA2ENwA=
Date: Sun, 25 Aug 2019 10:30:05 +0000
Message-ID: <0b3f1002-d3c5-a45d-3a91-fbe2acb59db0@virtuozzo.com>
References: <1563553816-148827-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <20190816200527.GA20950@localhost.localdomain>
In-Reply-To: <20190816200527.GA20950@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0701CA0045.eurprd07.prod.outlook.com
 (2603:10a6:3:9e::13) To VI1PR08MB4399.eurprd08.prod.outlook.com
 (2603:10a6:803:102::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a0a68e16-b38a-4e44-3d47-08d729473192
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:VI1PR08MB3760; 
x-ms-traffictypediagnostic: VI1PR08MB3760:
x-ms-exchange-purlcount: 2
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR08MB376060FB64F52C9E2583C8AFF4A60@VI1PR08MB3760.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 01401330D1
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(39840400004)(366004)(376002)(346002)(396003)(189003)(199004)(6486002)(6246003)(107886003)(31696002)(81156014)(4326008)(8676002)(6436002)(14454004)(478600001)(6306002)(6512007)(66446008)(64756008)(966005)(66556008)(66476007)(66946007)(53936002)(71190400001)(71200400001)(66066001)(8936002)(229853002)(31686004)(2906002)(99286004)(486006)(14444005)(6916009)(256004)(44832011)(7736002)(476003)(2616005)(11346002)(54906003)(86362001)(76176011)(316002)(6506007)(386003)(5660300002)(102836004)(53546011)(52116002)(26005)(81166006)(36756003)(25786009)(305945005)(446003)(186003)(6116002)(3846002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB3760;
 H:VI1PR08MB4399.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5wza/tqhRdfWNW8lmrsz21WgSbSeT6Nor9UswMC93l11C93v4dZ/0uGCY5l8wV82uSdpwEeBoAES4R+lJHRdfcSe7mCrw1/kAgSMoXXMAN57RrPdWBn80BnGe1dwAoh35fiND0GstqFmcOnSkdqjo7pH71E50XSiqiHr/VDWkRObKPAVh8UernbAEqozNRSssX80By2NHGfDzJkccaidjsfKXDhqXF6AKwWZGTlJwGH1ijUOGewpwrF/1tAgmOSGJoPaQtKCVrM62hVhOjpBgDiRvIOFfykcnoT78Hc3VpfeF81/IJq9NEhi5kuZ623WmcERqjyd1P/JinHE9HRqtlezaLUI83o/rWCKM64GaAYK2YjWyWR+YE4Z7sKv5aFUJee+nLX7C/iRV7FLufspbmbrEbWBgBlu+1U6Wl2T26c=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7D54505A198AE944BF8C45C52D28FF04@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0a68e16-b38a-4e44-3d47-08d729473192
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2019 10:30:05.0716 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s7e9gz6UwZhk5bL4t+ivtR6HkBw1O51p6zCnGNE+5qR5nufwVkTV6i3zbLCbHe6D2N+XU0PaoAQPjAEZTC9tjwZ3gKAiafGsSWdRxMg5x2E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3760
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.8.102
Subject: Re: [Qemu-devel] [PATCH v5 0/6] Allow Valgrind checking all QEMU
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDE2LzA4LzIwMTkgMjM6MDUsIENsZWJlciBSb3NhIHdyb3RlOg0KPiBPbiBGcmksIEp1
bCAxOSwgMjAxOSBhdCAwNzozMDoxMFBNICswMzAwLCBBbmRyZXkgU2hpbmtldmljaCB3cm90ZToN
Cj4+IEluIHRoZSBjdXJyZW50IGltcGxlbWVudGF0aW9uIG9mIHRoZSBRRU1VIGJhc2ggaW90ZXN0
cywgb25seSBxZW11LWlvDQo+PiBwcm9jZXNzZXMgbWF5IGJlIHJ1biB1bmRlciB0aGUgVmFsZ3Jp
bmQsIHdoaWNoIGlzIGEgdXNlZnVsIHRvb2wgZm9yDQo+PiBmaW5kaW5nIG1lbW9yeSB1c2FnZSBp
c3N1ZXMuIExldCdzIGFsbG93IHRoZSBjb21tb24ucmMgYmFzaCBzY3JpcHQNCj4+IHJ1bmluZyBh
bGwgdGhlIFFFTVUgcHJvY2Vzc2VzLCBzdWNoIGFzIHFlbXUta3ZtLCBxZW11LWltZywgcWVtdS1u
ZGINCj4+IGFuZCBxZW11LXZ4aHMsIHVuZGVyIHRoZSBWYWxncmluZCB0b29sLg0KPj4NCj4gDQo+
IEZJWSwgdGhpcyBsb29rcyB2ZXJ5IHNpbWlsYXIgKGluIHB1cnBvc2UpIHRvOg0KPiANCj4gICAg
IGh0dHBzOi8vYXZvY2Fkby1mcmFtZXdvcmsucmVhZHRoZWRvY3MuaW8vZW4vNzEuMC9XcmFwUHJv
Y2Vzcy5odG1sDQo+IA0KPiBBbmQgaW4gZmFjdCBWYWxncmluZCB3YXMgb25lIG9mIHRoZSBvcmln
aW5hbCBtb3RpdmF0aW9uczoNCj4gDQo+ICAgICBodHRwczovL2dpdGh1Yi5jb20vYXZvY2Fkby1m
cmFtZXdvcmsvYXZvY2Fkby9ibG9iL21hc3Rlci9leGFtcGxlcy93cmFwcGVycy92YWxncmluZC5z
aA0KPiANCj4gTWF5YmUgdGhpcyBjYW4gYmUgaGVscGZ1bCBmb3IgdGhlIFB5dGhvbiBiYXNlZCBp
b3Rlc3RzLg0KPiANCj4gLSBDbGViZXIuDQo+IA0KDQpUaGFuayB5b3UgQ2xlYmVyIGZvciB0aGUg
YWR2aWNlLiBUaGF0IGlzIHRoZSB3YXkgSSBhY3R1YWxseSByYW4gUHl0aG9uIA0KaW90ZXN0cyB1
bmRlciBWYWxncmluZCBvbiBteSBob3N0IGFuZCBkaXNjb3ZlcmVkIHNvbWUgaXNzdWVzIHdpdGgg
dGhlbSANCmFscmVhZHkuDQoNCkFuZHJleQ0KDQo+PiB2NToNCj4+ICAgIDAxOiBUaGUgcGF0Y2gg
ImJsb2NrL25iZDogTkJEUmVwbHkgaXMgdXNlZCBiZWluZyB1bmluaXRpYWxpemVkIiB3YXMgZGV0
YWNoZWQNCj4+ICAgICAgICBhbmQgdGFrZW4gaW50byBhY2NvdW50IGluIHRoZSBwYXRjaCAibmJk
OiBJbml0aWFsaXplIHJlcGx5IG9uIGZhaWx1cmUiDQo+PiAgICAgICAgYnkgRXJpYyBCbGFrZS4N
Cj4+DQo+PiB2NDoNCj4+ICAgIDAxOiBUaGUgcGF0Y2ggImlvdGVzdHM6IFNldCByZWFkLXplcm9l
cyBvbiBpbiBudWxsIGJsb2NrIGRyaXZlciBmb3IgVmFsZ3JpbmQiDQo+PiAgICAgICAgd2FzIGV4
dGVuZGVkIHdpdGggbmV3IGNhc2VzIGFuZCBpc3N1ZWQgYXMgYSBzZXBhcmF0ZSBzZXJpZXMuDQo+
PiAgICAwMjogVGhlIG5ldyBwYXRjaCAiYmxvY2svbmJkOiBOQkRSZXBseSBpcyB1c2VkIGJlaW5n
IHVuaW5pdGlhbGl6ZWQiIHdhcw0KPj4gICAgICAgIGFkZGVkIHRvIHJlc29sdmUgdGhlIGZhaWx1
cmUgb2YgdGhlIGlvdGVzdCAwODMgcnVuIHVuZGVyIFZhbGdyaW5kLg0KPj4NCj4+IHYzOg0KPj4g
ICAgMDE6IFRoZSBuZXcgZnVuY3Rpb24gX2Nhc2Vub3RydW4oKSB3YXMgYWRkZWQgdG8gdGhlIGNv
bW1vbi5yYyBiYXNoDQo+PiAgICAgICAgc2NyaXB0IHRvIG5vdGlmeSB0aGUgdXNlciBvZiB0ZXN0
IGNhc2VzIGRyb3BwZWQgZm9yIHNvbWUgcmVhc29uLg0KPj4gICAgICAgIFN1Z2dlc3RlZCBieSBL
ZXZpbi4NCj4+ICAgICAgICBQYXJ0aWN1bGFybHksIHRoZSBub3RpZmljYXRpb24gYWJvdXQgdGhl
IG5vbmV4aXN0ZW50IFRNUERJUiBpbg0KPj4gICAgICAgIHRoZSB0ZXN0IDA1MSB3YXMgYWRkZWQg
KG5vdGljZWQgYnkgVmxhZGltaXIpLg0KPj4gICAgMDI6IFRoZSB0aW1lb3V0IGluIHNvbWUgdGVz
dCBjYXNlcyB3YXMgZXh0ZW5kZWQgZm9yIFZhbGdyaW5kIGJlY2F1c2UNCj4+ICAgICAgICBpdCBk
aWZmZXJzIHdoZW4gcnVubmluZyBvbiB0aGUgcmFtZGlzay4NCj4+ICAgIDAzOiBEdWUgdG8gdGhl
IGNvbW1vbi5uYmQgc2NyaXB0IGhhcyBiZWVuIGNoYW5nZWQgd2l0aCB0aGUgY29tbWl0DQo+PiAg
ICAgICAgYjI4ZjU4MmMsIHRoZSBwYXRjaCAiaW90ZXN0czogYW1lbmQgUUVNVSBOQkQgcHJvY2Vz
cyBzeW5jaHJvbml6YXRpb24iDQo+PiAgICAgICAgaXMgYWN0dWFsIG5vIG1vcmUuIE5vdGUgdGhh
dCBRRU1VX05CRCBpcyBsYXVuY2hlZCBpbiB0aGUgYmFzaCBuZXN0ZWQNCj4+ICAgICAgICBzaGVs
bCBpbiB0aGUgX3FlbXVfbmJkX3dyYXBwZXIoKSBhcyBpdCB3YXMgYmVmb3JlIGluIGNvbW1vbi5y
Yy4NCj4+ICAgIDA0OiBUaGUgcGF0Y2ggImlvdGVzdHM6IG5ldyBmaWxlIHRvIHN1cHByZXNzIFZh
bGdyaW5kIGVycm9ycyIgd2FzIGRyb3BwZWQNCj4+ICAgICAgICBkdWUgdG8gbXkgc3VwZXJmaWNp
YWwgdW5kZXJzdGFuZGluZyBvZiB0aGUgd29yayBvZiB0aGUgZnVuY3Rpb24NCj4+ICAgICAgICBi
bGtfcHJlYWRfdW50aHJvdHRsZWQoKS4gU3BlY2lhbCB0aGFua3MgdG8gS2V2aW4gd2hvIHNoZWQg
dGhlIGxpZ2h0DQo+PiAgICAgICAgb24gdGhlIG51bGwgYmxvY2sgZHJpdmVyIGludm9sdmVkLiBO
b3csIHRoZSBwYXJhbWV0ZXIgJ3JlYWQtemVyb2VzPW9uJw0KPj4gICAgICAgIGlzIHBhc3NlZCB0
byB0aGUgbnVsbCBibG9jayBkcml2ZXIgdG8gaW5pdGlhbGl6ZSB0aGUgYnVmZmVyIGluIHRoZQ0K
Pj4gICAgICAgIGZ1bmN0aW9uIGd1ZXNzX2Rpc2tfbGNocygpIHRoYXQgdGhlIFZhbGdyaW5kIHdh
cyBjb21wbGFpbmluZyB0by4NCj4+DQo+PiB2MjoNCj4+ICAgIDAxOiBUaGUgcGF0Y2ggMi83IG9m
IHYxIHdhcyBtZXJnZWQgaW50byB0aGUgcGF0Y2ggMS83LCBzdWdnZXN0ZWQgYnkgRGFuaWVsLg0K
Pj4gICAgMDI6IEFub3RoZXIgcGF0Y2ggNy83IHdhcyBhZGRlZCB0byBpbnRyb2R1Y2UgdGhlIFZh
bGdyaW5kIGVycm9yIHN1cHByZXNzaW9uDQo+PiAgICAgICAgZmlsZSBpbnRvIHRoZSBRRU1VIHBy
b2plY3QuDQo+PiAgICBEaXNjdXNzZWQgaW4gdGhlIGVtYWlsIHRocmVhZCB3aXRoIHRoZSBtZXNz
YWdlIElEOg0KPj4gICAgPDE1NjAyNzYxMzEtNjgzMjQzLTEtZ2l0LXNlbmQtZW1haWwtYW5kcmV5
LnNoaW5rZXZpY2hAdmlydHVvenpvLmNvbT4NCj4+DQo+PiBBbmRyZXkgU2hpbmtldmljaCAoNik6
DQo+PiAgICBpb3Rlc3RzOiBhbGxvdyBWYWxncmluZCBjaGVja2luZyBhbGwgUUVNVSBwcm9jZXNz
ZXMNCj4+ICAgIGlvdGVzdHM6IGV4Y2x1ZGUga2lsbGVkIHByb2Nlc3NlcyBmcm9tIHJ1bm5pbmcg
dW5kZXIgIFZhbGdyaW5kDQo+PiAgICBpb3Rlc3RzOiBBZGQgY2FzZW5vdHJ1biByZXBvcnQgdG8g
YmFzaCB0ZXN0cw0KPj4gICAgaW90ZXN0czogVmFsZ3JpbmQgZmFpbHMgd2l0aCBub25leGlzdGVu
dCBkaXJlY3RvcnkNCj4+ICAgIGlvdGVzdHM6IGV4dGVuZGVkIHRpbWVvdXQgdW5kZXIgVmFsZ3Jp
bmQNCj4+ICAgIGlvdGVzdHM6IGV4dGVuZCBzbGVlcGluZyB0aW1lIHVuZGVyIFZhbGdyaW5kDQo+
Pg0KPj4gICB0ZXN0cy9xZW11LWlvdGVzdHMvMDI4ICAgICAgIHwgIDYgKysrLQ0KPj4gICB0ZXN0
cy9xZW11LWlvdGVzdHMvMDM5ICAgICAgIHwgIDUgKysrDQo+PiAgIHRlc3RzL3FlbXUtaW90ZXN0
cy8wMzkub3V0ICAgfCAzMCArKystLS0tLS0tLS0tLS0tLQ0KPj4gICB0ZXN0cy9xZW11LWlvdGVz
dHMvMDUxICAgICAgIHwgIDQgKysrDQo+PiAgIHRlc3RzL3FlbXUtaW90ZXN0cy8wNjEgICAgICAg
fCAgMiArKw0KPj4gICB0ZXN0cy9xZW11LWlvdGVzdHMvMDYxLm91dCAgIHwgMTIgKystLS0tLQ0K
Pj4gICB0ZXN0cy9xZW11LWlvdGVzdHMvMTM3ICAgICAgIHwgIDEgKw0KPj4gICB0ZXN0cy9xZW11
LWlvdGVzdHMvMTM3Lm91dCAgIHwgIDYgKy0tLQ0KPj4gICB0ZXN0cy9xZW11LWlvdGVzdHMvMTgz
ICAgICAgIHwgIDkgKysrKystDQo+PiAgIHRlc3RzL3FlbXUtaW90ZXN0cy8xOTIgICAgICAgfCAg
NiArKystDQo+PiAgIHRlc3RzL3FlbXUtaW90ZXN0cy8yNDcgICAgICAgfCAgNiArKystDQo+PiAg
IHRlc3RzL3FlbXUtaW90ZXN0cy9jb21tb24ucmMgfCA3NiArKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKystLS0tLS0tLS0tLQ0KPj4gICAxMiBmaWxlcyBjaGFuZ2VkLCAxMDEgaW5zZXJ0
aW9ucygrKSwgNjIgZGVsZXRpb25zKC0pDQo+Pg0KPj4gLS0gDQo+PiAxLjguMy4xDQo+Pg0KPj4N
Cg0KLS0gDQpXaXRoIHRoZSBiZXN0IHJlZ2FyZHMsDQpBbmRyZXkgU2hpbmtldmljaA0K

