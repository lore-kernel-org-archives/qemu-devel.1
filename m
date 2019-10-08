Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0882C10F14
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 09:24:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B98E20673
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 09:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="HclnGGZQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B98E20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHljY-00053o-M6
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 05:24:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35151)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iHlfk-0001SQ-8x
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 05:20:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iHlfe-00039q-PC
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 05:20:47 -0400
Received: from mail-am5eur02on070b.outbound.protection.outlook.com
 ([2a01:111:f400:fe07::70b]:30273
 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iHlfd-000369-CV; Tue, 08 Oct 2019 05:20:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i0Z4m4zcXoX9s1KzzPOyKkWhmCrumMeMlJe0BNhr9SWIFH+6p40qnT//OGhDSfXzkzvyjFLmGmw/NtfhzDCMUNMLnl5N/WBqunDesGKi2N0Cl8YSXjUpWxMWSU/WPgRSESgDvpKLpulINUT12AkD7WETYaUu0o4jOkKb6MNwSmPXBAcCK3qcc2nQx4+p5njPpQnEZJ5fUztVLxyDTFTtR2rNFWTu5S5M4q9qAmjOKOqRb5a/5Ugo0/GIVlzYyAMCuafwBBZ6OD0+8qwSL5AUy76VPbnQdH8Ej3nIw3QA2BVx8FhhKIXRACYQ1fjnetr1E8Q26vy2Y9MDSx48eXhrHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uLovW45aj7zbM2wlTexsbzUwsDfDKAzKKe45rj/dm1k=;
 b=CmCy/QDfBoKW0CrapV+fip9xWSGYs27Yx0KXmhQEjZ8oNDT0Sb6M+X3i94aaRvUSMsYmOEPpAfOqnpckLQ27BDbFZnwPlan8n2ZYAW3WO/2rkU1DqzGg1OSmGyAGQWOno8BOIB5qSrZd6Z1bTrxuf7EF8nosG67cELBs3Y56j0qAcoSFPySuYgZuaht2N9U1Z0QQL6GzhnG4FpxPAoCR/lC8aswL94sHKFJKuQzY4eSHNSk+WDxtEjmxnCCYwHM/Tgzvuw3O9TR+DYjK4peU8MvPstt0H8CLS3foz65aulXmUWxbzjMzdhJh6S4ltZMh2WFtmaACh01knudMCDA/wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uLovW45aj7zbM2wlTexsbzUwsDfDKAzKKe45rj/dm1k=;
 b=HclnGGZQUD+mOMe40V3yXwjm6aWtK+Ktjbpy09QFjMf642n5i2Y/L5vSBatdV2QeQ3FHX5mad62cCCAXfmt0UfM7KNHkkzwVKNrwNThoz2McUE14efXKoNTYwW8lnIT4SvoU+KnGlY9Um0jJfZ0QsIstCFypceAYYp68I7YZr+k=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5387.eurprd08.prod.outlook.com (52.133.241.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Tue, 8 Oct 2019 09:20:38 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f%2]) with mapi id 15.20.2327.023; Tue, 8 Oct 2019
 09:20:38 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH 5/6] block/block-copy: add memory limit
Thread-Topic: [PATCH 5/6] block/block-copy: add memory limit
Thread-Index: AQHVeg4yoh/rEPB1r0SkNCk9cwC6DKdPU0UAgAAc4QCAAQodgIAAA2kAgAABf4A=
Date: Tue, 8 Oct 2019 09:20:38 +0000
Message-ID: <bba9ff14-7550-7dfa-8908-bfb50d015891@virtuozzo.com>
References: <20191003171539.12327-1-vsementsov@virtuozzo.com>
 <20191003171539.12327-6-vsementsov@virtuozzo.com>
 <8aa011d7-3f11-2df5-d77e-5c5176ab63ed@redhat.com>
 <49b99621-2d8a-f4a8-d31a-e64a727952a9@virtuozzo.com>
 <8bd41e8a-acfb-8f55-b2d3-ae909dc21ae7@redhat.com>
 <c6cfb56c-970d-ab44-ee93-639c65370dc2@virtuozzo.com>
