Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB8C5C43331
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 12:40:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7543021783
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 12:40:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Lpkl1qWO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7543021783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUrwY-00025Y-LF
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 07:40:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37251)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1iUrvF-0001Fq-M3
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 07:38:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1iUrvD-0001lZ-E5
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 07:38:56 -0500
Received: from mail-eopbgr30095.outbound.protection.outlook.com
 ([40.107.3.95]:49120 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1iUrvB-0001jq-Vq
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 07:38:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lgMInsyhfzIYPZ7f09t57K2LLVmW57AoMCzG5Rj+oFE/7AbYaikcp7IhvzsM/6Fmpx3jT2XMyr8cQJ4h+ceN4/HpxsI6ykxAEZO6uUG5L2W18NyHF5ERheCK3tWm8bmgCkn9vb1xuOCF6A+jEJIYBk+4LAfXgOTM+/rt+4Q7Qx0G15GVN1vsXDal0Io4z7TO+uDXY5QjEpwp4kTj/WLNNUh0PO5Vs4xc5J2rLXePphI6LsuukqFCNGPu6K/1itURBWhpyPlfdCyjJXJy1c3ikoekzjCmfLB82d7QJrSJgBQUzhL6k1bHBLTkI14uEhK9wngJ2MidtqZ7QXT6exiwxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MQ3HmjKAeArUTiJn37cI/BnkEsX2KJ9/IwoMJQs/aWE=;
 b=WtXVTXJZu9CQMlhWq0py+B+We8rQLytP2Cn+igvXF8LXWuHNe7zdj7NEsPvWpntmL2hc1r6154b59dWPUGCTHklcEGefArSM+zjqmMybE+R/1pbgpEfr4glFsYNkznpkGSUMClucw1sQTX+JHyo+YrtrJmiKxsHZ5Fm811VBf2Wo80SD93RYfXVpaGmeRuv0mn5YshzuGHBN/fPW0IB6jUbGkwnTzwgGklMCTrvIruQ7Cfqh9fVVS4pcJtlflui2W5FUB9lTCRSBRmgzKbRCRT5uQoBl1jV+fJ10uz+CFXb/wSrO3iCjopZGUzZwf/C+rImbwSp8jKwNCS2pkOse4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MQ3HmjKAeArUTiJn37cI/BnkEsX2KJ9/IwoMJQs/aWE=;
 b=Lpkl1qWO+rg5d0O99Z+h4ENmOWfVlNlPYq/0vyoNIr5xTYDtkAuR1OfQUkHbpKrd6OhgNumqKJv9LJBb7FOyYMkkyS8YEL+J7gEdOLW9fQ/WToiTHPblLOs3LfBjx7qMiwqHyjtrojfazWKf5Ecn10P9rS473lM3dkcgb9Lftws=
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (20.178.22.27) by
 AM0PR08MB4323.eurprd08.prod.outlook.com (20.179.33.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.24; Wed, 13 Nov 2019 12:38:48 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::e8bf:705f:f64d:4aa]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::e8bf:705f:f64d:4aa%4]) with mapi id 15.20.2451.023; Wed, 13 Nov 2019
 12:38:48 +0000
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio: fix IO request length in virtio SCSI/block
 #PSBM-78839
Thread-Topic: [PATCH] virtio: fix IO request length in virtio SCSI/block
 #PSBM-78839
Thread-Index: AQHVhasj1hrogEqe4kWfxpGYRrvmHqdoxjuAgADscwCAFHZTAIALCjYA
Date: Wed, 13 Nov 2019 12:38:48 +0000
Message-ID: <650b229d-34d6-f9a5-6a52-d7b5892a2c0c@virtuozzo.com>
References: <20191018115547.19299-1-dplotnikov@virtuozzo.com>
 <20191023172005-mutt-send-email-mst@kernel.org>
 <42b80a75-6ab4-5123-bbf5-eee21c2841ac@virtuozzo.com>
 <20191106065816-mutt-send-email-mst@kernel.org>
In-Reply-To: <20191106065816-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0701CA0057.eurprd07.prod.outlook.com
 (2603:10a6:3:9e::25) To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dplotnikov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [109.168.240.45]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c14161a0-6d8d-4028-a011-08d768366e57
