Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF02C3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 15:03:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 881B52080F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 15:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="UwP5wnh4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 881B52080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3Lwy-0004iC-GO
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 11:03:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47523)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i3LuN-0003Uz-DL
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 11:00:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i3LuL-0006Wf-6C
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 11:00:18 -0400
Received: from mail-eopbgr60096.outbound.protection.outlook.com
 ([40.107.6.96]:24838 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1i3LuK-0006UY-Vz; Thu, 29 Aug 2019 11:00:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ccwnZhkXt9bK6+O0ORhYejTpT8meW3dr+S/poBWq/Bwdv+hcPNUKojAn32koWjSZDkFm6S20YnoZjA80HdGE1s/1p8pnwOP5H+al89hD07pdhuLIIqq+58t8XpX6nQafUDATO4ITvPQNfHE3aC8q8r3AdRLOhdBp1PoVSUX0Cx4RpVGHFulLAicfWOjk9mMXuZ/OKr2TA5I9oDlnJI/0EjD6vPjhgv9RjJqnOdMxyN8nELagN9FnVMz1wWC2Sr7HlvpQIKwt2N8N1DfWp9L4UwDXEPMibjsaEzxxaxJlBeGeBc8tJyrN3oiWEQRX6fNqJKzd6mmHAeojpHpvQBr2Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k70lRC7q3h7jWuL0mBwFxh5MVJ1MjxAJy1J6OcV69Yw=;
 b=PrWX7MsP1RtpROGeWRw2Ik9qmFRa8s6tcF4/M+Ampa8pjyWXZ7T9qZ1LyNgLeIA4rbvD6fCvKxPN9yyIQ/ERbgKqYF8wnmeduTz8yMi0mAu3Ib2p6hYysNMmpof7xG7W9sVvhqrGOANWfbBWg4NxEN/JmuaQFsXsN3LUFCwcNi5ic6Vb5X5TidIT22eEkjkjOS9roiP/itmaArfPszL0YEYM3hLYRu5JtD8LUr98sO0ZFlxLyl+LAqrKJA9INo64EkW1V0/OZ4cYKNKrvjJuzAJRH/TCYV2yIax+pTAYfAdxjea4Zv7luzXnAWZxdXfTjKOoeWQ+KfcaGK0xfDNKag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k70lRC7q3h7jWuL0mBwFxh5MVJ1MjxAJy1J6OcV69Yw=;
 b=UwP5wnh4/pzV1KUZbT4uJ9YejAQspd1Vd1yCjc+7LMeIn6x8zjUnxy5hCsX/MgVXfTNEd38o4GrqXUuWKgw+/tYO26/Tkb3TH/srz+zZQhpc/km0uCWD7eOa8Nz9+Fh78DXJNKWvETDHuUiernQHryJAz/Ky2OPHYZB1lbRm8XI=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4025.eurprd08.prod.outlook.com (20.179.10.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.19; Thu, 29 Aug 2019 15:00:15 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2199.021; Thu, 29 Aug 2019
 15:00:15 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>, Peter Krempa <pkrempa@redhat.com>
Thread-Topic: [PATCH 2/2] qapi: deprecate implicit filters
Thread-Index: AQHVUogdkuEpfSqLt0qlSVbE/q5j26cIg2YAgAb++gCAANxRAIAAjcEAgAFjZwA=
Date: Thu, 29 Aug 2019 15:00:15 +0000
Message-ID: <28206440-3929-7bb5-f4ea-ee14a9018eab@virtuozzo.com>
References: <20190814100735.24234-1-vsementsov@virtuozzo.com>
 <20190814100735.24234-3-vsementsov@virtuozzo.com>
 <de4667c2-7fd7-932d-6ce3-9844f284a0b4@virtuozzo.com>
 <d2bf50f1-e441-4cdb-291f-119a3ed93f51@redhat.com>
 <ba0e7e98-d02f-3514-b435-71923a483c6e@virtuozzo.com>
 <5b8dc9fa-6778-add9-01ae-7259d6bf633c@redhat.com>
In-Reply-To: <5b8dc9fa-6778-add9-01ae-7259d6bf633c@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0219.eurprd05.prod.outlook.com
 (2603:10a6:3:fa::19) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190829180012678
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 58f03f99-1d0a-4fb5-5412-08d72c91993d
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB4025; 
x-ms-traffictypediagnostic: DB8PR08MB4025:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB402544E6CDC485B3B59A6953C1A20@DB8PR08MB4025.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0144B30E41
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(346002)(376002)(136003)(39850400004)(396003)(189003)(199004)(71190400001)(71200400001)(6506007)(386003)(486006)(54906003)(110136005)(305945005)(52116002)(76176011)(6246003)(229853002)(6486002)(966005)(14454004)(478600001)(6116002)(3846002)(107886003)(6306002)(6512007)(8936002)(36756003)(31686004)(66066001)(81156014)(186003)(81166006)(26005)(2616005)(8676002)(476003)(86362001)(102836004)(14444005)(256004)(11346002)(7736002)(6436002)(316002)(53546011)(446003)(53936002)(31696002)(5660300002)(2501003)(66446008)(64756008)(66556008)(66946007)(66476007)(25786009)(99286004)(4326008)(2906002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4025;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: OS0M0382uOcJk46f1s/mJAJ6AYZNMBu4R9jGQ4+jS8LmxeaRaso3i2j7dYjrczc67JWNkQtbSXn8E+UJAEx8t70UFApo9N7aadC3EhSnVEPm32P9Jlz2cgAydDdeoS1CClVypQLnmfPsbrtAyXu3FYuU/kvI6qux/BwSRCCgrvTZ++a7Zvl2VDscr8IWgZpLp5vLHNJAgLi98juxstt1qsRCLy0MgmRWRv/W4FRvJAo7V1pNjlIqcOO+glP/hjtElFyJvQGOxxOnG1qjWHJfXvpcll+gomcRHxnwsyYBqVhv6JVcBDBRjzPuecaNz1qQHtuvsQ97K4YPrkQ/J3oDteZW49JrmNiy7GSaEQo14cDwB0s88FhxEMzaxrbAQ1CT7KH51/zH8JRIAlP9o/lRwBqnkb2ykPiu5Gol04nIsO0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8D985D7761576C40B2FA60BE32E929CE@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58f03f99-1d0a-4fb5-5412-08d72c91993d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2019 15:00:15.0589 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4TdrVWx5D7SPnVpkQWEw+rgnktZ3QkZoPBXfuPEMMp+6V5FVNC0ExusEOaMqChKinpH+RYkD9l6pCM2yojxxz74Ne3PtGQE9ZC31acgmC5M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4025
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.6.96
Subject: Re: [Qemu-devel] [PATCH 2/2] qapi: deprecate implicit filters
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
 "libvir-list@redhat.com" <libvir-list@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjguMDguMjAxOSAyMDo0OCwgSm9obiBTbm93IHdyb3RlOg0KPiAoUGV0ZXI6IHNlYXJjaCBmb3Ig
InBrcmVtcGEiIGRvd24gYmVsb3cuKQ0KPiANCj4gT24gOC8yOC8xOSA1OjIwIEFNLCBWbGFkaW1p
ciBTZW1lbnRzb3YtT2dpZXZza2l5IHdyb3RlOg0KPj4gMjcuMDguMjAxOSAyMzoxMiwgSm9obiBT
bm93IHdyb3RlOg0KPj4+DQo+Pj4NCj4+PiBPbiA4LzIzLzE5IDU6MjIgQU0sIFZsYWRpbWlyIFNl
bWVudHNvdi1PZ2lldnNraXkgd3JvdGU6DQo+Pj4+IDE0LjA4LjIwMTkgMTM6MDcsIFZsYWRpbWly
IFNlbWVudHNvdi1PZ2lldnNraXkgd3JvdGU6DQo+Pj4+PiBUbyBnZXQgcmlkIG9mIGltcGxpY2l0
IGZpbHRlcnMgcmVsYXRlZCB3b3JrYXJvdW5kcyBpbiBmdXR1cmUgbGV0J3MNCj4+Pj4+IGRlcHJl
Y2F0ZSB0aGVtIG5vdy4NCj4+Pj4NCj4+Pj4gSW50ZXJlc3RpbmcsIGNvdWxkIHdlIGRlcHJlY2F0
ZSBpbXBsaWNpdCBmaWx0ZXIgd2l0aG91dCBkZXByZWNhdGlvbiBvZiB1bm5lY2Vzc2l0eSBvZg0K
Pj4+PiBwYXJhbWV0ZXI/IEFzIGFjdHVhbGx5LCBpdCdzIGdvb2Qgd2hlbiB0aGlzIHBhcmFtZXRl
ciBpcyBub3QgbmVjZXNzYXJ5LCBpbiBtb3N0IGNhc2VzDQo+Pj4+IHVzZXIgaXMgbm90IGludGVy
ZXN0ZWQgaW4gbm9kZS1uYW1lLg0KPj4+Pg0KPj4+DQo+Pj4gaHR0cHM6Ly9lbi53aWt0aW9uYXJ5
Lm9yZy93aWtpL3VubmVjZXNzaXR5IC0tIEkgYW0gc3VycHJpc2VkIHRvIGxlYXJuDQo+Pj4gdGhh
dCB0aGlzIGEgcmVhbCB3b3JkIGluIHRoZSBsYW5ndWFnZSBJIHNwZWFrLiA6KQ0KPj4+DQo+Pj4g
SSBhc3N1bWUgeW91J3JlIHJlZmVycmluZyB0byBtYWtpbmcgdGhlIG9wdGlvbmFsIGFyZ3VtZW50
IG1hbmRhdG9yeS4NCj4+DQo+PiBleGFjdGx5LCBpdCdzIG15IGEgYml0ICJnb29nbGUtdHJhbnNs
YXRlLWRyaXZlbiIgRW5nbGlzaCkNCj4+DQo+IA0KPiBJdCB0ZWFjaGVzIG1lIHNvbWUgZnVuIHdv
cmRzIQ0KPiANCj4+Pg0KPj4+PiBPYnZpb3VzbHkgd2UgY2FuIGRvIHRoZSBmb2xsb3dpbmc6DQo+
Pj4+DQo+Pj4+IDEuIEluIDQuMiB3ZSBkZXByZWNhdGUgdW5uZWNlc3NpdHksIHdoaWNoIGltcGxp
ZXMgZGVwcmVjYXRpb24gb2YgaW1wbGljaXQgZmlsdGVycw0KPj4+PiAyLiBBZnRlciBzb21lIHJl
bGVhc2VzIGluIDQueCB3ZSBjYW4gZHJvcCBkZXByZWNhdGVkIGZ1bmN0aW9uYWxpdHksIHNvIHdl
IGRyb3AgaXQgdG9nZXRoZXIgd2l0aA0KPj4+PiBpbXBsaWNpdCBmaWx0ZXJzLiBBbmQsIGluIHNh
bWUgcmVsZWFzZSA0Lnggd2UgcmV0dXJuIGl0IGJhY2sgKGFzIGl0J3MgY29tcGF0aWJsZSBjaGFu
Z2UgOikNCj4+Pj4gYnV0IHdpdGhvdXQgaW1wbGljaXQgZmlsdGVycyAoc28sIGlmIGZpbHRlci1u
b2RlLW5hbWUgbm90IHNwZWNpZmllZCwgd2UganVzdCBjcmVhdGUNCj4+Pj4gZXhwbGljaXQgZmls
dGVyIHdpdGggYXV0b2dlbmVyYXRlZCBub2RlLW5hbWUpDQo+Pj4+DQo+Pj4+IFNvLCBlZmZlY3Rp
dmVseSB3ZSBqdXN0IGRyb3AgImRlcHJlY2F0aW9uIG1hcmsiIHRvZ2V0aGVyIHdpdGggaW1wbGlj
aXQgZmlsdGVycywgd2hpY2ggaXMgbmljZQ0KPj4+PiBidXQgYWN0dWFsbHkgY29uZnVzaW5nLg0K
Pj4+Pg0KPj4+PiBJbnN0ZWFkLCB3ZSBtYXkgZG8NCj4+Pj4gMS4gSW4gNC4yIGRlcHJlY2F0ZQ0K
Pj4+PiAyLiBJbiA0LnggZHJvcCBvcHRpb25hbGl0eSB0b2dldGhlciB3aXRoIGltcGxpY2l0IGZp
bHRlcnMNCj4+Pj4gMy4gSW4gNC55ICh5ID4geCBvZiBjb3Vyc2UpIHJldHVybiBvcHRpb25hbGl0
eSBiYWNrDQo+Pj4+DQo+Pj4NCj4+PiBBaCwgSSBzZWUgd2hhdCB5b3UncmUgZGlnZ2luZyBhdCBo
ZXJlIG5vdy4uLg0KPj4+DQo+Pj4+IEl0J3MgYSBiaXQgc2FmZXIsIGJ1dCBmb3IgdXNlcnMgd2hv
IG1pc3MgcmVsZWFzZXMgWzQueCwgNC55KSBpdCdzIG5vIGRpZmZlcmVuY2UuLg0KPj4+Pg0KPj4+
PiBPciB3ZSBqdXN0IHdyaXRlIGluIHNwZWMsIHRoYXQgaW1wbGljaXQgZmlsdGVycyBhcmUgZGVw
cmVjYXRlZD8gQnV0IHdlIGhhdmUgbm90aGluZyBhYm91dCBpbXBsaWNpdA0KPj4+PiBmaWx0ZXJz
IGluIHNwZWMuIE1vcmUgb3Zlciwgd2UgZGlyZWN0bHkgd3JpdGUgdGhhdCB3ZSBoYXZlIGZpbHRl
ciwgYW5kIGlmIHBhcmFtZXRlciBpcyBvbWl0dGVkDQo+Pj4+IGl0J3Mgbm9kZS1uYW1lIGlzIGF1
dG9nZW5lcmF0ZWQuIFNvIGFjdHVhbGx5LCB0aGUgZmFjdCB0aGUgZmlsdGVyIGlzIGhpZGRlbiB3
aGVuIGZpbHRlci1ub2RlLW5hbWUgaXMNCj4+Pj4gdW5zcGVjaWZpZWQgaXMgX3VuZG9jdW1lbnRl
ZF8uDQo+Pj4+DQo+Pj4+IFNvLCBmaW5hbGx5LCBpdCBsb29rcyBsaWtlIG5vdGhpbmcgdG8gZGVw
cmVjYXRlZCBpbiBzcGVjaWZpY2F0aW9uLCB3ZSBjYW4ganVzdCBkcm9wIGltcGxpY2l0IGZpbHRl
cnMgOikNCj4+Pj4NCj4+Pj4gV2hhdCBkbyB5b3UgdGhpbms/DQo+Pj4+DQo+Pj4NCj4+PiBXaGF0
IGV4YWN0bHkgX0lTXyBhbiBpbXBsaWNpdCBmaWx0ZXI/IEhvdyBkb2VzIGl0IGRpZmZlciB0b2Rh
eSBmcm9tIGFuDQo+Pj4gZXhwbGljaXQgZmlsdGVyPyBJIGFzc3VtZWQgdGhlIG9ubHkgZGlmZmVy
ZW5jZSB3YXMgaWYgaXQgd2FzIG5hbWVkIG9yDQo+Pj4gbm90OyBidXQgSSB0aGluayBJIG11c3Qg
YmUgbWlzdGFrZW4gbm93IGlmIHlvdSdyZSBwcm9wb3NpbmcgbGVhdmluZyB0aGUNCj4+PiBpbnRl
cmZhY2UgYWxvbmUgZW50aXJlbHkuDQo+Pj4NCj4+PiBBcmUgdGhleSBpbnN0YW50aWF0ZWQgZGlm
ZmVyZW50bHk/DQo+Pj4NCj4+DQo+PiBBcyBJIHVuZGVyc3RhbmQsIHRoZSBvbmx5IGRpZmZlcmVu
Y2UgaXMgdGhlaXIgQmxvY2tEcml2ZXJTdGF0ZS5pbXBpY2l0IGZpZWxkLCBhbmQgc2V2ZXJhbCBw
bGFjZXMgaW4gY29kZQ0KPj4gd2hlcmUgd2Ugc2tpcCBpbXBsaWNpdCBmaWx0ZXIgd2hlbiB0cnlp
bmcgdG8gZmluZCBzb21ldGhpbmcgaW4gYSBjaGFpbiBzdGFydGluZyBmcm9tIGEgZGV2aWNlLg0K
Pj4NCj4gDQo+IE9oLCBvaCwgeWVzLiBJIHNlZS4NCj4gDQo+PiBIbW0sIE9LLCBsZXQncyBzZWU6
DQo+Pg0KPj4gMS4gdGhlIG9ubHkgaW1wbGljaXQgZmlsdGVycyBhcmUgY29tbWl0X3RvcCBhbmQg
bWlycm9yX3RvcCBpZiB1c2VyIGRvbid0IHNwZWNpZnkgZmlsdGVyLW5vZGUtbmFtZS4NCj4+DQo+
PiBXaGVyZSBpdCBtYWtlIHNlbnNlLCBpLmUuLCB3aGVyZSBpbXBsaWNpdCBmaWVsZCB1c2VkPw0K
Pj4NCj4gDQo+IGBnaXQgZ3JlcCAtRSAnKC0+fFwuKWltcGxpY2l0J2AgaXMgd2hhdCBJIHVzZWQg
dG8gZmluZCB1c2FnZXMuDQo+IA0KPj4gMi4gYmRydl9xdWVyeV9pbmZvLCBiZHJ2X3F1ZXJ5X2Jk
c19zdGF0cywgYmRydl9ibG9ja19kZXZpY2VfaW5mbyhvbmx5IHdoZW4gY2FsbGVkIGZyb20gYmRy
dl9xdWVyeV9pbmZvKSwgdGhleSdsbA0KPj4gcmVwb3J0IGZpbHRlciBhcyB0b3Agbm9kZSBpZiB3
ZSBkb24ndCBtYXJrIGl0IGltcGxpY2l0Lg0KPj4NCj4gDQo+IFNvIHRoYXQncyBhIGJpdCBvZiBh
IGNoYW5nZSwgYnV0IG9ubHkgdmlzdWFsbHkuIFRoZSAicmVhbGl0eSIgaXMgc3RpbGwNCj4gdGhl
IHNhbWUsIHdlIGp1c3QgcmVwb3J0IGl0IG1vcmUgImFjY3VyYXRlbHkuIiBsaWJ2aXJ0IE1JR0hU
IG5lZWQgYQ0KPiBoZWFkcyB1cCBoZXJlLiBJJ20gbG9vcGluZyBwa3JlbXBhIGJhY2sgaW4gZm9y
IGNvbW1lbnQuDQo+IA0KPiA8cGtyZW1wYT4NCj4gV291bGQgbGlidmlydCBiZSBuZWdhdGl2ZWx5
IGltcGFjdGVkIGJ5IHRoZSByZXZlbGF0aW9uIG9mIGZvcm1lcmx5DQo+IGludGVybmFsICgiaW1w
bGljaXQiKSBub2RlcyBjcmVhdGVkIGJ5IG1pcnJvciBhbmQgY29tbWl0IHZpYSBxdWVyeSBibG9j
aw0KPiBjb21tYW5kcz8gQXQgdGhlIG1vbWVudCwgUUVNVSBoaWRlcyB0aGVtIGZyb20geW91IGlm
IHlvdSBkbyBub3QgbmFtZSB0aGVtLg0KPiA8L3BrcmVtcGE+DQo+IA0KPj4gMy4gYmRydl9yZWZy
ZXNoX2ZpbGVuYW1lLCBiZHJ2X3Jlb3Blbl9wYXJzZV9iYWNraW5nLCBiZHJ2X2Ryb3BfaW50ZXJt
ZWRpYXRlOg0KPj4gICAgIEkgdGhpbmsgaXQncyBub3QgYSBwcm9ibGVtLCBqdXN0IGRyb3Agc3Bl
Y2lhbCBjYXNlIGZvciBpbXBsaWNpdCBmaXRsZXJzDQo+Pg0KPiANCj4gSSdtIG11Y2ggbGVzcyBj
ZXJ0YWluIGFib3V0IHdoYXQgdGhlIGltcGFjdCBvZiB0aGlzIHdvdWxkIGJlIGFuZCB3b3VsZA0K
PiBuZWVkIHRvIGF1ZGl0IGl0IChhbmQgZG9uJ3QgaGF2ZSB0aGUgdGltZSB0bywgcGVyc29uYWxs
eS4pDQo+IA0KPiBEbyB5b3UgaGF2ZSBhIFBPQyBvciBSRkMgcGF0Y2ggdGhhdCBkZW1vbnN0cmF0
ZXMgZHJvcHBpbmcgdGhlc2Ugc3BlY2lhbA0KPiBjYXNlcz8gSXQgbWlnaHQgYmUgbmljZSB0byBz
ZWUgYXMgcHJvb2YgdGhhdCBpdCdzIHNhZmUgdG8gZGVwcmVjYXRlLg0KPiANCj4+IFNvLCBzZWVt
cyB0aGUgb25seSByZWFsIGNoYW5nZSBpcyBxdWVyeS1ibG9jayBhbmQgcXVlcnktYmxvY2tzdGF0
cyBvdXRwdXQgd2hlbiBtaXJyb3Igb3IgY29tbWl0IGlzIHN0YXJ0ZWQNCj4+IHdpdGhvdXQgc3Bl
Y2lmeWluZyBmaWx0ZXItbm9kZS1uYW1lIChmaWx0ZXIgd291bGQgYmUgb24gdG9wKQ0KPj4NCj4+
IFNvLCBob3cgc2hvdWxkIHdlIGRlcHJlY2F0ZSB0aGlzLCBvciBjYW4gd2UganVzdCBjaGFuZ2Ug
aXQ/DQo+Pg0KPiANCj4gSSdtIG5vdCBzdXJlIGlmIGl0J3Mgd29ydGggaXQgeWV0LCB3aGF0IGRv
ZXMgZHJvcHBpbmcgdGhlIGltcGxpY2l0IGZpZWxkDQo+IGJ1eSB1cz8gQ29uY2VwdHVhbGx5IEkg
dW5kZXJzdGFuZCB0aGF0IGl0J3Mgc2ltcGxlciB3aXRob3V0IHRoZSBub3Rpb24NCj4gb2YgaW1w
bGljaXQgZmllbGRzLCBidXQgSSBpbWFnaW5lIHRoZXJlJ3Mgc29tZSBjbGVhbnVwIGluIHBhcnRp
Y3VsYXINCj4gdGhhdCBtb3RpdmF0ZWQgdGhpcy4NCg0KUmV2aWV3aW5nIE1heCdzICJibG9jazog
RGVhbCB3aXRoIGZpbHRlcnMiIHNlcmllcyBtb3RpdmF0ZWQgbWUuDQoNCj4gDQo+IEknZCBzYXkg
dG8ganVzdCBjaGFuZ2UgdGhlIGJlaGF2aW9yLCB3ZSBzaG91bGQ6DQo+IA0KPiAtIEdpdmUgYSBz
dGFuZGFyZCB0aHJlZS1yZWxlYXNlIHdhcm5pbmcgdGhhdCB0aGUgYmVoYXZpb3Igd2lsbCBjaGFu
Z2UgaW4NCj4gYW4gaW5jb21wYXRpYmxlIHdheQ0KPiAtIERlbW9uc3RyYXRlIHdpdGggYW4gUkZD
IHBhdGNoIHRoYXQgc3BlY2lhbCBjYXNlcyBhcm91bmQgLT5pbXBsaWNpdCBpbg0KPiBibG9jay5j
IGNhbiBiZSByZW1vdmVkIGFuZCBkbyBub3QgbWFrZSB0aGUgY29kZSBtb3JlIGNvbXBsZXgsDQo+
IC0gR2V0IGJsZXNzaW5ncyBmcm9tIFBldGVyIEtyZW1wYS4NCj4gDQo+IEFzIGFsd2F5czogTGli
dmlydCBpcyBub3QgdGhlIGVuZC1hbGwgYmUtYWxsIG9mIFFFTVUgbWFuYWdlbWVudCwgYnV0IGlm
DQo+IGxpYnZpcnQgaXMgY2FwYWJsZSBvZiB3b3JraW5nIGFyb3VuZCBkZXNpZ24gY2hhbmdlcyB0
aGVuIEkgYmVsaWV2ZSBhbnkNCj4gcHJvamVjdCBvdXQgdGhlcmUgdG9kYXkgYWxzbyBjb3VsZCwg
c28gaXQncyBhIGdvb2QgbGl0bXVzIHRlc3QuDQo+IA0KPiAtLWpzDQo+IA0KDQoNCi0tIA0KQmVz
dCByZWdhcmRzLA0KVmxhZGltaXINCg==

