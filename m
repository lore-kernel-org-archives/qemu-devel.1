Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D918FC4CECE
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 09:34:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A753720862
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 09:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="NQ9wHBTj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A753720862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iA9sL-00064u-7N
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 05:34:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36303)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iA9qJ-00051L-90
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 05:32:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iA9qH-0002re-PL
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 05:32:14 -0400
Received: from mail-eopbgr140097.outbound.protection.outlook.com
 ([40.107.14.97]:35200 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iA9qG-0002qC-U0; Tue, 17 Sep 2019 05:32:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cGj99LVWW2pdsntcCXraZgK8Zd2myRfbWbwcJuX7NhapBqVQMoQtQ/Mv7iXu2qkNtfVeBFICEkKLwaD3M/jIGJxDxCJ9JSXr8SukxpjAKGxjKpa44bSgfbXgLySfDvpksIE20KcEzZux01HMyphqDFjk7uc0WmFiNBX4D6I8r2AKtI+yYBlZ+7UVXzT9nZK1Q8feJZqnxiNi74DdZ4XLw+v+xh283fsVRowsxq9gFHXJ0pQEgFijB4kUHFUpBelt33EvZ6dQCcvq4oz+vL8J8LqLu80T5k1NmF391EOhqEW1FfFDnXKMwPoci9ZLuTebckSVkzrqw6ydP8Sqr4XhAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VW9zk3JtShBQxaWQMa62ugtPMKhK2gG6aFYZGpNlOkA=;
 b=HWPU1zDS3qYAbYOxLwrODHAiPk3Y2vJbx6HVT/v4xPxvPZ8dIT1Yj1lYD++aNatwzl7l+EW2vdz7k3rudOPjzs3oGf3jY0j5TetS1uHwZ4TXdOcDrwSTlqvCbwASkjgsSbvNwWtsybTL4E+aJ12OnMdUatWVdutWDRWwFzMPOtTBRs2L/tacVLzGr97evwZ8+g9gdqUxGrf578SVL0WtvjKo+aDs2wUsGz+wvFU84hxe0o5rME5Z52EUp2P9aNZrSfoFCkEAJ5sf4sUJ71VNrtkDWH6T7Vu2lBV4K3Fvw0y1N/C73BbVOQiIZX9P77eX7lIbVF5MEaApqdc7dwgt3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VW9zk3JtShBQxaWQMa62ugtPMKhK2gG6aFYZGpNlOkA=;
 b=NQ9wHBTjiT4TzYJRtoP6MfSAZWqS5D4ZFmko8DkVqdS5dLMfgOzk1zRwGdvxlzeWYvis/getwO1ANdwq1qrnDikNVHS8yRYV0xJUhxoI3R4NMJa1oG8t66WKC5+pC2DLn6mJndWAK5xgqDXu17zWl01QWArujy8FhZhUoYHAx24=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5116.eurprd08.prod.outlook.com (10.255.17.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.15; Tue, 17 Sep 2019 09:32:07 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2263.023; Tue, 17 Sep 2019
 09:32:06 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [PATCH v5 0/5] qcow2: async handling of fragmented io
Thread-Index: AQHVbLeo76n3Ba9lJkqJlS+3Y8+k26cvnBgA
Date: Tue, 17 Sep 2019 09:32:06 +0000
Message-ID: <3a62c609-893a-3f2c-f9f9-0fcb165a2c6a@virtuozzo.com>
References: <20190916175324.18478-1-vsementsov@virtuozzo.com>
In-Reply-To: <20190916175324.18478-1-vsementsov@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0214.eurprd05.prod.outlook.com
 (2603:10a6:3:fa::14) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190917123204360
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6e84debe-6ffa-4f37-58da-08d73b51e7fd
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:DB8PR08MB5116; 
x-ms-traffictypediagnostic: DB8PR08MB5116:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB511658DD0B2706A7254D0728C18F0@DB8PR08MB5116.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 01630974C0
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(39850400004)(136003)(346002)(376002)(366004)(53754006)(199004)(189003)(4326008)(2616005)(476003)(6512007)(5660300002)(6436002)(2906002)(52116002)(486006)(5640700003)(66476007)(64756008)(66946007)(66556008)(81156014)(8676002)(66446008)(31686004)(76176011)(14454004)(86362001)(478600001)(229853002)(966005)(31696002)(81166006)(446003)(11346002)(256004)(2501003)(2351001)(71200400001)(25786009)(71190400001)(3846002)(107886003)(36756003)(8936002)(6116002)(6486002)(6916009)(6246003)(6506007)(54906003)(6306002)(102836004)(66066001)(7736002)(26005)(386003)(305945005)(99286004)(186003)(316002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5116;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5PeC2F/qZI4GmWn7mDBtV/7ls5Wdj3Q+eAz6aowNjpGln2f9b8rF0fVd68aQPB85C+fcU1yW92b0oyMGZ/kGcUhs+ZRWOpW2+dH3UEU7uhL3ouLdZ0sw68RYxIkTpVVX25nR9W4hneDVMX6DVEY8ZysZ++ri546lW8BWbaogYMi3Y4yG4Qnq2wKN8wuHiqJ9n3z6o7Ztp3hCGdkSyDeEoJl8dXZFlkLiR0Cu5lbJPROvt/e+Kh5QAonH2JOkZXksaWHaGzzmrPhp9yw+XkHa5lmmf8vCyA6UD05hqlyLMDoLNwm4a9hrnRQvN1cogge9kRM1CqhKLMstB4Dwy4ldMPQk/bin+BALvfhAJWK8KL2VUr/EnaGNyzCed8RtKgn8IRm7U92LHgAnOaDhKzVBFVNLy08RCMjlEizFNAnt4Po=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1C32F770D7185F469ABA281A229D39F6@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e84debe-6ffa-4f37-58da-08d73b51e7fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2019 09:32:06.8886 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PbEGqzyedrCUm20dElcf6GKcUIAW1NPe/ouh6sxFuY96cE7GwkUDtKXhN+8hvC1qi3G8JkFpYRkDmGbPF9QqlP1VKB7TVOnXfutRglBF7SU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5116
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.14.97
Subject: Re: [Qemu-devel] [PATCH v5 0/5] qcow2: async handling of fragmented
 io
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTYuMDkuMjAxOSAyMDo1MywgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4g
SGkgYWxsIQ0KPiANCj4gSGVyZSBpcyBhbiBhc3luY2hyb25vdXMgc2NoZW1lIGZvciBoYW5kbGlu
ZyBmcmFnbWVudGVkIHFjb3cyDQo+IHJlYWRzIGFuZCB3cml0ZXMuIEJvdGggcWNvdzIgcmVhZCBh
bmQgd3JpdGUgZnVuY3Rpb25zIGxvb3BzIHRocm91Z2gNCj4gc2VxdWVudGlhbCBwb3J0aW9ucyBv
ZiBkYXRhLiBUaGUgc2VyaWVzIGFpbSBpdCB0byBwYXJhbGxlbGl6ZSB0aGVzZQ0KPiBsb29wcyBp
dGVyYXRpb25zLg0KPiBJdCBpbXByb3ZlcyBwZXJmb3JtYW5jZSBmb3IgZnJhZ21lbnRlZCBxY293
MiBpbWFnZXMsIEkndmUgdGVzdGVkIGl0DQo+IGFzIGRlc2NyaWJlZCBiZWxvdy4NCj4gDQo+IHY1
OiBmaXggMDI2IGFuZCByZWJhc2Ugb24gTWF4J3MgYmxvY2sgYnJhbmNoIFtwZXJmIHJlc3VsdHMg
bm90IHVwZGF0ZWRdOg0KPiANCj4gMDE6IG5ldywgcHJlcGFyZSAwMjYgdG8gbm90IGZhaWwNCj4g
MDM6IC0gZHJvcCByZWFkX2VuY3J5cHRlZCBibGtkYmcgZXZlbnQgW0tldmluXQ0KPiAgICAgIC0g
YXNzZXJ0KCh4ICYgKEJEUlZfU0VDVE9SX1NJWkUgLSAxKSkgPT0gMCkgLT4gYXNzZXJ0KFFFTVVf
SVNfQUxJR05FRCh4LCBCRFJWX1NFQ1RPUl9TSVpFKSkgW3JlYmFzZV0NCj4gICAgICAtIGZ1bGwg
aG9zdCBvZmZzZXQgaW4gYXJndW1lbnQgb2YgcWNvdzJfY29fZGVjcnlwdCBbcmViYXNlXQ0KPiAw
NDogLSBzdWJzdGl0dXRlIHJlbWFpbmluZyBxY293Ml9jb19kb19wd3JpdGV2IGJ5IHFjb3cyX2Nv
X3B3cml0ZXZfdGFzayBpbiBjb21tZW50IFtNYXhdDQo+ICAgICAgLSBmdWxsIGhvc3Qgb2Zmc2V0
IGluIGFyZ3VtZW50IG9mIHFjb3cyX2NvX2VuY3J5cHQgW3JlYmFzZV0NCj4gMDU6IC0gTm93IHBh
dGNoIGRvbid0IGFmZmVjdCAwMjYgaW90ZXN0LCBzbyBpdHMgb3V0cHV0IGlzIG5vdCBjaGFuZ2Vk
DQo+IA0KPiBSZWJhc2UgY2hhbmdlcyBzZWVtcyB0cml2aWFsLCBzbywgSSd2ZSBrZXB0IHItYiBt
YXJrcy4NCj4gDQo+IEJhc2VkLW9uOiBodHRwczovL2dpdGh1Yi5jb20vWGFuQ2xpYy9xZW11Lmdp
dCBibG9jaw0KDQpOb3cgYmFzZWQgb24gbWFzdGVyLg0KDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMs
DQpWbGFkaW1pcg0K

