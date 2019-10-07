Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3192BC47404
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 17:17:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D53D206BB
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 17:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="grv9GrHV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D53D206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHWdw-0000T0-Bf
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 13:17:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38447)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iHWc2-0007cd-43
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 13:15:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iHWc0-0008EN-L9
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 13:15:57 -0400
Received: from mail-eopbgr20128.outbound.protection.outlook.com
 ([40.107.2.128]:10363 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iHWbp-0008Ac-6L; Mon, 07 Oct 2019 13:15:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WWPlDXJ19Y21u4B9JXraj+Fz+cpAY0aYRLEn2wFA2thA5P7r2tEGJsUBdFUtf1LsDzExp/gfQ2yAFrUk5fyvYU8QVzUoqW2aZyBJj6gqX/AjLVTIZYm/3DLobTdx8GukVneDCxRxJlPaXbJpBXYIEXEGsR9gpS6N3pPcFhyLipDaocxaCeUdMTNpsySTnpLHGPzbXS0UJIpen30+JIIc8rDLG7v1sJ0PSEnSFQOcr9kkfIZhlnMXHPorwMKQa01kdVX7tJxiVBJqWE2QVUJY2SjuATHdExhfyFaM7bBY1XyQnS3oo+1bN2RBBicy3kqt26RxQ5HMiMUV4Q69feGZoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ge4k0QmxRRt3negFvr3bGhlAo4/0oluSk7kdV9iR2NM=;
 b=F1f+U2LuE0jhgF4q3bRkIrRf7cqlreDs5ZDbzcDIRe7kWslEmQnE2LKt2mXKY85BFWGEoIaNAQmXdaamRtcEba75Xd/HHOXC4URHqT44JRbPV12ydJfY/N1QhcPidAsiuDzWuToRwwJCbycGxzhYGk63U/uGowkpBplk8GQ31ru0YadHsRbacofIEj0DeoldlXYGSvnIoyWG7WFxf/O2GEhEezsvGSyswn3sWqp3vQhjeAjbfAEwZP1sn60QtaAV4Bv8PrFwUhE6JXZvQ9eTf8yQAI1Ft32NEAiFILF0vcmY0+G6duwajfZO8UeHKIaHh2nQbcJd9T0KZE7F9ZOQuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ge4k0QmxRRt3negFvr3bGhlAo4/0oluSk7kdV9iR2NM=;
 b=grv9GrHVmavx3f/Raa6lUHqlhilOnEJX+rX8yc42NdVj9VWZGv0RvMhAfBy0qmfTsHdiIwzwNlFyKLE93kE9fZ+jEV1r3qQzOhh8G8aT9/qpOucZRtn2wfEWR1fJE5RvqIGzE+aBOGGX4Y8oGEcQtyITvrh3ZE1rTf6qPRWbUN4=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.24; Mon, 7 Oct 2019 17:15:42 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f%2]) with mapi id 15.20.2327.023; Mon, 7 Oct 2019
 17:15:42 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>, Cornelia
 Huck <cohuck@redhat.com>
Subject: Re: [PATCH v4 06/31] python: add commit-per-subsystem.py
Thread-Topic: [PATCH v4 06/31] python: add commit-per-subsystem.py
Thread-Index: AQHVeHBj95K2V5GzV0GqFsm4i4IPaqdPXlUAgAA2ZgD//8+kgIAAAVsAgAAPEYA=
Date: Mon, 7 Oct 2019 17:15:42 +0000
Message-ID: <778e8efb-3a86-4540-f51e-c8664d960990@virtuozzo.com>
References: <20191001155319.8066-1-vsementsov@virtuozzo.com>
 <20191001155319.8066-7-vsementsov@virtuozzo.com>
 <20191007175514.19360a2b.cohuck@redhat.com>
 <cc355055-871d-9fb8-6f2d-f75d5cd40a3b@virtuozzo.com>
 <20191007181651.2fd72fbf.cohuck@redhat.com>
 <20191007162142.GO4656@redhat.com>
