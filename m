Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5740FC5DF61
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 12:28:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FFA4214D8
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 12:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="NCWWFo+E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FFA4214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSgu1-0001Rw-87
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 07:28:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57346)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iSgsK-0000Ec-E7
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 07:26:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iSgsI-0002MQ-5x
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 07:26:55 -0500
Received: from mail-eopbgr150127.outbound.protection.outlook.com
 ([40.107.15.127]:45445 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iSgsH-0002M3-FH; Thu, 07 Nov 2019 07:26:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h/b2EXZ1oIq9yK47v2pGH6V68Xr5Yav9Ia53NwOQoGaFW383WQs6ayeP1zGN4sKHOHnM+S1xyLACRpBL7qiHosruUYKlsKI6wz9svztK3661fejL18Mi/PFa28SXIb9X8j6UIZCO82kO9iAnER1ARSnk56IHu2cuZLq1quZmWBm62THrJcPHo+rotphdSHtJzM77BGJh6/8KQnEWBG6g4haS19ZMCFcUL6Gur4FescDZ3zxucDiorw338a7El8s+T1QvCNww9sZVqVe7vPiSKzjaoTsrNNerJHqSJyS4aWMwjxsF1IttwAaPUOL3VnUHakP7qlzfBIqrQ+3cnfQ4aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tVuu3RmCcSBj75eAmrZr/3HeZ4SOTPDhyn5soIb4mhs=;
 b=oUCvEej/7WuJHiVwEiojjaTdNZXVO9gBksgNbY6dnwBAfjD2GWj6iWXgUe4k+gSgNf+wyVyjNiOjnHmEW8NPw82K0ZEv1QJoni5xlUc4vEtN3zPzcyvhZ4bwwpJ+Edo2aEL1LHF318NPv9OQOJJfMdn8j/sOITh9KAAIaTkMA3Jsw27f2bwe2UdpQFEj22LzGZANeaRRTqz7MQesZSz7de/DlgVSH3WvRxGojEg2nI0k/URHr7S38IrPX833J5fPnRqjSH/niHOiBtXVtM5pw1/E/Uk7MU+DuK6dYq6l40RXBlJfXmzzvYUNObx5S7Fpso11UmNeASWVjzBvaVcGKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tVuu3RmCcSBj75eAmrZr/3HeZ4SOTPDhyn5soIb4mhs=;
 b=NCWWFo+EIuLarthGGHj3FXFqHqvVw6ozVHSQqdVz3Tv/IEBEQCcg27NuhK9F5PhNOra7HifoHe373I0jJw7z/PJbZTPBZJEEa0l6IAGdThvoicf/ccAcLMHHLA7SYT01QY5eTW+zWbjy/AbUEPOw4iU8VYp5/YYJuUXZKWZ11Ww=
Received: from AM0PR08MB4097.eurprd08.prod.outlook.com (20.178.202.217) by
 AM0PR08MB4979.eurprd08.prod.outlook.com (10.255.29.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Thu, 7 Nov 2019 12:26:50 +0000
Received: from AM0PR08MB4097.eurprd08.prod.outlook.com
 ([fe80::41f0:981:fd75:9946]) by AM0PR08MB4097.eurprd08.prod.outlook.com
 ([fe80::41f0:981:fd75:9946%3]) with mapi id 15.20.2408.028; Thu, 7 Nov 2019
 12:26:50 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH v8 1/3] docs: improve qcow2 spec about extending image
 header
Thread-Topic: [PATCH v8 1/3] docs: improve qcow2 spec about extending image
 header
Thread-Index: AQHVhZkjTzzfnHiFj0qSiLP9bR+k/adgbZKAgAAKKwCAHitYAIABHveA
Date: Thu, 7 Nov 2019 12:26:50 +0000
Message-ID: <da2ddf4b-e549-c138-7bd9-237733885697@virtuozzo.com>
References: <20191018094758.7124-1-vsementsov@virtuozzo.com>
 <20191018094758.7124-2-vsementsov@virtuozzo.com>
 <71ad0b78-65da-9a39-4c12-f78449cdca9c@redhat.com>
 <ba5ae50c-9406-5095-89ae-6a10893e452e@virtuozzo.com>
 <8cfcca15-4018-2876-6d75-a4d5125beedc@redhat.com>
In-Reply-To: <8cfcca15-4018-2876-6d75-a4d5125beedc@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P195CA0011.EURP195.PROD.OUTLOOK.COM (2603:10a6:3:fd::21)
 To AM0PR08MB4097.eurprd08.prod.outlook.com
 (2603:10a6:208:132::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191107152647886
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 75cbff14-01ec-4332-ec3f-08d7637dc393
x-ms-traffictypediagnostic: AM0PR08MB4979:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR08MB4979014B0AE06BCEC2D980ECC1780@AM0PR08MB4979.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:901;
x-forefront-prvs: 0214EB3F68
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(376002)(366004)(396003)(39840400004)(136003)(189003)(199004)(31696002)(6512007)(26005)(107886003)(7736002)(305945005)(6486002)(14454004)(53546011)(6506007)(76176011)(86362001)(6436002)(6246003)(99286004)(31686004)(386003)(25786009)(229853002)(102836004)(64756008)(66446008)(66556008)(3846002)(66946007)(478600001)(66476007)(486006)(6116002)(11346002)(446003)(8676002)(110136005)(316002)(256004)(5660300002)(81166006)(2501003)(4326008)(54906003)(81156014)(66066001)(2906002)(186003)(8936002)(71200400001)(71190400001)(52116002)(36756003)(2616005)(476003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB4979;
 H:AM0PR08MB4097.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nzpAIpD+Sq/snGDVFiSG2rhJx3GENWEe39muO9M8fv5vd2TfzlfxkqqhY/1h03/rwgFnFkNYfWSEtjGXLijFQOugMatJ0BAICWhzRWOGHsd4Vpjbb7yD4jNWyZSTwRMqNJUgByaC8p4f435CKj+KAak/iT6x/Mm8nPBjZRElJJHuB4cXT05ZIa1UC1nqKovRwKQEFYcYM4vCSkABMPpQHcxhhztSR15qWtu44xvA4yKcLm/BrqPvOQ+VYyldnGxVHLcIJ84+q8cMFuSOSO6cQPgmCwx8Zih/WKCc2m4Fh1LylzzsQKQcyEp0/8qM4SrBwPuvszmtJEcRMknoZiYOcLuG6WnLmTYYwuEHgyOWOL1zzkxDjUw+mHQTz66fFinbrLD3lR7UOeH+yK1+eBVhMyJhxlRFw+guE/uum4EohCy/CyTDbEStOThpPgKqv9eW
Content-Type: text/plain; charset="utf-8"
Content-ID: <D43A2A7414A09F48BE103C75477B4499@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75cbff14-01ec-4332-ec3f-08d7637dc393
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2019 12:26:50.2206 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3epRzMY5ln5UZzMMtuzjT7PGMsTLoTs8JCV7g0mUBBmceDUxerimMLiWvYGLKI/bRnU1AJpVXxtz0aRHiAhdUnwWBLs5S5GiDal0W+ZQ4lc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4979
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.15.127
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

MDYuMTEuMjAxOSAyMjoxOSwgRXJpYyBCbGFrZSB3cm90ZToNCj4gT24gMTAvMTgvMTkgOTozNiBB
TSwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4gDQo+Pj4gTWF5YmU6DQo+
Pj4NCj4+PiBpZiBzb2Z0d2FyZSBkb2Vzbid0IGtub3cgaG93IHRvIGludGVycHJldCB0aGUgZmll
bGQsIGl0IG1heSBiZSBzYWZlbHkgaWdub3JlZCB1bmxlc3MgYSBjb3JyZXNwb25kaW5nIGluY29t
cGF0aWJsZSBmZWF0dXJlIGZsYWcgYml0IGlzIHNldDsgaG93ZXZlciwgdGhlIGZpZWxkIHNob3Vs
ZCBiZSBwcmVzZXJ2ZWQgdW5jaGFuZ2VkIHdoZW4gcmV3cml0aW5nIHRoZSBpbWFnZSBoZWFkZXIu
DQo+Pj4NCj4+Pj4gKw0KPj4+PiArRm9yIGFsbCBhZGRpdGlvbmFsIGZpZWxkcyB6ZXJvIHZhbHVl
IGVxdWFscyB0byBhYnNlbmNlIG9mIGZpZWxkIChhYnNlbmNlIGlzDQo+Pj4+ICt3aGVuIGZpZWxk
Lm9mZnNldCArIGZpZWxkLnNpemUgPiBAaGVhZGVyX2xlbmd0aCkuIFRoaXMgaW1wbGllcw0KPj4+
PiArdGhhdCBpZiBzb2Z0d2FyZSB3YW50J3MgdG8gc2V0IGZpZWxkcyB1cCB0byBzb21lIGZpZWxk
IG5vdCBhbGlnbmVkIHRvIG11bHRpcGx5DQo+Pj4+ICtvZiA4IGl0IG11c3QgYWxpZ24gaGVhZGVy
IHVwIGJ5IHplcm9lcy4gQW5kIG9uIHRoZSBvdGhlciBoYW5kLCBpZiBzb2Z0d2FyZQ0KPj4+PiAr
bmVlZCBzb21lIG9wdGlvbmFsIGZpZWxkIHdoaWNoIGlzIGFic2VudCBpdCBzaG91bGQgYXNzdW1l
IHRoYXQgaXQncyB2YWx1ZSBpcw0KPj4+PiAremVyby4NCj4+Pg0KPj4+IE1heWJlOg0KPj4+DQo+
Pj4gRWFjaCBvcHRpb25hbCBmaWVsZCB0aGF0IGRvZXMgbm90IGhhdmUgYSBjb3JyZXNwb25kaW5n
IGluY29tcGF0aWJsZSBmZWF0dXJlIGJpdCBtdXN0IHN1cHBvcnQgdGhlIHZhbHVlIDAgdGhhdCBn
aXZlcyB0aGUgc2FtZSBkZWZhdWx0IGJlaGF2aW9yIGFzIHdoZW4gdGhlIG9wdGlvbmFsIGZpZWxk
IGlzIG9taXR0ZWQuDQo+Pg0KPj4gSG1tbS4gVGhhdCBkb2Vzbid0IHdvcmssIGFzICJjb3JyZXNw
b25kaW5nIiBpcyBzb21ldGhpbmcgbm90IGFjdHVhbGx5IGRlZmluZWQuIENvbnNpZGVyIG91ciB6
c3RkIGV4dGVuc2lvbi4NCj4+DQo+PiBJdCBoYXMgY29ycmVzcG9uZGluZyBpbmNvbXBhdGlibGUg
Yml0LCB0aGVyZWZvcmUsIHRoaXMgc2VudGVuY2UgZG9lc24ndCBhcHBseSB0byBpdC4gQnV0IHN0
aWxsLCBpZiBpbmNvbXBhdGlibGUgYml0IGlzIHVuc2V0IHdlIGNhbiBoYXZlIHRoaXMgZmllbGQu
IEFuZCBpdCdzIHplcm8gdmFsdWUgbXVzdCBjb3JyZXNwb25kDQo+PiB0byB0aGUgYWJzZW5jZSBv
ZiB0aGUgZmllbGQuDQo+Pg0KPj4gU28sIGFkZGl0aW9uYWwgZmllbGQgbWF5IHVzZSBpbmNvbWFw
dGlibGUgYml0IG9ubHkgZm9yIHN1YnNldCBvZiBpdHMgdmFsdWVzLg0KPj4NCj4+IEJ1dCwgSSBz
ZWUsIHRoYXQgeW91IHdhbnQgdG8gYWxsb3cgMCB2YWx1ZSB0byBub3QgbWF0Y2ggZmllbGQtYWJz
ZW5jZSBpZiBpbmNvbXBhdGlibGUgYml0IGlzIHNldD8NCj4gDQo+IE5vdCBuZWNlc3NhcmlseS7C
oCBSYXRoZXIsIGlmIHRoZSB2YWx1ZSBvZiBhbiB1bmtub3duIGZpZWxkIGNhbiBiZSBzYWZlbHkg
aWdub3JlZCwgdGhlbiBpdCBzaG91bGQgZGVmYXVsdCB0byAwLsKgIElmIGl0IGNhbm5vdCBiZSBz
YWZlbHkgaWdub3JlZCwgdGhlbiB0aGF0IGZpZWxkIHdpbGwgbm90IGJlIHNldCB0byBhIG5vbi16
ZXJvIHZhbHVlIHdpdGhvdXQgYWxzbyBzZXR0aW5nIGFuIGluY29tcGF0aWJsZSBmZWF0dXJlIGZs
YWcsIHNvIHRoYXQgc29mdHdhcmUgdGhhdCBkb2VzIG5vdCBrbm93IGhvdyB0byBpbnRlcnByZXQg
dGhlIGZpZWxkIHdpbGwgZmFpbCB0byBsb2FkIHRoZSBpbWFnZSBiZWNhdXNlIGl0IGFsc28gZmFp
bHMgdG8gcmVjb2duaXplIHRoZSBhc3NvY2lhdGVkIG5ldyBpbmNvbXBhdGlibGUgZmVhdHVyZSBi
aXQuDQo+IA0KPiBCdXQgSSdkIHJlYWxseSBsaWtlIEtldmluJ3Mgb3BpbmlvbiBvbiBob3cgbXVj
aCB3b3JkaW5nIGlzIHdvcnRoIGFkZGluZy4NCj4gDQo+Pg0KPj4gU28sIG1heSBiZQ0KPj4NCj4+
IEFkZGl0aW9uYWwgZmllbGRzIGhhcyB0aGUgZm9sbG93aW5nIGNvbXBhdGlibGUgYmVoYXZpb3Ig
YnkgZGVmYXVsdDoNCj4gDQo+IHMvaGFzL2hhdmUvDQo+IA0KPj4NCj4+IDEuIElmIHNvZnR3YXJl
IGRvZXNuJ3Qga25vdyBob3cgdG8gaW50ZXJwcmV0IHRoZSBmaWVsZCwgaXQgbWF5IGJlIHNhZmVs
eSBpZ25vcmVkLCBvdGhlciB0aGFuIHByZXNlcnZpbmcgdGhlIGZpZWxkIHVuY2hhbmdlZCB3aGVu
IHJld3JpdGluZyB0aGUgaW1hZ2UgaGVhZGVyLg0KPj4gMi4gWmVyb2VkIGFkZGl0aW9uYWwgZmll
bGQgZ2l2ZXMgdGhlIHNhbWUgYmVoYXZpb3IgYXMgd2hlbiB0aGlzIGZpZWxkIGlzIG9taXR0ZWQu
DQo+IA0KPiBCb3RoIGdvb2QuDQo+IA0KPj4NCj4+IFRoaXMgZGVmYXVsdCBiZWhhdmlvciBtYXkg
YmUgYWx0ZXJlZCB3aXRoIGhlbHAgb2YgaW5jb21wYXRpYmxlIGZlYXR1cmUgYml0cy4gU28sIGlm
LCBmb3IgZXhhbXBsZSwgYWRkaXRpb25hbCBmaWVsZCBoYXMgY29ycmVzcG9uZGluZyBpbmNvbXBh
dGlibGUgZmVhdHVyZSBiaXQsIGFuZCBpdCBpcyBzZXQsIHdlIGFyZSBzdXJlIHRoYXQgc29mdHdh
cmUgd2hpY2ggb3BlbnMgdGhlIGltYWdlIGtub3dzIGhvdyB0byBpbnRlcnByZXQgdGhlIGZpZWxk
LCBzbywNCj4+IDEuIFRoZSBmaWVsZCBkZWZpbml0ZWx5IHdpbGwgbm90IGJlIGlnbm9yZWQgd2hl
biBjb3JyZXNwb25kaW5nIGluY29tcGF0aWJsZSBiaXQgaXMgc2V0Lg0KPj4gMi4gVGhlIGZpZWxk
IG1heSBkZWZpbmUgYW55IG1lYW5pbmcgaXQgd2FudHMgZm9yIHplcm8gdmFsdWUgZm9yIHRoZSBj
YXNlIHdoZW4gY29ycmVzcG9uZGluZyBpbmNvbXBhdGlibGUgYml0IGlzIHNldC4NCj4gDQo+IFJh
dGhlciB3b3JkeSBidXQgc2VlbXMgYWNjdXJhdGUuwqAgUGVyaGFwcyBjb21wcmVzcyBpdCB0bzoN
Cj4gDQo+IDMuIEFueSBhZGRpdGlvbmFsIGZpZWxkIHdob3NlIHZhbHVlIG11c3Qgbm90IGJlIGln
bm9yZWQgZm9yIGNvcnJlY3QgaGFuZGxpbmcgb2YgdGhlIGZpbGUgd2lsbCBiZSBhY2NvbXBhbmll
ZCBieSBhIGNvcnJlc3BvbmRpbmcgaW5jb21wYXRpYmxlIGZlYXR1cmUgYml0Lg0KPiANCj4gYW5k
IG1heWJlIGV2ZW4gcmVvcmRlciBpdCB0byBsaXN0IHRoZSBwb2ludHMgYXM6DQo+IA0KPiBBZGRp
dGlvbmFsIGZpZWxkcyBoYXZlIHRoZSBmb2xsb3dpbmcgY29tcGF0aWJpbGl0eSBydWxlczoNCj4g
MS4gQW55IGFkZGl0aW9uYWwgZmllbGQgd2hvc2UgdmFsdWUgbXVzdCBub3QgYmUgaWdub3JlZCBm
b3IgY29ycmVjdCBoYW5kbGluZyBvZiB0aGUgZmlsZSB3aWxsIGJlIGFjY29tcGFuaWVkIGJ5IGEg
Y29ycmVzcG9uZGluZyBpbmNvbXBhdGlibGUgZmVhdHVyZSBiaXQuDQoNCkknZCBsaWtlIHRvIHN0
cmVzcywgdGhhdCBpbmNvbXBhdGlibGUgYml0IGlzIG5lZWRlZCBmb3IgaW5jb21wYXRpYmxlIHZh
bHVlLCBub3QgZm9yIHRoZSBmaWVsZCBpdHNlbGYuIChTbyBmaWVsZCBtYXkgYmUgYWNjb21wYW5p
ZWQgYnkgaW5jb21wYXRpYmxlIGJpdCBmb3Igc29tZQ0KaXQncyB2YWx1ZXMgYW5kIGZvciBvdGhl
cnMgLSBub3QpLCBTbywgd2hhdCBhYm91dA0KDQoxLiBJZiB0aGUgdmFsdWUgb2YgdGhlIGFkZGl0
aW9uYWwgZmllbGQgbXVzdCBub3QgYmUgaWdub3JlZCBmb3IgY29ycmVjdCBoYW5kbGluZyBvZiB0
aGUgZmlsZSwgaXQgd2lsbCBiZSBhY2NvbXBhbmllZCBieSBhIGNvcnJlc3BvbmRpbmcgaW5jb21w
YXRpYmxlIGZlYXR1cmUgYml0Lg0KDQo+IDIuIElmIHRoZXJlIGFyZSBubyB1bnJlY29nbml6ZWQg
aW5jb21wYXRpYmxlIGZlYXR1cmUgYml0cyBzZXQsIGFuIGFkZGl0aW9uYWwgZmllbGQgbWF5IGJl
IHNhZmVseSBpZ25vcmVkIG90aGVyIHRoYW4gcHJlc2VydmluZyBpdHMgdmFsdWUgd2hlbiByZXdy
aXRpbmcgdGhlIGltYWdlIGhlYWRlci4NCg0KU291bmRzIGxpa2Ugd2UgY2FuIGlnbm9yZSB0aGUg
ZmllbGQgaWYgd2Uga25vdyBpdHMgbWVhbmluZyBhbmQga25vdyBpdHMgaW5jb21wYXRpYmxlIGJp
dC4uDQoNCjIuIElmIHRoZXJlIGFyZSBubyB1bnJlY29nbml6ZWQgaW5jb21wYXRpYmxlIGZlYXR1
cmUgYml0cyBzZXQsIGFuIHVua25vd24gYWRkaXRpb25hbCBmaWVsZCBtYXkgYmUgc2FmZWx5IGln
bm9yZWQgb3RoZXIgdGhhbiBwcmVzZXJ2aW5nIGl0cyB2YWx1ZSB3aGVuIHJld3JpdGluZyB0aGUg
aW1hZ2UgaGVhZGVyLg0KDQo+IDMuIEFuIGV4cGxpY2l0IHZhbHVlIG9mIDAgd2lsbCBoYXZlIHRo
ZSBzYW1lIGJlaGF2aW9yIGFzIHdoZW4gdGhlIGZpZWxkIGlzIG5vdCBwcmVzZW50Lg0KDQpCdXQg
aXQgbWF5IGJlIGNoYW5nZWQgYnkgaW5jb21wYXRpYmxlIGJpdC4uDQoNCjMuIEFuIGV4cGxpY2l0
IHZhbHVlIG9mIDAgd2lsbCBoYXZlIHRoZSBzYW1lIGJlaGF2aW9yIGFzIHdoZW4gdGhlIGZpZWxk
IGlzIG5vdCBwcmVzZW50LCBpZiBub3QgYWx0ZXJlZCBieSBzcGVjaWZpYyBpbmNvbXBhdGlibGUg
Yml0Lg0KDQo+IA0KPiANCj4+Pj4gK0l0J3MgYWxsb3dlZCBmb3IgdGhlIGhlYWRlciBlbmQgdG8g
Y3V0IHNvbWUgZmllbGQgaW4gdGhlIG1pZGRsZSAoaW4gdGhpcyBjYXNlDQo+Pj4+ICt0aGUgZmll
bGQgaXMgY29uc2lkZXJlZCBhcyBhYnNlbnQpLCBidXQgaW4gdGhpcyBjYXNlIHRoZSBwYXJ0IG9m
IHRoZSBmaWVsZA0KPj4+PiArd2hpY2ggaXMgY292ZXJlZCBieSBAaGVhZGVyX2xlbmd0aCBtdXN0
IGJlIHplcm9lZC4NCj4+Pj4gKw0KPj4+PiArwqDCoMKgwqDCoMKgwqAgPCAuLi4gTm8gYWRkaXRp
b25hbCBmaWVsZHMgaW4gdGhlIGhlYWRlciBjdXJyZW50bHkgLi4uID4NCj4+Pg0KPj4+IERvIHdl
IGV2ZW4gc3RpbGwgbmVlZCB0aGlzIGlmIHdlIHJlcXVpcmUgOC1ieXRlIGFsaWdubWVudD/CoCBX
ZSdkIG5ldmVyIGJlIGFibGUgdG8gY3V0IGEgc2luZ2xlIGZpZWxkIGluIHRoZSBtaWRkbGUNCj4+
DQo+PiBobW0sIGZvciBleGFtcGxlOg0KPj4gMTA1OiBjb21wcmVzc2lvbiBieXRlDQo+PiAxMDYt
MTEzOiBzb21lIG90aGVyIDgtYnl0ZXMgZmllbGQsIHVuYWxpbmdlZA0KPj4gMTEzLTExOTogcGFk
ZGluZyB0byBtdWx0aXBseSBvZiA4DQo+Pg0KPj4gLSBiYWQgZXhhbXBsZSwgZm9yIHN1cmUuIEJ1
dCB0byBwcmV2ZW50IGl0LCB3ZSBzaG91bGQgYWxzbyBkZWZpbmUgc29tZSBmaWVsZCBhbGlnbm1l
bnQgcmVxdWlyZW1lbnRzLi4NCj4+DQo+Pg0KPj4+ICwgYnV0IEkgc3VwcG9zZSB5b3UgYXJlIHdv
cnJpZWQgYWJvdXQgY3V0dGluZyBhIDItZmllbGQgMTYtYnl0ZSBhZGRpdGlvbiB0aWVkIHRvIGEg
c2luZ2xlIGZlYXR1cmUgaW4gdGhlIG1pZGRsZS4NCj4+DQo+PiBhbmQgdGhpcyB0b28uDQo+Pg0K
Pj4+IMKgwqAgQnV0IHRoYXQncyBub3QgZ29pbmcgdG8gaGFwcGVuIGluIHByYWN0aWNlLg0KPj4N
Cj4+IHdoeSBub3Q/DQo+Pg0KPj4gNCBieXRlczogZmVhdHVyZSAxDQo+Pg0KPj4gNCBieXRlczog
ZmVhdHVyZSAyDQo+PiA4IGJ5dGVzOiBmZWF0dXJlIDINCj4+DQo+PiBzbywgbGFzdCAxMiBieXRl
cyBtYXkgYmUgY29uc2lkZXJlZCBhcyBvbmUgZmllbGQuLiBBbmQgc29mdHdhcmUgd2hpY2ggZG9u
J3Qga25vdyBhYm91dCBmZWF0dXJlMiwgd2lsbCBwYWQgaGVhZGVyIHRvIHRoZSBtaWRkbGUgb2Yg
ZmVhdHVyZTINCj4+DQo+Pj4gVGhlIG9ubHkgdGltZSB0aGUgaGVhZGVyIHdpbGwgYmUgbG9uZ2Vy
IHRoYW4gMTA0IGJ5dGVzIGlzIGlmIGF0IGxlYXN0IG9uZSBkb2N1bWVudGVkIG9wdGlvbmFsIGZl
YXR1cmUgaGFzIGJlZW4gaW1wbGVtZW50ZWQvYmFja3BvcnRlZCwgYW5kIHRoYXQgZmVhdHVyZSB3
aWxsIGJlIGltcGxlbWVudGVkIGluIGl0cyBlbnRpcmV0eS7CoCBJZiB5b3UgYmFja3BvcnQgYSBs
YXRlciBmZWF0dXJlIGJ1dCBub3QgdGhlIGVhcmxpZXIsIHlvdSdyZSBzdGlsbCBnb2luZyB0byBz
ZXQgaGVhZGVyX2xlbmd0aCB0byB0aGUgYm91bmRhcnkgb2YgdGhlIGZlYXR1cmUgdGhhdCB5b3Ug
QVJFIGJhY2twb3J0aW5nLg0KPj4NCj4+IFRoYXQncyB0cnVlLCBvZiBjb3Vyc2UuDQo+Pg0KPj4+
IMKgwqAgVGh1cywgSSBhcmd1ZSB0aGF0IGJsaW5kbHkgc2V0dGluZyBoZWFkZXJfbGVuZ3RoIHRv
IDEyMCBwcmlvciB0byB0aGUgc3RhbmRhcmQgZXZlciBkZWZpbmluZyBvcHRpb25hbCBmaWVsZChz
KSBhdCAxMTItMTIwIGlzIHByZW1hdHVyZSwgYW5kIHRoYXQgaWYgd2UgZXZlciBhZGQgYSBmZWF0
dXJlIHJlcXVpcmluZyBieXRlcyAxMTItMTI4IGZvciBhIG5ldyBmZWF0dXJlLCB5b3Ugd2lsbCBu
ZXZlciBzZWUgYSB2YWxpZCBxY293MiBmaWxlIHdpdGggYSBoZWFkZXIgbGVuZ3RoIG9mIDEyMC4N
Cj4+DQo+PiBjb25zaWRlciBteSBleGFtcGxlIGFib3ZlLg0KPiANCj4gQXMgbG9uZyBhcyB3ZSBu
ZXZlciBhZGQgbmV3IGZpZWxkcyB0aGF0IGFyZSBub3QgOC1ieXRlIGFsaWduZWQgKGluY2x1ZGlu
ZyBhbnkgZXhwbGljaXQgcGFkZGluZyksIHRoZW4gd2Ugd2lsbCBuZXZlciBoYXZlIHRoZSBjYXNl
IG9mIGRpdmlkaW5nIGZpZWxkcyBpbiB0aGUgbWlkZGxlIGJ5IGtlZXBpbmcgdGhlIGhlYWRlciBs
ZW5ndGggYSBtdWx0aXBsZSBvZiA4Lg0KPiANCg0KT0suDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0K
VmxhZGltaXINCg==

