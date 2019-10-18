Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA16CA9EA9
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 14:15:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98C5E21925
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 14:15:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="j/nHZKzb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98C5E21925
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLT2O-00016z-Hf
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 10:15:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55926)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iLSi0-0002ku-OL
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 09:54:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iLShy-0008LE-25
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 09:54:24 -0400
Received: from mail-eopbgr20112.outbound.protection.outlook.com
 ([40.107.2.112]:33440 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iLShx-0008KE-E1; Fri, 18 Oct 2019 09:54:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AfMXnItOYD1MS7ywnn0efCb+9YlJUyBsmtCn1GeFWm0ZO3dnnM3JZCzUIwy2YbKugRgBoUT1ze44AxvtlroRiJNvvVoTUED3Sp5YeLR0vhfqnWmrNGNA5m8uEEO4Wu1TWxFKFDcsz7IHaHn6Hb4b3zD5ObaCeNlMdAsbhhiprfeZanIzENTzBBusDPejalWNUjBp5i8CFP7NSDB/HokVljWMlgsZeWH0XEKUTdZvS0bfb4oldOWBF7u/jatXg+pYT1JkH9uZeHQdzymOdqGfVKXLGNzh+baig7beAfuZr54w+Ud0ia+D4GKicwJiqML+zOdp+/bfzHmDNr1UuRWEDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WbYPJncYIJOFkknbA6XveKFQYCulWagmYR6PrbGU91s=;
 b=CwbwA6eJY5eHElHUf/wqw+SkUd1lj9YbUjK/XWrE/geOwFjeWqupizcsw7lZPiHLGW0GjbQV1298m0xbtN02MNbt34s0D3NCe+icJra5iF4VbWUamAIuGIB3NvO3e7U62IjLGwpu4xBSOq1Yxa4XHXJDAAi6Yu1PtUxloGG53u6rzqKz8xJgvebfv2OgFOCa72xBrOvQ35M0pHGAU/kJjilrG+6FYjukMFKn5SllbqfZiCXcwbr4nBsYlOgZdzo1g6vLhz4uurLObJS3yTSH+7z15iUvDJfapWRKyK2W4NEGgLFCIt18d1lgIoMRWst/CDCM4NljFJ+04XwgHfrwWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WbYPJncYIJOFkknbA6XveKFQYCulWagmYR6PrbGU91s=;
 b=j/nHZKzb9wP2kFZQLH+r7eZJsh35pFLCKe7A7hHBGSyALnqWMSgO2TqFj83OCgmi8VgZQdjsudOOGe+GEQqu1wGX1kua7NwFGo35m94eKoc1dxTw451O5nT3nZr3q1+FE6w9jzIgjpbeRL28iKSCFNnqX1odXrmgOr86xCsgmuk=
Received: from AM0PR08MB4435.eurprd08.prod.outlook.com (20.179.35.83) by
 AM0PR08MB4593.eurprd08.prod.outlook.com (20.178.21.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.21; Fri, 18 Oct 2019 13:54:18 +0000
Received: from AM0PR08MB4435.eurprd08.prod.outlook.com
 ([fe80::4461:dd32:b358:110c]) by AM0PR08MB4435.eurprd08.prod.outlook.com
 ([fe80::4461:dd32:b358:110c%7]) with mapi id 15.20.2347.026; Fri, 18 Oct 2019
 13:54:18 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH v7 1/2] docs: improve qcow2 spec about extending image
 header
Thread-Topic: [PATCH v7 1/2] docs: improve qcow2 spec about extending image
 header
Thread-Index: AQHVfSj4NZxneckXjESRnSlwVfPCUadPn1aAgADVRwCAD61pgIAAEDYAgABGQ4CAAAQ9gA==
Date: Fri, 18 Oct 2019 13:54:18 +0000
Message-ID: <8a039893-93df-aef2-3223-b5f9829c2047@virtuozzo.com>
References: <20191007160451.27334-1-vsementsov@virtuozzo.com>
 <20191007160451.27334-2-vsementsov@virtuozzo.com>
 <7afa803e-3efd-1186-2b37-7056d9a983f0@redhat.com>
 <90102485-ccbb-018c-c90d-b85a7b2f0392@virtuozzo.com>
 <2d60f7aa-7f3a-18f2-434f-0ab176924be2@virtuozzo.com>
 <b157b428-4f30-ddad-2eb6-78bd9ca3bc21@virtuozzo.com>
 <37a0d4f3-6967-1115-fbea-43d5ce5c6973@redhat.com>
In-Reply-To: <37a0d4f3-6967-1115-fbea-43d5ce5c6973@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0502CA0024.eurprd05.prod.outlook.com
 (2603:10a6:3:e3::34) To AM0PR08MB4435.eurprd08.prod.outlook.com
 (2603:10a6:208:144::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191018165415801
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 09e65c52-200b-4757-794d-08d753d2ab56
x-ms-traffictypediagnostic: AM0PR08MB4593:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR08MB459371511AEF4C1D67F72968C16C0@AM0PR08MB4593.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01949FE337
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(366004)(39840400004)(376002)(346002)(396003)(199004)(189003)(6506007)(256004)(14444005)(52116002)(26005)(316002)(76176011)(25786009)(478600001)(110136005)(6436002)(5660300002)(2501003)(386003)(486006)(54906003)(53546011)(66066001)(6486002)(6246003)(11346002)(14454004)(102836004)(107886003)(7736002)(66946007)(71200400001)(71190400001)(2616005)(66446008)(64756008)(66556008)(31696002)(66476007)(476003)(229853002)(6512007)(186003)(99286004)(8676002)(86362001)(81156014)(2906002)(6116002)(3846002)(4326008)(8936002)(446003)(305945005)(81166006)(31686004)(36756003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB4593;
 H:AM0PR08MB4435.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +6R5K0BzzvxApG5UGzmhC5zoX8k+2a0WPKKthUASOCAMBSkz36kT+JlONo565aJb8zlOd6KnlNg1c+IaNYIqfuQjPPKs54UkDJJgj3r3013DSY/FPUkdQD5u29RlAdO/ThcbYSUW5p5BQYW3M+oNC70DSq8gGMqGgrTzXNv+ZCJ3o5Fwr03ZtRxRvGV+bRpMBpmgTeMwwwwYE3263ga+sZhxCk5asVTjumLq/wPJQzfmbZlILmZ35b8zDNuR/regyYKJNHHD5acc0nFD06q6vqSEv3On9pejrcnMGE0mgQUiRf+nAyj5G7OuG8iqk5NwNLDH8oJsuD4gPBh92tSywUe1XFW+yH6Y+cEMzN0sjpH5CMZsJsIOAvYU79zhYs0om+p1yg8eBeM9p2DSmpO3ixsMh3oRiyqjRefsuv3hKXs=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FA96BCA291BBD94CA6F89F865D98F1A9@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09e65c52-200b-4757-794d-08d753d2ab56
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2019 13:54:18.3000 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BOMT5/XGda2GUf2yf/zyTzdSClhIir6Re4YA3xDSzkeLAajE8xD1iPSaYCnCvgUZjnWi8HKYs3lO6eDAB+DVLsgieHGrUYtF56BWJ7+ipYs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4593
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.2.112
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

MTguMTAuMjAxOSAxNjozOSwgRXJpYyBCbGFrZSB3cm90ZToNCj4gT24gMTAvMTgvMTkgNDoyNyBB
TSwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4gDQo+Pj4+PiBJIHdvdWxk
IHN1Z2dlc3QgYSBzdHJvbmdlciByZXF1aXJlbWVudDoNCj4+Pj4+DQo+Pj4+PiBoZWFkZXJfbGVu
Z3RoIG11c3QgYmUgYSBtdWx0aXBsZSBvZiA0LCBhbmQgbXVzdCBub3QgbGFuZCBpbiB0aGUgbWlk
ZGxlIG9mIGFueSBvcHRpb25hbCA4LWJ5dGUgZmllbGQuDQo+Pj4+Pg0KPj4+Pj4gT3IgbWF5YmUg
ZXZlbiBhZGQgb3VyIGNvbXByZXNzaW9uIHR5cGUgZXh0ZW5zaW9uIHdpdGggNCBieXRlcyBvZiBw
YWRkaW5nLCBzbyB0aGF0IHdlIGNvdWxkIGdvIGV2ZW4gc3Ryb25nZXI6DQo+Pj4+Pg0KPj4+Pj4g
aGVhZGVyX2xlbmd0aCBtdXN0IGJlIGEgbXVsdGlwbGUgb2YgOC4NCj4+Pj4NCj4+Pj4gSG1tLCBp
ZiB3ZSBpbXBseSB0aGF0IHNvZnR3YXJlIHdpbGwgaGF2ZSB0byBhZGQgc29tZSBwYWRkaW5nLCB0
aGFuIHJlcXVpcmVtZW50IGFib3ZlIGFib3V0IHplcm8gPT09IGZlYXR1cmUtYWJzZW5jZQ0KPj4+
PiBiZWNvbWVzIG5lY2Vzc2FyeS4gWypdDQo+Pj4+DQo+Pj4+IFN0aWxsIEkgaGF2ZSB0d28gcXVl
c3Rpb25zOg0KPj4+PiAxLiBEbyB3ZSByZWFsbHkgbmVlZCBhbGwgZmllbGRzIHRvIGJlIDQgb3Ig
OCBieXRlcz8gV2h5IG5vdCB1c2UgMSBieXRlIGZvciBjb21wcmVzc2lvbj8NCj4gDQo+IE5vLCBm
aWVsZHMgY2FuIGJlIHNtYWxsZXIgaWYgdGhhdCBtYWtlcyBzZW5zZTsgYnV0IEkgc3RpbGwgdGhp
bmsgaXQncyBpbXBvcnRhbnQgdGhhdCBmaWVsZHMgZG9uJ3Qgc3RyYWRkbGUgbmF0dXJhbCBhbGln
bm1lbnQgYm91bmRhcmllcy4gV2hlbiBhZGRpbmcganVzdCBvbmUgZmllbGQgYXQgYSB0aW1lLCBp
dCdzIGVhc2llciB0byBhZGQgYSB3aWRlIGZpZWxkIGFuZCBsZXNzIHBhZGRpbmcgdGhhbiBhIG5h
cnJvdyBmaWVsZCBhbmQgbG90cyBvZiBwYWRkaW5nLCBpZiB3ZSdyZSBzdGlsbCBzdHJpdmluZyBm
b3IgYWxpZ25tZW50Lg0KPiANCj4+Pj4gMi4gV2hhdCBpcyB0aGUgYmVuZWZpdCBvZiBwYWRkaW5n
LCB3aGljaCB5b3UgcHJvcG9zZT8NCj4gDQo+IFRoZSBiaWdnZXN0IGJlbmVmaXQgdG8ga2VlcGlu
ZyBsYXJnZSBmaWVsZHMgZnJvbSBzdHJhZGRsaW5nIGFsaWdubWVudCBib3VuZGFyaWVzIGlzIHRo
YXQgeW91IGNhbiBtbWFwKCkgYSBxY293MiBmaWxlIGFuZCBkbyBuYXR1cmFsbHktYWxpZ25lZCBy
ZWFkcyBvZiB0aG9zZSBsYXJnZSBmaWVsZHMsIHJhdGhlciB0aGFuIGJ5dGUtYnktYnl0ZSByZWFk
cywgd2l0aG91dCByaXNraW5nIFNJR0JVUyBvbiBzb21lIGFyY2hpdGVjdHVyZXMuwqAgKFlvdSBz
dGlsbCBoYXZlIHRvIHdvcnJ5IGFib3V0IGVuZGlhbm5lc3MsIGJ1dCB0aGF0J3MgdHJ1ZSByZWdh
cmRsZXNzIG9mIGFsaWdubWVudCkNCj4gDQo+IA0KPj4+IFNvLCBpdCBsb29rcyBpbmNvbnNpc3Rl
bnQsIGlmIHdlIHBhZCBhbGwgaGVhZGVyIGV4dGVuc2lvbnMgdG/CoCA4IGJ5dGVzIGV4Y2VwdCBm
b3IgdGhlIHN0YXJ0IG9mIHRoZSBmaXJzdCBleHRlbnNpb24uDQo+Pj4NCj4+PiBJJ2xsIHJlc2Vu
ZCB3aXRoIHBhZGRpbmcgc29vbi4NCj4+DQo+Pg0KPj4gU3RpbGwsIHdlIGhhdmUgdG8gbWFrZSBh
biBleGNlcHRpb24gYXQgbGVhc3QgZm9yIGhlYWRlcl9sZW5ndGggPSAxMDQsIHdoaWNoIGlzIG5v
dCBhIG11bHRpcGx5IG9mIDguDQo+IA0KPiBIdWg/wqAgMTA0ID09IDggKiAxMywgc28gb3VyIGN1
cnJlbnQgdjMgaGVhZGVyIHNpemUgaXMgOC1ieXRlIGFsaWduZWQuIExpa2V3aXNlIGZvciA3MiA9
PSA4ICogOSBmb3IgdjIgaGVhZGVyIHNpemUuDQoNCkFoYWhhaGFoYSwgc2hhbWUgb24gbXkgaGVh
ZDopIEkgc2hvdWxkIGdvIHRvIHNjaG9vbCBhZ2Fpbi4NCg0KPiANCj4+DQo+PiBBbHNvLCBpcyBy
ZXF1aXJpbmcgYWxpZ25tZW50IGlzIGFuIGluY29tcGF0aWJsZSBjaGFuZ2Ugb2Ygc3BlY2lmaWNh
dGlvbj8NCj4gDQo+IE5vLiBJIHRoaW5rIGl0IGlzIGp1c3QgY2xhcmlmeWluZyB3aGF0IHdhcyBp
bXBsaWNpdGx5IGFscmVhZHnCoCB0aGUgY2FzZS4gwqBSZW1lbWJlciwgaW1tZWRpYXRlbHkgYWZ0
ZXIgdGhlIGhlYWRlciBjb21lcyBoZWFkZXIgZXh0ZW5zaW9ucywgYW5kIFRIT1NFIGFyZSBleHBs
aWNpdGx5IHJlcXVpcmVkIHRvIGJlIG11bHRpcGxlLW9mLTggaW4gc2l6ZS7CoCBUaGF0IHJlcXVp
cmVtZW50IG1ha2VzIG5vIHNlbnNlIHVubGVzcyB0aGUgaGVhZGVyIGl0c2VsZiBlbmRzIG9uIGFu
IDgtYnl0ZSBhbGlnbm1lbnQgKHdoaWNoIGl0IGRvZXMgZm9yIGFsbCBleGlzdGluZyB2MiBhbmQg
djMgaW1hZ2VzIHByaW9yIHRvIG91ciBmaXJzdCBvZmZpY2lhbCB2MyBoZWFkZXIgZXh0ZW5zaW9u
KS4NCj4gDQoNCk9LLCBsZXQncyBnbyB3aXRoIGl0LCBJJ2xsIHJlc2VuZCBhZ2Fpbi4NCg0KDQot
LSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

