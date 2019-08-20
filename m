Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7869EC3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 11:11:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 432192070B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 11:11:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ctfmtING"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 432192070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i022h-0008Ve-C1
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 07:11:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51996)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1i021z-00087C-UJ
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 07:10:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1i021y-0005jJ-4o
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 07:10:27 -0400
Received: from mail-eopbgr30139.outbound.protection.outlook.com
 ([40.107.3.139]:38469 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1i021x-0005gv-Ad
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 07:10:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LaGya6RAaG/+7uacnWgsP0inA8g6AM0ybzPU42jgIj2m/ftaIlQEAKwU9nRwCdbn16A58dI/dorOFyCxpFqPaUqxAoFfWASXo0WF+VNQRipkVYS9GTH+KJ5Pw0WYuFfirNy4K3NCCegp0gOmH1sY4z14m9tHQtVg6iPcrwIY2M2/bAUnn3rKnUe3jZVUMfy7OZCYE4w5qLJiaVbEW2Xsayk76OCXhjQwTJFa4/NR2IA/pkkAZ996JjZE2uc74aQ4d2PSNCCmA6GiiTwHZ27PT8dQSAl9+fM+Ve7umgJ5Uz2GgkBPgcQ6WhbpOh4dw4he3HpGfuGeC4Z95AnotIrZaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ioAnh+/mswjhkgRPHQiAqbxLrK11EPId26FimdBAGjw=;
 b=UYO/tlhCDOWiFDqNj6ySLt4UJX7HHc8kqASU+ZRSodrYssMpXNfo6UoNIxbkZDvIcrXKZvZkB0OE8oW6FfuDf3IPfB3qXZdm7ukuKnFifCLqp7CnRP6OUknoedt8TRAfFRxOoo0OtMUwjQap895yBB2ySSJxVDms0Ry6c6uPDWXP9C2pDZGAtG5Neor9QurAk74Hkbv05R1i0ahuO8ua4DM+6BxZqOOXrPzYviToMD90mNdGJBpil9YeAish9sC6CQcAYB3BFz29RSjdiBEq9SsSmydgNhUVsqcUy9Q5k9mkz/cFJoqGrhIraSDvkQ8+f3xlSBbWMaSa6LWhZ9Xv6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ioAnh+/mswjhkgRPHQiAqbxLrK11EPId26FimdBAGjw=;
 b=ctfmtINGcLi7ZzWLZlp714W5tSgX2AQG9R/fWRymPWsokVuVDWV8WkQTTZHj90D5qYIjll1KUVLYe4gHZWA5uRXucN4DDvvVndYrWD1bp8G/tw8iEGHp3tN3oFfd235A3yMnlEiSzVhQwZpvhen//qBZa3NZPBkN4qOuS5zyisM=
Received: from VI1PR08MB4399.eurprd08.prod.outlook.com (20.179.28.141) by
 VI1PR08MB4046.eurprd08.prod.outlook.com (20.178.127.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Tue, 20 Aug 2019 11:10:21 +0000
Received: from VI1PR08MB4399.eurprd08.prod.outlook.com
 ([fe80::303d:1bb9:76b2:99d7]) by VI1PR08MB4399.eurprd08.prod.outlook.com
 ([fe80::303d:1bb9:76b2:99d7%6]) with mapi id 15.20.2157.022; Tue, 20 Aug 2019
 11:10:20 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
Thread-Topic: [PATCH v4 2/2] char-socket: Lock tcp_chr_disconnect() and
 socket_reconnect_timeout()
Thread-Index: AQHVUSbVMqIoHxErZUyWbnNoDz1hC6cD2TEAgAAUNAA=
Date: Tue, 20 Aug 2019 11:10:20 +0000
Message-ID: <40430de6-9159-f8d0-f140-0a862526f8b9@virtuozzo.com>
References: <1565625509-404969-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1565625509-404969-3-git-send-email-andrey.shinkevich@virtuozzo.com>
 <20190820095800.GF23352@redhat.com>
In-Reply-To: <20190820095800.GF23352@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0502CA0003.eurprd05.prod.outlook.com
 (2603:10a6:3:e3::13) To VI1PR08MB4399.eurprd08.prod.outlook.com
 (2603:10a6:803:102::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c2935050-96ed-4b9d-dce1-08d7255efd6c
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:VI1PR08MB4046; 
x-ms-traffictypediagnostic: VI1PR08MB4046:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR08MB40464705CCF46F16513CD611F4AB0@VI1PR08MB4046.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 013568035E
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(396003)(346002)(366004)(376002)(39840400004)(199004)(189003)(26005)(52116002)(76176011)(3846002)(53546011)(6506007)(386003)(6116002)(102836004)(8936002)(186003)(99286004)(81156014)(66066001)(36756003)(81166006)(2616005)(316002)(256004)(7736002)(486006)(446003)(476003)(31696002)(54906003)(14444005)(14454004)(5660300002)(305945005)(44832011)(229853002)(66946007)(6246003)(66476007)(66556008)(86362001)(11346002)(25786009)(478600001)(66446008)(6436002)(107886003)(71190400001)(71200400001)(8676002)(64756008)(6486002)(31686004)(53936002)(6916009)(4326008)(2906002)(6512007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB4046;
 H:VI1PR08MB4399.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1NG7egzycDjl6GBVhzXPZKXlnGOrkrP2fftoumc9egQRmL2aLnMhfkmNes9ygqUDN4kjiTUKEPVmMEokIj4uvb0RNYUaDKfLkUVc5///5JAiscfhYIksibTQf16O77np8k9Kie/E//wgouQWIWSRjOtKyBfY6hojnTH/67jMnwt5mh4B6mTq7uIe9BhbGBvDfrvhBkXANo6QAtROivHGTBqK5vwJI4gnPCIGtMUnWaRjaawZE3M8wQg0tZg8ZK6lMzaECVAu3spWQMhsCv24KbS9JEJky8ua9N9PtknrtYkRmppv05ZiY4/hW1YKQtssLYSYNc+n1j8aAMxAEK7k1V19fy4Ljs2NNLaCxHphmKiFF2CfSNj7gCXQzaM8/FR93JdFvysPtXHk+wL5BcRj222z1nqcJfjithTEse036tg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D0984AD71D0D364281BE9389C34A291E@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2935050-96ed-4b9d-dce1-08d7255efd6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2019 11:10:20.6337 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GD4bW9EtOsSygWBl5McXi2PXwHOqgQsxeWzvlLTN7O9H6n6khi4lZCn3PZxckeN1zSS6TLd1eMndXWLBaYtAn6gmP6Daa6n2czKRhl3DrMA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4046
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.3.139
Subject: Re: [Qemu-devel] [PATCH v4 2/2] char-socket: Lock
 tcp_chr_disconnect() and socket_reconnect_timeout()
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "berto@igalia.com" <berto@igalia.com>, Denis Lunev <den@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDIwLzA4LzIwMTkgMTI6NTgsIERhbmllbCBQLiBCZXJyYW5nw6kgd3JvdGU6DQo+IE9u
IE1vbiwgQXVnIDEyLCAyMDE5IGF0IDA2OjU4OjI5UE0gKzAzMDAsIEFuZHJleSBTaGlua2V2aWNo
IHdyb3RlOg0KPj4gRnJvbTogQWxiZXJ0byBHYXJjaWEgPGJlcnRvQGlnYWxpYS5jb20+DQo+Pg0K
Pj4gVGhlcmUncyBhIHJhY2UgY29uZGl0aW9uIGluIHdoaWNoIHRoZSB0Y3BfY2hyX3JlYWQoKSBp
b2MgaGFuZGxlciBjYW4NCj4+IGNsb3NlIGEgY29ubmVjdGlvbiB0aGF0IGlzIGJlaW5nIHdyaXR0
ZW4gdG8gZnJvbSBhbm90aGVyIHRocmVhZC4NCj4+DQo+PiBSdW5uaW5nIGlvdGVzdCAxMzYgaW4g
YSBsb29wIHRyaWdnZXJzIHRoaXMgcHJvYmxlbSBhbmQgY3Jhc2hlcyBRRU1VLg0KPj4NCj4+ICAg
KGdkYikgYnQNCj4+ICAgIzAgIDB4MDAwMDU1NThiODQyOTAyZCBpbiBvYmplY3RfZ2V0X2NsYXNz
IChvYmo9MHgwKSBhdCBxb20vb2JqZWN0LmM6ODYwDQo+PiAgICMxICAweDAwMDA1NTU4Yjg0Zjky
ZGIgaW4gcWlvX2NoYW5uZWxfd3JpdGV2X2Z1bGwgKGlvYz0weDAsIGlvdj0weDdmZmMzNTVkZWNm
MCwgbmlvdj0xLCBmZHM9MHgwLCBuZmRzPTAsIGVycnA9MHgwKSBhdCBpby9jaGFubmVsLmM6NzYN
Cj4+ICAgIzIgIDB4MDAwMDU1NThiODRlMGU5ZSBpbiBpb19jaGFubmVsX3NlbmRfZnVsbCAoaW9j
PTB4MCwgYnVmPTB4NTU1OGJhZjViZWIwLCBsZW49MTM4LCBmZHM9MHgwLCBuZmRzPTApIGF0IGNo
YXJkZXYvY2hhci1pby5jOjEyMw0KPj4gICAjMyAgMHgwMDAwNTU1OGI4NGU0YTY5IGluIHRjcF9j
aHJfd3JpdGUgKGNocj0weDU1NThiYTQ2MDM4MCwgYnVmPTB4NTU1OGJhZjViZWIwICIuLi4iLCBs
ZW49MTM4KSBhdCBjaGFyZGV2L2NoYXItc29ja2V0LmM6MTM1DQo+PiAgICM0ICAweDAwMDA1NTU4
Yjg0ZGNhNTUgaW4gcWVtdV9jaHJfd3JpdGVfYnVmZmVyIChzPTB4NTU1OGJhNDYwMzgwLCBidWY9
MHg1NTU4YmFmNWJlYjAgIi4uLiIsIGxlbj0xMzgsIG9mZnNldD0weDdmZmMzNTVkZWRkMCwgd3Jp
dGVfYWxsPWZhbHNlKSBhdCBjaGFyZGV2L2NoYXIuYzoxMTINCj4+ICAgIzUgIDB4MDAwMDU1NThi
ODRkY2JjMiBpbiBxZW11X2Nocl93cml0ZSAocz0weDU1NThiYTQ2MDM4MCwgYnVmPTB4NTU1OGJh
ZjViZWIwICIuLi4iLCBsZW49MTM4LCB3cml0ZV9hbGw9ZmFsc2UpIGF0IGNoYXJkZXYvY2hhci5j
OjE0Nw0KPj4gICAjNiAgMHgwMDAwNTU1OGI4NGRmYjI2IGluIHFlbXVfY2hyX2ZlX3dyaXRlIChi
ZT0weDU1NThiYTQ3NjYxMCwgYnVmPTB4NTU1OGJhZjViZWIwICIuLi4iLCBsZW49MTM4KSBhdCBj
aGFyZGV2L2NoYXItZmUuYzo0Mg0KPj4gICAjNyAgMHgwMDAwNTU1OGI4MDg4Yzg2IGluIG1vbml0
b3JfZmx1c2hfbG9ja2VkIChtb249MHg1NTU4YmE0NzY2MTApIGF0IG1vbml0b3IuYzo0MDYNCj4+
ICAgIzggIDB4MDAwMDU1NThiODA4OGU4YyBpbiBtb25pdG9yX3B1dHMgKG1vbj0weDU1NThiYTQ3
NjYxMCwgc3RyPTB4NTU1OGJhOTIxZTQ5ICIiKSBhdCBtb25pdG9yLmM6NDQ5DQo+PiAgICM5ICAw
eDAwMDA1NTU4YjgwODkxNzggaW4gcW1wX3NlbmRfcmVzcG9uc2UgKG1vbj0weDU1NThiYTQ3NjYx
MCwgcnNwPTB4NTU1OGJiMTYxNjAwKSBhdCBtb25pdG9yLmM6NDk4DQo+PiAgICMxMCAweDAwMDA1
NTU4YjgwODkyMGMgaW4gbW9uaXRvcl9xYXBpX2V2ZW50X2VtaXQgKGV2ZW50PVFBUElfRVZFTlRf
U0hVVERPV04sIHFkaWN0PTB4NTU1OGJiMTYxNjAwKSBhdCBtb25pdG9yLmM6NTI2DQo+PiAgICMx
MSAweDAwMDA1NTU4YjgwODkzMDcgaW4gbW9uaXRvcl9xYXBpX2V2ZW50X3F1ZXVlX25vX3JlZW50
ZXIgKGV2ZW50PVFBUElfRVZFTlRfU0hVVERPV04sIHFkaWN0PTB4NTU1OGJiMTYxNjAwKSBhdCBt
b25pdG9yLmM6NTUxDQo+PiAgICMxMiAweDAwMDA1NTU4YjgwODk2YzAgaW4gcWFwaV9ldmVudF9l
bWl0IChldmVudD1RQVBJX0VWRU5UX1NIVVRET1dOLCBxZGljdD0weDU1NThiYjE2MTYwMCkgYXQg
bW9uaXRvci5jOjYyNg0KPj4gICAjMTMgMHgwMDAwNTU1OGI4NTVmMjNiIGluIHFhcGlfZXZlbnRf
c2VuZF9zaHV0ZG93biAoZ3Vlc3Q9ZmFsc2UsIHJlYXNvbj1TSFVURE9XTl9DQVVTRV9IT1NUX1FN
UF9RVUlUKSBhdCBxYXBpL3FhcGktZXZlbnRzLXJ1bi1zdGF0ZS5jOjQzDQo+PiAgICMxNCAweDAw
MDA1NTU4YjgxOTExZWYgaW4gcWVtdV9zeXN0ZW1fc2h1dGRvd24gKGNhdXNlPVNIVVRET1dOX0NB
VVNFX0hPU1RfUU1QX1FVSVQpIGF0IHZsLmM6MTgzNw0KPj4gICAjMTUgMHgwMDAwNTU1OGI4MTkx
MzA4IGluIG1haW5fbG9vcF9zaG91bGRfZXhpdCAoKSBhdCB2bC5jOjE4ODUNCj4+ICAgIzE2IDB4
MDAwMDU1NThiODE5MTQwZCBpbiBtYWluX2xvb3AgKCkgYXQgdmwuYzoxOTI0DQo+PiAgICMxNyAw
eDAwMDA1NTU4YjgxOThjODQgaW4gbWFpbiAoYXJnYz0xOCwgYXJndj0weDdmZmMzNTVkZjNmOCwg
ZW52cD0weDdmZmMzNTVkZjQ5MCkgYXQgdmwuYzo0NjY1DQo+Pg0KPj4gVGhpcyBwYXRjaCBhZGRz
IGEgbG9jayB0byBwcm90ZWN0IHRjcF9jaHJfZGlzY29ubmVjdCgpIGFuZA0KPj4gc29ja2V0X3Jl
Y29ubmVjdF90aW1lb3V0KCkNCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBBbGJlcnRvIEdhcmNpYSA8
YmVydG9AaWdhbGlhLmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IEFuZHJleSBTaGlua2V2aWNoIDxh
bmRyZXkuc2hpbmtldmljaEB2aXJ0dW96em8uY29tPg0KPiANCj4gUmV2aWV3ZWQtYnk6IERhbmll
bCBQLiBCZXJyYW5nw6kgPGJlcnJhbmdlQHJlZGhhdC5jb20+DQo+IA0KPiANCj4gUmVnYXJkcywN
Cj4gRGFuaWVsDQo+IA0KDQpUaGFuayB5b3UgRGFuaWVsDQpBbmRyZXkNCi0tIA0KV2l0aCB0aGUg
YmVzdCByZWdhcmRzLA0KQW5kcmV5IFNoaW5rZXZpY2gNCg0K

