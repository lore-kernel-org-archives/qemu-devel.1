Received: from eggs.gnu.org ([208.118.235.92]:59255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gbLZV-00063T-0e
	for qemu-devel@nongnu.org; Mon, 24 Dec 2018 03:26:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gbLZU-0000WQ-8i
	for qemu-devel@nongnu.org; Mon, 24 Dec 2018 03:26:45 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 24 Dec 2018 08:26:30 +0000
Message-ID: <51f70267-9f79-807a-6559-da724f6ea32c@virtuozzo.com>
References: <20181221093529.23855-1-jsnow@redhat.com>
	<20181221093529.23855-10-jsnow@redhat.com>
	<785c6911-3871-2fc0-d7ea-b09246fb9f1d@virtuozzo.com>
	<45e11a42-da20-9998-574c-e88fc802918a@redhat.com>
In-Reply-To: <45e11a42-da20-9998-574c-e88fc802918a@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <F85A63252462D644A6E2A95631E4E266@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v6 09/11] iotests: change qmp_log filters
 to expect QMP objects only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "eblake@redhat.com" <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>, Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>

MjEuMTIuMjAxOCAyMzoxMywgSm9obiBTbm93IHdyb3RlOg0KPiANCj4gDQo+IE9uIDEyLzIxLzE4
IDc6NDEgQU0sIFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgd3JvdGU6DQo+PiBIbW0uIFRo
aXMgbWFkZSBtZSBjaGVjaywgaXMgZW51bWVyYXRlIGFwcGxpY2FibGUgdG8gZGljdHMsDQo+PiBh
bmQsIHllcyBpdCBpcy4NCj4+DQo+IA0KPiBlbnVtZXJhdGUgb24gZGljdHMgZ2l2ZXMgeW91IGEg
bnVtZXJpY2FsIGluZGV4IHBhaXJlZCB3aXRoIHRoZSBrZXksDQo+IHNvLi4uIGsgaXMgdGhlIG51
bWVyaWNhbCBpbmRleCBhbmQgdiBpcyB0aGUga2V5Lg0KDQpobW0sIHllcywgSSB3YXMgd3Jvbmcu
IE9rLCB0aGFuIEknbSBmaW5lIHdpdGggeW91ciBjb2RlLiBUYWtlIG15IHItYi4NCg0KPiANCj4+
IHNvLCBpdCBtYXkgYmUgYXMgZWFzeSBhcw0KPj4NCj4+ICAgICAgIGZvciBrLCB2IGluIGVudW1l
cmF0ZShxbXNnKToNCj4+ICAgICAgICAgICBpZiBpc2luc3RhbmNlKHYsIGxpc3QpIG9yIGlzaW5z
dGFuY2UodiwgZGljdCk6DQo+PiAgICAgICAgICAgICAgIHFtc2dba10gPSBmaWx0ZXJfcW1wKHYs
IGZpbHRlcl9mbikNCj4gDQo+ICAgICAgICAgICAgICAgICAgICAgIF4gdGhpcyB3aWxsIGJyZWFr
IGlmIHFtc2cgd2FzIGEgZGljdC4NCj4gDQo+PiAgICAgICAgICAgZWxzZToNCj4+ICAgICAgICAg
ICAgICAgcW1zZ1trXSA9IGZpbHRlcl9mbihrLCB2KQ0KPj4NCj4+IHdpdGggdGhpczoNCj4+IFJl
dmlld2VkLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1
b3p6by5jb20+DQo+Pg0KPj4NCj4+IEJ1dCBkb2VzIGl0IHdoYXQgeW91IHdhbnQ/DQo+PiBTbywg
Zm9yIGxpc3RzIG9mIHN0cmluZ3MsIGZpbHRlcl9mbiB3aWxsIGdldCBwYWlyIG9mIGluZGV4IGlu
IGFycmF5DQo+PiBhbmQgdmFsdWU/DQo+PiBPbiB0aGUgb3RoZXIgaGFuZCwgd2UgY2FuIGFkanVz
dCB0aGUgYmVoYXZpb3IgYXMgd2Ugd2FudCB3aGVuIHdlIGludHJvZHVjZQ0KPj4gc3VjaCBmaWx0
ZXJzLg0KPiANCj4gSSdtIG5vdCBzdXJlIHdoYXQgSSB3YW50Li4uDQo+IA0KPiBOYW1lZCBpbmRl
eCBpcyB0aGUgYmVzdCwgYnV0IGlzbid0IGFsd2F5cyBhdmFpbGFibGUgYmVjYXVzZSBsaWtlIHlv
dQ0KPiBzYXksIHRoZSBvYmplY3Qgd2UgYXJlIHBhc3NlZCBpcyBub3QgYWx3YXlzIGEgZGljdGlv
bmFyeS4gV2UgY291bGQNCj4gdGhlb3JldGljYWxseSBoYXZlIGEgbGlzdCBvZiBsaXN0cyBzb21l
d2hlcmUuIFdoYXQga2V5IHdvdWxkIEkgcGFzcw0KPiB0aGVuPyBJdCdzIG1lYW5pbmdsZXNzLg0K
PiANCj4gSSBjb3VsZCBjaGFuZ2UgcW1wX2ZpbHRlciB0byBwYXNzIHRoZSBrLHYgdG8gdGhlIGZp
bHRlciB3aGVuIGl0IGZpbmRzDQo+IHRoZSAibGFzdCBkaWN0aW9uYXJ5LCIgaS5lLiBpZiBpdCBy
ZWN1cnNpdmVseSBmaW5kcyBubyBtb3JlIGRpY3Rpb25hcmllcw0KPiB1bmRlcm5lYXRoLCBpdCBw
YXNzZXMgdGhlIHZhbHVlIGFsb25nIHJlZ2FyZGxlc3Mgb2Ygd2hhdGV2ZXIgaXQgZmluZHMuDQo+
IFRoaXMgaXMgYSBiaXQgbW9yZSBjb21wbGV4IGJlY2F1c2UgSSB0aGluayBJJ2QgbmVlZCBhIGNv
LW11dHVhbA0KPiByZWN1cnNpdmUgZnVuY3Rpb24gdG8gInRyYXZlbCIgZWFjaCB2YWx1ZSBhbmQg
cmVwb3J0IGlmIHRoZXJlIGFyZQ0KPiBmdXJ0aGVyIGRpY3Rpb25hcmllcyBkb3duIGJlbG93Lg0K
PiANCj4gT3IsIEkgY291bGQganVzdCBsZWF2ZSB0aGUgZmlsdGVyIGFzLWlzIHdoZXJlIGl0IG9u
bHkgZXZlciBnZXRzIG9uZSwNCj4gbm9uLWRpY3Qvbm9uLWxpc3QgaXRlbSBhbmQgcmVjZWl2ZXMg
YSBrZXkuIFNvbWV0aW1lcyB0aGUga2V5IHdpbGwgbm93IGJlDQo+IGEgbnVtZXJpY2FsIGluZGV4
IHdoaWNoIGlzIGxpa2VseSBub3QgdXNlZnVsLi4uDQo+IA0KPiBJIG1pZ2h0IHN0YWdlIHRoaXMg
YXMtaXMgZm9yIG5vdy4gTGV0J3MgcmV2aXNpdCBpdCBiZWZvcmUgNC4wIHJjMC4NCj4gDQo+IC0t
anMNCj4gDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K
