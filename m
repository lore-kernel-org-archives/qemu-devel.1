Received: from eggs.gnu.org ([2001:4830:134:3::10]:33279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gSk8X-0001BQ-OA
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 09:51:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gSk8W-00062d-PE
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 09:51:21 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 30 Nov 2018 14:51:09 +0000
Message-ID: <97939091-38e2-565b-7aa3-cfb9ebf239cb@virtuozzo.com>
References: <20181129101801.6421-1-vsementsov@virtuozzo.com>
	<20181129101801.6421-3-vsementsov@virtuozzo.com>
	<2f4c1bec-b5ca-e97f-88f9-75f3d2cb210c@redhat.com>
	<e9e07da0-0cd8-9820-642a-ab4fe227afc8@virtuozzo.com>
	<abcad6d9-2d40-15b4-9bce-964f6a3141a0@redhat.com>
	<73cb2885-3a40-6d2b-24fa-c528decdbc9b@virtuozzo.com>
	<20181130141017.GF5106@localhost.localdomain>
In-Reply-To: <20181130141017.GF5106@localhost.localdomain>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <F6A1C5C06886F24CAA7C467F49CB5F16@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 2/2] iotests: simple mirror test with
 kvm on 1G image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "jcody@redhat.com" <jcody@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, Denis Plotnikov <dplotnikov@virtuozzo.com>, Denis Lunev <den@virtuozzo.com>, "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>

MzAuMTEuMjAxOCAxNzoxMCwgS2V2aW4gV29sZiB3cm90ZToNCj4gQW0gMzAuMTEuMjAxOCB1bSAx
NDo0OCBoYXQgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSBnZXNjaHJpZWJlbjoNCj4+IDMw
LjExLjIwMTggMTY6MTMsIE1heCBSZWl0eiB3cm90ZToNCj4+PiBPbiAzMC4xMS4xOCAxNDowNiwg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+Pj4gMzAuMTEuMjAxOCAxNToz
MCwgTWF4IFJlaXR6IHdyb3RlOg0KPj4+Pj4gT24gMjkuMTEuMTggMTE6MTgsIFZsYWRpbWlyIFNl
bWVudHNvdi1PZ2lldnNraXkgd3JvdGU6DQo+Pj4+Pj4gVGhpcyB0ZXN0IGlzIGJyb2tlbiB3aXRo
b3V0IHByZXZpb3VzIGNvbW1pdCBmaXhpbmcgZGVhZC1sb2NrIGluIG1pcnJvci4NCj4+Pj4+Pg0K
Pj4+Pj4+IFNpZ25lZC1vZmYtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXk8dnNlbWVu
dHNvdkB2aXJ0dW96em8uY29tPg0KPj4+Pj4+IC0tLQ0KPj4+Pj4+ICAgICB0ZXN0cy9xZW11LWlv
dGVzdHMvMjM1ICAgICB8IDU5ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
DQo+Pj4+Pj4gICAgIHRlc3RzL3FlbXUtaW90ZXN0cy8yMzUub3V0IHwgIDEgKw0KPj4+Pj4+ICAg
ICB0ZXN0cy9xZW11LWlvdGVzdHMvZ3JvdXAgICB8ICAxICsNCj4+Pj4+PiAgICAgMyBmaWxlcyBj
aGFuZ2VkLCA2MSBpbnNlcnRpb25zKCspDQo+Pj4+Pj4gICAgIGNyZWF0ZSBtb2RlIDEwMDc1NSB0
ZXN0cy9xZW11LWlvdGVzdHMvMjM1DQo+Pj4+Pj4gICAgIGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0
cy9xZW11LWlvdGVzdHMvMjM1Lm91dA0KPj4+Pj4gSSdsbCBnZXQgdG8gdGhlIGZpcnN0IHBhdGNo
IGluIGEgc2Vjb25kLCBidXQgZmlyc3QgYSBzdWdnZXN0aW9uIGZvciB0aGlzDQo+Pj4+PiBwYXRj
aDogSSB0aGluayBpdCdzIG5vdCBzbyBnb29kIHRvIHVzZSAyIEdCIG9mIHNwYWNlIGZvciBhIHRl
c3QgKDEgR0INCj4+Pj4+IGZvciB0aGUgc291cmNlLCAxIEdCIGZvciB0aGUgdGFyZ2V0KS4gIFNv
IEkgdHJpZWQgbXkgbHVjayBhbmQgZm91bmQgdGhhdA0KPj4+Pj4gdGhlIHRlc3Qgd29ya3MsIHRv
bywgaWYgeW91IGp1c3QgdXNlIHByZWFsbG9jYXRpb249bWV0YWRhdGEgZm9yIHRoZQ0KPj4+Pj4g
c291cmNlIChpbnN0ZWFkIG9mIGFjdHVhbGx5IHdyaXRpbmcgZGF0YSkgYW5kIGJsb2NrZGV2LW1p
cnJvcidpbmcgdGhlDQo+Pj4+PiBkYXRhIHRvIGEgdGhyb3R0bGVkIG51bGwtY28gZGV2aWNlLg0K
Pj4+Pg0KPj4+PiBIbW0sIHNvIHBhcnNpbmcgbWV0YWRhdGEgaXMgZW5vdWdoIGZvciBxY293MiB0
byB5aWVsZCBvbiB3cml0ZSwgeWVzPw0KPj4+DQo+Pj4gQXBwYXJlbnRseSBzby4gIElmIHlvdSBj
YW4gY29uZmlybSB0aGF0IGFwcGx5aW5nIHRob3NlIGNoYW5nZXMgdG8gdGhlDQo+Pj4gdGVzdCBz
dGlsbCBtYWtlIGl0IHdvcmsgKGkuZS4sIGZhaWwgYmVmb3JlIHBhdGNoIDEsIHBhc3MgYWZ0ZXJ3
YXJkcyksDQo+Pj4gdGhlbiBJIHRoaW5rIGl0IGlzIGp1c3QgYXMgZ29vZC4NCj4+DQo+PiBPaywg
SSd2ZSBjaGVja2VkIHRoYXQgeW91ciBjaGFuZ2VzIHdvcmtzIGZvciBtZS4NCj4+DQo+PiBobSwg
YnV0IHdlIHdyaXRlIHRvIG51bGwsIHNvLCB5aWVsZCBvbiB3cml0ZSBjb21lcyBmcm9tIHRocm90
dGxpbmcsIGhvd2V2ZXIsDQo+PiB3aXRob3V0IHByZWFsbG9jYXRpb249bWV0YWRhdGEsIGl0IGRv
bid0IHdvcmsuLiwgZG8geW91IGtub3csIHdoeSB3ZSBuZWVkDQo+PiBwcmVhbGxvY2F0aW9uIHRv
IHJlcHJvZHVjZT8NCj4gDQo+IElmIEkgc2hvdWxkIHRha2UgYSBndWVzcywgcHJvYmFibHkgYmVj
YXVzZSBtaXJyb3Igb25seSBjb3BpZXMgYWxsb2NhdGVkDQo+IGNsdXN0ZXJzPw0KPiANCj4gS2V2
aW4NCj4gDQoNCmhtLCBzbywgd2hhdCBwcmVhbGxvY2F0aW9uPW1ldGFkYXRhIGRvZXM/IEkgdGhv
dWdodCwgaXQgcHJlYWxsb2NhdGVzIHRhYmxlcywgYnV0IGFsbCBxY293MiBjbHVzdGVycyB3b3Vs
ZCBiZSB1bmFsbG9jYXRlZC4uDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K
