Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,WEIRD_QUOTING autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7574CC352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 09:05:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CFC721783
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 09:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="I8QYJIx4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CFC721783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFE5i-00033w-KO
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 05:05:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59317)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iFDyb-00057S-8t
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 04:57:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iFDyY-00042U-VC
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 04:57:44 -0400
Received: from mail-eopbgr10099.outbound.protection.outlook.com
 ([40.107.1.99]:52207 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iFDyX-00040P-9a; Tue, 01 Oct 2019 04:57:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EyTrSsDsVuMFWxRNPmH7LpdHMZhuvLE1VZUonDC/xIMqa4O6OvpzjcHef0L8YMdd233aMdrUjNLVnbkER8fLOKQt1gMwtNnXPzAmuxQQ2vi8WIK/zeMK7JqSOtZSxkr2QE+sDprurKdq0nbGz3aZLmiSgWkyn8yA9oGOuTSpau+CgkEtkjWc08pEBt3qGY6B62AmiScO2PBEiOpTMQsiLpLmkAk36OVuI4byOUlU+HHoPo6VD6yr5icr2HAvIebbaVhr6WHbTGsqgQ9KWjNjODzmEazTZ4+BzUoEPOVV0t83X0qYZNi9K01fuHtFRrlXL+dVLIftdHZ3iW6LL4uY8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fG9Qo/EXp6zVeO16MquG9kT/wGGjBqg/ZjR2Y/rxOyQ=;
 b=D+6DnFBzq4Qo3wmImDDgLplfJoslQ66rR0+9AK7VwF2lu+3zu6mXJ7V2fE9iLuYBhxLQWhDCmEOXbHvOJDOtPLjWI/mDIMAQjZ8amQJoO/E8EWqkh0BtmLE6VF9Upvks5c07sx0j5hiCIn9N8rvIoTYifmS0lZiAIlWsOX6BO5vhEWAE1vbmx5DuTPAsEa8gPaAa+EhedTymsPcAXT5ABMq+eOHgS0vY0JjhdBbf0kkJJ1MUt5uOuJloYfmrdj5O/gJxT3+QlMnyValG/HJNwkIciQPehe2tM2ZNoK556KVV8S9lI/qP6n7jTI/fRpui0Rw16GsuldmedEtlNqrtAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fG9Qo/EXp6zVeO16MquG9kT/wGGjBqg/ZjR2Y/rxOyQ=;
 b=I8QYJIx4UmhJNNSUqRYNjKD97FBd64GbzMI11fabetDm8g3PWq7lXh53I885h4y8v152NtmzqBRFF4dv7p9IqzxFHqCmRxPlKcvKiwyFjVeJWAfJwopj1VeMp3YKjg8tlub8bfXAiszPNfwJtNaI8oUnCl5tTT1f4znz66vCFjg=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5276.eurprd08.prod.outlook.com (20.179.15.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Tue, 1 Oct 2019 08:57:37 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f%2]) with mapi id 15.20.2305.017; Tue, 1 Oct 2019
 08:57:37 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: bitmap migration bug with -drive while block mirror runs
