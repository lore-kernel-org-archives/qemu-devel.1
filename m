Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,WEIRD_QUOTING autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2069EECE587
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 14:54:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C336020815
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 14:54:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="FntKzTPm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C336020815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFJY5-0008MW-Py
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 10:54:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41144)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iFJWn-0007gO-ID
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 10:53:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iFJWl-0003UQ-Ni
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 10:53:25 -0400
Received: from mail-eopbgr50093.outbound.protection.outlook.com
 ([40.107.5.93]:48002 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iFJWk-0003Rc-Ug; Tue, 01 Oct 2019 10:53:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E76Uch72fgfEa/To6P68nLkbLzKsJvbQhTie5Bx0G2ntWBrj64sZGwqKUPXwADZnWC2D1YGN6YiyWFLVLyGRgsJB0K7MmAr1G+UA28T08+Zeg3D0DIvqXdnBvvbLtb5JFdgt10ZOvqCLp5kMo8atqGbog391BGtVZFPUPpGdIGLCjcWgTBn/96sjIT75qcF7EyFyYUd9yjWPRWrTcLLG1SPudN7jiZb1I7g5aTjbBrBokxSp0wGyYhw9hRHGAo8E0ejfejX4aOBjS2j3j6rSS7hiXuyOMahluvd13JbXmZbsu2itPsIooi6R8y1rLqFss/uAxBVBFlyrXNChxcG5zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=URWPLEV/sYF6Ug3j1KR4sqSjpu655Axq6wkAXNis3ls=;
 b=F79TvImU5+W3iiEhw67o6+00TPUfxwK3t9yR+vpXijJPuFfag+nLpzxsMcpre3rVWCv4hxWjg1MQIrkCpJDQwsS3tw+rRDUdKo+X74B5oY9jgfECzbAlVWgNXO6vj2y/4fuMNk50J+oCQ2eKyqfRIy3FUT6KYrFRMnscQRHFhPomCSY/dCjUSLGv99E/naZ/whgGlpbgspyi2nvKJaY6lR0awjvqdUU61sp/CSZ4g/p4WaF6S+DESGmCTXcVPEZEoymTUFUYm2JgxBmHZIJmz0dyyRDP3tgleP651RJgwdHp3CbDGzCg4gm6xmFd9Ynm7mlQ/oQlHuIrqVs2Rz6uGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=URWPLEV/sYF6Ug3j1KR4sqSjpu655Axq6wkAXNis3ls=;
 b=FntKzTPm80QROzWd78s7Z2rEY6Tl1kAeIiq7Bu4Lyfb7JRKRFLPU2ClF9aicnuwmHjHAzQF1iyyb2MLr77fxgj5lkbV8yLM9+zdlVokTsjLSfOr7TDk0jcppqYKiDCxnc7GysBNPdus2FDNmvB+DqOINuAgQt8psGF4LxsPHO7Q=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4060.eurprd08.prod.outlook.com (20.179.9.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Tue, 1 Oct 2019 14:53:20 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f%2]) with mapi id 15.20.2305.017; Tue, 1 Oct 2019
 14:53:19 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>
Subject: Re: bitmap migration bug with -drive while block mirror runs
Thread-Topic: bitmap migration bug with -drive while block mirror runs
Thread-Index: AQHVd+yDiWNDoVbdB0u/++2NVEJq8qdF0TUAgAADoACAAAP3AIAAAg8AgAAFNoA=
Date: Tue, 1 Oct 2019 14:53:19 +0000
Message-ID: <e809204f-48f3-b4c0-0b6f-1e3d59c34640@virtuozzo.com>
References: <315cff78-dcdb-a3ce-2742-da3cc9f0ca97@redhat.com>
 <d897c755-40e7-6392-23e3-c06b1a371f28@virtuozzo.com>
 <6dd4e735-47e7-45d1-98e9-2131746d470c@redhat.com>
 <dfc26b72-4795-09f8-9c50-07d4eabd971a@virtuozzo.com>
 <ef32215d-35e2-14dd-1b43-26f09a88f2dc@redhat.com>
