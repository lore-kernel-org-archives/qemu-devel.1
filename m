Received: from eggs.gnu.org ([209.51.188.92]:39846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1gud7k-0005tD-M5
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 08:01:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1gud7U-0004OA-0A
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 08:01:42 -0500
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Date: Fri, 15 Feb 2019 13:01:14 +0000
Message-ID: <6d0fca98-6b40-786e-2bd9-5eba1134d0a7@virtuozzo.com>
References: <20190215091950.20270-1-dplotnikov@virtuozzo.com>
	<13099f7d-3c90-8aea-d118-47370eb3685b@redhat.com>
In-Reply-To: <13099f7d-3c90-8aea-d118-47370eb3685b@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <3D16D2E21E3F5740A6EA31E2B9259EE0@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] block: don't set the same context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Denis Lunev <den@virtuozzo.com>

DQoNCk9uIDE1LjAyLjIwMTkgMTU6MjksIEVyaWMgQmxha2Ugd3JvdGU6DQo+IE9uIDIvMTUvMTkg
MzoxOSBBTSwgRGVuaXMgUGxvdG5pa292IHdyb3RlOg0KPj4gQWRkcyBhIGZhc3QgcGF0aCBvbiBh
aW8gY29udGV4dCBzZXR0aW5nIHByZXZlbnRpbmcNCj4+IHVubmVjZXNzYXJ5IGNvbnRleHQgc2V0
dGluZyByb3V0aW5lLg0KPj4gQWxzbywgaXQgcHJldmVudHMgaXNzdWVzIHdpdGggY3ljbGljIHdh
bGsgb2YgY2hpbGQNCj4+IGJkcy1lcyBhcHBlYXJlZCBiZWNhdXNlIG9mIHJlZ2lzdHJpbmcgYWlv
IHdhbGtpbmcNCj4gDQo+IHJlZ2lzdGVyaW5nDQp3aWxsIGZpeCBpdA0KPiANCj4+IG5vdGlmaWVy
czoNCj4+DQo+IA0KPj4gVGhpcyBjYW4gaGFwcGVuIGJlY2F1c2Ugb2YgIm5ldyIgY29udGV4dCBh
dHRhY2htZW50IHRvIFZNIGRpc2sgYmRzLg0KPj4gV2hlbiBhdHRhY2hpbmcgYSBuZXcgY29udGV4
dCB0aGUgY29ycmVzcG9uZGluZyBhaW8gY29udGV4dCBoYW5kbGVyIGlzDQo+PiBjYWxsZWQgZm9y
IGVhY2ggb2YgYWlvX25vdGlmaWVycyByZWdpc3RlcmVkIG9uIHRoZSBWTSBkaXNrIGJkcyBjb250
ZXh0Lg0KPj4gQW1vbmcgdGhvc2UgaGFuZGxlcnMsIHRoZXJlIGlzIHRoZSBibG9ja19qb2JfYXR0
YWNoZWRfYWlvX2NvbnRleHQgaGFuZGxlcg0KPj4gd2hpY2ggc2V0cyBhIG5ldyBhaW8gY29udGV4
dCBmb3IgdGhlIGJsb2NrIGpvYiBiZHMuIFdoZW4gZG9pbmcgc28sDQo+PiB0aGUgb2xkIGNvbnRl
eHQgaXMgZGV0YWNoZWQgZnJvbSBhbGwgdGhlIGJsb2NrIGpvYiBiZHMgY2hpbGRyZW4gYW5kIG9u
ZSBvZg0KPj4gdGhlbSBpcyB0aGUgVk0gZGlzayBiZHMsIHNlcnZpbmcgYXMgYmFja2luZyBzdG9y
ZSBmb3IgdGhlIGJsb2Nram9iIGJkcywNCj4+IGFsdGhvdWdoIHRoZSBWTSBkaXNrIGJkcyBpcyBh
Y3R1YWxseSB0aGUgaW5pdGlhbGl6ZXIgb2YgdGhhdCBwcm9jZXNzLg0KPj4gU2luY2UgdGhlIFZN
IGRpc2sgYmRzIGlzIHByb3RlY3RlZCB3aXRoIHdhbGtpbmdfYWlvX25vdGlmaWVycyBmbGFnDQo+
PiBmcm9tIGRvdWJsZSBwcm9jZXNzaW5nIGluIHJlY3Vyc2l2ZSBjYWxscywgdGhlIGFzc2VydCBm
aXJlcy4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBEZW5pcyBQbG90bmlrb3YgPGRwbG90bmlrb3ZA
dmlydHVvenpvLmNvbT4NCj4+IC0tLQ0KPj4gICBibG9jay5jIHwgNCArKysrDQo+PiAgIDEgZmls
ZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykNCj4+DQo+IA0KPiBOYWl2ZSBxdWVzdGlvbiAtIGRv
IHdlIGhhdmUgdG8gYWx3YXlzIGNhbGwNCj4gYXR0YWNoX2Fpb19jb250ZXh0L2RldGFjaF9haW9f
Y29udGV4dCBpbiBwYWlycz8NCnNlZW1zLCB0byBiZSBzby4gdGhlIG9ubHkgdXNlciBkb2luZyBh
dHRhY2gvZGV0YWNoIGlzIGJkcnZfc2V0X2Fpb19jb250ZXh0DQogICBJZiBzbywgd2lsbA0KPiBz
aG9ydC1jaXJjdWl0aW5nIGEgbmVzdGVkIGF0dGFjaCBjYXVzZSByZWZlcmVuY2UgY291bnQgcHJv
YmxlbXMgd2hlbiB3ZQ0KPiBjb21lIHRvIHRoZSBtYXRjaGluZyBkZXRhY2ggY2FsbHM/DQpJIGRv
bid0IHF1aXRlIHVuZGVyc3RhbmQuIEkgc3VnZ2VzdGVkIHRoZSBzaG9ydCBjaXJjdWl0IGZvciAN
CmJkcnZfc2V0X2Fpb19jb250ZXh0IHdoaWNoIGFjdHVhbGx5IHBhaXJzIGF0dGFjaC9kZXRhY2gg
Y29udGV4dC4gU28sIHRoZSANCnBhaXJpbmcgaGVyZSBzaG91bGQgYmUgYSBwcm9ibGVtDQo+IA0K
DQotLSANCkJlc3QsDQpEZW5pcw0K
