Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C9BCA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 13:24:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90C9F2084C
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 13:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="uKWWrXVu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90C9F2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNd6a-00074q-2i
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 09:24:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40086)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <den@virtuozzo.com>) id 1iNbO4-00009M-Lo
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:34:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <den@virtuozzo.com>) id 1iNbO1-0002EO-TZ
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:34:40 -0400
Received: from mail-eopbgr30117.outbound.protection.outlook.com
 ([40.107.3.117]:3238 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <den@virtuozzo.com>) id 1iNbO1-0002Dq-1y
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:34:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n7ejgtf1NULK7Hn8JT7RvCKudl4VBZM8v/nqTfvEW1iwyYBsRWn1TtSUUfCO/xZKpPq1howXRiZf/nsbErQEpExV6vMqyWUj7LQE25TXAtyial56rexLVoUmQvnXNYSdvfYA3oqb868NQJgeQhHvYEmhrKHKNnID88YSMEnaH5V6fDHklFHmGoR7yoJS4b8G9xP7eogdW1ZBS12yAMsDMIjn7UZoX+HzJ+Wrw8YU3dlW2/HOwNYk9xJBbmmul78h1EDbYds9rpoJDp+jTrMnBFEcH3W85QdsqHR0J+iNTGoNoN3+8H6alI8wP8qFkc84Re9BUK6X49VgAERdcGKEkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FiG20VSDDFW291h6sX612DrL5ZIWhxXPKfcYnS51lh0=;
 b=jX2VIJaDLNLjZfXeqq+cznL+TTlWOTbp2nfj0keXZ4+sVCh6TIsOo8xvxwri2JcX2cBt223tPuqTaNV/BltChOShTZRnbpLXYU3gv9BVXLG2ZqhHWrV6g8+qI3ECaGnjIXRk8O/J9M4rGjUKNH/8vcQQkWwm1DHB2GVYuWCMksNCY58ndWco/fPoVteJDoVEtr8VTJX4ksG5fTYqcTE4+z6+w21o4XsygLlZUm3MV0E87DsRe+0ym300N45AI9ktJ2j0nQN8+sA/nlHT+R9W8o2u23YzozPjYrY0+O5cktlxxgfp+chfwOMtgkvbPLhY5FXU8UVJ7h9bB3NjsbvI9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FiG20VSDDFW291h6sX612DrL5ZIWhxXPKfcYnS51lh0=;
 b=uKWWrXVuJOh3WCothr5+g/pM2qkJ9MTPSF38reHfB/aJFOBscYS7Kmgyw6jeaxcK/ipuVUbqLKLGMnNFg0fM80NSAouhmAS1nJDmNilSbFiV5PsyB+hRQB27qjyk4BXRXuixkw+gFon57kapkloLY+wav4aYfGrJhulLyVk7T1g=
