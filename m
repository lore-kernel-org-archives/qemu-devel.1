Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAEE5C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 12:57:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72AEE2073F
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 12:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="QokhpT77"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72AEE2073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBITa-0006EB-9i
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 08:57:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49703)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iBISJ-0005Sz-Aa
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 08:56:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iBISI-0006Hn-1o
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 08:56:11 -0400
Received: from mail-eopbgr150130.outbound.protection.outlook.com
 ([40.107.15.130]:44141 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iBISH-0006Ft-Pl; Fri, 20 Sep 2019 08:56:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S1UsFm8JnwGpsz2S/Qlv9lyLkMjPhBQPYLErypU2pHp+GbnKGXVeO4M7hMnksNffyFZ6W2PIjGX6jwAfbG2fAjekkfuRn9spNp+Her/YlXjvobihf3lGXR8ys3ZWX5N+JOQYUjE3ehW1NzhI+A4Xwq1uVYMoe+YuzKz836dw1/vqZ0r5i7z4e3nCCTQy12vNiQB3g3BKzIYNP1MrBjZLxV/HCAgW2dU4PA21+o06/YTFPVd0cDI8nphIL0T6+dDhBHZ7bcV+0EjW0bKmpMnvCTaD3hlWqLEzUQLbw4Scg4/zdBbhQUq4wB+d1KZ5pE8F+XiD3z520XV3FrYmKghpIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mobX/Zc5+gxX1yVnB9tUJPIhgnFcQ+qWlLCT0tYSvvU=;
 b=Jjq2YUmVIAElvlGVMqtVEW5Se92b0bBTawoBTIuNqmYxaBnnpyMsyJx7iGUnke7P+OfH7WqdxwRi7t2u/EpwIzbQ2wAvISf33+zK7pcnK3AFyL4PQRPRlsqeRZe2wdPqoOjWzjPObgZPGk6Po/oK/bXXpzjBcCf9nux9LPpTkGppIl/z6EuyIeeDOPOj8xHAlI5lnnY/v/T/x5W+O+y+3Fp80VFJYcggP82NOihAJ/rl/NKhsz14ST2LwIMNNjh/Rc7P2uWsKz55O4Vcboa7phu1hbK9wRDfSHdyFdMBu8gsUb52H2PhRDQZsOgOjYh9FMXzoWh+vXBgYZQhrw7ReA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mobX/Zc5+gxX1yVnB9tUJPIhgnFcQ+qWlLCT0tYSvvU=;
 b=QokhpT77xhVaH8Qf2TlllEY2UQQwWc0M5Yf2JKPjB5sgT2IxPxYPCKN0lhgu1T4EWJYVAgOLul/ReMRCF9E995IOxPYYFSpKvot7ypN0jHlv1qJ6awSFzxxBEvzW+Sfyuz2Zj42AcQCswGypIAYmhjcIiJHzDZLeprSPCeJAees=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5401.eurprd08.prod.outlook.com (10.255.185.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Fri, 20 Sep 2019 12:56:08 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2284.023; Fri, 20 Sep 2019
 12:56:08 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH v11 04/14] block/backup: introduce BlockCopyState
Thread-Topic: [PATCH v11 04/14] block/backup: introduce BlockCopyState
Thread-Index: AQHVZ8HWULZDkPZpMke6HdjhrfznqKcp8daAgAqhiQCAAAKhgA==
Date: Fri, 20 Sep 2019 12:56:07 +0000
Message-ID: <abf4fdcc-2ca3-7ec5-93ff-95be6b480a5d@virtuozzo.com>
References: <20190910102332.20560-1-vsementsov@virtuozzo.com>
 <20190910102332.20560-5-vsementsov@virtuozzo.com>
 <bafea6c6-38cc-1848-92ea-ec891457515a@virtuozzo.com>
 <bb798ca2-dd22-9ffe-de08-a4d0d8891f30@redhat.com>
In-Reply-To: <bb798ca2-dd22-9ffe-de08-a4d0d8891f30@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0136.eurprd05.prod.outlook.com
 (2603:10a6:7:28::23) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190920155603933
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1f95bfa7-40f2-4e19-33c3-08d73dc9e763
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5401; 
x-ms-traffictypediagnostic: DB8PR08MB5401:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB54011673513A77400A212970C1880@DB8PR08MB5401.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:96;
x-forefront-prvs: 0166B75B74
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(366004)(136003)(346002)(376002)(39850400004)(189003)(199004)(446003)(8936002)(11346002)(486006)(2616005)(316002)(476003)(25786009)(81166006)(8676002)(76176011)(186003)(36756003)(81156014)(53546011)(386003)(99286004)(52116002)(31686004)(86362001)(7416002)(6506007)(102836004)(5660300002)(71190400001)(256004)(71200400001)(26005)(6436002)(14454004)(4326008)(478600001)(6486002)(2501003)(229853002)(64756008)(66946007)(66446008)(66556008)(66476007)(6512007)(54906003)(66066001)(110136005)(305945005)(7736002)(31696002)(2906002)(6116002)(107886003)(3846002)(6246003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5401;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mLcS+t0TAIWrHEGBuDksbIg29InY5BUBVHSu7yNOOQCUfn51+cZRLMOz5M8PKS3ApiLiGloNAsuDe+d5Ve5/wa2Si/H7Ms9TLnjSvnqTk8BcRsFyA54MmQSWSP12E+ffVMqwDfERgyAn0kUKVJcWm9A+WfW+V0ggc+kR6ZLwa8mESYTSXCS40KVWDrYAQ4whRLFdhB3Y/MqGlv7kA/FMA9sfCn6LNwhq8vpUGstfs+jhuSa52tXM5NjDhl9bkqnLnkwSERlXvIv09yIcjhsO1by4pi5dvi0MPpkOy9ZaV6qaUx4LnWtXQdP4YXLRp6DgSNIGcEwHd38K6shnYcQeifc5JrCplDh6UEeAu/V4pApBTj+MYbHBjE2KEwgVQCAuhQSRqze+1NLmCmqhwgo+KXK7OCttV50swk7hv493cx0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D4BA48746142A84CB8921DBDE6877D0B@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f95bfa7-40f2-4e19-33c3-08d73dc9e763
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2019 12:56:07.8735 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bWZNjr7iu3j50hLcdJIFSNl7hZCoiRpQ7kYawMW37TuCBGw3X/z6ftYPRy3tAV6NnOMIDoN7eNzSYlHfrWL/jDIm1oqZ13aJImd8EQ+tEZQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5401
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.15.130
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
Cc: "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
 Denis Lunev <den@virtuozzo.com>,
 "wencongyang2@huawei.com" <wencongyang2@huawei.com>,
 "xiechanglong.d@gmail.com" <xiechanglong.d@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjAuMDkuMjAxOSAxNTo0NiwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAxMy4wOS4xOSAyMDoyNSwg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IDEwLjA5LjIwMTkgMTM6MjMs
IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgd3JvdGU6DQo+Pj4gU3BsaXQgY29weWluZyBj
b2RlIHBhcnQgZnJvbSBiYWNrdXAgdG8gImJsb2NrLWNvcHkiLCBpbmNsdWRpbmcgc2VwYXJhdGUN
Cj4+PiBzdGF0ZSBzdHJ1Y3R1cmUgYW5kIGZ1bmN0aW9uIHJlbmFtaW5nLiBUaGlzIGlzIG5lZWRl
ZCB0byBzaGFyZSBpdCB3aXRoDQo+Pj4gYmFja3VwLXRvcCBmaWx0ZXIgZHJpdmVyIGluIGZ1cnRo
ZXIgY29tbWl0cy4NCj4+Pg0KPj4+IE5vdGVzOg0KPj4+DQo+Pj4gMS4gQXMgQmxvY2tDb3B5U3Rh
dGUga2VlcHMgb3duIEJsb2NrQmFja2VuZCBvYmplY3RzLCByZW1haW5pbmcNCj4+PiBqb2ItPmNv
bW1vbi5ibGsgdXNlcnMgb25seSB1c2UgaXQgdG8gZ2V0IGJzIGJ5IGJsa19icygpIGNhbGwsIHNv
IGNsZWFyDQo+Pj4gam9iLT5jb21tZW4uYmxrIHBlcm1pc3Npb25zIHNldCBpbiBibG9ja19qb2Jf
Y3JlYXRlIGFuZCBhZGQNCj4+PiBqb2ItPnNvdXJjZV9icyB0byBiZSB1c2VkIGluc3RlYWQgb2Yg
YmxrX2JzKGpvYi0+Y29tbW9uLmJsayksIHRvIGtlZXANCj4+PiBpdCBtb3JlIGNsZWFyIHdoaWNo
IGJzIHdlIHVzZSB3aGVuIGludHJvZHVjZSBiYWNrdXAtdG9wIGZpbHRlciBpbg0KPj4+IGZ1cnRo
ZXIgY29tbWl0Lg0KPj4+DQo+Pj4gMi4gUmVuYW1lIHMvaW5pdGlhbGl6aW5nX2JpdG1hcC9za2lw
X3VuYWxsb2NhdGVkLyB0byBzb3VuZCBhIGJpdCBiZXR0ZXINCj4+PiBhcyBpbnRlcmZhY2UgdG8g
QmxvY2tDb3B5U3RhdGUNCj4+Pg0KPj4+IDMuIFNwbGl0IGlzIG5vdCB2ZXJ5IGNsZWFuOiB0aGVy
ZSBsZWZ0IHNvbWUgZHVwbGljYXRlZCBmaWVsZHMsIGJhY2t1cA0KPj4+IGNvZGUgdXNlcyBzb21l
IEJsb2NrQ29weVN0YXRlIGZpZWxkcyBkaXJlY3RseSwgbGV0J3MgcG9zdHBvbmUgaXQgZm9yDQo+
Pj4gZnVydGhlciBpbXByb3ZlbWVudHMgYW5kIGtlZXAgdGhpcyBjb21tZW50IHNpbXBsZXIgZm9y
IHJldmlldy4NCj4+Pg0KPj4+IFNpZ25lZC1vZmYtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2ll
dnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCj4+PiAtLS0NCj4+DQo+Pg0KPj4gWy4u
XQ0KPj4NCj4+PiArDQo+Pj4gK3N0YXRpYyBCbG9ja0NvcHlTdGF0ZSAqYmxvY2tfY29weV9zdGF0
ZV9uZXcoDQo+Pj4gKyAgICAgICAgQmxvY2tEcml2ZXJTdGF0ZSAqc291cmNlLCBCbG9ja0RyaXZl
clN0YXRlICp0YXJnZXQsDQo+Pj4gKyAgICAgICAgaW50NjRfdCBjbHVzdGVyX3NpemUsIEJkcnZS
ZXF1ZXN0RmxhZ3Mgd3JpdGVfZmxhZ3MsDQo+Pj4gKyAgICAgICAgUHJvZ3Jlc3NCeXRlc0NhbGxi
YWNrRnVuYyBwcm9ncmVzc19ieXRlc19jYWxsYmFjaywNCj4+PiArICAgICAgICBQcm9ncmVzc1Jl
c2V0Q2FsbGJhY2tGdW5jIHByb2dyZXNzX3Jlc2V0X2NhbGxiYWNrLA0KPj4+ICsgICAgICAgIHZv
aWQgKnByb2dyZXNzX29wYXF1ZSwgRXJyb3IgKiplcnJwKQ0KPj4+ICt7DQo+Pj4gKyAgICBCbG9j
a0NvcHlTdGF0ZSAqczsNCj4+PiArICAgIGludCByZXQ7DQo+Pj4gKyAgICB1aW50NjRfdCBub19y
ZXNpemUgPSBCTEtfUEVSTV9DT05TSVNURU5UX1JFQUQgfCBCTEtfUEVSTV9XUklURSB8DQo+Pj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICBCTEtfUEVSTV9XUklURV9VTkNIQU5HRUQgfCBCTEtf
UEVSTV9HUkFQSF9NT0Q7DQo+Pj4gKyAgICBCZHJ2RGlydHlCaXRtYXAgKmNvcHlfYml0bWFwOw0K
Pj4+ICsNCj4+PiArICAgIGNvcHlfYml0bWFwID0gYmRydl9jcmVhdGVfZGlydHlfYml0bWFwKHNv
dXJjZSwgY2x1c3Rlcl9zaXplLCBOVUxMLCBlcnJwKTsNCj4+PiArICAgIGlmICghY29weV9iaXRt
YXApIHsNCj4+PiArICAgICAgICByZXR1cm4gTlVMTDsNCj4+PiArICAgIH0NCj4+PiArICAgIGJk
cnZfZGlzYWJsZV9kaXJ0eV9iaXRtYXAoY29weV9iaXRtYXApOw0KPj4+ICsNCj4+PiArICAgIHMg
PSBnX25ldyhCbG9ja0NvcHlTdGF0ZSwgMSk7DQo+Pj4gKyAgICAqcyA9IChCbG9ja0NvcHlTdGF0
ZSkgew0KPj4+ICsgICAgICAgIC5zb3VyY2UgPSBibGtfbmV3KGJkcnZfZ2V0X2Fpb19jb250ZXh0
KHNvdXJjZSksDQo+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgQkxLX1BFUk1fQ09OU0lT
VEVOVF9SRUFELCBub19yZXNpemUpLA0KPj4+ICsgICAgICAgIC50YXJnZXQgPSBibGtfbmV3KGJk
cnZfZ2V0X2Fpb19jb250ZXh0KHRhcmdldCksDQo+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgQkxLX1BFUk1fV1JJVEUsIG5vX3Jlc2l6ZSksDQo+Pj4gKyAgICAgICAgLmNvcHlfYml0bWFw
ID0gY29weV9iaXRtYXAsDQo+Pj4gKyAgICAgICAgLmNsdXN0ZXJfc2l6ZSA9IGNsdXN0ZXJfc2l6
ZSwNCj4+PiArICAgICAgICAubGVuID0gYmRydl9kaXJ0eV9iaXRtYXBfc2l6ZShjb3B5X2JpdG1h
cCksDQo+Pj4gKyAgICAgICAgLndyaXRlX2ZsYWdzID0gd3JpdGVfZmxhZ3MsDQo+Pj4gKyAgICAg
ICAgLnVzZV9jb3B5X3JhbmdlID0gISh3cml0ZV9mbGFncyAmIEJEUlZfUkVRX1dSSVRFX0NPTVBS
RVNTRUQpLA0KPj4+ICsgICAgICAgIC5wcm9ncmVzc19ieXRlc19jYWxsYmFjayA9IHByb2dyZXNz
X2J5dGVzX2NhbGxiYWNrLA0KPj4+ICsgICAgICAgIC5wcm9ncmVzc19yZXNldF9jYWxsYmFjayA9
IHByb2dyZXNzX3Jlc2V0X2NhbGxiYWNrLA0KPj4+ICsgICAgICAgIC5wcm9ncmVzc19vcGFxdWUg
PSBwcm9ncmVzc19vcGFxdWUsDQo+Pj4gKyAgICB9Ow0KPj4+ICsNCj4+PiArICAgIHMtPmNvcHlf
cmFuZ2Vfc2l6ZSA9IFFFTVVfQUxJR05fVVAoTUlOKGJsa19nZXRfbWF4X3RyYW5zZmVyKHMtPnNv
dXJjZSksDQo+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBi
bGtfZ2V0X21heF90cmFuc2ZlcihzLT50YXJnZXQpKSwNCj4+PiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgcy0+Y2x1c3Rlcl9zaXplKTsNCj4+DQo+PiBwcmVleGlzdGVu
dCwgYnV0IGl0IG9idmlvdXNseSBzaG91bGQgYmUgUUVNVV9BTElHTl9ET1dOLiBJIGNhbiByZXNl
bmQgd2l0aCBhIHNlcGFyYXRlDQo+PiBmaXgsIGl0IG1heSBiZSBmaXhlZCB3aGlsZSBxdWV1aW5n
IChpZiByZXNlbmQgaXMgbm90IG5lZWRlZCBmb3Igb3RoZXIgcmVhc29ucykgb3INCj4+IEknbGwg
c2VuZCBhIGZvbGxvdy11cCBmaXggbGF0ZXIsIHdoaWNoZXZlciB5b3UgcHJlZmVyLg0KPiANCj4g
SG0sIHRydWUuICBCdXQgdGhlbiB3ZeKAmWxsIGFsc28gbmVlZCB0byBoYW5kbGUgdGhlICh1bmxp
a2VseSwgYWRtaXR0ZWRseSkNCj4gY2FzZSB3aGVyZSBtYXhfdHJhbnNmZXIgPCBjbHVzdGVyX3Np
emUgc28gdGhpcyB3b3VsZCB0aGVuIHJldHVybiAwIChieQ0KPiBzZXR0aW5nIHVzZV9jb3B5X3Jh
bmdlID0gZmFsc2UpLiAgU28gaG93IGFib3V0IHRoaXM6DQoNCkRvbmUgaW4gW1BBVENIIHYxMiAw
LzJdIGJhY2t1cDogY29weV9yYW5nZSBmaXhlcy4NCklmIGl0IGlzIGNvbnZlbmllbnQgSSdsbCBy
ZWJhc2UgdGhlc2Ugc2VyaWVzIG9uICJbUEFUQ0ggdjEyIDAvMl0gYmFja3VwOiBjb3B5X3Jhbmdl
IGZpeGVzIg0KDQo+IA0KPj4gZGlmZiAtLWdpdCBhL2Jsb2NrL2JhY2t1cC5jIGIvYmxvY2svYmFj
a3VwLmMNCj4+IGluZGV4IGU1YmNmZTcxNzcuLmJhNGEzN2RiYjUgMTAwNjQ0DQo+PiAtLS0gYS9i
bG9jay9iYWNrdXAuYw0KPj4gKysrIGIvYmxvY2svYmFja3VwLmMNCj4+IEBAIC0xODIsOSArMTgy
LDEzIEBAIHN0YXRpYyBCbG9ja0NvcHlTdGF0ZSAqYmxvY2tfY29weV9zdGF0ZV9uZXcoDQo+PiAg
ICAgICAgICAgLnByb2dyZXNzX29wYXF1ZSA9IHByb2dyZXNzX29wYXF1ZSwNCj4+ICAgICAgIH07
DQo+PiAgIA0KPj4gLSAgICBzLT5jb3B5X3JhbmdlX3NpemUgPSBRRU1VX0FMSUdOX1VQKE1JTihi
bGtfZ2V0X21heF90cmFuc2ZlcihzLT5zb3VyY2UpLA0KPj4gLSAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBibGtfZ2V0X21heF90cmFuc2ZlcihzLT50YXJnZXQpKSwN
Cj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzLT5jbHVzdGVyX3Np
emUpOw0KPj4gKyAgICBzLT5jb3B5X3JhbmdlX3NpemUgPSBRRU1VX0FMSUdOX0RPV04oTUlOKGJs
a19nZXRfbWF4X3RyYW5zZmVyKHMtPnNvdXJjZSksDQo+PiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgYmxrX2dldF9tYXhfdHJhbnNmZXIocy0+dGFyZ2V0KSks
DQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzLT5jbHVzdGVy
X3NpemUpOw0KPj4gKyAgICBpZiAocy0+Y29weV9yYW5nZV9zaXplID09IDApIHsNCj4+ICsgICAg
ICAgIC8qIG1heF90cmFuc2ZlciA8IGNsdXN0ZXJfc2l6ZSAqLw0KPj4gKyAgICAgICAgcy0+dXNl
X2NvcHlfcmFuZ2UgPSBmYWxzZTsNCj4+ICsgICAgfQ0KPj4gICANCj4+ICAgICAgIC8qDQo+PiAg
ICAgICAgKiBXZSBqdXN0IGFsbG93IGFpbyBjb250ZXh0IGNoYW5nZSBvbiBvdXIgYmxvY2sgYmFj
a2VuZHMuIGJsb2NrX2NvcHkoKSB1c2VyDQo+IA0KPiBNYXgNCj4gDQoNCg0KLS0gDQpCZXN0IHJl
Z2FyZHMsDQpWbGFkaW1pcg0K

