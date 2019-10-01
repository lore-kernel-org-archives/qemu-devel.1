Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,WEIRD_QUOTING autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8463BC352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 09:13:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D46521924
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 09:13:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="eObTCpdH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D46521924
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFEDW-0003qT-4i
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 05:13:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60811)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iFE7w-0006Wg-AI
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 05:07:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iFE7t-00007r-Iw
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 05:07:23 -0400
Received: from mail-eopbgr50135.outbound.protection.outlook.com
 ([40.107.5.135]:2182 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iFE7t-00007L-B5; Tue, 01 Oct 2019 05:07:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EGBr6S6qzr5gOE9kQyTdLW0QsPihC+D0a+bm036zDip0/SFYlQnZib0xk17bcwCGmOhdpAGZbyLdaeKNkBA7tUA0/ycQH76+V1MeC/pO/CUITAZ0Xe3lZryqCezJgKqXTr2bAsmEIPuTKiG0IUKl1l5pxKRTt5pMT9XWSsWFO/Ex9zVygnkC+BlTpSEAHBH2gRFR7f3ZFSUSwcnLax8cSe1zzRJ0zt8S1eXZ2DKQ8/O0N5hHvFxYPCNgdNR483rvPTCjmR7Ft7dt2AbbW4by9J/u0CntDaovVZHi4IGvYhwi5gbSrnP+G5pNHr4XaerPJVi2jY46G4Cn3XUKrcCPdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=41iwmNV2ly/jErO7RSO1eUgeEOI6gew31Kmq9CsYOEc=;
 b=UhsE8Shu+1QP/rmLuewwgmlH7uF4ceIYO1/xIVJvOd/OTig/ntHl3m2SqaUSzCmv0z40QnOgn7WHp4C1RXjj99cVur8ESYhtrnsGYgrdAbk14kVFRQL5fccTaf1xIL1I/SL+dx2zUipr4ypsIyYUL4+IpaFQU0ZgnDjEGC55Q7xx2wpDQItJHnDQQw7lPbHpAiL2EyyJ5xy5X/c4LRsaAZ0ZcIrDKLx92kdGKVOAfWx1TqLkJar/xg0M0zTF7DR1KlbLOUxJiwktiGEbNa5cXxuNPx0XfNI5kaI3ihKr8u79tkuvx4vD4Z4x5rBgecqGu7WMAn7/A4ZnlPIkIlfHnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=41iwmNV2ly/jErO7RSO1eUgeEOI6gew31Kmq9CsYOEc=;
 b=eObTCpdHxQK+PZXitRVy/zZXwTRyyRHArs30+LO+It6kw0v2WQtsxRFevHhsafT44YScfdvIrPeqHRJYj9afMtrc+O543/lOoxAOcylJd+jwhn1mEI3gqLQp7MplFvRA8dCh5aoEmQqM87sXR8UEOCqwl8PNqg68OKdzOkPkcJs=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5292.eurprd08.prod.outlook.com (20.179.9.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Tue, 1 Oct 2019 09:07:18 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f%2]) with mapi id 15.20.2305.017; Tue, 1 Oct 2019
 09:07:18 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Peter Krempa <pkrempa@redhat.com>, John Snow <jsnow@redhat.com>
Subject: Re: bitmap migration bug with -drive while block mirror runs
Thread-Topic: bitmap migration bug with -drive while block mirror runs
Thread-Index: AQHVd+yDiWNDoVbdB0u/++2NVEJq8qdFMaGAgABNwoA=
Date: Tue, 1 Oct 2019 09:07:17 +0000
Message-ID: <60f94d36-9c55-7e77-94dd-7dcecce22ad8@virtuozzo.com>
References: <315cff78-dcdb-a3ce-2742-da3cc9f0ca97@redhat.com>
 <20191001042857.GY9210@angien.pipo.sk>
