Received: from eggs.gnu.org ([2001:4830:134:3::10]:38723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1dBidH-0003Nq-3I
	for qemu-devel@nongnu.org; Fri, 19 May 2017 10:11:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1dBidC-0005rN-3b
	for qemu-devel@nongnu.org; Fri, 19 May 2017 10:11:55 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3998)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1dBidB-0005q6-Gz
	for qemu-devel@nongnu.org; Fri, 19 May 2017 10:11:50 -0400
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Fri, 19 May 2017 14:11:28 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA2A0CAF@DGGEMA505-MBS.china.huawei.com>
References: <36fcce23-2fd2-961a-80b4-c5cb152c7233@huawei.com>
	<b4e2b09b-0fb8-5b71-066e-b1aa50ab45f9@redhat.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] Migration downtime more than 5s when migrating
 guest with massive disks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, yanghongyang <yanghongyang@huawei.com>, "mst@redhat.com" <mst@redhat.com>
Cc: "quintela@redhat.com" <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Huangzhichao <huangzhichao@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "imhy.yang@gmail.com" <imhy.yang@gmail.com>

T29wcywgZm9yZ290IHRvIENDIHFlbXUtZGV2ZWwsIGFkZCBpdC4NCg0KDQo+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEdvbmdsZWkgKEFyZWkpDQo+IFNlbnQ6IEZyaWRheSwg
TWF5IDE5LCAyMDE3IDg6MTcgUE0NCj4gVG86ICdQYW9sbyBCb256aW5pJzsgeWFuZ2hvbmd5YW5n
OyBtc3RAcmVkaGF0LmNvbQ0KPiBDYzogcXVpbnRlbGFAcmVkaGF0LmNvbTsgRHIuIERhdmlkIEFs
YW4gR2lsYmVydDsgSHVhbmd6aGljaGFvDQo+IFN1YmplY3Q6IFJFOiBNaWdyYXRpb24gZG93bnRp
bWUgbW9yZSB0aGFuIDVzIHdoZW4gbWlncmF0aW5nIGd1ZXN0IHdpdGgNCj4gbWFzc2l2ZSBkaXNr
cw0KPiANCj4gDQo+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9tOiBQYW9s
byBCb256aW5pIFttYWlsdG86cGJvbnppbmlAcmVkaGF0LmNvbV0NCj4gPiBTZW50OiBGcmlkYXks
IE1heSAxOSwgMjAxNyA2OjE5IFBNDQo+ID4NCj4gPiBPbiAxOS8wNS8yMDE3IDEyOjAwLCBZYW5n
IEhvbmd5YW5nIHdyb3RlOg0KPiA+ID4gV2UgZm91bmQgdGhhdCBtaWdyYXRpb24gZG93bnRpbWUg
aXMgdW5hY2NlcHRhYmxlIHdoZW4gbWlncmF0aW5nIGd1ZXN0DQo+ID4gd2l0aA0KPiA+ID4gNjAg
ZGlza3MsIG1vcmUgdGhhbiA1LjUgc2Vjb25kcy4NCj4gPiA+IEJ5IGRlYnVnZ2luZywgd2UgZmlu
ZCBvdXQgdGhlIHByb2JsZW0gaXMgdGhlcmUncyB0b28gbWFueQ0KPiA+ID4gbWVtb3J5X3JlZ2lv
bl90cmFuc2FjdGlvbl9jb21taXQoKSBvcGVyYXRpb25zIGR1cmluZyBndWVzdCBsb2FkLCBhYm91
dA0KPiA+ID4gMzF3KyB0aW1lcy4NCj4gPiA+IEFueSBpZGVhIHRvIG9wdGltaXplIHRoZSBtaWdy
YXRpb24gZG93bnRpbWUgaW4gdGhpcyBzY2VuYXJpbz8NCj4gPiA+IG1heWJlIHJlZHVjZSB0aGUg
dGltZXMgb2YgbWVtb3J5X3JlZ2lvbl90cmFuc2FjdGlvbl9jb21taXQoKSBjYWxsLCBidXQNCj4g
PiBob3c/DQo+ID4gPiBvciB3ZSBjb3VsZCBvcHRpbWl6ZSB0aGUgdGltZSBjb3N0IG9mDQo+IG1l
bW9yeV9yZWdpb25fdHJhbnNhY3Rpb25fY29tbWl0KCkNCj4gPiBjYWxsLA0KPiA+ID4gYnV0IEkg
dGhpbmsgdGhhdCB3b3VsZG4ndCBoZWxwIG11Y2guDQo+ID4NCj4gPiBJdCB3b3VsZC4gIFJpZ2h0
IG5vdyBtZW1vcnlfcmVnaW9uX3RyYW5zYWN0aW9uX2NvbW1pdCgpIGlzIHJvdWdobHkNCj4gPiBP
KG5eMikgKG4gZGV2aWNlcyAqIG4gQkFScyksIGFuZCB0aGVyZSBhcmUgbiBvZiB0aGVtLg0KPiA+
DQo+ID4gUmVkdWNpbmcgbWVtb3J5X3JlZ2lvbl90cmFuc2FjdGlvbl9jb21taXQgdG8gTyhuKSB3
b3VsZCBiZSBhIGxhcmdlDQo+ID4gY2hhbmdlLiAgT25lIGlkZWEgaXMgdG8gc2hhcmUgdGhlIEFk
ZHJlc3NTcGFjZURpc3BhdGNoIGZvciBBZGRyZXNzU3BhY2VzDQo+ID4gdGhhdCBoYXZlIHRoZSBz
YW1lIHJvb3QgbWVtb3J5IHJlZ2lvbiAoYWZ0ZXIgcmVzb2x2aW5nIGFsaWFzZXMpLiAgVGhlDQo+
ID4gc3RhcnRpbmcgcG9pbnQgd291bGQgYmUgdG8gY2hhbmdlIG1lbV9iZWdpbi9tZW1fY29tbWl0
L21lbV9hZGQgZnJvbQ0KPiBhDQo+ID4gTWVtb3J5TGlzdGVuZXIgdG8gYW4gbG9vcCBvbiB0aGUg
RmxhdFZpZXcsIHN0b3JpbmcgdGhlDQo+ID4gQWRkcmVzc1NwYWNlRGlzcGF0Y2ggaW4gdGhlIEZs
YXRWaWV3Lg0KPiA+DQo+IEhvdyBhYm91dCBkbyBPKDEpIGZvciBzdG9wcGluZyBzdGFnZSBvZiBs
aXZlIG1pZ3JhdGlvbj8NCj4gQmVjYXVzZSB0aGUgY3B1IGlzIHN0b3BwZWQgaW4gdGhpcyBwaGFz
ZSwgaXQgd291bGRuJ3QgY2F1c2UNCj4gc2lkZSBlZmZlY3RzIElNSE8sIHJpZ2h0Pw0KPiANCj4g
VGhhbmtzLA0KPiAtR29uZ2xlaQ0KPiANCj4gPiBPbmUgYmFuZGFpZCBzb2x1dGlvbiBpcyB0byB1
c2UgdmlydGlvLXNjc2kgaW4gdGhlIGd1ZXN0LCB3aXRoIG11bHRpcGxlDQo+ID4gZGlza3MgYmVo
aW5kIG9uZSBjb250cm9sbGVyLg0KPiA+DQo+ID4gVGhhbmtzLA0KPiA+DQo+ID4gUGFvbG8NCg==
