Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 546A8C3A5A4
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 08:17:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EB2E22CEC
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 08:17:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="oKvi7sKH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EB2E22CEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i14lK-0008HT-H1
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 04:17:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41865)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <anton.nefedov@virtuozzo.com>) id 1i14jw-0007Er-Vm
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 04:16:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <anton.nefedov@virtuozzo.com>) id 1i14jv-0003TR-9A
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 04:16:08 -0400
Received: from mail-eopbgr70082.outbound.protection.outlook.com
 ([40.107.7.82]:64206 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
 id 1i14ju-0003T7-K7; Fri, 23 Aug 2019 04:16:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bly8b77SHoL2OhKgobJciasBwro/ME9T3d1ZzKfl7lvr4tnS8uix2H8av2pVg4f8KY/mVUEi25FX2njKKpAUZ7MNdm7b4prfRegg2H6rMYyPW5sXEy4wFHHJvZCKwhQvyaa3xzktLPvj8MWSpeRQGI4Y8NGcQGOP/DkWB2Tm+R25m+mEirD8l+Kap2jG71Pstn/ypBbxLUq84Q1pSg2E8cIMcmFXlyMMpjE574DVe6N2jXKR6EFF34FHR9fENj8QQ1FZTCEAF01CjHVuGea3wkzGGoYFcOUzZSN2iwFqyNJKYNNBr7snUj0RahNbqOLasLwgFQ9SG7An9ukXe7Qrng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tu5RuZq6v6TnkASmtFLIElzkZ5b98YXGJIz9bYxaMqM=;
 b=AbUbx+GlMyl0UKzr3DXnun202fyR/xWEL7BRoxPOhJKehgK7GtlADpeTZ2ixBMEq7HZqzMe4Dkqn9YJ6fM9MAWHVtn+d4jt96H9m0UnJaLY/E8mEDXPaU2TCpdEJRMyEYXuEohQ6JX1LuvB1EGAMY1rfms0EqlUTTxJTH2tgOqYmY6YdFCdNaV6wN0eGZQ7XXQ3scN0aqJ+sbeCUwI4PZBB9wIQQACpDccdmbUx2bkYAMiBR6eK3vQ5dH3Fa+1d6tJ9tbnFy5++O1bee53TqW+VNyGhyez0Zj3+KtiL+qp6UawpzlmQpPpI9OUjTkRnT+yddmD+k/+P0mh4ix0/p+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tu5RuZq6v6TnkASmtFLIElzkZ5b98YXGJIz9bYxaMqM=;
 b=oKvi7sKHVQC2da2VJm1XwZ6WzDt2qtcaU5fpmr2mKvk7hvHBHROXUp+8QldyHZeML2p+XP5DufYx9EdBYMgMGut7W74Y3Hjcll2dAHFMlQ/rHRwzUPvtViwWbTc0qENuwsDqtFcjAzz+u8HfY+BBox0cLoriiVfFfexEezxDpCA=
Received: from AM6PR08MB5208.eurprd08.prod.outlook.com (10.255.122.155) by
 AM6PR08MB4120.eurprd08.prod.outlook.com (20.179.0.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.19; Fri, 23 Aug 2019 08:16:02 +0000
Received: from AM6PR08MB5208.eurprd08.prod.outlook.com
 ([fe80::5820:8ce:9eb2:cc42]) by AM6PR08MB5208.eurprd08.prod.outlook.com
 ([fe80::5820:8ce:9eb2:cc42%3]) with mapi id 15.20.2178.020; Fri, 23 Aug 2019
 08:16:02 +0000
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH 0/2] block/file-posix: Fix xfs_write_zeroes()
Thread-Index: AQHVWQbg+no0I+BX5kK4M11pu7opIacIY/AA
Date: Fri, 23 Aug 2019 08:16:02 +0000
Message-ID: <7dec57bd-68cf-09a5-1850-d324c5baae65@virtuozzo.com>
References: <20190822162618.27670-1-mreitz@redhat.com>
In-Reply-To: <20190822162618.27670-1-mreitz@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0402CA0006.eurprd04.prod.outlook.com
 (2603:10a6:3:d0::16) To AM6PR08MB5208.eurprd08.prod.outlook.com
 (2603:10a6:20b:eb::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anton.nefedov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 23505445-5611-45bd-67f8-08d727a22334
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:AM6PR08MB4120; 
x-ms-traffictypediagnostic: AM6PR08MB4120:
x-microsoft-antispam-prvs: <AM6PR08MB4120FF8F817675F105A1FD4DF8A40@AM6PR08MB4120.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 0138CD935C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009001)(6009001)(428001)(377454003)(479174003)(51704005)(24454002)(199002)(189002)(20776003)(69226001)(63696002)(74876001)(74706001)(36756003)(77096001)(76786001)(76796001)(81542001)(54356001)(31686003)(93136001)(92566001)(46102001)(64706001)(81342001)(92726001)(77982001)(59766001)(56816005)(33646001)(80022001)(66066001)(76482001)(90146001)(65816001)(87936001)(56776001)(54316002)(74366001)(44376005)(87266001)(2656002)(4396001)(47976001)(50986001)(95666003)(49866001)(47736001)(51856001)(85306002)(79102001)(85852003)(83072002)(21056001)(97336001)(94946001)(93516002)(95416001)(94316002)(86362001)(97186001)(80976001)(31696002)(81686001)(83322001)(19580405001)(81816001)(31966008)(74662001)(19580395003)(53806001)(74502001)(47446002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR08MB4120;
 H:AM6PR08MB5208.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4B8qssO7WULffEwnvZ6n09SxgFx2XNV5KOUbnBN9pvxgwHAwUHlXKvWWyzztu6kzSQVXG0Bs5GLqQje3RTUr/Sda2LC6GqOPu3p+AvxDK0JJDO3LjRqgFPALk9fo2vJU1rdsmyL/MrS7BRQo0eQYvwj8aipgjFa8MC4PXLq5nEXNc4nvQu5jy+5oJhu9JXfSJeiSewnMSfTe9ZmHVZoF/LVNsO6bpkRo7zVZ5/URoFXChQmOMfDgWvMBBgol75CEZkfuuwWTiMX/S7+JIu2WGNfQt2zn+3aH5JpPFsOCb05xxbYXJV8fEutQr/bFsVhOuxT9eUITZdGNVVLvJwZIdIQMDet8oibka/aZ0F4JJfoE76fGsh6Usea/+pJc9KAYJkHsaKXKF04O5d692eQ88yyCstebQaKIAIaz7rBaY6E=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E814921EB6693849A9E05D790223E139@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23505445-5611-45bd-67f8-08d727a22334
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2019 08:16:02.6945 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XFcwo5AZQ0UUFWT3Vc2iwzZpffNwpP9my0nrOD6aA7eBsJ8mnxNuAueGf+E+mXkdtmaovN1zhx4QQcxKp7uOQY8U7Zd+0yLskOxm3XDuH1A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4120
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.82
Subject: Re: [Qemu-devel] [PATCH 0/2] block/file-posix: Fix
 xfs_write_zeroes()
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?utf-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gMjIvOC8yMDE5IDc6MjYgUE0sIE1heCBSZWl0eiB3cm90ZToNCj4gTHVrw6DFoSByYW4gb3Zl
ciBhIG5hc3R5IHJlZ3Jlc3Npb24gaW4gb3VyIHhmc193cml0ZV96ZXJvZXMoKSBmdW5jdGlvbg0K
PiAoc29ycnksIG15IGZhdWx0KSBtYWRlIGFwcGFyZW50IGJ5IGEgcmVjZW50IHBhdGNoIGZyb20g
QW50b24gdGhhdCBtYWtlcw0KPiBxY293MiBpbWFnZXMgaGVhdmlseSBleGVyY2lzZSB0aGUgb2Zm
ZW5kaW5nIGNvZGUgcGF0aC4NCj4gDQo+IFRoaXMgc2VyaWVzIGZpeGVzIHRoZSBidWcgYW5kIGFk
ZHMgYSB0ZXN0IHRvIHByZXZlbnQgaXQgZnJvbQ0KPiByZW9jY3VycmluZy4NCj4gDQo+IA0KPiBN
YXggUmVpdHogKDIpOg0KPiAgICBibG9jay9maWxlLXBvc2l4OiBGaXggeGZzX3dyaXRlX3plcm9l
cygpDQo+ICAgIGlvdGVzdHM6IFRlc3QgcmV2ZXJzZSBzdWItY2x1c3RlciBxY293MiB3cml0ZXMN
Cj4gDQo+ICAgYmxvY2svZmlsZS1wb3NpeC5jICAgICAgICAgfCAxNiArKysrKystLS0NCj4gICB0
ZXN0cy9xZW11LWlvdGVzdHMvMjY1ICAgICB8IDY3ICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrDQo+ICAgdGVzdHMvcWVtdS1pb3Rlc3RzLzI2NS5vdXQgfCAgNiArKysrDQo+
ICAgdGVzdHMvcWVtdS1pb3Rlc3RzL2dyb3VwICAgfCAgMSArDQo+ICAgNCBmaWxlcyBjaGFuZ2Vk
LCA4NSBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPiAgIGNyZWF0ZSBtb2RlIDEwMDc1
NSB0ZXN0cy9xZW11LWlvdGVzdHMvMjY1DQo+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RzL3Fl
bXUtaW90ZXN0cy8yNjUub3V0DQo+IA0KDQpOaWNlISB0aGFua3MgTWF4DQoNClJldmlld2VkLWJ5
OiBBbnRvbiBOZWZlZG92IDxhbnRvbi5uZWZlZG92QHZpcnR1b3p6by5jb20+DQo=