In-Reply-To: <c6cfb56c-970d-ab44-ee93-639c65370dc2@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0184.eurprd05.prod.outlook.com
 (2603:10a6:3:f8::32) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191008122035585
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 81659ae7-70b7-411a-422c-08d74bd0c825
x-ms-traffictypediagnostic: DB8PR08MB5387:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB53877022ED2BABBF6AB63F7CC19A0@DB8PR08MB5387.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:55;
x-forefront-prvs: 01842C458A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(376002)(39840400004)(136003)(366004)(396003)(199004)(189003)(7736002)(86362001)(186003)(316002)(4326008)(36756003)(3846002)(6116002)(66476007)(66946007)(26005)(66556008)(110136005)(8936002)(66446008)(64756008)(31696002)(53546011)(6506007)(99286004)(31686004)(102836004)(81166006)(386003)(81156014)(476003)(2616005)(11346002)(446003)(305945005)(486006)(52116002)(76176011)(8676002)(2501003)(229853002)(6512007)(6246003)(561944003)(14454004)(54906003)(256004)(107886003)(14444005)(2906002)(6486002)(66066001)(478600001)(6436002)(5660300002)(25786009)(71200400001)(71190400001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5387;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: en0dDRJeA3Ko7z2Ms9IaoVy/ePLUQorZHnQRUaVjGp8HhyU5pYo86CXvUZtLTr+NzMEqusZIhrWXRk4uNNYkOr7VkRCgZRYzHq/TL5aFEaupCHvvJMma6UoCYP+KjjuD/ud/foEu4jadHl4dKsjHFYD8dh6a8tUf/3QDg3Racw1XEKLM3jko6OJ8kr6Ifm5+pnrV7oltxHN0RdhlslRY0tLrOP3W7HWKfHhD7SJnNQmpGz+ogilwAa1WYcb9FlHwsNy8YO7EGnucRBgqXvWfvAx601GY94Wumht1K1BLWnLGWZXfTk0+S5itPmde66awrBSUsficWmW21Z/GxdPCipAf5+7JzLKaf34guO6hiJvnKHjHcoJsgUMxMaRGRUcY0I12erpWbgKCRcxTPOKuJM82USy5G1FMWJAwLmt6TW4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0D529E51FBB3FA43A3540DDA526BE692@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81659ae7-70b7-411a-422c-08d74bd0c825
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2019 09:20:38.0751 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HSCD/nPMgGvIErj4EV+sD8Lnuc88eccUMIvfg8srruPDRRRdcaPXjcQ0aV/4Eiot/QmDxW1polkz0hpxw+zuuhJrKQdV4n69CyyohgnsAkg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5387
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe07::70b
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

MDguMTAuMjAxOSAxMjoxNSwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4g
MDguMTAuMjAxOSAxMjowMywgTWF4IFJlaXR6IHdyb3RlOg0KPj4gT24gMDcuMTAuMTkgMTk6MTAs
IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgd3JvdGU6DQo+Pj4gMDcuMTAuMjAxOSAxODoy
NywgTWF4IFJlaXR6IHdyb3RlOg0KPj4+PiBPbiAwMy4xMC4xOSAxOToxNSwgVmxhZGltaXIgU2Vt
ZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+Pj4+IEN1cnJlbnRseSB0b3RhbCBhbGxvY2F0aW9u
IGZvciBwYXJhbGxlbCByZXF1ZXN0cyB0byBibG9jay1jb3B5IGluc3RhbmNlDQo+Pj4+PiBpcyB1
bmxpbWl0ZWQuIExldCdzIGxpbWl0IGl0IHRvIDEyOCBNaUIuDQo+Pj4+Pg0KPj4+Pj4gRm9yIG5v
dyBibG9jay1jb3B5IGlzIHVzZWQgb25seSBpbiBiYWNrdXAsIHNvIGFjdHVhbGx5IHdlIGxpbWl0
IHRvdGFsDQo+Pj4+PiBhbGxvY2F0aW9uIGZvciBiYWNrdXAgam9iLg0KPj4+Pj4NCj4+Pj4+IFNp
Z25lZC1vZmYtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmly
dHVvenpvLmNvbT4NCj4+Pj4+IC0tLQ0KPj4+Pj4gwqDCoCBpbmNsdWRlL2Jsb2NrL2Jsb2NrLWNv
cHkuaCB8IDMgKysrDQo+Pj4+PiDCoMKgIGJsb2NrL2Jsb2NrLWNvcHkuY8KgwqDCoMKgwqDCoMKg
wqAgfCA1ICsrKysrDQo+Pj4+PiDCoMKgIDIgZmlsZXMgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCsp
DQo+Pj4+Pg0KPj4+Pj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvYmxvY2svYmxvY2stY29weS5oIGIv
aW5jbHVkZS9ibG9jay9ibG9jay1jb3B5LmgNCj4+Pj4+IGluZGV4IGUyZTEzNWZmMWIuLmJiNjY2
ZTcwNjggMTAwNjQ0DQo+Pj4+PiAtLS0gYS9pbmNsdWRlL2Jsb2NrL2Jsb2NrLWNvcHkuaA0KPj4+
Pj4gKysrIGIvaW5jbHVkZS9ibG9jay9ibG9jay1jb3B5LmgNCj4+Pj4+IEBAIC0xNiw2ICsxNiw3
IEBADQo+Pj4+PiDCoMKgICNkZWZpbmUgQkxPQ0tfQ09QWV9IDQo+Pj4+PiDCoMKgICNpbmNsdWRl
ICJibG9jay9ibG9jay5oIg0KPj4+Pj4gKyNpbmNsdWRlICJxZW11L2NvLXNoYXJlZC1hbW91bnQu
aCINCj4+Pj4+IMKgwqAgdHlwZWRlZiBzdHJ1Y3QgQmxvY2tDb3B5SW5GbGlnaHRSZXEgew0KPj4+
Pj4gwqDCoMKgwqDCoMKgIGludDY0X3Qgc3RhcnRfYnl0ZTsNCj4+Pj4+IEBAIC02OSw2ICs3MCw4
IEBAIHR5cGVkZWYgc3RydWN0IEJsb2NrQ29weVN0YXRlIHsNCj4+Pj4+IMKgwqDCoMKgwqDCoMKg
ICovDQo+Pj4+PiDCoMKgwqDCoMKgwqAgUHJvZ3Jlc3NSZXNldENhbGxiYWNrRnVuYyBwcm9ncmVz
c19yZXNldF9jYWxsYmFjazsNCj4+Pj4+IMKgwqDCoMKgwqDCoCB2b2lkICpwcm9ncmVzc19vcGFx
dWU7DQo+Pj4+PiArDQo+Pj4+PiArwqDCoMKgIFFlbXVDb1NoYXJlZEFtb3VudCAqbWVtOw0KPj4+
Pj4gwqDCoCB9IEJsb2NrQ29weVN0YXRlOw0KPj4+Pj4gwqDCoCBCbG9ja0NvcHlTdGF0ZSAqYmxv
Y2tfY29weV9zdGF0ZV9uZXcoQmRydkNoaWxkICpzb3VyY2UsIEJkcnZDaGlsZCAqdGFyZ2V0LA0K
Pj4+Pj4gZGlmZiAtLWdpdCBhL2Jsb2NrL2Jsb2NrLWNvcHkuYyBiL2Jsb2NrL2Jsb2NrLWNvcHku
Yw0KPj4+Pj4gaW5kZXggY2M0OWQyMzQ1ZC4uZTcwMGMyMGQwZiAxMDA2NDQNCj4+Pj4+IC0tLSBh
L2Jsb2NrL2Jsb2NrLWNvcHkuYw0KPj4+Pj4gKysrIGIvYmxvY2svYmxvY2stY29weS5jDQo+Pj4+
PiBAQCAtMjEsNiArMjEsNyBAQA0KPj4+Pj4gwqDCoCAjaW5jbHVkZSAicWVtdS91bml0cy5oIg0K
Pj4+Pj4gwqDCoCAjZGVmaW5lIEJMT0NLX0NPUFlfTUFYX0NPUFlfUkFOR0UgKDE2ICogTWlCKQ0K
Pj4+Pj4gKyNkZWZpbmUgQkxPQ0tfQ09QWV9NQVhfTUVNICgxMjggKiBNaUIpDQo+Pj4+PiDCoMKg
IHN0YXRpYyB2b2lkIGNvcm91dGluZV9mbiBibG9ja19jb3B5X3dhaXRfaW5mbGlnaHRfcmVxcyhC
bG9ja0NvcHlTdGF0ZSAqcywNCj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpbnQ2NF90IHN0YXJ0LA0KPj4+Pj4gQEAgLTY0LDYg
KzY1LDcgQEAgdm9pZCBibG9ja19jb3B5X3N0YXRlX2ZyZWUoQmxvY2tDb3B5U3RhdGUgKnMpDQo+
Pj4+PiDCoMKgwqDCoMKgwqAgfQ0KPj4+Pj4gwqDCoMKgwqDCoMKgIGJkcnZfcmVsZWFzZV9kaXJ0
eV9iaXRtYXAocy0+c291cmNlLT5icywgcy0+Y29weV9iaXRtYXApOw0KPj4+Pj4gK8KgwqDCoCBx
ZW11X2NvX3NoYXJlZF9hbW91bnRfZnJlZShzLT5tZW0pOw0KPj4+Pj4gwqDCoMKgwqDCoMKgIGdf
ZnJlZShzKTsNCj4+Pj4+IMKgwqAgfQ0KPj4+Pj4gQEAgLTk1LDYgKzk3LDcgQEAgQmxvY2tDb3B5
U3RhdGUgKmJsb2NrX2NvcHlfc3RhdGVfbmV3KEJkcnZDaGlsZCAqc291cmNlLCBCZHJ2Q2hpbGQg
KnRhcmdldCwNCj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgIC5jbHVzdGVyX3NpemUgPSBjbHVz
dGVyX3NpemUsDQo+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoCAubGVuID0gYmRydl9kaXJ0eV9i
aXRtYXBfc2l6ZShjb3B5X2JpdG1hcCksDQo+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoCAud3Jp
dGVfZmxhZ3MgPSB3cml0ZV9mbGFncywNCj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCAubWVtID0gcWVt
dV9jb19zaGFyZWRfYW1vdW50X25ldyhCTE9DS19DT1BZX01BWF9NRU0pLA0KPj4+Pj4gwqDCoMKg
wqDCoMKgIH07DQo+Pj4+PiDCoMKgwqDCoMKgwqAgcy0+Y29weV9yYW5nZV9zaXplID0gUUVNVV9B
TElHTl9ET1dOKG1heF90cmFuc2ZlciwgY2x1c3Rlcl9zaXplKSwNCj4+Pj4+IEBAIC0zMTYsNyAr
MzE5LDkgQEAgaW50IGNvcm91dGluZV9mbiBibG9ja19jb3B5KEJsb2NrQ29weVN0YXRlICpzLA0K
Pj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqAgYmRydl9yZXNldF9kaXJ0eV9iaXRtYXAocy0+Y29w
eV9iaXRtYXAsIHN0YXJ0LCBjaHVua19lbmQgLSBzdGFydCk7DQo+Pj4+PiArwqDCoMKgwqDCoMKg
wqAgcWVtdV9jb19nZXRfYW1vdW50KHMtPm1lbSwgY2h1bmtfZW5kIC0gc3RhcnQpOw0KPj4+Pg0K
Pj4+PiBOb3cgdGhhdCBJIHNlZSBpdCBsaWtlIHRoaXMsIG1heWJlIHRoZSBuYW1lIGlzIHRvbyBz
aG9ydC7CoCBUaGlzIHNvdW5kcw0KPj4+PiBsaWtlIGl0IHdhcyB0cnlpbmcgdG8gZ2V0IHNvbWUg
YW1vdW50IG9mIGNvcm91dGluZXMuDQo+Pj4+DQo+Pj4+IFdvdWxkIOKAnHFlbXVfY29fZ2V0X2Zy
b21fc2hhcmVkX2Ftb3VudOKAnSBiZSB0b28gbG9uZz/CoCAoU29tZXRoaW5nIGxpa2UNCj4+Pj4g
cWVtdV9jb19zaGFtX2FsbG9jKCkgd291bGQgYmUgZnVubnksIGJ1dCBtYXliZSBub3QuwqAgOi0p
wqAgT3IgbWF5YmUNCj4+Pj4gZXhhY3RseSBiZWNhdXNlIGl04oCdcyBmdW5ueS4pDQo+Pj4+DQo+
Pj4NCj4+PiBobW0gc2hhbSBtYXkgYmUgaW50ZXJwcmV0ZWQgYXMgc2hhcmVkIG1lbW9yeSwgbm90
IG9ubHkgbGlrZSBzaGFtZS4uDQo+Pg0KPj4g4oCcc2hhbeKAnSBpcyBhbHNvIGEgd29yZCBieSBp
dHNlbGYuIDotKQ0KPiANCj4gSG1tIGRpZG4ndCBrbm93LCBtZSBnbyB0byBnb29nbGUgdHJhbnNs
YXRlLiBPSywgc2hhbSBsb29rcyBhIGxvdCBuaWNlciB0aGFuIHNoYW1lKQ0KPiANCj4+DQo+Pj4g
QW5kIGlmIHdlIGNhbGwgaXQgX2FsbG9jLCB0aGUgb3Bwb3NpdGUgc2hvdWxkIGJlIF9mcmVlLCBi
dXQgaG93IHRvDQo+Pj4gZGlzdGluZ3Vpc2ggaXQgZnJvbSBmcmVlaW5nIHRoZSB3aG9sZSBvYmpl
Y3Q/IEhtbSwgdXNlIGNyZWF0ZS9kZXN0cm95IGZvcg0KPj4+IHRoZSB3aG9sZSBvYmplY3QgbWF5
YmUuDQo+Pj4NCj4+PiBNYXkgYmUsIGRyb3AgInFlbXVfIiA/IEl0J3Mgbm90IHZlcnkgaW5mb3Jt
YXRpdmUuIE9yIG1heSBiZSBkcm9wICJjb18iPy4NCj4+Pg0KPj4+IEkgZG9uJ3QgbGlrZSBzaGFt
aW5nIG15IHNoYXJlZCBhbW91bnQgOikNCj4+DQo+PiBJdOKAmXMgd29yc2UgY2FsbGluZyBpdCBh
bGwgYSBzaGFtLg0KPj4NCj4+PiBNYXkgYmUsIHdlIHNob3VsZCBpbWFnaW5lLCB3aGF0IGFyZSB3
ZSBhbGxvY2F0aW5nPyBNYXkgYmUgYmFsbHM/DQo+Pj4NCj4+PiBzdHJ1Y3QgQmFsbEFsbG9jYXRv
cg0KPj4+DQo+Pj4gYmFsbF9hbGxvY2F0b3JfY3JlYXRlDQo+Pj4gYmFsbF9hbGxvY2F0b3JfZGVz
dHJveQ0KPj4+DQo+Pj4gY29fdHJ5X2FsbG9jX2JhbGxzDQo+Pj4gY29fYWxsb2NfYmFsbHMNCj4+
PiBjb19mcmVlX2JhbGxzDQo+Pj4NCj4+PiBPciBiYXJzPyBPciB3aGljaCB0aGluZyBtYXkgYmUg
dXNlZCBmb3IgZnVubnkgbmFtaW5nIGFuZCB0byBub3QgaW50ZXJzZWN0DQo+Pj4gd2l0aCBleGlz
dGluZyBjb25jZXB0cyBsaWtlIG1lbW9yeT8NCj4+DQo+PiBJIGxvdmUgaXQgKHRoYW5rcyBmb3Ig
bWFraW5nIG15IG1vcm5pbmcpLCBidXQgSSBmZWFyIGl0IG1heSBiZQ0KPj4gaW50ZXJwcmV0ZWQg
YXMgcmlzcXXDqS4NCj4+DQo+PiBNYXliZSBqdXN0IHNocmVzIGZvciBzaGFyZWQgcmVzb3VyY2U/
wqAgU28gYWxsb2NfZnJvbV9zaHJlcz8NCj4+DQo+IA0KPiBPSyBmb3IgbWUuIEJ1dC4uIEhvdyB0
byBuYW1lIF9mcmVlIGZ1bmN0aW9uIHRoYW4/DQo+IA0KPiBzdHJ1Y3QgU2hhcmVkUmVzb3VyY2UN
Cj4gDQo+IHNocmVzX2NyZWF0ZQ0KPiBzaHJlc19kZXN0cm95DQo+IA0KPiBjb190cnlfYWxsb2Nf
ZnJvbV9zaHJlcw0KPiBjb19hbGxvY19mcm9tX3NocmVzDQo+IGNvX2ZyZWVfPz8/DQo+IA0KPiBj
b19mcmVlX3Jlc19hbGxvY2VkX2Zyb21fc2hyZXMgPyA6KQ0KPiANCj4gb3INCj4gDQo+IGNvX3Ry
eV9nZXRfZnJvbV9zaHJlcw0KPiBjb19nZXRfZnJvbV9zaHJlcw0KPiBjb19wdXRfdG9fc2hyZXMN
Cj4gDQoNCg0KQW5vdGhlciBwcm9wb3NhbCBmcm9tIFJvbWE6IHVzZSAiYnVkZ2V0IiB3b3JkLg0K
DQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

