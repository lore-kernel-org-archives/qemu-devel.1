Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F289C00454
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:27:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1336521655
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ii4rXHnx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1336521655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifk0d-0007N0-IW
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 07:25:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35694)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1ifjzx-0006xR-7x
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 07:24:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1ifjzv-0000bJ-0K
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 07:24:44 -0500
Received: from mail-eopbgr00123.outbound.protection.outlook.com
 ([40.107.0.123]:38894 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1ifjzu-0000XP-5V
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 07:24:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GNRlf3q6aUdaE3oMoU8v8FoJANUAUA08ph6aPum1TplHsi8OBnftRvHxOVNWNdd+4+NsrPqiFAREZdAFZEV+YFKbV0IKpagZ53IutU8EhYlVhhd9MtR8os3o6u6qyKrXxEZ6L6uxsnbC91FHZcxfwO6AubN++bKO/kp4E98O+lPB7pymODEr1pVd09plCgH4+//59fN8T2HspBaEC7tIGyrhwWLsoIa4VCLi/jBq2EUJaH7iiSGqt3INZxXbTwVh7Y8qKNilsdff8InrvPJfbysLhVhY0H1j36DTzCxBfhw6RbAxeV7yaHsFsHPiDV4pIEknHmMaXCAKo4OF2bqahA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dIRh3eU/04z52jVwp4Eh2vjqz/qsddyD+bm1ESmb74M=;
 b=QqCR199M767EOAVJ8/rQaG9T2BsIGtjEkVqddRAVdgqc4B6P0uhcmlBJJIePl5pe+eb+BtqxdeQVJJ908AZ/2oBQ/iltlzeo6zzs3ghUI5KEXCmYYAUZj7zMDJNz3JjPpPOUOFDmKzwY7MdSenZWswFDnrCFFzl9JIrab2puPIUSEgefY+djDbUkbALKzre/amky244X+XwvCHGwdh7+Y8yMiWkB98geJF6XwDxWXY/EUtOX6wQYWP6GzA7yBzWdAzd8cwEzyJA+GbUGORF4GcPhO1d3SUqO1Nh53OOP3fSjw2UWB5BgCqKmSwfzvSgZG6lQuxwHF+b1Z0vLIiOzdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dIRh3eU/04z52jVwp4Eh2vjqz/qsddyD+bm1ESmb74M=;
 b=ii4rXHnxQvchxGPPFMaGgsqFYQyZH0y2PvPdrwUSLNXXOdpaSM14Ab0ENPH9P5guJW7VPWKzU4ZI1nFjeOYxBouHRpLW1qoqTAd79vC7w+aCZyUnVA6XS0S6Lf2fTevCUoWN6IsBoHG+DKCU0TUMklugSUME0oQs8ajJwilDoqs=
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (20.178.22.27) by
 AM0PR08MB5124.eurprd08.prod.outlook.com (10.255.30.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Fri, 13 Dec 2019 12:24:39 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::893d:bf37:4b98:12]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::893d:bf37:4b98:12%4]) with mapi id 15.20.2538.017; Fri, 13 Dec 2019
 12:24:38 +0000
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PING] [PATCH] virtio: fix IO request length in virtio SCSI/block
 #PSBM-78839
Thread-Topic: [PING] [PATCH] virtio: fix IO request length in virtio
 SCSI/block #PSBM-78839
Thread-Index: AQHVhasj1hrogEqe4kWfxpGYRrvmHqdoxjuAgADscwCAFHZTAIAd3+QAgA9vtoCADNycAA==
Date: Fri, 13 Dec 2019 12:24:38 +0000
Message-ID: <0b89bf1a-5454-2d12-d383-0c83c254dd9a@virtuozzo.com>
References: <20191018115547.19299-1-dplotnikov@virtuozzo.com>
 <20191023172005-mutt-send-email-mst@kernel.org>
 <42b80a75-6ab4-5123-bbf5-eee21c2841ac@virtuozzo.com>
 <20191106065816-mutt-send-email-mst@kernel.org>
 <c39d90bc-92c0-6b53-b7a6-992ec69bb0b0@virtuozzo.com>
 <f0a0906b-0a76-fe28-331c-f08e00014cef@virtuozzo.com>
In-Reply-To: <f0a0906b-0a76-fe28-331c-f08e00014cef@virtuozzo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0101CA0013.eurprd01.prod.exchangelabs.com
 (2603:10a6:3:77::23) To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dplotnikov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [46.63.153.184]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f687c229-f89c-4c2a-a8c9-08d77fc76bf5
