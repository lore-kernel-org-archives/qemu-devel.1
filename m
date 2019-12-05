Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF9BC43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 16:38:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95A9222525
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 16:38:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="kd7JrIfM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95A9222525
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icu9V-0005yx-F7
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 11:38:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45849)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1icu7U-00048B-7L
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 11:36:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1icu7S-0001cM-Ae
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 11:36:47 -0500
Received: from mail-eopbgr80125.outbound.protection.outlook.com
 ([40.107.8.125]:62784 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1icu7R-0001QU-9S; Thu, 05 Dec 2019 11:36:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fr4ykQT3Ewm21lon3aUQPxSwSL/JLevYNelkzsFKTG4Y9mHz3lenYYAstffgZ0XvEWLG8C68hdl1OUTFIOOn1wEeRZGj6byBiLIX4AhW+TV+EmbD0OUtf5mWkdrNrJsDyflV7vPgxORQtKUirTtqZ1HdzbrPhYfA8jAhPF2w//ArWuq3UwS2xrc8BIiNLL1TZwwZg6vSZt3k09LHK4kMo4773HHqTOaWaNKx8+Hlug+xOs+MzmTF0qqK4iS5PNdpMoD+29Mr9vXclRUfysQhQl6B/TuoMy841W/Hhtndvy85xC4AonEqbpgL/xsv0+VtXrNQ7qy1E0dYoIUCFD2f7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BYFcZEZvWhTiSAbFQyG3vTsddaFK3yn9mr+VXoBleB4=;
 b=mys6kURJ5U/S8z9ERRIk8VTzLrAyDpPnsZJVJlNyrbku93kha415V3wrsvxGrNkB+RA2m1cXSqQsRgd1MwuBVSjyuzE6wxJGV5CoUPq6Ot3B6x1UsepDw+PZSQUb0FuUdwxN5QoTt0v7yGuMYcpDnT7FrDDx4YnFYH17AhjxpvCExhJIEelUZwlHvkD3BF3bwoJxqc6wUDQ2RQQjKLsNCGHHx+O0cynyAlbG+kgAaAgohx6wqJNN0O3Ug61bjp1O26ouOTlhdmBd9fceEwaxPXIw8J4WL2s6HxHndSP44mVcAaDEJZeUXqOwoZMNNt+n1IVihMiKJ1EPoxBoi/+2AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BYFcZEZvWhTiSAbFQyG3vTsddaFK3yn9mr+VXoBleB4=;
 b=kd7JrIfMeOe9HUIUk1hOGaDSrtkaQUQaXAQ7ZSqZXMf6bPvtl6pXsGEDKPtbm0zRI9y4IuJOCqyw1rpRl+afy6GOTGPdl8RAqnJHFeSB4TLZqXCVzluGz1HdDCwzPuWGC2kJds+ptfcTVJfONYEj0N78n2VjTKzrCLJDV8BT2GE=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3413.eurprd08.prod.outlook.com (20.177.113.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.20; Thu, 5 Dec 2019 16:36:42 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2516.014; Thu, 5 Dec 2019
 16:36:42 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [RFC v5 024/126] error: auto propagated local_err
Thread-Topic: [RFC v5 024/126] error: auto propagated local_err
Thread-Index: AQHVgE3c5dwPNEl0z0OyUhbNfTU1EqeqZpzagAFqo4D///+mMYAAWcgA///pCIA=
Date: Thu, 5 Dec 2019 16:36:42 +0000
Message-ID: <a6df5b5b-7b76-fe38-cbd4-f2473a109d3d@virtuozzo.com>
References: <20191011160552.22907-1-vsementsov@virtuozzo.com>
 <20191011160552.22907-25-vsementsov@virtuozzo.com>
 <87muc8p24w.fsf@dusky.pond.sub.org>
 <55393c08-5bda-8042-1a95-f350b3781d99@virtuozzo.com>
 <87d0d3c5k7.fsf@dusky.pond.sub.org>
 <eef60af5-ff92-3df7-bad5-c981690d66ad@virtuozzo.com>
In-Reply-To: <eef60af5-ff92-3df7-bad5-c981690d66ad@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR07CA0005.eurprd07.prod.outlook.com
 (2603:10a6:7:67::15) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191205193635106
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a1cfaf18-b700-494f-df99-08d779a14f16
x-ms-traffictypediagnostic: AM6PR08MB3413:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR08MB34131D6E623E75FC45330EF1C15C0@AM6PR08MB3413.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 02426D11FE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(366004)(346002)(396003)(39850400004)(376002)(199004)(189003)(2906002)(5660300002)(14454004)(66556008)(31686004)(99286004)(25786009)(66476007)(66946007)(305945005)(66446008)(71190400001)(11346002)(71200400001)(2616005)(52116002)(186003)(102836004)(7336002)(64756008)(76176011)(54906003)(6486002)(229853002)(26005)(8676002)(478600001)(86362001)(6506007)(14444005)(316002)(6512007)(7406005)(7366002)(8936002)(81156014)(36756003)(7416002)(81166006)(6916009)(31696002)(4326008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3413;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XhQDb+2ARl2+jHpU+uwJQ+uh6sTJqoAzH2+T7uuoM6rK7g89Le1+sNf4bbgjjGWXLDTNzsPLocj9HEC8jnWT7hITmTh3+l9fOMpV809II19hVe+Mt9L9ne+BoVhfLzwVNWKvMtk5/7F3QeDc4DRqVbuQO9uvujEXCSVBPK5WgdTakLa9ppbTBygdaSv6Sqe+UxuEaX2Qw4PXCDaJj7idqjyTckcydRJTDTMPW4p6hPCiLxCjUeNr6MZLuopeTcJ+B/NOozorTq0uBzagFWuHsJA5MRBwbOP4BXyAkAZvK8ATJcsyJfZtPtlJDyIwpE1BSG4H3buqkVNLpSjA3TZGBYwRnJDfxTkoyEBXXij39Ry8U/7xDqtf16GitTm1YuLQxkS7fjMy5JvtizfGFi6V+NGI4wSzUP6aRRoNO7AGftBAuULOolSVNJVD+1R9+pnF
Content-Type: text/plain; charset="utf-8"
Content-ID: <E07E37C4DC38D7428A8813972FC8B55D@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1cfaf18-b700-494f-df99-08d779a14f16
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2019 16:36:42.3587 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9ww9nQ2S5biuo2Gs3TzO0zG6DcTSL/RApkcqWEvb6E17V9WBvtGy3Cbz01pgkplP3IhsPjesh9CXSt3U1ggljILAKqVf/A31/VazwVaEhvY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3413
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.8.125
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
 Laszlo Ersek <lersek@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Xie Changlong <xiechanglong.d@gmail.com>, Peter Lieven <pl@kamp.de>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Beniamino Galvani <b.galvani@gmail.com>, Eric Auger <eric.auger@redhat.com>,
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
 Anthony Green <green@moxielogic.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, Ari Sundholm <ari@tuxera.com>,
 Juan Quintela <quintela@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, Joel Stanley <joel@jms.id.au>,
 Jason Dillaman <dillaman@redhat.com>, Antony Pavlov <antonynpavlov@gmail.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 "integration@gluster.org" <integration@gluster.org>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 "Richard W.M.
 Jones" <rjones@redhat.com>, Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Max Reitz <mreitz@redhat.com>, Denis Lunev <den@virtuozzo.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
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

MDUuMTIuMjAxOSAxNzo1OCwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4g
MDUuMTIuMjAxOSAxNTozNiwgTWFya3VzIEFybWJydXN0ZXIgd3JvdGU6DQo+PiBWbGFkaW1pciBT
ZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+IHdyaXRlczoNCj4+
DQo+Pj4gMDQuMTIuMjAxOSAxNzo1OSwgTWFya3VzIEFybWJydXN0ZXIgd3JvdGU6DQo+Pj4+IFZs
YWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4gd3Jp
dGVzOg0KPj4+Pg0KPj4+Pj4gSGVyZSBpcyBpbnRyb2R1Y2VkIEVSUlBfQVVUT19QUk9QQUdBVEUg
bWFjcm8sIHRvIGJlIHVzZWQgYXQgc3RhcnQgb2YNCj4+Pj4+IGZ1bmN0aW9ucyB3aXRoIGVycnAg
T1VUIHBhcmFtZXRlci4NCj4+Pj4+DQo+Pj4+PiBJdCBoYXMgdGhyZWUgZ29hbHM6DQo+Pj4+Pg0K
Pj4+Pj4gMS4gRml4IGlzc3VlIHdpdGggZXJyb3JfZmF0YWwgJiBlcnJvcl9wcmVwZW5kL2Vycm9y
X2FwcGVuZF9oaW50OiB1c2VyDQo+Pj4+PiBjYW4ndCBzZWUgdGhpcyBhZGRpdGlvbmFsIGluZm9y
bWF0aW9uLCBiZWNhdXNlIGV4aXQoKSBoYXBwZW5zIGluDQo+Pj4+PiBlcnJvcl9zZXRnIGVhcmxp
ZXIgdGhhbiBpbmZvcm1hdGlvbiBpcyBhZGRlZC4gW1JlcG9ydGVkIGJ5IEdyZWcgS3Vyel0NCj4+
Pj4+DQo+Pj4+PiAyLiBGaXggaXNzdWUgd2l0aCBlcnJvcl9hYm9ydCAmIGVycm9yX3Byb3BhZ2F0
ZTogd2hlbiB3ZSB3cmFwDQo+Pj4+PiBlcnJvcl9hYm9ydCBieSBsb2NhbF9lcnIrZXJyb3JfcHJv
cGFnYXRlLCByZXN1bHRpbmcgY29yZWR1bXAgd2lsbA0KPj4+Pj4gcmVmZXIgdG8gZXJyb3JfcHJv
cGFnYXRlIGFuZCBub3QgdG8gdGhlIHBsYWNlIHdoZXJlIGVycm9yIGhhcHBlbmVkLg0KPj4+Pg0K
Pj4+PiBJIGdldCB3aGF0IHlvdSBtZWFuLCBidXQgSSBoYXZlIHBsZW50eSBvZiBjb250ZXh0Lg0K
Pj4+Pg0KPj4+Pj4gKHRoZSBtYWNybyBpdHNlbGYgZG9lc24ndCBmaXggdGhlIGlzc3VlLCBidXQg
aXQgYWxsb3dzIHRvIFszLl0gZHJvcCBhbGwNCj4+Pj4+IGxvY2FsX2VycitlcnJvcl9wcm9wYWdh
dGUgcGF0dGVybiwgd2hpY2ggd2lsbCBkZWZpbml0ZWx5IGZpeCB0aGUgaXNzdWUpDQo+Pj4+DQo+
Pj4+IFRoZSBwYXJlbnRoZXNpcyBpcyBub3QgcGFydCBvZiB0aGUgZ29hbC4NCj4+Pj4NCj4+Pj4+
IFtSZXBvcnRlZCBieSBLZXZpbiBXb2xmXQ0KPj4+Pj4NCj4+Pj4+IDMuIERyb3AgbG9jYWxfZXJy
K2Vycm9yX3Byb3BhZ2F0ZSBwYXR0ZXJuLCB3aGljaCBpcyB1c2VkIHRvIHdvcmthcm91bmQNCj4+
Pj4+IHZvaWQgZnVuY3Rpb25zIHdpdGggZXJycCBwYXJhbWV0ZXIsIHdoZW4gY2FsbGVyIHdhbnRz
IHRvIGtub3cgcmVzdWx0aW5nDQo+Pj4+PiBzdGF0dXMuIChOb3RlOiBhY3R1YWxseSB0aGVzZSBm
dW5jdGlvbnMgY291bGQgYmUgbWVyZWx5IHVwZGF0ZWQgdG8NCj4+Pj4+IHJldHVybiBpbnQgZXJy
b3IgY29kZSkuDQo+Pj4+Pg0KPj4+Pj4gVG8gYWNoaWV2ZSB0aGVzZSBnb2Fscywgd2UgbmVlZCB0
byBhZGQgaW52b2NhdGlvbiBvZiB0aGUgbWFjcm8gYXQgc3RhcnQNCj4+Pj4+IG9mIGZ1bmN0aW9u
cywgd2hpY2ggbmVlZHMgZXJyb3JfcHJlcGVuZC9lcnJvcl9hcHBlbmRfaGludCAoMS4pOyBhZGQN
Cj4+Pj4+IGludm9jYXRpb24gb2YgdGhlIG1hY3JvIGF0IHN0YXJ0IG9mIGZ1bmN0aW9ucyB3aGlj
aCBkbw0KPj4+Pj4gbG9jYWxfZXJyK2Vycm9yX3Byb3BhZ2F0ZSBzY2VuYXJpbyB0aGUgY2hlY2sg
ZXJyb3JzLCBkcm9wIGxvY2FsIGVycm9ycw0KPj4+Pj4gZnJvbSB0aGVtIGFuZCBqdXN0IHVzZSAq
ZXJycCBpbnN0ZWFkICgyLiwgMy4pLg0KPj4+Pg0KPj4+PiBUaGUgcGFyYWdyYXBoIHRhbGtzIGFi
b3V0IHR3byBjYXNlczogMS4gYW5kIDIuKzMuDQo+Pj4NCj4+PiBIbW0sIEkgZG9uJ3QgdGhpbmsg
c28uLiAxLiBhbmQgMi4gYXJlIGlzc3Vlcy4gMy4gaXMgYSByZWZhY3RvcmluZy4uIFdlIGp1c3QN
Cj4+PiBmaXggYWNoaWV2ZSAyIGFuZCAzIGJ5IG9uZSBhY3Rpb24uDQo+Pj4NCj4+Pj4gTWFrZXMg
bWUgdGhpbmsgd2UNCj4+Pj4gd2FudCB0d28gcGFyYWdyYXBocywgZWFjaCBpbGx1c3RyYXRlZCB3
aXRoIGFuIGV4YW1wbGUuDQo+Pj4+DQo+Pj4+IFdoYXQgYWJvdXQgeW91IHByb3ZpZGUgdGhlIGV4
YW1wbGVzLCBhbmQgdGhlbiBJIHRyeSB0byBwb2xpc2ggdGhlIHByb3NlPw0KPj4+DQo+Pj4gMTog
ZXJyb3JfZmF0YWwgcHJvYmxlbQ0KPj4+DQo+Pj4gQXNzdW1lIHRoZSBmb2xsb3dpbmcgY29kZSBm
bG93Og0KPj4+DQo+Pj4gaW50IGYxKGVycnApIHsNCj4+PiAgICAgICAuLi4NCj4+PiAgICAgICBy
ZXQgPSBmMihlcnJwKTsNCj4+PiAgICAgICBpZiAocmV0IDwgMCkgew0KPj4+ICAgICAgICAgIGVy
cm9yX2FwcGVuZF9oaW50KGVycnAsICJ2ZXJ5IHVzZWZ1bCBoaW50Iik7DQo+Pj4gICAgICAgICAg
cmV0dXJuIHJldDsNCj4+PiAgICAgICB9DQo+Pj4gICAgICAgLi4uDQo+Pj4gfQ0KPj4+DQo+Pj4g
Tm93LCBpZiB3ZSBjYWxsIGYxIHdpdGggJmVycm9yX2ZhdGFsIGFyZ3VtZW50IGFuZCBmMiBmYWls
cywgdGhlIHByb2dyYW0NCj4+PiB3aWxsIGV4aXQgaW1tZWRpYXRlbHkgaW5zaWRlIGYyLCB3aGVu
IHNldHRpbmcgdGhlIGVycnAuIFVzZXIgd2lsbCBub3QNCj4+PiBzZWUgdGhlIGhpbnQuDQo+Pj4N
Cj4+PiBTbywgaW4gdGhpcyBjYXNlIHdlIHNob3VsZCB1c2UgbG9jYWxfZXJyLg0KPj4NCj4+IEhv
dyBkb2VzIHRoaXMgZXhhbXBsZSBsb29rIGFmdGVyIHRoZSB0cmFuc2Zvcm1hdGlvbj8NCj4gDQo+
IEdvb2QgcG9pbnQuDQo+IA0KPiBpbnQgZjEoZXJycCkgew0KPiAgICAgIEVSUlBfQVVUT19QUk9Q
QUdBVEUoKTsNCj4gICAgICAuLi4NCj4gICAgICByZXQgPSBmMihlcnJwKTsNCj4gICAgICBpZiAo
cmV0IDwgMCkgew0KPiAgICAgICAgIGVycm9yX2FwcGVuZF9oaW50KGVycnAsICJ2ZXJ5IHVzZWZ1
bCBoaW50Iik7DQo+ICAgICAgICAgcmV0dXJuIHJldDsNCj4gICAgICB9DQo+ICAgICAgLi4uDQo+
IH0NCj4gDQo+IC0gbm90aGluZyBjaGFuZ2VkLCBvbmx5IGFkZCBtYWNybyBhdCBzdGFydC4gQnV0
IG5vdyBlcnJwIGlzIHNhZmUsIGlmIGl0IHdhcw0KPiBlcnJvcl9mYXRhbCBpdCBpcyB3cmFwcGVk
IGJ5IGxvY2FsIGVycm9yLCBhbmQgd2lsbCBvbmx5IGNhbGwgZXhpdCBvbiBhdXRvbWF0aWMNCj4g
cHJvcGFnYXRpb24gb24gZjEgZmluaXNoLg0KPiANCj4+DQo+Pj4gMjogZXJyb3JfYWJvcnQgcHJv
YmxlbQ0KPj4+DQo+Pj4gTm93LCBjb25zaWRlciBmdW5jdGlvbnMgd2l0aG91dCByZXR1cm4gdmFs
dWUuIFdlIG5vcm1hbGx5IHVzZSBsb2NhbF9lcnINCj4+PiB2YXJpYWJsZSB0byBjYXRjaCBmYWls
dXJlczoNCj4+Pg0KPj4+IHZvaWQgZjEoZXJycCkgew0KPj4+ICAgICAgIEVycm9yICpsb2NhbF9l
cnIgPSBOVUxMOw0KPj4+ICAgICAgIC4uLg0KPj4+ICAgICAgIGYyKCZsb2NhbF9lcnIpOw0KPj4+
ICAgICAgIGlmIChsb2NhbF9lcnIpIHsNCj4+PiAgICAgICAgICAgZXJyb3JfcHJvcGFnYXRlKGVy
cnAsIGxvY2FsX2Vycik7DQo+Pj4gICAgICAgICAgIHJldHVybjsNCj4+PiAgICAgICB9DQo+Pj4g
ICAgICAgLi4uDQo+Pj4gfQ0KPj4+DQo+Pj4gTm93LCBpZiB3ZSBjYWxsIGYyIHdpdGggJmVycm9y
X2Fib3J0IGFuZCBmMiBmYWlscywgdGhlIHN0YWNrIGluIHJlc3VsdGluZw0KPj4+IGNyYXNoIGR1
bXAgd2lsbCBwb2ludCB0byBlcnJvcl9wcm9wYWdhdGUsIG5vdCB0byB0aGUgZmFpbHVyZSBwb2lu
dCBpbiBmMiwNCj4+PiB3aGljaCBjb21wbGljYXRlcyBkZWJ1Z2dpbmcuDQo+Pj4NCj4+PiBTbywg
d2Ugc2hvdWxkIG5ldmVyIHdyYXAgZXJyb3JfYWJvcnQgYnkgbG9jYWxfZXJyLg0KPj4NCj4+IExp
a2V3aXNlLg0KPiANCj4gQW5kIGhlcmU6DQo+IA0KPiB2b2lkIGYxKGVycnApIHsNCj4gICAgICAg
RVJSUF9BVVRPX1BST1BBR0FURSgpOw0KPiAgICAgICAuLi4NCj4gICAgICAgZjIoZXJycCk7DQo+
ICAgICAgIGlmICgqZXJycCkgew0KPiAgICAgICAgICAgcmV0dXJuOw0KPiAgICAgICB9DQo+ICAg
ICAgIC4uLg0KPiANCj4gLSBpZiBlcnJwIHdhcyBOVUxMLCBpdCBpcyB3cmFwcGVkLCBzbyBkZXJl
ZmVyZW5jaW5nIGVycnAgaXMgc2FmZS4gT24gcmV0dXJuLA0KPiAgICAgbG9jYWwgZXJyb3IgaXMg
YXV0b21hdGljYWxseSBwcm9wYWdhdGVkIHRvIG9yaWdpbmFsIG9uZS4NCg0KYW5kIGlmIGl0IHdh
cyBlcnJvcl9hYm9ydCwgaXQgaXMgbm90IHdyYXBwZWQsIHNvIHdpbGwgY3Jhc2ggd2hlcmUgZmFp
bGVkLg0KDQo+IA0KPj4NCj4+Pg0KPj4+ID09PQ0KPj4+DQo+Pj4gT3VyIHNvbHV0aW9uOg0KPj4+
DQo+Pj4gLSBGaXhlcyBbMS5dLCBhZGRpbmcgaW52b2NhdGlvbiBvZiBuZXcgbWFjcm8gaW50byBm
dW5jdGlvbnMgd2l0aCBlcnJvcl9hcHBlbl9oaW50L2Vycm9yX3ByZXBlbmQsDQo+Pj4gICAgICBO
ZXcgbWFjcm8gd2lsbCB3cmFwIGVycm9yX2ZhdGFsLg0KPj4+IC0gRml4ZXMgWzIuXSwgYnkgc3dp
dGNoaW5nIGZyb20gaGFuZC13cml0dGVuIGxvY2FsX2VyciB0byBzbWFydCBtYWNybywgd2hpY2gg
bmV2ZXINCj4+PiAgICAgIHdyYXBzIGVycm9yX2Fib3J0Lg0KPj4+IC0gSGFuZGxlcyBbMy5dLCBi
eSBzd2l0Y2hpbmcgdG8gbWFjcm8sIHdoaWNoIGlzIGxlc3MgY29kZQ0KPj4+IC0gQWRkaXRpb25h
bGx5LCBtYWNybyBkb2Vzbid0IHdyYXAgbm9ybWFsIG5vbi16ZXJvIGVycnAsIHRvIGF2b2lkIGV4
dHJhIHByb3BhZ2F0aW9ucw0KPj4+ICAgICAgKGluIGZhY3QsIGVycm9yX3Byb3BhZ2F0ZSBpcyBj
YWxsZWQsIGJ1dCByZXR1cm5zIGltbWVkaWF0ZWx5IG9uIGZpcnN0IGlmICghbG9jYWxfZXJyKSkN
Cj4+DQo+IA0KPiANCg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

