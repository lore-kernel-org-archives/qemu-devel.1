Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C2DC43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 16:32:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BC7620801
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 16:32:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="BZ9g6jzR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BC7620801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icu3Y-0001Go-Fr
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 11:32:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55220)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1icu0v-00088w-Sp
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 11:30:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1icu0t-0004jr-7H
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 11:30:01 -0500
Received: from mail-eopbgr150094.outbound.protection.outlook.com
 ([40.107.15.94]:13781 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1icu0q-0004gW-43
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 11:29:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jhz9hZoG4NwLHHY9Y3IiUjShZbB5Atuz0l6I9rf1lT5ZusjmgwCPLZlxFZ77jS6SsPh1wTMDJtCB5sQOpOnDN04+FjvHEnhJKyJKRVCjc6GXDanljGGAukjd5yPJrHef3OWueRnHnM6BMhaFYI8pkdjbhwD5K7e56EmfR6UU/leX6UjOpLlyOA5s+oAkq5esjISzYyp+/vCXXYzrLDJsziro529wPHpNnlsYXYXf3LAAGcKuHhvQ/9dTVI97hPNCXtphC7InIjqRdMCxPqMcrHupoKs26S3UwBzT64UD13NqPQ/aY3g4ROB3BiTXdbsIbcyMHbjq9/i+LveQsfjRug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=si2BCrfz7kWaQ/mh011tYkQHgKg45PNS4TvsB5np93g=;
 b=fSbpxAQLbwPG9OP+Fgcufo2QUa2d9qDi5ZVJCUUIKWhcInBN9D6Mdg8ExajSx1cQkjqGWpKeNSGmwB6dRXvAPck0P6WyQUiK5UrK70mtdk9PfigNWv9T6n7yxCaRK8XRcYgFDmouzAsXFVqWl7tSyZs4FaJbsZapYfYNSHGnSAKXIcD6la9tDYI0ciCbVR320NyE2bK0egPNAa1pNYhI1WpLbxEKMJmqmmLNW2Kougz5KzT40ZAQDftbdqDHCPfPVSitKt1RqTPcCOy3YaASOoVcfvknayLZdPEu5DYt5Cf+AXr3GYOBHMRZL3D9U8SzFVOtpigYR0peWpmy7zlS/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=si2BCrfz7kWaQ/mh011tYkQHgKg45PNS4TvsB5np93g=;
 b=BZ9g6jzRXqr/9ogiGPIGQKNw25/7HhBWpG8lQbhj+iYUFZbQ4doOMorxKzO8mLW5XVi+rku+cDbN/brDPGQVBjJOetacvs/nTthiK6onqIpTJnE63JPsTcVZkxghaeUFCnFdmDAOpW4Pp4bZrDMChKESxaJcfkcNt3/0VGqxKkI=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3765.eurprd08.prod.outlook.com (20.178.91.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.14; Thu, 5 Dec 2019 16:29:50 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2516.014; Thu, 5 Dec 2019
 16:29:50 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Markus Armbruster <armbru@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH 12/21] qga: Fix latent guest-get-fsinfo error handling bug
Thread-Topic: [PATCH 12/21] qga: Fix latent guest-get-fsinfo error handling bug
Thread-Index: AQHVp7Zdezk2Va4+UEq4nSSEPT1nCKerwv8A
Date: Thu, 5 Dec 2019 16:29:50 +0000
Message-ID: <c6fef374-f62f-5909-8e3e-d928abba19b2@virtuozzo.com>
References: <20191130194240.10517-1-armbru@redhat.com>
 <20191130194240.10517-13-armbru@redhat.com>
In-Reply-To: <20191130194240.10517-13-armbru@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0202CA0032.eurprd02.prod.outlook.com
 (2603:10a6:3:e4::18) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191205192948786
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cd08189e-d3a3-4166-7883-08d779a059ca
x-ms-traffictypediagnostic: AM6PR08MB3765:
x-microsoft-antispam-prvs: <AM6PR08MB3765DC96C51B064881C82B2BC15C0@AM6PR08MB3765.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:127;
x-forefront-prvs: 02426D11FE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(346002)(396003)(136003)(376002)(39850400004)(189003)(199004)(66446008)(66556008)(8936002)(64756008)(66476007)(66946007)(229853002)(186003)(86362001)(4326008)(26005)(2906002)(102836004)(14454004)(5660300002)(305945005)(8676002)(81156014)(81166006)(478600001)(25786009)(31686004)(110136005)(36756003)(6486002)(6512007)(2616005)(11346002)(71200400001)(6506007)(31696002)(316002)(52116002)(71190400001)(99286004)(76176011);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3765;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GEyZNAD9vAkRyzpRlusUEA3s4+qMR2gFmEklUF9jlCqiHQVAB6eEPAsJQEo0FCnMgeajMW3JKtPwDfvypjTDUYq9baXA1Qt4agpl6WHKgr5zSFk0zwxfpdeYgK357gbhAtHlAEfwj3DkOmOdOsUTbEr84VMx11YTTXmO9rRR1atRwj3rlqPIJEIxzgVKQhdaW/j3NnYaYlGFZtdX6V33yMAgsPIsYyU79GPFzwMHg7UBFGhxfjGH7u2dmXF+kCz9B9A9sPGHhUUrguSwEcnWewYYNjqu4BWSFhztHnvG9PfhLOcODnYFd0qxSoJFjY5p5awxGQ9uoEuwSmZsdO489S/qbZIMTlJYoNOQzRgyAM7spNsX7aVkIPu9CJaA4DMZvyjrFMU+kww1mBHTHvAmh9lJbHe95DzyX4WaD8KK5/fn77mwGpZzrh1pFQU2xVQw
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E282366A6C389A44A68A53082EB4CD9C@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd08189e-d3a3-4166-7883-08d779a059ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2019 16:29:50.5973 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xo87rHgfCccCdUOlTkc7ighH0jW7RXTK5YLg39JXpjkO0QHj9oxJqEKN9cQLy09ycu5Ok6/7TyILNL961u0xY35CDwa4DOy1uZJGNPAZP0I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3765
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.15.94
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
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MzAuMTEuMjAxOSAyMjo0MiwgTWFya3VzIEFybWJydXN0ZXIgd3JvdGU6DQo+IGJ1aWxkX2d1ZXN0
X2ZzaW5mb19mb3JfdmlydHVhbF9kZXZpY2UoKSBjcmFzaGVzIHdoZW4NCj4gYnVpbGRfZ3Vlc3Rf
ZnNpbmZvX2Zvcl9kZXZpY2UoKSBmYWlscyBhbmQgaXRzIEBlcnJwIGFyZ3VtZW50IGlzIG51bGwu
DQo+IE1lc3NlZCB1cCBpbiBjb21taXQgNDZkNGM1NzIzZSAicWdhOiBBZGQgZ3Vlc3QtZ2V0LWZz
aW5mbyBjb21tYW5kIi4NCj4gDQo+IFRoZSBidWcgY2FuJ3QgYml0ZSBhcyBubyBjYWxsZXIgYWN0
dWFsbHkgcGFzc2VzIG51bGwuICBGaXggaXQgYW55d2F5Lg0KPiANCj4gQ2M6IE1pY2hhZWwgUm90
aCA8bWRyb3RoQGxpbnV4LnZuZXQuaWJtLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogTWFya3VzIEFy
bWJydXN0ZXIgPGFybWJydUByZWRoYXQuY29tPg0KDQoNClJldmlld2VkLWJ5OiBWbGFkaW1pciBT
ZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+DQoNCkFjdHVhbGx5
LCBhbGwgc3VjaCBidWdzIHNob3VsZCBiZSBmaXhlZCBieSBteSBhdXRvLWdlbmVyYXRlZCBzZXJp
ZXMuLg0KQW5kLCBpZiBmaXhpbmcgYnkgaGFuZCwgaXQgbWF5IGJlIGJldHRlciB0byB0ZWFjaCB0
aGlzIGZ1bmN0aW9uIHRvIHJldHVybg0KaW50LCB0aGFuIHByb3BhZ2F0aW9uIGlzIG5vdCBuZWVk
ZWQuDQoNCj4gLS0tDQo+ICAgcWdhL2NvbW1hbmRzLXBvc2l4LmMgfCA2ICsrKystLQ0KPiAgIDEg
ZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvcWdhL2NvbW1hbmRzLXBvc2l4LmMgYi9xZ2EvY29tbWFuZHMtcG9zaXguYw0KPiBp
bmRleCAxYzFhMTY1ZGFlLi4wYmU1MjdjY2I4IDEwMDY0NA0KPiAtLS0gYS9xZ2EvY29tbWFuZHMt
cG9zaXguYw0KPiArKysgYi9xZ2EvY29tbWFuZHMtcG9zaXguYw0KPiBAQCAtMTA0OSw2ICsxMDQ5
LDcgQEAgc3RhdGljIHZvaWQgYnVpbGRfZ3Vlc3RfZnNpbmZvX2Zvcl92aXJ0dWFsX2RldmljZShj
aGFyIGNvbnN0ICpzeXNwYXRoLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgR3Vlc3RGaWxlc3lzdGVtSW5mbyAqZnMsDQo+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBFcnJvciAqKmVycnApDQo+
ICAgew0KPiArICAgIEVycm9yICplcnIgPSBOVUxMOw0KPiAgICAgICBESVIgKmRpcjsNCj4gICAg
ICAgY2hhciAqZGlycGF0aDsNCj4gICAgICAgc3RydWN0IGRpcmVudCAqZW50cnk7DQo+IEBAIC0x
MDc4LDEwICsxMDc5LDExIEBAIHN0YXRpYyB2b2lkIGJ1aWxkX2d1ZXN0X2ZzaW5mb19mb3Jfdmly
dHVhbF9kZXZpY2UoY2hhciBjb25zdCAqc3lzcGF0aCwNCj4gICANCj4gICAgICAgICAgICAgICBn
X2RlYnVnKCIgc2xhdmUgZGV2aWNlICclcyciLCBlbnRyeS0+ZF9uYW1lKTsNCj4gICAgICAgICAg
ICAgICBwYXRoID0gZ19zdHJkdXBfcHJpbnRmKCIlcy9zbGF2ZXMvJXMiLCBzeXNwYXRoLCBlbnRy
eS0+ZF9uYW1lKTsNCj4gLSAgICAgICAgICAgIGJ1aWxkX2d1ZXN0X2ZzaW5mb19mb3JfZGV2aWNl
KHBhdGgsIGZzLCBlcnJwKTsNCj4gKyAgICAgICAgICAgIGJ1aWxkX2d1ZXN0X2ZzaW5mb19mb3Jf
ZGV2aWNlKHBhdGgsIGZzLCAmZXJyKTsNCj4gICAgICAgICAgICAgICBnX2ZyZWUocGF0aCk7DQo+
ICAgDQo+IC0gICAgICAgICAgICBpZiAoKmVycnApIHsNCj4gKyAgICAgICAgICAgIGlmIChlcnIp
IHsNCj4gKyAgICAgICAgICAgICAgICBlcnJvcl9wcm9wYWdhdGUoZXJycCwgZXJyKTsNCj4gICAg
ICAgICAgICAgICAgICAgYnJlYWs7DQo+ICAgICAgICAgICAgICAgfQ0KPiAgICAgICAgICAgfQ0K
PiANCg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

