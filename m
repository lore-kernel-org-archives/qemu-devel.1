Received: from eggs.gnu.org ([2001:4830:134:3::10]:60363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1fNx3M-0007Qd-GE
	for qemu-devel@nongnu.org; Wed, 30 May 2018 05:05:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1fNx3I-0002Uz-HJ
	for qemu-devel@nongnu.org; Wed, 30 May 2018 05:05:56 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2327 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <arei.gonglei@huawei.com>)
	id 1fNx3I-0002TB-1t
	for qemu-devel@nongnu.org; Wed, 30 May 2018 05:05:52 -0400
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Wed, 30 May 2018 09:05:34 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA646AD6@DGGEMA505-MBX.china.huawei.com>
References: <D9DE8DBB19F2A24080482022C1DE758302C89900@dggemm509-mbx.china.huawei.com>
	<e4a72796-562e-adf8-21ba-7bed953126e8@redhat.com>
In-Reply-To: <e4a72796-562e-adf8-21ba-7bed953126e8@redhat.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] socket: dont't free msgfds if error equals
 EAGAIN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, linzhecheng <linzhecheng@huawei.com>, =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, "peterx@redhat.com" <peterx@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRXJpYyBCbGFrZSBbbWFp
bHRvOmVibGFrZUByZWRoYXQuY29tXQ0KPiBTZW50OiBXZWRuZXNkYXksIE1heSAzMCwgMjAxOCAz
OjMzIEFNDQo+IFRvOiBsaW56aGVjaGVuZyA8bGluemhlY2hlbmdAaHVhd2VpLmNvbT47IE1hcmMt
QW5kcsOpIEx1cmVhdQ0KPiA8bWFyY2FuZHJlLmx1cmVhdUBnbWFpbC5jb20+DQo+IENjOiBRRU1V
IDxxZW11LWRldmVsQG5vbmdudS5vcmc+OyBQYW9sbyBCb256aW5pIDxwYm9uemluaUByZWRoYXQu
Y29tPjsNCj4gd2FuZ3hpbiAoVSkgPHdhbmd4aW54aW4ud2FuZ0BodWF3ZWkuY29tPjsgR29uZ2xl
aSAoQXJlaSkNCj4gPGFyZWkuZ29uZ2xlaUBodWF3ZWkuY29tPjsgcGV0ZXJ4QHJlZGhhdC5jb207
IGJlcnJhbmdlQHJlZGhhdC5jb20NCj4gU3ViamVjdDogUmU6IFtRZW11LWRldmVsXSBbUEFUQ0hd
IHNvY2tldDogZG9udCd0IGZyZWUgbXNnZmRzIGlmIGVycm9yIGVxdWFscw0KPiBFQUdBSU4NCj4g
DQo+IE9uIDA1LzI5LzIwMTggMDQ6MzMgQU0sIGxpbnpoZWNoZW5nIHdyb3RlOg0KPiA+IEkgdGhp
bmsgdGhpcyBwYXRjaCBkb2Vzbid0IGZpeCBteSBpc3N1ZS4gRm9yIG1vcmUgZGV0YWlscywgcGxl
YXNlIHNlZSBHb25nbGVpJ3MNCj4gcmVwbHkuDQo+ID4gaHR0cHM6Ly9saXN0cy5nbnUub3JnL2Fy
Y2hpdmUvaHRtbC9xZW11LWRldmVsLzIwMTgtMDUvbXNnMDYyOTYuaHRtbA0KPiANCj4gWW91ciBt
YWlsZXIgaXMgbm90IGhvbm9yaW5nIHRocmVhZGluZyAoaXQgZmFpbGVkIHRvIGluY2x1ZGUNCj4g
J0luLVJlcGx5LVRvOicgYW5kICdSZWZlcmVuY2VzOicgaGVhZGVycyB0aGF0IHJlZmVyIHRvIHRo
ZSBtZXNzYWdlIHlvdQ0KPiBhcmUgcmVwbHlpbmcgdG8pLCBhbmQgeW91IGFyZSB0b3AtcG9zdGlu
ZywgYm90aCBvZiB3aGljaCBtYWtlIGl0DQo+IGRpZmZpY3VsdCB0byBmb2xsb3cgeW91ciBjb21t
ZW50cyBvbiBhIHRlY2huaWNhbCBsaXN0Lg0KPiANCj4gDQpBZ3JlZS4NCg0KQFpoZWNoZW5nLCBw
bHMgcmVzZW5kIGEgcGF0Y2ggd2l0aCBjb21taXQgbWVzc2FnZS4gQ2NpbmcgdGhlc2UgZ3V5cy4N
Cg0KUmVnYXJkcywNCi1Hb25nbGVpDQo=
