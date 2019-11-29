Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A531C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 16:27:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C742921736
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 16:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="AwUJkAKF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C742921736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaj71-0000MR-Rk
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 11:27:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44214)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iaiGX-0007Ue-28
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 10:33:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iaiGS-0004oO-A2
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 10:33:02 -0500
Received: from mail-eopbgr140097.outbound.protection.outlook.com
 ([40.107.14.97]:2362 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iaiGQ-0004jD-Nm
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 10:33:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O/fZJ0XE8Hlkv+YDjuitb2g9tWJk1I94WsncZHPH7tq5tkO/XtpC06ap8vJryb2rGS62JfD80gGTngv60GookB/ctLus1hqImnqMzRrYratP/VJQDHHddl9i+ySUyGzLJL5ahO0MtN8PqmChHe9oJY6SbPMG+7TY7S0oDGPytS8aTJAR0QLw3dOHwqk3s2EaIvp2uN8o57AWiEDxQsxe8pTILANHvw8Q9XOPqzCvIRxqQISRLga/YZS1g3p2f+P930TNMATWldZQpgW0ay1gHeJtmIZhIt3vRLOE+gS2MoxB4K4q0aJsK9alfHI5I0Iqdm12Edf7sjLBHzgD9VEbWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LdpSCJ3n/TUGLM2GED6sb1DM2xlt72ik2YH9HlR8Rp4=;
 b=jMa4SYzcKVAteUMEdVquAY4zox73pwnCrcDL8zKz6v2mrlEyxpjQ7uYY3acyV+63Mw8sAN4U7+Vb876zfHCCsHdDl19x+Q6ar4LQp+dAvFSLW1w8qQEFRBTd3TkRrd87AcETAqwaxVdvMzLc5uPdRQRYnbeF0f49PFT4kvPlu1pLnEqB0ELaS+w2YhrkjL+eFleH0FTlLFOD/9OtLKv/BWp53BOPkW9v+J+s8Yr9FTl3WKA6WDj6rwXsP5QnA2T2QHQVr5TRWWRoPS2KZV9CXiSa5ziIkzhl/oF4InvKWf3nyrzqJtit7lhVAAw/zFrwSIUU9F/+wup6DAxyEQrkAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LdpSCJ3n/TUGLM2GED6sb1DM2xlt72ik2YH9HlR8Rp4=;
 b=AwUJkAKFGSICzKx67DWdEB6Om1cZF5tX0UERGoFT0IMn9zeKmhC6dS6XZF7HI4o2zAi9Yhq72xkNB1D7pgZkqblBfDKcQx3m9M82oV1iaUGd6WthPsKh9zOVtcQueL4LFKKH4nmFTciihsnsCrcy/UHz44jGAHdn2HsDZZIIjHQ=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4881.eurprd08.prod.outlook.com (10.255.97.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.17; Fri, 29 Nov 2019 15:32:53 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f%3]) with mapi id 15.20.2495.014; Fri, 29 Nov 2019
 15:32:53 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v6] hw/core/loader-fit: fix freeing errp in fit_load_fdt
Thread-Topic: [PATCH v6] hw/core/loader-fit: fix freeing errp in fit_load_fdt
Thread-Index: AQHVpVDHCu/hcnUjHUWYtvuOQu9NH6eiMNjUgAA0gICAAABlAP//4aT7gAACgQA=
Date: Fri, 29 Nov 2019 15:32:53 +0000
Message-ID: <988bff55-1f94-ac29-6193-7de13b2feca0@virtuozzo.com>
References: <20191127183016.13852-1-vsementsov@virtuozzo.com>
 <87muceeq5l.fsf@dusky.pond.sub.org>
 <4fcd8245-790e-220d-366b-ce25743dddc8@virtuozzo.com>
 <48c23c62-59ed-3da7-4803-cafd14b8fe49@virtuozzo.com>
 <87tv6mbta9.fsf@dusky.pond.sub.org>
