Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1767DC43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 15:00:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C39FC21835
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 15:00:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="fLNSvBOW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C39FC21835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icscC-0008AT-U5
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 10:00:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60705)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1icsau-0007QI-7Y
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 09:59:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1icsas-0007oF-4t
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 09:59:03 -0500
Received: from mail-eopbgr20110.outbound.protection.outlook.com
 ([40.107.2.110]:26143 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1icsaq-0007iY-7t; Thu, 05 Dec 2019 09:59:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WQU3RZweU4eFuQT5pAoOJSL8qn26rFI7/JLB+Kx0T6sV8xlqjH6Fgwl9LDRicgwBY2MrBILOwmsxkx1a7mvVf4gY7j5HxH3qeNXDXj0+vmK3m4fkfzSkJADEx2ESFZYOu7dZTOWIXwzJ7NftYtl5UaIpCu+vK29XZVcEF9MvCbf+LqOztAcZLXMCqRMMrhelqYMyu1/DJKa2abEUmka0SvCUsdQGfm9z/6BKCoRSGnVROwZp5nQhvpa4iZmwE1pUU1VwLF/ZK9F6M49T3Q5171APHUHLvTpXC2wem7ak3eDtpXmJ35XJ9A1ImSj0Di+0jD7Yei65dwT/DI22K7oU6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z9qcvYIewmJI5A6vWn3JtW1ppPG3kwmVYrEc3hjTzyM=;
 b=f4mBrYayH0nrP9mSofE1qPcRQ5FbABUXl9q0CKjZiSuA0z0B4DqiZtx87Oucylit2LpLEyfGLRshIPiANlaIYpVc+R4jQegzQ5QBwm8foAoRoefr6gR0sEqUqdUd9jR53t9opojkeEMYGEp5d/tF5mHaTAEOAxmoPMtv6Bp//pgQwdeAyPMirCGQdOCg/BH0PUMbEe/OZlTcX+VJoHOCrMwDOZpKiCQubO4U/CaU5XHdN0q8Xf+edV4aF//Vp21bF+LRFMtpOL8zMvBKJHwpz1eAjKHToPEE/JxQfw9P9hyXqonvP8FzVrUY6YQKuCcU3V7HwZu9w6xV1EHqAnSCLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z9qcvYIewmJI5A6vWn3JtW1ppPG3kwmVYrEc3hjTzyM=;
 b=fLNSvBOW+SN+uAa81zdtJe++gDojv06rNG4DZPXfBDYEQZSg7pCa6rFErFMD1A23ceWrvFd+bc2EJwuj4bxAmJUVdNQBCuQXejZguhbNs4IG2/K52M93hCMkkWkB1bnAypFZuUnjKw9AZxSE4oMPdJgTd4Artr1EmL8FD0D3rsM=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB2949.eurprd08.prod.outlook.com (52.135.167.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.12; Thu, 5 Dec 2019 14:58:54 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2516.014; Thu, 5 Dec 2019
 14:58:54 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [RFC v5 024/126] error: auto propagated local_err
Thread-Topic: [RFC v5 024/126] error: auto propagated local_err
Thread-Index: AQHVgE3c5dwPNEl0z0OyUhbNfTU1EqeqZpzagAFqo4D///+mMYAAJ34A
Date: Thu, 5 Dec 2019 14:58:53 +0000
Message-ID: <eef60af5-ff92-3df7-bad5-c981690d66ad@virtuozzo.com>
References: <20191011160552.22907-1-vsementsov@virtuozzo.com>
 <20191011160552.22907-25-vsementsov@virtuozzo.com>
 <87muc8p24w.fsf@dusky.pond.sub.org>
 <55393c08-5bda-8042-1a95-f350b3781d99@virtuozzo.com>
 <87d0d3c5k7.fsf@dusky.pond.sub.org>
In-Reply-To: <87d0d3c5k7.fsf@dusky.pond.sub.org>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR06CA0141.eurprd06.prod.outlook.com
 (2603:10a6:7:16::28) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191205175848006
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1b469883-1ae0-440e-ddae-08d77993a55d
x-ms-traffictypediagnostic: AM6PR08MB2949:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR08MB2949C842E2E59951446C6B61C15C0@AM6PR08MB2949.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 02426D11FE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(366004)(39850400004)(346002)(396003)(376002)(189003)(199004)(81156014)(81166006)(8676002)(54906003)(6486002)(478600001)(8936002)(6512007)(26005)(6506007)(102836004)(186003)(4326008)(11346002)(99286004)(76176011)(14454004)(25786009)(31686004)(2616005)(52116002)(6916009)(5660300002)(36756003)(31696002)(305945005)(2906002)(86362001)(7366002)(7416002)(7406005)(316002)(64756008)(66946007)(66556008)(66476007)(229853002)(14444005)(7336002)(66446008)(71190400001)(71200400001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB2949;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4crTOeKmgG48QjzZhnAuYFtWswZIf77y8ORhRNTejYzCsMIkLT6bFbpipZ3a8PBsHk8PT6270E308dkstK4wjxYSsV7D0MCni9iRBj2yDsi7F7FMTzSzhvXHM/pUy0uy0NBnAFd1nLxrx5L7MYYvuqu6wWv9OuBoNrCXIcZJE6lj94yvOi8OzEj37wsQMLqsqvTfEjG1tJK9mqK2o1YBVC4k20J905cYJ9YuyHPwNhV/mH/gVJB52Lq7NfiKF6crtp2CNS+NjSG8vH3ZqeZO6+UlMzyduDwB9GTfBwKv3FnQHNBVWZjSnPUcbXz48EhZLtUVpMojnbmQJppyk3Rhb/LnqTEBmWKwzrBHDH/AWq/Gs+cOGCEFxH7X8ShlOltuZwkqycuYZmsyNdeTvpqnhXfSm0ten/g6+72aymQ2PSAS5Gw1MSeu+64rRzMq+P/3
Content-Type: text/plain; charset="utf-8"
Content-ID: <C0D07A0C4DBC374FAB57C7541713859B@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b469883-1ae0-440e-ddae-08d77993a55d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2019 14:58:53.9739 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N94XwTGcnPiNX6Z6dsbqpipTtg0l8F5dAsDF8P6qSeSD2lYtDayDjWdPouRNUKnhrv4XVzHNFGUUqvSL2so+xoap9LiXZHXnxo/99BUigak=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB2949
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.2.110
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Jeff Cody <codyprime@gmail.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Alberto Garcia <berto@igalia.com>,
 Hailiang Zhang <zhang.zhanghailiang@huawei.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, Halil Pasic <pasic@linux.ibm.com>,
 =?utf-8?B?SGVydsOpIFBvdXNzaW5lYXU=?= <hpoussin@reactos.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 Anthony Green <green@moxielogic.com>, Laurent Vivier <lvivier@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Xie Changlong <xiechanglong.d@gmail.com>, Peter Lieven <pl@kamp.de>,
 "Dr. David
 Alan Gilbert" <dgilbert@redhat.com>, Beniamino Galvani <b.galvani@gmail.com>,
 Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 Andrew Jeffery <andrew@aj.id.au>, Chris Wulff <crwulff@gmail.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, Michael Walle <michael@walle.cc>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Igor Mammedov <imammedo@redhat.com>, Fam Zheng <fam@euphon.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 "sheepdog@lists.wpkg.org" <sheepdog@lists.wpkg.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Palmer Dabbelt <palmer@sifive.com>, Eric Farman <farman@linux.ibm.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Hannes Reinecke <hare@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>, Liu Yuan <namei.unix@gmail.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Amit Shah <amit@kernel.org>, Stefan Weil <sw@weilnetz.de>,
 Greg Kurz <groug@kaod.org>, Yuval Shaia <yuval.shaia@oracle.com>,
 "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 Peter Chubb <peter.chubb@nicta.com.au>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>,
 Stafford Horne <shorne@gmail.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 Cornelia Huck <cohuck@redhat.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Paul Burton <pburton@wavecomp.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, Paul Durrant <paul@xen.org>,
 Jason Wang <jasowang@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, Ari Sundholm <ari@tuxera.com>,
 Juan Quintela <quintela@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, Joel Stanley <joel@jms.id.au>,
 Jason Dillaman <dillaman@redhat.com>, Antony Pavlov <antonynpavlov@gmail.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 "integration@gluster.org" <integration@gluster.org>,
 Laszlo Ersek <lersek@redhat.com>, "Richard
 W.M. Jones" <rjones@redhat.com>, Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Max Reitz <mreitz@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Vincenzo Maffione <v.maffione@gmail.com>, Marek Vasut <marex@denx.de>,
 =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>, Luigi Rizzo <rizzo@iet.unipi.it>,
 David Gibson <david@gibson.dropbear.id.au>,
 Tony Krowiak <akrowiak@linux.ibm.com>,
 =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Pierre Morel <pmorel@linux.ibm.com>, Wen Congyang <wencongyang2@huawei.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDUuMTIuMjAxOSAxNTozNiwgTWFya3VzIEFybWJydXN0ZXIgd3JvdGU6DQo+IFZsYWRpbWlyIFNl
bWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4gd3JpdGVzOg0KPiAN
Cj4+IDA0LjEyLjIwMTkgMTc6NTksIE1hcmt1cyBBcm1icnVzdGVyIHdyb3RlOg0KPj4+IFZsYWRp
bWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4gd3JpdGVz
Og0KPj4+DQo+Pj4+IEhlcmUgaXMgaW50cm9kdWNlZCBFUlJQX0FVVE9fUFJPUEFHQVRFIG1hY3Jv
LCB0byBiZSB1c2VkIGF0IHN0YXJ0IG9mDQo+Pj4+IGZ1bmN0aW9ucyB3aXRoIGVycnAgT1VUIHBh
cmFtZXRlci4NCj4+Pj4NCj4+Pj4gSXQgaGFzIHRocmVlIGdvYWxzOg0KPj4+Pg0KPj4+PiAxLiBG
aXggaXNzdWUgd2l0aCBlcnJvcl9mYXRhbCAmIGVycm9yX3ByZXBlbmQvZXJyb3JfYXBwZW5kX2hp
bnQ6IHVzZXINCj4+Pj4gY2FuJ3Qgc2VlIHRoaXMgYWRkaXRpb25hbCBpbmZvcm1hdGlvbiwgYmVj
YXVzZSBleGl0KCkgaGFwcGVucyBpbg0KPj4+PiBlcnJvcl9zZXRnIGVhcmxpZXIgdGhhbiBpbmZv
cm1hdGlvbiBpcyBhZGRlZC4gW1JlcG9ydGVkIGJ5IEdyZWcgS3Vyel0NCj4+Pj4NCj4+Pj4gMi4g
Rml4IGlzc3VlIHdpdGggZXJyb3JfYWJvcnQgJiBlcnJvcl9wcm9wYWdhdGU6IHdoZW4gd2Ugd3Jh
cA0KPj4+PiBlcnJvcl9hYm9ydCBieSBsb2NhbF9lcnIrZXJyb3JfcHJvcGFnYXRlLCByZXN1bHRp
bmcgY29yZWR1bXAgd2lsbA0KPj4+PiByZWZlciB0byBlcnJvcl9wcm9wYWdhdGUgYW5kIG5vdCB0
byB0aGUgcGxhY2Ugd2hlcmUgZXJyb3IgaGFwcGVuZWQuDQo+Pj4NCj4+PiBJIGdldCB3aGF0IHlv
dSBtZWFuLCBidXQgSSBoYXZlIHBsZW50eSBvZiBjb250ZXh0Lg0KPj4+DQo+Pj4+ICh0aGUgbWFj
cm8gaXRzZWxmIGRvZXNuJ3QgZml4IHRoZSBpc3N1ZSwgYnV0IGl0IGFsbG93cyB0byBbMy5dIGRy
b3AgYWxsDQo+Pj4+IGxvY2FsX2VycitlcnJvcl9wcm9wYWdhdGUgcGF0dGVybiwgd2hpY2ggd2ls
bCBkZWZpbml0ZWx5IGZpeCB0aGUgaXNzdWUpDQo+Pj4NCj4+PiBUaGUgcGFyZW50aGVzaXMgaXMg
bm90IHBhcnQgb2YgdGhlIGdvYWwuDQo+Pj4NCj4+Pj4gW1JlcG9ydGVkIGJ5IEtldmluIFdvbGZd
DQo+Pj4+DQo+Pj4+IDMuIERyb3AgbG9jYWxfZXJyK2Vycm9yX3Byb3BhZ2F0ZSBwYXR0ZXJuLCB3
aGljaCBpcyB1c2VkIHRvIHdvcmthcm91bmQNCj4+Pj4gdm9pZCBmdW5jdGlvbnMgd2l0aCBlcnJw
IHBhcmFtZXRlciwgd2hlbiBjYWxsZXIgd2FudHMgdG8ga25vdyByZXN1bHRpbmcNCj4+Pj4gc3Rh
dHVzLiAoTm90ZTogYWN0dWFsbHkgdGhlc2UgZnVuY3Rpb25zIGNvdWxkIGJlIG1lcmVseSB1cGRh
dGVkIHRvDQo+Pj4+IHJldHVybiBpbnQgZXJyb3IgY29kZSkuDQo+Pj4+DQo+Pj4+IFRvIGFjaGll
dmUgdGhlc2UgZ29hbHMsIHdlIG5lZWQgdG8gYWRkIGludm9jYXRpb24gb2YgdGhlIG1hY3JvIGF0
IHN0YXJ0DQo+Pj4+IG9mIGZ1bmN0aW9ucywgd2hpY2ggbmVlZHMgZXJyb3JfcHJlcGVuZC9lcnJv
cl9hcHBlbmRfaGludCAoMS4pOyBhZGQNCj4+Pj4gaW52b2NhdGlvbiBvZiB0aGUgbWFjcm8gYXQg
c3RhcnQgb2YgZnVuY3Rpb25zIHdoaWNoIGRvDQo+Pj4+IGxvY2FsX2VycitlcnJvcl9wcm9wYWdh
dGUgc2NlbmFyaW8gdGhlIGNoZWNrIGVycm9ycywgZHJvcCBsb2NhbCBlcnJvcnMNCj4+Pj4gZnJv
bSB0aGVtIGFuZCBqdXN0IHVzZSAqZXJycCBpbnN0ZWFkICgyLiwgMy4pLg0KPj4+DQo+Pj4gVGhl
IHBhcmFncmFwaCB0YWxrcyBhYm91dCB0d28gY2FzZXM6IDEuIGFuZCAyLiszLg0KPj4NCj4+IEht
bSwgSSBkb24ndCB0aGluayBzby4uIDEuIGFuZCAyLiBhcmUgaXNzdWVzLiAzLiBpcyBhIHJlZmFj
dG9yaW5nLi4gV2UganVzdA0KPj4gZml4IGFjaGlldmUgMiBhbmQgMyBieSBvbmUgYWN0aW9uLg0K
Pj4NCj4+PiBNYWtlcyBtZSB0aGluayB3ZQ0KPj4+IHdhbnQgdHdvIHBhcmFncmFwaHMsIGVhY2gg
aWxsdXN0cmF0ZWQgd2l0aCBhbiBleGFtcGxlLg0KPj4+DQo+Pj4gV2hhdCBhYm91dCB5b3UgcHJv
dmlkZSB0aGUgZXhhbXBsZXMsIGFuZCB0aGVuIEkgdHJ5IHRvIHBvbGlzaCB0aGUgcHJvc2U/DQo+
Pg0KPj4gMTogZXJyb3JfZmF0YWwgcHJvYmxlbQ0KPj4NCj4+IEFzc3VtZSB0aGUgZm9sbG93aW5n
IGNvZGUgZmxvdzoNCj4+DQo+PiBpbnQgZjEoZXJycCkgew0KPj4gICAgICAuLi4NCj4+ICAgICAg
cmV0ID0gZjIoZXJycCk7DQo+PiAgICAgIGlmIChyZXQgPCAwKSB7DQo+PiAgICAgICAgIGVycm9y
X2FwcGVuZF9oaW50KGVycnAsICJ2ZXJ5IHVzZWZ1bCBoaW50Iik7DQo+PiAgICAgICAgIHJldHVy
biByZXQ7DQo+PiAgICAgIH0NCj4+ICAgICAgLi4uDQo+PiB9DQo+Pg0KPj4gTm93LCBpZiB3ZSBj
YWxsIGYxIHdpdGggJmVycm9yX2ZhdGFsIGFyZ3VtZW50IGFuZCBmMiBmYWlscywgdGhlIHByb2dy
YW0NCj4+IHdpbGwgZXhpdCBpbW1lZGlhdGVseSBpbnNpZGUgZjIsIHdoZW4gc2V0dGluZyB0aGUg
ZXJycC4gVXNlciB3aWxsIG5vdA0KPj4gc2VlIHRoZSBoaW50Lg0KPj4NCj4+IFNvLCBpbiB0aGlz
IGNhc2Ugd2Ugc2hvdWxkIHVzZSBsb2NhbF9lcnIuDQo+IA0KPiBIb3cgZG9lcyB0aGlzIGV4YW1w
bGUgbG9vayBhZnRlciB0aGUgdHJhbnNmb3JtYXRpb24/DQoNCkdvb2QgcG9pbnQuDQoNCmludCBm
MShlcnJwKSB7DQogICAgRVJSUF9BVVRPX1BST1BBR0FURSgpOw0KICAgIC4uLg0KICAgIHJldCA9
IGYyKGVycnApOw0KICAgIGlmIChyZXQgPCAwKSB7DQogICAgICAgZXJyb3JfYXBwZW5kX2hpbnQo
ZXJycCwgInZlcnkgdXNlZnVsIGhpbnQiKTsNCiAgICAgICByZXR1cm4gcmV0Ow0KICAgIH0NCiAg
ICAuLi4NCn0NCg0KLSBub3RoaW5nIGNoYW5nZWQsIG9ubHkgYWRkIG1hY3JvIGF0IHN0YXJ0LiBC
dXQgbm93IGVycnAgaXMgc2FmZSwgaWYgaXQgd2FzDQplcnJvcl9mYXRhbCBpdCBpcyB3cmFwcGVk
IGJ5IGxvY2FsIGVycm9yLCBhbmQgd2lsbCBvbmx5IGNhbGwgZXhpdCBvbiBhdXRvbWF0aWMNCnBy
b3BhZ2F0aW9uIG9uIGYxIGZpbmlzaC4NCg0KPiANCj4+IDI6IGVycm9yX2Fib3J0IHByb2JsZW0N
Cj4+DQo+PiBOb3csIGNvbnNpZGVyIGZ1bmN0aW9ucyB3aXRob3V0IHJldHVybiB2YWx1ZS4gV2Ug
bm9ybWFsbHkgdXNlIGxvY2FsX2Vycg0KPj4gdmFyaWFibGUgdG8gY2F0Y2ggZmFpbHVyZXM6DQo+
Pg0KPj4gdm9pZCBmMShlcnJwKSB7DQo+PiAgICAgIEVycm9yICpsb2NhbF9lcnIgPSBOVUxMOw0K
Pj4gICAgICAuLi4NCj4+ICAgICAgZjIoJmxvY2FsX2Vycik7DQo+PiAgICAgIGlmIChsb2NhbF9l
cnIpIHsNCj4+ICAgICAgICAgIGVycm9yX3Byb3BhZ2F0ZShlcnJwLCBsb2NhbF9lcnIpOw0KPj4g
ICAgICAgICAgcmV0dXJuOw0KPj4gICAgICB9DQo+PiAgICAgIC4uLg0KPj4gfQ0KPj4NCj4+IE5v
dywgaWYgd2UgY2FsbCBmMiB3aXRoICZlcnJvcl9hYm9ydCBhbmQgZjIgZmFpbHMsIHRoZSBzdGFj
ayBpbiByZXN1bHRpbmcNCj4+IGNyYXNoIGR1bXAgd2lsbCBwb2ludCB0byBlcnJvcl9wcm9wYWdh
dGUsIG5vdCB0byB0aGUgZmFpbHVyZSBwb2ludCBpbiBmMiwNCj4+IHdoaWNoIGNvbXBsaWNhdGVz
IGRlYnVnZ2luZy4NCj4+DQo+PiBTbywgd2Ugc2hvdWxkIG5ldmVyIHdyYXAgZXJyb3JfYWJvcnQg
YnkgbG9jYWxfZXJyLg0KPiANCj4gTGlrZXdpc2UuDQoNCkFuZCBoZXJlOg0KDQp2b2lkIGYxKGVy
cnApIHsNCiAgICAgRVJSUF9BVVRPX1BST1BBR0FURSgpOw0KICAgICAuLi4NCiAgICAgZjIoZXJy
cCk7DQogICAgIGlmICgqZXJycCkgew0KICAgICAgICAgcmV0dXJuOw0KICAgICB9DQogICAgIC4u
Lg0KDQotIGlmIGVycnAgd2FzIE5VTEwsIGl0IGlzIHdyYXBwZWQsIHNvIGRlcmVmZXJlbmNpbmcg
ZXJycCBpcyBzYWZlLiBPbiByZXR1cm4sDQogICBsb2NhbCBlcnJvciBpcyBhdXRvbWF0aWNhbGx5
IHByb3BhZ2F0ZWQgdG8gb3JpZ2luYWwgb25lLg0KDQo+IA0KPj4NCj4+ID09PQ0KPj4NCj4+IE91
ciBzb2x1dGlvbjoNCj4+DQo+PiAtIEZpeGVzIFsxLl0sIGFkZGluZyBpbnZvY2F0aW9uIG9mIG5l
dyBtYWNybyBpbnRvIGZ1bmN0aW9ucyB3aXRoIGVycm9yX2FwcGVuX2hpbnQvZXJyb3JfcHJlcGVu
ZCwNCj4+ICAgICBOZXcgbWFjcm8gd2lsbCB3cmFwIGVycm9yX2ZhdGFsLg0KPj4gLSBGaXhlcyBb
Mi5dLCBieSBzd2l0Y2hpbmcgZnJvbSBoYW5kLXdyaXR0ZW4gbG9jYWxfZXJyIHRvIHNtYXJ0IG1h
Y3JvLCB3aGljaCBuZXZlcg0KPj4gICAgIHdyYXBzIGVycm9yX2Fib3J0Lg0KPj4gLSBIYW5kbGVz
IFszLl0sIGJ5IHN3aXRjaGluZyB0byBtYWNybywgd2hpY2ggaXMgbGVzcyBjb2RlDQo+PiAtIEFk
ZGl0aW9uYWxseSwgbWFjcm8gZG9lc24ndCB3cmFwIG5vcm1hbCBub24temVybyBlcnJwLCB0byBh
dm9pZCBleHRyYSBwcm9wYWdhdGlvbnMNCj4+ICAgICAoaW4gZmFjdCwgZXJyb3JfcHJvcGFnYXRl
IGlzIGNhbGxlZCwgYnV0IHJldHVybnMgaW1tZWRpYXRlbHkgb24gZmlyc3QgaWYgKCFsb2NhbF9l
cnIpKQ0KPiANCg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

