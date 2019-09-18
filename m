Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EABD0C4CEC9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 10:20:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6231218AF
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 10:20:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="MEP/+Z8U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6231218AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAX4C-0002rb-SB
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 06:20:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34811)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iAX2G-0001jQ-HC
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 06:18:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iAX2F-0000Fy-28
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 06:18:08 -0400
Received: from mail-eopbgr60097.outbound.protection.outlook.com
 ([40.107.6.97]:10114 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iAX20-00006e-Hx; Wed, 18 Sep 2019 06:17:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZC8Ic9dRK4jqsmfReYNie5aHKC14Pax1s91bfCCnnD4PfmI7VcuBrOAOiDb5qmD5G1Y/G8iPnfe9PxSKd7aneKLby3jbPRn+6zbVqpL5wQGNTNRsqH5eEYGp64rSF/egKDy0w0R9P+v61ofNHCgvhF+PeVbRw4cRtA3K4etFcwmpR2ltH0qYV3tAV/rm/Wz7rAeq9OsTgPliv6mOOVFEHN6NiMwuRPqJrl3wYpmj00OCFTYEhBSMBRKA4/DYMxkPvCpUs2n48mCDXcPQ0n6OelsejTjWbH1S/dXBLRDxlWEYnrnpwgqtFOiW0mjlZg75Y97gt4A0dVDDEjBJqV5a+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6DT1ZqVCuK8yPUE/bzblcVgFTw87OiVI5/kaXc8xtcY=;
 b=LC+qWQJUUxJqltglswopiDvprhDxUoK6dv+0UOMbQW2haVZ3+OrjHhKR6hJOzjivdr4qsKp+2HaBcH9H0z0rlzuFWIkaTD6QqSCu5GvtaioyLYHrPci3ofPPbtssS34fbkwzIqR5ijyucCQyYtmzm2ENjCGbxscfhcwP+8sC4E+76SGMBjRtM1Wre4CPDOstpzbd5XwIRxtA3zQV+EH+UR8gTNhC6rp9lpLzZ5VCyPZPEzORXxaMCpQCG4x9JlNhBxL4S5sQHrbAyZHcQcKhcvObKQ/+RIMba5q4hq0hkOhm10vr8ZbMyose0mpMXzKS2MmgF+xBVk6SeeLVI6VJGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6DT1ZqVCuK8yPUE/bzblcVgFTw87OiVI5/kaXc8xtcY=;
 b=MEP/+Z8UeOVLFZMR/nqw24UIOzHh1UDIPmwcTJu6gv+vcqjQMmuaJ4/2KOmP1Vk/1zPG7ufWgnQezDGjysRhNNvDHCe3EOKxehMdTcfanPJC5KvfkL8p6iFpVSd8sL5oRrT0QbzEfx7YeJUerxFjXQigJKRiBqKsyObNFc+93m4=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5273.eurprd08.prod.outlook.com (10.255.18.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.17; Wed, 18 Sep 2019 10:17:48 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2263.023; Wed, 18 Sep 2019
 10:17:48 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Greg Kurz <groug@kaod.org>
Thread-Topic: [Qemu-devel] [PATCH 02/17] block: Pass local error object
 pointer to error_append_hint()
Thread-Index: AQHVbUH6TzrJ58vIKEO+OGTVPIfvz6cv3BeAgAAlJQCAACIjgIAA79GAgAAm6wA=
Date: Wed, 18 Sep 2019 10:17:48 +0000
Message-ID: <47254528-c915-1654-b924-7a8018984b29@virtuozzo.com>
References: <156871562997.196432.17776290406203122029.stgit@bahia.lan>
 <156871564329.196432.5930574495661947805.stgit@bahia.lan>
 <5dba090e-8a59-6f42-a93a-eb676422211e@virtuozzo.com>
 <20190917173756.5ff0e571@bahia.lan>
 <09d047e3-7bc2-892d-31dc-9f9201b99862@virtuozzo.com>
 <20190918095827.39b410f8@bahia.lan>
In-Reply-To: <20190918095827.39b410f8@bahia.lan>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0260.eurprd05.prod.outlook.com
 (2603:10a6:3:fc::12) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190918131744421
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b75c71df-7fa2-4a7c-d958-08d73c2174be
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5273; 
x-ms-traffictypediagnostic: DB8PR08MB5273:
x-microsoft-antispam-prvs: <DB8PR08MB5273AF7B0883CF6B3E5C8806C18E0@DB8PR08MB5273.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 01644DCF4A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(366004)(346002)(39850400004)(376002)(396003)(189003)(199004)(6116002)(2906002)(316002)(86362001)(11346002)(446003)(3846002)(25786009)(36756003)(256004)(2616005)(4326008)(6246003)(31696002)(26005)(7736002)(478600001)(102836004)(305945005)(186003)(7416002)(7406005)(14454004)(6436002)(66476007)(81156014)(8676002)(64756008)(66446008)(386003)(99286004)(6486002)(54906003)(6506007)(8936002)(66946007)(6916009)(31686004)(52116002)(66556008)(229853002)(81166006)(71200400001)(6512007)(5660300002)(71190400001)(486006)(76176011)(66066001)(476003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5273;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: e2SpTYMZ/bcYDlLFWmGu+rAMjNxLSy+saeZprf8e6hOCQMqgbAhpNHmScq1HN59oS+CnM9hQO9y7Jat4yw7jv/P1gwBrLo3tfPPQPOv5VSD52hKtRZBWnXaZKzoEUH3NIIJsDmRbEvNasCVQl+C2DFImA8IdFefJIMhj6xfGYjNk9IRHav21/T0lloee5xwmrXKdzK8ePF465HR/RjDaAjiLHoNqhH1IC+zH6zFZACb2dx4kwynWpMx5DjB8zBqhkGHCmUyJc6IWDb7+ZgfqNq1I1G+fiLqjCD8uEOeBavJTi74/iXIH5bJHvMAzKm684Mo4P2PRuuZXE5MB0UFemjQF2OgmPuZxbRXUM4hqmCygncZBCBLxSgmwpgoimXNw3rDXPGJ7rIBfrInAngx4EES2uJdGWRDqcXoIiVEeEe0=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <AFD74C10EB9B304BBC105D647E6EE4A2@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b75c71df-7fa2-4a7c-d958-08d73c2174be
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2019 10:17:48.8026 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CbbMATwQudpG4Z/FjGGMfsT0V2sPxxXD5Ik84zTR1Vk0q0F1p6r3Bwn5q8dCZrZNaaUBlA7dmtb7c94QBlpPba4hQhK4ooqw78F1QT+uca8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5273
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.6.97
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

MTguMDkuMjAxOSAxMDo1OCwgR3JlZyBLdXJ6IHdyb3RlOg0KPiBPbiBUdWUsIDE3IFNlcCAyMDE5
IDE3OjQwOjExICswMDAwDQo+IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRz
b3ZAdmlydHVvenpvLmNvbT4gd3JvdGU6DQo+IA0KPj4gMTcuMDkuMjAxOSAxODozNywgR3JlZyBL
dXJ6IHdyb3RlOg0KPj4+IE9uIFR1ZSwgMTcgU2VwIDIwMTkgMTM6MjU6MDMgKzAwMDANCj4+PiBW
bGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+IHdy
b3RlOg0KPj4+DQo+Pj4+IDE3LjA5LjIwMTkgMTM6MjAsIEdyZWcgS3VyeiB3cm90ZToNCj4+Pj4+
IEVuc3VyZSB0aGF0IGhpbnRzIGFyZSBhZGRlZCBldmVuIGlmIGVycnAgaXMgJmVycm9yX2ZhdGFs
IG9yICZlcnJvcl9hYm9ydC4NCj4+Pj4+DQo+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBHcmVnIEt1cnog
PGdyb3VnQGthb2Qub3JnPg0KPj4+Pj4gLS0tDQo+Pj4+PiAgICAgYmxvY2svYmFja3VwLmMgICAg
ICAgfCAgICA3ICsrKysrLS0NCj4+Pj4+ICAgICBibG9jay9kaXJ0eS1iaXRtYXAuYyB8ICAgIDcg
KysrKystLQ0KPj4+Pj4gICAgIGJsb2NrL2ZpbGUtcG9zaXguYyAgIHwgICAyMCArKysrKysrKysr
KysrLS0tLS0tLQ0KPj4+Pj4gICAgIGJsb2NrL2dsdXN0ZXIuYyAgICAgIHwgICAyMyArKysrKysr
KysrKysrKystLS0tLS0tLQ0KPj4+Pj4gICAgIGJsb2NrL3Fjb3cuYyAgICAgICAgIHwgICAxMCAr
KysrKystLS0tDQo+Pj4+PiAgICAgYmxvY2svcWNvdzIuYyAgICAgICAgfCAgICA3ICsrKysrLS0N
Cj4+Pj4+ICAgICBibG9jay92aGR4LWxvZy5jICAgICB8ICAgIDcgKysrKystLQ0KPj4+Pj4gICAg
IGJsb2NrL3ZwYy5jICAgICAgICAgIHwgICAgNyArKysrKy0tDQo+Pj4+PiAgICAgOCBmaWxlcyBj
aGFuZ2VkLCA1OSBpbnNlcnRpb25zKCspLCAyOSBkZWxldGlvbnMoLSkNCj4+Pj4+DQo+Pj4+PiBk
aWZmIC0tZ2l0IGEvYmxvY2svYmFja3VwLmMgYi9ibG9jay9iYWNrdXAuYw0KPj4+Pj4gaW5kZXgg
NzYzZjBkN2ZmNmRiLi5kOGM0MjJhMGUzYmMgMTAwNjQ0DQo+Pj4+PiAtLS0gYS9ibG9jay9iYWNr
dXAuYw0KPj4+Pj4gKysrIGIvYmxvY2svYmFja3VwLmMNCj4+Pj4+IEBAIC02MDIsMTEgKzYwMiwx
NCBAQCBzdGF0aWMgaW50NjRfdCBiYWNrdXBfY2FsY3VsYXRlX2NsdXN0ZXJfc2l6ZShCbG9ja0Ry
aXZlclN0YXRlICp0YXJnZXQsDQo+Pj4+PiAgICAgICAgICAgICAgICAgICAgICAgICBCQUNLVVBf
Q0xVU1RFUl9TSVpFX0RFRkFVTFQpOw0KPj4+Pj4gICAgICAgICAgICAgcmV0dXJuIEJBQ0tVUF9D
TFVTVEVSX1NJWkVfREVGQVVMVDsNCj4+Pj4+ICAgICAgICAgfSBlbHNlIGlmIChyZXQgPCAwICYm
ICF0YXJnZXQtPmJhY2tpbmcpIHsNCj4+Pj4+IC0gICAgICAgIGVycm9yX3NldGdfZXJybm8oZXJy
cCwgLXJldCwNCj4+Pj4+ICsgICAgICAgIEVycm9yICpsb2NhbF9lcnIgPSBOVUxMOw0KPj4+Pj4g
Kw0KPj4+Pj4gKyAgICAgICAgZXJyb3Jfc2V0Z19lcnJubygmbG9jYWxfZXJyLCAtcmV0LA0KPj4+
Pj4gICAgICAgICAgICAgICAgICJDb3VsZG4ndCBkZXRlcm1pbmUgdGhlIGNsdXN0ZXIgc2l6ZSBv
ZiB0aGUgdGFyZ2V0IGltYWdlLCAiDQo+Pj4+PiAgICAgICAgICAgICAgICAgIndoaWNoIGhhcyBu
byBiYWNraW5nIGZpbGUiKTsNCj4+Pj4+IC0gICAgICAgIGVycm9yX2FwcGVuZF9oaW50KGVycnAs
DQo+Pj4+PiArICAgICAgICBlcnJvcl9hcHBlbmRfaGludCgmbG9jYWxfZXJyLA0KPj4+Pj4gICAg
ICAgICAgICAgICAgICJBYm9ydGluZywgc2luY2UgdGhpcyBtYXkgY3JlYXRlIGFuIHVudXNhYmxl
IGRlc3RpbmF0aW9uIGltYWdlXG4iKTsNCj4+Pj4+ICsgICAgICAgIGVycm9yX3Byb3BhZ2F0ZShl
cnJwLCBsb2NhbF9lcnIpOw0KPj4+Pj4gICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4+Pj4+ICAg
ICAgICAgfSBlbHNlIGlmIChyZXQgPCAwICYmIHRhcmdldC0+YmFja2luZykgew0KPj4+Pj4gICAg
ICAgICAgICAgLyogTm90IGZhdGFsOyBqdXN0IHRydWRnZSBvbiBhaGVhZC4gKi8NCj4+Pj4NCj4+
Pj4NCj4+Pj4gUGFpbi4uIERvIHdlIG5lZWQgdGhlc2UgaGludHMsIGlmIHRoZXkgYXJlIHNvIHBh
aW5mdWw/DQo+Pj4+DQo+Pj4NCj4+PiBJIGFncmVlIHRoYXQgdGhlIG9uZSBhYm92ZSBkb2Vzbid0
IHF1YWxpZnkgYXMgYSB1c2VmdWwgaGludC4NCj4+PiBJdCBqdXN0IHRlbGxzIHRoYXQgUUVNVSBp
cyBnaXZpbmcgdXAgYW5kIGdpdmVzIG5vIGluZGljYXRpb24NCj4+PiB0byB0aGUgdXNlciBvbiBo
b3cgdG8gYXZvaWQgdGhlIGlzc3VlLiBJdCBzaG91bGQgcHJvYmFibHkgYmUNCj4+PiBkcm9wcGVk
Lg0KPj4+DQo+Pj4+IEF0IGxlYXN0IGZvciBjYXNlcyBsaWtlIHRoaXMsIHdlIGNhbiBjcmVhdGUg
aGVscGVyIGZ1bmN0aW9uDQo+Pj4+DQo+Pj4+IGVycm9yX3NldGdfZXJybm9faGludCguLi4sIGVy
cm9yLCBoaW50KQ0KPj4+DQo+Pj4gTm90IHZlcnkgdXNlZnVsIGlmIGhpbnQgaGFzIHRvIGJlIGZv
cmdlZCBzZXBhcmF0ZWx5IHdpdGgNCj4+PiBnX3NwcmludGYoKSwgYW5kIHdlIGNhbid0IGhhdmUg
c3VjaCBhIHRoaW5nIGFzOg0KPj4+DQo+Pj4gZXJyb3Jfc2V0Z19lcnJub19oaW50KGVycnAsIGVy
cl9mbXQsIC4uLiwgaGludF9mbXQsIC4uLikNCj4+Pg0KPj4+Pg0KPj4+PiBCdXQgd2hhdCBjb3Vs
ZCBiZSBkb25lIHdoZW4gd2UgY2FsbCBmdW5jdGlvbiwgd2hpY2ggbWF5IG9yIG1heSBub3Qgc2V0
IGVycnA/DQo+Pj4+DQo+Pj4+IHJldCA9IGYoZXJycCk7DQo+Pj4+IGlmIChyZXQpIHsNCj4+Pj4g
ICAgICAgZXJyb3JfYXBwZW5kX2hpbnQoZXJycCwgaGludCk7DQo+Pj4+IH0NCj4+Pj4NCj4+Pg0K
Pj4+IFNhbWUgcHJvYmxlbS4gSWYgZXJycCBpcyAmZXJyb3JfZmF0YWwgYW5kIGYoKSBkb2VzIGVy
cm5vX3NldGcoZXJycCksIGl0DQo+Pj4gZW5kcyB1cCBjYWxsaW5nIGV4aXQoKS4NCj4+Pg0KPj4+
PiBIbW1tLi4NCj4+Pj4NCj4+Pj4gQ2FuIGl0IGxvb2sgbGlrZQ0KPj4+Pg0KPj4+PiByZXQgPSBm
KC4uLiwgaGludF9oZWxwZXIoZXJycCwgaGludCkpDQo+Pj4+DQo+Pj4+ID8NCj4+Pj4NCj4+Pg0K
Pj4+IE5vcGUsIGhpbnRfaGVscGVyKCkgd2lsbCBnZXQgY2FsbGVkIGJlZm9yZSBmKCkgYW5kIHRo
aW5ncyBhcmUgd29yc2UuDQo+Pj4gSWYgZXJycCBpcyBOVUxMIHRoZW4gZXJyb3JfYXBwZW5kX2hp
bnQoKSBkb2VzIG5vdGhpbmcgYW5kIGlmIGl0IGlzDQo+Pj4gJmVycm9yX2ZhdGFsIHRoZW4gaXQg
YWJvcnRzLg0KPj4+DQo+Pj4+IEkgY2FuJ3QgaW1hZ2luZSBob3cgdG8gZG8gaXQsIGFzIHNvbWVv
bmUgc2hvdWxkIHJlbW92ZSBoaW50IGZyb20gZXJyb3JfYWJvcnQgb2JqZWN0IG9uDQo+Pj4+IHN1
Y2Nlc3MgcGF0aC4uDQo+Pj4+DQo+Pj4+IEJ1dCBzZWVtcywgdGhlIGZvbGxvd2luZyBpcyBwb3Nz
aWJsZSwgd2hpY2ggc2VlbXMgYmV0dGVyIGZvciBtZSB0aGFuIGxvY2FsLWVycm9yIGFwcHJvYWNo
Og0KPj4+Pg0KPj4+PiBlcnJvcl9wdXNoX2hpbnQoZXJycCwgaGludCk7DQo+Pj4+IHJldCA9IGYo
Li4sIGVycnApOw0KPj4+PiBlcnJvcl9wb3BfaGludChlcnJwKTsNCj4+Pj4NCj4+Pg0KPj4+IE1h
dHRlciBvZiB0YXN0ZS4uLiBhbHNvLCBpdCBsb29rcyBhd2t3YXJkIHRvIGNvbWUgdXAgd2l0aCBh
IGhpbnQNCj4+PiBiZWZvcmUga25vd2luZyB3aGF0IGhhcHBlbmVkLiBJIG1lYW4gdGhlIGFwcHJv
cHJpYXRlIGhpbnQgY291bGQNCj4+PiBkZXBlbmQgb24gdGhlIHZhbHVlIHJldHVybmVkIGJ5IGYo
KSBhbmQvb3IgZXJybm8gZm9yIGV4YW1wbGUuDQo+Pj4NCj4+Pj4gPT09DQo+Pj4+DQo+Pj4+IENv
bnRpbnVlIHRoaW5raW5nIG9uIHRoaXM6DQo+Pj4+DQo+Pj4+IEl0IG1heSBsb29rIGxpa2UganVz
dA0KPj4+PiByZXQgPSBmKC4uLiwgc2V0X2hpbnQoZXJycCwgaGludCkpOw0KPj4+Pg0KPj4+PiBv
ciAoanVzdCB0byBzcGxpdCBsb25nIGxpbmUpOg0KPj4+PiBzZXRfaGludChlcnJwLCBoaW50KTsN
Cj4+Pj4gcmV0ID0gZiguLi4sIGVycnApOw0KPj4+Pg0KPj4+PiBpZiBpbiBlYWNoIGZ1bmN0aW9u
IHdpdGggZXJycCBkb2VzIGVycm9yX3B1c2hfaGludChlcnJwKSBvbiBzdGFydCBhbmQgZXJyb3Jf
cG9wX2hpbnQoZXJycCkgb24gZXhpdCwNCj4+Pj4gd2hpY2ggbWF5IGJlIGp1c3Qgb25lIGNhbGwg
YXQgZnVuY3Rpb24gc3RhcnQgb2YgbWFjcm8sIHdoaWNoIHdpbGwgY2FsbCBlcnJvcl9wdXNoX2hp
bnQoZXJycCkgYW5kDQo+Pj4+IGRlZmluZSBsb2NhbCB2YXJpYWJsZSBieSBnX2F1dG8sIHdpdGgg
Y2xlYW51cCB3aGljaCB3aWxsIGNhbGwgZXJyb3JfcG9wX2hpbnQoZXJycCkgb24gZnVuY3Rpb24N
Cj4+Pj4gZXhpdC4uDQo+Pj4+DQo+Pj4+IE9yLCBtYXkgYmUsIG1vcmUgZGlyZWN0IHdheSB0byBz
ZXQgY2xlYW51cCBmb3IgZnVuY3Rpb24gZXhpc3RzPw0KPj4+Pg0KPj4+PiA9PT0NCj4+Pj4NCj4+
Pj4gQWxzbywgd2UgY2FuIGltcGxlbWVudCBzb21lIGNvZGUgZ2VuZXJhdGlvbiwgdG8gZ2VuZXJh
dGUgZm9yIGZ1bmN0aW9ucyB3aXRoIGVycnAgYXJndW1lbnQNCj4+Pj4gd3JhcHBlcnMgd2l0aCBh
ZGRpdGlvbmFsIGhpbnQgcGFyYW1ldGVyLCBhbmQganVzdCB1c2UgdGhlc2Ugd3JhcHBlcnMuLg0K
Pj4+Pg0KPj4+PiA9PT0NCj4+Pj4NCj4+Pj4gSWYgbm9ib2R5IGxpa2VzIGFueSBvZiBteSBzdWdn
ZXN0aW9ucywgdGhlbiBpZ25vcmUgdGhlbS4gSSB1bmRlcnN0YW5kIHRoYXQgdGhpcyBzZXJpZXMg
Zml4ZXMNCj4+Pj4gcmVhbCBpc3N1ZSBhbmQgbXVjaCBlZmZvcnQgaGFzIGFscmVhZHkgYmVlbiBz
cGVudC4gTWF5IGJlIG9uZSBkYXkgSSdsbCB0cnkgdG8gcmV3cml0ZSBpdC4uLg0KPj4+Pg0KPj4+
DQo+Pj4gRm9yIHRoZSByZWFzb24gZXhwb3NlZCBhYm92ZSwgSSBkb24ndCB0aGluayBpdCBtYWtl
cyBzZW5zZSB0bw0KPj4+IGJ1aWxkIHRoZSBoaW50IGJlZm9yZSBjYWxsaW5nIGEgZnVuY3Rpb24g
dGhhdCBjYWxscyBlcnJvcl9zZXRnKCkuDQo+Pj4gSSdtIGFmcmFpZCB3ZSdyZSBzdHVjayB3aXRo
IGxvY2FsX2Vyci4uLiBpdCBpcyB0aGVuIHVwIHRvIHRoZQ0KPj4+IHBlb3BsZSB0byBtYWtlIGl0
IGFzIGxlc3MgcGFpbmZ1bCBhcyBwb3NzaWJsZS4NCj4+Pg0KPj4NCj4+IEhtbS4gc28sIHNlZW1z
IHRoYXQgaW4gZ2VuZXJhbCB3ZSBuZWVkIGxvY2FsX2Vyci4uDQo+Pg0KPj4gVGhlbiBtYXkgYmUs
IG1heSBjYW4gbWFrZSBhdXRvbWF0ZWQgcHJvcGFnYXRpb24/DQo+Pg0KPj4gSXQgd2lsbCBsb29r
IGxpa2UNCj4+DQo+PiBnX2F1dG8oRXJyb3JQcm9wYWdhdGlvbikgX2Vycm9yX3Byb3AgPSAoRXJy
b3JQcm9wYWdhdGlvbil7DQo+PiAgICAgLmVycnAgPSBlcnJwLA0KPj4gICAgIC5sb2NhbF9lcnIg
PSBOVUxMLA0KPj4gfQ0KPj4NCj4+IGVycnAgPSAmX2Vycm9yX3Byb3AubG9jYWxfZXJyOw0KPj4N
Cj4+IGFuZCB0aGlzIHRoaW5nIG1heSBiZSBmdWxseSBjb3ZlcmVkIGludG8gbWFjcm8sDQo+PiB0
byBsb29rIGxpa2UgdGhpcyBhdCBmdW5jdGlvbiBzdGFydCAodG8gYmUgaG9uZXN0IGl0IHNob3Vs
ZCBleGFjdGx5IGFmdGVyIGFsbA0KPj4gbG9jYWwgdmFyaWFibGUgZGVmaW5pdGlvbnMpOg0KPj4N
Cj4+IE1BS0VfRVJSUF9TQUZFKF9lcnJvcl9wcm9wLCBlcnJwKTsNCj4+DQo+Pg0KPiANCj4gTWF5
YmUgeW91IGNhbiBzZW5kIGFuIFJGQyBwYXRjaCB0aGF0IGNvbnZlcnRzIGEgaGFuZGZ1bCBvZg0K
PiBsb2NhbF9lcnIgdXNlcnMgdG8gZ19hdXRvKCkgPw0KPiANCg0KWWVzLCBJJ2xsIHRyeQ0KDQot
LSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

