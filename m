Received: from eggs.gnu.org ([2001:4830:134:3::10]:35446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Andrew.Baumann@microsoft.com>) id 1cqSrD-000517-S7
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 19:06:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Andrew.Baumann@microsoft.com>) id 1cqSr9-0001Sr-Tx
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 19:06:27 -0400
Received: from mail-dm3nam03on0101.outbound.protection.outlook.com
	([104.47.41.101]:61312
	helo=NAM03-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Andrew.Baumann@microsoft.com>)
	id 1cqSr9-0001Sj-Hl
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 19:06:23 -0400
From: Andrew Baumann <Andrew.Baumann@microsoft.com>
Date: Tue, 21 Mar 2017 23:06:21 +0000
Message-ID: <DM5PR03MB2827F4507244124CB15683209E3D0@DM5PR03MB2827.namprd03.prod.outlook.com>
References: <20170321223151.12984-1-Andrew.Baumann@microsoft.com>
	<158d19e3-feaf-84fb-6d7b-22f6204858fd@redhat.com>
In-Reply-To: <158d19e3-feaf-84fb-6d7b-22f6204858fd@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] virtio: fix vring_align() on 64-bit win32
 platforms
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Stefan Weil <sw@weilnetz.de>, "Michael S . Tsirkin" <mst@redhat.com>

PiBGcm9tOiBFcmljIEJsYWtlIFttYWlsdG86ZWJsYWtlQHJlZGhhdC5jb21dDQo+IFNlbnQ6IFR1
ZXNkYXksIDIxIE1hcmNoIDIwMTcgMTU6NTINCj4gDQo+IE9uIDAzLzIxLzIwMTcgMDU6MzEgUE0s
IEFuZHJldyBCYXVtYW5uIHdyb3RlOg0KPiA+ICJsb25nIiBpcyAzMi1iaXRzIG9uIHdpbjMyLCBi
dXQgd2UgbmVlZCB0byBwcm9tb3RlIGl0IHRvIGEgNjQtYml0IGh3YWRkcg0KPiA+IGJlZm9yZSBu
ZWdhdGluZywgb3IgZWxzZSB0aGUgdG9wIGhhbGYgb2YgdGhlIGFkZHJlc3MgaXMgdHJ1bmNhdGVk
DQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbmRyZXcgQmF1bWFubiA8QW5kcmV3LkJhdW1hbm5A
bWljcm9zb2Z0LmNvbT4NCj4gPiAtLS0NCj4gPiAgaW5jbHVkZS9ody92aXJ0aW8vdmlydGlvLmgg
fCAyICstDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigt
KQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvdmlydGlvL3ZpcnRpby5oIGIvaW5j
bHVkZS9ody92aXJ0aW8vdmlydGlvLmgNCj4gPiBpbmRleCAxNWVmY2YyLi5hMGE4NTQzIDEwMDY0
NA0KPiA+IC0tLSBhL2luY2x1ZGUvaHcvdmlydGlvL3ZpcnRpby5oDQo+ID4gKysrIGIvaW5jbHVk
ZS9ody92aXJ0aW8vdmlydGlvLmgNCj4gPiBAQCAtMzQsNyArMzQsNyBAQCBzdHJ1Y3QgVmlydFF1
ZXVlOw0KPiA+ICBzdGF0aWMgaW5saW5lIGh3YWRkciB2cmluZ19hbGlnbihod2FkZHIgYWRkciwN
Cj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdW5zaWdu
ZWQgbG9uZyBhbGlnbikNCj4gPiAgew0KPiA+IC0gICAgcmV0dXJuIChhZGRyICsgYWxpZ24gLSAx
KSAmIH4oYWxpZ24gLSAxKTsNCj4gPiArICAgIHJldHVybiAoYWRkciArIGFsaWduIC0gMSkgJiB+
KGh3YWRkcikoYWxpZ24gLSAxKTsNCj4gDQo+IFdoeSBub3QganVzdCB1c2UgdGhlIFFFTVVfQUxJ
R05fRE9XTiBtYWNybywgaW5zdGVhZCBvZiBvcGVuLWNvZGluZyBpdD8NCg0KV2VsbCwgdGhpcyBj
b2RlIGlzIGFsaWduaW5nIHVwLCBidXQgeWVzIHRoZSBBTElHTl9VUCBtYWNybyBsb29rcyBsaWtl
IGl0IHNob3VsZCBhbHNvIGF2b2lkIHRoZSB0eXBlIHByb21vdGlvbiBwcm9ibGVtLiBUaGlzIHBh
dGNoIGlzIGp1c3QgdGhlIG1pbmltYWxseS1pbnZhc2l2ZSBjaGFuZ2UgYWZ0ZXIgZGlzY292ZXJp
bmcgdGhlIGJ1Zy4NCg0KTGV0IG1lIGtub3cgaWYgeW91IHdhbnQgbWUgdG8gc3BpbiBhbm90aGVy
IHBhdGNoIHdpdGggdGhlIG1hY3JvLg0KDQpBbmRyZXcNCg0K
