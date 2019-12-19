Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36521C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 08:23:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECE6321D7D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 08:23:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="eRAeZviv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECE6321D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihr5l-0005ID-4E
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 03:23:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59056)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ihr50-0004mx-2z
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 03:22:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ihr4z-0003Vj-0N
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 03:22:41 -0500
Received: from mail-eopbgr40091.outbound.protection.outlook.com
 ([40.107.4.91]:50518 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1ihr4u-0002sg-TZ; Thu, 19 Dec 2019 03:22:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K1XGYvXWS4goTBOHG6f19HxoWvEpJluro5ztmGPuuefMbC+HP496Isa8QN24+WXcsD69OhV9QSBYHCA471nROC0wE0kj6niaNuEPsBcls59Gxu6/2qd28pMRv04pqCSxh8Ogeo25Hm1k+p0e1mvyO4LsFQ7X+6tcw0eTF/ESWWa05iVX+GuFwMM54kTWXmnY40vO6FIRsNsXOJ2zJ/Z6FGa9j3jYr2/Jgp3PgjoHaxCShQIu8rGX90+be7kCvnJ2aIEL/9b/TB3Xb74pjINSdSJWfZymx1yI6bxsmljG9fQ93fEWzo+68VuQBPKQsFyG10lo+gOXdujWcVCQ39dd4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dh/Yp2B0YMcAcEoWoExO5neper65RzO017nQGwb5qlk=;
 b=QAgMNQ9Q5lrP8O6s/HtGKfoyeMK/g1wRgVcpDCKH4VP/tpdL5nKWWQnv566spMzPz/r5cPqjGVbzdLAi4XXKlJ/EW5M8TO1+xhmD7a1JsNdI7XMOM6DoJqpfLjo1uMQ5cJp59bdQpTyM8PqyI9KA6Udb+IagwQo4wKOao3QKaCROalvwSWhF47ejTpYSJd2iGIkb1EH0zZJzBhC1RRU3ikcnbCSojAozQprDw7wvj5X6bXNMV4Yp6S4Jyfeg1liuB6alKh8cfen5Z1r+7i65sEWoRzgv66wXfhRK06rZQTkvr6pz2G5hyAGEkV955RXXOZXe9z+GyHDDUYlANqR9gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dh/Yp2B0YMcAcEoWoExO5neper65RzO017nQGwb5qlk=;
 b=eRAeZviv+XqvB1bcCchBcQ+AMKvqCWTqOVKYJseAsQVg/MY0j8MtqDAjSS/CiEw6R1QW4d67xQHLy9ZsJpDZGBJJfilALSkPueJ5nJe1stBF96cWOGi7KRYZk9FSiCmqtCc7dIkGBYbbyASvafCFwb7/fcf92/9vQWb2dU2F7P0=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3720.eurprd08.prod.outlook.com (20.178.91.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Thu, 19 Dec 2019 08:22:25 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2559.012; Thu, 19 Dec 2019
 08:22:24 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH for-5.0 v2 0/3] benchmark util
Thread-Topic: [PATCH for-5.0 v2 0/3] benchmark util
Thread-Index: AQHVpHEG5YfDz7UI8UOBrTTRR2csGafBQfyA
Date: Thu, 19 Dec 2019 08:22:24 +0000
Message-ID: <cb0afaa9-1fbc-2bee-7a55-e58a554c6908@virtuozzo.com>
References: <20191126154848.193407-1-vsementsov@virtuozzo.com>
In-Reply-To: <20191126154848.193407-1-vsementsov@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0155.eurprd05.prod.outlook.com
 (2603:10a6:7:28::42) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191219112221601
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 085f6d12-23e3-4362-df08-08d7845c9358
x-ms-traffictypediagnostic: AM6PR08MB3720:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR08MB37209A7BE19D7A6C3D9131ABC1520@AM6PR08MB3720.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 0256C18696
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39850400004)(366004)(136003)(346002)(376002)(396003)(199004)(189003)(53754006)(6486002)(66946007)(316002)(6506007)(31686004)(54906003)(71200400001)(66446008)(66556008)(64756008)(110136005)(6512007)(4326008)(36756003)(2906002)(186003)(66476007)(2616005)(5660300002)(26005)(86362001)(81166006)(81156014)(8676002)(52116002)(478600001)(31696002)(8936002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3720;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0pd+POilpg3aAXj0gTDigvAnkI6KBbTqx19b7jJHpIZ+HHXbX8XlcoK1PtjR/URL5uCbR+QoVqVVFRf8t2UZMm1dXFuZktrfdiJJvrFM98sL0e5wKwC6J7ypV4VkBHf20k3k4Zq3aDmW5lFggOC7DORl8jYvfrSIOV5A1XpLX2aPNID0tM4XKEQIwUTpFZTxk+glz+JU8rHWMxww795qN87qHyzYfnc6cOomuqq0lVKT0uxB6zFS3WqLL18lJ9hRzASmoopQSQ8+SwhCUeA+yLoM0iXfMScwG1jx1IGtuTs7txrVdsXDeguBJj9uHsHu/DsCa+pgdbX1ZdGmvw9go1ZcGfecAwnweHxYmxTNMWdwMp0W2qRes+/Gos4XS771KeCYM5DUm+d8MdEf5GYzQuYjbTyoWzStIq9U1zgE5uamO6K3aFhbgjNkDI6v5OPNS/ZaRP5g2goI03BL2nHZMTK+fjWXImIu7GXkhjTIUL7nymQkNR2+pbF1s2m8hGxM
Content-Type: text/plain; charset="utf-8"
Content-ID: <514DECF6C7ADEA49BEFE013060D83271@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 085f6d12-23e3-4362-df08-08d7845c9358
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2019 08:22:24.5903 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hBKutfnnfTX0kmpLq4Jlvl/Q1yZnH1HtZHKQ8jxbLgLM34IHJMUY/ViVHsh+o0g0W1gqXtC83UoDMYN3VtB2cRXWuneKU95wzvy/rmEo0Uo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3720
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.4.91
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
 "stefanha@gmail.com" <stefanha@gmail.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>, "crosa@redhat.com" <crosa@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

cGluZw0KDQoyNi4xMS4yMDE5IDE4OjQ4LCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdy
b3RlOg0KPiBIaSBhbGwhDQo+IA0KPiBIZXJlIGlzIHNpbXBsZSBiZW5jaG1hcmtpbmcgdXRpbGl0
eSwgdG8gZ2VuZXJhdGUgcGVyZm9ybWFuY2UNCj4gY29tcGFyaXNvbiB0YWJsZXMsIGxpa2UgdGhl
IGZvbGxvd2luZzoNCj4gDQo+IC0tLS0tLS0tLS0gIC0tLS0tLS0tLS0tLS0gIC0tLS0tLS0tLS0t
LS0gIC0tLS0tLS0tLS0tLS0NCj4gICAgICAgICAgICAgIGJhY2t1cC0xICAgICAgIGJhY2t1cC0y
ICAgICAgIG1pcnJvcg0KPiBzc2QgLT4gc3NkICAwLjQzICstIDAuMDAgICA0LjQ4ICstIDAuMDYg
ICA0LjM4ICstIDAuMDINCj4gc3NkIC0+IGhkZCAgMTAuNjAgKy0gMC4wOCAgMTAuNjkgKy0gMC4x
OCAgMTAuNTcgKy0gMC4wNQ0KPiBzc2QgLT4gbmJkICAzMy44MSArLSAwLjM3ICAxMC42NyArLSAw
LjE3ICAxMC4wNyArLSAwLjA3DQo+IC0tLS0tLS0tLS0gIC0tLS0tLS0tLS0tLS0gIC0tLS0tLS0t
LS0tLS0gIC0tLS0tLS0tLS0tLS0NCj4gDQo+IFRoaXMgaXMgYSB2MiwgYXMgdjEgd2FzIGluc2lk
ZQ0KPiAgICJbUkZDIDAwLzI0XSBiYWNrdXAgcGVyZm9ybWFuY2U6IGJsb2NrX3N0YXR1cyArIGFz
eW5jIg0KPiANCj4gSSdsbCB1c2UgdGhpcyBiZW5jaG1hcmsgaW4gb3RoZXIgc2VyaWVzLCBob3Bl
IHNvbWVvbmUNCj4gd2lsbCBsaWtlIGl0Lg0KPiANCj4gVmxhZGltaXIgU2VtZW50c292LU9naWV2
c2tpeSAoMyk6DQo+ICAgIHB5dGhvbjogYWRkIHNpbXBsZWJlbmNoLnB5DQo+ICAgIHB5dGhvbjog
YWRkIHFlbXUvYmVuY2hfYmxvY2tfam9iLnB5DQo+ICAgIHB5dGhvbjogYWRkIGV4YW1wbGUgdXNh
Z2Ugb2Ygc2ltcGxlYmVuY2gNCj4gDQo+ICAgcHl0aG9uL2JlbmNoLWV4YW1wbGUucHkgICAgICAg
IHwgIDgwICsrKysrKysrKysrKysrKysrKysrKw0KPiAgIHB5dGhvbi9xZW11L2JlbmNoX2Jsb2Nr
X2pvYi5weSB8IDExNSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAgIHB5dGhvbi9z
aW1wbGViZW5jaC5weSAgICAgICAgICB8IDEyOCArKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysNCj4gICAzIGZpbGVzIGNoYW5nZWQsIDMyMyBpbnNlcnRpb25zKCspDQo+ICAgY3JlYXRl
IG1vZGUgMTAwNjQ0IHB5dGhvbi9iZW5jaC1leGFtcGxlLnB5DQo+ICAgY3JlYXRlIG1vZGUgMTAw
NzU1IHB5dGhvbi9xZW11L2JlbmNoX2Jsb2NrX2pvYi5weQ0KPiAgIGNyZWF0ZSBtb2RlIDEwMDY0
NCBweXRob24vc2ltcGxlYmVuY2gucHkNCj4gDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFk
aW1pcg0K

