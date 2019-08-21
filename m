Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47866C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 16:01:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13CC922CF7
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 16:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="AjsEzgBF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13CC922CF7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0T3E-0001MD-JX
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 12:01:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52774)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <anton.nefedov@virtuozzo.com>) id 1i0T0a-0006fO-HP
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 11:58:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <anton.nefedov@virtuozzo.com>) id 1i0SrX-00081O-P0
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 11:49:28 -0400
Received: from mail-eopbgr80117.outbound.protection.outlook.com
 ([40.107.8.117]:40613 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
 id 1i0SrV-0007zs-Ti; Wed, 21 Aug 2019 11:49:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MZvuqOfvCezgQv15zgc87t7MILMU/LwqWtnd7b5Ks/cJTTEQrDICBeAfLK9/qPYnLKPU9rY+gCmiykoj7qCfOlzN6/QzmRjsyESzpCBNnhBd8YdWRN8PrKPqB9Ltpb6xQ/Ft0opUEQuoK0l/3x8b3YqkKbEVcojkBGNc3BGmELe6mNfjFFtaWxO/rJsFUar0n5EqdBsVDPEaoc2U4rpyIfilf+uva4vdM7AEzVO7XNsv7/fWhK0HPriYaxutEsB6deWDsNyPVddynWaGRZ/Hro3aHXC+lCOOSvFSe8qIoxJ/o3ITabczvP9T3f27ySX3AmnSeRzjuiYxxsIXVc2wkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XaskJxi0E2RNtBeEzKkd2Nv+byP4DrQnv5TcaAAnKH0=;
 b=WP/YX9/UqXGXJmYK+icxfq9aeZWuuWVLY3bRQn7dpTw7Hql2KCY4/eaIw92c++nhEOXdEinLni8K5gPbONo2IIeh6RXNMc6m+2Uh/65JQPXNohuYCBwLefbkbIVv8xGcjtsW38y28aYbfzIaiWyaZZXigOvyuMcj+qtP7SD26+vXvfxUI9Yd6D++c/0Ww1qt/l/Ds60tL7ZDXyAoveRQ1xQUm6V7Cpml+5EhqXJuYbq/rfV4RHKpFvo0k6w9RVK1x6GPwiHdPneavRWYbSDpft1fbbgPR5GPr+K8VzDSTQs/c/qh/dAY4BgtFXrkAZ4b2/dpfQPPnK7FWev4R0JJIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XaskJxi0E2RNtBeEzKkd2Nv+byP4DrQnv5TcaAAnKH0=;
 b=AjsEzgBF3Q6c6iUHJ1+qAY5llrHtqntRBHcS0OVbZ4cj13et0eOZcgq/oL5svkZRX/QYizW1TAColSGtNYdi+/Ua7i1FJaoxNqbCgzpQN5aD3yJoI6e6JLC6ESbqJLLvhuNEGRsLee4T3KJlyRGERtttNf2xE7uduWovDncKK84=
Received: from AM6PR08MB5208.eurprd08.prod.outlook.com (10.255.122.155) by
 AM6PR08MB3160.eurprd08.prod.outlook.com (52.135.163.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Wed, 21 Aug 2019 15:49:23 +0000
Received: from AM6PR08MB5208.eurprd08.prod.outlook.com
 ([fe80::5820:8ce:9eb2:cc42]) by AM6PR08MB5208.eurprd08.prod.outlook.com
 ([fe80::5820:8ce:9eb2:cc42%3]) with mapi id 15.20.2178.018; Wed, 21 Aug 2019
 15:49:23 +0000
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
To: =?utf-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>, QEMU Developers
 <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Max
 Reitz <mreitz@redhat.com>, Andrew Jones <drjones@redhat.com>
Thread-Topic: Broken aarch64 by qcow2: skip writing zero buffers to empty COW
 areas [v2]
Thread-Index: AQHVWCrM0jZeq3hWakapBJmRneBttKcFv6gA
Date: Wed, 21 Aug 2019 15:49:23 +0000
Message-ID: <b9129921-91cb-4339-0a3e-eb73ae5f6390@virtuozzo.com>
References: <db672a84-0f30-bb82-ef94-c543e444372e@redhat.com>
In-Reply-To: <db672a84-0f30-bb82-ef94-c543e444372e@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0301CA0016.eurprd03.prod.outlook.com
 (2603:10a6:3:76::26) To AM6PR08MB5208.eurprd08.prod.outlook.com
 (2603:10a6:20b:eb::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anton.nefedov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6417db1b-8947-4966-f44f-08d7264f2332
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:AM6PR08MB3160; 
x-ms-traffictypediagnostic: AM6PR08MB3160:
x-microsoft-antispam-prvs: <AM6PR08MB316079B777F316D719A7C447F8AA0@AM6PR08MB3160.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0136C1DDA4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39840400004)(376002)(366004)(136003)(396003)(346002)(199004)(189003)(6436002)(186003)(7736002)(31696002)(66066001)(6486002)(86362001)(256004)(5024004)(14444005)(14454004)(71200400001)(71190400001)(102836004)(6512007)(31686004)(26005)(305945005)(25786009)(110136005)(2501003)(53936002)(6246003)(2906002)(36756003)(486006)(446003)(11346002)(478600001)(3846002)(6116002)(8936002)(2616005)(99286004)(66946007)(476003)(76176011)(64756008)(66446008)(66556008)(66476007)(5660300002)(81166006)(81156014)(229853002)(8676002)(52116002)(316002)(44832011)(53546011)(6506007)(386003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3160;
 H:AM6PR08MB5208.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: G6bqRj1hflmVpGUnpVeIynsjLz3GF2lPRB6qnMNWcIPfO8IBk/bUqkhamCGBuvi3MWCGx3MzlGinKJw3j5phkufX/k/9YL9b5Kt+kUwg9DdldeVfYyBq/Lin64dh3OMod83CR6v6YZxsh9S8efL4bV2af8gZypF9NCQSzHgWjK0STfJeG9QnvRZ/1sP9e5p0lyFEdY983RrvRDOzAIfXoPb7m97Y0VGw/lgHiCApiuNiwlfR5HIJDy+QKO6m3Ub1CphtdJDCzguqjwTRp2uD1vcNabkKpvr0s3JXtOcPVVoorJKT5YVrucdK4Mq4cuh39FQlYBdDq7y+17lLmpgLZjHSzqcFP1HUHxNl9zKZy0TCfe7c5KAleMRL9a4WVI9b7dolCZrrhOfiNN1zI/HqwD4jhObwjH1KYbdPqLWgxF4=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <FB2314430191E645A57356AE903EE69F@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6417db1b-8947-4966-f44f-08d7264f2332
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2019 15:49:23.4006 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uSKhx4N0qfT9kUhnlB9vEtitV3lI5OikM3PmOzVdbKUp41unoI71KUMew+NbeYwxFdLqG2Z5D0hew9LE+0ksApETVABb0LHdLO9IPm+g5uY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3160
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.8.117
Subject: Re: [Qemu-devel] Broken aarch64 by qcow2: skip writing zero buffers
 to empty COW areas [v2]
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gMjEvOC8yMDE5IDU6MTQgUE0sIEx1a8OhxaEgRG9rdG9yIHdyb3RlOg0KPiBIZWxsbyBndXlz
LA0KPiANCj4gRmlyc3QgYXR0ZW1wdCB3YXMgcmVqZWN0ZWQgZHVlIHRvIHppcCBhdHRhY2htZW50
LCBsZXQncyB0cnkgaXQgYWdhaW4gd2l0aCBqdXN0IEF2b2NhZG8tdnQgZGVidWcubG9nIGFuZCBz
ZXJpYWwgY29uc29sZSBsb2cgZmlsZXMgYXR0YWNoZWQuDQo+IA0KPiBJIGJpc2VjdGVkIGEgcmVn
cmVzc2lvbiBvbiBhYXJjaDY0IGFsbCB0aGUgd2F5IHRvIHRoaXMgY29tbWl0OiAicWNvdzI6IHNr
aXAgd3JpdGluZyB6ZXJvIGJ1ZmZlcnMgdG8gZW1wdHkgQ09XIGFyZWFzIiBjOGJiMjNjYmRiZTMy
ZjVjMzI2MzY1ZTBhODJlMWIwZTY4Y2RjZDhhLiBXb3VsZCB5b3UgcGxlYXNlIGhhdmUgYSBsb29r
IGF0IGl0Pw0KPiANCj4gTXkgcmVwcm9kdWNlciBpcyBydW5uaW5nIGtpY2tzdGFydCBpbnN0YWxs
YXRpb24gb2YgUkhFTC04IGZyb20gRFZEIG9uIGFhcmNoNjQgZ2ljdjMgbWFjaGluZSwgd2hpY2gg
bmV2ZXIgZmluaXNoZXMgc2luY2UgdGhpcyBjb21taXQsIHdoZXJlIGFuYWNvbmRhIGNvbXBsYWlu
cyBhYm91dCBwYWNrYWdlIGluc3RhbGxhdGlvbiwgb2NjYXNpb25hbGx5IHRoZXJlIGFyZSBhbHNv
IFhGUyBtZXRhZGF0YSBjb3JydXB0aW9uIG1lc3NhZ2VzIG9uIHNlcmlhbCBjb25zb2xlOg0KPiAN
Cg0KaGksDQoNCnRoaXMgbG9va3Mgc2NhcnkgOiggSSBkb3VidCB0aGF0IGl0IGNhbiBoYXZlIGFu
eXRoaW5nIHRvIGRvIHdpdGggYWFyY2g2NA0KYnV0IHJhdGhlciBhIHJlYWxseSB0cmlja3kgdGlt
aW5nIChvciwgcG9zc2libHksIGEgYnJva2VuIGVudmlyb25tZW50DQpsaWtlIGJyb2tlbiBmYWxs
b2NhdGUoKSBvbiBhIGhvc3Q/IHdobyBrbm93cy4uKQ0KDQpJcyBpdCBhbHdheXMgdGhlIHNhbWUg
bWFjaGluZSB5b3Ugb2JzZXJ2ZSB0aGlzIGlzc3VlIG9uPyBEaWQgeW91IHRyeQ0Kb3RoZXJzPw0K
DQpJIGp1c3Qgd29uZGVyIGlmIGl0J3Mgd29ydGggdG8gdHJ5IHRvIHJlcHJvZHVjZSBpdCBvbiBt
eSBtYWNoaW5lDQooYW5kIEkgZG9uJ3QgaGF2ZSBhYXJjaDY0IG9uIGhhbmQgbm93KS4gSSBjYW4g
cHJvYmFibHkgY29tZSB1cCB3aXRoDQpzb21lIHRvcnR1cmUgdGVzdCB0aGF0IHdpbGwgY29udGlu
dW91c2x5IHdyaXRlIHRvIHFjb3cyIHdpdGggcmFuZG9tDQpvZmZzZXRzL3NpemVzIGFuZCB2ZXJp
ZnkgdGhlIHJlc3VsdC4NCg0KSWYgeW91IGNvdWxkIGtpbmRseSByZXByb2R1Y2UgaXQgYWdhaW4g
dGhlbiB3ZSBjYW4gcHJvYmFibHkgc3RhcnQgd2l0aA0KZW5hYmxpbmcgcWVtdSB0cmFjZXMgYnkg
YXBwZW5kaW5nDQogICIgLXRyYWNlIGJkcnYqIC10cmFjZSBxY293MiogLXRyYWNlIGZpbGU9L3Nv
bWVfaHVnZV9wYXJ0aXRpb24vcWVtdS5sb2ciDQp0byB0aGUgY29tbWFuZCBsaW5lLg0KDQpCZXdh
cmUgdGhhdCBpdCdzIGdvaW5nIHRvIHByb2R1Y2UgYSBodWdlIGFtb3VudCBvZiBsb2dzLg0KDQpB
bHNvLCB0aGUgY29ycnVwdGVkIGltYWdlIGFuZCB0aGUgc2VyaWFsIGxvZyB3aWxsIGJlIHJlcXVp
cmVkIGZvcg0KaW52ZXN0aWdhdGlvbi4NCg0KdGhhbmtzLA0KDQovQW50b24NCg==

