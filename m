Received: from eggs.gnu.org ([2001:4830:134:3::10]:43900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gVHMd-0001IZ-60
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 09:44:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gVHMc-0003rQ-HR
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 09:44:23 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 7 Dec 2018 14:44:12 +0000
Message-ID: <4017b0bb-8ac7-d15c-3a02-436eead73971@virtuozzo.com>
References: <20181205144700.26563-1-vsementsov@virtuozzo.com>
	<20181205144700.26563-6-vsementsov@virtuozzo.com>
	<20181206105430.GN29540@redhat.com>
In-Reply-To: <20181206105430.GN29540@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <A141B519BB210E4FAE6496E4594F3ECD@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 5/5] crypto: support multiple threads
 accessing one QCryptoBlock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "mreitz@redhat.com" <mreitz@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>

MDYuMTIuMjAxOCAxMzo1NCwgRGFuaWVsIFAuIEJlcnJhbmfDqSB3cm90ZToNCj4+IEBAIC0zMSw4
ICszMiwxMiBAQCBzdHJ1Y3QgUUNyeXB0b0Jsb2NrIHsNCj4+ICAgICAgIGNvbnN0IFFDcnlwdG9C
bG9ja0RyaXZlciAqZHJpdmVyOw0KPj4gICAgICAgdm9pZCAqb3BhcXVlOw0KPj4gICANCj4+IC0g
ICAgUUNyeXB0b0NpcGhlciAqY2lwaGVyOw0KPj4gKyAgICBRQ3J5cHRvQ2lwaGVyICoqY2lwaGVy
czsNCj4+ICsgICAgaW50IG5fY2lwaGVyczsNCj4+ICsgICAgaW50IG5fZnJlZV9jaXBoZXJzOw0K
PiBzaXplX3QgZm9yIGJvdGggb2YgdGhlc2Ugc2luY2UgdGhleSdyZSBlZmZlY3RpdmVseSBhcnJh
eSBpbmRleGVzLg0KPiANCj4+ICAgICAgIFFDcnlwdG9JVkdlbiAqaXZnZW47DQo+PiArICAgIFFl
bXVNdXRleCBtdXRleDsNCj4+ICsNCj4+ICAgICAgIFFDcnlwdG9IYXNoQWxnb3JpdGhtIGtkZmhh
c2g7DQo+PiAgICAgICBzaXplX3Qgbml2Ow0KPj4gICAgICAgdWludDY0X3QgcGF5bG9hZF9vZmZz
ZXQ7IC8qIEluIGJ5dGVzICovDQo+PiBAQCAtNDYsNiArNTEsNyBAQCBzdHJ1Y3QgUUNyeXB0b0Js
b2NrRHJpdmVyIHsNCj4+ICAgICAgICAgICAgICAgICAgIFFDcnlwdG9CbG9ja1JlYWRGdW5jIHJl
YWRmdW5jLA0KPj4gICAgICAgICAgICAgICAgICAgdm9pZCAqb3BhcXVlLA0KPj4gICAgICAgICAg
ICAgICAgICAgdW5zaWduZWQgaW50IGZsYWdzLA0KPj4gKyAgICAgICAgICAgICAgICBpbnQgbl90
aHJlYWRzLA0KPiB1bnNpZ25lZCBpbnQsIGFuZCBtb3JlIGJlbG93IHdoaWNoIEkgd29uJ3QgcmVw
ZWF0Li4uDQo+IA0KDQpXaHkgbm90IHNpemVfdCBoZXJlLCB0aGVuPyB0aGlzIHBhcmFtZXRlciBk
aXJlY3RseSBtYXBzIGludG8gbl9jaXBoZXJzDQoNCg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZs
YWRpbWlyDQo=
