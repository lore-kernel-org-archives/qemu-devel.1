Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F249CA9EA1
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 09:28:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A24521897
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 09:28:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="aOcFoybx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A24521897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLOYj-0007V5-Fe
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 05:28:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46214)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iLOXy-0006ur-0m
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 05:27:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iLOXv-00057B-JO
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 05:27:45 -0400
Received: from mail-eopbgr80117.outbound.protection.outlook.com
 ([40.107.8.117]:13536 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iLOXu-000566-MN; Fri, 18 Oct 2019 05:27:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OGT8B2H3NygKodzU5TBg0BKpAbF7BXKGM9KG2CSh2g9IQCivnesQe/aGF5T4m0wNgioCGNqJVZEo1KdzTOk3rq+4vRpWWEUSgzA/Ez/5aL8EOXXX4pw+DI5KYTb/nx8eYahl4nd7QcMLG4L8tJ3pDRqp190WdeGWHlsAMeIXWmC9Sptw0/KMn4s1nrp8kJNhA/ywZmkAxSSvV4tBiXpaAoj9VD+1qhlH/KWy90W3ZxkWTarfC9cIx7HnQNUleAtrH4XUpJI9y9X5jN3YwvNpA0iRcC0CTzSfXks7nneLZHv2szDw0RjcV4q5o62vSa+tU2zlOwSDM9j9w/EShliN6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DIMpF1nfo/auHiORJRWL5823Gi39phcvRJOd0KqYKok=;
 b=ZTq/Zk131HRCCrpvJZ6Q+QP2NGm77aTP6dP3KqAG9kRfvttyCMHO+gytRPw7gWTpZP4BwXvISlxSaGZRvscCWmfMT6rTbDlgrlGpWqkRKVGAwZy7iyJL3YB5ijy49xkEqGd+ALTlPD62iWT8T5vLedyKGQrBbrV2r+n6HLuj94Wg2qG/5cIHElTkStXz84Y0/K62JJ8S/SmacQdn5ogotxryQHTDAadvmLZPvi2b7ua4nfwp0pW6v9qYzNs6jlcNnwsD2EXhXvOHDUWYxIGJYFhI2/a6FgHGbF7b415E5bf0fC/qSgBOHKpLL/9pQ5RiP5Ve0jnI3tytPx2yAOdKmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DIMpF1nfo/auHiORJRWL5823Gi39phcvRJOd0KqYKok=;
 b=aOcFoybxcV0+2Tczzcdi4ELPm/5rhRn3nog6Z7Ot8InK6cHPO3pPmljGxCCdCIK66LNXQXpMpd+s9gjscIOsuABRvA/LKOzOlQjPkNBLodV9vL43419Qp6qGLvSvHeGO4qKarpM20fexviMKLbeqA+pSOSMGZxV0DjVIxDVEuw8=
Received: from AM0PR08MB4435.eurprd08.prod.outlook.com (20.179.35.83) by
 AM0PR08MB4163.eurprd08.prod.outlook.com (20.178.119.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.21; Fri, 18 Oct 2019 09:27:40 +0000
Received: from AM0PR08MB4435.eurprd08.prod.outlook.com
 ([fe80::4461:dd32:b358:110c]) by AM0PR08MB4435.eurprd08.prod.outlook.com
 ([fe80::4461:dd32:b358:110c%7]) with mapi id 15.20.2347.026; Fri, 18 Oct 2019
 09:27:40 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH v7 1/2] docs: improve qcow2 spec about extending image
 header
Thread-Topic: [PATCH v7 1/2] docs: improve qcow2 spec about extending image
 header
Thread-Index: AQHVfSj4NZxneckXjESRnSlwVfPCUadPn1aAgADVRwCAD61pgIAAEDYA
Date: Fri, 18 Oct 2019 09:27:39 +0000
Message-ID: <b157b428-4f30-ddad-2eb6-78bd9ca3bc21@virtuozzo.com>
References: <20191007160451.27334-1-vsementsov@virtuozzo.com>
 <20191007160451.27334-2-vsementsov@virtuozzo.com>
 <7afa803e-3efd-1186-2b37-7056d9a983f0@redhat.com>
 <90102485-ccbb-018c-c90d-b85a7b2f0392@virtuozzo.com>
 <2d60f7aa-7f3a-18f2-434f-0ab176924be2@virtuozzo.com>
In-Reply-To: <2d60f7aa-7f3a-18f2-434f-0ab176924be2@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0236.eurprd05.prod.outlook.com
 (2603:10a6:3:fb::12) To AM0PR08MB4435.eurprd08.prod.outlook.com
 (2603:10a6:208:144::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191018122736617
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5bbb6aa5-f9c4-466f-cf33-08d753ad6b54
x-ms-traffictypediagnostic: AM0PR08MB4163:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR08MB4163CD63C7B0A03230496B79C16C0@AM0PR08MB4163.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01949FE337
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(366004)(396003)(39850400004)(136003)(376002)(199004)(189003)(6246003)(305945005)(316002)(99286004)(71190400001)(14454004)(3846002)(71200400001)(7736002)(31686004)(66556008)(110136005)(64756008)(66476007)(54906003)(66446008)(2906002)(66946007)(36756003)(107886003)(4326008)(81166006)(8936002)(478600001)(102836004)(31696002)(6116002)(386003)(476003)(229853002)(256004)(25786009)(6486002)(52116002)(26005)(81156014)(66066001)(486006)(6436002)(11346002)(186003)(8676002)(2616005)(6512007)(5660300002)(2501003)(76176011)(86362001)(446003)(53546011)(6506007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB4163;
 H:AM0PR08MB4435.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fhcGqSj1N5N3AQIP87uCqTI8kSnWgTQqSbVsXKaQsMgAn/gK8b2OMFITaT3dylCUytYyhyUvwosQNdA1gH5ErvAEX/g2p7eQ536lg5+k812Q/Q37m+S3VrFq8G4ZPLl0t8rkW3tljSb1HrL/5DxLEqj1iDWKEH+mQoUb8nQvbnasNPQmBC2VUbEX2QB7H3xIQFYMm+jnqmr1gpmicsluyUN1R4OJwRT3vAoUqDGAVgjYuEjbVnKaSasruy3eX/h6uJFNK77ju5io+2UT5XLUjiMOzwqCLw+30LlNinipJF6k4EtDp8VBQaVsSsYhxPkLFOvz8VkLG2BKnfzvLClEtb2J32ziymR3YUR+pNoFfpCWdW20XTZU/f3U+lPKhtcKly+KZyNS4J2a301Hn6CDab7KiMGofR50XGcMI49m9/o=
Content-Type: text/plain; charset="utf-8"
Content-ID: <11B7ED25A2E0D64AA4D6D2639E239967@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bbb6aa5-f9c4-466f-cf33-08d753ad6b54
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2019 09:27:39.9277 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R2Rt5xEaN7MP0LcE2sKD1dJiZqulf9S3d5q98Oko8X6KnaYs4X6m8z0QFj6UKFKdSrlNxA/xzAM5GUVhLZhDsOQXsocOzFmOZBp7rqZTiKM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4163
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.8.117
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTguMTAuMjAxOSAxMToyOSwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4g
MDguMTAuMjAxOSAxMjowNSwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+
IDA3LjEwLjIwMTkgMjM6MjEsIEVyaWMgQmxha2Ugd3JvdGU6DQo+Pj4gT24gMTAvNy8xOSAxMTow
NCBBTSwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+Pj4gTWFrZSBpdCBt
b3JlIG9idmlvdXMgaG93IHRvIGFkZCBuZXcgZmllbGRzIHRvIHRoZSB2ZXJzaW9uIDMgaGVhZGVy
IGFuZA0KPj4+PiBob3cgdG8gaW50ZXJwcmV0IHRoZW0uDQo+Pj4+DQo+Pj4+IFNpZ25lZC1vZmYt
Ynk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNv
bT4NCj4+Pj4gLS0tDQo+Pj4+IMKgIGRvY3MvaW50ZXJvcC9xY293Mi50eHQgfCAyNiArKysrKysr
KysrKysrKysrKysrKysrKy0tLQ0KPj4+PiDCoCAxIGZpbGUgY2hhbmdlZCwgMjMgaW5zZXJ0aW9u
cygrKSwgMyBkZWxldGlvbnMoLSkNCj4+Pj4NCj4+Pj4gZGlmZiAtLWdpdCBhL2RvY3MvaW50ZXJv
cC9xY293Mi50eHQgYi9kb2NzL2ludGVyb3AvcWNvdzIudHh0DQo+Pj4+IGluZGV4IGFmNTcxMWU1
MzMuLjNmMjg1NTU5M2YgMTAwNjQ0DQo+Pj4+IC0tLSBhL2RvY3MvaW50ZXJvcC9xY293Mi50eHQN
Cj4+Pj4gKysrIGIvZG9jcy9pbnRlcm9wL3Fjb3cyLnR4dA0KPj4+PiBAQCAtNzksOSArNzksOSBA
QCBUaGUgZmlyc3QgY2x1c3RlciBvZiBhIHFjb3cyIGltYWdlIGNvbnRhaW5zIHRoZSBmaWxlIGhl
YWRlcjoNCj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIE9m
ZnNldCBpbnRvIHRoZSBpbWFnZSBmaWxlIGF0IHdoaWNoIHRoZSBzbmFwc2hvdCB0YWJsZQ0KPj4+
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RhcnRzLiBNdXN0
IGJlIGFsaWduZWQgdG8gYSBjbHVzdGVyIGJvdW5kYXJ5Lg0KPj4+PiAtSWYgdGhlIHZlcnNpb24g
aXMgMyBvciBoaWdoZXIsIHRoZSBoZWFkZXIgaGFzIHRoZSBmb2xsb3dpbmcgYWRkaXRpb25hbCBm
aWVsZHMuDQo+Pj4+IC1Gb3IgdmVyc2lvbiAyLCB0aGUgdmFsdWVzIGFyZSBhc3N1bWVkIHRvIGJl
IHplcm8sIHVubGVzcyBzcGVjaWZpZWQgb3RoZXJ3aXNlDQo+Pj4+IC1pbiB0aGUgZGVzY3JpcHRp
b24gb2YgYSBmaWVsZC4NCj4+Pj4gK0ZvciB2ZXJzaW9uIDIsIGhlYWRlciBpcyBhbHdheXMgNzIg
Ynl0ZXMgbGVuZ3RoIGFuZCBmaW5pc2hlcyBoZXJlLg0KPj4+PiArRm9yIHZlcnNpb24gMyBvciBo
aWdoZXIgdGhlIGhlYWRlciBsZW5ndGggaXMgYXQgbGVhc3QgMTA0IGJ5dGVzIGFuZCBoYXMgYXQN
Cj4+Pj4gK2xlYXN0IG5leHQgZml2ZSBmaWVsZHMsIHVwIHRvIHRoZSBAaGVhZGVyX2xlbmd0aCBm
aWVsZC4NCj4+Pg0KPj4+IFRoaXMgaHVuayBzZWVtcyBva2F5Lg0KPj4+DQo+Pj4+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgIDcyIC3CoCA3OTrCoCBpbmNvbXBhdGlibGVfZmVhdHVyZXMNCj4+Pj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEJpdG1hc2sgb2YgaW5jb21w
YXRpYmxlIGZlYXR1cmVzLiBBbiBpbXBsZW1lbnRhdGlvbiBtdXN0DQo+Pj4+IEBAIC0xNjUsNiAr
MTY1LDI2IEBAIGluIHRoZSBkZXNjcmlwdGlvbiBvZiBhIGZpZWxkLg0KPj4+PiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgTGVuZ3RoIG9mIHRoZSBoZWFkZXIgc3Ry
dWN0dXJlIGluIGJ5dGVzLiBGb3IgdmVyc2lvbiAyDQo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpbWFnZXMsIHRoZSBsZW5ndGggaXMgYWx3YXlzIGFzc3Vt
ZWQgdG8gYmUgNzIgYnl0ZXMuDQo+Pj4+ICtBZGRpdGlvbmFsIGZpZWxkcyAodmVyc2lvbiAzIGFu
ZCBoaWdoZXIpDQo+Pj4+ICsNCj4+Pj4gK1RoZSBmb2xsb3dpbmcgZmllbGRzIG9mIHRoZSBoZWFk
ZXIgYXJlIG9wdGlvbmFsOiBpZiBzb2Z0d2FyZSBkb24ndCBrbm93IGhvdyB0bw0KPj4+PiAraW50
ZXJwcmV0IHRoZSBmaWVsZCwgaXQgbWF5IHNhZmVseSBpZ25vcmUgaXQuIFN0aWxsIHRoZSBmaWVs
ZCBtdXN0IGJlIGtlcHQgYXMgaXMNCj4+Pj4gK3doZW4gcmV3cml0aW5nIHRoZSBpbWFnZS4NCj4+
Pg0KPj4+IGlmIHNvZnR3YXJlIGRvZXNuJ3Qga25vdyBob3cgdG8gaW50ZXJwcmV0IHRoZSBmaWVs
ZCwgaXQgbWF5IGJlIHNhZmVseSBpZ25vcmVkLCBvdGhlciB0aGFuIHByZXNlcnZpbmcgdGhlIGZp
ZWxkIHVuY2hhbmdlZCB3aGVuIHJld3JpdGluZyB0aGUgaW1hZ2UgaGVhZGVyLg0KPj4+DQo+Pj4g
TWlzc2luZzoNCj4+Pg0KPj4+IElmIGhlYWRlcl9sZW5ndGggZXhjbHVkZXMgYW4gb3B0aW9uYWwg
ZmllbGQsIHRoZSB2YWx1ZSBvZiAwIHNob3VsZCBiZSB1c2VkIGZvciB0aGF0IGZpZWxkLg0KPj4N
Cj4+IFRoaXMgaXMgd2hhdCBJIGRpc2xpa2UgaW4gb2xkIHdvcmRpbmcuIFdoeSBkbyB3ZSBuZWVk
IHRoaXMgZGVmYXVsdC16ZXJvIHRoaW5nWypdPyBXaGF0IGlzIHRoZSBkZWZhdWx0Pw0KPj4NCj4+
IERlZmF1bHQgaXMgYWJzZW5jZSBvZiB0aGUgZmVhdHVyZSwgd2UgZG9uJ3QgaGF2ZSB0aGVzZSBm
dXR1cmUgZmVhdHVyZXMgbm93IGFuZCBkb24ndCBjYXJlIG9mIHRoZW0uDQo+PiBXaGF0IGlzIHRo
aXMgZGVmYXVsdCAwIGZvciB1cyBub3c/IE5vdGhpbmcuDQo+Pg0KPj4gQ29uc2lkZXIgc29tZSBm
dXR1cmUgdmVyc2lvbjogaWYgaXQgc2VlcyB0aGF0IGhlYWRlcl9sZW5ndGggZXhjbHVkZXMgc29t
ZSBmaWVsZHMsIGl0IHVuZGVyc3RhbmRzLA0KPj4gdGhhdCB0aGVyZSBpcyBubyBzdWNoIGZlYXR1
cmUgaGVyZS4gVGhhdCdzIGFsbC4gV29yayB3aXRob3V0IGl0LiBUaGUgZmVhdHVyZSBpdHNlbGYg
c2hvdWxkIGRlY2xhcmUNCj4+IGJlaGF2aW9yIHdpdGhvdXQgdGhpcyBmZWF0dXJlLCB3aGljaCBz
aG91bGQgY29ycmVzcG9uZCB0byBiZWhhdmlvciBiZWZvcmUgdGhpcyBmZWF0dXJlIGludHJvZHVj
dGlvbi4uDQo+Pg0KPj4gU28gYXQgbGVhc3QsIEkgZG9uJ3QgbGlrZSAidGhlIHZhbHVlIG9mIDAg
c2hvdWxkIGJlIHVzZWQgZm9yIHRoYXQgZmllbGQiLCBhcyBpbnN0YW5jZXMgb2YgUWVtdSB3aGlj
aA0KPj4gZG9uJ3Qga25vdyBhYm91dCB0aGUgZmVhdHVyZSB3aWxsIGlnbm9yZSB0aGlzIHJlcXVp
cmVtZW50LCBhcyB0aGV5IGRvbid0IG5lZWQgYW55IHZhbHVlIG9mIHRoYXQNCj4+IGZpZWxkIGF0
IGFsbC4NCj4+DQo+PiBXaGF0IHlvdSBhY3R1YWxseSBtZWFuLCBJTUhPLCBpczogZm9yIGFsbCBv
cHRpb25hbCBmaWVsZCAwIHZhbHVlIG11c3QgYmUgZXF1YWwgdG8gYWJzZW5jZSBvZiB0aGUgZmVh
dHVyZSwNCj4+IGxpa2Ugd2hlbiBoZWFkZXJfbGVuZ3RoIGV4Y2x1ZGVzIHRoaXMgZmllbGQuIEkg
ZG9uJ3Qgc2VlLCBkbyB3ZSByZWFsbHkgbmVlZCB0aGlzIHJlcXVpcmVtZW50LCBidXQNCj4+IHNl
ZW1zIGl0IHdhcyBtZW50aW9uZWQgYmVmb3JlIHRoaXMgcGF0Y2ggYW5kIHdlJ2QgYmV0dGVyIGtl
ZXAgaXQuLiBJIGp1c3QgZG9uJ3QgbGlrZSBjb25jZXB0IG9mDQo+PiAiZGVmYXVsdCIgdmFsdWUg
a2VlcGluZyBpbiBtaW5kIHZhbGlkIFFlbXUgaW5zdGFuY2VzIHdoaWNoIGRvbid0IGtub3cgYWJv
dXQgZmllbGQgYXQgYWxsLg0KPj4NCj4+Pg0KPj4+PiBAaGVhZGVyX2xlbmd0aCBtdXN0IGJlIGJv
dW5kIHRvIHRoZSBlbmQgb2Ygb25lIG9mDQo+Pj4+ICt0aGVzZSBmaWVsZHMgKG9yIHRvIEBoZWFk
ZXJfbGVuZ3RoIGZpZWxkIGVuZCBpdHNlbGYsIHRvIGJlIDEwNCBieXRlcykuDQo+Pj4NCj4+PiBX
ZSBkb24ndCB1c2UgdGhlIEBoZWFkZXJfbGVuZ3RoIG1hcmt1cCBhbnl3aGVyZSBlbHNlIGluIHRo
aXMgZmlsZSwgc3RhcnRpbmcgdG8gZG8gc28gaGVyZSBpcyBvZGQuDQo+Pj4NCj4+PiBJIHdvdWxk
IHN1Z2dlc3QgYSBzdHJvbmdlciByZXF1aXJlbWVudDoNCj4+Pg0KPj4+IGhlYWRlcl9sZW5ndGgg
bXVzdCBiZSBhIG11bHRpcGxlIG9mIDQsIGFuZCBtdXN0IG5vdCBsYW5kIGluIHRoZSBtaWRkbGUg
b2YgYW55IG9wdGlvbmFsIDgtYnl0ZSBmaWVsZC4NCj4+Pg0KPj4+IE9yIG1heWJlIGV2ZW4gYWRk
IG91ciBjb21wcmVzc2lvbiB0eXBlIGV4dGVuc2lvbiB3aXRoIDQgYnl0ZXMgb2YgcGFkZGluZywg
c28gdGhhdCB3ZSBjb3VsZCBnbyBldmVuIHN0cm9uZ2VyOg0KPj4+DQo+Pj4gaGVhZGVyX2xlbmd0
aCBtdXN0IGJlIGEgbXVsdGlwbGUgb2YgOC4NCj4+DQo+PiBIbW0sIGlmIHdlIGltcGx5IHRoYXQg
c29mdHdhcmUgd2lsbCBoYXZlIHRvIGFkZCBzb21lIHBhZGRpbmcsIHRoYW4gcmVxdWlyZW1lbnQg
YWJvdmUgYWJvdXQgemVybyA9PT0gZmVhdHVyZS1hYnNlbmNlDQo+PiBiZWNvbWVzIG5lY2Vzc2Fy
eS4gWypdDQo+Pg0KPj4gU3RpbGwgSSBoYXZlIHR3byBxdWVzdGlvbnM6DQo+PiAxLiBEbyB3ZSBy
ZWFsbHkgbmVlZCBhbGwgZmllbGRzIHRvIGJlIDQgb3IgOCBieXRlcz8gV2h5IG5vdCB1c2UgMSBi
eXRlIGZvciBjb21wcmVzc2lvbj8NCj4+IDIuIFdoYXQgaXMgdGhlIGJlbmVmaXQgb2YgcGFkZGlu
Zywgd2hpY2ggeW91IHByb3Bvc2U/DQo+IA0KPiBIbW0sIG5vdyBJIHRoaW5rLCB0aGF0IHdlIHNo
b3VsZCBhbGlnbiBoZWFkZXIgdG8gbXVsdGlwbHkgb2YgOCwgYXMgaGVhZGVyIGV4dGVuc2lvbnMg
YXJlIGFscmVhZHkgaGF2ZQ0KPiAiIiINCj4gRGlyZWN0bHkgYWZ0ZXIgdGhlIGltYWdlIGhlYWRl
ciwgb3B0aW9uYWwgc2VjdGlvbnMgY2FsbGVkIGhlYWRlciBleHRlbnNpb25zIGNhbg0KPiBiZSBz
dG9yZWQuIEVhY2ggZXh0ZW5zaW9uIGhhcyBhIHN0cnVjdHVyZSBsaWtlIHRoZSBmb2xsb3dpbmc6
DQo+IA0KPiBbLi4uXQ0KPiANCj4gIMKgwqDCoMKgwqDCoMKgwqDCoCBuIC3CoCBtOsKgwqAgUGFk
ZGluZyB0byByb3VuZCB1cCB0aGUgaGVhZGVyIGV4dGVuc2lvbiBzaXplIHRvIHRoZSBuZXh0DQo+
ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBtdWx0aXBsZSBvZiA4Lg0K
PiAiIiINCj4gDQo+IFNvLCBpdCBsb29rcyBpbmNvbnNpc3RlbnQsIGlmIHdlIHBhZCBhbGwgaGVh
ZGVyIGV4dGVuc2lvbnMgdG/CoCA4IGJ5dGVzIGV4Y2VwdCBmb3IgdGhlIHN0YXJ0IG9mIHRoZSBm
aXJzdCBleHRlbnNpb24uDQo+IA0KPiBJJ2xsIHJlc2VuZCB3aXRoIHBhZGRpbmcgc29vbi4NCg0K
DQpTdGlsbCwgd2UgaGF2ZSB0byBtYWtlIGFuIGV4Y2VwdGlvbiBhdCBsZWFzdCBmb3IgaGVhZGVy
X2xlbmd0aCA9IDEwNCwgd2hpY2ggaXMgbm90IGEgbXVsdGlwbHkgb2YgOC4NCg0KQWxzbywgaXMg
cmVxdWlyaW5nIGFsaWdubWVudCBpcyBhbiBpbmNvbXBhdGlibGUgY2hhbmdlIG9mIHNwZWNpZmlj
YXRpb24/DQoNCj4gDQo+Pg0KPj4+DQo+Pj4+ICtUaGlzIGRlZmluaXRpb24gaW1wbGllcyB0aGUg
Zm9sbG93aW5nOg0KPj4+PiArMS4gU29mdHdhcmUgbWF5IHN1cHBvcnQgc29tZSBvZiB0aGVzZSBv
cHRpb25hbCBmaWVsZHMgYW5kIGlnbm9yZSB0aGUgb3RoZXJzLA0KPj4+PiArwqDCoCB3aGljaCBt
ZWFucyB0aGF0IGZlYXR1cmVzIG1heSBiZSBiYWNrcG9ydGVkIHRvIGRvd25zdHJlYW0gUWVtdSBp
bmRlcGVuZGVudGx5Lg0KPj4+DQo+Pj4gSSBkb24ndCB0aGluayB0aGlzIGJlbG9uZ3MgaW4gdGhl
IHNwZWMuDQo+Pg0KPj4gTWUgdG9vLiBCdXQgYXQgbGVhc3QgSSBub3RlZCB3aGF0IEkgdHJ5IHRv
IGFjaGlldmUsIHNvIGNvbnNpZGVyIGl0IGEgYml0IGxpa2UgUkZDLiBBbmQgb2YgY291cnNlIEkg
aG9wZWQgZm9yIHlvdXIgcmV3b3JkaW5ncyApDQo+Pg0KPj4+IMKgIElkZWFsbHksIHdlIGFkZCBm
aWVsZHMgc28gaW5mcmVxdWVudGx5IHRoYXQgYmFja3BvcnRpbmcgZG9lc24ndCBoYXZlIHRvIHdv
cnJ5IGFib3V0IGJhY2twb3J0aW5nIGZpZWxkIDIgd2hpbGUgc2tpcHBpbmcgZmllbGQgMS4NCj4+
DQo+PiBXaG8ga25vd3MuLiBFdmVuIGhhdmluZyBvbmx5IHR3byBmaWVsZHMgQSBhbmQgQiwgd2hl
biB3ZSBuZWVkIEIgd2hpY2ggYWN0dWFsbHkgbmVlZHMgMTAgcGF0Y2hlcyB0byBiYWNrcG9ydCBh
bmQgQSBuZWVkcyAxMDAgd291bGQgYmUNCj4+IGEgcHJvYmxlbSwgaWYgd2UgY2FuJ3QgYmFja3Bv
cnQgQiBpbiBzZXBhcmF0ZS4NCj4+DQo+PiBJIHJlbWVtYmVyIHNpbWlsYXIgdGhpbmcgYWJvdXQg
TkJEOiBJIG5lZWRlZCBCTE9DS19TVEFUVVMsIGJ1dCBiZWNhdXNlIG9mIHNwZWNpZmljYXRpb24g
SSBoYWQgdG8gaW1wbGVtZW50DQo+PiBzdHJ1Y3R1cmVkIHJlYWQgZmlyc3QsIHdoaWNoIHdhc24n
dCBpbnRlcmVzdGluZyB0byBtZSBhdCB0aGF0IG1vbWVudC4NCj4+DQo+Pj4NCj4+Pj4gKzIuIFNv
ZnR3YXJlIG1heSBjaGVjayBAaGVhZGVyX2xlbmd0aCwgaWYgaXQga25vd3Mgb3B0aW9uYWwgZmll
bGRzIHNwZWNpZmljYXRpb24NCj4+Pj4gK8KgwqAgZW5vdWdoIChrbm93cyBhYm91dCB0aGUgZmll
bGQgd2hpY2ggZXhjZWVkcyBAaGVhZGVyX2xlbmd0aCkuDQo+Pj4NCj4+PiBBZ2FpbiwgSSBkb24n
dCB0aGluayB0aGlzIGFkZHMgYW55dGhpbmcuwqAgU2luY2Ugd2UgYWxyZWFkeSBkb2N1bWVudGVk
IGZpZWxkcyBhcmUgb3B0aW9uYWwsIGFuZCB0aGF0IGlmIGhlYWRlcl9sZW5ndGggaXMgdG9vIHNo
b3J0LCB0aGUgbWlzc2luZyBmaWVsZCBpcyB0cmVhdGVkIGFzIDAsIHNvZnR3YXJlIHRoYXQga25v
d3MgYWJvdXQgYSBsb25nZXIgaGVhZGVyX2xlbmd0aCB3aWxsIGFscmVhZHkgaGFuZGxlIGl0IGNv
cnJlY3RseS4NCj4+DQo+PiBJIHRoaW5rLCBJJ2xsIG1vdmUgdGhlc2UgcG9pbnRzIHRvIGNvbW1p
dCBtZXNzYWdlLCB0byBrZWVwIHRoZW0gc29tZWhvdy4NCj4+DQo+Pj4NCj4+Pj4gKzMuIElmIEBo
ZWFkZXJfbGVuZ3RoIGlzIGhpZ2hlciB0aGFuIHRoZSBoaWdoZXN0IGZpZWxkIGVuZCB0aGF0IHNv
ZnR3YXJlIGtub3dzLA0KPj4+PiArwqDCoCBpdCBzaG91bGQgYXNzdW1lIHRoYXQgYWRkaXRpb25h
bCBmaWVsZHMgYXJlIGNvcnJlY3QsIEBoZWFkZXJfbGVuZ3RoIGlzDQo+Pj4+ICvCoMKgIGNvcnJl
Y3QgYW5kIGtlZXAgQGhlYWRlcl9sZW5ndGggYW5kIGFkZGl0aW9uYWwgdW5rbm93biBmaWVsZHMg
YXMgaXMgb24NCj4+Pj4gK8KgwqAgcmV3cml0aW5nIHRoZSBpbWFnZS4NCj4+Pj4gKzMuIElmIHdl
IHdhbnQgdG8gYWRkIGluY29tcGF0aWJsZSBmaWVsZCAob3IgYSBmaWVsZCwgZm9yIHdoaWNoIHNv
bWUgaXRzIHZhbHVlcw0KPj4+PiArwqDCoCB3b3VsZCBiZSBpbmNvbXBhdGlibGUpLCBpdCBtdXN0
IGJlIGFjY29tcGFuaWVkIGJ5IGluY29tcGF0aWJsZSBmZWF0dXJlIGJpdC4NCj4+Pj4gKw0KPj4+
PiArwqDCoMKgwqDCoMKgwqAgPCAuLi4gTm8gYWRkaXRpb25hbCBmaWVsZHMgaW4gdGhlIGhlYWRl
ciBjdXJyZW50bHkgLi4uID4NCj4+Pj4gKw0KPj4+DQo+Pj4gSSdtIHN0aWxsIG5vdCBzZWVpbmcg
dGhlIHZhbHVlIGluIGFkZGluZyBhbnkgb2YgdGhpcyBwYXJhZ3JhcGggdG8gdGhlIHNwZWMuwqAg
TWF5YmUgaW4gdGhlIGNvbW1pdCBtZXNzYWdlIHRoYXQgYWNjb21wYW5pZXMgdGhlIHNwZWMgY2hh
bmdlLCBidXQgdGhlIHNwZWMgaXMgY2xlYXIgZW5vdWdoIGlmIGl0IGRvY3VtZW50cyBob3cgb3B0
aW9uYWwgaGVhZGVyIGZpZWxkcyBhcmUgdG8gYmUgbWFuYWdlZCAodHJlYXQgYXMgMCBpZiBtaXNz
aW5nLCBwcmVzZXJ2ZSBvbiB3cml0ZSBpZiB1bmtub3duLCBhbmQgd2l0aCBhIG1hbmRhdGVkIGFs
aWdubWVudCB0byBhdm9pZCBoYXZpbmcgdG8gd29ycnkgYWJvdXQgb3RoZXIgaXNzdWVzKS4NCj4+
Pg0KPj4+PiDCoCBEaXJlY3RseSBhZnRlciB0aGUgaW1hZ2UgaGVhZGVyLCBvcHRpb25hbCBzZWN0
aW9ucyBjYWxsZWQgaGVhZGVyIGV4dGVuc2lvbnMgY2FuDQo+Pj4+IMKgIGJlIHN0b3JlZC4gRWFj
aCBleHRlbnNpb24gaGFzIGEgc3RydWN0dXJlIGxpa2UgdGhlIGZvbGxvd2luZzoNCj4+Pj4NCj4+
Pg0KPj4NCj4+DQo+IA0KPiANCg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

