Received: from eggs.gnu.org ([209.51.188.92]:59551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <driver1998@foxmail.com>) id 1hMItP-0005GX-AB
	for qemu-devel@nongnu.org; Thu, 02 May 2019 17:05:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <driver1998@foxmail.com>) id 1hMItO-0000V2-Ag
	for qemu-devel@nongnu.org; Thu, 02 May 2019 17:05:23 -0400
Received: from smtpbgbr2.qq.com ([54.207.22.56]:35581)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <driver1998@foxmail.com>)
	id 1hMItN-0000RR-AO
	for qemu-devel@nongnu.org; Thu, 02 May 2019 17:05:22 -0400
In-Reply-To: <141080f9-8374-1d16-7b40-a4848a455086@redhat.com>
References: <20190430181343.1362-1-driver1998@foxmail.com>
	<141080f9-8374-1d16-7b40-a4848a455086@redhat.com>
From: "=?ISO-8859-1?B?ZHJpdmVyMTk5OA==?=" <driver1998@foxmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: base64
Date: Fri, 3 May 2019 05:05:07 +0800
Message-ID: <tencent_DAABF38404447BB09E9711B789C215AAD109@qq.com>
Subject: Re: [Qemu-devel] [PATCH v2 4/4] include/qemu/osdep.h: Move
 the__USE_MINGW_ANSI_STDIO define up to avoid confliction.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-1?B?RXJpYyBCbGFrZQ==?= <eblake@redhat.com>, =?ISO-8859-1?B?cWVtdS1kZXZlbA==?= <qemu-devel@nongnu.org>

T24gNS8xLzE5IDI6MzAgQU0sIEVyaWMgQmxha2Ugd3JvdGU6DQo+IFlvdXIgZW50aXJlIHNl
cmllcyBpcyBtaXNzaW5nICdJbi1SZXBseS1UbzonIGFuZCAnUmVmZXJlbmNlczonIGhlYWRl
cnMsDQo+IG1ha2luZyBlYWNoIG1lc3NhZ2Ugc2hvdyB1cCBhcyBpbmRpdmlkdWFsIG5ldyB0
aHJlYWRzIHJhdGhlciB0aGFuDQo+IHByb3Blcmx5IHRocmVhZGVkIHRvIGEgMC80IGNvdmVy
IGxldHRlci4gWW91J2xsIHdhbnQgdG8gZml4IHlvdXIgc2VuZGluZw0KPiBoYWJpdHMgdG8g
YXZvaWQgdGhhdCBwcm9ibGVtIGluIGZ1dHVyZSBzdWJtaXNzaW9ucy4NCg0KSSBhbSB0ZXJy
aWJseSBzb3JyeSBhYm91dCB0aGF0LCB0aGlzIGlzIHRoZSBmaXJzdCB0aW1lIEkgc3VtbWl0
IHBhdGNoZXMsIGFuZCBJIGFtIHN0aWxsIGdldHRpbmcgdXNlZCB0byB0aGUgdG9vbGluZy4N
ClRoYW5rIHlvdSBmb3IgcG9pbnRpbmcgb3V0IHRoZSBpc3N1ZSB0aG91Z2guDQoNCj4gSXQn
cyB1bnVzdWFsIHRvIHVzZSBhIHRyYWlsaW5nICcuJyBpbiB0aGUgc3ViamVjdCBsaW5lLiBB
bHNvLCB5b3VyDQo+IHN1YmplY3QgaXMgdmVyeSBsb25nOyBjb21taXQgbWVzc2FnZSBzdW1t
YXJpZXMgc2hvdWxkIHR5cGljYWxseSBiZQ0KPiBhcm91bmQgNjAtNzAgY2hhcmFjdGVycyBi
ZWNhdXNlICdnaXQgbG9nJyBzaG93cyB0aGVtIHdpdGggZnVydGhlcg0KPiBpbmRlbnRhdGlv
biwgd2hlcmUgYW4gODAtY29sdW1uIHRlcm1pbmFsIHdpbmRvdyBtYWtlcyBpdCBoYXJkIHRv
IHNlZSB0aGUNCj4gdGFpbCBhdCBhIGdsYW5jZS4gIEJldHRlciBtaWdodCBiZSBhIHNob3J0
IHN1YmplY3QgbGluZSBleHBsYWluaW5nIHRoZQ0KPiAid2hhdCIsIGFuZCB0aGVuIGEgbm9u
LWVtcHR5IGNvbW1pdCBtZXNzYWdlIGV4cGxhaW5pbmcgdGhlICJ3aHkiDQoNClRoYW5rIHlv
dSBmb3IgcG9pbnRpbmcgb3V0LCBJJ2xsIHVwZGF0ZSB0aGF0IGluIHRoZSB1cGNvbWluZyB2
MyBzZXQuDQoNCj4gUXVlc3Rpb24gLSBkb2VzIGl0IGh1cnQgdG8gbWFrZSB0aGUgZGVmaW5l
IG9mIF9fVVNFX01JTkdXX0FOU0lfU1RESU8NCj4gdW5jb25kaXRpb25hbD8gIEluIG90aGVy
IHdvcmRzLCB3ZSdyZSB1bmxpa2VseSB0byBicmVhayBhbnkgbm9uLW1pbmd3DQo+IHBsYXRm
b3JtIGlmIHdlIGRyb3AgdGhlICNpZmRlZiBfX01JTkdXMzJfXyBsaW5lLg0KDQpJIHBlcnNv
bmFsbHkgaGF2ZSBubyBpZGVhLCBzbyBJJ2xsIGtlZXAgaXQgYXMgaXMu
