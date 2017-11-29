Received: from eggs.gnu.org ([2001:4830:134:3::10]:48663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1eK5Dj-0000nQ-Bo
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 11:28:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1eK5Dg-0006TK-Ng
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 11:28:23 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:2235 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <arei.gonglei@huawei.com>)
	id 1eK5Dg-0006Qi-CV
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 11:28:20 -0500
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Wed, 29 Nov 2017 16:28:05 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA4A9A07@DGGEMA505-MBS.china.huawei.com>
References: <20171128044656.10592-1-linzhecheng@huawei.com>
	<cd2bad80-1790-aa01-fde4-4979b4c53b97@redhat.com>
In-Reply-To: <cd2bad80-1790-aa01-fde4-4979b4c53b97@redhat.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v4] thread: move detach_thread from
 creating thread to created thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, linzhecheng <linzhecheng@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "famz@redhat.com" <famz@redhat.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRXJpYyBCbGFrZSBbbWFp
bHRvOmVibGFrZUByZWRoYXQuY29tXQ0KPiBTZW50OiBUaHVyc2RheSwgTm92ZW1iZXIgMzAsIDIw
MTcgMTI6MTkgQU0NCj4gVG86IGxpbnpoZWNoZW5nOyBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4g
Q2M6IGFsaWd1b3JpQHVzLmlibS5jb207IGZhbXpAcmVkaGF0LmNvbTsgd2FuZ3hpbiAoVSk7IEdv
bmdsZWkgKEFyZWkpOw0KPiBwYm9uemluaUByZWRoYXQuY29tDQo+IFN1YmplY3Q6IFJlOiBbUWVt
dS1kZXZlbF0gW1BBVENIIHY0XSB0aHJlYWQ6IG1vdmUgZGV0YWNoX3RocmVhZCBmcm9tDQo+IGNy
ZWF0aW5nIHRocmVhZCB0byBjcmVhdGVkIHRocmVhZA0KPiANCj4gT24gMTEvMjcvMjAxNyAxMDo0
NiBQTSwgbGluemhlY2hlbmcgd3JvdGU6DQo+ID4gSWYgd2UgY3JlYXRlIGEgdGhyZWFkIHdpdGgg
UUVNVV9USFJFQURfREVUQUNIRUQgbW9kZSwgUUVNVSBtYXkNCj4gZ2V0IGEgc2VnZmF1bHQgaW4g
YSBsb3cgcHJvYmFiaWxpdHkuDQo+ID4NCj4gDQo+ID4NCj4gPiBUaGUgcm9vdCBjYXVzZSBvZiB0
aGlzIHByb2JsZW0gaXMgYSBidWcgb2YgZ2xpYmModmVyc2lvbiAyLjE3LHRoZSBsYXRlc3QgdmVy
c2lvbg0KPiBoYXMgdGhlIHNhbWUgYnVnKSwNCj4gPiBsZXQncyBzZWUgd2hhdCBoYXBwZW5lZCBp
biBnbGliYydzIGNvZGUuDQo+IA0KPiBIYXZlIHlvdSByZXBvcnRlZCB0aGlzIGJ1ZyB0byB0aGUg
Z2xpYmMgZm9sa3MsIGFuZCBpZiBzbywgY2FuIHdlIGluY2x1ZGUNCj4gYSBVUkwgdG8gdGhlIGds
aWJjIGJ1Z3ppbGxhPw0KPiANCk5vLCB3ZSBkaWRuJ3QgZG8gdGhhdCB5ZXQuIDooDQoNCg0KPiBX
b3JraW5nIGFyb3VuZCB0aGUgZ2xpYmMgYnVnIGlzIG5pY2UsIGJ1dCBnbGliYyBzaG91bGQgcmVh
bGx5IGJlIGZpeGVkDQo+IHNvIHRoYXQgb3RoZXIgcHJvamVjdHMgZG8gbm90IGhhdmUgdG8gY29u
dGludWUgd29ya2luZyBhcm91bmQgaXQuDQo+IA0KPiANClllcywgYWdyZWUuDQoNCg0KUmVnYXJk
cywNCi1Hb25nbGVpDQoNCj4gPg0KPiA+IFFFTVUgZ2V0IGEgc2VnZmF1bHQgYXQgbGluZSA1MCwg
YmVjYXN1ZSBwZCBpcyBhbiBpbnZhbGlkIGFkZHJlc3MuDQo+ID4gcGQgaXMgc3RpbGwgdmFsaWQg
YXQgbGluZSAzOCB3aGVuIHNldCBwZC0+am9pbmlkID0gcGQsIGF0IHRoaXMgbW9tZW50LA0KPiA+
IGNyZWF0ZWQgdGhyZWFkIGlzIGp1c3QgZXhpdGluZyhvbmx5IGtlZXBzIHJ1bmluZyBmb3IgYSBz
aG9ydCB0aW1lKSwNCj4gDQo+IHMvcnVuaW5nL3J1bm5pbmcvDQo+IA0KPiAtLQ0KPiBFcmljIEJs
YWtlLCBQcmluY2lwYWwgU29mdHdhcmUgRW5naW5lZXINCj4gUmVkIEhhdCwgSW5jLiAgICAgICAg
ICAgKzEtOTE5LTMwMS0zMjY2DQo+IFZpcnR1YWxpemF0aW9uOiAgcWVtdS5vcmcgfCBsaWJ2aXJ0
Lm9yZw0K
