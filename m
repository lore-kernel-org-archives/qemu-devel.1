Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E05C433EF
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 11:19:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F0102086D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 11:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="L/0VO+jz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F0102086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7HhR-0007np-8R
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 07:19:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37197)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i7HgX-0007Gz-9d
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 07:18:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i7HgV-0001av-7Y
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 07:18:16 -0400
Received: from mail-eopbgr70123.outbound.protection.outlook.com
 ([40.107.7.123]:1766 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1i7HgU-0001XQ-CS; Mon, 09 Sep 2019 07:18:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hO2egnB9nNJusi9itrT8W9m336Z4V5kJyPIdKUmyP79l4vWA6XTTM1det1kWIr1h/ChkP44rHMI2D5RY8ri04ho/uzV/xfddzv4tq3WiCknzKvE7JywTXd3M7LRjvCMXvYRwOTB/P82c6ad5W9ONHPnpp4Fb7LsOT3yM21NT0a4pesCimWYdME/FDHw668v6gqtc6Ac3Mk8JtSggp6LpA/uZg0qdio8ZWau0LQHuWZbtrB2ftkAFSv2I7u+cMe6oESWIIf79fYy35Zc1xczm+cLKlz4aExm5bJl6eT5J+5MXYMgAlk8XLJI4q+cf8cOuewFW5n3yCROAYAgfFpdbIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=efDd/MuUzd95NWx3kt92qtpBr8A5umW0k6Fe0zvpLIA=;
 b=jq8TbfL5VA0hEKANBiJIMNzXZnAkl3lSQjgFk4qlHbk/gWbPd8qP57irst7fDo6pX0YHzGXI3rIC5chfKIxD7AnBpSSP4milpMsaHnM2m50W2T0zUxVbfC6QVeKDBj4/UEP1/qrznPht/ux1Z9DvgQ2RFu58/uUcDqLuQ/yHOMPnkmoaH7V8dzCAjGJQquaqpBYbmNi8iZjaO/vV6CvDUTQTz+xMlIW+r+SphjQjb/aYhvRlSgyomDfpDppZ+NoMcGSEtuueEqvvmgxdYBGl0THRomLuGmSzaU7gWdqwJolz5ucWg+MmNa8o226Y4ZhXbhCYM3KwxytylSIUjnMaQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=efDd/MuUzd95NWx3kt92qtpBr8A5umW0k6Fe0zvpLIA=;
 b=L/0VO+jzfxt+AvZu2Z7TqP3WD2kCmi1Z5/NVkq8K7F7fIGIcMSTXP2RPWMesjciB+ZB2TobDdGRXRZMiZ8LOWKzEtwu7FSD7Sm13X3lIvPGspApiO57CPIKo/rtgECGgkquT9nOEGaTEUU2gPqVhlSJZO9exN48g1zbDmHl2TFQ=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4091.eurprd08.prod.outlook.com (20.179.8.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.15; Mon, 9 Sep 2019 11:18:10 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2241.018; Mon, 9 Sep 2019
 11:18:10 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>
Thread-Topic: qcow2 lock
Thread-Index: AQHVZvdKkVBqwFZhkECbBQ9d49IlGacjKf4AgAAIlwA=
Date: Mon, 9 Sep 2019 11:18:10 +0000
Message-ID: <fc65548f-c629-2b28-11aa-1d9fa60b545b@virtuozzo.com>
References: <135df452-397a-30bb-7518-2184fa5971aa@virtuozzo.com>
 <20190909104724.GD17606@localhost.localdomain>
In-Reply-To: <20190909104724.GD17606@localhost.localdomain>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR06CA0156.eurprd06.prod.outlook.com
 (2603:10a6:7:16::43) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190909141808347
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 284b82d6-ee9f-4222-ac07-08d7351765ce
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB4091; 
x-ms-traffictypediagnostic: DB8PR08MB4091:
x-microsoft-antispam-prvs: <DB8PR08MB4091F6D90B089757FC89B64CC1B70@DB8PR08MB4091.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:883;
x-forefront-prvs: 01559F388D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(396003)(376002)(366004)(346002)(39840400004)(52314003)(189003)(199004)(102836004)(6246003)(36756003)(54906003)(71200400001)(6916009)(25786009)(19627235002)(3846002)(256004)(66446008)(64756008)(66556008)(7736002)(14444005)(31686004)(6116002)(6486002)(229853002)(66946007)(14454004)(31696002)(7116003)(186003)(53936002)(8676002)(26005)(52116002)(2906002)(478600001)(305945005)(66476007)(6506007)(6436002)(6512007)(316002)(386003)(2616005)(476003)(81166006)(81156014)(11346002)(446003)(4326008)(8936002)(66066001)(99286004)(76176011)(486006)(5660300002)(86362001)(71190400001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4091;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vLAoavSmS25WO1GCZGgF0+bKDv157f7E3QGo+FKEICmdfCrw4hc/zSFjVLl3pjdOSeiNPc0WQj+B93w/iVLfLHe16kJTqiOfIxykRmPx1lEOU5jRQBGUNZSInPpSZwSCOhK3K8wVo48xgB8mQ+DEKna7uVZSvuiRrwbfltJCV8LA+zZWj0gqrhYpDKwMlAmJR88xipdJoeyQr48ZmdOERNDNCJH7up3hD3RYW1+6d63U8vI2WYGUKAPEZ2Y4z3RYwiUiQACIP6dwlUF+waAaEDyq515SMN2oGL+p/T9t5dFP4ndcEpwfvc+hopx+RwAVJ24/Aa//Fo2lIXftIbxue+GHZslc3V5ypCyOrYlMFOD59dV6ryldFWLe+mzhfi/B+YuGZFvivpUKBYnocg//aJV8tapkNWUE11D1WlvmWIE=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <C18661D00AEFE942A0357ACCFD586B35@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 284b82d6-ee9f-4222-ac07-08d7351765ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2019 11:18:10.6479 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WMN3uKol/CArEdhrtB4+AEQxepA2+hW6lT7I20hRQ1lcbHrNbcvbDaPXJ7HIOW0Aj5bCKKl6icdosj+/z8n24aZoHyLHKLi4FNROUTs49mE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4091
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.123
Subject: Re: [Qemu-devel] qcow2 lock
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
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDkuMDkuMjAxOSAxMzo0NywgS2V2aW4gV29sZiB3cm90ZToNCj4gQW0gMDkuMDkuMjAxOSB1bSAx
MjoxMyBoYXQgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSBnZXNjaHJpZWJlbjoNCj4+IEhp
IQ0KPj4NCj4+IEkgaGF2ZSBhIChtYXkgYmUgc3R1cGlkKSBxdWVzdGlvbjogd2hhdCBpcyBCRFJW
UWNvdzJTdGF0ZS5sb2NrIGZvciBhbmQgd2hlbiBzaG91bGQgaXQgYmUgbG9ja2VkPw0KPj4NCj4+
DQo+PiBJIGZhY2VkIFNJR1NFR1YgaGVyZToNCj4+DQo+PiAjMCAgcWNvdzJfcHJvY2Vzc19kaXNj
YXJkcyAoYnM9YnNAZW50cnk9MHg1NjRiOTNiYzgwMDAsIHJldD1yZXRAZW50cnk9MCkgYXQgYmxv
Y2svcWNvdzItcmVmY291bnQuYzo3MzcNCj4+ICMxICAweDAwMDA1NjRiOTBlOWYxNWYgaW4gcWNv
dzJfY2x1c3Rlcl9kaXNjYXJkIChicz1ic0BlbnRyeT0weDU2NGI5M2JjODAwMCwgb2Zmc2V0PTAs
IG9mZnNldEBlbnRyeT0zMDYyODkwNDk2LCBieXRlcz1ieXRlc0BlbnRyeT0xMzQyMTc3MjgsIHR5
cGU9dHlwZUBlbnRyeT1RQ09XMl9ESVNDQVJEX1JFUVVFU1QsDQo+PiAgICAgICBmdWxsX2Rpc2Nh
cmQ9ZnVsbF9kaXNjYXJkQGVudHJ5PWZhbHNlKSBhdCBibG9jay9xY293Mi1jbHVzdGVyLmM6MTg1
Mw0KPj4gIzIgIDB4MDAwMDU2NGI5MGU4ZjcyMCBpbiBxY293Ml9jb19wZGlzY2FyZCAoYnM9MHg1
NjRiOTNiYzgwMDAsIG9mZnNldD0zMDYyODkwNDk2LCBieXRlcz0xMzQyMTc3MjgpIGF0IGJsb2Nr
L3Fjb3cyLmM6Mzc0OQ0KPj4gIzMgIDB4MDAwMDU2NGI5MGVjNTY1ZCBpbiBiZHJ2X2NvX3BkaXNj
YXJkIChicz0weDU2NGI5M2JjODAwMCwgb2Zmc2V0PTMwNjI4OTA0OTYsIGJ5dGVzPTEzNDIxNzcy
OCkgYXQgYmxvY2svaW8uYzoyOTM5DQo+PiAjNCAgMHgwMDAwNTY0YjkwZWI1YzA0IGluIGJsa19h
aW9fcGRpc2NhcmRfZW50cnkgKG9wYXF1ZT0weDU2NGI5NGY5NjhjMCkgYXQgYmxvY2svYmxvY2st
YmFja2VuZC5jOjE1MjcNCj4+ICM1ICAweDAwMDA1NjRiOTBmNjgxZWEgaW4gY29yb3V0aW5lX3Ry
YW1wb2xpbmUgKGkwPTxvcHRpbWl6ZWQgb3V0PiwgaTE9PG9wdGltaXplZCBvdXQ+KSBhdCB1dGls
L2Nvcm91dGluZS11Y29udGV4dC5jOjExNg0KPj4NCj4+IFNJR1NFR1YgaXMgb24gUVRBSUxRX1JF
TU9WRSBpbiBxY293Ml9wcm9jZXNzX2Rpc2NhcmRzOg0KPj4gKGdkYikgbGlzdA0KPj4gNzMyICAg
ICB7DQo+PiA3MzMgICAgICAgICBCRFJWUWNvdzJTdGF0ZSAqcyA9IGJzLT5vcGFxdWU7DQo+PiA3
MzQgICAgICAgICBRY293MkRpc2NhcmRSZWdpb24gKmQsICpuZXh0Ow0KPj4gNzM1DQo+PiA3MzYg
ICAgICAgICBRVEFJTFFfRk9SRUFDSF9TQUZFKGQsICZzLT5kaXNjYXJkcywgbmV4dCwgbmV4dCkg
ew0KPj4gNzM3ICAgICAgICAgICAgIFFUQUlMUV9SRU1PVkUoJnMtPmRpc2NhcmRzLCBkLCBuZXh0
KTsNCj4+IDczOA0KPj4gNzM5ICAgICAgICAgICAgIC8qIERpc2NhcmQgaXMgb3B0aW9uYWwsIGln
bm9yZSB0aGUgcmV0dXJuIHZhbHVlICovDQo+PiA3NDAgICAgICAgICAgICAgaWYgKHJldCA+PSAw
KSB7DQo+PiA3NDEgICAgICAgICAgICAgICAgIGJkcnZfcGRpc2NhcmQoYnMtPmZpbGUtPmJzLCBk
LT5vZmZzZXQsIGQtPmJ5dGVzKTsNCj4+DQo+Pg0KPj4gKHlvdSBzZWUgYnMtPmZpbGUtPmJzLCB5
ZXMgaXQncyBvbGQgY29kZSBiYXNlZCBvbiAyLjEyLCBidXQgc3RpbGwsDQo+PiBJIG5lZWQgc29t
ZSBoZWxwIG9uIHRoZSBmb2xsb3dpbmcpDQo+Pg0KPj4gYW5kIHByb2JsZW0gaXMgdGhhdCBkIGlz
IGFscmVhZHkgZGVsZXRlZDoNCj4+IChnZGIpIHAgZC0+bmV4dA0KPj4gJDUwID0ge3RxZV9uZXh0
ID0gMHg1NjRiOTRiMGIxNDAsIHRxZV9wcmV2ID0gMHgwfQ0KPj4NCj4+IFN1Y2ggcHJvYmxlbXMg
bWF5IG9jY3VyIHdoZW4gdGhlcmUgaXMgYW4gaW50ZXJsZWF2aW5nIG9mIHN1Y2gNCj4+IHJlbW92
aW5nIGxvb3BzIHdpdGggb3RoZXIgdXNhZ2Ugb2YgdGhlIHF1ZXVlLiBBbmQgdGhpcyBpcyBwb3Nz
aWJsZSwNCj4+IGFzIHdlIGNhbGwgYmRydl9wZGlzY2FyZCBpbnNpZGUgdGhlIGxvb3Agd2hpY2gg
bWF5IHlpZWxkLg0KPj4NCj4+IGdvIHRvIGZyYW1lICM1LCBhbmQgcHJpbnQgY28tPmNhbGxlciBz
dGFjazoNCj4+DQo+PiAjMCAgMHgwMDAwNTY0YjkwZjY4MTgwIGluIHFlbXVfY29yb3V0aW5lX3N3
aXRjaCAoKQ0KPj4gIzEgIDB4MDAwMDU2NGI5MGY2NmM4NCBpbiBxZW11X2Fpb19jb3JvdXRpbmVf
ZW50ZXIgKCkNCj4+ICMyICAweDAwMDA1NjRiOTBmNTA3NjQgaW4gYWlvX2NvX2VudGVyICgpDQo+
PiAjMyAgMHgwMDAwNTY0YjkwZjUwZWE5IGluIHRocmVhZF9wb29sX2NvbXBsZXRpb25fYmggKCkN
Cj4+ICM0ICAweDAwMDA1NjRiOTBmNTAwZDEgaW4gYWlvX2JoX3BvbGwgKCkNCj4+ICM1ICAweDAw
MDA1NjRiOTBmNTM2MGIgaW4gYWlvX3BvbGwgKCkNCj4+ICM2ICAweDAwMDA1NjRiOTBlYzU5Y2Qg
aW4gYmRydl9wZGlzY2FyZCAoKQ0KPj4gIzcgIDB4MDAwMDU2NGI5MGU5NmEzNiBpbiBxY293Ml9w
cm9jZXNzX2Rpc2NhcmRzICgpDQo+PiAjOCAgMHgwMDAwNTY0YjkwZTk3Nzg1IGluIHVwZGF0ZV9y
ZWZjb3VudCAoKQ0KPj4gIzkgIDB4MDAwMDU2NGI5MGU5NmJkZCBpbiBxY293Ml9mcmVlX2NsdXN0
ZXJzICgpDQo+PiAjMTAgMHgwMDAwNTY0YjkwZWEyOWM3IGluIHVwZGF0ZV9leHRfaGVhZGVyX2Fu
ZF9kaXIgKCkNCj4+ICMxMSAweDAwMDA1NjRiOTBlYTNhMTQgaW4gcWNvdzJfcmVtb3ZlX3BlcnNp
c3RlbnRfZGlydHlfYml0bWFwICgpDQo+PiAjMTIgMHgwMDAwNTY0YjkwY2U3YmNlIGluIHFtcF9i
bG9ja19kaXJ0eV9iaXRtYXBfcmVtb3ZlICgpDQo+PiAjMTMgMHgwMDAwNTY0YjkwY2Y1MzkwIGlu
IHFtcF9tYXJzaGFsX2Jsb2NrX2RpcnR5X2JpdG1hcF9yZW1vdmUgKCkNCj4+ICMxNCAweDAwMDA1
NjRiOTBmNDYwODAgaW4gcW1wX2Rpc3BhdGNoICgpDQo+PiAjMTUgMHgwMDAwNTY0YjkwYmVkYzc0
IGluIG1vbml0b3JfcW1wX2Rpc3BhdGNoX29uZSAoKQ0KPj4gIzE2IDB4MDAwMDU2NGI5MGJlZTA0
YSBpbiBtb25pdG9yX3FtcF9iaF9kaXNwYXRjaGVyICgpDQo+PiAjMTcgMHgwMDAwNTY0YjkwZjUw
MGQxIGluIGFpb19iaF9wb2xsICgpDQo+PiAjMTggMHgwMDAwNTY0YjkwZjUzNDMwIGluIGFpb19k
aXNwYXRjaCAoKQ0KPj4gIzE5IDB4MDAwMDU2NGI5MGY0ZmZhZSBpbiBhaW9fY3R4X2Rpc3BhdGNo
ICgpDQo+PiAjMjAgMHgwMDAwN2YwYThlM2U5MDQ5IGluIGdfbWFpbl9jb250ZXh0X2Rpc3BhdGNo
ICgpIGZyb20gL2xpYjY0L2xpYmdsaWItMi4wLnNvLjANCj4+ICMyMSAweDAwMDA1NjRiOTBmNTI3
MjcgaW4gbWFpbl9sb29wX3dhaXQgKCkNCj4+ICMyMiAweDAwMDA1NjRiOTBiYTBjMDcgaW4gbWFp
biAoKQ0KPj4NCj4+DQo+PiBBbmQgdGhpcyAoYXQgbGVhc3QgcGFydGx5KSBjb25maXJtcyBteSBn
dWVzcy4NCj4+DQo+PiBTbywgbXkgYWN0dWFsIHF1ZXN0aW9uIGlzLCB3aGF0IHNob3VsZCBiZSBm
aXhlZCBoZXJlOg0KPj4NCj4+IDEuIHlpZWxkaW5nIGluIHFjb3cyX3Byb2Nlc3NfZGlzY2FyZHMs
IGxpa2UgdGhpczoNCj4+DQo+PiAtLS0gYS9ibG9jay9xY293Mi1yZWZjb3VudC5jDQo+PiArKysg
Yi9ibG9jay9xY293Mi1yZWZjb3VudC5jDQo+PiBAQCAtNzMyLDkgKzczMiwxMyBAQCB2b2lkIHFj
b3cyX3Byb2Nlc3NfZGlzY2FyZHMoQmxvY2tEcml2ZXJTdGF0ZSAqYnMsIGludCByZXQpDQo+PiAg
ICB7DQo+PiAgICAgICAgQkRSVlFjb3cyU3RhdGUgKnMgPSBicy0+b3BhcXVlOw0KPj4gICAgICAg
IFFjb3cyRGlzY2FyZFJlZ2lvbiAqZCwgKm5leHQ7DQo+PiArICAgIFFUQUlMUV9IRUFEICgsIFFj
b3cyRGlzY2FyZFJlZ2lvbikgZGlzY2FyZHM7DQo+Pg0KPj4gLSAgICBRVEFJTFFfRk9SRUFDSF9T
QUZFKGQsICZzLT5kaXNjYXJkcywgbmV4dCwgbmV4dCkgew0KPj4gLSAgICAgICAgUVRBSUxRX1JF
TU9WRSgmcy0+ZGlzY2FyZHMsIGQsIG5leHQpOw0KPj4gKyAgICBkaXNjYXJkcyA9IHMtPmRpc2Nh
cmRzOw0KPj4gKyAgICBRVEFJTFFfSU5JVCgmcy0+ZGlzY2FyZHMpOw0KPj4gKw0KPj4gKyAgICBR
VEFJTFFfRk9SRUFDSF9TQUZFKGQsICZkaXNjYXJkcywgbmV4dCwgbmV4dCkgew0KPj4gKyAgICAg
ICAgUVRBSUxRX1JFTU9WRSgmZGlzY2FyZHMsIGQsIG5leHQpOw0KPj4NCj4+ICAgICAgICAgICAg
LyogRGlzY2FyZCBpcyBvcHRpb25hbCwgaWdub3JlIHRoZSByZXR1cm4gdmFsdWUgKi8NCj4+ICAg
ICAgICAgICAgaWYgKHJldCA+PSAwKSB7DQo+IA0KPiBJIHRoaW5rIHRoaXMgaXMgbm90IGVub3Vn
aC4NCj4gDQo+IElmIHlvdSBkb24ndCBob2xkIHMtPmxvY2sgaGVyZSwgY29uY3VycmVudCByZXF1
ZXN0cyBjb3VsZCAocmUtKWFsbG9jYXRlDQo+IHRoZSBjbHVzdGVycyB0byBiZSBkaXNjYXJkZWQg
YW5kIHRoZW4geW91J2QgZGlzY2FyZCBuZXcgZGF0YSBpbnN0ZWFkIG9mDQo+IHRoZSBvbGQgb25l
Lg0KDQpJIGNhbWUgdG8gdGhlIHNhbWUgdGhvdWdodC4NCg0KPiANCj4gU28gSSBiZWxpZXZlIHRo
YXQgcWNvdzJfcHJvY2Vzc19kaXNjYXJkcygpIG11c3QgYWx3YXlzIGJlIGNhbGxlZCBiZWZvcmUN
Cj4gdGhlIGltYWdlIGNhbiBiZSB1bmxvY2tlZCBhZnRlciBhZGRpbmcgc29tZXRoaW5nIHRvIHRo
ZSBkaXNjYXJkIHF1ZXVlLg0KPiANCj4+IG9yDQo+PiAyLiBjYWxsaW5nIHFjb3cyX3JlbW92ZV9w
ZXJzaXN0ZW50X2RpcnR5X2JpdG1hcCB3aXRob3V0IHRha2luZyBsb2NrLCBsaWtlIHRoaXM6DQo+
Pg0KPj4gLS0tIGEvYmxvY2svcWNvdzItYml0bWFwLmMNCj4+ICsrKyBiL2Jsb2NrL3Fjb3cyLWJp
dG1hcC5jDQo+PiBAQCAtMTM1OSw4ICsxMzU5LDggQEAgdm9pZCBxY293Ml9yZW1vdmVfcGVyc2lz
dGVudF9kaXJ0eV9iaXRtYXAoQmxvY2tEcml2ZXJTdGF0ZSAqYnMsDQo+PiAgICB7DQo+PiAgICAg
ICAgaW50IHJldDsNCj4+ICAgICAgICBCRFJWUWNvdzJTdGF0ZSAqcyA9IGJzLT5vcGFxdWU7DQo+
PiAtICAgIFFjb3cyQml0bWFwICpibTsNCj4+IC0gICAgUWNvdzJCaXRtYXBMaXN0ICpibV9saXN0
Ow0KPj4gKyAgICBRY293MkJpdG1hcCAqYm0gPSBOVUxMOw0KPj4gKyAgICBRY293MkJpdG1hcExp
c3QgKmJtX2xpc3QgPSBOVUxMOw0KPj4NCj4+ICAgICAgICBpZiAocy0+bmJfYml0bWFwcyA9PSAw
KSB7DQo+PiAgICAgICAgICAgIC8qIEFic2VuY2Ugb2YgdGhlIGJpdG1hcCBpcyBub3QgYW4gZXJy
b3I6IHNlZSBleHBsYW5hdGlvbiBhYm92ZQ0KPj4gQEAgLTEzNjgsMTUgKzEzNjgsMTcgQEAgdm9p
ZCBxY293Ml9yZW1vdmVfcGVyc2lzdGVudF9kaXJ0eV9iaXRtYXAoQmxvY2tEcml2ZXJTdGF0ZSAq
YnMsDQo+PiAgICAgICAgICAgIHJldHVybjsNCj4+ICAgICAgICB9DQo+Pg0KPj4gKyAgICBxZW11
X2NvX211dGV4X2xvY2soJnMtPmxvY2spOw0KPj4gKw0KPj4gICAgICAgIGJtX2xpc3QgPSBiaXRt
YXBfbGlzdF9sb2FkKGJzLCBzLT5iaXRtYXBfZGlyZWN0b3J5X29mZnNldCwNCj4+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBzLT5iaXRtYXBfZGlyZWN0b3J5X3NpemUsIGVycnAp
Ow0KPj4gICAgICAgIGlmIChibV9saXN0ID09IE5VTEwpIHsNCj4+IC0gICAgICAgIHJldHVybjsN
Cj4+ICsgICAgICAgIGdvdG8gb3V0Ow0KPj4gICAgICAgIH0NCj4+DQo+PiAgICAgICAgYm0gPSBm
aW5kX2JpdG1hcF9ieV9uYW1lKGJtX2xpc3QsIG5hbWUpOw0KPj4gICAgICAgIGlmIChibSA9PSBO
VUxMKSB7DQo+PiAtICAgICAgICBnb3RvIGZhaWw7DQo+PiArICAgICAgICBnb3RvIG91dDsNCj4+
ICAgICAgICB9DQo+Pg0KPj4gICAgICAgIFFTSU1QTEVRX1JFTU9WRShibV9saXN0LCBibSwgUWNv
dzJCaXRtYXAsIGVudHJ5KTsNCj4+IEBAIC0xMzg0LDEyICsxMzg2LDE0IEBAIHZvaWQgcWNvdzJf
cmVtb3ZlX3BlcnNpc3RlbnRfZGlydHlfYml0bWFwKEJsb2NrRHJpdmVyU3RhdGUgKmJzLA0KPj4g
ICAgICAgIHJldCA9IHVwZGF0ZV9leHRfaGVhZGVyX2FuZF9kaXIoYnMsIGJtX2xpc3QpOw0KPj4g
ICAgICAgIGlmIChyZXQgPCAwKSB7DQo+PiAgICAgICAgICAgIGVycm9yX3NldGdfZXJybm8oZXJy
cCwgLXJldCwgIkZhaWxlZCB0byB1cGRhdGUgYml0bWFwIGV4dGVuc2lvbiIpOw0KPj4gLSAgICAg
ICAgZ290byBmYWlsOw0KPj4gKyAgICAgICAgZ290byBvdXQ7DQo+PiAgICAgICAgfQ0KPj4NCj4+
ICAgICAgICBmcmVlX2JpdG1hcF9jbHVzdGVycyhicywgJmJtLT50YWJsZSk7DQo+Pg0KPj4gLWZh
aWw6DQo+PiArb3V0Og0KPj4gKyAgICBxZW11X2NvX211dGV4X3VubG9jaygmcy0+bG9jayk7DQo+
PiArDQo+PiAgICAgICAgYml0bWFwX2ZyZWUoYm0pOw0KPj4gICAgICAgIGJpdG1hcF9saXN0X2Zy
ZWUoYm1fbGlzdCk7DQo+PiAgICB9DQo+Pg0KPj4gQW5kIGluIHRoaXMgY2FzZSwgSSdtIGFmcmFp
ZCB0aGF0IGxvY2tpbmcgaXMgbWlzc2VkIGluIHNvbWUgb3RoZXINCj4+IGJpdG1hcCByZWxhdGVk
IHFjb3cyIGNvZGVzIDooDQo+IA0KPiBUaGVuIHdlIHNob3VsZCBwcm9iYWJseSBhZGQgbG9ja2lu
ZyB0byBhbGwgb2YgaXQuIEkgZG9uJ3Qga25vdyBlbm91Z2gNCj4gYWJvdXQgdGhlIGJpdG1hcCBj
b2RlIHRvIHRlbGwgd2hldGhlciBpdCdzIHRoZSBmdWxsIHNvbHV0aW9uLCBhbmQgbWF5YmUNCj4g
bm90IGFsbCBvZiB0aGUgY29kZSBhY3R1YWxseSBuZWVkcyBpdCwgYnV0IHRoZSBiaXRtYXAgbWFu
YWdlbWVudA0KPiBmdW5jdGlvbnMgYXJlIGEgc2xvdyBwYXRoIGFueXdheSwgc28ganVzdCBsb2Nr
aW5nIHMtPmxvY2sgaXMgY2VydGFpbmx5IGENCj4gZ29vZCBpZGVhLg0KDQpPSywgSSdsbCBtYWtl
IGEgcGF0Y2gNCg0KPiANCj4+IG9yDQo+PiAzLiBKdXN0IGJhY2twb3J0IGZyb20gdXBzdHJlYW0g
Sm9obidzIGZpeCAwYTZjODZkMDI0YzUyYiwgd2hpY2gNCj4+IGFjcXVpcmVzIGFpbyBjb250ZXh0
IGFyb3VuZCBiZHJ2X3JlbW92ZV9wZXJzaXN0ZW50X2RpcnR5X2JpdG1hcCBjYWxsPw0KPj4gSXMg
aXQgZW5vdWdoLCBvciB3ZSBzdGlsbCBuZWVkIGxvY2tpbmcgaW5zaWRlIHFjb3cyPw0KPiANCj4g
SXQgcHJvdGVjdHMgb25seSBhZ2FpbiBvdGhlciB0aHJlYWRzIGFjY2Vzc2luZyB0aGUgc2FtZSBk
YXRhIHN0cnVjdHVyZXMNCj4gY29uY3VycmVudGx5LCBidXQgd2hlbiB5b3UgeWllbGQsIGJvdGgg
dGhlIEFpb0NvbnRleHQgbG9jayBpcyBkcm9wcGVkDQo+IGFuZCB0aGUgc2FtZSB0aHJlYWQgY2Fu
IHN0YXJ0IGEgY29uY3VycmVudCBvcGVyYXRpb24sIHNvIHRoaXMgaXMgbm90DQo+IGVub3VnaC4N
Cj4gDQo+IEtldmluDQo+IA0KDQpUaGFua3MgYSBsb3QgZm9yIHF1aWNrIHJlc3BvbnNlIQ0KDQot
LSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

