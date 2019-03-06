Received: from eggs.gnu.org ([209.51.188.92]:39127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1h1Wtl-0006Ao-Gv
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 08:47:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1h1Wtj-0008I2-6p
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 08:47:53 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 6 Mar 2019 13:47:03 +0000
Message-ID: <b792b26c-8184-a047-a014-68380ad332e0@virtuozzo.com>
References: <20190301191545.8728-1-jsnow@redhat.com>
	<20190301191545.8728-5-jsnow@redhat.com>
In-Reply-To: <20190301191545.8728-5-jsnow@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <1210EA1B66B67E43918AB0AFB8911F4B@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 4/7] block/dirty-bitmaps: prohibit
 readonly bitmaps for backups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: Max Reitz <mreitz@redhat.com>, Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Juan Quintela <quintela@redhat.com>

MDEuMDMuMjAxOSAyMjoxNSwgSm9obiBTbm93IHdyb3RlOg0KPiBkcml2ZSBhbmQgYmxvY2tkZXYg
YmFja3VwIGNhbm5vdCB1c2UgcmVhZG9ubHkgYml0bWFwcywgYmVjYXVzZSB0aGUNCj4gc3luYz1p
bmNyZW1lbnRhbCBtZWNoYW5pc20gYWN0dWFsbHkgZWRpdHMgdGhlIGJpdG1hcHMgb24gc3VjY2Vz
cy4NCj4gDQo+IElmIHlvdSByZWFsbHkgd2FudCB0byBkbyB0aGlzIG9wZXJhdGlvbiwgdXNlIGEg
Y29waWVkIGJpdG1hcC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEpvaG4gU25vdyA8anNub3dAcmVk
aGF0LmNvbT4NCg0KDQpSZXZpZXdlZC1ieTogVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSA8
dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPg0KDQoNCj4gLS0tDQo+ICAgYmxvY2tkZXYuYyB8IDQg
KystLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0p
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvYmxvY2tkZXYuYyBiL2Jsb2NrZGV2LmMNCj4gaW5kZXggNWQ3
NDQ3OWJhNy4uYzgyNTVkZGEwYiAxMDA2NDQNCj4gLS0tIGEvYmxvY2tkZXYuYw0KPiArKysgYi9i
bG9ja2Rldi5jDQo+IEBAIC0zNTI2LDcgKzM1MjYsNyBAQCBzdGF0aWMgQmxvY2tKb2IgKmRvX2Ry
aXZlX2JhY2t1cChEcml2ZUJhY2t1cCAqYmFja3VwLCBKb2JUeG4gKnR4biwNCj4gICAgICAgICAg
ICAgICBiZHJ2X3VucmVmKHRhcmdldF9icyk7DQo+ICAgICAgICAgICAgICAgZ290byBvdXQ7DQo+
ICAgICAgICAgICB9DQo+IC0gICAgICAgIGlmIChiZHJ2X2RpcnR5X2JpdG1hcF9jaGVjayhibWFw
LCBCRFJWX0JJVE1BUF9BTExPV19STywgZXJycCkpIHsNCj4gKyAgICAgICAgaWYgKGJkcnZfZGly
dHlfYml0bWFwX2NoZWNrKGJtYXAsIEJEUlZfQklUTUFQX0RFRkFVTFQsIGVycnApKSB7DQo+ICAg
ICAgICAgICAgICAgZ290byBvdXQ7DQo+ICAgICAgICAgICB9DQo+ICAgICAgIH0NCj4gQEAgLTM2
MzYsNyArMzYzNiw3IEBAIEJsb2NrSm9iICpkb19ibG9ja2Rldl9iYWNrdXAoQmxvY2tkZXZCYWNr
dXAgKmJhY2t1cCwgSm9iVHhuICp0eG4sDQo+ICAgICAgICAgICAgICAgZXJyb3Jfc2V0ZyhlcnJw
LCAiQml0bWFwICclcycgY291bGQgbm90IGJlIGZvdW5kIiwgYmFja3VwLT5iaXRtYXApOw0KPiAg
ICAgICAgICAgICAgIGdvdG8gb3V0Ow0KPiAgICAgICAgICAgfQ0KPiAtICAgICAgICBpZiAoYmRy
dl9kaXJ0eV9iaXRtYXBfY2hlY2soYm1hcCwgQkRSVl9CSVRNQVBfQUxMT1dfUk8sIGVycnApKSB7
DQo+ICsgICAgICAgIGlmIChiZHJ2X2RpcnR5X2JpdG1hcF9jaGVjayhibWFwLCBCRFJWX0JJVE1B
UF9ERUZBVUxULCBlcnJwKSkgew0KPiAgICAgICAgICAgICAgIGdvdG8gb3V0Ow0KPiAgICAgICAg
ICAgfQ0KPiAgICAgICB9DQo+IA0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==
