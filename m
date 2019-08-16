Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A54C3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 10:48:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9960A206C2
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 10:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Z2ZW6onP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9960A206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyZmw-0006DA-FD
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 06:48:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42769)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hyZmB-0005j8-VZ
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 06:48:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hyZmA-0003CK-Dh
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 06:48:07 -0400
Received: from mail-eopbgr140093.outbound.protection.outlook.com
 ([40.107.14.93]:15620 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hyZm5-00034i-T9; Fri, 16 Aug 2019 06:48:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YtJpLY5K2+uxqiSzIm394Q09RGYzEf4d60Q+c9c7HZOlre9QK0uYgS8cqjiH35gnr2/+JJgTqnqtuZxXEYB8HKePPysHnrT4Rc/MlZVL1LH+FviU+fWgYSTNKzNds2SOrPokHQb1DOZKytUaLSWvUmTa27iCma7/TVJZ1t7E+KjdFAaBlgsiJ1gA4QD+vt06SjIIY/TJL8k9OhofhH7nQYK8/3wcbp90ggX55i/N5J+lCZM5Uf2e2I6vHdWgdzIjiA64P6wNXQ/38KKcIchUxj8eNxpOmmI5959D8PRVVGuEJ58/zRcxvkt5rzHqqWz/x/bGNaDGJxMOUnEXTxcJQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Em+ClF4vwtdMaQVYu7hSZ+L/MQaB5NCAEujCpkJzcq0=;
 b=jrdsXWlWEnLSNSVfS2UY2J/z6KaCP15eQN2n3P3JRgNtnLjOq1N84G/vVbhezfZmH2uuVxuz0EP/TwDN9aSw8SwA26k3gdIqHcbjOns4DqcyrhULLhPwo7oXRVYVKUPZs+RMrTeNgDPa+GH/yffvFFeUWc0kTcDmwNlKCYnOp4DQ8wQSK8b9zsQFKqLeW4xpkSiOhfdCoOr6cjgOGNw6kHxSapWT48IQlN5IgvW62JeIRywkAStBQDAY46JmWPqAChLhvSQ8AgxFgb98WIbXBOJYex39RDeRvOS4Z4xrTYDs5keVjFtga7wKO9FoqY9gUbxSmZJDTcRje026kMEc+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Em+ClF4vwtdMaQVYu7hSZ+L/MQaB5NCAEujCpkJzcq0=;
 b=Z2ZW6onPvGl1LRJ3VfOEKxv8/IWWYEXucdexuG92UCCZFLEnWXqIQEB61YZYGsyIZIiC4Ajj5LFmBw/VpXFlXeOCM6EyFX7l9xVPLXRVzTc1T9NBWcnwmCIuJAwMzLB9TMAtd2sE9OXOJhDjBHZsLWGDT7O+wOY9XdMnDBn0Xpg=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB3979.eurprd08.prod.outlook.com (20.179.9.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.20; Fri, 16 Aug 2019 10:47:58 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2157.022; Fri, 16 Aug 2019
 10:47:58 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Thread-Topic: [PATCH] nbd: Advertise multi-conn for shared read-only
 connections
Thread-Index: AQHVU5pRbfX2Dmnn90+3JIt/UilW+Kb9xGyA///UfwA=
Date: Fri, 16 Aug 2019 10:47:58 +0000
Message-ID: <22c4c265-91fc-3639-4a4e-2fffe426ce68@virtuozzo.com>
References: <20190815185024.7010-1-eblake@redhat.com>
 <104559cd-a1dc-2b2c-8992-689cbdd0f827@virtuozzo.com>
In-Reply-To: <104559cd-a1dc-2b2c-8992-689cbdd0f827@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR09CA0068.eurprd09.prod.outlook.com
 (2603:10a6:7:3d::12) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190816134756335
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 64c0b0a9-99fb-46e3-80e2-08d7223733a6
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:DB8PR08MB3979; 
x-ms-traffictypediagnostic: DB8PR08MB3979:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DB8PR08MB39799662F047FF354ECE772AC1AF0@DB8PR08MB3979.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0131D22242
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(376002)(136003)(39850400004)(366004)(396003)(199004)(189003)(7736002)(6246003)(305945005)(6512007)(5660300002)(6306002)(66066001)(36756003)(229853002)(31686004)(31696002)(2501003)(8936002)(6486002)(6436002)(66446008)(76176011)(66556008)(64756008)(66476007)(66946007)(8676002)(486006)(6506007)(110136005)(102836004)(14454004)(71190400001)(966005)(256004)(71200400001)(81166006)(2616005)(54906003)(11346002)(446003)(186003)(14444005)(476003)(386003)(52116002)(4326008)(86362001)(99286004)(6116002)(25786009)(53936002)(478600001)(26005)(2906002)(316002)(3846002)(81156014);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB3979;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VciYdTDKcqZO+ohZ2BjWQ1BwE2x3XR4k7oyIsXd6WyTAyMut2LEJK1+sgSNDUKJjVFGCEiy9ov+ewsXnVbi3UauMprOkqMx6L9ln14Tkwnlcaf1QAU+eyzoDzZ04k++wviLLrmsMuPR/n4b6jwNwMMRpkaP5XGcRq3Q8yFRg1GKEJoZPHqIwTj7lG8yQ4X+JYQIPhQK/ncZErjMzhnTnmYDSjxn7g6OrrJhazbPJw/cfkXC5IBL3eA0AD/o1+Fj8aGif754mmvNMy1fSkmSHOXNXPPrCJPwGsU9NN0m5iU67cJYZ8TjI+e2Lc8zFS6qO+5Dz4KyEHHoCaZVrtfg266e3Kf4XZD6PvV/OVuTEUU2VTWxzld9pKby2328W9KPfcWSgDyHXcqfhMZciM6569YG49FB+5o2FA6Ph2de2Bjk=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <EAE7D571CBAE174488489BF32A252E82@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64c0b0a9-99fb-46e3-80e2-08d7223733a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2019 10:47:58.3201 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q+JpWJlTC14KfhTFrdXYHCt56YrzqDiVqIqyMX637TalVVmioPwlAjkdz+z8PJQSetJVDvR5Oa/UKikuZAw9DD0iKLnNjtBptzhG/a9Dp50=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB3979
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.14.93
Subject: Re: [Qemu-devel] [PATCH] nbd: Advertise multi-conn for shared
 read-only connections
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
Cc: Kevin Wolf <kwolf@redhat.com>, "rjones@redhat.com" <rjones@redhat.com>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTYuMDguMjAxOSAxMzoyMywgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4g
MTUuMDguMjAxOSAyMTo1MCwgRXJpYyBCbGFrZSB3cm90ZToNCj4+IFRoZSBOQkQgc3BlY2lmaWNh
dGlvbiBkZWZpbmVzIE5CRF9GTEFHX0NBTl9NVUxUSV9DT05OLCB3aGljaCBjYW4gYmUNCj4+IGFk
dmVydGlzZWQgd2hlbiB0aGUgc2VydmVyIHByb21pc2VzIGNhY2hlIGNvbnNpc3RlbmN5IGJldHdl
ZW4NCj4+IHNpbXVsdGFuZW91cyBjbGllbnRzIChiYXNpY2FsbHksIHJ1bGVzIHRoYXQgZGV0ZXJt
aW5lIHdoYXQgRlVBIGFuZA0KPj4gZmx1c2ggZnJvbSBvbmUgY2xpZW50IGFyZSBhYmxlIHRvIGd1
YXJhbnRlZSBmb3IgcmVhZHMgZnJvbSBhbm90aGVyDQo+PiBjbGllbnQpLsKgIFdoZW4gd2UgZG9u
J3QgcGVybWl0IHNpbXVsdGFuZW91cyBjbGllbnRzIChzdWNoIGFzIHFlbXUtbmJkDQo+PiB3aXRo
b3V0IC1lKSwgdGhlIGJpdCBtYWtlcyBubyBzZW5zZTsgYW5kIGZvciB3cml0YWJsZSBpbWFnZXMs
IHdlDQo+PiBwcm9iYWJseSBoYXZlIGEgbG90IG1vcmUgd29yayBiZWZvcmUgd2UgY2FuIGRlY2xh
cmUgdGhhdCBhY3Rpb25zIGZyb20NCj4+IG9uZSBjbGllbnQgYXJlIGNhY2hlLWNvbnNpc3RlbnQg
d2l0aCBhY3Rpb25zIGZyb20gYW5vdGhlci7CoCBCdXQgZm9yDQo+PiByZWFkLW9ubHkgaW1hZ2Vz
LCB3aGVyZSBmbHVzaCBpc24ndCBjaGFuZ2luZyBhbnkgZGF0YSwgd2UgbWlnaHQgYXMNCj4+IHdl
bGwgYWR2ZXJ0aXNlIG11bHRpLWNvbm4gc3VwcG9ydC7CoCBXaGF0J3MgbW9yZSwgYWR2ZXJ0aXNl
bWVudCBvZiB0aGUNCj4+IGJpdCBtYWtlcyBpdCBlYXNpZXIgZm9yIGNsaWVudHMgdG8gZGV0ZXJt
aW5lIGlmICdxZW11LW5iZCAtZScgd2FzIGluDQo+PiB1c2UsIHdoZXJlIGEgc2Vjb25kIGNvbm5l
Y3Rpb24gd2lsbCBzdWNjZWVkIHJhdGhlciB0aGFuIGhhbmcgdW50aWwgdGhlDQo+PiBmaXJzdCBj
bGllbnQgZ29lcyBhd2F5Lg0KPj4NCj4+IFRoaXMgcGF0Y2ggYWZmZWN0cyBxZW11IGFzIHNlcnZl
ciBpbiBhZHZlcnRpc2luZyB0aGUgYml0LsKgIFdlIG1heSB3YW50DQo+PiB0byBjb25zaWRlciBw
YXRjaGVzIHRvIHFlbXUgYXMgY2xpZW50IHRvIGF0dGVtcHQgcGFyYWxsZWwgY29ubmVjdGlvbnMN
Cj4+IGZvciBoaWdoZXIgdGhyb3VnaHB1dCBieSBzcHJlYWRpbmcgdGhlIGxvYWQgb3ZlciB0aG9z
ZSBjb25uZWN0aW9ucw0KPj4gd2hlbiBhIHNlcnZlciBhZHZlcnRpc2VzIG11bHRpLWNvbm4sIGJ1
dCBmb3Igbm93IHN0aWNraW5nIHRvIG9uZQ0KPj4gY29ubmVjdGlvbiBwZXIgbmJkOi8vIEJEUyBp
cyBva2F5Lg0KPj4NCj4+IFNlZSBhbHNvOiBodHRwczovL2J1Z3ppbGxhLnJlZGhhdC5jb20vMTcw
ODMwMA0KPj4gU2lnbmVkLW9mZi1ieTogRXJpYyBCbGFrZSA8ZWJsYWtlQHJlZGhhdC5jb20+DQo+
PiAtLS0NCj4+IMKgIGRvY3MvaW50ZXJvcC9uYmQudHh0IHwgMSArDQo+PiDCoCBpbmNsdWRlL2Js
b2NrL25iZC5owqAgfCAyICstDQo+PiDCoCBibG9ja2Rldi1uYmQuY8KgwqDCoMKgwqDCoCB8IDIg
Ky0NCj4+IMKgIG5iZC9zZXJ2ZXIuY8KgwqDCoMKgwqDCoMKgwqAgfCA0ICsrKy0NCj4+IMKgIHFl
bXUtbmJkLmPCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDIgKy0NCj4+IMKgIDUgZmlsZXMgY2hhbmdl
ZCwgNyBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9k
b2NzL2ludGVyb3AvbmJkLnR4dCBiL2RvY3MvaW50ZXJvcC9uYmQudHh0DQo+PiBpbmRleCBmYzY0
NDczZTAyYjIuLjZkZmVjN2Y0NzY0NyAxMDA2NDQNCj4+IC0tLSBhL2RvY3MvaW50ZXJvcC9uYmQu
dHh0DQo+PiArKysgYi9kb2NzL2ludGVyb3AvbmJkLnR4dA0KPj4gQEAgLTUzLDMgKzUzLDQgQEAg
dGhlIG9wZXJhdGlvbiBvZiB0aGF0IGZlYXR1cmUuDQo+PiDCoCAqIDIuMTI6IE5CRF9DTURfQkxP
Q0tfU1RBVFVTIGZvciAiYmFzZTphbGxvY2F0aW9uIg0KPj4gwqAgKiAzLjA6IE5CRF9PUFRfU1RB
UlRUTFMgd2l0aCBUTFMgUHJlLVNoYXJlZCBLZXlzIChQU0spLA0KPj4gwqAgTkJEX0NNRF9CTE9D
S19TVEFUVVMgZm9yICJxZW11OmRpcnR5LWJpdG1hcDoiLCBOQkRfQ01EX0NBQ0hFDQo+PiArKiA0
LjI6IE5CRF9GTEFHX0NBTl9NVUxUSV9DT05OIGZvciBzaGFyYWJsZSByZWFkLW9ubHkgZXhwb3J0
cw0KPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvYmxvY2svbmJkLmggYi9pbmNsdWRlL2Jsb2NrL25i
ZC5oDQo+PiBpbmRleCA3YjM2ZDY3MmYwNDYuLjk5MWZkNTJhNTEzNCAxMDA2NDQNCj4+IC0tLSBh
L2luY2x1ZGUvYmxvY2svbmJkLmgNCj4+ICsrKyBiL2luY2x1ZGUvYmxvY2svbmJkLmgNCj4+IEBA
IC0zMjYsNyArMzI2LDcgQEAgdHlwZWRlZiBzdHJ1Y3QgTkJEQ2xpZW50IE5CRENsaWVudDsNCj4+
DQo+PiDCoCBOQkRFeHBvcnQgKm5iZF9leHBvcnRfbmV3KEJsb2NrRHJpdmVyU3RhdGUgKmJzLCB1
aW50NjRfdCBkZXZfb2Zmc2V0LA0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVpbnQ2NF90IHNpemUsIGNvbnN0IGNoYXIgKm5hbWUsIGNv
bnN0IGNoYXIgKmRlc2MsDQo+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgY29uc3QgY2hhciAqYml0bWFwLCB1aW50MTZfdCBuYmRmbGFncywNCj4+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb25z
dCBjaGFyICpiaXRtYXAsIHVpbnQxNl90IG5iZGZsYWdzLCBib29sIHNoYXJlZCwNCj4+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB2b2lkICgq
Y2xvc2UpKE5CREV4cG9ydCAqKSwgYm9vbCB3cml0ZXRocm91Z2gsDQo+PiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgQmxvY2tCYWNrZW5kICpv
bl9lamVjdF9ibGssIEVycm9yICoqZXJycCk7DQo+PiDCoCB2b2lkIG5iZF9leHBvcnRfY2xvc2Uo
TkJERXhwb3J0ICpleHApOw0KPj4gZGlmZiAtLWdpdCBhL2Jsb2NrZGV2LW5iZC5jIGIvYmxvY2tk
ZXYtbmJkLmMNCj4+IGluZGV4IDY2ZWViYWIzMTg3NS4uZTVkMjI4NzcxMjkyIDEwMDY0NA0KPj4g
LS0tIGEvYmxvY2tkZXYtbmJkLmMNCj4+ICsrKyBiL2Jsb2NrZGV2LW5iZC5jDQo+PiBAQCAtMTg5
LDcgKzE4OSw3IEBAIHZvaWQgcW1wX25iZF9zZXJ2ZXJfYWRkKGNvbnN0IGNoYXIgKmRldmljZSwg
Ym9vbCBoYXNfbmFtZSwgY29uc3QgY2hhciAqbmFtZSwNCj4+IMKgwqDCoMKgwqAgfQ0KPj4NCj4+
IMKgwqDCoMKgwqAgZXhwID0gbmJkX2V4cG9ydF9uZXcoYnMsIDAsIGxlbiwgbmFtZSwgTlVMTCwg
Yml0bWFwLA0KPj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCB3cml0YWJsZSA/IDAgOiBOQkRfRkxBR19SRUFEX09OTFksDQo+PiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHdyaXRhYmxlID8gMCA6IE5CRF9G
TEFHX1JFQURfT05MWSwgdHJ1ZSwNCj4gDQo+IHMvdHJ1ZS8hd3JpdGFibGUgPw0KDQpPaCwgSSBz
ZWUsIEpvaG4gYWxyZWFkeSBub3RpY2VkIHRoaXMsIGl0J3MgY2hlY2tlZCBpbiBuYmRfZXhwb3J0
X25ldyBhbnl3YXkuLg0KDQo+IA0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBOVUxMLCBmYWxzZSwgb25fZWplY3RfYmxrLCBlcnJwKTsNCj4+
IMKgwqDCoMKgwqAgaWYgKCFleHApIHsNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm47DQo+
PiBkaWZmIC0tZ2l0IGEvbmJkL3NlcnZlci5jIGIvbmJkL3NlcnZlci5jDQo+PiBpbmRleCBhMmNm
MDg1Zjc2MzUuLmE2MDJkODUwNzBmZiAxMDA2NDQNCj4+IC0tLSBhL25iZC9zZXJ2ZXIuYw0KPj4g
KysrIGIvbmJkL3NlcnZlci5jDQo+PiBAQCAtMTQ2MCw3ICsxNDYwLDcgQEAgc3RhdGljIHZvaWQg
bmJkX2VqZWN0X25vdGlmaWVyKE5vdGlmaWVyICpuLCB2b2lkICpkYXRhKQ0KPj4NCj4+IMKgIE5C
REV4cG9ydCAqbmJkX2V4cG9ydF9uZXcoQmxvY2tEcml2ZXJTdGF0ZSAqYnMsIHVpbnQ2NF90IGRl
dl9vZmZzZXQsDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgdWludDY0X3Qgc2l6ZSwgY29uc3QgY2hhciAqbmFtZSwgY29uc3QgY2hhciAq
ZGVzYywNCj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBjb25zdCBjaGFyICpiaXRtYXAsIHVpbnQxNl90IG5iZGZsYWdzLA0KPj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbnN0IGNoYXIgKmJp
dG1hcCwgdWludDE2X3QgbmJkZmxhZ3MsIGJvb2wgc2hhcmVkLA0KPj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHZvaWQgKCpjbG9zZSkoTkJE
RXhwb3J0ICopLCBib29sIHdyaXRldGhyb3VnaCwNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBCbG9ja0JhY2tlbmQgKm9uX2VqZWN0X2Js
aywgRXJyb3IgKiplcnJwKQ0KPj4gwqAgew0KPj4gQEAgLTE0ODYsNiArMTQ4Niw4IEBAIE5CREV4
cG9ydCAqbmJkX2V4cG9ydF9uZXcoQmxvY2tEcml2ZXJTdGF0ZSAqYnMsIHVpbnQ2NF90IGRldl9v
ZmZzZXQsDQo+PiDCoMKgwqDCoMKgIHBlcm0gPSBCTEtfUEVSTV9DT05TSVNURU5UX1JFQUQ7DQo+
PiDCoMKgwqDCoMKgIGlmICgobmJkZmxhZ3MgJiBOQkRfRkxBR19SRUFEX09OTFkpID09IDApIHsN
Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBwZXJtIHw9IEJMS19QRVJNX1dSSVRFOw0KPj4gK8KgwqDC
oCB9IGVsc2UgaWYgKHNoYXJlZCkgew0KPj4gK8KgwqDCoMKgwqDCoMKgIG5iZGZsYWdzIHw9IE5C
RF9GTEFHX0NBTl9NVUxUSV9DT05OOw0KDQpGb3IgbWUgaXQgbG9va3MgYSBiaXQgc3RyYW5nZTog
d2UgYWxyZWFkeSBoYXZlIG5iZGZsYWdzIHBhcmFtZXRlciBmb3IgbmJkX2V4cG9ydF9uZXcoKSwg
d2h5DQp0byBhZGQgYSBzZXBhcmF0ZSBib29sZWFuIHRvIHBhc3Mgb25lIG9mIG5iZGZsYWdzIGZs
YWdzPw0KDQpBbHNvLCBmb3IgcWVtdS1uYmQsIHNob3VsZG4ndCB3ZSBhbGxvdyAtZSBvbmx5IHRv
Z2V0aGVyIHdpdGggLXIgPw0KDQo+PiDCoMKgwqDCoMKgIH0NCj4+IMKgwqDCoMKgwqAgYmxrID0g
YmxrX25ldyhiZHJ2X2dldF9haW9fY29udGV4dChicyksIHBlcm0sDQo+PiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBCTEtfUEVSTV9DT05TSVNURU5UX1JFQUQgfCBCTEtf
UEVSTV9XUklURV9VTkNIQU5HRUQgfA0KPj4gZGlmZiAtLWdpdCBhL3FlbXUtbmJkLmMgYi9xZW11
LW5iZC5jDQo+PiBpbmRleCAwNDk2NDU0OTFkYWIuLjU1ZjVjZWFmNWM5MiAxMDA2NDQNCj4+IC0t
LSBhL3FlbXUtbmJkLmMNCj4+ICsrKyBiL3FlbXUtbmJkLmMNCj4+IEBAIC0xMTczLDcgKzExNzMs
NyBAQCBpbnQgbWFpbihpbnQgYXJnYywgY2hhciAqKmFyZ3YpDQo+PiDCoMKgwqDCoMKgIH0NCj4+
DQo+PiDCoMKgwqDCoMKgIGV4cG9ydCA9IG5iZF9leHBvcnRfbmV3KGJzLCBkZXZfb2Zmc2V0LCBm
ZF9zaXplLCBleHBvcnRfbmFtZSwNCj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZXhwb3J0X2Rlc2NyaXB0aW9uLCBiaXRtYXAsIG5iZGZs
YWdzLA0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBleHBvcnRfZGVzY3JpcHRpb24sIGJpdG1hcCwgbmJkZmxhZ3MsIHNoYXJlZCA+IDEs
DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIG5iZF9leHBvcnRfY2xvc2VkLCB3cml0ZXRocm91Z2gsIE5VTEwsDQo+PiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICZlcnJv
cl9mYXRhbCk7DQo+Pg0KPiANCj4gDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

