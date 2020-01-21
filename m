Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7351C2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 09:17:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83D6F20882
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 09:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="dJNgvTAi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83D6F20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itpfY-0000D6-Ab
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 04:17:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57143)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1itpdm-00074P-M6
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 04:16:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1itpdi-0004a1-UA
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 04:16:06 -0500
Received: from mail-eopbgr150117.outbound.protection.outlook.com
 ([40.107.15.117]:4778 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1itpdi-0004Yj-AY; Tue, 21 Jan 2020 04:16:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BUfWDXvjKAXd5oLDWq+UZEsJXsU6rpsNVTzaROcwL91hVMt7ePASA0MUMqPE8yVfnGPJ90iReuyiT9BAE8sPyCabCwIO8H9Mboz3nF9J5g8Ls2KDBFHtL9giX1K19SxB1Pdfl67Yp56fSTi8WUQTcaHBBYK/J7kVJtO1hxKSBLVAMfQOX/2xsb8gJvcf8gCVg66gRNGgkXIbJ/mT57FMaqq2EXjHA1ULdReak9doq0LO7pKViXb0Fb3S/R+QYPAt80P8O3NkdVudDBgNCHkqBp1ObJ7sUmIRfn2WSAlOO8He7EWVDLoHKD+Cc+Zpj3qFXcib2XS6iNIyej2i/qeyHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fTlAmSJtxJOlCnLyt+T5+1miwShNYOBhAOvZd14vDHQ=;
 b=YhO8/yU78AOPbjaTaYNkyibaSzSHyKnX5xcUsbM/Z5yDCYxv/r549/cTaPtFC3TXpk65K68I76cJxj9VRC446AdXLccSYtqa/WT8HZFqF4XmoSIIf/W5GkNr0bgyTDV5Zd2emgApVnQm2U23G46u1u5cHof/JEs7BZQYXFGuqcfX+mQtnkbRGeATk0rM/3g1v39JEPR/ULfAeJj8JFGBRefkXlzjPti1dcFsvsMwiIY2YrQWLVG7eH4cTVtSePyrWkFzbggL8LeZR5L40+F3FnokgK5iWwD7gmYU918jdhD5gFwAso7m2KzUFswieXji5ay3sk2YMerou5IcG9mHOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fTlAmSJtxJOlCnLyt+T5+1miwShNYOBhAOvZd14vDHQ=;
 b=dJNgvTAiaM+u3St+CEM2s5FVvaTPKR7E9FvP138OxbJ9Vu+KkAOe139BZ60tm/T8YQZECQ0VTB100NJMgXm7ncB2j5vJPN9CSD+RZBi7eh7LUltoBlCw8qPG5Nk3QDQNB7J52hhgPlzAfwRLDbtBdwE8BxK8QnuGr5UjC+hbLdc=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4865.eurprd08.prod.outlook.com (10.255.96.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.24; Tue, 21 Jan 2020 09:15:58 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2644.027; Tue, 21 Jan 2020
 09:15:58 +0000
Received: from [172.16.24.200] (185.231.240.5) by
 AM0PR0402CA0020.eurprd04.prod.outlook.com (2603:10a6:208:15::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.19 via Frontend
 Transport; Tue, 21 Jan 2020 09:15:57 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: Re: [PATCH v3 04/10] hbitmap: drop meta bitmaps as they are unused
Thread-Topic: [PATCH v3 04/10] hbitmap: drop meta bitmaps as they are unused
Thread-Index: AQHVtlOfjJFz1HLGS0Gzm2LfZzDgPKfzmLyAgACH1YD//9p+AIAABloAgAAogoCAAOAzAA==
Date: Tue, 21 Jan 2020 09:15:57 +0000
Message-ID: <2a47f7f4-8d29-1af1-2832-aebd4795b86f@virtuozzo.com>
References: <20191219100348.24827-1-vsementsov@virtuozzo.com>
 <20191219100348.24827-5-vsementsov@virtuozzo.com>
 <a42037d5-0d62-d916-a814-ba755b6ad9a4@redhat.com>
 <e6d654fb-7c04-c709-6b2a-3801ae1008d6@virtuozzo.com>
 <0cf94b1f-e7cb-081a-34ab-63a7d9ba80ce@redhat.com>
 <3b4f3ef4-adc7-1fda-44cc-b16b497cb110@virtuozzo.com>
 <166c4439-58cb-072b-b3b0-e51d4952673a@redhat.com>
In-Reply-To: <166c4439-58cb-072b-b3b0-e51d4952673a@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR0402CA0020.eurprd04.prod.outlook.com
 (2603:10a6:208:15::33) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20200121121556128
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7b9cdb83-acdb-46ce-e726-08d79e528683
x-ms-traffictypediagnostic: AM6PR08MB4865:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR08MB4865D0D86F2A3CF155050541C10D0@AM6PR08MB4865.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0289B6431E
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39850400004)(396003)(346002)(136003)(376002)(366004)(189003)(199004)(31696002)(16576012)(110136005)(71200400001)(316002)(2906002)(36756003)(26005)(53546011)(8936002)(86362001)(4326008)(16526019)(52116002)(6486002)(2616005)(956004)(186003)(54906003)(81156014)(107886003)(81166006)(31686004)(8676002)(5660300002)(508600001)(66946007)(66446008)(64756008)(66556008)(66476007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4865;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7jnhkGqML6VS5fgKTFmi0OmJvxJ6/yrzd7BtLCwZ7pGQaqVcz6zCTYAKB1HpWQHqK94gQVt10NbbqIwbD+thJsxWfJfd+e1LUioc9Xtg3EiQ5Hc5howf7gIRhsV5cG7aXG5AEzNrxo00BvYPvxetCOpu7EgbP4hHtwNKLBLQPdTLvGQWeL/XAcwmSY1XV1EIu3LsHm3RU6mJkwRFCd43AxubXHlTfNY9QyaoEIWARUB8ZQrg/KVjmMQEkOKDtcR4JgKwtspWBLR03niL0dtZQrY6O+d07vy/edv6AVh2DdJmqjknQyG3xQdUdx8d44OsBmw1rYOgUKQr79Pu+4O1wbZJ/ea2+PLeNbXjXBjUXRe5sx+3TQOaaTAaxUR8TcsdS51xYWacmqoPlF9TaPEJeO+rsQa4wKQ8Go0SWlJDFAsBowFReFIhuUwOfLvIZwJz
Content-Type: text/plain; charset="utf-8"
Content-ID: <860FBB70DD45BB4DB071825A6F2F2229@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b9cdb83-acdb-46ce-e726-08d79e528683
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2020 09:15:57.9111 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /1y2SIawByGAwcEgM1hWGe8AiKA8USfV+5ebrex3+F8q2fGzUawZqNhmWp40k9SCQ+6tZe7u4XXxoy2jk1K0fo167A549JwHUXEBRLkdT6o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4865
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.15.117
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
 "jsnow@redhat.com" <jsnow@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjAuMDEuMjAyMCAyMjo1MywgRXJpYyBCbGFrZSB3cm90ZToNCj4gT24gMS8yMC8yMCAxMToyOCBB
TSwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4gDQo+Pj4+IEknbSBhIGJp
dCBub3QgZm9sbG93IHdoYXQgeW91IG1lYW4uIEkgY2FuIGp1c3Qgbm90ZSwgdGhhdCBkaXJ0eS1i
aXRtYXAuYw0KPj4+PiBwYXJ0IG9mIG1ldGEgYml0bWFwcyB3YXMgcmVjZW50bHkgcmVtb3ZlZCwg
YW5kIGhiaXRtYXAuYyBwYXJ0IEkgZm9yZ290IHRvDQo+Pj4+IHJlbW92ZS4uLg0KPj4+DQo+Pj4g
WWVzLCBidXQgd2hvIHVzZWQgdGhhdCBkaXJ0eS1iaXRtYXAuYyBpbnRlcmZhY2U/wqAgQXMgZmFy
IGFzIEkgY2FuIHRlbGwsDQo+Pj4gbm9ib2R5Lg0KPj4NCj4+IFllcywgYXMgZmFyIGFzIEkga25v
dywgbm9ib2R5IGFuZCBuZXZlci4NCj4+DQo+Pj4NCj4+Pj4gTWV0YSBiaXRtYXBzIHdlcmUgaW50
ZW5kZWQgdG8gY29udHJvbCBsaXZlIG1pZ3JhdGlvbiBvZiBiaXRtYXBzIGFuZCB0bw0KPj4+PiBp
bXBsZW1lbnQgc29tZXRoaW5nIGxpa2UgcGFydGlhbCBzeW5jIG9mIGJpdG1hcHMgKHdyaXRlIHRv
IHFjb3cyIG9ubHkNCj4+Pj4gY2hhbmdlZCBwYXJ0IG9mIGJpdG1hcCksIGJ1dCBtaWdyYXRpb24g
aW1wbGVtZW50ZWQgaW4gb3RoZXIgd2F5DQo+Pj4+IChwb3N0Y29weSkgYW5kIHRoZSBzZWNvbmQg
dGhpbmcgd2FzIG5vdCBpbXBsZW1lbnRlZC4NCj4+Pg0KPj4+IE9LLsKgIEkgd2FzIHdvbmRlcmlu
ZyB3aHkgdGhleSB3ZXJlIGltcGxlbWVudGVkIHdpdGhvdXQgZXZlciBoYXZpbmcgYmVlbg0KPj4+
IHVzZWQgKGFzIGZhciBhcyBJIGNhbiB0ZWxsKS4NCj4+Pg0KPj4NCj4+IEl0IHdhcyB0b28gb3B0
aW1pc3RpYyBwcmVwYXJhdG9yeSBzZXJpZXMuDQo+IA0KPiBNYXRjaGVzIG15IHJlY29sbGVjdGlv
biAod2UgaGFkIHNldmVyYWwgaWRlYXMgYWJvdXQgaG93IHRvIHRhY2tsZSBpdDsgbWV0YS1iaXRt
YXBzIHdhcyBwcm9wb3NlZCBhcyBvbmUgaWRlYSBhbmQgdGhpcyBjb2RlIGxhbmRlZCwgYnV0IHdl
IG5ldmVyIGFjdHVhbGx5IGZpbmlzaGVkIHRoYXQgaWRlYSBiZWZvcmUgYSBiZXR0ZXIgb25lIHdh
cyBhY3R1YWxseSBjb2RlZCwgc28gdGhpcyBoYXMgYWx3YXlzIGJlZW4gZGVhZCBjb2RlKS4NCj4g
DQo+Pg0KPj4gKEkgY2FuIG5ldmVyIGZpbmFsbHkgdW5kZXJzdGFuZCwgc2VyaWVzIC0gd2hvIGEg
dGhleSBvciB3aGF0IGlzIGl0Pw0KPj4gwqDCoCBQbHVyYWwgb3Igc2luZ3VsYXI/DQo+IA0KPiBF
bmdsaXNoIGlzIGZ1bm55OyAic2VyaWVzIiBpcyBvbmUgb2YgdGhlIGZldyB3b3JkcyB0aGF0IHdv
cmtzIGFzIGJvdGggc2luZ3VsYXIgYW5kIHBsdXJhbCAoYW5vdGhlciBleGFtcGxlIGlzICJzaGVl
cCIpLg0KDQpPSywgdGhhbmtzKSBBY3R1YWxseSwgUnVzc2lhbiBoYXMgc3VjaCB3b3JkcyB0b28g
KNGI0YLQsNC90Ys9cGFudHMsINC90L7QttC90LjRhtGLPXNjaXNzb3JzLCBpbnRlcmVzdGluZyB0
aGF0IGZpcnN0IGV4YW1wbGVzDQp3aGljaCBjYW1lIGluIG15IG1pbmQgaGFzIHNhbWUgZmVhdHVy
ZSBpbiBFbmdsaXNoIHRvbykuDQoNCj4gDQo+PiBUaGV5IHdlcmUgdG9vIG9wdGltaXN0aWMgc2Vy
aWVzPyBTb3VuZHMgd2VpcmQuLg0KPiANCj4gTXkgc3BpbjogIlRoZSBvcmlnaW5hbCBzZXJpZXMg
d2FzIHRvbyBvcHRpbWlzdGljLiINCj4gDQo+PiDCoMKgIEFuZCBpZiBvbmUgc2VyaWVzIGlzIHNl
cmllcywgdGhhbiB3aGF0IGFib3V0IHNldmVyYWwgc2VyaWVzZXM/DQo+PiDCoMKgIE9LLCBsZXQn
cyBzYXksIGl0IHdhcyB0b28gb3B0aW1pc3RpYyBwcmVwYXJhdG9yeSBwYXRjaCBzZXQgOikNCj4+
DQo+Pg0KPiANCg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

