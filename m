Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 665EDCA9EA9
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 16:13:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2038B21D7C
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 16:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Dk+Vg8gC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2038B21D7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLUsM-0000nw-9F
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 12:13:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48575)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iLUnD-0003Hl-9R
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 12:07:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iLUnB-00069v-Lp
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 12:07:55 -0400
Received: from mail-eopbgr70108.outbound.protection.outlook.com
 ([40.107.7.108]:18153 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iLUnA-00067e-Nw; Fri, 18 Oct 2019 12:07:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T+9ciaUXnFG7i4ERQQfDPZJCK+4zLi3jNNDiAm4VkIOkSwDSw8RXJIQ00wnHTGrE+xJGRXVDflk/F9YNG9C4ao4VamVeZ9GrJZbu6NRIq4+qazhUbtuJDj427HUEiTSsCMLk2evvKf0KGk/Q6pkU/SXYluEMAOOGY5pvrxjTeWrNrd+uI23ukNpm/nhDilEBfwar4sOjcitPVf4wTnybXowBOMc9LZwybZf9pZ10mLR7Zmd2qqA61cUsjHMREVf0Nme01xVpvyDouj8Ok/wg2zdsI3rD5nXCAgOpv0q4UOhY81rHfWKyuP+bDKZe2XublwXpjOfvQmXTYDYART47lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vauwSK3nOMw7npSZ7F8Mqth5mcG5fEuRh6ndzIX/BqA=;
 b=MyrVoiOcZ/QGxOGxCKL7pLF5S7/v73/86QkbCdDDMqfwD+7Guv3eDEweX6HcmfXTRhmnzhleCgGqbWICAUz/5FWg6kl4Zy0WF3On7/6mH9whAJiI4bDUqTA9D6zRkian8Ogyj7yeWVlgkUctdmcAvt6eHs94eEqUbwYQNoyd4gvB8Bxlct7vsL96Xs1wVjSSwUm4JLE6Ed9R67I7jaaxKmCGVJ6/gJq98obRf0Cqbeu4f0Xn+Bcgc/pWL+1sbHbXr1/ARtngx0Mu7yr/BRb5lxnmH6cBAZ9VYFSfSMhp66Zp8qtHQPj7SiB815avrUwPUflLz1SJan6AQKSxm61OYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vauwSK3nOMw7npSZ7F8Mqth5mcG5fEuRh6ndzIX/BqA=;
 b=Dk+Vg8gCbMH1dwErhlqO+5ry35UIabL1qhlRr0Y6w4VqKOJJr5ifwtBPeJyW+RU3CeB6BX5aF6foH2iAp1a3SHj/X1fkEGrPK0QtXNR0UYFZ4aUC5UpaXxWNdZ8NCY8XzDcMXL0Def9KKUCmAu4URVtS1zzO4nq/6T7Vd/vEKcg=
Received: from AM0PR08MB4435.eurprd08.prod.outlook.com (20.179.35.83) by
 AM0PR08MB5458.eurprd08.prod.outlook.com (52.132.214.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Fri, 18 Oct 2019 16:07:50 +0000
Received: from AM0PR08MB4435.eurprd08.prod.outlook.com
 ([fe80::4461:dd32:b358:110c]) by AM0PR08MB4435.eurprd08.prod.outlook.com
 ([fe80::4461:dd32:b358:110c%7]) with mapi id 15.20.2347.026; Fri, 18 Oct 2019
 16:07:50 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH 08/10] nbd/server: introduce NBDExtentArray
Thread-Topic: [PATCH 08/10] nbd/server: introduce NBDExtentArray
Thread-Index: AQHVd6Ha2eAgWRw6rUmmfrR6kvnayKdSl1OAgA4VxoA=
Date: Fri, 18 Oct 2019 16:07:49 +0000
Message-ID: <ffee3ef7-d931-bcac-be82-2ae3533aa981@virtuozzo.com>
References: <20190930151502.7829-1-vsementsov@virtuozzo.com>
 <20190930151502.7829-9-vsementsov@virtuozzo.com>
 <c56a7e0c-50df-1ad7-6c6e-d4c3fe52132f@redhat.com>
In-Reply-To: <c56a7e0c-50df-1ad7-6c6e-d4c3fe52132f@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P190CA0033.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:52::22)
 To AM0PR08MB4435.eurprd08.prod.outlook.com
 (2603:10a6:208:144::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191018190747819
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a364e778-e08d-4646-ea26-08d753e552bf
x-ms-traffictypediagnostic: AM0PR08MB5458:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR08MB5458F882F9E054A63820E1DAC16C0@AM0PR08MB5458.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01949FE337
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(39850400004)(396003)(136003)(376002)(346002)(189003)(199004)(26005)(52116002)(2501003)(305945005)(8936002)(7736002)(71190400001)(71200400001)(102836004)(186003)(31696002)(4326008)(76176011)(86362001)(99286004)(6246003)(53546011)(386003)(36756003)(54906003)(6506007)(316002)(107886003)(66066001)(8676002)(81166006)(81156014)(31686004)(66446008)(14454004)(5660300002)(229853002)(2906002)(64756008)(25786009)(110136005)(66476007)(66556008)(478600001)(6436002)(66946007)(486006)(6512007)(2616005)(476003)(6486002)(11346002)(446003)(3846002)(14444005)(256004)(6116002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB5458;
 H:AM0PR08MB4435.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rZvGMwtSsOzSY5GF9VwGPmDDT5KRKfNAiJ6r8cJnjZYJZhHcjBD9AYxAIlYOYS+v1VrPKDO1bCdweg41IElzRRzuw66oZzMKr8fxRZNFIaf54LxnV5PulxnLVPK80NJMBTX0Vu1eX06kOarDdTmUMl1ZtANebUmx9zok4RW8TwzXcJUu75IuPwvtvh79TqW9x+fEd8LfY3fKSgqEugr/H+J4Vca7h3TadZVyEHIV9EAl0Q1WWsn0QAWayhy+9ZlpPSvmsa8Cr0QwD60i8fjiW6qTlHHWQ5xpK9leBCvALDsjplUFoU26KfZogBP9E6oC6e3SIwLJ3g3SCGa6Mi4hgHiVB146fudl1KM0mg8Pb73NkNMRU9DbtwGZddMIh+RG+2B8Cttf/bN9pABZqRnWTRPatinb1nY34QsHRT4BRZ0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <949540F033698E4C9CA122C9D118577A@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a364e778-e08d-4646-ea26-08d753e552bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2019 16:07:49.9498 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wVmP78Pfg4P9O+YTDhm5lFMSpjoIkxtl8j+Uc0DR8HcTudgeUd6XRyGHb9npk0yh3HKZeCh6pJcRIZ8KD7qe4snrZlqLhMpUq0wpIzZ6qdk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5458
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.108
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, "fam@euphon.net" <fam@euphon.net>,
 Denis Lunev <den@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDkuMTAuMjAxOSAyMDowMiwgRXJpYyBCbGFrZSB3cm90ZToNCj4gT24gOS8zMC8xOSAxMDoxNSBB
TSwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IEludHJvZHVjZSBOQkRF
eHRlbnRBcnJheSBjbGFzcywgdG8gaGFuZGxlIGV4dGVudHMgbGlzdCBjcmVhdGlvbiBpbiBtb3Jl
DQo+PiBjb250cm9sbGVkIHdheSBhbmQgd2l0aCBsZXNzIE9VVCBwYXJhbWV0ZXJzIGluIGZ1bmN0
aW9ucy4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5
IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+DQo+PiAtLS0NCj4+IMKgIG5iZC9zZXJ2ZXIuYyB8
IDE4NCArKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0N
Cj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCA5MCBpbnNlcnRpb25zKCspLCA5NCBkZWxldGlvbnMoLSkN
Cj4+DQo+IA0KPj4gK3N0YXRpYyB2b2lkIG5iZF9leHRlbnRfYXJyYXlfZnJlZShOQkRFeHRlbnRB
cnJheSAqZWEpDQo+PiArew0KPj4gK8KgwqDCoCBnX2ZyZWUoZWEtPmV4dGVudHMpOw0KPj4gK8Kg
wqDCoCBnX2ZyZWUoZWEpOw0KPj4gK30NCj4+ICtHX0RFRklORV9BVVRPUFRSX0NMRUFOVVBfRlVO
QyhOQkRFeHRlbnRBcnJheSwgbmJkX2V4dGVudF9hcnJheV9mcmVlKTsNCj4gDQo+IE5pY2UgdG8g
c2VlIHRoaXMgZ2V0dGluZyBtb3JlIHBvcHVsYXIgOikNCj4gDQo+PiArDQo+PiArc3RhdGljIGlu
dCBuYmRfZXh0ZW50X2FycmF5X2FkZChOQkRFeHRlbnRBcnJheSAqZWEsDQo+PiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdWlu
dDMyX3QgbGVuZ3RoLCB1aW50MzJfdCBmbGFncykNCj4+IMKgIHsNCj4gDQo+PiAtwqDCoMKgIGFz
c2VydCgqbmJfZXh0ZW50cyk7DQo+PiAtwqDCoMKgIHdoaWxlIChyZW1haW5pbmdfYnl0ZXMpIHsN
Cj4+ICvCoMKgwqAgaWYgKGVhLT5jb3VudCA+PSBlYS0+bmJfYWxsb2MpIHsNCj4+ICvCoMKgwqDC
oMKgwqDCoCByZXR1cm4gLTE7DQo+PiArwqDCoMKgIH0NCj4gDQo+IFJldHVybmluZyAtMSBpcyBu
b3QgYSBmYWlsdXJlIGluIHRoZSBwcm90b2NvbCwganVzdCBmYWlsdXJlIHRvIGFkZCBhbnkgbW9y
ZSBpbmZvcm1hdGlvbiB0byB0aGUgcmVwbHkuwqAgQSBmdW5jdGlvbiBjb21tZW50IG1pZ2h0IGhl
bHAsIGJ1dCB0aGlzIGxvb2tzIGxpa2UgYSBnb29kIGhlbHBlciBmdW5jdGlvbi4NCg0KU29tZXRo
aW5nIGxpa2UNCi8qDQogICogQWRkIGV4dGVudCB0byBOQkRFeHRlbnRBcnJheS4gSWYgZXh0ZW50
IGNhbid0IGJlIGFkZGVkIChubyBhdmFpbGFibGUgc3BhY2UpLA0KICAqIHJldHVybiAtMS4NCiAg
Ki8NCmFib3ZlIHRoZSBmdW5jdGlvbj8NCg0KPiANCj4+ICtzdGF0aWMgaW50IGJsb2Nrc3RhdHVz
X3RvX2V4dGVudHMoQmxvY2tEcml2ZXJTdGF0ZSAqYnMsIHVpbnQ2NF90IG9mZnNldCwNCj4+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgdWludDY0X3QgYnl0ZXMsIE5CREV4dGVudEFycmF5ICplYSkNCj4+ICt7DQo+PiAr
wqDCoMKgIHdoaWxlIChieXRlcykgew0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHVpbnQzMl90IGZs
YWdzOw0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGludDY0X3QgbnVtOw0KPj4gLcKgwqDCoMKgwqDC
oMKgIGludCByZXQgPSBiZHJ2X2Jsb2NrX3N0YXR1c19hYm92ZShicywgTlVMTCwgb2Zmc2V0LCBy
ZW1haW5pbmdfYnl0ZXMsDQo+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAmbnVtLCBOVUxM
LCBOVUxMKTsNCj4+ICvCoMKgwqDCoMKgwqDCoCBpbnQgcmV0ID0gYmRydl9ibG9ja19zdGF0dXNf
YWJvdmUoYnMsIE5VTEwsIG9mZnNldCwgYnl0ZXMsICZudW0sDQo+PiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBOVUxMLCBOVUxMKTsNCj4gDQo+PiArwqDCoMKgwqDCoMKgwqAgaWYgKG5iZF9l
eHRlbnRfYXJyYXlfYWRkKGVhLCBudW0sIGZsYWdzKSA8IDApIHsNCj4+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHJldHVybiAwOw0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgIH0NCj4+IC3CoMKgwqDC
oMKgwqDCoCBvZmZzZXQgKz0gbnVtOw0KPj4gLcKgwqDCoMKgwqDCoMKgIHJlbWFpbmluZ19ieXRl
cyAtPSBudW07DQo+PiAtwqDCoMKgIH0NCj4+IC3CoMKgwqAgZXh0ZW50c19lbmQgPSBleHRlbnQg
KyAxOw0KPj4gLQ0KPj4gLcKgwqDCoCBmb3IgKGV4dGVudCA9IGV4dGVudHM7IGV4dGVudCA8IGV4
dGVudHNfZW5kOyBleHRlbnQrKykgew0KPj4gLcKgwqDCoMKgwqDCoMKgIGV4dGVudC0+ZmxhZ3Mg
PSBjcHVfdG9fYmUzMihleHRlbnQtPmZsYWdzKTsNCj4+IC3CoMKgwqDCoMKgwqDCoCBleHRlbnQt
Pmxlbmd0aCA9IGNwdV90b19iZTMyKGV4dGVudC0+bGVuZ3RoKTsNCj4+ICvCoMKgwqDCoMKgwqDC
oCBvZmZzZXQgKz0gbnVtOw0KPj4gK8KgwqDCoMKgwqDCoMKgIGJ5dGVzIC09IG51bTsNCj4+IMKg
wqDCoMKgwqAgfQ0KPj4gLcKgwqDCoCAqYnl0ZXMgLT0gcmVtYWluaW5nX2J5dGVzOw0KPj4gLcKg
wqDCoCAqbmJfZXh0ZW50cyA9IGV4dGVudHNfZW5kIC0gZXh0ZW50czsNCj4+IC0NCj4+IMKgwqDC
oMKgwqAgcmV0dXJuIDA7DQo+IA0KPiBBbHNvIGxvb2tzIGdvb2QgKHJldHVybiAwIGlmIHdlIHBv
cHVsYXRlZCB1bnRpbCB3ZSBlaXRoZXIgcmFuIG91dCBvZiByZXBseSBzcGFjZSBvciBvdXQgb2Yg
Ynl0ZXMgdG8gcmVwb3J0IG9uKS4NCj4gDQo+PiDCoCBzdGF0aWMgaW50IG5iZF9jb19zZW5kX2V4
dGVudHMoTkJEQ2xpZW50ICpjbGllbnQsIHVpbnQ2NF90IGhhbmRsZSwNCj4+IC3CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgTkJERXh0
ZW50ICpleHRlbnRzLCB1bnNpZ25lZCBpbnQgbmJfZXh0ZW50cywNCj4+IC3CoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdWludDY0X3Qg
bGVuZ3RoLCBib29sIGxhc3QsDQo+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVpbnQzMl90IGNvbnRleHRfaWQsIEVycm9yICoq
ZXJycCkNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgTkJERXh0ZW50QXJyYXkgKmVhLA0KPj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBib29sIGxhc3QsIHVp
bnQzMl90IGNvbnRleHRfaWQsIEVycm9yICoqZXJycCkNCj4+IMKgIHsNCj4+IMKgwqDCoMKgwqAg
TkJEU3RydWN0dXJlZE1ldGEgY2h1bms7DQo+PiAtDQo+PiArwqDCoMKgIHNpemVfdCBsZW4gPSBl
YS0+Y291bnQgKiBzaXplb2YoZWEtPmV4dGVudHNbMF0pOw0KPj4gK8KgwqDCoCBnX2F1dG9mcmVl
IE5CREV4dGVudCAqZXh0ZW50cyA9IGdfbWVtZHVwKGVhLT5leHRlbnRzLCBsZW4pOw0KPiANCj4g
V2h5IGRvIHdlIG5lZWQgbWVtZHVwIGhlcmU/wqAgV2hhdCdzIHdyb25nIHdpdGggbW9kaWZ5aW5n
IGVhLT5leHRlbnRzIGluIHBsYWNlPy4uLg0KDQpUbyBub3QgbWFrZSBlYSB0byBiZSBJTi1PVVQg
cGFyYW1ldGVyLi4gSSBkb24ndCBsaWtlIGZ1bmN0aW9ucyB3aXRoIHNpZGUgZWZmZWN0cy4NCkl0
IHdpbGwgYnJlYWsgdGhlIGNvZGUgaWYgYXQgc29tZSBwb2ludCB3ZSBjYWxsIG5iZF9jb19zZW5k
X2V4dGVudHMgdHdpY2Ugb24gc2FtZQ0KZWEgb2JqZWN0Lg0KDQpXaGF0IGlzIHRoZSB0cnVlIHdh
eT8gVG8gbm90IG1lbWR1cCwgbmJkX2NvX3NlbmRfZXh0ZW50cyBzaG91bGQgY29uc3VtZSB0aGUg
d2hvbGUNCmVhIG9iamVjdC4uDQoNClNlZW1zLCBnX2F1dG9wdHIgYXR0cmlidXRlIGNhbid0IGJl
IHVzZWQgZm9yIGZ1bmN0aW9uIHBhcmFtZXRlciwgZ2NjIGNvbXBsYWluczoNCm5iZC9zZXJ2ZXIu
YzoxOTgzOjMyOiBlcnJvcjog4oCYY2xlYW51cOKAmSBhdHRyaWJ1dGUgaWdub3JlZCBbLVdlcnJv
cj1hdHRyaWJ1dGVzXQ0KICAxOTgzIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGdf
YXV0b3B0cihOQkRFeHRlbnRBcnJheSkgZWEsDQogICAgICAgfCAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgXn5+fn5+fn5+DQoNCnNvLCBpcyBpdCBiZXR0ZXINCnRvIGNhbGwgbmJkX2Nv
X3NlbmRfZXh0ZXJuYWwoLi4uIGdfc3RlYWxfcG9pbnRlcigmZWEpIC4uLikNCg0KYW5kIHRoYW4g
aW4gbmJkX2NvX3NlbmRfZXh0ZXJuYWwgZG8NCg0KZ19hdXRvcHRyKE5CREV4dGVudEFycmF5KSBs
b2NhbF9lYSA9IGVhOw0KTkJERXh0ZW50ICpleHRlbnRzID0gbG9jYWxfZWEtPmV4dGVudHM7DQoN
Cj8NCg0KDQo+IA0KPj4gK8KgwqDCoCBOQkRFeHRlbnQgKmV4dGVudCwgKmV4dGVudHNfZW5kID0g
ZXh0ZW50cyArIGVhLT5jb3VudDsNCj4+IMKgwqDCoMKgwqAgc3RydWN0IGlvdmVjIGlvdltdID0g
ew0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHsuaW92X2Jhc2UgPSAmY2h1bmssIC5pb3ZfbGVuID0g
c2l6ZW9mKGNodW5rKX0sDQo+PiAtwqDCoMKgwqDCoMKgwqAgey5pb3ZfYmFzZSA9IGV4dGVudHMs
IC5pb3ZfbGVuID0gbmJfZXh0ZW50cyAqIHNpemVvZihleHRlbnRzWzBdKX0NCj4+ICvCoMKgwqDC
oMKgwqDCoCB7Lmlvdl9iYXNlID0gZXh0ZW50cywgLmlvdl9sZW4gPSBsZW59DQo+PiDCoMKgwqDC
oMKgIH07DQo+PiAtwqDCoMKgIHRyYWNlX25iZF9jb19zZW5kX2V4dGVudHMoaGFuZGxlLCBuYl9l
eHRlbnRzLCBjb250ZXh0X2lkLCBsZW5ndGgsIGxhc3QpOw0KPj4gK8KgwqDCoCBmb3IgKGV4dGVu
dCA9IGV4dGVudHM7IGV4dGVudCA8IGV4dGVudHNfZW5kOyBleHRlbnQrKykgew0KPj4gK8KgwqDC
oMKgwqDCoMKgIGV4dGVudC0+ZmxhZ3MgPSBjcHVfdG9fYmUzMihleHRlbnQtPmZsYWdzKTsNCj4+
ICvCoMKgwqDCoMKgwqDCoCBleHRlbnQtPmxlbmd0aCA9IGNwdV90b19iZTMyKGV4dGVudC0+bGVu
Z3RoKTsNCj4+ICvCoMKgwqAgfQ0KPj4gKw0KPj4gK8KgwqDCoCB0cmFjZV9uYmRfY29fc2VuZF9l
eHRlbnRzKGhhbmRsZSwgZWEtPmNvdW50LCBjb250ZXh0X2lkLCBlYS0+dG90YWxfbGVuZ3RoLA0K
Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgbGFzdCk7DQo+PiDCoMKgwqDCoMKgIHNldF9iZV9jaHVuaygmY2h1bmsuaCwgbGFzdCA/
IE5CRF9SRVBMWV9GTEFHX0RPTkUgOiAwLA0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIE5CRF9SRVBMWV9UWVBFX0JMT0NLX1NUQVRVUywNCj4+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBoYW5kbGUsIHNpemVvZihjaHVuaykgLSBzaXplb2YoY2h1
bmsuaCkgKyBpb3ZbMV0uaW92X2xlbik7DQo+PiBAQCAtMTk5NCwzOSArMjAxMiwyNyBAQCBzdGF0
aWMgaW50IG5iZF9jb19zZW5kX2Jsb2NrX3N0YXR1cyhOQkRDbGllbnQgKmNsaWVudCwgdWludDY0
X3QgaGFuZGxlLA0KPj4gwqAgew0KPj4gwqDCoMKgwqDCoCBpbnQgcmV0Ow0KPj4gwqDCoMKgwqDC
oCB1bnNpZ25lZCBpbnQgbmJfZXh0ZW50cyA9IGRvbnRfZnJhZ21lbnQgPyAxIDogTkJEX01BWF9C
TE9DS19TVEFUVVNfRVhURU5UUzsNCj4+IC3CoMKgwqAgTkJERXh0ZW50ICpleHRlbnRzID0gZ19u
ZXcoTkJERXh0ZW50LCBuYl9leHRlbnRzKTsNCj4+IC3CoMKgwqAgdWludDY0X3QgZmluYWxfbGVu
Z3RoID0gbGVuZ3RoOw0KPj4gK8KgwqDCoCBnX2F1dG9wdHIoTkJERXh0ZW50QXJyYXkpIGVhID0g
bmJkX2V4dGVudF9hcnJheV9uZXcobmJfZXh0ZW50cyk7DQo+PiAtwqDCoMKgIHJldCA9IGJsb2Nr
c3RhdHVzX3RvX2V4dGVudHMoYnMsIG9mZnNldCwgJmZpbmFsX2xlbmd0aCwgZXh0ZW50cywNCj4+
IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgICZuYl9leHRlbnRzKTsNCj4+ICvCoMKgwqAgcmV0ID0gYmxvY2tzdGF0dXNfdG9f
ZXh0ZW50cyhicywgb2Zmc2V0LCBsZW5ndGgsIGVhKTsNCj4+IMKgwqDCoMKgwqAgaWYgKHJldCA8
IDApIHsNCj4+IC3CoMKgwqDCoMKgwqDCoCBnX2ZyZWUoZXh0ZW50cyk7DQo+PiDCoMKgwqDCoMKg
wqDCoMKgwqAgcmV0dXJuIG5iZF9jb19zZW5kX3N0cnVjdHVyZWRfZXJyb3IoDQo+PiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNsaWVudCwgaGFuZGxlLCAtcmV0LCAiY2FuJ3Qg
Z2V0IGJsb2NrIHN0YXR1cyIsIGVycnApOw0KPj4gwqDCoMKgwqDCoCB9DQo+PiAtwqDCoMKgIHJl
dCA9IG5iZF9jb19zZW5kX2V4dGVudHMoY2xpZW50LCBoYW5kbGUsIGV4dGVudHMsIG5iX2V4dGVu
dHMsDQo+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBmaW5hbF9sZW5ndGgsIGxhc3QsIGNvbnRleHRfaWQsIGVycnApOw0KPj4gLQ0K
Pj4gLcKgwqDCoCBnX2ZyZWUoZXh0ZW50cyk7DQo+PiAtDQo+PiAtwqDCoMKgIHJldHVybiByZXQ7
DQo+PiArwqDCoMKgIHJldHVybiBuYmRfY29fc2VuZF9leHRlbnRzKGNsaWVudCwgaGFuZGxlLCBl
YSwgbGFzdCwgY29udGV4dF9pZCwgZXJycCk7DQo+IA0KPiAuLi5lc3BlY2lhbGx5IHNpbmNlIGVh
IGdvZXMgb3V0IG9mIHNjb3BlIHJpZ2h0IGFmdGVyIHRoZSBoZWxwZXIgZnVuY3Rpb24gZmluaXNo
ZXM/DQo+IA0KPiBPdmVyYWxsIGxvb2tzIGxpa2UgYSBuaWNlIHJlZmFjdG9yaW5nLg0KPiANCj4g
UmV2aWV3ZWQtYnk6IEVyaWMgQmxha2UgPGVibGFrZUByZWRoYXQuY29tPg0KPiANCg0KDQotLSAN
CkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