In-Reply-To: <20191007162142.GO4656@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P190CA0028.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:52::17)
 To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191007201537383
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 46482545-7dc2-498e-c9b2-08d74b49fb92
x-ms-traffictypediagnostic: DB8PR08MB5498:
x-microsoft-antispam-prvs: <DB8PR08MB5498D05E18B35997C7B4D66EC19B0@DB8PR08MB5498.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-forefront-prvs: 01834E39B7
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39840400004)(396003)(376002)(346002)(136003)(366004)(52314003)(189003)(199004)(6512007)(66066001)(86362001)(7406005)(2906002)(6486002)(478600001)(31696002)(256004)(6246003)(66556008)(66446008)(81166006)(81156014)(8936002)(8676002)(71190400001)(229853002)(64756008)(66946007)(66476007)(316002)(71200400001)(110136005)(54906003)(5660300002)(6436002)(446003)(11346002)(386003)(102836004)(99286004)(26005)(36756003)(76176011)(6506007)(186003)(52116002)(25786009)(4326008)(7416002)(3846002)(6116002)(7736002)(14454004)(305945005)(476003)(31686004)(486006)(2616005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5498;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YWOO//AxjcIu3TSBT8Ikz0u+m+DLn0XfUYEVilkulIKu/XemxDIZqhM4NYgaAvyjoVGN7Y7vn4dwLm6Vl4v0/RokhNHXED4qEyHq5ObcYtHAUDozEg6mf3iEVngQa0u2FgI6nfnX0Vne5J4NsAbAMzDFWaIaPZb0X3uTqx6s7R40BYOGFmWd3L5C5S+SQShL/K3gbqpWZ5fWA6rApcrpMzaUawi7rqpPPgVZo1huDec9Dg6Wd1Wq5bCUw5T+ZkTNqYofj6X5Ui8FYSWhlUGQ6xNeivOW9pIqwEU4oCr68fMNuC203i7PMu6OA0dBB5kk4fJcx95Fzfznmok6fEZNvGulYBdCDCpXv0+UJVRPs2o4IfUfPh0kGoFuthkzw81ErqxyNgvbjSwFG1W64I+FwUabJ+tHWCcU5M1vte1bWWI=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <3FC42988FF02764CA1EABB1670E18A31@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46482545-7dc2-498e-c9b2-08d74b49fb92
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2019 17:15:42.5514 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1849MlSweiDT+hMjia2qqgHLDr0l5VHKXFSrP+TuwkoAgFJ6muFFSfhdiNY/zpZGlYhI6xD3n5aNaGS+T5smDCx/xH694T3y2GgpG5cI0Fk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5498
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.2.128
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mdroth@linux.vnet.ibm.com" <mdroth@linux.vnet.ibm.com>,
 "kraxel@redhat.com" <kraxel@redhat.com>,
 "sundeep.lkml@gmail.com" <sundeep.lkml@gmail.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "quintela@redhat.com" <quintela@redhat.com>,
 "arikalo@wavecomp.com" <arikalo@wavecomp.com>,
 "mst@redhat.com" <mst@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "pasic@linux.ibm.com" <pasic@linux.ibm.com>,
 "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>,
 "joel@jms.id.au" <joel@jms.id.au>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>,
 "farman@linux.ibm.com" <farman@linux.ibm.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>, "sw@weilnetz.de" <sw@weilnetz.de>,
 "groug@kaod.org" <groug@kaod.org>,
 "yuval.shaia@oracle.com" <yuval.shaia@oracle.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "clg@kaod.org" <clg@kaod.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "david@redhat.com" <david@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>,
 "kwolf@redhat.com" <kwolf@redhat.com>,
 "integration@gluster.org" <integration@gluster.org>,
 "andrew@aj.id.au" <andrew@aj.id.au>,
 "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDcuMTAuMjAxOSAxOToyMSwgRGFuaWVsIFAuIEJlcnJhbmfDqSB3cm90ZToNCj4gT24gTW9uLCBP
Y3QgMDcsIDIwMTkgYXQgMDY6MTY6NTFQTSArMDIwMCwgQ29ybmVsaWEgSHVjayB3cm90ZToNCj4+
IE9uIE1vbiwgNyBPY3QgMjAxOSAxNjoxMDowMiArMDAwMA0KPj4gVmxhZGltaXIgU2VtZW50c292
LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPiB3cm90ZToNCj4+DQo+Pj4gMDcu
MTAuMjAxOSAxODo1NSwgQ29ybmVsaWEgSHVjayB3cm90ZToNCj4+Pj4gT24gVHVlLCAgMSBPY3Qg
MjAxOSAxODo1Mjo1NCArMDMwMA0KPj4+PiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2
c2VtZW50c292QHZpcnR1b3p6by5jb20+IHdyb3RlOg0KPj4NCj4+Pj4+ICtkZWYgZ2l0X2FkZChw
YXR0ZXJuKToNCj4+Pj4+ICsgICAgc3VicHJvY2Vzcy5ydW4oWydnaXQnLCAnYWRkJywgcGF0dGVy
bl0pDQo+Pj4+PiArDQo+Pj4+PiArDQo+Pj4+PiArZGVmIGdpdF9jb21taXQobXNnKToNCj4+Pj4+
ICsgICAgc3VicHJvY2Vzcy5ydW4oWydnaXQnLCAnY29tbWl0JywgJy1tJywgbXNnXSwgY2FwdHVy
ZV9vdXRwdXQ9VHJ1ZSkNCj4+Pj4+ICsNCj4+Pj4+ICsNCj4+Pj4+ICttYWludGFpbmVycyA9IHN5
cy5hcmd2WzFdDQo+Pj4+PiArbWVzc2FnZSA9IHN5cy5hcmd2WzJdLnN0cmlwKCkNCj4+Pj4+ICsN
Cj4+Pj4+ICtzdWJzeXN0ZW0gPSBOb25lDQo+Pj4+PiArDQo+Pj4+PiArc2hvcnRuYW1lcyA9IHsN
Cj4+Pj4+ICsgICAgJ0Jsb2NrIGxheWVyIGNvcmUnOiAnYmxvY2snLA0KPj4+Pj4gKyAgICAnQVJN
IGNvcmVzJzogJ2FybScsDQo+Pj4+PiArICAgICdOZXR3b3JrIEJsb2NrIERldmljZSAoTkJEKSc6
ICduYmQnLA0KPj4+Pj4gKyAgICAnQ29tbWFuZCBsaW5lIG9wdGlvbiBhcmd1bWVudCBwYXJzaW5n
JzogJ2NtZGxpbmUnLA0KPj4+Pj4gKyAgICAnQ2hhcmFjdGVyIGRldmljZSBiYWNrZW5kcyc6ICdj
aGFyZGV2JywNCj4+Pj4+ICsgICAgJ1MzOTAgZ2VuZXJhbCBhcmNoaXRlY3R1cmUgc3VwcG9ydCc6
ICdzMzkwJw0KPj4+Pj4gK30NCj4+Pj4+ICsNCj4+Pj4+ICsNCj4+Pj4+ICtkZWYgY29tbWl0KCk6
DQo+Pj4+PiArICAgIGlmIHN1YnN5c3RlbToNCj4+Pj4+ICsgICAgICAgIG1zZyA9IHN1YnN5c3Rl
bQ0KPj4+Pj4gKyAgICAgICAgaWYgbXNnIGluIHNob3J0bmFtZXM6DQo+Pj4+PiArICAgICAgICAg
ICAgbXNnID0gc2hvcnRuYW1lc1ttc2ddDQo+Pj4+PiArICAgICAgICBtc2cgKz0gJzogJyArIG1l
c3NhZ2UNCj4+Pj4+ICsgICAgICAgIGdpdF9jb21taXQobXNnKQ0KPj4+Pj4gKw0KPj4+Pj4gKw0K
Pj4+Pj4gK3dpdGggb3BlbihtYWludGFpbmVycykgYXMgZjoNCj4+Pj4+ICsgICAgZm9yIGxpbmUg
aW4gZjoNCj4+Pj4+ICsgICAgICAgIGxpbmUgPSBsaW5lLnJzdHJpcCgpDQo+Pj4+PiArICAgICAg
ICBpZiBub3QgbGluZToNCj4+Pj4+ICsgICAgICAgICAgICBjb250aW51ZQ0KPj4+Pj4gKyAgICAg
ICAgaWYgbGVuKGxpbmUpID49IDIgYW5kIGxpbmVbMV0gPT0gJzonOg0KPj4+Pj4gKyAgICAgICAg
ICAgIGlmIGxpbmVbMF0gPT0gJ0YnIGFuZCBsaW5lWzM6XSBub3QgaW4gWycqJywgJyovJ106DQo+
Pj4+PiArICAgICAgICAgICAgICAgIGdpdF9hZGQobGluZVszOl0pDQo+Pj4+PiArICAgICAgICBl
bHNlOg0KPj4+Pj4gKyAgICAgICAgICAgICMgbmV3IHN1YnN5c3RlbSBzdGFydA0KPj4+Pj4gKyAg
ICAgICAgICAgIGNvbW1pdCgpDQo+Pj4+PiArDQo+Pj4+PiArICAgICAgICAgICAgc3Vic3lzdGVt
ID0gbGluZQ0KPj4+Pj4gKw0KPj4+Pj4gK2NvbW1pdCgpDQo+Pj4+DQo+Pj4+IEhtLi4uIEknbSBu
b3Qgc3VyZSBhYm91dCB0aGUgcHVycG9zZSBvZiB0aGlzIHNjcmlwdCAoYW5kIG15IHB5dGhvbiBp
cw0KPj4+PiByYXRoZXIgd2VhaykuLi4gaXMgdGhpcyBzdXBwb3NlZCB0byBjb2xsZWN0IGFsbCBj
aGFuZ2VzIGNvdmVyZWQgYnkgYQ0KPj4+PiBzdWJzeXN0ZW0gRjogcGF0dGVybiBpbnRvIG9uZSBw
YXRjaD8NCj4+Pg0KPj4+IFllcw0KPj4+DQo+Pj4+IElmIHNvLCB3aGF0IGhhcHBlbnMgdG8gZmls
ZXMNCj4+Pj4gY292ZXJlZCBieSBtdWx0aXBsZSBzZWN0aW9ucz8NCj4+Pj4gICAgDQo+Pj4NCj4+
PiBIbW0sIHRoZXkganVzdCBnbyB0byB0aGUgZmlyc3Qgb2YgdGhlc2Ugc2VjdGlvbnMsIG1lbnRp
b25lZCBpbiBNQUlOVEFJTkVSUy4NCj4+PiBJcyBpdCBiYWQgSSBkb24ndCBrbm93LCBidXQgSSB0
cmllZCB0byBhdXRvbWF0ZSBpdCBzb21laG93LiBBbnl3YXksIEkgbXlzZWxmDQo+Pj4gY2FuJ3Qg
aGF2ZSBiZXR0ZXIgaWRlYSBhYm91dCBob3cgdG8gb3JnYW5pemUgcGF0Y2hlcyB0byB0aGUgc3Vi
c3lzdGVtcyB3aGljaA0KPj4+IEkgZG9uJ3Qga25vdy4NCj4+Pg0KPj4NCj4+IFllYWgsIHRoYXQg
aXMgYSBwcm9ibGVtIEkgZG9uJ3QgaGF2ZSBhIHNvbHV0aW9uIGZvciwgZWl0aGVyLg0KPj4NCj4+
IEJ1dCB0aGUgc2NyaXB0IHNob3VsZCBwcm9iYWJseSBnZXQgYXQgbGVhc3QgYSBjb21tZW50IGFi
b3V0IGl0cw0KPj4gaW50ZW5kZWQgcHVycG9zZSBhbmQgbGltaXRhdGlvbnM/IFdlIGRvbid0IHJl
YWxseSB3YW50IHBlb3BsZSB0byBzdGFydA0KPj4gdXNpbmcgaXQgYmxpbmRseS4NCj4gDQo+IElz
IHRoaXMgcmVhbGx5IGEgY29tbW9uIGVub3VnaCBwcm9ibGVtIHRvIGV2ZW4ganVzdGlmeSBoYXZp
bmcgdGhlDQo+IHNjcmlwdCB0byBzdGFydCB3aXRoID8NCj4gDQo+IEl0IGxvb2tzIGxpa2UgaXRz
IG9ubHkgcmVhbGx5IHVzYWJsZSBpbiB0aGUgY2FzZSB3aGVyZSB0aGUgY2hhbmdlcw0KPiB0byBl
YWNoIHN1YnN5c3RlbSBhcmUgdG90YWxseSBzZWxmLWNvbnRhaW5lZCwgb3RoZXJ3aXNlIHlvdSds
bCBnZXQNCj4gZ2l0IGJpc2VjdCBmYWlsdXJlcy4gVGhlIHVzZXIgc3RpbGwgaGFzIHRvIGdvIGJh
Y2sgYW5kIGVkaXQgZWFjaA0KPiBjb21taXQgaGVyZSB0byBmaWxsIGluIGEgdXNlZnVsIGNvbW1p
dCBtZXNzYWdlcy4gSXQgZG9lc24ndCBzZWVtDQo+IHRvIHNhdmUgbXVjaCBlZmZvcnQgb3ZlciAn
Z2l0IGFkZCAtdSBzdWIvZGlyLyAmJiBnaXQgY29tbWl0IC1zJw0KPiB3aGljaCBpcyB3aGF0IEkn
ZCB0eXBpY2FsbHkgZG8gZm9yIGdyb3VwaW5nIGNoYW5nZXMgdGhhdCBhcmUNCj4gc3ByZWFkIGFj
cm9zcyB0aGUgdHJlZS4NCj4gDQoNCg0KQ29tbWl0IG1lc3NhZ2UgaXMgdGhlIHNhbWUgZXhjZXB0
ICJzdWJzeXN0ZW06ICIsIEkgZG9uJ3QgdGhpbmsgaXQgc2hvdWQNCmJlIGVkaXRlZC4NClN0aWxs
LCB3ZSBjYW4ganVzdCBub3QgY29tbWl0IHRoaXMgc2NyaXB0IHRvIFFlbXUgaWYgd2UgZG9uJ3Qg
bGlrZSBpdC4gSXQganVzdA0KaGVscGVkIG1lIHRvIGNyZWF0ZSBwYXRjaGVzLCBhbmQgd2UgY2Fu
J3QgdGFrZSB0aGVtIHdpdGhvdXQgYSByZXZpZXcgYW55d2F5Lg0KDQoNCi0tIA0KQmVzdCByZWdh
cmRzLA0KVmxhZGltaXINCg==

