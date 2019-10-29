Return-Path: <SRS0=qR42=YW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C48F6CA9EAE
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 12:06:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77C9D208E3
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 12:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="kDFRKmZK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77C9D208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPQGi-0007IR-Cl
	for qemu-devel@archiver.kernel.org; Tue, 29 Oct 2019 08:06:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43542)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iPQFS-0006AL-Jf
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 08:05:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iPQFQ-0002DA-NG
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 08:05:18 -0400
Received: from mail-eopbgr10100.outbound.protection.outlook.com
 ([40.107.1.100]:62214 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iPQFQ-0002C2-B7; Tue, 29 Oct 2019 08:05:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qq309HTTTqQwNh8a8baIjWjB4WZuzcD4k/m6sJrxYnxJOKWJ4B3FAvG/glRP7gdBWZc7a3pxdsvP0DFZk35LKphKWgZKajI+Ew330Q5w9SrsJ+CoG/VhL59VdJ8CmLPxh1+YYzMObtpv2uKAEycW+2i47NU6caVuXmTZ184HQEyOQJXSSosQBZ7A/xtFDe/7nD9vgRi1yBIwtLu/yhulqB+VWJivbzWkA/08vaxpITvnmjTB7aJ8XAs90vF9klVFKa3lC9coDuAsjxFRmLLhaP5C9I4nFUnmGICmBnoQU3F+Kk/WPMx310GcnxGqF20H0vuHjZfnai/DBC0OJmtYQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JyS2xhmtJtMhDaLEnha1Ba05KpBW6G/7duYbKzP5T08=;
 b=HhYXsPpCaUCOT/9rRCgQtkpw8yKh/2qUr7BjCWHCLPU9cztGrq34RI8cnp8EtFTt24lT6wGjt6/Ewwo4H800EhLabOfiWFc3Zg4gXS4gkjdWc8MlGo2r01k2fEqHZt2WFeedsVK3JN5F1bIc7nlXAl0vdFS255FsnFdm9zOT9TISrTqqArOe48TFleuxuXcHIAGZYlE8auR2sJcsXAQLd9sR0uxf3+gn6KD+UnzKys4Y22p0zbWVlaC2FsQl4muAAn3aWEfxeI2z7A4TRUX2sa79E4AKCshvVmVhCL2GKZrWajfrZTmS9W/R86vXwsUgC7H1exqukroKqBYxeWtMpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JyS2xhmtJtMhDaLEnha1Ba05KpBW6G/7duYbKzP5T08=;
 b=kDFRKmZKtb9SL6dhQEOVL8AMAq2a+AvnMl1SXoS+petF+XBsFGxLinBJUpSg8zbpXfHZV/KTkWCyhlSKJiFeP1IeLuXSs9nLSCqSVf+EnFYFBmj7O5C5dGAI7dEmRp+9yU6YssfuUzm1vO6vi26HaEDh5TxxImo9ZZOnjnItlkg=
Received: from AM0PR08MB4097.eurprd08.prod.outlook.com (20.178.202.217) by
 AM0PR08MB4114.eurprd08.prod.outlook.com (20.178.202.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Tue, 29 Oct 2019 12:05:13 +0000
Received: from AM0PR08MB4097.eurprd08.prod.outlook.com
 ([fe80::6844:bb8c:7d2c:b119]) by AM0PR08MB4097.eurprd08.prod.outlook.com
 ([fe80::6844:bb8c:7d2c:b119%6]) with mapi id 15.20.2387.025; Tue, 29 Oct 2019
 12:05:13 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Stefan
 Hajnoczi <stefanha@redhat.com>
Subject: Re: [RFC 0/3] block/file-posix: Work around XFS bug
Thread-Topic: [RFC 0/3] block/file-posix: Work around XFS bug
Thread-Index: AQHVixrVzIJNY5LqnE6V3J8eZcL1nqdub/GAgAF4sACAAAXuAIABZygAgAAxigCAAAIFAIAAAr6A
Date: Tue, 29 Oct 2019 12:05:13 +0000
Message-ID: <319e9b81-407b-62d0-2f79-d12e0b24e457@virtuozzo.com>
References: <20191025095849.25283-1-mreitz@redhat.com>
 <20191027123555.GN4472@stefanha-x1.localdomain>
 <20191028110408.GB3579@localhost.localdomain>
 <44565375-b051-e782-4988-c3e0b1745e37@virtuozzo.com>
 <9780d020-e573-866f-dce4-d99d73f1f5e8@redhat.com>
 <98a5da91-d018-13e1-cf5c-168d7348117b@virtuozzo.com>
 <b93e2b5c-b245-e8eb-bd9e-cbde46290544@redhat.com>
In-Reply-To: <b93e2b5c-b245-e8eb-bd9e-cbde46290544@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0183.eurprd05.prod.outlook.com
 (2603:10a6:3:f8::31) To AM0PR08MB4097.eurprd08.prod.outlook.com
 (2603:10a6:208:132::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191029150511181
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 19f9a1ef-0969-4764-4962-08d75c6840c7
x-ms-traffictypediagnostic: AM0PR08MB4114:
x-ms-exchange-purlcount: 2
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR08MB41149272A5A670EE0B6B61E4C1610@AM0PR08MB4114.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0205EDCD76
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39840400004)(136003)(366004)(396003)(376002)(346002)(199004)(189003)(6116002)(6306002)(6512007)(66556008)(64756008)(66446008)(66476007)(66066001)(486006)(7736002)(71190400001)(52116002)(71200400001)(25786009)(2906002)(14454004)(76176011)(476003)(305945005)(6246003)(31696002)(2616005)(86362001)(66946007)(99286004)(446003)(8676002)(11346002)(6436002)(26005)(3846002)(5660300002)(31686004)(186003)(81156014)(81166006)(478600001)(102836004)(316002)(36756003)(54906003)(229853002)(110136005)(256004)(6486002)(4326008)(386003)(6506007)(53546011)(8936002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB4114;
 H:AM0PR08MB4097.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Kf2h1nmp+Eb8ZL4e2f03hLxuAvycy18+A1qZ+eyQRhish0WHpTI8WkAET1mTuDS05yP6kIEr/urv08S/S+/bRUApEa9CWrNntFZkrjjePb/qGkKge09BNYXnIhs1p94p5fNu8vNHDRpkz7VBKHgUhCJDZjh9aEr6OX2XrTXCtF2VmcMr5I+4vvqSNa5V5yC7mSrNGXxAdDu/157EGvEVvf3hFWguIuaptT7j+vHV27SSt0/V6ZVvHBBDuJcb8bsXH8x5LGlckhd+l0bRt7HxHjMB4CnBHBssdp8vQ0iRnUArQ4lwLssBZssN8QJKYQ8lC9CA5buk3qM7Pie8bSGzI0GMZACgIIRV1UHO87UIyWfoz624yZmUlQzRieHzLKjSpqYcHJRBkHlcaBtAxfU7+MmXG1+9aidK7v/v1vGGsQxU0wvgEsqt9FVmGjUQaG78rcieC1I9ctKDwN3GoPRb8ROTxs7YqDxgKxy3PCoR2rM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <80638A9D977B2C4FA10BC08CCD37DD38@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19f9a1ef-0969-4764-4962-08d75c6840c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2019 12:05:13.0840 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ec42bwd73TxxpgThaN6vj3EvO+RUlP+K1LAlr2iUugxkmpM7F/ZqujiTXmtCkpHpyT7Mb7E0Rt2udK9l9/SDw4kyFH9Yo69SsHvBhlGBlgg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4114
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.100
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
Cc: Anton Nefedov <anton.nefedov@virtuozzo.com>,
 Alberto Garcia <berto@igalia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjkuMTAuMjAxOSAxNDo1NSwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAyOS4xMC4xOSAxMjo0OCwg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IDI5LjEwLjIwMTkgMTE6NTAs
IE1heCBSZWl0eiB3cm90ZToNCj4+PiBPbiAyOC4xMC4xOSAxMjoyNSwgVmxhZGltaXIgU2VtZW50
c292LU9naWV2c2tpeSB3cm90ZToNCj4+Pj4gMjguMTAuMjAxOSAxNDowNCwgS2V2aW4gV29sZiB3
cm90ZToNCj4+Pj4+IEFtIDI3LjEwLjIwMTkgdW0gMTM6MzUgaGF0IFN0ZWZhbiBIYWpub2N6aSBn
ZXNjaHJpZWJlbjoNCj4+Pj4+PiBPbiBGcmksIE9jdCAyNSwgMjAxOSBhdCAxMTo1ODo0NkFNICsw
MjAwLCBNYXggUmVpdHogd3JvdGU6DQo+Pj4NCj4+PiBbLi4uXQ0KPj4+DQo+Pj4+Pj4+ICgzKSBE
cm9wIGhhbmRsZV9hbGxvY19zcGFjZSgpLCBpLmUuIHJldmVydCBjOGJiMjNjYmRiZTMyZi4NCj4+
Pj4+Pj4gICAgICAgIFRvIG15IGtub3dsZWRnZSBJ4oCZbSB0aGUgb25seSBvbmUgd2hvIGhhcyBw
cm92aWRlZCBhbnkgYmVuY2htYXJrcyBmb3INCj4+Pj4+Pj4gICAgICAgIHRoaXMgY29tbWl0LCBh
bmQgZXZlbiB0aGVuIEkgd2FzIGEgYml0IHNrZXB0aWNhbCBiZWNhdXNlIGl0IHBlcmZvcm1zDQo+
Pj4+Pj4+ICAgICAgICB3ZWxsIGluIHNvbWUgY2FzZXMgYW5kIGJhZCBpbiBvdGhlcnMuICBJIGNv
bmNsdWRlZCB0aGF0IGl04oCZcw0KPj4+Pj4+PiAgICAgICAgcHJvYmFibHkgd29ydGggaXQgYmVj
YXVzZSB0aGUg4oCcc29tZSBjYXNlc+KAnSBhcmUgbW9yZSBsaWtlbHkgdG8gb2NjdXIuDQo+Pj4+
Pj4+DQo+Pj4+Pj4+ICAgICAgICBOb3cgd2UgaGF2ZSB0aGlzIHByb2JsZW0gb2YgY29ycnVwdGlv
biBoZXJlIChncmFudGVkIGR1ZSB0byBhIGJ1ZyBpbg0KPj4+Pj4+PiAgICAgICAgdGhlIFhGUyBk
cml2ZXIpLCBhbmQgYW5vdGhlciByZXBvcnQgb2YgbWFzc2l2ZWx5IGRlZ3JhZGVkDQo+Pj4+Pj4+
ICAgICAgICBwZXJmb3JtYW5jZSBvbiBwcGM2NA0KPj4+Pj4+PiAgICAgICAgKGh0dHBzOi8vYnVn
emlsbGEucmVkaGF0LmNvbS9zaG93X2J1Zy5jZ2k/aWQ9MTc0NTgyMyDigJMgc29ycnksIGENCj4+
Pj4+Pj4gICAgICAgIHByaXZhdGUgQlo7IEkgaGF0ZSB0aGF0IDotLyAgVGhlIHJlcG9ydCBpcyBh
Ym91dCA0MCAlIHdvcnNlDQo+Pj4+Pj4+ICAgICAgICBwZXJmb3JtYW5jZSBmb3IgYW4gaW4tZ3Vl
c3QgZmlvIHdyaXRlIGJlbmNobWFyay4pDQo+Pj4+Pj4+DQo+Pj4+Pj4+ICAgICAgICBTbyBJIGhh
dmUgdG8gYXNrIHRoZSBxdWVzdGlvbiBhYm91dCB3aGF0IHRoZSBqdXN0aWZpY2F0aW9uIGZvcg0K
Pj4+Pj4+PiAgICAgICAga2VlcGluZyBjOGJiMjNjYmRiZTMyZiBpcy4gIEhvdyBtdWNoIGRvZXMg
cGVyZm9ybWFuY2UgaW5jcmVhc2Ugd2l0aA0KPj4+Pj4+PiAgICAgICAgaXQgYWN0dWFsbHk/ICAo
T24gbm9uLShwcGM2NCtYRlMpIG1hY2hpbmVzLCBvYnZpb3VzbHkpDQo+Pj4+Pj4+DQo+Pj4+Pj4+
ICAgICAgICBBZHZhbnRhZ2VzOg0KPj4+Pj4+PiAgICAgICAgKyBUcml2aWFsDQo+Pj4+Pj4+ICAg
ICAgICArIE5vIGxheWVyaW5nIHZpb2xhdGlvbnMNCj4+Pj4+Pj4gICAgICAgICsgV2Ugd291bGRu
4oCZdCBuZWVkIHRvIGtlZXAgdHJhY2sgb2Ygd2hldGhlciB0aGUga2VybmVsIGJ1ZyBoYXMgYmVl
bg0KPj4+Pj4+PiAgICAgICAgICBmaXhlZCBvciBub3QNCj4+Pj4+Pj4gICAgICAgICsgRml4ZXMg
dGhlIHBwYzY0K1hGUyBwZXJmb3JtYW5jZSBwcm9ibGVtDQo+Pj4+Pj4+DQo+Pj4+Pj4+ICAgICAg
ICBEaXNhZHZhbnRhZ2VzOg0KPj4+Pj4+PiAgICAgICAgLSBSZXZlcnRzIGNsdXN0ZXIgYWxsb2Nh
dGlvbiBwZXJmb3JtYW5jZSB0byBwcmUtYzhiYjIzY2JkYmUzMmYNCj4+Pj4+Pj4gICAgICAgICAg
bGV2ZWxzLCB3aGF0ZXZlciB0aGF0IG1lYW5zDQo+Pj4+Pj4NCj4+Pj4+PiBNeSBmYXZvcml0ZSBi
ZWNhdXNlIGl0IGlzIGNsZWFuIGFuZCBzaW1wbGUsIGJ1dCBWbGFkaW1pciBoYXMgYSB2YWxpZA0K
Pj4+Pj4+IHVzZS1jYXNlIGZvciByZXF1aXJpbmcgdGhpcyBwZXJmb3JtYW5jZSBvcHRpbWl6YXRp
b24gc28gcmV2ZXJ0aW5nIGlzbid0DQo+Pj4+Pj4gYW4gb3B0aW9uLg0KPj4+Pj4NCj4+Pj4+IFZs
YWRpbWlyIGFsc28gc2FpZCB0aGF0IHFjb3cyIHN1YmNsdXN0ZXJzIHdvdWxkIHByb2JhYmx5IGFs
c28gc29sdmUgaGlzDQo+Pj4+PiBwcm9ibGVtLCBzbyBtYXliZSByZXZlcnRpbmcgYW5kIGFwcGx5
aW5nIHRoZSBzdWJjbHVzdGVyIHBhdGNoZXMgaW5zdGVhZA0KPj4+Pj4gaXMgYSBwb3NzaWJsZSBz
b2x1dGlvbiwgdG9vPw0KPj4+Pg0KPj4+PiBJJ20gbm90IHN1cmUgYWJvdXQgc3NkIGNhc2UsIGl0
IG1heSBuZWVkIHdyaXRlLXplcm8gb3B0aW1pemF0aW9uIGFueXdheS4NCj4+Pg0KPj4+IFdoYXQg
ZXhhY3RseSBkbyB5b3UgbmVlZD8gIERvIHlvdSBhY3R1YWxseSBuZWVkIHRvIHdyaXRlIHplcm9l
cyAoZS5nLg0KPj4+IGJlY2F1c2UgeW914oCZcmUgc3RvcmluZyBpbWFnZXMgb24gYmxvY2sgZGV2
aWNlcykgb3Igd291bGQgaXQgYmUNCj4+PiBzdWZmaWNpZW50IHRvIGp1c3QgZHJvcCB0aGUgQ09X
IGFyZWFzIHdoZW4gYmRydl9oYXNfemVyb19pbml0KCkgYW5kDQo+Pj4gYmRydl9oYXNfemVyb19p
bml0X3RydW5jYXRlKCkgYXJlIHRydWU/DQo+Pg0KPj4gSG1tLCB3aGF0IGRvIHlvdSBtZWFuPyBX
ZSBuZWVkIHRvIHplcm8gQ09XIGFyZWFzLiBTbywgb3JpZ2luYWwgd2F5IGlzIHRvDQo+PiB3cml0
ZSByZWFsIHplcm9lcywgb3B0aW1pemVkIHdheSBpcyBmYWxsb2NhdGUuLiBXaGF0IGRvIHlvdSBt
ZWFuIGJ5IGRyb3A/DQo+PiBNYXJrIHN1Ymx1c3RlcnMgYXMgemVyb2VzIGJ5IG1ldGFkYXRhPw0K
PiANCj4gV2h5IGRvIHlvdSBuZWVkIHRvIHplcm8gQ09XIGFyZWFzPyAgRm9yIG5vcm1hbCBmaWxl
cywgYW55IGRhdGEgd2lsbCByZWFkDQo+IGFzIHplcm8gaWYgeW91IGRpZG7igJl0IHdyaXRlIGFu
eXRoaW5nIHRoZXJlLg0KDQpIbW0sIGJ1dCB3aGVuIGFsbG9jYXRpbmcgbmV3IGNsdXN0ZXIgaW4g
cWNvdzIsIGl0J3Mgbm90IGd1YXJhbnRlZWQgdG8gYmUgemVybywNCmFzIGl0IG1heSBiZSByZXVz
ZWQgcHJldmlvdXNseSBhbGxvY2F0ZWQgY2x1c3Rlci4uDQoNCj4gDQo+PiBCdXQgc3RpbGwgd2Un
bGwgaGF2ZSBDT1cgYXJlYXMgaW4gc3ViY2x1c3RlciwgYW5kIHdlJ2xsIG5lZWQgdG8gZGlyZWN0
bHkgemVybw0KPj4gdGhlbS4uIEFuZCBmYWxsb2NhdGUgd2lsbCBtb3N0IHByb2JhYmx5IGJlIGZh
c3RlciBvbiBzc2QgZXh0NCBjYXNlLi4NCj4+DQo+Pj4NCj4+PiBJ4oCZbSBhc2tpbmcgYmVjYXVz
ZSBEYXZlIENoaW5uZXIgc2FpZA0KPj4+IChodHRwczovL2J1Z3ppbGxhLnJlZGhhdC5jb20vc2hv
d19idWcuY2dpP2lkPTE3NjU1NDcjYzcpIHRoYXQNCj4+PiBmYWxsb2NhdGUoKSBpcyBhbHdheXMg
c2xvdyBhdCBsZWFzdCB3aXRoIGFpbz1uYXRpdmUgYmVjYXVzZSBpdCBuZWVkcyB0bw0KPj4+IHdh
aXQgZm9yIGFsbCBjb25jdXJyZW50IEFJTyB3cml0ZXMgdG8gZmluaXNoLCBhbmQgc28gaXQgY2F1
c2VzIHRoZSBBSU8NCj4+PiBwaXBlbGluZSB0byBzdGFsbC4NCj4+Pg0KPj4+IChIZSBzdWdnZXN0
ZWQgdXNpbmcgWEZTIGV4dGVudCBzaXplIGhpbnRzIHRvIGdldCB0aGUgc2FtZSBlZmZlY3QgYXMN
Cj4+PiB3cml0ZS16ZXJvZXMgZm9yIGZyZWUsIGJhc2ljYWxseSwgYnV0IEkgZG9u4oCZdCBrbm93
IHdoZXRoZXIgdGhhdOKAmXMgcmVhbGx5DQo+Pj4gdXNlZnVsIHRvIHVzOyBhcyB1bmFsbG9jYXRl
ZCBhcmVhcyBvbiBYRlMgcmVhZCBiYWNrIGFzIHplcm8gYW55d2F5LikNCj4+Pg0KPj4+Pj4gV2Ug
YWxyZWFkeSBoYXZlIHNvbWUgY2FzZXMgd2hlcmUgdGhlIGV4aXN0aW5nIGhhbmRsZV9hbGxvY19z
cGFjZSgpDQo+Pj4+PiBjYXVzZXMgcGVyZm9ybWFuY2UgdG8gYWN0dWFsbHkgYmVjb21lIHdvcnNl
LCBhbmQgc2VyaWFsaXNpbmcgcmVxdWVzdHMgYXMNCj4+Pj4+IGEgd29ya2Fyb3VuZCBpc24ndCBn
b2luZyB0byBtYWtlIHBlcmZvcm1hbmNlIGFueSBiZXR0ZXIuIFNvIGV2ZW4gb24NCj4+Pj4+IHRo
ZXNlIGdyb3VuZHMsIGtlZXBpbmcgY29tbWl0IGM4YmIyM2NiZGJlMzJmIGlzIHF1ZXN0aW9uYWJs
ZS4NCj4+Pj4+DQo+Pj4+DQo+Pj4+IENhbiBrZWVwaW5nIGhhbmRsZV9hbGxvY19zcGFjZSB1bmRl
ciBzb21lIGNvbmZpZyBvcHRpb24gYmUgYW4gb3B0aW9uPw0KPj4+DQo+Pj4gSG0uICBBIGNvbmZp
ZyBvcHRpb24gaXMgd2VpcmQgaWYgeW914oCZcmUgdGhlIG9ubHkgb25lIHdob+KAmXMgZ29pbmcg
dG8NCj4+PiBlbmFibGUgaXQuICBCdXQgb3RoZXIgdGhhbiB0aGF0IEkgZG9u4oCZdCBoYXZlIGFu
eXRoaW5nIGFnYWluc3QgaXQuDQo+Pj4NCj4+DQo+PiBJdCdzIGp1c3QgYSBiaXQgZWFzaWVyIGZv
ciB1cyB0byBtYWludGFpbiBjb25maWcgb3B0aW9uLCB0aGFuIG91dC1vZi10cmVlIHBhdGNoLg0K
Pj4gT24gdGhlIG90aGVyIGhhbmQsIGl0J3Mgbm90IGEgcmVhbCBwcm9ibGVtIHRvIG1haW50YWlu
IHRoaXMgb25lIHBhdGNoIGluIHNlcGFyYXRlLg0KPj4gSXQgbWF5IHJldHVybiBhZ2FpbiB0byB0
aGUgdHJlZSwgd2hlbiBYRlMgYnVnIGZpeGVkLg0KPiANCj4gV2XigJlsbCBzdGlsbCBoYXZlIHRo
ZSBwcm9ibGVtIHRoYXQgZmFsbG9jYXRlKCkgbXVzdCBzdGFsbCBhaW89bmF0aXZlDQo+IHJlcXVl
c3RzLg0KPiANCg0KRG9lcyBpdCBtZWFuIHRoYXQgZmFsbG9jYXRlIGlzIGJhZCBpbiBnZW5lcmFs
PyBQcmFjdGljZSBzaG93cyB0aGUgb3Bwb3NpdGUuLg0KQXQgbGVhc3QgSSBoYXZlIG15IGV4YW1w
bGVzIHdpdGggcWVtdS1pbWcgYmVuY2guIENhbiB0aGF0IHRoaW5nIGJlIHNob3duIHdpdGgNCnFl
bXUtaW1nIGJlbmNoIG9yIHNvbWV0aGluZz8NCg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRp
bWlyDQo=

