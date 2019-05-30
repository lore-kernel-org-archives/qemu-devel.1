Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 545E6C28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 08:13:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 128AE2576E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 08:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="UF2jadYE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 128AE2576E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48946 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWGBf-0006Ky-3x
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 04:13:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1hWGAK-0005OT-03
	for qemu-devel@nongnu.org; Thu, 30 May 2019 04:12:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1hWGAJ-0008Pl-0X
	for qemu-devel@nongnu.org; Thu, 30 May 2019 04:11:59 -0400
Received: from mail-ve1eur01on0731.outbound.protection.outlook.com
	([2a01:111:f400:fe1f::731]:3202
	helo=EUR01-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
	id 1hWGAG-0008NY-8L; Thu, 30 May 2019 04:11:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=438CqVr5n0dn4qJ4kFqD9iF9bF5rE4J4xRz0j1WwzCQ=;
	b=UF2jadYEWoEu2AUL2lvrHtYSU7jvh4CQPtuHyEiAIJ3hQCqKw8OlDOlT0f+dCKBgTPlBmcWh4wA+nY7xg6PB78rhPWTvg2mn5RD5XOOU/yI4G0Vs0u8jL9PqWFhAqLckSxYLdk1GVKRpulijzREPT5dESSiAm3r7FNMwzwBFzzM=
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (20.178.22.27) by
	AM0PR08MB3858.eurprd08.prod.outlook.com (20.178.82.18) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1922.20; Thu, 30 May 2019 08:11:52 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
	([fe80::1deb:8cf1:f7d2:16cf]) by
	AM0PR08MB3745.eurprd08.prod.outlook.com
	([fe80::1deb:8cf1:f7d2:16cf%6]) with mapi id 15.20.1922.021;
	Thu, 30 May 2019 08:11:52 +0000
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Thread-Topic: [Qemu-block] [PATCH v2] qemu-io: add pattern file for write
	command
Thread-Index: AQHVFryShBuDKdiVE0mpe/siTqMHK6aDUTEA
Date: Thu, 30 May 2019 08:11:52 +0000
Message-ID: <762e39e1-f39d-f7bd-96bf-107a70ca00a7@virtuozzo.com>
References: <20190529114624.23107-1-dplotnikov@virtuozzo.com>
	<20190530075158.nxwed37oqs5qqjzb@steredhat.homenet.telecomitalia.it>
In-Reply-To: <20190530075158.nxwed37oqs5qqjzb@steredhat.homenet.telecomitalia.it>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P190CA0017.EURP190.PROD.OUTLOOK.COM (2603:10a6:3:bc::27)
	To AM0PR08MB3745.eurprd08.prod.outlook.com
	(2603:10a6:208:ff::27)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=dplotnikov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 35895ae2-968d-458b-3526-08d6e4d678d4
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
	SRVR:AM0PR08MB3858; 
x-ms-traffictypediagnostic: AM0PR08MB3858:
x-microsoft-antispam-prvs: <AM0PR08MB3858E973687698A2FD02DD09CF180@AM0PR08MB3858.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 00531FAC2C
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(346002)(396003)(39850400004)(376002)(366004)(136003)(189003)(199004)(6512007)(31686004)(256004)(6246003)(305945005)(25786009)(186003)(3846002)(6116002)(76176011)(6486002)(14444005)(478600001)(66946007)(66476007)(66066001)(6916009)(102836004)(73956011)(64756008)(66446008)(6436002)(53936002)(2906002)(4326008)(66556008)(14454004)(36756003)(99286004)(11346002)(107886003)(54906003)(5660300002)(68736007)(26005)(86362001)(386003)(53546011)(8676002)(8936002)(52116002)(81166006)(81156014)(6506007)(71190400001)(476003)(2616005)(486006)(71200400001)(446003)(31696002)(7736002)(316002)(229853002);
	DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3858;
	H:AM0PR08MB3745.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: X1tRBxQUXjzF8KAmbWCj2QHT0cHYDn2JuErPpTufKo1zRHOqjnqWpwHY40CRzCGK1sHhnv/AddG91UE3AdV7nzDRCD5xtbZsf2PPMxTLawNtzXHw66GFNuqAvx70pi2zgsNfq/B9kqrd0a6A4uznBwa89BcKNf/6pT7EWJR607JIf/1bKud7PGT1eUUfN1/l7UQVUloNaiUdMbZgu6sDlCME0R95lpvXrr3iXtEZmuAdH7//Yb3FRylpkyUdxWzqTPgkEIxJVTSszTep8CIAa7kYVAy1PT8xKPoJdpFABv63uO4+38OthbgE40oOYEOgosyQHGYIykrqZ/hgi3u89SGUW+tox5dtRHmC9cm28whdqtF5eB20uBK0tkDsQZoIrB10JnQvJjzM2qdBxq1WdFPUuab6cFHjMikkDtKzmlM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9863793501AE6C4A9931B075EA516F61@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35895ae2-968d-458b-3526-08d6e4d678d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2019 08:11:52.3889 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dplotnikov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3858
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe1f::731
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2] qemu-io: add pattern file
 for write command
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>,
	"qemu-block@nongnu.org" <qemu-block@nongnu.org>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDMwLjA1LjIwMTkgMTA6NTEsIFN0ZWZhbm8gR2FyemFyZWxsYSB3cm90ZToNCj4gT24g
