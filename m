Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1DFCC3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 11:10:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81D432064A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 11:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="EeC5hmvZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81D432064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hya8I-0004mR-ON
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 07:10:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45862)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hya72-0004BX-F4
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 07:09:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hya71-000777-6G
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 07:09:40 -0400
Received: from mail-eopbgr70138.outbound.protection.outlook.com
 ([40.107.7.138]:30108 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hya70-00076T-Ul; Fri, 16 Aug 2019 07:09:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VlK5izNghrlWBJqrCJOaAkxDH3UsVs3FkKlZjV0GyKr+xTblMIEXcKlmUj+jjqurAtUIHrWNmWP29cIngCaGhfxuDLAPwTYhpc0Xv9Ip5e4FC7RzX51/G61M3LsSbNKKOi0v2MzG3uierH5RThl8JdZwaSpt631deRnh7H0Vb0TvguXOU0KvrI7YW1/2P5dXUgbQlX5krFkVLUuVQ6qNDV1muIXwFfiGA4hVDQTivgH7VLkTwE/BgL+VICJelwKYZJmjwX5XzDEvRTaJXtZbf/ff/nX4jQGNrBDPL5dWhmtwjSV2RAV7L43aGDdYI0H2Cw9fZSqMSI51EXD5inSK6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EUnWkwMV7/edlx57PoUNbOL+JOO4JsiLfukdefoXs8s=;
 b=QFbwzJW5+A1zPGtUkip4ckXEhnnYw7L2O138XMwdoumaCIOQOzMQEwiIaSFeJqqGRsT0Y1XtWFogYs59XcIKScwbXY0uUez4teQEeZuA5vQUyUNJNZW+GjtYJKD/wzq96deZtmlkdPTg/4N3M94CoECS8XqJWvzUAcCBFrWsDsq2tSAzBKe1LBuKWGD2j9uNulOFT+/vymz1ZRLa9VvsOjGuZvcrwuWxaxf043a2SXT3gaZUJJMVA9ZHIRiNxv2SDhk+Ifl6dt1IxGZkP9JLUmCnhie/cnUN60RYwSKHCcB4Ezy2V15Uv+92uWbjigSWCQGcrnNvEANpbhZhUS29yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EUnWkwMV7/edlx57PoUNbOL+JOO4JsiLfukdefoXs8s=;
 b=EeC5hmvZUKZbj4Ex1cYZZ79dS9CpvbCYO57fb7ODLyOcR72vZNab6p9x2mnlDVwja1G0t0+fCIqUNf4gqw81F3yHZ4VtlJym7keGB9YP3hJUYbewysU4yYHZHviXdNHJm2olm7PTf/F8nkQmuGIQMOxPoSSNSqGASffaOCjYG2c=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4570.eurprd08.prod.outlook.com (20.179.11.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Fri, 16 Aug 2019 11:09:36 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2157.022; Fri, 16 Aug 2019
 11:09:36 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v4] blockjob: drain all job nodes in block_job_drain
Thread-Index: AQHVSRgJp3mwUkdfEEiT5O2TXD+luKb8ROgAgAFvEwA=
Date: Fri, 16 Aug 2019 11:09:36 +0000
Message-ID: <3920cef9-11ed-ec67-2071-a12e25f54085@virtuozzo.com>
References: <20190802095239.31975-1-vsementsov@virtuozzo.com>
 <d2a58313-6ae8-4310-8121-03eb6692b598@redhat.com>
In-Reply-To: <d2a58313-6ae8-4310-8121-03eb6692b598@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR02CA0108.eurprd02.prod.outlook.com
 (2603:10a6:7:29::37) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190816140934292
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bf4eb694-5f0b-4195-b285-08d7223a393f
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB4570; 
x-ms-traffictypediagnostic: DB8PR08MB4570:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB4570397561889E1A18AC0B9EC1AF0@DB8PR08MB4570.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0131D22242
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39850400004)(396003)(136003)(376002)(346002)(366004)(189003)(199004)(31686004)(229853002)(86362001)(2501003)(36756003)(26005)(66066001)(53936002)(4326008)(2616005)(81166006)(107886003)(6246003)(8936002)(256004)(476003)(14454004)(11346002)(486006)(5660300002)(66946007)(66556008)(66446008)(25786009)(305945005)(66476007)(64756008)(4744005)(54906003)(446003)(7736002)(81156014)(110136005)(3846002)(8676002)(6116002)(316002)(52116002)(31696002)(76176011)(99286004)(6486002)(6436002)(186003)(6512007)(478600001)(71200400001)(71190400001)(386003)(6506007)(53546011)(2906002)(102836004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4570;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: oqfZeJMax5uriepDyb9kcKTSWx9AlxT5QfjtM38reNPadIoLdbbD1s582dc2Jrat+IvZxnfJwRFi5ybdDBdqPE9E0+qVDuMHID8/rCUGHAmyaWvONY0tju0CqcOVMA437dgJh5e9YsKKzZMLApWpw5cbhcjc9AOwVFFTX9D2+bea2MsLQ2IeJ46AXvAumPKtB2esKWr0NlDy2sdSGdtiR3i1PBBxYKF7AirGAkY0D+mz6RZCYAhrLxd4OfxdS0ck9Ee/Oz9io78Lg0NRuJww1SzeWwKxVnIcyh5CrEsJ6SEmovhZlwYE9jIrct8abFGTbQ+0p6UYaabz/5UWAiU+MAsZUrjtKnNIvEowoZahPEBOE0RH50cx8C1mavxjpWZScUXZjmJoP5QJGXbhFk6Z+JNf6C4MLIE7T8Lzr6Mi2oM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F76467B33FB307488FBCC78BBE4D6212@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf4eb694-5f0b-4195-b285-08d7223a393f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2019 11:09:36.0988 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /9M7rBqUOA6PNgeInb02e9mWoBofgqhC4pn9J8BpescRgYDdOC9xsydj2eYH+mifz+NNQBSED/wEv7zuy/W7302k04rHleUZBjtA5mvDFZE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4570
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.138
Subject: Re: [Qemu-devel] [PATCH v4] blockjob: drain all job nodes in
 block_job_drain
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
 "jsnow@redhat.com" <jsnow@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTUuMDguMjAxOSAxNjoxNSwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAwMi4wOC4xOSAxMTo1Miwg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IEluc3RlYWQgb2YgZHJhaW5p
bmcgYWRkaXRpb25hbCBub2RlcyBpbiBlYWNoIGpvYiBjb2RlLCBsZXQncyBkbyBpdCBpbg0KPj4g
Y29tbW9uIGJsb2NrX2pvYl9kcmFpbiwgZHJhaW5pbmcganVzdCBhbGwgam9iJ3MgY2hpbGRyZW4u
DQo+PiBCbG9ja0pvYkRyaXZlci5kcmFpbiBiZWNvbWVzIHVudXNlZCwgc28sIGRyb3AgaXQgYXQg
YWxsLg0KPj4NCj4+IEl0J3MgYWxzbyBhIGZpcnN0IHN0ZXAgdG8gZmluYWxseSBnZXQgcmlkIG9m
IGJsb2Nram9iLT5ibGsuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogVmxhZGltaXIgU2VtZW50c292
LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPg0KPj4gLS0tDQo+IA0KPiBXaGF0
IGRvIHlvdSB0aGluayBvZiBLZXZpbuKAmXMgY29tbWVudCB0aGF0IGRyYWluaW5nIHRoZSBibG9j
ayBub2RlcyBtYXkNCj4gYWN0dWFsbHkgYmUgZW50aXJlbHkgdW5uZWNlc3Nhcnk/DQo+IA0KDQpI
bW1tLCBJJ20gYWZyYWlkIHRoYXQgbm90aGluZyBtb3JlIHRoYW4gSSBjYW4gdHJ5LCBhbmQgaWYg
bm8gcmVhbCBwcm9ibGVtcw0Kd2l0aCBpb3Rlc3RzIEknbGwgc2VuZCBhIHBhdGNoLg0KDQoNCi0t
IA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