In-Reply-To: <ef32215d-35e2-14dd-1b43-26f09a88f2dc@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0902CA0002.eurprd09.prod.outlook.com
 (2603:10a6:3:e5::12) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191001175317623
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d1e8a597-323d-4a3c-36c4-08d7467f1974
x-ms-traffictypediagnostic: DB8PR08MB4060:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DB8PR08MB4060A22CD683594A98DE9272C19D0@DB8PR08MB4060.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0177904E6B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(376002)(346002)(136003)(39850400004)(366004)(199004)(189003)(31696002)(6116002)(2906002)(8936002)(5024004)(25786009)(4326008)(3846002)(31686004)(86362001)(7736002)(36756003)(5660300002)(305945005)(8676002)(66066001)(81166006)(81156014)(186003)(316002)(2616005)(6246003)(66946007)(6486002)(229853002)(446003)(11346002)(64756008)(256004)(478600001)(66476007)(476003)(66556008)(6306002)(26005)(6506007)(52116002)(102836004)(386003)(99286004)(53546011)(54906003)(6512007)(66446008)(486006)(71200400001)(71190400001)(76176011)(14454004)(6436002)(966005)(110136005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4060;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ee1xP+YcsRVAi2R6FDgoi2xkLjGeuNJVmH91EbIZ/JvdRQWCSIED1UcMuIRFIunGuTXVYiWKxV2uEtNvZIQL4Z14qLqN8331h26xLve9bHTjbglt8oL7jCvit9X/O8zI2gFTCLlxJo+kgqS8Fjs6ra8l8Z0svUU0cSU15eQVn0EH6m7gI6qDL1f+gOvVre77fAmhE5FwxP3mPgFqqZpyooEe4Kpdx2rknyoKDNyhk8GwkpxggNPIoAZZ7M5p4eypCjLn6N70GfWzth0CB156AsDGGd365HQvKJYe/UqjO8H4/HkP78TeEAtG3ID50BLil+f10oCoFFL0posduWFyyriA/dBMVdXEgSxUwJAHdpT/LtDgTr1YsP9SVQ4GBLXSPO5qJ6A9WZRmErIUS9KLj7o1idtBnep8rB1XXgmqZWTKSj9/+G5U9rtXlIPsT0bqTycEkNNiKRie2xJQiLUlcQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <FE71D83428854948BF271639CAC6997D@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1e8a597-323d-4a3c-36c4-08d7467f1974
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2019 14:53:19.9323 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AUXEFIo6mV39neCpBFN20q/jME+1DRZ0C8H0vnnugKSJbYtZxqgLpfMApCN7ks1+zgW40Tgx8QSIjI8M9CGDpPWSAyhFX1/RYhsVewHSY/E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4060
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.5.93
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
Cc: Peter Krempa <pkrempa@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDEuMTAuMjAxOSAxNzozNCwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAwMS4xMC4xOSAxNjoyNywg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IDAxLjEwLjIwMTkgMTc6MTMs
IE1heCBSZWl0eiB3cm90ZToNCj4+PiBPbiAwMS4xMC4xOSAxNjowMCwgVmxhZGltaXIgU2VtZW50
c292LU9naWV2c2tpeSB3cm90ZToNCj4+Pj4gMDEuMTAuMjAxOSAzOjA5LCBKb2huIFNub3cgd3Jv
dGU6DQo+Pj4+PiBIaSBmb2xrcywgSSBpZGVudGlmaWVkIGEgcHJvYmxlbSB3aXRoIHRoZSBtaWdy
YXRpb24gY29kZSB0aGF0IFJlZCBIYXQgUUUNCj4+Pj4+IGZvdW5kIGFuZCB0aG91Z2h0IHlvdSdk
IGxpa2UgdG8gc2VlIGl0Og0KPj4+Pj4NCj4+Pj4+IGh0dHBzOi8vYnVnemlsbGEucmVkaGF0LmNv
bS9zaG93X2J1Zy5jZ2k/aWQ9MTY1MjQyNCNjMjANCj4+Pj4+DQo+Pj4+PiBWZXJ5LCB2ZXJ5IGJy
aWVmbHk6IGRyaXZlLW1pcnJvciBpbnNlcnRzIGEgZmlsdGVyIG5vZGUgdGhhdCBjaGFuZ2VzIHdo
YXQNCj4+Pj4+IGJkcnZfZ2V0X2RldmljZV9vcl9ub2RlX25hbWUoKSByZXR1cm5zLCB3aGljaCBj
YXVzZXMgYSBtaWdyYXRpb24gcHJvYmxlbS4NCj4+Pj4+DQo+Pj4+Pg0KPj4+Pj4gSWdub3JhbnQg
cXVlc3Rpb24gIzE6IENhbiB3ZSBtdWx0aS1wYXJlbnQgdGhlIGZpbHRlciBub2RlIGFuZA0KPj4+
Pj4gc291cmNlLW5vZGU/IEl0IGxvb2tzIGxpa2UgYXQgdGhlIG1vbWVudCBib3RoIGNvbnNpZGVy
IHRoZWlyIG9ubHkgcGFyZW50DQo+Pj4+PiB0byBiZSB0aGUgYmxvY2stam9iIGFuZCBkb24ndCBo
YXZlIGEgbGluayBiYWNrIHRvIHRoZWlyIHBhcmVudHMgb3RoZXJ3aXNlLg0KPj4+Pj4NCj4+Pj4+
DQo+Pj4+PiBPdGhlcndpc2U6IEkgaGF2ZSBhIGxvdCBvZiBjbG91ZHkgaWRlYXMgb24gaG93IHRv
IHNvbHZlIHRoaXMsIGJ1dA0KPj4+Pj4gdWx0aW1hdGVseSB3aGF0IHdlIHdhbnQgaXMgdG8gYmUg
YWJsZSB0byBmaW5kIHRoZSAiYWRkcmVzc2FibGUiIG5hbWUgZm9yDQo+Pj4+PiB0aGUgbm9kZSB0
aGUgYml0bWFwIGlzIGF0dGFjaGVkIHRvLCB3aGljaCB3b3VsZCBiZSB0aGUgbmFtZSBvZiB0aGUg
Zmlyc3QNCj4+Pj4+IGFuY2VzdG9yIG5vZGUgdGhhdCBpc24ndCBhIGZpbHRlci4gKE9SLCB0aGUg
bmFtZSBvZiB0aGUgYmxvY2stYmFja2VuZA0KPj4+Pj4gYWJvdmUgdGhhdCBub2RlLikNCj4+Pj4N
Cj4+Pj4gTm90IHRoZSBuYW1lIG9mIGFuY2VzdG9yIG5vZGUsIGl0IHdpbGwgYnJlYWsgbWFwcGlu
ZzogaXQgbXVzdCBiZSBuYW1lIG9mIHRoZQ0KPj4+PiBub2RlIGl0c2VsZiBvciBuYW1lIG9mIHBh
cmVudCAobWF5IGJlIHRocm91Z2ggc2V2ZXJhbCBmaWx0ZXJzKSBibG9jay1iYWNrZW5kDQo+Pj4+
DQo+Pj4+Pg0KPj4+Pj4gQSBzaW1wbGUgd2F5IHRvIGRvIHRoaXMgbWlnaHQgYmUgYSAiY2hpbGRf
dW5maWx0ZXJlZCIgQmRydkNoaWxkIHJvbGUNCj4+Pj4+IHRoYXQgc2ltcGx5IGJ5cGFzc2VzIHRo
ZSBmaWx0ZXIgdGhhdCB3YXMgaW5zZXJ0ZWQgYW5kIHNlcnZlcyBubyByZWFsDQo+Pj4+PiBwdXJw
b3NlIG90aGVyIHRoYW4gdG8gYWxsb3cgdGhlIGNoaWxkIHRvIGhhdmUgYSBwYXJlbnQgbGluayBh
bmQgZmluZCB3aG8NCj4+Pj4+IGl0J3MgIiIicmVhbCIiIiBwYXJlbnQgaXMuDQo+Pj4+Pg0KPj4+
Pj4gQmVjYXVzZSBvZiBmbHVzaGluZywgcmVvcGVuLCBzeW5jLCBkcmFpbiAmYyAmYyAmYyBJJ20g
bm90IHN1cmUgaG93DQo+Pj4+PiBmZWFzaWJsZSB0aGlzIHF1aWNrIGlkZWEgbWlnaHQgYmUsIHRo
b3VnaC4NCj4+Pj4+DQo+Pj4+Pg0KPj4+Pj4gLSBDb3JvbGxhcnkgZml4ICMxOiBjYWxsIGVycm9y
X3NldGcgaWYgdGhlIGJpdG1hcCBub2RlIG5hbWUgdGhhdCdzIGFib3V0DQo+Pj4+PiB0byBnbyBv
dmVyIHRoZSB3aXJlIGlzIGFuIGF1dG9nZW5lcmF0ZWQgbm9kZTogdGhpcyBpcyBuZXZlciBjb3Jy
ZWN0IQ0KPj4+Pj4NCj4+Pj4+IChXaHkgbm90PyBiZWNhdXNlIHRoZSB0YXJnZXQgaXMgaW5jYXBh
YmxlIG9mIG1hdGNoaW5nIHRoZSBub2RlLW5hbWUNCj4+Pj4+IGJlY2F1c2UgdGhleSBhcmUgcmFu
ZG9tbHkgZ2VuZXJhdGVkIEFORCB5b3UgY2Fubm90IHNwZWNpZnkgbm9kZS1uYW1lcw0KPj4+Pj4g
d2l0aCAjIHByZWZpeGVzIGFzIHRoZXkgYXJlIGVzcGVjaWFsbHkgcmVzZXJ2ZWQhDQo+Pj4+Pg0K
Pj4+Pj4gKFRoaXMgcmFpc2VzIGEgcmVsYXRlZCBwcm9ibGVtOiBpZiB5b3UgZXhwbGljaXRseSBh
ZGQgYml0bWFwcyB0byBub2Rlcw0KPj4+Pj4gd2l0aCBhdXRvZ2VuZXJhdGVkIG5hbWVzLCB5b3Ug
d2lsbCBiZSB1bmFibGUgdG8gbWlncmF0ZSB0aGVtLikpDQo+Pj4+Pg0KPj4+Pj4gLS1qcw0KPj4+
Pj4NCj4+Pj4NCj4+Pj4gV2hhdCBhYm91dCB0aGUgZm9sbG93aW5nOg0KPj4+Pg0KPj4+PiBkaWZm
IC0tZ2l0IGEvYmxvY2suYyBiL2Jsb2NrLmMNCj4+Pj4gaW5kZXggNTk0NDEyNDg0NS4uNjczOWMx
OWJlOSAxMDA2NDQNCj4+Pj4gLS0tIGEvYmxvY2suYw0KPj4+PiArKysgYi9ibG9jay5jDQo+Pj4+
IEBAIC0xMDA5LDggKzEwMDksMjAgQEAgc3RhdGljIHZvaWQgYmRydl9pbmhlcml0ZWRfb3B0aW9u
cyhpbnQgKmNoaWxkX2ZsYWdzLCBRRGljdCAqY2hpbGRfb3B0aW9ucywNCj4+Pj4gICAgICAgICAq
Y2hpbGRfZmxhZ3MgPSBmbGFnczsNCj4+Pj4gICAgIH0NCj4+Pj4NCj4+Pj4gK3N0YXRpYyBjb25z
dCBjaGFyICpiZHJ2X2NoaWxkX2dldF9uYW1lKEJkcnZDaGlsZCAqY2hpbGQpDQo+Pj4+ICt7DQo+
Pj4+ICsgICAgQmxvY2tEcml2ZXJTdGF0ZSAqcGFyZW50ID0gY2hpbGQtPm9wYXF1ZTsNCj4+Pj4g
Kw0KPj4+PiArICAgIGlmIChwYXJlbnQtPmRydiAmJiBwYXJlbnQtPmRydi0+aXNfZmlsdGVyKSB7
DQo+Pj4+ICsgICAgICAgIHJldHVybiBiZHJ2X2dldF9wYXJlbnRfbmFtZShwYXJlbnQpOw0KPj4+
PiArICAgIH0NCj4+Pj4gKw0KPj4+PiArICAgIHJldHVybiBOVUxMOw0KPj4+PiArfQ0KPj4+PiAr
DQo+Pj4NCj4+PiBXaHkgd291bGQgd2Ugc2tpcCBmaWx0ZXJzIGV4cGxpY2l0bHkgYWRkZWQgYnkg
dGhlIHVzZXI/DQo+Pj4NCj4+DQo+PiBXaHkgbm90PyBPdGhlcndpc2UgbWlncmF0aW9uIG9mIGJp
dG1hcHMgd2lsbCBub3Qgd29yazogd2UgbWF5IGhhdmUgZGlmZmVyZW50IHNldA0KPj4gb2YgZmls
dGVycyBvbiBzb3VyY2UgYW5kIGRlc3RpbmF0aW9uLCBhbmQgd2Ugc3RpbGwgc2hvdWxkIG1hcCBu
b2RlcyB3aXRoIGJpdG1hcHMNCj4+IGF1dG9tYXRpY2FsbHkuDQo+IA0KPiBXaHkgd291bGQgd2Ug
aGF2ZSBhIGRpZmZlcmVudCBzZXQgb2YgZXhwbGljaXRseSBhZGRlZCBmaWx0ZXJzIG9uIHNvdXJj
ZQ0KPiBhbmQgZGVzdGluYXRpb24gYW5kIGFsbG93IHRoZW0gdG8gYmUgYXV0b21hdGljYWxseSBj
aGFuZ2VkIGR1cmluZw0KPiBtaWdyYXRpb24/ICBTaG91bGRu4oCZdCB1c2VycyBvbmx5IGNoYW5n
ZSB0aGVtIHByZSBvciBwb3N0IG1pZ3JhdGlvbj8NCg0KSG0gSSBkaWRuJ3Qgc2F5IHRvIGF1dG9t
YXRpY2FsbHkgY2hhbmdlIGZpbHRlcnMuDQoNCkkgbWVhbnQsIHRoYXQgd2UgbXVzdCB1bmRlcnN0
YW5kIHRoZSBtYXBwaW5nIG9mIG5vZGVzIHdpdGggYml0bWFwczogaWYgd2UgaGF2ZSBzb3VyY2UN
Cm5vZGUgTiB3aXRoIGJpdG1hcHMsIGluIHdoaWNoIHRhcmdldCBub2RlIHRoZXNlIGJpdG1hcHMg
c2hvdWxkIGJlIGFmdGVyIG1pZ3JhdGlvbj8NCkFuZCB3ZSBoYXZlIHRvIHVuZGVyc3RhbmQgaXQg
d2l0aG91dCB1c2VyIGludGVyYWN0aW9uLg0KDQpTdGlsbCwgaWYgeW91IGRvbid0IGxpa2Ugc2tp
cHBpbmcgZXhwbGljaXQgZmlsdGVycywgSSdtIE9LIHdpdGggaW1wbGljaXQgb25seSwgaXQgd2ls
bA0KZml4IHRoZSBidWcgd2UgYXJlIHNheWluZyBhYm91dC4NCg0KQnV0IHdoeSB5b3UgZG9uJ3Qg
bGlrZSBjcmVhdGluZyBzb21lIGFkZGl0aW9uYWwgZXhwbGljaXQgZmlsdGVycyBvbiB0YXJnZXQg
KHByaW9yIHRvDQptaWdyYXRpb24gcHJvY2Vzcykgd2hpY2ggd2UgZGlkbid0IGhhdmUgb24gc291
cmNlPw0KDQo+IA0KPiBBbmQgeW91IGNhbiBhbHNvIGFkZCBiaXRtYXBzIG9uIGZpbHRlcnMsIG9m
IGNvdXJzZS4NCj4gDQo+PiBJIGxpa2UgSm9obidzIGlkZWEgb2YgZXhwbGljaXRseSBkZWZpbmVk
IG5vZGUgbWFwcGluZywgYnV0IG5vdyB3ZSBuZWVkIHNpbXBsZXIgZml4LA0KPj4gbm90IGludm9s
dmluZyBsaWJ2aXJ0IGNoYW5nZXMgaWYgcG9zc2libGUuDQo+Pg0KPj4gSG1tLCBvciB5b3UgbWVh
biB0aGF0IGJ5IHRoaXMgcGF0Y2ggSSB0b3VjaCBub3Qgb25seSBtaWdyYXRpb24gYnV0IGFsbCB1
c2VycyBvZg0KPj4gYmRydl9nZXRfZGV2aWNlX29yX25vZGVfbmFtZT8gVGhhbiBJIGNhbid0IHBy
ZWRpY3QgYWxsIHRoZSBjb25zZXF1ZW5jZXMuLi4NCj4gDQo+IEnigJltIGhpbnRpbmcgYXQgdGhl
IGZhY3QgdGhhdCBtYXliZSB3ZSBjYW5ub3QgZHJvcCB0aGUgY29uY2VwdCBvZg0KPiBpbXBsaWNp
dCBmaWx0ZXJzIHF1aXRlIGFzIGZhc3QgYXMgd2Ugd2FudGVkLg0KPiANCj4gTWF4DQo+IA0KDQoN
Ci0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