In-Reply-To: <20191001042857.GY9210@angien.pipo.sk>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0401CA0064.eurprd04.prod.outlook.com
 (2603:10a6:3:19::32) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191001120715743
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c22a8682-fcf3-4bea-4098-08d7464ec261
x-ms-traffictypediagnostic: DB8PR08MB5292:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DB8PR08MB5292EBE66B5693249ABE5CB8C19D0@DB8PR08MB5292.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0177904E6B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(346002)(39850400004)(136003)(396003)(366004)(189003)(199004)(8936002)(25786009)(7736002)(305945005)(8676002)(81166006)(81156014)(66476007)(6506007)(66446008)(64756008)(66556008)(102836004)(53546011)(316002)(110136005)(66946007)(54906003)(66066001)(5660300002)(386003)(486006)(6512007)(26005)(6436002)(31686004)(6486002)(229853002)(52116002)(186003)(99286004)(2906002)(6306002)(76176011)(14454004)(2616005)(36756003)(11346002)(6116002)(3846002)(476003)(446003)(966005)(14444005)(5024004)(256004)(4326008)(86362001)(478600001)(31696002)(71200400001)(71190400001)(6246003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5292;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s9Jjv41vBh6vV25Lkl7c9JLnquSpdXl8wp5z5/nb3Dltsm76yHvIHMaEmZV/vvWrJeQ0YngN59w0pNXQ4NUh6C7U1tasXcf2B0NlBolHNG+1k3O9CDZm8MZiCr8Hyd5aB4bqdOYkTVYr9rwbf80ElXNBxD4MjiIaXk9fxr6Gr2f+DOHHdonRXWTchZzEXISqEd361sqdFSMO/2R/WZWfV/xx1+6uISlYIRJGZgXRWtWcjWF9ywHzom3ZDbAhM3Cw9BCOfb4nmjSdfWj0w7agT7amSCDMgkjWf/72sPkbDaQbzaCJ3wn4wQHKs/yK+OkkvUXyrCBMmEW60uTGFTH9VJM8JHTu5VnNvaejACfdjKA0FkaT7GEcu7iym/t5QzH2fVeZNa6rFA263qIkOoPQmxkNEHWDR1kq6K8CovlCOYPbqqo6eDuAvLX16PWevzSjF3AjTcljIgO7W+9okiHmNA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <2D59C6B84FBAC046B87AF593B022A7FE@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c22a8682-fcf3-4bea-4098-08d7464ec261
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2019 09:07:18.0112 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P8TcnX+hWj3xSipunlVeNl8GnpimmJC44UWDv37qBSJHpJiFWnNyUS1pFG1OK5+ydwrvaYK01zWWnzqfajZ8qO8uQtpjKXg10uitT30QOyI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5292
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.5.135
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
Cc: qemu-devel <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDEuMTAuMjAxOSA3OjI4LCBQZXRlciBLcmVtcGEgd3JvdGU6DQo+IE9uIE1vbiwgU2VwIDMwLCAy
MDE5IGF0IDIwOjA5OjI4IC0wNDAwLCBKb2huIFNub3cgd3JvdGU6DQo+PiBIaSBmb2xrcywgSSBp
ZGVudGlmaWVkIGEgcHJvYmxlbSB3aXRoIHRoZSBtaWdyYXRpb24gY29kZSB0aGF0IFJlZCBIYXQg
UUUNCj4+IGZvdW5kIGFuZCB0aG91Z2h0IHlvdSdkIGxpa2UgdG8gc2VlIGl0Og0KPj4NCj4+IGh0
dHBzOi8vYnVnemlsbGEucmVkaGF0LmNvbS9zaG93X2J1Zy5jZ2k/aWQ9MTY1MjQyNCNjMjANCj4+
DQo+PiBWZXJ5LCB2ZXJ5IGJyaWVmbHk6IGRyaXZlLW1pcnJvciBpbnNlcnRzIGEgZmlsdGVyIG5v
ZGUgdGhhdCBjaGFuZ2VzIHdoYXQNCj4+IGJkcnZfZ2V0X2RldmljZV9vcl9ub2RlX25hbWUoKSBy
ZXR1cm5zLCB3aGljaCBjYXVzZXMgYSBtaWdyYXRpb24gcHJvYmxlbS4NCj4+DQo+PiBJZ25vcmFu
dCBxdWVzdGlvbiAjMTogQ2FuIHdlIG11bHRpLXBhcmVudCB0aGUgZmlsdGVyIG5vZGUgYW5kDQo+
PiBzb3VyY2Utbm9kZT8gSXQgbG9va3MgbGlrZSBhdCB0aGUgbW9tZW50IGJvdGggY29uc2lkZXIg
dGhlaXIgb25seSBwYXJlbnQNCj4+IHRvIGJlIHRoZSBibG9jay1qb2IgYW5kIGRvbid0IGhhdmUg
YSBsaW5rIGJhY2sgdG8gdGhlaXIgcGFyZW50cyBvdGhlcndpc2UuDQo+Pg0KPj4NCj4+IE90aGVy
d2lzZTogSSBoYXZlIGEgbG90IG9mIGNsb3VkeSBpZGVhcyBvbiBob3cgdG8gc29sdmUgdGhpcywg
YnV0DQo+PiB1bHRpbWF0ZWx5IHdoYXQgd2Ugd2FudCBpcyB0byBiZSBhYmxlIHRvIGZpbmQgdGhl
ICJhZGRyZXNzYWJsZSIgbmFtZSBmb3INCj4+IHRoZSBub2RlIHRoZSBiaXRtYXAgaXMgYXR0YWNo
ZWQgdG8sIHdoaWNoIHdvdWxkIGJlIHRoZSBuYW1lIG9mIHRoZSBmaXJzdA0KPj4gYW5jZXN0b3Ig
bm9kZSB0aGF0IGlzbid0IGEgZmlsdGVyLiAoT1IsIHRoZSBuYW1lIG9mIHRoZSBibG9jay1iYWNr
ZW5kDQo+PiBhYm92ZSB0aGF0IG5vZGUuKQ0KPiANCj4gT25lIHBvc3NpYmlsaXR5IGlmIHRoZXJl
IGlzbid0IGFuIGVsZWdhbnQgcWVtdS1iYXNlZCBzb2x1dGlvbiB3b3VsZCBiZQ0KPiB0byBhZGQg
YSBtaWdyYXRpb24gZmVhdHVyZSBsaWJ2aXJ0IGNvdWxkIGVuYWJsZSB3aGljaCB3b3VsZCBzaW1w
bHkgc3RvcA0KPiBiaXRtYXBzIGZyb20gYmVpbmcgY29waWVkIGFuZCBsaWJ2aXJ0IHdvdWxkIGRv
IHRoYXQgaW4gdGhlIHN5bmNocm9uaXNlZA0KPiBwaGFzZSBvZiB0aGUgbWlncmF0aW9uIGV4cGxp
Y2l0bHkuDQoNCkhtbS4gSG93IGl0IGNhbiBkbyBpdD8NCg0KSSBub3cgdGhlIG9ubHkgd2F5IHRv
IG1pZ3JhdGUgYml0bWFwcyB3aXRob3V0IG1pZ3JhdGlvbi1jYXBhYmlsaXR5OiB0aHJvdWdoDQpz
aGFyZWQgc3RvcmFnZSBkdXJpbmcgbWlncmF0aW9uIGRvd250aW1lLiBCdXQgdGhpcyBtZWFucyB0
aGF0IGRvd250aW1lIGJlY29tZXMNCmxvbmcgaWYgdGhlcmUgYXJlIGEgbG90IG9mIGJpdG1hcCBk
YXRhIGFuZCBzdG9yYWdlIGlzIG5vdCBmYXN0IGVub3VnaC4NCg0KPiANCj4gTGlidmlydCBtaWdo
dCBwb3NzaWJseSBuZWVkIHRvIGRvIGl0IGFueXdheXMgZm9yIGluYWN0aXZlIGJpdG1hcHMgaWYN
Cj4gdGhlIGF1dG9tYXRpYyBiaXRtYXAgY29weWluZyBpbmNsdWRlcyBvbmx5IGFjdGl2ZSBiaXRt
YXBzLg0KDQpBbGwgYml0bWFwcyBhcmUgbWlncmF0ZWQuDQoNCj4gDQo+IEknbSBub3Qgc3VyZSB0
aG91Z2ggaG93IHRoYXQgd291bGQgY29tYmluZSB3aXRoIHBvc3QtY29weSBtaWdyYXRpb24gb3IN
Cj4gd2hhdCB0aGUgaW1wYWN0IG9uIGxhdGVuY3kgd291bGQgYmUsIGJ1dCBpZiB5b3UgYXJlIG1p
Z3JhdGluZyB3aXRoDQo+IHN0b3JhZ2UgSSB0aGluayBwZXJmb3JtYW5jZSB3aWxsIG5vdCBiZSBz
dGVsYXIgYW55d2F5cy4NCg0KSnVzdCBrZWVwIGluIG1pbmQgdGhhdCBiaXRtYXAgd2l0aCBkZWZh
dWx0IGdyYW51bGFyaXR5ICg2NGspIGZvciAxNlRCIGRpc2sNCmlzIDMyTSwgYW5kIHdlIG1heSBo
YXZlIHNldmVyYWwgc3VjaCBiaXRtYXBzLiBTdG9yaW5nL2xvYWRpbmcgdGhlbQ0KZHVyaW5nIG1p
Z3JhdGlvbiBkb3dudGltZSB3aWxsIG9mIGNvdXJzZSBpbmZsdWVuY2UgdGhpcyBkb3dudGltZQ0K
DQo+IA0KPj4gQSBzaW1wbGUgd2F5IHRvIGRvIHRoaXMgbWlnaHQgYmUgYSAiY2hpbGRfdW5maWx0
ZXJlZCIgQmRydkNoaWxkIHJvbGUNCj4+IHRoYXQgc2ltcGx5IGJ5cGFzc2VzIHRoZSBmaWx0ZXIg
dGhhdCB3YXMgaW5zZXJ0ZWQgYW5kIHNlcnZlcyBubyByZWFsDQo+PiBwdXJwb3NlIG90aGVyIHRo
YW4gdG8gYWxsb3cgdGhlIGNoaWxkIHRvIGhhdmUgYSBwYXJlbnQgbGluayBhbmQgZmluZCB3aG8N
Cj4+IGl0J3MgIiIicmVhbCIiIiBwYXJlbnQgaXMuDQo+Pg0KPj4gQmVjYXVzZSBvZiBmbHVzaGlu
ZywgcmVvcGVuLCBzeW5jLCBkcmFpbiAmYyAmYyAmYyBJJ20gbm90IHN1cmUgaG93DQo+PiBmZWFz
aWJsZSB0aGlzIHF1aWNrIGlkZWEgbWlnaHQgYmUsIHRob3VnaC4NCj4+DQo+Pg0KPj4gLSBDb3Jv
bGxhcnkgZml4ICMxOiBjYWxsIGVycm9yX3NldGcgaWYgdGhlIGJpdG1hcCBub2RlIG5hbWUgdGhh
dCdzIGFib3V0DQo+PiB0byBnbyBvdmVyIHRoZSB3aXJlIGlzIGFuIGF1dG9nZW5lcmF0ZWQgbm9k
ZTogdGhpcyBpcyBuZXZlciBjb3JyZWN0IQ0KPj4NCj4+IChXaHkgbm90PyBiZWNhdXNlIHRoZSB0
YXJnZXQgaXMgaW5jYXBhYmxlIG9mIG1hdGNoaW5nIHRoZSBub2RlLW5hbWUNCj4+IGJlY2F1c2Ug
dGhleSBhcmUgcmFuZG9tbHkgZ2VuZXJhdGVkIEFORCB5b3UgY2Fubm90IHNwZWNpZnkgbm9kZS1u
YW1lcw0KPj4gd2l0aCAjIHByZWZpeGVzIGFzIHRoZXkgYXJlIGVzcGVjaWFsbHkgcmVzZXJ2ZWQh
DQo+Pg0KPj4gKFRoaXMgcmFpc2VzIGEgcmVsYXRlZCBwcm9ibGVtOiBpZiB5b3UgZXhwbGljaXRs
eSBhZGQgYml0bWFwcyB0byBub2Rlcw0KPj4gd2l0aCBhdXRvZ2VuZXJhdGVkIG5hbWVzLCB5b3Ug
d2lsbCBiZSB1bmFibGUgdG8gbWlncmF0ZSB0aGVtLikpDQo+IA0KPiBJIHRoaW5rIHRoaXMgc2hv
dWxkIGJlIG9rYXkuIEluIGxpYnZpcnQgSSBvcHRlZCB0byBmb3JiaWQgY2hlY2twb2ludHMNCj4g
d2hpY2ggbWFwIHRvIGJpdG1hcCBjcmVhdGlvbiB1bnRpbCBibG9ja2RldiB3aWxsIGJlIHN1cHBv
cnRlZCB3aGVyZSB3ZQ0KPiBtYW5hZ2Ugbm9kZSBuYW1lcyBvdXJzZWx2ZXMuDQo+IA0KDQpIbW0s
IEknbSBhZnJhaWQgdGhhdCB3ZSdsbCBoYXZlIHRvIGZpeCB0aGlzIHByb2JsZW0gc29vbmVyLg0K
DQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

