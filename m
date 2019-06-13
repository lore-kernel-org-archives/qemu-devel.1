Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC1B5C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 10:02:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B4ED20B7C
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 10:02:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="c0dcZ7GW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B4ED20B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38142 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbMYz-00080r-R2
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 06:02:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55278)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hbMSQ-0002xW-EU
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 05:55:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hbMSO-0003dz-Co
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 05:55:46 -0400
Received: from mail-eopbgr150130.outbound.protection.outlook.com
 ([40.107.15.130]:59102 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hbMSG-0003Ze-Fj; Thu, 13 Jun 2019 05:55:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3hrlZyvY/LyZ7zo2/kkdg+HtexXbOyqpEmxshbt3/O4=;
 b=c0dcZ7GWK3EN8FOWhqD8mn6Fsa1n4VlZuH6meMY3RF7SqY7c2Do886qq+LD/pKaKkPny0JpkkE8UgfQAxw2d87zC2uO8/wRHqV7NrUZx513aQbgzVblGSWXwndBHUYHEO+xZ09q+90KATVPxvivBCvE7Ui8voEw6M2ztyG7v0FU=
Received: from AM0PR08MB3572.eurprd08.prod.outlook.com (20.177.110.153) by
 AM0PR08MB5490.eurprd08.prod.outlook.com (52.132.215.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Thu, 13 Jun 2019 09:55:33 +0000
Received: from AM0PR08MB3572.eurprd08.prod.outlook.com
 ([fe80::d064:530:c7:ad76]) by AM0PR08MB3572.eurprd08.prod.outlook.com
 ([fe80::d064:530:c7:ad76%6]) with mapi id 15.20.1987.012; Thu, 13 Jun 2019
 09:55:33 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v2 5/7] iotests: extend sleeping time under Valgrind
Thread-Index: AQHVIH/YNgMiF1PH+E+l4xoRVSfqsKaZW0aA
Date: Thu, 13 Jun 2019 09:55:33 +0000
Message-ID: <3dd8e998-0e84-c7b3-667c-ba6c332dc836@virtuozzo.com>
References: <1560276131-683243-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1560276131-683243-6-git-send-email-andrey.shinkevich@virtuozzo.com>
In-Reply-To: <1560276131-683243-6-git-send-email-andrey.shinkevich@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P195CA0008.EURP195.PROD.OUTLOOK.COM (2603:10a6:3:fd::18)
 To AM0PR08MB3572.eurprd08.prod.outlook.com
 (2603:10a6:208:e1::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190613125531045
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5d541c39-9e74-4c97-3566-08d6efe5466a
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:AM0PR08MB5490; 
x-ms-traffictypediagnostic: AM0PR08MB5490:
x-microsoft-antispam-prvs: <AM0PR08MB5490F399E0964A02657BD48EC1EF0@AM0PR08MB5490.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:158;
x-forefront-prvs: 0067A8BA2A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(366004)(396003)(376002)(39850400004)(346002)(189003)(199004)(31686004)(229853002)(71190400001)(4326008)(71200400001)(6246003)(14454004)(107886003)(2906002)(66446008)(64756008)(99286004)(73956011)(66556008)(66476007)(66946007)(446003)(11346002)(476003)(2616005)(486006)(53936002)(110136005)(68736007)(14444005)(256004)(2501003)(6486002)(31696002)(6116002)(3846002)(54906003)(6512007)(6436002)(2201001)(316002)(186003)(4744005)(36756003)(5660300002)(86362001)(102836004)(25786009)(478600001)(26005)(8676002)(81156014)(81166006)(8936002)(305945005)(7736002)(66066001)(386003)(6506007)(76176011)(52116002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB5490;
 H:AM0PR08MB3572.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NS2gApH1eo8rcPeTCxltQ0OLUtT/IbtO05KCbhXOPokeLslvwQemEOp5mKJvsak3HDJ2fFwmY2w/SY+XMtqCLJoJ7Ldt3yETXrJvAos/CGeaUcPOZ3NZ9wX4vDB5wnfcWwXAuGsp2qrNnC+SUD+fxB7GC7za/cbJdrYsxKUGEIh6DJByiXHo2UlgCmdix75XFJgY/6vCAje0CCt3RDT4wDTuz81yNg8GAHU5iXx8p8w1VrbGKiSgk3kADUVT0KRpVvzWiuOeTRqiMqEy8hm9lTkLyYH6P3LMNY9c00Fw+M4RmEsYUYXSPCvtZo2iEJA+23cAvtm+W1COBN4MOJOVi5GOmV39XN4x0fWFTiB55OBcdC3df0Fxi54OT4jx1wNfGzhAnrDNLChOPp+pcyS8VgfRRMaAchRh0jQZJHnReO0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DB83831EE9FA8E41B7084AFD3492928B@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d541c39-9e74-4c97-3566-08d6efe5466a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2019 09:55:33.0646 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5490
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.15.130
Subject: Re: [Qemu-devel] [PATCH v2 5/7] iotests: extend sleeping time under
 Valgrind
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Roman Kagan <rkagan@virtuozzo.com>,
 "berrange@redhat.com" <berrange@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTEuMDYuMjAxOSAyMTowMiwgQW5kcmV5IFNoaW5rZXZpY2ggd3JvdGU6DQo+IFRvIHN5bmNocm9u
aXplIHRoZSB0aW1lIHdoZW4gUUVNVSBpcyBydW5uaW5nIGxvbmdlciB1bmRlciB0aGUgVmFsZ3Jp
bmQsDQo+IGluY3JlYXNlIHRoZSBzbGVlcGluZyB0aW1lIGludCB0aGUgdGVzdCAyNDcuDQoNCmlu
IHRoZSB0ZXN0DQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFuZHJleSBTaGlua2V2aWNoIDxhbmRy
ZXkuc2hpbmtldmljaEB2aXJ0dW96em8uY29tPg0KDQpSZXZpZXdlZC1ieTogVmxhZGltaXIgU2Vt
ZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPg0KDQo+IC0tLQ0KPiAg
IHRlc3RzL3FlbXUtaW90ZXN0cy8yNDcgfCA2ICsrKysrLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA1
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS90ZXN0cy9x
ZW11LWlvdGVzdHMvMjQ3IGIvdGVzdHMvcWVtdS1pb3Rlc3RzLzI0Nw0KPiBpbmRleCA1NDZhNzk0
Li4xMDM2YTE3IDEwMDc1NQ0KPiAtLS0gYS90ZXN0cy9xZW11LWlvdGVzdHMvMjQ3DQo+ICsrKyBi
L3Rlc3RzL3FlbXUtaW90ZXN0cy8yNDcNCj4gQEAgLTU3LDcgKzU3LDExIEBAIFRFU1RfSU1HPSIk
VEVTVF9JTUcuNCIgX21ha2VfdGVzdF9pbWcgJHNpemUNCj4gICB7ImV4ZWN1dGUiOiJibG9jay1j
b21taXQiLA0KPiAgICAiYXJndW1lbnRzIjp7ImRldmljZSI6ImZvcm1hdC00IiwgInRvcC1ub2Rl
IjogImZvcm1hdC0yIiwgImJhc2Utbm9kZSI6ImZvcm1hdC0wIiwgImpvYi1pZCI6ImpvYjAifX0N
Cj4gICBFT0YNCj4gLXNsZWVwIDENCj4gK2lmIFsgIiR7VkFMR1JJTkRfUUVNVX0iID09ICJ5IiBd
OyB0aGVuDQo+ICsgICAgc2xlZXAgNQ0KPiArZWxzZQ0KPiArICAgIHNsZWVwIDENCj4gK2ZpDQo+
ICAgZWNobyAneyJleGVjdXRlIjoicXVpdCJ9Jw0KPiAgICkgfCAkUUVNVSAtcW1wIHN0ZGlvIC1u
b2dyYXBoaWMgLW5vZGVmYXVsdHMgXA0KPiAgICAgICAtYmxvY2tkZXYgZmlsZSxub2RlLW5hbWU9
ZmlsZS0wLGZpbGVuYW1lPSRURVNUX0lNRy4wLGF1dG8tcmVhZC1vbmx5PW9uIFwNCj4gDQoNCg0K
LS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

