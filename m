Received: from eggs.gnu.org ([209.51.188.92]:54930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gmIcm-0007S6-RX
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 08:31:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gmIci-0007xO-UX
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 08:31:22 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 23 Jan 2019 13:31:12 +0000
Message-ID: <1b3d637d-f559-905f-69fb-da24fd697ad0@virtuozzo.com>
References: <20181229122027.42245-1-vsementsov@virtuozzo.com>
	<20181229122027.42245-6-vsementsov@virtuozzo.com>
	<a4565e50-b670-333e-a3db-72ff5a42b776@redhat.com>
	<084ff0b6-1de8-1c17-f085-97a8b1aeb8b5@virtuozzo.com>
	<fab4d292-ea59-5e1f-ec43-486abc455e7c@redhat.com>
	<76562236-6535-a064-e8ed-6c2c2e285ac5@virtuozzo.com>
In-Reply-To: <76562236-6535-a064-e8ed-6c2c2e285ac5@virtuozzo.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <14F38ECD9A18574C8D046FCDC7F600F1@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v5 05/11] iotests: allow resume_drive by
 node name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "fam@euphon.net" <fam@euphon.net>, "stefanha@redhat.com" <stefanha@redhat.com>, "jcody@redhat.com" <jcody@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>, "eblake@redhat.com" <eblake@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>

