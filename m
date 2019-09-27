Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C1CFC4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 12:56:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A160217D9
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 12:56:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="chJgbQNM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A160217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDpna-00064S-Jy
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 08:56:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52195)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iDpkC-000331-0t
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 08:53:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iDpk7-0001Sh-Se
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 08:53:06 -0400
Received: from mail-eopbgr20116.outbound.protection.outlook.com
 ([40.107.2.116]:8836 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iDpk6-0001R9-Gf; Fri, 27 Sep 2019 08:53:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=epoc9OdsIlHwbCpG+VbS5gfaM7DmtJyYaSiOb2pidtCd82HgSnbE9xxoM8uuYWJ0Co5Sc3kneIQyBiuKT87M++hpgVLuIza+nlYnOXEA9AGcwXbB7ieR2VJ/QoqtQSzi9k2CGKjYGqCJOPJ8V7M/9x/cvwH/k7fKhh3uMoZ+t97GyBYh48C8JhVwZ9UNsxedplqN/I0O/9UWoN+E7UcrRb9Ad9qptLENWkwIR1rIDZp9de33LdqTRYoSJIdyqFvIdhG7aEfmBuQy7usp+55u2kqszDT4mWFnXq2a4QSj986am0vCTg+faMo23kT9CehxxRI9d5cyQCk1aXiGKXZKyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0j0W/WYOn42mE+yctLDbqOb9VDB1L0mLz6wB5pAFP2E=;
 b=evZrOlScyByuZqi05qgYGwhzzRJMULeFKmHZgtXaWkOqsW81QF5zEpqFdSjHc/abVZ+3QSwtL74SElnwM02+sdPfCRj4vE81qxz40yNzxUxfSjeAfPTjsz86iTaDmKVdqwM8WVCvDxUD2rNedylBOn+8PM/6wPv7u70O3zodG0OwPNgGbCkS7Hd+Zbu6rrd303OcEWdPFn95kNsG8laB2igrdhv5725Wt6bf9hKXr05jDZ3yg84VAD0+x34YO1ZSwkypK50nK3M0XpJlrHJXyonw6E6vkwv7Paj8A5s0liID8YxrsUGo/rXGc46GBlCrtKKGZ3Ys7RbhWwLjUZGXJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0j0W/WYOn42mE+yctLDbqOb9VDB1L0mLz6wB5pAFP2E=;
 b=chJgbQNMB8Z4VDentfd+kdL2tAJANKyBbDVR0b+ogvChRm+/PIR7tuPEkI3Rvr5J89kcB0a50soUUyCqqtnz085j0vxgDt9OuH66MH10lICXeYBj6wQ2WsNJMmy8QRx10pgFRJqu5fXfUqMAY/QBom/MviGfRsHxjdYGsv5oa3A=
Received: from AM0PR08MB5491.eurprd08.prod.outlook.com (52.132.215.9) by
 AM0PR08MB3922.eurprd08.prod.outlook.com (20.178.118.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Fri, 27 Sep 2019 10:29:57 +0000
Received: from AM0PR08MB5491.eurprd08.prod.outlook.com
 ([fe80::d552:8bd7:4773:3d75]) by AM0PR08MB5491.eurprd08.prod.outlook.com
 ([fe80::d552:8bd7:4773:3d75%2]) with mapi id 15.20.2305.017; Fri, 27 Sep 2019
 10:29:57 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [Qemu-devel] [PATCH v4 03/10] iotests: add test-case to 165 to
 test reopening qcow2 bitmaps to RW
Thread-Topic: [Qemu-devel] [PATCH v4 03/10] iotests: add test-case to 165 to
 test reopening qcow2 bitmaps to RW
Thread-Index: AQHVTSopNDU5oGi3VU6xm0/sCJBvxac+4RqAgACO6YCAADKpAA==
Date: Fri, 27 Sep 2019 10:29:57 +0000
Message-ID: <99db5bbd-6601-4a37-cca0-e211a945674b@virtuozzo.com>
References: <20190807141226.193501-1-vsementsov@virtuozzo.com>
 <20190807141226.193501-4-vsementsov@virtuozzo.com>
 <6c308090-5841-fcba-d319-8b9d65b7d6b8@redhat.com>
 <0db3ca38-65db-c224-e718-210bb910116b@virtuozzo.com>
In-Reply-To: <0db3ca38-65db-c224-e718-210bb910116b@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR08CA0044.eurprd08.prod.outlook.com
 (2603:10a6:7:2a::15) To AM0PR08MB5491.eurprd08.prod.outlook.com
 (2603:10a6:208:189::9)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190927132954735
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 641ad7bf-c652-4213-3593-08d74335a4a4
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:AM0PR08MB3922; 
x-ms-traffictypediagnostic: AM0PR08MB3922:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR08MB39225FE3CE7096CF4CF981A6C1810@AM0PR08MB3922.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2043;
x-forefront-prvs: 0173C6D4D5
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(136003)(346002)(376002)(39850400004)(366004)(189003)(199004)(2501003)(305945005)(66946007)(3846002)(14454004)(478600001)(7736002)(66066001)(486006)(11346002)(4326008)(446003)(6116002)(25786009)(2616005)(31696002)(66476007)(66446008)(66556008)(64756008)(5660300002)(2906002)(86362001)(6246003)(53546011)(256004)(14444005)(107886003)(6512007)(476003)(386003)(99286004)(316002)(8676002)(6436002)(26005)(186003)(54906003)(81156014)(110136005)(71190400001)(81166006)(6506007)(8936002)(76176011)(31686004)(36756003)(102836004)(71200400001)(6486002)(229853002)(52116002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3922;
 H:AM0PR08MB5491.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: a2K7hsVPgCvH2xrdKXcp5e89bF32kPBHUVgpJ9msnxtkZ32BKANkaTWMcIb8Mx8AYT/L5Kkb/lN4qTPqrBHlKzfZLt4ytuju0JvsKBURx+fqZjdWpva+bhRd52wxR3Zmu+ImrGuSzIPYJEg258fL8ytlzhNza6TqO/UMh0ZViDArUi7KbRth0Lbthv0dPouOo8W1qGUOmR0iZPaX7nELfPM4UJ+KcDSv6txmMwm6u91FPBx8Ula9XQurhCdnUa6/p2HbMsEvzviuNEekoVV1sGVfgMfWcb89F6GBEsDqSSyTXm8R5Pi7Yh1kIGzAkafCZwCadjnft/0x3ZJE1u9iMwWJltwKpLSpLdzKTaGMLBmMLczVTRqLUH4vGrrXM9SkhY8/NkeFKJnNvbP3fFmOFlu2h/Bae7ZAgdhXMbx6ljs=
Content-Type: text/plain; charset="utf-8"
Content-ID: <357269A3C80FD440A047FEE2EB6696B7@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 641ad7bf-c652-4213-3593-08d74335a4a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2019 10:29:57.1577 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I8+95OzrMNh9KfWy3XG3siLXgWU28glPWSq1WqeJWbNfV2tvWY5k9MXrQUrXpNIWsZuBGUTd3wNQzTLeQVKL5VB12fJs2LoNFeKvdwRsT40=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3922
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.2.116
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjcuMDkuMjAxOSAxMDoyOCwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4g
MjcuMDkuMjAxOSAxOjU3LCBKb2huIFNub3cgd3JvdGU6DQo+Pg0KPj4NCj4+IE9uIDgvNy8xOSAx
MDoxMiBBTSwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+PiBSZW9wZW5p
bmcgYml0bWFwcyB0byBSVyB3YXMgYnJva2VuIHByaW9yIHRvIHByZXZpb3VzIGNvbW1pdC4gQ2hl
Y2sgdGhhdA0KPj4+IGl0IHdvcmtzIG5vdy4NCj4+Pg0KPj4+IFNpZ25lZC1vZmYtYnk6IFZsYWRp
bWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCj4+PiAt
LS0NCj4+PiDCoCB0ZXN0cy9xZW11LWlvdGVzdHMvMTY1wqDCoMKgwqAgfCA0NiArKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKystLQ0KPj4+IMKgIHRlc3RzL3FlbXUtaW90ZXN0cy8x
NjUub3V0IHzCoCA0ICsrLS0NCj4+PiDCoCAyIGZpbGVzIGNoYW5nZWQsIDQ2IGluc2VydGlvbnMo
KyksIDQgZGVsZXRpb25zKC0pDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvdGVzdHMvcWVtdS1pb3Rl
c3RzLzE2NSBiL3Rlc3RzL3FlbXUtaW90ZXN0cy8xNjUNCj4+PiBpbmRleCA4OGY2MmQzYzZkLi5k
ZDkzYjVhMmQwIDEwMDc1NQ0KPj4+IC0tLSBhL3Rlc3RzL3FlbXUtaW90ZXN0cy8xNjUNCj4+PiAr
KysgYi90ZXN0cy9xZW11LWlvdGVzdHMvMTY1DQo+Pj4gQEAgLTQzLDEwICs0MywxMCBAQCBjbGFz
cyBUZXN0UGVyc2lzdGVudERpcnR5Qml0bWFwKGlvdGVzdHMuUU1QVGVzdENhc2UpOg0KPj4+IMKg
wqDCoMKgwqDCoMKgwqDCoCBvcy5yZW1vdmUoZGlzaykNCj4+PiDCoMKgwqDCoMKgIGRlZiBta1Zt
KHNlbGYpOg0KPj4+IC3CoMKgwqDCoMKgwqDCoCByZXR1cm4gaW90ZXN0cy5WTSgpLmFkZF9kcml2
ZShkaXNrKQ0KPj4+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4gaW90ZXN0cy5WTSgpLmFkZF9kcml2
ZShkaXNrLCBvcHRzPSdub2RlLW5hbWU9bm9kZTAnKQ0KPj4+IMKgwqDCoMKgwqAgZGVmIG1rVm1S
byhzZWxmKToNCj4+PiAtwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGlvdGVzdHMuVk0oKS5hZGRfZHJp
dmUoZGlzaywgb3B0cz0ncmVhZG9ubHk9b24nKQ0KPj4+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4g
aW90ZXN0cy5WTSgpLmFkZF9kcml2ZShkaXNrLCBvcHRzPSdyZWFkb25seT1vbixub2RlLW5hbWU9
bm9kZTAnKQ0KPj4+IMKgwqDCoMKgwqAgZGVmIGdldFNoYTI1NihzZWxmKToNCj4+PiDCoMKgwqDC
oMKgwqDCoMKgwqAgcmVzdWx0ID0gc2VsZi52bS5xbXAoJ3gtZGVidWctYmxvY2stZGlydHktYml0
bWFwLXNoYTI1NicsDQo+Pj4gQEAgLTEwMiw1ICsxMDIsNDcgQEAgY2xhc3MgVGVzdFBlcnNpc3Rl
bnREaXJ0eUJpdG1hcChpb3Rlc3RzLlFNUFRlc3RDYXNlKToNCj4+PiDCoMKgwqDCoMKgwqDCoMKg
wqAgc2VsZi52bS5zaHV0ZG93bigpDQo+Pj4gK8KgwqDCoCBkZWYgdGVzdF9yZW9wZW5fcncoc2Vs
Zik6DQo+Pj4gK8KgwqDCoMKgwqDCoMKgIHNlbGYudm0gPSBzZWxmLm1rVm0oKQ0KPj4+ICvCoMKg
wqDCoMKgwqDCoCBzZWxmLnZtLmxhdW5jaCgpDQo+Pj4gK8KgwqDCoMKgwqDCoMKgIHNlbGYucW1w
QWRkQml0bWFwKCkNCj4+PiArDQo+Pj4gK8KgwqDCoMKgwqDCoMKgICMgQ2FsY3VsYXRlIHNoYTI1
NiBjb3JyZXNwb25kaW5nIHRvIHJlZ2lvbnMxDQo+Pj4gK8KgwqDCoMKgwqDCoMKgIHNlbGYud3Jp
dGVSZWdpb25zKHJlZ2lvbnMxKQ0KPj4+ICvCoMKgwqDCoMKgwqDCoCBzaGEyNTYgPSBzZWxmLmdl
dFNoYTI1NigpDQo+Pj4gK8KgwqDCoMKgwqDCoMKgIHJlc3VsdCA9IHNlbGYudm0ucW1wKCdibG9j
ay1kaXJ0eS1iaXRtYXAtY2xlYXInLCBub2RlPSdkcml2ZTAnLA0KPj4+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBuYW1lPSdiaXRtYXAw
JykNCj4+PiArwqDCoMKgwqDCoMKgwqAgc2VsZi5hc3NlcnRfcW1wKHJlc3VsdCwgJ3JldHVybics
IHt9KQ0KPj4+ICsNCj4+PiArwqDCoMKgwqDCoMKgwqAgc2VsZi52bS5zaHV0ZG93bigpDQo+Pj4g
Kw0KPj4+ICvCoMKgwqDCoMKgwqDCoCBzZWxmLnZtID0gc2VsZi5ta1ZtUm8oKQ0KPj4+ICvCoMKg
wqDCoMKgwqDCoCBzZWxmLnZtLmxhdW5jaCgpDQo+Pj4gKw0KPj4+ICvCoMKgwqDCoMKgwqDCoCAj
IFdlJ3ZlIGxvYWRlZCBlbXB0eSBiaXRtYXANCj4+PiArwqDCoMKgwqDCoMKgwqAgYXNzZXJ0IHNo
YTI1NiAhPSBzZWxmLmdldFNoYTI1NigpDQo+Pj4gKw0KPj4+ICvCoMKgwqDCoMKgwqDCoCAjIENo
ZWNrIHRoYXQgd2UgYXJlIGluIFJPIG1vZGUNCj4+PiArwqDCoMKgwqDCoMKgwqAgc2VsZi53cml0
ZVJlZ2lvbnMocmVnaW9uczEpDQo+Pj4gK8KgwqDCoMKgwqDCoMKgIGFzc2VydCBzaGEyNTYgIT0g
c2VsZi5nZXRTaGEyNTYoKQ0KPj4+ICsNCj4+DQo+PiB0aGUgSE1QIG1vbml0b3IgbGV0cyB5b3Ug
YXR0ZW1wdCB3cml0ZXMgdG8gYSBSZWFkIE9ubHkgZHJpdmUuLi4/IE9yIGRvZXMNCj4+IGl0IGVy
cm9yIG91dCBhbmQgd2UganVzdCBkb24ndCBjaGVjayB0aGUgcmVwbHk/DQo+IA0KPiBJdCBtdXN0
IGZhaWwgYW5kIHdlIGNoZWNrIHRoaXMgYnkgY29tcGFyaW5nIGRpcnR5IGJpdG1hcCBoYXNoLg0K
PiANCj4+DQo+PiBJIHdvdWxkIHByZWZlciB3ZSB1c2UgYW4gYWN0dWFsIGRpcnR5IHNlY3RvciBj
b3VudCBoZXJlIGluc3RlYWQ7IHdlIGhhdmUNCj4+IHRoZSBuZXcgQVBJIHRoYXQgc2hvdWxkIG1h
a2UgaXQgZWFzeSB0byBkby4NCj4+DQo+PiBJZiB0aGUgZGVidWcgU0hBIGNoYW5nZXMgdGhpcyBt
aWdodCBiZSBhIGxpdHRsZSBmcmFnaWxlLg0KPiANCj4gSG1tLCBJIGFncmVlIHRoYXQgY2hlY2tp
bmcgdGhhdCBiaXRtYXAgaXMgZW1wdHkgYnkgY29tcGFyaW5nIHdpdGggc29tZSBoYXNoDQo+IGlz
IG5vdCB2ZXJ5IHJlbGlhYmxlLiBXaWxsIGRvLg0KPiANCj4+DQo+PiBBQ0sgb3RoZXJ3aXNlLg0K
Pj4NCj4+PiArwqDCoMKgwqDCoMKgwqAgcmVzdWx0ID0gc2VsZi52bS5xbXAoJ3gtYmxvY2tkZXYt
cmVvcGVuJywgKip7DQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgJ25vZGUtbmFtZSc6ICdu
b2RlMCcsDQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgJ2RyaXZlcic6IGlvdGVzdHMuaW1n
Zm10LA0KPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICdmaWxlJzogew0KPj4+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgJ2RyaXZlcic6ICdmaWxlJywNCj4+PiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgICdmaWxlbmFtZSc6IGRpc2sNCj4+PiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCB9LA0KPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICdyZWFkLW9ubHknOiBG
YWxzZQ0KPj4+ICvCoMKgwqDCoMKgwqDCoCB9KQ0KPj4+ICvCoMKgwqDCoMKgwqDCoCBzZWxmLmFz
c2VydF9xbXAocmVzdWx0LCAncmV0dXJuJywge30pDQo+Pj4gKw0KPj4+ICvCoMKgwqDCoMKgwqDC
oCAjIENoZWNrIHRoYXQgYml0bWFwIGlzIHJlb3BlbmVkIHRvIFJXIGFuZCB3ZSBjYW4gd3JpdGUg
dG8gaXQuDQo+Pj4gK8KgwqDCoMKgwqDCoMKgIHNlbGYud3JpdGVSZWdpb25zKHJlZ2lvbnMxKQ0K
Pj4+ICvCoMKgwqDCoMKgwqDCoCBhc3NlcnQgc2hhMjU2ID09IHNlbGYuZ2V0U2hhMjU2KCkNCj4+
PiArDQo+Pj4gK8KgwqDCoMKgwqDCoMKgIHNlbGYudm0uc2h1dGRvd24oKQ0KPj4+ICsNCj4+PiAr
DQo+Pj4gwqAgaWYgX19uYW1lX18gPT0gJ19fbWFpbl9fJzoNCj4+PiDCoMKgwqDCoMKgIGlvdGVz
dHMubWFpbihzdXBwb3J0ZWRfZm10cz1bJ3Fjb3cyJ10pDQo+Pj4gZGlmZiAtLWdpdCBhL3Rlc3Rz
L3FlbXUtaW90ZXN0cy8xNjUub3V0IGIvdGVzdHMvcWVtdS1pb3Rlc3RzLzE2NS5vdXQNCj4+PiBp
bmRleCBhZTEyMTNlNmY4Li5mYmM2M2U2MmY4IDEwMDY0NA0KPj4+IC0tLSBhL3Rlc3RzL3FlbXUt
aW90ZXN0cy8xNjUub3V0DQo+Pj4gKysrIGIvdGVzdHMvcWVtdS1pb3Rlc3RzLzE2NS5vdXQNCj4+
PiBAQCAtMSw1ICsxLDUgQEANCj4+PiAtLg0KPj4+ICsuLg0KPj4+IMKgIC0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0N
Cj4+PiAtUmFuIDEgdGVzdHMNCj4+PiArUmFuIDIgdGVzdHMNCj4+PiDCoCBPSw0KPj4+DQo+Pg0K
Pj4gVGhpcyBpcyBhIHN1Z2dlc3Rpb24gZm9yIGFuIGV2ZW4gbW9yZSByaWdvcm91cyB0ZXN0Og0K
Pj4NCj4+IC0gQ3JlYXRlIGJpdG1hcA0KPj4gLSBXcml0ZSBhIHJlZ2lvbiBvciB0d28NCj4+IC0g
UmVjb3JkIHRoZSBkaXJ0eSBjb3VudCBhbmQgdGhlIFNIQTsgYXNzZXJ0IGl0IGlzIGVxdWFsIHRv
IGtub3duIC8NCj4+IHByZWRldGVybWluZWQgdmFsdWVzLg0KPj4gLSByZW9wZW4gUk8NCj4+IC0g
dmVyaWZ5IHRoZSBiaXRtYXAgc3RpbGwgZXhpc3RzIGFuZCB0aGF0IHRoZSBoYXNoIGFuZCBjb3Vu
dCBhcmUgdGhlIHNhbWUuDQo+PiAtIFN0b3AgdGhlIFZNDQo+PiAtIFN0YXJ0IHRoZSBWTSBpbiBy
ZWFkb25seSBtb2RlDQo+PiAtIHZlcmlmeSB0aGUgYml0bWFwIHN0aWxsIGV4aXN0cyBhbmQgdGhh
dCB0aGUgaGFzaCBhbmQgY291bnQgYXJlIHRoZSBzYW1lLg0KPj4gLSBSZW9wZW4tUlcNCj4+IC0g
dmVyaWZ5IHRoZSBiaXRtYXAgc3RpbGwgZXhpc3RzIGFuZCB0aGF0IHRoZSBoYXNoIGFuZCBjb3Vu
dCBhcmUgdGhlIHNhbWUuDQo+PiAtIFdyaXRlIGZ1cnRoZXIgcmVnaW9uKHMpDQo+PiAtIEdldCB0
aGUgbmV3IGRpcnR5IGNvdW50IGFuZCBTSEEsIGFuZCBhc3NlcnQgaXQgaXMgZXF1YWwgdG8ga25v
d24gLw0KPj4gcHJlZGV0ZXJtaW5lZCB2YWx1ZXMuDQo+Pg0KPiANCj4gT0sNCj4gDQoNCkFoLCBz
dG9wLiBXZSBjYW4ndCBjaGVjayByZW9wZW4gUk8gYXQgdGhpcyBwb2ludCwgYXMgaXQgd2lsbCBi
ZSBmaXhlZCBpbiBsYXRlciBwYXRjaA0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

