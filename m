Received: from eggs.gnu.org ([209.51.188.92]:49391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1ghdaN-0006IV-BM
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 11:53:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1ghdaL-0008Re-W6
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 11:53:39 -0500
From: Leonid Bloch <lbloch@janustech.com>
Date: Thu, 10 Jan 2019 16:53:24 +0000
Message-ID: <316c67a6-54aa-3312-1994-64baec94c164@janustech.com>
References: <20190103213320.2653-1-lbloch@janustech.com>
	<20190103213320.2653-2-lbloch@janustech.com>
	<20190108122021.GB11492@linux.fritz.box>
	<91dfd3e9-7293-4301-e3ac-852d8a038d4e@janustech.com>
	<87d0p4he0v.fsf@dusky.pond.sub.org>
In-Reply-To: <87d0p4he0v.fsf@dusky.pond.sub.org>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <05C4841422F91B41836B1D3ADBB56DBF@namprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 1/1] include: Auto-generate the sizes
 lookup table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Stefan Weil <sw@weilnetz.de>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>

T24gMS8xMC8xOSAyOjUxIFBNLCAgd3JvdGU6DQo+IExlb25pZCBCbG9jaCA8bGJsb2NoQGphbnVz
dGVjaC5jb20+IHdyaXRlczoNCj4gDQo+PiBIaSwNCj4+DQo+PiBPbiAxLzgvMTkgMjoyMCBQTSwg
S2V2aW4gV29sZiB3cm90ZToNCj4+PiBBbSAwMy4wMS4yMDE5IHVtIDIyOjMzIGhhdCBMZW9uaWQg
QmxvY2ggZ2VzY2hyaWViZW46DQo+Pj4+IFRoZSBsb29rdXAgdGFibGUgZm9yIHBvd2VyLW9mLXR3
byBzaXplcyBpcyBub3cgYXV0by1nZW5lcmF0ZWQgZHVyaW5nIHRoZQ0KPj4+PiBidWlsZCwgYW5k
IG5vdCBoYXJkLWNvZGVkIGludG8gdGhlIHVuaXRzLmggZmlsZS4NCj4+Pj4NCj4+Pj4gVGhpcyBw
YXJ0aWFsbHkgcmV2ZXJ0cyBjb21taXQgNTQwYjg0OTI2MThlYi4NCj4+Pj4NCj4+Pj4gU2lnbmVk
LW9mZi1ieTogTGVvbmlkIEJsb2NoIDxsYmxvY2hAamFudXN0ZWNoLmNvbT4NCj4+Pg0KPj4+IER1
cmluZyBhIGRvd25zdHJlYW0gcmV2aWV3LCBNYXggZm91bmQgYSBwcm9ibGVtIHdpdGggdGhlIHRh
YmxlIHRoYXQgd2UNCj4+PiBjb3VsZCBmaXggd2hpbGUgd2UncmUgdG91Y2hpbmcgaXQ6DQo+Pj4N
Cj4+PiAgICAgICBVcHN0cmVhbTogQWxsID49IFNfMkdpQiBhcmUgbm90IHZhbGlkIGludHMuICAo
cWVtdSBhc3N1bWVzIHRoYXQNCj4+PiAgICAgICBzaXplb2YoaW50KSA9PSA0LCByaWdodD8pICBT
byBTXzJHaUIgc2hvdWxkIGJlIDIxNDc0ODM2NDh1IGFuZCBhbGwNCj4+PiAgICAgICBhYm92ZSBz
aG91bGQgYmUgLi4udWxsIG9yIGJldHRlciBVSU5UNjRfQygpLg0KPiANCj4gU28gdGhlaXIgKGlu
dGVnZXIpIHR5cGUgY2FuIHZhcnkuICBXaGV0aGVyIHRoYXQncyBhIHByb2JsZW0gZGVwZW5kcyBv
bg0KPiBob3cgdGhlIG1hY3JvcyBhcmUgdXNlZC4NCj4gDQo+PiBCdXQgdGhlIGluaXRpYWwgcmVh
c29uaW5nIGZvciB0aGlzIHRhYmxlIHdhcyB0byBoYXZlIGEgcHVyZSBudW1iZXINCj4+IHRoZXJl
LiBJZiB0aGVyZSB3aWxsIGJlIHN0cmluZ3MgbGlrZSAiMjE0NzQ4MzY0OHUvdWxsIiBvcg0KPj4g
IlVJTlQ2NF9DKC4uLikiIHRoZXJlLCB0aGV5IHdpbGwgYmUgc3RyaW5naWZpZWQsIGxpdGVyYWxs
eSwgYW5kIHdpbGwNCj4+IGFwcGVhciBhcyBzdWNoIGluc2lkZSB0aGUgYmluYXJ5Lg0KPiANCj4g
Ik1hY3JvIHRoYXQgZXhwYW5kcyB0byBhbiBpbnRlZ2VyIGNvbnN0YW50IHRoYXQgc3RyaW5naWZ5
KCkgdHVybnMgaW50byBhDQo+IGRlY2ltYWwgbnVtYmVyIiBpcyBhIHJhdGhlciBwZWN1bGlhciBj
b250cmFjdC4NCj4gDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIElmIHNw
ZWNpZnlpbmcgdGhlIHVuaXQ2NCB0eXBlIGlzDQo+PiByZWFsbHkgbmVlZGVkLCBvbmUgY2FuIGFs
d2F5cyB1c2UsIGUuZy4sIDIgKiBHaUIsIGZyb20gdW5pdHMuaC4NCj4gDQo+IFJpZ2h0IG5vdyBJ
IHN1c3BlY3QgdGhlc2UgU18gbWFjcm9zIHNob3VsZCBnZW5lcmFsbHkgYmUgYXZvaWRlZC4NCj4g
DQo+IFdlIGhhdmUgNTQgb2YgdGhlbS4gIEkgY291bnQgc2l4IHVzZXM6DQo+IA0KPiAgICAgIGJs
b2NrL3Fjb3cyLmg6I2RlZmluZSBRQ09XX01BWF9SRUZUQUJMRV9TSVpFIFNfOE1pQg0KPiAgICAg
IGJsb2NrL3Fjb3cyLmg6I2RlZmluZSBRQ09XX01BWF9MMV9TSVpFIFNfMzJNaUINCj4gICAgICBi
bG9jay9xY293Mi5oOiNkZWZpbmUgREVGQVVMVF9MMl9DQUNIRV9NQVhfU0laRSBTXzMyTWlCDQo+
ICAgICAgYmxvY2svcWNvdzIuaDojZGVmaW5lIERFRkFVTFRfTDJfQ0FDSEVfTUFYX1NJWkUgU184
TWlCDQo+ICAgICAgYmxvY2svcWNvdzIuaDojZGVmaW5lIERFRkFVTFRfQ0xVU1RFUl9TSVpFIFNf
NjRLaUINCj4gICAgICBibG9jay92ZGkuYzojZGVmaW5lIERFRkFVTFRfQ0xVU1RFUl9TSVpFIFNf
MU1pQg0KPiANCj4gV2hpY2ggaWYgdGhlbSB0cnVseSBuZWVkIHN0cmluZ2lmeS1hYmxlIGludGVn
ZXJzPw0KPiANCg0KVGhlc2UgdHdvOg0KDQpibG9jay9xY293Mi5oOiNkZWZpbmUgREVGQVVMVF9D
TFVTVEVSX1NJWkUNCmJsb2NrL3ZkaS5jOiNkZWZpbmUgREVGQVVMVF9DTFVTVEVSX1NJWkUuDQo=
