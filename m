Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D9EC43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 09:51:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9824720665
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 09:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Wv3fXPn7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9824720665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57604 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heGD0-0003QZ-Tf
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 05:51:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50699)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1heG6i-0000D3-6t
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 05:45:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1heG6f-000691-4s
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 05:45:20 -0400
Received: from mail-eopbgr20137.outbound.protection.outlook.com
 ([40.107.2.137]:1131 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1heG6Y-000668-6X; Fri, 21 Jun 2019 05:45:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h3fr5FKdwiIphBV5BE0tad6/fQVYo5VpPO7T8XDJBa8=;
 b=Wv3fXPn7gbMPfvLPmzEs0IIMoNMoleLtXEKTOFXrxpXV8CCsV+1ktLtUnwx9IuSONedisYwO8qqLie6lSz43pfoTF6t3G6Lhc68BiLTQ7TuaOCHHacIp3z1fXsS4IC3oBejHLy0CtpHsByGOBTv0zY2wEUbZYu5MuhLduTk7KYA=
Received: from DBBPR08MB4838.eurprd08.prod.outlook.com (20.179.46.151) by
 DBBPR08MB4774.eurprd08.prod.outlook.com (20.179.45.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.12; Fri, 21 Jun 2019 09:45:07 +0000
Received: from DBBPR08MB4838.eurprd08.prod.outlook.com
 ([fe80::9c49:321c:cc13:35d3]) by DBBPR08MB4838.eurprd08.prod.outlook.com
 ([fe80::9c49:321c:cc13:35d3%3]) with mapi id 15.20.1987.014; Fri, 21 Jun 2019
 09:45:07 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: zhenwei pi <pizhenwei@bytedance.com>, "kwolf@redhat.com"
 <kwolf@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>
Thread-Topic: [PATCH 1/3] block/accounting: rename struct BlockLatencyHistogram
Thread-Index: AQHVJ0XOeToDK/4TIkSDivAuvr+E16al3XaA
Date: Fri, 21 Jun 2019 09:45:07 +0000
Message-ID: <3c68d669-fce2-0047-2b2a-a153cdaa9f5c@virtuozzo.com>
References: <1561020872-6214-1-git-send-email-pizhenwei@bytedance.com>
 <1561020872-6214-2-git-send-email-pizhenwei@bytedance.com>
In-Reply-To: <1561020872-6214-2-git-send-email-pizhenwei@bytedance.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0270.eurprd05.prod.outlook.com
 (2603:10a6:3:fc::22) To DBBPR08MB4838.eurprd08.prod.outlook.com
 (2603:10a6:10:d9::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190621124505116
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 73e9ce6b-cf77-4d0b-900f-08d6f62d24d6
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DBBPR08MB4774; 
x-ms-traffictypediagnostic: DBBPR08MB4774:
x-microsoft-antispam-prvs: <DBBPR08MB47740A8DDB6A3E011E8C1213C1E70@DBBPR08MB4774.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0075CB064E
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(376002)(366004)(346002)(39850400004)(396003)(199004)(189003)(2616005)(186003)(8936002)(31696002)(102836004)(229853002)(68736007)(26005)(66556008)(71200400001)(36756003)(71190400001)(6512007)(476003)(73956011)(5660300002)(2201001)(31686004)(2906002)(3846002)(386003)(64756008)(446003)(6506007)(11346002)(76176011)(54906003)(6116002)(52116002)(66946007)(7736002)(256004)(14454004)(110136005)(478600001)(6246003)(4326008)(66446008)(15650500001)(305945005)(486006)(66476007)(6486002)(316002)(86362001)(6436002)(99286004)(81156014)(14444005)(66066001)(2501003)(81166006)(53936002)(8676002)(25786009);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DBBPR08MB4774;
 H:DBBPR08MB4838.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: EMwROSO1xDx9tx6ec7k3mmJV9bgqXGlK1j59hPKHxyQP7oYCGOytEtN6vfEeR7CO749WwtSsho3L6DStIwDU32iiic/JwcfRdBtr9iuXwl2ixcwIdKQTTGcIO5x3lHGCtLl9gdpFGZgqqkASUS9NwXrEApGlz/TYkdzakg8g4YTnFwVX80Mn0lCwP8rjeaCNV8g5atJCdqUn7nY7FmjzvfLURETjNOn1lsVdoi3Yi4m8JxNtHf0iz9+n9fnyfY0Omi0DcOXKKAFjl7u0hohxZjgdErtCp8/Y4rN0/kasH+ZdKBpe3NslcY0F6eYRRE+7Q9i3YMu215Ra0sWBPF8Di5Vj/CO8EVrTyvWumqMu7N3N8WR52PotXCDiwJL2GRVWjNF69S4a2r1cIxb57cf8iKwIJcQ0/aCS5vOE7Sjyons=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F6543C8C0FB647419A965E4BC40759AF@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73e9ce6b-cf77-4d0b-900f-08d6f62d24d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2019 09:45:07.4874 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4774
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.2.137
Subject: Re: [Qemu-devel] [PATCH 1/3] block/accounting: rename struct
 BlockLatencyHistogram
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
Cc: "fam@euphon.net" <fam@euphon.net>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjAuMDYuMjAxOSAxMTo1NCwgemhlbndlaSBwaSB3cm90ZToNCj4gUmVuYW1lIHN0cnVjdCBCbG9j
a0xhdGVuY3lIaXN0b2dyYW0gdG8gQmxvY2tIaXN0b2dyYW0sIGFuZCByZW5hbWUNCj4gcmVsYXRl
ZCBmdW5jdGlvbnMgbmFtZS4NCj4gbWFrZSB0aGlzIHN0cnVjdCBhbmQgZnVuY3Rpb25zIGJlIGNv
bW1vbiwgdGhleSBjYW4gYmUgdXNlZCB3aWRlbHkuDQoNCkhtbSwgd2UgY2FuIGdvIGZ1cnRoZXIs
IGFuZCBtYWtlIGl0IGp1c3QgSGlzdG9ncmFtIGFuZCBtb3ZlIHRvIHNlcGFyYXRlIGZpbGUsDQph
cyB0aGVyZSBpcyBub3RoaW5nIGFjdHVhbGx5IGFib3V0IGJsb2NrLWxheWVyIGluc2lkZSBpdC4g
QnV0IGl0IG1heSBiZSBkb25lDQpsYXRlciBvZiBjb3Vyc2UsIEknbSBPSyB3aXRoIHRoaXMgdG9v
Lg0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiB6aGVud2VpIHBpIDxwaXpoZW53ZWlAYnl0ZWRhbmNl
LmNvbT4NCj4gLS0tDQo+ICAgYmxvY2svYWNjb3VudGluZy5jICAgICAgICAgfCAzMSArKysrKysr
KysrKysrKysrKystLS0tLS0tLS0tLS0tDQo+ICAgYmxvY2svcWFwaS5jICAgICAgICAgICAgICAg
fCAgMiArLQ0KPiAgIGluY2x1ZGUvYmxvY2svYWNjb3VudGluZy5oIHwgIDggKysrKy0tLS0NCj4g
ICAzIGZpbGVzIGNoYW5nZWQsIDIzIGluc2VydGlvbnMoKyksIDE4IGRlbGV0aW9ucygtKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2Jsb2NrL2FjY291bnRpbmcuYyBiL2Jsb2NrL2FjY291bnRpbmcuYw0K
PiBpbmRleCA3MGEzZDlhNDI2Li5iYjgxNDhiNmIxIDEwMDY0NA0KPiAtLS0gYS9ibG9jay9hY2Nv
dW50aW5nLmMNCj4gKysrIGIvYmxvY2svYWNjb3VudGluZy5jDQo+IEBAIC05NCwxMyArOTQsMTMg
QEAgdm9pZCBibG9ja19hY2N0X3N0YXJ0KEJsb2NrQWNjdFN0YXRzICpzdGF0cywgQmxvY2tBY2N0
Q29va2llICpjb29raWUsDQo+ICAgICAgIGNvb2tpZS0+dHlwZSA9IHR5cGU7DQo+ICAgfQ0KPiAg
IA0KPiAtLyogYmxvY2tfbGF0ZW5jeV9oaXN0b2dyYW1fY29tcGFyZV9mdW5jOg0KPiArLyogYmxv
Y2tfaGlzdG9ncmFtX2NvbXBhcmVfZnVuYzoNCj4gICAgKiBDb21wYXJlIEBrZXkgd2l0aCBpbnRl
cnZhbCBbQGl0WzBdLCBAaXRbMV0pLg0KPiAgICAqIFJldHVybjogLTEgaWYgQGtleSA8IEBpdFsw
XQ0KPiAgICAqICAgICAgICAgIDAgaWYgQGtleSBpbiBbQGl0WzBdLCBAaXRbMV0pDQo+ICAgICog
ICAgICAgICArMSBpZiBAa2V5ID49IEBpdFsxXQ0KPiAgICAqLw0KPiAtc3RhdGljIGludCBibG9j
a19sYXRlbmN5X2hpc3RvZ3JhbV9jb21wYXJlX2Z1bmMoY29uc3Qgdm9pZCAqa2V5LCBjb25zdCB2
b2lkICppdCkNCj4gK3N0YXRpYyBpbnQgYmxvY2tfaGlzdG9ncmFtX2NvbXBhcmVfZnVuYyhjb25z
dCB2b2lkICprZXksIGNvbnN0IHZvaWQgKml0KQ0KPiAgIHsNCj4gICAgICAgdWludDY0X3QgayA9
ICoodWludDY0X3QgKilrZXk7DQo+ICAgICAgIHVpbnQ2NF90IGEgPSAoKHVpbnQ2NF90ICopaXQp
WzBdOw0KPiBAQCAtMTA5LDggKzEwOSw3IEBAIHN0YXRpYyBpbnQgYmxvY2tfbGF0ZW5jeV9oaXN0
b2dyYW1fY29tcGFyZV9mdW5jKGNvbnN0IHZvaWQgKmtleSwgY29uc3Qgdm9pZCAqaXQpDQo+ICAg
ICAgIHJldHVybiBrIDwgYSA/IC0xIDogKGsgPCBiID8gMCA6IDEpOw0KPiAgIH0NCj4gICANCj4g
LXN0YXRpYyB2b2lkIGJsb2NrX2xhdGVuY3lfaGlzdG9ncmFtX2FjY291bnQoQmxvY2tMYXRlbmN5
SGlzdG9ncmFtICpoaXN0LA0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBpbnQ2NF90IGxhdGVuY3lfbnMpDQo+ICtzdGF0aWMgdm9pZCBibG9ja19oaXN0b2dy
YW1fYWNjb3VudChCbG9ja0hpc3RvZ3JhbSAqaGlzdCwgaW50NjRfdCB2YWwpDQo+ICAgew0KPiAg
ICAgICB1aW50NjRfdCAqcG9zOw0KPiAgIA0KPiBAQCAtMTIwLDI4ICsxMTksMjYgQEAgc3RhdGlj
IHZvaWQgYmxvY2tfbGF0ZW5jeV9oaXN0b2dyYW1fYWNjb3VudChCbG9ja0xhdGVuY3lIaXN0b2dy
YW0gKmhpc3QsDQo+ICAgICAgIH0NCj4gICANCj4gICANCj4gLSAgICBpZiAobGF0ZW5jeV9ucyA8
IGhpc3QtPmJvdW5kYXJpZXNbMF0pIHsNCj4gKyAgICBpZiAodmFsIDwgaGlzdC0+Ym91bmRhcmll
c1swXSkgew0KPiAgICAgICAgICAgaGlzdC0+Ymluc1swXSsrOw0KPiAgICAgICAgICAgcmV0dXJu
Ow0KPiAgICAgICB9DQo+ICAgDQo+IC0gICAgaWYgKGxhdGVuY3lfbnMgPj0gaGlzdC0+Ym91bmRh
cmllc1toaXN0LT5uYmlucyAtIDJdKSB7DQo+ICsgICAgaWYgKHZhbCA+PSBoaXN0LT5ib3VuZGFy
aWVzW2hpc3QtPm5iaW5zIC0gMl0pIHsNCj4gICAgICAgICAgIGhpc3QtPmJpbnNbaGlzdC0+bmJp
bnMgLSAxXSsrOw0KPiAgICAgICAgICAgcmV0dXJuOw0KPiAgICAgICB9DQo+ICAgDQo+IC0gICAg
cG9zID0gYnNlYXJjaCgmbGF0ZW5jeV9ucywgaGlzdC0+Ym91bmRhcmllcywgaGlzdC0+bmJpbnMg
LSAyLA0KPiArICAgIHBvcyA9IGJzZWFyY2goJnZhbCwgaGlzdC0+Ym91bmRhcmllcywgaGlzdC0+
bmJpbnMgLSAyLA0KPiAgICAgICAgICAgICAgICAgICAgIHNpemVvZihoaXN0LT5ib3VuZGFyaWVz
WzBdKSwNCj4gLSAgICAgICAgICAgICAgICAgIGJsb2NrX2xhdGVuY3lfaGlzdG9ncmFtX2NvbXBh
cmVfZnVuYyk7DQo+ICsgICAgICAgICAgICAgICAgICBibG9ja19oaXN0b2dyYW1fY29tcGFyZV9m
dW5jKTsNCj4gICAgICAgYXNzZXJ0KHBvcyAhPSBOVUxMKTsNCj4gICANCj4gICAgICAgaGlzdC0+
Ymluc1twb3MgLSBoaXN0LT5ib3VuZGFyaWVzICsgMV0rKzsNCj4gICB9DQo+ICAgDQo+IC1pbnQg
YmxvY2tfbGF0ZW5jeV9oaXN0b2dyYW1fc2V0KEJsb2NrQWNjdFN0YXRzICpzdGF0cywgZW51bSBC
bG9ja0FjY3RUeXBlIHR5cGUsDQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVp
bnQ2NExpc3QgKmJvdW5kYXJpZXMpDQo+ICtzdGF0aWMgaW50IGJsb2NrX2hpc3RvZ3JhbV9zZXQo
QmxvY2tIaXN0b2dyYW0gKmhpc3QsIHVpbnQ2NExpc3QgKmJvdW5kYXJpZXMpDQo+ICAgew0KPiAt
ICAgIEJsb2NrTGF0ZW5jeUhpc3RvZ3JhbSAqaGlzdCA9ICZzdGF0cy0+bGF0ZW5jeV9oaXN0b2dy
YW1bdHlwZV07DQo+ICAgICAgIHVpbnQ2NExpc3QgKmVudHJ5Ow0KPiAgICAgICB1aW50NjRfdCAq
cHRyOw0KPiAgICAgICB1aW50NjRfdCBwcmV2ID0gMDsNCj4gQEAgLTE3MCwxMiArMTY3LDIwIEBA
IGludCBibG9ja19sYXRlbmN5X2hpc3RvZ3JhbV9zZXQoQmxvY2tBY2N0U3RhdHMgKnN0YXRzLCBl
bnVtIEJsb2NrQWNjdFR5cGUgdHlwZSwNCj4gICAgICAgcmV0dXJuIDA7DQo+ICAgfQ0KPiAgIA0K
PiAraW50IGJsb2NrX2xhdGVuY3lfaGlzdG9ncmFtX3NldChCbG9ja0FjY3RTdGF0cyAqc3RhdHMs
IGVudW0gQmxvY2tBY2N0VHlwZSB0eXBlLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB1aW50NjRMaXN0ICpib3VuZGFyaWVzKQ0KPiArew0KPiArICAgIEJsb2NrSGlzdG9ncmFt
ICpoaXN0ID0gJnN0YXRzLT5sYXRlbmN5X2hpc3RvZ3JhbVt0eXBlXTsNCj4gKw0KPiArICAgIHJl
dHVybiBibG9ja19oaXN0b2dyYW1fc2V0KGhpc3QsIGJvdW5kYXJpZXMpOw0KPiArfQ0KPiArDQo+
ICAgdm9pZCBibG9ja19sYXRlbmN5X2hpc3RvZ3JhbXNfY2xlYXIoQmxvY2tBY2N0U3RhdHMgKnN0
YXRzKQ0KPiAgIHsNCj4gICAgICAgaW50IGk7DQo+ICAgDQo+ICAgICAgIGZvciAoaSA9IDA7IGkg
PCBCTE9DS19NQVhfSU9UWVBFOyBpKyspIHsNCj4gLSAgICAgICAgQmxvY2tMYXRlbmN5SGlzdG9n
cmFtICpoaXN0ID0gJnN0YXRzLT5sYXRlbmN5X2hpc3RvZ3JhbVtpXTsNCj4gKyAgICAgICAgQmxv
Y2tIaXN0b2dyYW0gKmhpc3QgPSAmc3RhdHMtPmxhdGVuY3lfaGlzdG9ncmFtW2ldOw0KPiAgICAg
ICAgICAgZ19mcmVlKGhpc3QtPmJpbnMpOw0KPiAgICAgICAgICAgZ19mcmVlKGhpc3QtPmJvdW5k
YXJpZXMpOw0KDQpJIHRoaW5rIHRoaXMgc2hvdWxkIGJlIG1vdmVkIHRvIHNlcGFyYXRlIGJsb2Nr
X2hpc3RvZ3JhbV9jbGVhciwgdG8gbm90IGR1cGxpY2F0ZSB0aGlzIGNvZGUNCmluIDAyLg0KDQo+
ICAgICAgICAgICBtZW1zZXQoaGlzdCwgMCwgc2l6ZW9mKCpoaXN0KSk7DQo+IEBAIC0yMDQsNyAr
MjA5LDcgQEAgc3RhdGljIHZvaWQgYmxvY2tfYWNjb3VudF9vbmVfaW8oQmxvY2tBY2N0U3RhdHMg
KnN0YXRzLCBCbG9ja0FjY3RDb29raWUgKmNvb2tpZSwNCj4gICAgICAgICAgIHN0YXRzLT5ucl9v
cHNbY29va2llLT50eXBlXSsrOw0KPiAgICAgICB9DQo+ICAgDQo+IC0gICAgYmxvY2tfbGF0ZW5j
eV9oaXN0b2dyYW1fYWNjb3VudCgmc3RhdHMtPmxhdGVuY3lfaGlzdG9ncmFtW2Nvb2tpZS0+dHlw
ZV0sDQo+ICsgICAgYmxvY2tfaGlzdG9ncmFtX2FjY291bnQoJnN0YXRzLT5sYXRlbmN5X2hpc3Rv
Z3JhbVtjb29raWUtPnR5cGVdLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGxhdGVuY3lfbnMpOw0KDQppbmRlbnRhdGlvbg0KDQo+ICAgDQo+ICAgICAgIGlmICghZmFp
bGVkIHx8IHN0YXRzLT5hY2NvdW50X2ZhaWxlZCkgew0KPiBkaWZmIC0tZ2l0IGEvYmxvY2svcWFw
aS5jIGIvYmxvY2svcWFwaS5jDQo+IGluZGV4IDkxNzQzNWYwMjIuLmYzYTg0Zjc3NmUgMTAwNjQ0
DQo+IC0tLSBhL2Jsb2NrL3FhcGkuYw0KPiArKysgYi9ibG9jay9xYXBpLmMNCj4gQEAgLTQxNSw3
ICs0MTUsNyBAQCBzdGF0aWMgdWludDY0TGlzdCAqdWludDY0X2xpc3QodWludDY0X3QgKmxpc3Qs
IGludCBzaXplKQ0KPiAgICAgICByZXR1cm4gb3V0X2xpc3Q7DQo+ICAgfQ0KPiAgIA0KPiAtc3Rh
dGljIHZvaWQgYmRydl9sYXRlbmN5X2hpc3RvZ3JhbV9zdGF0cyhCbG9ja0xhdGVuY3lIaXN0b2dy
YW0gKmhpc3QsDQo+ICtzdGF0aWMgdm9pZCBiZHJ2X2xhdGVuY3lfaGlzdG9ncmFtX3N0YXRzKEJs
b2NrSGlzdG9ncmFtICpoaXN0LA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgYm9vbCAqbm90X251bGwsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBCbG9ja0xhdGVuY3lIaXN0b2dyYW1JbmZvICoqaW5mbykNCj4gICB7DQoN
CldoeSBub3QgcmVuYW1lIHRoaXMgZnVuY3Rpb24gdG9vLCBhbmQgbm90IGR1cGxpY2F0ZSBpdCBp
biAwMz8NCg0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ibG9jay9hY2NvdW50aW5nLmggYi9pbmNs
dWRlL2Jsb2NrL2FjY291bnRpbmcuaA0KPiBpbmRleCBkMWY2N2IxMGRkLi4yNzBmZGRiNjljIDEw
MDY0NA0KPiAtLS0gYS9pbmNsdWRlL2Jsb2NrL2FjY291bnRpbmcuaA0KPiArKysgYi9pbmNsdWRl
L2Jsb2NrL2FjY291bnRpbmcuaA0KPiBAQCAtNDYsNyArNDYsNyBAQCBzdHJ1Y3QgQmxvY2tBY2N0
VGltZWRTdGF0cyB7DQo+ICAgICAgIFFTTElTVF9FTlRSWShCbG9ja0FjY3RUaW1lZFN0YXRzKSBl
bnRyaWVzOw0KPiAgIH07DQo+ICAgDQo+IC10eXBlZGVmIHN0cnVjdCBCbG9ja0xhdGVuY3lIaXN0
b2dyYW0gew0KPiArdHlwZWRlZiBzdHJ1Y3QgQmxvY2tIaXN0b2dyYW0gew0KPiAgICAgICAvKiBU
aGUgZm9sbG93aW5nIGhpc3RvZ3JhbSBpcyByZXByZXNlbnRlZCBsaWtlIHRoaXM6DQo+ICAgICAg
ICAqDQo+ICAgICAgICAqIDV8ICAgICAgICAgICAqDQo+IEBAIC01Nyw3ICs1Nyw3IEBAIHR5cGVk
ZWYgc3RydWN0IEJsb2NrTGF0ZW5jeUhpc3RvZ3JhbSB7DQo+ICAgICAgICAqICArLS0tLS0tLS0t
LS0tLS0tLS0tDQo+ICAgICAgICAqICAgICAgMTAgICA1MCAgIDEwMA0KPiAgICAgICAgKg0KPiAt
ICAgICAqIEJsb2NrTGF0ZW5jeUhpc3RvZ3JhbSBoaXN0b2dyYW0gPSB7DQo+ICsgICAgICogQmxv
Y2tIaXN0b2dyYW0gaGlzdG9ncmFtID0gew0KPiAgICAgICAgKiAgICAgLm5iaW5zID0gNCwNCj4g
ICAgICAgICogICAgIC5ib3VuZGFyaWVzID0gezEwLCA1MCwgMTAwfSwNCj4gICAgICAgICogICAg
IC5iaW5zID0gezMsIDEsIDUsIDJ9LA0KPiBAQCAtNzQsNyArNzQsNyBAQCB0eXBlZGVmIHN0cnVj
dCBCbG9ja0xhdGVuY3lIaXN0b2dyYW0gew0KPiAgICAgICB1aW50NjRfdCAqYm91bmRhcmllczsg
LyogQG5iaW5zLTEgbnVtYmVycyBoZXJlDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAoYWxsIGJvdW5kYXJpZXMsIGV4Y2VwdCAwIGFuZCAraW5mKSAqLw0KPiAgICAgICB1aW50NjRf
dCAqYmluczsNCj4gLX0gQmxvY2tMYXRlbmN5SGlzdG9ncmFtOw0KPiArfSBCbG9ja0hpc3RvZ3Jh
bTsNCj4gICANCj4gICBzdHJ1Y3QgQmxvY2tBY2N0U3RhdHMgew0KPiAgICAgICBRZW11TXV0ZXgg
bG9jazsNCj4gQEAgLTg4LDcgKzg4LDcgQEAgc3RydWN0IEJsb2NrQWNjdFN0YXRzIHsNCj4gICAg
ICAgUVNMSVNUX0hFQUQoLCBCbG9ja0FjY3RUaW1lZFN0YXRzKSBpbnRlcnZhbHM7DQo+ICAgICAg
IGJvb2wgYWNjb3VudF9pbnZhbGlkOw0KPiAgICAgICBib29sIGFjY291bnRfZmFpbGVkOw0KPiAt
ICAgIEJsb2NrTGF0ZW5jeUhpc3RvZ3JhbSBsYXRlbmN5X2hpc3RvZ3JhbVtCTE9DS19NQVhfSU9U
WVBFXTsNCj4gKyAgICBCbG9ja0hpc3RvZ3JhbSBsYXRlbmN5X2hpc3RvZ3JhbVtCTE9DS19NQVhf
SU9UWVBFXTsNCj4gICB9Ow0KPiAgIA0KPiAgIHR5cGVkZWYgc3RydWN0IEJsb2NrQWNjdENvb2tp
ZSB7DQo+IA0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

