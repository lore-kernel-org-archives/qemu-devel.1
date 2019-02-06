Received: from eggs.gnu.org ([209.51.188.92]:53533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1grQr9-0004qr-8v
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 12:19:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1grQr7-0006iI-GY
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 12:19:27 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 6 Feb 2019 17:19:17 +0000
Message-ID: <6eb344a9-32a1-5031-2afb-0e1ab1fab2bc@virtuozzo.com>
References: <20190206170205.13061-1-jsnow@redhat.com>
In-Reply-To: <20190206170205.13061-1-jsnow@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <8723E446C182014ABC89622380CA0D16@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] blockdev: acquire aio_context for bitmap
 add/remove
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

YWRkIFBhb2xvDQoNCjA2LjAyLjIwMTkgMjA6MDIsIEpvaG4gU25vdyB3cm90ZToNCj4gV2hlbiBi
aXRtYXBzIGFyZSBwZXJzaXN0ZW50LCB0aGV5IG1heSBpbmN1ciBhIGRpc2sgcmVhZCBvciB3cml0
ZSB3aGVuIGJpdG1hcHMNCj4gYXJlIGFkZGVkIG9yIHJlbW92ZWQuIEZvciBjb25maWd1cmF0aW9u
cyBsaWtlIHZpcnRpby1kYXRhcGxhbmUsIGZhaWxpbmcgdG8NCj4gYWNxdWlyZSB0aGlzIGxvY2sg
d2lsbCBhYm9ydCBRRU1VIHdoZW4gZGlzayBJTyBvY2N1cnMuDQo+IA0KPiBXZSB1c2VkIHRvIGFj
cXVpcmUgYWlvX2NvbnRleHQgYXMgcGFydCBvZiB0aGUgYml0bWFwIGxvb2t1cCwgc28gcmUtaW50
cm9kdWNlDQo+IHRoZSBsb2NrIGZvciBqdXN0IHRoZSBjYXNlcyB0aGF0IGhhdmUgYW4gSU8gcGVu
YWx0eS4NCj4gDQo+IEZpeGVzOiBodHRwczovL2J1Z3ppbGxhLnJlZGhhdC5jb20vc2hvd19idWcu
Y2dpP2lkPTE2NzIwMTANCj4gUmVwb3J0ZWQtQnk6IEFpaHVhIExpYW5nIDxhbGlhbmdAcmVkaGF0
LmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogSm9obiBTbm93IDxqc25vd0ByZWRoYXQuY29tPg0KDQoN
Ci0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==
