Return-Path: <SRS0=eB96=XC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5195EC43331
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2019 14:20:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16A2320854
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2019 14:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ReqzaHg4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16A2320854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6bZn-0002ms-5B
	for qemu-devel@archiver.kernel.org; Sat, 07 Sep 2019 10:20:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55795)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i6bZ5-0002Jf-FC
 for qemu-devel@nongnu.org; Sat, 07 Sep 2019 10:19:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i6bZ3-0005w1-5z
 for qemu-devel@nongnu.org; Sat, 07 Sep 2019 10:19:46 -0400
Received: from mail-eopbgr70125.outbound.protection.outlook.com
 ([40.107.7.125]:30484 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1i6bZ2-0005uw-EM; Sat, 07 Sep 2019 10:19:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N9bZyEqh234BL+mlU98hI042YRuFqcbJAKLdqXUaXCu4TkT7/igzKKDBKt8pcnkbmim8qppfRj9kZGZVvO9plU29k/cunYcE+xiNy6uRH487sQ8uOU9g4dIaGeNzjhxC+KRzLb3sDv8C95CWb5t4VuT5Xw4vL+M8YyGN/jQ8uu8vZIbCDv/+5Ayu/fPkQzvrFDrV5s4ZwYHlx32FVlUDI/byvn15D7o/pmrPzrt9x50Rs4KLJMQULHRdKZGOsZKCH8aR8XXtlZrx0CXQ3yqpeC/LE7Qa6wEfRukozeeu6pXZkpvyYYrRc257GCCuJZ/AD71Yb0mlbO4ZLnyj09lKiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ns1GL9wqFKZ+5OBNYqaeQDFYOSjq7ZlO8CfsPoyTOlc=;
 b=i3+GNOBfVqdNDD126FhQV32fzQOX1jfAn/pYD3+ujQxo9VlEdm5NUyeG10dFbb1QgQzP7NM3GFDeDV62ygMDfKhXIY9ir5Hu6auoaxBTyztnxobEvpxIFVZiaB0PGC1UH5sg5a6wpmEfVfZ/KGtkVsmUpC75H3VzovTha9CPx09NPioOqo3hzX2E9fSupp70+pyIyzfcxD7LG0nKWMA73LyoreolcLSTW0sLOLFProsqivwG81HguJTDu8pPVhIWKDO2CmdMijPoo6FJewjmqRv9Dzv7Kpupj9GKafAd3YrpLf5uSfWqKLt21cbEnTnZ/YrVHRcZn7a23JhuRxiXzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ns1GL9wqFKZ+5OBNYqaeQDFYOSjq7ZlO8CfsPoyTOlc=;
 b=ReqzaHg4LygQgfdWZQBk7AufBVgi0IZgjZBRNGyTQ/vq6NuAGuDYv9bMR4ZuNOmy1I9o24UsS4lncma0YK7QRidrdfQ27dFCRDMQ7m2ximh7RhkU7DvGLa0N3w/DCCnt+3xIHjwweV1Qv7+gAbZVREZHSGgbdrmbweQ1ViyKrgM=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5033.eurprd08.prod.outlook.com (10.255.17.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.18; Sat, 7 Sep 2019 14:19:40 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2241.018; Sat, 7 Sep 2019
 14:19:40 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v9 7/9] scsi: account unmap operations
Thread-Index: AQHVZMxkNKVirPa/U06qys1d6S2sy6cgRPWA
Date: Sat, 7 Sep 2019 14:19:40 +0000
Message-ID: <67c6db2c-7cb9-36a2-3e59-b69175dfa63a@virtuozzo.com>
References: <20190906160120.70239-1-anton.nefedov@virtuozzo.com>
 <20190906160120.70239-8-anton.nefedov@virtuozzo.com>
In-Reply-To: <20190906160120.70239-8-anton.nefedov@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0101CA0014.eurprd01.prod.exchangelabs.com
 (2603:10a6:3:77::24) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190907171937360
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a75e063c-331e-4539-0476-08d7339e6b92
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5033; 
x-ms-traffictypediagnostic: DB8PR08MB5033:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB5033917BAD715E5E736DB15BC1B50@DB8PR08MB5033.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:40;
x-forefront-prvs: 0153A8321A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(39840400004)(346002)(366004)(136003)(376002)(189003)(199004)(8936002)(36756003)(2501003)(86362001)(31686004)(66066001)(31696002)(64756008)(66946007)(66476007)(66556008)(66446008)(5660300002)(14444005)(4326008)(2616005)(6116002)(386003)(316002)(81156014)(6436002)(52116002)(6506007)(102836004)(54906003)(11346002)(446003)(26005)(229853002)(76176011)(6486002)(25786009)(256004)(7736002)(53936002)(71200400001)(71190400001)(99286004)(2906002)(186003)(305945005)(81166006)(14454004)(6512007)(6246003)(110136005)(8676002)(486006)(478600001)(3846002)(476003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5033;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: WrbVJ8jqydWcSGFNgN1qpdWQ/s3htUTf9iXMifa/jRhZKQwfYO3hztDZW6xBLv1yQ4HVUtq8uzK4QSUPTKhy1IYCEWzjMy+R6qW8iZeVzv3muS0VPygSQGKxHie9vV+4LMn4a8MhLLurBj+KgCcIG57raZGRHBqmf5hNIvOLptfdugq6CSRG/PH9vi0E+3vpL+dkSkdNUwhTd/uGSJ52IrTpoveT48DtqT6O2dVMac/U2fMEFEAYpbm9rQhDEEZkbvhf3kXI8w1NaTnSJJyxT41C3yS3XrxtO6dOeubgvPlcgdugG9lmgNcWp0LKqWbMKcHJ1LHPQMWdaqZV5sF2YDuBgy4ywsL5Kc8nTV4eVTCW5VEuUN1BvkNdGEcXfFvIi7nloa0vilz86wHevMGkiAiAHQkC0s31yVUojodKOPA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FD9003986B819F48BE76A786CB37FD4B@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a75e063c-331e-4539-0476-08d7339e6b92
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2019 14:19:40.0856 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6DuJxgy7v+1CIE2GVy+VQ+C8Cg3+UEqFxTJr3jkE2wb0SuonpaXpmeVSo4uwVlTctJb0gRyC30Rr0yoS83VSuGsZjtHOI5CXH1a56a6QNIA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5033
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.125
Subject: Re: [Qemu-devel] [PATCH v9 7/9] scsi: account unmap operations
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
 "berto@igalia.com" <berto@igalia.com>, Denis Lunev <den@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDYuMDkuMjAxOSAxOTowMSwgQW50b24gTmVmZWRvdiB3cm90ZToNCj4gU2lnbmVkLW9mZi1ieTog
QW50b24gTmVmZWRvdiA8YW50b24ubmVmZWRvdkB2aXJ0dW96em8uY29tPg0KDQpSZXZpZXdlZC1i
eTogVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8uY29t
Pg0KDQo+IC0tLQ0KPiAgIGh3L3Njc2kvc2NzaS1kaXNrLmMgfCAxMiArKysrKysrKysrKy0NCj4g
ICAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL2h3L3Njc2kvc2NzaS1kaXNrLmMgYi9ody9zY3NpL3Njc2ktZGlzay5jDQo+
IGluZGV4IGEwMDJmZGFiZTguLjY4YjE2NzVmZDkgMTAwNjQ0DQo+IC0tLSBhL2h3L3Njc2kvc2Nz
aS1kaXNrLmMNCj4gKysrIGIvaHcvc2NzaS9zY3NpLWRpc2suYw0KPiBAQCAtMTYxNywxMCArMTYx
NywxNiBAQCBzdGF0aWMgdm9pZCBzY3NpX3VubWFwX2NvbXBsZXRlX25vaW8oVW5tYXBDQkRhdGEg
KmRhdGEsIGludCByZXQpDQo+ICAgICAgICAgICByLT5zZWN0b3JfY291bnQgPSAobGRsX2JlX3Ao
JmRhdGEtPmluYnVmWzhdKSAmIDB4ZmZmZmZmZmZVTEwpDQo+ICAgICAgICAgICAgICAgKiAocy0+
cWRldi5ibG9ja3NpemUgLyBCRFJWX1NFQ1RPUl9TSVpFKTsNCj4gICAgICAgICAgIGlmICghY2hl
Y2tfbGJhX3JhbmdlKHMsIHItPnNlY3Rvciwgci0+c2VjdG9yX2NvdW50KSkgew0KPiArICAgICAg
ICAgICAgYmxvY2tfYWNjdF9pbnZhbGlkKGJsa19nZXRfc3RhdHMocy0+cWRldi5jb25mLmJsayks
DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQkxPQ0tfQUNDVF9VTk1BUCk7DQo+
ICAgICAgICAgICAgICAgc2NzaV9jaGVja19jb25kaXRpb24ociwgU0VOU0VfQ09ERShMQkFfT1VU
X09GX1JBTkdFKSk7DQo+ICAgICAgICAgICAgICAgZ290byBkb25lOw0KPiAgICAgICAgICAgfQ0K
PiAgIA0KPiArICAgICAgICBibG9ja19hY2N0X3N0YXJ0KGJsa19nZXRfc3RhdHMocy0+cWRldi5j
b25mLmJsayksICZyLT5hY2N0LA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgIHItPnNlY3Rv
cl9jb3VudCAqIEJEUlZfU0VDVE9SX1NJWkUsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
QkxPQ0tfQUNDVF9VTk1BUCk7DQo+ICsNCj4gICAgICAgICAgIHItPnJlcS5haW9jYiA9IGJsa19h
aW9fcGRpc2NhcmQocy0+cWRldi5jb25mLmJsaywNCj4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgci0+c2VjdG9yICogQkRSVl9TRUNUT1JfU0laRSwNCj4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgci0+c2VjdG9yX2NvdW50ICogQkRS
Vl9TRUNUT1JfU0laRSwNCj4gQEAgLTE2NDcsMTAgKzE2NTMsMTEgQEAgc3RhdGljIHZvaWQgc2Nz
aV91bm1hcF9jb21wbGV0ZSh2b2lkICpvcGFxdWUsIGludCByZXQpDQo+ICAgICAgIHItPnJlcS5h
aW9jYiA9IE5VTEw7DQo+ICAgDQo+ICAgICAgIGFpb19jb250ZXh0X2FjcXVpcmUoYmxrX2dldF9h
aW9fY29udGV4dChzLT5xZGV2LmNvbmYuYmxrKSk7DQo+IC0gICAgaWYgKHNjc2lfZGlza19yZXFf
Y2hlY2tfZXJyb3IociwgcmV0LCBmYWxzZSkpIHsNCj4gKyAgICBpZiAoc2NzaV9kaXNrX3JlcV9j
aGVja19lcnJvcihyLCByZXQsIHRydWUpKSB7DQo+ICAgICAgICAgICBzY3NpX3JlcV91bnJlZigm
ci0+cmVxKTsNCj4gICAgICAgICAgIGdfZnJlZShkYXRhKTsNCj4gICAgICAgfSBlbHNlIHsNCj4g
KyAgICAgICAgYmxvY2tfYWNjdF9kb25lKGJsa19nZXRfc3RhdHMocy0+cWRldi5jb25mLmJsayks
ICZyLT5hY2N0KTsNCj4gICAgICAgICAgIHNjc2lfdW5tYXBfY29tcGxldGVfbm9pbyhkYXRhLCBy
ZXQpOw0KPiAgICAgICB9DQo+ICAgICAgIGFpb19jb250ZXh0X3JlbGVhc2UoYmxrX2dldF9haW9f
Y29udGV4dChzLT5xZGV2LmNvbmYuYmxrKSk7DQo+IEBAIC0xNjgyLDYgKzE2ODksNyBAQCBzdGF0
aWMgdm9pZCBzY3NpX2Rpc2tfZW11bGF0ZV91bm1hcChTQ1NJRGlza1JlcSAqciwgdWludDhfdCAq
aW5idWYpDQo+ICAgICAgIH0NCj4gICANCj4gICAgICAgaWYgKGJsa19pc19yZWFkX29ubHkocy0+
cWRldi5jb25mLmJsaykpIHsNCj4gKyAgICAgICAgYmxvY2tfYWNjdF9pbnZhbGlkKGJsa19nZXRf
c3RhdHMocy0+cWRldi5jb25mLmJsayksIEJMT0NLX0FDQ1RfVU5NQVApOw0KPiAgICAgICAgICAg
c2NzaV9jaGVja19jb25kaXRpb24ociwgU0VOU0VfQ09ERShXUklURV9QUk9URUNURUQpKTsNCj4g
ICAgICAgICAgIHJldHVybjsNCj4gICAgICAgfQ0KPiBAQCAtMTY5NywxMCArMTcwNSwxMiBAQCBz
dGF0aWMgdm9pZCBzY3NpX2Rpc2tfZW11bGF0ZV91bm1hcChTQ1NJRGlza1JlcSAqciwgdWludDhf
dCAqaW5idWYpDQo+ICAgICAgIHJldHVybjsNCj4gICANCj4gICBpbnZhbGlkX3BhcmFtX2xlbjoN
Cj4gKyAgICBibG9ja19hY2N0X2ludmFsaWQoYmxrX2dldF9zdGF0cyhzLT5xZGV2LmNvbmYuYmxr
KSwgQkxPQ0tfQUNDVF9VTk1BUCk7DQo+ICAgICAgIHNjc2lfY2hlY2tfY29uZGl0aW9uKHIsIFNF
TlNFX0NPREUoSU5WQUxJRF9QQVJBTV9MRU4pKTsNCj4gICAgICAgcmV0dXJuOw0KPiAgIA0KPiAg
IGludmFsaWRfZmllbGQ6DQo+ICsgICAgYmxvY2tfYWNjdF9pbnZhbGlkKGJsa19nZXRfc3RhdHMo
cy0+cWRldi5jb25mLmJsayksIEJMT0NLX0FDQ1RfVU5NQVApOw0KPiAgICAgICBzY3NpX2NoZWNr
X2NvbmRpdGlvbihyLCBTRU5TRV9DT0RFKElOVkFMSURfRklFTEQpKTsNCj4gICB9DQo+ICAgDQo+
IA0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

