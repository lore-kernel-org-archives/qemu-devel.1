Received: from eggs.gnu.org ([209.51.188.92]:46165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1ghXD5-0001Ji-BR
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 05:05:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1ghXD4-0007x6-Eg
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 05:05:11 -0500
From: Leonid Bloch <lbloch@janustech.com>
Date: Thu, 10 Jan 2019 10:04:59 +0000
Message-ID: <91dfd3e9-7293-4301-e3ac-852d8a038d4e@janustech.com>
References: <20190103213320.2653-1-lbloch@janustech.com>
	<20190103213320.2653-2-lbloch@janustech.com>
	<20190108122021.GB11492@linux.fritz.box>
In-Reply-To: <20190108122021.GB11492@linux.fritz.box>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <0E54482364786A44A9DF0AF147E28F99@namprd07.prod.outlook.com>
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
To: Kevin Wolf <kwolf@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Stefan Weil <sw@weilnetz.de>, Max Reitz <mreitz@redhat.com>, =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>, Alberto Garcia <berto@igalia.com>, Markus Armbruster <armbru@redhat.com>

SGksDQoNCk9uIDEvOC8xOSAyOjIwIFBNLCBLZXZpbiBXb2xmIHdyb3RlOg0KPiBBbSAwMy4wMS4y
MDE5IHVtIDIyOjMzIGhhdCBMZW9uaWQgQmxvY2ggZ2VzY2hyaWViZW46DQo+PiBUaGUgbG9va3Vw
IHRhYmxlIGZvciBwb3dlci1vZi10d28gc2l6ZXMgaXMgbm93IGF1dG8tZ2VuZXJhdGVkIGR1cmlu
ZyB0aGUNCj4+IGJ1aWxkLCBhbmQgbm90IGhhcmQtY29kZWQgaW50byB0aGUgdW5pdHMuaCBmaWxl
Lg0KPj4NCj4+IFRoaXMgcGFydGlhbGx5IHJldmVydHMgY29tbWl0IDU0MGI4NDkyNjE4ZWIuDQo+
Pg0KPj4gU2lnbmVkLW9mZi1ieTogTGVvbmlkIEJsb2NoIDxsYmxvY2hAamFudXN0ZWNoLmNvbT4N
Cj4gDQo+IER1cmluZyBhIGRvd25zdHJlYW0gcmV2aWV3LCBNYXggZm91bmQgYSBwcm9ibGVtIHdp
dGggdGhlIHRhYmxlIHRoYXQgd2UNCj4gY291bGQgZml4IHdoaWxlIHdlJ3JlIHRvdWNoaW5nIGl0
Og0KPiANCj4gICAgICBVcHN0cmVhbTogQWxsID49IFNfMkdpQiBhcmUgbm90IHZhbGlkIGludHMu
ICAocWVtdSBhc3N1bWVzIHRoYXQNCj4gICAgICBzaXplb2YoaW50KSA9PSA0LCByaWdodD8pICBT
byBTXzJHaUIgc2hvdWxkIGJlIDIxNDc0ODM2NDh1IGFuZCBhbGwNCj4gICAgICBhYm92ZSBzaG91
bGQgYmUgLi4udWxsIG9yIGJldHRlciBVSU5UNjRfQygpLg0KDQpCdXQgdGhlIGluaXRpYWwgcmVh
c29uaW5nIGZvciB0aGlzIHRhYmxlIHdhcyB0byBoYXZlIGEgcHVyZSBudW1iZXIgDQp0aGVyZS4g
SWYgdGhlcmUgd2lsbCBiZSBzdHJpbmdzIGxpa2UgIjIxNDc0ODM2NDh1L3VsbCIgb3IgDQoiVUlO
VDY0X0MoLi4uKSIgdGhlcmUsIHRoZXkgd2lsbCBiZSBzdHJpbmdpZmllZCwgbGl0ZXJhbGx5LCBh
bmQgd2lsbCANCmFwcGVhciBhcyBzdWNoIGluc2lkZSB0aGUgYmluYXJ5LiBJZiBzcGVjaWZ5aW5n
IHRoZSB1bml0NjQgdHlwZSBpcyANCnJlYWxseSBuZWVkZWQsIG9uZSBjYW4gYWx3YXlzIHVzZSwg
ZS5nLiwgMiAqIEdpQiwgZnJvbSB1bml0cy5oLg0KDQpMZW9uaWQuDQo=