MjMuMDEuMjAxOSAxNjoyMiwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4g
MTYuMDEuMjAxOSAxNjoxMSwgTWF4IFJlaXR6IHdyb3RlOg0KPj4gT24gMTQuMDEuMTkgMTc6MDYs
IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgd3JvdGU6DQo+Pj4gMTQuMDEuMjAxOSAxNzo0
NiwgTWF4IFJlaXR6IHdyb3RlOg0KPj4+PiBPbiAyOS4xMi4xOCAxMzoyMCwgVmxhZGltaXIgU2Vt
ZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+Pj4+IEFmdGVyIG5vZGUgZ3JhcGggY2hhbmdlcywg
d2UgbWF5IG5vdCBiZSBhYmxlIHRvIHJlc3VtZV9kcml2ZSBieSBkZXZpY2UNCj4+Pj4+IG5hbWUg
KGJhY2tpbmcgZmlsZXMgYXJlIG5vdCByZWN1cnNpdmVseSBzZWFyY2hlZCkuIFNvLCBsZXRzIGFs
bG93IHRvDQo+Pj4+PiByZXN1bWUgYnkgbm9kZS1uYW1lLiBTZXQgY29uc3RhbnQgbmFtZSBmb3Ig
YnJlYWtwb2ludHMsIHRvIGF2b2lkDQo+Pj4+PiBpbnRyb2R1Y2luZyBleHRyYSBwYXJhbWV0ZXJz
Lg0KPj4+Pg0KPj4+PiBIbSwgSSBkb24ndCBxdWl0ZSB1bmRlcnN0YW5kIHRoaXMgcmVhc29uLsKg
IElzIHRoaXMgc28geW91IGNhbiBjcmVhdGUNCj4+Pj4gYnJlYWtwb2ludHMgb24gb25lIG5vZGUg
KHdoaWNoIGZhbGxzIHRocm91Z2ggdG8gdGhlIGZpcnN0IGJsa2RlYnVnIG5vZGUpDQo+Pj4+IGFu
ZCB0aGVuIHJlbW92ZSB0aGVtIGZyb20gYW5vdGhlciAoZmFsbGluZyB0aHJvdWdoIHRvIHRoZSBz
YW1lIGJsa2RlYnVnDQo+Pj4+IG5vZGUpPw0KPj4+DQo+Pj4gYWRkL3JlbW92ZSBicmVha3BvaW50
IGdvZXMgdGhyb3VnaCAtPmZpbGUgY2hpbGRyZW4sIGJ1dCBteSBmaWx0ZXIgbGlua3MNCj4+PiBh
Y3RpdmUgZGlzayBhcyAtPmJhY2tpbmcuIFNvLCBiZWZvcmUgYmxvY2stam9iIHN0YXJ0IHdlIGNh
biBpbnNlcnQgYnJlYWtwb2ludA0KPj4+IGJ5IGRldmljZSBuYW1lLiBCdXQgdGhlbiwgd2hlbiBm
aWx0ZXIgaW5zZXJ0ZWQsIHdlIGNhbid0IHJlbW92ZSBicmVha3BvaW50LA0KPj4+IGJlY2F1c2Ug
bXkgZmlsdGVyIGhpZGVzIGJsa2RlYnVnIHdpdGggYWN0aXZlIGRpc2sgdW5kZXIgLT5iYWNraW5n
IGxpbmsuDQo+Pj4NCj4+PiBNYXliZSwgcmlnaHQgc29sdXRpb24gd291bGQgYmUgc3VwcG9ydCBi
YWNraW5nIGxpbmtzIGluIGJkcnZfZGVidWdfYnJlYWtwb2ludCgpDQo+Pj4gYW5kIGJkcnZfZGVi
dWdfcmVtb3ZlX2JyZWFrcG9pbnQoKSBmb3IgdGhlIGNhc2Ugd2hlbiB0aGVyZSBpcyBubyBmaWxl
IGNoaWxkLg0KPj4+DQo+Pj4gQnV0IGJlaW5nIHVuc3VyZSBhYm91dCByaWdodCBiZWhhdmlvciwg
SSd2ZSBkZWNpZGVkIHRvIGFkanVzdCB0aGUgdGVzdC4NCj4+Pg0KPj4+IFdoYXQgYWJvdXQganVz
dCBkbyBib3RowqAgYWRkL3JlbW92ZSBicmVha3BvaW50IHRocm91Z2ggYmxrZGVidWcgbm9kZS1u
YW1lLCB0bw0KPj4+IG1ha2UgaXQgbGVzcyB3ZWlyZD8NCj4+DQo+PiBZZXMsIEkgd2FzIG1vc3Rs
eSB3b25kZXJpbmcgYWJvdXQgdGhlICJzZXQgY29uc3RhbnQgbmFtZSBmb3INCj4+IGJyZWFrcG9p
bnRzIi7CoCBJdCBkb2Vzbid0IHNlZW0gbmVjZXNzYXJ5IHRvIG1lOw0KPiANCj4gSXQncyBqdXN0
IHRvIG5vdCBjcmVhdGUgZXh0cmEgcGFyYW1ldGVycyBvciBzb21ldGhpbmcuIEN1cnJlbnQgY29k
ZSBkb24ndCBhbGxvdw0KPiB0byBjcmVhdGUgc2V2ZXJhbCBicmVha3BvaW50cyBpbiBvbmUgYmxr
ZGVidWcgYW55d2F5IChhcyBAZHJpdmUgaXMgdXNlZCBhcw0KPiBicmVha3BvaW50IG5hbWUpLCBz
byB0aGVyZSBpcyBubyByZWFzb24gZm9yIGRpZmZlcmVudCBuYW1lcyBhdCBhbGwuDQo+IA0KPiBJ
J2xsIGltcHJvdmUgY29tbWl0IG1lc3NhZ2UgdG8gbWFrZSBpdCBjbGVhbi4NCj4gDQoNCkhtbW0u
DQoNCk9yLCBmaW5hbGx5LCBtYXkgYmUgYmV0dGVyIHRvIHRlYWNoIGJkcnZfZGVidWdfYnJlYWtw
b2ludCgpIGFuZA0KYmRydl9kZWJ1Z19yZW1vdmVfYnJlYWtwb2ludCgpIHRvIHNraXAgZmlsdGVy
cyB3aXRoIGJhY2tpbmcgY2hpbGQ/DQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K
