Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F20D1CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 10:12:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B969520578
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 10:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="e84oQ2WO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B969520578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNwZk-0005Xs-MW
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 06:12:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60636)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iNwMs-0005qx-VY
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 05:58:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iNwMp-0004UM-50
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 05:58:48 -0400
Received: from mail-vi1eur04on0702.outbound.protection.outlook.com
 ([2a01:111:f400:fe0e::702]:61038
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iNwLH-0003T3-Q7; Fri, 25 Oct 2019 05:58:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n3tpMa/Tv+dSlSQbTUZrv+rpgr/bSOiO9P5bN9BFv2vzUZ9Prl1WF8URRhbqSYpBZ64mv5qoCcGzNjNuzKc+GYSO0+JL253JngRH8Mn/RHwg3TGU7GaXncedsMzmeSAQGCBxa8gE8S0/Symg+KNXKPYsnb8WnCVZYMK1LOwE5VX0tL8/kqhBHiLrAU9AZVq6ZJVbpxhAtMcmo2EBXlVvC5KNh0PGKN+GCldsLQPC/NnQCZsT0LbW4+65Nnj9yiSUhYR/iHoV10CQvXBBzDaDjDPrugj7HpzEwkXizgeYEMW8iyhUdl4T9Sj3fEv+NstTkUB/PYCaMDHYuh0dQ7DiKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gBoyHaa40VRyucZdhDnFS/muFdJeGX4fUEyW4CP4aSY=;
 b=CU7fWBolpmeFA9xw4rxFXA22cYfPTQRZJk1wY490hT/dxbZq0kZQKzUMoGRiQ/ElNzsjpoMoRba4AnYt74U5GK5sT3KH+ZR0GCbHGifOmgiuz3Rb/vVzY9ZRMXTLyHPskyJAMFRruh/sDv+G0hGtULPlfHsnQsZ833gLdyoMoCceXXc8t+faHuaUB1m4bGuHc+56CI3BNU5Aukd3CEYjEUOqq5ZV0yB80kXXMcNwMFb9t3nv/hYeQMZVglNy9ZRFgqgWXLxo44EPuQLb3GVps6auFuK32yR9OKMZO/TWYfExfghZLqp/a1aKvKSIUafhRLfRZD4dRbrMoWXvre+UMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gBoyHaa40VRyucZdhDnFS/muFdJeGX4fUEyW4CP4aSY=;
 b=e84oQ2WOR5CD4ZpRtfUuDl7/jDAAdS02qJZJuXKb4FNDqmAXYkyY/lQ17cfvDJU5BSXIMyUMtmYV3h6V09K2zK/FigZMzuXNtGHZykdbq46RLAiwSWUe0yYgUgno3DK2rRo5QVxdmUqmwhnu9grKm8tOixWCEz5zhqK7FkOXWdQ=
Received: from AM0PR08MB4435.eurprd08.prod.outlook.com (20.179.35.83) by
 AM0PR08MB4402.eurprd08.prod.outlook.com (20.179.36.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Fri, 25 Oct 2019 09:57:08 +0000
Received: from AM0PR08MB4435.eurprd08.prod.outlook.com
 ([fe80::4461:dd32:b358:110c]) by AM0PR08MB4435.eurprd08.prod.outlook.com
 ([fe80::4461:dd32:b358:110c%7]) with mapi id 15.20.2367.029; Fri, 25 Oct 2019
 09:57:08 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: [bugfix ping] Re: [PATCH v2 0/2] fix qcow2_can_store_new_dirty_bitmap
Thread-Topic: [bugfix ping] Re: [PATCH v2 0/2] fix
 qcow2_can_store_new_dirty_bitmap
Thread-Index: AQHVgoW5R0JiiFjWEkC5eKx2r1dN66drMBIA
Date: Fri, 25 Oct 2019 09:57:08 +0000
Message-ID: <e89b8844-26c7-0768-f6dd-6faa814551e2@virtuozzo.com>
References: <20191014115126.15360-1-vsementsov@virtuozzo.com>
In-Reply-To: <20191014115126.15360-1-vsementsov@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P18901CA0010.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:3:8b::20) To AM0PR08MB4435.eurprd08.prod.outlook.com
 (2603:10a6:208:144::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191025125706752
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 14008b0d-e9ec-44ac-749d-08d75931b2c8
x-ms-traffictypediagnostic: AM0PR08MB4402:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR08MB4402189279C573415314D4CAC1650@AM0PR08MB4402.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:628;
x-forefront-prvs: 02015246A9
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(396003)(136003)(346002)(376002)(39840400004)(53754006)(189003)(199004)(7736002)(31696002)(81156014)(6916009)(6486002)(66476007)(478600001)(5640700003)(6512007)(2906002)(6306002)(966005)(305945005)(86362001)(52116002)(2501003)(76176011)(54906003)(4326008)(6436002)(99286004)(14454004)(3846002)(316002)(5660300002)(66066001)(476003)(8676002)(486006)(256004)(36756003)(11346002)(81166006)(386003)(6506007)(2616005)(6116002)(66556008)(66446008)(64756008)(25786009)(8936002)(2351001)(102836004)(107886003)(31686004)(446003)(71200400001)(71190400001)(26005)(186003)(66946007)(14143004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB4402;
 H:AM0PR08MB4435.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VHXGYk/jGctqw/69d7vrivHtHdZ7EdBAnSJLpAtNjb/khW9twUc+3Cid0IrBggP34MPyyJ5PutxFJacujw80jh5C4BcpB5UKF2WB+wW2RuJMhXxYPVWCYdSs7y9da7KHcGU5pVfBAy4nL3apAobb6wEubffZIaVMxVngQkYR8v4iSh60N3pOQQ/5N/b6lMGHvPLem2tPQd1MRx4SSoX8QjrDVP9FQo4Q4o3Yuras+XUtUQY/19OUm73saac4W89YaOyAe5ZtEX3AWQgQcKIMAp9fh/cDM9E7+A/3isvt863y7pxdNQEPJzY5NjNccmZwlLadHpg4PtmcvVw+jQppiTbnVdBDHrwy32e7xL+mF63QKy/tkEwmZxATtTNJL11EeCZQSiViJLR73D/TCxqZ5pBjigzgJCkeQK/4nK+aQhP2T/sShRZotepumgCoqqSHnDRCscpZm8evrUZj4XUg0cb5PgBDwI0RU1Z01FxQeGQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <666C5BD7DD843744A83E71113DFA6364@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14008b0d-e9ec-44ac-749d-08d75931b2c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2019 09:57:08.5684 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jQfWq1gGQMM+OeB2jv65TJHnZAgziR7KRGF1AZngc1oDhYXqkR4qH6hQCNPFwFEL2zidg0dWYFdlKO7X/P3ukwjuo32W923YiufwU4xBTig=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4402
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe0e::702
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGkhDQoNCkRvbid0IHdlIGZvcmdldCBpdD8NCg0KSGVyZSBpcyBhIGJ1Zy1maXgsIEkgdGhpbmsg
d2Ugd2FudCBpdCBmb3IgNC4yLg0KDQoxNC4xMC4yMDE5IDE0OjUxLCBWbGFkaW1pciBTZW1lbnRz
b3YtT2dpZXZza2l5IHdyb3RlOg0KPiBIaSBhbGwhDQo+IA0KPiBIZXJlIGlzIGEgZml4IGZvciBw
ZXJzaXN0ZW50IGJpdG1hcHMgbWFuYWdpbmc6IHdlIG11c3QgY2hlY2sgZXhpc3RlbnQNCj4gYnV0
IG5vdCB5ZXQgc3RvcmVkIGJpdG1hcHMgZm9yIHFjb3cyLXJlbGF0ZWQgY29uc3RyYWludHMsIGxp
a2UgbWF4aW11bQ0KPiBudW1iZXIgb2YgYml0bWFwcyBpbiBxY293MiBpbWFnZS4NCj4gDQo+IHYy
Og0KPiANCj4gMDE6IGNoYW5nZSBhc3NlcnRpb24gdG8gZXJyb3ItcmV0dXJuIGF0IGZ1bmN0aW9u
IHN0YXJ0DQo+ICAgICAgQmUgZnJlZSB0byBhZGQNCj4gICAgICBSZXBvcnRlZC1ieTogYWlodWEg
bGlhbmcgPGFsaWFuZ0ByZWRoYXQuY29tPg0KPiAgICAgIEZpeGVzOiBodHRwczovL2J1Z3ppbGxh
LnJlZGhhdC5jb20vc2hvd19idWcuY2dpP2lkPTE3MTI2MzYNCj4gICAgICBpZiBpdCdzIGFwcHJv
cHJpYXRlDQo+IDAyOiBuZXcgdGVzdA0KPiAgICAgIE9oaCwgaXQgdGFrZXMgYWJvdXQgNCBtaW51
dGVzLiBCZSBmcmVlIHRvIGRyb3AgaXQsIGFzIEkgZG91YnQgdGhhdA0KPiAgICAgIGl0IHdvcnRo
IHRvIGhhdmUuIFRoZSBjYXNlIGlzIHNpbXBsZSwgd2UgbWF5IGxpdmUgd2l0aG91dCBhDQo+ICAg
ICAgdGVzdC4NCj4gDQo+IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgKDIpOg0KPiAgICBx
Y293Mi1iaXRtYXBzOiBmaXggcWNvdzJfY2FuX3N0b3JlX25ld19kaXJ0eV9iaXRtYXANCj4gICAg
aW90ZXN0czogYWRkIDI2OSB0byBjaGVjayBtYXhpbXVtIG9mIGJpdG1hcHMgaW4gcWNvdzINCj4g
DQo+ICAgYmxvY2svcWNvdzItYml0bWFwLmMgICAgICAgfCA0MSArKysrKysrKysrKysrKystLS0t
LS0tLS0tLS0tLS0tLS0NCj4gICB0ZXN0cy9xZW11LWlvdGVzdHMvMjY5ICAgICB8IDQ3ICsrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICAgdGVzdHMvcWVtdS1pb3Rlc3Rz
LzI2OS5vdXQgfCAgMyArKysNCj4gICB0ZXN0cy9xZW11LWlvdGVzdHMvZ3JvdXAgICB8ICAxICsN
Cj4gICA0IGZpbGVzIGNoYW5nZWQsIDY5IGluc2VydGlvbnMoKyksIDIzIGRlbGV0aW9ucygtKQ0K
PiAgIGNyZWF0ZSBtb2RlIDEwMDc1NSB0ZXN0cy9xZW11LWlvdGVzdHMvMjY5DQo+ICAgY3JlYXRl
IG1vZGUgMTAwNjQ0IHRlc3RzL3FlbXUtaW90ZXN0cy8yNjkub3V0DQo+IA0KDQoNCi0tIA0KQmVz
dCByZWdhcmRzLA0KVmxhZGltaXINCg==

