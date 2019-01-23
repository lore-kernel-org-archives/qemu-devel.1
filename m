Received: from eggs.gnu.org ([209.51.188.92]:38555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gmHOd-0002Ua-2M
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 07:12:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gmHH1-0005dB-O0
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 07:04:57 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 23 Jan 2019 12:04:40 +0000
Message-ID: <340bf08d-57ff-c6b3-13f4-b7c1b0a5e707@virtuozzo.com>
References: <20190110132048.49451-1-vsementsov@virtuozzo.com>
	<20190111104126.GC5010@dhcp-200-186.str.redhat.com>
	<b504e946-205c-8800-fe2c-e11f0b27c23a@virtuozzo.com>
	<20190122185740.GC5220@localhost.localdomain>
In-Reply-To: <20190122185740.GC5220@localhost.localdomain>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <9932CF8ADA5AB04DBD6681BCD7A8CF4E@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] block: don't probe zeroes in bs->file by
 default on block_status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "armbru@redhat.com" <armbru@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, "fam@euphon.net" <fam@euphon.net>, "stefanha@redhat.com" <stefanha@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, Denis Lunev <den@virtuozzo.com>

MjIuMDEuMjAxOSAyMTo1NywgS2V2aW4gV29sZiB3cm90ZToNCj4gQW0gMTEuMDEuMjAxOSB1bSAx
Mjo0MCBoYXQgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSBnZXNjaHJpZWJlbjoNCj4+IDEx
LjAxLjIwMTkgMTM6NDEsIEtldmluIFdvbGYgd3JvdGU6DQo+Pj4gQW0gMTAuMDEuMjAxOSB1bSAx
NDoyMCBoYXQgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSBnZXNjaHJpZWJlbjoNCj4+Pj4g
ZHJ2X2NvX2Jsb2NrX3N0YXR1cyBkaWdzIGJzLT5maWxlIGZvciBhZGRpdGlvbmFsLCBtb3JlIGFj
Y3VyYXRlIHNlYXJjaA0KPj4+PiBmb3IgaG9sZSBpbnNpZGUgcmVnaW9uLCByZXBvcnRlZCBhcyBE
QVRBIGJ5IGJzIHNpbmNlIDVkYWE3NGE2ZWJjLg0KPj4+Pg0KPj4+PiBUaGlzIGFjY3VyYWN5IGlz
IG5vdCBmcmVlOiBhc3N1bWUgd2UgaGF2ZSBxY293MiBkaXNrLiBBY3R1YWxseSwgcWNvdzINCj4+
Pj4ga25vd3MsIHdoZXJlIGFyZSBob2xlcyBhbmQgd2hlcmUgaXMgZGF0YS4gQnV0IGV2ZXJ5IGJs
b2NrX3N0YXR1cw0KPj4+PiByZXF1ZXN0IGNhbGxzIGxzZWVrIGFkZGl0aW9uYWxseS4gQXNzdW1l
IGEgYmlnIGRpc2ssIGZ1bGwgb2YNCj4+Pj4gZGF0YSwgaW4gYW55IGl0ZXJhdGl2ZSBjb3B5aW5n
IGJsb2NrIGpvYiAob3IgaW1nIGNvbnZlcnQpIHdlJ2xsIGNhbGwNCj4+Pj4gbHNlZWsoSE9MRSkg
b24gZXZlcnkgaXRlcmF0aW9uLCBhbmQgZWFjaCBvZiB0aGVzZSBsc2Vla3Mgd2lsbCBoYXZlIHRv
DQo+Pj4+IGl0ZXJhdGUgdGhyb3VnaCBhbGwgbWV0YWRhdGEgdXAgdG8gdGhlIGVuZCBvZiBmaWxl
LiBJdCdzIG9idmlvdXNseQ0KPj4+PiBpbmVmZmVjdGl2ZSBiZWhhdmlvci4gQW5kIGZvciBtYW55
IHNjZW5hcmlvcyB3ZSBkb24ndCBuZWVkIHRoaXMgbHNlZWsNCj4+Pj4gYXQgYWxsLg0KPj4+Pg0K
Pj4+PiBTbywgbGV0J3MgIjVkYWE3NGE2ZWJjIiBieSBkZWZhdWx0LCBsZWF2aW5nIGFuIG9wdGlv
biB0byByZXR1cm4NCj4+Pj4gcHJldmlvdXMgYmVoYXZpb3IsIHdoaWNoIGlzIG5lZWRlZCBmb3Ig
c2NlbmFyaW9zIHdpdGggcHJlYWxsb2NhdGVkDQo+Pj4+IGltYWdlcy4NCj4+Pj4NCj4+Pj4gQWRk
IGlvdGVzdCBpbGx1c3RyYXRpbmcgbmV3IG9wdGlvbiBzZW1hbnRpY3MuDQo+Pj4+DQo+Pj4+IFNp
Z25lZC1vZmYtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmly
dHVvenpvLmNvbT4NCj4+Pg0KPj4+IEkgc3RpbGwgdGhpbmsgdGhhdCBhbiBvcHRpb24gaXNuJ3Qg
YSBnb29kIHNvbHV0aW9uIGFuZCB3ZSBzaG91bGQgdHJ5IHVzZQ0KPj4+IHNvbWUgaGV1cmlzdGlj
cyBpbnN0ZWFkLg0KPj4NCj4+IERvIHlvdSB0aGluayB0aGF0IGhldXJpc3RpY3Mgd291bGQgYmUg
YmV0dGVyIHRoYW4gZmFpciBjYWNoZSBmb3IgbHNlZWsgcmVzdWx0cz8NCj4gDQo+IEkganVzdCBw
bGF5ZWQgYSBiaXQgd2l0aCB0aGlzIChxZW11LWltZyBjb252ZXJ0IG9ubHkpLCBhbmQgaG93IG11
Y2gNCj4gY2FjaGluZyBsc2VlaygpIHJlc3VsdHMgaGVscHMgZGVwZW5kcyBjb21wbGV0ZWx5IG9u
IHRoZSBpbWFnZS4gQXMgaXQNCj4gaGFwcGVuZWQsIG15IHRlc3QgaW1hZ2Ugd2FzIHRoZSB3b3Jz
dCBjYXNlIHdoZXJlIGNhY2hpbmcgZGlkbid0IGJ1eSB1cw0KPiBtdWNoLiBPYnZpb3VzbHksIEkg
Y2FuIGp1c3QgYXMgZWFzaWx5IGNvbnN0cnVjdCBhbiBpbWFnZSB3aGVyZSBpdCBtYWtlcw0KPiBh
IGh1Z2UgZGlmZmVyZW5jZS4gSSB0aGluayB0aGF0IG1vc3QgcmVhbC13b3JsZCBpbWFnZXMgc2hv
dWxkIGJlIGFibGUgdG8NCj4gdGFrZSBnb29kIGFkdmFudGFnZSBvZiBpdCwgdGhvdWdoLCBhbmQg
aXQgZG9lc24ndCBodXJ0LCBzbyBtYXliZSB0aGF0J3MNCj4gYSBmaXJzdCB0aGluZyB0aGF0IHdl
IGNhbiBkbyBpbiBhbnkgY2FzZS4gSXQgbWlnaHQgbm90IGJlIHRoZSBjb21wbGV0ZQ0KPiBzb2x1
dGlvbiwgdGhvdWdoLg0KDQpIbW0sIGFuZCBvbmUgbW9yZSBpZGVhIGZyb20gRGVuOg0KDQpXZSBj
YW4gZGV0ZWN0IHByZWFsbG9jYXRlZCBpbWFnZSwgY29tcGFyaW5nIGFsbG9jYXRlZCBzaXplIG9m
IHJlYWwgZmlsZSB3aXRoDQpudW1iZXIgb2Ygbm9uLXplcm8gcWNvdzIgcmVmY291bnRzLiBTbywg
cmVhbCBhbGxvY2F0aW9uIGlzIG11Y2ggbGVzcyB0aGFuDQphbGxvY2F0aW9uIGluIHFjb3cyIHBv
aW50IG9mIHZpZXcsIHdlJ2xsIGVuYWJsZSBsc2Vla3MsIG90aGVyd2lzZSAtIG5vdC4NCg0KLS0g
DQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K
