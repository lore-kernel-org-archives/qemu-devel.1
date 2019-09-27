Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1305C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 07:54:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8100B2075D
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 07:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="mf8XI3DD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8100B2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDl5X-0003um-E9
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 03:54:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39742)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iDl4R-0002zi-FT
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 03:53:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iDl4Q-0005Wu-IZ
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 03:53:43 -0400
Received: from mail-he1eur04on072f.outbound.protection.outlook.com
 ([2a01:111:f400:fe0d::72f]:18634
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iDl4Q-0005So-B9; Fri, 27 Sep 2019 03:53:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B+0DLu3y+kRd6WrbAYNZduRIuzyZQKnMyyorUxs3CZ07e5dqpNAuCgs07dq7fxAWlcbKmmV30qMyAZhkJ/e5JW1sjvx5m8HFbKyBuQYmIbm9OxOfwqCD9ns59SitSvLck01kK0S+TQBWVaoOPO+fwjVJ28ZPrmAg5NNOS4eQo4HIPh7Kn5muCEdI9zf4gtw9uNMdYBO4jCBdQrrq7T4GM4fsOx6fZwP1oY22A30jWWyCQ9hbnr573z3fJ3gPyaMf622erFQC9t9pTBE11UlXHPrzG1uNFJ/w7pRNGeEhuQ13LP2qYiAkpKUk7LSwYcbFUsMcVxCqOoWOCP2TvgyenA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NsoMopGTKxDRD/iS98i4BEXtEzClwJYo2grKtHCBXPc=;
 b=NHbW0UeExR2aMPuP/y5gxLLxb1IQWBC4q+RF3GvN1/SBZ5sT6q9s9u1psj+q5kCOOLz8oEbhD80YYIDd91/1fldysG+PE0oBiSH045wjXF1SS9ynfgkD3iTFTWimLWhkiplSyw3J/lM2Rl9MZZ95IEtvNx7TW1CKt2+y9tW4+lctW/ogd862plmpIGuk0WOSG9nvYfNvNqMwbp6pVa0YkedLPazWQGYfKBKVLgFGqRgWduvgzRkCNB4T8C7HBb4fFlG5NTsRdsWd2KlulDWHOfy4Yt7kX+4GrNRWg41hXmmjBkDP4UrVqVleyPwFNgYS3bYzD3QNmOBfI02pb01mfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NsoMopGTKxDRD/iS98i4BEXtEzClwJYo2grKtHCBXPc=;
 b=mf8XI3DDqBPNsZuspCOZdcSfuFBzKo6oEykc14F0mAOW0mpI304NPvq7Tx5GtoB9rCT//FZXaNsAq5G84nX0p2KaecGRnwnH2171C/IBCIBeTT/F6nlrtYf8UQFEokVPyG7vKXfb5cBqDEkua3tufzdLRGep4YqKClIMtDx1H1I=
Received: from AM0PR08MB5491.eurprd08.prod.outlook.com (52.132.215.9) by
 AM0PR08MB3955.eurprd08.prod.outlook.com (20.178.119.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.15; Fri, 27 Sep 2019 07:53:38 +0000
Received: from AM0PR08MB5491.eurprd08.prod.outlook.com
 ([fe80::d552:8bd7:4773:3d75]) by AM0PR08MB5491.eurprd08.prod.outlook.com
 ([fe80::d552:8bd7:4773:3d75%2]) with mapi id 15.20.2305.017; Fri, 27 Sep 2019
 07:53:38 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [Qemu-devel] [PATCH v4 00/10] qcow2-bitmaps: rewrite reopening
 logic
Thread-Topic: [Qemu-devel] [PATCH v4 00/10] qcow2-bitmaps: rewrite reopening
 logic
Thread-Index: AQHVTSopPwiUxx2MOkaQtW14Kblt36c+6R0AgACN4QA=
Date: Fri, 27 Sep 2019 07:53:38 +0000
Message-ID: <d630aeb5-9c42-ce5b-24a0-a39ce88644ef@virtuozzo.com>
References: <20190807141226.193501-1-vsementsov@virtuozzo.com>
 <8989f49a-6211-e65d-4146-4ad3fdf7ea57@redhat.com>
In-Reply-To: <8989f49a-6211-e65d-4146-4ad3fdf7ea57@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0174.eurprd05.prod.outlook.com
 (2603:10a6:3:f8::22) To AM0PR08MB5491.eurprd08.prod.outlook.com
 (2603:10a6:208:189::9)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190927105333965
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ae00a4d5-221d-4f62-a093-08d7431fce46
x-ms-traffictypediagnostic: AM0PR08MB3955:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR08MB395537AEB9E4DAE74CB0B75EC1810@AM0PR08MB3955.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0173C6D4D5
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(396003)(366004)(39850400004)(136003)(346002)(189003)(199004)(53754006)(6116002)(8936002)(446003)(2501003)(11346002)(2906002)(4326008)(110136005)(81156014)(107886003)(66946007)(64756008)(6246003)(71200400001)(3846002)(8676002)(229853002)(71190400001)(66476007)(53546011)(66556008)(6436002)(26005)(66446008)(6506007)(52116002)(31696002)(76176011)(386003)(6486002)(6512007)(186003)(5660300002)(316002)(36756003)(86362001)(54906003)(81166006)(102836004)(25786009)(66066001)(99286004)(7736002)(14454004)(478600001)(31686004)(2616005)(256004)(4744005)(305945005)(14444005)(486006)(476003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3955;
 H:AM0PR08MB5491.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tqATrziTxJJJkp+fwN06B6Gs+ADDfgNBShiNEe5XcsVO9YuDa76Qx8vajPWZZicq+HXnaaChQT7JVQjX7gB97RcdFSqEcwahLsvjTK64m7k64yH14QVkUuNTthWVtthmaSuTuRLxnj5JMY7FDWGlrDGbtu9ZliYgUjn+gHudusvzUWVCKB+uPQzVa0vQKkZuzw3ugE9u5AgW5ASGgstGGFqG0anq9ajxVOhlaxLIS2NSXyHaHqXlDRTT30uHjsO9TYlM2sa1gDTSZtHc/LJwwdX1rLyh04b3Ykijj/JV5uaDyzFAuu0GYnuGEgiM0KQAIVFilsdmaHRWoe046OwMZXFZKJ9dIl0l+OH5jzDzYMDIaylr/rFzxr3FZ+WdOkC/MnB/CzJc9yoDfWH4PToicnRI1h/1XGYYY0zLCzfAV6Y=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6E602FD0102E9841A5742963712D5C4C@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae00a4d5-221d-4f62-a093-08d7431fce46
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2019 07:53:38.0907 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DzYi5OYPZ1misGGJyNRK12wfN2P+9dJdAsG90F+6br3MHOeq78VYNVcanxJuWZaWEG6mcpC2OrGRoqRMaXC0ELEdVPG7rkELjQAOEvhGIVQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3955
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe0d::72f
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjcuMDkuMjAxOSAyOjI1LCBKb2huIFNub3cgd3JvdGU6DQo+IA0KPiBPbiA4LzcvMTkgMTA6MTIg
QU0sIFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgd3JvdGU6DQo+PiBIaSBhbGwhDQo+Pg0K
Pj4gQml0bWFwcyByZW9wZW5pbmcgaXMgYnVnZ3ksIHJlb3BlbmluZy1ydyBqdXN0IG5vdCB3b3Jr
aW5nIGF0IGFsbCBhbmQNCj4+IHJlb3BlbmluZy1ybyBtYXkgbGVhZCB0byBwcm9kdWNpbmcgYnJv
a2VuIGluY3JlbWVudGFsDQo+PiBiYWNrdXAgaWYgd2UgZG8gdGVtcG9yYXJ5IHNuYXBzaG90IGlu
IGEgbWVhbnRpbWUuDQo+Pg0KPj4gdjQ6IERyb3AgY29tcGxpY2F0ZWQgc29sdXRpb24gYXJvdW5k
IHJlb3BlbmluZyBsb2dpYyBbS2V2aW5dLCBmaXgNCj4+ICAgICAgdGhlIGV4aXN0aW5nIGJ1ZyBp
biBhIHNpbXBsZXN0IHdheQ0KPj4NCj4gT3ZlcmFsbCwgc2VlbXMgZ29vZC4gSSB3YW50IE1heCB0
byB0YWtlIGEgbG9vayBhdCAxMC8xMCwgYW5kIHRoZXJlIGFyZQ0KPiBzb21lIG1pbm9yIHJlYmFz
ZSBjb25mbGljdHMuIEkgaG9wZSB0byBnZXQgdGhpcyBzdGFnZWQgbmV4dCB3ZWVrIGlmIGF0DQo+
IGFsbCBwb3NzaWJsZS4NCj4gDQo+IFRoYW5rcywNCj4gLS1qcw0KPiANCg0KVGhhbmsgeW91IGZv
ciByZXZpZXdpbmchDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

