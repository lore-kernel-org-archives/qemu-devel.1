Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6451C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 07:22:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0084222CC
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 07:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Z4vyuQ+x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0084222CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD1dM-0007dj-Pj
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 03:22:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43280)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iD1aw-0005np-Kj
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 03:20:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iD1av-00071U-Aj
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 03:20:14 -0400
Received: from mail-eopbgr30104.outbound.protection.outlook.com
 ([40.107.3.104]:54832 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iD1ar-0006yL-6j; Wed, 25 Sep 2019 03:20:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QMcaPIhjnYvpL/lhADh9iQLMfL40F5FuVvi3FvdyCTfitd/qTdHjbZ6C9B5sCJc1IOVOWYaKBrAg7e2GgARe2XLImGuzsfQKEBKmauHNJZVS19ahLHOD8J9POQJi38KXCn2gX4lvDiUkg6XPBFdDZ1UqR2IcLxycVT0wO+jiDU6Q232q8XKVAH54bb2a8Gxi0dD65JmaHoun2+2INhbz0RWfVxcaVyvOVDNVAQJxMUtQjjspXkI3ADAB7BtwcdVAZ8JunuGit5gu2NDee9txn5Ygz3yeHdggTva+9AZmekxycfVQIME97Y6XV4DgbHaUal5tZXNPvnrFhg1W6PZqCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=03kARDMmVtOqhTszX7xobLzrHaan+kjYlMLEIOtyDko=;
 b=l5mGlutDbIl4wVJey5/eKcBEKdsFUbhEc9Qs+pKNr5JVkPANE+iZUFdtYBxn0I0XtBoqxN0Og9md3wU4m+X/rlLRSODDj3VapR/uSIDzncMXaOz8P92n0ahssntKp2OQhOTGX+7DGONV5BHnM0HplhSw3BUvCmv3nZdA80e4ji3dRX5hm/kT2vmj/P6JyDkep8aY5jGnfs5WUPInEmjaUMgcUIX9myZoPkXC35VgO9/KekhyBFy4k2x7QRSZb2kouPnedhbLu90sMc1DGrGkahJp85lTnHNfIzXrOp5k15gr9ked4LTyspu8iaf4zUdQkeCYN0t+3j4oBn0kKTLVoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=03kARDMmVtOqhTszX7xobLzrHaan+kjYlMLEIOtyDko=;
 b=Z4vyuQ+x6vfHKB1VMH0akYP38Ji9mfxu6MqDlqUohlqnFrEO2LzTy9pQicY0CbOdien3rB6GgoP8DXpMXt1XEPx1QKCEgjd3AKosNg5OHoCuWsC4y8vcd5LBUJrKkskCF3c/ZpSWPp/XR1z3IvIQk0JmiegywzZUWXXI0tuMKMc=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5130.eurprd08.prod.outlook.com (10.255.18.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.26; Wed, 25 Sep 2019 07:20:06 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2284.023; Wed, 25 Sep 2019
 07:20:06 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH 1/1] dirty-bitmaps: remove deprecated autoload parameter
Thread-Topic: [PATCH 1/1] dirty-bitmaps: remove deprecated autoload parameter
Thread-Index: AQHVcywPBh38eAPT8keZrK2tIN61GKc7/POA
Date: Wed, 25 Sep 2019 07:20:06 +0000
Message-ID: <fe7c69d5-16b7-d834-d490-b630db387d76@virtuozzo.com>
References: <20190924230143.22551-1-jsnow@redhat.com>
 <20190924230143.22551-2-jsnow@redhat.com>
In-Reply-To: <20190924230143.22551-2-jsnow@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0202CA0040.eurprd02.prod.outlook.com
 (2603:10a6:3:e4::26) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190925102003544
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 976b077e-a25b-40f5-1f68-08d74188ca44
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5130; 
x-ms-traffictypediagnostic: DB8PR08MB5130:
x-microsoft-antispam-prvs: <DB8PR08MB5130688EABF747D7293DF0E7C1870@DB8PR08MB5130.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 01713B2841
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39850400004)(396003)(136003)(366004)(376002)(346002)(189003)(199004)(31696002)(6246003)(14454004)(2906002)(110136005)(316002)(54906003)(14444005)(6512007)(64756008)(66556008)(66476007)(66946007)(66446008)(256004)(6506007)(386003)(26005)(8936002)(4326008)(99286004)(102836004)(76176011)(476003)(478600001)(2616005)(7736002)(71200400001)(5660300002)(71190400001)(305945005)(6436002)(31686004)(11346002)(36756003)(81156014)(25786009)(2501003)(8676002)(6486002)(81166006)(52116002)(186003)(86362001)(486006)(446003)(66066001)(229853002)(6116002)(3846002)(14143004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5130;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 42IPi/I+b/h9zEI7N2c/zGSWWFq9CpVkw1kjA6wuVPsqs6dXZyLpebLqx/OjQO8WaMmwkbZXmcL00WK6uxJcFgBgNqJifyVlfGwHx/ZUbhYoCr9y4vjp5G47zlx0nEoexqhDqHhQM4UN7gvJGFx8Pm9766MYE+BUcWDgp2c8NizPEC++HnuilPligyOZccoV57ifWdL4C9IcgwJ6kgKp6IVdQk3tnyUCqyqOMC+KVT8kP4ZXGBdMxcrZEPffDaJvGrjJPkzrvJG7MR4qqTZtUkSRIhHPZRYt8kl6B4JmocQ2nLeDcIlC1XKOKJyT0nuVN1lNIiJ+WFsuH1ITIymktOw2VVdtqI93cgzDPOhJMYhuv4rL0O/RrP62qpAh6FdY2nboQAUWft19zwsqGlb92F6tCe6Bmaib4O25o0SCxRc=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <DAC0025FF9FA03438D50D0DF266D9C90@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 976b077e-a25b-40f5-1f68-08d74188ca44
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2019 07:20:06.3436 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GaJxTc23/RPCn4EA45+IRbmP1qdm8B0H8N6Oq5rprmZ0N3Wpt3hVAkgI9RZPbt2w9ey8J6VT+8F/VIGGzW4syJgX2tPfhGz4uIbeaGWU6t4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5130
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.3.104
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
Cc: Kevin Wolf <kwolf@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "libvir-list@redhat.com" <libvir-list@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjUuMDkuMjAxOSAyOjAxLCBKb2huIFNub3cgd3JvdGU6DQo+IFRoaXMgcGFyYW1ldGVyIGhhcyBi
ZWVuIGRlcHJlY2F0ZWQgc2luY2UgMi4xMi4wIGFuZCBpcyBlbGlnaWJsZSBmb3INCj4gcmVtb3Zh
bC4gUmVtb3ZlIHRoaXMgcGFyYW1ldGVyIGFzIGl0IGlzIGFjdHVhbGx5IGNvbXBsZXRlbHkgaWdu
b3JlZDsNCj4gbGV0J3Mgbm90IGdpdmUgZmFsc2UgaG9wZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IEpvaG4gU25vdyA8anNub3dAcmVkaGF0LmNvbT4NCj4gLS0tDQo+ICAgcWVtdS1kZXByZWNhdGVk
LnRleGkgfCAyMCArKysrKysrKysrKysrKystLS0tLQ0KPiAgIHFhcGkvYmxvY2stY29yZS5qc29u
IHwgIDYgKy0tLS0tDQo+ICAgYmxvY2tkZXYuYyAgICAgICAgICAgfCAgNiAtLS0tLS0NCj4gICAz
IGZpbGVzIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKyksIDE2IGRlbGV0aW9ucygtKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL3FlbXUtZGVwcmVjYXRlZC50ZXhpIGIvcWVtdS1kZXByZWNhdGVkLnRleGkN
Cj4gaW5kZXggMDEyNDVlMGIxYy4uZDYwMjQ2ZDVkNiAxMDA2NDQNCj4gLS0tIGEvcWVtdS1kZXBy
ZWNhdGVkLnRleGkNCj4gKysrIGIvcWVtdS1kZXByZWNhdGVkLnRleGkNCj4gQEAgLTE0OSwxMSAr
MTQ5LDYgQEAgUUVNVSA0LjEgaGFzIHRocmVlIG9wdGlvbnMsIHBsZWFzZSBtaWdyYXRlIHRvIG9u
ZSBvZiB0aGVzZSB0aHJlZToNCj4gICANCj4gICBAc2VjdGlvbiBRRU1VIE1hY2hpbmUgUHJvdG9j
b2wgKFFNUCkgY29tbWFuZHMNCj4gICANCj4gLUBzdWJzZWN0aW9uIGJsb2NrLWRpcnR5LWJpdG1h
cC1hZGQgImF1dG9sb2FkIiBwYXJhbWV0ZXIgKHNpbmNlIDIuMTIuMCkNCj4gLQ0KPiAtImF1dG9s
b2FkIiBwYXJhbWV0ZXIgaXMgbm93IGlnbm9yZWQuIEFsbCBiaXRtYXBzIGFyZSBhdXRvbWF0aWNh
bGx5IGxvYWRlZA0KPiAtZnJvbSBxY293MiBpbWFnZXMuDQo+IC0NCj4gICBAc3Vic2VjdGlvbiBx
dWVyeS1ibG9jayByZXN1bHQgZmllbGQgZGlydHktYml0bWFwc1tpXS5zdGF0dXMgKHNpbmNlIDQu
MCkNCj4gICANCj4gICBUaGUgYGBzdGF0dXMnJyBmaWVsZCBvZiB0aGUgYGBCbG9ja0RpcnR5SW5m
bycnIHN0cnVjdHVyZSwgcmV0dXJuZWQgYnkNCj4gQEAgLTM1NiwzICszNTEsMTggQEAgZXhpc3Rp
bmcgQ1BVIG1vZGVscy4gIE1hbmFnZW1lbnQgc29mdHdhcmUgdGhhdCBuZWVkcyBydW5uYWJpbGl0
eQ0KPiAgIGd1YXJhbnRlZXMgbXVzdCByZXNvbHZlIHRoZSBDUFUgbW9kZWwgYWxpYXNlcyB1c2lu
ZyB0ZQ0KPiAgIGBgYWxpYXMtb2YnJyBmaWVsZCByZXR1cm5lZCBieSB0aGUgYGBxdWVyeS1jcHUt
ZGVmaW5pdGlvbnMnJyBRTVANCj4gICBjb21tYW5kLg0KPiArDQo+ICsNCj4gK0Bub2RlIFJlY2Vu
dGx5IHJlbW92ZWQgZmVhdHVyZXMNCj4gK0BhcHBlbmRpeCBSZWNlbnRseSByZW1vdmVkIGZlYXR1
cmVzDQo+ICsNCj4gK1doYXQgZm9sbG93cyBpcyBhIHJlY29yZCBvZiByZWNlbnRseSByZW1vdmVk
LCBmb3JtZXJseSBkZXByZWNhdGVkDQo+ICtmZWF0dXJlcyB0aGF0IHNlcnZlcyBhcyBhIHJlY29y
ZCBmb3IgdXNlcnMgd2hvIGhhdmUgZW5jb3VudGVyZWQNCj4gK3Ryb3VibGUgYWZ0ZXIgYSByZWNl
bnQgdXBncmFkZS4NCj4gKw0KPiArQHNlY3Rpb24gUUVNVSBNYWNoaW5lIFByb3RvY29sIChRTVAp
IGNvbW1hbmRzDQo+ICsNCj4gK0BzdWJzZWN0aW9uIGJsb2NrLWRpcnR5LWJpdG1hcC1hZGQgImF1
dG9sb2FkIiBwYXJhbWV0ZXIgKHNpbmNlIDIuMTIuMCkNCg0KQWdyZWUgd2l0aCBFcmljIHRoYXQg
aXQgc2hvdWxkIGJlIDQuMiAtIGFzIHRoaXMgc2VjdGlvbiBpcyBhYm91dCByZW1vdmluZw0KDQo+
ICsNCj4gKyJhdXRvbG9hZCIgcGFyYW1ldGVyIGlzIG5vdyBpZ25vcmVkLiBBbGwgYml0bWFwcyBh
cmUgYXV0b21hdGljYWxseSBsb2FkZWQNCj4gK2Zyb20gcWNvdzIgaW1hZ2VzLg0KDQpNYXliZSwg
cmVwaHJhc2UgaXQgYXMgcy9pcyBub3cgaWdub3JlZC9pcyBub3cgcmVtb3ZlZCAoaWdub3JlZCBz
aW5jZSAyLjEyLjApLyAsDQpzbyB0aGF0IHRoaXMgcGFyYWdyYXBoIGRvbid0IG1pc2xlYWQgd2l0
aG91dCBhIGNvbnRleHQuDQoNClJldmlld2VkLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZz
a2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+DQoNCihZYXksIGRlcHJlY2F0aW9uIHdvcmtz
ISkNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

