Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79CADC49ED7
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 07:14:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 310D221907
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 07:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="VaEr7usP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 310D221907
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAqeK-0007aK-Am
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 03:14:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53797)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iAqbi-0004e9-Ls
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 03:12:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iAqbh-0006co-1j
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 03:12:02 -0400
Received: from mail-eopbgr50132.outbound.protection.outlook.com
 ([40.107.5.132]:6819 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iAqba-0006Wx-GU; Thu, 19 Sep 2019 03:11:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k9HpjpbWgGMLMLv5x3J4zxUN7yjKZn7c5BJ7u6KxfQ3Jd/Drodvn3k3HtPuQXauF95nmLaAWUhu7G8r37TSepeAV4qu4dWGsYWyStJES+bkSuN7p535CGWrMWW2EVPnea5gxmDYYWSrvz8bR0SHkI6bmhhNgiV8CX4IL0q/TDh/ddWuEX9lTzV3eY1PTH5oGjf115ksfwAu0/0BIlezXHbpXtGlqfQCrs52zBGaEF02gnWg2tknLMauXTbQ/xjmXwfu0tnc6IlUZYh1HLRebhGSuM12MJtqsVzdS3QxzsE0a1QXYe1gHMf/M7LT6o+kJeddX5C9jTLvDnD3iWAgaNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7pEZiHGtfmpAaScziVnoBmL/kltJ9+Zlm40h2DS0BPE=;
 b=BeC2aHasE6kPwZW6kHt99qo+RmOUNfRHhD73IznsANAA16huoArh0HdynHouxTxHaxMnb65oISaGc+MNCWjRPCm68MDJQMCMhtrGvRY+brvnn9n8bQDCDLIzuJCLGz4Kuv+GFYHZl0p9jqMK61v/c261Wg2+NknSIs+J1wx7mSMfd192MNmVcVIBX4oBjkO/KNb4nUT2JIBjH4HOdrKbbCECCNhyTYRO0OBpn0a2mn2ww1+z4KKNsKEoBmv9Ys2imVpAKlJkhtIyIrnVYNLdNunN7oH78vhUVQtjsP+me059HuFBblpV97sc53oeuLiaZycvt5RMHdgbM5At2E/9zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7pEZiHGtfmpAaScziVnoBmL/kltJ9+Zlm40h2DS0BPE=;
 b=VaEr7usP8eUkas6MzrpXyQk6wuFpBqpM8zcyhuNlWAlj34jcuV7uUVDmLZt0yL/vcaXYjGNsJXBsS+HkdqtBOEkxqNPtU+25djw2XwYCDBOR39R7iweql9DvdFWUyaxHp0CqGbZEg0XtVeKkpJMaUR22CW3ATsTGw8Vgii0YUI8=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4985.eurprd08.prod.outlook.com (20.179.15.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.19; Thu, 19 Sep 2019 07:11:52 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2284.009; Thu, 19 Sep 2019
 07:11:52 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Thread-Topic: [Qemu-block] [Qemu-devel] [PATCH] block/backup: install notifier
 during creation
Thread-Index: AQHVTu7v5GJB5n7vl0itOMdQhozpxacFvxkAgABZlQCAHqpyAIAAVPIAgA0KCQCAALMJgA==
Date: Thu, 19 Sep 2019 07:11:51 +0000
Message-ID: <6e3c1b53-c104-2b05-418e-d44f45a82be8@virtuozzo.com>
References: <20190809201333.29033-1-jsnow@redhat.com>
 <b85698e6-cd79-a9c5-554c-c92487060280@virtuozzo.com>
 <154bc276-d782-443f-3db6-38d87992d609@redhat.com>
 <20190910081942.GA23976@stefanha-x1.localdomain>
 <9bf835d7-8bfa-feba-c2f7-acd6cda4a81e@redhat.com>
 <0abc4992-9322-010a-118b-62e79cbc5b58@redhat.com>
In-Reply-To: <0abc4992-9322-010a-118b-62e79cbc5b58@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR08CA0062.eurprd08.prod.outlook.com
 (2603:10a6:7:2a::33) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190919101149784
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: db69babd-2af8-4bde-98f9-08d73cd0a52e
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB4985; 
x-ms-traffictypediagnostic: DB8PR08MB4985:
x-microsoft-antispam-prvs: <DB8PR08MB4985E1F633250B7BD921CE80C1890@DB8PR08MB4985.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 016572D96D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(346002)(136003)(366004)(39850400004)(396003)(189003)(199004)(305945005)(5660300002)(6506007)(316002)(486006)(7736002)(36756003)(76176011)(102836004)(386003)(186003)(26005)(53546011)(54906003)(446003)(110136005)(3846002)(2616005)(476003)(52116002)(2906002)(14454004)(8936002)(11346002)(25786009)(478600001)(81166006)(81156014)(6486002)(229853002)(8676002)(6512007)(6116002)(4326008)(6246003)(31686004)(6436002)(64756008)(14444005)(86362001)(99286004)(31696002)(66066001)(256004)(66556008)(71200400001)(66446008)(71190400001)(66476007)(66946007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4985;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mFhkUHhKLKFctnegTFHCEWSyqLTY/EBlXGEQOYIu6gTkmDTuwztwAPhD3HbeKSk5Vu9flF2t3spEg7E13Hn1KGPDMoXnxVIRi5Pr2ptJxrgYDcj7I37ghqLFDgsYmWRA0ugvpJ7w1WlFmBdrLCRH8yw1goZg03eqNloH6iYS4A45obvGFMbZOciRtmZ4pFVCjH2+epRtHNGmaI5b1fG7WJHCbdcrgNTeFcbM40aXaiW9u5Dvqdq4SMSMRjqCsqLZ8hTSc7fFaekvpMzGqLKUlJRIlCj5jehgxBG7O1/TA0NWj6c5d9Qbs0Y5hNDxMoX8Pa/1YnYkDb1cFVTZJQBogg+Xf19VxBdAXPqZeZgrVKeQ5hVhrsHZBoxRxxo9Ub4kkTnI0jV96QneDyRNe2IUz/Bpxn53dFFvJZ5rUtNvKKM=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <19DF1D11C4A84644BF355CA69BFE7A83@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db69babd-2af8-4bde-98f9-08d73cd0a52e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2019 07:11:52.0524 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: stRHU3lr5FiEhqz26BO6J28PcdpxdDbbvOIAhSy3is/mbdAtaLrJRXYcSdcsQE2Xz6tuUoHkhnQUy7nN6b10Ba6vuNagHQ6WObh8xF1RqMg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4985
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.5.132
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block/backup: install
 notifier during creation
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
Cc: Max Reitz <mreitz@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTguMDkuMjAxOSAyMzozMSwgSm9obiBTbm93IHdyb3RlOg0KPiANCj4gDQo+IE9uIDkvMTAvMTkg
OToyMyBBTSwgSm9obiBTbm93IHdyb3RlOg0KPj4NCj4+DQo+PiBPbiA5LzEwLzE5IDQ6MTkgQU0s
IFN0ZWZhbiBIYWpub2N6aSB3cm90ZToNCj4+PiBPbiBXZWQsIEF1ZyAyMSwgMjAxOSBhdCAwNDow
MTo1MlBNIC0wNDAwLCBKb2huIFNub3cgd3JvdGU6DQo+Pj4+DQo+Pj4+DQo+Pj4+IE9uIDgvMjEv
MTkgMTA6NDEgQU0sIFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgd3JvdGU6DQo+Pj4+PiAw
OS4wOC4yMDE5IDIzOjEzLCBKb2huIFNub3cgd3JvdGU6DQo+Pj4+Pj4gQmFja3VwIGpvYnMgbWF5
IHlpZWxkIHByaW9yIHRvIGluc3RhbGxpbmcgdGhlaXIgaGFuZGxlciwgYmVjYXVzZSBvZiB0aGUN
Cj4+Pj4+PiBqb2JfY29fZW50cnkgc2hpbSB3aGljaCBndWFyYW50ZWVzIHRoYXQgYSBqb2Igd29u
J3QgYmVnaW4gd29yayB1bnRpbA0KPj4+Pj4+IHdlIGFyZSByZWFkeSB0byBzdGFydCBhbiBlbnRp
cmUgdHJhbnNhY3Rpb24uDQo+Pj4+Pj4NCj4+Pj4+PiBVbmZvcnR1bmF0ZWx5LCB0aGlzIG1ha2Vz
IHByb3ZpbmcgY29ycmVjdG5lc3MgYWJvdXQgdHJhbnNhY3Rpb25hbA0KPj4+Pj4+IHBvaW50cy1p
bi10aW1lIGZvciBiYWNrdXAgaGFyZCB0byByZWFzb24gYWJvdXQuIE1ha2UgaXQgZXhwbGljaXRs
eSBjbGVhcg0KPj4+Pj4+IGJ5IG1vdmluZyB0aGUgaGFuZGxlciByZWdpc3RyYXRpb24gdG8gY3Jl
YXRpb24gdGltZSwgYW5kIGNoYW5naW5nIHRoZQ0KPj4+Pj4+IHdyaXRlIG5vdGlmaWVyIHRvIGEg
bm8tb3AgdW50aWwgdGhlIGpvYiBpcyBzdGFydGVkLg0KPj4+Pj4+DQo+Pj4+Pj4gUmVwb3J0ZWQt
Ynk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNv
bT4NCj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBKb2huIFNub3cgPGpzbm93QHJlZGhhdC5jb20+DQo+
Pj4+Pj4gLS0tDQo+Pj4+Pj4gICAgYmxvY2svYmFja3VwLmMgICAgIHwgMzIgKysrKysrKysrKysr
KysrKysrKysrKystLS0tLS0tLS0NCj4+Pj4+PiAgICBpbmNsdWRlL3FlbXUvam9iLmggfCAgNSAr
KysrKw0KPj4+Pj4+ICAgIGpvYi5jICAgICAgICAgICAgICB8ICAyICstDQo+Pj4+Pj4gICAgMyBm
aWxlcyBjaGFuZ2VkLCAyOSBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkNCj4+Pj4+Pg0K
Pj4+Pj4+IGRpZmYgLS1naXQgYS9ibG9jay9iYWNrdXAuYyBiL2Jsb2NrL2JhY2t1cC5jDQo+Pj4+
Pj4gaW5kZXggMDdkNzUxYWVhNC4uNGRmNWI5NTQxNSAxMDA2NDQNCj4+Pj4+PiAtLS0gYS9ibG9j
ay9iYWNrdXAuYw0KPj4+Pj4+ICsrKyBiL2Jsb2NrL2JhY2t1cC5jDQo+Pj4+Pj4gQEAgLTM0NCw2
ICszNDQsMTMgQEAgc3RhdGljIGludCBjb3JvdXRpbmVfZm4gYmFja3VwX2JlZm9yZV93cml0ZV9u
b3RpZnkoDQo+Pj4+Pj4gICAgICAgIGFzc2VydChRRU1VX0lTX0FMSUdORUQocmVxLT5vZmZzZXQs
IEJEUlZfU0VDVE9SX1NJWkUpKTsNCj4+Pj4+PiAgICAgICAgYXNzZXJ0KFFFTVVfSVNfQUxJR05F
RChyZXEtPmJ5dGVzLCBCRFJWX1NFQ1RPUl9TSVpFKSk7DQo+Pj4+Pj4gICAgDQo+Pj4+Pj4gKyAg
ICAvKiBUaGUgaGFuZGxlciBpcyBpbnN0YWxsZWQgYXQgY3JlYXRpb24gdGltZTsgdGhlIGFjdHVh
bCBwb2ludC1pbi10aW1lDQo+Pj4+Pj4gKyAgICAgKiBzdGFydHMgYXQgam9iX3N0YXJ0KCkuIFRy
YW5zYWN0aW9ucyBndWFyYW50ZWUgdGhvc2UgdHdvIHBvaW50cyBhcmUNCj4+Pj4+PiArICAgICAq
IHRoZSBzYW1lIHBvaW50IGluIHRpbWUuICovDQo+Pj4+Pj4gKyAgICBpZiAoIWpvYl9zdGFydGVk
KCZqb2ItPmNvbW1vbi5qb2IpKSB7DQo+Pj4+Pj4gKyAgICAgICAgcmV0dXJuIDA7DQo+Pj4+Pj4g
KyAgICB9DQo+Pj4+Pg0KPj4+Pj4gSG1tLCBzb3JyeSBpZiBpdCBpcyBhIHN0dXBpZCBxdWVzdGlv
biwgSSdtIG5vdCBnb29kIGluIG11bHRpcHJvY2Vzc2luZyBhbmQgaW4NCj4+Pj4+IFFlbXUgaW90
aHJlYWRzLi4NCj4+Pj4+DQo+Pj4+PiBqb2Jfc3RhcnRlZCBqdXN0IHJlYWRzIGpvYi0+Y28uIElm
IGJzIHJ1bnMgaW4gaW90aHJlYWQsIGFuZCB0aGVyZWZvcmUgd3JpdGUtbm90aWZpZXINCj4+Pj4+
IGlzIGluIGlvdGhyZWFkLCB3aGVuIGpvYl9zdGFydCBpcyBjYWxsZWQgZnJvbSBtYWluIHRocmVh
ZC4uIElzIGl0IGd1YXJhbnRlZWQgdGhhdA0KPj4+Pj4gd3JpdGUtbm90aWZpZXIgd2lsbCBzZWUg
am9iLT5jbyB2YXJpYWJsZSBjaGFuZ2UgZWFybHkgZW5vdWdoIHRvIG5vdCBtaXNzIGd1ZXN0IHdy
aXRlPw0KPj4+Pj4gU2hvdWxkIG5vdCBqb2ItPmNvIGJlIHZvbGF0aWxlIGZvciBleGFtcGxlIG9y
IHNvbWV0aGluZyBsaWtlIHRoaXM/DQo+Pj4+Pg0KPj4+Pj4gSWYgbm90IHRoaW5rIGFib3V0IHRo
aXMgcGF0Y2ggbG9va3MgZ29vZCBmb3IgbWUuDQo+Pj4+Pg0KPj4+Pg0KPj4+PiBZb3Uga25vdywg
aXQncyBhIHJlYWxseSBnb29kIHF1ZXN0aW9uLg0KPj4+PiBTbyBnb29kLCBpbiBmYWN0LCB0aGF0
IEkgaGF2ZSBubyBpZGVhLg0KPj4+Pg0KPj4+PiDCr1xfKOODhClfL8KvDQo+Pj4+DQo+Pj4+IEkn
bSBmYWlybHkgY2VydGFpbiB0aGF0IElPIHdpbGwgbm90IGNvbWUgaW4gdW50aWwgdGhlIC5jbGVh
biBwaGFzZSBvZiBhDQo+Pj4+IHFtcF90cmFuc2FjdGlvbiwgYmVjYXVzZSBiZHJ2X2RyYWluZWRf
YmVnaW4oYnMpIGlzIGNhbGxlZCBkdXJpbmcNCj4+Pj4gLnByZXBhcmUsIGFuZCB3ZSBhY3RpdmF0
ZSB0aGUgaGFuZGxlciAoYnkgc3RhcnRpbmcgdGhlIGpvYikgaW4gLmNvbW1pdC4NCj4+Pj4gV2Ug
ZG8gbm90IGVuZCB0aGUgZHJhaW5lZCBzZWN0aW9uIHVudGlsIC5jbGVhbi4NCj4+Pj4NCj4+Pj4g
SSdtIG5vdCBmdWxseSBjbGVhciBvbiB3aGF0IHRocmVhZGluZyBndWFyYW50ZWVzIHdlIGhhdmUg
b3RoZXJ3aXNlLA0KPj4+PiB0aG91Z2g7IGlzIGl0IHBvc3NpYmxlIHRoYXQgIlRocmVhZCBBIiB3
b3VsZCBzb21laG93IGxpZnQgdGhlIGJkcnZfZHJhaW4NCj4+Pj4gb24gYW4gSU8gdGhyZWFkICgi
VGhyZWFkIEIiKSBhbmQsIGFmdGVyIHRoYXQsICJUaHJlYWQgQiIgd291bGQgc29tZWhvdw0KPj4+
PiBzdGlsbCBiZSBhYmxlIHRvIHNlZSBhbiBvdXRkYXRlZCB2ZXJzaW9uIG9mIGpvYi0+Y28gdGhh
dCB3YXMgc2V0IGJ5DQo+Pj4+ICJUaHJlYWQgQSI/DQo+Pj4+DQo+Pj4+IEkgZG91YnQgaXQ7IGJ1
dCBJIGNhbid0IHByb3ZlIGl0Lg0KPj4+DQo+Pj4gSW4gdGhlIHFtcF9iYWNrdXAoKSBjYXNlIChu
b3QgcW1wX3RyYW5zYWN0aW9uKCkpIHRoZXJlIGlzOg0KPj4+DQo+Pj4gICAgdm9pZCBxbXBfZHJp
dmVfYmFja3VwKERyaXZlQmFja3VwICphcmcsIEVycm9yICoqZXJycCkNCj4+PiAgICB7DQo+Pj4N
Cj4+PiAgICAgICAgQmxvY2tKb2IgKmpvYjsNCj4+PiAgICAgICAgam9iID0gZG9fZHJpdmVfYmFj
a3VwKGFyZywgTlVMTCwgZXJycCk7DQo+Pj4gICAgICAgIGlmIChqb2IpIHsNCj4+PiAgICAgICAg
ICAgIGpvYl9zdGFydCgmam9iLT5qb2IpOw0KPj4+ICAgICAgICB9DQo+Pj4gICAgfQ0KPj4+DQo+
Pj4gam9iX3N0YXJ0KCkgaXMgY2FsbGVkIHdpdGhvdXQgYW55IHRocmVhZCBzeW5jaHJvbml6YXRp
b24sIHdoaWNoIGlzDQo+Pj4gdXN1YWxseSBmaW5lIGJlY2F1c2UgdGhlIGNvcm91dGluZSBkb2Vz
bid0IHJ1biB1bnRpbCBqb2Jfc3RhcnQoKSBjYWxscw0KPj4+IGFpb19jb19lbnRlcigpLg0KPj4+
DQo+Pj4gTm93IHRoYXQgdGhlIGJlZm9yZSB3cml0ZSBub3RpZmllciBoYXMgYmVlbiBpbnN0YWxs
ZWQgZWFybHksIHRoZXJlIGlzDQo+Pj4gaW5kZWVkIGEgcmFjZSBiZXR3ZWVuIGpvYl9zdGFydCgp
IGFuZCB0aGUgd3JpdGUgbm90aWZpZXIgYWNjZXNzaW5nDQo+Pj4gam9iLT5jbyBmcm9tIGFuIElP
VGhyZWFkLg0KPj4+DQo+Pj4gVGhlIHdyaXRlIGJlZm9yZSBub3RpZmllciBtaWdodCBzZWUgam9i
LT5jbyAhPSBOVUxMIGJlZm9yZSBqb2Jfc3RhcnQoKQ0KPj4+IGhhcyBmaW5pc2hlZC4gIFRoaXMg
Y291bGQgbGVhZCB0byBpc3N1ZXMgaWYgam9iXyooKSBBUElzIGFyZSBpbnZva2VkIGJ5DQo+Pj4g
dGhlIHdyaXRlIG5vdGlmaWVyIGFuZCBhY2Nlc3MgYW4gaW4tYmV0d2VlbiBqb2Igc3RhdGUuDQo+
Pj4NCj4+DQo+PiBJIHNlZS4gSSB0aGluayBpbiB0aGlzIGNhc2UsIGFzIGxvbmcgYXMgaXQgc2Vl
cyAhPSBOVUxMLCB0aGF0IHRoZQ0KPj4gbm90aWZpZXIgaXMgYWN0dWFsbHkgc2FmZSB0byBydW4u
IEkgYWdyZWUgdGhhdCB0aGlzIG1pZ2h0IGJlIGNvbmZ1c2luZw0KPj4gdG8gdmVyaWZ5IGFuZCBj
b3VsZCBiaXRlIHVzIGluIHRoZSBmdXR1cmUuIFRoZSB3b3JyeSB3ZSBoYWQsIHRvbywgaXMNCj4+
IG1vcmUgdGhlIG9wcG9zaXRlOiB3aWxsIGl0IHNlZSBOVUxMIGZvciB0b28gbG9uZz8gV2Ugd2Fu
dCB0byBtYWtlIHN1cmUNCj4+IHRoYXQgaXQgaXMgcmVnaXN0ZXJpbmcgYXMgdHJ1ZSAqYmVmb3Jl
IHRoZSBmaXJzdCB5aWVsZCouDQo+Pg0KPj4+IEEgc2FmZXIgYXBwcm9hY2ggaXMgdG8gc2V0IGEg
QmFja3VwQmxvY2tKb2IgdmFyaWFibGUgYXQgdGhlIGJlZ2lubmluZyBvZg0KPj4+IGJhY2t1cF9y
dW4oKSBhbmQgY2hlY2sgaXQgZnJvbSB0aGUgYmVmb3JlIHdyaXRlIG5vdGlmaWVyLg0KPj4+DQo+
Pg0KPj4gVGhhdCdzIHRvbyBsYXRlLCBmb3IgcmVhc29ucyBiZWxvdy4NCj4+DQo+Pj4gVGhhdCBz
YWlkLCBJIGRvbid0IHVuZGVyc3RhbmQgdGhlIGJlbmVmaXQgb2YgdGhpcyBwYXRjaCBhbmQgSU1P
IGl0IG1ha2VzDQo+Pj4gdGhlIGNvZGUgaGFyZGVyIHRvIHVuZGVyc3RhbmQgYmVjYXVzZSBub3cg
d2UgbmVlZCB0byB0aGluayBhYm91dCB0aGUNCj4+PiBjcmVhdGVkIGJ1dCBub3Qgc3RhcnRlZCBz
dGF0ZSB0b28uDQo+Pj4NCj4+PiBTdGVmYW4NCj4+Pg0KPj4NCj4+IEl0J3MgYWx3YXlzIHBvc3Np
YmxlIEkndmUgaHlwZWQgbXlzZWxmIHVwIGludG8gYmVsaWV2aW5nIHRoZXJlJ3MgYQ0KPj4gcHJv
YmxlbSB3aGVyZSB0aGVyZSBpc24ndCBvbmUsIGJ1dCB0aGUgZmVhciBpcyB0aGlzOg0KPj4NCj4+
IFRoZSBwb2ludCBpbiB0aW1lIGZyb20gYSBRTVAgdHJhbnNhY3Rpb24gY292ZXJzIHRoZSBqb2Ig
Y3JlYXRpb24gYW5kIHRoZQ0KPj4gam9iIHN0YXJ0LCBidXQgd2hlbiB3ZSBzdGFydCB0aGUgam9i
IGl0IHdpbGwgYWN0dWFsbHkgeWllbGQgYmVmb3JlIHdlDQo+PiBnZXQgdG8gYmFja3VwX3J1biAt
LSBhbmQgdGhlcmUgaXMgbm8gZ3VhcmFudGVlIHRoYXQgdGhlIGhhbmRsZXIgd2lsbCBnZXQNCj4+
IGluc3RhbGxlZCBzeW5jaHJvbm91c2x5LCBzbyB0aGUgcG9pbnQgaW4gdGltZSBlbmRzIGJlZm9y
ZSB0aGUgaGFuZGxlcg0KPj4gYWN0aXZhdGVzLg0KPj4NCj4gDQo+IGkuZS4sIHRoZSBoYW5kbGVy
IG1pZ2h0IGdldCBpbnN0YWxsZWQgQUZURVIgdGhlIGNyaXRpY2FsIHJlZ2lvbiBvZiBhDQo+IHRy
YW5zYWN0aW9uLiBXZSBjb3VsZCBkcm9wIGluaXRpYWwgd3JpdGVzIGlmIHdlIHdlcmUgdW5sdWNr
eS4NCj4gDQo+IChJIHRoaW5rLikNCj4gDQo+PiBUaGUgeWllbGQgb2NjdXJzIGluIGpvYl9jb19l
bnRyeSBhcyBhbiBpbnRlbnRpb25hbCBmZWF0dXJlIG9mIGZvcmNpbmcgYQ0KPj4geWllbGQgYW5k
IHBhdXNlIHBvaW50IGF0IHJ1biB0aW1lIC0tIHNvIGl0J3MgaGFyZGVyIHRvIHdyaXRlIGEgam9i
IHRoYXQNCj4+IGFjY2lkZW50YWxseSBob2dzIHRoZSB0aHJlYWQgZHVyaW5nIGluaXRpYWxpemF0
aW9uLg0KPj4NCj4+IFRoaXMgaXMgYW4gYXR0ZW1wdCB0byBnZXQgdGhlIGhhbmRsZXIgaW5zdGFs
bGVkIGVhcmxpZXIgdG8gZW5zdXJlIHRoZQ0KPj4gcG9pbnQgb2YgdGltZSBzdGF5cyBzeW5jaHJv
bml6ZWQgd2l0aCBjcmVhdGlvbiB0aW1lIHRvIHByb3ZpZGUgYQ0KPj4gc3Ryb25nZXIgdHJhbnNh
Y3Rpb25hbCBndWFyYW50ZWUuDQo+Pg0KPiANCj4gU3F1ZWFreSB3aGVlbCBnZXRzIHRoZSBncmVh
c2UuIEFueSBjb21tZW50Pw0KPiANCg0KSG1tLCB0aGlzIGFsbCBiZWNvbWVzIGRpZmZpY3VsdCwg
SSdkIHByZWZlciB0byBub3Qgd29ycnkgYW5kIHdhaXQgZm9yIGJhY2t1cC10b3ANCmZpbHRlciBh
cHBsaWVkLg0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

