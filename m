Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF3FC3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 09:18:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45FA02339E
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 09:18:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="hsXN5+TJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45FA02339E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3GZR-0001kK-WD
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 05:18:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35791)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i3GYh-0001L3-8u
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 05:17:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i3GYg-0000Xh-9i
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 05:17:35 -0400
Received: from mail-eopbgr70122.outbound.protection.outlook.com
 ([40.107.7.122]:49360 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1i3GYf-0000X0-MT; Thu, 29 Aug 2019 05:17:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AuvJrp535GO4pGmHZKdnkhQI7ONXn1BRn5vN7TnS1UWlFxeX3JvfUhfPqhHSD/wY1MwWwsLSU87nJ4oC7cDr2s3KLIgQUjphcr0FydLghffZglYz0PzpIJg4jJC4sQPoUW6Y+R12CsC0eV2cVHnUqWCqWVH598lV9KAAz26oZ2kD61kOpB2SReeeg5RBLRfK83D1QtjZS2MlNr19qJQYJVp8n6PUogM3KA0stPhsLCQ1w8ly5WvFIrQPAAQpNrD+OgkxCgu7Ve5Mtc2vPj1Mh5CeJ2rMH5KmocijTUVDHWmPwkjLT3wmiSXNbc6ccCIsx/FvB+z/aJ9QIESPmDFaWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/rDrkoU/h4QxU6XUjkHKFraJSie4V+TPP/0eyamf9C8=;
 b=B9n0J/NJCn3iNkeSUgpImR1q5HftEpodSNx1ynhJfihxsZWYadOINYeydhYS9Via2kBS7KZxoXwDqB79wX97TXZa7nPPfIpJcVwjT29/pqfKFek9fHXmpyWZN/SzcvXaKLb8/oMq+QncYy1ySxqroje1q3OgarVDMe82+lr2Vsf8/jwBiES62Vr7rs5YORNiL6tYlyQGaWkg0FUNS3Sj76lalI8jE1uXFqygCpga6XJNlTkahpA2oIdVVHOfflv3jhHAVJ335IFQF616aDFjB7n0ID72/Ziz1ADC2/dC76uD9jC86VYpNuYWz9e7U8eAqaZCzmrzkQL4PoLJFvVE9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/rDrkoU/h4QxU6XUjkHKFraJSie4V+TPP/0eyamf9C8=;
 b=hsXN5+TJGMF6jFK0aFxRFs5UcgxcC2KGC0UMEOPP3ZA8WhAMldmX6z2GiDTuVDm7NzL0vEw39gFpkNzDzYgXgjvgOVnqHp0zDRRLzG4mAmpCal+IVqHNhzES1R8oOmp6nx9D6DsrrOjj5JHM4520VTZc/q/SmIncKc8E7A/H4VE=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4123.eurprd08.prod.outlook.com (20.179.12.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.16; Thu, 29 Aug 2019 09:17:30 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2199.021; Thu, 29 Aug 2019
 09:17:30 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v9 11/13] block: add lock/unlock range functions
Thread-Index: AQHVXCkyY7XU6YKMu0eVL2XIpif+kKcQzGIAgAEQcwA=
Date: Thu, 29 Aug 2019 09:17:30 +0000
Message-ID: <159bca65-a3a6-716d-82c3-acfc8540124d@virtuozzo.com>
References: <20190826161312.489398-1-vsementsov@virtuozzo.com>
 <20190826161312.489398-12-vsementsov@virtuozzo.com>
 <3e24d3d4-d5f0-b187-fa2d-021afeec098d@redhat.com>
In-Reply-To: <3e24d3d4-d5f0-b187-fa2d-021afeec098d@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR07CA0028.eurprd07.prod.outlook.com
 (2603:10a6:7:66::14) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190829121727970
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7f8d7767-44a1-47f1-e7e4-08d72c61b7cc
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB4123; 
x-ms-traffictypediagnostic: DB8PR08MB4123:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB412323CF6DB3F15CFF8B2CD5C1A20@DB8PR08MB4123.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:792;
x-forefront-prvs: 0144B30E41
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(366004)(39850400004)(136003)(346002)(396003)(199004)(189003)(110136005)(6246003)(71200400001)(86362001)(107886003)(8676002)(256004)(81156014)(53936002)(81166006)(2616005)(6116002)(14444005)(3846002)(8936002)(36756003)(71190400001)(11346002)(66066001)(4326008)(476003)(446003)(486006)(31696002)(5660300002)(25786009)(186003)(229853002)(4744005)(14454004)(99286004)(66446008)(7736002)(76176011)(53546011)(6506007)(386003)(6486002)(52116002)(2501003)(478600001)(102836004)(31686004)(7416002)(66946007)(2906002)(66556008)(6512007)(64756008)(26005)(6436002)(305945005)(66476007)(316002)(54906003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4123;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5jA0xe7BWGdXYT31aDaNkemYJ0brnQ8Z3v6LESKM+9bB0b2XQny7U8CDwofh5YYUpOwpGaCaupDqpKLWWY3SRqt6bYPdfGFAOEDwcpChb7eH1K5RNZmaXDrwZi6YyN3f7LMc6YLSdRzu3+sEo9Yy+j8WFtCnLXNmhZqKBVZAzaJdLUsI8KSMeCoxWKrWGga9J7755KK0uebEfXe1AlyMWBemwAjmc8cDduIN7u3HP1w+eh0vbEx+oBlLZFCXZzv20DLd3UB5iOzzfH+OWLjk1wQ+b0QZheNolL7RaLlAraoqq3AMHRm/L7R7noZ/1JVSxGXooT4gi+uNf3Xcq4V6h90JF55JNiYXPvT7y+xLqdbAqX3hHNRkpDgsa/Q+CZGhMwXBRU2Exo/TKhlUQR28GcAZaAFWtcoavFuxApQXPsg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B072AAFBCD84EC40ACA10A09010DD7EC@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f8d7767-44a1-47f1-e7e4-08d72c61b7cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2019 09:17:30.5595 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fRNogRfjRJissNa9Phoazvqqo2jRUvG6YekQO64Dio/r+/+fxSG1JxSP/v3Y7zPHVktZy/KJVa6YvLtbRIDdH1gb7Izd5oEsozHBGQdDFUU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4123
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.122
Subject: Re: [Qemu-devel] [PATCH v9 11/13] block: add lock/unlock range
 functions
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
Cc: "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
 Denis Lunev <den@virtuozzo.com>,
 "wencongyang2@huawei.com" <wencongyang2@huawei.com>,
 "xiechanglong.d@gmail.com" <xiechanglong.d@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjguMDguMjAxOSAyMDowMiwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAyNi4wOC4xOSAxODoxMywg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IEZyb206IFZsYWRpbWlyIFNl
bWVudHNvdi1PZ2lldnNraXkgPGV0ZW5kcmVuQGdtYWlsLmNvbT4NCj4gDQo+IEhtLiA6LSkNCj4g
DQo+IERvIHlvdSB3YW50IHRvIGZpeCB0aGF0Pw0KDQpZZXMuLiBIbW0gc2VlbXMgbGlrZSBJIHdh
cyB3b3JraW5nIGZyb20gaG9tZSBhdCBzb21lIG1vbWVudA0KDQo+IA0KPj4gSW50cm9kdWNlIGxv
Y2svdW5sb2NrIHJhbmdlIGZ1bmN0aW9uYWxpdHksIGJhc2VkIG9uIHNlcmlhbGl6ZWQNCj4+IHJl
cXVlc3RzLiBUaGlzIGlzIG5lZWRlZCB0byByZWZhY3RvciBiYWNrdXAsIGRyb3BwaW5nIGxvY2Fs
DQo+PiB0cmFja2VkLXJlcXVlc3QtbGlrZSBzeW5jaHJvbml6YXRpb24uDQo+Pg0KPj4gU2lnbmVk
LW9mZi1ieTogVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSA8ZXRlbmRyZW5AZ21haWwuY29t
Pg0KPj4gLS0tDQo+PiAgIGluY2x1ZGUvYmxvY2svYmxvY2tfaW50LmggfCAgNCArKysrDQo+PiAg
IGJsb2NrL2lvLmMgICAgICAgICAgICAgICAgfCA0NCArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKy0NCj4+ICAgMiBmaWxlcyBjaGFuZ2VkLCA0NyBpbnNlcnRpb25zKCspLCAx
IGRlbGV0aW9uKC0pDQo+IA0KPiBBcGFydCBmcm9tIHRoYXQsIEkgY2Fu4oCZdCBzZWUgYW55IGNo
YW5nZXMgZnJvbSB2OCwgc286DQo+IA0KPiBSZXZpZXdlZC1ieTogTWF4IFJlaXR6IDxtcmVpdHpA
cmVkaGF0LmNvbT4NCj4gDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

