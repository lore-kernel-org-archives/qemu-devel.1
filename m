Received: from eggs.gnu.org ([208.118.235.92]:45157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1gfA3u-0005pv-PA
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 15:57:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1gfA3u-0007Tn-3c
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 15:57:54 -0500
From: Leonid Bloch <lbloch@janustech.com>
Date: Thu, 3 Jan 2019 20:57:45 +0000
Message-ID: <9df1a9a8-284b-573b-98aa-fd77edb0cd65@janustech.com>
References: <20190102110804.18155-1-lbloch@janustech.com>
	<20190102110804.18155-2-lbloch@janustech.com>
	<w51h8eqdroh.fsf@maestria.local.igalia.com>
In-Reply-To: <w51h8eqdroh.fsf@maestria.local.igalia.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <33CC8D65B9DE4548BEA4DCD34D875C6B@namprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 1/1] include: Auto-generate the sizes
 lookup table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Stefan Weil <sw@weilnetz.de>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>, Markus Armbruster <armbru@redhat.com>

SGkgQmVydG8sDQoNCk9uIDEvMy8xOSAxMjoxOSBQTSwgQWxiZXJ0byBHYXJjaWEgd3JvdGU6DQo+
IE9uIFdlZCAwMiBKYW4gMjAxOSAxMjowOTowNSBQTSBDRVQsIExlb25pZCBCbG9jaCB3cm90ZToN
Cj4+ICtwcmludF9zaXplcygpIHsNCj4+ICsgICAgbG9jYWwgcD0xMA0KPj4gKyAgICB3aGlsZSBb
ICR7cH0gLWx0IDY0IF0NCj4+ICsgICAgZG8NCj4+ICsgICAgICAgIGxvY2FsIHBhZD0nICcNCj4+
ICsgICAgICAgIGxvY2FsIG49JCgocCAlIDEwKSkNCj4+ICsgICAgICAgIG49JCgoMSA8PCBuKSkN
Cj4+ICsgICAgICAgIFsgJCgobiAvIDEwMCkpIC1lcSAwIF0gJiYgcGFkPScgICcNCj4+ICsgICAg
ICAgIFsgJCgobiAvIDEwKSkgLWVxIDAgXSAmJiBwYWQ9JyAgICcNCj4+ICsgICAgICAgIGxvY2Fs
IHN1ZmY9JCgocCAvIDEwKSkNCj4+ICsgICAgICAgIHByaW50ZiAiI2RlZmluZSBTXyV1JXMlcyUy
MHVcbiIgJHtufSAiJChzaXplX3N1ZmZpeCAke3N1ZmZ9KSIgXA0KPj4gKyAgICAgICAgICAgICIk
e3BhZH0iICQoKDEgPDwgcCkpDQo+PiArICAgICAgICBwPSQoKHAgKyAxKSkNCj4+ICsgICAgZG9u
ZQ0KPj4gK30NCj4gDQo+IEkgaGF2ZSB0byBzYXkgdGhhdCBJJ20gbm90IHZlcnkgY29udmluY2Vk
IG9mIHRoZSBiZW5lZml0cyBvZiByZXBsYWNpbmcgYQ0KPiBzZXQgb2YgdHJpdmlhbCBudW1lcmlj
IG1hY3JvcyB3aXRoIGEgbG9uZ2VyIGFuZCBoYXJkZXIgdG8gcmVhZCBzaGVsbA0KPiBzY3JpcHQg
YWNjb21wYW5pZWQgYnkgY2hhbmdlcyB0byB0aGUgYnVpbGQgc3lzdGVtLg0KDQpJIHRoaW5rIHRo
YXQgdGhlIGJlbmVmaXQgaXMgdGhhdCB0aGUgc2NyaXB0IGlzIGVhc2lseSB2ZXJpZmlhYmxlLCAN
CndoZXJlYXMgaWYgc29tZW9uZSB3b3VsZCBsaWtlIHRvIHZlcmlmeSB0aGUgdGFibGUsIHRoZXkg
d2lsbCBuZWVkIHRvIA0KZ2VuZXJhdGUgaXQgdGhlbXNlbHZlcy4gQWxzbywgdGhpcyB0YWJsZSBp
cyBhdXRvbWF0aWNhbGx5IGdlbmVyYXRlZCANCmFueXdheSwgc28gaXQgb25seSBtYWtlcyBzZW5z
ZSB0byBnZW5lcmF0ZSBpdCBkdXJpbmcgdGhlIGJ1aWxkLg0KDQoNCkxlb25pZC4NCg0KPiANCj4g
QmVydG8NCj4gDQo=
