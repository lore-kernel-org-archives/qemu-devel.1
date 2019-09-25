Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C23F8C432C1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 10:18:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C9C52082F
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 10:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="IIQqsc5L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C9C52082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD4NT-00052B-NC
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 06:18:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39277)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iD4Lv-0004B4-2u
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 06:16:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iD4Lt-00040M-Ld
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 06:16:54 -0400
Received: from mail-eopbgr40115.outbound.protection.outlook.com
 ([40.107.4.115]:57473 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iD4Lk-0003vq-96; Wed, 25 Sep 2019 06:16:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cWZf79napY2FPdpM/4YEw2P0nkNeM/eg8pCicbZIAYk4cafReeX/VnZtYrwaZnSRxddLY0UoVasoUzqGW/s/+fnpqpg4I+K4gLz7DDZKzzDBnWt2tQ5sGrQKk162cgVlNqCQUQnuSOeeY1NuD8s9Z9OZ5kTmWv+Lezt15X1AsOhWlpsGeSk2OC1E7l7+temCr6uMkhFxJc2jJok0gukPyxePzCHxU3CpIL7pQ2lW7FdV6K3i9P3cPB2fRw1OpTOpRLqpzkLF7VNhTYJaMRWShv8io2X70M4KKGrobFX7fRXl6VFNxx1hArchCgO5x66hUQWP0AXr0NDEsTL75FSJeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZkRSji/aOkbS0qNSLdMx/knP7Q+uLSKzIk9PHnFsNa8=;
 b=VxAA68vNe8u3m3Bzfyj//cU/KU+t4moyowkH2bku6hHWxTknQPxxwNBA0+CQt9GNnaPdm82aoToc2DY9Yqra582ngPQ4r1+FJ+q1vcG1bLlw3rHDuRruaZhePqKOMLiO0UJrzWSqZuWDe2QMBOa4b4OT0hbn3oRti545YArQ4EkT71P5f3fWAhY1OxcfJps/m1s6URDSJlxCK34VZCJ8bxgQbONC2sITgNa5aeG4zhxoB+Ll3KKWFuq5FcXsNHCA7I6BD6SUO4kHVLfcguRMHJ4zAlC5F/FQOE0TOaHxj1itwZhFr5lo19pS9hlexBJorIUI1Ztz1Pli5//G6irn4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZkRSji/aOkbS0qNSLdMx/knP7Q+uLSKzIk9PHnFsNa8=;
 b=IIQqsc5Lx6VjtCZotvkFGL0eYbA+7wsLgHbhq/n1OObDjqptrXkItmJdWSu0xlPSouYV/FM5wz65acNdKSE6p3kZAZtEQZ8AD2xg2YPnb7Vj1TmMlXJW6md8deXHr3Id7NWyjSSoV2/2T4x0nbXxm2XaxFEIOfcUSI6pxR5DguM=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5193.eurprd08.prod.outlook.com (10.255.17.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.23; Wed, 25 Sep 2019 10:16:41 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2284.023; Wed, 25 Sep 2019
 10:16:41 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v3 00/25] error: auto propagated local_err
Thread-Topic: [PATCH v3 00/25] error: auto propagated local_err
Thread-Index: AQHVcxQBJu4VoELFd0C+1xvxAySdg6c8LJYAgAAB2gA=
Date: Wed, 25 Sep 2019 10:16:41 +0000
Message-ID: <b7eda904-0ded-ab98-fbe2-e617b03ebcb3@virtuozzo.com>
References: <156940618778.4823.16859844052516018660@8230166b0665>
In-Reply-To: <156940618778.4823.16859844052516018660@8230166b0665>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P189CA0008.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::21)
 To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190925131630488
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 51de05af-0883-4e05-5b95-08d741a17548
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5193; 
x-ms-traffictypediagnostic: DB8PR08MB5193:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DB8PR08MB51933C8E8074588B82CC538BC1870@DB8PR08MB5193.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:758;
x-forefront-prvs: 01713B2841
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(39850400004)(376002)(346002)(396003)(136003)(199004)(189003)(66946007)(31686004)(5660300002)(2906002)(8936002)(81156014)(64756008)(66556008)(66476007)(6116002)(81166006)(386003)(3846002)(66446008)(8676002)(6506007)(66066001)(76176011)(54906003)(2501003)(86362001)(99286004)(52116002)(316002)(229853002)(31696002)(14454004)(966005)(11346002)(476003)(2616005)(4326008)(6246003)(26005)(2351001)(6512007)(446003)(486006)(186003)(36756003)(102836004)(6306002)(6436002)(5640700003)(478600001)(256004)(6916009)(7736002)(305945005)(7406005)(7416002)(25786009)(6486002)(71200400001)(71190400001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5193;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: W86pt8gcNxKH+OLv2DmZo5Fl9j1JBA1KOVWyM9duBr/EUYIt3wQAYfEToNIxfoTU1NCHtMSoSEi78YxyXFLCtDj2LbX480mjw5KN557K4nEYZ8dzG7rPWiWEVCf4sgIIuPKKzm3X32jJwdNiZM/p3b4HuyzsAHPKMTvFIVNDNHHMPyIE6oJIfIGXm+xnaQvbgZtacCYbSUljeVde8b6aTXYqQJ3kgoxR2vY1R0Bo132EhvPgijLAO9/XioGmBjSExb2T7S27pKw7pq+T+XYdIWUkvSHvOevZY5+KKsL2Zu3BtlagAIMJckc5/shn69sj0XQz1P86WpJtwzk52B9bZ0howWg1JBj0r0yOP39pAXHYtZ1jAM11aSVwiJtMCIy4pL4NW5ZxvakfVlrhjlRQf0Q4Tx3qDDY7os+HPKuE2cLVe/oP2O/X2foQB83dUYyC6RV09XsNEKL+DrbdIXRcpQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <FCCB8C445789DF4799F277D91254304A@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51de05af-0883-4e05-5b95-08d741a17548
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2019 10:16:41.1192 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6Vs0ZbxfwuvfVxSE129V1/I9oWxJhLrjdzsCvCf6WAlqC7nkDXbReOAN+q6ALLEiYzoK3vvsV4mBWxyhwmGyuWM7V5lKPK/DlovMdPbTU8o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5193
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.4.115
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
 "pburton@wavecomp.com" <pburton@wavecomp.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "codyprime@gmail.com" <codyprime@gmail.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "mark.cave-ayland@ilande.co.uk" <mark.cave-ayland@ilande.co.uk>,
 "mdroth@linux.vnet.ibm.com" <mdroth@linux.vnet.ibm.com>,
 "kraxel@redhat.com" <kraxel@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "quintela@redhat.com" <quintela@redhat.com>,
 "arikalo@wavecomp.com" <arikalo@wavecomp.com>,
 "mst@redhat.com" <mst@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "pasic@linux.ibm.com" <pasic@linux.ibm.com>,
 "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>,
 "farman@linux.ibm.com" <farman@linux.ibm.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>, "groug@kaod.org" <groug@kaod.org>,
 "yuval.shaia@oracle.com" <yuval.shaia@oracle.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "david@redhat.com" <david@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>,
 "kwolf@redhat.com" <kwolf@redhat.com>,
 "integration@gluster.org" <integration@gluster.org>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>,
 "sundeep.lkml@gmail.com" <sundeep.lkml@gmail.com>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjUuMDkuMjAxOSAxMzowOSwgbm8tcmVwbHlAcGF0Y2hldy5vcmcgd3JvdGU6DQo+IFBhdGNoZXcg
VVJMOiBodHRwczovL3BhdGNoZXcub3JnL1FFTVUvMjAxOTA5MjQyMDA5MDIuNDcwMy0xLXZzZW1l
bnRzb3ZAdmlydHVvenpvLmNvbS8NCj4gDQo+IA0KPiANCj4gSGksDQo+IA0KPiBUaGlzIHNlcmll
cyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJl
bG93IGZvcg0KPiBtb3JlIGluZm9ybWF0aW9uOg0KPiANCg0KWy4uXQ0KDQo+IA0KPiA9PT0gT1VU
UFVUIEJFR0lOID09PQ0KPiAxLzI1IENoZWNraW5nIGNvbW1pdCAyNDkzMDY5Yjc2MDMgKGVycnA6
IHJlbmFtZSBlcnJwIHRvIGVycnBfaW4gd2hlcmUgaXQgaXMgSU4tYXJndW1lbnQpDQo+IDIvMjUg
Q2hlY2tpbmcgY29tbWl0IDExOGY2MTc4NzI3OSAoaHcvY29yZS9sb2FkZXItZml0OiBmaXggZnJl
ZWluZyBlcnJwIGluIGZpdF9sb2FkX2ZkdCkNCj4gMy8yNSBDaGVja2luZyBjb21taXQgMWY1ZDk4
MzI4ZDZjIChuZXQvbmV0OiBmaXggbG9jYWwgdmFyaWFibGUgc2hhZG93aW5nIGluIG5ldF9jbGll
bnRfaW5pdCkNCj4gNC8yNSBDaGVja2luZyBjb21taXQgNGMzN2Q1YzZkMjI4IChlcnJvcjogYXV0
byBwcm9wYWdhdGVkIGxvY2FsX2VycikNCj4gRVJST1I6IE1hY3JvcyB3aXRoIG11bHRpcGxlIHN0
YXRlbWVudHMgc2hvdWxkIGJlIGVuY2xvc2VkIGluIGEgZG8gLSB3aGlsZSBsb29wDQoNCkluIGdl
bmVyYWwgLSB5ZXMuIEJ1dCB0aGlzIGlzIGEgdmVyeSBzcGVjaWFsIGNhc2UgYW5kIGl0IHdvcnRo
IGFuIGV4Y2VwdGlvbiBvZiB0aGUgcnVsZS4NCg0KPiAjNjk6IEZJTEU6IGluY2x1ZGUvcWFwaS9l
cnJvci5oOjM1NToNCj4gKyNkZWZpbmUgRVJSUF9GVU5DVElPTl9CRUdJTigpIFwNCj4gK2dfYXV0
byhFcnJvclByb3BhZ2F0b3IpIF9fYXV0b19lcnJwX3Byb3AgPSB7LmVycnAgPSBlcnJwfTsgXA0K
PiArZXJycCA9ICgoZXJycCA9PSBOVUxMIHx8ICplcnJwID09IGVycm9yX2ZhdGFsKSA/IFwNCj4g
KyAgICAmX19hdXRvX2VycnBfcHJvcC5sb2NhbF9lcnIgOiBlcnJwKQ0KPiANCj4gdG90YWw6IDEg
ZXJyb3JzLCAwIHdhcm5pbmdzLCA0MSBsaW5lcyBjaGVja2VkDQoNCg0KDQotLSANCkJlc3QgcmVn
YXJkcywNClZsYWRpbWlyDQo=