Received: from DB6PR0801MB1702.eurprd08.prod.outlook.com (10.169.221.21) by
 DB6PR0801MB2070.eurprd08.prod.outlook.com (10.168.86.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Thu, 24 Oct 2019 11:34:34 +0000
Received: from DB6PR0801MB1702.eurprd08.prod.outlook.com
 ([fe80::f849:2ba0:2a0b:5b34]) by DB6PR0801MB1702.eurprd08.prod.outlook.com
 ([fe80::f849:2ba0:2a0b:5b34%7]) with mapi id 15.20.2347.030; Thu, 24 Oct 2019
 11:34:34 +0000
From: Denis Lunev <den@virtuozzo.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Denis Plotnikov
 <dplotnikov@virtuozzo.com>
Subject: Re: [PATCH] virtio: fix IO request length in virtio SCSI/block
 #PSBM-78839
Thread-Topic: [PATCH] virtio: fix IO request length in virtio SCSI/block
 #PSBM-78839
Thread-Index: AQHVhasC5IeHsTPw3kK+gvsF622z76doxjuAgADscAA=
Date: Thu, 24 Oct 2019 11:34:34 +0000
Message-ID: <42b80a75-6ab4-5123-bbf5-eee21c2841ac@virtuozzo.com>
References: <20191018115547.19299-1-dplotnikov@virtuozzo.com>
 <20191023172005-mutt-send-email-mst@kernel.org>
In-Reply-To: <20191023172005-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0258.eurprd05.prod.outlook.com
 (2603:10a6:3:fb::34) To DB6PR0801MB1702.eurprd08.prod.outlook.com
 (2603:10a6:4:2f::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=den@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 28333af3-4525-4bb6-f713-08d7587624bd
x-ms-traffictypediagnostic: DB6PR0801MB2070:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR0801MB2070485B88D076C767E28080B66A0@DB6PR0801MB2070.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-forefront-prvs: 0200DDA8BE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(366004)(39840400004)(346002)(396003)(136003)(199004)(189003)(25786009)(7736002)(478600001)(305945005)(6246003)(99286004)(14444005)(36756003)(186003)(256004)(316002)(54906003)(31696002)(110136005)(14454004)(66476007)(66556008)(66446008)(66946007)(64756008)(2906002)(6512007)(71200400001)(71190400001)(86362001)(6486002)(446003)(6636002)(4326008)(11346002)(8936002)(102836004)(66066001)(76176011)(5660300002)(476003)(2616005)(8676002)(81156014)(81166006)(229853002)(386003)(6116002)(6506007)(53546011)(31686004)(6436002)(52116002)(26005)(3846002)(486006);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB6PR0801MB2070;
 H:DB6PR0801MB1702.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nAxyKzASobQAeY8U9xU/IuMdVKUGelkxLd93o7TDAIChGf2tFr5Vf3sP+uo0mhpLTRmZA5+ospW4AD3uUC8AqyOVL8TAdy/ZQp7DjPpi5Br8CEyEIEkHv7/vgTi3w0h2DFCu2hxU9rLRGdgsLZC615DFLNi0Ygue4eSoq8qksBg9ApZYfBPA093lWaOX7hxcnwovMMlmsMoglp2c3Ilt5dfscaCpMfG/WbivR5alXotQuHDe8fC8zw2J1pRlIe4/vE47RpO/9KH/C9530b5NL5S3JOzOIipaKtnEShRhFfM6ln1YBeRCVjAkXSq5tbG9BELYg4hqt9+E6Mxeooq1V+nR+F8XOXBG7cDalvXLHR/PuZG4QCalL6Ovbwyd//udWPne+6xe1H1Y9PbaF43DNs17gAyKvdbou4CdqofKIxET0QMNHbJetEA8HhilS2EZ
Content-Type: text/plain; charset="utf-8"
Content-ID: <66EBBFDB4915264199F44571263939E3@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28333af3-4525-4bb6-f713-08d7587624bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2019 11:34:34.4058 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KTVLI3VZK02SbVHFTRbn/QPXal0w8fD9nlP9fl1VC01DLxo6YJbSJ3aPvE34T/IQxb5+PRcRhZbAgBnLsjsiAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB2070
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.3.117
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 "kraxel@redhat.com" <kraxel@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gMTAvMjQvMTkgMTI6MjggQU0sIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToNCj4gT24gRnJp
LCBPY3QgMTgsIDIwMTkgYXQgMDI6NTU6NDdQTSArMDMwMCwgRGVuaXMgUGxvdG5pa292IHdyb3Rl
Og0KPj4gRnJvbTogIkRlbmlzIFYuIEx1bmV2IiA8ZGVuQG9wZW52ei5vcmc+DQo+Pg0KPj4gTGlu
dXggZ3Vlc3RzIHN1Ym1pdCBJTyByZXF1ZXN0cyBubyBsb25nZXIgdGhhbiBQQUdFX1NJWkUgKiBt
YXhfc2VnDQo+PiBmaWVsZCByZXBvcnRlZCBieSBTQ1NJIGNvbnRyb2xlci4gVGh1cyB0eXBpY2Fs
IHNlcXVlbnRpYWwgcmVhZCB3aXRoDQo+PiAxIE1CIHNpemUgcmVzdWx0cyBpbiB0aGUgZm9sbG93
aW5nIHBhdHRlcm4gb2YgdGhlIElPIGZyb20gdGhlIGd1ZXN0Og0KPj4gICA4LDE2ICAgMSAgICAx
NTc1NCAgICAgMi43NjYwOTUxMjIgIDIwNzEgIEQgICBSIDIwOTUxMDQgKyAxMDA4IFtkZF0NCj4+
ICAgOCwxNiAgIDEgICAgMTU3NTUgICAgIDIuNzY2MTA4Nzg1ICAyMDcxICBEICAgUiAyMDk2MTEy
ICsgMTAwOCBbZGRdDQo+PiAgIDgsMTYgICAxICAgIDE1NzU2ICAgICAyLjc2NjExMzQ4NiAgMjA3
MSAgRCAgIFIgMjA5NzEyMCArIDMyIFtkZF0NCj4+ICAgOCwxNiAgIDEgICAgMTU3NTcgICAgIDIu
NzY3NjY4OTYxICAgICAwICBDICAgUiAyMDk1MTA0ICsgMTAwOCBbMF0NCj4+ICAgOCwxNiAgIDEg
ICAgMTU3NTggICAgIDIuNzY4NTM0MzE1ICAgICAwICBDICAgUiAyMDk2MTEyICsgMTAwOCBbMF0N
Cj4+ICAgOCwxNiAgIDEgICAgMTU3NTkgICAgIDIuNzY4NTM5NzgyICAgICAwICBDICAgUiAyMDk3
MTIwICsgMzIgWzBdDQo+PiBUaGUgSU8gd2FzIGdlbmVyYXRlZCBieQ0KPj4gICBkZCBpZj0vZGV2
L3NkYSBvZj0vZGV2L251bGwgYnM9MTAyNCBpZmxhZz1kaXJlY3QNCj4+DQo+PiBUaGlzIGVmZmVj
dGl2ZWx5IG1lYW5zIHRoYXQgb24gcm90YXRpb25hbCBkaXNrcyB3ZSB3aWxsIG9ic2VydmUgMyBJ
T1BTDQo+PiBmb3IgZWFjaCAyIE1CcyBwcm9jZXNzZWQuIFRoaXMgZGVmaW5pdGVseSBuZWdhdGl2
ZWx5IGFmZmVjdHMgYm90aA0KPj4gZ3Vlc3QgYW5kIGhvc3QgSU8gcGVyZm9ybWFuY2UuDQo+Pg0K
Pj4gVGhlIGN1cmUgaXMgcmVsYXRpdmVseSBzaW1wbGUgLSB3ZSBzaG91bGQgcmVwb3J0IGxlbmd0
aHkgc2NhdHRlci1nYXRoZXINCj4+IGFiaWxpdHkgb2YgdGhlIFNDU0kgY29udHJvbGxlci4gRm9y
dHVuYXRlbHkgdGhlIHNpdHVhdGlvbiBoZXJlIGlzIHZlcnkNCj4+IGdvb2QuIFZpcnRJTyB0cmFu
c3BvcnQgbGF5ZXIgY2FuIGFjY29tb2RhdGUgMTAyNCBpdGVtcyBpbiBvbmUgcmVxdWVzdA0KPj4g
d2hpbGUgd2UgYXJlIHVzaW5nIG9ubHkgMTI4LiBUaGlzIHNpdHVhdGlvbiBpcyBwcmVzZW50IHNp
bmNlIGFsbW9zdA0KPj4gdmVyeSBiZWdpbm5pbmcuIDIgaXRlbXMgYXJlIGRlZGljYXRlZCBmb3Ig
cmVxdWVzdCBtZXRhZGF0YSB0aHVzIHdlDQo+PiBzaG91bGQgcHVibGlzaCBWSVJUUVVFVUVfTUFY
X1NJWkUgLSAyIGFzIG1heF9zZWcuDQo+Pg0KPj4gVGhlIGZvbGxvd2luZyBwYXR0ZXJuIGlzIG9i
c2VydmVkIGFmdGVyIHRoZSBwYXRjaDoNCj4+ICAgOCwxNiAgIDEgICAgIDk5MjEgICAgIDIuNjYy
NzIxMzQwICAyMDYzICBEICAgUiAyMDk1MTA0ICsgMTAyNCBbZGRdDQo+PiAgIDgsMTYgICAxICAg
ICA5OTIyICAgICAyLjY2MjczNzU4NSAgMjA2MyAgRCAgIFIgMjA5NjEyOCArIDEwMjQgW2RkXQ0K
Pj4gICA4LDE2ICAgMSAgICAgOTkyMyAgICAgMi42NjUxODgxNjcgICAgIDAgIEMgICBSIDIwOTUx
MDQgKyAxMDI0IFswXQ0KPj4gICA4LDE2ICAgMSAgICAgOTkyNCAgICAgMi42NjUxOTg3NzcgICAg
IDAgIEMgICBSIDIwOTYxMjggKyAxMDI0IFswXQ0KPj4gd2hpY2ggaXMgbXVjaCBiZXR0ZXIuDQo+
Pg0KPj4gVGhlIGRhcmsgc2lkZSBvZiB0aGlzIHBhdGNoIGlzIHRoYXQgd2UgYXJlIHR3ZWFraW5n
IGd1ZXN0IHZpc2libGUNCj4+IHBhcmFtZXRlciwgdGhvdWdoIHRoaXMgc2hvdWxkIGJlIHJlbGF0
aXZlbHkgc2FmZSBhcyBhYm92ZSB0cmFuc3BvcnQNCj4+IGxheWVyIHN1cHBvcnQgaXMgcHJlc2Vu
dCBpbiBRRU1VL2hvc3QgTGludXggZm9yIGEgdmVyeSBsb25nIHRpbWUuDQo+PiBUaGUgcGF0Y2gg
YWRkcyBjb25maWd1cmFibGUgcHJvcGVydHkgZm9yIFZpcnRJTyBTQ1NJIHdpdGggYSBuZXcgZGVm
YXVsdA0KPj4gYW5kIGhhcmRjb2RlIG9wdGlvbiBmb3IgVmlydEJsb2NrIHdoaWNoIGRvZXMgbm90
IHByb3ZpZGUgZ29vZA0KPj4gY29uZmlndXJhYmxlIGZyYW1ld29yay4NCj4+DQo+PiBVbmZvcnR1
bmF0ZWx5IHRoZSBjb21taXQgY2FuIG5vdCBiZSBhcHBsaWVkIGFzIGlzLiBGb3IgdGhlIHJlYWwg
Y3VyZSB3ZQ0KPj4gbmVlZCBndWVzdCB0byBiZSBmaXhlZCB0byBhY2NvbW9kYXRlIHRoYXQgcXVl
dWUgbGVuZ3RoLCB3aGljaCBpcyBkb25lDQo+PiBvbmx5IGluIHRoZSBsYXRlc3QgNC4xNCBrZXJu
ZWwuIFRodXMgd2UgYXJlIGdvaW5nIHRvIGV4cG9zZSB0aGUgcHJvcGVydHkNCj4+IGFuZCB0d2Vh
ayBpdCBvbiBtYWNoaW5lIHR5cGUgbGV2ZWwuDQo+Pg0KPj4gVGhlIHByb2JsZW0gd2l0aCB0aGUg
b2xkIGtlcm5lbHMgaXMgdGhhdCB0aGV5IGhhdmUNCj4+IG1heF9zZWdtZW50cyA8PSB2aXJ0cXVl
dWVfc2l6ZSByZXN0cmljdGlvbiB3aGljaCBjYXVzZSB0aGUgZ3Vlc3QNCj4+IGNyYXNoaW5nIGlu
IHRoZSBjYXNlIG9mIHZpb2xhdGlvbi4NCj4gVGhpcyBpc24ndCBqdXN0IGluIHRoZSBndWVzdHM6
IHZpcnRpbyBzcGVjIGFsc28gc2VlbXMgdG8gaW1wbHkgdGhpcywNCj4gb3IgYXQgbGVhc3QgYmUg
dmFndWUgb24gdGhpcyBwb2ludC4NCj4NCj4gU28gSSB0aGluayBpdCdsbCBuZWVkIGEgZmVhdHVy
ZSBiaXQuDQo+IERvaW5nIHRoYXQgaW4gYSBzYWZlIHdheSB3aWxsIGFsc28gYWxsb3cgYmVpbmcg
Y29tcGF0aWJsZSB3aXRoIG9sZCBndWVzdHMuDQo+DQo+IFRoZSBvbmx5IGRvd25zaWRlIGlzIGl0
J3MgYSBiaXQgbW9yZSB3b3JrIGFzIHdlIG5lZWQgdG8NCj4gc3BlYyB0aGlzIG91dCBhbmQgYWRk
IGd1ZXN0IHN1cHBvcnQuDQo+DQo+PiBUbyBmaXggdGhlIGNhc2UgZGVzY3JpYmVkIGFib3ZlIGlu
IHRoZSBvbGQga2VybmVscyB3ZSBjYW4gaW5jcmVhc2UNCj4+IHZpcnRxdWV1ZV9zaXplIHRvIDI1
NiBhbmQgbWF4X3NlZ21lbnRzIHRvIDI1NC4gVGhlIHBpdGZhbGwgaGVyZSBpcw0KPj4gdGhhdCBz
ZWFiaW9zIGFsbG93cyB0aGUgdmlydHF1ZXVlX3NpemUtcyA8IDEyOCwgaG93ZXZlciwgdGhlIHNl
YWJpb3MNCj4+IHBhdGNoIGV4dGVuZGluZyB0aGF0IHZhbHVlIHRvIDI1NiBpcyBwZW5kaW5nLg0K
Pg0KPiBBbmQgdGhlIGZpeCBoZXJlIGlzIGp1c3QgdG8gbGltaXQgbGFyZ2UgdnEgc2l6ZSB0byB2
aXJ0aW8gMS4wLg0KPiBJbiB0aGF0IG1vZGUgaXQncyBmaW5lIEkgdGhpbms6DQo+DQo+DQo+ICAg
IC8qIGNoZWNrIGlmIHRoZSBxdWV1ZSBpcyBhdmFpbGFibGUgKi8NCj4gICAgaWYgKHZwLT51c2Vf
bW9kZXJuKSB7DQo+ICAgICAgICBudW0gPSB2cF9yZWFkKCZ2cC0+Y29tbW9uLCB2aXJ0aW9fcGNp
X2NvbW1vbl9jZmcsIHF1ZXVlX3NpemUpOw0KPiAgICAgICAgaWYgKG51bSA+IE1BWF9RVUVVRV9O
VU0pIHsNCj4gICAgICAgICAgICB2cF93cml0ZSgmdnAtPmNvbW1vbiwgdmlydGlvX3BjaV9jb21t
b25fY2ZnLCBxdWV1ZV9zaXplLA0KPiAgICAgICAgICAgICAgICAgICAgIE1BWF9RVUVVRV9OVU0p
Ow0KPiAgICAgICAgICAgIG51bSA9IHZwX3JlYWQoJnZwLT5jb21tb24sIHZpcnRpb19wY2lfY29t
bW9uX2NmZywgcXVldWVfc2l6ZSk7DQo+ICAgICAgICB9DQo+ICAgIH0gZWxzZSB7DQo+ICAgICAg
ICBudW0gPSB2cF9yZWFkKCZ2cC0+bGVnYWN5LCB2aXJ0aW9fcGNpX2xlZ2FjeSwgcXVldWVfbnVt
KTsNCj4gICAgfQ0KDQp5b3UgbWVhbiB0byBwdXQgdGhlIGNvZGUgbGlrZSB0aGlzIGludG8gdmly
dGlvX3BjaV9yZWFsaXplKCkgaW5zaWRlIFFFTVU/DQoNCklmIG5vLCBjYW4geW91IHBscyBjbGFy
aWZ5IHdoaWNoIGNvbXBvbmVudCBzaG91bGQgYmUgdG91Y2hlZC4NCg0KRGVuDQo=

