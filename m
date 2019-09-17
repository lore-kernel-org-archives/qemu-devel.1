Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1385CC4CEC9
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 17:41:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 859EC2067B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 17:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="h/mfKP8d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 859EC2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAHUD-00031W-FB
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 13:41:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53813)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iAHSr-0002MP-T3
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 13:40:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iAHSq-0008VH-HA
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 13:40:33 -0400
Received: from mail-vi1eur04on071b.outbound.protection.outlook.com
 ([2a01:111:f400:fe0e::71b]:1939
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iAHSa-0008OP-MF; Tue, 17 Sep 2019 13:40:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LIJ+rjNr5XMTQtXHOfWBHUcQLUeRNk/eXzY9k1x19D8s46roMbW6PsJoQegQasvWIYZ+alCgNWIGVVfTFJMUTByKLtdXnLFrhDMv/kX8QmM7z5gJKhaXkvODIm2ZZLoPVBeumzMMyWIAK+GksPPIbinLHwqZXPHBrKqIjUzFWs2tr637zbtcmRzZa8TjR1eNJfQz3q94d3AKDBFNflB+uqAIfdT7CcDVA3Pw3KzRjFVMjGMYJuHJ2ks6aP1Zug1GLOqZRCpj5cg8CMEycZKqz8sUhCMVd04+ppwktDhHS+JYT4Y3Bd2qbYPLPHJfH2vSiwCJUD9QepbmCnJ4vu8M6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Hu8uUx5rRYSwcmtsUrQLJLcIMiefMKRrx0SWm4BDOo=;
 b=bxh4ljjL54GdekYgUg4jiZr75BiIOI3JlnKQNkOg03XoThO1BTo7pIYuW4n++MPHHSzCkrM8781nh2MuU3cWvI+7PN+wUAjEUMBecv09ZlyU5fX/YpSjdcfrUvWYNYzsH9zvokFSqZwdKGzH7V6HKM6FzGGhwxcVSs319ml1LywcAmid8R8BDZ2if7rR88EJF0TjBFxbIIzmNBlPwF+iNlHzz+8VwNRkVKIJnAh20YWQ+wP7G525SU53iIIe7upDlNU6UesRGamihlJG92xpaCW+bi1gyOo/o4Aii14bnRZmLKdo/nIpQQ+8jZ89DGgp1oE9xxUEXNjM1SNDV5gRbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Hu8uUx5rRYSwcmtsUrQLJLcIMiefMKRrx0SWm4BDOo=;
 b=h/mfKP8d4tMbk5l3S12PoBrNWra70eWelmQgHG3zV8PHW31++fwju+6oCKtu6CFT+ZucHR4xg/Pqe1d3fBLxOejxv+1HjLenbFMGucXPzBPEm60E7RUUDyvhLrkuN3/34fVIa7lL96vWOCk2Z18uYn6BLekHOsAczck9OC5pcxY=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5290.eurprd08.prod.outlook.com (20.179.9.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.16; Tue, 17 Sep 2019 17:40:11 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2263.023; Tue, 17 Sep 2019
 17:40:11 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Greg Kurz <groug@kaod.org>
Thread-Topic: [Qemu-devel] [PATCH 02/17] block: Pass local error object
 pointer to error_append_hint()
Thread-Index: AQHVbUH6TzrJ58vIKEO+OGTVPIfvz6cv3BeAgAAlJQCAACIjgA==
Date: Tue, 17 Sep 2019 17:40:11 +0000
Message-ID: <09d047e3-7bc2-892d-31dc-9f9201b99862@virtuozzo.com>
References: <156871562997.196432.17776290406203122029.stgit@bahia.lan>
 <156871564329.196432.5930574495661947805.stgit@bahia.lan>
 <5dba090e-8a59-6f42-a93a-eb676422211e@virtuozzo.com>
 <20190917173756.5ff0e571@bahia.lan>
In-Reply-To: <20190917173756.5ff0e571@bahia.lan>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0202CA0024.eurprd02.prod.outlook.com
 (2603:10a6:3:8c::34) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190917204007156
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 399cffb5-2a53-4a74-711d-08d73b9616d0
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:DB8PR08MB5290; 
x-ms-traffictypediagnostic: DB8PR08MB5290:
x-microsoft-antispam-prvs: <DB8PR08MB5290577CD35D3AABDDC081A4C18F0@DB8PR08MB5290.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 01630974C0
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(376002)(39850400004)(396003)(366004)(136003)(199004)(189003)(8936002)(31686004)(76176011)(81166006)(386003)(11346002)(186003)(71200400001)(71190400001)(3846002)(478600001)(36756003)(4326008)(6506007)(102836004)(52116002)(66066001)(25786009)(6116002)(99286004)(316002)(2906002)(2616005)(476003)(64756008)(66556008)(66446008)(66476007)(66946007)(6512007)(446003)(26005)(81156014)(6246003)(54906003)(486006)(14454004)(256004)(6436002)(7416002)(7406005)(305945005)(6916009)(8676002)(6486002)(86362001)(7736002)(229853002)(31696002)(5660300002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5290;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TwrqggTmW0aSbKhmvlJL+AC6kXPQ2boCjX4Pii0IUH5CSFs7xV6C0RBT2lH12jzVDq4UXOyDdgSFG+48eCoCGdnj4q55CBqDvg6mO4HfegVkoCTBvCZ8PiS+BtKeqzMh3SwGhxy+vmlQ/FC8nDZvVPUeS2Glr947Cz4+/CGWOv/UIHR3Ocm86aeXdYs/G0KPpe7yv9t5Qe/GqxBUq8+MJWN/HEw4myQIng4LzJqZk4hoJzi3SB8HQetef3hqIhNsM3ze9JWj6vz+UVwUFUGmH53d6aHi71U42toLbqWfkTq9I2KscHxvgqzgA6jgH5tpbXDNgMZ2J67ib2yxZ/hsYbxrrqYEIfg+DjTPZECjWCvZDPtksBAJzH3AI/K21r0gGzDAZG41bltpz7sxNFsK9sOFV4FlK+Bh0gYY82NfIcg=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <8A6465B1BD7D424EA66C9EB5F842EAFD@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 399cffb5-2a53-4a74-711d-08d73b9616d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2019 17:40:11.4099 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yZmQoeiLS5/sfQ+SCsTf9Z6HwZtrVVX7wtSeZULOH5DKYFGDKXMjOJcc+hRA7vXhlecg//o0SOsZGKKZJjGr2awEnT42u2+jwn4QFol9KNg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5290
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe0e::71b
Subject: Re: [Qemu-devel] [PATCH 02/17] block: Pass local error object
 pointer to error_append_hint()
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jeff Cody <codyprime@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Juan Quintela <quintela@redhat.com>, David Hildenbrand <david@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Eric Farman <farman@linux.ibm.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Yuval Shaia <yuval.shaia@oracle.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, John Snow <jsnow@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, Kevin Wolf <kwolf@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTcuMDkuMjAxOSAxODozNywgR3JlZyBLdXJ6IHdyb3RlOg0KPiBPbiBUdWUsIDE3IFNlcCAyMDE5
IDEzOjI1OjAzICswMDAwDQo+IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRz
b3ZAdmlydHVvenpvLmNvbT4gd3JvdGU6DQo+IA0KPj4gMTcuMDkuMjAxOSAxMzoyMCwgR3JlZyBL
dXJ6IHdyb3RlOg0KPj4+IEVuc3VyZSB0aGF0IGhpbnRzIGFyZSBhZGRlZCBldmVuIGlmIGVycnAg
aXMgJmVycm9yX2ZhdGFsIG9yICZlcnJvcl9hYm9ydC4NCj4+Pg0KPj4+IFNpZ25lZC1vZmYtYnk6
IEdyZWcgS3VyeiA8Z3JvdWdAa2FvZC5vcmc+DQo+Pj4gLS0tDQo+Pj4gICAgYmxvY2svYmFja3Vw
LmMgICAgICAgfCAgICA3ICsrKysrLS0NCj4+PiAgICBibG9jay9kaXJ0eS1iaXRtYXAuYyB8ICAg
IDcgKysrKystLQ0KPj4+ICAgIGJsb2NrL2ZpbGUtcG9zaXguYyAgIHwgICAyMCArKysrKysrKysr
KysrLS0tLS0tLQ0KPj4+ICAgIGJsb2NrL2dsdXN0ZXIuYyAgICAgIHwgICAyMyArKysrKysrKysr
KysrKystLS0tLS0tLQ0KPj4+ICAgIGJsb2NrL3Fjb3cuYyAgICAgICAgIHwgICAxMCArKysrKyst
LS0tDQo+Pj4gICAgYmxvY2svcWNvdzIuYyAgICAgICAgfCAgICA3ICsrKysrLS0NCj4+PiAgICBi
bG9jay92aGR4LWxvZy5jICAgICB8ICAgIDcgKysrKystLQ0KPj4+ICAgIGJsb2NrL3ZwYy5jICAg
ICAgICAgIHwgICAgNyArKysrKy0tDQo+Pj4gICAgOCBmaWxlcyBjaGFuZ2VkLCA1OSBpbnNlcnRp
b25zKCspLCAyOSBkZWxldGlvbnMoLSkNCj4+Pg0KPj4+IGRpZmYgLS1naXQgYS9ibG9jay9iYWNr
dXAuYyBiL2Jsb2NrL2JhY2t1cC5jDQo+Pj4gaW5kZXggNzYzZjBkN2ZmNmRiLi5kOGM0MjJhMGUz
YmMgMTAwNjQ0DQo+Pj4gLS0tIGEvYmxvY2svYmFja3VwLmMNCj4+PiArKysgYi9ibG9jay9iYWNr
dXAuYw0KPj4+IEBAIC02MDIsMTEgKzYwMiwxNCBAQCBzdGF0aWMgaW50NjRfdCBiYWNrdXBfY2Fs
Y3VsYXRlX2NsdXN0ZXJfc2l6ZShCbG9ja0RyaXZlclN0YXRlICp0YXJnZXQsDQo+Pj4gICAgICAg
ICAgICAgICAgICAgICAgICBCQUNLVVBfQ0xVU1RFUl9TSVpFX0RFRkFVTFQpOw0KPj4+ICAgICAg
ICAgICAgcmV0dXJuIEJBQ0tVUF9DTFVTVEVSX1NJWkVfREVGQVVMVDsNCj4+PiAgICAgICAgfSBl
bHNlIGlmIChyZXQgPCAwICYmICF0YXJnZXQtPmJhY2tpbmcpIHsNCj4+PiAtICAgICAgICBlcnJv
cl9zZXRnX2Vycm5vKGVycnAsIC1yZXQsDQo+Pj4gKyAgICAgICAgRXJyb3IgKmxvY2FsX2VyciA9
IE5VTEw7DQo+Pj4gKw0KPj4+ICsgICAgICAgIGVycm9yX3NldGdfZXJybm8oJmxvY2FsX2Vyciwg
LXJldCwNCj4+PiAgICAgICAgICAgICAgICAiQ291bGRuJ3QgZGV0ZXJtaW5lIHRoZSBjbHVzdGVy
IHNpemUgb2YgdGhlIHRhcmdldCBpbWFnZSwgIg0KPj4+ICAgICAgICAgICAgICAgICJ3aGljaCBo
YXMgbm8gYmFja2luZyBmaWxlIik7DQo+Pj4gLSAgICAgICAgZXJyb3JfYXBwZW5kX2hpbnQoZXJy
cCwNCj4+PiArICAgICAgICBlcnJvcl9hcHBlbmRfaGludCgmbG9jYWxfZXJyLA0KPj4+ICAgICAg
ICAgICAgICAgICJBYm9ydGluZywgc2luY2UgdGhpcyBtYXkgY3JlYXRlIGFuIHVudXNhYmxlIGRl
c3RpbmF0aW9uIGltYWdlXG4iKTsNCj4+PiArICAgICAgICBlcnJvcl9wcm9wYWdhdGUoZXJycCwg
bG9jYWxfZXJyKTsNCj4+PiAgICAgICAgICAgIHJldHVybiByZXQ7DQo+Pj4gICAgICAgIH0gZWxz
ZSBpZiAocmV0IDwgMCAmJiB0YXJnZXQtPmJhY2tpbmcpIHsNCj4+PiAgICAgICAgICAgIC8qIE5v
dCBmYXRhbDsganVzdCB0cnVkZ2Ugb24gYWhlYWQuICovDQo+Pg0KPj4NCj4+IFBhaW4uLiBEbyB3
ZSBuZWVkIHRoZXNlIGhpbnRzLCBpZiB0aGV5IGFyZSBzbyBwYWluZnVsPw0KPj4NCj4gDQo+IEkg
YWdyZWUgdGhhdCB0aGUgb25lIGFib3ZlIGRvZXNuJ3QgcXVhbGlmeSBhcyBhIHVzZWZ1bCBoaW50
Lg0KPiBJdCBqdXN0IHRlbGxzIHRoYXQgUUVNVSBpcyBnaXZpbmcgdXAgYW5kIGdpdmVzIG5vIGlu
ZGljYXRpb24NCj4gdG8gdGhlIHVzZXIgb24gaG93IHRvIGF2b2lkIHRoZSBpc3N1ZS4gSXQgc2hv
dWxkIHByb2JhYmx5IGJlDQo+IGRyb3BwZWQuDQo+IA0KPj4gQXQgbGVhc3QgZm9yIGNhc2VzIGxp
a2UgdGhpcywgd2UgY2FuIGNyZWF0ZSBoZWxwZXIgZnVuY3Rpb24NCj4+DQo+PiBlcnJvcl9zZXRn
X2Vycm5vX2hpbnQoLi4uLCBlcnJvciwgaGludCkNCj4gDQo+IE5vdCB2ZXJ5IHVzZWZ1bCBpZiBo
aW50IGhhcyB0byBiZSBmb3JnZWQgc2VwYXJhdGVseSB3aXRoDQo+IGdfc3ByaW50ZigpLCBhbmQg
d2UgY2FuJ3QgaGF2ZSBzdWNoIGEgdGhpbmcgYXM6DQo+IA0KPiBlcnJvcl9zZXRnX2Vycm5vX2hp
bnQoZXJycCwgZXJyX2ZtdCwgLi4uLCBoaW50X2ZtdCwgLi4uKQ0KPiANCj4+DQo+PiBCdXQgd2hh
dCBjb3VsZCBiZSBkb25lIHdoZW4gd2UgY2FsbCBmdW5jdGlvbiwgd2hpY2ggbWF5IG9yIG1heSBu
b3Qgc2V0IGVycnA/DQo+Pg0KPj4gcmV0ID0gZihlcnJwKTsNCj4+IGlmIChyZXQpIHsNCj4+ICAg
ICAgZXJyb3JfYXBwZW5kX2hpbnQoZXJycCwgaGludCk7DQo+PiB9DQo+Pg0KPiANCj4gU2FtZSBw
cm9ibGVtLiBJZiBlcnJwIGlzICZlcnJvcl9mYXRhbCBhbmQgZigpIGRvZXMgZXJybm9fc2V0Zyhl
cnJwKSwgaXQNCj4gZW5kcyB1cCBjYWxsaW5nIGV4aXQoKS4NCj4gDQo+PiBIbW1tLi4NCj4+DQo+
PiBDYW4gaXQgbG9vayBsaWtlDQo+Pg0KPj4gcmV0ID0gZiguLi4sIGhpbnRfaGVscGVyKGVycnAs
IGhpbnQpKQ0KPj4NCj4+ID8NCj4+DQo+IA0KPiBOb3BlLCBoaW50X2hlbHBlcigpIHdpbGwgZ2V0
IGNhbGxlZCBiZWZvcmUgZigpIGFuZCB0aGluZ3MgYXJlIHdvcnNlLg0KPiBJZiBlcnJwIGlzIE5V
TEwgdGhlbiBlcnJvcl9hcHBlbmRfaGludCgpIGRvZXMgbm90aGluZyBhbmQgaWYgaXQgaXMNCj4g
JmVycm9yX2ZhdGFsIHRoZW4gaXQgYWJvcnRzLg0KPiANCj4+IEkgY2FuJ3QgaW1hZ2luZSBob3cg
dG8gZG8gaXQsIGFzIHNvbWVvbmUgc2hvdWxkIHJlbW92ZSBoaW50IGZyb20gZXJyb3JfYWJvcnQg
b2JqZWN0IG9uDQo+PiBzdWNjZXNzIHBhdGguLg0KPj4NCj4+IEJ1dCBzZWVtcywgdGhlIGZvbGxv
d2luZyBpcyBwb3NzaWJsZSwgd2hpY2ggc2VlbXMgYmV0dGVyIGZvciBtZSB0aGFuIGxvY2FsLWVy
cm9yIGFwcHJvYWNoOg0KPj4NCj4+IGVycm9yX3B1c2hfaGludChlcnJwLCBoaW50KTsNCj4+IHJl
dCA9IGYoLi4sIGVycnApOw0KPj4gZXJyb3JfcG9wX2hpbnQoZXJycCk7DQo+Pg0KPiANCj4gTWF0
dGVyIG9mIHRhc3RlLi4uIGFsc28sIGl0IGxvb2tzIGF3a3dhcmQgdG8gY29tZSB1cCB3aXRoIGEg
aGludA0KPiBiZWZvcmUga25vd2luZyB3aGF0IGhhcHBlbmVkLiBJIG1lYW4gdGhlIGFwcHJvcHJp
YXRlIGhpbnQgY291bGQNCj4gZGVwZW5kIG9uIHRoZSB2YWx1ZSByZXR1cm5lZCBieSBmKCkgYW5k
L29yIGVycm5vIGZvciBleGFtcGxlLg0KPiANCj4+ID09PQ0KPj4NCj4+IENvbnRpbnVlIHRoaW5r
aW5nIG9uIHRoaXM6DQo+Pg0KPj4gSXQgbWF5IGxvb2sgbGlrZSBqdXN0DQo+PiByZXQgPSBmKC4u
Liwgc2V0X2hpbnQoZXJycCwgaGludCkpOw0KPj4NCj4+IG9yIChqdXN0IHRvIHNwbGl0IGxvbmcg
bGluZSk6DQo+PiBzZXRfaGludChlcnJwLCBoaW50KTsNCj4+IHJldCA9IGYoLi4uLCBlcnJwKTsN
Cj4+DQo+PiBpZiBpbiBlYWNoIGZ1bmN0aW9uIHdpdGggZXJycCBkb2VzIGVycm9yX3B1c2hfaGlu
dChlcnJwKSBvbiBzdGFydCBhbmQgZXJyb3JfcG9wX2hpbnQoZXJycCkgb24gZXhpdCwNCj4+IHdo
aWNoIG1heSBiZSBqdXN0IG9uZSBjYWxsIGF0IGZ1bmN0aW9uIHN0YXJ0IG9mIG1hY3JvLCB3aGlj
aCB3aWxsIGNhbGwgZXJyb3JfcHVzaF9oaW50KGVycnApIGFuZA0KPj4gZGVmaW5lIGxvY2FsIHZh
cmlhYmxlIGJ5IGdfYXV0bywgd2l0aCBjbGVhbnVwIHdoaWNoIHdpbGwgY2FsbCBlcnJvcl9wb3Bf
aGludChlcnJwKSBvbiBmdW5jdGlvbg0KPj4gZXhpdC4uDQo+Pg0KPj4gT3IsIG1heSBiZSwgbW9y
ZSBkaXJlY3Qgd2F5IHRvIHNldCBjbGVhbnVwIGZvciBmdW5jdGlvbiBleGlzdHM/DQo+Pg0KPj4g
PT09DQo+Pg0KPj4gQWxzbywgd2UgY2FuIGltcGxlbWVudCBzb21lIGNvZGUgZ2VuZXJhdGlvbiwg
dG8gZ2VuZXJhdGUgZm9yIGZ1bmN0aW9ucyB3aXRoIGVycnAgYXJndW1lbnQNCj4+IHdyYXBwZXJz
IHdpdGggYWRkaXRpb25hbCBoaW50IHBhcmFtZXRlciwgYW5kIGp1c3QgdXNlIHRoZXNlIHdyYXBw
ZXJzLi4NCj4+DQo+PiA9PT0NCj4+DQo+PiBJZiBub2JvZHkgbGlrZXMgYW55IG9mIG15IHN1Z2dl
c3Rpb25zLCB0aGVuIGlnbm9yZSB0aGVtLiBJIHVuZGVyc3RhbmQgdGhhdCB0aGlzIHNlcmllcyBm
aXhlcw0KPj4gcmVhbCBpc3N1ZSBhbmQgbXVjaCBlZmZvcnQgaGFzIGFscmVhZHkgYmVlbiBzcGVu
dC4gTWF5IGJlIG9uZSBkYXkgSSdsbCB0cnkgdG8gcmV3cml0ZSBpdC4uLg0KPj4NCj4gDQo+IEZv
ciB0aGUgcmVhc29uIGV4cG9zZWQgYWJvdmUsIEkgZG9uJ3QgdGhpbmsgaXQgbWFrZXMgc2Vuc2Ug
dG8NCj4gYnVpbGQgdGhlIGhpbnQgYmVmb3JlIGNhbGxpbmcgYSBmdW5jdGlvbiB0aGF0IGNhbGxz
IGVycm9yX3NldGcoKS4NCj4gSSdtIGFmcmFpZCB3ZSdyZSBzdHVjayB3aXRoIGxvY2FsX2Vyci4u
LiBpdCBpcyB0aGVuIHVwIHRvIHRoZQ0KPiBwZW9wbGUgdG8gbWFrZSBpdCBhcyBsZXNzIHBhaW5m
dWwgYXMgcG9zc2libGUuDQo+IA0KDQpIbW0uIHNvLCBzZWVtcyB0aGF0IGluIGdlbmVyYWwgd2Ug
bmVlZCBsb2NhbF9lcnIuLg0KDQpUaGVuIG1heSBiZSwgbWF5IGNhbiBtYWtlIGF1dG9tYXRlZCBw
cm9wYWdhdGlvbj8NCg0KSXQgd2lsbCBsb29rIGxpa2UNCg0KZ19hdXRvKEVycm9yUHJvcGFnYXRp
b24pIF9lcnJvcl9wcm9wID0gKEVycm9yUHJvcGFnYXRpb24pew0KICAgLmVycnAgPSBlcnJwLA0K
ICAgLmxvY2FsX2VyciA9IE5VTEwsDQp9DQoNCmVycnAgPSAmX2Vycm9yX3Byb3AubG9jYWxfZXJy
Ow0KDQphbmQgdGhpcyB0aGluZyBtYXkgYmUgZnVsbHkgY292ZXJlZCBpbnRvIG1hY3JvLA0KdG8g
bG9vayBsaWtlIHRoaXMgYXQgZnVuY3Rpb24gc3RhcnQgKHRvIGJlIGhvbmVzdCBpdCBzaG91bGQg
ZXhhY3RseSBhZnRlciBhbGwNCmxvY2FsIHZhcmlhYmxlIGRlZmluaXRpb25zKToNCg0KTUFLRV9F
UlJQX1NBRkUoX2Vycm9yX3Byb3AsIGVycnApOw0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxh
ZGltaXINCg==