Thread-Topic: bitmap migration bug with -drive while block mirror runs
Thread-Index: AQHVd+yDiWNDoVbdB0u/++2NVEJq8qdFfK+A
Date: Tue, 1 Oct 2019 08:57:37 +0000
Message-ID: <f84745dc-68df-c10a-a91b-a28498e54870@virtuozzo.com>
References: <315cff78-dcdb-a3ce-2742-da3cc9f0ca97@redhat.com>
In-Reply-To: <315cff78-dcdb-a3ce-2742-da3cc9f0ca97@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0701CA0077.eurprd07.prod.outlook.com
 (2603:10a6:3:64::21) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191001115735326
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b5a2cad3-e827-40db-7b65-08d7464d6874
x-ms-traffictypediagnostic: DB8PR08MB5276:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DB8PR08MB5276E80FAE491E1916139619C19D0@DB8PR08MB5276.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0177904E6B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(396003)(136003)(366004)(346002)(39850400004)(189003)(199004)(6916009)(6506007)(305945005)(186003)(66556008)(66476007)(11346002)(446003)(54906003)(316002)(6486002)(64756008)(66446008)(386003)(229853002)(66066001)(25786009)(6436002)(102836004)(26005)(476003)(5024004)(5660300002)(2616005)(256004)(71190400001)(7736002)(71200400001)(486006)(66946007)(36756003)(6246003)(31686004)(31696002)(6512007)(86362001)(4326008)(6306002)(14454004)(8936002)(81166006)(81156014)(3846002)(6116002)(8676002)(99286004)(2906002)(478600001)(76176011)(966005)(52116002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5276;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zSl7vcRbRALIRtXSXtMXhqNEY6xGHXfbWqUwO1iI2rsEh3s7FCzxKTa3WIfFr7soO4xZeOBKhoGBu3Mslcjl7hdZ6TDCvIXWlceEF+WtVyhVLoRDrEIJv45crIFuEgo0UFxBA9Wz8GBsOnQxMTqooZRqLJOsVGeg2Xg9hzK5V/HkfykQeoSuhWu9T1hz/SQiVEQGfYLytc7FI2qbDXQvd557HAG921xAnp23fGNzDmZGTCWi2Qk5amJI589cAShz6boTP4dD7xSmfs2PYvgzIzHElyjMrukBqaB5xuXa63z++TACxkdFSuX0JOvXmxfoyqLDBJgBO1mKN9/5yXLIA7OhUYpz8nMOtAp8gaL3Hzf9pT1y0zsQXqiNONF9/0ZReLPidvTkTET4fFW6TJNKFW26DM1U9u5b2mbV6SIziynhgUEu/T5dGq/Wt+ImrKCqbSESC839PB5XewJi8Ij/2Q==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <CF6AB5D066D3954ABD3ABDCFF7380CAE@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5a2cad3-e827-40db-7b65-08d7464d6874
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2019 08:57:37.6475 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wyBHpqPxnMBetq8Vushf4q12ohFYbCW55Ky/Bq4Bw65w+73DfC78VItJnnFFU1+JytTi1WXCt7JdKoC2XCNLrevCPXepYLD9Y0DETEQmTFw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5276
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.99
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
 Qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDEuMTAuMjAxOSAzOjA5LCBKb2huIFNub3cgd3JvdGU6DQo+IEhpIGZvbGtzLCBJIGlkZW50aWZp
ZWQgYSBwcm9ibGVtIHdpdGggdGhlIG1pZ3JhdGlvbiBjb2RlIHRoYXQgUmVkIEhhdCBRRQ0KPiBm
b3VuZCBhbmQgdGhvdWdodCB5b3UnZCBsaWtlIHRvIHNlZSBpdDoNCj4gDQo+IGh0dHBzOi8vYnVn
emlsbGEucmVkaGF0LmNvbS9zaG93X2J1Zy5jZ2k/aWQ9MTY1MjQyNCNjMjANCj4gDQo+IFZlcnks
IHZlcnkgYnJpZWZseTogZHJpdmUtbWlycm9yIGluc2VydHMgYSBmaWx0ZXIgbm9kZSB0aGF0IGNo
YW5nZXMgd2hhdA0KPiBiZHJ2X2dldF9kZXZpY2Vfb3Jfbm9kZV9uYW1lKCkgcmV0dXJucywgd2hp
Y2ggY2F1c2VzIGEgbWlncmF0aW9uIHByb2JsZW0uDQo+IA0KPiANCj4gSWdub3JhbnQgcXVlc3Rp
b24gIzE6IENhbiB3ZSBtdWx0aS1wYXJlbnQgdGhlIGZpbHRlciBub2RlIGFuZA0KPiBzb3VyY2Ut
bm9kZT8gSXQgbG9va3MgbGlrZSBhdCB0aGUgbW9tZW50IGJvdGggY29uc2lkZXIgdGhlaXIgb25s
eSBwYXJlbnQNCj4gdG8gYmUgdGhlIGJsb2NrLWpvYiBhbmQgZG9uJ3QgaGF2ZSBhIGxpbmsgYmFj
ayB0byB0aGVpciBwYXJlbnRzIG90aGVyd2lzZS4NCj4gDQo+IA0KPiBPdGhlcndpc2U6IEkgaGF2
ZSBhIGxvdCBvZiBjbG91ZHkgaWRlYXMgb24gaG93IHRvIHNvbHZlIHRoaXMsIGJ1dA0KPiB1bHRp
bWF0ZWx5IHdoYXQgd2Ugd2FudCBpcyB0byBiZSBhYmxlIHRvIGZpbmQgdGhlICJhZGRyZXNzYWJs
ZSIgbmFtZSBmb3INCj4gdGhlIG5vZGUgdGhlIGJpdG1hcCBpcyBhdHRhY2hlZCB0bywgd2hpY2gg
d291bGQgYmUgdGhlIG5hbWUgb2YgdGhlIGZpcnN0DQo+IGFuY2VzdG9yIG5vZGUgdGhhdCBpc24n
dCBhIGZpbHRlci4gKE9SLCB0aGUgbmFtZSBvZiB0aGUgYmxvY2stYmFja2VuZA0KPiBhYm92ZSB0
aGF0IG5vZGUuKQ0KDQoNCkJldHRlciB3b3VsZCBiZSB0byBtaWdyYXRlIGJ5IG5vZGUtbmFtZSBv
bmx5Li4gQnV0IGFtIEkgcmlnaHQgdGhhdCBub2RlLW5hbWVzDQphcmUgZGlmZmVyZW50IG9uIHNv
dXJjZSBhbmQgZGVzdGluYXRpb24/IE9yIHRoaXMgc2l0dWF0aW9uIGNoYW5nZWQ/DQoNCj4gDQo+
IEEgc2ltcGxlIHdheSB0byBkbyB0aGlzIG1pZ2h0IGJlIGEgImNoaWxkX3VuZmlsdGVyZWQiIEJk
cnZDaGlsZCByb2xlDQo+IHRoYXQgc2ltcGx5IGJ5cGFzc2VzIHRoZSBmaWx0ZXIgdGhhdCB3YXMg
aW5zZXJ0ZWQgYW5kIHNlcnZlcyBubyByZWFsDQo+IHB1cnBvc2Ugb3RoZXIgdGhhbiB0byBhbGxv
dyB0aGUgY2hpbGQgdG8gaGF2ZSBhIHBhcmVudCBsaW5rIGFuZCBmaW5kIHdobw0KPiBpdCdzICIi
InJlYWwiIiIgcGFyZW50IGlzLg0KPiANCj4gQmVjYXVzZSBvZiBmbHVzaGluZywgcmVvcGVuLCBz
eW5jLCBkcmFpbiAmYyAmYyAmYyBJJ20gbm90IHN1cmUgaG93DQo+IGZlYXNpYmxlIHRoaXMgcXVp
Y2sgaWRlYSBtaWdodCBiZSwgdGhvdWdoLg0KPiANCj4gDQo+IC0gQ29yb2xsYXJ5IGZpeCAjMTog
Y2FsbCBlcnJvcl9zZXRnIGlmIHRoZSBiaXRtYXAgbm9kZSBuYW1lIHRoYXQncyBhYm91dA0KPiB0
byBnbyBvdmVyIHRoZSB3aXJlIGlzIGFuIGF1dG9nZW5lcmF0ZWQgbm9kZTogdGhpcyBpcyBuZXZl
ciBjb3JyZWN0IQ0KPiANCj4gKFdoeSBub3Q/IGJlY2F1c2UgdGhlIHRhcmdldCBpcyBpbmNhcGFi
bGUgb2YgbWF0Y2hpbmcgdGhlIG5vZGUtbmFtZQ0KPiBiZWNhdXNlIHRoZXkgYXJlIHJhbmRvbWx5
IGdlbmVyYXRlZCBBTkQgeW91IGNhbm5vdCBzcGVjaWZ5IG5vZGUtbmFtZXMNCj4gd2l0aCAjIHBy
ZWZpeGVzIGFzIHRoZXkgYXJlIGVzcGVjaWFsbHkgcmVzZXJ2ZWQhDQo+IA0KPiAoVGhpcyByYWlz
ZXMgYSByZWxhdGVkIHByb2JsZW06IGlmIHlvdSBleHBsaWNpdGx5IGFkZCBiaXRtYXBzIHRvIG5v
ZGVzDQo+IHdpdGggYXV0b2dlbmVyYXRlZCBuYW1lcywgeW91IHdpbGwgYmUgdW5hYmxlIHRvIG1p
Z3JhdGUgdGhlbS4pKQ0KPiANCg0KSW4gb3RoZXIgd29yZHMsIHdlIG5lZWQgYSB3ZWxsIGRlZmlu
ZWQgd2F5IHRvIG1hdGNoIG5vZGVzIG9uIHNvdXJjZSBhbmQgZGVzdGluYXRpb24sDQprZWVwaW5n
IGluIG1pbmQgZmlsdGVycywgdG8gbWlncmF0ZSBiaXRtYXBzIGNvcnJlY3RseS4NCg0KSG0sIGRp
ZCB5b3UgdGhvdWdodCBhYm91dCBiaXRtYXBzIGluIGZpbHRlcnM/IEl0J3Mgbm90IGEgcHJvYmxl
bSB0byBjcmVhdGUgYml0bWFwIGluDQptaXJyb3ItdG9wIGZpbHRlciBkdXJpbmcgbWlycm9yIGpv
YjopDQoNCk9yIHdoYXQgYWJvdXQgYml0bWFwcyBpbiBRdW9ydW0gY2hpbGRyZW4/IE9yIHdoYXQg
YWJvdXQgYml0bWFwIGluIHFjb3cyIGZpbGUgY2hpbGQgYnM/DQoNCklmIG5vZGUtbmFtZXMgYXJl
IGRpZmZlcmVudCBvbiBzb3VyY2UgYW5kIGRlc3RpbmF0aW9uLCB3aGF0IGlzIHRoZSBzYW1lPyBU
b3AgYmxrIG5hbWUNCmFuZCBiZHJ2LWNoaWxkcmVuIG5hbWVzIChJIHJlY2VudGx5IHNhdyBNYXgn
cyBpZGVhIHRvIGNoZWNrIG5vZGUgInBhdGgiIGluIGlvdGVzdCkuDQoNClNvLCBhY3R1YWxseSBu
b2RlIGlzIG1pZ3JhdGlvbi1hZGRyZXNzYWJsZSwgaWYgcGF0aCA8YmxrLW5hbWU+L3Jvb3RbL2No
aWxkLW5hbWVdIHRvIHRoZQ0KZGVmaW5lcyB0aGlzIG5vZGUgZGlyZWN0bHkgKHdlIG11c3Qgbm90
IGhhdmUgY2hpbGRyZW4gd2l0aCBzYW1lIG5hbWUgZm9yIHNvbWUgbm9kZSBpbg0KdGhlIHBhdGgp
Lg0KDQpBbmQgSSB0aGluayBpdCdzIGEgY29ycmVjdCB3YXkgdG8gZGVmaW5lIG5vZGUgaW4gbWln
cmF0aW9uIHN0cmVhbSAtIGJ5IHBhdGguDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1p
cg0K

