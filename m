Received: from eggs.gnu.org ([209.51.188.92]:57529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1h1YT5-0001tc-8V
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 10:28:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1h1YT4-0006hy-BC
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 10:28:27 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 6 Mar 2019 15:28:20 +0000
Message-ID: <2329eba6-bba0-46ea-7960-b19eb16623d4@virtuozzo.com>
References: <20190305234337.18353-1-jsnow@redhat.com>
	<20190305234337.18353-4-jsnow@redhat.com>
In-Reply-To: <20190305234337.18353-4-jsnow@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <25790404EC217049AE69FF37D032E2ED@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 3/5] block/qcow2-bitmap: don't remove
 bitmaps on reopen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "eblake@redhat.com" <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

MDYuMDMuMjAxOSAyOjQzLCBKb2huIFNub3cgd3JvdGU6DQo+IFdlIHRlbmQgdG8gcmVtb3ZlIGJp
dG1hcHMgd2hlbiB3ZSBmbHVzaCB0aGVtIHRvIGRpc2ssIGJ1dCBpdCdzIG5vdCBhcHByb3ByaWF0
ZQ0KPiBpbiBhbGwgY2FzZXMuIGxldCB0aGUgcmVvcGVuIG1lY2hhbmlzbSB1c2UgdGhlIGxpZ2h0
ZXIgd2VpZ2h0IGZsdXNoIGluc3RlYWQgb2YNCj4gdGhlIGhlYXZpZXIgc3RvcmUuDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBKb2huIFNub3cgPGpzbm93QHJlZGhhdC5jb20+DQo+IC0tLQ0KPiAgIGJs
b2NrL3Fjb3cyLWJpdG1hcC5jIHwgMiArLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlv
bigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Jsb2NrL3Fjb3cyLWJpdG1h
cC5jIGIvYmxvY2svcWNvdzItYml0bWFwLmMNCj4gaW5kZXggNGUxMWI2YjA1YS4uOTM3MzA1NWQz
YiAxMDA2NDQNCj4gLS0tIGEvYmxvY2svcWNvdzItYml0bWFwLmMNCj4gKysrIGIvYmxvY2svcWNv
dzItYml0bWFwLmMNCj4gQEAgLTE1NjAsNyArMTU2MCw3IEBAIGludCBxY293Ml9yZW9wZW5fYml0
bWFwc19ybyhCbG9ja0RyaXZlclN0YXRlICpicywgRXJyb3IgKiplcnJwKQ0KPiAgICAgICBCZHJ2
RGlydHlCaXRtYXAgKmJpdG1hcDsNCj4gICAgICAgRXJyb3IgKmxvY2FsX2VyciA9IE5VTEw7DQo+
ICAgDQo+IC0gICAgcWNvdzJfc3RvcmVfcGVyc2lzdGVudF9kaXJ0eV9iaXRtYXBzKGJzLCAmbG9j
YWxfZXJyKTsNCj4gKyAgICBxY293Ml9mbHVzaF9wZXJzaXN0ZW50X2RpcnR5X2JpdG1hcHMoYnMs
ICZsb2NhbF9lcnIpOw0KPiAgICAgICBpZiAobG9jYWxfZXJyICE9IE5VTEwpIHsNCj4gICAgICAg
ICAgIGVycm9yX3Byb3BhZ2F0ZShlcnJwLCBsb2NhbF9lcnIpOw0KPiAgICAgICAgICAgcmV0dXJu
IC1FSU5WQUw7DQo+IA0KDQoNCmhtbSB3aWxsIGl0IHdvcms/IGlmIHdlIGNhbGwgcWNvdzJfb3Bl
biBhZnRlciB0aGF0LCBpdCB3aWxsIGZhaWwgdG8gbG9hZCBiaXRtYXBzLCBhcyB0aGV5DQphcmUg
YWxyZWFkeSBleGlzdA0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=
