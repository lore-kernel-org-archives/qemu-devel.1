Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B768C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 14:19:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00850218AF
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 14:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="USleExbI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00850218AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAxH5-00065U-0j
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 10:19:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54273)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iAxBO-0000WZ-Dt
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 10:13:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iAxBN-0006D1-0G
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 10:13:18 -0400
Received: from mail-eopbgr40115.outbound.protection.outlook.com
 ([40.107.4.115]:14015 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iAxB9-0005tF-2u; Thu, 19 Sep 2019 10:13:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VAsSBRKLujyN/JqcmAEz98WesL5vh73O0IZcmW0zGZ9so0TdQdIAjmcAIeImKCmpwDLyJB/MhXWJWLG3fLFR1BwN7+krVbwW1Vw1X3b8A1P1ulMrPPrURmqBffx1IL8HrCEkvxdKNUG+2oeXbvtCbAaT1sQhcaWHukX5STtfMlMsekwPGLohzFpwWRgeiLfFf6TI/C/zuDMhsFWMXdFrA57DWlxOJGQ5KScVE9YrpNG3al2FgcxlG134dT/H0MdwTVJvKSyjqYNc+8i0Ge29zQ6MA2FMhHFyAuVxslIJUiSOD4LhacC/M0/3i1y4kDGy7JpZlGjbPWAhCAiiog2Dpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cnQtM5fR0kGSmjxDFg6O5NO+CxMtig+gROHKEVDh3+A=;
 b=DDWjBuc9pNXjEFielFWyBG4w3HuMP/NEckpgP6LSldGZSwgItMa7Gzb7a04VJ5kyeYvyqIjgHfmWBwq1wG94Qt29/aVxWjI1RY0FpuewAWCTjLsfUD/Q5Ku6++am5KXM3Xq3/p2WCXgz1w9q3TwBZt3UhSwyU33LD/Hq/cW9Iq9hP0ZoOBf5AZaFEH9oU/G07JezJ7aspOOM59+cs7O70QASe5EnsLalRt5ObiKNHedxHS5/ztMfonoIQL3nx93UYnW/P7Vu3ZCYN+PiSQZMnPSwPat5VaD1H1NlFQhsRKjw5KZ26LHKSoHGCrhSZTbSd0yeaykoiYoTY48xWAHdCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cnQtM5fR0kGSmjxDFg6O5NO+CxMtig+gROHKEVDh3+A=;
 b=USleExbIxktm8bmmkbbe4VNXkaSsd7eX1085xU+eU7hRXUlBF/6pJXWNLI8YGcYWc575P1eSlbQdFfoIcp+U79Hpl/bR8CIiHAVMrw3J1htOvpndDPKijGIvywam5sHM2AttuDbo9zp3Q6qb6YR9Ek4WeI3tsZbRRnOc7I6/scY=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4122.eurprd08.prod.outlook.com (20.179.11.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.23; Thu, 19 Sep 2019 14:13:00 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2284.009; Thu, 19 Sep 2019
 14:13:00 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Thread-Topic: [RFC] error: auto propagated local_err
Thread-Index: AQHVbiFyZhBrSsOpYEOTsgc7Le+SIKcxq6KAgAEOLgCAAEmpAIAACO4A
Date: Thu, 19 Sep 2019 14:13:00 +0000
Message-ID: <35c972e1-bdb5-cbcb-ed45-6a51f19af98c@virtuozzo.com>
References: <20190918130244.24257-1-vsementsov@virtuozzo.com>
 <abb14088-6af2-5db2-da0d-0948fd4ac81c@redhat.com>
 <20190919091720.GB10163@localhost.localdomain>
 <57483252-273c-4606-47a8-eddeb840109a@redhat.com>
In-Reply-To: <57483252-273c-4606-47a8-eddeb840109a@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P192CA0014.EURP192.PROD.OUTLOOK.COM (2603:10a6:3:fe::24)
 To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190919171256338
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 84ce11bd-58d0-4ffb-9d03-08d73d0b7a26
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:DB8PR08MB4122; 
x-ms-traffictypediagnostic: DB8PR08MB4122:
x-microsoft-antispam-prvs: <DB8PR08MB4122B064C69B483092F96CE8C1890@DB8PR08MB4122.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 016572D96D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(39850400004)(396003)(376002)(346002)(366004)(199004)(51444003)(189003)(305945005)(229853002)(6246003)(66066001)(486006)(7736002)(186003)(6512007)(66946007)(64756008)(66556008)(86362001)(7416002)(66446008)(66476007)(4326008)(7406005)(102836004)(11346002)(26005)(31686004)(14454004)(6506007)(53546011)(71190400001)(6116002)(36756003)(54906003)(71200400001)(110136005)(3846002)(8936002)(2906002)(76176011)(31696002)(316002)(478600001)(6436002)(476003)(5660300002)(81156014)(99286004)(2616005)(52116002)(81166006)(14444005)(8676002)(6486002)(256004)(25786009)(386003)(446003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4122;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: z82CFMLkIAlciruMjw2P6ETl7E8bCOyL/rd2frt9K7xJqhCoKdyVmQAiIkDwFkS3lL872KAqBmrnvIG7ste37yRFILpyXM54eHi87niBIE2tlg+cEBjmXs4GX0ZL5CBYLqD6x+3Sq8ZFq2JtWCfvCSL3a7JjJoJSJB6nvuAl/ANkXGg7HrDeLOEAAjqc5KsfDWYEuXXYNO7yPhv9YZ1svR5KZtYriDVQgklDkCimixRezzur6dYGQiodQ2tLDU95hB2MtP7gea5fi64qqocq7MpkBJQpEZWn8iMi5vJTw61YMWkq8GbD+1ir7Ifz7mZzst6o5hkHv+3jwZqpa3b2PXKe+QGs7jQrU8jA/C1yxN7UaagFW5+wzsU4pmwCPBZjuqJIwunm3POoF5J0YDedRhvaPQvMkdx58kwmx4q0D8k=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <142B444994358F40BD8761E7EA390D48@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84ce11bd-58d0-4ffb-9d03-08d73d0b7a26
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2019 14:13:00.0600 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yz71X6w4tZ3aTzGqjTwj4dKjNF4Vi1RJDNduV3l5rie1dCooVzCmH3wZ+d6K/n+jO9XScIdGaAk8AXiS1rr9zaSGV5lyDgbE2saSm+ACmoc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4122
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.4.115
Subject: Re: [Qemu-devel] [RFC] error: auto propagated local_err
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
Cc: "fam@euphon.net" <fam@euphon.net>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "mst@redhat.com" <mst@redhat.com>, "codyprime@gmail.com" <codyprime@gmail.com>,
 "mark.cave-ayland@ilande.co.uk" <mark.cave-ayland@ilande.co.uk>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "kraxel@redhat.com" <kraxel@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "quintela@redhat.com" <quintela@redhat.com>,
 "david@redhat.com" <david@redhat.com>,
 "mdroth@linux.vnet.ibm.com" <mdroth@linux.vnet.ibm.com>,
 "pasic@linux.ibm.com" <pasic@linux.ibm.com>,
 "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>,
 "farman@linux.ibm.com" <farman@linux.ibm.com>,
 "groug@kaod.org" <groug@kaod.org>, "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>,
 "sundeep.lkml@gmail.com" <sundeep.lkml@gmail.com>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTkuMDkuMjAxOSAxNjo0MCwgRXJpYyBCbGFrZSB3cm90ZToNCj4gT24gOS8xOS8xOSA0OjE3IEFN
LCBLZXZpbiBXb2xmIHdyb3RlOg0KPj4gQW0gMTguMDkuMjAxOSB1bSAxOToxMCBoYXQgRXJpYyBC
bGFrZSBnZXNjaHJpZWJlbjoNCj4+PiBPbiA5LzE4LzE5IDg6MDIgQU0sIFZsYWRpbWlyIFNlbWVu
dHNvdi1PZ2lldnNraXkgd3JvdGU6DQo+Pj4+ICsgKi8NCj4+Pj4gKyNkZWZpbmUgTUFLRV9FUlJQ
X1NBRkUoZXJycCkgXA0KPj4+PiArZ19hdXRvKEVycm9yUHJvcGFnYXRpb25TdHJ1Y3QpIChfX2F1
dG9fZXJycF9wcm9wKSA9IHsuZXJycCA9IChlcnJwKX07IFwNCj4+Pj4gK2lmICgoZXJycCkgPT0g
TlVMTCB8fCAqKGVycnApID09IGVycm9yX2Fib3J0IHx8ICooZXJycCkgPT0gZXJyb3JfZmF0YWwp
IHsgXA0KPj4+PiArICAgIChlcnJwKSA9ICZfX2F1dG9fZXJycF9wcm9wLmxvY2FsX2VycjsgXA0K
Pj4+PiArfQ0KPj4+DQo+Pj4gTm90IHdyaXR0ZW4gdG8gdGFrZSBhIHRyYWlsaW5nIHNlbWljb2xv
biBpbiB0aGUgY2FsbGVyLg0KPj4+DQo+Pj4gWW91IGNvdWxkIGV2ZW4gc2V0IF9fYXV0b19lcnJw
X3Byb3AgdW5jb25kaXRpb25hbGx5IHJhdGhlciB0aGFuIHRyeWluZw0KPj4+IHRvIHJldXNlIGlu
Y29taW5nIGVycnAgKHRoZSBkaWZmZXJlbmNlIGJlaW5nIHRoYXQgZXJyb3JfcHJvcGFnYXRlKCkg
Z2V0cw0KPj4+IGNhbGxlZCBtb3JlIGZyZXF1ZW50bHkpLg0KPj4NCj4+IEkgdGhpbmsgdGhpcyBk
aWZmZXJlbmNlIGlzIGFjdHVhbGx5IGEgcHJvYmxlbS4NCj4+DQo+PiBXaGVuIGRlYnVnZ2luZyB0
aGluZ3MsIEkgaGF0ZSBlcnJvcl9wcm9wYWdhdGUoKS4gSXQgbWVhbnMgdGhhdCB0aGUgRXJyb3IN
Cj4+IChzcGVjaWZpY2FsbHkgaXRzIGZpZWxkcyBzcmMvZnVuYy9saW5lKSBwb2ludHMgdG8gdGhl
IG91dGVybW9zdA0KPj4gZXJyb3JfcHJvcGFnYXRlKCkgcmF0aGVyIHRoYW4gdGhlIHBsYWNlIHdo
ZXJlIHRoZSBlcnJvciByZWFsbHkgaGFwcGVuZWQuDQo+PiBJdCBhbHNvIG1ha2VzIGVycm9yX2Fi
b3J0IGNvbXBsZXRlbHkgdXNlbGVzcyBiZWNhdXNlIGF0IHRoZSBwb2ludCB3aGVyZQ0KPj4gdGhl
IHByb2Nlc3MgZ2V0cyBhYm9ydGVkLCB0aGUgaW50ZXJlc3RpbmcgaW5mb3JtYXRpb24gaXMgYWxy
ZWFkeSBsb3N0Lg0KPiANCj4gT2theSwgYmFzZWQgb24gdGhhdCwgSSBzZWUgdGhlIGZvbGxvd2lu
ZyBkZXNpcmFibGUgc2VtYW50aWNzOg0KPiANCj4gQ2FsbGVyOiBvbmUgb2YgNCBjYWxsaW5nIHBh
cmFkaWdtczoNCj4gDQo+IHBhc3MgZXJycD1OVUxMICh3ZSBkb24ndCBjYXJlIGFib3V0IGZhaWx1
cmVzKQ0KPiBwYXNzIGVycnA9JmVycm9yX2Fib3J0ICh3ZSB3YW50IHRvIGFib3J0KCkgYXMgc29v
biBhcyBwb3NzaWJsZSBhcyBjbG9zZQ0KPiB0byB0aGUgcmVhbCBwcm9ibGVtIGFzIHBvc3NpYmxl
KQ0KPiBwYXNzIGVycnA9JmVycm9yX2ZhdGFsICh3ZSB3YW50IHRvIGV4aXQoKSwgYnV0IG9ubHkg
YWZ0ZXIgY29sbGVjdGluZyBhcw0KPiBtdWNoIGluZm9ybWF0aW9uIGFzIHBvc3NpYmxlKQ0KPiBw
YXNzIGVycnAgPSBhbnl0aGluZyBlbHNlICh3ZSBhcmUgY29sbGVjdGluZyBhbiBlcnJvciBmb3Ig
b3RoZXIgcmVhc29ucywNCj4gd2UgbWF5IHJlcG9ydCBpdCBvciBsZXQgdGhlIGNhbGxlciBkZWNp
ZGUgb3IgLi4uKQ0KPiANCj4gQ2FsbGVlOiB3ZSB3YW50IGEgU0lOR0xFIHBhcmFkaWdtOg0KPiAN
Cj4gZnVuYyAoRXJyb3IgKiplcnJwKQ0KPiB7DQo+ICAgICAgTUFLRV9FUlJQX1NBRkUoKTsNCj4g
DQo+ICAgICAgbm93IHdlIGNhbiBwYXNzIGVycnAgdG8gYW55IGNoaWxkIGZ1bmN0aW9uLCB0ZXN0
ICcqZXJycCcsIG9yIGRvDQo+IGFueXRoaW5nIGVsc2UsIGFuZCB3ZSBET04nVCBoYXZlIHRvIGNh
bGwgZXJyb3JfcHJvcGFnYXRlLg0KPiANCj4gSSB0aGluayB0aGF0IG1lYW5zIHdlIG5lZWQ6DQo+
IA0KPiAjZGVmaW5lIE1BS0VfRVJSUF9TQUZFKCkgXA0KPiAgICBnX2F1dG8oLi4uKSBfX2F1dG9f
ZXJycCA9IHsgLmVycnAgPSBlcnJwIH07IFwNCj4gICAgZG8geyBcDQo+ICAgICAgaWYgKCFlcnJw
IHx8IGVycnAgPT0gJmVycm9yX2ZhdGFsKSB7IGVycnAgPSAmX19hdXRvX2VycnAubG9jYWw7IH0g
XA0KPiAgICB9IHdoaWxlICgwKQ0KPiANCj4gU28gYmFjayB0byB0aGUgY2FsbGVyIHNlbWFudGlj
czoNCj4gDQo+IGlmIHRoZSBjYWxsZXIgcGFzc2VkIE5VTEwsIHdlJ3ZlIHJlZGlyZWN0ZWQgZXJy
cCBsb2NhbGx5IHNvIHRoYXQgd2UgY2FuDQo+IHVzZSAqZXJycCBhdCB3aWxsOyB0aGUgYXV0by1j
bGVhbnVwIHdpbGwgZnJlZSBvdXIgbG9jYWwgZXJyb3IuDQo+IA0KPiBpZiB0aGUgY2FsbGVyIHBh
c3NlZCAmZXJyb3JfYWJvcnQsIHdlIGtlZXAgZXJycCB1bmNoYW5nZWQuICAqZXJycCB0ZXN0cw0K
PiB3aWxsIG5ldmVyIHRyaWdnZXIsIGJlY2F1c2Ugd2UnbGwgaGF2ZSBhbHJlYWR5IGFib3J0ZWQg
aW4gdGhlIGNoaWxkIG9uDQo+IHRoZSBvcmlnaW5hbCBlcnJwLCBnaXZpbmcgZGV2ZWxvcGVycyB0
aGUgYmVzdCBzdGFjayB0cmFjZS4NCj4gDQo+IGlmIHRoZSBjYWxsZXIgcGFzc2VkICZlcnJvcl9m
YXRhbCwgd2UgcmVkaXJlY3QgZXJycC4gIGF1dG8tY2xlYW51cCB3aWxsDQo+IHRoZW4gZXJyb3Jf
cHJvcGFnYXRlIHRoYXQgYmFjayB0byB0aGUgY2FsbGVyLCBwcm9kdWNpbmcgYXMgbXVjaCBuaWNl
DQo+IGluZm9ybWF0aW9uIGFzIHBvc3NpYmxlLg0KPiANCj4gaWYgdGhlIGNhbGxlciBwYXNzZWQg
YW55dGhpbmcgZWxzZSwgd2Uga2VlcCBlcnJwIHVuY2hhbmdlZCwgc28gbm8gZXh0cmENCj4gZXJy
b3JfcHJvcGFnYXRlIGluIHRoZSBtaXguDQo+IA0KPj4NCj4+IFNvIEknZCByZWFsbHkgbGlrZSB0
byByZXN0cmljdCB0aGUgdXNlIG9mIGVycm9yX3Byb3BhZ2F0ZSgpIHRvIHBsYWNlcw0KPj4gd2hl
cmUgaXQncyBhYnNvbHV0ZWx5IG5lY2Vzc2FyeS4gVW5sZXNzLCBvZiBjb3Vyc2UsIHlvdSBjYW4g
Zml4IHRoZXNlDQo+PiBwcmFjdGljYWwgcHJvYmxlbXMgdGhhdCBlcnJvcl9wcm9wYWdhdGUoKSBj
YXVzZXMgZm9yIGRlYnVnZ2luZy4NCj4+DQo+PiBJbiBmYWN0LCBpbiB0aGUgY29udGV4dCBvZiBH
cmVnJ3Mgc2VyaWVzLCBJIHRoaW5rIHdlIHJlYWxseSBvbmx5IG5lZWQgdG8NCj4+IHN1cHBvcnQg
aGludHMgZm9yIGVycm9yX2ZhdGFsLCB3aGljaCBhcmUgY2FzZXMgdGhhdCB1c2VycyBhcmUgc3Vw
cG9zZWQNCj4+IHRvIHNlZS4gV2Ugc2hvdWxkIGV4Y2x1ZGUgZXJyb3JfYWJvcnQgaW4gTUFLRV9F
UlJQX1NBRkUoKSBiZWNhdXNlIHRoZXNlDQo+PiBhcmUgdGhpbmdzIHRoYXQgYXJlIG5ldmVyIHN1
cHBvc2VkIHRvIGhhcHBlbi4gQSBnb29kIHN0YWNrIHRyYWNlIGlzIG1vcmUNCj4+IGltcG9ydGFu
dCB0aGVyZSB0aGFuIGFkZGluZyBhIGhpbnQgdG8gdGhlIG1lc3NhZ2UuDQo+IA0KPiBXZSBhbHNv
IHdhbnQgdG8gaGFuZGxlIHRoZSBjYWxsZXIgcGFzc2luZyBOVUxMLCBzbyB0aGF0IHdlIG5vIGxv
bmdlcg0KPiBoYXZlIHRvIGludHJvZHVjZSAnRXJyb3IgKmxvY2FsX2Vycm9yID0gTlVMTCcgZXZl
cnl3aGVyZS4NCj4gDQoNCldpdGggbXkgcGxhbiBvZiB0d28gZGlmZmVyZW50IG1hY3JvLCBJIGF0
IGxlYXN0IG1lc3NlZCB0aGUgY2FzZSB3aGVuIHdlIG5lZWQNCmJvdGggZGVyZWZlcmVuY2luZyBh
bmQgaGludHMsIHdoaWNoIG1lYW5zIHRoaXJkIG1hY3JvLCBvciBvbmUgbWFjcm8gd2l0aCBwYXJh
bWV0ZXJzLA0Kc2F5aW5nIHdoYXQgdG8gd3JhcC4NCg0KQW5kIG15IGFpbSB3YXMgdG8gZm9sbG93
IHRoZSBpZGVhIG9mICJkbyBwcm9wYWdhdGlvbiBvbmx5IGlmIGl0IHJlYWxseSBuZWNlc3Nhcnkg
aW4gdGhpcyBjYXNlIi4NCg0KQnV0IG1heSBiZSB5b3UgYXJlIHJpZ2h0LCBhbmQgd2Ugc2hvdWxk
bid0IGNhcmUgc28gbXVjaC4NCg0KMS4gV2hhdCBpcyBiYWQsIGlmIHdlIHdyYXAgTlVMTCwgd2hl
biB3ZSBvbmx5IHdhbnQgdG8gdXNlIGhpbnRzPw0KU2VlbXMgbm90aGluZy4gU29tZSBleHRyYSBh
Y3Rpb25zIG9uIGVycm9yIHBhdGgsIGJ1dCB3aG8gY2FyZXMgYWJvdXQgaXQ/DQoNCjIuIFdoYXQg
aXMgYmFkLCBpZiB3ZSB3cmFwIGVycm9yX2ZhdGFsLCB3aGVuIHdlIG9ubHkgd2FudCB0byBkZXJl
ZmVyZW5jZSwgYW5kIGRvbid0IHVzZSBoaW50cz8NClNlZW1zIG5vdGhpbmcgYWdhaW4sIG9uIGVy
cm9yIHBhdGggd2Ugd2lsbCByZXR1cm4gZnJvbSBoaWdoZXIgbGV2ZWwsIGFuZCBhIGJpdCBvZiBl
eHRyYSB3b3JrLCBidXQgbm90aGluZyB3b3JzZS4uDQoNClNvIEkgdGVuZCB0byBhZ3JlZS4gQnV0
IGhvbmVzdGx5LCBJIGRpZG4ndCB1bmRlcnN0YW5kIGZpcnN0IHBhcnQgb2YgS2V2aW4ncyBwYXJh
Z3JhcGggYWdhaW5zdCBwcm9wYWdhdGlvbiwNCnNvLCBtYXkgYmUgaGUgaGF2ZSBtb3JlIHJlYXNv
bnMgdG8gbWluaW1pemUgbnVtYmVyIG9mIGNhc2VzIHdoZW4gd2UgcHJvcGFnYXRlLg0KDQpUbyB0
aGUgc2FtZSB0b3BpYywgb2YgbWluaW1pemF0aW9uOiBzaG91bGQgd2UgYWx3YXlzIGNhbGwgTUFL
RV9FUlJQX1NBRkUgYXQgZnVuY3Rpb24gdG9wLCBvciBvbmx5DQppbiBibG9jaywgd2hlcmUgaXQg
aXMgbmVlZGVkIChhc3N1bWUsIHdlIGRlcmVmZXJlbmNlIGl0IG9ubHkgaW5zaWRlIHNvbWUgImlm
IiBvciAid2hpbGUiPw0KS2V2aW4sIGlzIHNvbWV0aGluZyBiYWQgaW4gcHJvcGFnYXRpb24sIHdo
ZW4gaXQgbm90IHJlbGF0ZWQgdG8gZXJyb3JfYWJvcnQ/DQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMs
DQpWbGFkaW1pcg0K

