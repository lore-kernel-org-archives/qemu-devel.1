Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF07C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 17:05:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 388D621901
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 17:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="f+1OZTII"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 388D621901
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqhBb-0002V9-E4
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 13:05:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56081)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alxndr@bu.edu>) id 1hqhBK-0001vA-Qw
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 13:05:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1hqhBJ-0000IC-ID
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 13:05:30 -0400
Received: from mail-eopbgr700105.outbound.protection.outlook.com
 ([40.107.70.105]:30560 helo=NAM04-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1hqhBI-0000Gl-SP
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 13:05:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ifBRiB/78HdpTgA5exxRkbLeC8UTzhs+JeNczTfwQUjCMWb0sfi/0ClaUoKUnvR8d7WeexjvQJpJbJ4xeVcm3U4yX4NxKM9ZVLOKopG1lhkNWvmN0kSQ7IlngSC9CMkbhRJaf99gRKA+KFawslILH0mkM3OcxQdVQPCRezH3r834JflpIIjPJW6Ou1kIv5cUXynsa/UaaPpqUpKoffx2OGRruT9ct63ZgrzRon0i8zGHONGNrGp9V4M4Z9amM7iJL0LYwotdLneb8oE5NBZwv2pMYwVNQGEFFkFysBN2u0A1vtX7tarvWImPbfQwxQL0PUwY/873py7lfQMAUUbpeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EssTeWcG684oL2nGvGz+SbQc2yv1SOFCIKAlNJmStyk=;
 b=D/Bt+xgaPo2LTYYKCV1N2dnOLB3MD13MaAOjOK4rBD62GuhoO4aFtNEN5ioEbjiN4ZkpjYu1GYRyE0mSqkwhjMiCAR748d5ukWGN3bz7r9UmXbkr/cLdG5RzqdlzOY/kjvwSQ6osFsqjAtAqzENalO16m+0uLf5Eh3BTVAcjnWTwWrDALBY1NXpl6CVDU6UbgzYlyR6VKppNZblZ2t/SQSYnUhRGxSbIHeVPw35YLlUMph2yhUDHXS/hOJ2kEAiG/LG6lasGz0RoPpcw/N/Bn4kqZeBbR7xeYXC8R4ANJOhsidNmHdQj5N/R+6fvDx83aOruQWVykfpq8Ogf8ZBJTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=bu.edu;dmarc=pass action=none header.from=bu.edu;dkim=pass
 header.d=bu.edu;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EssTeWcG684oL2nGvGz+SbQc2yv1SOFCIKAlNJmStyk=;
 b=f+1OZTIIHKHzE5QoKW7Ri4QvsO5lI/M2FmlqtgABiwkSW2ONh9YTy0xRZCz/fqXOommKDHi5T8k9L2nkgb9PAp+udUKCYEeD3LeGOEEh+bialPwijGn6PA6PFq+Rjeyn3XaO3IQhGHFyTbcszuBW/1935xTdTANdeziUV8/7b0E=
Received: from CY4PR03MB2872.namprd03.prod.outlook.com (10.175.118.17) by
 CY4PR03MB2872.namprd03.prod.outlook.com (10.175.118.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.16; Thu, 25 Jul 2019 17:05:25 +0000
Received: from CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::25e1:d1e3:2ad8:e6b5]) by CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::25e1:d1e3:2ad8:e6b5%5]) with mapi id 15.20.2094.013; Thu, 25 Jul 2019
 17:05:25 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "jsnow@redhat.com"
 <jsnow@redhat.com>
Thread-Topic: [Qemu-devel] [RFC 13/19] fuzz: add ctrl vq support to virtio-net
 in libqos
Thread-Index: AQHVQphjneGWyeR1FUC3cWSGwtJT0abbhgeAgAALEIA=
Date: Thu, 25 Jul 2019 17:05:25 +0000
Message-ID: <b2503c69ad82bd13c1bab518154c6168e7eeb1cc.camel@bu.edu>
References: <20190725032321.12721-1-alxndr@bu.edu>
 <20190725032321.12721-14-alxndr@bu.edu>
 <51cc86ad-0dda-ada0-1c44-a6ac365bc4cf@redhat.com>
