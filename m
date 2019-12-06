Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D9A9C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 20:03:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6E04206C3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 20:03:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="RrUFWtng"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6E04206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idJp9-0006iT-Dw
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 15:03:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45832)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1idJmE-000586-Kb
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 15:00:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1idJmD-0001ay-8s
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 15:00:34 -0500
Received: from mail-eopbgr10102.outbound.protection.outlook.com
 ([40.107.1.102]:3138 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1idJm7-0001TI-3m; Fri, 06 Dec 2019 15:00:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nEIEwVQmBejYXh63+xLA6olFASH0otlXLb1GaIBtNcHFk0t0MIfjq/dOMBrU+D8TICusLazeOgtUh0ukDipMtZMfwY73ekUgewbSsT/Xuv/eQCiZdSeCnhtgQj1ortNrEVmcjGGEdWLHeRLvWQ63JWhMcWigzRVCtJuqK/At2+v293tCyyp2wNX5UJfCOfrD6r0i32aWtIPRc5ieBgbI3y9SP0Zwx5AddjEF/3OqixXUCoGAFMBrrzn6caaUhgUWIKb2m0HpqtU2Dr3o7EHhF5YvksGhVVxm01J9KDsugnAGHpDt3XyusU9SZyRAxKOISsKv+hYSvrDIECnlwKxKpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vVfLe7maMGsLehnqQxXLR4Z7ks3IA1mbSQZhUot/PJs=;
 b=CPC8LntrI4RVnc8iYpEPGpYYn3MHxoSCATgUqno1iLanOzOw8MC8i5KL9twBQ0izUpA+Lza+Sqcspm0xvTtwVBUOWud5kbyxJk6AVEbVFKeEfwxWVf0Xpd2boGJCaWF5TW0b0Jw5LSibDq/9xrqZaabxBOrG+8x/bePYAjdz/QqwUQ/evcIcO0ZduH06lx50fTkYbSW5CMZ14nphFGYyQ1FEey4K801x/iU9b0K6dYw0hKU6qZE7JPSKdJzVOVR/veHP3BcLrdOMatqzV7xQ6UT1vZ/vNrddeGdiewsrrRierljPykqg7QxoZkDqsuQ9L7xnfddIEVoJcd6tOAaYrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vVfLe7maMGsLehnqQxXLR4Z7ks3IA1mbSQZhUot/PJs=;
 b=RrUFWtngFk347yBBbvRwqDSmNtIum5Bd7qne7jRYYLNFLg8fV3yrXppL61Jkwpe/xiDOq74BZKd/otseBLrkGqZT61rTxwhSs3ATTUGVO60zBqz+m08faT+F6pj8IVMEgjC4bC9GmsCboAs99hGt4b8DAwF969Qky4Z8Zi7QLCQ=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4818.eurprd08.prod.outlook.com (10.255.98.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.17; Fri, 6 Dec 2019 20:00:22 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2516.014; Fri, 6 Dec 2019
 20:00:22 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Cleber Rosa <crosa@redhat.com>
Subject: Re: [PATCH for-5.0 v2 0/3] benchmark util
Thread-Topic: [PATCH for-5.0 v2 0/3] benchmark util
Thread-Index: AQHVpHEG5YfDz7UI8UOBrTTRR2csGaetkfeAgAAEuIA=
Date: Fri, 6 Dec 2019 20:00:22 +0000
Message-ID: <88e4e98d-7b35-b8fd-547b-d356cb7b71d5@virtuozzo.com>
References: <20191126154848.193407-1-vsementsov@virtuozzo.com>
 <20191206194325.GB6252@dhcp-17-72.bos.redhat.com>
In-Reply-To: <20191206194325.GB6252@dhcp-17-72.bos.redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0178.eurprd05.prod.outlook.com
 (2603:10a6:3:f8::26) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191206230019672
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b0e6b74b-f12d-44f1-6ae3-08d77a86ed48
x-ms-traffictypediagnostic: AM6PR08MB4818:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR08MB4818CCEBB8B0681632F8671BC15F0@AM6PR08MB4818.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0243E5FD68
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(376002)(396003)(346002)(39850400004)(366004)(199004)(189003)(53754006)(71190400001)(31696002)(5660300002)(81156014)(305945005)(71200400001)(6916009)(2616005)(229853002)(8676002)(66476007)(66946007)(66556008)(26005)(66446008)(64756008)(8936002)(81166006)(186003)(6512007)(2906002)(86362001)(102836004)(76176011)(6506007)(4326008)(52116002)(7416002)(966005)(316002)(6486002)(99286004)(31686004)(478600001)(54906003)(36756003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4818;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H4+QyBHoLfBNOl2OhEvFJ/8lADUhVk/wPLjxQRoc5ZCfcCzz8MIktK78umHhBnNOTKZ4u0ODhf1lJ3a606wqWiWIcQ4zOe2Bqi7FkpoX4DY008b4tDe0pMl5Y5rGIx0U1HzTOOsVwc5nSC654Aw5wUe5dfmdDPejQ2EqWqYrZ5C5FxDQodR4omeSfPc1HpEfLXTxZ2F8o1YqzSuz+aTIZp8Fbove/6TA2ocZxbufWN44M3Ekb/3G1H6IYWXrakwsVkEaEdJH0Mkx9BMxDEUxoar7T7CepwvWu/rTAgFRpziNKjPRyxAUm+sscjQTgwJfJtVV2yz6m6/+KDqFBJU2fBwnOJ6HVR4v9QrbFa1PGZHYV9dPswCIAxxvMvzFpM3IDdJRRR1TTB7yUgpBbWxw135OiDqD/R/2dQaFp8HW1/mAyR2WimllZ0OCXq/2yoWHjmNoWkbKE7svjJgZc0B9hgNn4R7hAGOzJDJd1FwvMN74jUz0+VvDfjTzTktrppQ7kKu1OXxf4KkB1b+MmgrQngDdiB0KTLU1vw7U5jNC2Oo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F8985D1CD76F6A499760687315D81293@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0e6b74b-f12d-44f1-6ae3-08d77a86ed48
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2019 20:00:22.2576 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TfjHC3+LVPqeTNet/Syi7wmSSiIgROBnQfvdI/B4VFq6+cpHjtFQ+g7oXizdGt7KLmQHH3drkNER4Yp06axkCUaOeU9cnXWcsMxn38k0DCc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4818
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.102
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
 =?utf-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>,
 Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "stefanha@gmail.com" <stefanha@gmail.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDYuMTIuMjAxOSAyMjo0MywgQ2xlYmVyIFJvc2Egd3JvdGU6DQo+IE9uIFR1ZSwgTm92IDI2LCAy
MDE5IGF0IDA2OjQ4OjQ1UE0gKzAzMDAsIFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgd3Jv
dGU6DQo+PiBIaSBhbGwhDQo+Pg0KPj4gSGVyZSBpcyBzaW1wbGUgYmVuY2htYXJraW5nIHV0aWxp
dHksIHRvIGdlbmVyYXRlIHBlcmZvcm1hbmNlDQo+PiBjb21wYXJpc29uIHRhYmxlcywgbGlrZSB0
aGUgZm9sbG93aW5nOg0KPj4NCj4+IC0tLS0tLS0tLS0gIC0tLS0tLS0tLS0tLS0gIC0tLS0tLS0t
LS0tLS0gIC0tLS0tLS0tLS0tLS0NCj4+ICAgICAgICAgICAgICBiYWNrdXAtMSAgICAgICBiYWNr
dXAtMiAgICAgICBtaXJyb3INCj4+IHNzZCAtPiBzc2QgIDAuNDMgKy0gMC4wMCAgIDQuNDggKy0g
MC4wNiAgIDQuMzggKy0gMC4wMg0KPj4gc3NkIC0+IGhkZCAgMTAuNjAgKy0gMC4wOCAgMTAuNjkg
Ky0gMC4xOCAgMTAuNTcgKy0gMC4wNQ0KPj4gc3NkIC0+IG5iZCAgMzMuODEgKy0gMC4zNyAgMTAu
NjcgKy0gMC4xNyAgMTAuMDcgKy0gMC4wNw0KPj4gLS0tLS0tLS0tLSAgLS0tLS0tLS0tLS0tLSAg
LS0tLS0tLS0tLS0tLSAgLS0tLS0tLS0tLS0tLQ0KPj4NCj4+IFRoaXMgaXMgYSB2MiwgYXMgdjEg
d2FzIGluc2lkZQ0KPj4gICAiW1JGQyAwMC8yNF0gYmFja3VwIHBlcmZvcm1hbmNlOiBibG9ja19z
dGF0dXMgKyBhc3luYyINCj4+DQo+PiBJJ2xsIHVzZSB0aGlzIGJlbmNobWFyayBpbiBvdGhlciBz
ZXJpZXMsIGhvcGUgc29tZW9uZQ0KPj4gd2lsbCBsaWtlIGl0Lg0KPj4NCj4+IFZsYWRpbWlyIFNl
bWVudHNvdi1PZ2lldnNraXkgKDMpOg0KPj4gICAgcHl0aG9uOiBhZGQgc2ltcGxlYmVuY2gucHkN
Cj4+ICAgIHB5dGhvbjogYWRkIHFlbXUvYmVuY2hfYmxvY2tfam9iLnB5DQo+PiAgICBweXRob246
IGFkZCBleGFtcGxlIHVzYWdlIG9mIHNpbXBsZWJlbmNoDQo+Pg0KPj4gICBweXRob24vYmVuY2gt
ZXhhbXBsZS5weSAgICAgICAgfCAgODAgKysrKysrKysrKysrKysrKysrKysrDQo+PiAgIHB5dGhv
bi9xZW11L2JlbmNoX2Jsb2NrX2pvYi5weSB8IDExNSArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKw0KPj4gICBweXRob24vc2ltcGxlYmVuY2gucHkgICAgICAgICAgfCAxMjggKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrDQo+PiAgIDMgZmlsZXMgY2hhbmdlZCwgMzIzIGluc2Vy
dGlvbnMoKykNCj4+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IHB5dGhvbi9iZW5jaC1leGFtcGxlLnB5
DQo+PiAgIGNyZWF0ZSBtb2RlIDEwMDc1NSBweXRob24vcWVtdS9iZW5jaF9ibG9ja19qb2IucHkN
Cj4+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IHB5dGhvbi9zaW1wbGViZW5jaC5weQ0KPj4NCj4+IC0t
IA0KPj4gMi4xOC4wDQo+Pg0KPiANCj4gSGkgVmxhZGltaXIsDQo+IA0KPiBUaGlzIGxvb2tzIGlu
dGVyZXN0aW5nLg0KPiANCj4gRG8geW91IHRoaW5rIHRoZSBleGVjdXRpb24gb2YgInRlc3QgY2Fz
ZXMiIGluIGFuICJlbnZpcm9ubWVudCIgYXJlIGENCj4gZ2VuZXJpYyBlbm91Z2ggY29uY2VwdCB0
aGF0IGNvdWxkIGJlIHJldXNlZCAob3IgcmV1c2Ugb3RoZXIgc3lzdGVtKT8NCg0KdGhhdCB3YXMg
bXkgZ29hbDogdG8gbWFrZSBzb21ldGhpbmcgZ2VuZXJpYyBlbm91Z2gsIGJ1dCBzaW1wbGUuIFll
cywNCml0IGNhbiBiZSByZXVzZWQgZm9yIGFueXRoaW5nDQoNCj4gTXkgcG9pbnQgaXMgdGhhdCBp
dCdkIGJlIG5pY2UgdG8gZG8gdGhlIHNhbWUgdGhpbmcgc2F5IGZvciB0aGUNCj4gYWNjZXB0YW5j
ZSB0ZXN0cywgb3IgYW55IHRlc3RzIGZvciB0aGF0IG1hdHRlci4gIEZvciBpbnN0YW5jZSwgZm9y
DQo+IGtub3duIHBhcmFtZXRlcnMsIHdlIGNvdWxkIHJlY29yZCB3aGF0J3MgdGhlIHRpbWUgZGlm
ZmVyZW5jZSBiZXR3ZWVuDQo+IGJvb3RpbmcgYSBndWVzdCB3aXRoIHEzNSBvciBwYyBtYWNoaW5l
IHR5cGVzIGFuZCB2aXJ0aW8tYmxvY2sgb3INCj4gdmlydGlvLXNjc2kgZGV2aWNlcy4NCj4gDQo+
IEJUVywgVGhpcyByZW1pbmRlZCBtZSBvZiBhIElPem9uZVsxXSB0ZXN0IHJ1bm5lciAvIHJlc3Vs
dHMgYW5hbHl6ZXI6DQo+IA0KPiAgICBodHRwczovL2dpdGh1Yi5jb20vYXZvY2Fkby1mcmFtZXdv
cmstdGVzdHMvYXZvY2Fkby1taXNjLXRlc3RzL2Jsb2IvbWFzdGVyL2lvL2Rpc2svaW96b25lLnB5
DQo+IA0KPiBJJ20gYWxzbyBjYydpbmcgTHVrw6HFoSBEb2t0b3IsIHdobyBoYXMgYWN0aXZlbHkg
d29ya2VkIGluIHNvbWV0aGluZw0KPiBzaW1pbGFyLg0KPiANCj4gQ2hlZXJzLA0KPiAtIENsZWJl
ci4NCj4gDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

