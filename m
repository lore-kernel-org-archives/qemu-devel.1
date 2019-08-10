Return-Path: <SRS0=VlUQ=WG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01CE8C433FF
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 16:41:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9722206C2
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 16:41:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="bl4D8ZKQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9722206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwUR3-0003eC-3f
	for qemu-devel@archiver.kernel.org; Sat, 10 Aug 2019 12:41:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53274)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hwUQc-0003AR-28
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 12:41:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hwUQb-0006B9-2M
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 12:41:14 -0400
Received: from mail-eopbgr150093.outbound.protection.outlook.com
 ([40.107.15.93]:61703 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hwUQa-0006AP-Tl; Sat, 10 Aug 2019 12:41:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=juQuQwiIRyX/TvPMbML5jvSWCS3JrezGjMhlbBJMy+vT23h3enOC1zG/YKNI/xeJq7M7xSlI+ydQ99q4fEaNJhvbEXk9iWLcGa3iZi92sxiP1jKvBezr9EBEWTvqxHsxGt4ElnT6wYj6TRBjeCRG1Na8v/KNeppc7cWsqlGKMOqenJ6dgUPxjhV7ZRBS/mxh+SZEYTdYGbmIQa1Ue1eRBs3bQk200H52+iAWAWzcW6nSTe2UGS/4xFQG7qYz69nTuEf/JcuiN/Eo2mwmnwdIxYmhqVH2XrdIJpVD5iT706YeMdcEaoWuWzjnAlUGtLiNkm9Z6j2Vf/QVFg8+owHDQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hD2fOvcs9xTG68Y8MYRm7hVaVZyvViM+7SjyxrUP2zA=;
 b=OCuwdmBJOAstH/dWjKL/Rsu8kh7nRjXziQ8eJtzcEYmiqRlgpmzDK8dhHXgBIXxurc8/Dt2ZYQQHCRF7S1JKDTOZjQbMUCGlX9xBNsamsAOwVte23gkvLbbKny2l3OVIuPqTX3QCoD7Q/fAsZe/fbVTnrp2A657PvE6rdYXfcAfU8j0nuS2YV+BjY6SgEUn3vRwT+hdxBAk6Q9P85ju2zKDenW8RhS8lmqTMU7j+pVU0JcLg/EMTMgzSdXhhcJrFR5gbZibuOAuFEE4WSwHP5lv/h2ZuVq/GkOln+0vOazwNP81tEA6b5fZJIVuI1QGCG6OtAznb7lgofmf3It+EUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hD2fOvcs9xTG68Y8MYRm7hVaVZyvViM+7SjyxrUP2zA=;
 b=bl4D8ZKQ3/CxWGLqb/N+fuXuIq5PkEDLD1OJua/YLklJAFgLjywj4N6PLM1OT3xqw/McP2/GZeWHssZv9jdH5EcWkw91b/wc9L3+n0rXfUxU28PUDLefZi4GGc6z7vLjSOsQsFgSaSfcVakyrdsk6ApsPDiMcwhb0aqTGMIFsJU=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4569.eurprd08.prod.outlook.com (20.179.12.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.20; Sat, 10 Aug 2019 16:41:11 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2157.022; Sat, 10 Aug 2019
 16:41:10 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v6 22/42] block: Fix bdrv_get_allocated_file_size's
 fallback
Thread-Index: AQHVTs2Z4sBlL0bNk0yfK96bh7A+Bab0lzYA
Date: Sat, 10 Aug 2019 16:41:10 +0000
Message-ID: <c5571509-98ed-b99d-37fe-39a1067105cd@virtuozzo.com>
References: <20190809161407.11920-1-mreitz@redhat.com>
 <20190809161407.11920-23-mreitz@redhat.com>
In-Reply-To: <20190809161407.11920-23-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR07CA0041.eurprd07.prod.outlook.com
 (2603:10a6:7:66::27) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190810194108277
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 25c1f6a4-e084-4fad-dd31-08d71db18ce5
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB4569; 
x-ms-traffictypediagnostic: DB8PR08MB4569:
x-microsoft-antispam-prvs: <DB8PR08MB45692E728D4066E54839AF73C1D10@DB8PR08MB4569.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 012570D5A0
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(136003)(396003)(376002)(39840400004)(366004)(189003)(199004)(6116002)(102836004)(6246003)(186003)(2906002)(52116002)(76176011)(6506007)(476003)(3846002)(2501003)(486006)(256004)(386003)(26005)(2616005)(31686004)(53936002)(14454004)(478600001)(31696002)(305945005)(7736002)(99286004)(66946007)(66476007)(66556008)(64756008)(66446008)(316002)(36756003)(6512007)(229853002)(6436002)(6486002)(54906003)(86362001)(110136005)(4326008)(71190400001)(71200400001)(25786009)(8936002)(446003)(8676002)(81156014)(81166006)(11346002)(5660300002)(66066001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4569;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Ne7h70164lBDpQastg0vWLcCKFckRx3U31vujf1WWnXdUlS7a8HBxqKWs+oLLIXt7nN7kY+V6DeFE+zgQjvUrnBXt9lCAG0Aplz396woaHXSEMIBlAnQj+DBGO4CgMCH8u6WorflYH6Amu9fF5ayyTiQ3BaUwgdScM3wYGO6tRZXyedi+ObRIcAHNyEDifjxwfyINNE4QzgEHVWVxs7FfvX6oZ5LoOnkst1BX9vfbyI4tXg1gCLqC/GHctk0amYSVvDvpoM/+14WRvGadli93VS6O5m5BycVQBz4dFke4wQl2wG8lrWI9c3LQzc8H3m3j57r540uzOo4R+KsESz1yhl5vQtEm9tLEjnN++7MidzZLsEB9aoZY+u5zK246WX4pqXvNIsUpd6TXh77s6UFr5gajUw62CGW+U4Yen5lDQo=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <000A05B94B54A64B958337536D370861@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25c1f6a4-e084-4fad-dd31-08d71db18ce5
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2019 16:41:10.8227 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sVRw2N8zemy1kKOuMyTQ9drnvKsnq5iu/OmvM7BKchPMAtRbliyDTbi48RniYc30g6pkyVa6vNzopafg8WDeuicT/FaaoL2c4qyTrG+GKKg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4569
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.15.93
Subject: Re: [Qemu-devel] [PATCH v6 22/42] block: Fix
 bdrv_get_allocated_file_size's fallback
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDkuMDguMjAxOSAxOToxMywgTWF4IFJlaXR6IHdyb3RlOg0KPiBJZiB0aGUgZHJpdmVyIGRvZXMg
bm90IGltcGxlbWVudCBiZHJ2X2dldF9hbGxvY2F0ZWRfZmlsZV9zaXplKCksIHdlDQo+IHNob3Vs
ZCBmYWxsIGJhY2sgdG8gY3VtdWxhdGluZyB0aGUgYWxsb2NhdGVkIHNpemUgb2YgYWxsIG5vbi1D
T1cNCj4gY2hpbGRyZW4gaW5zdGVhZCBvZiBqdXN0IGJzLT5maWxlLg0KPiANCj4gU3VnZ2VzdGVk
LWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5j
b20+DQo+IFNpZ25lZC1vZmYtYnk6IE1heCBSZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+DQo+IC0t
LQ0KPiAgIGJsb2NrLmMgfCAyMiArKysrKysrKysrKysrKysrKysrKy0tDQo+ICAgMSBmaWxlIGNo
YW5nZWQsIDIwIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvYmxvY2suYyBiL2Jsb2NrLmMNCj4gaW5kZXggMTA3MGFhMWJhOS4uNmUxZGRhYjA1NiAxMDA2
NDQNCj4gLS0tIGEvYmxvY2suYw0KPiArKysgYi9ibG9jay5jDQo+IEBAIC00NjUwLDkgKzQ2NTAs
MjcgQEAgaW50NjRfdCBiZHJ2X2dldF9hbGxvY2F0ZWRfZmlsZV9zaXplKEJsb2NrRHJpdmVyU3Rh
dGUgKmJzKQ0KPiAgICAgICBpZiAoZHJ2LT5iZHJ2X2dldF9hbGxvY2F0ZWRfZmlsZV9zaXplKSB7
DQo+ICAgICAgICAgICByZXR1cm4gZHJ2LT5iZHJ2X2dldF9hbGxvY2F0ZWRfZmlsZV9zaXplKGJz
KTsNCj4gICAgICAgfQ0KPiAtICAgIGlmIChicy0+ZmlsZSkgew0KPiAtICAgICAgICByZXR1cm4g
YmRydl9nZXRfYWxsb2NhdGVkX2ZpbGVfc2l6ZShicy0+ZmlsZS0+YnMpOw0KPiArDQo+ICsgICAg
aWYgKCFRTElTVF9FTVBUWSgmYnMtPmNoaWxkcmVuKSkgew0KPiArICAgICAgICBCZHJ2Q2hpbGQg
KmNoaWxkOw0KPiArICAgICAgICBpbnQ2NF90IGNoaWxkX3NpemUsIHRvdGFsX3NpemUgPSAwOw0K
PiArDQo+ICsgICAgICAgIFFMSVNUX0ZPUkVBQ0goY2hpbGQsICZicy0+Y2hpbGRyZW4sIG5leHQp
IHsNCj4gKyAgICAgICAgICAgIGlmIChjaGlsZCA9PSBiZHJ2X2ZpbHRlcmVkX2Nvd19jaGlsZChi
cykpIHsNCj4gKyAgICAgICAgICAgICAgICAvKiBJZ25vcmUgQ09XIGJhY2tpbmcgZmlsZXMgKi8N
Cj4gKyAgICAgICAgICAgICAgICBjb250aW51ZTsNCj4gKyAgICAgICAgICAgIH0NCj4gKw0KPiAr
ICAgICAgICAgICAgY2hpbGRfc2l6ZSA9IGJkcnZfZ2V0X2FsbG9jYXRlZF9maWxlX3NpemUoY2hp
bGQtPmJzKTsNCj4gKyAgICAgICAgICAgIGlmIChjaGlsZF9zaXplIDwgMCkgew0KPiArICAgICAg
ICAgICAgICAgIHJldHVybiBjaGlsZF9zaXplOw0KPiArICAgICAgICAgICAgfQ0KPiArICAgICAg
ICAgICAgdG90YWxfc2l6ZSArPSBjaGlsZF9zaXplOw0KPiArICAgICAgICB9DQo+ICsNCj4gKyAg
ICAgICAgcmV0dXJuIHRvdGFsX3NpemU7DQo+ICAgICAgIH0NCj4gKw0KPiAgICAgICByZXR1cm4g
LUVOT1RTVVA7DQo+ICAgfQ0KPiAgIA0KPiANCg0KSG1tLi4NCg0KMS4gTm8gY2hpbGRyZW4gLT4g
LUVOT1RTVVANCjIuIE9ubHkgY293IGNoaWxkIC0+IDANCjMuIFNvbWUgbm9uLWNvdyBjaGlsZHJl
biAtPiBTVU0NCg0KSXQncyBhbGwgYXJndWFibGUgKHRoZSBzdHJpY3Rlc3Qgd2F5IGlzIC1FTk9U
U1VQIGluIGVpdGhlciBjYXNlKSwNCmJ1dCBpZiB3ZSB3YW50IHRvIGZhbGxiYWNrIHRvIFNVTSBv
ZiBub24tY293IGNoaWxkcmVuLCAxLiBhbmQgMi4gc2hvdWxkIHJldHVybg0KdGhlIHNhbWUuDQoN
Ci0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

