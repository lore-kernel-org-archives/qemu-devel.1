Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF1BFCA9EBC
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 10:20:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68586208C0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 10:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="VIPNqpUH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68586208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP281-00086n-Gx
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 06:20:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37361)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1iP26h-0006mi-7m
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 06:18:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1iP26g-0001mh-37
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 06:18:39 -0400
Received: from mail-eopbgr10117.outbound.protection.outlook.com
 ([40.107.1.117]:23326 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1iP26d-0001l4-FA; Mon, 28 Oct 2019 06:18:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YN6MVJKn8We8QWstrEr4KTVUSH40lXOYhTW0aDn0oHOW8PWLIWENFWnFWNMvpyVJOWvew/J8n26vyMiPz4yiCgxnyaQsiVejP/HfylblUiqeYz8hse//tO9CWX4jfGvqEBPECQI9t/QzabL2EdYJjTae7KFKSkYE+QFe9ebxspSXIX5134bqtOXVg0GDnF12bV+fqh+DsKrDDTo7kujowgzaK04ZdzAibOF4EMyrdaZZYGmo0fi0RdZ7JzdWqEbS7qxt9jSU38IRhBhwoGNpd2/f+zzZYy3rShrFnrDi+1X9H33EostQv+0C2qIzBhc3k2Mvtuu+3C3f0yPwdw2+Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IBbwXp8IJWBYFdSWA8DwTV/1WPU2Gu/jLVQcDFnk2mI=;
 b=E/g8mogv4xTNbbRJUisEJu0OV1I+lJoZCGVwlLD+mlZC65Lsr81KfLDXNoQEPCr6dLoz4w9r1883JXnXEOTkLdDn/gmhItu+Mms1hxPHKaHhlD+FbHBlFecP4UgQHCDnax/UaCmbhJ9ubpOXHve8PkCYDfgs3F+WK/z8D3WpcOJIFZnYgrqY2DAKITW45lnxzPHSYRI0RiDXUPk1XL7CQaFwfwsnF+WstqtBkOJ8OD38KK2QKVAaHcqEiQPXniVp/XDwKuyq5QA9q5zXjg3g3A3ABgfkZaPUT0RdolD0TcijtmTbxZzceAbBvRoVl70G5nhFxLZeSDqvAqJgapVYNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IBbwXp8IJWBYFdSWA8DwTV/1WPU2Gu/jLVQcDFnk2mI=;
 b=VIPNqpUHseQtTHjvit6NsGrASL2JCZgDfzq41Nlm3GoaOIXo2uGfqL6QGaf4Hi+eoKPpBm/2Z88xOd/PuRgPWRAMQ6lsW6gzRt99W1H/8UEqs0zUyQOiNt0boCe6ruZrxfhBqyIWAckMt8qmt9N2qtDSThKtx4eo2F3trTd3sOA=
Received: from DB6PR08MB2757.eurprd08.prod.outlook.com (10.170.220.33) by
 DB6PR08MB2629.eurprd08.prod.outlook.com (10.175.233.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.22; Mon, 28 Oct 2019 10:18:32 +0000
Received: from DB6PR08MB2757.eurprd08.prod.outlook.com
 ([fe80::a1ee:668f:c3a5:87b]) by DB6PR08MB2757.eurprd08.prod.outlook.com
 ([fe80::a1ee:668f:c3a5:87b%4]) with mapi id 15.20.2387.023; Mon, 28 Oct 2019
 10:18:32 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Eric Blake
 <eblake@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: Re: [PATCH] iotests: Test nbd client reconnect
Thread-Topic: [PATCH] iotests: Test nbd client reconnect
Thread-Index: AQHVjNWt0TAMGNw3iEi7A8SFdwW3mqdvsIUAgAAnm4CAAABLAA==
Date: Mon, 28 Oct 2019 10:18:32 +0000
Message-ID: <6f7412fe-95fd-45df-6fb2-acd2ce8916a3@virtuozzo.com>
References: <1572187725-685325-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <8acd5c43-adcb-eff5-aa87-030d57216a5e@redhat.com>
 <bd964acf-63a1-daba-904d-2a74e3b3a781@virtuozzo.com>
In-Reply-To: <bd964acf-63a1-daba-904d-2a74e3b3a781@virtuozzo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR07CA0033.eurprd07.prod.outlook.com
 (2603:10a6:7:66::19) To DB6PR08MB2757.eurprd08.prod.outlook.com
 (2603:10a6:6:18::33)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f94a64d3-6647-4e05-868a-08d75b902f3e
x-ms-traffictypediagnostic: DB6PR08MB2629:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR08MB26297ACBEB9CA775D9DF2A0EF4660@DB6PR08MB2629.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0204F0BDE2
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(136003)(376002)(346002)(396003)(39840400004)(189003)(199004)(51444003)(7736002)(6512007)(478600001)(2501003)(6246003)(107886003)(31696002)(6486002)(2201001)(86362001)(5660300002)(3846002)(2906002)(14444005)(256004)(6436002)(8676002)(81156014)(31686004)(66476007)(66556008)(66446008)(66066001)(81166006)(66946007)(4326008)(305945005)(44832011)(71200400001)(11346002)(2616005)(8936002)(64756008)(486006)(476003)(99286004)(36756003)(52116002)(6506007)(54906003)(110136005)(26005)(186003)(53546011)(76176011)(316002)(102836004)(386003)(229853002)(25786009)(6116002)(446003)(71190400001)(14454004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB6PR08MB2629;
 H:DB6PR08MB2757.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IC7Jo/WXVemKuziX8YHjdARHWh4MA4EsFfmza8OIdSvZZ7Mb2p259P/0WIm+DYelw18kRgWcrguT9GpqQI/Sndq6knM/6ZYwN0m8LKZdw5eJjPsa9QUGeuD2xTNfQ+TVoRV5XvmxQasUc2l4FW2yWCjKknlhwMpiJwpGjNw01CbOpqUgxeveVvX0DVZIFE8QbOPHi+IvE+LC1ZZWPZ2C3fsWq3LmWKx1gdd0WS1gQKshgfXRqbjpP2zDq9TdIWgpukfkX7br43ZVvblepXmuvTWWqMYcNhGD1fYZ8H5BaKXhOwlkYvHCRsddyhiwNn5OXuSh9AX+pSTW+ktSSHZCwyQ2v2YSTjyVEz778ybVMlCp4H3+fCvvLi9TJ3oUdovn16k9Div75UxXktp4IYYEXVPSrzoRf18J25idz6PKGl92wUvgiAXyKVPrSur2nGzk
Content-Type: text/plain; charset="utf-8"
Content-ID: <39B35F8F889F9E45A5E5D112FE5D1C19@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f94a64d3-6647-4e05-868a-08d75b902f3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2019 10:18:32.3698 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8D9T5J0sUaVywqzbieXo4pGnYqQa70U+UZUjJyXh7Z4VsSd0zwXy8o2lucwjm9f4leNJ+QF6HrQVU3wU4u7mwST40y7EhuyZvXyguF3vb24=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR08MB2629
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.117
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
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDI4LzEwLzIwMTkgMTM6MTcsIFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgd3Jv
dGU6DQo+IDI4LjEwLjIwMTkgMTA6NTUsIEVyaWMgQmxha2Ugd3JvdGU6DQo+PiBPbiAxMC8yNy8x
OSAzOjQ4IFBNLCBBbmRyZXkgU2hpbmtldmljaCB3cm90ZToNCj4+PiBUaGUgc3RyZXNzIHRlc3Qg
Zm9yIGFuIE5CRCBjbGllbnQuIFRoZSBOQkQgc2VydmVyIGlzIGRpc2Nvbm5lY3RlZCBhZnRlcg0K
Pj4+IGEgY2xpZW50IHdyaXRlIG9wZXJhdGlvbi4gVGhlIE5CRCBjbGllbnQgc2hvdWxkIHJlY29u
bmVjdCBhbmQgcmV0cnkgdGhlDQo+Pj4gb3BlcmF0aW9uLg0KPj4+DQo+Pj4gU3VnZ2VzdGVkLWJ5
OiBEZW5pcyBWLiBMdW5ldiA8ZGVuQG9wZW52ei5vcmc+DQo+Pj4gU2lnbmVkLW9mZi1ieTogQW5k
cmV5IFNoaW5rZXZpY2ggPGFuZHJleS5zaGlua2V2aWNoQHZpcnR1b3p6by5jb20+DQo+Pj4gLS0t
DQo+Pj4gIMKgIHRlc3RzL3FlbXUtaW90ZXN0cy8yNzfCoMKgwqDCoCB8IDkxICsrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4+PiAgwqAgdGVzdHMvcWVtdS1p
b3Rlc3RzLzI3Ny5vdXQgfMKgIDcgKysrKw0KPj4+ICDCoCB0ZXN0cy9xZW11LWlvdGVzdHMvZ3Jv
dXDCoMKgIHzCoCAxICsNCj4+PiAgwqAgMyBmaWxlcyBjaGFuZ2VkLCA5OSBpbnNlcnRpb25zKCsp
DQo+Pj4gIMKgIGNyZWF0ZSBtb2RlIDEwMDc1NSB0ZXN0cy9xZW11LWlvdGVzdHMvMjc3DQo+Pj4g
IMKgIGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0cy9xZW11LWlvdGVzdHMvMjc3Lm91dA0KPj4NCj4+
IEhvdyBkb2VzIHRoaXMgZGlmZmVyIGZyb20gMjY0P8KgIElmIGl0IGFkZHMgYW55dGhpbmcgbmV3
LCBjYW4gaXQgYmUgbWVyZ2VkIGludG8gdGhlIGV4aXN0aW5nIHRlc3Q/DQo+Pg0KPiANCj4gMjY0
IGlzIGJhY2t1cCBvdmVyIE5CRCB3aXRoIHJlY29ubmVjdC4gSGVyZSBpcyBhbm90aGVyIHRoaW5n
OiBjaGVjayB0aGF0IHRoZSBvbmx5IHNtYWxsIHJlcXVlc3Qgd29ya3MNCj4gd2l0aCByZWNvbm5l
Y3QsIGlmIGRpc2Nvbm5lY3Qgb2NjdXJzIGV4YWN0bHkgYWZ0ZXIgcmVxdWVzdCB3YXMgYWNjZXB0
ZWQgYnkgc2VydmVyIGFuZCBjbGllbnQga25vd3MsDQo+IHRoYXQgcmVxdWVzdHMgaXMgc3VjY2Vz
c2Z1bGx5IGFjY2VwdGVkLiBXZSB3YW50IHRvIGNoZWNrIHRoYXQgY2xpZW50IHdpbGwgbm90IHdh
aXQgcmVwbHkgZm9yZXZlciBidXQNCj4gcmVzZW5kIHRoZSByZXF1ZXN0IHRvIG5ldyBzdGFydGVk
IE5CRCBzZXJ2ZXIuDQo+IA0KPiBTbywgSSB0aGluaywgdGhleSBhcmUgZGlmZmVyZW50IGVub3Vn
aCB0byBrZWVwIHRoZW0gaW4gc2VwYXJhdGUuIFN0aWxsLCBpZiB3ZSB3YW50IHRvIG1lcmdlIHRo
ZW0sIGl0DQo+IG1lYW5zIHRoYXQgd2Ugc2hvdWxkIHJld3JpdGUgdGhlbSBpbiB1bml0dGVzdCBz
dHlsZSwgd2l0aCB0ZXN0LWNhc2VzLCBhcyBJIHRoaW5rIHRoYXQgaHVnZSB0ZXh0LWNhbXBhcmlu
Zw0KPiB0ZXN0cyB3aXRoIHNldmVyYWwgdGVzdCBjYXNlcyBhcmUgYmFkIHRoaW5nLCBJJ2xsIHdy
aXRlIGEgc2VwYXJhdGUgbGV0dGVyIGFib3V0IGl0IHRvIGRpc2N1c3MgYSBiaXQgbGF0ZXIuDQo+
IA0KDQpQbGVhc2UgbG9vayBhdCB0aGUgdjIgY29taW5nLi4uDQotLSANCldpdGggdGhlIGJlc3Qg
cmVnYXJkcywNCkFuZHJleSBTaGlua2V2aWNoDQoNCg==