In-Reply-To: <51cc86ad-0dda-ada0-1c44-a6ac365bc4cf@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-originating-ip: [71.162.119.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3b2af0af-4211-46a1-c9c2-08d711224982
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:CY4PR03MB2872; 
x-ms-traffictypediagnostic: CY4PR03MB2872:
x-microsoft-antispam-prvs: <CY4PR03MB287292DF34F653A73313BB84BAC10@CY4PR03MB2872.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0109D382B0
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(346002)(366004)(376002)(136003)(396003)(39860400002)(189003)(199004)(6512007)(2906002)(53936002)(6246003)(25786009)(6506007)(305945005)(99286004)(476003)(66476007)(71190400001)(71200400001)(186003)(53546011)(2616005)(446003)(75432002)(8936002)(256004)(88552002)(2501003)(229853002)(3846002)(81166006)(6436002)(14444005)(36756003)(6116002)(66446008)(110136005)(68736007)(76116006)(478600001)(11346002)(316002)(91956017)(66946007)(66556008)(102836004)(81156014)(14454004)(4326008)(8676002)(64756008)(54906003)(486006)(7736002)(6486002)(86362001)(786003)(26005)(66066001)(5660300002)(118296001)(76176011)(42522002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR03MB2872;
 H:CY4PR03MB2872.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: a8mQob1KwTPoGd4qM/XtMcI9KtJJGnN6kKrDbYTfgLjKb9rbfdacct918znPyz7W68piRVCk724A/RoqECj7r9zrU4j+vu23XG4OimYYbjW9v7k5R+7Ms5BXf6huFbtSnJ65rATHznvtKNSvVU5f1vtoETFY/iBuw0Fin7WoW/YnuoTX2AdSKF2ca6iyOMccZEyplMhE/dcyax/VhWMc3TnyG6ufsPqPQ/1Zj9dnY3Iydjj/3oV3DBEuxgfIpoqDbCAtBkkfVWK8z0S2iLME/LAP0/9afK4BCdi3NmyEdaij2OCA4oCAFs3evARNWdm/jTtgu5fB+/1jwLB+8hMKJse3OmvaJXkZjQtcZzZyro2rG7XH6WxFJwugxodSjhbU2CpLb8Nm45fRDXaycAr258Hnwqmn6uhwRhzzZfZFFec=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0E32BC4224A8B04997AC7DDFF4D1F9E3@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b2af0af-4211-46a1-c9c2-08d711224982
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2019 17:05:25.5193 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: alxndr@bu.edu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2872
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.70.105
Subject: Re: [Qemu-devel] [RFC 13/19] fuzz: add ctrl vq support to
 virtio-net in libqos
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
Cc: "lvivier@redhat.com" <lvivier@redhat.com>,
 "thuth@redhat.com" <thuth@redhat.com>, "bsd@redhat.com" <bsd@redhat.com>,
 "superirishdonkey@gmail.com" <superirishdonkey@gmail.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gVGh1LCAyMDE5LTA3LTI1IGF0IDEyOjI1IC0wNDAwLCBKb2huIFNub3cgd3JvdGU6DQo+IA0K
PiBPbiA3LzI0LzE5IDExOjIzIFBNLCBPbGVpbmlrLCBBbGV4YW5kZXIgd3JvdGU6DQo+ID4gU2ln
bmVkLW9mZi1ieTogQWxleGFuZGVyIE9sZWluaWsgPGFseG5kckBidS5lZHU+DQo+IA0KPiBJcyB0
aGVyZSBzb21lIGV4cGxhbmF0aW9uIGZvciB3aHkgdGhlIGJlbG93IHBhdGNoIGRvZXMgd2hhdCB0
aGUNCj4gc3ViamVjdA0KPiBsaW5lIGNsYWltcyBmb3IgdGhlIHVuaW5pdGlhdGVkPw0KV2hlbiBt
dWx0aXF1ZXVlIG1vZGUgKFZJUlRJT19ORVRfRl9NUSkgaXMgZGlzYWJsZWQsIHZpcnRpby1uZXQg
c2V0cyB1cA0KdGhyZWUgcXVldWVzLiAwOnJlY2VpdmVxLCAxOnRyYW5zbWl0cSBhbmQgMjpjb250
cm9scS4gDQo+IEkgZG9uJ3Qga25vdyB3aHkgaW5jcmVhc2luZyB0aGUgbnVtYmVyIG9mIHF1ZXVl
cyBmcm9tIDIgdG8gMyBoZXJlIGlzDQo+IGNvcnJlY3QgaW4gdGhlIGdlbmVyYWwgY2FzZSwgT1Ig
d2h5IGl0IHdvdWxkICJhZGQgY3RybCB2cSBzdXBwb3J0Ii4NCj4gKE9yIHdoYXQgaXQgaGFzIHRv
IGRvIHdpdGggZnV6emluZywgaW4gZ2VuZXJhbC4pDQoNClByaW9yIHRvIHRoZSBjaGFuZ2UsIGFj
Y2Vzc2luZyB0aGUgY3RybCB2cSB0aHJvdWdoIFFPUywgd291bGQgdHJpZ2dlciBhDQpzZWdmYXVs
dCwgc2luY2Ugb25seSB0d28gcXVldWVzIHdlcmUgYWxsb2NhdGVkIHRvIFFWaXJ0aW9EZXZpY2Uq
DQppbnRlcmZhY2UtPnF1ZXVlcy4NCg0KQWxzbywgd2hlbiBWSVJUSU9fTkVUX0ZfTVEgaXMgZW5h
YmxlZCwgdGhlIG51bWJlciBvZiBxdWV1ZXMgaXMgMipOICsgMSwNCnNvIEkgdGhpbmsgaW4gdGhh
dCBjYXNlIG4tPm5fcXVldWVzIGlzIGFsc28gc2hvcnQgYnkgb25lIGluIHRoZSBjb2RlDQpiZWxv
dy4NCg0KPiBbT25seSByZXNwb25kaW5nIGJlY2F1c2UgdGhpcyBsYW5kZWQgaW4gdGVzdHMvbGli
cW9zLCB3aGljaCBJIGRvIHRyeQ0KPiB0bw0KPiBrZWVwIGFuIGV5ZSBvbiwgYnV0IHRoaXMgcGF0
Y2ggaXMgb3BhcXVlIHRvIG1lLiAtLWpzXQ0KPiANCj4gPiAtLS0NCj4gPiAgdGVzdHMvbGlicW9z
L3ZpcnRpby1uZXQuYyB8IDIgKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
LCAxIGRlbGV0aW9uKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL3Rlc3RzL2xpYnFvcy92aXJ0
aW8tbmV0LmMgYi90ZXN0cy9saWJxb3MvdmlydGlvLW5ldC5jDQo+ID4gaW5kZXggNjY0MDViNjQ2
ZS4uMjQ3YTBhMTdhOCAxMDA2NDQNCj4gPiAtLS0gYS90ZXN0cy9saWJxb3MvdmlydGlvLW5ldC5j
DQo+ID4gKysrIGIvdGVzdHMvbGlicW9zL3ZpcnRpby1uZXQuYw0KPiA+IEBAIC01MSw3ICs1MSw3
IEBAIHN0YXRpYyB2b2lkIHZpcnRpb19uZXRfc2V0dXAoUVZpcnRpb05ldA0KPiA+ICppbnRlcmZh
Y2UpDQo+ID4gICAgICBpZiAoZmVhdHVyZXMgJiAoMXUgPDwgVklSVElPX05FVF9GX01RKSkgew0K
PiA+ICAgICAgICAgIGludGVyZmFjZS0+bl9xdWV1ZXMgPSBxdmlydGlvX2NvbmZpZ19yZWFkdyh2
ZGV2LCA4KSAqIDI7DQo+ID4gICAgICB9IGVsc2Ugew0KPiA+IC0gICAgICAgIGludGVyZmFjZS0+
bl9xdWV1ZXMgPSAyOw0KPiA+ICsgICAgICAgIGludGVyZmFjZS0+bl9xdWV1ZXMgPSAzOw0KPiA+
ICAgICAgfQ0KPiA+ICANCj4gPiAgICAgIGludGVyZmFjZS0+cXVldWVzID0gZ19uZXcoUVZpcnRR
dWV1ZSAqLCBpbnRlcmZhY2UtPm5fcXVldWVzKTsNCj4gPiANCg0K

