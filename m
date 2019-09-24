Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B08C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 19:28:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 639D1207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 19:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="CwFe9f9f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 639D1207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCqTl-0001N8-7v
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 15:28:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57947)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iCqSm-0000r3-Dz
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 15:27:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iCqSl-0002um-Fg
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 15:27:04 -0400
Received: from mail-he1eur02on0720.outbound.protection.outlook.com
 ([2a01:111:f400:fe05::720]:57900
 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iCqSf-0002ow-7v; Tue, 24 Sep 2019 15:26:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bjFWN054Cas185dk5ZlSQD69BG37HOqcPxUvoyqBvkAFqkL1NhuNwli2XUVgOsK139/b7K7BHmozO97XL+vwb0pQkR/PqVlKsk3OwFFYCdlsHtc6JNDK2pwJzGmSl9sT/1WEAJsHqtqQydGWAG/usMVdSkGX8QDymSUpWCk8ldW1V8FVktB88WwmB7nheb+xx3SZHs34Fap0k2Df46uDxBJZjcoTDb17erOykKIJi+uD+sQ6f13iSpV214kIJvSAdn4A3JWC5rrXwZEVI8cFvXptNdBIGB18rgAjyJixrT+xtEw0jB9lYLiAldSyy2/5m2UyvKwx26hu1E5kKhw4Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nhaHmE4QtiGf76nS6fasiTL2h1omsuJcAKJYwo6eOxw=;
 b=IMUqfGr3cdkhOpHl0jSYd4CHO7BH0BJxospd0F5OQc4BCtEk1rZdaeRepxlcKkdUm181xDetyjL/gGyKXPbIPEsRLRabo4S/hGED/hxYd5RndFetwPcu2Mnd3gYdsjZA7JXMBlIbSSB8vnKYIxfYpCNtWaEHB6K1xxH37nVrJvwhWwJXCU8r2HMklzluEN+2oy3iTCxrg8Jr3BXsIuFWaWlkjr59Zb1aDuh9TWYDVCdWsGnI5P1zLcxx5y/8tBPzokdCq0liA4cZ5eimQhM0hFKzM73CrmTvaWWtgK8tSNNp6pvTy65xPJOgD4Wq1fuyHNKmawNbfLVOnHmKoFmsHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nhaHmE4QtiGf76nS6fasiTL2h1omsuJcAKJYwo6eOxw=;
 b=CwFe9f9fGIjJIZLbcyIW3/Kcf8fBk3dl4ji25Dtb96EpzjF4NLGuwE4NkzNZ+dxrWvqU2ciA2OyVgcvOsBOYDsT7XFOIGzEfUIHT0gOxYyuYvzqKEd0RVqCWNLZLjaE6/Q6noP2Rs7KGtB2dfpbgs0En4KHuKhpibmUIxvAQ61s=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5241.eurprd08.prod.outlook.com (10.255.16.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.18; Tue, 24 Sep 2019 19:26:33 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2284.023; Tue, 24 Sep 2019
 19:26:33 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH 0/2] enhance iotest 223 coverage
Thread-Topic: [PATCH 0/2] enhance iotest 223 coverage
Thread-Index: AQHVcuzA/guIV4TSrkyAW36PHjteH6c7NhUA
Date: Tue, 24 Sep 2019 19:26:33 +0000
Message-ID: <8463a76e-74d7-7785-79f4-563cd78182a5@virtuozzo.com>
References: <20190924143522.22902-1-eblake@redhat.com>
In-Reply-To: <20190924143522.22902-1-eblake@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0303.eurprd05.prod.outlook.com
 (2603:10a6:7:93::34) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190924222630777
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c0630604-c0ff-4bd3-139b-08d741251ba8
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:DB8PR08MB5241; 
x-ms-traffictypediagnostic: DB8PR08MB5241:
x-microsoft-antispam-prvs: <DB8PR08MB524163D5B371B0C46D0D8823C1840@DB8PR08MB5241.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0170DAF08C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(376002)(396003)(366004)(346002)(39850400004)(199004)(189003)(316002)(2906002)(478600001)(14454004)(25786009)(7736002)(81166006)(81156014)(8676002)(2501003)(305945005)(8936002)(4744005)(31696002)(66556008)(256004)(14444005)(4326008)(86362001)(102836004)(26005)(386003)(6506007)(186003)(5660300002)(52116002)(99286004)(66066001)(76176011)(66446008)(64756008)(71190400001)(66946007)(31686004)(66476007)(476003)(486006)(11346002)(2616005)(446003)(36756003)(71200400001)(6512007)(110136005)(54906003)(229853002)(6436002)(6486002)(3846002)(6116002)(6246003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5241;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: k41mNtJFBTmnOQr8AknGmuI0ItIXLzqTzfD/y2u3BmWh6hZuzjsGsRdwrCnpiDtQnknkW2xXM+nxUbDLAYdV+kBJejmHJFfIkUzy3q93+wEW5MYnIcq9GfhNICKbzcPuaww8yZ69zbsTi8NaQcMhRE/iDMyLa9uERR4R/s+b9lJW4T6qohESYqbc4dpA6lKd4Zaa2xzlU8+7E6/uJTzkv5SN7D2w0ZLz9vOVzHKsCpU/IvZKpL+vik5Z0niq18IgfF3AKzvzpYojHcC6nC4HATTjb5I7fZH73SYp/KHxhQR98qzRFgOW9Lcmv2rrSaODkbxuJBmxX9mcoavK10SHuAnTy+zP5B8Ltg1HHBbOYBSJ7DLCdqrvUAISHz3O3rehbX6zhN9Qd0OIZQZoQhd64g9hgkEkXOhKQNRSg6Zsxjg=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <827A8896DD1D934395E0BB391755C3D7@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0630604-c0ff-4bd3-139b-08d741251ba8
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2019 19:26:33.0820 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 71/QX5fcbG83TyXu2w497Ac4S1+n8fJhrwhZ9/RcRuiDvex+p1/thTj1yp5F3Ccn+5NxfhOrBjDiJGpDQ86+TkPhhyV71fSqPVlBJH6mSAc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5241
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe05::720
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
Cc: "nsoffer@redhat.com" <nsoffer@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjQuMDkuMjAxOSAxNzozNSwgRXJpYyBCbGFrZSB3cm90ZToNCj4gQ29tbWl0IDUwNjkwMmM2IGRy
b3BwZWQgbm9uLWlvdGhyZWFkIGNvdmVyYWdlIGluIG9yZGVyIHRvIHRlc3QgaW90aHJlYWQsDQo+
IGJldHRlciBpcyB0byBydW4gdGhpbmdzIHR3aWNlLiAgSW4gZG9pbmcgdGhpcywgSSBmb3VuZCBp
dCBlYXNpZXIgdG8NCj4gZWRpdCB0aGUgdGVzdCB3aGVuIHRoZSBsb2cgc2hvd3Mgd2hhdCBjb21t
YW5kcyB3ZXJlIHRyaWdnZXJpbmcgdmFyaW91cw0KPiByZXNwb25zZXMuDQoNCkRpZCB5b3UgY29u
c2lkZXIgYWRkaW5nIC1pb3RocmVhZCB0byB0ZXN0cy9xZW11LWlvdGVzdHMvY2hlY2sgaW5zdGVh
ZCwgdG8gYmUNCmFibGUgdG8gcnVuIGFueSAob3Igc29tZSkgdGVzdHMgd2l0aCBvciB3aXRob3V0
IGlvdGhyZWFkPw0KDQo+IA0KPiBFcmljIEJsYWtlICgyKToNCj4gICAgdGVzdHM6IE1ha2UgaW90
ZXN0IDIyMyBlYXNpZXIgdG8gZWRpdA0KPiAgICB0ZXN0czogTW9yZSBpb3Rlc3QgMjIzIGltcHJv
dmVtZW50cw0KPiANCj4gICB0ZXN0cy9xZW11LWlvdGVzdHMvMjIzICAgICB8IDExNCArKysrKysr
KysrKysrKysrKysrKysrKystLS0tLS0NCj4gICB0ZXN0cy9xZW11LWlvdGVzdHMvMjIzLm91dCB8
IDEzOCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICAgMiBmaWxlcyBj
aGFuZ2VkLCAyMzEgaW5zZXJ0aW9ucygrKSwgMjEgZGVsZXRpb25zKC0pDQo+IA0KDQoNCi0tIA0K
QmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