V2VkLCBNYXkgMjksIDIwMTkgYXQgMDI6NDY6MjRQTSArMDMwMCwgRGVuaXMgUGxvdG5pa292IHdy
b3RlOg0KPj4gVGhlIHBhdGNoIGFsbG93cyB0byBwcm92aWRlIGEgcGF0dGVybiBmaWxlIGZvciB3
cml0ZQ0KPj4gY29tbWFuZC4gVGhlcmUgd2FzIG5vIHNpbWlsYXIgYWJpbGl0eSBiZWZvcmUuDQo+
PiAtLS0NCj4+ICAgcWVtdS1pby1jbWRzLmMgfCA1OCArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrLS0tLQ0KPj4gICAxIGZpbGUgY2hhbmdlZCwgNTQgaW5zZXJ0
aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvcWVtdS1pby1jbWRz
LmMgYi9xZW11LWlvLWNtZHMuYw0KPj4gaW5kZXggMDk3NTBhMjNjZS4uMTQ4ZjJmZjkyYSAxMDA2
NDQNCj4+IC0tLSBhL3FlbXUtaW8tY21kcy5jDQo+PiArKysgYi9xZW11LWlvLWNtZHMuYw0KPj4g
QEAgLTIxLDYgKzIxLDcgQEANCj4+ICAgI2luY2x1ZGUgInFlbXUvb3B0aW9uLmgiDQo+PiAgICNp
bmNsdWRlICJxZW11L3RpbWVyLmgiDQo+PiAgICNpbmNsdWRlICJxZW11L2N1dGlscy5oIg0KPj4g
KyNpbmNsdWRlICJzdHJpbmcuaCINCj4+ICAgDQo+PiAgICNkZWZpbmUgQ01EX05PRklMRV9PSyAg
IDB4MDENCj4+ICAgDQo+PiBAQCAtMzQzLDYgKzM0NCwzNSBAQCBzdGF0aWMgdm9pZCAqcWVtdV9p
b19hbGxvYyhCbG9ja0JhY2tlbmQgKmJsaywgc2l6ZV90IGxlbiwgaW50IHBhdHRlcm4pDQo+PiAg
ICAgICByZXR1cm4gYnVmOw0KPj4gICB9DQo+PiAgIA0KPj4gK3N0YXRpYyB2b2lkICpxZW11X2lv
X2FsbG9jX2Zyb21fZmlsZShCbG9ja0JhY2tlbmQgKmJsaywgc2l6ZV90IGxlbiwNCj4+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY2hhciAqZmlsZV9uYW1lKQ0KPj4gK3sN
Cj4+ICsgICAgdm9pZCAqYnVmOw0KPj4gKyAgICBGSUxFICpmID0gZm9wZW4oZmlsZV9uYW1lLCAi
ciIpOw0KPj4gKw0KPj4gKyAgICBpZiAoIWYpIHsNCj4+ICsgICAgICAgIHByaW50ZigiY2Fubm90
IG9wZW4gZmlsZSAnJXMnXG4iLCBmaWxlX25hbWUpOw0KPj4gKyAgICAgICAgcmV0dXJuIE5VTEw7
DQo+PiArICAgIH0NCj4+ICsNCj4+ICsgICAgaWYgKHFlbXVpb19taXNhbGlnbikgew0KPj4gKyAg
ICAgICAgbGVuICs9IE1JU0FMSUdOX09GRlNFVDsNCj4+ICsgICAgfQ0KPj4gKyAgICBidWYgPSBi
bGtfYmxvY2thbGlnbihibGssIGxlbik7DQo+PiArICAgIG1lbXNldChidWYsIDAsIGxlbik7DQo+
PiArDQo+PiArICAgIGlmICghZnJlYWQoYnVmLCBzaXplb2YoY2hhciksIGxlbiwgZikpIHsNCj4+
ICsgICAgICAgIHByaW50ZigiZmlsZSAnJXMnIGlzIGVtcHR5XG4iLCBmaWxlX25hbWUpOw0KPj4g
KyAgICAgICAgcWVtdV92ZnJlZShidWYpOw0KPj4gKyAgICAgICAgcmV0dXJuIE5VTEw7DQo+PiAr
ICAgIH0NCj4gDQo+IFNob3VsZCB3ZSBjbG9zZSB0aGUgRklMRSAqZiBhdCB0aGUgZW5kIG9mIHRo
aXMgZnVuY3Rpb24gb3Igd2hlbiBmcmVhZCgpDQo+IHJldHVybnMgd2l0aCBhbiBlcnJvcj8NCg0K
SSB0aGluayB3ZSBzaG91bGQuIEZpeGVkIGluIHYzICh2NCBoYXMgYmVlbiBzZW50KS4NClRoYW5r
cyENCj4gDQo+IFRoYW5rcywNCj4gU3RlZmFubw0KPiANCg0KLS0gDQpCZXN0LA0KRGVuaXMNCg==

