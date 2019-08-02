Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD5B6C32750
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 16:42:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A9D22087E
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 16:42:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="OAdRDBqI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A9D22087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htadQ-0002h3-Vh
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 12:42:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40550)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1htacz-0002Dl-8P
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 12:42:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1htacx-0002MJ-Gv
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 12:42:01 -0400
Received: from mail-eopbgr10102.outbound.protection.outlook.com
 ([40.107.1.102]:18577 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1htact-0002Is-5Y; Fri, 02 Aug 2019 12:41:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CCC8mRPOkQ9mYqzylc6pOTbtcGXkZMfWrlvfi4DB9MVQ9tz4hX5621ZcrHdW64w835EgvZlvAshktKlygXA9f+nUdQOyhmHc4gmnyvwi/KGJMsOmtaG8lhdxZuEEUXZoa7Ti2yOMs5CLBnRQejS/Ybo/B34OU7bwxlXmxXw8smWDVr4HNARu/kKYP6NKN2r1yS/1Bepfr36HEe7zqcBGYR057VkY0NV4IbLDS8QUhPRCIz2eyrJxkW3MHfos2U3+rzOIRcb5TYUziSUUMgkG+IkJHX8NRsftKhznZWcdYTufut4JHb2o+B3cS9K3fqXow9xeT3fmWoPxgek29CoUYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=baN82foB8urDsR7toBaVfKkhd3zR89rvv5+4dsBh59Y=;
 b=mEQzTBOpXVyFaPdlH1eudWAzeVeQGmUTbux2b55rL55zGEB+Fq2AhmxPs+sTbKrvJCQBi3nMX+PeyVAXwrC2uR9WkZXlQWNbhq0FIPMFfWLAL+4uC5N0hPQZUBAYSrVvaRZOSYQtA1cnjEHjwc/0WfGueL/9XP+vfToMOk8jaovFwMdsHkq+rdwHGVdrk9oyCdvbPBXaYNUoOxDBvcuKD6l2IpSMWqhy7MbsbHaJz+wSzgXGxoRo5n2JqHm6RK7focW3Sy1x/xHHyBpSxsLhg+StD392We1cNQHh6cRczDiMpXn+akN6uROJW/HfU98ipXQuTSJgipib0TZliNQRdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=virtuozzo.com;dmarc=pass action=none
 header.from=virtuozzo.com;dkim=pass header.d=virtuozzo.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=baN82foB8urDsR7toBaVfKkhd3zR89rvv5+4dsBh59Y=;
 b=OAdRDBqI5q3Od86PPuo+dSRAhJc8dfy0HC6Bcc9yejIwhsgQ6KuDrd8auTvgTYukajnNXzJQA+mHY552BV9MFfr7sWJH4jhmQdlFww24C0rzWHN12inUjA85GGoEljFCXHmUgHeBt9HjSfc3/LVyLhkx3170cfOdpVx8DhNp76s=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5050.eurprd08.prod.outlook.com (10.255.16.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.16; Fri, 2 Aug 2019 16:41:50 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2136.010; Fri, 2 Aug 2019
 16:41:50 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Thread-Topic: [PATCH v3 1/9] block: add
 .bdrv_need_rw_file_child_during_reopen_rw handler
Thread-Index: AQHVQsoEzSVYPpC2/ESD+i80Sbskiqbkq/cAgANgXQCAAAs9AIAABTSA
Date: Fri, 2 Aug 2019 16:41:50 +0000
Message-ID: <98ccec58-ea1d-e772-7bef-f66001cdd3f6@virtuozzo.com>
References: <20190725091900.30542-1-vsementsov@virtuozzo.com>
 <20190725091900.30542-2-vsementsov@virtuozzo.com>
 <2a105159-ab90-8f7c-bba9-4cec27e6144c@redhat.com>
 <20190802154256.GE6379@localhost.localdomain>
 <c469c74d-fa4e-b692-ff60-c41d8dcca68d@virtuozzo.com>
In-Reply-To: <c469c74d-fa4e-b692-ff60-c41d8dcca68d@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0501CA0013.eurprd05.prod.outlook.com
 (2603:10a6:3:1a::23) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190802194147305
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4cf333a1-61b9-4fd1-5fb7-08d7176850f9
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5050; 
x-ms-traffictypediagnostic: DB8PR08MB5050:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DB8PR08MB50509ED086F9EB661267EF03C1D90@DB8PR08MB5050.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 011787B9DD
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(396003)(346002)(39840400004)(136003)(366004)(189003)(199004)(5660300002)(6246003)(107886003)(66446008)(64756008)(66556008)(66476007)(66946007)(36756003)(31686004)(71190400001)(31696002)(6436002)(2906002)(446003)(68736007)(26005)(186003)(476003)(102836004)(53546011)(6506007)(486006)(2616005)(386003)(71200400001)(6512007)(966005)(11346002)(81156014)(478600001)(81166006)(8676002)(7736002)(53936002)(305945005)(8936002)(14454004)(6116002)(66066001)(3846002)(6306002)(4326008)(14444005)(25786009)(86362001)(54906003)(110136005)(316002)(76176011)(229853002)(6486002)(99286004)(52116002)(256004)(142923001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5050;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: dXcKBFao7FphweXwwJ4/1XQyaRDsyT9dPhSz9NkTXB4pgQbqJRKtwKT5Zikj6qinho5aUxg5X/gR905Uxqr124w0feD7owj+e5rhN772bJXnjcBp4l9GyzrYWCCyrCShtyTpgbOYHyz/Hwq4E7lz3GQyVxQgz/Jwu84anm0u5UF4O/h4Z2RMwYAoMLmoVne1tS3tCMsahkKVQ0NZdliqj86DYJGwHoQcihFsJKGWvlh2Z1vs73bdbv4od9QNOhaOlwnNgfc72r7Zjac75wuZWH+35fM3DBwCs54Zs5Z8VpXxio+UhvefdHB0FLE2BQtdP2Z54WY1G3ErePIWt2LPEXpSqPZ+UiXs/7zsIDlTegpChmuy5Bn+JZt8I8a/PuQ1VngVzGqgsos5r78DDBsAm5hf8nzj2q7mH5YkL3pGZxU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <39F6F10CFEDF4748B675FAC1DF3671D8@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cf333a1-61b9-4fd1-5fb7-08d7176850f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2019 16:41:50.0763 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5050
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.102
Subject: Re: [Qemu-devel] [PATCH v3 1/9] block: add
 .bdrv_need_rw_file_child_during_reopen_rw handler
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
Cc: "fam@euphon.net" <fam@euphon.net>, "jsnow@redhat.com" <jsnow@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDIuMDguMjAxOSAxOToyMywgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4g
MDIuMDguMjAxOSAxODo0MiwgS2V2aW4gV29sZiB3cm90ZToNCj4+IEFtIDMxLjA3LjIwMTkgdW0g
MTQ6MDkgaGF0IE1heCBSZWl0eiBnZXNjaHJpZWJlbjoNCj4+PiBPbiAyNS4wNy4xOSAxMToxOCwg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+Pj4gT24gcmVvcGVuIHRvIHJ3
IHBhcmVudCBtYXkgbmVlZCBydyBhY2Nlc3MgdG8gY2hpbGQgaW4gLnByZXBhcmUsIGZvcg0KPj4+
PiBleGFtcGxlIHFjb3cyIG5lZWRzIHRvIHdyaXRlIElOX1VTRSBmbGFncyBpbnRvIHN0b3JlZCBi
aXRtYXBzDQo+Pj4+IChjdXJyZW50bHkgaXQgaXMgZG9uZSBpbiBhIGhhY2t5IHdheSBhZnRlciBj
b21taXQgYW5kIGRvbid0IHdvcmspLg0KPj4+PiBTbywgbGV0J3MgaW50cm9kdWNlIHN1Y2ggbG9n
aWMuDQo+Pj4+DQo+Pj4+IFRoZSBkcmF3YmFjayBpcyB0aGF0IGluIHdvcnN0IGNhc2UgYmRydl9y
ZW9wZW5fc2V0X3JlYWRfb25seSBtYXkgZmluaXNoDQo+Pj4+IHdpdGggZXJyb3IgYW5kIGluIHNv
bWUgaW50ZXJtZWRpYXRlIHN0YXRlOiBzb21lIG5vZGVzIHJlb3BlbmVkIFJXIGFuZA0KPj4+PiBz
b21lIGFyZSBub3QuIEJ1dCB0aGlzIGlzIGEgd2F5IHRvIGZpeCBidWcgYXJvdW5kIHJlb3Blbmlu
ZyBxY293Mg0KPj4+PiBiaXRtYXBzIGluIHRoZSBmb2xsb3dpbmcgY29tbWl0cy4NCj4+Pg0KPj4+
IFRoaXMgY29tbWl0IG1lc3NhZ2UgZG9lc27igJl0IHJlYWxseSBleHBsYWluIHdoYXQgdGhpcyBw
YXRjaCBkb2VzLg0KPj4+DQo+Pj4+IFNpZ25lZC1vZmYtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1P
Z2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCj4+Pj4gLS0tDQo+Pj4+IMKgIGlu
Y2x1ZGUvYmxvY2svYmxvY2tfaW50LmggfMKgwqAgMiArDQo+Pj4+IMKgIGJsb2NrLmPCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAxNDQgKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKy0tLS0NCj4+Pj4gwqAgMiBmaWxlcyBjaGFuZ2VkLCAxMzMgaW5zZXJ0aW9u
cygrKSwgMTMgZGVsZXRpb25zKC0pDQo+Pj4+DQo+Pj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2Js
b2NrL2Jsb2NrX2ludC5oIGIvaW5jbHVkZS9ibG9jay9ibG9ja19pbnQuaA0KPj4+PiBpbmRleCAz
YWExZTgzMmE4Li43YmQ2ZmQ2OGRkIDEwMDY0NA0KPj4+PiAtLS0gYS9pbmNsdWRlL2Jsb2NrL2Js
b2NrX2ludC5oDQo+Pj4+ICsrKyBiL2luY2x1ZGUvYmxvY2svYmxvY2tfaW50LmgNCj4+Pj4gQEAg
LTUzMSw2ICs1MzEsOCBAQCBzdHJ1Y3QgQmxvY2tEcml2ZXIgew0KPj4+PiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdWludDY0X3Qg
cGFyZW50X3Blcm0sIHVpbnQ2NF90IHBhcmVudF9zaGFyZWQsDQo+Pj4+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1aW50NjRfdCAq
bnBlcm0sIHVpbnQ2NF90ICpuc2hhcmVkKTsNCj4+Pj4gK8KgwqDCoMKgIGJvb2wgKCpiZHJ2X25l
ZWRfcndfZmlsZV9jaGlsZF9kdXJpbmdfcmVvcGVuX3J3KShCbG9ja0RyaXZlclN0YXRlICpicyk7
DQo+Pj4+ICsNCj4+Pj4gwqDCoMKgwqDCoCAvKioNCj4+Pj4gwqDCoMKgwqDCoMKgICogQml0bWFw
cyBzaG91bGQgYmUgbWFya2VkIGFzICdJTl9VU0UnIGluIHRoZSBpbWFnZSBvbiByZW9wZW5pbmcg
aW1hZ2UNCj4+Pj4gwqDCoMKgwqDCoMKgICogYXMgcncuIFRoaXMgaGFuZGxlciBzaG91bGQgcmVh
bGl6ZSBpdC4gSXQgYWxzbyBzaG91bGQgdW5zZXQgcmVhZG9ubHkNCj4+Pj4gZGlmZiAtLWdpdCBh
L2Jsb2NrLmMgYi9ibG9jay5jDQo+Pj4+IGluZGV4IGNiZDhkYTVmM2IuLjNjOGUxYzU5YjQgMTAw
NjQ0DQo+Pj4+IC0tLSBhL2Jsb2NrLmMNCj4+Pj4gKysrIGIvYmxvY2suYw0KPj4+PiBAQCAtMTcx
NSwxMCArMTcxNSwxMiBAQCBzdGF0aWMgdm9pZCBiZHJ2X2dldF9jdW11bGF0aXZlX3Blcm0oQmxv
Y2tEcml2ZXJTdGF0ZSAqYnMsIHVpbnQ2NF90ICpwZXJtLA0KPj4+PiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHVpbnQ2NF90ICpzaGFyZWRfcGVybSk7DQo+Pj4+IMKgIHR5cGVkZWYgc3RydWN0IEJsb2Nr
UmVvcGVuUXVldWVFbnRyeSB7DQo+Pj4+IC3CoMKgwqDCoCBib29sIHByZXBhcmVkOw0KPj4+PiAt
wqDCoMKgwqAgYm9vbCBwZXJtc19jaGVja2VkOw0KPj4+PiAtwqDCoMKgwqAgQkRSVlJlb3BlblN0
YXRlIHN0YXRlOw0KPj4+PiAtwqDCoMKgwqAgUVNJTVBMRVFfRU5UUlkoQmxvY2tSZW9wZW5RdWV1
ZUVudHJ5KSBlbnRyeTsNCj4+Pj4gK8KgwqDCoCBib29sIHJlb3BlbmVkX2ZpbGVfY2hpbGRfcnc7
DQo+Pj4+ICvCoMKgwqAgYm9vbCBjaGFuZ2VkX2ZpbGVfY2hpbGRfcGVybV9ydzsNCj4+Pj4gK8Kg
wqDCoCBib29sIHByZXBhcmVkOw0KPj4+PiArwqDCoMKgIGJvb2wgcGVybXNfY2hlY2tlZDsNCj4+
Pj4gK8KgwqDCoCBCRFJWUmVvcGVuU3RhdGUgc3RhdGU7DQo+Pj4+ICvCoMKgwqAgUVNJTVBMRVFf
RU5UUlkoQmxvY2tSZW9wZW5RdWV1ZUVudHJ5KSBlbnRyeTsNCj4+Pj4gwqAgfSBCbG9ja1Jlb3Bl
blF1ZXVlRW50cnk7DQo+Pj4+IMKgIC8qDQo+Pj4+IEBAIC0zNDIxLDYgKzM0MjMsMTA1IEBAIEJs
b2NrUmVvcGVuUXVldWUgKmJkcnZfcmVvcGVuX3F1ZXVlKEJsb2NrUmVvcGVuUXVldWUgKmJzX3F1
ZXVlLA0KPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAga2VlcF9vbGRfb3B0cyk7DQo+Pj4+IMKgIH0NCj4+
Pj4gK3N0YXRpYyBpbnQgYmRydl9yZW9wZW5fc2V0X3JlYWRfb25seV9kcmFpbmVkKEJsb2NrRHJp
dmVyU3RhdGUgKmJzLA0KPj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBib29s
IHJlYWRfb25seSwNCj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgRXJyb3Ig
KiplcnJwKQ0KPj4+PiArew0KPj4+PiArwqDCoMKgIEJsb2NrUmVvcGVuUXVldWUgKnF1ZXVlOw0K
Pj4+PiArwqDCoMKgIFFEaWN0ICpvcHRzID0gcWRpY3RfbmV3KCk7DQo+Pj4+ICsNCj4+Pj4gK8Kg
wqDCoCBxZGljdF9wdXRfYm9vbChvcHRzLCBCRFJWX09QVF9SRUFEX09OTFksIHJlYWRfb25seSk7
DQo+Pj4+ICsNCj4+Pj4gK8KgwqDCoCBxdWV1ZSA9IGJkcnZfcmVvcGVuX3F1ZXVlKE5VTEwsIGJz
LCBvcHRzLCB0cnVlKTsNCj4+Pj4gKw0KPj4+PiArwqDCoMKgIHJldHVybiBiZHJ2X3Jlb3Blbl9t
dWx0aXBsZShxdWV1ZSwgZXJycCk7DQo+Pj4+ICt9DQo+Pj4+ICsNCj4+Pj4gKy8qDQo+Pj4+ICsg
KiBoYW5kbGVfcmVjdXJzaXZlX3Jlb3BlbnMNCj4+Pj4gKyAqDQo+Pj4+ICsgKiBPbiBmYWlsIGl0
IG5lZWRzIHJvbGxiYWNrX3JlY3Vyc2l2ZV9yZW9wZW5zIHRvIGJlIGNhbGxlZC4NCj4+Pg0KPj4+
IEl0IHdvdWxkIGJlIG5pY2UgaWYgdGhpcyBkZXNjcmlwdGlvbiBhY3R1YWxseSBzYWlkIGFueXRo
aW5nIGFib3V0IHdoYXQNCj4+PiB0aGUgZnVuY3Rpb24gaXMgc3VwcG9zZWQgdG8gZG8uDQo+Pj4N
Cj4+Pj4gKyAqLw0KPj4+PiArc3RhdGljIGludCBoYW5kbGVfcmVjdXJzaXZlX3Jlb3BlbnMoQmxv
Y2tSZW9wZW5RdWV1ZUVudHJ5ICpjdXJyZW50LA0KPj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBFcnJvciAq
KmVycnApDQo+Pj4+ICt7DQo+Pj4+ICvCoMKgwqAgaW50IHJldDsNCj4+Pj4gK8KgwqDCoCBCbG9j
a0RyaXZlclN0YXRlICpicyA9IGN1cnJlbnQtPnN0YXRlLmJzOw0KPj4+PiArDQo+Pj4+ICvCoMKg
wqAgLyoNCj4+Pj4gK8KgwqDCoMKgICogV2UgdXNlIHRoZSBmYWN0IHRoYXQgaW4gcmVvcGVuLXF1
ZXVlIGNoaWxkcmVuIGFyZSBhbHdheXMgZm9sbG93aW5nDQo+Pj4+ICvCoMKgwqDCoCAqIHBhcmVu
dHMuDQo+Pj4+ICvCoMKgwqDCoCAqIFRPRE86IFN3aXRjaCBCbG9ja1Jlb3BlblF1ZXVlIHRvIGJl
IFFUQUlMUSBhbmQgdXNlDQo+Pj4+ICvCoMKgwqDCoCAqwqDCoMKgwqDCoMKgIFFUQUlMUV9GT1JF
QUNIX1JFVkVSU0UuDQo+Pj4NCj4+PiBXaHkgZG9u4oCZdCB5b3UgZG8gdGhhdCBmaXJzdD/CoCBJ
dCB3b3VsZCBtYWtlIHRoZSBjb2RlIG1vcmUgb2J2aW91cyBhdA0KPj4+IGxlYXN0IHRvIG1lLg0K
Pj4+DQo+Pj4+ICvCoMKgwqDCoCAqLw0KPj4+PiArwqDCoMKgIGlmIChRU0lNUExFUV9ORVhUKGN1
cnJlbnQsIGVudHJ5KSkgew0KPj4+PiArwqDCoMKgwqDCoMKgwqAgcmV0ID0gaGFuZGxlX3JlY3Vy
c2l2ZV9yZW9wZW5zKFFTSU1QTEVRX05FWFQoY3VycmVudCwgZW50cnkpLCBlcnJwKTsNCj4+Pj4g
K8KgwqDCoMKgwqDCoMKgIGlmIChyZXQgPCAwKSB7DQo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHJldHVybiByZXQ7DQo+Pj4+ICvCoMKgwqDCoMKgwqDCoCB9DQo+Pj4+ICvCoMKgwqAgfQ0K
Pj4+PiArDQo+Pj4+ICvCoMKgwqAgaWYgKChjdXJyZW50LT5zdGF0ZS5mbGFncyAmIEJEUlZfT19S
RFdSKSAmJiBicy0+ZmlsZSAmJiBicy0+ZHJ2ICYmDQo+Pj4+ICvCoMKgwqDCoMKgwqDCoCBicy0+
ZHJ2LT5iZHJ2X25lZWRfcndfZmlsZV9jaGlsZF9kdXJpbmdfcmVvcGVuX3J3ICYmDQo+Pj4+ICvC
oMKgwqDCoMKgwqDCoCBicy0+ZHJ2LT5iZHJ2X25lZWRfcndfZmlsZV9jaGlsZF9kdXJpbmdfcmVv
cGVuX3J3KGJzKSkNCj4+Pj4gK8KgwqDCoCB7DQo+Pj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAoIWJk
cnZfaXNfd3JpdGFibGUoYnMtPmZpbGUtPmJzKSkgew0KPj4+PiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCByZXQgPSBiZHJ2X3Jlb3Blbl9zZXRfcmVhZF9vbmx5X2RyYWluZWQoYnMtPmZpbGUtPmJz
LCBmYWxzZSwgZXJycCk7DQo+Pj4NCj4+PiBIbS7CoCBTb3JyeSwgSSBmaW5kIHRoaXMgYWxsIGEg
Yml0IGhhcmQgdG8gdW5kZXJzdGFuZC7CoCAoTm8gY29tbWVudHMgYW5kDQo+Pj4gYWxsLikNCj4+
Pg0KPj4+IEkgdW5kZXJzdGFuZCB0aGF0IHRoaXMgaXMgZm9yIGFuIFJPIC0+IFJXIHRyYW5zaXRp
b24/wqAgRXZlcnl0aGluZyBpcw0KPj4+IHN0aWxsIFJPLCBidXQgdGhlIHBhcmVudCB3aWxsIG5l
ZWQgYW4gUlcgY2hpbGQgYmVmb3JlIGl0IHRyYW5zaXRpb25zIHRvDQo+Pj4gUlcgaXRzZWxmLg0K
Pj4+DQo+Pj4NCj4+PiBJ4oCZbSBnb2luZyB0byBiZSBob25lc3QgdXAgZnJvbnQsIEkgZG9u4oCZ
dCBsaWtlIHRoaXMgdmVyeSBtdWNoLsKgIEJ1dCBJDQo+Pj4gdGhpbmsgaXQgbWF5IGJlIGEgcmVh
c29uYWJsZSBzb2x1dGlvbiBmb3Igbm93Lg0KPj4+DQo+Pj4gQXMgSSByZW1lbWJlciwgdGhlIHBy
b2JsZW0gd2FzIHRoYXQgd2hlbiByZW9wZW5pbmcgYSBxY293MiBub2RlIGZyb20gUk8NCj4+PiB0
byBSVywgd2UgbmVlZCB0byB3cml0ZSBzb21ldGhpbmcgaW4gLnByZXBhcmUoKSAoYmVjYXVzZSBp
dCBjYW4gZmFpbCksDQo+Pj4gYnV0IG5hdHVyYWxseSBubyAucHJlcGFyZSgpIGlzIGNhbGxlZCBh
ZnRlciBhbnkgLmNvbW1pdCgpLCBzbyBubyBtYXR0ZXINCj4+PiB0aGUgb3JkZXIgb2Ygbm9kZXMg
aW4gdGhlIFJlb3BlblF1ZXVlLCB0aGUgY2hpbGQgbm9kZSB3aWxsIG5ldmVyIGJlIFJXDQo+Pj4g
YnkgdGhpcyBwb2ludC4NCj4+Pg0KPj4+IEhtLsKgIFRvIG1lIHRoYXQgbW9zdGx5IG1lYW5zIHRo
YXQgbWFraW5nIHRoZSB3aG9sZSByZW9wZW4gcHJvY2VzcyBhDQo+Pj4gdHJhbnNhY3Rpb24gd2Fz
IGp1c3QgYSBkcmVhbSB0aGF0IHR1cm5zIG91dCBub3QgdG8gd29yay4NCj4+DQo+PiBUaGlzIHBh
dGNoIGFscmVhZHkgbG9va3Mgc29tZXdoYXQgY29tcGxpY2F0ZWQgdG8gbWUsIGFuZCB3aGF0IHlv
dSdyZQ0KPj4gcHJvcG9zaW5nIGJlbG93IHNvdW5kcyBhbm90aGVyIG9yZGVyIG9mIG1hZ25pdHVk
ZSBtb3JlIGNvbXBsZXguDQo+IA0KPiBBZ3JlZSA6KSBIb3dldmVyLCBhdCB0aGlzIHBvaW50IEkn
dmUgYWxtb3N0IGltcGxlbWVudGVkIGl0IChpdCdzIG5vdCBhIHJlYXNvbg0KPiB0byBjaG9zZSBt
b3JlIGNvbXBsZXggd2F5LCBvZiBjb3Vyc2UpLg0KPiANCj4+DQo+PiBCdXQgSSB0aGluayB0aGUg
aW1wb3J0YW50IHBvaW50IGlzIHlvdXIgbGFzdCBzZW50ZW5jZSBhYm92ZS4gT25jZSB3ZQ0KPj4g
YWNrbm93bGVkZ2UgdGhhdCB3ZSBjYW4ndCBwb3NzaWJseSBtYWludGFpbiBmdWxsIHRyYW5zYWN0
aW9uIHNlbWFudGljcywNCj4+IEknbGwgYXNrIHRoaXMgbmFpdmUgcXVlc3Rpb246IFdoYXQgcHJl
dmVudHMgdXMgZnJvbSBqdXN0IGtlZXBpbmcgdGhlDQo+PiBhZGRpdGlvbmFsIHdyaXRlIGluIC5j
b21taXQ/DQo+IA0KPiBIbW0sIGl0J3Mgd2hhdCB3ZSd2ZSBzdGFydGVkIHdpdGguIFRoZSBvbmx5
IHRoaW5nIHRvIGRvIGlzIHRvIHJldmVyc2Ugb3JkZXINCj4gb2YgY29tbWl0cywgdG8gY29tbWl0
IGZpbGUgY2hpbGQgYmVmb3JlIHBhcmVudCAoYW5kIHRoaXMgd2F5IGl0IHdvcmtzIGluDQo+IFZp
cnR1b3p6byBub3cpLg0KPiBBbmQgSSBwcm9wb3NlZCBpdCBsb25nIGFnbzoNCj4gaHR0cHM6Ly9s
aXN0cy5nbnUub3JnL2FyY2hpdmUvaHRtbC9xZW11LWRldmVsLzIwMTgtMDYvbXNnMDQ1MjguaHRt
bA0KPiANCj4gDQo+Pg0KPj4gSXQgaXMgZXhwZWN0ZWQgdG8gd29yayBpbiB0aGUgY29tbW9uIGNh
c2UsIHNvIHdlJ3JlIG9ubHkgdGFsa2luZyBhYm91dA0KPj4gdGhlIGJlaGF2aW91ciBpbiBlcnJv
ciBjYXNlcyBhbnl3YXkuIElmIHNvbWV0aGluZyBmYWlscyBhbmQgd2UgY2FuJ3QgZG8NCj4+IHRo
aW5ncyBpbiBhIHRyYW5zYWN0aW9uYWJsZSB3YXksIHdlIG5lZWQgdG8gZGVjaWRlIHdoYXQgdGhl
IHN1cnByaXNlDQo+PiByZXN1bHQgd2lsbCBsb29rIGxpa2UsIGJlY2F1c2Ugd2UgY2FuIG5laXRo
ZXIgZ3VhcmFudGVlIGEgcm9sbGJhY2sgbm9yDQo+PiBzdWNjZXNzZnVsIGNvbXBsZXRpb24uDQo+
Pg0KPj4gSWYgdGhlIHdyaXRlIGZhaWxzIHVuZXhwZWN0ZWRseSwgYW5kIHdlIGVuZCB1cCB3aXRo
IGEgcWNvdzIgaW1hZ2UgdGhhdA0KPj4gaXMgb3BlbmVkIHIvdywgYnV0IGhhcyByZWFkLW9ubHkg
Yml0bWFwcyAtIHdvdWxkbid0IHRoYXQgYmUgYSByZWFzb25hYmxlDQo+PiByZXN1bHQ/IEl0IHNl
ZW1zIG11Y2ggZWFzaWVyIHRvIGV4cGxhaW4gdGhhbiBzb21lIGRlcGVuZGVuY3kgc3ViY2hhaW4N
Cj4+IGFscmVhZHkgYmVpbmcgY29tbWl0dGVkIGFuZCB0aGUgcmVzdCByb2xsZWQgYmFjay4NCj4g
DQo+IEFuZCB0aGlzIGlzIGhvdyBpdCB3b3JrcyBub3cgKGV4Y2VwdCBpdCBkb2Vzbid0IHdvcmsg
YmVjYXVzZSBvZiBjb21taXQgb3JkZXIpLg0KPiBJbiBvdXIgbG9uZyBhZ28gY29udmVyc2F0aW9u
IChsaW5rIGFib3ZlKSB5b3UgcG9pbnRlZCB0aGF0IHRoZSBwcm9ibGVtIGhlcmUNCj4gaXMgdGhh
dCB3ZSBkb24ndCByZXR1cm4gYW4gZXJyb3IgZnJvbSBhY3R1YWxseSBmYWlsZWQgY29tbWl0IGFu
ZCBpdCBpcw0KPiBpZ25vcmVkLi4NCj4gDQo+Pg0KPj4gU28sIEkgZ3Vlc3MgbXkgcXVlc3Rpb24g
aXMsIHdoYXQgaXMgdGhlIHNwZWNpZmMgc2NlbmFyaW8geW91J3JlIHRyeWluZw0KPj4gdG8gZml4
IHdpdGggdGhpcyBzZXJpZXMgKHdoeSBpc24ndCB0aGUgZmluYWwgcGF0Y2ggYSB0ZXN0IGNhc2Ug
dGhhdA0KPj4gd291bGQgYW5zd2VyIHRoaXMgcXVlc3Rpb24/KSwgYW5kIGFyZSB3ZSBzdXJlIHRo
YXQgdGhlIGN1cmUgaXNuJ3Qgd29yc2UNCj4+IHRoYW4gdGhlIGRpc2Vhc2U/DQo+Pg0KPiANCj4g
VGVzdCBhcHBlYXJzIGF0IDAzIGFuZCB0ZXN0cyB3aGF0IGFscmVhZHkgd29ya3MsIGFuZCBsYWNr
cyB0ZXN0LWNhc2VzIHdoaWNoDQo+IGFyZSBicm9rZW4sIGFuZCB0aGV5IGFyZSBhZGRlZCBpbiAw
OCB3aGVuIGFsbCBpcyBmaXhlZC4NCj4gDQo+IEFuZCBoZXJlIGFyZSB0d28gdGhpbmdzIHRvIGZp
eDoNCj4gRmlyc3QgaXMgdGhhdCB3ZSBsb3NlIGJpdG1hcHMgb24gcmVvcGVuaW5nIHRvIFJPIGFu
ZCBpdCBpcyBkZXNjcmliZWQgYW5kDQo+IGZpeGVkIGluIDA2Lg0KPiBTZWNvbmQgaXMgdGhhdCB3
ZSBjYW50IHNldCBJTl9VU0UgZmxhZyB3aGVuIHJlb3BlbmluZyB0byBSVyBhbmQgaXQgaXMgZml4
ZWQNCj4gZmluYWxseSBpbiAwOC4NCj4gDQo+IA0KPiA9PT09PQ0KPiANCj4gU28sIGlmIHdlIGRl
Y2lkZSB0byBrZWVwIHRoaW5ncyBzaW1wbGUsIHdoYXQgdG8gZG8/IEp1c3QgcmVvcmRlciBjb21t
aXRzIHRvDQo+IHNhdGlzZnkgZGVwZW5kZW5jaWVzLCBpZiBhbnk/DQo+IA0KPiBTaG91bGQgd2Ug
YWRkIHJldHVybiBjb2RlIHRvIGNvbW1pdCwgd2hpY2ggc2hvdWxkIGFsd2F5cyBiZSAwIGV4Y2Vw
dCB2ZXJ5IHJhcmUNCj4gY2FzZT8NCj4gDQo+IA0KDQoNCkFuZCBhbm90aGVyIGlkZWEgaXMgdG8g
cG9zdHBvbmUgSU5fVVNFIHNldHRpbmcgdW50aWwgd2UgcmVhbGx5IG5lZWQgdG8gbW9kaWZ5IHRo
ZQ0KYml0bWFwLi4gTm90IHN1cmUgdGhhdCBpdCBpcyBzaW1wbGVyLg0KDQotLSANCkJlc3QgcmVn
YXJkcywNClZsYWRpbWlyDQo=

