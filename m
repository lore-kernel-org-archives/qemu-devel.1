Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 553C1C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 18:26:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2138B207FC
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 18:26:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="En3vb5mR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2138B207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB18F-0008Ll-U5
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 14:26:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59475)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iB16g-0007Ca-P7
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 14:24:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iB16f-0000YM-17
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 14:24:42 -0400
Received: from mail-he1eur02on0724.outbound.protection.outlook.com
 ([2a01:111:f400:fe05::724]:38574
 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iB16e-0000PJ-AF; Thu, 19 Sep 2019 14:24:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=amMcqo9bE33c1IAZ+z7aPdMRohhbjHGOyBS3pkEzgee0HnCmbOkkZ4ovk6HBAqZMN0jK3LcVEBoC1OIMdlkCwDGyCGRHfsAiHJJBbtCu1yQtpHSx4pXpOuwjsCHpWXzUitwon+fK8SrHEf8c0AwZvFfbD8qi7YiKbZ1OMFf33qEex7w9xoXGwGFzWtrj6Xl+o0Ib5gE0yrGUSQBfPSLaFB4wMkzQy6Ogb5GNxY4xffwOb7KogFWOW1XEpXktNGiP0lJJN2D0s4UBW+IWRTCWB3QGRhur2DQXUgHiJBEr374n8nP9WNKMHO8Kuy46zSuozRk27l64S7DqE0y2iKTfSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UxjbeSMgnbyyAPJE7cQ63TIDRLpAU/XoXmIOEgabZx4=;
 b=IAsDRQTxsJTKeM+5RFKXElsKdKvgNBkYVsVEVS/TeNIUUBs1YqmDP2G1hGWWNNzaX/oKdbPybHDmTe+d0hXbwKch4lULAxwCvqWxjZ6x2R7VhEQZ+fLqTuQIIRk6WYyEfDjWrPMmPb7T8e7xaMuAEpZstHciVIcAeHouyqEPcEx3fXikr9f4WKgTPFWI2NaP2W2zMOPQhEtNpRuQilMPcYt75yQQkkzXgPRsWmW0cM5I5VqoIojd7laa5sjSWsRNW2kDgBq4IzSqwEUyPRR9ktwv2baQ2rfd2k32Vh4+2SkK/wMocju6o+5sckkMl0b2XEru4RfXkskHSAzfKT/tNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UxjbeSMgnbyyAPJE7cQ63TIDRLpAU/XoXmIOEgabZx4=;
 b=En3vb5mR0OmNyZbzgNf6zVX9uxfcvtACTMEphH/KC4iV4nhna+EBXYDMpD7fXkjBJe1w/Q7CAWb76hlh6udAyHgnlTWu1FXAyGJMbOtojWiSgu7T0/u09wpikitYC4S3O97KzwSyGIduSdcpLvKovg8/Y895LdXIzYgngU0otMs=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4028.eurprd08.prod.outlook.com (20.179.10.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.21; Thu, 19 Sep 2019 18:24:36 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2284.009; Thu, 19 Sep 2019
 18:24:36 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: bugfix ping Re: [PATCH v4 00/10] qcow2-bitmaps: rewrite reopening
 logic
Thread-Topic: bugfix ping Re: [PATCH v4 00/10] qcow2-bitmaps: rewrite
 reopening logic
Thread-Index: AQHVTSopPwiUxx2MOkaQtW14Kblt36cdBWyAgBaPN4A=
Date: Thu, 19 Sep 2019 18:24:36 +0000
Message-ID: <7e911cd8-2bfe-3419-2188-17106635dc99@virtuozzo.com>
References: <20190807141226.193501-1-vsementsov@virtuozzo.com>
 <8cdac817-c444-7851-1ffb-47ebcf59e18a@virtuozzo.com>
In-Reply-To: <8cdac817-c444-7851-1ffb-47ebcf59e18a@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0402CA0026.eurprd04.prod.outlook.com
 (2603:10a6:7:7c::15) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190919212433218
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f1dcbff9-54be-439c-c234-08d73d2ea013
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:DB8PR08MB4028; 
x-ms-traffictypediagnostic: DB8PR08MB4028:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB40284225B1B0D93D96EC5EE4C1890@DB8PR08MB4028.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:462;
x-forefront-prvs: 016572D96D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(366004)(346002)(376002)(396003)(39850400004)(53754006)(54534003)(199004)(189003)(6916009)(6486002)(478600001)(26005)(64756008)(386003)(316002)(256004)(446003)(66946007)(14444005)(2616005)(6506007)(6436002)(99286004)(6116002)(5660300002)(476003)(31686004)(3846002)(71190400001)(25786009)(2351001)(14454004)(102836004)(7736002)(86362001)(6512007)(11346002)(66476007)(52116002)(186003)(2501003)(305945005)(54906003)(36756003)(8936002)(71200400001)(76176011)(66446008)(66556008)(2906002)(31696002)(107886003)(4326008)(8676002)(81156014)(5640700003)(66066001)(81166006)(486006);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4028;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: nP91wv7jho1C6NzTeLRYzy12eFINi/yvryzeOoPXvWWemn/L8KtpnM00+wvmSdRQxGJX2KgbtGJHe7iTOrCjmT2Muew1CVtOQ4YEat5VjzCSWqkqn/iDLMVRnbyBKs3Hd5/03zq5beFpp+wTneLOTr2GXpt++RG97W32+xacrzaPPJR51dqZgILjgA1Ofi2bIpEk8mX96sTt2Ae5zMYEG9JuTSfKZq+mHK1r954EA9JLkFmntiXUj+rceeoojGagdYETf+HOEqIUMnrN2TuRsvTd3xJmGFAmsztJKbR9qLNhB1SmilwhMYiMOhZxUgtXXsIfRXoxI15d5/ALL5XExvaMTpDqnvQXDmpyl3IpUiSbpr9kcX2OFuOcw6zlCBao0HeOw3DowKwGDQJFgb5vA0zP/57Iw5RJ01geHcIPlTY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <19F54427DC5CE449B9091E9E7E7C61F1@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1dcbff9-54be-439c-c234-08d73d2ea013
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2019 18:24:36.1665 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 80PubySuEKrHcs/uIjk+mHRXHWKTjSxxJS27Zj9iPifasoQqLfR7bDzWUYAstOIUHxxG+L4QINjay+lamhdF2OJ3vSiPWM7oisjqBgiqRjE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4028
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe05::724
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
 "mreitz@redhat.com" <mreitz@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

cGluZw0KMDUuMDkuMjAxOSAxMjo1NCwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90
ZToNCj4gcGluZw0KPiANCj4gMDcuMDguMjAxOSAxNzoxMiwgVmxhZGltaXIgU2VtZW50c292LU9n
aWV2c2tpeSB3cm90ZToNCj4+IEhpIGFsbCENCj4+DQo+PiBCaXRtYXBzIHJlb3BlbmluZyBpcyBi
dWdneSwgcmVvcGVuaW5nLXJ3IGp1c3Qgbm90IHdvcmtpbmcgYXQgYWxsIGFuZA0KPj4gcmVvcGVu
aW5nLXJvIG1heSBsZWFkIHRvIHByb2R1Y2luZyBicm9rZW4gaW5jcmVtZW50YWwNCj4+IGJhY2t1
cCBpZiB3ZSBkbyB0ZW1wb3Jhcnkgc25hcHNob3QgaW4gYSBtZWFudGltZS4NCj4+DQo+PiB2NDog
RHJvcCBjb21wbGljYXRlZCBzb2x1dGlvbiBhcm91bmQgcmVvcGVuaW5nIGxvZ2ljIFtLZXZpbl0s
IGZpeA0KPj4gwqDCoMKgwqAgdGhlIGV4aXN0aW5nIGJ1ZyBpbiBhIHNpbXBsZXN0IHdheQ0KPj4N
Cj4+IFN0cnVjdHVyZToNCj4+DQo+PiAwMjogZml4IHJlb3BlbiB0byBSVw0KPj4gMDM6IHRlc3Qg
cmVvcGVuIHRvIFJXDQo+Pg0KPj4gMDc6IGZpeCByZW9wZW4gdG8gUk8NCj4+IDA4OiB0ZXN0IHJl
b3BlbiB0byBSTw0KPj4NCj4+IE90aGVycyBhcmUgbGVzcyBzaWduaWZpY2FudCBpbXByb3ZlbWVu
dHMgYW5kIHJlZmFjdG9yaW5nDQo+Pg0KPj4gQ2hhbmdlbG9nOg0KPj4NCj4+IDAxLTAzOiBuZXcg
cGF0Y2hlcywgdG8gZml4IHJlb3BlbmluZyBiaXRtYXBzIHRvIFJXIGFuZCBwZXJzb25hbCB0ZXN0
IGZvcg0KPj4gwqDCoMKgwqDCoMKgwqAgdGhpcyBidWcNCj4+IDA4OiBtZXJnZWQgdGVzdCBmcm9t
IHYzLCBpdCBjb3ZlcnMgYm90aCBidWdzIChyZW9wZW4gdG8gUlcgYW5kIHJlb3BlbiB0byBSTykN
Cj4+IDEwOiBpbnN0ZWFkIG9mIG1vdmluZyBiaXRtYXAtcmVvcGVuaW5nIHRvIHByZXBhcmUoYXMg
aW4gMDkgaW4gdjMpIHdlIG5vdyBrZWVwIGl0DQo+PiDCoMKgwqDCoCBpbiBjb21taXQsIGJ1dCBp
biByaWdodCBwbGFjZQ0KPj4gb3RoZXJzOiB1bmNoYW5nZWQNCj4+DQo+PiB2MzoNCj4+IDAyOiBK
b2huJ3MgZXZlbnRzX3dhaXQgYWxyZWFkeSBtZXJnZWQgaW4sIHNvIG15IDAyIGZyb20gdjIgaXMg
bm90IG5lZWRlZC4NCj4+IMKgwqDCoMKgIEluc3RlYWQsIGFkZCB0d28gc2ltcGxlIGxvZ2dpbmcg
d3JhcHBlcnMgaGVyZQ0KPj4gMDM6IHJlYmFzZSBvbiAwMiAtIHVzZSBuZXcgd3JhcHBlcnMsIG1v
dmUgdG8gMjYwDQo+PiAwNTogYWRkIEpvaG4ncyByLWINCj4+IDA2OiBpbXByb3ZlIGZ1bmN0aW9u
IGRvY3MgW0pvaG5dLCBhZGQgSm9obidzIHItYg0KPj4NCj4+IHYyOg0KPj4gMDE6IG5ldw0KPj4g
MDItMDM6IHRlc3Q6IHNwbGF0IGludG8gdHdvIHBhdGNoZXMsIHNvbWUgd29yZGluZw0KPj4gwqDC
oMKgwqDCoMKgwqAgaW1wcm92ZW1lbnRzIGFuZCBldmVudF93YWl0IGltcHJvdmVkDQo+PiAwNDog
YWRkIEpvaG4ncyByLWINCj4+IDA1OiBuZXcNCj4+IDA2LTA5OiBmaXhlczogY2hhbmdlZCwgc3Bs
YXQsIHVzZSBwYXRjaCAwMQ0KPj4NCj4+IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgKDEw
KToNCj4+IMKgwqAgYmxvY2s6IHN3aXRjaCByZW9wZW4gcXVldWUgZnJvbSBRU0lNUExFUSB0byBR
VEFJTFENCj4+IMKgwqAgYmxvY2s6IHJldmVyc2Ugb3JkZXIgZm9yIHJlb3BlbiBjb21taXRzDQo+
PiDCoMKgIGlvdGVzdHM6IGFkZCB0ZXN0LWNhc2UgdG8gMTY1IHRvIHRlc3QgcmVvcGVuaW5nIHFj
b3cyIGJpdG1hcHMgdG8gUlcNCj4+IMKgwqAgaW90ZXN0cy5weTogYWRkIGV2ZW50X3dhaXRfbG9n
IGFuZCBldmVudHNfd2FpdF9sb2cgaGVscGVycw0KPj4gwqDCoCBibG9jay9xY293Mi1iaXRtYXA6
IGdldCByaWQgb2YgYmRydl9oYXNfY2hhbmdlZF9wZXJzaXN0ZW50X2JpdG1hcHMNCj4+IMKgwqAg
YmxvY2svcWNvdzItYml0bWFwOiBkcm9wIHFjb3cyX3Jlb3Blbl9iaXRtYXBzX3J3X2hpbnQoKQ0K
Pj4gwqDCoCBibG9jay9xY293Mi1iaXRtYXA6IGRvIG5vdCByZW1vdmUgYml0bWFwcyBvbiByZW9w
ZW4tcm8NCj4+IMKgwqAgaW90ZXN0czogYWRkIHRlc3QgMjYwIHRvIGNoZWNrIGJpdG1hcCBsaWZl
IGFmdGVyIHNuYXBzaG90ICsgY29tbWl0DQo+PiDCoMKgIGJsb2NrL3Fjb3cyLWJpdG1hcDogZml4
IGFuZCBpbXByb3ZlIHFjb3cyX3Jlb3Blbl9iaXRtYXBzX3J3DQo+PiDCoMKgIHFjb3cyLWJpdG1h
cDogbW92ZSBiaXRtYXAgcmVvcGVuLXJ3IGNvZGUgdG8gcWNvdzJfcmVvcGVuX2NvbW1pdA0KPj4N
Cj4+IMKgIGJsb2NrL3Fjb3cyLmjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDC
oCA1ICstDQo+PiDCoCBpbmNsdWRlL2Jsb2NrL2Jsb2NrLmjCoMKgwqDCoMKgwqDCoMKgIHzCoMKg
IDIgKy0NCj4+IMKgIGluY2x1ZGUvYmxvY2svYmxvY2tfaW50LmjCoMKgwqDCoCB8wqDCoCA2IC0t
DQo+PiDCoCBpbmNsdWRlL2Jsb2NrL2RpcnR5LWJpdG1hcC5owqAgfMKgwqAgMSAtDQo+PiDCoCBi
bG9jay5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDUx
ICsrKysrLS0tLS0tLQ0KPj4gwqAgYmxvY2svZGlydHktYml0bWFwLmPCoMKgwqDCoMKgwqDCoMKg
wqAgfMKgIDEyIC0tLQ0KPj4gwqAgYmxvY2svcWNvdzItYml0bWFwLmPCoMKgwqDCoMKgwqDCoMKg
wqAgfCAxNDMgKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLQ0KPj4gwqAgYmxvY2sv
cWNvdzIuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAxNyArKystDQo+PiDC
oCB0ZXN0cy9xZW11LWlvdGVzdHMvMTY1wqDCoMKgwqDCoMKgwqAgfMKgIDQ2ICsrKysrKysrKyst
DQo+PiDCoCB0ZXN0cy9xZW11LWlvdGVzdHMvMTY1Lm91dMKgwqDCoCB8wqDCoCA0ICstDQo+PiDC
oCB0ZXN0cy9xZW11LWlvdGVzdHMvMjYwwqDCoMKgwqDCoMKgwqAgfMKgIDg3ICsrKysrKysrKysr
KysrKysrKysrKw0KPj4gwqAgdGVzdHMvcWVtdS1pb3Rlc3RzLzI2MC5vdXTCoMKgwqAgfMKgIDUy
ICsrKysrKysrKysrKysNCj4+IMKgIHRlc3RzL3FlbXUtaW90ZXN0cy9ncm91cMKgwqDCoMKgwqAg
fMKgwqAgMSArDQo+PiDCoCB0ZXN0cy9xZW11LWlvdGVzdHMvaW90ZXN0cy5weSB8wqAgMTAgKysr
DQo+PiDCoCAxNCBmaWxlcyBjaGFuZ2VkLCAzMTggaW5zZXJ0aW9ucygrKSwgMTE5IGRlbGV0aW9u
cygtKQ0KPj4gwqAgY3JlYXRlIG1vZGUgMTAwNzU1IHRlc3RzL3FlbXUtaW90ZXN0cy8yNjANCj4+
IMKgIGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0cy9xZW11LWlvdGVzdHMvMjYwLm91dA0KPj4NCj4g
DQo+IA0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

