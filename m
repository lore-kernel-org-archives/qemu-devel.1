Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 127F8C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 15:56:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE269222C6
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 15:56:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="g9pZ8ooJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE269222C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDW8R-0008Hc-W2
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 11:56:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58340)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iDVuj-0002Ds-92
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 11:42:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iDVuf-0008FC-59
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 11:42:38 -0400
Received: from mail-eopbgr140093.outbound.protection.outlook.com
 ([40.107.14.93]:5350 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iDUWj-0003Mv-Qp; Thu, 26 Sep 2019 10:13:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k15SkHMEh+mDZHjvHd5NhwBaqpAZci/tFMVBGVPPcVXVbz5Y8ZjpwmZPeo9rb9OPvPyBxY0xVK808lEwcaRTilzHRB77nrdiloe0lIswTYpqPzZcams3ysjMQLYb1Kn1SxAHalNBuVXznOK7L5p7ykBDVj8sGjTJmW7j7lKyS/drST1WmK/ncFHChw8twA1pDVkB5lGwNlSkRxPTFQ4M7+h+hWq4jHyW8n/ogOZ5o2Xp3LsyalfIKCvM3+J0zLwQqTpSwwOLxdYdDedfc6OW3PmzQo4BmURl7nuHaZgM/w5ebm7FlQig1dTkTVMkCT+Z1KxdvrQD9FyjRbfpQA7i+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pkDA4wifgGHfZJ0jQ10pi88jMmITbaAAEt078Ch21Lg=;
 b=RZV+Dh01XZdyLlpUhYnsKf9ufNsx34xDO8m/2C6C0FiwForVetsbYB5K56/fU+A4kfTSymwTXxdyCjimi+x9coDGOck+vghdv9+U15AgjFWmZu97yjgGct3TBun3bVOkCAINrw/SxHrcKo0YSaV9qMY3A0ywu3pUGeTuyB0FzN/M6waubZ5f8QGif6PVANGDVTOcdlXr69znpz9FotoN8zPWeMyiPINnXGPbttOL6nPIVDrm2SCr12byNxIW6vFiNsoNgTwai+vaP64KL/APnBe4CbGeyo7Rznc9OCVjMr6+UGYtwXz0mvQthfAuiCNbDOvGJ9HaE4YAYZy8yPPCbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pkDA4wifgGHfZJ0jQ10pi88jMmITbaAAEt078Ch21Lg=;
 b=g9pZ8ooJIOqqczohQQmwjM09I4lOhVwIG5GClLNj/qD+Y6XwixrpdDBrXJBmrkEfZf/omQGfP5wCIbiQYRJem/E8G21xu5OenXCOUQf92c7h164yY1FMIFOID9fTFUlqRzfNrKLlaNUNbHdxrPHr84HMY8yVF79IKgizRKCfAyM=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5466.eurprd08.prod.outlook.com (52.133.242.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.15; Thu, 26 Sep 2019 14:13:45 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2284.023; Thu, 26 Sep 2019
 14:13:45 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH 19/22] iotests: Use self.image_len in TestRepairQuorum
Thread-Topic: [PATCH 19/22] iotests: Use self.image_len in TestRepairQuorum
Thread-Index: AQHVb84YpwYV+MD+RU64z+o6LExA/Kc+CZkA
Date: Thu, 26 Sep 2019 14:13:45 +0000
Message-ID: <18a0f40d-7253-58a1-21e6-fb5a466f7e11@virtuozzo.com>
References: <20190920152804.12875-1-mreitz@redhat.com>
 <20190920152804.12875-20-mreitz@redhat.com>
In-Reply-To: <20190920152804.12875-20-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P191CA0019.EURP191.PROD.OUTLOOK.COM (2603:10a6:3:cf::29)
 To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190926171344070
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bae02021-7da3-4070-c432-08d7428bbe4e
x-ms-traffictypediagnostic: DB8PR08MB5466:
x-microsoft-antispam-prvs: <DB8PR08MB54667A8F419BD5EEABA30690C1860@DB8PR08MB5466.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2150;
x-forefront-prvs: 0172F0EF77
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(376002)(136003)(346002)(39850400004)(396003)(189003)(199004)(31696002)(6506007)(486006)(256004)(76176011)(2501003)(14444005)(6486002)(478600001)(14454004)(6436002)(2616005)(31686004)(476003)(99286004)(71200400001)(66446008)(66556008)(7736002)(5660300002)(305945005)(102836004)(66946007)(386003)(64756008)(66476007)(25786009)(52116002)(2906002)(26005)(4326008)(446003)(36756003)(66066001)(71190400001)(186003)(11346002)(6512007)(54906003)(6246003)(229853002)(316002)(110136005)(6116002)(3846002)(81166006)(81156014)(8676002)(8936002)(86362001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5466;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YfZm7DtL91PmXzXitFYWZS0iWySe0igSLPRp17EEbnM4mDRp08Cz3AlGKpQyO42KIG3A0UxQH7SfB+A1uf9ijystbROsMxx2D9xr4QRu3/yloj1kT5faJu5mpoidboug5RYRYlFbG4KwRhRPIfv4EzY+mgZ/xd9GFPrITefXAg2um3CS19wSxzf5eGnDOoLbifLNFE08meV3K8SEulLsVj7R0xne/wgA8Yyz6JTo659OGAX9x+RBYRCJI4ZQJQl5e7AHiD64le0yfNo/7LyC6IwOFvR0/Og48m2fiMGsEm15RRgYus00UTMrHqV/VrRZ+tbuqe+QrQ3vRlp+FaSY41rle/kXd4/gn3AL0y9DnRUdgh5EYE6w+8AZgT8iF5w4bBZGIbNJoio2mXsXRrMJYhNltCWobL6aO6RZ6Z5O/Io=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <D49791D70DB3FB42A19AF0200A148F53@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bae02021-7da3-4070-c432-08d7428bbe4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2019 14:13:45.8765 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: psGuKazXTwWDPmU/zX0EaukfE7K7QDCKDCHL8rmrfy2pIjOztfmL6ZVUsPzJyZsRejBDn6xzyXaNmzLT5NY2fiNo4GfYyEhBe5GjHGHjveI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5466
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.14.93
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjAuMDkuMjAxOSAxODoyOCwgTWF4IFJlaXR6IHdyb3RlOg0KPiAwNDEncyBUZXN0UmVwYWlyUXVv
cnVtIGhhcyBpdHMgb3duIGltYWdlX2xlbiwgbm8gbmVlZCB0byByZWZlciB0bw0KPiBUZXN0U2lu
Z2xlRHJpdmUuICAoVGhpcyBwYXRjaCBhbGxvd3MgdW5jb21tZW50aW5nIFRlc3RTaW5nbGVEcml2
ZSB0bw0KDQp5b3UgbWVhbiBjb21tZW50aW5nDQoNCj4gc3BlZWQgdXAgMDQxIGR1cmluZyB0ZXN0
IHRlc3RpbmcuKQ0KDQp3ZSBkZWZpbml0ZWx5IHdhbnQgYSB3YXkgdG8gcnVuIGEgc3Vic2V0IG9m
IHRlc3QgY2FzZXMuDQoNCkkgdXN1YWxseSBkbyBzL2RlZiB0ZXN0L2RlZiBudGVzdC8sIGFuZCB0
aGVuIHNldCBuZWVkZWQgdGVzdC1jYXNlIGJhY2sgdG8NCidkZWYgdGVzdCcNCg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogTWF4IFJlaXR6IDxtcmVpdHpAcmVkaGF0LmNvbT4NCj4gLS0tDQo+ICAgdGVz
dHMvcWVtdS1pb3Rlc3RzLzA0MSB8IDIgKy0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS90ZXN0cy9xZW11LWlvdGVz
dHMvMDQxIGIvdGVzdHMvcWVtdS1pb3Rlc3RzLzA0MQ0KPiBpbmRleCBjYTEyNmRlM2ZmLi4yMGFl
OTc1MGI3IDEwMDc1NQ0KPiAtLS0gYS90ZXN0cy9xZW11LWlvdGVzdHMvMDQxDQo+ICsrKyBiL3Rl
c3RzL3FlbXUtaW90ZXN0cy8wNDENCj4gQEAgLTg4MCw3ICs4ODAsNyBAQCBjbGFzcyBUZXN0UmVw
YWlyUXVvcnVtKGlvdGVzdHMuUU1QVGVzdENhc2UpOg0KPiAgICAgICAgICAgIyBBZGQgZWFjaCBp
bmRpdmlkdWFsIHF1b3J1bSBpbWFnZXMNCj4gICAgICAgICAgIGZvciBpIGluIHNlbGYuSU1BR0VT
Og0KPiAgICAgICAgICAgICAgIHFlbXVfaW1nKCdjcmVhdGUnLCAnLWYnLCBpb3Rlc3RzLmltZ2Zt
dCwgaSwNCj4gLSAgICAgICAgICAgICAgICAgICAgIHN0cihUZXN0U2luZ2xlRHJpdmUuaW1hZ2Vf
bGVuKSkNCj4gKyAgICAgICAgICAgICAgICAgICAgIHN0cihzZWxmLmltYWdlX2xlbikpDQoNCnll
cywgc2VlbXMgVGVzdFNpbmdsZURyaXZlLmltYWdlX2xlbiBpcyBhIGNvcHktcGFzdGluZyBtaXN0
YWtlIGhlcmUuLg0KDQo+ICAgICAgICAgICAgICAgIyBBc3NpZ24gYSBub2RlIG5hbWUgdG8gZWFj
aCBxdW9ydW0gaW1hZ2UgaW4gb3JkZXIgdG8gbWFuaXB1bGF0ZQ0KPiAgICAgICAgICAgICAgICMg
dGhlbQ0KPiAgICAgICAgICAgICAgIG9wdHMgPSAibm9kZS1uYW1lPWltZyVpIiAlIHNlbGYuSU1B
R0VTLmluZGV4KGkpDQo+IA0KDQoNClJldmlld2VkLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dp
ZXZza2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+DQoNCi0tIA0KQmVzdCByZWdhcmRzLA0K
VmxhZGltaXINCg==

