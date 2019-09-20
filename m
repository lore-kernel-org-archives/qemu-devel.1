Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91420C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 13:36:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C2E9206B6
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 13:36:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="wdxXI4Sn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C2E9206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBJ5O-0004E5-Cb
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 09:36:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55058)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iBJ1W-0001Ti-33
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 09:32:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iBJ1U-0003sW-4f
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 09:32:33 -0400
Received: from mail-he1eur04on0724.outbound.protection.outlook.com
 ([2a01:111:f400:fe0d::724]:3854
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iBJ1T-0003pL-IM; Fri, 20 Sep 2019 09:32:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Twa/zmRY/24QK2Cwy6ttuDrr3J0Lko/2rTYzvNmeIlTW2qk4cXV5YR+IRpv42KKSEaLa4m8ex7OZYaNrDNlQBcW2REi9wbAgKA3JPvfM4jDZo+2WQ973Ci4hAOAQ2p0XDWZ3moRvMmQ1itE33zqP4qdk0PSj36FW3Eh3Wsa+SjojtGT0OFxxpoUBMiKiNUgrdGiWRWuBkHunh97LDA/KnHB9WwlkVImJ4PzXQ3f8RcK70xHvW84T4K3uIWoyqTZGLEqUr5oT8qQV6QB39oPiDwMTgvc2ag3d+s/vkiM6/RGoZb6eAOPSEocfj/RMsI03O32CGTEd7i7de5RagE2NkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4XnYw0I9Bn2E/4VGAxzlI+alEhBnD1rA+ikvHNg/cJ4=;
 b=NE0CFtAdCl0vDuOHJSLZuSaY/h7jvcjDj3H8LnryCnqpGlNiTMuddLKiYf4B/bukWRxxWg0KonoQ3IJV3WBMzrlXhVAL0+Yuc4lE9HeGNj1vxTJaN22P2n4oP74wDHnnjsX+DI+e7EEZ7ETxCEuCbzBy+MbsG2oABLu50pT01RWOxzxB+D6t5FrpTdYU/GvbLR3YBEUb4+5y8Qmk6TVnVzC0CZjZxCpzRkcEX2R4Jjs6n6R2Yr2sBziLrCG9N+Xt7LGgb6SRQ2GG21+NKAEo/i2bhEe8ApV3HZiw0Atw4XU1/C0Pgb9a2qUAANo8SWh+pjYpiB59nritcdG66aB02g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4XnYw0I9Bn2E/4VGAxzlI+alEhBnD1rA+ikvHNg/cJ4=;
 b=wdxXI4Sn2YSPusvFD9xc7gqLjIh4kCnR1IPOVQ0o8GWhxV/b3BRpECo9ZywONZFhsGmzcqWPeldkg5TNjexityPVlJ8F8cl4wl74/xBqDUtlPD9a3p2N18kl1HVU0XOSR0Phll/cP48wRdj9HSCmiuNgbbnI0PEx1flLAirHeQM=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4201.eurprd08.prod.outlook.com (20.179.8.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.21; Fri, 20 Sep 2019 13:32:28 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2284.023; Fri, 20 Sep 2019
 13:32:28 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH v11 04/14] block/backup: introduce BlockCopyState
Thread-Topic: [PATCH v11 04/14] block/backup: introduce BlockCopyState
Thread-Index: AQHVZ8HWULZDkPZpMke6HdjhrfznqKcp8daAgAqhiQCAAAKhgIAAADEAgAAIaoCAAAGOgA==
Date: Fri, 20 Sep 2019 13:32:28 +0000
Message-ID: <aa260fb3-7eaf-3564-6183-85cade318227@virtuozzo.com>
References: <20190910102332.20560-1-vsementsov@virtuozzo.com>
 <20190910102332.20560-5-vsementsov@virtuozzo.com>
 <bafea6c6-38cc-1848-92ea-ec891457515a@virtuozzo.com>
 <bb798ca2-dd22-9ffe-de08-a4d0d8891f30@redhat.com>
 <abf4fdcc-2ca3-7ec5-93ff-95be6b480a5d@virtuozzo.com>
 <fbcb6733-b19f-e275-71cb-466238d8b193@virtuozzo.com>
 <5d9c1263-c0d7-0f51-424a-25406ed435db@redhat.com>
In-Reply-To: <5d9c1263-c0d7-0f51-424a-25406ed435db@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0501CA0015.eurprd05.prod.outlook.com
 (2603:10a6:3:1a::25) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190920163225525
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 274edf95-5af5-4963-e5e9-08d73dcefaec
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB4201; 
x-ms-traffictypediagnostic: DB8PR08MB4201:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB4201459B837EDBA25210D1E5C1880@DB8PR08MB4201.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:345;
x-forefront-prvs: 0166B75B74
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(396003)(376002)(346002)(39850400004)(136003)(189003)(199004)(4326008)(256004)(66946007)(5660300002)(316002)(7416002)(54906003)(52116002)(6116002)(3846002)(66476007)(26005)(186003)(478600001)(476003)(64756008)(66556008)(6486002)(2616005)(8676002)(107886003)(6512007)(8936002)(86362001)(81156014)(81166006)(305945005)(2501003)(36756003)(71190400001)(486006)(25786009)(386003)(53546011)(229853002)(110136005)(6506007)(14454004)(2906002)(71200400001)(102836004)(6436002)(31686004)(66446008)(99286004)(6246003)(31696002)(66066001)(446003)(7736002)(11346002)(76176011);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4201;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ujEQmBSvqT7MYKaa7twmerNe3fe/jYnW7kp2znJn3+ZA2FJUu3i2VQR3/utGexdp2pUPpRBO3xbmWSM3HcY3hkRZ/fZAebK1mrEadeifbktOrIP+/PSVT1LGqeBYU90FFWz30XGioDqBCcKoDxjTHz5nxVqcR35mgDaoiQTCSDGPaXg00W2zV2MEkRIAoQEsDP0R+5/xX9cAQzzNkH2Pp3tkyIIhXYU3WJuoZ9ahEglTUu9Q8rR7CYsUg6qfXp/d2haTIlW9SeKKfI4NNz+UyNWfIfmlsf9Wg4y4uu81ZI1wQTZbYlLytjZg0yFyi0MFZWjRI+tjDk59yBm5b09Y4d3LjASTWarlqqEQWiKp1KiST5AvEVJdZC8gHgeuI540GuUGAwptwkVcOnnTFTtZttBUKwutoA+RqHxuZWgKpz4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2BF2CD9B968E004DABDB52534EE751F1@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 274edf95-5af5-4963-e5e9-08d73dcefaec
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2019 13:32:28.0192 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /4N8zRJH10QtfaS2QibutwBOQs+6ov3/nWT+T1tQmOaJ4CP+epYA5VY8SJpnkKIw/Moqq5Wgi+dN6YXYa9NboSc04AhG9E4SAfiCVVvJnfQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4201
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe0d::724
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

MjAuMDkuMjAxOSAxNjoyNiwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAyMC4wOS4xOSAxNDo1Niwg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IDIwLjA5LjIwMTkgMTU6NTYs
IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgd3JvdGU6DQo+Pj4gMjAuMDkuMjAxOSAxNTo0
NiwgTWF4IFJlaXR6IHdyb3RlOg0KPj4+PiBPbiAxMy4wOS4xOSAyMDoyNSwgVmxhZGltaXIgU2Vt
ZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+Pj4+IDEwLjA5LjIwMTkgMTM6MjMsIFZsYWRpbWly
IFNlbWVudHNvdi1PZ2lldnNraXkgd3JvdGU6DQo+Pj4+Pj4gU3BsaXQgY29weWluZyBjb2RlIHBh
cnQgZnJvbSBiYWNrdXAgdG8gImJsb2NrLWNvcHkiLCBpbmNsdWRpbmcgc2VwYXJhdGUNCj4+Pj4+
PiBzdGF0ZSBzdHJ1Y3R1cmUgYW5kIGZ1bmN0aW9uIHJlbmFtaW5nLiBUaGlzIGlzIG5lZWRlZCB0
byBzaGFyZSBpdCB3aXRoDQo+Pj4+Pj4gYmFja3VwLXRvcCBmaWx0ZXIgZHJpdmVyIGluIGZ1cnRo
ZXIgY29tbWl0cy4NCj4+Pj4+Pg0KPj4+Pj4+IE5vdGVzOg0KPj4+Pj4+DQo+Pj4+Pj4gMS4gQXMg
QmxvY2tDb3B5U3RhdGUga2VlcHMgb3duIEJsb2NrQmFja2VuZCBvYmplY3RzLCByZW1haW5pbmcN
Cj4+Pj4+PiBqb2ItPmNvbW1vbi5ibGsgdXNlcnMgb25seSB1c2UgaXQgdG8gZ2V0IGJzIGJ5IGJs
a19icygpIGNhbGwsIHNvIGNsZWFyDQo+Pj4+Pj4gam9iLT5jb21tZW4uYmxrIHBlcm1pc3Npb25z
IHNldCBpbiBibG9ja19qb2JfY3JlYXRlIGFuZCBhZGQNCj4+Pj4+PiBqb2ItPnNvdXJjZV9icyB0
byBiZSB1c2VkIGluc3RlYWQgb2YgYmxrX2JzKGpvYi0+Y29tbW9uLmJsayksIHRvIGtlZXANCj4+
Pj4+PiBpdCBtb3JlIGNsZWFyIHdoaWNoIGJzIHdlIHVzZSB3aGVuIGludHJvZHVjZSBiYWNrdXAt
dG9wIGZpbHRlciBpbg0KPj4+Pj4+IGZ1cnRoZXIgY29tbWl0Lg0KPj4+Pj4+DQo+Pj4+Pj4gMi4g
UmVuYW1lIHMvaW5pdGlhbGl6aW5nX2JpdG1hcC9za2lwX3VuYWxsb2NhdGVkLyB0byBzb3VuZCBh
IGJpdCBiZXR0ZXINCj4+Pj4+PiBhcyBpbnRlcmZhY2UgdG8gQmxvY2tDb3B5U3RhdGUNCj4+Pj4+
Pg0KPj4+Pj4+IDMuIFNwbGl0IGlzIG5vdCB2ZXJ5IGNsZWFuOiB0aGVyZSBsZWZ0IHNvbWUgZHVw
bGljYXRlZCBmaWVsZHMsIGJhY2t1cA0KPj4+Pj4+IGNvZGUgdXNlcyBzb21lIEJsb2NrQ29weVN0
YXRlIGZpZWxkcyBkaXJlY3RseSwgbGV0J3MgcG9zdHBvbmUgaXQgZm9yDQo+Pj4+Pj4gZnVydGhl
ciBpbXByb3ZlbWVudHMgYW5kIGtlZXAgdGhpcyBjb21tZW50IHNpbXBsZXIgZm9yIHJldmlldy4N
Cj4+Pj4+Pg0KPj4+Pj4+IFNpZ25lZC1vZmYtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNr
aXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCj4+Pj4+PiAtLS0NCj4+Pj4+DQo+Pj4+Pg0K
Pj4+Pj4gWy4uXQ0KPj4+Pj4NCj4+Pj4+PiArDQo+Pj4+Pj4gK3N0YXRpYyBCbG9ja0NvcHlTdGF0
ZSAqYmxvY2tfY29weV9zdGF0ZV9uZXcoDQo+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIEJsb2NrRHJp
dmVyU3RhdGUgKnNvdXJjZSwgQmxvY2tEcml2ZXJTdGF0ZSAqdGFyZ2V0LA0KPj4+Pj4+ICvCoMKg
wqDCoMKgwqDCoCBpbnQ2NF90IGNsdXN0ZXJfc2l6ZSwgQmRydlJlcXVlc3RGbGFncyB3cml0ZV9m
bGFncywNCj4+Pj4+PiArwqDCoMKgwqDCoMKgwqAgUHJvZ3Jlc3NCeXRlc0NhbGxiYWNrRnVuYyBw
cm9ncmVzc19ieXRlc19jYWxsYmFjaywNCj4+Pj4+PiArwqDCoMKgwqDCoMKgwqAgUHJvZ3Jlc3NS
ZXNldENhbGxiYWNrRnVuYyBwcm9ncmVzc19yZXNldF9jYWxsYmFjaywNCj4+Pj4+PiArwqDCoMKg
wqDCoMKgwqAgdm9pZCAqcHJvZ3Jlc3Nfb3BhcXVlLCBFcnJvciAqKmVycnApDQo+Pj4+Pj4gK3sN
Cj4+Pj4+PiArwqDCoMKgIEJsb2NrQ29weVN0YXRlICpzOw0KPj4+Pj4+ICvCoMKgwqAgaW50IHJl
dDsNCj4+Pj4+PiArwqDCoMKgIHVpbnQ2NF90IG5vX3Jlc2l6ZSA9IEJMS19QRVJNX0NPTlNJU1RF
TlRfUkVBRCB8IEJMS19QRVJNX1dSSVRFIHwNCj4+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEJMS19QRVJNX1dSSVRFX1VOQ0hBTkdFRCB8IEJM
S19QRVJNX0dSQVBIX01PRDsNCj4+Pj4+PiArwqDCoMKgIEJkcnZEaXJ0eUJpdG1hcCAqY29weV9i
aXRtYXA7DQo+Pj4+Pj4gKw0KPj4+Pj4+ICvCoMKgwqAgY29weV9iaXRtYXAgPSBiZHJ2X2NyZWF0
ZV9kaXJ0eV9iaXRtYXAoc291cmNlLCBjbHVzdGVyX3NpemUsIE5VTEwsIGVycnApOw0KPj4+Pj4+
ICvCoMKgwqAgaWYgKCFjb3B5X2JpdG1hcCkgew0KPj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCByZXR1
cm4gTlVMTDsNCj4+Pj4+PiArwqDCoMKgIH0NCj4+Pj4+PiArwqDCoMKgIGJkcnZfZGlzYWJsZV9k
aXJ0eV9iaXRtYXAoY29weV9iaXRtYXApOw0KPj4+Pj4+ICsNCj4+Pj4+PiArwqDCoMKgIHMgPSBn
X25ldyhCbG9ja0NvcHlTdGF0ZSwgMSk7DQo+Pj4+Pj4gK8KgwqDCoCAqcyA9IChCbG9ja0NvcHlT
dGF0ZSkgew0KPj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCAuc291cmNlID0gYmxrX25ldyhiZHJ2X2dl
dF9haW9fY29udGV4dChzb3VyY2UpLA0KPj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBCTEtfUEVSTV9DT05TSVNURU5UX1JFQUQsIG5vX3Jl
c2l6ZSksDQo+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIC50YXJnZXQgPSBibGtfbmV3KGJkcnZfZ2V0
X2Fpb19jb250ZXh0KHRhcmdldCksDQo+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEJMS19QRVJNX1dSSVRFLCBub19yZXNpemUpLA0KPj4+
Pj4+ICvCoMKgwqDCoMKgwqDCoCAuY29weV9iaXRtYXAgPSBjb3B5X2JpdG1hcCwNCj4+Pj4+PiAr
wqDCoMKgwqDCoMKgwqAgLmNsdXN0ZXJfc2l6ZSA9IGNsdXN0ZXJfc2l6ZSwNCj4+Pj4+PiArwqDC
oMKgwqDCoMKgwqAgLmxlbiA9IGJkcnZfZGlydHlfYml0bWFwX3NpemUoY29weV9iaXRtYXApLA0K
Pj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCAud3JpdGVfZmxhZ3MgPSB3cml0ZV9mbGFncywNCj4+Pj4+
PiArwqDCoMKgwqDCoMKgwqAgLnVzZV9jb3B5X3JhbmdlID0gISh3cml0ZV9mbGFncyAmIEJEUlZf
UkVRX1dSSVRFX0NPTVBSRVNTRUQpLA0KPj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCAucHJvZ3Jlc3Nf
Ynl0ZXNfY2FsbGJhY2sgPSBwcm9ncmVzc19ieXRlc19jYWxsYmFjaywNCj4+Pj4+PiArwqDCoMKg
wqDCoMKgwqAgLnByb2dyZXNzX3Jlc2V0X2NhbGxiYWNrID0gcHJvZ3Jlc3NfcmVzZXRfY2FsbGJh
Y2ssDQo+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIC5wcm9ncmVzc19vcGFxdWUgPSBwcm9ncmVzc19v
cGFxdWUsDQo+Pj4+Pj4gK8KgwqDCoCB9Ow0KPj4+Pj4+ICsNCj4+Pj4+PiArwqDCoMKgIHMtPmNv
cHlfcmFuZ2Vfc2l6ZSA9IFFFTVVfQUxJR05fVVAoTUlOKGJsa19nZXRfbWF4X3RyYW5zZmVyKHMt
PnNvdXJjZSksDQo+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBibGtfZ2V0X21h
eF90cmFuc2ZlcihzLT50YXJnZXQpKSwNCj4+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzLT5j
bHVzdGVyX3NpemUpOw0KPj4+Pj4NCj4+Pj4+IHByZWV4aXN0ZW50LCBidXQgaXQgb2J2aW91c2x5
IHNob3VsZCBiZSBRRU1VX0FMSUdOX0RPV04uIEkgY2FuIHJlc2VuZCB3aXRoIGEgc2VwYXJhdGUN
Cj4+Pj4+IGZpeCwgaXQgbWF5IGJlIGZpeGVkIHdoaWxlIHF1ZXVpbmcgKGlmIHJlc2VuZCBpcyBu
b3QgbmVlZGVkIGZvciBvdGhlciByZWFzb25zKSBvcg0KPj4+Pj4gSSdsbCBzZW5kIGEgZm9sbG93
LXVwIGZpeCBsYXRlciwgd2hpY2hldmVyIHlvdSBwcmVmZXIuDQo+Pj4+DQo+Pj4+IEhtLCB0cnVl
LsKgIEJ1dCB0aGVuIHdl4oCZbGwgYWxzbyBuZWVkIHRvIGhhbmRsZSB0aGUgKHVubGlrZWx5LCBh
ZG1pdHRlZGx5KQ0KPj4+PiBjYXNlIHdoZXJlIG1heF90cmFuc2ZlciA8IGNsdXN0ZXJfc2l6ZSBz
byB0aGlzIHdvdWxkIHRoZW4gcmV0dXJuIDAgKGJ5DQo+Pj4+IHNldHRpbmcgdXNlX2NvcHlfcmFu
Z2UgPSBmYWxzZSkuwqAgU28gaG93IGFib3V0IHRoaXM6DQo+Pj4NCj4+PiBEb25lIGluIFtQQVRD
SCB2MTIgMC8yXSBiYWNrdXA6IGNvcHlfcmFuZ2UgZml4ZXMuDQo+Pj4gSWYgaXQgaXMgY29udmVu
aWVudCBJJ2xsIHJlYmFzZSB0aGVzZSBzZXJpZXMgb24gIltQQVRDSCB2MTIgMC8yXSBiYWNrdXA6
IGNvcHlfcmFuZ2UgZml4ZXMiDQo+IA0KPiBPaCwgZ29vZC4NCj4gDQo+IEkgdGhpbmsgdGFraW5n
IGNvcHlfcmFuZ2UgZml4ZXMgZmlyc3Qgd291bGQgbWFrZSBtb3JlIHNlbnNlLiAgSXQgc2VlbXMN
Cj4gdGhhdCBKb2huIHN0aWxsIGhhZCBzb21lIHN1Z2dlc3Rpb24gZm9yIGl0Li4uPw0KPiANCj4g
TWF4DQo+IA0KDQpGaW5hbGx5LCBvbmx5IHdvcmRpbmcgb2YgdGhlIGNvbW1lbnQuIEkgdGhpbmss
IEkgY2FuIHJlc2VuZCBjb21iaW5lZCBzZXJpZXMgd2l0aCBteSBmaW5hbCBzdWdnZXN0aW9uDQpv
ZiB0aGUgY29tbWVudCAoYSBiaXQgdHdlYWtlZCBKb2huJ3Mgb25lKS4NCg0KLS0gDQpCZXN0IHJl
Z2FyZHMsDQpWbGFkaW1pcg0K