In-Reply-To: <87tv6mbta9.fsf@dusky.pond.sub.org>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR09CA0073.eurprd09.prod.outlook.com
 (2603:10a6:7:3d::17) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191129183250268
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 311e674b-ea88-4ead-97be-08d774e16674
x-ms-traffictypediagnostic: AM6PR08MB4881:
x-microsoft-antispam-prvs: <AM6PR08MB488141EF8B12B317EB793FF1C1460@AM6PR08MB4881.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0236114672
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(376002)(346002)(136003)(366004)(39840400004)(199004)(189003)(64756008)(66446008)(76176011)(86362001)(229853002)(66556008)(81156014)(26005)(66946007)(31696002)(6116002)(8676002)(66476007)(81166006)(102836004)(6506007)(446003)(25786009)(3846002)(8936002)(186003)(66066001)(6916009)(52116002)(54906003)(6486002)(71200400001)(71190400001)(99286004)(256004)(14444005)(6512007)(11346002)(386003)(36756003)(31686004)(7736002)(14454004)(5660300002)(2906002)(305945005)(2616005)(316002)(478600001)(6246003)(4326008)(6436002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4881;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lyM4ypsMsij/wrKKbHUUiiDEdokby0pLBTBHscVGfE1NRNqa8tgEhs0FhHPkmhkvgsnbi9XGlCw2w5SPaXu900F7pEWsj3xthPE1t+0lRIG4CBobXAO6VfGBL+kWgtnhxe0EnYdPv5QWEVzx/0e83bWBDVFrAlDF61tOUQRDoyTKmhadepvIq7yaGxIgDV2SHmcAfChoFMW4vXEhPYdCuSBdGD3gfvqsTUykuziqwZ5flB0NrY9SplJOqwaWt5kwtcaSqq7pPopknqDSEHV+ceXwFQh4kHH7asukF9L4PBRrP8ggD0vWpAX0OTFFRYchBICY/7yh38WwC1hFznHWX0ZBzoPuoeAR8DoWhtkJrMDkiwkcnOQYOyCKYv1VWmVyMv8zoqUq+Iisjq4fIS9c+7HqIiOZKzTXOIXZw6ORxewPbaygQ6CQ1/dVD2xe4nlw
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <365722A2F7ED054D9D2659CBFF756077@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 311e674b-ea88-4ead-97be-08d774e16674
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2019 15:32:53.2934 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oAmYb2i26162DX716EvS8yoyt8a9hC2C9FA3NE4BTLa1CMjwYbZDIa8Iuyd6MEHezfGeB/Cd5aXF7u4SlQI9NU9uLFr0Q/m5agRKzHyIlFY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4881
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.14.97
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
Cc: "pburton@wavecomp.com" <pburton@wavecomp.com>,
 "aleksandar.rikalo@rt-rk.com" <aleksandar.rikalo@rt-rk.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjkuMTEuMjAxOSAxODoyMywgTWFya3VzIEFybWJydXN0ZXIgd3JvdGU6DQo+IFZsYWRpbWlyIFNl
bWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4gd3JpdGVzOg0KPiAN
Cj4+IDI5LjExLjIwMTkgMTc6MTEsIFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgd3JvdGU6
DQo+Pj4gMjkuMTEuMjAxOSAxNzowMywgTWFya3VzIEFybWJydXN0ZXIgd3JvdGU6DQo+Pj4+IFZs
YWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4gd3Jp
dGVzOg0KPj4+Pg0KPj4+Pj4gZml0X2xvYWRfZmR0IGZvcmdldCB0byBjaGVjayB0aGF0IGVycnAg
aXMgbm90IE5VTEwgYW5kIHRvIHplcm8gaXQgYWZ0ZXINCj4+Pj4+IGZyZWVpbmcuIEZpeCBpdC4N
Cj4+Pj4+DQo+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5
IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+DQo+Pj4+PiBSZXZpZXdlZC1ieTogRXJpYyBCbGFr
ZSA8ZWJsYWtlQHJlZGhhdC5jb20+DQo+Pj4+PiAtLS0NCj4+Pj4+ICDCoCBody9jb3JlL2xvYWRl
ci1maXQuYyB8IDUgKysrKy0NCj4+Pj4+ICDCoCAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25z
KCspLCAxIGRlbGV0aW9uKC0pDQo+Pj4+Pg0KPj4+Pj4gZGlmZiAtLWdpdCBhL2h3L2NvcmUvbG9h
ZGVyLWZpdC5jIGIvaHcvY29yZS9sb2FkZXItZml0LmMNCj4+Pj4+IGluZGV4IDk1M2IxNmJjODIu
LjNlZTlmYjJmMmUgMTAwNjQ0DQo+Pj4+PiAtLS0gYS9ody9jb3JlL2xvYWRlci1maXQuYw0KPj4+
Pj4gKysrIGIvaHcvY29yZS9sb2FkZXItZml0LmMNCj4+Pj4+IEBAIC0yMDAsNyArMjAwLDEwIEBA
IHN0YXRpYyBpbnQgZml0X2xvYWRfZmR0KGNvbnN0IHN0cnVjdCBmaXRfbG9hZGVyICpsZHIsIGNv
bnN0IHZvaWQgKml0YiwNCj4+Pj4+ICDCoMKgwqDCoMKgIGVyciA9IGZpdF9pbWFnZV9hZGRyKGl0
YiwgaW1nX29mZiwgImxvYWQiLCAmbG9hZF9hZGRyLCBlcnJwKTsNCj4+Pj4+ICDCoMKgwqDCoMKg
IGlmIChlcnIgPT0gLUVOT0VOVCkgew0KPj4+Pj4gIMKgwqDCoMKgwqDCoMKgwqDCoCBsb2FkX2Fk
ZHIgPSBST1VORF9VUChrZXJuZWxfZW5kLCA2NCAqIEtpQikgKyAoMTAgKiBNaUIpOw0KPj4+Pj4g
LcKgwqDCoMKgwqDCoMKgIGVycm9yX2ZyZWUoKmVycnApOw0KPj4+Pj4gK8KgwqDCoMKgwqDCoMKg
IGlmIChlcnJwKSB7DQo+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBlcnJvcl9mcmVlKCpl
cnJwKTsNCj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICplcnJwID0gTlVMTDsNCj4+Pj4+
ICvCoMKgwqDCoMKgwqDCoCB9DQo+Pj4+PiAgwqDCoMKgwqDCoCB9IGVsc2UgaWYgKGVycikgew0K
Pj4+Pj4gIMKgwqDCoMKgwqDCoMKgwqDCoCBlcnJvcl9wcmVwZW5kKGVycnAsICJ1bmFibGUgdG8g
cmVhZCBGRFQgbG9hZCBhZGRyZXNzIGZyb20gRklUOiAiKTsNCj4+Pj4+ICDCoMKgwqDCoMKgwqDC
oMKgwqAgcmV0ID0gZXJyOw0KPj4+Pg0KPj4+PiBUaGlzIGZpeGVzIGxhdGVudCBidWdzIHdoZW4g
Zml0X2ltYWdlX2FkZHIoKSBmYWlscyB3aXRoIEVOT0VOVDoNCj4+Pj4NCj4+Pj4gKiBJZiBhIGNh
bGxlciBwYXNzZXMgYSBudWxsIEBlcnJwLCB3ZSBjcmFzaCBkZXJlZmVyZW5jaW5nIGl0DQo+Pj4+
DQo+Pj4+ICogRWxzZSwgd2UgcGFzcyBhIGRhbmdsaW5nIEVycm9yICogdG8gdGhlIGNhbGxlciwg
YW5kIHJldHVybiBzdWNjZXNzLg0KPj4+PiAgwqDCoCBJZiBhIGNhbGxlciBkZXJlZmVyZW5jZXMg
dGhlIEVycm9yICogcmVnYXJkbGVzcywgd2UgaGF2ZSBhDQo+Pj4+ICDCoMKgIHVzZS1hZnRlci1m
cmVlLg0KPj4+Pg0KPj4+PiBOb3QgZml4ZWQ6DQo+Pj4+DQo+Pj4+ICogSWYgYSBjYWxsZXIgcGFz
c2VzICZlcnJvcl9hYm9ydCBvciAmZXJyb3JfZmF0YWwsIHdlIGRpZSBpbnN0ZWFkIG9mDQo+Pj4+
ICDCoMKgIHRha2luZyB0aGUgcmVjb3ZlcnkgcGF0aC4NCj4+Pg0KPj4+IE5vLCBpZiBpdCBpcyBl
cnJvcl9hYm9ydCBvciBlcnJvcl9mYXRhbCwgd2Ugd2lsbCBub3QgcmVhY2ggdGhpcyBwb2ludCwg
dGhlIGV4ZWN1dGlvbg0KPj4+IGZpbmlzaGVkIGJlZm9yZSwgd2hlbiBlcnJvciB3YXMgc2V0Lg0K
Pj4NCj4+IEFoLCB0aGF0IGlzIHdoYXQgeW91IG1lbnRpb24uLiBIbW0uIElzIGl0IGJhZD8gQXQg
bGVhc3QgY3Jhc2hpbmcgb24NCj4+IGVycm9yX2Fib3J0IHdpdGhvdXQgYW55IHJlY292ZXJ5IHNo
b3VsZCBub3QgYmUgYmFkLi4NCj4gDQo+IExhdGVudCBidWdzIGFyZW4ndCBiYWQsIGJ1dCB0aGV5
IGNvdWxkIHBvc3NpYmx5IGJlY29tZSBiYWQgOikNCj4gDQo+IFdoZW4geW91IHBhc3MgJmVyciB0
byBmaXRfbG9hZF9mZHQoKSwgd2hlcmUgQGVyciBpcyBhIGxvY2FsIHZhcmlhYmxlLA0KPiB0aGUg
RU5PRU5UIGNhc2UgaXMgbm90IGFjdHVhbGx5IGFuIGVycm9yOyBmaXRfbG9hZF9mZHQoKSByZWNv
dmVycyBmaW5lDQo+IGFuZCBzdWNjZWVkcy4NCj4gDQo+IFdoZW4geW91IHBhc3MgJmVycm9yX2Zh
dGFsIG9yICZlcnJvcl9hYm9ydCwgaXQgc2hvdWxkIGxpa2V3aXNlIG5vdCBiZSBhbg0KPiBlcnJv
ci4NCg0KQWgsIHllcywgdW5kZXJzdGFuZCBub3cuDQoNCkludGVyZXN0aW5nLCB0aGF0IGF1dG8t
cHJvcGFnZXRlZCBlcnJwIHdpbGwgbm90IGNhdGNoIHRoaXMuIEl0IHdpbGwgb25seQ0KaGVscCB3
aXRoIGVycm9yX2ZhdGFsLCBidXQgbm90IHdpdGggZXJyb3JfYWJvcnQuLg0KDQpTbywgaW4gdGhp
cyBjYXNlIHdlIHNob3VsZCB3cmFwIGVycm9yX2Fib3J0IHRvby4gQW5kIGl0IGluIGV2ZXJ5IGZ1
bmN0aW9uIHRoYXQNCnVzZXMgZXJyb3JfZnJlZS4NCg0KQW5kIHRoaXMgbWVhbnMsIHRoYXQgaW4g
dGhpcyBjYXNlIHdlIGNhbid0IG1ha2UgZXJyb3JfYWJvcnQgY3Jhc2ggYXQgcG9pbnQgd2hlcmUN
CmFjdHVhbCBlcnJvciBvY2N1cmVzLiBUaGF0IGlzIHZlcnkgc2FkLg0KDQo+IA0KPiBHZW5lcmFs
IHJ1bGU6IHdoZW4geW91IHdhbnQgdG8gaGFuZGxlIHNvbWUgKG9yIGFsbCkgb2YgYSBmdW5jdGlv
bidzDQo+IGVycm9ycyB5b3Vyc2VsZiwgeW91IG11c3Qgbm90IHBhc3MgeW91ciBvd24gQGVycnAg
YXJndW1lbnQuICBJbnN0ZWFkLA0KPiBwYXNzICZlcnIgYW5kIHByb3BhZ2F0ZSB0aGUgZXJyb3Jz
IHlvdSBkb24ndCBoYW5kbGUgeW91cnNlbGYgd2l0aA0KPiBlcnJvcl9wcm9wYWdhdGUoZXJycCwg
ZXJyKS4NCj4gDQo+Pj4+IFdlIG5lZWQgdG8gdXNlIGEgbG9jYWxfZXJyIGhlcmUuDQo+Pj4+DQo+
Pj4+IEknbGwgc2VhcmNoIGZvciB0aGUgcGF0dGVybiwgYW5kIHBvc3QgZml4KGVzKS4NCj4gDQo+
IEZvdW5kIHNldmVyYWwgYnVncyBhbHJlYWR5Li4uDQo+IA0KDQoNCi0tIA0KQmVzdCByZWdhcmRz
LA0KVmxhZGltaXINCg==

