Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AFF8C76188
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 14:44:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D5ED2085A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 14:44:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="H1Bg6+hL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D5ED2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoU7D-0001L4-6B
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 10:44:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53243)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hoU71-0000s8-RW
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 10:43:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hoU70-0002qw-Qq
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 10:43:55 -0400
Received: from mail-eopbgr50110.outbound.protection.outlook.com
 ([40.107.5.110]:57208 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1hoU6y-0002of-5c; Fri, 19 Jul 2019 10:43:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cwILQeRiqz3r1BgH2dObrwrS9zlbxyAbtExh4Ox1X0ilR09PU2Jd9BTZuo6vR5C6yW7DKbIy0NB3vHCxMl3pg4r/U66TjGXfEW3Bo7f0a4aUG5H95A0yo1nbd74fyO2Ejr2hF6pOj8KzsHNKyjF4f03JU+hrruExrZAwLb/B3FuqX9YL/vVOoYgA4HVuGtvFVyWuOz5ZurZM8DoSFX2YA2FaqhfyOoHGXOJzE0WtT0S/3O8pKHWanneNL1SJxyr91nwoehrWaBB1i3QShGiaTlnGjFTD+IIGeJiZWAAT2lZkJ5sIGtWPbixSBJrIhJt/n8JwOCEWAMLm+AjM7HHjyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+SaYIn84nZS4hMqag1QkgMAiksvBnZ1bqPFqW9i1Hos=;
 b=aBi9PF5CcKlMfGWa+0r/IN1+hI+gjm84KJSeJZULy5y7GS7/z4VVFr431H60lRkVqeBvSs+Fyf6HArDh+kQYn+XG4f3V/sE0xt0e4ARtEuEnu4SdnzVXneDzqgnZiPiZWvwOh5dWEDKHbTqiYkG0l4ECYqihZQV6EWu7UMmEhfnNY5VvCMnDwK4PxA4NUNxQ/NDhXcl1SxULVt7Eo1the2yAExpjzQqMwjpECkfYvt3QNif9v0joJygOZA5Iej37iuqh1JQvh0sac6ibd9NzhW0szigB9XNmnaWK67n0O3WfmVUwtbANm/+nqeDXBPnziorxnfl8KmF/kgHVDnTb7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=virtuozzo.com;dmarc=pass action=none
 header.from=virtuozzo.com;dkim=pass header.d=virtuozzo.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+SaYIn84nZS4hMqag1QkgMAiksvBnZ1bqPFqW9i1Hos=;
 b=H1Bg6+hLdg1qEBT902dzHT1WQ1qyZBrCy4oqsg5Qp8syVGkDmG7TpJpj6H0AoGmBQNwt+uuCZDoVz67N3g96EtSLT3vjWHsP9oLu6gFlKlJJr0jCgA+D4BeEkc0U3KRZOqzlXpY5HLVNSL9Hrsz1f8x2N02eKiu7hlfERR5BI1U=
Received: from VI1PR08MB4399.eurprd08.prod.outlook.com (20.179.28.141) by
 VI1PR08MB2669.eurprd08.prod.outlook.com (10.175.245.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.14; Fri, 19 Jul 2019 14:43:47 +0000
Received: from VI1PR08MB4399.eurprd08.prod.outlook.com
 ([fe80::4c3d:79b3:a884:18c4]) by VI1PR08MB4399.eurprd08.prod.outlook.com
 ([fe80::4c3d:79b3:a884:18c4%3]) with mapi id 15.20.2073.012; Fri, 19 Jul 2019
 14:43:47 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [PATCH v4 7/7] block/nbd: NBDReply is used being uninitialized
Thread-Index: AQHVPhX6yHnO2fi6H020bxQ0/FYE6abSAfoAgAAClYA=
Date: Fri, 19 Jul 2019 14:43:47 +0000
Message-ID: <c0d5513f-5db8-c1db-166c-bf20b201dc85@virtuozzo.com>
References: <1563529204-3368-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1563529204-3368-8-git-send-email-andrey.shinkevich@virtuozzo.com>
 <a4214009-e9ba-2f67-138b-30ce31f7905f@redhat.com>
In-Reply-To: <a4214009-e9ba-2f67-138b-30ce31f7905f@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0501CA0011.eurprd05.prod.outlook.com
 (2603:10a6:3:1a::21) To VI1PR08MB4399.eurprd08.prod.outlook.com
 (2603:10a6:803:102::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7e26b6fe-5d57-4bab-e6c0-08d70c5781c8
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:VI1PR08MB2669; 
x-ms-traffictypediagnostic: VI1PR08MB2669:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR08MB2669B9AB9F298EDF7FBBF5E2F4CB0@VI1PR08MB2669.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:372;
x-forefront-prvs: 01039C93E4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(366004)(39850400004)(376002)(396003)(136003)(199004)(189003)(386003)(446003)(11346002)(66446008)(53546011)(44832011)(102836004)(6306002)(66946007)(64756008)(76176011)(2501003)(26005)(2616005)(6436002)(486006)(66556008)(31696002)(6246003)(476003)(7736002)(86362001)(305945005)(8676002)(5660300002)(81156014)(8936002)(53936002)(66476007)(52116002)(6512007)(6506007)(14444005)(186003)(6486002)(2906002)(68736007)(256004)(81166006)(25786009)(54906003)(99286004)(110136005)(71200400001)(14454004)(71190400001)(4326008)(316002)(478600001)(966005)(229853002)(36756003)(31686004)(66066001)(6116002)(3846002)(2201001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB2669;
 H:VI1PR08MB4399.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IBjHK3H+frLClElvAVBhQM/ygXOaj/o2jGXPFCTDmWCl0dW7gD+niv46suX/2+Jk1EPYLlL02Hpv9F3NFrBZSKMiq1fvfwRg69LGrV0y4mlEil4UdrhbBqde4Qq/Aq8Vyfj2Ymwv9b3IomT63TbzN1ypWW14cL6lKfay2wr7KkNFeNQLzFcorI9hxTTKySJo7b9xkRDTO4H66XaGovh+Y1bNsvUE98jmi/VKnEm7if+atYFhce15gK+7qEBHnrVpLPfjqSzXdlmJgk4Nm2xj8rUhwl26fxIHQkT2AQa1BOPdRbH/VlNVib+xKlsnKhxgWqyW+KXJSyvXjN5m1/H2Vwiw/N2qedvrIqLpmFWVgwMUPvEjNr036DIvzLTsI7wnnHT5hcErEymDRpdDrYRlFOsd4Y6JtggMArhEd3DR8QE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BA15F01D5023754FB4F8F55DCAA7004B@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e26b6fe-5d57-4bab-e6c0-08d70c5781c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2019 14:43:47.6958 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: andrey.shinkevich@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2669
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.5.110
Subject: Re: [Qemu-devel] [PATCH v4 7/7] block/nbd: NBDReply is used being
 uninitialized
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
 John Snow <jsnow@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>,
 =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDE5LzA3LzIwMTkgMTc6MzQsIEVyaWMgQmxha2Ugd3JvdGU6DQo+IE9uIDcvMTkvMTkg
NDo0MCBBTSwgQW5kcmV5IFNoaW5rZXZpY2ggd3JvdGU6DQo+PiBJbiBjYXNlIG5iZF9jb19yZWNl
aXZlX29uZV9jaHVuaygpIGZhaWxzIGluDQo+PiBuYmRfcmVwbHlfY2h1bmtfaXRlcl9yZWNlaXZl
KCksICdOQkRSZXBseSByZXBseScgcGFyYW1ldGVyIGlzIHVzZWQgaW4NCj4+IHRoZSBjaGVjayBu
YmRfcmVwbHlfaXNfc2ltcGxlKCkgd2l0aG91dCBiZWluZyBpbml0aWFsaXplZC4gVGhlIGlvdGVz
dA0KPj4gMDgzIGRvZXMgbm90IHBhc3MgdW5kZXIgdGhlIFZhbGdyaW5kOiAkLi9jaGVjayAtbmJk
IC12YWxncmluZCAwODMuDQo+PiBUaGUgYWx0ZXJuYXRpdmUgc29sdXRpb24gaXMgdG8gc3dhcCB0
aGUgb3BlcmFuZHMgaW4gdGhlIGNvbmRpdGlvbjoNCj4+ICdpZiAocy0+cXVpdCB8fCBuYmRfcmVw
bHlfaXNfc2ltcGxlKHJlcGx5KSknDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogQW5kcmV5IFNoaW5r
ZXZpY2ggPGFuZHJleS5zaGlua2V2aWNoQHZpcnR1b3p6by5jb20+DQo+PiAtLS0NCj4+ICAgYmxv
Y2svbmJkLmMgfCAyICstDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBk
ZWxldGlvbigtKQ0KPiANCj4gSHVoLiBWZXJ5IHNpbWlsYXIgdG8NCj4gaHR0cHM6Ly9saXN0cy5n
bnUub3JnL2FyY2hpdmUvaHRtbC9xZW11LWRldmVsLzIwMTktMDcvbXNnMDM3MTIuaHRtbCwgYnV0
DQo+IGFmZmVjdHMgYSBkaWZmZXJlbnQgZnVuY3Rpb24uIEkgY2FuIHF1ZXVlIHRoaXMgb25lIHRo
cm91Z2ggbXkgTkJEIHRyZWUNCj4gdG8gZ2V0IGJvdGggaW4gbXkgcmMyIHB1bGwgcmVxdWVzdC4N
Cj4gDQo+IFJldmlld2VkLWJ5OiBFcmljIEJsYWtlIDxlYmxha2VAcmVkaGF0LmNvbT4NCj4gDQoN
Ck1hbnkgdGhhbmtzLA0KQW5kcmV5DQoNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvYmxvY2svbmJkLmMg
Yi9ibG9jay9uYmQuYw0KPj4gaW5kZXggODFlZGFiYi4uODQ4MGFkNCAxMDA2NDQNCj4+IC0tLSBh
L2Jsb2NrL25iZC5jDQo+PiArKysgYi9ibG9jay9uYmQuYw0KPj4gQEAgLTc4Niw3ICs3ODYsNyBA
QCBzdGF0aWMgaW50IG5iZF9jb19yZWNlaXZlX2NtZHJlYWRfcmVwbHkoQkRSVk5CRFN0YXRlICpz
LCB1aW50NjRfdCBoYW5kbGUsDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBpbnQgKnJlcXVlc3RfcmV0LCBFcnJvciAqKmVycnApDQo+PiAgIHsNCj4+ICAgICAg
IE5CRFJlcGx5Q2h1bmtJdGVyIGl0ZXI7DQo+PiAtICAgIE5CRFJlcGx5IHJlcGx5Ow0KPj4gKyAg
ICBOQkRSZXBseSByZXBseSA9IHt9Ow0KPj4gICAgICAgdm9pZCAqcGF5bG9hZCA9IE5VTEw7DQo+
PiAgICAgICBFcnJvciAqbG9jYWxfZXJyID0gTlVMTDsNCj4+ICAgDQo+Pg0KPiANCg0KLS0gDQpX
aXRoIHRoZSBiZXN0IHJlZ2FyZHMsDQpBbmRyZXkgU2hpbmtldmljaA0K