x-ms-traffictypediagnostic: AM0PR08MB4323:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR08MB432388C8EA86AB8342B52E94CF760@AM0PR08MB4323.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0220D4B98D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(39840400004)(376002)(346002)(136003)(396003)(189003)(199004)(53546011)(4326008)(386003)(31686004)(66066001)(76176011)(6916009)(478600001)(52116002)(71190400001)(14454004)(186003)(26005)(7736002)(476003)(2616005)(6506007)(11346002)(71200400001)(6512007)(256004)(486006)(102836004)(25786009)(14444005)(31696002)(36756003)(305945005)(86362001)(446003)(8676002)(81156014)(229853002)(64756008)(66446008)(3846002)(54906003)(8936002)(2906002)(81166006)(66476007)(6116002)(99286004)(6436002)(5660300002)(66556008)(316002)(66946007)(6486002)(6246003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB4323;
 H:AM0PR08MB3745.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rnhvQ/IH8BSy6t3K4+jJwP9BxiuDsHH7W0eaxr+DISwH/fnO85WM1USy+uEeSEFUYmqKctOGm9Wg2yPXfbHZT6TvP3PY3yT7Rla1b4DelTHiaXEPFRAkpEEGMHq0bnVb8wrPIWNIifn8cLreGPgVT1wyJ5/FpuTuWgdAymDh3Ddcani9bLgQ3kD8L4zd+5ogRq55llGwHFPavrOP85LCijjGSkvX2p/ib6GaalWQdr1SCvn3FARp725f+FS3dGdweQTtdZaVp+PP814ragLc8SuvD0hkwhcVMlBt7IXz6GzSYqpJz+vWKh7lmQrBnlUZkmtNMXGZZ5vUwbQ3X4RIkvnSxFTPnVB565REulExRNTMlAqTRq+iF/ZkoFhyrf8CglFOsGtJnUzYbYj5PBGQV9twum+9RdGlnc2RHOw8MVg/IUhXIY5k8MQQjYGmd5Qn
Content-Type: text/plain; charset="utf-8"
Content-ID: <4293857A0E80EC4B86FA5D0B30C9F6C5@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c14161a0-6d8d-4028-a011-08d768366e57
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 12:38:48.6262 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yZJYshOdsXTXTGrOHPOXdQVgYcMRcxVjFmlsl3/33wBqawZhAo18g8TP9Q+652BBfwrZFWEnzG7ico8HNn1HuFRrNot+38dsJ37gGds2GsQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4323
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.3.95
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
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "kraxel@redhat.com" <kraxel@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDA2LjExLjIwMTkgMTU6MDMsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToNCj4gT24g
VGh1LCBPY3QgMjQsIDIwMTkgYXQgMTE6MzQ6MzRBTSArMDAwMCwgRGVuaXMgTHVuZXYgd3JvdGU6
DQo+PiBPbiAxMC8yNC8xOSAxMjoyOCBBTSwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOg0KPj4+
IE9uIEZyaSwgT2N0IDE4LCAyMDE5IGF0IDAyOjU1OjQ3UE0gKzAzMDAsIERlbmlzIFBsb3RuaWtv
diB3cm90ZToNCj4+Pj4gRnJvbTogIkRlbmlzIFYuIEx1bmV2IiA8ZGVuQG9wZW52ei5vcmc+DQo+
Pj4+DQo+Pj4+IExpbnV4IGd1ZXN0cyBzdWJtaXQgSU8gcmVxdWVzdHMgbm8gbG9uZ2VyIHRoYW4g
UEFHRV9TSVpFICogbWF4X3NlZw0KPj4+PiBmaWVsZCByZXBvcnRlZCBieSBTQ1NJIGNvbnRyb2xl
ci4gVGh1cyB0eXBpY2FsIHNlcXVlbnRpYWwgcmVhZCB3aXRoDQo+Pj4+IDEgTUIgc2l6ZSByZXN1
bHRzIGluIHRoZSBmb2xsb3dpbmcgcGF0dGVybiBvZiB0aGUgSU8gZnJvbSB0aGUgZ3Vlc3Q6DQo+
Pj4+ICAgIDgsMTYgICAxICAgIDE1NzU0ICAgICAyLjc2NjA5NTEyMiAgMjA3MSAgRCAgIFIgMjA5
NTEwNCArIDEwMDggW2RkXQ0KPj4+PiAgICA4LDE2ICAgMSAgICAxNTc1NSAgICAgMi43NjYxMDg3
ODUgIDIwNzEgIEQgICBSIDIwOTYxMTIgKyAxMDA4IFtkZF0NCj4+Pj4gICAgOCwxNiAgIDEgICAg
MTU3NTYgICAgIDIuNzY2MTEzNDg2ICAyMDcxICBEICAgUiAyMDk3MTIwICsgMzIgW2RkXQ0KPj4+
PiAgICA4LDE2ICAgMSAgICAxNTc1NyAgICAgMi43Njc2Njg5NjEgICAgIDAgIEMgICBSIDIwOTUx
MDQgKyAxMDA4IFswXQ0KPj4+PiAgICA4LDE2ICAgMSAgICAxNTc1OCAgICAgMi43Njg1MzQzMTUg
ICAgIDAgIEMgICBSIDIwOTYxMTIgKyAxMDA4IFswXQ0KPj4+PiAgICA4LDE2ICAgMSAgICAxNTc1
OSAgICAgMi43Njg1Mzk3ODIgICAgIDAgIEMgICBSIDIwOTcxMjAgKyAzMiBbMF0NCj4+Pj4gVGhl
IElPIHdhcyBnZW5lcmF0ZWQgYnkNCj4+Pj4gICAgZGQgaWY9L2Rldi9zZGEgb2Y9L2Rldi9udWxs
IGJzPTEwMjQgaWZsYWc9ZGlyZWN0DQo+Pj4+DQo+Pj4+IFRoaXMgZWZmZWN0aXZlbHkgbWVhbnMg
dGhhdCBvbiByb3RhdGlvbmFsIGRpc2tzIHdlIHdpbGwgb2JzZXJ2ZSAzIElPUFMNCj4+Pj4gZm9y
IGVhY2ggMiBNQnMgcHJvY2Vzc2VkLiBUaGlzIGRlZmluaXRlbHkgbmVnYXRpdmVseSBhZmZlY3Rz
IGJvdGgNCj4+Pj4gZ3Vlc3QgYW5kIGhvc3QgSU8gcGVyZm9ybWFuY2UuDQo+Pj4+DQo+Pj4+IFRo
ZSBjdXJlIGlzIHJlbGF0aXZlbHkgc2ltcGxlIC0gd2Ugc2hvdWxkIHJlcG9ydCBsZW5ndGh5IHNj
YXR0ZXItZ2F0aGVyDQo+Pj4+IGFiaWxpdHkgb2YgdGhlIFNDU0kgY29udHJvbGxlci4gRm9ydHVu
YXRlbHkgdGhlIHNpdHVhdGlvbiBoZXJlIGlzIHZlcnkNCj4+Pj4gZ29vZC4gVmlydElPIHRyYW5z
cG9ydCBsYXllciBjYW4gYWNjb21vZGF0ZSAxMDI0IGl0ZW1zIGluIG9uZSByZXF1ZXN0DQo+Pj4+
IHdoaWxlIHdlIGFyZSB1c2luZyBvbmx5IDEyOC4gVGhpcyBzaXR1YXRpb24gaXMgcHJlc2VudCBz
aW5jZSBhbG1vc3QNCj4+Pj4gdmVyeSBiZWdpbm5pbmcuIDIgaXRlbXMgYXJlIGRlZGljYXRlZCBm
b3IgcmVxdWVzdCBtZXRhZGF0YSB0aHVzIHdlDQo+Pj4+IHNob3VsZCBwdWJsaXNoIFZJUlRRVUVV
RV9NQVhfU0laRSAtIDIgYXMgbWF4X3NlZy4NCj4+Pj4NCj4+Pj4gVGhlIGZvbGxvd2luZyBwYXR0
ZXJuIGlzIG9ic2VydmVkIGFmdGVyIHRoZSBwYXRjaDoNCj4+Pj4gICAgOCwxNiAgIDEgICAgIDk5
MjEgICAgIDIuNjYyNzIxMzQwICAyMDYzICBEICAgUiAyMDk1MTA0ICsgMTAyNCBbZGRdDQo+Pj4+
ICAgIDgsMTYgICAxICAgICA5OTIyICAgICAyLjY2MjczNzU4NSAgMjA2MyAgRCAgIFIgMjA5NjEy
OCArIDEwMjQgW2RkXQ0KPj4+PiAgICA4LDE2ICAgMSAgICAgOTkyMyAgICAgMi42NjUxODgxNjcg
ICAgIDAgIEMgICBSIDIwOTUxMDQgKyAxMDI0IFswXQ0KPj4+PiAgICA4LDE2ICAgMSAgICAgOTky
NCAgICAgMi42NjUxOTg3NzcgICAgIDAgIEMgICBSIDIwOTYxMjggKyAxMDI0IFswXQ0KPj4+PiB3
aGljaCBpcyBtdWNoIGJldHRlci4NCj4+Pj4NCj4+Pj4gVGhlIGRhcmsgc2lkZSBvZiB0aGlzIHBh
dGNoIGlzIHRoYXQgd2UgYXJlIHR3ZWFraW5nIGd1ZXN0IHZpc2libGUNCj4+Pj4gcGFyYW1ldGVy
LCB0aG91Z2ggdGhpcyBzaG91bGQgYmUgcmVsYXRpdmVseSBzYWZlIGFzIGFib3ZlIHRyYW5zcG9y
dA0KPj4+PiBsYXllciBzdXBwb3J0IGlzIHByZXNlbnQgaW4gUUVNVS9ob3N0IExpbnV4IGZvciBh
IHZlcnkgbG9uZyB0aW1lLg0KPj4+PiBUaGUgcGF0Y2ggYWRkcyBjb25maWd1cmFibGUgcHJvcGVy
dHkgZm9yIFZpcnRJTyBTQ1NJIHdpdGggYSBuZXcgZGVmYXVsdA0KPj4+PiBhbmQgaGFyZGNvZGUg
b3B0aW9uIGZvciBWaXJ0QmxvY2sgd2hpY2ggZG9lcyBub3QgcHJvdmlkZSBnb29kDQo+Pj4+IGNv
bmZpZ3VyYWJsZSBmcmFtZXdvcmsuDQo+Pj4+DQo+Pj4+IFVuZm9ydHVuYXRlbHkgdGhlIGNvbW1p
dCBjYW4gbm90IGJlIGFwcGxpZWQgYXMgaXMuIEZvciB0aGUgcmVhbCBjdXJlIHdlDQo+Pj4+IG5l
ZWQgZ3Vlc3QgdG8gYmUgZml4ZWQgdG8gYWNjb21vZGF0ZSB0aGF0IHF1ZXVlIGxlbmd0aCwgd2hp
Y2ggaXMgZG9uZQ0KPj4+PiBvbmx5IGluIHRoZSBsYXRlc3QgNC4xNCBrZXJuZWwuIFRodXMgd2Ug
YXJlIGdvaW5nIHRvIGV4cG9zZSB0aGUgcHJvcGVydHkNCj4+Pj4gYW5kIHR3ZWFrIGl0IG9uIG1h
Y2hpbmUgdHlwZSBsZXZlbC4NCj4+Pj4NCj4+Pj4gVGhlIHByb2JsZW0gd2l0aCB0aGUgb2xkIGtl
cm5lbHMgaXMgdGhhdCB0aGV5IGhhdmUNCj4+Pj4gbWF4X3NlZ21lbnRzIDw9IHZpcnRxdWV1ZV9z
aXplIHJlc3RyaWN0aW9uIHdoaWNoIGNhdXNlIHRoZSBndWVzdA0KPj4+PiBjcmFzaGluZyBpbiB0
aGUgY2FzZSBvZiB2aW9sYXRpb24uDQo+Pj4gVGhpcyBpc24ndCBqdXN0IGluIHRoZSBndWVzdHM6
IHZpcnRpbyBzcGVjIGFsc28gc2VlbXMgdG8gaW1wbHkgdGhpcywNCj4+PiBvciBhdCBsZWFzdCBi
ZSB2YWd1ZSBvbiB0aGlzIHBvaW50Lg0KPj4+DQo+Pj4gU28gSSB0aGluayBpdCdsbCBuZWVkIGEg
ZmVhdHVyZSBiaXQuDQo+Pj4gRG9pbmcgdGhhdCBpbiBhIHNhZmUgd2F5IHdpbGwgYWxzbyBhbGxv
dyBiZWluZyBjb21wYXRpYmxlIHdpdGggb2xkIGd1ZXN0cy4NCj4+Pg0KPj4+IFRoZSBvbmx5IGRv
d25zaWRlIGlzIGl0J3MgYSBiaXQgbW9yZSB3b3JrIGFzIHdlIG5lZWQgdG8NCj4+PiBzcGVjIHRo
aXMgb3V0IGFuZCBhZGQgZ3Vlc3Qgc3VwcG9ydC4NCj4+Pg0KPj4+PiBUbyBmaXggdGhlIGNhc2Ug
ZGVzY3JpYmVkIGFib3ZlIGluIHRoZSBvbGQga2VybmVscyB3ZSBjYW4gaW5jcmVhc2UNCj4+Pj4g
dmlydHF1ZXVlX3NpemUgdG8gMjU2IGFuZCBtYXhfc2VnbWVudHMgdG8gMjU0LiBUaGUgcGl0ZmFs
bCBoZXJlIGlzDQo+Pj4+IHRoYXQgc2VhYmlvcyBhbGxvd3MgdGhlIHZpcnRxdWV1ZV9zaXplLXMg
PCAxMjgsIGhvd2V2ZXIsIHRoZSBzZWFiaW9zDQo+Pj4+IHBhdGNoIGV4dGVuZGluZyB0aGF0IHZh
bHVlIHRvIDI1NiBpcyBwZW5kaW5nLg0KPj4+IEFuZCB0aGUgZml4IGhlcmUgaXMganVzdCB0byBs
aW1pdCBsYXJnZSB2cSBzaXplIHRvIHZpcnRpbyAxLjAuDQo+Pj4gSW4gdGhhdCBtb2RlIGl0J3Mg
ZmluZSBJIHRoaW5rOg0KPj4+DQo+Pj4NCj4+PiAgICAgLyogY2hlY2sgaWYgdGhlIHF1ZXVlIGlz
IGF2YWlsYWJsZSAqLw0KPj4+ICAgICBpZiAodnAtPnVzZV9tb2Rlcm4pIHsNCj4+PiAgICAgICAg
IG51bSA9IHZwX3JlYWQoJnZwLT5jb21tb24sIHZpcnRpb19wY2lfY29tbW9uX2NmZywgcXVldWVf
c2l6ZSk7DQo+Pj4gICAgICAgICBpZiAobnVtID4gTUFYX1FVRVVFX05VTSkgew0KPj4+ICAgICAg
ICAgICAgIHZwX3dyaXRlKCZ2cC0+Y29tbW9uLCB2aXJ0aW9fcGNpX2NvbW1vbl9jZmcsIHF1ZXVl
X3NpemUsDQo+Pj4gICAgICAgICAgICAgICAgICAgICAgTUFYX1FVRVVFX05VTSk7DQo+Pj4gICAg
ICAgICAgICAgbnVtID0gdnBfcmVhZCgmdnAtPmNvbW1vbiwgdmlydGlvX3BjaV9jb21tb25fY2Zn
LCBxdWV1ZV9zaXplKTsNCj4+PiAgICAgICAgIH0NCj4+PiAgICAgfSBlbHNlIHsNCj4+PiAgICAg
ICAgIG51bSA9IHZwX3JlYWQoJnZwLT5sZWdhY3ksIHZpcnRpb19wY2lfbGVnYWN5LCBxdWV1ZV9u
dW0pOw0KPj4+ICAgICB9DQo+PiB5b3UgbWVhbiB0byBwdXQgdGhlIGNvZGUgbGlrZSB0aGlzIGlu
dG8gdmlydGlvX3BjaV9yZWFsaXplKCkgaW5zaWRlIFFFTVU/DQo+Pg0KPj4gSWYgbm8sIGNhbiB5
b3UgcGxzIGNsYXJpZnkgd2hpY2ggY29tcG9uZW50IHNob3VsZCBiZSB0b3VjaGVkLg0KPj4NCj4+
IERlbg0KPiBJIG1lYW46DQo+ICAgLSBhZGQgYW4gQVBJIHRvIGNoYW5nZSB0aGUgZGVmYXVsdCBx
dWV1ZSBzaXplDQo+ICAgLSBhZGQgYSB2YWxpZGF0ZSBmZWF0dXJlcyBjYWxsYmFjaywgaW4gdGhl
cmUgY2hlY2sgYW5kIGZvciBtb2Rlcm4NCj4gICAgIGZsYWcgc2V0IGluIGZlYXR1cmVzIGluY3Jl
YXNlIHRoZSBxdWV1ZSBzaXplDQo+DQo+IG1heWJlIGFsbCB0aGlzIGlzIHRvbyBtdWNoIHdvcmss
IHdlIGNvdWxkIGJsb2NrIHRoaXMNCj4gZm9yIHRyYW5zaXRpb25hbCBkZXZpY2VzLCBidXQgeW91
ciBwYXRjaCBkb2VzIG5vdCBkbyBpdCwNCj4geW91IG5lZWQgdG8gY2hlY2sgdGhhdCBsZWdhY3kg
aXMgZW5hYmxlZCBub3QgdGhhdCBtb2Rlcm4NCj4gaXMgbm90IGRpc2FibGVkLg0KVG8gZGV2ZWxv
cCB0aGUgaWRlYSBvZiBob3cgdG8gYWRqdXN0IHF1ZXVlIHNpemUgZnVydGhlciBJJ2QgbGlrZSB0
byANCnN1bW1hcml6ZSB3aGF0IHdlIGhhdmU6DQoNCjEuIFZhcmlhdGx5IG9mIGd1c3RzIHdpdGhv
dXQoPykgcXVldWUgc2l6ZSBsaW1pdGF0aW9ucyB3aGljaCBjYW4gc3VwcG9ydCANCnF1ZXVlIHNp
emVzIHVwIHRvIE1BWCgxMDI0KQ0KDQoyLiBzZWFiaW9zIHNldHVwcyB3aXRoIHR3byBwb3NzaWJs
ZSBtYXggcXVldWUgc2l6ZSBsaW1pdGF0aW9uczogMTI4IGFuZCANCjI1NiAocmVjZW50bHkgY29t
bWl0ZWQpDQoNCjMuIG5vbi1zZWJpb3Mgc2V0dXBzIHdpdGggdW5rbm93biBtYXggcXVldWUtc2l6
ZSBsaW1pdGF0aW9ucw0KDQpUYWtpbmcgaW50byBhY2NvdW50IHRoYXQgcXVldWUgc2l6ZSBtYXkg
YmUgbGltaXRlZCBpbiBiaW9zKGVmaSksIHRvIA0Kc2FmZWx5IHN1cHBvcnQgZ3VldWUgc2l6ZXMg
PiAxMjggd2UgbmVlZCB0byBkaXN0aW5ndWlzaCB0aG9zZSBob3cgY2FuIA0Kc3VwcG9ydCBncmVh
dGVyX3RoYW5fMTI4IGZyb20gdGhvc2Ugd2hvIGNhbid0Lg0Kc2VhYmlvcyBwb3RlbnRpYWxseSBj
YW4ndCBkbyBpdCwgc28sIGFzIGZhciBhcyBJIHVuZGVyc3Rvb2QsIHRoZSBpZGVhIGlzIA0KdG8g
c3RhcnQgd2l0aCBxdWV1ZSBzaXplPTEyOCBhbmQgdGhlbiBpbmNyZWFzZSB0aGUgcXVldWUgc2l6
ZSB3aGVuIHRoZSANCmd1ZXN0IGRyaXZlciBpcyBlbmdhZ2VkLg0KDQpUbyBhY2hpZXZlIHRoYXQs
IHdlIG5lZWQgdG8NCg0KMS7CoCB1bmRlcnN0YW5kLCB3aGljaCBkcml2ZXIgaXMgY3VycmVudGx5
IHdvcmtpbmcgd2l0aCBhIHZpcnRpbyBkZXZpY2U6IA0Kc2VhYmlvcywgZ3Vlc3QsIG90aGVyLiBU
aGluZ3MNCiDCoMKgwqAgaGVyZSBhcmUgcXVpdGUgY29tcGxleCwgc2luY2Ugd2UgY2FuJ3QgbW9k
aWZ5IGFueSBndWVzdCwgc2VhYmlvcyBvciANCm90aGVyIGRyaXZlcnMgdG8gZXhwbGljaXRseSB0
ZWxsDQogwqDCoMKgIHRoYXTCoCB0byBkZXZpY2UNCg0KMi4gYmUgYWJsZSB0byBpbmNyZWFzZSBx
dWV1ZSBzaXplIGR5bmFtaWNhbGx5IChyZS1jcmVhdGUgcXVldWVzPykuIEF0IA0KdGhlIHRpbWUs
IHRoaXMgZnVuY3Rpb25hbGl0eQ0KIMKgwqAgaXMgYWJzZW50LCBhdCBsZWFzdCBpbiBxZW11IHZp
cnRpby1zY3NpLg0KIMKgwqAgSXMgaXQgcG9zc2libGUgYnkgZGVzaWduPw0KDQozLiBjaG9vc2Ug
YSBwbGFjZSBmb3IgcXVldWUgc2l6ZSBleHRlbmRpbmcgKHJlLWNyZWF0aW9uKS4gDQpWaXJ0aW9E
ZXZpY2VDbGFzcy0+cmVzZXQ/DQoNCkkgYWN0dWFsbHkgZG9uJ3Qga25vdyBob3cgdG8gZG8gaXQg
cmVsaWFibHksIHNvIHdvdWxkIHJlYWxseSBhcHByZWNpYXRlIA0Kc29uZSBoZWxwIG9yIGFkdmlj
ZS4NCg0KWW91J3ZlIG1lbnRpb25lZCB0aGF0IG9sZCBzZWFiaW9zIHdvbid0IHVzZSB0aGUgbW9k
ZXJuIGludGVyZmFjZSwgc28gDQp3b3VsZCBpdCBiZSBvaywgaWYgd2UNCg0KIMKgwqDCoCAqIGRl
ZmluZSBERUZBVUxUX1FVRVVFX1NJWkUgPSAxMjgNCiDCoMKgwqAgKiBsZWF2ZSBxdWV1ZXMgY3Jl
YXRpb24gYXMgaXMgYXQgVmlydGlvRGV2aWNlQ2xhc3MtPnJlYWxpemUoKQ0KIMKgwqDCoMKgwqAg
d2l0aCBxdWV1ZV9zaXplID0gY29uZi5xdWV1ZV9zaXplDQogwqDCoMKgICogb24gVmlydGlvRGV2
aWNlQ2xhc3MtPnJlc2V0KCkgd2UgY2hlY2sgaWYgdGhlIGRldmljZSBhY2Nlc3NlZCANCnRocm91
Z2ggImxlZ2FjeSIgaW50ZXJmYWNlDQogwqDCoMKgwqDCoCBpZiBzbywgdGhlbiAoaW4gcHNldWRv
Y29kZSkNCiDCoMKgwqDCoMKgwqDCoMKgIGlmIChjdXJyZW50X3F1ZXVlX3NpemUgPiBERUZBVUxU
X1FVRVVFX1NJWkUpIHsNCiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZm9yIChxdWV1ZSBpbiBh
bGxfcXVldWVzKSB7DQogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmVkdWNlX3F1
ZXVlX3NpemUocXVldWUsIERFRkFVTFRfUVVFVUVfU0laRSkgLy8gDQpyZWNyZWF0ZV9xdWV1ZSgp
ID8NCiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQ0KIMKgwqDCoMKgwqDCoMKgwqAgfQ0KIMKg
wqDCoMKgwqAgZWxzZQ0KIMKgwqDCoMKgwqDCoMKgwqAgaWYgKGNvbmYucXVldWVfc2l6ZSA+IGN1
cnJlbnRfcXVldWVfc2l6ZSkgew0KIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBmb3IgKHF1ZXVl
IGluIGFsbF9xdWV1ZXMpIHsNCiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpbmNy
ZWFzZV9xdWV1ZV9zaXplKHF1ZXVlLCBjb25mLnF1ZXVlX3NpemUpDQogwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIH0NCiDCoMKgwqDCoMKgwqDCoMKgIH0NCg0KTWlnaHQgdGhpcyBhcHByb2FjaCB3
b3JrPyBEb2VzIGl0IHdoYXQgeW91IG1lYW50Pw0KDQpEZW5pcw0KPg0KPg0KPg0KDQo=

