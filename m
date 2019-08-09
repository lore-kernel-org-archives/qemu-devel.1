Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A6A9C433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 07:51:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57CB520B7C
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 07:51:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="M8X9806M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57CB520B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvzgd-0007Ly-M3
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 03:51:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59065)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hvzfe-0006HX-51
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 03:50:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hvzfd-0007lq-3r
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 03:50:42 -0400
Received: from mail-eopbgr00107.outbound.protection.outlook.com
 ([40.107.0.107]:47750 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hvzfc-0007kX-OZ; Fri, 09 Aug 2019 03:50:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jCkc/9HFmMOikFvA6IrFVQNpO8zLP0H0w8CMSkc8VteE8jV+9PHqszDf59qFfZuGGmb/zuD+ypJSldKo1oJdmbVt/IdmLF/0Lg5P4mIUeVQgb8a2fp/HVVt96e5jdsy3Zkn9Jo1lnYABvOiYfejf+DtuScNGIaKEORH3D+d1hHeS5TnqsCPOf4oJocBQ4h/I9JGOPsoSBTqXz+lKOHU47TBFgQXi1yL9Tt7RdhYf9pnWfL0S5ZOZTmXbXkdYw3WTmrvsFM4Mf6c1fNQaJZiRgIsC4G0lpd09mKkwVVZzQh0HIv+oSkpBii4Pfgjh0R+TAAJgUnuOCH1RMuJpBfD3iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JC9ZgZWOHvaHmwDVMfSnInQ9eSQQs0p5T8ylHLrp8sk=;
 b=hjkVziV3iqncSdL+4Ao8/lbDPO6775IixtcpSnKwbBNtQp4L/AfeSJJQS1tdjBQ99DZ+igLSCqEcJ4x6TPyz3vhCpmpux9BA1+7ioEHJIjwx/YwpoxdOYRc+yfHj3OE+gp45nlU3cMVfRbTF1BpHGxz5z9ts3h8F8FT+n7eP+s5CSczTxUr3qnVHQSvAo8DuOuWDCkqjxKuZZefTfLMqubD7KEEA30ropIL5+qWXTDyH1YUQRTEbqjd9vc7fCOHZWkR5Wkk4ru34DiGR3j4UXHCoDtm2ohVjIciq8NwuOdsX1klAjJpZRLsPbJnFW+5qX5QlnG8YseSFBr/T+N1R9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JC9ZgZWOHvaHmwDVMfSnInQ9eSQQs0p5T8ylHLrp8sk=;
 b=M8X9806Mj1C/KdOgnsgrq1px0AnGRtX+AbcKNsjeTwmz7ihaxyiSZxlUBMmq5+m/eppG+6YZyYcl/sUs+IByqDVAzASIIHLsVRUTFNx8c/Nx3K6+7p0fDElOxMPj7Cf4y8C6ELYL+WmYIo6WoC6hrAe9y2WmJq2tMM73dZUyLRU=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5002.eurprd08.prod.outlook.com (10.255.17.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.20; Fri, 9 Aug 2019 07:50:38 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2157.015; Fri, 9 Aug 2019
 07:50:38 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH 3/8] block/io: handle alignment and max_transfer for
 copy_range
Thread-Index: AQHVTPc5+PHQMduDGEyAaN91ptys/abv8QyAgAKDRwA=
Date: Fri, 9 Aug 2019 07:50:38 +0000
Message-ID: <a7c7b0b2-53cb-f8a7-1917-a4d09cb8810e@virtuozzo.com>
References: <20190807080750.15950-1-vsementsov@virtuozzo.com>
 <20190807080750.15950-4-vsementsov@virtuozzo.com>
 <8472029e-a7e1-b5aa-d6d6-7fbfb39460c1@redhat.com>
In-Reply-To: <8472029e-a7e1-b5aa-d6d6-7fbfb39460c1@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0387.eurprd05.prod.outlook.com
 (2603:10a6:7:94::46) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190809105036552
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f5492d2a-7179-40bc-fb7a-08d71c9e450c
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5002; 
x-ms-traffictypediagnostic: DB8PR08MB5002:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB500254B9518BCA29694A18E5C1D60@DB8PR08MB5002.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 01244308DF
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(136003)(39850400004)(346002)(366004)(376002)(189003)(199004)(6246003)(7736002)(5660300002)(107886003)(478600001)(53936002)(6436002)(14454004)(36756003)(4326008)(99286004)(229853002)(31686004)(25786009)(6512007)(52116002)(66556008)(8676002)(3846002)(14444005)(256004)(66446008)(76176011)(26005)(6116002)(54906003)(486006)(110136005)(66476007)(81156014)(81166006)(64756008)(316002)(305945005)(6486002)(2501003)(446003)(66946007)(66066001)(102836004)(6506007)(386003)(8936002)(53546011)(31696002)(86362001)(186003)(71190400001)(71200400001)(2906002)(2616005)(11346002)(476003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5002;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: liGqkfV2wJ4QI1x9rsgaeETBSZf38m2L76rUHONkcCpwziR0vXYE71pdt6I9aV2Du2r64kHtspJNxGQetK7RVI/EH5pxEYBFyXORQrsf/2Mk2JLGoQ58MCZqE6KZIjembzJMs7c4rMKw4B/PL5l3v1Pi3LRg1X3P+Tu1fduqXP06B2Od5N7+W/WwKZ01s+TKtFOwjjNStxyaHzUlHnrrM93HG9UTBaJwqKm8qvXopQwTMQZ7lE/Yrdzmgo7/OpQMHnTtz1fh/X9ks4WfbVwiSdPgJfJdZWXqmAVdSG9bhaNwlRb4yLfXeBg7KLFjjyAEcwnnBIeY5e0r5ObQ1u/EuTY6C09ohNgXQqIc2MEDwnjDV3ePOiWpnqW06cfOoX2BAVDZQIB6pu9QRaj7ql2Q44NZQK7kSS4ZD/G9bVGPtVw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F3DA4E0F8176074E86E089C77B828068@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5492d2a-7179-40bc-fb7a-08d71c9e450c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2019 07:50:38.6885 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DzY4ZIcqfjNAkbHzfpJodkoepgINunQWqSjveLlzCV7vqMBU3JsUL2kQIORRfObNgDiLVox/nioATQwuCeYzML8YLmch2+PQSnhpMPuspHI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5002
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.0.107
Subject: Re: [Qemu-devel] [PATCH 3/8] block/io: handle alignment and
 max_transfer for copy_range
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
 "armbru@redhat.com" <armbru@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDcuMDguMjAxOSAyMDoyOCwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAwNy4wOC4xOSAxMDowNywg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IGNvcHlfcmFuZ2UgaWdub3Jl
cyB0aGVzZSBsaW1pdGF0aW9ucywgbGV0J3MgaW1wcm92ZSBpdC4gYmxvY2svYmFja3VwDQo+PiBj
b2RlIGhhbmRsZXMgbWF4X3RyYW5zZmVyIGZvciBjb3B5X3JhbmdlIGJ5IGl0c2VsZiwgbm93IGl0
J3Mgbm90IG5lZWRlZA0KPj4gbW9yZSwgZHJvcCBpdC4NCj4gDQo+IFNob3VsZG7igJl0IHRoaXMg
YmUgdHdvIHNlcGFyYXRlIHBhdGNoZXM/DQoNCk5vdCBhIHByb2JsZW0sIHdpbGwgZG8uDQoNCj4g
DQo+PiBTaWduZWQtb2ZmLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50
c292QHZpcnR1b3p6by5jb20+DQo+PiAtLS0NCj4+ICAgYmxvY2svYmFja3VwLmMgfCAxMSArKy0t
LS0tLS0tLQ0KPj4gICBibG9jay9pby5jICAgICB8IDQxICsrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKy0tLS0tLS0tDQo+PiAgIDIgZmlsZXMgY2hhbmdlZCwgMzUgaW5zZXJ0aW9ucygr
KSwgMTcgZGVsZXRpb25zKC0pDQo+IA0KPiBbLi4uXQ0KPiANCj4+IGRpZmYgLS1naXQgYS9ibG9j
ay9pby5jIGIvYmxvY2svaW8uYw0KPj4gaW5kZXggMDYzMDVjNmVhNi4uNWFiYmQwZmZmMiAxMDA2
NDQNCj4+IC0tLSBhL2Jsb2NrL2lvLmMNCj4+ICsrKyBiL2Jsb2NrL2lvLmMNCj4+IEBAIC0zMDA1
LDYgKzMwMDUsMTIgQEAgc3RhdGljIGludCBjb3JvdXRpbmVfZm4gYmRydl9jb19jb3B5X3Jhbmdl
X2ludGVybmFsKA0KPj4gICB7DQo+PiAgICAgICBCZHJ2VHJhY2tlZFJlcXVlc3QgcmVxOw0KPj4g
ICAgICAgaW50IHJldDsNCj4+ICsgICAgdWludDMyX3QgYWxpZ24gPSBNQVgoc3JjLT5icy0+Ymwu
cmVxdWVzdF9hbGlnbm1lbnQsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgIGRzdC0+YnMt
PmJsLnJlcXVlc3RfYWxpZ25tZW50KTsNCj4+ICsgICAgdWludDMyX3QgbWF4X3RyYW5zZmVyID0N
Cj4+ICsgICAgICAgICAgICBRRU1VX0FMSUdOX0RPV04oTUlOX05PTl9aRVJPKE1JTl9OT05fWkVS
TyhzcmMtPmJzLT5ibC5tYXhfdHJhbnNmZXIsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZHN0LT5icy0+YmwubWF4X3RyYW5zZmVyKSwN
Cj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIElOVF9NQVgpLCBh
bGlnbik7DQo+IA0KPiBJIHN1cHBvc2UgdGhlIG91dGVyIFFFTVVfQUxJR05fRE9XTigpIG1heSBy
ZXN1bHQgaW4gQG1heF90cmFuc2ZlciBvZiAwDQo+IChpbiB0aGVvcnksIGlmIG9uZeKAmXMgbWF4
X3RyYW5zZmVyIGlzIHNtYWxsZXIgdGhhbiB0aGUgb3RoZXLigJlzIGFsaWdubWVudCkuDQo+IA0K
PiBOb3QgbGlrZWx5LCBidXQgc2hvdWxkIHN0aWxsIGJlIGhhbmRsZWQuDQo+IA0KPiBUaGUgcmVz
dCBsb29rcyBnb29kIHRvIG1lLg0KPiANCj4gTWF4DQo+IA0KPj4gICAgICAgLyogVE9ETyBXZSBj
YW4gc3VwcG9ydCBCRFJWX1JFUV9OT19GQUxMQkFDSyBoZXJlICovDQo+PiAgICAgICBhc3NlcnQo
IShyZWFkX2ZsYWdzICYgQkRSVl9SRVFfTk9fRkFMTEJBQ0spKTsNCj4gDQoNCg0KLS0gDQpCZXN0
IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

