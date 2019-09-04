Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6974BC3A5A7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 13:54:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 359DE22CED
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 13:54:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="k1BX+I+2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 359DE22CED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5VkO-00064E-9L
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 09:54:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40524)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1i5Vje-0005Wx-JZ
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 09:54:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1i5Vjd-0008Du-L1
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 09:54:10 -0400
Received: from mail-eopbgr140095.outbound.protection.outlook.com
 ([40.107.14.95]:42976 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1i5Vja-0008Bl-0p; Wed, 04 Sep 2019 09:54:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YgZHB+qbVVw3jJKqtfp6Wctk0jYvPCJcK5d1Pg8fngSIMz7etN1BIXLN97QhQrosYyDkJLRxf03EEUQw3C7KTGiYuEjBDEkvFyzWJyAq6OosEWZvtstQuSQ6bi+y6eHQYesUQ2BE/Y06cH9ZN44yqJk765QR8vPLDSp8Xo2u7K0fmE5ubqi6TPwQFeDNXuMIaq8KTCzkUTdva/2eJNJvLz9W8ycjE3i+SD4HaIdT8yriuKxsTwr/inFHsi6CQ9I3btEksKJ1bn0vqcTXEafwQE+bdFfpjpPSd5xWakkF8WpcKs5bC+cxh4c5bwChY/kXDDHQbyDecNqbYGOEW6xEqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tqd7eX2Ks35GddEwdalGxZpDaNWHB2SvEBaXxeyckz0=;
 b=kk5rjjSiSgFg1QF8XntRVCO0fIZQIJyLdY+U5BBB8vqTRp7MtZlFhh8O2rVA/zUR3Qm7nyZOI/cfrPI4smhjhZjgbqsXCSkNZlwRrlc4Y2Y0pb6+58v2q0FaUpCPnML+lTYLRgF1mWqrBQutE4aTvwobEi6mSif6fyRpz4WHCUEEaKTCrKYkMAcgbscRt8lBLpkBlElzZRUrbZqM0f28przb4PpgUZRQSylJuKNthEfZsM2PJqkEUjeiMN1Js0cBuvbmQVNQZS3ki4gKGOo5je7uzA9M6IREA4MmFbXhUESZcyewZUKeKmjk/+AqavdlFn3du28E0MHRScZZjVPmsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tqd7eX2Ks35GddEwdalGxZpDaNWHB2SvEBaXxeyckz0=;
 b=k1BX+I+2CMfPr9/mvfV4UFpaivguVYd/xkbDsuxTDgt75Ah7sRydJdYuYvQA0/+qV634dJ7TqLCM/TdyNfKgQdRnj7+x4pCt6ItSHkwr6kpkQKbnWDdbrV3lXhdt7qo4CCKl0H1pcgfWv1Ub6zWfdQdZNon7Cf/fyqggbUhhA7c=
Received: from AM0PR08MB3027.eurprd08.prod.outlook.com (52.134.95.154) by
 AM0PR08MB4116.eurprd08.prod.outlook.com (20.178.202.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.19; Wed, 4 Sep 2019 13:54:02 +0000
Received: from AM0PR08MB3027.eurprd08.prod.outlook.com
 ([fe80::19a3:6903:45eb:bf51]) by AM0PR08MB3027.eurprd08.prod.outlook.com
 ([fe80::19a3:6903:45eb:bf51%6]) with mapi id 15.20.2220.022; Wed, 4 Sep 2019
 13:54:02 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>
Thread-Topic: [PATCH v8 0/6] Allow Valgrind checking all QEMU processes
Thread-Index: AQHVYwDEFNJTsAl0k0Gx1XJoYb+1eqcbh6qAgAACugA=
Date: Wed, 4 Sep 2019 13:54:02 +0000
Message-ID: <896365da-702c-6838-9904-c044b56ff239@virtuozzo.com>
References: <1567588284-975381-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <20190904134413.GB21246@localhost.localdomain>
In-Reply-To: <20190904134413.GB21246@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0401CA0046.eurprd04.prod.outlook.com
 (2603:10a6:3:19::14) To AM0PR08MB3027.eurprd08.prod.outlook.com
 (2603:10a6:208:61::26)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9baa6c67-63f9-4dfe-0975-08d7313f57ec
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:AM0PR08MB4116; 
x-ms-traffictypediagnostic: AM0PR08MB4116:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR08MB41167DA951B4229C760D306FF4B80@AM0PR08MB4116.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0150F3F97D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39840400004)(136003)(366004)(346002)(396003)(376002)(199004)(189003)(99286004)(26005)(6506007)(25786009)(52116002)(53546011)(386003)(66946007)(6486002)(66556008)(102836004)(66446008)(64756008)(36756003)(76176011)(66476007)(66066001)(54906003)(6116002)(14454004)(3846002)(44832011)(486006)(478600001)(71200400001)(6512007)(6436002)(71190400001)(316002)(2906002)(186003)(229853002)(2616005)(446003)(11346002)(8936002)(4744005)(5660300002)(4326008)(6916009)(31696002)(256004)(7736002)(8676002)(81156014)(81166006)(305945005)(6246003)(107886003)(31686004)(53936002)(86362001)(476003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB4116;
 H:AM0PR08MB3027.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: R8dI9w54GNcCxWt639iMUfYoA4+iqnvBX0P3Nh/BLLM9PrlPyDD8PwupTK52Oe0l6ze27waJiHj1YU0tEZk1yMkkLa6AOSkvZvyAlfu8ZpPBmfC6qpqEHDosO89kpHf+0shx10N/Le0xvtoySHl4GU/f9gSI3QlKh9/NS9Pr9NLhkPB5mVbV/CKupnZvsEsBXrYKko0NhOP2j29//Q1MjPtfPVIeRNFrkSFcILDnrAjf7AT+l3Ka15rO/uPiwAZwRGdz6TugucHZsjDmvz9mJUMuanGpOF7lIlFUs8/F488iGfYV6XECzsb5rx/1XR+rtr6jJN64tTQsKAvRqerEtGo4rWb4v2Tm8dsKwxBmfdJJBgpDzEwgF4iHx5pfON3D56Yi/bcgS/2YCpgLJC6F4E+dkiWHAl/WnpU1EiAkMMg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <344B7CAED10E7D4FBBC29BDD53A9C3FF@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9baa6c67-63f9-4dfe-0975-08d7313f57ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2019 13:54:02.6530 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AycKjuzrE1nVTPPj33DDc476ZJ34Lg0fBodK6O7IWyvPfrRyO60qvPa0h4FLKMh6SPbwei4a+KIlzj5rW2GnujBwHv1iqZdWzzHuiLOG7Ns=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4116
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.14.95
Subject: Re: [Qemu-devel] [PATCH v8 0/6] Allow Valgrind checking all QEMU
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDA0LzA5LzIwMTkgMTY6NDQsIEtldmluIFdvbGYgd3JvdGU6DQo+IEFtIDA0LjA5LjIw
MTkgdW0gMTE6MTEgaGF0IEFuZHJleSBTaGlua2V2aWNoIGdlc2NocmllYmVuOg0KPj4gSW4gdGhl
IGN1cnJlbnQgaW1wbGVtZW50YXRpb24gb2YgdGhlIFFFTVUgYmFzaCBpb3Rlc3RzLCBvbmx5IHFl
bXUtaW8NCj4+IHByb2Nlc3NlcyBtYXkgYmUgcnVuIHVuZGVyIHRoZSBWYWxncmluZCB3aXRoIHRo
ZSBzd2l0Y2ggJy12YWxncmluZCcuDQo+PiBMZXQncyBhbGxvdyB0aGUgY29tbW9uLnJjIGJhc2gg
c2NyaXB0IHJ1bm5pbmcgYWxsIG90aGVyIFFFTVUgcHJvY2Vzc2VzLA0KPj4gc3VjaCBhcyBxZW11
LWt2bSwgcWVtdS1pbWcsIHFlbXUtbmRiIGFuZCBxZW11LXZ4aHMsIHVuZGVyIHRoZSBWYWxncmlu
ZC4NCj4+DQo+PiB2ODoNCj4+ICAgIDAxOiBGaXggZm9yIHRoZSBvcHRpbWl6YXRpb24gbWFkZSBp
biB2NyB3aGVyZSB0aGUgaW90ZXN0cyAwMzkgYW5kIDA1MQ0KPj4gICAgICAgIGRpZCBub3QgcGFz
cyBiZWluZyBydW4gdW5kZXIgdGhlIFZhbGdyaW5kLiBOT19WQUxHUklORCB2YXJpYWJsZQ0KPj4g
ICAgICAgIGhhcyBiZWVuIGludHJvZHVjZWQgdG8gY29tcGxldGUgdGhlIG9wdGltaXphdGlvbiBs
b2dpYyAocGF0Y2ggMi82KS4NCj4gDQo+IFRoYW5rcywgYXBwbGllZCB0byB0aGUgYmxvY2sgYnJh
bmNoLg0KPiANCj4gS2V2aW4NCj4gDQoNClRoYW5rIHlvdSB0b28sIEtldmluLg0KDQpBbmRyZXkN
Ci0tIA0KV2l0aCB0aGUgYmVzdCByZWdhcmRzLA0KQW5kcmV5IFNoaW5rZXZpY2gNCg==

