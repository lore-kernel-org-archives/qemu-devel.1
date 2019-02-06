Received: from eggs.gnu.org ([209.51.188.92]:37682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1grKOs-0003kG-92
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 05:25:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1grKOr-0006lw-7U
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 05:25:50 -0500
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Date: Wed, 6 Feb 2019 10:25:19 +0000
Message-ID: <1ff257a6-282e-5fe9-8039-067e7e6e5360@virtuozzo.com>
References: <1549397675-189741-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1549397675-189741-3-git-send-email-andrey.shinkevich@virtuozzo.com>
	<ce1a623e-8844-72d5-e4a7-ca8cb9354c86@redhat.com>
In-Reply-To: <ce1a623e-8844-72d5-e4a7-ca8cb9354c86@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <5F383E1013674441BC831C1D7AC348E9@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v12 2/3] qcow2: Add list of bitmaps to
 ImageInfoSpecificQCow2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>, Denis Lunev <den@virtuozzo.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

DQoNCk9uIDA1LzAyLzIwMTkgMjM6MzMsIEVyaWMgQmxha2Ugd3JvdGU6DQo+IE9uIDIvNS8xOSAy
OjE0IFBNLCBBbmRyZXkgU2hpbmtldmljaCB3cm90ZToNCj4+IEluIHRoZSAnRm9ybWF0IHNwZWNp
ZmljIGluZm9ybWF0aW9uJyBzZWN0aW9uIG9mIHRoZSAncWVtdS1pbWcgaW5mbycNCj4+IGNvbW1h
bmQgb3V0cHV0LCB0aGUgc3VwcGxlbWVudGFsIGluZm9ybWF0aW9uIGFib3V0IGV4aXN0aW5nIFFD
T1cyDQo+PiBiaXRtYXBzIHdpbGwgYmUgc2hvd24sIHN1Y2ggYXMgYSBiaXRtYXAgbmFtZSwgZmxh
Z3MgYW5kIGdyYW51bGFyaXR5Og0KPj4NCj4gDQo+PiArIyMNCj4+ICsjIEBRY293MkJpdG1hcElu
Zm86DQo+PiArIw0KPj4gKyMgUWNvdzIgYml0bWFwIGluZm9ybWF0aW9uLg0KPj4gKyMNCj4+ICsj
IEBuYW1lOiB0aGUgbmFtZSBvZiB0aGUgYml0bWFwDQo+PiArIw0KPj4gKyMgQGdyYW51bGFyaXR5
OiBncmFudWxhcml0eSBvZiB0aGUgYml0bWFwIGluIGJ5dGVzDQo+PiArIw0KPj4gKyMgQGZsYWdz
OiBmbGFncyBvZiB0aGUgYml0bWFwDQo+PiArIw0KPj4gKyMgU2luY2U6IDQuMA0KPiANCj4gWW91
IGdvdCByaWQgb2YgdGhlIGRvY3MgZm9yIHVua25vd24tZmxhZ3MsDQo+IA0KPj4gKyMjDQo+PiAr
eyAnc3RydWN0JzogJ1Fjb3cyQml0bWFwSW5mbycsDQo+PiArICAnZGF0YSc6IHsnbmFtZSc6ICdz
dHInLCAnZ3JhbnVsYXJpdHknOiAndWludDMyJywNCj4+ICsgICAgICAgICAgICdmbGFncyc6IFsn
UWNvdzJCaXRtYXBJbmZvRmxhZ3MnXSwNCj4+ICsgICAgICAgICAgICcqdW5rbm93bi1mbGFncyc6
ICd1aW50MzInIH0gfQ0KPiANCj4gYnV0IGZvcmdvdCB0byBhY3R1YWxseSBnZXQgcmlkIG9mIHRo
ZSBmaWVsZC4gVGhhdCdzIGEgcHJldHR5IHNpbXBsZQ0KPiBjbGVhbnVwLCB3aGljaCBJIGRvbid0
IG1pbmQgbWFraW5nIGlmIHRoaXMgc2VyaWVzIGlzIG90aGVyd2lzZSByZWFkeSB0byBnby4NCj4g
DQo+IFJldmlld2VkLWJ5OiBFcmljIEJsYWtlIDxlYmxha2VAcmVkaGF0LmNvbT4NCj4gDQoNCkRl
YXIgRXJpYywNCg0KVGhhbmsgeW91IGZvciBiZWluZyBtaW5kZnVsIG9mIHRoaXMgc2VyaWVzIGFu
ZCBmb3IgeW91cg0KY29udHJpYnV0aW9uIHRvIHRoZSBjb21tb24gd29yayENCi0tIA0KV2l0aCB0
aGUgYmVzdCByZWdhcmRzLA0KQW5kcmV5IFNoaW5rZXZpY2gNCg==