x-ms-traffictypediagnostic: AM0PR08MB5124:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR08MB5124DD43F13CC2A3F44E9C79CF540@AM0PR08MB5124.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0250B840C1
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(376002)(366004)(39850400004)(396003)(136003)(189003)(199004)(66556008)(66476007)(36756003)(6916009)(2906002)(31686004)(52116002)(31696002)(66946007)(86362001)(478600001)(81166006)(81156014)(66446008)(64756008)(5660300002)(54906003)(6486002)(4326008)(316002)(2616005)(8676002)(71200400001)(26005)(8936002)(186003)(6506007)(53546011)(6512007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB5124;
 H:AM0PR08MB3745.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8GFBuGGDThJb0J8xv3R8if4HlFS/h+S31r954VTcccST8MByp0g3ZWNcEWUOxrMgDqwPpup81xFcAMmFHedhRS393I6WdnzgIm96i1qfgBbA+EdER40zw5cRHhp7IWOL8cXt5uUUFA3g+RrTYP87Lk1wHh4DhXu5QKdWsraTHkKB56Kwi/UgOX86RQLvTElA1Wdf/D5KWpGBtWFSYtco7YQC/CZlBDNN1MmeeZXQZew+2ydc0r7sprEAe9Nqih2c4yjKgrvV21P95ihtyXoOsO/73EGihyFYlarm3pAytSNvoQ5K6piX2CGj1DrYfn7z5w1w+VcF/Nv2sVTAv8/3p5dc0SLlJrfdMiFRjo1BnHG+BJKzuU5Bo0PCk7uuxxAmXJWtVaRxiLuIzfk19M7rfDRHhtJOFn956IGH4NWy/3OiaSkcCv4SVx+Uz1u/VsIV
Content-Type: text/plain; charset="utf-8"
Content-ID: <B5F8030378D02547BD471EDF74C0C4D0@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f687c229-f89c-4c2a-a8c9-08d77fc76bf5
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2019 12:24:38.6773 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9OTdUgYg+2QYAJ8SLL+7nIXlSsZW3AKSL8UgoAFw+sq8oF+ckhKoMeLviEAYAeFP+gWpc2Ub4IA5HdarFjEPKnnL5jQ2ji0VktSm8x5yP14=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5124
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.0.123
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>, Roman Kagan <rkagan@virtuozzo.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "kraxel@redhat.com" <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDA1LjEyLjIwMTkgMTA6NTksIERlbmlzIFBsb3RuaWtvdiB3cm90ZToNCj4gUGluZyEN
Cj4NCj4gT24gMjUuMTEuMjAxOSAxMjoxNiwgRGVuaXMgUGxvdG5pa292IHdyb3RlOg0KPj4NCj4+
DQo+PiBPbiAwNi4xMS4yMDE5IDE1OjAzLCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6DQo+Pj4g
T24gVGh1LCBPY3QgMjQsIDIwMTkgYXQgMTE6MzQ6MzRBTSArMDAwMCwgRGVuaXMgTHVuZXYgd3Jv
dGU6DQo+Pj4+IE9uIDEwLzI0LzE5IDEyOjI4IEFNLCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6
DQo+Pj4+PiBPbiBGcmksIE9jdCAxOCwgMjAxOSBhdCAwMjo1NTo0N1BNICswMzAwLCBEZW5pcyBQ
bG90bmlrb3Ygd3JvdGU6DQo+Pj4+Pj4gRnJvbTogIkRlbmlzIFYuIEx1bmV2IiA8ZGVuQG9wZW52
ei5vcmc+DQo+Pj4+Pj4NCj4+Pj4+PiBMaW51eCBndWVzdHMgc3VibWl0IElPIHJlcXVlc3RzIG5v
IGxvbmdlciB0aGFuIFBBR0VfU0laRSAqIG1heF9zZWcNCj4+Pj4+PiBmaWVsZCByZXBvcnRlZCBi
eSBTQ1NJIGNvbnRyb2xlci4gVGh1cyB0eXBpY2FsIHNlcXVlbnRpYWwgcmVhZCB3aXRoDQo+Pj4+
Pj4gMSBNQiBzaXplIHJlc3VsdHMgaW4gdGhlIGZvbGxvd2luZyBwYXR0ZXJuIG9mIHRoZSBJTyBm
cm9tIHRoZSBndWVzdDoNCj4+Pj4+PiDCoMKgIDgsMTbCoMKgIDHCoMKgwqAgMTU3NTTCoMKgwqDC
oCAyLjc2NjA5NTEyMsKgIDIwNzHCoCBEwqDCoCBSIDIwOTUxMDQgKyAxMDA4IA0KPj4+Pj4+IFtk
ZF0NCj4+Pj4+PiDCoMKgIDgsMTbCoMKgIDHCoMKgwqAgMTU3NTXCoMKgwqDCoCAyLjc2NjEwODc4
NcKgIDIwNzHCoCBEwqDCoCBSIDIwOTYxMTIgKyAxMDA4IA0KPj4+Pj4+IFtkZF0NCj4+Pj4+PiDC
oMKgIDgsMTbCoMKgIDHCoMKgwqAgMTU3NTbCoMKgwqDCoCAyLjc2NjExMzQ4NsKgIDIwNzHCoCBE
wqDCoCBSIDIwOTcxMjAgKyAzMiBbZGRdDQo+Pj4+Pj4gwqDCoCA4LDE2wqDCoCAxwqDCoMKgIDE1
NzU3wqDCoMKgwqAgMi43Njc2Njg5NjHCoMKgwqDCoCAwwqAgQ8KgwqAgUiAyMDk1MTA0ICsgMTAw
OCBbMF0NCj4+Pj4+PiDCoMKgIDgsMTbCoMKgIDHCoMKgwqAgMTU3NTjCoMKgwqDCoCAyLjc2ODUz
NDMxNcKgwqDCoMKgIDDCoCBDwqDCoCBSIDIwOTYxMTIgKyAxMDA4IFswXQ0KPj4+Pj4+IMKgwqAg
OCwxNsKgwqAgMcKgwqDCoCAxNTc1OcKgwqDCoMKgIDIuNzY4NTM5NzgywqDCoMKgwqAgMMKgIEPC
oMKgIFIgMjA5NzEyMCArIDMyIFswXQ0KPj4+Pj4+IFRoZSBJTyB3YXMgZ2VuZXJhdGVkIGJ5DQo+
Pj4+Pj4gwqDCoCBkZCBpZj0vZGV2L3NkYSBvZj0vZGV2L251bGwgYnM9MTAyNCBpZmxhZz1kaXJl
Y3QNCj4+Pj4+Pg0KPj4+Pj4+IFRoaXMgZWZmZWN0aXZlbHkgbWVhbnMgdGhhdCBvbiByb3RhdGlv
bmFsIGRpc2tzIHdlIHdpbGwgb2JzZXJ2ZSAzIA0KPj4+Pj4+IElPUFMNCj4+Pj4+PiBmb3IgZWFj
aCAyIE1CcyBwcm9jZXNzZWQuIFRoaXMgZGVmaW5pdGVseSBuZWdhdGl2ZWx5IGFmZmVjdHMgYm90
aA0KPj4+Pj4+IGd1ZXN0IGFuZCBob3N0IElPIHBlcmZvcm1hbmNlLg0KPj4+Pj4+DQo+Pj4+Pj4g
VGhlIGN1cmUgaXMgcmVsYXRpdmVseSBzaW1wbGUgLSB3ZSBzaG91bGQgcmVwb3J0IGxlbmd0aHkg
DQo+Pj4+Pj4gc2NhdHRlci1nYXRoZXINCj4+Pj4+PiBhYmlsaXR5IG9mIHRoZSBTQ1NJIGNvbnRy
b2xsZXIuIEZvcnR1bmF0ZWx5IHRoZSBzaXR1YXRpb24gaGVyZSBpcyANCj4+Pj4+PiB2ZXJ5DQo+
Pj4+Pj4gZ29vZC4gVmlydElPIHRyYW5zcG9ydCBsYXllciBjYW4gYWNjb21vZGF0ZSAxMDI0IGl0
ZW1zIGluIG9uZSANCj4+Pj4+PiByZXF1ZXN0DQo+Pj4+Pj4gd2hpbGUgd2UgYXJlIHVzaW5nIG9u
bHkgMTI4LiBUaGlzIHNpdHVhdGlvbiBpcyBwcmVzZW50IHNpbmNlIGFsbW9zdA0KPj4+Pj4+IHZl
cnkgYmVnaW5uaW5nLiAyIGl0ZW1zIGFyZSBkZWRpY2F0ZWQgZm9yIHJlcXVlc3QgbWV0YWRhdGEg
dGh1cyB3ZQ0KPj4+Pj4+IHNob3VsZCBwdWJsaXNoIFZJUlRRVUVVRV9NQVhfU0laRSAtIDIgYXMg
bWF4X3NlZy4NCj4+Pj4+Pg0KPj4+Pj4+IFRoZSBmb2xsb3dpbmcgcGF0dGVybiBpcyBvYnNlcnZl
ZCBhZnRlciB0aGUgcGF0Y2g6DQo+Pj4+Pj4gwqDCoCA4LDE2wqDCoCAxwqDCoMKgwqAgOTkyMcKg
wqDCoMKgIDIuNjYyNzIxMzQwwqAgMjA2M8KgIETCoMKgIFIgMjA5NTEwNCArIDEwMjQgDQo+Pj4+
Pj4gW2RkXQ0KPj4+Pj4+IMKgwqAgOCwxNsKgwqAgMcKgwqDCoMKgIDk5MjLCoMKgwqDCoCAyLjY2
MjczNzU4NcKgIDIwNjPCoCBEwqDCoCBSIDIwOTYxMjggKyAxMDI0IA0KPj4+Pj4+IFtkZF0NCj4+
Pj4+PiDCoMKgIDgsMTbCoMKgIDHCoMKgwqDCoCA5OTIzwqDCoMKgwqAgMi42NjUxODgxNjfCoMKg
wqDCoCAwwqAgQ8KgwqAgUiAyMDk1MTA0ICsgMTAyNCBbMF0NCj4+Pj4+PiDCoMKgIDgsMTbCoMKg
IDHCoMKgwqDCoCA5OTI0wqDCoMKgwqAgMi42NjUxOTg3NzfCoMKgwqDCoCAwwqAgQ8KgwqAgUiAy
MDk2MTI4ICsgMTAyNCBbMF0NCj4+Pj4+PiB3aGljaCBpcyBtdWNoIGJldHRlci4NCj4+Pj4+Pg0K
Pj4+Pj4+IFRoZSBkYXJrIHNpZGUgb2YgdGhpcyBwYXRjaCBpcyB0aGF0IHdlIGFyZSB0d2Vha2lu
ZyBndWVzdCB2aXNpYmxlDQo+Pj4+Pj4gcGFyYW1ldGVyLCB0aG91Z2ggdGhpcyBzaG91bGQgYmUg
cmVsYXRpdmVseSBzYWZlIGFzIGFib3ZlIHRyYW5zcG9ydA0KPj4+Pj4+IGxheWVyIHN1cHBvcnQg
aXMgcHJlc2VudCBpbiBRRU1VL2hvc3QgTGludXggZm9yIGEgdmVyeSBsb25nIHRpbWUuDQo+Pj4+
Pj4gVGhlIHBhdGNoIGFkZHMgY29uZmlndXJhYmxlIHByb3BlcnR5IGZvciBWaXJ0SU8gU0NTSSB3
aXRoIGEgbmV3IA0KPj4+Pj4+IGRlZmF1bHQNCj4+Pj4+PiBhbmQgaGFyZGNvZGUgb3B0aW9uIGZv
ciBWaXJ0QmxvY2sgd2hpY2ggZG9lcyBub3QgcHJvdmlkZSBnb29kDQo+Pj4+Pj4gY29uZmlndXJh
YmxlIGZyYW1ld29yay4NCj4+Pj4+Pg0KPj4+Pj4+IFVuZm9ydHVuYXRlbHkgdGhlIGNvbW1pdCBj
YW4gbm90IGJlIGFwcGxpZWQgYXMgaXMuIEZvciB0aGUgcmVhbCANCj4+Pj4+PiBjdXJlIHdlDQo+
Pj4+Pj4gbmVlZCBndWVzdCB0byBiZSBmaXhlZCB0byBhY2NvbW9kYXRlIHRoYXQgcXVldWUgbGVu
Z3RoLCB3aGljaCBpcyANCj4+Pj4+PiBkb25lDQo+Pj4+Pj4gb25seSBpbiB0aGUgbGF0ZXN0IDQu
MTQga2VybmVsLiBUaHVzIHdlIGFyZSBnb2luZyB0byBleHBvc2UgdGhlIA0KPj4+Pj4+IHByb3Bl
cnR5DQo+Pj4+Pj4gYW5kIHR3ZWFrIGl0IG9uIG1hY2hpbmUgdHlwZSBsZXZlbC4NCj4+Pj4+Pg0K
Pj4+Pj4+IFRoZSBwcm9ibGVtIHdpdGggdGhlIG9sZCBrZXJuZWxzIGlzIHRoYXQgdGhleSBoYXZl
DQo+Pj4+Pj4gbWF4X3NlZ21lbnRzIDw9IHZpcnRxdWV1ZV9zaXplIHJlc3RyaWN0aW9uIHdoaWNo
IGNhdXNlIHRoZSBndWVzdA0KPj4+Pj4+IGNyYXNoaW5nIGluIHRoZSBjYXNlIG9mIHZpb2xhdGlv
bi4NCj4+Pj4+IFRoaXMgaXNuJ3QganVzdCBpbiB0aGUgZ3Vlc3RzOiB2aXJ0aW8gc3BlYyBhbHNv
IHNlZW1zIHRvIGltcGx5IHRoaXMsDQo+Pj4+PiBvciBhdCBsZWFzdCBiZSB2YWd1ZSBvbiB0aGlz
IHBvaW50Lg0KPj4+Pj4NCj4+Pj4+IFNvIEkgdGhpbmsgaXQnbGwgbmVlZCBhIGZlYXR1cmUgYml0
Lg0KPj4+Pj4gRG9pbmcgdGhhdCBpbiBhIHNhZmUgd2F5IHdpbGwgYWxzbyBhbGxvdyBiZWluZyBj
b21wYXRpYmxlIHdpdGggb2xkIA0KPj4+Pj4gZ3Vlc3RzLg0KPj4+Pj4NCj4+Pj4+IFRoZSBvbmx5
IGRvd25zaWRlIGlzIGl0J3MgYSBiaXQgbW9yZSB3b3JrIGFzIHdlIG5lZWQgdG8NCj4+Pj4+IHNw
ZWMgdGhpcyBvdXQgYW5kIGFkZCBndWVzdCBzdXBwb3J0Lg0KPj4+Pj4NCj4+Pj4+PiBUbyBmaXgg
dGhlIGNhc2UgZGVzY3JpYmVkIGFib3ZlIGluIHRoZSBvbGQga2VybmVscyB3ZSBjYW4gaW5jcmVh
c2UNCj4+Pj4+PiB2aXJ0cXVldWVfc2l6ZSB0byAyNTYgYW5kIG1heF9zZWdtZW50cyB0byAyNTQu
IFRoZSBwaXRmYWxsIGhlcmUgaXMNCj4+Pj4+PiB0aGF0IHNlYWJpb3MgYWxsb3dzIHRoZSB2aXJ0
cXVldWVfc2l6ZS1zIDwgMTI4LCBob3dldmVyLCB0aGUgc2VhYmlvcw0KPj4+Pj4+IHBhdGNoIGV4
dGVuZGluZyB0aGF0IHZhbHVlIHRvIDI1NiBpcyBwZW5kaW5nLg0KPj4+Pj4gQW5kIHRoZSBmaXgg
aGVyZSBpcyBqdXN0IHRvIGxpbWl0IGxhcmdlIHZxIHNpemUgdG8gdmlydGlvIDEuMC4NCj4+Pj4+
IEluIHRoYXQgbW9kZSBpdCdzIGZpbmUgSSB0aGluazoNCj4+Pj4+DQo+Pj4+Pg0KPj4+Pj4gwqDC
oMKgIC8qIGNoZWNrIGlmIHRoZSBxdWV1ZSBpcyBhdmFpbGFibGUgKi8NCj4+Pj4+IMKgwqDCoCBp
ZiAodnAtPnVzZV9tb2Rlcm4pIHsNCj4+Pj4+IMKgwqDCoMKgwqDCoMKgIG51bSA9IHZwX3JlYWQo
JnZwLT5jb21tb24sIHZpcnRpb19wY2lfY29tbW9uX2NmZywgDQo+Pj4+PiBxdWV1ZV9zaXplKTsN
Cj4+Pj4+IMKgwqDCoMKgwqDCoMKgIGlmIChudW0gPiBNQVhfUVVFVUVfTlVNKSB7DQo+Pj4+PiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHZwX3dyaXRlKCZ2cC0+Y29tbW9uLCB2aXJ0aW9fcGNpX2Nv
bW1vbl9jZmcsIHF1ZXVlX3NpemUsDQo+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIE1BWF9RVUVVRV9OVU0pOw0KPj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBudW0gPSB2cF9yZWFkKCZ2cC0+Y29tbW9uLCB2aXJ0aW9fcGNpX2NvbW1vbl9jZmcsIA0KPj4+
Pj4gcXVldWVfc2l6ZSk7DQo+Pj4+PiDCoMKgwqDCoMKgwqDCoCB9DQo+Pj4+PiDCoMKgwqAgfSBl
bHNlIHsNCj4+Pj4+IMKgwqDCoMKgwqDCoMKgIG51bSA9IHZwX3JlYWQoJnZwLT5sZWdhY3ksIHZp
cnRpb19wY2lfbGVnYWN5LCBxdWV1ZV9udW0pOw0KPj4+Pj4gwqDCoMKgIH0NCj4+IFRoZSBzYW1l
IHNlYWJpb3Mgc25pcHBldCzCoCBidXQgbW9yZSBkZXRhaWxlZDoNCj4+DQo+PiB2cF9maW5kX3Zx
KCkNCj4+IHsNCj4+IMKgwqAgLi4uDQo+PiDCoMKgIC8qIGNoZWNrIGlmIHRoZSBxdWV1ZSBpcyBh
dmFpbGFibGUgKi8NCj4+IMKgwqAgaWYgKHZwLT51c2VfbW9kZXJuKSB7DQo+PiDCoMKgwqDCoMKg
wqAgbnVtID0gdnBfcmVhZCgmdnAtPmNvbW1vbiwgdmlydGlvX3BjaV9jb21tb25fY2ZnLCBxdWV1
ZV9zaXplKTsNCj4+IMKgwqDCoMKgwqDCoCBpZiAobnVtID4gTUFYX1FVRVVFX05VTSkgew0KPj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqAgdnBfd3JpdGUoJnZwLT5jb21tb24sIHZpcnRpb19wY2lfY29t
bW9uX2NmZywgcXVldWVfc2l6ZSwNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIE1BWF9RVUVVRV9OVU0pOw0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqAgbnVtID0gdnBf
cmVhZCgmdnAtPmNvbW1vbiwgdmlydGlvX3BjaV9jb21tb25fY2ZnLCANCj4+IHF1ZXVlX3NpemUp
Ow0KPj4gwqDCoMKgwqDCoMKgIH0NCj4+IMKgwqAgfSBlbHNlIHsNCj4+IMKgwqDCoMKgwqDCoCBu
dW0gPSB2cF9yZWFkKCZ2cC0+bGVnYWN5LCB2aXJ0aW9fcGNpX2xlZ2FjeSwgcXVldWVfbnVtKTsN
Cj4+IMKgwqAgfQ0KPj4gwqDCoCBpZiAoIW51bSkgew0KPj4gwqDCoMKgwqDCoMKgIGRwcmludGYo
MSwgIkVSUk9SOiBxdWV1ZSBzaXplIGlzIDBcbiIpOw0KPj4gwqDCoMKgwqDCoMKgIGdvdG8gZmFp
bDsNCj4+IMKgwqAgfQ0KPj4gwqDCoCBpZiAobnVtID4gTUFYX1FVRVVFX05VTSkgew0KPj4gwqDC
oMKgwqDCoMKgIGRwcmludGYoMSwgIkVSUk9SOiBxdWV1ZSBzaXplICVkID4gJWRcbiIsIG51bSwg
TUFYX1FVRVVFX05VTSk7DQo+PiDCoMKgwqDCoMKgwqAgZ290byBmYWlsOw0KPj4gwqDCoCB9DQo+
PiAuLi4NCj4+IH0NCj4+DQo+PiBJdCB0dXJuZWQgb3V0IHRoYXQgdGhlIHByb2JsZW0gaXMgaGVy
ZSwgYnV0IG5vdCBiZWNhdXNlIG9mIHRoZSANCj4+IHNlYWJpb3MgY29kZS4NCj4+IFRoZSB2aXJ0
cXVldWUgc2l6ZSBpcyB3cml0dGVuIGFuZCB0aGVuIGluY29ycmVjdCB2YWx1ZSBpcyByZS1yZWFk
Lg0KPj4gVGhhbmtzIHRvIFJvbWFuIEthZ2FuIChya2FnYW5AdmlydHVvenpvLmNvbSkgZm9yIGlu
dmVzdGlnYXRpbmcgdGhlIA0KPj4gcm9vdCBjYXVzZSBvZiB0aGUgcHJvYmxlbS4NCj4+DQo+PiBB
cyB0aGUgY29kZSBzdGF0ZXMsIGZvciB0aGUgbW9kZXJuIGRldmljZXMsIHNlYWJpb3MgcmVhZHMg
dGhlIHF1ZXVlIA0KPj4gc2l6ZSBhbmQgaWYgaXQncw0KPj4gZ3JlYXRlciB0aGFuIHNlYWJpb3Mg
Y2FuIHN1cHBvcnQsIHJlZHVjZSB0aGUgcXVldWUgc2l6ZSB0byB0aGUgbWF4IA0KPj4gc2VhYmlv
cyBzdXBwb3J0ZWQgdmFsdWUuDQo+Pg0KPj4gVGhpcyBkb2Vzbid0IHdvcmsuDQo+Pg0KPj4gVGhl
IHJlYXNvbiBpcyB0aGF0IHRoZSBzaXplIGlzIHJlYWQgZnJvbSB0aGUgdmlydGlvIGRldmljZSwN
Cj4+DQo+PiB2aXJ0aW9fcGNpX2NvbW1vbl9yZWFkKCkNCj4+IHsNCj4+IMKgwqDCoCAuLi4NCj4+
IMKgwqDCoCBjYXNlIFZJUlRJT19QQ0lfQ09NTU9OX1FfU0laRToNCj4+IMKgwqDCoMKgwqDCoMKg
IHZhbCA9IHZpcnRpb19xdWV1ZV9nZXRfbnVtKHZkZXYsIHZkZXYtPnF1ZXVlX3NlbCk7DQo+PiDC
oMKgwqDCoMKgwqDCoCBicmVhazsNCj4+IMKgwqDCoCAuLi4NCj4+IH0NCj4+DQo+PiBidXQgaXMg
d3JpdHRlbiB0byB0aGUgcHJveHkNCj4+DQo+PiB2aXJ0aW9fcGNpX2NvbW1vbl93cml0ZSgpDQo+
PiB7DQo+PiDCoMKgwqAgLi4uDQo+PiDCoMKgwqAgY2FzZSBWSVJUSU9fUENJX0NPTU1PTl9RX1NJ
WkU6DQo+PiDCoMKgwqDCoMKgwqDCoCBwcm94eS0+dnFzW3ZkZXYtPnF1ZXVlX3NlbF0ubnVtID0g
dmFsOw0KPj4gwqDCoMKgwqDCoMKgwqAgYnJlYWs7DQo+PiDCoMKgIC4uLg0KPj4gfS4NCj4+DQo+
PiBUaGUgZmluYWwgc3RhZ2Ugb2YgdGhlIHNpemUgc2V0dGluZyBpcyBwcm9wYWdhdGVkIGl0IGZy
b20gdGhlIHByb3h5IA0KPj4gdG8gdGhlIGRldmljZSBvbiB2aXJ0cXVldWUgZW5hYmxpbmc6DQo+
Pg0KPj4gdmlydGlvX2NwaV9jb21tb25fd3JpdGUoKQ0KPj4gew0KPj4gwqDCoMKgIC4uLg0KPj4g
wqDCoMKgIGNhc2UgVklSVElPX1BDSV9DT01NT05fUV9FTkFCTEU6DQo+PiDCoMKgwqDCoMKgwqDC
oCB2aXJ0aW9fcXVldWVfc2V0X251bSh2ZGV2LCB2ZGV2LT5xdWV1ZV9zZWwsDQo+PiBwcm94eS0+
dnFzW3ZkZXYtPnF1ZXVlX3NlbF0ubnVtKTsNCj4+IMKgwqDCoMKgwqDCoMKgIHZpcnRpb19xdWV1
ZV9zZXRfcmluZ3ModmRldiwgdmRldi0+cXVldWVfc2VsLA0KPj4gKCh1aW50NjRfdClwcm94eS0+
dnFzW3ZkZXYtPnF1ZXVlX3NlbF0uZGVzY1sxXSkgPDwgMzIgfA0KPj4gcHJveHktPnZxc1t2ZGV2
LT5xdWV1ZV9zZWxdLmRlc2NbMF0sDQo+PiAoKHVpbnQ2NF90KXByb3h5LT52cXNbdmRldi0+cXVl
dWVfc2VsXS5hdmFpbFsxXSkgPDwgMzIgfA0KPj4gcHJveHktPnZxc1t2ZGV2LT5xdWV1ZV9zZWxd
LmF2YWlsWzBdLA0KPj4gKCh1aW50NjRfdClwcm94eS0+dnFzW3ZkZXYtPnF1ZXVlX3NlbF0udXNl
ZFsxXSkgPDwgMzIgfA0KPj4gcHJveHktPnZxc1t2ZGV2LT5xdWV1ZV9zZWxdLnVzZWRbMF0pOw0K
Pj4gwqDCoMKgwqDCoMKgwqAgcHJveHktPnZxc1t2ZGV2LT5xdWV1ZV9zZWxdLmVuYWJsZWQgPSAx
Ow0KPj4gwqDCoMKgwqDCoMKgwqAgYnJlYWs7DQo+PiDCoMKgwqAgLi4uDQo+PiB9Lg0KPj4NCj4+
IFNvIHdlIGhhdmUgdGhlIGZvbGxvd2luZyB3b3JrZmxvdzoNCj4+IHN1cHBvc2UgdGhlIGRldmlj
ZSBoYXMgdmlydHF1ZXVlIHNpemUgPSAyNTYgYW5kIHNlYWJpb3MgTUFYX1FVRVVFX05VTSANCj4+
ID0gMTI4Lg0KPj4gSW4gdGhhdCBjYXNlIHRoZSBzZWFiaW9zIHdvcmtzIGxpa2U6DQo+Pg0KPj4g
MS4gaWYgdnBfbW9kZXJuIHJlYWQgdGhlIHNpemUgKDI1NikNCj4+IDIuIDI1NiA+IDEyOA0KPj4g
My4gd3JpdGUgdmlydHF1ZXVlIHNpemUgPSAxMjgNCj4+IDQuIHJlLXJlYWQgdmlydHF1ZXVlIHNp
emUgPSAyNTYgISEhDQo+PiA1LiBmYWlsIGJlY2F1c2Ugb2YgdGhlIGNoZWNrDQo+PiDCoMKgwqAg
aWYgKG51bSA+IE1BWF9RVUVVRV9OVU0pIHsNCj4+IMKgwqDCoMKgwqDCoMKgIGRwcmludGYoMSwg
IkVSUk9SOiBxdWV1ZSBzaXplICVkID4gJWRcbiIsIG51bSwgTUFYX1FVRVVFX05VTSk7DQo+PiDC
oMKgwqDCoMKgwqDCoCBnb3RvIGZhaWw7DQo+PiDCoMKgwqAgfQ0KPj4NCj4+IFRvIGZpeCB0aGUg
aXNzdWUsIHdlIG5lZWQgdG8gcmVhZCBhbmQgd3JpdGUgdGhlIHZpcnRxdWV1ZSBzaXplIGZyb20g
DQo+PiB0aGUgc2FtZSBwbGFjZS4NCj4+IFNob3VsZCB3ZSBkbyB3aXRoIHRoZSBwcm94eT8NCj4+
IElzIHRoZXJlIGFueSByZWFzb24gdG8gcmVhZCBmcm9tIHRoZSBkZXZpY2UgYW5kIHdyaXRlIHRv
IHRoZSBwcm94eT8NCj4+DQo+PiBGdXJ0aGVybW9yZSwgdGhlIHNpemUgc2V0dGluZyBoYXMgYSBm
ZXcgZmxhd3M6DQo+Pg0KPj4gMS4gVGhlIHNpemUgYmVpbmcgc2V0IHNob3VsZCBiZSBhIHBvd2Vy
IG9mIDINCj4+IDIuIFRoZSBzaXplIGJlaW5nIHNldCBzaG91bGQgYmUgbGVzcyBvciBlcXVhbCB0
byB0aGUgdmlydHF1ZXVlIHNpemUgDQo+PiAoYW5kIGJlIGdyZWF0ZXIgdGhhdCAyPykNCj4+DQo+
PiBEZW5pcw0KPj4+PiB5b3UgbWVhbiB0byBwdXQgdGhlIGNvZGUgbGlrZSB0aGlzIGludG8gdmly
dGlvX3BjaV9yZWFsaXplKCkgaW5zaWRlIA0KPj4+PiBRRU1VPw0KPj4+Pg0KPj4+PiBJZiBubywg
Y2FuIHlvdSBwbHMgY2xhcmlmeSB3aGljaCBjb21wb25lbnQgc2hvdWxkIGJlIHRvdWNoZWQuDQo+
Pj4+DQo+Pj4+IERlbg0KPj4+IEkgbWVhbjoNCj4+PiDCoCAtIGFkZCBhbiBBUEkgdG8gY2hhbmdl
IHRoZSBkZWZhdWx0IHF1ZXVlIHNpemUNCj4+PiDCoCAtIGFkZCBhIHZhbGlkYXRlIGZlYXR1cmVz
IGNhbGxiYWNrLCBpbiB0aGVyZSBjaGVjayBhbmQgZm9yIG1vZGVybg0KPj4+IMKgwqDCoCBmbGFn
IHNldCBpbiBmZWF0dXJlcyBpbmNyZWFzZSB0aGUgcXVldWUgc2l6ZQ0KPj4+DQo+Pj4gbWF5YmUg
YWxsIHRoaXMgaXMgdG9vIG11Y2ggd29yaywgd2UgY291bGQgYmxvY2sgdGhpcw0KPj4+IGZvciB0
cmFuc2l0aW9uYWwgZGV2aWNlcywgYnV0IHlvdXIgcGF0Y2ggZG9lcyBub3QgZG8gaXQsDQo+Pj4g
eW91IG5lZWQgdG8gY2hlY2sgdGhhdCBsZWdhY3kgaXMgZW5hYmxlZCBub3QgdGhhdCBtb2Rlcm4N
Cj4+PiBpcyBub3QgZGlzYWJsZWQuDQo+Pj4NCj4+Pg0KPj4+DQo+Pg0KPg0KDQo=

